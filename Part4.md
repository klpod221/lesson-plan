## 📘 PHẦN 4: XỬ LÝ NGOẠI LỆ, FILE I/O VÀ COLLECTIONS

### 🎯 Mục tiêu tổng quát

- Hiểu và xử lý lỗi bằng cách sử dụng cơ chế ngoại lệ trong Java.
- Đọc ghi dữ liệu vào file văn bản.
- Làm việc với các cấu trúc dữ liệu động trong Java: List, Set, Map.

---

### 🧑‍🏫 Bài 1: Xử lý ngoại lệ (Exception Handling)

- Khái niệm ngoại lệ và sự khác biệt giữa lỗi (error) và ngoại lệ (exception).
- Cơ chế xử lý: `try - catch - finally`.
- Từ khóa `throw` và `throws`.
- Tạo và ném ngoại lệ tùy chỉnh (custom exception).

---

### 🧑‍🏫 Bài 2: Đọc ghi file văn bản

- Làm việc với các lớp `File`, `FileReader`, `BufferedReader`, `FileWriter`, `BufferedWriter`.
- Đọc dữ liệu từ file dòng theo dòng.
- Ghi dữ liệu vào file, ghi đè và ghi nối tiếp.
- Xử lý các lỗi thường gặp khi thao tác file.

---

### 🧑‍🏫 Bài 3: Giới thiệu Collections Framework

- Tổng quan về Collections Framework trong Java.
- Sự khác biệt giữa Collection và Map.
- Tầm quan trọng của collections trong xử lý dữ liệu lớn và linh hoạt.

---

### 🧑‍🏫 Bài 4: List, Set và Map

- `ArrayList`, `LinkedList`: cách sử dụng và khi nào dùng.
- `HashSet`, `TreeSet`: tập hợp không trùng lặp, sắp xếp.
- `HashMap`, `TreeMap`: lưu trữ dữ liệu dưới dạng key-value.
- Các thao tác cơ bản: thêm, xóa, duyệt, tìm kiếm, cập nhật.

---

### 🧑‍🏫 Bài 5: Kết hợp File và Collections

- Đọc dữ liệu từ file vào các collection.
- Lưu dữ liệu từ collection ra file.
- Ứng dụng xử lý dữ liệu lớn, tự động hóa lưu trữ và truy xuất dữ liệu.

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Hệ thống quản lý khóa học**

Viết chương trình quản lý danh sách khóa học:

- Mỗi khóa học có mã, tên, giảng viên, và số lượng sinh viên đăng ký.
- Cho phép người dùng:
  - Thêm, sửa, xóa khóa học.
  - Lưu và tải danh sách từ file.
  - Tìm kiếm khóa học theo mã hoặc tên.
  - In danh sách khóa học theo tên giảng viên.

Yêu cầu:

- Sử dụng `ArrayList` hoặc `HashMap` để lưu danh sách khóa học.
- Lưu trữ dữ liệu vào file và nạp lại khi khởi động chương trình.
- Xử lý các trường hợp lỗi như trùng mã khóa học, file không tồn tại,...
