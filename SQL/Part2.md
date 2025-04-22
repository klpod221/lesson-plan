# 📘 PHẦN 2: SQL NÂNG CAO

## Nội dung

- [📘 PHẦN 2: SQL NÂNG CAO](#-phần-2-sql-nâng-cao)
  - [Nội dung](#nội-dung)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Truy vấn nâng cao](#-bài-1-truy-vấn-nâng-cao)
  - [🧑‍🏫 Bài 2: Hàm và thủ tục lưu trữ](#-bài-2-hàm-và-thủ-tục-lưu-trữ)
  - [🧑‍🏫 Bài 3: Tối ưu hóa truy vấn](#-bài-3-tối-ưu-hóa-truy-vấn)
  - [🧑‍🏫 Bài 4: Thiết kế cơ sở dữ liệu](#-bài-4-thiết-kế-cơ-sở-dữ-liệu)
  - [🧑‍🏫 Bài 5: Bảo mật và quản trị](#-bài-5-bảo-mật-và-quản-trị)
    - [Quản lý người dùng và phân quyền](#quản-lý-người-dùng-và-phân-quyền)
    - [Backup và phục hồi dữ liệu](#backup-và-phục-hồi-dữ-liệu)
    - [Bảo mật và phòng chống SQL Injection](#bảo-mật-và-phòng-chống-sql-injection)
    - [Giám sát và điều chỉnh hệ thống](#giám-sát-và-điều-chỉnh-hệ-thống)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN](#-bài-tập-lớn-cuối-phần)
    - [**Đề bài: Quản lý sinh viên và lớp học**](#đề-bài-quản-lý-sinh-viên-và-lớp-học)

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

---

## 🧑‍🏫 Bài 2: Hàm và thủ tục lưu trữ

- Tạo và sử dụng hàm người dùng
- Thủ tục lưu trữ (Stored Procedures)
- Triggers và sự kiện
- Giao dịch và xử lý lỗi

---

## 🧑‍🏫 Bài 3: Tối ưu hóa truy vấn

- Chỉ mục (Indexes) và cách hoạt động
- Phân tích kế hoạch thực thi truy vấn
- Kỹ thuật tối ưu câu lệnh SQL
- Theo dõi và đánh giá hiệu suất

---

## 🧑‍🏫 Bài 4: Thiết kế cơ sở dữ liệu

- Chuẩn hóa và phi chuẩn hóa
- Mô hình dữ liệu: khái niệm và ứng dụng
- Ràng buộc toàn vẹn và quan hệ
- Thiết kế hướng hiệu suất

---

## 🧑‍🏫 Bài 5: Bảo mật và quản trị

### Quản lý người dùng và phân quyền

- **Tạo người dùng**:

  ```sql
  CREATE USER 'student_user'@'localhost' IDENTIFIED BY 'secure_password';
  ```

- **Cấp quyền cụ thể**:

  ```sql
  -- Cấp quyền SELECT cho một bảng cụ thể
  GRANT SELECT ON SchoolManagement.Students TO 'student_user'@'localhost';

  -- Cấp nhiều loại quyền
  GRANT SELECT, INSERT, UPDATE ON SchoolManagement.* TO 'teacher_user'@'localhost';

  -- Cấp tất cả quyền (chỉ nên cấp cho admin)
  GRANT ALL PRIVILEGES ON SchoolManagement.* TO 'admin_user'@'localhost';
  ```

- **Thu hồi quyền**:

  ```sql
  REVOKE INSERT, UPDATE ON SchoolManagement.Students FROM 'student_user'@'localhost';
  ```

- **Xem quyền của người dùng**:

  ```sql
  SHOW GRANTS FOR 'student_user'@'localhost';
  ```

### Backup và phục hồi dữ liệu

- **Backup cơ sở dữ liệu**:

  ```bash
  # Sử dụng mysqldump để tạo backup
  mysqldump -u root -p SchoolManagement > school_backup.sql

  # Backup chỉ cấu trúc bảng (không có dữ liệu)
  mysqldump -u root -p --no-data SchoolManagement > schema_backup.sql

  # Backup chỉ một số bảng cụ thể
  mysqldump -u root -p SchoolManagement Students Courses > tables_backup.sql
  ```

- **Phục hồi dữ liệu**:

  ```bash
  # Phục hồi từ file backup
  mysql -u root -p SchoolManagement < school_backup.sql

  # Thực hiện từ trong MySQL client
  SOURCE /path/to/school_backup.sql;
  ```

- **Lập lịch backup tự động** (Linux crontab):

  ```bash
  # Backup hàng ngày lúc 01:00 sáng
  0 1 * * * mysqldump -u root -p'password' SchoolManagement > /backup/school_$(date +\%Y\%m\%d).sql
  ```

### Bảo mật và phòng chống SQL Injection

- **Vấn đề SQL Injection**:

  ```sql
  -- Ví dụ nguy hiểm (KHÔNG NÊN LÀM):
  $username = $_POST['username'];
  $query = "SELECT * FROM Users WHERE username = '$username'";
  // Nếu người dùng nhập: admin' --
  // Câu truy vấn trở thành: SELECT * FROM Users WHERE username = 'admin' --'
  ```

- **Cách phòng tránh SQL Injection**:

  1. **Sử dụng Prepared Statements**:

     ```php
     // PHP với PDO
     $stmt = $pdo->prepare("SELECT * FROM Users WHERE username = ?");
     $stmt->execute([$username]);

     // Java với JDBC
     PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Users WHERE username = ?");
     stmt->setString(1, username);
     ```

  2. **Kiểm tra và làm sạch dữ liệu đầu vào**:

     ```php
     $username = mysqli_real_escape_string($conn, $_POST['username']);
     ```

  3. **Sử dụng ORM (Object-Relational Mapping)**:

     ```java
     // Sử dụng Hibernate trong Java
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

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Quản lý sinh viên và lớp học**

Mở rộng cơ sở dữ liệu quản lý sinh viên:

- Tạo thêm bảng `Classes` để lưu thông tin về các lớp học
- Tạo mối quan hệ một-nhiều giữa `Classes` và `Students`
- Thêm bảng `Subjects` để lưu thông tin môn học

Yêu cầu:

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
