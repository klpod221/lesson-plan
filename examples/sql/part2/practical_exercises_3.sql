-- THIẾT KẾ HỆ THỐNG QUẢN LÝ THƯ VIỆN

DROP DATABASE IF EXISTS library_management;

CREATE DATABASE IF NOT EXISTS library_management;

USE library_management;

-- Bảng Authors (Tác giả)
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    nationality VARCHAR(50),
    biography TEXT
);

-- Bảng Publishers (Nhà xuất bản)
CREATE TABLE publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(15),
    email VARCHAR(100)
);

-- Bảng Categories (Thể loại sách)
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    description VARCHAR(255)
);

-- Bảng Books (Sách)
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE,
    title VARCHAR(255) NOT NULL,
    publisher_id INT,
    publication_date DATE,
    pages INT,
    language VARCHAR(30),
    description TEXT,
    shelf_location VARCHAR(20),
    available_copies INT NOT NULL DEFAULT 0,
    FOREIGN KEY (publisher_id) REFERENCES publishers (publisher_id)
);

-- Bảng book_authors (quan hệ nhiều-nhiều giữa sách và tác giả)
CREATE TABLE book_authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books (book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors (author_id) ON DELETE CASCADE
);

-- Bảng book_categories (quan hệ nhiều-nhiều giữa sách và thể loại)
CREATE TABLE book_categories (
    book_id INT,
    category_id INT,
    PRIMARY KEY (book_id, category_id),
    FOREIGN KEY (book_id) REFERENCES books (book_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories (category_id) ON DELETE CASCADE
);

-- Bảng Members (Độc giả/Thành viên)
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    address VARCHAR(255),
    phone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    registration_date DATE NOT NULL DEFAULT(CURRENT_DATE),
    expiry_date DATE,
    status ENUM(
        'Active',
        'Expired',
        'Suspended'
    ) DEFAULT 'Active'
);

-- Bảng Loans (Mượn sách)
CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    loan_date DATE NOT NULL DEFAULT(CURRENT_DATE),
    due_date DATE NOT NULL,
    return_date DATE,
    status ENUM(
        'Borrowed',
        'Returned',
        'Overdue',
        'Lost'
    ) DEFAULT 'Borrowed',
    notes TEXT,
    FOREIGN KEY (book_id) REFERENCES books (book_id),
    FOREIGN KEY (member_id) REFERENCES members (member_id)
);

-- Bảng Fines (Tiền phạt)
CREATE TABLE fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    reason VARCHAR(255) NOT NULL,
    fine_date DATE NOT NULL DEFAULT(CURRENT_DATE),
    payment_date DATE,
    status ENUM('Paid', 'Unpaid') DEFAULT 'Unpaid',
    FOREIGN KEY (loan_id) REFERENCES loans (loan_id)
);

-- Bảng Reservations (Đặt trước sách)
CREATE TABLE reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    reservation_date DATE NOT NULL DEFAULT(CURRENT_DATE),
    expiry_date DATE NOT NULL,
    status ENUM(
        'Active',
        'Completed',
        'Cancelled',
        'Expired'
    ) DEFAULT 'Active',
    FOREIGN KEY (book_id) REFERENCES books (book_id),
    FOREIGN KEY (member_id) REFERENCES members (member_id)
);

-- Các chỉ mục cần thiết để cải thiện hiệu suất
CREATE INDEX idx_book_title ON books (title);

CREATE INDEX idx_book_isbn ON books (isbn);

CREATE INDEX idx_member_name ON members (last_name, first_name);

CREATE INDEX idx_loan_dates ON loans (
    loan_date,
    due_date,
    return_date
);

CREATE INDEX idx_loan_status ON loans (status);

CREATE FULLTEXT INDEX idx_book_search ON books (title, description);

-- Các trigger để đảm bảo tính nhất quán dữ liệu

-- 1. Cập nhật số lượng sách có sẵn khi cho mượn
DELIMITER //
CREATE TRIGGER after_loan_insert
AFTER INSERT ON loans
FOR EACH ROW
BEGIN
    UPDATE books SET available_copies = available_copies - 1
    WHERE book_id = NEW.book_id;
