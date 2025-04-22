# 📘 PHẦN 1: NHẬP MÔN JAVA

- [📘 PHẦN 1: NHẬP MÔN JAVA](#-phần-1-nhập-môn-java)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Cấu trúc chương trình JAVA](#-bài-1-cấu-trúc-chương-trình-java)
  - [🧑‍🏫 Bài 2: Biến và kiểu dữ liệu](#-bài-2-biến-và-kiểu-dữ-liệu)
  - [🧑‍🏫 Bài 3: Toán tử và biểu thức](#-bài-3-toán-tử-và-biểu-thức)
  - [🧑‍🏫 Bài 4: Câu lệnh điều kiện](#-bài-4-câu-lệnh-điều-kiện)
  - [🧑‍🏫 Bài 5: Câu lệnh lặp](#-bài-5-câu-lệnh-lặp)
  - [🧪 Bài tập lớn cuối phần: Quản lý điểm sinh viên](#-bài-tập-lớn-cuối-phần-quản-lý-điểm-sinh-viên)
    - [Đề bài](#đề-bài)
    - [Kết quả chạy chương trình (Ví dụ)](#kết-quả-chạy-chương-trình-ví-dụ)

## 🎯 Mục tiêu tổng quát

- Làm quen với cú pháp và cách tổ chức chương trình JAVA.
- Biết cách khai báo biến, sử dụng kiểu dữ liệu, câu lệnh điều kiện và vòng lặp.

---

## 🧑‍🏫 Bài 1: Cấu trúc chương trình JAVA

**Tổ chức project JAVA cơ bản:**

- File có đuôi `.java` chứa mã nguồn JAVA
- Mỗi file `.java` chứa ít nhất một class
- Tên file phải trùng với tên class chứa phương thức `main`

**Phương thức main:**

```java
// file HelloWorld.java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```

**Giải thích:**

- `public class HelloWorld`: Định nghĩa một class có tên HelloWorld
- `public static void main(String[] args)`: Phương thức main - điểm bắt đầu của chương trình
- `System.out.println()`: Lệnh in ra màn hình

**Quy ước đặt tên:**

- Class: Viết hoa chữ cái đầu mỗi từ (PascalCase) - `HelloWorld`, `StudentManager`
- Biến và phương thức: Chữ cái đầu viết thường, từ tiếp theo viết hoa (camelCase) - `studentName`, `calculateTotal`
- Hằng số: Viết hoa tất cả, các từ cách nhau bởi dấu gạch dưới - `MAX_SIZE`, `PI_VALUE`

**Chạy chương trình:**

- Sử dụng lệnh `javac` để biên dịch mã nguồn thành bytecode
- Sử dụng lệnh `java` để chạy chương trình

```bash
javac HelloWorld.java  # Biên dịch
java HelloWorld        # Chạy chương trình
```

- Kết quả sẽ là:

```text
Hello, World!
```

**Biên dịch và chạy chương trình từ VS Code:**

- Nếu bạn đã cài đặt [JAVA Extension Pack](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack), bạn có thể mở file `.java` và nhấn `Ctrl + F5` để biên dịch và chạy chương trình.
- Kết quả sẽ hiển thị trong terminal tích hợp của VS Code.
- Bạn có thể tham khảo thêm về [debugging JAVA trong VS Code](https://code.visualstudio.com/docs/java/java-debugging) để biết cách debug chương trình JAVA.

---

## 🧑‍🏫 Bài 2: Biến và kiểu dữ liệu

**Khái niệm biến trong JAVA:**

- Biến là vùng nhớ để lưu trữ dữ liệu
- Mỗi biến có tên, kiểu dữ liệu và giá trị

**Kiểu dữ liệu nguyên thủy:**

```java
int age = 25;                // Số nguyên
double salary = 5000.50;     // Số thực
char grade = 'A';            // Ký tự
boolean isActive = true;     // Giá trị logic
```

**Kiểu dữ liệu tham chiếu:**

```java
String name = "Nguyen Van A";  // Chuỗi ký tự
int[] numbers = {1, 2, 3, 4};  // Mảng số nguyên
```

**Cách lưu trữ dữ liệu trong bộ nhớ:**

Đối với kiểu nguyên thủy, giá trị được lưu trực tiếp trong biến.
Đối với kiểu tham chiếu, biến lưu địa chỉ trỏ đến dữ liệu thực.

```text
┌─────────────┐
│  Biến: age  │
├─────────────┤
│     25      │  ◄── Giá trị được lưu trong ô nhớ
└─────────────┘

┌───────────────┐
│ Biến: salary  │
├───────────────┤
│    5000.50    │
└───────────────┘

┌───────────────┐
│ Biến: name    │
├───────────────┤
│  0x12AB34CD   │  ◄── Địa chỉ (tham chiếu) đến vùng nhớ khác
└───────────────┘
    │
    ▼
┌───────────────────────┐
│  "Nguyen Van A"       │  ◄── Dữ liệu thực tế nằm ở vùng nhớ khác
└───────────────────────┘
```

**Khai báo và khởi tạo biến:**

```java
// Khai báo và khởi tạo sau
int count;
count = 10;

// Khai báo và khởi tạo cùng lúc
double price = 19.99;

// Khai báo nhiều biến cùng kiểu
int x = 1, y = 2, z = 3;
```

**Ép kiểu:**

```java
// Ép kiểu ngầm định (mở rộng) - không mất dữ liệu
int num = 10;
double numDouble = num;  // 10.0

// Ép kiểu tường minh (thu hẹp) - có thể mất dữ liệu
double pi = 3.14;
int wholePi = (int) pi;  // 3
```

---

## 🧑‍🏫 Bài 3: Toán tử và biểu thức

- Toán tử số học: `+`, `-`, `*`, `/`, `%`
- Toán tử so sánh: `==`, `!=`, `>`, `<`, `>=`, `<=`
- Toán tử logic: `&&`, `||`, `!`

**Toán tử số học:**

```java
int a = 10, b = 3;
int sum = a + b;        // 13
int difference = a - b; // 7
int product = a * b;    // 30
int quotient = a / b;   // 3 (phần nguyên)
int remainder = a % b;  // 1 (phần dư)

// Toán tử tăng/giảm
int i = 5;
i++;                   // i = 6 (tăng sau)
++i;                   // i = 7 (tăng trước)
i--;                   // i = 6 (giảm sau)
--i;                   // i = 5 (giảm trước)
```

**Toán tử gán:**

```java
int x = 10;
x += 5;  // x = x + 5 = 15
x -= 3;  // x = x - 3 = 12
x *= 2;  // x = x * 2 = 24
x /= 4;  // x = x / 4 = 6
x %= 4;  // x = x % 4 = 2
```

**Toán tử so sánh:**

```java
int p = 10, q = 20;
boolean isEqual = (p == q);       // false
boolean isNotEqual = (p != q);    // true
boolean isGreater = (p > q);      // false
boolean isLess = (p < q);         // true
boolean isGreaterOrEqual = (p >= q); // false
boolean isLessOrEqual = (p <= q);    // true
```

**Toán tử logic:**

```java
boolean condition1 = true;
boolean condition2 = false;

boolean andResult = condition1 && condition2;  // false
boolean orResult = condition1 || condition2;   // true
boolean notResult = !condition1;               // false
```

**Thứ tự ưu tiên toán tử:**

1. Toán tử tăng giảm (`++`, `--`), phủ định (`!`)
2. Toán tử nhân, chia, lấy dư (`*`, `/`, `%`)
3. Toán tử cộng, trừ (`+`, `-`)
4. Toán tử so sánh (`<`, `>`, `<=`, `>=`)
5. Toán tử bằng và khác (`==`, `!=`)
6. Toán tử logic AND (`&&`)
7. Toán tử logic OR (`||`)
8. Toán tử gán (`=`, `+=`, `-=`, `*=`, `/=`, `%=`)

**Ví dụ thứ tự ưu tiên:**

```java
int result = 5 + 3 * 2;  // 5 + 6 = 11 (nhân trước, cộng sau)
int result2 = (5 + 3) * 2;  // 8 * 2 = 16 (dấu ngoặc ưu tiên cao nhất)
```

---

## 🧑‍🏫 Bài 4: Câu lệnh điều kiện

**Câu lệnh if:**

```java
int age = 18;

// Câu lệnh if đơn
if (age >= 18) {
    System.out.println("Bạn đã đủ tuổi bầu cử");
}

// Câu lệnh if-else
if (age >= 18) {
    System.out.println("Bạn đã đủ tuổi bầu cử");
} else {
    System.out.println("Bạn chưa đủ tuổi bầu cử");
}

// Câu lệnh if-else if-else
int score = 75;
if (score >= 90) {
    System.out.println("Xuất sắc");
} else if (score >= 80) {
    System.out.println("Giỏi");
} else if (score >= 70) {
    System.out.println("Khá");
} else if (score >= 60) {
    System.out.println("Trung bình");
} else {
    System.out.println("Yếu");
}
```

**Câu lệnh switch-case:**

```java
int day = 3;
String dayName;

switch (day) {
    case 1:
        dayName = "Chủ nhật";
        break;
    case 2:
        dayName = "Thứ hai";
        break;
    case 3:
        dayName = "Thứ ba";
        break;
    case 4:
        dayName = "Thứ tư";
        break;
    case 5:
        dayName = "Thứ năm";
        break;
    case 6:
        dayName = "Thứ sáu";
        break;
    case 7:
        dayName = "Thứ bảy";
        break;
    default:
        dayName = "Ngày không hợp lệ";
}
System.out.println("Hôm nay là " + dayName);  // Hôm nay là Thứ ba
```

**Switch với JAVA 12+ (cú pháp mới):**

```java
int day = 3;
String dayType = switch (day) {
    case 1, 7 -> "Cuối tuần";
    case 2, 3, 4, 5, 6 -> "Ngày làm việc";
    default -> "Ngày không hợp lệ";
};
```

**Biểu thức điều kiện phức hợp:**

```java
int age = 25;
boolean hasID = true;
boolean isResident = true;

// Sử dụng AND (&&)
if (age >= 18 && hasID) {
    System.out.println("Bạn có thể bỏ phiếu");
}

// Sử dụng OR (||)
if (isResident || age >= 65) {
    System.out.println("Bạn được giảm giá vé");
}

// Kết hợp nhiều điều kiện
if ((age >= 18 && hasID) || (isResident && age >= 65)) {
    System.out.println("Bạn có đặc quyền");
}
```

**Toán tử ba ngôi:**

```java
int age = 20;
String status = (age >= 18) ? "Đã trưởng thành" : "Chưa trưởng thành";
System.out.println(status);  // Đã trưởng thành
```

---

## 🧑‍🏫 Bài 5: Câu lệnh lặp

**Vòng lặp for:**

```java
// In các số từ 1 đến 5
for (int i = 1; i <= 5; i++) {
    System.out.println(i);
}

// Tính tổng các số từ 1 đến 10
int sum = 0;
for (int i = 1; i <= 10; i++) {
    sum += i;
}
System.out.println("Tổng: " + sum);  // Tổng: 55

// Vòng lặp for cải tiến (for-each) - duyệt mảng/collection
int[] numbers = {1, 2, 3, 4, 5};
for (int num : numbers) {
    System.out.println(num);
}
```

**Vòng lặp while:**

```java
// In các số từ 1 đến 5
int i = 1;
while (i <= 5) {
    System.out.println(i);
    i++;
}

// Tìm số đầu tiên chia hết cho cả 3 và 5
int num = 1;
while (num <= 100) {
    if (num % 3 == 0 && num % 5 == 0) {
        System.out.println("Số đầu tiên chia hết cho cả 3 và 5: " + num);
        break;
    }
    num++;
}
```

**Vòng lặp do-while:**

```java
// In các số từ 1 đến 5
int i = 1;
do {
    System.out.println(i);
    i++;
} while (i <= 5);

// Mô phỏng menu lựa chọn
int choice;
do {
    System.out.println("\nMenu:");
    System.out.println("1. Xem danh sách");
    System.out.println("2. Thêm mới");
    System.out.println("3. Xóa");
    System.out.println("0. Thoát");

    choice = 1; // Giả sử người dùng chọn 1

    switch (choice) {
        case 1:
            System.out.println("Đang hiển thị danh sách...");
            break;
        case 2:
            System.out.println("Đang thêm mới...");
            break;
        case 3:
            System.out.println("Đang xóa...");
            break;
        case 0:
            System.out.println("Đang thoát...");
            break;
        default:
            System.out.println("Lựa chọn không hợp lệ!");
    }
} while (choice != 0);
```

**Từ khóa break và continue:**

```java
// Sử dụng break để thoát khỏi vòng lặp
for (int i = 1; i <= 10; i++) {
    if (i == 5) {
        break;  // Thoát khỏi vòng lặp khi i = 5
    }
    System.out.println(i);  // In: 1, 2, 3, 4
}

// Sử dụng continue để bỏ qua lần lặp hiện tại
for (int i = 1; i <= 5; i++) {
    if (i == 3) {
        continue;  // Bỏ qua lần lặp khi i = 3
    }
    System.out.println(i);  // In: 1, 2, 4, 5
}

// Vòng lặp lồng nhau với nhãn (label)
outerLoop: for (int i = 1; i <= 3; i++) {
    for (int j = 1; j <= 3; j++) {
        if (i * j > 5) {
            break outerLoop;  // Thoát khỏi cả vòng lặp ngoài
        }
        System.out.println(i + " * " + j + " = " + (i * j));
    }
}
```

---

## 🧪 Bài tập lớn cuối phần: Quản lý điểm sinh viên

### Đề bài

Viết chương trình cho phép người dùng:

- Nhập tên sinh viên và điểm của 3 môn học (Toán, Lý, Hóa)
- Tính điểm trung bình
- Xếp loại học lực theo các tiêu chí:
  - TB >= 8.0 → Giỏi
  - 6.5 <= TB < 8.0 → Khá
  - 5.0 <= TB < 6.5 → Trung bình
  - < 5.0 → Yếu
- In ra bảng thông tin sinh viên và kết quả xếp loại

### Kết quả chạy chương trình (Ví dụ)

```text
CHƯƠNG TRÌNH QUẢN LÝ ĐIỂM SINH VIÊN
-----------------------------------
Nhập tên sinh viên: Nguyễn Văn A
Nhập điểm Toán: 8.5
Nhập điểm Lý: 7.5
Nhập điểm Hóa: 9.0

KẾT QUẢ XẾP LOẠI
-----------------------------------
Sinh viên: Nguyễn Văn A
Điểm Toán: 8.5
Điểm Lý: 7.5
Điểm Hóa: 9.0
Điểm trung bình: 8.33
Xếp loại: Giỏi
```

---

[⬅️ Trở lại: GIT.md](../GIT.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: JAVA/Part2.md](../JAVA/Part2.md)
