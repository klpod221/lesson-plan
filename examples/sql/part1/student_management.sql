-- Tạo cơ sở dữ liệu student_management
CREATE DATABASE IF NOT EXISTS student_management;

-- Sử dụng cơ sở dữ liệu
USE student_management;

-- Tạo bảng students
DROP TABLE IF EXISTS students;
CREATE TABLE IF NOT EXISTS students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    math_score DECIMAL(4, 1) NOT NULL,
    physics_score DECIMAL(4, 1) NOT NULL,
    chemistry_score DECIMAL(4, 1) NOT NULL,
    average_score DECIMAL(4, 2),
    classification VARCHAR(20)
);

-- Thêm dữ liệu mẫu cho 5 sinh viên
INSERT INTO students (full_name, math_score, physics_score, chemistry_score)
VALUES
    ('Nguyễn Văn A', 8.5, 7.5, 9.0),
    ('Trần Thị B', 6.5, 7.0, 8.0),
    ('Lê Văn C', 5.0, 6.0, 7.0),
    ('Phạm Thị D', 9.0, 8.5, 8.0),
    ('Hoàng Văn E', 4.0, 5.0, 4.5);

-- Tính điểm trung bình cho mỗi sinh viên
UPDATE students
SET average_score = (math_score + physics_score + chemistry_score) / 3;

-- Cập nhật xếp loại học lực dựa trên điểm trung bình
UPDATE students
SET classification = 
    CASE 
        WHEN average_score >= 8.0 THEN 'Giỏi'
        WHEN average_score >= 6.5 THEN 'Khá'
        WHEN average_score >= 5.0 THEN 'Trung bình'
        ELSE 'Yếu'
    END;

-- Hiển thị danh sách sinh viên kèm điểm trung bình và xếp loại
SELECT 
    student_id,
    full_name,
    math_score,
    physics_score,
    chemistry_score,
    average_score,
    classification
FROM students
ORDER BY average_score DESC;
