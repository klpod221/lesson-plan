---
prev:
  text: '🏆 Bài Tập Lớn Java'
  link: '/JAVA/FINAL'
next:
  text: '📊 SQL Nâng Cao'
  link: '/SQL/Part2'
---

# 📘 PHẦN 1: NHẬP MÔN SQL

## 🎯 Mục tiêu tổng quát

- Làm quen với cú pháp và cách sử dụng ngôn ngữ truy vấn SQL
- Biết cách tạo cơ sở dữ liệu, bảng và thao tác dữ liệu
- Hiểu được các câu lệnh truy vấn và kết hợp dữ liệu

## 🧑‍🏫 Bài 1: Giới thiệu về SQL và CSDL

### Khái niệm cơ sở dữ liệu quan hệ

- Cơ sở dữ liệu quan hệ (RDBMS) là hệ thống lưu trữ dữ liệu theo bảng (table) với các cột và hàng.
- Mỗi bảng sẽ có các cột (column) đại diện cho các thuộc tính và các hàng (row) đại diện cho các bản ghi dữ liệu.
- Các bảng có thể liên kết với nhau thông qua khóa chính (primary key) và khóa ngoại (foreign key).

### Các hệ quản trị CSDL phổ biến

| Hệ quản trị | Ưu điểm                                      | Nhược điểm                                   |
| ----------- | -------------------------------------------- | -------------------------------------------- |
| MySQL       | Miễn phí, phổ biến, dễ sử dụng               | Hiệu suất thấp hơn so với một số DBMS khác   |
| PostgreSQL  | Mạnh mẽ, nhiều tính năng nâng cao            | Phức tạp hơn để cấu hình                     |
| SQL Server  | Tích hợp tốt với các sản phẩm Microsoft      | Chi phí giấy phép cao                        |
| Oracle      | Độ ổn định cao, nhiều tính năng doanh nghiệp | Rất đắt và phức tạp                          |
| SQLite      | Nhẹ, không cần máy chủ, nhúng được           | Không phù hợp cho ứng dụng đa người dùng lớn |

### Công cụ quản lý

