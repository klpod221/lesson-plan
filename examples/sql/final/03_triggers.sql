USE library_management;

-- 1. Trigger: Cập nhật trạng thái sách quá hạn mỗi ngày
DELIMITER //
CREATE EVENT update_overdue_status
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    -- Cập nhật trạng thái các giao dịch đã quá hạn
    UPDATE transactions
    SET status = 'overdue'
    WHERE due_date < CURRENT_TIMESTAMP
      AND status = 'borrowed'
      AND return_date IS NULL;
    
    -- Ghi log hoạt động
    INSERT INTO activity_logs (action, entity, details)
    VALUES ('SYSTEM', 'transactions', 'Updated overdue transaction status');
END //
DELIMITER ;

-- 2. Trigger: Kiểm tra điều kiện mượn sách (số lượng còn, người dùng không bị khóa)
DELIMITER //
CREATE TRIGGER before_transaction_insert
BEFORE INSERT ON transactions
FOR EACH ROW
BEGIN
    DECLARE v_book_available INT;
    DECLARE v_user_status VARCHAR(20);
    
    -- Kiểm tra số lượng sách có sẵn
    SELECT available_copies INTO v_book_available
    FROM books WHERE book_id = NEW.book_id;
    
    -- Kiểm tra trạng thái người dùng
    SELECT status INTO v_user_status
    FROM users WHERE user_id = NEW.user_id;
    
    -- Nếu không còn sách hoặc người dùng bị khóa
    IF v_book_available <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Book is not available for borrowing';
    ELSEIF v_user_status != 'active' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User account is not active';
    END IF;
END //
DELIMITER ;

-- 3. Trigger: Ghi log các thao tác quan trọng trên bảng books
DELIMITER //
CREATE TRIGGER after_book_update
AFTER UPDATE ON books
FOR EACH ROW
BEGIN
    -- Ghi log khi thay đổi thông tin sách
    IF OLD.title != NEW.title OR
       OLD.publisher_id != NEW.publisher_id OR
       OLD.total_copies != NEW.total_copies THEN
        INSERT INTO activity_logs (action, entity, entity_id, details)
        VALUES ('UPDATE', 'books', NEW.book_id, 
                CONCAT('Book information updated. ID: ', NEW.book_id, ', Title: ', NEW.title));
    END IF;
END //
DELIMITER ;

-- 4. Trigger: Kiểm tra điều kiện khi thêm sách mới
DELIMITER //
CREATE TRIGGER before_book_insert
BEFORE INSERT ON books
FOR EACH ROW
BEGIN
    -- Kiểm tra các điều kiện hợp lệ
    IF NEW.total_copies < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Total copies cannot be negative';
    END IF;
    
    -- Đảm bảo available_copies không vượt quá total_copies
    IF NEW.available_copies > NEW.total_copies THEN
        SET NEW.available_copies = NEW.total_copies;
    END IF;
    
    -- Đảm bảo year hợp lệ
    IF NEW.publication_year > YEAR(CURRENT_TIMESTAMP) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Publication year cannot be in the future';
    END IF;
END //
DELIMITER ;

-- 5. Trigger: Tự động cập nhật trạng thái giao dịch khi trả sách
DELIMITER //
CREATE TRIGGER after_return_update
AFTER UPDATE ON transactions
FOR EACH ROW
BEGIN
    -- Nếu sách được trả (return_date từ NULL -> có giá trị)
    IF OLD.return_date IS NULL AND NEW.return_date IS NOT NULL THEN
        -- Cập nhật số lượng sách có sẵn
        UPDATE books
        SET available_copies = available_copies + 1
        WHERE book_id = NEW.book_id;
        
        -- Ghi log hoạt động
        INSERT INTO activity_logs (user_id, action, entity, entity_id, details)
        VALUES (NEW.staff_id, 'RETURN', 'transactions', NEW.transaction_id, 
                CONCAT('Book ID ', NEW.book_id, ' returned by User ID ', NEW.user_id));
    END IF;
END //
DELIMITER ;

-- 6. Trigger: Xử lý khi xóa người dùng
DELIMITER //
CREATE TRIGGER before_user_delete
BEFORE DELETE ON users
FOR EACH ROW
BEGIN
    DECLARE v_active_borrows INT DEFAULT 0;
    
    -- Kiểm tra có sách đang mượn không
    SELECT COUNT(*) INTO v_active_borrows
    FROM transactions
    WHERE user_id = OLD.user_id AND status IN ('borrowed', 'overdue');
    
    IF v_active_borrows > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot delete user with active borrows. Return all books first.';
    END IF;
    
    -- Ghi log hoạt động
    INSERT INTO activity_logs (action, entity, entity_id, details)
    VALUES ('DELETE', 'users', OLD.user_id, CONCAT('User deleted: ', OLD.username));
END //
DELIMITER ;