END //
DELIMITER;

-- 2. Cập nhật số lượng sách có sẵn khi trả sách
DELIMITER //
CREATE TRIGGER after_loan_return
AFTER UPDATE ON loans
FOR EACH ROW
BEGIN
    IF OLD.status = 'Borrowed' AND NEW.status = 'Returned' THEN
        UPDATE books SET available_copies = available_copies + 1
        WHERE book_id = NEW.book_id;
    END IF;
END //
DELIMITER;

-- 3. Tính tiền phạt tự động khi trả sách quá hạn
DELIMITER //
CREATE TRIGGER calculate_fine_on_return
BEFORE UPDATE ON loans
FOR EACH ROW
BEGIN
    DECLARE days_overdue INT;
    DECLARE fine_per_day DECIMAL(10,2) DEFAULT 10000; -- 10,000 VND per day
    
    IF OLD.status = 'Borrowed' AND NEW.status = 'Returned' AND NEW.return_date > NEW.due_date THEN
        SET days_overdue = DATEDIFF(NEW.return_date, NEW.due_date);
        
        -- Insert fine record
        INSERT INTO fines (loan_id, amount, reason, fine_date)
        VALUES (NEW.loan_id, days_overdue * fine_per_day, 
                CONCAT('Quá hạn ', days_overdue, ' ngày'), NEW.return_date);
    END IF;
END //
DELIMITER;

-- Tạo dữ liệu mẫu cho hệ thống thư viện

-- Thêm dữ liệu vào bảng authors
INSERT INTO authors (author_name, birth_date, nationality, biography) VALUES
('Nguyễn Nhật Ánh', '1955-05-07', 'Vietnamese', 'Nhà văn nổi tiếng với nhiều tác phẩm văn học thiếu nhi và thanh niên'),
('Tô Hoài', '1920-09-27', 'Vietnamese', 'Nhà văn nổi tiếng với tác phẩm Dế Mèn phiêu lưu ký'),
('Paulo Coelho', '1947-08-24', 'Brazilian', 'Tác giả của cuốn The Alchemist'),
('J.K. Rowling', '1965-07-31', 'British', 'Tác giả của series Harry Potter'),
('Dale Carnegie', '1888-11-24', 'American', 'Tác giả của nhiều cuốn sách self-help nổi tiếng');

-- Thêm dữ liệu vào bảng publishers
INSERT INTO publishers (publisher_name, address, phone, email) VALUES
('NXB Trẻ', 'TP. Hồ Chí Minh', '0283822524', 'nxbtre@gmail.com'),
('NXB Kim Đồng', 'Hà Nội', '0243825444', 'kimdong@gmail.com'),
('NXB Giáo Dục', 'Hà Nội', '0243822972', 'nxbgd@gmail.com'),
('Bloomsbury', 'London, UK', '+44207631888', 'contact@bloomsbury.com'),
('HarperCollins', 'New York, USA', '+12124075000', 'info@harpercollins.com');

-- Thêm dữ liệu vào bảng categories
INSERT INTO categories (category_name, description) VALUES
('Văn học thiếu nhi', 'Sách dành cho trẻ em và thanh thiếu niên'),
('Tiểu thuyết', 'Các tác phẩm văn học có cốt truyện dài'),
('Self-help', 'Sách về phát triển bản thân'),
('Khoa học', 'Sách về các lĩnh vực khoa học'),
('Lập trình', 'Sách về ngôn ngữ lập trình và công nghệ');

