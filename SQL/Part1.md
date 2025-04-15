[Back to Readme.md](../README.md)

## 📘 PHẦN 1: NHẬP MÔN SQL

### 🎯 Mục tiêu tổng quát

- Làm quen với cú pháp và cách sử dụng ngôn ngữ truy vấn SQL
- Biết cách tạo cơ sở dữ liệu, bảng và thao tác dữ liệu
- Hiểu được các câu lệnh truy vấn và kết hợp dữ liệu

---

### 🧑‍🏫 Bài 1: Giới thiệu về SQL và CSDL

- Khái niệm cơ sở dữ liệu quan hệ
- Các hệ quản trị CSDL phổ biến (MySQL, PostgreSQL, SQL Server)
- Cài đặt và cấu hình môi trường làm việc

---

### 🧑‍🏫 Bài 2: Tạo và quản lý cơ sở dữ liệu

- Lệnh `CREATE DATABASE`, `USE`, `DROP DATABASE`
- Các kiểu dữ liệu cơ bản trong SQL
- Tạo bảng với `CREATE TABLE`
- Ràng buộc: `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `UNIQUE`

---

### 🧑‍🏫 Bài 3: Truy vấn dữ liệu

- Truy vấn cơ bản với `SELECT`
- Lọc dữ liệu với `WHERE`
- Sắp xếp kết quả với `ORDER BY`
- Giới hạn kết quả với `LIMIT`/`TOP`

---

### 🧑‍🏫 Bài 4: Thao tác dữ liệu

- Thêm dữ liệu với `INSERT INTO`
- Cập nhật dữ liệu với `UPDATE`
- Xóa dữ liệu với `DELETE`
- Thay đổi cấu trúc bảng với `ALTER TABLE`

---

### 🧑‍🏫 Bài 5: Kết hợp dữ liệu

- Kết hợp bảng với `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`
- Nhóm dữ liệu với `GROUP BY`
- Hàm tổng hợp: `COUNT`, `SUM`, `AVG`, `MAX`, `MIN`
- Lọc nhóm dữ liệu với `HAVING`

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Quản lý sinh viên**

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
