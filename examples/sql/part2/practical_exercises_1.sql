-- Tạo bảng Students với 100,000 bản ghi mẫu và tối ưu hiệu suất truy vấn

-- 1. Tạo cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS sql_optimization;

USE sql_optimization;

-- 2. Tạo bảng Students với cấu trúc phù hợp
DROP TABLE IF EXISTS students;

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_code VARCHAR(10) NOT NULL UNIQUE,
    fullname VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    date_of_birth DATE,
    class_id INT,
    score DECIMAL(4, 2),
    city VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Tạo bảng Classes để làm quan hệ với Students
DROP TABLE IF EXISTS classes;

CREATE TABLE classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL,
    department VARCHAR(100)
);

-- 4. Thêm dữ liệu mẫu vào Classes
INSERT INTO
    classes (class_name, department)
VALUES ('CS101', 'Computer Science'),
    ('CS102', 'Computer Science'),
    ('MATH101', 'Mathematics'),
    ('PHYS101', 'Physics'),
    ('BIO101', 'Biology');

-- 5. Tạo procedure để sinh dữ liệu mẫu ngẫu nhiên
DROP PROCEDURE IF EXISTS generate_sample_data;

DELIMITER //
CREATE PROCEDURE generate_sample_data(IN num_records INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE class_count INT;
    DECLARE random_class INT;
    DECLARE random_score DECIMAL(4,2);
    DECLARE random_day INT;
    DECLARE random_month INT;
    DECLARE random_year INT;
    DECLARE birthdate DATE;
    DECLARE student_name VARCHAR(100);
    DECLARE first_names VARCHAR(300) DEFAULT 'Nguyễn,Trần,Lê,Phạm,Hoàng,Huỳnh,Phan,Vũ,Võ,Đặng,Bùi,Đỗ,Hồ,Ngô,Dương,Lý';
    DECLARE middle_names VARCHAR(300) DEFAULT 'Văn,Thị,Hữu,Đức,Công,Quang,Thành,Minh,Hoài,Thái,Mạnh,Thanh,Đình';
    DECLARE last_names VARCHAR(300) DEFAULT 'Nam,Hòa,Tuấn,Anh,Mai,Linh,Hương,Phương,Thảo,Hiếu,Đạt,Dũng,Huyền,Quỳnh,Trung,Tú,Hà,Lan,Hùng,Hải';
    DECLARE cities VARCHAR(300) DEFAULT 'Hà Nội,Hồ Chí Minh,Đà Nẵng,Hải Phòng,Cần Thơ,Huế,Nha Trang,Quy Nhơn,Đà Lạt,Vũng Tàu';
    
    -- Lấy số lượng lớp
    SELECT COUNT(*) INTO class_count FROM classes;
    
    -- Xóa dữ liệu cũ nếu có
    TRUNCATE TABLE students;
    
    -- Tạo dữ liệu mẫu
    WHILE i < num_records DO
        SET random_class = FLOOR(1 + RAND() * class_count);
        SET random_score = ROUND(4 + RAND() * 6, 1); -- Điểm từ 4.0 đến 10.0
        
        -- Tạo ngày sinh ngẫu nhiên từ 1990-2005
        SET random_year = 1990 + FLOOR(RAND() * 15);
        SET random_month = 1 + FLOOR(RAND() * 12);
        SET random_day = 1 + FLOOR(RAND() * 28);
        SET birthdate = STR_TO_DATE(CONCAT(random_year, '-', random_month, '-', random_day), '%Y-%m-%d');
        
        -- Tạo tên ngẫu nhiên
        SET student_name = CONCAT(
            SUBSTRING_INDEX(SUBSTRING_INDEX(first_names, ',', 1 + FLOOR(RAND() * 16)), ',', -1),
            ' ',
            SUBSTRING_INDEX(SUBSTRING_INDEX(middle_names, ',', 1 + FLOOR(RAND() * 13)), ',', -1),
            ' ',
            SUBSTRING_INDEX(SUBSTRING_INDEX(last_names, ',', 1 + FLOOR(RAND() * 20)), ',', -1)
        );
        
        -- Tạo mã sinh viên
        SET @student_code = CONCAT('SV', LPAD(i + 1, 6, '0'));
        
        -- Tạo email với số thứ tự để đảm bảo duy nhất
        SET @email = CONCAT(LOWER(REPLACE(student_name, ' ', '.')), '.', i + 1, '@student.edu.vn');
        
        -- Chọn thành phố ngẫu nhiên
        SET @city = SUBSTRING_INDEX(SUBSTRING_INDEX(cities, ',', 1 + FLOOR(RAND() * 10)), ',', -1);
        
        -- Chèn dữ liệu
        INSERT INTO students (student_code, fullname, email, date_of_birth, class_id, score, city)
        VALUES (@student_code, student_name, @email, birthdate, random_class, random_score, @city);
        
        SET i = i + 1;
    END WHILE;
END //

DELIMITER;

-- 6. Chạy procedure để tạo dữ liệu mẫu 100,000 bản ghi
-- Ghi chú: Thời gian chạy procedure này có thể lâu tùy thuộc vào cấu hình máy chủ và tốc độ I/O
-- bạn có thể điều chỉnh số lượng bản ghi để kiểm tra (ví dụ: 10,000 hoặc 50,000)
CALL generate_sample_data (100000);

-- 7. Phân tích và so sánh hiệu suất trước và sau khi tạo index

-- 7.1 Truy vấn có độ phức tạp cao mà không có index
-- Thực hiện và ghi thời gian
SELECT SQL_NO_CACHE *
FROM students
WHERE
    score > 8.5
    AND city = 'Hà Nội';

-- Sử dụng EXPLAIN để phân tích
EXPLAIN SELECT * FROM students WHERE score > 8.5 AND city = 'Hà Nội';

-- 7.2 Tạo index cho các cột được sử dụng trong điều kiện WHERE
CREATE INDEX idx_score ON students (score);

CREATE INDEX idx_city ON students (city);

CREATE INDEX idx_score_city ON students (score, city);

-- 7.3 Thực hiện lại truy vấn có index
SELECT SQL_NO_CACHE *
FROM students
WHERE
    score > 8.5
    AND city = 'Hà Nội';

-- Phân tích lại
EXPLAIN SELECT * FROM students WHERE score > 8.5 AND city = 'Hà Nội';

-- 8. Viết lại các truy vấn không hiệu quả

-- 8.1 Truy vấn ban đầu: Sử dụng hàm trên cột trong WHERE
-- Không hiệu quả:
EXPLAIN SELECT * FROM students WHERE YEAR(date_of_birth) = 2000;

-- Tối ưu:
EXPLAIN
SELECT *
FROM students
WHERE
    date_of_birth >= '2000-01-01'
    AND date_of_birth < '2001-01-01';

-- 8.2 Sử dụng IN với subquery lớn
-- Không hiệu quả:
EXPLAIN
SELECT *
FROM classes
WHERE
    class_id IN (
        SELECT class_id
        FROM students
        WHERE
            score > 8.0
    );

-- Tối ưu với EXISTS:
EXPLAIN
SELECT *
FROM classes c
WHERE
    EXISTS (
        SELECT 1
        FROM students s
        WHERE
            s.class_id = c.class_id
            AND s.score > 8.0
    );

-- 8.3 Sử dụng LIKE với wildcard ở đầu
-- Không hiệu quả:
EXPLAIN SELECT * FROM students WHERE fullname LIKE '%Anh%';

-- Tạo FULLTEXT INDEX và sử dụng:
ALTER TABLE students ADD FULLTEXT (fullname);

EXPLAIN
SELECT *
FROM students
WHERE
    MATCH(fullname) AGAINST (
        'Anh' IN NATURAL LANGUAGE MODE
    );

-- 8.4 Sử dụng JOIN không hiệu quả
-- Không hiệu quả (Cartesian product):
EXPLAIN
SELECT s.student_id, s.fullname, c.class_name
FROM students s, classes c
WHERE
    s.class_id = c.class_id
    AND s.score > 8.0;

-- Tối ưu với INNER JOIN:
EXPLAIN
SELECT s.student_id, s.fullname, c.class_name
FROM students s
    INNER JOIN classes c ON s.class_id = c.class_id
WHERE
    s.score > 8.0;

-- 8.5 Truy vấn với ORDER BY và không có LIMIT
-- Không hiệu quả:
EXPLAIN SELECT * FROM students ORDER BY score DESC;

-- Tối ưu:
EXPLAIN SELECT * FROM students ORDER BY score DESC LIMIT 100;