-- Thêm dữ liệu vào bảng books
INSERT INTO books (isbn, title, publisher_id, publication_date, pages, language, description, shelf_location, available_copies) VALUES
('9786045877377', 'Mắt biếc', 1, '2019-05-01', 300, 'Vietnamese', 'Câu chuyện về tình yêu tuổi học trò', 'A1-01', 5),
('9786045879222', 'Cho tôi xin một vé đi tuổi thơ', 1, '2018-06-15', 250, 'Vietnamese', 'Hồi ức về tuổi thơ', 'A1-02', 3),
('9786048948868', 'Dế Mèn phiêu lưu ký', 2, '2020-01-10', 180, 'Vietnamese', 'Cuộc phiêu lưu của chú Dế Mèn', 'A2-01', 10),
('9788408052784', 'The Alchemist', 5, '2015-08-24', 163, 'English', 'A philosophical novel about following your dreams', 'B1-01', 7),
('9780747558194', 'Harry Potter and the Philosopher''s Stone', 4, '2001-06-26', 223, 'English', 'The first book in the Harry Potter series', 'B2-01', 4),
('9780671723651', 'How to Win Friends and Influence People', 5, '2010-11-03', 291, 'English', 'The fundamental techniques in handling people', 'C1-01', 8),
('9786045628394', 'Cơ sở dữ liệu', 3, '2021-03-15', 400, 'Vietnamese', 'Giáo trình về cơ sở dữ liệu', 'D1-01', 15);

-- Thêm dữ liệu vào bảng book_authors
INSERT INTO book_authors (book_id, author_id) VALUES
(1, 1), -- Mắt biếc - Nguyễn Nhật Ánh
(2, 1), -- Cho tôi xin một vé đi tuổi thơ - Nguyễn Nhật Ánh
(3, 2), -- Dế Mèn phiêu lưu ký - Tô Hoài
(4, 3), -- The Alchemist - Paulo Coelho
(5, 4), -- Harry Potter - J.K. Rowling
(6, 5); -- How to Win Friends - Dale Carnegie

-- Thêm dữ liệu vào bảng book_categories
INSERT INTO book_categories (book_id, category_id) VALUES
(1, 2), -- Mắt biếc - Tiểu thuyết
(2, 1), -- Cho tôi xin một vé đi tuổi thơ - Văn học thiếu nhi
(2, 2), -- Cho tôi xin một vé đi tuổi thơ - Tiểu thuyết
(3, 1), -- Dế Mèn phiêu lưu ký - Văn học thiếu nhi
(4, 2), -- The Alchemist - Tiểu thuyết
(5, 1), -- Harry Potter - Văn học thiếu nhi
(5, 2), -- Harry Potter - Tiểu thuyết
(6, 3), -- How to Win Friends - Self-help
(7, 4), -- Cơ sở dữ liệu - Khoa học
(7, 5); -- Cơ sở dữ liệu - Lập trình

-- Thêm dữ liệu vào bảng members
INSERT INTO members (first_name, last_name, date_of_birth, address, phone, email, registration_date, expiry_date, status) VALUES
('Minh', 'Nguyễn', '1995-05-15', 'Hà Nội', '0912345678', 'minh@example.com', '2023-01-15', '2024-01-15', 'Active'),
('Hương', 'Trần', '1990-08-20', 'TP. Hồ Chí Minh', '0987654321', 'huong@example.com', '2023-02-10', '2024-02-10', 'Active'),
('Nam', 'Lê', '1998-11-05', 'Đà Nẵng', '0909123456', 'nam@example.com', '2023-01-20', '2024-01-20', 'Active'),
('Linh', 'Phạm', '2000-03-25', 'Cần Thơ', '0978123456', 'linh@example.com', '2022-12-01', '2023-12-01', 'Active'),
('Tuấn', 'Vũ', '1985-07-10', 'Hải Phòng', '0918765432', 'tuan@example.com', '2023-05-05', '2023-11-05', 'Expired');

-- Thêm dữ liệu vào bảng loans
INSERT INTO loans (book_id, member_id, loan_date, due_date, return_date, status, notes) VALUES
(1, 1, '2023-06-01', '2023-06-15', '2023-06-14', 'Returned', 'Trả đúng hạn'),
(2, 1, '2023-07-05', '2023-07-19', NULL, 'Borrowed', 'Sách đang được mượn'),
(3, 2, '2023-06-10', '2023-06-24', '2023-06-30', 'Returned', 'Trả muộn 6 ngày'),
(4, 3, '2023-07-01', '2023-07-15', NULL, 'Borrowed', 'Sách đang được mượn'),
(5, 4, '2023-05-20', '2023-06-03', NULL, 'Overdue', 'Quá hạn'),
(6, 5, '2023-04-15', '2023-04-29', NULL, 'Lost', 'Thành viên báo mất sách');

