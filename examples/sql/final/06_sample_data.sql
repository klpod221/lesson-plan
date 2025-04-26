USE library_management;

-- Thêm dữ liệu mẫu cho bảng users
INSERT INTO users (username, password, full_name, email, phone, address, user_type, status)
VALUES
    ('admin1', 'admin123', 'Nguyễn Văn Admin', 'admin@library.com', '0901234567', 'Hà Nội', 'admin', 'active'),
    ('staff1', 'staff123', 'Trần Thị Nhân Viên', 'staff1@library.com', '0912345678', 'Hà Nội', 'staff', 'active'),
    ('staff2', 'staff123', 'Lê Văn Nhân Viên', 'staff2@library.com', '0923456789', 'Hồ Chí Minh', 'staff', 'active'),
    ('reader1', 'reader123', 'Phạm Văn Độc Giả', 'reader1@gmail.com', '0934567890', 'Đà Nẵng', 'reader', 'active'),
    ('reader2', 'reader123', 'Hoàng Thị Độc Giả', 'reader2@gmail.com', '0945678901', 'Hải Phòng', 'reader', 'active'),
    ('reader3', 'reader123', 'Đỗ Văn Độc', 'reader3@gmail.com', '0956789012', 'Cần Thơ', 'reader', 'active'),
    ('reader4', 'reader123', 'Ngô Thị Hoa', 'reader4@gmail.com', '0967890123', 'Huế', 'reader', 'active'),
    ('reader5', 'reader123', 'Vũ Văn Nam', 'reader5@gmail.com', '0978901234', 'Nha Trang', 'reader', 'suspended'),
    ('reader6', 'reader123', 'Đinh Thị Lan', 'reader6@gmail.com', '0989012345', 'Quảng Ninh', 'reader', 'active'),
    ('reader7', 'reader123', 'Bùi Văn Tuấn', 'reader7@gmail.com', '0990123456', 'Bình Dương', 'reader', 'inactive');

-- Thêm dữ liệu mẫu cho bảng publishers
INSERT INTO publishers (name, address, phone, email, website)
VALUES
    ('NXB Giáo Dục', 'Hà Nội', '0241234567', 'contact@nxbgiaoduc.com', 'www.nxbgiaoduc.com'),
    ('NXB Trẻ', 'Hồ Chí Minh', '0281234567', 'contact@nxbtre.com', 'www.nxbtre.com'),
    ('NXB Kim Đồng', 'Hà Nội', '0241234568', 'contact@nxbkimdong.com', 'www.nxbkimdong.com'),
    ('NXB Tổng hợp TP.HCM', 'Hồ Chí Minh', '0281234568', 'contact@nxbhcm.com', 'www.nxbhcm.com'),
    ('NXB Chính trị Quốc gia', 'Hà Nội', '0241234569', 'contact@nxbctqg.vn', 'www.nxbctqg.vn'),
    ('O\'Reilly Media', 'Sebastopol, CA, USA', '+14159037000', 'info@oreilly.com', 'www.oreilly.com'),
    ('Addison-Wesley', 'Boston, MA, USA', '+16173542200', 'info@addisonwesley.com', 'www.addisonwesley.com'),
    ('Manning Publications', 'Shelter Island, NY, USA', '+17327592800', 'info@manning.com', 'www.manning.com'),
    ('Packt Publishing', 'Birmingham, UK', '+441214651125', 'info@packtpub.com', 'www.packtpub.com'),
    ('Apress', 'New York, NY, USA', '+12127602800', 'info@apress.com', 'www.apress.com');

