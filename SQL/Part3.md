# 📘 PHẦN 3: SQL NÂNG CAO VÀ ỨNG DỤNG

## Nội dung

- [📘 PHẦN 3: SQL NÂNG CAO VÀ ỨNG DỤNG](#-phần-3-sql-nâng-cao-và-ứng-dụng)
  - [Table of Contents](#table-of-contents)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Thủ tục lưu trữ nâng cao](#-bài-1-thủ-tục-lưu-trữ-nâng-cao)
    - [Stored Procedure có tham số](#stored-procedure-có-tham-số)
    - [Xử lý lỗi trong Stored Procedure](#xử-lý-lỗi-trong-stored-procedure)
    - [Sử dụng Cursor để xử lý dữ liệu theo dòng](#sử-dụng-cursor-để-xử-lý-dữ-liệu-theo-dòng)
    - [Thủ tục lưu trữ có trả về giá trị](#thủ-tục-lưu-trữ-có-trả-về-giá-trị)
  - [🧑‍🏫 Bài 2: Trigger và ràng buộc](#-bài-2-trigger-và-ràng-buộc)
    - [Trigger BEFORE INSERT](#trigger-before-insert)
    - [Trigger AFTER UPDATE](#trigger-after-update)
    - [Trigger BEFORE DELETE](#trigger-before-delete)
    - [Trigger để duy trì tính toàn vẹn dữ liệu](#trigger-để-duy-trì-tính-toàn-vẹn-dữ-liệu)
  - [🧑‍🏫 Bài 3: Giao dịch và xử lý đồng thời](#-bài-3-giao-dịch-và-xử-lý-đồng-thời)
    - [Quản lý transaction](#quản-lý-transaction)
    - [Các cấp độ cô lập (Isolation Levels)](#các-cấp-độ-cô-lập-isolation-levels)
    - [Xử lý lock và deadlock](#xử-lý-lock-và-deadlock)
  - [🧑‍🏫 Bài 4: Bảo mật dữ liệu](#-bài-4-bảo-mật-dữ-liệu)
    - [Quản lý người dùng và phân quyền](#quản-lý-người-dùng-và-phân-quyền)
    - [Mã hóa và bảo mật dữ liệu](#mã-hóa-và-bảo-mật-dữ-liệu)
    - [Phòng chống SQL Injection](#phòng-chống-sql-injection)
  - [🧑‍🏫 Bài 5: SQL và ứng dụng web](#-bài-5-sql-và-ứng-dụng-web)
    - [Kết nối cơ sở dữ liệu từ ứng dụng](#kết-nối-cơ-sở-dữ-liệu-từ-ứng-dụng)
    - [Tối ưu truy vấn cho ứng dụng web](#tối-ưu-truy-vấn-cho-ứng-dụng-web)
    - [Xử lý vấn đề N+1 và hiệu suất](#xử-lý-vấn-đề-n1-và-hiệu-suất)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN](#-bài-tập-lớn-cuối-phần)
    - [**Đề bài: Quản lý giao dịch mượn sách thư viện**](#đề-bài-quản-lý-giao-dịch-mượn-sách-thư-viện)

## 🎯 Mục tiêu tổng quát

- Xây dựng được các chức năng phức tạp với thủ tục lưu trữ
- Hiểu và triển khai được các quy tắc ràng buộc dữ liệu
- Bảo đảm tính toàn vẹn dữ liệu trong môi trường đa người dùng

---

## 🧑‍🏫 Bài 1: Thủ tục lưu trữ nâng cao

- Tạo và quản lý stored procedure có tham số
- Xử lý lỗi trong stored procedure
- Sử dụng cursor để xử lý dữ liệu theo dòng
- Thủ tục lưu trữ có trả về giá trị

### Stored Procedure có tham số

```sql
-- Tạo stored procedure để thêm sinh viên mới
DELIMITER //
CREATE PROCEDURE sp_AddStudent(
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_date_of_birth DATE,
    IN p_gender CHAR(1),
    OUT p_student_id INT
)
BEGIN
    INSERT INTO Students(first_name, last_name, email, date_of_birth, gender)
    VALUES(p_first_name, p_last_name, p_email, p_date_of_birth, p_gender);

    SET p_student_id = LAST_INSERT_ID();
END //
DELIMITER ;

-- Gọi stored procedure
CALL sp_AddStudent('Hoàng', 'Trần', 'hoang.tran@example.com', '2001-08-15', 'M', @new_id);
SELECT @new_id AS new_student_id;
```

### Xử lý lỗi trong Stored Procedure

```sql
DELIMITER //
CREATE PROCEDURE sp_EnrollStudent(
    IN p_student_id INT,
    IN p_course_id INT
)
BEGIN
    DECLARE exit_handler BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET exit_handler = TRUE;
        ROLLBACK;
        SELECT 'Lỗi xảy ra trong quá trình đăng ký khóa học' AS error_message;
    END;

    START TRANSACTION;

    -- Kiểm tra sinh viên có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM Students WHERE student_id = p_student_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Sinh viên không tồn tại';
    END IF;

    -- Kiểm tra khóa học có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM Courses WHERE course_id = p_course_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khóa học không tồn tại';
    END IF;

    -- Kiểm tra sinh viên đã đăng ký khóa học này chưa
    IF EXISTS (SELECT 1 FROM Enrollments WHERE student_id = p_student_id AND course_id = p_course_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Sinh viên đã đăng ký khóa học này';
    END IF;

    -- Thêm đăng ký mới
    INSERT INTO Enrollments(student_id, course_id, enrollment_date)
    VALUES(p_student_id, p_course_id, CURDATE());

    IF exit_handler = FALSE THEN
        COMMIT;
        SELECT 'Đăng ký khóa học thành công' AS success_message;
    END IF;
END //
DELIMITER ;
```

### Sử dụng Cursor để xử lý dữ liệu theo dòng

```sql
DELIMITER //
CREATE PROCEDURE sp_UpdateStudentRanks()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE s_id INT;
    DECLARE s_avg DECIMAL(4,2);

    -- Khai báo cursor
    DECLARE student_cursor CURSOR FOR
        SELECT student_id, (math_score + physics_score + chemistry_score)/3 AS avg_score
        FROM Students;

    -- Khai báo handler cho cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Mở cursor
    OPEN student_cursor;

    -- Bắt đầu vòng lặp
    student_loop: LOOP
        -- Đọc dữ liệu từng dòng
        FETCH student_cursor INTO s_id, s_avg;

        -- Kiểm tra đã hết dữ liệu chưa
        IF done THEN
            LEAVE student_loop;
        END IF;

        -- Cập nhật xếp loại dựa trên điểm trung bình
        UPDATE Students SET
            average_score = s_avg,
            rank = CASE
                WHEN s_avg >= 8.0 THEN 'Giỏi'
                WHEN s_avg >= 6.5 THEN 'Khá'
                WHEN s_avg >= 5.0 THEN 'Trung bình'
                ELSE 'Yếu'
            END
        WHERE student_id = s_id;
    END LOOP;

    -- Đóng cursor
    CLOSE student_cursor;
END //
DELIMITER ;
```

### Thủ tục lưu trữ có trả về giá trị

```sql
DELIMITER //
CREATE FUNCTION fn_CalculateGPA(
    p_student_id INT
) RETURNS DECIMAL(4,2)
DETERMINISTIC
BEGIN
    DECLARE avg_grade DECIMAL(4,2);

    SELECT AVG(grade) INTO avg_grade
    FROM Enrollments
    WHERE student_id = p_student_id;

    -- Nếu không có điểm (NULL), trả về 0
    IF avg_grade IS NULL THEN
        RETURN 0.0;
    ELSE
        RETURN avg_grade;
    END IF;
END //
DELIMITER ;

-- Sử dụng function
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS full_name,
    fn_CalculateGPA(s.student_id) AS gpa
FROM Students s;
```

---

## 🧑‍🏫 Bài 2: Trigger và ràng buộc

- Tạo trigger cho các sự kiện INSERT, UPDATE, DELETE
- Trigger BEFORE và AFTER
- Kiểm tra ràng buộc phức tạp
- Sử dụng trigger để duy trì tính toàn vẹn dữ liệu

### Trigger BEFORE INSERT

```sql
DELIMITER //
CREATE TRIGGER before_student_insert
BEFORE INSERT ON Students
FOR EACH ROW
BEGIN
    -- Chuyển email về chữ thường
    SET NEW.email = LOWER(NEW.email);

    -- Kiểm tra định dạng email
    IF NEW.email NOT LIKE '%@%.%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Định dạng email không hợp lệ';
    END IF;

    -- Kiểm tra tuổi (phải từ 16 tuổi trở lên)
    IF NEW.date_of_birth > DATE_SUB(CURDATE(), INTERVAL 16 YEAR) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Học sinh phải từ 16 tuổi trở lên';
    END IF;
END //
DELIMITER ;
```

### Trigger AFTER UPDATE

```sql
DELIMITER //
CREATE TRIGGER after_grade_update
AFTER UPDATE ON Enrollments
FOR EACH ROW
BEGIN
    -- Nếu điểm thay đổi, ghi log
    IF OLD.grade <> NEW.grade THEN
        INSERT INTO GradeChangeLog(
            student_id,
            course_id,
            old_grade,
            new_grade,
            changed_at,
            changed_by
        )
        VALUES(
            NEW.student_id,
            NEW.course_id,
            OLD.grade,
            NEW.grade,
            NOW(),
            CURRENT_USER()
        );
    END IF;
END //
DELIMITER ;
```

### Trigger BEFORE DELETE

```sql
DELIMITER //
CREATE TRIGGER before_course_delete
BEFORE DELETE ON Courses
FOR EACH ROW
BEGIN
    -- Không cho phép xóa khóa học đã có sinh viên đăng ký
    DECLARE student_count INT;

    SELECT COUNT(*) INTO student_count
    FROM Enrollments
    WHERE course_id = OLD.course_id;

    IF student_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không thể xóa khóa học đã có sinh viên đăng ký';
    END IF;
END //
DELIMITER ;
```

### Trigger để duy trì tính toàn vẹn dữ liệu

```sql
DELIMITER //
CREATE TRIGGER after_enrollment_insert
AFTER INSERT ON Enrollments
FOR EACH ROW
BEGIN
    -- Cập nhật số lượng sinh viên đăng ký vào bảng Courses
    UPDATE Courses
    SET enrolled_students = (
        SELECT COUNT(*)
        FROM Enrollments
        WHERE course_id = NEW.course_id
    )
    WHERE course_id = NEW.course_id;
END //
DELIMITER ;

-- Tương tự cho DELETE và UPDATE
CREATE TRIGGER after_enrollment_delete
AFTER DELETE ON Enrollments
FOR EACH ROW
BEGIN
    UPDATE Courses
    SET enrolled_students = (
        SELECT COUNT(*)
        FROM Enrollments
        WHERE course_id = OLD.course_id
    )
    WHERE course_id = OLD.course_id;
END //
DELIMITER ;
```

---

## 🧑‍🏫 Bài 3: Giao dịch và xử lý đồng thời

- Quản lý transaction với COMMIT và ROLLBACK
- Cách xử lý lock và deadlock
- Cấp độ cô lập (Isolation levels)
- Hiệu suất trong môi trường nhiều người dùng

### Quản lý transaction

```sql
-- Ví dụ về transaction khi chuyển điểm từ sinh viên này sang sinh viên khác
START TRANSACTION;

-- Trừ điểm từ sinh viên nguồn
UPDATE Students
SET bonus_points = bonus_points - 10
WHERE student_id = 101;

-- Kiểm tra lỗi (ví dụ: điểm âm)
IF (SELECT bonus_points FROM Students WHERE student_id = 101) < 0 THEN
    ROLLBACK;
    SELECT 'Không đủ điểm để chuyển' AS message;
ELSE
    -- Cộng điểm cho sinh viên đích
    UPDATE Students
    SET bonus_points = bonus_points + 10
    WHERE student_id = 102;

    COMMIT;
    SELECT 'Chuyển điểm thành công' AS message;
END IF;
```

### Các cấp độ cô lập (Isolation Levels)

```sql
-- READ UNCOMMITTED (mức thấp nhất, cho phép đọc dữ liệu chưa commit)
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- READ COMMITTED (chỉ đọc dữ liệu đã được commit)
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- REPEATABLE READ (mức mặc định trong MySQL, đảm bảo đọc lại cùng dữ liệu)
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- SERIALIZABLE (mức cao nhất, mọi giao dịch được thực hiện tuần tự)
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Ví dụ giao dịch với mức REPEATABLE READ
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;

-- Đọc dữ liệu
SELECT * FROM Students WHERE student_id = 1;

-- Thực hiện các thao tác khác...

-- Đọc lại dữ liệu, đảm bảo kết quả như lần đọc đầu
SELECT * FROM Students WHERE student_id = 1;

COMMIT;
```

### Xử lý lock và deadlock

```sql
-- Thiết lập timeout cho lock
SET innodb_lock_wait_timeout = 50; -- 50 giây

-- Ví dụ transaction với FOR UPDATE (tạo row-level lock)
START TRANSACTION;

-- Khóa hàng để đọc
SELECT * FROM Enrollments WHERE enrollment_id = 101 FOR UPDATE;

-- Thực hiện cập nhật
UPDATE Enrollments SET grade = 9.5 WHERE enrollment_id = 101;

COMMIT;

-- Xử lý deadlock với timeout
START TRANSACTION;

-- Thử khóa dữ liệu với timeout
SELECT * FROM Students WHERE student_id = 1 FOR UPDATE NOWAIT; -- Lỗi ngay nếu bị khóa
-- hoặc
SELECT * FROM Students WHERE student_id = 1 FOR UPDATE WAIT 10; -- Đợi tối đa 10 giây

-- Nếu xảy ra deadlock, MySQL sẽ tự động rollback một transaction
-- Ta có thể xử lý trong code của ứng dụng

COMMIT;
```

---

## 🧑‍🏫 Bài 4: Bảo mật dữ liệu

- Tạo và quản lý người dùng
- Phân quyền hệ thống và đối tượng
- Mã hóa và bảo mật dữ liệu
- Phòng chống SQL Injection

### Quản lý người dùng và phân quyền

```sql
-- Tạo người dùng với mật khẩu mã hóa
CREATE USER 'teacher_user'@'localhost' IDENTIFIED BY 'Strong_P@ssw0rd!';

-- Tạo vai trò (MySQL 8.0+)
CREATE ROLE 'app_read', 'app_write', 'app_admin';

-- Gán quyền cho vai trò
GRANT SELECT ON SchoolManagement.* TO 'app_read';
GRANT SELECT, INSERT, UPDATE ON SchoolManagement.* TO 'app_write';
GRANT ALL PRIVILEGES ON SchoolManagement.* TO 'app_admin';

-- Gán vai trò cho người dùng
GRANT 'app_write' TO 'teacher_user'@'localhost';

-- Thiết lập vai trò mặc định
SET DEFAULT ROLE 'app_write' TO 'teacher_user'@'localhost';

-- Gán quyền trực tiếp trên các bảng cụ thể
GRANT SELECT ON SchoolManagement.Students TO 'student_user'@'localhost';
GRANT SELECT, UPDATE (first_name, last_name, email) ON SchoolManagement.Students
TO 'student_user'@'localhost';

-- Thu hồi quyền
REVOKE UPDATE ON SchoolManagement.Students FROM 'student_user'@'localhost';
```

### Mã hóa và bảo mật dữ liệu

```sql
-- Mã hóa dữ liệu nhạy cảm
-- 1. Sử dụng hàm mã hóa tích hợp
UPDATE Users SET
    password_hash = SHA2(CONCAT(password, salt), 256)
WHERE user_id = 101;

-- 2. Sử dụng AES cho dữ liệu cần giải mã
SET @key = 'my_secure_key';

-- Mã hóa
UPDATE Students SET
    encrypted_ssn = AES_ENCRYPT(social_security_number, @key)
WHERE student_id = 1;

-- Giải mã
SELECT
    student_id,
    first_name,
    CONVERT(AES_DECRYPT(encrypted_ssn, @key) USING utf8) as ssn
FROM Students;
```

### Phòng chống SQL Injection

```sql
-- Cách không an toàn (KHÔNG NÊN DÙNG)
-- PHP code: $query = "SELECT * FROM Users WHERE username = '$username' AND password = '$password'";

-- Cách an toàn sử dụng Prepared Statements
-- PHP với PDO
/*
$stmt = $pdo->prepare("SELECT * FROM Users WHERE username = ? AND password_hash = ?");
$stmt->execute([$username, hash('sha256', $password . $salt)]);
*/

-- Hoặc sử dụng stored procedure
DELIMITER //
CREATE PROCEDURE sp_AuthenticateUser(
    IN p_username VARCHAR(100),
    IN p_password VARCHAR(100)
)
BEGIN
    DECLARE p_salt VARCHAR(32);

    -- Lấy salt của người dùng
    SELECT salt INTO p_salt FROM Users WHERE username = p_username;

    -- Kiểm tra xác thực
    SELECT user_id, username, email, role
    FROM Users
    WHERE username = p_username
    AND password_hash = SHA2(CONCAT(p_password, p_salt), 256);
END //
DELIMITER ;

-- Gọi procedure để xác thực
CALL sp_AuthenticateUser('user1', 'password123');
```

---

## 🧑‍🏫 Bài 5: SQL và ứng dụng web

- Kết nối cơ sở dữ liệu từ ứng dụng
- Tối ưu truy vấn cho ứng dụng web
- Mô hình ORM và SQL
- Xử lý vấn đề N+1 và hiệu suất

### Kết nối cơ sở dữ liệu từ ứng dụng

```java
// Kết nối từ Java với JDBC
import java.sql.*;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/SchoolManagement";
    private static final String USER = "app_user";
    private static final String PASSWORD = "secure_password";

    public static void main(String[] args) {
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            System.out.println("Kết nối thành công!");

            // Thực hiện truy vấn
            try (Statement stmt = conn.createStatement()) {
                ResultSet rs = stmt.executeQuery("SELECT * FROM Students");

                while (rs.next()) {
                    System.out.println(rs.getInt("student_id") + " - " +
                                     rs.getString("first_name") + " " +
                                     rs.getString("last_name"));
                }
            }

            // Sử dụng Prepared Statement (an toàn hơn)
            String query = "SELECT * FROM Students WHERE student_id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setInt(1, 1); // Gán giá trị cho tham số
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    System.out.println("Tìm thấy: " + rs.getString("first_name"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
```

```php
// Kết nối từ PHP với PDO
<?php
$host = 'localhost';
$db   = 'SchoolManagement';
$user = 'app_user';
$pass = 'secure_password';
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);

    // Truy vấn đơn giản
    $stmt = $pdo->query('SELECT student_id, first_name, last_name FROM Students');
    while ($row = $stmt->fetch()) {
        echo $row['student_id'] . ' - ' . $row['first_name'] . ' ' . $row['last_name'] . '<br>';
    }

    // Prepared statement
    $stmt = $pdo->prepare('SELECT * FROM Students WHERE student_id = ?');
    $stmt->execute([1]);
    $student = $stmt->fetch();

    if ($student) {
        echo "Tìm thấy: " . $student['first_name'];
    }

} catch (PDOException $e) {
    echo "Lỗi kết nối: " . $e->getMessage();
}
?>
```

### Tối ưu truy vấn cho ứng dụng web

```sql
-- 1. Sử dụng INDEX cho các cột thường xuyên tìm kiếm
CREATE INDEX idx_students_email ON Students(email);
CREATE INDEX idx_enrollments_student ON Enrollments(student_id);
CREATE INDEX idx_enrollments_course ON Enrollments(course_id);

-- 2. Chỉ lấy các cột cần thiết
SELECT student_id, first_name, last_name FROM Students WHERE gender = 'F';
-- thay vì
-- SELECT * FROM Students WHERE gender = 'F';

-- 3. Sử dụng LIMIT để phân trang
SELECT * FROM Students LIMIT 10 OFFSET 20; -- Trang 3, 10 item/trang

-- 4. Sử dụng JOIN hiệu quả
-- Thay vì nhiều truy vấn riêng lẻ
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_name,
    e.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE s.student_id = 101;

-- 5. Sử dụng EXPLAIN để phân tích truy vấn
EXPLAIN SELECT * FROM Students WHERE last_name LIKE 'Nguy%';
```

### Xử lý vấn đề N+1 và hiệu suất

```java
// Vấn đề N+1 (không nên dùng)
List<Student> students = getStudents(); // 1 truy vấn lấy danh sách sinh viên
for (Student student : students) {
    List<Course> courses = getCoursesForStudent(student.getId()); // N truy vấn
    // Xử lý...
}

// Giải pháp: sử dụng JOIN
// SQL: SELECT s.*, c.* FROM Students s JOIN Enrollments e ON ... JOIN Courses c ON ...
```

```sql
-- Truy vấn tối ưu để giải quyết vấn đề N+1
-- Lấy sinh viên và các khóa học đã đăng ký trong 1 truy vấn
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'course_id', c.course_id,
            'course_name', c.course_name,
            'grade', e.grade
        )
    ) AS enrolled_courses
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
LEFT JOIN Courses c ON e.course_id = c.course_id
GROUP BY s.student_id, s.first_name, s.last_name;
```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Quản lý giao dịch mượn sách thư viện**

Xây dựng cơ sở dữ liệu quản lý thư viện với các bảng:

- `Books`: thông tin sách
- `Users`: thông tin người dùng
- `Borrowings`: giao dịch mượn sách

Yêu cầu:

- Thiết kế cấu trúc dữ liệu đầy đủ với các ràng buộc
- Tạo các stored procedure để:
  - Thêm sách mới
  - Đăng ký người dùng
  - Xử lý giao dịch mượn sách (kiểm tra số lượng tồn, ghi nhận ngày mượn)
  - Xử lý trả sách (cập nhật trạng thái, tính phí phạt nếu trễ hạn)
- Tạo các triggers để:
  - Tự động cập nhật số lượng sách khi có giao dịch mượn/trả
  - Kiểm tra điều kiện trước khi cho mượn sách

---

[⬅️ Trở lại: SQL/Part2.md](../SQL/Part2.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: SQL/Part4.md](../SQL/Part4.md)
