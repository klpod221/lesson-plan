## 📘 PHẦN 2: SQL NÂNG CAO

### 🎯 Mục tiêu tổng quát

- Hiểu và sử dụng được các kỹ thuật truy vấn phức tạp
- Tối ưu hiệu suất truy vấn và thiết kế cơ sở dữ liệu
- Biết cách xử lý dữ liệu lớn và đảm bảo an toàn

---

### 🧑‍🏫 Bài 1: Truy vấn nâng cao

- Truy vấn con (Subquery)
- Common Table Expressions (CTE) với `WITH`
- Toán tử tập hợp: `UNION`, `INTERSECT`, `EXCEPT`
- Window Functions: `OVER`, `PARTITION BY`, `ROW_NUMBER`

---

### 🧑‍🏫 Bài 2: Hàm và thủ tục lưu trữ

- Tạo và sử dụng hàm người dùng
- Thủ tục lưu trữ (Stored Procedures)
- Triggers và sự kiện
- Giao dịch và xử lý lỗi

---

### 🧑‍🏫 Bài 3: Tối ưu hóa truy vấn

- Chỉ mục (Indexes) và cách hoạt động
- Phân tích kế hoạch thực thi truy vấn
- Kỹ thuật tối ưu câu lệnh SQL
- Theo dõi và đánh giá hiệu suất

---

### 🧑‍🏫 Bài 4: Thiết kế cơ sở dữ liệu

- Chuẩn hóa và phi chuẩn hóa
- Mô hình dữ liệu: khái niệm và ứng dụng
- Ràng buộc toàn vẹn và quan hệ
- Thiết kế hướng hiệu suất

---

### 🧑‍🏫 Bài 5: Bảo mật và quản trị

- Quản lý người dùng và phân quyền
- Backup và phục hồi dữ liệu
- Bảo mật và phòng chống SQL Injection
- Giám sát và điều chỉnh hệ thống

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
