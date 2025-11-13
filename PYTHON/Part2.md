# 📗 PHẦN 2: LẬP TRÌNH HƯỚNG ĐỐI TƯỢNG VÀ CÁC KHÁI NIỆM TRUNG GIAN

## 🎯 Mục tiêu tổng quát

- Hiểu và áp dụng được tư duy lập trình hướng đối tượng (OOP).
- Nắm vững cách tạo và sử dụng Class, Object, Kế thừa, Đóng gói, Đa hình.
- Biết cách đọc/ghi dữ liệu từ file, đặc biệt là định dạng JSON để lưu trữ dữ liệu có cấu trúc.
- Tổ chức code hiệu quả bằng cách sử dụng Modules.
- Xử lý các lỗi có thể xảy ra trong chương trình một cách chuyên nghiệp.
- Nâng cấp ứng dụng từ Phần 1 để có khả năng lưu trữ dữ liệu lâu dài và có cấu trúc tốt hơn.

## 🧑‍🏫 Bài 1: Lập trình Hướng đối tượng (OOP) - Khái niệm cơ bản

### Tại sao cần OOP?

OOP giúp chúng ta mô hình hóa các đối tượng trong thế giới thực vào trong code. Thay vì suy nghĩ về chương trình như một chuỗi các thủ tục, chúng ta suy nghĩ về nó như một tập hợp các đối tượng tương tác với nhau.

- **Dễ tổ chức**: Gom dữ liệu (thuộc tính) và hành vi (phương thức) liên quan vào cùng một đối tượng.
- **Dễ tái sử dụng**: Có thể sử dụng lại các lớp đã định nghĩa ở nhiều nơi.
- **Dễ bảo trì và mở rộng**: Thay đổi một đối tượng không ảnh hưởng nhiều đến các đối tượng khác.

### Class và Object

- **Class (Lớp)**: Là một bản thiết kế hoặc khuôn mẫu để tạo ra các đối tượng. Nó định nghĩa các thuộc tính (dữ liệu) và phương thức (hành vi) mà các đối tượng của lớp đó sẽ có.
- **Object (Đối tượng)**: Là một thể hiện (instance) cụ thể của một lớp. Bạn có thể tạo nhiều đối tượng từ một lớp duy nhất.

Sơ đồ minh họa:

```text
      +---------------------+
      |      Class: Car     |  (Bản thiết kế)
      |---------------------|
      | Thuộc tính:         |
      |   - color           |
      |   - brand           |
      |   - model           |
      |---------------------|
      | Phương thức:        |
      |   - start_engine()  |
      |   - accelerate()    |
      +---------------------+
                |
                | Tạo ra các thể hiện (Objects)
                |
  +-------------+--------------+
  |                            |
  V                            V
+-------------------+      +-------------------+
|  my_car (Object)  |      | your_car (Object) |
|-------------------|      |-------------------|
| color: "Red"      |      | color: "Blue"     |
| brand: "Vinfast"  |      | brand: "Toyota"   |
| model: "VF8"      |      | model: "Vios"     |
+-------------------+      +-------------------+
```

### Phương thức khởi tạo `__init__` và `self`

- `__init__`: Là một phương thức đặc biệt, được gọi tự động khi một đối tượng mới được tạo ra. Nó dùng để khởi tạo các thuộc tính ban đầu cho đối tượng.
- `self`: Là một tham chiếu đến chính đối tượng (thể hiện) đang được tạo ra hoặc đang gọi phương thức. `self` phải là tham số đầu tiên của mọi phương thức trong một lớp.

```python
class Student:
    # Phương thức khởi tạo
    def __init__(self, name, age, student_id):
        print(f"Một sinh viên mới vừa được tạo!")
        self.name = name          # Thuộc tính của đối tượng
        self.age = age
        self.student_id = student_id
        self.subjects = []

    # Một phương thức của đối tượng
    def display_info(self):
        print("--- Thông tin sinh viên ---")
        print(f"Tên: {self.name}")
        print(f"Tuổi: {self.age}")
        print(f"MSSV: {self.student_id}")

    def add_subject(self, subject_name):
        self.subjects.append(subject_name)
        print(f"Đã thêm môn học '{subject_name}' cho sinh viên {self.name}.")

# Tạo ra các đối tượng (instance) từ class Student
student1 = Student("Nguyễn Văn An", 20, "SV001")
student2 = Student("Trần Thị Bình", 21, "SV002")

# Gọi phương thức của đối tượng
student1.display_info()
student2.add_subject("Lập trình Python")
student2.display_info()
```

