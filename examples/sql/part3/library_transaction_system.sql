-- QUẢN LÝ TRANSACTION MƯỢN SÁCH THƯ VIỆN
-- ===============================

-- Tạo cơ sở dữ liệu
DROP DATABASE IF EXISTS library_transaction_system;
CREATE DATABASE IF NOT EXISTS library_transaction_system;
USE library_transaction_system;

-- ======== CẤU TRÚC DỮ LIỆU ========

-- Bảng Books: Thông tin sách
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    publication_year INT,
    publisher VARCHAR(100),
    category VARCHAR(50),
    total_copies INT NOT NULL DEFAULT 0,
    available_copies INT NOT NULL DEFAULT 0,
    shelf_location VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng Users: Thông tin người dùng
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,  -- Lưu hash của mật khẩu
    fullname VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255),
    membership_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    expiry_date DATE,
    status ENUM('Active', 'Suspended', 'Expired') DEFAULT 'Active',
    max_allowed_books INT DEFAULT 3,
    current_borrowed INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng Borrowings: Transaction mượn sách
CREATE TABLE Borrowings (
    borrowing_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    borrow_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    due_date DATE NOT NULL,
    return_date DATE,
    status ENUM('Borrowed', 'Returned', 'Overdue', 'Lost') DEFAULT 'Borrowed',
    fine_amount DECIMAL(10, 2) DEFAULT 0.00,
    fine_paid BOOLEAN DEFAULT FALSE,
    notes TEXT,
    created_by VARCHAR(50),  -- Người thực hiện transaction
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Bảng BorrowingHistory: Lịch sử các thay đổi trên giao dịch mượn sách
CREATE TABLE BorrowingHistory (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    borrowing_id INT NOT NULL,
    action_type VARCHAR(50) NOT NULL, -- 'Borrow', 'Return', 'Renew', 'MarkAsLost', etc.
    action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    action_by VARCHAR(50),
    old_status VARCHAR(20),
    new_status VARCHAR(20),
    notes TEXT,
    FOREIGN KEY (borrowing_id) REFERENCES Borrowings(borrowing_id)
);

-- Bảng Fines: Lưu phạt trễ hạn
CREATE TABLE Fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    borrowing_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    reason VARCHAR(255) NOT NULL,
    fine_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    payment_date DATE,
    payment_status ENUM('Paid', 'Unpaid') DEFAULT 'Unpaid',
    FOREIGN KEY (borrowing_id) REFERENCES Borrowings(borrowing_id)
);

-- Tạo chỉ mục để tối ưu hiệu suất truy vấn
CREATE INDEX idx_books_title ON Books(title);
CREATE INDEX idx_books_author ON Books(author);
CREATE INDEX idx_books_isbn ON Books(isbn);
CREATE INDEX idx_books_category ON Books(category);
CREATE INDEX idx_books_copies ON Books(available_copies);

CREATE INDEX idx_users_username ON Users(username);
CREATE INDEX idx_users_fullname ON Users(fullname);
CREATE INDEX idx_users_email ON Users(email);
CREATE INDEX idx_users_status ON Users(status);

CREATE INDEX idx_borrowings_user ON Borrowings(user_id);
CREATE INDEX idx_borrowings_book ON Borrowings(book_id);
CREATE INDEX idx_borrowings_dates ON Borrowings(borrow_date, due_date, return_date);
CREATE INDEX idx_borrowings_status ON Borrowings(status);

-- ======== CÁC STORED PROCEDURES ========

