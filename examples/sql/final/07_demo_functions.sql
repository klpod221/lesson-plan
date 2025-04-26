USE library_management;

-- ===================================================================
-- PHẦN 1: DEMO CÁC STORED PROCEDURES
-- ===================================================================

-- 1.1. Đăng ký người dùng mới (RegisterUser)
-- Demo: Đăng ký một độc giả mới
CALL RegisterUser(
    'reader8', 
    'pass123', 
    'Lý Thị Hương', 
    'huong@gmail.com', 
    '0912345678', 
    'Hà Nội', 
    'reader'
);

-- 1.2. Thêm sách mới (AddNewBook)
-- Demo: Thêm một cuốn sách mới về lập trình Python
CALL AddNewBook(
    'Python for Data Analysis', 
    '9781449319793', 
    6, -- O'Reilly Media
    2022, 
    'Sách về phân tích dữ liệu với Python', 
    550, 
    'English', 
    3, 
    'Kệ A4', 
    '5,6', -- Robert Martin, Martin Fowler
    '4,15' -- Lập trình, Machine Learning
);

-- 1.3. Mượn sách (BorrowBook)
-- Demo: Độc giả mượn sách
CALL BorrowBook(
    4, -- user_id (reader1)
    15, -- book_id (SQL căn bản và nâng cao)
    2, -- staff_id (staff1)
    14 -- mượn trong 14 ngày
);

-- 1.4. Trả sách và tính phí phạt (ReturnBook)
-- Demo: Trả sách đúng hạn
CALL ReturnBook(
    8, -- transaction_id
    2  -- staff_id (staff1)
);

-- 1.5. Tìm kiếm sách nâng cao (SearchBooks)
-- Demo: Tìm sách theo tiêu đề và thể loại
CALL SearchBooks(
    'code', -- title
    NULL, -- author_name
    4, -- category_id (Lập trình)
    NULL, -- publisher_id
    TRUE -- chỉ hiển thị sách có sẵn
);

-- 1.6. Thanh toán tiền phạt (PayFine)
-- Demo: Thanh toán khoản phạt cho giao dịch quá hạn
CALL PayFine(
    2, -- fine_id
    2  -- staff_id (staff1)
);

-- ===================================================================
-- PHẦN 2: DEMO CÁC VIEWS
-- ===================================================================

-- 2.1. Xem danh sách sách đang được mượn
SELECT * FROM vw_currently_borrowed_books;

-- 2.2. Xem chi tiết sách
SELECT * FROM vw_book_details WHERE title LIKE '%SQL%';

-- 2.3. Xem thống kê mượn sách của độc giả
SELECT * FROM vw_user_borrowing_statistics ORDER BY total_borrowed DESC LIMIT 5;

-- 2.4. Xem sách phổ biến nhất
SELECT * FROM vw_most_popular_books ORDER BY borrow_count DESC LIMIT 5;

-- 2.5. Xem báo cáo tình trạng thư viện
SELECT * FROM vw_library_status_report;

-- 2.6. Xem báo cáo hoạt động theo thời gian
SELECT * FROM vw_activity_by_time WHERE activity_date > '2023-03-01' ORDER BY activity_date DESC;

-- ===================================================================
-- PHẦN 3: DEMO CÁC TÍNH NĂNG NÂNG CAO
-- ===================================================================

-- 3.1. Tìm sách với điều kiện phức tạp
SELECT b.book_id, b.title, b.isbn, b.available_copies,
       GROUP_CONCAT(DISTINCT a.name SEPARATOR ', ') AS authors,
       GROUP_CONCAT(DISTINCT c.name SEPARATOR ', ') AS categories
FROM books b
JOIN book_authors ba ON b.book_id = ba.book_id
JOIN authors a ON ba.author_id = a.author_id
JOIN book_categories bc ON b.book_id = bc.book_id
JOIN categories c ON bc.category_id = c.category_id
WHERE c.name IN ('Lập trình', 'Cơ sở dữ liệu')
AND b.available_copies > 0
AND b.publication_year > 2015
GROUP BY b.book_id
HAVING COUNT(DISTINCT c.category_id) >= 1
ORDER BY b.publication_year DESC;

