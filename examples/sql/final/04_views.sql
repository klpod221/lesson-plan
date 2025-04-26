USE library_management;

-- 1. View: Danh sách sách đang được mượn
CREATE VIEW vw_currently_borrowed_books AS
SELECT 
    t.transaction_id,
    b.book_id,
    b.title,
    b.isbn,
    u.user_id,
    u.full_name AS borrower_name,
    t.borrow_date,
    t.due_date,
    CASE 
        WHEN t.due_date < CURRENT_TIMESTAMP THEN 'Overdue'
        ELSE 'On time'
    END AS status,
    DATEDIFF(t.due_date, CURRENT_TIMESTAMP) AS days_remaining
FROM 
    transactions t
JOIN 
    books b ON t.book_id = b.book_id
JOIN 
    users u ON t.user_id = u.user_id
WHERE 
    t.return_date IS NULL
ORDER BY 
    days_remaining ASC;

-- 2. View: Thông tin chi tiết sách kèm tình trạng
CREATE VIEW vw_book_details AS
SELECT 
    b.book_id,
    b.title,
    b.isbn,
    b.publication_year,
    b.page_count,
    b.language,
    p.name AS publisher_name,
    b.total_copies,
    b.available_copies,
    ROUND((b.available_copies / b.total_copies) * 100, 2) AS availability_percentage,
    GROUP_CONCAT(DISTINCT a.name SEPARATOR ', ') AS authors,
    GROUP_CONCAT(DISTINCT c.name SEPARATOR ', ') AS categories,
    b.description
FROM 
    books b
LEFT JOIN 
    publishers p ON b.publisher_id = p.publisher_id
LEFT JOIN 
    book_authors ba ON b.book_id = ba.book_id
LEFT JOIN 
    authors a ON ba.author_id = a.author_id
LEFT JOIN 
    book_categories bc ON b.book_id = bc.book_id
LEFT JOIN 
    categories c ON bc.category_id = c.category_id
GROUP BY 
    b.book_id;

-- 3. View: Thống kê mượn sách theo độc giả
CREATE VIEW vw_user_borrowing_statistics AS
SELECT 
    u.user_id,
    u.username,
    u.full_name,
    COUNT(t.transaction_id) AS total_borrowed,
    SUM(CASE WHEN t.return_date IS NULL THEN 1 ELSE 0 END) AS currently_borrowed,
    SUM(CASE WHEN t.status = 'overdue' THEN 1 ELSE 0 END) AS overdue_count,
    SUM(f.amount) AS total_fines,
    SUM(CASE WHEN f.payment_status = 'unpaid' THEN f.amount ELSE 0 END) AS unpaid_fines
FROM 
    users u
LEFT JOIN 
    transactions t ON u.user_id = t.user_id
LEFT JOIN 
    fines f ON t.transaction_id = f.transaction_id
WHERE 
    u.user_type = 'reader'
GROUP BY 
    u.user_id
ORDER BY 
    total_borrowed DESC;

-- 4. View: Thống kê sách phổ biến nhất
CREATE VIEW vw_most_popular_books AS
SELECT 
    b.book_id,
    b.title,
    b.isbn,
    COUNT(t.transaction_id) AS borrow_count,
    AVG(CASE 
        WHEN t.return_date IS NOT NULL THEN 
            DATEDIFF(t.return_date, t.borrow_date) 
        ELSE 
            DATEDIFF(CURRENT_TIMESTAMP, t.borrow_date) 
    END) AS avg_borrow_days,
    GROUP_CONCAT(DISTINCT a.name SEPARATOR ', ') AS authors,
    GROUP_CONCAT(DISTINCT c.name SEPARATOR ', ') AS categories
FROM 
    books b
LEFT JOIN 
    transactions t ON b.book_id = t.book_id
LEFT JOIN 
    book_authors ba ON b.book_id = ba.book_id
LEFT JOIN 
    authors a ON ba.author_id = a.author_id
LEFT JOIN 
    book_categories bc ON b.book_id = bc.book_id
LEFT JOIN 
    categories c ON bc.category_id = c.category_id
GROUP BY 
    b.book_id
ORDER BY 
    borrow_count DESC, avg_borrow_days DESC;

-- 5. View: Báo cáo tình trạng thư viện
CREATE VIEW vw_library_status_report AS
SELECT
    (SELECT COUNT(*) FROM books) AS total_books,
    (SELECT SUM(total_copies) FROM books) AS total_copies,
    (SELECT SUM(available_copies) FROM books) AS available_copies,
    (SELECT COUNT(*) FROM users WHERE user_type = 'reader') AS total_readers,
    (SELECT COUNT(*) FROM users WHERE user_type = 'staff') AS total_staff,
    (SELECT COUNT(*) FROM transactions WHERE return_date IS NULL) AS active_borrows,
    (SELECT COUNT(*) FROM transactions WHERE status = 'overdue') AS overdue_borrows,
    (SELECT SUM(amount) FROM fines WHERE payment_status = 'unpaid') AS unpaid_fines;

-- 6. View: Báo cáo hoạt động theo thời gian
CREATE VIEW vw_activity_by_time AS
SELECT 
    DATE(borrow_date) AS activity_date,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status = 'borrowed' THEN 1 ELSE 0 END) AS borrows,
    SUM(CASE WHEN return_date IS NOT NULL THEN 1 ELSE 0 END) AS returns,
    SUM(CASE WHEN status = 'overdue' THEN 1 ELSE 0 END) AS overdue_items
FROM 
    transactions
GROUP BY 
    activity_date
ORDER BY 
    activity_date DESC;
