# 📘 PHẦN 1: NHẬP MÔN SQL

## Table of Contents

- [📘 PHẦN 1: NHẬP MÔN SQL](#-phần-1-nhập-môn-sql)
  - [Table of Contents](#table-of-contents)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Giới thiệu về SQL và CSDL](#-bài-1-giới-thiệu-về-sql-và-csdl)
  - [🧑‍🏫 Bài 2: Tạo và quản lý cơ sở dữ liệu](#-bài-2-tạo-và-quản-lý-cơ-sở-dữ-liệu)
  - [🧑‍🏫 Bài 3: Truy vấn dữ liệu](#-bài-3-truy-vấn-dữ-liệu)
  - [🧑‍🏫 Bài 4: Thao tác dữ liệu](#-bài-4-thao-tác-dữ-liệu)
  - [🧑‍🏫 Bài 5: Kết hợp dữ liệu](#-bài-5-kết-hợp-dữ-liệu)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN](#-bài-tập-lớn-cuối-phần)
  - [**Đề bài: Quản lý sinh viên**](#đề-bài-quản-lý-sinh-viên)
    - [**Kết quả chạy chương trình (Ví dụ):**](#kết-quả-chạy-chương-trình-ví-dụ)
    - [**Nâng cao: tạo stored procedure để tự động cập nhật điểm trung bình và xếp loại**](#nâng-cao-tạo-stored-procedure-để-tự-động-cập-nhật-điểm-trung-bình-và-xếp-loại)

## 🎯 Mục tiêu tổng quát

- Làm quen với cú pháp và cách sử dụng ngôn ngữ truy vấn SQL
- Biết cách tạo cơ sở dữ liệu, bảng và thao tác dữ liệu
- Hiểu được các câu lệnh truy vấn và kết hợp dữ liệu

---

## 🧑‍🏫 Bài 1: Giới thiệu về SQL và CSDL

- Khái niệm cơ sở dữ liệu quan hệ
- Các hệ quản trị CSDL phổ biến (MySQL, PostgreSQL, SQL Server)
- Cài đặt và cấu hình môi trường làm việc

1. **Khái niệm cơ sở dữ liệu quan hệ:**

   - Cơ sở dữ liệu quan hệ (RDBMS) là hệ thống lưu trữ dữ liệu theo bảng (table) với các cột và hàng.
   - Mỗi bảng sẽ có các cột (column) đại diện cho các thuộc tính và các hàng (row) đại diện cho các bản ghi dữ liệu.
   - Các bảng có thể liên kết với nhau thông qua khóa chính (primary key) và khóa ngoại (foreign key).

2. **Các hệ quản trị CSDL phổ biến:**

   | Hệ quản trị | Ưu điểm                                      | Nhược điểm                                   |
   | ----------- | -------------------------------------------- | -------------------------------------------- |
   | MySQL       | Miễn phí, phổ biến, dễ sử dụng               | Hiệu suất thấp hơn so với một số DBMS khác   |
   | PostgreSQL  | Mạnh mẽ, nhiều tính năng nâng cao            | Phức tạp hơn để cấu hình                     |
   | SQL Server  | Tích hợp tốt với các sản phẩm Microsoft      | Chi phí giấy phép cao                        |
   | Oracle      | Độ ổn định cao, nhiều tính năng doanh nghiệp | Rất đắt và phức tạp                          |
   | SQLite      | Nhẹ, không cần máy chủ, nhúng được           | Không phù hợp cho ứng dụng đa người dùng lớn |

3. **Môi trường làm việc:**

   - **Cài đặt MySQL:**

     - **Linux (Ubuntu/Debian):**

       ```bash
       sudo apt update
       sudo apt install mysql-server
       sudo systemctl start mysql
       sudo systemctl enable mysql
       sudo mysql_secure_installation  # Thiết lập bảo mật
       ```

     - **Linux (CentOS/RHEL):**

       ```bash
       sudo yum install mysql-server
       sudo systemctl start mysqld
       sudo systemctl enable mysqld
       sudo mysql_secure_installation
       ```

     - **Windows:**

       - Tải MySQL Installer từ [trang chủ MySQL](https://dev.mysql.com/downloads/installer/)
       - Chạy installer và làm theo hướng dẫn cài đặt
       - Chọn "Developer Default" hoặc "Custom" để cài MySQL Server và các công cụ
       - Thiết lập mật khẩu root trong quá trình cài đặt

     - **macOS:**

       - Phương pháp 1: Sử dụng Homebrew

         ```bash
         brew install mysql
         brew services start mysql
         mysql_secure_installation
         ```

       - Phương pháp 2: Tải MySQL dmg từ [trang chủ MySQL](https://dev.mysql.com/downloads/mysql/)

   - **Cấu hình cơ bản:**

     - **Đăng nhập vào MySQL:**

       ```bash
       mysql -u root -p
       ```

     - **Tạo người dùng mới:**

       ```sql
       CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';
       ```

     - **Tạo cơ sở dữ liệu:**

       ```sql
       CREATE DATABASE mydatabase;
       ```

     - **Cấp quyền cho người dùng:**

       ```sql
       GRANT ALL PRIVILEGES ON mydatabase.* TO 'username'@'localhost';
       FLUSH PRIVILEGES;
       ```

     - **Kiểm tra người dùng và quyền:**

       ```sql
       SHOW GRANTS FOR 'username'@'localhost';
       ```

   - **Công cụ quản lý:**
     - **MySQL Workbench:** GUI chính thức từ MySQL, có các tính năng thiết kế, phát triển, quản trị
     - **phpMyAdmin:** Công cụ quản lý dựa trên web, thường được cài đặt cùng với stack web LAMP/WAMP
     - **HeidiSQL:** Công cụ miễn phí cho Windows với giao diện thân thiện
     - **DBeaver:** Công cụ quản lý đa nền tảng cho nhiều loại cơ sở dữ liệu, bao gồm MySQL

---

## 🧑‍🏫 Bài 2: Tạo và quản lý cơ sở dữ liệu

- Lệnh `CREATE DATABASE`, `USE`, `DROP DATABASE`
- Các kiểu dữ liệu cơ bản trong SQL
- Tạo bảng với `CREATE TABLE`
- Ràng buộc: `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `UNIQUE`

1. **Tạo và quản lý cơ sở dữ liệu:**

   ```sql
   -- Tạo cơ sở dữ liệu mới
   CREATE DATABASE SchoolManagement;

   -- Sử dụng cơ sở dữ liệu
   USE SchoolManagement;

   -- Xóa cơ sở dữ liệu (cẩn thận với lệnh này)
   DROP DATABASE SchoolManagement;
   ```

2. **Các kiểu dữ liệu cơ bản trong SQL:**

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

3. **Tạo bảng và ràng buộc:**

   ```sql
   -- Tạo bảng Students
   CREATE TABLE Students (
       student_id INT PRIMARY KEY AUTO_INCREMENT,
       first_name VARCHAR(50) NOT NULL,
       last_name VARCHAR(50) NOT NULL,
       email VARCHAR(100) UNIQUE,
       date_of_birth DATE,
       gender CHAR(1),
       admission_date DATE DEFAULT CURRENT_DATE,
       is_active BOOLEAN DEFAULT TRUE
   );

   -- Tạo bảng Courses
   CREATE TABLE Courses (
       course_id INT PRIMARY KEY AUTO_INCREMENT,
       course_name VARCHAR(100) NOT NULL,
       credits INT CHECK (credits > 0),
       department VARCHAR(50)
   );

   -- Tạo bảng Enrollments với khóa ngoại
   CREATE TABLE Enrollments (
       enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
       student_id INT,
       course_id INT,
       enrollment_date DATE,
       grade DECIMAL(4,1),
       FOREIGN KEY (student_id) REFERENCES Students(student_id),
       FOREIGN KEY (course_id) REFERENCES Courses(course_id),
       UNIQUE (student_id, course_id) -- Không cho phép học sinh đăng ký 1 khóa học 2 lần
   );
   ```

4. **Ràng buộc trong SQL:**
   - `PRIMARY KEY`: Định danh duy nhất cho mỗi bản ghi
   - `FOREIGN KEY`: Thiết lập quan hệ giữa các bảng
   - `NOT NULL`: Bắt buộc phải có giá trị
   - `UNIQUE`: Đảm bảo giá trị không trùng lặp
   - `DEFAULT`: Xác định giá trị mặc định
   - `CHECK`: Thêm điều kiện hợp lệ cho giá trị

---

## 🧑‍🏫 Bài 3: Truy vấn dữ liệu

- Truy vấn cơ bản với `SELECT`
- Lọc dữ liệu với `WHERE`
- Sắp xếp kết quả với `ORDER BY`
- Giới hạn kết quả với `LIMIT`/`TOP`

1. **Truy vấn cơ bản với SELECT:**

   ```sql
   -- Lấy tất cả dữ liệu từ bảng Students
   SELECT * FROM Students;

   -- Lấy các cột cụ thể
   SELECT first_name, last_name, email FROM Students;

   -- Đổi tên cột khi hiển thị kết quả
   SELECT
       first_name AS 'Tên',
       last_name AS 'Họ',
       date_of_birth AS 'Ngày sinh'
   FROM Students;

   -- Kết hợp các cột
   SELECT
       CONCAT(first_name, ' ', last_name) AS 'Họ và tên',
       email
   FROM Students;
   ```

2. **Lọc dữ liệu với WHERE:**

   ```sql
   -- Lọc theo điều kiện
   SELECT * FROM Students WHERE gender = 'F';

   -- Nhiều điều kiện với AND và OR
   SELECT * FROM Students
   WHERE gender = 'M' AND is_active = TRUE;

   SELECT * FROM Students
   WHERE gender = 'F' OR date_of_birth > '2000-01-01';

   -- Kiểm tra giá trị NULL
   SELECT * FROM Students WHERE email IS NULL;
   SELECT * FROM Students WHERE email IS NOT NULL;

   -- Tìm kiếm với LIKE
   SELECT * FROM Students WHERE last_name LIKE 'Nguy%'; -- Bắt đầu bằng "Nguy"
   SELECT * FROM Students WHERE email LIKE '%@gmail.com'; -- Kết thúc bằng "@gmail.com"
   SELECT * FROM Students WHERE first_name LIKE '_an'; -- Có 3 ký tự, kết thúc bằng "an"

   -- Kiểm tra giá trị trong tập hợp
   SELECT * FROM Courses WHERE department IN ('IT', 'Math', 'Physics');

   -- Kiểm tra giá trị trong khoảng
   SELECT * FROM Enrollments WHERE grade BETWEEN 8.0 AND 10.0;
   ```

3. **Sắp xếp kết quả với ORDER BY:**

   ```sql
   -- Sắp xếp tăng dần theo họ
   SELECT * FROM Students ORDER BY last_name ASC;

   -- Sắp xếp giảm dần theo ngày sinh
   SELECT * FROM Students ORDER BY date_of_birth DESC;

   -- Sắp xếp theo nhiều cột
   SELECT * FROM Students ORDER BY gender, last_name, first_name;

   -- Sắp xếp kết hợp tăng/giảm dần
   SELECT * FROM Enrollments ORDER BY course_id ASC, grade DESC;
   ```

4. **Giới hạn kết quả với LIMIT (MySQL, PostgreSQL) hoặc TOP (SQL Server):**

   ```sql
   -- MySQL/PostgreSQL: Lấy 5 học sinh đầu tiên
   SELECT * FROM Students LIMIT 5;

   -- MySQL/PostgreSQL: Lấy 5 học sinh từ vị trí thứ 10
   SELECT * FROM Students LIMIT 5 OFFSET 10;

   -- SQL Server: Lấy 5 học sinh đầu tiên
   SELECT TOP 5 * FROM Students;

   -- Kết hợp ORDER BY và LIMIT để lấy top 3 điểm cao nhất
   SELECT * FROM Enrollments ORDER BY grade DESC LIMIT 3;
   ```

---

## 🧑‍🏫 Bài 4: Thao tác dữ liệu

- Thêm dữ liệu với `INSERT INTO`
- Cập nhật dữ liệu với `UPDATE`
- Xóa dữ liệu với `DELETE`
- Thay đổi cấu trúc bảng với `ALTER TABLE`

1. **Thêm dữ liệu với INSERT INTO:**

   ```sql
   -- Thêm một bản ghi
   INSERT INTO Students (first_name, last_name, email, date_of_birth, gender)
   VALUES ('Văn', 'Nguyễn', 'van.nguyen@example.com', '2000-05-15', 'M');

   -- Thêm nhiều bản ghi
   INSERT INTO Students (first_name, last_name, email, date_of_birth, gender)
   VALUES
       ('Thị', 'Lê', 'thi.le@example.com', '2001-03-21', 'F'),
       ('Minh', 'Trần', 'minh.tran@example.com', '1999-11-08', 'M'),
       ('Hoa', 'Phạm', 'hoa.pham@example.com', '2002-07-30', 'F');

   -- Thêm dữ liệu từ một bảng khác (sao chép dữ liệu)
   INSERT INTO ArchivedStudents (student_id, first_name, last_name, email)
   SELECT student_id, first_name, last_name, email
   FROM Students
   WHERE admission_date < '2022-01-01';
   ```

2. **Cập nhật dữ liệu với UPDATE:**

   ```sql
   -- Cập nhật một cột cho tất cả bản ghi
   UPDATE Students SET is_active = TRUE;

   -- Cập nhật một bản ghi cụ thể
   UPDATE Students SET email = 'new.email@example.com'
   WHERE student_id = 5;

   -- Cập nhật nhiều cột
   UPDATE Students
   SET
       first_name = 'Thành',
       last_name = 'Hoàng',
       is_active = FALSE
   WHERE student_id = 10;

   -- Cập nhật dựa trên điều kiện phức tạp
   UPDATE Enrollments
   SET grade = grade + 0.5
   WHERE grade < 5.0 AND course_id IN (SELECT course_id FROM Courses WHERE department = 'Math');

   -- Lưu ý: Luôn cẩn thận khi UPDATE không có WHERE (sẽ cập nhật tất cả bản ghi)
   ```

3. **Xóa dữ liệu với DELETE:**

   ```sql
   -- Xóa một bản ghi cụ thể
   DELETE FROM Students WHERE student_id = 15;

   -- Xóa nhiều bản ghi theo điều kiện
   DELETE FROM Students WHERE is_active = FALSE;

   -- Xóa dữ liệu dựa trên subquery
   DELETE FROM Enrollments
   WHERE student_id IN (SELECT student_id FROM Students WHERE is_active = FALSE);

   -- Xóa tất cả dữ liệu trong bảng (THẬN TRỌNG!)
   DELETE FROM Enrollments;

   -- Hoặc nhanh hơn (reset cả auto-increment)
   TRUNCATE TABLE Enrollments;
   ```

4. **Thay đổi cấu trúc bảng với ALTER TABLE:**

   ```sql
   -- Thêm cột mới
   ALTER TABLE Students ADD COLUMN phone VARCHAR(20);

   -- Thêm cột với giá trị mặc định
   ALTER TABLE Students ADD COLUMN nationality VARCHAR(50) DEFAULT 'Vietnam';

   -- Đổi tên cột
   ALTER TABLE Students CHANGE first_name given_name VARCHAR(50);
   -- Hoặc (tùy DBMS)
   ALTER TABLE Students RENAME COLUMN first_name TO given_name;

   -- Thay đổi kiểu dữ liệu của cột
   ALTER TABLE Students MODIFY email VARCHAR(150);

   -- Xóa cột
   ALTER TABLE Students DROP COLUMN phone;

   -- Thêm khóa chính (nếu chưa có)
   ALTER TABLE Students ADD PRIMARY KEY (student_id);

   -- Thêm khóa ngoại
   ALTER TABLE Enrollments ADD CONSTRAINT fk_student
   FOREIGN KEY (student_id) REFERENCES Students(student_id);

   -- Xóa khóa ngoại
   ALTER TABLE Enrollments DROP FOREIGN KEY fk_student;

   -- Đổi tên bảng
   ALTER TABLE Students RENAME TO StudentRecords;
   ```

---

## 🧑‍🏫 Bài 5: Kết hợp dữ liệu

- Kết hợp bảng với `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`
- Nhóm dữ liệu với `GROUP BY`
- Hàm tổng hợp: `COUNT`, `SUM`, `AVG`, `MAX`, `MIN`
- Lọc nhóm dữ liệu với `HAVING`

1. **Kết hợp bảng với JOIN:**

   ```sql
   -- INNER JOIN: chỉ lấy dữ liệu khớp ở cả hai bảng
   SELECT
       s.student_id,
       CONCAT(s.first_name, ' ', s.last_name) AS student_name,
       c.course_name,
       e.grade
   FROM Students s
   INNER JOIN Enrollments e ON s.student_id = e.student_id
   INNER JOIN Courses c ON e.course_id = c.course_id;

   -- LEFT JOIN: lấy tất cả dữ liệu từ bảng bên trái, và dữ liệu khớp từ bảng bên phải
   SELECT
       s.student_id,
       CONCAT(s.first_name, ' ', s.last_name) AS student_name,
       COUNT(e.enrollment_id) AS enrolled_courses
   FROM Students s
   LEFT JOIN Enrollments e ON s.student_id = e.student_id
   GROUP BY s.student_id, student_name;

   -- RIGHT JOIN: lấy tất cả dữ liệu từ bảng bên phải, và dữ liệu khớp từ bảng bên trái
   SELECT
       c.course_id,
       c.course_name,
       COUNT(e.enrollment_id) AS student_count
   FROM Enrollments e
   RIGHT JOIN Courses c ON e.course_id = c.course_id
   GROUP BY c.course_id, c.course_name;

   -- FULL JOIN (không hỗ trợ trực tiếp trong MySQL)
   -- PostgreSQL:
   SELECT s.student_id, c.course_id
   FROM Students s
   FULL JOIN Enrollments e ON s.student_id = e.student_id
   FULL JOIN Courses c ON e.course_id = c.course_id;

   -- Thay thế FULL JOIN trong MySQL
   SELECT s.student_id, c.course_id
   FROM Students s
   LEFT JOIN Enrollments e ON s.student_id = e.student_id
   LEFT JOIN Courses c ON e.course_id = c.course_id
   UNION
   SELECT s.student_id, c.course_id
   FROM Students s
   RIGHT JOIN Enrollments e ON s.student_id = e.student_id
   RIGHT JOIN Courses c ON e.course_id = c.course_id;
   ```

2. **Nhóm dữ liệu với GROUP BY:**

   ```sql
   -- Đếm số sinh viên theo giới tính
   SELECT
       gender,
       COUNT(*) AS student_count
   FROM Students
   GROUP BY gender;

   -- Tính điểm trung bình của mỗi môn học
   SELECT
       c.course_id,
       c.course_name,
       AVG(e.grade) AS average_grade
   FROM Courses c
   JOIN Enrollments e ON c.course_id = e.course_id
   GROUP BY c.course_id, c.course_name;

   -- Nhóm theo nhiều cột
   SELECT
       c.department,
       s.gender,
       COUNT(*) AS enrollment_count
   FROM Courses c
   JOIN Enrollments e ON c.course_id = e.course_id
   JOIN Students s ON e.student_id = s.student_id
   GROUP BY c.department, s.gender;
   ```

3. **Hàm tổng hợp:**

   ```sql
   -- COUNT: đếm số lượng bản ghi
   SELECT COUNT(*) AS total_students FROM Students;
   SELECT COUNT(email) AS students_with_email FROM Students; -- Không đếm NULL

   -- SUM: tính tổng
   SELECT SUM(credits) AS total_credits FROM Courses;

   -- AVG: tính trung bình
   SELECT AVG(grade) AS average_grade FROM Enrollments;

   -- MAX, MIN: tìm giá trị lớn nhất, nhỏ nhất
   SELECT
       MAX(grade) AS highest_grade,
       MIN(grade) AS lowest_grade
   FROM Enrollments;

   -- Kết hợp nhiều hàm tổng hợp
   SELECT
       COUNT(*) AS enrollment_count,
       AVG(grade) AS average_grade,
       MAX(grade) AS highest_grade,
       MIN(grade) AS lowest_grade,
       SUM(grade) / COUNT(*) AS calculated_average
   FROM Enrollments;
   ```

4. **Lọc nhóm dữ liệu với HAVING:**

   ```sql
   -- Tìm các khóa học có hơn 10 học sinh đăng ký
   SELECT
       c.course_id,
       c.course_name,
       COUNT(e.student_id) AS student_count
   FROM Courses c
   JOIN Enrollments e ON c.course_id = e.course_id
   GROUP BY c.course_id, c.course_name
   HAVING student_count > 10;

   -- Tìm học sinh có điểm trung bình trên 8.0
   SELECT
       s.student_id,
       CONCAT(s.first_name, ' ', s.last_name) AS student_name,
       AVG(e.grade) AS average_grade
   FROM Students s
   JOIN Enrollments e ON s.student_id = e.student_id
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
   FROM Courses c
   WHERE credits > 2 -- Lọc trước khi nhóm
   GROUP BY c.department
   HAVING average_credits > 3 -- Lọc sau khi nhóm
   ORDER BY course_count DESC;
   ```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

## **Đề bài: Quản lý sinh viên**

Xây dựng cơ sở dữ liệu để lưu trữ và quản lý điểm sinh viên:

- Tạo cơ sở dữ liệu `StudentManagement`
- Thiết kế bảng `Students` với các trường:
  - `student_id` (khóa chính)
  - `full_name`
  - `math_score`
  - `physics_score`
  - `chemistry_score`
  - `average_score` (có thể tính toán)
  - `rank` (xếp loại học lực)

Yêu cầu:

- Viết lệnh SQL để tạo cơ sở dữ liệu và bảng
- Thêm dữ liệu mẫu cho 5 sinh viên
- Viết truy vấn tính điểm trung bình cho mỗi sinh viên
- Viết truy vấn cập nhật xếp loại học lực dựa trên điểm trung bình:
  - TB >= 8.0 → Giỏi
  - 6.5 <= TB < 8.0 → Khá
  - 5.0 <= TB < 6.5 → Trung bình
  - < 5.0 → Yếu
- Hiển thị danh sách sinh viên kèm điểm trung bình và xếp loại

### **Kết quả chạy chương trình (Ví dụ):**

```text
+------------+---------------+------------+---------------+----------------+---------------+-------------+
| student_id | full_name     | math_score | physics_score | chemistry_score | average_score | rank       |
+------------+---------------+------------+---------------+----------------+---------------+-------------+
|          4 | Phạm Thị D    |        9.0 |           8.5 |            8.0 |          8.50 | Giỏi       |
|          1 | Nguyễn Văn A  |        8.5 |           7.5 |            9.0 |          8.33 | Giỏi       |
|          2 | Trần Thị B    |        6.5 |           7.0 |            8.0 |          7.17 | Khá        |
|          3 | Lê Văn C      |        5.0 |           6.0 |            7.0 |          6.00 | Trung bình |
|          5 | Hoàng Văn E   |        4.0 |           5.0 |            4.5 |          4.50 | Yếu        |
+------------+---------------+------------+---------------+----------------+---------------+-------------+
```

### **Nâng cao: tạo stored procedure để tự động cập nhật điểm trung bình và xếp loại**

---

[⬅️ Trở lại: JAVA/Part5.md](JAVA/Part5.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: SQL/Part2.md](SQL/Part2.md)