-- 1. Thêm sách mới
DELIMITER //
CREATE PROCEDURE sp_AddNewBook(
    IN p_title VARCHAR(255),
    IN p_author VARCHAR(100),
    IN p_isbn VARCHAR(20),
    IN p_publication_year INT,
    IN p_publisher VARCHAR(100),
    IN p_category VARCHAR(50),
    IN p_total_copies INT,
    IN p_shelf_location VARCHAR(20),
    OUT p_book_id INT
)
BEGIN
    DECLARE exit_handler BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET exit_handler = TRUE;
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi khi thêm sách mới';
    END;

    START TRANSACTION;

    -- Kiểm tra xem ISBN đã tồn tại chưa (nếu có)
    IF p_isbn IS NOT NULL AND p_isbn != '' THEN
        IF EXISTS (SELECT 1 FROM Books WHERE isbn = p_isbn) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ISBN đã tồn tại trong hệ thống';
        END IF;
    END IF;

    -- Thêm sách mới
    INSERT INTO Books(title, author, isbn, publication_year, publisher, 
                     category, total_copies, available_copies, shelf_location)
    VALUES(p_title, p_author, p_isbn, p_publication_year, p_publisher,
          p_category, p_total_copies, p_total_copies, p_shelf_location);

    SET p_book_id = LAST_INSERT_ID();

    -- Kiểm tra đã chèn thành công chưa
    IF p_book_id = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Thêm sách mới không thành công';
    END IF;

    IF exit_handler = FALSE THEN
        COMMIT;
    END IF;
END //
DELIMITER ;

-- 2. Đăng ký người dùng mới
DELIMITER //
CREATE PROCEDURE sp_RegisterUser(
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_fullname VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(15),
    IN p_address VARCHAR(255),
    IN p_expiry_months INT,
    OUT p_user_id INT
)
BEGIN
    DECLARE exit_handler BOOLEAN DEFAULT FALSE;
    DECLARE password_encrypted VARCHAR(255);
    DECLARE expiry DATE;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET exit_handler = TRUE;
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi khi đăng ký người dùng mới';
    END;

    START TRANSACTION;

    -- Kiểm tra username đã tồn tại chưa
    IF EXISTS (SELECT 1 FROM Users WHERE username = p_username) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tên đăng nhập đã tồn tại';
    END IF;

    -- Kiểm tra email đã tồn tại chưa nếu được cung cấp
    IF p_email IS NOT NULL AND p_email != '' THEN
        IF EXISTS (SELECT 1 FROM Users WHERE email = p_email) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email đã tồn tại';
        END IF;
    END IF;

    -- Mã hóa mật khẩu (thực tế nên thực hiện ở tầng ứng dụng)
    -- Chỉ mô phỏng việc mã hóa bằng SHA2 tại đây
    SET password_encrypted = SHA2(p_password, 256);
    
    -- Tính ngày hết hạn dựa vào số tháng
    IF p_expiry_months IS NOT NULL AND p_expiry_months > 0 THEN
        SET expiry = DATE_ADD(CURRENT_DATE, INTERVAL p_expiry_months MONTH);
    ELSE
        -- Mặc định 1 năm
        SET expiry = DATE_ADD(CURRENT_DATE, INTERVAL 12 MONTH);
    END IF;

    -- Thêm người dùng mới
    INSERT INTO Users(username, password_hash, fullname, email, phone, address, membership_date, expiry_date)
    VALUES(p_username, password_encrypted, p_fullname, p_email, p_phone, p_address, CURRENT_DATE, expiry);

    SET p_user_id = LAST_INSERT_ID();

    IF exit_handler = FALSE THEN
        COMMIT;
    END IF;
END //
DELIMITER ;