-- Thêm dữ liệu vào bảng fines
INSERT INTO fines (loan_id, amount, reason, fine_date, payment_date, status) VALUES
(3, 60000, 'Quá hạn 6 ngày', '2023-06-30', '2023-07-02', 'Paid'),
(5, 380000, 'Quá hạn 38 ngày', '2023-07-11', NULL, 'Unpaid'),
(6, 500000, 'Làm mất sách', '2023-05-10', NULL, 'Unpaid');

-- Thêm dữ liệu vào bảng reservations
INSERT INTO reservations (book_id, member_id, reservation_date, expiry_date, status) VALUES
(1, 3, '2023-07-10', '2023-07-17', 'Active'),
(5, 2, '2023-07-05', '2023-07-12', 'Active'),
(4, 4, '2023-06-25', '2023-07-02', 'Expired'),
(2, 5, '2023-06-20', '2023-06-27', 'Cancelled');


-- Truy vấn mẫu cho hệ thống thư viện:

-- 1. Tìm tất cả sách của một tác giả
SELECT b.book_id, b.title, b.isbn, b.publication_date
FROM
    books b
    JOIN book_authors ba ON b.book_id = ba.book_id
    JOIN authors a ON ba.author_id = a.author_id
WHERE
    a.author_name = 'Nguyễn Nhật Ánh';

-- 2. Kiểm tra sách đang được mượn bởi thành viên nào
SELECT m.member_id, CONCAT(
        m.first_name, ' ', m.last_name
    ) as member_name, b.title, l.loan_date, l.due_date
FROM loans l
    JOIN books b ON l.book_id = b.book_id
    JOIN members m ON l.member_id = m.member_id
WHERE
    l.status = 'Borrowed'
ORDER BY l.due_date;

-- 3. Thống kê sách quá hạn
SELECT
    b.title,
    CONCAT(
        m.first_name,
        ' ',
        m.last_name
    ) as borrower,
    l.loan_date,
    l.due_date,
    DATEDIFF(CURRENT_DATE, l.due_date) as days_overdue
FROM loans l
    JOIN books b ON l.book_id = b.book_id
    JOIN members m ON l.member_id = m.member_id
WHERE
    l.status = 'Borrowed'
    AND l.due_date < CURRENT_DATE
ORDER BY days_overdue DESC;

-- 4. Tìm sách theo từ khóa (sử dụng FULLTEXT search)
SELECT book_id, title, description
FROM books
WHERE
    MATCH(title, description) AGAINST (
        'lập trình' IN NATURAL LANGUAGE MODE
    );

-- 5. Thống kê số lượng sách theo thể loại
SELECT c.category_name, COUNT(bc.book_id) as book_count
FROM
    categories c
    LEFT JOIN book_categories bc ON c.category_id = bc.category_id
GROUP BY
    c.category_id,
    c.category_name
ORDER BY book_count DESC;

-- 6. Tìm tất cả thành viên có sách đang mượn
SELECT m.member_id, CONCAT(
        m.first_name, ' ', m.last_name
    ) as member_name, COUNT(l.loan_id) as books_borrowed
FROM members m
    LEFT JOIN loans l ON m.member_id = l.member_id
WHERE
    l.status = 'Borrowed'
GROUP BY
    m.member_id,
    m.first_name,
    m.last_name
ORDER BY books_borrowed DESC;

-- 7. Tìm tất cả sách đã được đặt trước
SELECT b.book_id, b.title, r.reservation_date, r.expiry_date
FROM
    books b
    JOIN reservations r ON b.book_id = r.book_id
WHERE
    r.status = 'Active'
ORDER BY r.reservation_date DESC;


