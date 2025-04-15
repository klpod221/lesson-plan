## 📘 PHẦN 3: SQL NÂNG CAO VÀ ỨNG DỤNG

### 🎯 Mục tiêu tổng quát

- Xây dựng được các chức năng phức tạp với thủ tục lưu trữ
- Hiểu và triển khai được các quy tắc ràng buộc dữ liệu
- Bảo đảm tính toàn vẹn dữ liệu trong môi trường đa người dùng

---

### 🧑‍🏫 Bài 1: Thủ tục lưu trữ nâng cao

- Tạo và quản lý stored procedure có tham số
- Xử lý lỗi trong stored procedure
- Sử dụng cursor để xử lý dữ liệu theo dòng
- Thủ tục lưu trữ có trả về giá trị

---

### 🧑‍🏫 Bài 2: Trigger và ràng buộc

- Tạo trigger cho các sự kiện INSERT, UPDATE, DELETE
- Trigger BEFORE và AFTER
- Kiểm tra ràng buộc phức tạp
- Sử dụng trigger để duy trì tính toàn vẹn dữ liệu

---

### 🧑‍🏫 Bài 3: Giao dịch và xử lý đồng thời

- Quản lý transaction với COMMIT và ROLLBACK
- Cách xử lý lock và deadlock
- Cấp độ cô lập (Isolation levels)
- Hiệu suất trong môi trường nhiều người dùng

---

### 🧑‍🏫 Bài 4: Bảo mật dữ liệu

- Tạo và quản lý người dùng
- Phân quyền hệ thống và đối tượng
- Mã hóa và bảo mật dữ liệu
- Phòng chống SQL Injection

---

### 🧑‍🏫 Bài 5: SQL và ứng dụng web

- Kết nối cơ sở dữ liệu từ ứng dụng
- Tối ưu truy vấn cho ứng dụng web
- Mô hình ORM và SQL
- Xử lý vấn đề N+1 và hiệu suất

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Quản lý giao dịch mượn sách thư viện**

Xây dựng cơ sở dữ liệu quản lý thư viện với các bảng:

- `Books`: thông tin sách
- `Users`: thông tin người dùng
- `Borrowings`: giao dịch mượn sách

Yêu cầu:

- Thiết kế cấu trúc dữ liệu đầy đủ với các ràng buộc
- Tạo các stored procedure để:
  - Thêm sách mới
  - Đăng ký người dùng
  - Xử lý giao dịch mượn sách (kiểm tra số lượng tồn, ghi nhận ngày mượn)
  - Xử lý trả sách (cập nhật trạng thái, tính phí phạt nếu trễ hạn)
- Tạo các triggers để:
  - Tự động cập nhật số lượng sách khi có giao dịch mượn/trả
  - Kiểm tra điều kiện trước khi cho mượn sách
