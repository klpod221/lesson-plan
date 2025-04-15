## 📘 PHẦN 4: SQL CHUYÊN SÂU VÀ HIỆU SUẤT

### 🎯 Mục tiêu tổng quát

- Tối ưu hóa hiệu suất truy vấn và cấu trúc dữ liệu
- Xử lý dữ liệu lớn một cách hiệu quả
- Triển khai giải pháp dữ liệu phức tạp

---

### 🧑‍🏫 Bài 1: Tối ưu hiệu suất

- Kế hoạch thực thi truy vấn và cách phân tích
- Chỉ mục nâng cao (Composite, Covering, Filtered)
- Chiến lược phân vùng dữ liệu
- Điều chỉnh cấu hình máy chủ cơ sở dữ liệu

---

### 🧑‍🏫 Bài 2: Xử lý dữ liệu lớn

- Kỹ thuật thao tác với bảng có hàng triệu dòng
- Phân tích dữ liệu với các hàm window nâng cao
- Chiến lược sao lưu và phục hồi dữ liệu lớn
- Truy vấn dữ liệu phân tán

---

### 🧑‍🏫 Bài 3: Thiết kế cơ sở dữ liệu nâng cao

- Mô hình hóa dữ liệu phức tạp
- Thiết kế kiến trúc microservices với cơ sở dữ liệu
- Cơ sở dữ liệu đa hình thái (Polyglot Persistence)
- Cơ sở dữ liệu NoSQL và SQL

---

### 🧑‍🏫 Bài 4: SQL và dữ liệu thực tế

- Xử lý dữ liệu không đồng nhất
- Cleaning và chuyển đổi dữ liệu
- ETL và data warehouse
- Data mining với SQL

---

### 🧑‍🏫 Bài 5: Quản trị và giám sát

- Công cụ giám sát và phân tích
- Xử lý sự cố hiệu suất
- Tự động hóa quản trị cơ sở dữ liệu
- Chiến lược mở rộng và nâng cấp

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Hệ thống quản lý đăng ký môn học**

Xây dựng cơ sở dữ liệu quản lý đăng ký môn học:

- `Students`: thông tin sinh viên
- `Courses`: thông tin khóa học
- `Enrollments`: đăng ký khóa học
- `CourseSchedules`: lịch học

Yêu cầu:

- Thiết kế cơ sở dữ liệu đầy đủ với các ràng buộc
- Tạo các stored procedure để:
  - Đăng ký khóa học (kiểm tra số lượng, đủ điều kiện)
  - Hủy đăng ký
  - Thay đổi lớp
- Triển khai xử lý transaction để đảm bảo tính toàn vẹn dữ liệu khi nhiều sinh viên cùng đăng ký một lớp (giới hạn số lượng)
- Tạo view và function để:
  - Hiển thị thời khóa biểu cho sinh viên
  - Kiểm tra xung đột lịch học khi đăng ký
