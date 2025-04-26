-- Tạo cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS student_class_management;
USE student_class_management;

-- Xóa các bảng nếu đã tồn tại để tránh lỗi
DROP TABLE IF EXISTS student_subjects;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS subjects;
DROP TABLE IF EXISTS classes;

-- 1. TẠO BẢNG classes - lưu thông tin về các lớp học
CREATE TABLE classes (
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    class_name VARCHAR(50) NOT NULL,
    department VARCHAR(100),
    advisor VARCHAR(100),
    max_students INT DEFAULT 40,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. TẠO BẢNG subjects - lưu thông tin môn học
CREATE TABLE subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_code VARCHAR(10) NOT NULL UNIQUE,
    subject_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits > 0),
    description TEXT
);

-- 3. TẠO BẢNG students - lưu thông tin sinh viên với mối quan hệ đến lớp
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_code VARCHAR(10) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Nam', 'Nữ', 'Khác'),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address TEXT,
    class_id INT,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- 4. TẠO BẢNG student_subjects - bảng trung gian cho mối quan hệ nhiều-nhiều
-- giữa sinh viên và môn học, lưu điểm số
CREATE TABLE student_subjects (
    student_id INT,
    subject_id INT,
    semester VARCHAR(20) NOT NULL,
    score DECIMAL(4, 1) CHECK (score >= 0 AND score <= 10),
    PRIMARY KEY (student_id, subject_id, semester),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- THÊM CHỈ MỤC ĐỂ TỐI ƯU TRUY VẤN
CREATE INDEX idx_student_name ON students(full_name);
CREATE INDEX idx_student_code ON students(student_code);
CREATE INDEX idx_student_class ON students(class_id);
CREATE INDEX idx_student_subject_score ON student_subjects(score);

-- CHÈN DỮ LIỆU MẪU
-- Thêm dữ liệu vào bảng classes
INSERT INTO classes (class_name, department, advisor)
VALUES 
    ('CNTT01', 'Công nghệ thông tin', 'TS. Nguyễn Văn A'),
    ('CNTT02', 'Công nghệ thông tin', 'TS. Lê Thị B'),
    ('KTPM01', 'Kỹ thuật phần mềm', 'TS. Trần Văn C'),
    ('HTTT01', 'Hệ thống thông tin', 'TS. Phạm Thị D');

-- Thêm dữ liệu vào bảng subjects
INSERT INTO subjects (subject_code, subject_name, credits, description)
VALUES 
    ('COMP101', 'Nhập môn lập trình', 3, 'Giới thiệu về lập trình cơ bản'),
    ('COMP201', 'Cấu trúc dữ liệu và giải thuật', 4, 'Học về các cấu trúc dữ liệu và giải thuật cơ bản'),
    ('COMP301', 'Cơ sở dữ liệu', 4, 'Nguyên lý và thực hành về cơ sở dữ liệu'),
    ('COMP401', 'Lập trình web', 3, 'Phát triển các ứng dụng web'),
    ('COMP501', 'Trí tuệ nhân tạo', 4, 'Giới thiệu về trí tuệ nhân tạo và học máy');

-- Thêm dữ liệu vào bảng students
INSERT INTO students (student_code, full_name, date_of_birth, gender, email, class_id)
VALUES 
    ('SV001', 'Nguyễn Văn Nam', '2002-05-15', 'Nam', 'nam@example.com', 1),
    ('SV002', 'Trần Thị Hoa', '2001-09-20', 'Nữ', 'hoa@example.com', 1),
    ('SV003', 'Lê Minh Tuấn', '2002-03-10', 'Nam', 'tuan@example.com', 2),
    ('SV004', 'Phạm Thị Mai', '2001-11-25', 'Nữ', 'mai@example.com', 2),
    ('SV005', 'Hoàng Văn Đức', '2003-01-05', 'Nam', 'duc@example.com', 3),
    ('SV006', 'Đỗ Thị Lan', '2002-07-18', 'Nữ', 'lan@example.com', 3),
    ('SV007', 'Vũ Quang Huy', '2001-08-12', 'Nam', 'huy@example.com', 4),
    ('SV008', 'Ngô Thị Hương', '2003-04-22', 'Nữ', 'huong@example.com', 4),
    ('SV009', 'Bùi Văn Tùng', '2002-12-30', 'Nam', 'tung@example.com', 1),
    ('SV010', 'Lý Thị Hà', '2001-06-15', 'Nữ', 'ha@example.com', 2),
    ('SV011', 'Đặng Minh Quân', '2002-02-28', 'Nam', 'quan@example.com', 3),
    ('SV012', 'Trịnh Thu Trang', '2003-03-17', 'Nữ', 'trang@example.com', 4);

-- Thêm dữ liệu vào bảng student_subjects
INSERT INTO student_subjects (student_id, subject_id, semester, score)
VALUES
    (1, 1, '2022-1', 8.5),
    (1, 2, '2022-1', 7.5),
    (1, 3, '2022-2', 9.0),
    (1, 4, '2022-2', 8.0),
    
    (2, 1, '2022-1', 7.0),
    (2, 2, '2022-1', 6.5),
    (2, 3, '2022-2', 8.0),
    (2, 5, '2022-2', 7.5),
    
    (3, 1, '2022-1', 9.0),
    (3, 2, '2022-1', 8.5),
    (3, 4, '2022-2', 9.5),
    (3, 5, '2022-2', 9.0),
    
    (4, 1, '2022-1', 6.0),
    (4, 3, '2022-1', 6.5),
    (4, 4, '2022-2', 7.0),
    (4, 5, '2022-2', 6.5),
    
    (5, 2, '2022-1', 8.0),
    (5, 3, '2022-1', 8.5),
    (5, 4, '2022-2', 7.5),
    (5, 5, '2022-2', 8.0),
    
    (6, 1, '2022-1', 9.5),
    (6, 2, '2022-1', 9.0),
    (6, 3, '2022-2', 8.5),
    (6, 5, '2022-2', 9.0),
    
    (7, 1, '2022-1', 7.5),
    (7, 3, '2022-1', 8.0),
    (7, 4, '2022-2', 7.0),
    (7, 5, '2022-2', 7.5),
    
    (8, 2, '2022-1', 8.5),
    (8, 3, '2022-1', 9.0),
    (8, 4, '2022-2', 8.0),
    (8, 5, '2022-2', 8.5),
    
    (9, 1, '2022-1', 6.5),
    (9, 2, '2022-1', 7.0),
    (9, 4, '2022-2', 6.0),
    (9, 5, '2022-2', 6.5),
    
    (10, 1, '2022-1', 7.0),
    (10, 3, '2022-1', 7.5),
    (10, 4, '2022-2', 8.0),
    (10, 5, '2022-2', 7.0),
    
    (11, 1, '2022-1', 9.0),
    (11, 2, '2022-1', 8.5),
    (11, 3, '2022-2', 9.0),
    (11, 4, '2022-2', 8.0),
    
    (12, 2, '2022-1', 8.0),
    (12, 3, '2022-1', 8.5),
    (12, 4, '2022-2', 7.5),
    (12, 5, '2022-2', 8.0);

-- PHẦN TRẢ LỜI CÁC YÊU CẦU CỦA BÀI TẬP

-- 1. Tìm kiếm sinh viên theo tên hoặc mã
-- 1.1. Tìm kiếm sinh viên theo tên (tìm gần đúng)
SELECT student_id, student_code, full_name, gender, email, class_name
FROM students s
JOIN classes c ON s.class_id = c.class_id
WHERE full_name LIKE '%Văn%';

-- 1.2. Tìm kiếm sinh viên theo mã (tìm chính xác)
SELECT student_id, student_code, full_name, gender, email, class_name
FROM students s
JOIN classes c ON s.class_id = c.class_id
WHERE student_code = 'SV005';

-- 2. Liệt kê sinh viên theo lớp
SELECT c.class_id, c.class_name, s.student_code, s.full_name, s.gender
FROM classes c
LEFT JOIN students s ON c.class_id = s.class_id
ORDER BY c.class_name, s.full_name;

-- 3. Tính điểm trung bình của từng lớp
SELECT 
    c.class_id,
    c.class_name,
    COUNT(DISTINCT s.student_id) AS so_sinh_vien,
    ROUND(AVG(ss.score), 2) AS diem_trung_binh
FROM classes c
LEFT JOIN students s ON c.class_id = s.class_id
LEFT JOIN student_subjects ss ON s.student_id = ss.student_id
GROUP BY c.class_id, c.class_name
ORDER BY diem_trung_binh DESC;

-- 4. Sắp xếp sinh viên theo điểm trung bình (toàn bộ môn học)
WITH student_avg AS (
    SELECT 
        s.student_id,
        s.student_code,
        s.full_name,
        c.class_name,
        ROUND(AVG(ss.score), 2) AS avg_score
    FROM students s
    JOIN classes c ON s.class_id = c.class_id
    LEFT JOIN student_subjects ss ON s.student_id = ss.student_id
    GROUP BY s.student_id, s.student_code, s.full_name, c.class_name
)
SELECT * FROM student_avg
ORDER BY avg_score DESC;

-- 5. Tìm sinh viên có điểm cao nhất trong mỗi lớp
WITH student_avg AS (
    SELECT 
        s.student_id,
        s.student_code,
        s.full_name,
        s.class_id,
        c.class_name,
        ROUND(AVG(ss.score), 2) AS avg_score,
        RANK() OVER (PARTITION BY s.class_id ORDER BY AVG(ss.score) DESC) AS rank_in_class
    FROM students s
    JOIN classes c ON s.class_id = c.class_id
    LEFT JOIN student_subjects ss ON s.student_id = ss.student_id
    GROUP BY s.student_id, s.student_code, s.full_name, s.class_id, c.class_name
)
SELECT 
    class_id,
    class_name,
    student_code,
    full_name,
    avg_score
FROM student_avg
WHERE rank_in_class = 1;

-- 6. Truy vấn dữ liệu từ nhiều bảng bằng các loại JOIN

-- 6.1. INNER JOIN: Liệt kê sinh viên và điểm số của họ
SELECT 
    s.student_code,
    s.full_name,
    c.class_name,
    sub.subject_name,
    ss.score
FROM students s
JOIN classes c ON s.class_id = c.class_id
JOIN student_subjects ss ON s.student_id = ss.student_id
JOIN subjects sub ON ss.subject_id = sub.subject_id
ORDER BY s.full_name, sub.subject_name;

-- 6.2. LEFT JOIN: Liệt kê tất cả sinh viên và điểm số (nếu có)
SELECT 
    s.student_code,
    s.full_name,
    sub.subject_name,
    ss.score
FROM students s
LEFT JOIN student_subjects ss ON s.student_id = ss.student_id
LEFT JOIN subjects sub ON ss.subject_id = sub.subject_id
ORDER BY s.full_name, sub.subject_name;

-- 6.3. RIGHT JOIN: Liệt kê tất cả môn học và sinh viên đăng ký (nếu có)
SELECT 
    sub.subject_code,
    sub.subject_name,
    s.student_code,
    s.full_name,
    ss.score
FROM student_subjects ss
RIGHT JOIN subjects sub ON ss.subject_id = sub.subject_id
LEFT JOIN students s ON ss.student_id = s.student_id
ORDER BY sub.subject_name, s.full_name;

-- 6.4. FULL OUTER JOIN (mô phỏng bằng UNION của LEFT và RIGHT JOIN trong MySQL)
-- Liệt kê tất cả sinh viên và môn học, bất kể có điểm hay không
(SELECT 
    s.student_code,
    s.full_name,
    sub.subject_code,
    sub.subject_name,
    ss.score
FROM students s
LEFT JOIN student_subjects ss ON s.student_id = ss.student_id
LEFT JOIN subjects sub ON ss.subject_id = sub.subject_id)
UNION
(SELECT 
    s.student_code,
    s.full_name,
    sub.subject_code,
    sub.subject_name,
    ss.score
FROM subjects sub
LEFT JOIN student_subjects ss ON sub.subject_id = ss.subject_id
LEFT JOIN students s ON ss.student_id = s.student_id
WHERE s.student_id IS NULL)
ORDER BY full_name, subject_name;

-- 7. Thống kê số sinh viên theo từng môn học
SELECT 
    sub.subject_code,
    sub.subject_name,
    COUNT(DISTINCT ss.student_id) AS so_sinh_vien,
    ROUND(AVG(ss.score), 2) AS diem_trung_binh
FROM subjects sub
LEFT JOIN student_subjects ss ON sub.subject_id = ss.subject_id
GROUP BY sub.subject_id, sub.subject_code, sub.subject_name
ORDER BY so_sinh_vien DESC;

-- 8. Tìm môn học có điểm trung bình cao nhất
SELECT 
    sub.subject_code,
    sub.subject_name,
    ROUND(AVG(ss.score), 2) AS diem_trung_binh
FROM subjects sub
JOIN student_subjects ss ON sub.subject_id = ss.subject_id
GROUP BY sub.subject_id, sub.subject_code, sub.subject_name
ORDER BY diem_trung_binh DESC
LIMIT 1;

-- 9. Liệt kê sinh viên chưa có điểm môn nào
SELECT 
    s.student_code,
    s.full_name,
    c.class_name
FROM students s
JOIN classes c ON s.class_id = c.class_id
LEFT JOIN student_subjects ss ON s.student_id = ss.student_id
WHERE ss.student_id IS NULL;

-- 10. Tạo view thống kê điểm trung bình của sinh viên
CREATE OR REPLACE VIEW student_average_scores AS
SELECT 
    s.student_id,
    s.student_code,
    s.full_name,
    c.class_name,
    ROUND(AVG(ss.score), 2) AS average_score,
    CASE 
        WHEN AVG(ss.score) >= 9.0 THEN 'Xuất sắc'
        WHEN AVG(ss.score) >= 8.0 THEN 'Giỏi'
        WHEN AVG(ss.score) >= 6.5 THEN 'Khá'
        WHEN AVG(ss.score) >= 5.0 THEN 'Trung bình'
        ELSE 'Yếu'
    END AS ranking
FROM students s
JOIN classes c ON s.class_id = c.class_id
LEFT JOIN student_subjects ss ON s.student_id = ss.student_id
GROUP BY s.student_id, s.student_code, s.full_name, c.class_name;

-- Truy vấn view
SELECT * FROM student_average_scores ORDER BY average_score DESC;
