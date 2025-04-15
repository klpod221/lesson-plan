# 🧪 BÀI TẬP TỔNG HỢP CUỐI KHÓA

### **Đề bài: Xây dựng CSDL cho ứng dụng Quản lý Thư viện**

Thiết kế và triển khai cơ sở dữ liệu hoàn chỉnh cho ứng dụng quản lý thư viện, tích hợp với ứng dụng Java:

#### Yêu cầu cơ sở dữ liệu

- Bảng `Users` với phân loại độc giả/nhân viên
- Bảng `Books` với đầy đủ thông tin sách
- Bảng `Transactions` lưu giao dịch mượn/trả
- Bảng `Categories` để phân loại sách
- Bảng `Publishers` thông tin nhà xuất bản

#### Chức năng SQL cần triển khai

1. **Stored Procedures**:

   - Đăng ký người dùng mới
   - Thêm sách mới vào hệ thống
   - Xử lý giao dịch mượn sách
   - Xử lý trả sách và tính phí phạt quá hạn
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

5. **Tích hợp với Java**:
   - Viết các câu SQL chuẩn để tích hợp với ứng dụng Java qua JDBC
   - Đảm bảo xử lý transaction an toàn
   - Cung cấp stored procedures cho tất cả chức năng cần thiết

Bài tập này sẽ kết hợp với bài tập Java để tạo thành một ứng dụng hoàn chỉnh, trong đó phần Java sẽ sử dụng cơ sở dữ liệu được thiết kế trong phần SQL.