-- Thêm dữ liệu mẫu cho bảng categories
INSERT INTO categories (name, description, parent_id)
VALUES
    ('Công nghệ thông tin', 'Sách về CNTT, lập trình, mạng máy tính...', NULL),
    ('Văn học', 'Các tác phẩm văn học Việt Nam và thế giới', NULL),
    ('Kinh tế', 'Sách về kinh tế, kinh doanh, tài chính...', NULL),
    ('Lập trình', 'Sách về lập trình các ngôn ngữ', 1),
    ('Cơ sở dữ liệu', 'Sách về hệ quản trị CSDL, thiết kế CSDL...', 1),
    ('Mạng máy tính', 'Sách về mạng máy tính, bảo mật...', 1),
    ('Văn học Việt Nam', 'Tác phẩm văn học Việt Nam', 2),
    ('Văn học nước ngoài', 'Tác phẩm văn học nước ngoài được dịch', 2),
    ('Quản trị kinh doanh', 'Sách về quản trị kinh doanh, khởi nghiệp...', 3),
    ('Tài chính - Ngân hàng', 'Sách về tài chính, ngân hàng, chứng khoán...', 3),
    ('Truyện ngắn', 'Các tập truyện ngắn', 2),
    ('Tiểu thuyết', 'Các tác phẩm tiểu thuyết', 2),
    ('Lập trình web', 'Sách về phát triển web', 4),
    ('Lập trình di động', 'Sách về phát triển ứng dụng di động', 4),
    ('Machine Learning', 'Sách về học máy, AI...', 1);

-- Thêm dữ liệu mẫu cho bảng authors
INSERT INTO authors (name, bio, birth_date)
VALUES
    ('Nguyễn Nhật Ánh', 'Nhà văn thiếu nhi nổi tiếng Việt Nam', '1955-05-07'),
    ('Tô Hoài', 'Nhà văn Việt Nam nổi tiếng với tác phẩm Dế Mèn Phiêu Lưu Ký', '1920-09-27'),
    ('Nam Cao', 'Nhà văn, nhà báo Việt Nam nổi tiếng thời kỳ 1945', '1917-10-29'),
    ('Ngô Tất Tố', 'Nhà văn, nhà báo, nhà nghiên cứu Việt Nam', '1893-01-01'),
    ('Robert Martin', 'Kỹ sư phần mềm người Mỹ, tác giả Clean Code', '1952-12-05'),
    ('Martin Fowler', 'Kỹ sư phần mềm, tác giả cuốn Refactoring', '1963-12-18'),
    ('Thomas Cormen', 'Giáo sư khoa học máy tính tại Đại học Dartmouth', '1956-01-01'),
    ('Donald Knuth', 'Giáo sư danh dự Stanford, tác giả The Art of Computer Programming', '1938-01-10'),
    ('Andrew Tanenbaum', 'Giáo sư khoa học máy tính, tác giả nhiều sách về hệ điều hành', '1944-03-16'),
    ('Abraham Silberschatz', 'Giáo sư khoa học máy tính tại Đại học Yale', '1952-01-01'),
    ('Dương Thu Hương', 'Nhà văn Việt Nam', '1947-01-01'),
    ('Bảo Ninh', 'Nhà văn Việt Nam, tác giả Nỗi buồn chiến tranh', '1952-10-18'),
    ('J.K. Rowling', 'Tác giả bộ truyện Harry Potter', '1965-07-31'),
    ('George R.R. Martin', 'Tác giả bộ tiểu thuyết A Song of Ice and Fire', '1948-09-20'),
    ('Paulo Coelho', 'Nhà văn người Brazil', '1947-08-24');

