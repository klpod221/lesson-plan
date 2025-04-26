-- Tạo database
DROP DATABASE IF EXISTS library_management;
CREATE DATABASE IF NOT EXISTS library_management;
USE library_management;

-- Bảng users: Lưu thông tin người dùng (độc giả và nhân viên)
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL, -- Sẽ lưu password đã mã hóa nhận được từ ứng dụng, trong phạm vi bài tập này, chúng ta sẽ không mã hóa
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(255),
    user_type ENUM('reader', 'staff', 'admin') NOT NULL,
    status ENUM('active', 'suspended', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng publishers: Lưu thông tin nhà xuất bản
CREATE TABLE publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(100),
    website VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng categories: Phân loại sách
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    parent_id INT,
    FOREIGN KEY (parent_id) REFERENCES categories(category_id) ON DELETE SET NULL
);

-- Bảng authors: Lưu thông tin tác giả
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    bio TEXT,
    birth_date DATE
);

-- Bảng books: Lưu thông tin sách
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    publisher_id INT,
    publication_year INT,
    description TEXT,
    page_count INT,
    language VARCHAR(50),
    total_copies INT DEFAULT 0,
    available_copies INT DEFAULT 0,
    location VARCHAR(50), -- Vị trí trong thư viện
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id) ON DELETE SET NULL
);

-- Bảng book_authors: Quan hệ nhiều-nhiều giữa sách và tác giả
CREATE TABLE book_authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE
);

-- Bảng book_categories: Quan hệ nhiều-nhiều giữa sách và thể loại
CREATE TABLE book_categories (
    book_id INT,
    category_id INT,
    PRIMARY KEY (book_id, category_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
);

-- Bảng transactions: Lưu giao dịch mượn/trả sách
CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    borrow_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    due_date TIMESTAMP NOT NULL,
    return_date TIMESTAMP NULL,
    fine_amount DECIMAL(10,2) DEFAULT 0.00,
    status ENUM('borrowed', 'returned', 'overdue', 'lost') DEFAULT 'borrowed',
    staff_id INT, -- Nhân viên xử lý giao dịch
    notes TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- Bảng fines: Lưu chi tiết phạt
CREATE TABLE fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    reason VARCHAR(255) NOT NULL,
    fine_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_status ENUM('paid', 'unpaid') DEFAULT 'unpaid',
    payment_date TIMESTAMP NULL,
    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id) ON DELETE CASCADE
);

-- Bảng activity_logs: Ghi lại các hoạt động trong hệ thống
CREATE TABLE activity_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(255) NOT NULL,
    entity VARCHAR(50) NOT NULL,
    entity_id INT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    details TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- Tạo các indexes cho các trường thường xuyên tìm kiếm
CREATE INDEX idx_books_title ON books(title);
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_transactions_user ON transactions(user_id);
CREATE INDEX idx_transactions_book ON transactions(book_id);
CREATE INDEX idx_transactions_status ON transactions(status);
CREATE INDEX idx_books_isbn ON books(isbn);
