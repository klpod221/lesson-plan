## 📘 PHẦN 5: LUỒNG, ĐA LUỒNG VÀ JDBC

### 🎯 Mục tiêu tổng quát

- Hiểu cách xử lý nhập/xuất dữ liệu bằng luồng (Streams).
- Làm quen với lập trình đa luồng (Multithreading).
- Kết nối và thao tác dữ liệu với cơ sở dữ liệu sử dụng JDBC.

---

### 🧑‍🏫 Bài 1: Java I/O Streams

- Khái niệm luồng trong Java: `InputStream`, `OutputStream`, `Reader`, `Writer`.
- Phân biệt luồng nhị phân và luồng ký tự.
- Các lớp thường dùng: `FileInputStream`, `FileOutputStream`, `BufferedReader`, `BufferedWriter`.
- Đọc và ghi file bằng stream với xử lý ngoại lệ.

---

### 🧑‍🏫 Bài 2: Đa luồng trong Java

- Khái niệm Thread và lợi ích của đa luồng.
- Tạo thread bằng kế thừa `Thread` hoặc triển khai `Runnable`.
- Quản lý luồng bằng `start()`, `join()`, `sleep()`.
- Vấn đề đồng bộ (synchronization), sử dụng từ khóa `synchronized`.

---

### 🧑‍🏫 Bài 3: Lập trình đồng thời (Concurrency)

- Quản lý thread nâng cao với `ExecutorService`.
- Giới thiệu `Callable`, `Future`.
- Đồng bộ dữ liệu trong môi trường đa luồng.
- Ứng dụng thực tế: tải song song dữ liệu, xử lý đa nhiệm.

---

### 🧑‍🏫 Bài 4: Kết nối cơ sở dữ liệu với JDBC

- Tổng quan về JDBC và các bước kết nối:
  1. Tải driver JDBC.
  2. Tạo kết nối (`Connection`).
  3. Thực thi truy vấn (`Statement`, `PreparedStatement`).
  4. Đọc kết quả (`ResultSet`).
- Kết nối với MySQL (hoặc SQLite).
- Cách dùng `try-with-resources` khi làm việc với JDBC.

---

### 🧑‍🏫 Bài 5: Thao tác CRUD với JDBC

- Tạo bảng và thêm dữ liệu từ Java.
- Truy vấn dữ liệu và hiển thị kết quả.
- Cập nhật và xóa dữ liệu với `PreparedStatement`.
- Xử lý lỗi và đóng kết nối đúng cách.

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Hệ thống quản lý sinh viên với cơ sở dữ liệu**

Xây dựng ứng dụng Java với các chức năng:

- Kết nối đến cơ sở dữ liệu (MySQL hoặc SQLite).
- Cho phép:
  - Thêm sinh viên (mã, tên, ngày sinh, email).
  - Xem danh sách sinh viên.
  - Sửa, xóa sinh viên.
  - Tìm sinh viên theo tên hoặc mã.
- Giao diện dòng lệnh, menu tùy chọn.

Yêu cầu:

- Sử dụng JDBC để thao tác dữ liệu.
- Xử lý đa luồng khi đọc/ghi dữ liệu từ/đến file backup song song với thao tác người dùng.
- Đảm bảo dữ liệu không bị xung đột khi có nhiều thao tác đồng thời.