-- Thêm dữ liệu mẫu cho bảng books
INSERT INTO books (title, isbn, publisher_id, publication_year, description, page_count, language, total_copies, available_copies, location)
VALUES
    ('Clean Code', '9780132350884', 6, 2008, 'Sách về cách viết code sạch', 464, 'English', 5, 5, 'Kệ A1'),
    ('Refactoring', '9780201485677', 7, 1999, 'Sách về kỹ thuật tái cấu trúc code', 431, 'English', 3, 3, 'Kệ A1'),
    ('Introduction to Algorithms', '9780262033848', 7, 2009, 'Giáo trình về thuật toán', 1292, 'English', 4, 3, 'Kệ A2'),
    ('Operating System Concepts', '9781118063330', 8, 2012, 'Giáo trình về hệ điều hành', 976, 'English', 3, 2, 'Kệ A2'),
    ('Dế Mèn Phiêu Lưu Ký', '9786045890134', 3, 2020, 'Tác phẩm văn học thiếu nhi nổi tiếng', 208, 'Vietnamese', 10, 9, 'Kệ B1'),
    ('Cho tôi xin một vé đi tuổi thơ', '9786045890141', 2, 2018, 'Tác phẩm của Nguyễn Nhật Ánh', 208, 'Vietnamese', 8, 7, 'Kệ B1'),
    ('Tắt đèn', '9786045890158', 1, 2019, 'Tác phẩm của Ngô Tất Tố', 196, 'Vietnamese', 7, 7, 'Kệ B2'),
    ('Chí Phèo', '9786045890165', 1, 2019, 'Tác phẩm của Nam Cao', 184, 'Vietnamese', 6, 6, 'Kệ B2'),
    ('Nỗi buồn chiến tranh', '9786045890172', 1, 2017, 'Tác phẩm của Bảo Ninh', 292, 'Vietnamese', 5, 5, 'Kệ B3'),
    ('Nhà giả kim', '9786045890189', 2, 2020, 'Tác phẩm của Paulo Coelho, người dịch: Lê Chu Cầu', 228, 'Vietnamese', 10, 9, 'Kệ B3'),
    ('Harry Potter và Hòn đá Phù thủy', '9786045890196', 3, 2020, 'Tác phẩm của J.K. Rowling, người dịch: Lý Lan', 366, 'Vietnamese', 15, 13, 'Kệ C1'),
    ('Trò chơi vương quyền', '9786045890202', 4, 2018, 'Tác phẩm của George R.R. Martin', 864, 'Vietnamese', 8, 7, 'Kệ C1'),
    ('Kinh tế học vi mô', '9786045890219', 1, 2019, 'Giáo trình kinh tế học vi mô', 456, 'Vietnamese', 4, 4, 'Kệ D1'),
    ('Khởi nghiệp tinh gọn', '9786045890226', 4, 2021, 'Sách về phương pháp khởi nghiệp', 324, 'Vietnamese', 6, 6, 'Kệ D1'),
    ('SQL căn bản và nâng cao', '9786045890233', 6, 2020, 'Sách về ngôn ngữ truy vấn SQL', 412, 'Vietnamese', 5, 4, 'Kệ A3');

-- Thêm dữ liệu mẫu cho bảng book_authors (mối quan hệ giữa sách và tác giả)
INSERT INTO book_authors (book_id, author_id)
VALUES
    (1, 5),  -- Clean Code - Robert Martin
    (2, 6),  -- Refactoring - Martin Fowler
    (3, 7),  -- Introduction to Algorithms - Thomas Cormen
    (4, 9),  -- Operating System Concepts - Andrew Tanenbaum
    (4, 10), -- Operating System Concepts - Abraham Silberschatz
    (5, 2),  -- Dế Mèn Phiêu Lưu Ký - Tô Hoài
    (6, 1),  -- Cho tôi xin một vé đi tuổi thơ - Nguyễn Nhật Ánh
    (7, 4),  -- Tắt đèn - Ngô Tất Tố
    (8, 3),  -- Chí Phèo - Nam Cao
    (9, 12), -- Nỗi buồn chiến tranh - Bảo Ninh
    (10, 15), -- Nhà giả kim - Paulo Coelho
    (11, 13), -- Harry Potter và Hòn đá Phù thủy - J.K. Rowling
    (12, 14), -- Trò chơi vương quyền - George R.R. Martin
    (15, 5),  -- SQL căn bản và nâng cao - Robert Martin
    (15, 6);  -- SQL căn bản và nâng cao - Martin Fowler

-- Thêm dữ liệu mẫu cho bảng book_categories (mối quan hệ giữa sách và thể loại)
INSERT INTO book_categories (book_id, category_id)
VALUES
    (1, 4),  -- Clean Code - Lập trình
    (2, 4),  -- Refactoring - Lập trình
    (3, 4),  -- Introduction to Algorithms - Lập trình
    (4, 6),  -- Operating System Concepts - Mạng máy tính
    (5, 7),  -- Dế Mèn Phiêu Lưu Ký - Văn học Việt Nam
    (6, 7),  -- Cho tôi xin một vé đi tuổi thơ - Văn học Việt Nam
    (7, 7),  -- Tắt đèn - Văn học Việt Nam
    (8, 7),  -- Chí Phèo - Văn học Việt Nam
    (9, 7),  -- Nỗi buồn chiến tranh - Văn học Việt Nam
    (10, 8), -- Nhà giả kim - Văn học nước ngoài
    (11, 8), -- Harry Potter và Hòn đá Phù thủy - Văn học nước ngoài
    (12, 8), -- Trò chơi vương quyền - Văn học nước ngoài
    (13, 9), -- Kinh tế học vi mô - Quản trị kinh doanh
    (14, 9), -- Khởi nghiệp tinh gọn - Quản trị kinh doanh
    (15, 5), -- SQL căn bản và nâng cao - Cơ sở dữ liệu
    (1, 1),  -- Clean Code - Công nghệ thông tin
    (2, 1),  -- Refactoring - Công nghệ thông tin
    (3, 1),  -- Introduction to Algorithms - Công nghệ thông tin
    (4, 1),  -- Operating System Concepts - Công nghệ thông tin
    (15, 1); -- SQL căn bản và nâng cao - Công nghệ thông tin

