# 🧪 BÀI TẬP LỚN (SQL)

## **Đề bài: Xây dựng CSDL cho ứng dụng Quản lý Thư viện**

Thiết kế và triển khai cơ sở dữ liệu hoàn chỉnh cho ứng dụng quản lý thư viện, bao gồm các chức năng như đăng ký người dùng, mượn sách, trả sách, tìm kiếm sách, thống kê mượn sách, và quản lý thông tin sách.

### Mô tả hệ thống

- **Người dùng**: Độc giả và nhân viên thư viện
- **Chức năng chính**:
  - Đăng ký người dùng
  - Đăng nhập
  - Tìm kiếm sách theo nhiều tiêu chí (tên, tác giả, thể loại)
  - Mượn sách
  - Trả sách
  - Thống kê mượn sách theo thời gian
  - Quản lý thông tin sách (thêm, sửa, xóa)
  - Quản lý thông tin người dùng (độc giả và nhân viên)

### Yêu cầu cơ sở dữ liệu

- Bảng `users` với phân loại độc giả/nhân viên
- Bảng `books` với đầy đủ thông tin sách
- Bảng `transactions` lưu giao dịch mượn/trả
- Bảng `categories` để phân loại sách
- Bảng `publishers` thông tin nhà xuất bản

### Chức năng SQL cần triển khai

1. **Stored Procedures**:

   - Đăng ký người dùng mới
   - Thêm sách mới vào hệ thống
   - Xử lý giao dịch mượn sách
   - Xử lý trả sách và phạt quá hạn
   - Tìm kiếm sách nâng cao (theo nhiều tiêu chí)

2. **Triggers**:

   - Cập nhật số lượng sách khi mượn/trả
   - Kiểm tra điều kiện mượn sách (số lượng còn, người dùng không bị khóa)
   - Ghi log các thao tác quan trọng

3. **Views**:

   - Danh sách sách đang được mượn
   - Thông tin chi tiết sách kèm tình trạng
   - Thống kê mượn sách theo độc giả
   - Thống kê sách phổ biến nhất

4. **Tối ưu hóa**:

   - Tạo các index cho các trường thường xuyên tìm kiếm
   - Thiết kế cấu trúc bảng hiệu quả
   - Tối ưu các câu truy vấn phức tạp

5. **Bảo mật**:
   - Phân quyền người dùng (độc giả, nhân viên)
   - Sử dụng view để ẩn thông tin nhạy cảm

---

Sau khi hoàn thành bài tập lớn này, bạn đã nắm vững các khái niệm cơ bản và nâng cao trong SQL, bao gồm việc thiết kế cơ sở dữ liệu, viết các câu truy vấn phức tạp, sử dụng stored procedures, triggers, views và tối ưu hóa hiệu suất.

Sau đây các bạn sẽ quay lại với JAVA để tiếp tục học tập và áp dụng các kiến thức đã học trong SQL vào các ứng dụng thực tế.

---

[⬅️ Trở lại: SQL/Part4.md](../SQL/Part4.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: JAVA/Part5.md](../JAVA/Part5.md)
