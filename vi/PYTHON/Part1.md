# 📘 PHẦN 1: NHẬP MÔN PYTHON

## 🎯 Mục tiêu tổng quát

- Hiểu được Python là gì, triết lý và các ứng dụng của nó.
- Nắm vững cú pháp cơ bản, biến, các kiểu dữ liệu và cấu trúc điều khiển.
- Biết cách sử dụng các cấu trúc dữ liệu quan trọng như List, Dictionary.
- Xây dựng được các hàm để tái sử dụng code.
- Tạo được một ứng dụng dòng lệnh (command-line) đơn giản.

## 🧑‍🏫 Bài 1: Giới thiệu Python

### Python là gì?

- Python là ngôn ngữ lập trình bậc cao, thông dịch, đa mục đích.
- Cú pháp đơn giản, trong sáng, dễ đọc, gần với ngôn ngữ tự nhiên.
- Hệ sinh thái thư viện khổng lồ, hỗ trợ nhiều lĩnh vực: Web, Data Science, AI, Automation...
- Chạy trên đa nền tảng (Windows, macOS, Linux).

### Cài đặt và Chạy file Python đầu tiên

1. Tải và cài đặt Python từ [python.org](https://python.org).
2. Tạo file `hello.py`.
3. Mở terminal và chạy lệnh: `python hello.py`

```python
# Đây là comment một dòng

"""
Đây là comment
trên nhiều dòng (docstring)
"""

print("Hello, World!")

# Sử dụng f-string để định dạng chuỗi (cách hiện đại)
import datetime
today = datetime.date.today()
print(f"Hôm nay là ngày {today.day} tháng {today.month} năm {today.year}")
```

### Sơ đồ minh họa môi trường Python

```text
            +----------------------+
Bạn viết -> |      hello.py      | --(Chạy lệnh: python hello.py)--> Python Interpreter
            | (Mã nguồn Python)  |                                        |
            +----------------------+                                        |
                                                                            V
                                                                    +-----------------+
                                                                    |   Kết quả       |
                                                                    | (Hiện ra trên   |
                                                                    |    Terminal)    |
                                                                    +-----------------+
```

## 🧑‍🏫 Bài 2: Biến, Kiểu dữ liệu và Toán tử

### Biến trong Python

- Không cần khai báo kiểu dữ liệu, Python tự nhận diện.
- Tên biến bắt đầu bằng chữ cái hoặc dấu gạch dưới, không bắt đầu bằng số.
- Tên biến phân biệt chữ hoa, chữ thường (`name` khác `Name`).

```python
# Khai báo và gán giá trị
name = "Nguyễn Văn B"
age = 30
is_developer = True

# In giá trị biến
print(f"Tên: {name}")
print(f"Tuổi: {age}")
print(f"Là lập trình viên: {'Có' if is_developer else 'Không'}")
```

### Các kiểu dữ liệu cơ bản

- **String (str)**: Chuỗi ký tự.
- **Integer (int)**: Số nguyên.
- **Float (float)**: Số thực.
- **Boolean (bool)**: `True` hoặc `False`.
- **NoneType (None)**: Biểu thị giá trị rỗng.

```python
# Lấy kiểu dữ liệu
print(type("Hello Python"))  # <class 'str'>
print(type(100))             # <class 'int'>
print(type(99.9))            # <class 'float'>
print(type(False))           # <class 'bool'>
print(type(None))            # <class 'NoneType'>
```

### Các toán tử chính

```python
# Toán tử số học
a = 10
b = 3
print(f"Cộng: {a + b}")          # 13
print(f"Trừ: {a - b}")           # 7
print(f"Nhân: {a * b}")           # 30
print(f"Chia: {a / b}")           # 3.333...
print(f"Chia lấy nguyên: {a // b}") # 3
print(f"Chia lấy dư: {a % b}")     # 1
print(f"Lũy thừa: {a ** b}")      # 1000

# Toán tử so sánh
p = 5
q = "5"
print(f"p == 5: {p == 5}")       # True
print(f"p == q: {p == q}")       # False (khác kiểu dữ liệu)

# Toán tử logic
is_active = True
has_permission = False
print(f"and: {is_active and has_permission}") # False
print(f"or: {is_active or has_permission}")  # True
print(f"not: {not is_active}")              # False
```

## 🧑‍🏫 Bài 3: Cấu trúc điều khiển

### Cấu trúc điều kiện (if/elif/else)

- **Quan trọng**: Python dùng thụt đầu dòng (indentation) để xác định các khối lệnh, thay vì dùng `{}`.

```python
# Sơ đồ logic
#
#  (Bắt đầu)
#      |
#      V
#  [ score >= 8 ] ---Có---> (In "Giỏi") ---+
#      |                                    |
#      | Không                              |
#      V                                    |
#  [ score >= 6.5 ] --Có---> (In "Khá") --+
#      |                                    |
#      | Không                              |
#      V                                    |
#  (In "Trung bình") <----------------------+
#      |
#      V
#  (Kết thúc)

score = 7.5
if score >= 8.0:
    print("Xếp loại: Giỏi")
elif score >= 6.5:
    print("Xếp loại: Khá")
elif score >= 5.0:
    print("Xếp loại: Trung bình")
else:
    print("Xếp loại: Yếu")
```

### Vòng lặp

```python
# Vòng lặp for (dùng để duyệt qua một chuỗi/danh sách)
print("--- Vòng lặp for ---")
fruits = ["Táo", "Cam", "Chuối"]
for fruit in fruits:
    print(f"- {fruit}")

# Vòng lặp for với range()
for i in range(1, 6): # Lặp từ 1 đến 5
    print(f"Số: {i}")

# Vòng lặp while
print("--- Vòng lặp while ---")
count = 1
while count <= 5:
    print(f"Đếm: {count}")
    count += 1 # Tương đương count = count + 1

# break và continue
print("--- break và continue ---")
for i in range(1, 11):
    if i == 3:
        continue # Bỏ qua số 3 và tiếp tục vòng lặp
    if i == 8:
        break # Thoát khỏi vòng lặp khi i = 8
    print(i, end=" ") # in trên cùng một dòng
```

## 🧑‍🏫 Bài 4: Cấu trúc dữ liệu cơ bản

### List (Danh sách)

- Tập hợp các phần tử có thứ tự, có thể thay đổi.
- Các phần tử có thể khác kiểu dữ liệu.

```python
# Khai báo List
numbers = [1, 10, 5, 8]
mixed = [1, "Python", True, 3.14]

# Truy cập phần tử (index bắt đầu từ 0)
print(f"Phần tử đầu tiên: {numbers[0]}") # 1

# Thêm/Xóa phần tử
numbers.append(20) # Thêm vào cuối: [1, 10, 5, 8, 20]
numbers.pop(1)     # Xóa phần tử ở index 1: [1, 5, 8, 20]

# Sắp xếp
numbers.sort() # [1, 5, 8, 20]
print(f"List đã sắp xếp: {numbers}")

# Duyệt list
for num in numbers:
    print(num)
```

### Dictionary (Từ điển)

- Tập hợp các cặp `key: value`, không có thứ tự (trước Python 3.7), có thể thay đổi.
- `key` phải là duy nhất và không thể thay đổi (thường là string hoặc số).

```python
# Khai báo Dictionary
student = {
    'name': 'Trần Thị B',
    'age': 21,
    'major': 'Information Technology'
}

# Truy cập giá trị qua key
print(f"Tên: {student['name']}")
print(f"Tuổi: {student.get('age')}")

# Thêm/Cập nhật
student['gpa'] = 3.5 # Thêm cặp key-value mới
student['age'] = 22  # Cập nhật giá trị

# Duyệt dictionary
print("--- Thông tin sinh viên ---")
for key, value in student.items():
    print(f"{key.capitalize()}: {value}")
```

### Tuple và Set

- **Tuple**: Giống List nhưng không thể thay đổi (immutable). Dùng để chứa dữ liệu không đổi.
- **Set**: Tập hợp các phần tử không có thứ tự, không trùng lặp. Dùng để thực hiện các phép toán tập hợp.

```python
# Tuple
point = (10, 20)
print(f"Tọa độ x: {point[0]}")
# point[0] = 15 # Sẽ gây lỗi TypeError

# Set
colors = {'red', 'green', 'blue', 'red'}
print(colors) # {'red', 'green', 'blue'} (tự động loại bỏ 'red' trùng lặp)
```

## 🧑‍🏫 Bài 5: Hàm (Functions)

- Khối code có thể tái sử dụng.
- Giúp chương trình có cấu trúc và dễ bảo trì.

```python
# Hàm không có tham số
def say_hello():
    """Hàm này in ra một lời chào."""
    print("Chào mừng đến với Python!")

say_hello()

# Hàm có tham số và giá trị trả về
def add(a, b):
    """Hàm này trả về tổng của hai số."""
    return a + b

total = add(15, 7)
print(f"Tổng của 15 và 7 là: {total}")

# Hàm với tham số mặc định
def greet(name, message="Xin chào"):
    print(f"{message}, {name}!")

greet("An") # Xin chào, An!
greet("Bình", "Tạm biệt") # Tạm biệt, Bình!

# Hàm nhận số lượng tham số tùy ý
def calculate_average(*numbers):
    """Tính trung bình cộng của các số được truyền vào."""
    if not numbers:
        return 0
    return sum(numbers) / len(numbers)

avg1 = calculate_average(10, 20, 30)
avg2 = calculate_average(5, 10, 15, 20)
print(f"Trung bình 1: {avg1}")
print(f"Trung bình 2: {avg2}")
```

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Ứng dụng quản lý danh bạ trên Terminal

### Mô tả bài toán

Xây dựng một ứng dụng quản lý danh bạ đơn giản chạy trên cửa sổ dòng lệnh (Terminal). Ứng dụng cho phép người dùng:

- Xem toàn bộ danh bạ.
- Thêm một liên hệ mới (tên, số điện thoại).
- Tìm kiếm liên hệ theo tên.
- Thoát chương trình.

### Yêu cầu

1. Sử dụng một **List** để lưu trữ danh bạ. Mỗi liên hệ trong danh bạ là một **Dictionary** có các `key` là `name` và `phone`.
2. Sử dụng các **Hàm** để tổ chức code cho mỗi chức năng (ví dụ: `display_contacts()`, `add_contact()`, `find_contact()`).
3. Sử dụng vòng lặp `while` để chương trình chạy liên tục cho đến khi người dùng chọn thoát.
4. Sử dụng `if/elif/else` để xử lý lựa chọn của người dùng.
5. Sử dụng `input()` để nhận dữ liệu từ người dùng và `print()` để hiển thị thông tin.

### Gợi ý cấu trúc dữ liệu

```python
contacts = [
    {'name': 'An Nguyen', 'phone': '0901234567'},
    {'name': 'Binh Le', 'phone': '0912345678'}
]
```

### Luồng hoạt động chính

```text
(Bắt đầu)
    |
    V
Hiển thị Menu (1. Xem, 2. Thêm, 3. Tìm, 4. Thoát)
    |
    V
Người dùng nhập lựa chọn
    |
    +-----> (Nếu 1) -> Gọi hàm display_contacts() --+
    |                                               |
    +-----> (Nếu 2) -> Gọi hàm add_contact() --------+
    |                                               |
    +-----> (Nếu 3) -> Gọi hàm find_contact() -------+
    |                                               |
    +-----> (Nếu 4) -> (Thoát vòng lặp) -> (Kết thúc)
    |                                               |
    +-----> (Khác) -> Báo lỗi lựa chọn không hợp lệ -+
    |                                               |
    +-----------------------------------------------+
    |
    V
(Lặp lại)
```