## 🧑‍🏫 Bài 2: Các trụ cột của OOP

### Tính kế thừa (Inheritance)

Cho phép một lớp (lớp con) kế thừa các thuộc tính và phương thức từ một lớp khác (lớp cha). Giúp tái sử dụng code và tạo ra một hệ thống phân cấp logic.

```python
# Lớp cha
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def introduce(self):
        print(f"Tôi là {self.name}, {self.age} tuổi.")

# Lớp con kế thừa từ Person
class Teacher(Person):
    def __init__(self, name, age, subject):
        # Gọi __init__ của lớp cha để khởi tạo name và age
        super().__init__(name, age)
        self.subject = subject

    # Ghi đè (override) phương thức của lớp cha
    def introduce(self):
        print(f"Tôi là giáo viên {self.name}, {self.age} tuổi. Tôi dạy môn {self.subject}.")

teacher_A = Teacher("Thầy Quang", 35, "Toán")
teacher_A.introduce() # Gọi phương thức đã được override
```

### Tính đóng gói (Encapsulation)

- Là việc gói gọn dữ liệu (thuộc tính) và các phương thức làm việc với dữ liệu đó vào trong một đối tượng.
- Giúp che giấu thông tin (information hiding), hạn chế truy cập trực tiếp vào dữ liệu từ bên ngoài.
- Trong Python, ta dùng quy ước:
  - `_ten_thuoc_tinh`: Thuộc tính "protected", chỉ nên dùng trong nội bộ class và các class con.
  - `__ten_thuoc_tinh`: Thuộc tính "private", Python sẽ "bóp méo" tên để khó truy cập hơn từ bên ngoài.

```python
class BankAccount:
    def __init__(self, owner, balance=0):
        self.owner = owner
        self.__balance = balance # Thuộc tính private

    def deposit(self, amount):
        if amount > 0:
            self.__balance += amount
            print(f"Nạp {amount} thành công.")
        else:
            print("Số tiền nạp phải lớn hơn 0.")

    def withdraw(self, amount):
        if 0 < amount <= self.__balance:
            self.__balance -= amount
            print(f"Rút {amount} thành công.")
        else:
            print("Số tiền rút không hợp lệ hoặc không đủ số dư.")

    def get_balance(self):
        # Cung cấp một phương thức công khai để xem số dư
        return self.__balance

acc = BankAccount("An Nguyễn")
acc.deposit(1000)
acc.withdraw(300)
# print(acc.__balance) # Sẽ gây lỗi AttributeError vì là private
print(f"Số dư hiện tại: {acc.get_balance()}")
```

### Tính đa hình (Polymorphism)

- "Poly" (nhiều) + "morph" (hình dạng). Cho phép các đối tượng của các lớp khác nhau phản hồi cùng một thông điệp (gọi cùng một tên phương thức) theo cách riêng của chúng.
- Thường được thể hiện qua việc ghi đè phương thức (method overriding) như trong ví dụ Kế thừa.

```python
class Dog:
    def speak(self):
        return "Gâu gâu!"

class Cat:
    def speak(self):
        return "Meo meo!"

class Duck:
    def speak(self):
        return "Quạc quạc!"

# Cùng một lời gọi hàm animal_sound, nhưng kết quả khác nhau
# tùy thuộc vào đối tượng được truyền vào.
def animal_sound(animal):
    print(animal.speak())

dog = Dog()
cat = Cat()
duck = Duck()

animal_sound(dog)  # In ra "Gâu gâu!"
animal_sound(cat)  # In ra "Meo meo!"
animal_sound(duck) # In ra "Quạc quạc!"
```

## 🧑‍🏫 Bài 3: Xử lý File và Định dạng JSON

### Đọc và Ghi file văn bản