-- 3.2. Thống kê số sách mượn theo từng thể loại
SELECT c.name AS category_name,
       COUNT(DISTINCT t.transaction_id) AS borrow_count
FROM categories c
JOIN book_categories bc ON c.category_id = bc.category_id
JOIN books b ON bc.book_id = b.book_id
JOIN transactions t ON b.book_id = t.book_id
GROUP BY c.name
ORDER BY borrow_count DESC;

-- 3.3. Tìm độc giả thường xuyên trả sách trễ
SELECT u.user_id, u.username, u.full_name,
       COUNT(t.transaction_id) AS total_transactions,
       SUM(CASE WHEN t.status = 'overdue' OR t.fine_amount > 0 THEN 1 ELSE 0 END) AS overdue_count,
       ROUND(SUM(CASE WHEN t.status = 'overdue' OR t.fine_amount > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(t.transaction_id), 2) AS overdue_percentage,
       SUM(t.fine_amount) AS total_fine_amount
FROM users u
JOIN transactions t ON u.user_id = t.user_id
GROUP BY u.user_id, u.username, u.full_name
HAVING COUNT(t.transaction_id) >= 2
ORDER BY overdue_percentage DESC, total_fine_amount DESC;

-- 3.4. Tìm sách chưa từng được mượn
SELECT b.book_id, b.title, b.isbn, b.publication_year,
       GROUP_CONCAT(DISTINCT a.name SEPARATOR ', ') AS authors
FROM books b
LEFT JOIN transactions t ON b.book_id = t.book_id
LEFT JOIN book_authors ba ON b.book_id = ba.book_id
LEFT JOIN authors a ON ba.author_id = a.author_id
WHERE t.transaction_id IS NULL
GROUP BY b.book_id, b.title, b.isbn, b.publication_year
ORDER BY b.publication_year DESC;

-- 3.5. Đề xuất sách cho độc giả dựa trên lịch sử mượn
SELECT u.user_id, u.full_name,
       -- Sách đã mượn
       (SELECT GROUP_CONCAT(DISTINCT b.title SEPARATOR ', ')
        FROM transactions t
        JOIN books b ON t.book_id = b.book_id
        WHERE t.user_id = u.user_id) AS borrowed_books,
        
       -- Thể loại yêu thích
       (SELECT GROUP_CONCAT(DISTINCT c.name SEPARATOR ', ')
        FROM transactions t
        JOIN books b ON t.book_id = b.book_id
        JOIN book_categories bc ON b.book_id = bc.book_id
        JOIN categories c ON bc.category_id = c.category_id
        WHERE t.user_id = u.user_id
        GROUP BY t.user_id) AS favorite_categories,
        
       -- Đề xuất sách cùng thể loại nhưng chưa mượn
       (SELECT GROUP_CONCAT(DISTINCT rec_b.title SEPARATOR ', ')
        FROM books rec_b
        JOIN book_categories rec_bc ON rec_b.book_id = rec_bc.book_id
        JOIN categories rec_c ON rec_bc.category_id = rec_c.category_id
        WHERE rec_c.category_id IN (
            SELECT bc.category_id
            FROM transactions t
            JOIN books b ON t.book_id = b.book_id
            JOIN book_categories bc ON b.book_id = bc.book_id
            WHERE t.user_id = u.user_id
        )
        AND rec_b.book_id NOT IN (
            SELECT t.book_id
            FROM transactions t
            WHERE t.user_id = u.user_id
        )
        AND rec_b.available_copies > 0
        LIMIT 3) AS recommended_books
FROM users u
WHERE u.user_type = 'reader'
AND EXISTS (
    SELECT 1
    FROM transactions t
    WHERE t.user_id = u.user_id
)
ORDER BY u.user_id;

-- ===================================================================
-- PHẦN 4: DEMO CÁC TÌNH HUỐNG LỖI VÀ XỬ LÝ
-- ===================================================================

-- 4.1. Đăng ký người dùng với username đã tồn tại
CALL RegisterUser(
    'reader1', -- username đã tồn tại
    'pass123', 
    'Người Trùng Tên', 
    'trungten@gmail.com', 
    '0912345678', 
    'Hà Nội', 
    'reader'
);

-- 4.2. Mượn sách khi không còn sách 
-- (giả sử đã cập nhật available_copies = 0 cho sách có book_id = 1)
UPDATE books SET available_copies = 0 WHERE book_id = 1;
CALL BorrowBook(
    4, -- user_id (reader1)
    1, -- book_id (Clean Code, không còn sách)
    2, -- staff_id (staff1)
    14 -- mượn trong 14 ngày
);

-- 4.3. Mượn sách khi người dùng bị khóa
CALL BorrowBook(
    8, -- user_id (reader5, status = suspended)
    5, -- book_id (Dế Mèn Phiêu Lưu Ký)
    2, -- staff_id (staff1)
    14 -- mượn trong 14 ngày
);

-- 4.4. Trả sách đã trả rồi
CALL ReturnBook(
    1, -- transaction_id (đã trả sách rồi)
    2  -- staff_id (staff1)
);

-- 4.5. Thanh toán khoản phạt không tồn tại
CALL PayFine(
    99, -- fine_id không tồn tại
    2   -- staff_id (staff1)
);

-- ===================================================================
-- PHẦN 5: DEMO CÁC CHỨC NĂNG DÀNH CHO ADMIN
-- ===================================================================

-- 5.1. Thống kê hoạt động của nhân viên
SELECT 
    u.user_id,
    u.username,
    u.full_name,
    COUNT(CASE WHEN al.action = 'BORROW' THEN 1 ELSE NULL END) AS borrow_count,
    COUNT(CASE WHEN al.action = 'RETURN' THEN 1 ELSE NULL END) AS return_count,
    COUNT(CASE WHEN al.action = 'PAYMENT' THEN 1 ELSE NULL END) AS payment_count,
    COUNT(al.log_id) AS total_activities
FROM 
    users u
JOIN 
    activity_logs al ON u.user_id = al.user_id
WHERE 
    u.user_type = 'staff'
GROUP BY 
    u.user_id, u.username, u.full_name
ORDER BY 
    total_activities DESC;

-- 5.2. Khóa tài khoản người dùng vi phạm nhiều lần
UPDATE users SET status = 'suspended'
WHERE user_id IN (
    SELECT user_id FROM (
        SELECT u.user_id
        FROM users u
        JOIN transactions t ON u.user_id = t.user_id
        WHERE t.status = 'overdue'
        GROUP BY u.user_id
        HAVING COUNT(*) >= 2
    ) AS violators
);

-- 5.3. Kiểm tra các giao dịch quá hạn hiện tại
SELECT 
    t.transaction_id,
    b.title,
    u.full_name AS reader_name,
    t.borrow_date,
    t.due_date,
    DATEDIFF(CURRENT_TIMESTAMP, t.due_date) AS days_overdue,
    DATEDIFF(CURRENT_TIMESTAMP, t.due_date) * 5.00 AS estimated_fine
FROM 
    transactions t
JOIN 
    books b ON t.book_id = b.book_id
JOIN 
    users u ON t.user_id = u.user_id
WHERE 
    t.status = 'borrowed'
    AND t.due_date < CURRENT_TIMESTAMP
    AND t.return_date IS NULL
ORDER BY 
    days_overdue DESC;

-- 5.4. Sao lưu thông tin quan trọng (có thể chạy trong câu lệnh export)
SELECT 'Backup của bảng users:' AS info;
SELECT * FROM users;

SELECT 'Backup của bảng books:' AS info;
SELECT * FROM books;

SELECT 'Backup của bảng transactions:' AS info;
SELECT * FROM transactions WHERE return_date IS NULL;

-- 5.5. Tìm người dùng có nhiều hoạt động không bình thường
SELECT 
    u.user_id, 
    u.username, 
    u.full_name,
    COUNT(t.transaction_id) AS borrow_count,
    COUNT(DISTINCT DATE(t.borrow_date)) AS active_days,
    COUNT(t.transaction_id) / COUNT(DISTINCT DATE(t.borrow_date)) AS borrows_per_day
FROM 
    users u
JOIN 
    transactions t ON u.user_id = t.user_id
GROUP BY 
    u.user_id, u.username, u.full_name
HAVING 
    COUNT(DISTINCT DATE(t.borrow_date)) > 1
    AND COUNT(t.transaction_id) / COUNT(DISTINCT DATE(t.borrow_date)) > 2
ORDER BY 
    borrows_per_day DESC;