-- 3. Xử lý Transaction mượn sách
DELIMITER //
CREATE PROCEDURE sp_BorrowBook(
    IN p_user_id INT,
    IN p_book_id INT,
    IN p_days_to_borrow INT,
    IN p_created_by VARCHAR(50),
    OUT p_borrowing_id INT,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE exit_handler BOOLEAN DEFAULT FALSE;
    DECLARE v_user_status VARCHAR(20);
    DECLARE v_current_borrowed INT;
    DECLARE v_max_allowed INT;
    DECLARE v_available_copies INT;
    DECLARE v_due_date DATE;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET exit_handler = TRUE;
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi trong quá trình xử lý mượn sách';
    END;

    START TRANSACTION;

    -- Mặc định số ngày mượn
    IF p_days_to_borrow IS NULL OR p_days_to_borrow <= 0 THEN
        SET p_days_to_borrow = 14; -- 2 tuần
    END IF;

    -- Tính ngày đến hạn
    SET v_due_date = DATE_ADD(CURRENT_DATE, INTERVAL p_days_to_borrow DAY);

    -- Kiểm tra xem người dùng có tồn tại không và đang hoạt động
    SELECT status, current_borrowed, max_allowed_books 
    INTO v_user_status, v_current_borrowed, v_max_allowed
    FROM Users 
    WHERE user_id = p_user_id;

    IF v_user_status IS NULL THEN
        SET p_message = 'Người dùng không tồn tại';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Người dùng không tồn tại';
    END IF;

    -- Kiểm tra trạng thái người dùng
    IF v_user_status != 'Active' THEN
        SET p_message = CONCAT('Tài khoản người dùng không hoạt động: ', v_user_status);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tài khoản người dùng không hoạt động';
    END IF;

    -- Kiểm tra số sách đã mượn
    IF v_current_borrowed >= v_max_allowed THEN
        SET p_message = CONCAT('Đã vượt quá số sách được phép mượn (', v_max_allowed, ')');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Đã vượt quá số sách được phép mượn';
    END IF;

    -- Kiểm tra xem sách có tồn tại và còn sách để mượn không
    SELECT available_copies INTO v_available_copies
    FROM Books WHERE book_id = p_book_id;

    IF v_available_copies IS NULL THEN
        SET p_message = 'Sách không tồn tại';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Sách không tồn tại';
    END IF;

    IF v_available_copies <= 0 THEN
        SET p_message = 'Sách hiện không có sẵn để mượn';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Sách hiện không có sẵn để mượn';
    END IF;

    -- Kiểm tra xem người dùng đã mượn cuốn sách này chưa và chưa trả
    IF EXISTS (
        SELECT 1 FROM Borrowings 
        WHERE user_id = p_user_id AND book_id = p_book_id AND status IN ('Borrowed', 'Overdue')
    ) THEN
        SET p_message = 'Người dùng đã mượn cuốn sách này và chưa trả';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Người dùng đã mượn cuốn sách này và chưa trả';
    END IF;

    -- Tạo transaction mượn sách
    INSERT INTO Borrowings(user_id, book_id, borrow_date, due_date, status, created_by)
    VALUES(p_user_id, p_book_id, CURRENT_DATE, v_due_date, 'Borrowed', p_created_by);

    SET p_borrowing_id = LAST_INSERT_ID();

    -- Ghi log vào lịch sử
    INSERT INTO BorrowingHistory(borrowing_id, action_type, action_by, new_status)
    VALUES(p_borrowing_id, 'Borrow', p_created_by, 'Borrowed');

    -- Các bảng sẽ được cập nhật tự động qua các triggers
    -- (cập nhật available_copies trong Books và current_borrowed trong Users)

    IF exit_handler = FALSE THEN
        COMMIT;
        SET p_message = CONCAT('Mượn sách thành công. Hạn trả: ', v_due_date);
    END IF;
END //
DELIMITER ;

-- 4. Xử lý trả sách
DELIMITER //
CREATE PROCEDURE sp_ReturnBook(
    IN p_borrowing_id INT,
    IN p_action_by VARCHAR(50),
    IN p_lost BOOLEAN,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE exit_handler BOOLEAN DEFAULT FALSE;
    DECLARE v_current_status VARCHAR(20);
    DECLARE v_user_id INT;
    DECLARE v_book_id INT;
    DECLARE v_due_date DATE;
    DECLARE v_days_overdue INT;
    DECLARE v_fine_amount DECIMAL(10, 2);
    DECLARE v_new_status VARCHAR(20);
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET exit_handler = TRUE;
        ROLLBACK;
        SET p_message = 'Lỗi trong quá trình xử lý trả sách';
    END;

    START TRANSACTION;

    -- Kiểm tra thông tin mượn sách
    SELECT status, user_id, book_id, due_date 
    INTO v_current_status, v_user_id, v_book_id, v_due_date
    FROM Borrowings 
    WHERE borrowing_id = p_borrowing_id;

    IF v_current_status IS NULL THEN
        SET p_message = 'Không tìm thấy thông tin mượn sách';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Không tìm thấy thông tin mượn sách';
    END IF;

    -- Kiểm tra xem sách đã được trả chưa
    IF v_current_status = 'Returned' THEN
        SET p_message = 'Sách đã được trả';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Sách đã được trả';
    END IF;

    -- Xác định trạng thái mới
    IF p_lost THEN
        SET v_new_status = 'Lost';
    ELSE
        SET v_new_status = 'Returned';
    END IF;

    -- Tính số ngày trễ hạn và phí phạt nếu có
    SET v_days_overdue = DATEDIFF(CURRENT_DATE, v_due_date);
    SET v_fine_amount = 0;

    IF v_days_overdue > 0 THEN
        -- Giả sử mức phạt 10,000 VND/ngày
        SET v_fine_amount = v_days_overdue * 10000;
    END IF;

    -- Nếu làm mất sách, phí phạt bổ sung 
    IF p_lost THEN
        -- Giả sử phí phạt làm mất sách là 500,000 VND
        SET v_fine_amount = v_fine_amount + 500000;
    END IF;

    -- Cập nhật thông tin trả sách
    UPDATE Borrowings
    SET 
        return_date = CURRENT_DATE,
        status = v_new_status,
        fine_amount = v_fine_amount
    WHERE borrowing_id = p_borrowing_id;

    -- Nếu có phí phạt, ghi nhận vào bảng Fines
    IF v_fine_amount > 0 THEN
        INSERT INTO Fines(borrowing_id, amount, reason, fine_date)
        VALUES(p_borrowing_id, v_fine_amount, 
              IF(p_lost, 
                 CONCAT('Mất sách và trễ ', v_days_overdue, ' ngày'),
                 CONCAT('Trễ hạn ', v_days_overdue, ' ngày')
              ),
              CURRENT_DATE);
    END IF;

    -- Ghi log vào lịch sử
    INSERT INTO BorrowingHistory(
        borrowing_id, action_type, action_by, 
        old_status, new_status, 
        notes)
    VALUES(
        p_borrowing_id, 
        IF(p_lost, 'MarkAsLost', 'Return'), 
        p_action_by, 
        v_current_status, 
        v_new_status, 
        IF(v_fine_amount > 0, CONCAT('Phí phạt: ', v_fine_amount, ' VND'), NULL)
    );

    -- Các bảng sẽ được cập nhật tự động qua các triggers
    -- (cập nhật available_copies trong Books và current_borrowed trong Users)

    IF exit_handler = FALSE THEN
        COMMIT;
        IF v_fine_amount > 0 THEN
            SET p_message = CONCAT('Trả sách thành công. Phí phạt: ', v_fine_amount, ' VND');
        ELSE
            SET p_message = 'Trả sách thành công. Không có phí phạt.';
        END IF;
    END IF;
END //
DELIMITER ;

-- 5. Gia hạn mượn sách
DELIMITER //
CREATE PROCEDURE sp_RenewBook(
    IN p_borrowing_id INT,
    IN p_additional_days INT,
    IN p_action_by VARCHAR(50),
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE exit_handler BOOLEAN DEFAULT FALSE;
    DECLARE v_current_status VARCHAR(20);
    DECLARE v_current_due_date DATE;
    DECLARE v_new_due_date DATE;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET exit_handler = TRUE;
        ROLLBACK;
        SET p_message = 'Lỗi trong quá trình gia hạn sách';
    END;

    START TRANSACTION;

    -- Mặc định số ngày gia hạn
    IF p_additional_days IS NULL OR p_additional_days <= 0 THEN
        SET p_additional_days = 7; -- 1 tuần
    END IF;

    -- Kiểm tra thông tin mượn sách
    SELECT status, due_date INTO v_current_status, v_current_due_date
    FROM Borrowings 
    WHERE borrowing_id = p_borrowing_id;

    IF v_current_status IS NULL THEN
        SET p_message = 'Không tìm thấy thông tin mượn sách';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Không tìm thấy thông tin mượn sách';
    END IF;

    -- Kiểm tra xem sách có đang được mượn không
    IF v_current_status != 'Borrowed' AND v_current_status != 'Overdue' THEN
        SET p_message = CONCAT('Không thể gia hạn sách với trạng thái: ', v_current_status);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Không thể gia hạn sách với trạng thái hiện tại';
    END IF;

    -- Tính ngày đến hạn mới
    SET v_new_due_date = DATE_ADD(v_current_due_date, INTERVAL p_additional_days DAY);

    -- Cập nhật ngày đến hạn mới
    UPDATE Borrowings
    SET 
        due_date = v_new_due_date,
        status = 'Borrowed' -- Reset status từ Overdue nếu có
    WHERE borrowing_id = p_borrowing_id;

    -- Ghi log vào lịch sử
    INSERT INTO BorrowingHistory(
        borrowing_id, action_type, action_by, 
        old_status, new_status, 
        notes)
    VALUES(
        p_borrowing_id, 
        'Renew', 
        p_action_by, 
        v_current_status, 
        'Borrowed', 
        CONCAT('Gia hạn thêm ', p_additional_days, ' ngày. Hạn mới: ', v_new_due_date)
    );

    IF exit_handler = FALSE THEN
        COMMIT;
        SET p_message = CONCAT('Gia hạn sách thành công. Hạn mới: ', v_new_due_date);
    END IF;
END //
DELIMITER ;

-- 6. Procedure thanh toán phí phạt
DELIMITER //
CREATE PROCEDURE sp_PayFine(
    IN p_fine_id INT,
    IN p_action_by VARCHAR(50),
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE exit_handler BOOLEAN DEFAULT FALSE;
    DECLARE v_borrowing_id INT;
    DECLARE v_amount DECIMAL(10, 2);
    DECLARE v_payment_status VARCHAR(10);
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET exit_handler = TRUE;
        ROLLBACK;
        SET p_message = 'Lỗi trong quá trình thanh toán phí phạt';
    END;

    START TRANSACTION;

    -- Kiểm tra thông tin phí phạt
    SELECT borrowing_id, amount, payment_status INTO v_borrowing_id, v_amount, v_payment_status
    FROM Fines 
    WHERE fine_id = p_fine_id;

    IF v_borrowing_id IS NULL THEN
        SET p_message = 'Không tìm thấy thông tin phí phạt';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Không tìm thấy thông tin phí phạt';
    END IF;

    -- Kiểm tra xem phí phạt đã được thanh toán chưa
    IF v_payment_status = 'Paid' THEN
        SET p_message = 'Phí phạt này đã được thanh toán';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Phí phạt này đã được thanh toán';
    END IF;

    -- Cập nhật trạng thái thanh toán
    UPDATE Fines
    SET 
        payment_status = 'Paid',
        payment_date = CURRENT_DATE
    WHERE fine_id = p_fine_id;

    -- Cập nhật thông tin phí phạt đã thanh toán trong Borrowings
    UPDATE Borrowings
    SET 
        fine_paid = TRUE
    WHERE borrowing_id = v_borrowing_id;

    -- Ghi log vào lịch sử
    INSERT INTO BorrowingHistory(
        borrowing_id, action_type, action_by, notes)
    VALUES(
        v_borrowing_id, 
        'PayFine', 
        p_action_by, 
        CONCAT('Thanh toán phí phạt: ', v_amount, ' VND')
    );

    IF exit_handler = FALSE THEN
        COMMIT;
        SET p_message = CONCAT('Thanh toán phí phạt thành công: ', v_amount, ' VND');
    END IF;
END //
DELIMITER ;

-- ======== CÁC TRIGGERS ========

-- 1. Trigger cập nhật số lượng sách có sẵn khi mượn sách
DELIMITER //
CREATE TRIGGER after_borrowing_insert
AFTER INSERT ON Borrowings
FOR EACH ROW
BEGIN
    -- Giảm số lượng sách có sẵn
    UPDATE Books
    SET available_copies = available_copies - 1
    WHERE book_id = NEW.book_id;

    -- Tăng số sách đã mượn của người dùng
    UPDATE Users
    SET current_borrowed = current_borrowed + 1
    WHERE user_id = NEW.user_id;
END //
DELIMITER ;

-- 2. Trigger cập nhật số lượng sách có sẵn khi trả sách
DELIMITER //
CREATE TRIGGER after_borrowing_update
AFTER UPDATE ON Borrowings
FOR EACH ROW
BEGIN
    -- Nếu status chuyển từ Borrowed/Overdue sang Returned
    IF (OLD.status IN ('Borrowed', 'Overdue')) AND NEW.status = 'Returned' THEN
        -- Tăng số lượng sách có sẵn
        UPDATE Books
        SET available_copies = available_copies + 1
        WHERE book_id = NEW.book_id;

        -- Giảm số sách đã mượn của người dùng
        UPDATE Users
        SET current_borrowed = current_borrowed - 1
        WHERE user_id = NEW.user_id;
    END IF;

    -- Nếu status chuyển từ Borrowed/Overdue sang Lost
    -- Sách bị mất, KHÔNG tăng số lượng sách có sẵn, chỉ giảm số sách đã mượn của người dùng
    IF (OLD.status IN ('Borrowed', 'Overdue')) AND NEW.status = 'Lost' THEN
        -- Giảm tổng số lượng sách (vì mất)
        UPDATE Books
        SET total_copies = total_copies - 1
        WHERE book_id = NEW.book_id;

        -- Giảm số sách đã mượn của người dùng
        UPDATE Users
        SET current_borrowed = current_borrowed - 1
        WHERE user_id = NEW.user_id;
    END IF;
END //
DELIMITER ;

-- 3. Trigger kiểm tra điều kiện trước khi cho mượn sách
DELIMITER //
CREATE TRIGGER before_borrowing_insert
BEFORE INSERT ON Borrowings
FOR EACH ROW
BEGIN
    DECLARE v_available INT;
    DECLARE v_user_status VARCHAR(20);
    DECLARE v_current_borrowed INT;
    DECLARE v_max_allowed INT;
    
    -- Kiểm tra sách còn có sẵn không
    SELECT available_copies INTO v_available
    FROM Books WHERE book_id = NEW.book_id;
    
    IF v_available <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Sách không còn sẵn để mượn';
    END IF;
    
    -- Kiểm tra trạng thái người dùng
    SELECT status, current_borrowed, max_allowed_books 
    INTO v_user_status, v_current_borrowed, v_max_allowed
    FROM Users WHERE user_id = NEW.user_id;
    
    IF v_user_status != 'Active' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tài khoản người dùng không hoạt động';
    END IF;
    
    IF v_current_borrowed >= v_max_allowed THEN
        SET @error_message = CONCAT('Vượt quá số sách được phép mượn (', v_max_allowed, ')');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @error_message;
    END IF;

END //
DELIMITER ;

-- 4. Trigger tự động cập nhật trạng thái Overdue khi quá hạn
DELIMITER //
CREATE EVENT evt_check_overdue_books
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_DATE
DO
BEGIN
    -- Cập nhật trạng thái các sách quá hạn
    UPDATE Borrowings
    SET status = 'Overdue'
    WHERE status = 'Borrowed'
    AND due_date < CURRENT_DATE
    AND return_date IS NULL;
    
    -- Ghi log cho các sách vừa được đánh dấu quá hạn hôm nay
    INSERT INTO BorrowingHistory(borrowing_id, action_type, old_status, new_status, notes)
    SELECT borrowing_id, 'SystemUpdate', 'Borrowed', 'Overdue', 'Tự động đánh dấu quá hạn'
    FROM Borrowings
    WHERE status = 'Overdue'
    AND due_date = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY);
END //
DELIMITER ;

-- ======== DỮ LIỆU MẪU ========

-- Thêm sách mẫu
INSERT INTO Books (title, author, isbn, publication_year, publisher, category, total_copies, available_copies, shelf_location)
VALUES 
('Dế Mèn Phiêu Lưu Ký', 'Tô Hoài', '9786040224903', 2018, 'NXB Kim Đồng', 'Văn học thiếu nhi', 10, 10, 'A1-01'),
('Số Đỏ', 'Vũ Trọng Phụng', '9786049528743', 2017, 'NXB Hội Nhà Văn', 'Văn học Việt Nam', 5, 5, 'A1-02'),
('Tắt Đèn', 'Ngô Tất Tố', '9786046987741', 2019, 'NXB Văn Học', 'Văn học Việt Nam', 8, 8, 'A1-03'),
('Lập Trình Python Cơ Bản', 'Đỗ Minh Hùng', '9786040220912', 2020, 'NXB Thông Tin Truyền Thông', 'Công nghệ', 6, 6, 'B2-05'),
('Cơ Sở Dữ Liệu', 'Phạm Hữu Khang', '9786049831148', 2021, 'NXB Giáo Dục', 'Công nghệ', 7, 7, 'B2-06'),
('Người Nhện: Không Còn Nhà', 'Marvel Comics', '9781302934101', 2021, 'Marvel', 'Truyện tranh', 4, 4, 'C3-01'),
('Harry Potter và Hòn Đá Phù Thuỷ', 'J.K. Rowling', '9786047704088', 2016, 'NXB Trẻ', 'Văn học nước ngoài', 5, 5, 'D1-01');

-- Thêm người dùng mẫu (mật khẩu mặc định '123456' đã được hash)
INSERT INTO Users (username, password_hash, fullname, email, phone, address, membership_date, expiry_date, status, max_allowed_books)
VALUES 
('nguyenv', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'Nguyễn Văn A', 'nguyenva@email.com', '0901234567', 'Hà Nội', '2023-01-15', '2024-01-15', 'Active', 3),
('tranth', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'Trần Thị B', 'tranthib@email.com', '0912345678', 'TP. Hồ Chí Minh', '2023-02-20', '2024-02-20', 'Active', 3),
('lequoc', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'Lê Quốc C', 'lequocc@email.com', '0923456789', 'Đà Nẵng', '2023-03-05', '2024-03-05', 'Active', 2),
('phamh', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'Phạm Hoàng D', 'phamhd@email.com', '0934567890', 'Cần Thơ', '2022-12-10', '2023-06-10', 'Expired', 3);

-- ======== CÁC VÍ DỤ SỬ DỤNG ========

-- 1. Thêm sách mới
CALL sp_AddNewBook('Cấu Trúc Dữ Liệu và Giải Thuật', 'Lê Minh Hoàng', '9786048898008', 2022, 
                  'NXB Đại học Quốc gia', 'Công nghệ', 5, 'B2-07', @book_id);
SELECT @book_id AS new_book_id;

-- 2. Đăng ký người dùng mới
CALL sp_RegisterUser('hoangm', '123456', 'Hoàng Minh E', 'hoangme@email.com', 
                    '0945678901', 'Hải Phòng', 12, @user_id);
SELECT @user_id AS new_user_id;

-- 3. Mượn sách
CALL sp_BorrowBook(1, 1, 14, 'admin', @borrowing_id, @message);
SELECT @borrowing_id AS borrowing_id, @message AS message;

-- 4. Mượn sách khác
CALL sp_BorrowBook(1, 2, 7, 'admin', @borrowing_id, @message);
SELECT @borrowing_id AS borrowing_id, @message AS message;

-- 5. Trả sách
CALL sp_ReturnBook(1, 'admin', FALSE, @message);
SELECT @message AS message;

-- 6. Gia hạn mượn sách
CALL sp_BorrowBook(2, 3, 14, 'admin', @borrowing_id, @message);
SELECT @borrowing_id AS borrowing_id, @message AS message;

CALL sp_RenewBook(3, 7, 'admin', @message);
SELECT @message AS message;

-- 7. Báo mất sách
CALL sp_BorrowBook(2, 4, 14, 'admin', @borrowing_id, @message);
SELECT @borrowing_id AS borrowing_id, @message AS message;

CALL sp_ReturnBook(4, 'admin', TRUE, @message);
SELECT @message AS message;
