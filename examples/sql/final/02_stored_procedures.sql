USE library_management;

-- 1. Stored Procedure: Đăng ký người dùng mới
DELIMITER //
CREATE PROCEDURE RegisterUser(
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_full_name VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(20),
    IN p_address VARCHAR(255),
    IN p_user_type ENUM('reader', 'staff', 'admin')
)
BEGIN
    DECLARE existing_user INT DEFAULT 0;
    
    -- Kiểm tra username đã tồn tại chưa
    SELECT COUNT(*) INTO existing_user FROM users WHERE username = p_username;
    
    IF existing_user > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Username already exists';
    ELSE
        -- Hash mật khẩu trong thực tế (ở đây chỉ mô phỏng)
        SET p_password = CONCAT('hashed_', p_password);
        
        INSERT INTO users (username, password, full_name, email, phone, address, user_type)
        VALUES (p_username, p_password, p_full_name, p_email, p_phone, p_address, p_user_type);
        
        -- Ghi log hoạt động
        INSERT INTO activity_logs (user_id, action, entity, entity_id, details)
        VALUES (LAST_INSERT_ID(), 'CREATE', 'users', LAST_INSERT_ID(), CONCAT('New user registered: ', p_username));
        
        SELECT LAST_INSERT_ID() AS user_id, 'User registered successfully' AS message;
    END IF;
END //
DELIMITER ;

-- 2. Stored Procedure: Thêm sách mới vào hệ thống
DELIMITER //
CREATE PROCEDURE AddNewBook(
    IN p_title VARCHAR(255),
    IN p_isbn VARCHAR(20),
    IN p_publisher_id INT,
    IN p_publication_year INT,
    IN p_description TEXT,
    IN p_page_count INT,
    IN p_language VARCHAR(50),
    IN p_total_copies INT,
    IN p_location VARCHAR(50),
    IN p_author_ids VARCHAR(255), -- Danh sách các author_id, cách nhau bởi dấu phẩy
    IN p_category_ids VARCHAR(255) -- Danh sách các category_id, cách nhau bởi dấu phẩy
)
BEGIN
    DECLARE v_book_id INT;
    DECLARE v_author_id INT;
    DECLARE v_category_id INT;
    DECLARE v_pos INT DEFAULT 1;
    DECLARE v_author_list VARCHAR(255);
    DECLARE v_category_list VARCHAR(255);
    DECLARE v_next_pos INT;
    
    -- Bắt đầu transaction để đảm bảo tính toàn vẹn
    START TRANSACTION;
    
    -- Thêm sách mới
    INSERT INTO books (
        title, isbn, publisher_id, publication_year, description, 
        page_count, language, total_copies, available_copies, location
    )
    VALUES (
        p_title, p_isbn, p_publisher_id, p_publication_year, p_description, 
        p_page_count, p_language, p_total_copies, p_total_copies, p_location
    );
    
    SET v_book_id = LAST_INSERT_ID();
    
    -- Thêm các tác giả cho sách
    SET v_author_list = p_author_ids;
    
    author_loop: WHILE v_author_list != '' DO
        SET v_next_pos = LOCATE(',', v_author_list);
        
        IF v_next_pos > 0 THEN
            SET v_author_id = CAST(SUBSTRING(v_author_list, 1, v_next_pos - 1) AS UNSIGNED);
            SET v_author_list = SUBSTRING(v_author_list, v_next_pos + 1);
        ELSE
            SET v_author_id = CAST(v_author_list AS UNSIGNED);
            SET v_author_list = '';
        END IF;
        
        -- Thêm liên kết với tác giả
        INSERT INTO book_authors (book_id, author_id)
        VALUES (v_book_id, v_author_id);
    END WHILE;
    
    -- Thêm các thể loại cho sách
    SET v_category_list = p_category_ids;
    
    category_loop: WHILE v_category_list != '' DO
        SET v_next_pos = LOCATE(',', v_category_list);
        
        IF v_next_pos > 0 THEN
            SET v_category_id = CAST(SUBSTRING(v_category_list, 1, v_next_pos - 1) AS UNSIGNED);
            SET v_category_list = SUBSTRING(v_category_list, v_next_pos + 1);
        ELSE
            SET v_category_id = CAST(v_category_list AS UNSIGNED);
            SET v_category_list = '';
        END IF;
        
        -- Thêm liên kết với thể loại
        INSERT INTO book_categories (book_id, category_id)
        VALUES (v_book_id, v_category_id);
    END WHILE;
    
    -- Ghi log hoạt động
    INSERT INTO activity_logs (action, entity, entity_id, details)
    VALUES ('CREATE', 'books', v_book_id, CONCAT('New book added: ', p_title));
    
    COMMIT;
    
    SELECT v_book_id AS book_id, 'Book added successfully' AS message;
    