- [MySQL Workbench](https://www.mysql.com/products/workbench/): Công cụ chính thức của MySQL, hỗ trợ thiết kế và quản lý cơ sở dữ liệu
- [phpMyAdmin](https://www.phpmyadmin.net/): Công cụ quản lý MySQL qua web, dễ sử dụng cho người mới (khuyên dùng)
- [HeidiSQL](https://www.heidisql.com/): Công cụ quản lý MySQL miễn phí trên Windows, giao diện thân thiện
- [DBeaver](https://dbeaver.io/): Công cụ quản lý CSDL đa nền tảng, hỗ trợ nhiều loại CSDL khác nhau
- [DataGrip](https://www.jetbrains.com/datagrip/): Công cụ quản lý CSDL của JetBrains, hỗ trợ nhiều loại CSDL, có phí
- [Navicat](https://www.navicat.com/en/products/navicat-for-mysql): Công cụ quản lý CSDL thương mại, giao diện đẹp và nhiều tính năng mạnh mẽ

### Sử dụng phpMyAdmin để quản lý cơ sở dữ liệu

- phpMyAdmin là công cụ quản lý MySQL/MariaDB được viết bằng PHP, cho phép bạn quản lý cơ sở dữ liệu qua trình duyệt web. Đây là công cụ rất phổ biến, đặc biệt với người mới bắt đầu vì giao diện trực quan và dễ sử dụng.
- Tôi đã hướng dẫn cài đặt phpMyAdmin trong phần [cài đặt môi trường học tập](../INSTALL.md). Bạn có thể tham khảo lại để biết cách cài đặt và cấu hình.

#### Sử dụng phpMyAdmin

1. **Đăng nhập**:

   - Username: thường là "root"
   - Password: mật khẩu bạn đã thiết lập cho MySQL

2. **Giao diện chính**:

   - Bên trái: Danh sách các cơ sở dữ liệu
   - Bên phải: Các tùy chọn và thông tin

3. **Các tính năng cơ bản**:

   - Tạo cơ sở dữ liệu mới: Nhấp vào "New" hoặc "Database"
   - Tạo bảng: Chọn cơ sở dữ liệu, nhấp vào "Create table"
   - Thực hiện truy vấn: Nhấp vào tab "SQL" để nhập và chạy các câu lệnh SQL
   - Quản lý dữ liệu: Nhấp vào tên bảng để xem, thêm, sửa, xóa dữ liệu
   - Xuất/nhập dữ liệu: Sử dụng các tùy chọn "Export" và "Import"

4. **Ưu điểm của phpMyAdmin**:
   - Giao diện trực quan, dễ sử dụng
   - Không cần cài đặt phần mềm riêng (chỉ cần trình duyệt)
   - Hỗ trợ nhiều tính năng nâng cao như quản lý người dùng, quyền truy cập
   - Có thể thực hiện các thao tác phức tạp mà không cần viết SQL

### Sử dụng VSCode extension để kết nối CSDL

- Như đã đề cập đến trong phần [về VSCode](../INSTALL.md#cài-đặt-các-extension-cần-thiết) của bài cài đặt môi trường học tập, bạn có thể sử dụng extension [MySQL](https://marketplace.visualstudio.com/items?itemName=cweijan.vscode-mysql-client2) để kết nối và quản lý cơ sở dữ liệu ngay trong VSCode. Các bước thực hiện như sau:

  1. Cài đặt extension MySQL từ VS Code Marketplace
  2. Sau khi cài đặt xong, bạn sẽ thấy biểu tượng MySQL xuất hiện trong thanh bên trái của VS Code
  3. Nhấp vào biểu tượng MySQL, sau đó nhấn vào biểu tượng "+" để tạo kết nối mới
  4. Nhập thông tin kết nối:
     - **Connection name**: Tên kết nối (tự đặt)
     - **Select Type**: Chọn loại kết nối (MySQL hoặc MariaDB)
     - **Host**: Địa chỉ máy chủ (thường là localhost)
     - **Port**: Cổng kết nối (mặc định là 3306)
     - **Username**: Tên người dùng (thường là root)
     - **Password**: Mật khẩu của người dùng
     - **Database**: Tên cơ sở dữ liệu (có thể để trống để hiển thị tất cả cơ sở dữ liệu)
  5. Nhấn nút "Connect" để kiểm tra kết nối
     - Nếu kết nối thành công, bạn sẽ thấy danh sách các cơ sở dữ liệu và bảng trong thanh bên trái
     - Nếu không thành công, hãy kiểm tra lại thông tin kết nối và đảm bảo rằng MySQL server đang chạy
  6. Nhấn "Save" để lưu kết nối
  7. Sau khi kết nối thành công, bạn có thể:
     - Xem tất cả cơ sở dữ liệu trong hệ thống
     - Mở rộng cơ sở dữ liệu để xem các bảng, view, procedure, và các thành phần khác
     - Nhấp chuột phải vào các thành phần để thực hiện các thao tác như chỉnh sửa dữ liệu, xuất dữ liệu, v.v.
     - Tạo file SQL và chạy các câu lệnh trực tiếp từ VS Code

  ```sql
  -- test.sql
  SHOW DATABASES; -- Hiển thị danh sách các cơ sở dữ liệu
  ```

## 🧑‍🏫 Bài 2: Tạo và quản lý cơ sở dữ liệu

### Tạo và quản lý cơ sở dữ liệu

```sql
-- Tạo cơ sở dữ liệu mới
CREATE DATABASE school_management;

-- Sử dụng cơ sở dữ liệu
USE school_management;

-- Xóa cơ sở dữ liệu (cẩn thận với lệnh này)
DROP DATABASE school_management;
```

### Các kiểu dữ liệu cơ bản trong SQL

- Giống như các ngôn ngữ lập trình khác, SQL cũng có các kiểu dữ liệu để lưu trữ thông tin. Dưới đây là một số kiểu dữ liệu phổ biến trong SQL:

  | Kiểu dữ liệu | Mô tả                                            | Ví dụ                 |
  | ------------ | ------------------------------------------------ | --------------------- |
  | INT          | Số nguyên                                        | 10, -5, 0             |
  | DECIMAL(p,s) | Số thập phân với p chữ số, s chữ số sau dấu phẩy | 123.45                |
  | VARCHAR(n)   | Chuỗi có độ dài thay đổi, tối đa n ký tự         | 'Hello'               |
  | CHAR(n)      | Chuỗi có độ dài cố định n ký tự                  | 'ABC'                 |
  | TEXT         | Chuỗi văn bản dài                                | Đoạn văn dài          |
  | DATE         | Ngày (YYYY-MM-DD)                                | '2023-05-25'          |
  | DATETIME     | Ngày và giờ                                      | '2023-05-25 10:30:00' |
  | BOOLEAN      | Giá trị logic (TRUE/FALSE)                       | TRUE, FALSE           |
  | BLOB         | Dữ liệu nhị phân lớn                             | Hình ảnh, tệp         |

### Một số ràng buộc trong SQL

- `PRIMARY KEY`: Khóa chính, đảm bảo tính duy nhất cho mỗi bản ghi
- `AUTO_INCREMENT`: Tự động tăng giá trị cho cột (thường dùng cho khóa chính)
- `FOREIGN KEY`: Khóa ngoại, liên kết với khóa chính của bảng khác
- `NOT NULL`: Bắt buộc phải có giá trị
- `UNIQUE`: Đảm bảo giá trị là duy nhất trong cột
- `DEFAULT`: Xác định giá trị mặc định
- `CHECK`: Thêm điều kiện hợp lệ cho giá trị

### Tạo bảng và ràng buộc

```sql
-- Tạo bảng students
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    date_of_birth DATE,
    gender CHAR(1),
    admission_date DATE DEFAULT (CURRENT_DATE),
    is_active BOOLEAN DEFAULT TRUE
);

-- Tạo bảng courses
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    credits INT CHECK (credits > 0),
    department VARCHAR(50)
);

-- Tạo bảng enrollments với khóa ngoại
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade DECIMAL(4,1),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    UNIQUE (student_id, course_id) -- Không cho phép học sinh đăng ký 1 khóa học 2 lần
);

```

### Sơ đồ quan hệ của cơ sở dữ liệu

```text
+----------------+        +-----------------+        +-------------+
| students       |        | enrollments     |        | courses     |
+----------------+        +-----------------+        +-------------+
| student_id     |<-------| student_id      |        | course_id   |
| first_name     |        | course_id       |------->| course_name |
| last_name      |        | enrollment_id   |        | credits     |
| email          |        | enrollment_date |        | department  |
| date_of_birth  |        | grade           |        |             |
| gender         |        +-----------------+        +-------------+
| admission_date |
| is_active      |
+----------------+
```

- Giải thích mối quan hệ:

  - Một sinh viên (`students`) có thể đăng ký nhiều khóa học → Mối quan hệ 1-n với `enrollments`
  - Một khóa học (`courses`) có thể được nhiều sinh viên đăng ký → Mối quan hệ 1-n với `enrollments`
  - Bảng `enrollments` là bảng trung gian tạo mối quan hệ n-n giữa sinh viên và khóa học

## 🧑‍🏫 Bài 3: Thao tác dữ liệu

### Thêm dữ liệu với INSERT INTO

```sql
-- Thêm một bản ghi
INSERT INTO students (first_name, last_name, email, date_of_birth, gender)
VALUES ('Văn', 'Nguyễn', 'van.nguyen@example.com', '2000-05-15', 'M');

-- Thêm nhiều bản ghi
INSERT INTO students (first_name, last_name, email, date_of_birth, gender)
VALUES
    ('Thị', 'Lê', 'thi.le@example.com', '2001-03-21', 'F'),
    ('Minh', 'Trần', 'minh.tran@example.com', '1999-11-08', 'M'),
    ('Hoa', 'Phạm', 'hoa.pham@example.com', '2002-07-30', 'F');

-- Thêm dữ liệu từ một bảng khác (sao chép dữ liệu)
INSERT INTO archived_students (student_id, first_name, last_name, email)
SELECT student_id, first_name, last_name, email
FROM students
WHERE admission_date < '2022-01-01';
```

### Cập nhật dữ liệu với UPDATE

```sql
-- Cập nhật một cột cho tất cả bản ghi
UPDATE students SET is_active = TRUE;

-- Cập nhật một bản ghi cụ thể
UPDATE students SET email = 'new.email@example.com'
WHERE student_id = 5;

-- Cập nhật nhiều cột
UPDATE students
SET
    first_name = 'Thành',
    last_name = 'Hoàng',
    is_active = FALSE
WHERE student_id = 10;

-- Cập nhật dựa trên điều kiện phức tạp
UPDATE enrollments
SET grade = grade + 0.5
WHERE grade < 5.0 AND course_id IN (SELECT course_id FROM courses WHERE department = 'Math');

-- Lưu ý: Luôn cẩn thận khi UPDATE không có WHERE (sẽ cập nhật tất cả bản ghi)
```

### Xóa dữ liệu với DELETE

```sql
-- Xóa một bản ghi cụ thể
DELETE FROM students WHERE student_id = 15;

-- Xóa nhiều bản ghi theo điều kiện
DELETE FROM students WHERE is_active = FALSE;

-- Xóa dữ liệu dựa trên subquery
DELETE FROM enrollments
WHERE student_id IN (SELECT student_id FROM students WHERE is_active = FALSE);

-- Xóa tất cả dữ liệu trong bảng (THẬN TRỌNG!)
DELETE FROM enrollments;

-- Hoặc nhanh hơn (reset cả auto-increment)
TRUNCATE TABLE enrollments;
```

### Thay đổi cấu trúc bảng với ALTER TABLE

```sql
-- Thêm cột mới
ALTER TABLE students ADD COLUMN phone VARCHAR(20);

-- Thêm cột với giá trị mặc định
ALTER TABLE students ADD COLUMN nationality VARCHAR(50) DEFAULT 'Vietnam';

-- Đổi tên cột
ALTER TABLE students CHANGE first_name given_name VARCHAR(50);
-- Hoặc (tùy DBMS)
ALTER TABLE students RENAME COLUMN first_name TO given_name;

-- Thay đổi kiểu dữ liệu của cột
ALTER TABLE students MODIFY email VARCHAR(150);

-- Xóa cột
ALTER TABLE students DROP COLUMN phone;

-- Thêm khóa chính (nếu chưa có)
ALTER TABLE students ADD PRIMARY KEY (student_id);

-- Thêm khóa ngoại
ALTER TABLE enrollments ADD CONSTRAINT fk_student
FOREIGN KEY (student_id) REFERENCES students(student_id);

-- Xóa khóa ngoại
ALTER TABLE enrollments DROP FOREIGN KEY fk_student;

-- Đổi tên bảng
ALTER TABLE students RENAME TO student_records;
```

## 🧑‍🏫 Bài 4: Truy vấn dữ liệu

### Truy vấn cơ bản với SELECT

```sql
-- Lấy tất cả dữ liệu từ bảng students
SELECT * FROM students;

-- Lấy các cột cụ thể
SELECT first_name, last_name, email FROM students;

-- Đổi tên cột khi hiển thị kết quả
SELECT
    first_name AS 'Tên',
    last_name AS 'Họ',
    date_of_birth AS 'Ngày sinh'
FROM students;

-- Kết hợp các cột
SELECT
    CONCAT(first_name, ' ', last_name) AS 'Họ và tên',
    email
FROM students;
```

### Lọc dữ liệu với WHERE

```sql
-- Lọc theo điều kiện
SELECT * FROM students WHERE gender = 'F';

-- Nhiều điều kiện với AND và OR
SELECT * FROM students
WHERE gender = 'M' AND is_active = TRUE;

SELECT * FROM students
WHERE gender = 'F' OR date_of_birth > '2000-01-01';

-- Kiểm tra giá trị NULL
SELECT * FROM students WHERE email IS NULL;
SELECT * FROM students WHERE email IS NOT NULL;

-- Tìm kiếm với LIKE
SELECT * FROM students WHERE last_name LIKE 'Nguy%'; -- Bắt đầu bằng "Nguy"
SELECT * FROM students WHERE email LIKE '%@gmail.com'; -- Kết thúc bằng "@gmail.com"
SELECT * FROM students WHERE first_name LIKE '_an'; -- Có 3 ký tự, kết thúc bằng "an"

-- Kiểm tra giá trị trong tập hợp
SELECT * FROM courses WHERE department IN ('IT', 'Math', 'Physics');

-- Kiểm tra giá trị trong khoảng
SELECT * FROM enrollments WHERE grade BETWEEN 8.0 AND 10.0;
```

### Sắp xếp kết quả với ORDER BY

```sql
-- Sắp xếp tăng dần theo họ
SELECT * FROM students ORDER BY last_name ASC;

-- Sắp xếp giảm dần theo ngày sinh
SELECT * FROM students ORDER BY date_of_birth DESC;

-- Sắp xếp theo nhiều cột
SELECT * FROM students ORDER BY gender, last_name, first_name;

-- Sắp xếp kết hợp tăng/giảm dần
SELECT * FROM enrollments ORDER BY course_id ASC, grade DESC;
```

### Giới hạn kết quả với LIMIT (MySQL, PostgreSQL) hoặc TOP (SQL Server)

- Thường được dùng để giới hạn số lượng bản ghi trả về trong truy vấn. Giúp phân trang dữ liệu hoặc lấy một số bản ghi đầu tiên.

```sql
-- MySQL/PostgreSQL: Lấy 5 học sinh đầu tiên
SELECT * FROM students LIMIT 5;

-- MySQL/PostgreSQL: Lấy 5 học sinh từ vị trí thứ 10
SELECT * FROM students LIMIT 5 OFFSET 10;

-- SQL Server: Lấy 5 học sinh đầu tiên
SELECT TOP 5 * FROM students;

-- Kết hợp ORDER BY và LIMIT để lấy top 3 điểm cao nhất
SELECT * FROM enrollments ORDER BY grade DESC LIMIT 3;
```

## 🧑‍🏫 Bài 5: Kết hợp dữ liệu

### Kết hợp bảng với JOIN

```sql
-- INNER JOIN: chỉ lấy dữ liệu khớp ở cả hai bảng
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_name,
    e.grade
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id;

-- LEFT JOIN: lấy tất cả dữ liệu từ bảng bên trái, và dữ liệu khớp từ bảng bên phải
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    COUNT(e.enrollment_id) AS enrolled_courses
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, student_name;

-- RIGHT JOIN: lấy tất cả dữ liệu từ bảng bên phải, và dữ liệu khớp từ bảng bên trái
SELECT
    c.course_id,
    c.course_name,
    COUNT(e.enrollment_id) AS student_count
FROM enrollments e
RIGHT JOIN courses c ON e.course_id = c.course_id
GROUP BY c.course_id, c.course_name;

-- FULL JOIN (không hỗ trợ trực tiếp trong MySQL)
-- PostgreSQL:
SELECT s.student_id, c.course_id
FROM students s
FULL JOIN enrollments e ON s.student_id = e.student_id
FULL JOIN courses c ON e.course_id = c.course_id;

-- Thay thế FULL JOIN trong MySQL
SELECT s.student_id, c.course_id
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id
UNION
SELECT s.student_id, c.course_id
FROM students s
RIGHT JOIN enrollments e ON s.student_id = e.student_id
RIGHT JOIN courses c ON e.course_id = c.course_id;
```

### Nhóm dữ liệu với GROUP BY

```sql
-- Đếm số sinh viên theo giới tính
SELECT
    gender,
    COUNT(*) AS student_count
FROM students
GROUP BY gender;

-- Tính điểm trung bình của mỗi môn học
SELECT
    c.course_id,
    c.course_name,
    AVG(e.grade) AS average_grade
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

-- Nhóm theo nhiều cột
SELECT
    c.department,
    s.gender,
    COUNT(*) AS enrollment_count
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
JOIN students s ON e.student_id = s.student_id
GROUP BY c.department, s.gender;
```

### Hàm tổng hợp

```sql
-- COUNT: đếm số lượng bản ghi
SELECT COUNT(*) AS total_students FROM students;
SELECT COUNT(email) AS students_with_email FROM students; -- Không đếm NULL

-- SUM: tính tổng
SELECT SUM(credits) AS total_credits FROM courses;

-- AVG: tính trung bình
SELECT AVG(grade) AS average_grade FROM enrollments;

-- MAX, MIN: tìm giá trị lớn nhất, nhỏ nhất
SELECT
    MAX(grade) AS highest_grade,
    MIN(grade) AS lowest_grade
FROM enrollments;

-- Kết hợp nhiều hàm tổng hợp
SELECT
    COUNT(*) AS enrollment_count,
    AVG(grade) AS average_grade,
    MAX(grade) AS highest_grade,
    MIN(grade) AS lowest_grade,
    SUM(grade) / COUNT(*) AS calculated_average
FROM enrollments;
```

### Lọc nhóm dữ liệu với HAVING

```sql
-- Tìm các khóa học có hơn 10 học sinh đăng ký
SELECT
    c.course_id,
    c.course_name,
    COUNT(e.student_id) AS student_count
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING student_count > 10;

-- Tìm học sinh có điểm trung bình trên 8.0
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    AVG(e.grade) AS average_grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, student_name
HAVING average_grade > 8.0
ORDER BY average_grade DESC;

-- Lưu ý sự khác biệt giữa WHERE và HAVING:
-- WHERE lọc dữ liệu trước khi nhóm
-- HAVING lọc dữ liệu sau khi nhóm
SELECT
    c.department,
    COUNT(*) AS course_count,
    AVG(credits) AS average_credits
FROM courses c
WHERE credits > 2 -- Lọc trước khi nhóm
GROUP BY c.department
HAVING average_credits > 3 -- Lọc sau khi nhóm
ORDER BY course_count DESC;
```

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Quản lý sinh viên

### Mô tả bài toán

Xây dựng cơ sở dữ liệu để lưu trữ và quản lý điểm sinh viên:

- Tạo cơ sở dữ liệu `student_management`
- Thiết kế bảng `students` với các trường:
  - `student_id` (khóa chính)
  - `full_name`
  - `math_score`
  - `physics_score`
  - `chemistry_score`
  - `average_score` (có thể tính toán)
  - `classification` (xếp loại học lực)

### Yêu cầu

- Viết lệnh SQL để tạo cơ sở dữ liệu và bảng
- Thêm dữ liệu mẫu cho 5 sinh viên
- Viết truy vấn tính điểm trung bình cho mỗi sinh viên
- Viết truy vấn cập nhật xếp loại học lực dựa trên điểm trung bình:
  - TB >= 8.0 → Giỏi
  - 6.5 <= TB < 8.0 → Khá
  - 5.0 <= TB < 6.5 → Trung bình
  - < 5.0 → Yếu
- Hiển thị danh sách sinh viên kèm điểm trung bình và xếp loại

### Kết quả chạy chương trình (Ví dụ)

```text
+------------+---------------+------------+---------------+-----------------+---------------+----------------+
| student_id | full_name     | math_score | physics_score | chemistry_score | average_score | classification |
+------------+---------------+------------+---------------+-----------------+---------------+----------------+
|          4 | Phạm Thị D    |        9.0 |           8.5 |             8.0 |          8.50 | Giỏi           |
|          1 | Nguyễn Văn A  |        8.5 |           7.5 |             9.0 |          8.33 | Giỏi           |
|          2 | Trần Thị B    |        6.5 |           7.0 |             8.0 |          7.17 | Khá            |
|          3 | Lê Văn C      |        5.0 |           6.0 |             7.0 |          6.00 | Trung bình     |
|          5 | Hoàng Văn E   |        4.0 |           5.0 |             4.5 |          4.50 | Yếu            |
+------------+---------------+------------+---------------+-----------------+---------------+----------------+
```
