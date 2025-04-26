USE library_management;

-- Tạo các role
CREATE ROLE IF NOT EXISTS reader_role;
CREATE ROLE IF NOT EXISTS staff_role;
CREATE ROLE IF NOT EXISTS admin_role;

-- Cấp quyền cho các role
GRANT SELECT ON library_management.vw_book_details TO reader_role;
GRANT SELECT ON library_management.vw_currently_borrowed_books TO reader_role;
GRANT EXECUTE ON PROCEDURE library_management.SearchBooks TO reader_role;

GRANT SELECT, INSERT, UPDATE ON library_management.books TO staff_role;
GRANT SELECT, INSERT, UPDATE ON library_management.users TO staff_role;
GRANT SELECT, INSERT, UPDATE ON library_management.transactions TO staff_role;
GRANT SELECT, INSERT, UPDATE ON library_management.categories TO staff_role;
GRANT SELECT, INSERT, UPDATE ON library_management.authors TO staff_role;
GRANT SELECT, INSERT, UPDATE ON library_management.publishers TO staff_role;
GRANT SELECT, INSERT ON library_management.activity_logs TO staff_role;
GRANT EXECUTE ON PROCEDURE library_management.RegisterUser TO staff_role;
GRANT EXECUTE ON PROCEDURE library_management.AddNewBook TO staff_role;
GRANT EXECUTE ON PROCEDURE library_management.BorrowBook TO staff_role;
GRANT EXECUTE ON PROCEDURE library_management.ReturnBook TO staff_role;
GRANT EXECUTE ON PROCEDURE library_management.SearchBooks TO staff_role;
GRANT EXECUTE ON PROCEDURE library_management.PayFine TO staff_role;
GRANT SELECT ON library_management.vw_currently_borrowed_books TO staff_role;
GRANT SELECT ON library_management.vw_book_details TO staff_role;
GRANT SELECT ON library_management.vw_user_borrowing_statistics TO staff_role;
GRANT SELECT ON library_management.vw_most_popular_books TO staff_role;
GRANT SELECT ON library_management.vw_library_status_report TO staff_role;
GRANT SELECT ON library_management.vw_activity_by_time TO staff_role;

GRANT ALL PRIVILEGES ON library_management.* TO admin_role;

-- Tạo user
CREATE USER IF NOT EXISTS 'admin'@'localhost' IDENTIFIED BY 'admin_password';
CREATE USER IF NOT EXISTS 'staff'@'localhost' IDENTIFIED BY 'staff_password';
CREATE USER IF NOT EXISTS 'reader'@'localhost' IDENTIFIED BY 'reader_password';

-- Gán role
GRANT admin_role TO 'admin'@'localhost';
GRANT staff_role TO 'staff'@'localhost';
GRANT reader_role TO 'reader'@'localhost';

-- Set default role
ALTER USER 'admin'@'localhost' DEFAULT ROLE admin_role;
ALTER USER 'staff'@'localhost' DEFAULT ROLE staff_role;
ALTER USER 'reader'@'localhost' DEFAULT ROLE reader_role;
