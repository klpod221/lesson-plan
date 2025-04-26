-- THIẾT KẾ HỆ THỐNG QUẢN LÝ THƯ VIỆN

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
DELIMITER / /

CREATE TRIGGER after_loan_insert
AFTER INSERT ON loans
FOR EACH ROW
BEGIN
    UPDATE books SET available_copies = available_copies - 1
    WHERE book_id = NEW.book_id;
END //

DELIMITER;

-- 2. Cập nhật số lượng sách có sẵn khi trả sách
DELIMITER / /

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
DELIMITER / /

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