-- Thêm dữ liệu mẫu cho bảng transactions (giao dịch mượn/trả sách)
INSERT INTO transactions (user_id, book_id, borrow_date, due_date, return_date, fine_amount, status, staff_id)
VALUES
    (4, 5, '2023-01-10', '2023-01-24', '2023-01-22', 0, 'returned', 2),
    (4, 10, '2023-02-15', '2023-03-01', '2023-03-05', 20.00, 'returned', 2),
    (5, 11, '2023-02-20', '2023-03-06', NULL, 0, 'borrowed', 2),
    (5, 12, '2023-03-01', '2023-03-15', NULL, 0, 'borrowed', 3),
    (6, 3, '2023-03-05', '2023-03-19', '2023-03-18', 0, 'returned', 3),
    (6, 15, '2023-03-20', '2023-04-03', NULL, 0, 'borrowed', 2),
    (7, 6, '2023-03-25', '2023-04-08', NULL, 0, 'borrowed', 3),
    (4, 1, '2023-04-01', '2023-04-15', '2023-04-10', 0, 'returned', 2),
    (6, 2, '2023-04-10', '2023-04-24', NULL, 0, 'borrowed', 3),
    (7, 4, '2023-01-05', '2023-01-19', '2023-02-05', 85.00, 'overdue', 2);

-- Thêm dữ liệu mẫu cho bảng fines (các khoản phạt)
INSERT INTO fines (transaction_id, amount, reason, payment_status, payment_date)
VALUES
    (2, 20.00, 'Overdue by 4 days', 'paid', '2023-03-05'),
    (10, 85.00, 'Overdue by 17 days', 'unpaid', NULL);

-- Thêm dữ liệu mẫu cho bảng activity_logs (log hoạt động)
INSERT INTO activity_logs (user_id, action, entity, entity_id, details)
VALUES
    (1, 'CREATE', 'users', 4, 'New user registered: reader1'),
    (1, 'CREATE', 'users', 5, 'New user registered: reader2'),
    (2, 'BORROW', 'transactions', 1, 'User ID 4 borrowed Book ID 5'),
    (2, 'RETURN', 'transactions', 1, 'User ID 4 returned Book ID 5'),
    (2, 'BORROW', 'transactions', 2, 'User ID 4 borrowed Book ID 10'),
    (2, 'RETURN', 'transactions', 2, 'User ID 4 returned Book ID 10 with fine: $20.00'),
    (2, 'PAYMENT', 'fines', 1, 'Fine payment of $20.00 for Transaction ID 2'),
    (2, 'UPDATE', 'books', 3, 'Book information updated. ID: 3, Title: Introduction to Algorithms'),
    (3, 'BORROW', 'transactions', 3, 'User ID 5 borrowed Book ID 11'),
    (3, 'BORROW', 'transactions', 4, 'User ID 5 borrowed Book ID 12'),
    (3, 'BORROW', 'transactions', 5, 'User ID 6 borrowed Book ID 3'),
    (3, 'RETURN', 'transactions', 5, 'User ID 6 returned Book ID 3'),
    (2, 'BORROW', 'transactions', 6, 'User ID 6 borrowed Book ID 15'),
    (3, 'BORROW', 'transactions', 7, 'User ID 7 borrowed Book ID 6'),
    (2, 'BORROW', 'transactions', 8, 'User ID 4 borrowed Book ID 1'),
    (2, 'RETURN', 'transactions', 8, 'User ID 4 returned Book ID 1'),
    (3, 'BORROW', 'transactions', 9, 'User ID 6 borrowed Book ID 2'),
    (2, 'BORROW', 'transactions', 10, 'User ID 7 borrowed Book ID 4'),
    (2, 'RETURN', 'transactions', 10, 'User ID 7 returned Book ID 4 with fine: $85.00');
