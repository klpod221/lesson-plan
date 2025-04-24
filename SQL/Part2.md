# 📘 PHẦN 2: SQL NÂNG CAO

- [📘 PHẦN 2: SQL NÂNG CAO](#-phần-2-sql-nâng-cao)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Truy vấn nâng cao](#-bài-1-truy-vấn-nâng-cao)
    - [Truy vấn con (Subquery)](#truy-vấn-con-subquery)
      - [Ví dụ 1: Truy vấn con trong mệnh đề WHERE](#ví-dụ-1-truy-vấn-con-trong-mệnh-đề-where)
      - [Ví dụ 2: Truy vấn con trong mệnh đề FROM](#ví-dụ-2-truy-vấn-con-trong-mệnh-đề-from)
      - [Ví dụ 3: Truy vấn con tương quan](#ví-dụ-3-truy-vấn-con-tương-quan)
    - [Common Table Expressions (CTE) với WITH](#common-table-expressions-cte-với-with)
      - [Ví dụ 1: CTE cơ bản](#ví-dụ-1-cte-cơ-bản)
      - [Ví dụ 2: CTE đệ quy](#ví-dụ-2-cte-đệ-quy)
    - [Toán tử tập hợp: UNION, INTERSECT, EXCEPT](#toán-tử-tập-hợp-union-intersect-except)
      - [Ví dụ 1: UNION](#ví-dụ-1-union)
      - [Ví dụ 2: INTERSECT](#ví-dụ-2-intersect)
      - [Ví dụ 3: EXCEPT (MINUS)](#ví-dụ-3-except-minus)
    - [Window Functions](#window-functions)
      - [Ví dụ 1: ROW\_NUMBER()](#ví-dụ-1-row_number)
      - [Ví dụ 2: PARTITION BY](#ví-dụ-2-partition-by)
      - [Ví dụ 3: Hàm tổng hợp qua cửa sổ](#ví-dụ-3-hàm-tổng-hợp-qua-cửa-sổ)
      - [Ví dụ 4: NTILE() và các hàm khác](#ví-dụ-4-ntile-và-các-hàm-khác)
  - [🧑‍🏫 Bài 2: Hàm và thủ tục lưu trữ](#-bài-2-hàm-và-thủ-tục-lưu-trữ)
    - [Tạo và sử dụng hàm người dùng](#tạo-và-sử-dụng-hàm-người-dùng)
      - [Ví dụ 1: Hàm tính tuổi từ ngày sinh](#ví-dụ-1-hàm-tính-tuổi-từ-ngày-sinh)
      - [Ví dụ 2: Hàm tính điểm trung bình](#ví-dụ-2-hàm-tính-điểm-trung-bình)
      - [Ví dụ 3: Hàm xếp loại học lực](#ví-dụ-3-hàm-xếp-loại-học-lực)
    - [Thủ tục lưu trữ (Stored Procedures)](#thủ-tục-lưu-trữ-stored-procedures)
      - [Ví dụ 1: Thủ tục cơ bản để lấy thông tin sinh viên](#ví-dụ-1-thủ-tục-cơ-bản-để-lấy-thông-tin-sinh-viên)
      - [Ví dụ 2: Thủ tục với tham số đầu ra](#ví-dụ-2-thủ-tục-với-tham-số-đầu-ra)
      - [Ví dụ 3: Thủ tục cập nhật dữ liệu](#ví-dụ-3-thủ-tục-cập-nhật-dữ-liệu)
    - [Triggers và sự kiện](#triggers-và-sự-kiện)
      - [Ví dụ 1: Trigger kiểm tra điểm trước khi chèn](#ví-dụ-1-trigger-kiểm-tra-điểm-trước-khi-chèn)
      - [Ví dụ 2: Trigger cập nhật lịch sử thay đổi](#ví-dụ-2-trigger-cập-nhật-lịch-sử-thay-đổi)
      - [Ví dụ 3: Event định kỳ tính toán thống kê](#ví-dụ-3-event-định-kỳ-tính-toán-thống-kê)
    - [Giao dịch và xử lý lỗi](#giao-dịch-và-xử-lý-lỗi)
      - [Ví dụ 1: Giao dịch cơ bản](#ví-dụ-1-giao-dịch-cơ-bản)
      - [Ví dụ 2: Xử lý lỗi với DECLARE...HANDLER](#ví-dụ-2-xử-lý-lỗi-với-declarehandler)
      - [Ví dụ 3: Kiểm soát lỗi với SIGNAL](#ví-dụ-3-kiểm-soát-lỗi-với-signal)
  - [🧑‍🏫 Bài 3: Tối ưu hóa truy vấn](#-bài-3-tối-ưu-hóa-truy-vấn)
    - [Chỉ mục (Indexes) và cách hoạt động](#chỉ-mục-indexes-và-cách-hoạt-động)
      - [Ví dụ 1: Tạo chỉ mục cơ bản](#ví-dụ-1-tạo-chỉ-mục-cơ-bản)
      - [Ví dụ 2: Chỉ mục đa cột (Composite Index)](#ví-dụ-2-chỉ-mục-đa-cột-composite-index)
      - [Ví dụ 3: Loại bỏ chỉ mục](#ví-dụ-3-loại-bỏ-chỉ-mục)
      - [Ví dụ 4: Chỉ mục đầy đủ văn bản (Fulltext Index)](#ví-dụ-4-chỉ-mục-đầy-đủ-văn-bản-fulltext-index)
    - [Phân tích kế hoạch thực thi truy vấn](#phân-tích-kế-hoạch-thực-thi-truy-vấn)
      - [Ví dụ 1: Sử dụng EXPLAIN](#ví-dụ-1-sử-dụng-explain)
      - [Ví dụ 2: EXPLAIN với chỉ mục](#ví-dụ-2-explain-với-chỉ-mục)
      - [Ví dụ 3: Phân tích JOIN](#ví-dụ-3-phân-tích-join)
    - [Kỹ thuật tối ưu câu lệnh SQL](#kỹ-thuật-tối-ưu-câu-lệnh-sql)
      - [Ví dụ 1: Chỉ chọn những cột cần thiết](#ví-dụ-1-chỉ-chọn-những-cột-cần-thiết)
      - [Ví dụ 2: Sử dụng điều kiện lọc hiệu quả](#ví-dụ-2-sử-dụng-điều-kiện-lọc-hiệu-quả)
      - [Ví dụ 3: Tránh sử dụng hàm trên cột trong điều kiện WHERE](#ví-dụ-3-tránh-sử-dụng-hàm-trên-cột-trong-điều-kiện-where)
      - [Ví dụ 4: Sử dụng LIMIT để giới hạn kết quả](#ví-dụ-4-sử-dụng-limit-để-giới-hạn-kết-quả)
      - [Ví dụ 5: Sử dụng EXISTS thay vì IN cho subquery](#ví-dụ-5-sử-dụng-exists-thay-vì-in-cho-subquery)
    - [Theo dõi và đánh giá hiệu suất](#theo-dõi-và-đánh-giá-hiệu-suất)
      - [Ví dụ 1: Theo dõi truy vấn chậm](#ví-dụ-1-theo-dõi-truy-vấn-chậm)
      - [Ví dụ 2: Xem trạng thái của hệ thống](#ví-dụ-2-xem-trạng-thái-của-hệ-thống)
      - [Ví dụ 3: Phân tích câu lệnh bằng ANALYZE](#ví-dụ-3-phân-tích-câu-lệnh-bằng-analyze)
      - [Ví dụ 4: Tối ưu hóa câu lệnh SQL](#ví-dụ-4-tối-ưu-hóa-câu-lệnh-sql)
    - [Bài tập thực hành](#bài-tập-thực-hành)
  - [🧑‍🏫 Bài 4: Thiết kế cơ sở dữ liệu](#-bài-4-thiết-kế-cơ-sở-dữ-liệu)
    - [Chuẩn hóa và phi chuẩn hóa](#chuẩn-hóa-và-phi-chuẩn-hóa)
      - [Ví dụ 1: Dữ liệu chưa chuẩn hóa](#ví-dụ-1-dữ-liệu-chưa-chuẩn-hóa)
      - [Ví dụ 2: Chuẩn hóa dạng 1NF](#ví-dụ-2-chuẩn-hóa-dạng-1nf)
      - [Ví dụ 3: Chuẩn hóa dạng 2NF](#ví-dụ-3-chuẩn-hóa-dạng-2nf)
      - [Ví dụ 4: Chuẩn hóa dạng 3NF](#ví-dụ-4-chuẩn-hóa-dạng-3nf)
      - [Ví dụ 5: Phi chuẩn hóa có chủ đích](#ví-dụ-5-phi-chuẩn-hóa-có-chủ-đích)
    - [Mô hình dữ liệu: khái niệm và ứng dụng](#mô-hình-dữ-liệu-khái-niệm-và-ứng-dụng)
      - [Ví dụ 1: Mô hình Entity-Relationship (ER)](#ví-dụ-1-mô-hình-entity-relationship-er)
      - [Ví dụ 2: Mối quan hệ một-nhiều (One-to-Many)](#ví-dụ-2-mối-quan-hệ-một-nhiều-one-to-many)
      - [Ví dụ 3: Mối quan hệ nhiều-nhiều (Many-to-Many)](#ví-dụ-3-mối-quan-hệ-nhiều-nhiều-many-to-many)
      - [Ví dụ 4: Mối quan hệ một-một (One-to-One)](#ví-dụ-4-mối-quan-hệ-một-một-one-to-one)
    - [Ràng buộc toàn vẹn và quan hệ](#ràng-buộc-toàn-vẹn-và-quan-hệ)
      - [Ví dụ 1: Ràng buộc khóa chính (PRIMARY KEY)](#ví-dụ-1-ràng-buộc-khóa-chính-primary-key)
      - [Ví dụ 2: Ràng buộc khóa ngoại (FOREIGN KEY)](#ví-dụ-2-ràng-buộc-khóa-ngoại-foreign-key)
      - [Ví dụ 3: Ràng buộc CHECK](#ví-dụ-3-ràng-buộc-check)
      - [Ví dụ 4: Ràng buộc DEFAULT](#ví-dụ-4-ràng-buộc-default)
      - [Ví dụ 5: Ràng buộc NOT NULL](#ví-dụ-5-ràng-buộc-not-null)
    - [Thiết kế hướng hiệu suất](#thiết-kế-hướng-hiệu-suất)
      - [Ví dụ 1: Chọn kiểu dữ liệu phù hợp](#ví-dụ-1-chọn-kiểu-dữ-liệu-phù-hợp)
      - [Ví dụ 2: Phân vùng bảng (Table Partitioning)](#ví-dụ-2-phân-vùng-bảng-table-partitioning)
      - [Ví dụ 3: Đánh chỉ mục hiệu quả](#ví-dụ-3-đánh-chỉ-mục-hiệu-quả)
      - [Ví dụ 4: Sử dụng các bảng tổng hợp (Materialized Views)](#ví-dụ-4-sử-dụng-các-bảng-tổng-hợp-materialized-views)
      - [Ví dụ 5: Thiết kế schema hợp lý](#ví-dụ-5-thiết-kế-schema-hợp-lý)
    - [Bài tập thực hành: Thiết kế cơ sở dữ liệu](#bài-tập-thực-hành-thiết-kế-cơ-sở-dữ-liệu)
  - [🧑‍🏫 Bài 5: Bảo mật và quản trị](#-bài-5-bảo-mật-và-quản-trị)
    - [Giám sát và điều chỉnh hệ thống](#giám-sát-và-điều-chỉnh-hệ-thống)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN: Quản lý sinh viên và lớp học](#-bài-tập-lớn-cuối-phần-quản-lý-sinh-viên-và-lớp-học)
    - [Mô tả bài toán](#mô-tả-bài-toán)
    - [Yêu cầu](#yêu-cầu)

## 🎯 Mục tiêu tổng quát

- Hiểu và sử dụng được các kỹ thuật truy vấn phức tạp
- Tối ưu hiệu suất truy vấn và thiết kế cơ sở dữ liệu
- Biết cách xử lý dữ liệu lớn và đảm bảo an toàn

---

## 🧑‍🏫 Bài 1: Truy vấn nâng cao

- Truy vấn con (Subquery)
- Common Table Expressions (CTE) với `WITH`
- Toán tử tập hợp: `UNION`, `INTERSECT`, `EXCEPT`
- Window Functions: `OVER`, `PARTITION BY`, `ROW_NUMBER`

### Truy vấn con (Subquery)

Truy vấn con là một câu truy vấn SQL lồng trong một câu truy vấn khác, có thể xuất hiện trong mệnh đề WHERE, FROM, hoặc SELECT.

#### Ví dụ 1: Truy vấn con trong mệnh đề WHERE

```sql
-- Tìm học sinh có điểm cao hơn điểm trung bình của tất cả học sinh
SELECT student_id, fullname, score
FROM students
WHERE score > (SELECT AVG(score) FROM students);
```

#### Ví dụ 2: Truy vấn con trong mệnh đề FROM

```sql
-- Lấy thông tin từ kết quả của một truy vấn khác
SELECT dept_name, avg_salary
FROM (
    SELECT department_id, AVG(salary) as avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_salaries
JOIN departments d ON dept_salaries.department_id = d.id;
```

#### Ví dụ 3: Truy vấn con tương quan

```sql
-- Tìm học sinh có điểm cao nhất trong mỗi lớp
SELECT s.student_id, s.fullname, s.class_id, s.score
FROM students s
WHERE s.score = (
    SELECT MAX(score)
    FROM students s2
    WHERE s2.class_id = s.class_id
);
```

### Common Table Expressions (CTE) với WITH

CTE tạo ra một bảng tạm thời có thể được tham chiếu nhiều lần trong một truy vấn, giúp code SQL dễ đọc và bảo trì hơn.

#### Ví dụ 1: CTE cơ bản

```sql
-- Tìm học sinh có điểm cao hơn điểm trung bình của lớp mình
WITH class_avg_scores AS (
    SELECT class_id, AVG(score) AS avg_score
    FROM students
    GROUP BY class_id
)
SELECT s.student_id, s.fullname, s.score, c.avg_score
FROM students s
JOIN class_avg_scores c ON s.class_id = c.class_id
WHERE s.score > c.avg_score;
```

#### Ví dụ 2: CTE đệ quy

```sql
-- Hiển thị cấu trúc phân cấp của nhân viên (quản lý - nhân viên)
WITH RECURSIVE employee_hierarchy AS (
    -- Trường hợp cơ sở: các nhân viên cấp cao nhất (không có quản lý)
    SELECT id, fullname, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Trường hợp đệ quy: tìm nhân viên cấp dưới
    SELECT e.id, e.fullname, e.manager_id, eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.id
)
SELECT id, fullname, level
FROM employee_hierarchy
ORDER BY level, id;
```

### Toán tử tập hợp: UNION, INTERSECT, EXCEPT

Các toán tử tập hợp kết hợp kết quả từ nhiều truy vấn SELECT.

#### Ví dụ 1: UNION

```sql
-- Kết hợp danh sách học sinh và giáo viên
SELECT 'Student' AS role, fullname, email
FROM students
UNION
SELECT 'Teacher' AS role, fullname, email
FROM teachers
ORDER BY role, fullname;
```

#### Ví dụ 2: INTERSECT

```sql
-- Tìm học sinh vừa học môn Toán vừa học môn Văn
-- (MySQL không hỗ trợ INTERSECT trực tiếp, phải dùng JOIN hoặc IN)
-- Cách viết với INTERSECT (PostgreSQL, SQL Server,...)
SELECT student_id
FROM course_registrations
WHERE course_id = 1  -- Toán
INTERSECT
SELECT student_id
FROM course_registrations
WHERE course_id = 2;  -- Văn

-- Cách viết với MySQL
SELECT cr1.student_id
FROM course_registrations cr1
JOIN course_registrations cr2 ON cr1.student_id = cr2.student_id
WHERE cr1.course_id = 1 AND cr2.course_id = 2;
```

#### Ví dụ 3: EXCEPT (MINUS)

```sql
-- Tìm học sinh học môn Toán nhưng không học môn Văn
-- (MySQL không hỗ trợ EXCEPT trực tiếp, phải dùng LEFT JOIN hoặc NOT IN)
-- Cách viết với EXCEPT (PostgreSQL, SQL Server,...)
SELECT student_id
FROM course_registrations
WHERE course_id = 1  -- Toán
EXCEPT
SELECT student_id
FROM course_registrations
WHERE course_id = 2;  -- Văn

-- Cách viết với MySQL
SELECT DISTINCT cr1.student_id
FROM course_registrations cr1
LEFT JOIN course_registrations cr2 ON cr1.student_id = cr2.student_id AND cr2.course_id = 2
WHERE cr1.course_id = 1 AND cr2.student_id IS NULL;
```

### Window Functions

Window functions thực hiện tính toán trên một tập hợp các hàng liên quan đến hàng hiện tại, nhưng không gộp các hàng thành một kết quả duy nhất.

#### Ví dụ 1: ROW_NUMBER()

```sql
-- Đánh số thứ tự cho học sinh theo điểm số từ cao đến thấp
SELECT
    student_id,
    fullname,
    score,
    ROW_NUMBER() OVER (ORDER BY score DESC) AS rank
FROM students;
```

#### Ví dụ 2: PARTITION BY

```sql
-- Đánh số thứ tự học sinh theo điểm số trong từng lớp riêng biệt
SELECT
    student_id,
    fullname,
    class_id,
    score,
    ROW_NUMBER() OVER (PARTITION BY class_id ORDER BY score DESC) AS class_rank
FROM students;
```

#### Ví dụ 3: Hàm tổng hợp qua cửa sổ

```sql
-- Tính điểm trung bình của lớp và chênh lệch của mỗi học sinh so với trung bình lớp
SELECT
    student_id,
    fullname,
    class_id,
    score,
    AVG(score) OVER (PARTITION BY class_id) AS class_avg,
    score - AVG(score) OVER (PARTITION BY class_id) AS difference_from_avg
FROM students;
```

#### Ví dụ 4: NTILE() và các hàm khác

```sql
-- Chia học sinh thành 4 nhóm (tứ phân vị) theo điểm số
SELECT
    student_id,
    fullname,
    score,
    NTILE(4) OVER (ORDER BY score) AS quartile,
    LEAD(score, 1) OVER (ORDER BY score) AS next_higher_score,
    LAG(score, 1) OVER (ORDER BY score) AS next_lower_score
FROM students;
```

---

## 🧑‍🏫 Bài 2: Hàm và thủ tục lưu trữ

- Tạo và sử dụng hàm người dùng
- Thủ tục lưu trữ (Stored Procedures)
- Triggers và sự kiện
- Giao dịch và xử lý lỗi

### Tạo và sử dụng hàm người dùng

Hàm người dùng (User-Defined Functions) là các đoạn code SQL được lưu trữ và có thể tái sử dụng, trả về một giá trị duy nhất.

#### Ví dụ 1: Hàm tính tuổi từ ngày sinh

```sql
DELIMITER //
CREATE FUNCTION calculate_age(birthdate DATE)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE age INT;
    SET age = YEAR(CURRENT_DATE()) - YEAR(birthdate) -
              (DATE_FORMAT(CURRENT_DATE(), '%m%d') < DATE_FORMAT(birthdate, '%m%d'));
    RETURN age;
END //
DELIMITER ;

-- Sử dụng hàm
SELECT
    student_id,
    fullname,
    date_of_birth,
    calculate_age(date_of_birth) AS age
FROM students;
```

#### Ví dụ 2: Hàm tính điểm trung bình

```sql
DELIMITER //
CREATE FUNCTION calculate_gpa(student_id INT)
RETURNS DECIMAL(4,2) READS SQL DATA
BEGIN
    DECLARE avg_score DECIMAL(4,2);

    SELECT AVG(score) INTO avg_score
    FROM student_scores
    WHERE student_id = student_id;

    RETURN IFNULL(avg_score, 0);
END //
DELIMITER ;

-- Sử dụng hàm
SELECT
    s.student_id,
    s.fullname,
    calculate_gpa(s.student_id) AS gpa
FROM students s;
```

#### Ví dụ 3: Hàm xếp loại học lực

```sql
DELIMITER //
CREATE FUNCTION get_grade_ranking(score DECIMAL(4,2))
RETURNS VARCHAR(20) DETERMINISTIC
BEGIN
    DECLARE ranking VARCHAR(20);

    IF score >= 9.0 THEN
        SET ranking = 'Xuất sắc';
    ELSEIF score >= 8.0 THEN
        SET ranking = 'Giỏi';
    ELSEIF score >= 7.0 THEN
        SET ranking = 'Khá';
    ELSEIF score >= 5.0 THEN
        SET ranking = 'Trung bình';
    ELSE
        SET ranking = 'Yếu';
    END IF;

    RETURN ranking;
END //
DELIMITER ;

-- Sử dụng hàm
SELECT
    student_id,
    fullname,
    score,
    get_grade_ranking(score) AS ranking
FROM student_scores;
```

### Thủ tục lưu trữ (Stored Procedures)

Thủ tục lưu trữ là tập hợp các câu lệnh SQL được đặt tên và lưu trữ trong cơ sở dữ liệu. Khác với hàm, thủ tục có thể không trả về giá trị và có thể có nhiều tham số đầu vào/đầu ra.

#### Ví dụ 1: Thủ tục cơ bản để lấy thông tin sinh viên

```sql
DELIMITER //
CREATE PROCEDURE get_student_info(IN student_id INT)
BEGIN
    SELECT *
    FROM students
    WHERE student_id = student_id;
END //
DELIMITER ;

-- Gọi thủ tục
CALL get_student_info(101);
```

#### Ví dụ 2: Thủ tục với tham số đầu ra

```sql
DELIMITER //
CREATE PROCEDURE get_class_statistics(
    IN class_id INT,
    OUT total_students INT,
    OUT avg_score DECIMAL(4,2)
)
BEGIN
    -- Tính tổng số sinh viên
    SELECT COUNT(*) INTO total_students
    FROM students
    WHERE class_id = class_id;

    -- Tính điểm trung bình
    SELECT AVG(score) INTO avg_score
    FROM students
    WHERE class_id = class_id;
END //
DELIMITER ;

-- Gọi thủ tục với tham số đầu ra
CALL get_class_statistics(1, @total, @avg);
SELECT @total AS 'Tổng sinh viên', @avg AS 'Điểm trung bình';
```

#### Ví dụ 3: Thủ tục cập nhật dữ liệu

```sql
DELIMITER //
CREATE PROCEDURE update_student_score(
    IN student_id INT,
    IN subject_id INT,
    IN new_score DECIMAL(4,2),
    OUT result VARCHAR(100)
)
BEGIN
    DECLARE current_score DECIMAL(4,2);
    DECLARE score_exists INT;

    -- Kiểm tra xem điểm đã tồn tại chưa
    SELECT COUNT(*), IFNULL(score, 0)
    INTO score_exists, current_score
    FROM student_scores
    WHERE student_id = student_id AND subject_id = subject_id;

    -- Cập nhật hoặc thêm mới điểm
    IF score_exists > 0 THEN
        UPDATE student_scores
        SET score = new_score
        WHERE student_id = student_id AND subject_id = subject_id;

        SET result = CONCAT('Cập nhật điểm từ ', current_score, ' thành ', new_score);
    ELSE
        INSERT INTO student_scores (student_id, subject_id, score)
        VALUES (student_id, subject_id, new_score);

        SET result = CONCAT('Thêm mới điểm: ', new_score);
    END IF;
END //
DELIMITER ;

-- Gọi thủ tục cập nhật
CALL update_student_score(101, 1, 8.5, @result);
SELECT @result;
```

### Triggers và sự kiện

Trigger là đoạn mã SQL tự động thực thi khi một sự kiện cụ thể xảy ra (như INSERT, UPDATE, DELETE). Sự kiện (Event) là các tác vụ SQL được lên lịch để chạy tại một thời điểm cụ thể.

#### Ví dụ 1: Trigger kiểm tra điểm trước khi chèn

```sql
DELIMITER //
CREATE TRIGGER before_score_insert
BEFORE INSERT ON student_scores
FOR EACH ROW
BEGIN
    -- Đảm bảo điểm nằm trong khoảng hợp lệ
    IF NEW.score < 0 THEN
        SET NEW.score = 0;
    ELSEIF NEW.score > 10 THEN
        SET NEW.score = 10;
    END IF;
END //
DELIMITER ;
```

#### Ví dụ 2: Trigger cập nhật lịch sử thay đổi

```sql
-- Tạo bảng lưu lịch sử
CREATE TABLE student_score_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    old_score DECIMAL(4,2),
    new_score DECIMAL(4,2),
    changed_by VARCHAR(50),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER after_score_update
AFTER UPDATE ON student_scores
FOR EACH ROW
BEGIN
    INSERT INTO student_score_history
       (student_id, subject_id, old_score, new_score, changed_by)
    VALUES
       (NEW.student_id, NEW.subject_id, OLD.score, NEW.score, CURRENT_USER());
END //
DELIMITER ;
```

#### Ví dụ 3: Event định kỳ tính toán thống kê

```sql
-- Tạo bảng lưu thống kê
CREATE TABLE class_statistics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT,
    total_students INT,
    avg_score DECIMAL(4,2),
    calculated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE EVENT calculate_class_statistics
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    INSERT INTO class_statistics (class_id, total_students, avg_score)
    SELECT
        class_id,
        COUNT(*) as total_students,
        AVG(score) as avg_score
    FROM students s
    JOIN student_scores ss ON s.student_id = ss.student_id
    GROUP BY class_id;
END //
DELIMITER ;
```

### Giao dịch và xử lý lỗi

Giao dịch (Transaction) đảm bảo tính toàn vẹn của dữ liệu khi thực hiện nhiều thao tác. Xử lý lỗi giúp ứng dụng phản ứng khi có lỗi xảy ra.

#### Ví dụ 1: Giao dịch cơ bản

```sql
-- Chuyển điểm từ sinh viên này sang sinh viên khác
START TRANSACTION;

-- Trừ điểm từ sinh viên nguồn
UPDATE student_scores
SET score = score - 2
WHERE student_id = 101 AND subject_id = 1;

-- Thêm điểm cho sinh viên đích
UPDATE student_scores
SET score = score + 2
WHERE student_id = 102 AND subject_id = 1;

-- Kiểm tra nếu có điểm âm thì không thực hiện
IF EXISTS (SELECT 1 FROM student_scores WHERE score < 0) THEN
    ROLLBACK;
    SELECT 'Giao dịch bị hủy vì điểm trở thành âm';
ELSE
    COMMIT;
    SELECT 'Giao dịch đã được thực hiện thành công';
END IF;
```

#### Ví dụ 2: Xử lý lỗi với DECLARE...HANDLER

```sql
DELIMITER //
CREATE PROCEDURE transfer_score(
    IN source_student_id INT,
    IN target_student_id INT,
    IN subject_id INT,
    IN points DECIMAL(4,2),
    OUT message VARCHAR(100)
)
BEGIN
    -- Khai báo biến
    DECLARE source_score DECIMAL(4,2);
    DECLARE exit_handler BOOLEAN DEFAULT FALSE;

    -- Khai báo handler cho lỗi
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET exit_handler = TRUE;
        SET message = 'Lỗi SQL xảy ra trong quá trình chuyển điểm';
        ROLLBACK;
    END;

    -- Bắt đầu giao dịch
    START TRANSACTION;

    -- Lấy điểm hiện tại của sinh viên nguồn
    SELECT score INTO source_score
    FROM student_scores
    WHERE student_id = source_student_id AND subject_id = subject_id;

    -- Kiểm tra xem có đủ điểm để chuyển không
    IF source_score IS NULL OR source_score < points THEN
        SET message = 'Không đủ điểm để chuyển';
        ROLLBACK;
    ELSE
        -- Trừ điểm từ sinh viên nguồn
        UPDATE student_scores
        SET score = score - points
        WHERE student_id = source_student_id AND subject_id = subject_id;

        -- Thêm điểm cho sinh viên đích
        IF EXISTS (SELECT 1 FROM student_scores WHERE student_id = target_student_id AND subject_id = subject_id) THEN
            UPDATE student_scores
            SET score = score + points
            WHERE student_id = target_student_id AND subject_id = subject_id;
        ELSE
            INSERT INTO student_scores (student_id, subject_id, score)
            VALUES (target_student_id, subject_id, points);
        END IF;

        -- Nếu không có lỗi, hoàn tất giao dịch
        IF exit_handler = FALSE THEN
            COMMIT;
            SET message = CONCAT('Đã chuyển ', points, ' điểm thành công');
        END IF;
    END IF;
END //
DELIMITER ;

-- Gọi thủ tục
CALL transfer_score(101, 102, 1, 2.5, @message);
SELECT @message;
```

#### Ví dụ 3: Kiểm soát lỗi với SIGNAL

```sql
DELIMITER //
CREATE PROCEDURE insert_new_student(
    IN p_fullname VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_class_id INT
)
BEGIN
    -- Kiểm tra email đã tồn tại chưa
    IF EXISTS (SELECT 1 FROM students WHERE email = p_email) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Email đã tồn tại trong hệ thống';
    END IF;

    -- Kiểm tra lớp học có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM classes WHERE class_id = p_class_id) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Lớp học không tồn tại';
    END IF;

    -- Nếu dữ liệu hợp lệ, thêm sinh viên mới
    INSERT INTO students (fullname, email, class_id)
    VALUES (p_fullname, p_email, p_class_id);

    SELECT LAST_INSERT_ID() AS new_student_id;
END //
DELIMITER ;

-- Gọi thủ tục
CALL insert_new_student('Nguyễn Văn A', 'nguyenvana@example.com', 1);
```

---

## 🧑‍🏫 Bài 3: Tối ưu hóa truy vấn

- Chỉ mục (Indexes) và cách hoạt động
- Phân tích kế hoạch thực thi truy vấn
- Kỹ thuật tối ưu câu lệnh SQL
- Theo dõi và đánh giá hiệu suất

### Chỉ mục (Indexes) và cách hoạt động

Chỉ mục là cấu trúc dữ liệu giúp tăng tốc độ truy vấn bằng cách tạo ra một bảng tra cứu nhanh cho một hoặc nhiều cột trong cơ sở dữ liệu.

#### Ví dụ 1: Tạo chỉ mục cơ bản

```sql
-- Tạo chỉ mục cho cột họ tên học sinh để tìm kiếm nhanh
CREATE INDEX idx_student_fullname ON students(fullname);

-- Tạo chỉ mục cho cột email (duy nhất)
CREATE UNIQUE INDEX idx_student_email ON students(email);
```

#### Ví dụ 2: Chỉ mục đa cột (Composite Index)

```sql
-- Tạo chỉ mục cho cả lớp học và điểm số để tìm kiếm hiệu quả
CREATE INDEX idx_class_score ON students(class_id, score);

-- Tìm kiếm sử dụng chỉ mục đa cột
-- Sử dụng hiệu quả chỉ mục
SELECT * FROM students WHERE class_id = 2 AND score > 8;

-- Cũng sử dụng hiệu quả chỉ mục
SELECT * FROM students WHERE class_id = 2;

-- KHÔNG sử dụng hiệu quả chỉ mục (bỏ qua cột đầu tiên trong chỉ mục)
SELECT * FROM students WHERE score > 8;
```

#### Ví dụ 3: Loại bỏ chỉ mục

```sql
-- Xóa chỉ mục không cần thiết
DROP INDEX idx_student_fullname ON students;
```

#### Ví dụ 4: Chỉ mục đầy đủ văn bản (Fulltext Index)

```sql
-- Tạo fulltext index cho cột mô tả khóa học
CREATE FULLTEXT INDEX idx_course_description ON courses(description);

-- Tìm kiếm văn bản sử dụng fulltext index
SELECT * FROM courses
WHERE MATCH(description) AGAINST('lập trình' IN NATURAL LANGUAGE MODE);
```

### Phân tích kế hoạch thực thi truy vấn

Để tối ưu hiệu quả, cần hiểu cách MySQL thực thi câu truy vấn. Lệnh EXPLAIN cung cấp thông tin về cách truy vấn được thực hiện.

#### Ví dụ 1: Sử dụng EXPLAIN

```sql
-- Phân tích cách thực thi truy vấn
EXPLAIN SELECT * FROM students WHERE score > 8.5;
```

Kết quả:

```text
+----+-------------+----------+------+---------------+------+---------+------+------+-------------+
| id | select_type | table    | type | possible_keys | key  | key_len | ref  | rows | Extra       |
+----+-------------+----------+------+---------------+------+---------+------+------+-------------+
|  1 | SIMPLE      | students | ALL  | NULL          | NULL | NULL    | NULL | 1000 | Using where |
+----+-------------+----------+------+---------------+------+---------+------+------+-------------+
```

Phân tích:

- `type = ALL`: phải quét toàn bộ bảng (full table scan)
- `possible_keys = NULL`: không có chỉ mục phù hợp để sử dụng
- `rows = 1000`: ước tính số hàng phải quét qua

#### Ví dụ 2: EXPLAIN với chỉ mục

```sql
-- Tạo chỉ mục cho cột score
CREATE INDEX idx_score ON students(score);

-- Phân tích lại truy vấn
EXPLAIN SELECT * FROM students WHERE score > 8.5;
```

Kết quả:

```text
+----+-------------+----------+-------+---------------+----------+---------+------+------+-----------------------+
| id | select_type | table    | type  | possible_keys | key      | key_len | ref  | rows | Extra                 |
+----+-------------+----------+-------+---------------+----------+---------+------+------+-----------------------+
|  1 | SIMPLE      | students | range | idx_score     | idx_score| 4       | NULL |  200 | Using index condition |
+----+-------------+----------+-------+---------------+----------+---------+------+------+-----------------------+
```

Phân tích:

- `type = range`: sử dụng chỉ mục để tìm kiếm trong một phạm vi
- `possible_keys = idx_score`: chỉ mục có thể sử dụng
- `key = idx_score`: chỉ mục thực sự được sử dụng
- `rows = 200`: ước tính số hàng phải quét qua (giảm đáng kể)

#### Ví dụ 3: Phân tích JOIN

```sql
-- Phân tích truy vấn JOIN phức tạp
EXPLAIN SELECT s.student_id, s.fullname, c.class_name
FROM students s
JOIN classes c ON s.class_id = c.class_id
WHERE s.score > 8.0
ORDER BY s.fullname;
```

### Kỹ thuật tối ưu câu lệnh SQL

#### Ví dụ 1: Chỉ chọn những cột cần thiết

```sql
-- KHÔNG tốt: Lấy tất cả các cột
SELECT * FROM students JOIN classes ON students.class_id = classes.class_id;

-- Tốt hơn: Chỉ lấy những cột cần thiết
SELECT students.student_id, students.fullname, classes.class_name
FROM students
JOIN classes ON students.class_id = classes.class_id;
```

#### Ví dụ 2: Sử dụng điều kiện lọc hiệu quả

```sql
-- KHÔNG tốt: Điều kiện không sử dụng chỉ mục
SELECT * FROM students WHERE YEAR(date_of_birth) = 2000;

-- Tốt hơn: Điều kiện cho phép sử dụng chỉ mục
SELECT * FROM students
WHERE date_of_birth >= '2000-01-01' AND date_of_birth <= '2000-12-31';
```

#### Ví dụ 3: Tránh sử dụng hàm trên cột trong điều kiện WHERE

```sql
-- KHÔNG tốt: Sử dụng hàm trên cột ngăn cản việc sử dụng chỉ mục
SELECT * FROM students WHERE LOWER(email) = 'student@example.com';

-- Tốt hơn: Không sử dụng hàm trên cột trong WHERE
SELECT * FROM students WHERE email = 'student@example.com';
```

#### Ví dụ 4: Sử dụng LIMIT để giới hạn kết quả

```sql
-- KHÔNG tốt: Lấy tất cả kết quả khi chỉ cần một số ít
SELECT * FROM students ORDER BY score DESC;

-- Tốt hơn: Giới hạn số kết quả trả về
SELECT * FROM students ORDER BY score DESC LIMIT 10;
```

#### Ví dụ 5: Sử dụng EXISTS thay vì IN cho subquery

```sql
-- KHÔNG tốt khi có nhiều kết quả: Sử dụng IN với subquery
SELECT * FROM classes
WHERE class_id IN (SELECT class_id FROM students WHERE score > 9);

-- Tốt hơn: Sử dụng EXISTS
SELECT * FROM classes c
WHERE EXISTS (SELECT 1 FROM students s WHERE s.class_id = c.class_id AND s.score > 9);
```

### Theo dõi và đánh giá hiệu suất

#### Ví dụ 1: Theo dõi truy vấn chậm

```sql
-- Bật log cho các truy vấn chậm
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL slow_query_log_file = '/var/log/mysql/slow-queries.log';
SET GLOBAL long_query_time = 1; -- Log các truy vấn chạy > 1 giây
```

#### Ví dụ 2: Xem trạng thái của hệ thống

```sql
-- Xem các biến trạng thái
SHOW STATUS LIKE 'Com_%'; -- Hiển thị số lần mỗi lệnh được thực thi

-- Xem trạng thái của InnoDB
SHOW ENGINE INNODB STATUS;

-- Xem các truy vấn đang chạy
SHOW PROCESSLIST;

-- Kiểm tra các truy vấn tốn thời gian dài
SELECT * FROM information_schema.PROCESSLIST
WHERE TIME > 60; -- Các truy vấn chạy hơn 60 giây
```

#### Ví dụ 3: Phân tích câu lệnh bằng ANALYZE

```sql
-- Phân tích bảng để cập nhật thống kê
ANALYZE TABLE students, classes, student_scores;
```

#### Ví dụ 4: Tối ưu hóa câu lệnh SQL

```sql
-- Sử dụng EXPLAIN FORMAT=JSON để có thêm chi tiết về kế hoạch thực thi
EXPLAIN FORMAT=JSON
SELECT s.student_id, s.fullname, AVG(ss.score) as avg_score
FROM students s
JOIN student_scores ss ON s.student_id = ss.student_id
WHERE s.class_id = 3
GROUP BY s.student_id, s.fullname
HAVING avg_score > 7.5
ORDER BY avg_score DESC;
```

### Bài tập thực hành

1. Tạo một bảng Students với 100,000 bản ghi mẫu
2. Thực hiện các truy vấn khác nhau và sử dụng EXPLAIN để phân tích
3. Tạo chỉ mục và đo thời gian truy vấn trước và sau khi tạo chỉ mục
4. Viết lại các câu truy vấn không hiệu quả để cải thiện hiệu suất

---

## 🧑‍🏫 Bài 4: Thiết kế cơ sở dữ liệu

- Chuẩn hóa và phi chuẩn hóa
- Mô hình dữ liệu: khái niệm và ứng dụng
- Ràng buộc toàn vẹn và quan hệ
- Thiết kế hướng hiệu suất

### Chuẩn hóa và phi chuẩn hóa

Chuẩn hóa là quá trình cấu trúc cơ sở dữ liệu để giảm thiểu sự dư thừa và đảm bảo tính nhất quán của dữ liệu. Phi chuẩn hóa là quá trình ngược lại, thêm dư thừa có chủ đích để tối ưu hiệu suất.

#### Ví dụ 1: Dữ liệu chưa chuẩn hóa

Bảng `student_courses` ban đầu:

| student_id | student_name | course_id | course_name | teacher_name | score |
| ---------- | ------------ | --------- | ----------- | ------------ | ----- |
| 101        | Nguyễn Văn A | C001      | SQL Cơ bản  | Trần Văn X   | 8.5   |
| 102        | Lê Thị B     | C001      | SQL Cơ bản  | Trần Văn X   | 9.0   |
| 101        | Nguyễn Văn A | C002      | HTML/CSS    | Phạm Thị Y   | 7.5   |
| 102        | Lê Thị B     | C002      | HTML/CSS    | Phạm Thị Y   | 8.0   |

**Vấn đề**:

- Lặp lại thông tin sinh viên, khóa học, giáo viên
- Khó cập nhật (VD: thay đổi tên khóa học phải cập nhật nhiều dòng)
- Rủi ro dữ liệu không nhất quán

#### Ví dụ 2: Chuẩn hóa dạng 1NF

Dữ liệu trong mỗi cột phải là giá trị nguyên tử (không được chia nhỏ hơn).

```sql
-- Ví dụ bảng vi phạm 1NF
CREATE TABLE contacts (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    phone_numbers VARCHAR(255) -- Lưu nhiều số điện thoại trong một cột "098765432, 012345678"
);

-- Sửa thành 1NF: Tách thành 2 bảng
CREATE TABLE contacts (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE contact_phones (
    contact_id INT,
    phone_number VARCHAR(15),
    PRIMARY KEY (contact_id, phone_number),
    FOREIGN KEY (contact_id) REFERENCES contacts(id)
);
```

#### Ví dụ 3: Chuẩn hóa dạng 2NF

Phải đạt 1NF và mọi cột không khóa phải phụ thuộc đầy đủ vào khóa chính (không phụ thuộc vào một phần của khóa chính).

```sql
-- Ví dụ bảng vi phạm 2NF
CREATE TABLE student_courses (
    student_id INT,
    course_id INT,
    student_name VARCHAR(100), -- Phụ thuộc vào student_id (một phần của khóa chính)
    course_name VARCHAR(100), -- Phụ thuộc vào course_id (một phần của khóa chính)
    score DECIMAL(4,2),
    PRIMARY KEY (student_id, course_id)
);

-- Sửa thành 2NF: Tách thành 3 bảng
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE courses (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    score DECIMAL(4,2),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);
```

#### Ví dụ 4: Chuẩn hóa dạng 3NF

Phải đạt 2NF và không có cột không khóa phụ thuộc vào cột không khóa khác (phụ thuộc bắc cầu).

```sql
-- Ví dụ bảng vi phạm 3NF
CREATE TABLE courses (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    teacher_id INT,
    teacher_name VARCHAR(100) -- Phụ thuộc vào teacher_id (không phải khóa chính)
);

-- Sửa thành 3NF: Tách thành 2 bảng
CREATE TABLE teachers (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE courses (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);
```

#### Ví dụ 5: Phi chuẩn hóa có chủ đích

```sql
-- Lưu trữ dữ liệu tổng hợp để tăng hiệu suất truy vấn
CREATE TABLE classes (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    student_count INT, -- Dư thừa có tính toán
    avg_score DECIMAL(4,2) -- Dư thừa có tính toán
);

-- Procedure cập nhật dữ liệu tổng hợp
DELIMITER //
CREATE PROCEDURE update_class_statistics(IN class_id INT)
BEGIN
    -- Cập nhật số lượng sinh viên
    UPDATE classes c
    SET student_count = (
        SELECT COUNT(*) FROM students s WHERE s.class_id = c.id
    )
    WHERE c.id = class_id;

    -- Cập nhật điểm trung bình
    UPDATE classes c
    SET avg_score = (
        SELECT AVG(score)
        FROM students s
        WHERE s.class_id = c.id
    )
    WHERE c.id = class_id;
END //
DELIMITER ;
```

### Mô hình dữ liệu: khái niệm và ứng dụng

#### Ví dụ 1: Mô hình Entity-Relationship (ER)

![ER Diagram](/assets/er_diagram.png)

```sql
-- Triển khai mô hình ER thành các bảng
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    date_of_birth DATE,
    address VARCHAR(255)
);

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    credits INT
);

CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    enrollment_date DATE DEFAULT CURRENT_DATE,
    grade DECIMAL(4,2),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);
```

#### Ví dụ 2: Mối quan hệ một-nhiều (One-to-Many)

```sql
-- Một giáo viên phụ trách nhiều khóa học
CREATE TABLE teachers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department VARCHAR(50)
);

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);
```

#### Ví dụ 3: Mối quan hệ nhiều-nhiều (Many-to-Many)

```sql
-- Sinh viên có thể đăng ký nhiều khóa học và mỗi khóa học có nhiều sinh viên
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL
);

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL
);

CREATE TABLE student_courses (
    student_id INT,
    course_id INT,
    registration_date DATE,
    grade DECIMAL(4,2),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);
```

#### Ví dụ 4: Mối quan hệ một-một (One-to-One)

```sql
-- Mỗi sinh viên có một hồ sơ chi tiết
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE student_profiles (
    student_id INT PRIMARY KEY,
    bio TEXT,
    address VARCHAR(255),
    phone VARCHAR(15),
    avatar_url VARCHAR(255),
    FOREIGN KEY (student_id) REFERENCES students(id)
);
```

### Ràng buộc toàn vẹn và quan hệ

#### Ví dụ 1: Ràng buộc khóa chính (PRIMARY KEY)

```sql
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Đảm bảo mỗi sinh viên có một id duy nhất
    student_code VARCHAR(10) UNIQUE NOT NULL, -- Mã sinh viên cũng phải duy nhất
    fullname VARCHAR(100) NOT NULL
);
```

#### Ví dụ 2: Ràng buộc khóa ngoại (FOREIGN KEY)

```sql
CREATE TABLE enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(id)
        ON DELETE CASCADE -- Xóa tự động khi sinh viên bị xóa
        ON UPDATE CASCADE, -- Cập nhật tự động khi id sinh viên thay đổi
    FOREIGN KEY (course_id) REFERENCES courses(id)
        ON DELETE RESTRICT -- Không cho phép xóa khóa học nếu có sinh viên đăng ký
);
```

#### Ví dụ 3: Ràng buộc CHECK

```sql
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    age INT CHECK (age >= 18), -- Đảm bảo tuổi >= 18
    email VARCHAR(100) UNIQUE CHECK (email LIKE '%@%.%') -- Đảm bảo email có định dạng hợp lệ
);

-- Với MySQL < 8.0.16 không hỗ trợ CHECK trực tiếp, có thể dùng TRIGGER
DELIMITER //
CREATE TRIGGER check_student_age
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
    IF NEW.age < 18 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tuổi phải lớn hơn hoặc bằng 18';
    END IF;
END //
DELIMITER ;
```

#### Ví dụ 4: Ràng buộc DEFAULT

```sql
CREATE TABLE enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE DEFAULT CURRENT_DATE, -- Tự động set ngày hiện tại
    status VARCHAR(20) DEFAULT 'Active', -- Trạng thái mặc định
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);
```

#### Ví dụ 5: Ràng buộc NOT NULL

```sql
CREATE TABLE teachers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL, -- Không được để trống
    email VARCHAR(100) NOT NULL UNIQUE, -- Không được để trống và phải duy nhất
    department VARCHAR(50)
);
```

### Thiết kế hướng hiệu suất

#### Ví dụ 1: Chọn kiểu dữ liệu phù hợp

```sql
-- Không hiệu quả
CREATE TABLE products (
    id VARCHAR(255) PRIMARY KEY, -- Dùng VARCHAR cho id
    name VARCHAR(255), -- Dùng VARCHAR quá lớn cho tên sản phẩm
    price VARCHAR(50), -- Lưu số tiền dưới dạng chuỗi
    description TEXT -- Dùng TEXT cho mọi mô tả
);

-- Hiệu quả hơn
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Dùng INT tiết kiệm hơn cho ID
    name VARCHAR(100), -- Giới hạn kích thước hợp lý
    price DECIMAL(10,2), -- Dùng DECIMAL cho giá tiền
    description VARCHAR(1000) -- Giới hạn kích thước cho mô tả ngắn
);
```

#### Ví dụ 2: Phân vùng bảng (Table Partitioning)

```sql
-- Phân vùng dữ liệu theo năm để cải thiện hiệu suất truy vấn
CREATE TABLE orders (
    id INT AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    PRIMARY KEY(id, order_date)
)
PARTITION BY RANGE (YEAR(order_date)) (
    PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION pOthers VALUES LESS THAN MAXVALUE
);

-- Truy vấn hiệu quả chỉ quét một phân vùng
SELECT * FROM orders WHERE order_date BETWEEN '2022-01-01' AND '2022-12-31';
```

#### Ví dụ 3: Đánh chỉ mục hiệu quả

```sql
-- Tạo chỉ mục đơn cho các cột thường dùng trong WHERE
CREATE INDEX idx_student_email ON students(email);

-- Tạo chỉ mục kết hợp cho các cột thường được sử dụng cùng nhau
CREATE INDEX idx_course_dept_semester ON courses(department_id, semester);

-- Tạo chỉ mục bao gồm (covering index) để tránh tìm kiếm dữ liệu
CREATE INDEX idx_student_list ON students(class_id, fullname, email);
-- Cho phép truy vấn sau đây chỉ sử dụng chỉ mục mà không cần truy cập vào bảng:
-- SELECT fullname, email FROM students WHERE class_id = 5;
```

#### Ví dụ 4: Sử dụng các bảng tổng hợp (Materialized Views)

```sql
-- Tạo bảng tổng hợp thông tin thống kê
CREATE TABLE class_statistics (
    class_id INT PRIMARY KEY,
    total_students INT,
    avg_score DECIMAL(4,2),
    highest_score DECIMAL(4,2),
    lowest_score DECIMAL(4,2),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Procedure cập nhật bảng tổng hợp
DELIMITER //
CREATE PROCEDURE refresh_class_statistics()
BEGIN
    -- Xóa dữ liệu cũ
    TRUNCATE TABLE class_statistics;

    -- Chèn dữ liệu mới
    INSERT INTO class_statistics (class_id, total_students, avg_score, highest_score, lowest_score)
    SELECT
        class_id,
        COUNT(*) AS total_students,
        AVG(score) AS avg_score,
        MAX(score) AS highest_score,
        MIN(score) AS lowest_score
    FROM students
    GROUP BY class_id;

    -- Cập nhật thời gian
    UPDATE class_statistics SET last_updated = CURRENT_TIMESTAMP;
END //
DELIMITER ;

-- Lên lịch cập nhật mỗi ngày
CREATE EVENT refresh_class_statistics
ON SCHEDULE EVERY 1 DAY
DO
CALL refresh_class_statistics();
```

#### Ví dụ 5: Thiết kế schema hợp lý

```sql
-- Thiết kế schema phân cấp
CREATE DATABASE school_management;

USE school_management;

-- Bảng các phòng ban
CREATE TABLE departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Bảng nhân viên (đặt trong schema chính)
CREATE TABLE staff (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- Tạo schema riêng cho dữ liệu học tập
CREATE DATABASE school_management_academic;

USE school_management_academic;

-- Bảng học sinh
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL
);

-- Thiết lập quyền truy cập
GRANT SELECT, INSERT, UPDATE ON school_management.staff TO 'admin_user'@'localhost';
GRANT SELECT ON school_management_academic.students TO 'teacher_user'@'localhost';
```

### Bài tập thực hành: Thiết kế cơ sở dữ liệu

1. Cho dữ liệu bán hàng chưa được chuẩn hóa, hãy phân tích và thiết kế lại theo các dạng chuẩn 1NF, 2NF và 3NF
2. Thiết kế mô hình ER cho hệ thống quản lý thư viện, bao gồm sách, độc giả, mượn trả sách
3. Chuyển đổi mô hình ER thành các bảng SQL với đầy đủ ràng buộc
4. Xác định các chỉ mục cần thiết để cải thiện hiệu suất truy vấn

---

## 🧑‍🏫 Bài 5: Bảo mật và quản trị

1. Quản lý người dùng và phân quyền

   - **Tạo người dùng**:

     ```sql
     CREATE USER 'student_user'@'localhost' IDENTIFIED BY 'secure_password';
     ```

   - **Cấp quyền cụ thể**:

     ```sql
     -- Cấp quyền SELECT cho một bảng cụ thể
     GRANT SELECT ON school_management.students TO 'student_user'@'localhost';

     -- Cấp nhiều loại quyền
     GRANT SELECT, INSERT, UPDATE ON school_management.* TO 'teacher_user'@'localhost';

     -- Cấp tất cả quyền (chỉ nên cấp cho admin)
     GRANT ALL PRIVILEGES ON school_management.* TO 'admin_user'@'localhost';
     ```

   - **Thu hồi quyền**:

     ```sql
     REVOKE INSERT, UPDATE ON school_management.students FROM 'student_user'@'localhost';
     ```

   - **Xem quyền của người dùng**:

     ```sql
     SHOW GRANTS FOR 'student_user'@'localhost';
     ```

2. Backup và phục hồi dữ liệu

   - **Backup cơ sở dữ liệu**:

   ```bash
   # Sử dụng mysqldump để tạo backup
   mysqldump -u root -p school_management > school_backup.sql

   # Backup chỉ cấu trúc bảng (không có dữ liệu)
   mysqldump -u root -p --no-data school_management > schema_backup.sql

   # Backup chỉ một số bảng cụ thể
   mysqldump -u root -p school_management students courses > tables_backup.sql
   ```

   - **Phục hồi dữ liệu**:

   ```bash
   # Phục hồi từ file backup
   mysql -u root -p school_management < school_backup.sql

   # Thực hiện từ trong MySQL client
   SOURCE /path/to/school_backup.sql;
   ```

   - **Lập lịch backup tự động** (Linux crontab):

   ```bash
   # Backup hàng ngày lúc 01:00 sáng
   0 1 * * * mysqldump -u root -p'password' school_management > /backup/school_$(date +\%Y\%m\%d).sql
   ```

3. Bảo mật và phòng chống SQL Injection

   - **Vấn đề SQL Injection**:

   ```sql
   -- Ví dụ nguy hiểm (KHÔNG NÊN LÀM):
   $username = $_POST['username'];
   $query = "SELECT * FROM users WHERE username = '$username'";
   // Nếu người dùng nhập: admin' --
   // Câu truy vấn trở thành: SELECT * FROM users WHERE username = 'admin' --'
   ```

   - **Cách phòng tránh SQL Injection**:

   1. **Sử dụng Prepared Statements**:

      ```php
      // PHP với PDO
      $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
      $stmt->execute([$username]);

      // JAVA với JDBC
      PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE username = ?");
      stmt->setString(1, username);
      ```

   2. **Kiểm tra và làm sạch dữ liệu đầu vào**:

      ```php
      $username = mysqli_real_escape_string($conn, $_POST['username']);
      ```

   3. **Sử dụng ORM (Object-Relational Mapping)**:

      ```java
      // Sử dụng Hibernate trong JAVA
      User user = session.createQuery("from User where username = :username")
          .setParameter("username", username)
          .uniqueResult();
      ```

### Giám sát và điều chỉnh hệ thống

- **Theo dõi truy vấn chậm**:

  ```sql
  -- Bật log slow queries trong MySQL
  SET GLOBAL slow_query_log = 'ON';
  SET GLOBAL slow_query_log_file = '/var/log/mysql/slow-queries.log';
  SET GLOBAL long_query_time = 2; -- Log các truy vấn chạy > 2 giây
  ```

- **Xem trạng thái hệ thống**:

  ```sql
  -- Xem các biến trạng thái của hệ thống
  SHOW STATUS;

  -- Xem các biến cấu hình
  SHOW VARIABLES;

  -- Xem các kết nối đang hoạt động
  SHOW PROCESSLIST;
  ```

- **Tối ưu cấu hình MySQL**:

  ```ini
  # Ví dụ cấu hình trong file my.cnf
  [mysqld]
  # Bộ nhớ cache cho InnoDB
  innodb_buffer_pool_size = 1G

  # Cache truy vấn
  query_cache_size = 64M

  # Kích thước tệp log
  max_binlog_size = 100M
  ```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Quản lý sinh viên và lớp học

### Mô tả bài toán

Mở rộng cơ sở dữ liệu quản lý sinh viên:

- Tạo thêm bảng `classes` để lưu thông tin về các lớp học
- Tạo mối quan hệ một-nhiều giữa `classes` và `students`
- Thêm bảng `subjects` để lưu thông tin môn học

### Yêu cầu

- Thiết kế các bảng với khóa chính và khóa ngoại phù hợp
- Viết các truy vấn để:
  - Tìm kiếm sinh viên theo tên hoặc mã
  - Liệt kê sinh viên theo lớp
  - Tính điểm trung bình của từng lớp
  - Sắp xếp sinh viên theo điểm trung bình
  - Tìm sinh viên có điểm cao nhất trong mỗi lớp
- Truy vấn dữ liệu từ nhiều bảng bằng các loại JOIN

---

[⬅️ Trở lại: SQL/Part2.md](../SQL/Part2.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: SQL/Part3.md](../SQL/Part3.md)