Cách tốt nhất để làm việc với file trong Python là sử dụng `with open(...)`. Nó sẽ tự động đóng file sau khi hoàn thành, kể cả khi có lỗi xảy ra.

```python
# Ghi vào file
# 'w' (write): Ghi đè nội dung. 'a' (append): Ghi nối vào cuối file.
try:
    with open("notes.txt", "w", encoding="utf-8") as file:
        file.write("Dòng đầu tiên.\n")
        file.write("Học Python rất vui!\n")
    print("Ghi file thành công.")
except IOError as e:
    print(f"Lỗi khi ghi file: {e}")

# Đọc từ file
try:
    with open("notes.txt", "r", encoding="utf-8") as file:
        content = file.read() # Đọc toàn bộ nội dung
        print("--- Nội dung file ---")
        print(content)
except FileNotFoundError:
    print("Không tìm thấy file notes.txt")
except IOError as e:
    print(f"Lỗi khi đọc file: {e}")

```

### Làm việc với JSON

JSON (JavaScript Object Notation) là một định dạng văn bản nhẹ, dễ đọc, rất phổ biến để trao đổi dữ liệu. Cấu trúc của JSON rất giống với Dictionary và List trong Python.

```python
import json

# Dữ liệu Python (list của các dictionary)
students_data = [
    {'id': 'SV001', 'name': 'An Nguyen', 'major': 'IT'},
    {'id': 'SV002', 'name': 'Binh Le', 'major': 'Business'}
]

# 1. Ghi dữ liệu Python vào file JSON (Serialization)
with open('students.json', 'w', encoding='utf-8') as f:
    json.dump(students_data, f, ensure_ascii=False, indent=4)
print("Đã lưu dữ liệu vào students.json")

# 2. Đọc dữ liệu từ file JSON vào Python (Deserialization)
try:
    with open('students.json', 'r', encoding='utf-8') as f:
        data_from_json = json.load(f)
        print("--- Dữ liệu đọc từ JSON ---")
        for student in data_from_json:
            print(f"- {student['name']} ({student['major']})")
except FileNotFoundError:
    print("Không tìm thấy file JSON.")
```

## 🧑‍🏫 Bài 4: Modules và Xử lý Lỗi (Exceptions)

### Modules trong Python

Module là một file Python (`.py`) chứa các định nghĩa và câu lệnh. Nó giúp bạn chia nhỏ chương trình lớn thành các file nhỏ hơn, dễ quản lý hơn.

**Ví dụ:** Tạo 2 file trong cùng một thư mục.

`utils.py`:

```python
# File: utils.py
PI = 3.14159

def circle_area(radius):
    """Tính diện tích hình tròn."""
    return PI * (radius ** 2)

def greet(name):
    return f"Hello, {name}!"
```

`main.py`:

```python
# File: main.py
import utils # Import toàn bộ module

# Sử dụng các thành phần từ module
print(f"PI = {utils.PI}")
print(f"Diện tích hình tròn bán kính 5: {utils.circle_area(5)}")

# Hoặc import cụ thể
from utils import greet

print(greet("Python Developer"))
```

### Xử lý ngoại lệ với try-except

Ngoại lệ (Exception) là các lỗi xảy ra trong quá trình thực thi chương trình. Sử dụng khối `try...except` để "bắt" các lỗi này và xử lý chúng một cách an toàn, tránh làm chương trình bị dừng đột ngột.

Sơ đồ logic:

```text
      (Bắt đầu)
          |
          V
      +-------+
      |  try  |  <-- Chạy khối code có khả năng gây lỗi
      +-------+
          |
   (Có lỗi xảy ra?)
      |        |
   Có |        | Không
      V        V
  +--------+   (Tiếp tục bình thường)
  | except |   |
  +--------+   |
      |        |
      +--------+
          |
          V
      (Kết thúc khối try-except)
```

