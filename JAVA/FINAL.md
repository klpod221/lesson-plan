# 🧪 BÀI TẬP LỚN (JAVA)

## **Đề bài: Xây dựng ứng dụng Quản lý Thư viện**

Thiết kế và triển khai ứng dụng Java console hoàn chỉnh cho hệ thống quản lý thư viện, tích hợp với cơ sở dữ liệu SQL đã thiết kế trong phần SQL:

### Yêu cầu ứng dụng

- Ứng dụng dòng lệnh (console-based application)
- Kết nối cơ sở dữ liệu thông qua JDBC
- Áp dụng các nguyên lý OOP đã học trong Part 3
- Sử dụng Collections Framework để quản lý dữ liệu
- Xử lý ngoại lệ để đảm bảo tính ổn định của chương trình

### Chức năng cần triển khai

1. **Quản lý sách**:
   - Thêm, sửa, xóa thông tin sách
   - Tìm kiếm sách theo nhiều tiêu chí (tên, tác giả, thể loại)
   - Hiển thị thông tin chi tiết sách
   - Hiển thị danh sách sách

2. **Quản lý độc giả**:
   - Đăng ký độc giả mới
   - Cập nhật thông tin độc giả
   - Tìm kiếm độc giả theo mã hoặc tên
   - Hiển thị lịch sử mượn sách của độc giả

3. **Quản lý mượn trả**:
   - Xử lý mượn sách
   - Xử lý trả sách
   - Tính tiền phạt nếu trả muộn
   - Hiển thị danh sách sách đang được mượn

4. **Báo cáo và thống kê**:
   - Thống kê sách mượn nhiều nhất
   - Thống kê độc giả mượn sách thường xuyên
   - Thống kê sách quá hạn chưa trả
   - Xuất báo cáo dưới dạng file văn bản

### Yêu cầu kỹ thuật

1. **Kiến trúc phần mềm**:
   - Áp dụng mô hình phân tầng (3-tier architecture)
   - Sử dụng các nguyên tắc SOLID
   - Thiết kế các lớp đối tượng tuân theo nguyên tắc OOP

2. **Tương tác CSDL**:
   - Sử dụng JDBC để kết nối với cơ sở dữ liệu SQL đã thiết kế
   - Xử lý transaction khi thực hiện các thao tác quan trọng
   - Sử dụng PreparedStatement để ngăn SQL Injection

3. **Xử lý dữ liệu**:
   - Sử dụng Collections Framework (List, Set, Map) để quản lý dữ liệu trong bộ nhớ
   - Xử lý luồng với I/O Streams để đọc/ghi file khi cần
   - Sử dụng đa luồng để xử lý các tác vụ độc lập như sao lưu dữ liệu

4. **Giao diện console**:
   - Thiết kế menu điều hướng rõ ràng, dễ sử dụng
   - Hiển thị thông tin được định dạng đẹp mắt
   - Xử lý nhập liệu từ người dùng với kiểm tra hợp lệ

5. **Xử lý ngoại lệ**:
   - Xử lý tất cả các ngoại lệ có thể xảy ra
   - Hiển thị thông báo lỗi thân thiện với người dùng
   - Đảm bảo tính ổn định của ứng dụng khi có lỗi xảy ra

### Hướng dẫn triển khai

1. **Thiết kế cơ sở dữ liệu**:
   - Sử dụng cơ sở dữ liệu đã thiết kế trong phần SQL/FINAL.md
   - Tạo kết nối JDBC đến cơ sở dữ liệu

2. **Thiết kế các lớp đối tượng**:
   - Xây dựng các lớp Entity: Book, User, Transaction
   - Xây dựng các lớp DAO (Data Access Object) để thao tác với CSDL
   - Xây dựng các lớp Service xử lý logic nghiệp vụ

3. **Xây dựng giao diện console**:
   - Thiết kế menu chính và các menu con
   - Xử lý nhập liệu và hiển thị kết quả

4. **Kiểm thử**:
   - Kiểm thử các chức năng chính
   - Xử lý các trường hợp ngoại lệ

Bài tập này sẽ kết hợp với bài tập SQL để tạo thành một ứng dụng hoàn chỉnh, trong đó phần JAVA sẽ tạo logic nghiệp vụ và giao diện dòng lệnh, còn phần SQL sẽ đảm nhiệm việc lưu trữ và xử lý dữ liệu.

---

[⬅️ Trở lại: JAVA/Part4.md](../JAVA/Part4.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: SQL/FINAL.md](../SQL/FINAL.md)
