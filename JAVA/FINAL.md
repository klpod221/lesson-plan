# 🎓 BÀI TẬP TỔNG HỢP CUỐI KHÓA

## **Tên bài: Ứng dụng Quản lý Thư viện**

---

## 📌 Mô tả

Xây dựng một ứng dụng Java quản lý thư viện mini có giao diện dòng lệnh, cho phép quản lý sách, người dùng (độc giả & nhân viên), và các giao dịch mượn/trả sách. Ứng dụng lưu trữ dữ liệu vào cơ sở dữ liệu và hỗ trợ thao tác đồng thời, đọc/ghi file, xử lý ngoại lệ.

---

## 🎯 Yêu cầu chức năng

### 1. **Quản lý người dùng**

- Phân loại 2 loại người dùng: `Reader`, `Staff` kế thừa từ lớp `User`.
- Tạo, sửa, xóa, tìm kiếm người dùng theo mã hoặc tên.
- Mỗi người dùng có thông tin: mã, tên, ngày sinh, email, loại người dùng.

### 2. **Quản lý sách**

- Quản lý danh sách sách bao gồm: mã sách, tiêu đề, tác giả, năm xuất bản, số lượng tồn.
- Thêm, sửa, xóa, tìm kiếm sách.
- Lưu trữ sách trong `ArrayList`, hỗ trợ thao tác đồng thời.

### 3. **Quản lý giao dịch mượn/trả sách**

- Khi `Reader` mượn sách: kiểm tra tồn kho, ghi nhận giao dịch.
- Khi trả sách: cập nhật lại số lượng tồn.
- Lưu lịch sử giao dịch trong database: mã giao dịch, người mượn, sách, ngày mượn, ngày trả, trạng thái.

### 4. **Lưu trữ dữ liệu**

- Dữ liệu người dùng, sách và giao dịch được lưu vào cơ sở dữ liệu (MySQL/SQLite) sử dụng JDBC.
- Đồng thời lưu backup vào file văn bản `.txt` định kỳ (sử dụng `ExecutorService` để ghi song song).

### 5. **Xử lý ngoại lệ**

- Kiểm tra lỗi nhập dữ liệu từ người dùng (ví dụ: mã trùng, không tìm thấy đối tượng...).
- Bắt và xử lý các lỗi kết nối, I/O, và truy vấn SQL.

---

## 🧠 Kiến thức sử dụng

| Chủ đề                        | Ứng dụng trong bài                                      |
| ----------------------------- | ------------------------------------------------------- |
| Biến, kiểu dữ liệu, toán tử   | Xử lý thông tin người dùng và sách                      |
| Câu lệnh điều kiện & vòng lặp | Duyệt danh sách, menu tùy chọn                          |
| Hàm và lớp                    | Tổ chức chương trình thành các class rõ ràng            |
| OOP                           | `User`, `Reader`, `Staff`, `Book`, `Transaction`        |
| Xử lý ngoại lệ                | Bắt lỗi nhập dữ liệu, lỗi khi thao tác với DB và file   |
| Collections                   | Quản lý danh sách sách, người dùng, giao dịch bằng List |
| File I/O                      | Lưu backup dữ liệu ra file văn bản                      |
| Multithreading                | Ghi file song song trong quá trình sử dụng ứng dụng     |
| JDBC                          | CRUD dữ liệu từ cơ sở dữ liệu thực                      |

---

## 🛠 Gợi ý chia module

- `models/`: chứa các class `User`, `Reader`, `Staff`, `Book`, `Transaction`
- `services/`: chứa `BookService`, `UserService`, `TransactionService`, xử lý nghiệp vụ
- `database/`: chứa class `DBConnection`, `BookRepository`, `UserRepository`,...
- `utils/`: chứa `FileManager`, `InputValidator`, `ThreadPoolManager`

---

## 📦 Yêu cầu nâng cao (tuỳ chọn)

- Thêm chức năng tìm kiếm nâng cao (ví dụ: theo khoảng ngày mượn).
- Cho phép xuất dữ liệu thống kê ra file CSV.