```python
try:
    numerator = int(input("Nhập tử số: "))
    denominator = int(input("Nhập mẫu số: "))
    result = numerator / denominator
except ValueError:
    # Bắt lỗi khi người dùng nhập không phải là số
    print("Lỗi: Vui lòng chỉ nhập số nguyên.")
except ZeroDivisionError:
    # Bắt lỗi khi chia cho 0
    print("Lỗi: Không thể chia cho 0.")
except Exception as e:
    # Bắt tất cả các lỗi khác
    print(f"Đã có lỗi không xác định xảy ra: {e}")
else:
    # Khối này sẽ chạy nếu không có lỗi nào trong 'try'
    print(f"Kết quả phép chia là: {result}")
finally:
    # Khối này LUÔN LUÔN chạy, dù có lỗi hay không
    print("Chương trình kết thúc.")
```

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Nâng cấp ứng dụng Quản lý Danh bạ

### Mô tả bài toán

Nâng cấp ứng dụng Quản lý Danh bạ từ Phần 1 bằng cách áp dụng các kiến thức về OOP, xử lý file và xử lý lỗi. Giờ đây, ứng dụng sẽ có cấu trúc tốt hơn và dữ liệu sẽ được lưu lại sau mỗi lần chạy.

### Yêu cầu

1. **Tái cấu trúc với OOP**:
    - Tạo một class `Contact` với các thuộc tính như `name`, `phone`, `email`.
    - Tạo một class `ContactManager` để quản lý danh sách các đối tượng `Contact`. Class này sẽ chứa các phương thức như:
      - `add_contact(contact)`
      - `display_all()`
      - `search_contact(name)`
      - `load_contacts()` (đọc từ file)
      - `save_contacts()` (lưu vào file)

2. **Lưu trữ dữ liệu bền vững**:
    - Sử dụng file `contacts.json` để lưu trữ danh bạ.
    - Khi chương trình khởi động, phương thức `load_contacts()` sẽ được gọi để đọc dữ liệu từ `contacts.json` (nếu có) và tạo ra danh sách các đối tượng `Contact`.
    - Trước khi chương trình thoát, phương thức `save_contacts()` sẽ được gọi để ghi lại danh sách liên hệ hiện tại vào file `contacts.json`.

3. **Xử lý lỗi**:
    - Sử dụng `try-except` để xử lý trường hợp file `contacts.json` không tồn tại khi khởi động lần đầu (`FileNotFoundError`). Trong trường hợp này, chương trình nên bắt đầu với một danh bạ trống.
    - Xử lý các lỗi nhập liệu từ người dùng (ví dụ: nhập lựa chọn menu không hợp lệ).

4. **(Tùy chọn) Tổ chức code**:
    - Chia code thành các module:
      - `contact.py`: Chứa class `Contact`.
      - `manager.py`: Chứa class `ContactManager`.
      - `main.py`: Chứa vòng lặp chính của chương trình và giao diện người dùng.

### Sơ đồ kiến trúc đề xuất

```text
+------------+        +-------------+        +-----------------+
|  main.py   |        | manager.py  |        |   contact.py    |
| (UI &      | ---->  | (Class      | ---->  |   (Class        |
|  main loop)|        | ContactMa...)        |    Contact)     |
+------------+        +-------------+        +-----------------+
                           |
                           | Đọc/Ghi
                           V
                     +---------------+
                     | contacts.json |
                     | (Lưu trữ data)|
                     +---------------+
```

### Luồng hoạt động gợi ý

1. `main.py` chạy, tạo một đối tượng `ContactManager`.
2. Đối tượng `ContactManager` được khởi tạo, nó sẽ gọi ngay phương thức `load_contacts()` của chính nó.
3. `load_contacts()`:
    - `try` để mở và đọc `contacts.json`.
    - Với mỗi dictionary đọc được từ JSON, tạo một đối tượng `Contact` và thêm vào danh sách liên hệ của manager.
    - `except FileNotFoundError`: Bỏ qua và bắt đầu với danh sách rỗng.
4. Vòng lặp `while` trong `main.py` hiển thị menu và nhận lựa chọn người dùng.
5. Dựa trên lựa chọn, `main.py` gọi các phương thức tương ứng của đối tượng `ContactManager` (ví dụ `add_contact`, `display_all`,...).
6. Khi người dùng chọn "Thoát", `main.py` sẽ gọi phương thức `save_contacts()` của `ContactManager` trước khi kết thúc chương trình.