END //
DELIMITER ;

-- 3. Stored Procedure: Xử lý giao dịch mượn sách
DELIMITER //
CREATE PROCEDURE BorrowBook(
    IN p_user_id INT,
    IN p_book_id INT,
    IN p_staff_id INT,
    IN p_due_days INT -- Số ngày được phép mượn
)
BEGIN
    DECLARE v_book_available INT DEFAULT 0;
    DECLARE v_user_status VARCHAR(20);
    DECLARE v_existing_borrows INT DEFAULT 0;
    DECLARE v_transaction_id INT;
    
    -- Kiểm tra trạng thái của độc giả
    SELECT status INTO v_user_status FROM users
    WHERE user_id = p_user_id AND user_type = 'reader';
    
    -- Kiểm tra số lượng sách đang được mượn
    SELECT COUNT(*) INTO v_existing_borrows FROM transactions
    WHERE user_id = p_user_id AND status IN ('borrowed', 'overdue');
    
    -- Kiểm tra số lượng sách có sẵn
    SELECT available_copies INTO v_book_available FROM books
    WHERE book_id = p_book_id;
    
    -- Bắt đầu kiểm tra các điều kiện
    IF v_user_status IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User not found or not a reader';
    ELSEIF v_user_status != 'active' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User account is not active';
    ELSEIF v_existing_borrows >= 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User has reached maximum allowed borrows (5)';
    ELSEIF v_book_available <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Book is not available for borrowing';
    ELSE
        -- Bắt đầu transaction
        START TRANSACTION;
        
        -- Tạo giao dịch mượn sách
        INSERT INTO transactions (
            user_id, book_id, borrow_date, due_date, staff_id, status
        )
        VALUES (
            p_user_id, 
            p_book_id, 
            CURRENT_TIMESTAMP, 
            DATE_ADD(CURRENT_TIMESTAMP, INTERVAL p_due_days DAY), 
            p_staff_id, 
            'borrowed'
        );
        
        SET v_transaction_id = LAST_INSERT_ID();
        
        -- Cập nhật số lượng sách có sẵn
        UPDATE books
        SET available_copies = available_copies - 1
        WHERE book_id = p_book_id;
        
        -- Ghi log hoạt động
        INSERT INTO activity_logs (user_id, action, entity, entity_id, details)
        VALUES (
            p_staff_id, 
            'BORROW', 
            'transactions', 
            v_transaction_id, 
            CONCAT('User ID ', p_user_id, ' borrowed Book ID ', p_book_id)
        );
        
        COMMIT;
        
        SELECT v_transaction_id AS transaction_id, 'Book borrowed successfully' AS message;
    END IF;
END //
DELIMITER ;

-- 4. Stored Procedure: Xử lý trả sách và tính phí phạt quá hạn
DELIMITER //
CREATE PROCEDURE ReturnBook(
    IN p_transaction_id INT,
    IN p_staff_id INT
)
BEGIN
    DECLARE v_book_id INT;
    DECLARE v_user_id INT;
    DECLARE v_due_date TIMESTAMP;
    DECLARE v_days_overdue INT;
    DECLARE v_fine_amount DECIMAL(10, 2) DEFAULT 0.00;
    DECLARE v_transaction_status VARCHAR(20);
    DECLARE v_fine_id INT;
    
    -- Kiểm tra giao dịch
    SELECT book_id, user_id, due_date, status
    INTO v_book_id, v_user_id, v_due_date, v_transaction_status
    FROM transactions
    WHERE transaction_id = p_transaction_id;
    
    -- Kiểm tra điều kiện
    IF v_book_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Transaction not found';
    ELSEIF v_transaction_status = 'returned' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Book already returned';
    ELSE
        -- Bắt đầu transaction
        START TRANSACTION;
        
        -- Tính toán số ngày trễ hạn và tiền phạt
        IF CURRENT_TIMESTAMP > v_due_date THEN
            SET v_days_overdue = DATEDIFF(CURRENT_TIMESTAMP, v_due_date);
            -- Phạt 5.000 VND/ngày quá hạn
            SET v_fine_amount = v_days_overdue * 5.00;
        END IF;
        
        -- Cập nhật giao dịch
        UPDATE transactions
        SET return_date = CURRENT_TIMESTAMP,
            fine_amount = v_fine_amount,
            status = IF(v_fine_amount > 0, 'overdue', 'returned'),
            staff_id = p_staff_id
        WHERE transaction_id = p_transaction_id;
        
        -- Tạo bản ghi phạt nếu có
        IF v_fine_amount > 0 THEN
            INSERT INTO fines (transaction_id, amount, reason)
            VALUES (p_transaction_id, v_fine_amount, CONCAT('Overdue by ', v_days_overdue, ' days'));
            
            SET v_fine_id = LAST_INSERT_ID();
        END IF;
        
        -- Cập nhật số lượng sách có sẵn
        UPDATE books
        SET available_copies = available_copies + 1
        WHERE book_id = v_book_id;
        
        -- Ghi log hoạt động
        INSERT INTO activity_logs (user_id, action, entity, entity_id, details)
        VALUES (
            p_staff_id, 
            'RETURN', 
            'transactions', 
            p_transaction_id, 
            CONCAT('User ID ', v_user_id, ' returned Book ID ', v_book_id, 
                   IF(v_fine_amount > 0, CONCAT(' with fine: $', v_fine_amount), ''))
        );
        
        COMMIT;
        
        -- Trả về thông tin
        SELECT 
            'Book returned successfully' AS message,
            v_days_overdue AS days_overdue,
            v_fine_amount AS fine_amount,
            IF(v_fine_amount > 0, 'Yes', 'No') AS is_overdue;
    END IF;
