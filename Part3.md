## 📘 PHẦN 3: LẬP TRÌNH HƯỚNG ĐỐI TƯỢNG (OOP)

### 🎯 Mục tiêu tổng quát

- Hiểu và áp dụng các nguyên lý của lập trình hướng đối tượng trong Java.
- Làm việc với các lớp, đối tượng, kế thừa, đóng gói, và đa hình.

---

### 🧑‍🏫 Bài 1: Lớp và Đối tượng

- Khái niệm lớp (class) và đối tượng (object).
- Cách khai báo lớp và tạo đối tượng.
- Phương thức khởi tạo (constructor) và cách sử dụng chúng để tạo đối tượng.
- Cách sử dụng phương thức trong lớp.

---

### 🧑‍🏫 Bài 2: Kế thừa

- Khái niệm kế thừa (inheritance) và tại sao nó quan trọng trong OOP.
- Cách sử dụng từ khóa `extends` để kế thừa lớp.
- Kế thừa các phương thức và thuộc tính của lớp cha.
- Sử dụng từ khóa `super` để truy cập các thành phần của lớp cha.
- Kế thừa và ghi đè phương thức (method overriding).

---

### 🧑‍🏫 Bài 3: Đóng gói (Encapsulation)

- Khái niệm đóng gói và tại sao nó quan trọng.
- Quy tắc sử dụng `private`, `protected`, và `public` để hạn chế quyền truy cập.
- Getter và Setter để truy cập và thay đổi thuộc tính của đối tượng.
- Đảm bảo tính an toàn và kiểm tra dữ liệu trong quá trình thay đổi trạng thái đối tượng.

---

### 🧑‍🏫 Bài 4: Đa hình (Polymorphism)

- Khái niệm đa hình và tại sao nó hữu ích.
- Đa hình thời gian biên dịch (method overloading) và đa hình thời gian chạy (method overriding).
- Sử dụng interface và abstract class để thực hiện đa hình.
- Các phương thức trừu tượng (abstract methods) và cách sử dụng lớp trừu tượng (abstract class).

---

### 🧑‍🏫 Bài 5: Interface và Abstract Class

- Sự khác biệt giữa Interface và Abstract Class.
- Khi nào sử dụng Interface, khi nào sử dụng Abstract Class.
- Tạo và triển khai Interface.
- Tạo và kế thừa Abstract Class.
- Đặc điểm và ứng dụng thực tế của Interface và Abstract Class.

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Quản lý sinh viên, giảng viên và khóa học**

Viết chương trình:

- Tạo lớp `Person` với các thuộc tính chung như tên, tuổi.
- Tạo lớp `Student` và `Teacher` kế thừa từ lớp `Person` với các đặc điểm riêng.
- Tạo lớp `Course` để quản lý các khóa học.
- Mỗi `Student` và `Teacher` có thể tham gia vào nhiều khóa học.
- Cung cấp phương thức để đăng ký, hủy đăng ký khóa học.

Các chức năng cần có:

- Lớp `Person` với các thuộc tính cơ bản (tên, tuổi).
- Lớp `Student` và `Teacher` kế thừa từ `Person`, với phương thức đặc thù.
- Lớp `Course` quản lý các thông tin khóa học và người tham gia.
- Phương thức đăng ký và hủy khóa học trong lớp `Student`.
