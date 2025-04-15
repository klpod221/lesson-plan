# 🎓 Java và SQL - Lộ Trình Học Tích Hợp

Kho lưu trữ này chứa tài liệu học tập và dự án giúp học lập trình Java và kỹ năng cơ sở dữ liệu SQL từ cơ bản đến nâng cao.

## 📋 Cấu Trúc Kho Lưu Trữ

```
lesson-plan/
├── JAVA/
│   ├── Part1.md   # Nhập môn Java
│   ├── Part2.md   # MẢNG, CHUỖI VÀ HÀM
│   ├── Part3.md   # LẬP TRÌNH HƯỚNG ĐỐI TƯỢNG (OOP)
│   ├── Part4.md   # XỬ LÝ NGOẠI LỆ, FILE I/O VÀ COLLECTIONS
│   ├── Part5.md   # LUỒNG, ĐA LUỒNG VÀ JDBC
│   └── FINAL.md   # Dự án tổng hợp cuối khóa: Quản lý Thư viện
├── SQL/
│   ├── Part1.md   # Nhập môn SQL
│   ├── Part2.md   # SQL NÂNG CAO
│   ├── Part3.md   # SQL NÂNG CAO VÀ ỨNG DỤNG
│   ├── Part4.md   # SQL CHUYÊN SÂU VÀ HIỆU SUẤT
│   └── FINAL.md   # Dự án tổng hợp cuối khóa: Quản lý Thư viện
└── README.md
```

## 📚 Lộ Trình Học

### 1. Nhập môn Java [/JAVA/Part1.md](./JAVA/Part1.md)

- Làm quen với cú pháp và cách tổ chức chương trình Java.
- Biết cách khai báo biến, sử dụng kiểu dữ liệu, câu lệnh điều kiện và vòng lặp.

### 2. Mảng, Chuỗi và Hàm [/JAVA/Part2.md](./JAVA/Part2.md)

- Làm quen với việc sử dụng mảng để lưu trữ và xử lý tập hợp dữ liệu.
- Hiểu và làm việc với chuỗi trong Java.
- Tạo và sử dụng hàm để tách chương trình thành các khối logic độc lập.

### 3. Lập trình hướng đối tượng (OOP) [/JAVA/Part3.md](./JAVA/Part3.md)

- Hiểu và áp dụng các nguyên lý của lập trình hướng đối tượng trong Java.
- Làm việc với các lớp, đối tượng, kế thừa, đóng gói, và đa hình.

### 4. Xử lý ngoại lệ, File I/O và Collections [/JAVA/Part4.md](./JAVA/Part4.md)

- Hiểu và xử lý lỗi bằng cách sử dụng cơ chế ngoại lệ trong Java.
- Đọc ghi dữ liệu vào file văn bản.
- Làm việc với các cấu trúc dữ liệu động trong Java: List, Set, Map.

### 5. NHẬP MÔN SQL [/SQL/Part1.md](./SQL/Part1.md)

- Làm quen với cú pháp và cách sử dụng ngôn ngữ truy vấn SQL
- Biết cách tạo cơ sở dữ liệu, bảng và thao tác dữ liệu
- Hiểu được các câu lệnh truy vấn và kết hợp dữ liệu

### 6. SQL NÂNG CAO [/SQL/Part2.md](./SQL/Part2.md)

- Hiểu và sử dụng được các kỹ thuật truy vấn phức tạp
- Tối ưu hiệu suất truy vấn và thiết kế cơ sở dữ liệu
- Biết cách xử lý dữ liệu lớn và đảm bảo an toàn

### 7. LUỒNG, ĐA LUỒNG VÀ JDBC [/JAVA/Part5.md](./JAVA/Part5.md)

- Hiểu cách xử lý nhập/xuất dữ liệu bằng luồng (Streams).
- Làm quen với lập trình đa luồng (Multithreading).
- Kết nối và thao tác dữ liệu với cơ sở dữ liệu sử dụng JDBC.

### 8. Dự án tổng hợp cuối khóa tích hợp kiến thức Java và SQL để xây dựng hệ thống quản lý thư viện [/JAVA/FINAL.md](./JAVA/FINAL.md) | [/SQL/FINAL.md](./SQL/FINAL.md)

### 9. SQL NÂNG CAO VÀ ỨNG DỤNG [/SQL/Part3.md](./SQL/Part3.md)

- Xây dựng được các chức năng phức tạp với thủ tục lưu trữ
- Hiểu và triển khai được các quy tắc ràng buộc dữ liệu
- Bảo đảm tính toàn vẹn dữ liệu trong môi trường đa người dùng

### 10. SQL CHUYÊN SÂU VÀ HIỆU SUẤT [/SQL/Part4.md](./SQL/Part4.md)

- Tối ưu hóa hiệu suất truy vấn và cấu trúc dữ liệu
- Xử lý dữ liệu lớn một cách hiệu quả
- Triển khai giải pháp dữ liệu phức tạp

## 🎯 Dự Án Tổng Hợp: Ứng Dụng Quản Lý Thư Viện

Dự án cuối khóa tích hợp kiến thức Java và SQL để xây dựng hệ thống quản lý thư viện:

### Chức năng chính

- **Quản lý người dùng**: `Reader`, `Staff` kế thừa từ `User`
- **Quản lý sách**: thêm, sửa, xóa, tìm kiếm
- **Quản lý giao dịch mượn/trả**: theo dõi, cập nhật tồn kho
- **Lưu trữ dữ liệu**: sử dụng JDBC để tương tác với CSDL
- **Backup dữ liệu**: sử dụng multithreading để ghi file song song

## 🚀 Bắt Đầu

1. Clone [repository](https://github.com/klpod221/lesson-plan) về máy tính của bạn.
2. Cài đặt Java Development Kit (JDK) và hệ quản trị cơ sở dữ liệu SQL (MySQL, PostgreSQL, SQLite).
3. Mở IDE (IntelliJ IDEA, Eclipse, NetBeans, VS Code) và import dự án.
4. Thực hiện theo hướng dẫn trong từng phần để hoàn thành bài tập và dự án

## 📝 Yêu Cầu Tiên Quyết

- Đã cài đặt Java Development Kit (JDK)
- Đã cài đặt hệ quản trị cơ sở dữ liệu SQL
- IDE cho phát triển Java (IntelliJ IDEA, Eclipse, NetBeans, VS Code)