END //
DELIMITER ;

-- 5. Stored Procedure: Tìm kiếm sách nâng cao (theo nhiều tiêu chí)
DELIMITER //
CREATE PROCEDURE SearchBooks(
    IN p_title VARCHAR(255),
    IN p_author_name VARCHAR(100),
    IN p_category_id INT,
    IN p_publisher_id INT,
    IN p_available_only BOOLEAN
)
BEGIN
    SELECT DISTINCT b.book_id, b.title, b.isbn, b.publication_year, b.language,
           b.total_copies, b.available_copies, p.name AS publisher,
           GROUP_CONCAT(DISTINCT a.name SEPARATOR ', ') AS authors,
           GROUP_CONCAT(DISTINCT c.name SEPARATOR ', ') AS categories
    FROM books b
    LEFT JOIN publishers p ON b.publisher_id = p.publisher_id
    LEFT JOIN book_authors ba ON b.book_id = ba.book_id
    LEFT JOIN authors a ON ba.author_id = a.author_id
    LEFT JOIN book_categories bc ON b.book_id = bc.book_id
    LEFT JOIN categories c ON bc.category_id = c.category_id
    WHERE (p_title IS NULL OR b.title LIKE CONCAT('%', p_title, '%'))
      AND (p_author_name IS NULL OR a.name LIKE CONCAT('%', p_author_name, '%'))
      AND (p_category_id IS NULL OR bc.category_id = p_category_id)
      AND (p_publisher_id IS NULL OR b.publisher_id = p_publisher_id)
      AND (p_available_only = FALSE OR b.available_copies > 0)
    GROUP BY b.book_id
    ORDER BY b.title;
END //
DELIMITER ;

-- 6. Stored Procedure: Thanh toán tiền phạt
DELIMITER //
CREATE PROCEDURE PayFine(
    IN p_fine_id INT,
    IN p_staff_id INT
)
BEGIN
    DECLARE v_transaction_id INT;
    DECLARE v_fine_amount DECIMAL(10,2);
    DECLARE v_fine_status VARCHAR(10);
    
    -- Lấy thông tin về khoản phạt
    SELECT transaction_id, amount, payment_status
    INTO v_transaction_id, v_fine_amount, v_fine_status
    FROM fines
    WHERE fine_id = p_fine_id;
    
    -- Kiểm tra điều kiện
    IF v_transaction_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Fine record not found';
    ELSEIF v_fine_status = 'paid' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Fine already paid';
    ELSE
        -- Bắt đầu transaction
        START TRANSACTION;
        
        -- Cập nhật trạng thái thanh toán
        UPDATE fines
        SET payment_status = 'paid',
            payment_date = CURRENT_TIMESTAMP
        WHERE fine_id = p_fine_id;
        
        -- Cập nhật trạng thái giao dịch nếu đã trả sách
        UPDATE transactions t
        JOIN (SELECT transaction_id, 
                     COUNT(*) AS total_fines,
                     SUM(IF(payment_status = 'paid', 1, 0)) AS paid_fines
              FROM fines
              WHERE transaction_id = v_transaction_id
              GROUP BY transaction_id) f ON t.transaction_id = f.transaction_id
        SET t.status = 'returned'
        WHERE t.transaction_id = v_transaction_id
          AND t.return_date IS NOT NULL
          AND f.total_fines = f.paid_fines;
        
        -- Ghi log hoạt động
        INSERT INTO activity_logs (user_id, action, entity, entity_id, details)
        VALUES (
            p_staff_id, 
            'PAYMENT', 
            'fines', 
            p_fine_id, 
            CONCAT('Fine payment of $', v_fine_amount, ' for Transaction ID ', v_transaction_id)
        );
        
        COMMIT;
        
        SELECT 'Fine payment processed successfully' AS message;
    END IF;
END //
DELIMITER ;
