# 📘 PHẦN 1: NHẬP MÔN CẤU TRÚC DỮ LIỆU VÀ THUẬT TOÁN

## Nội dung

- [📘 PHẦN 1: NHẬP MÔN CẤU TRÚC DỮ LIỆU VÀ THUẬT TOÁN](#-phần-1-nhập-môn-cấu-trúc-dữ-liệu-và-thuật-toán)
  - [Nội dung](#nội-dung)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Giới thiệu về cấu trúc dữ liệu và thuật toán](#-bài-1-giới-thiệu-về-cấu-trúc-dữ-liệu-và-thuật-toán)
  - [🧑‍🏫 Bài 2: Phân tích độ phức tạp thuật toán](#-bài-2-phân-tích-độ-phức-tạp-thuật-toán)
  - [🧑‍🏫 Bài 3: Mảng và danh sách](#-bài-3-mảng-và-danh-sách)
  - [🧑‍🏫 Bài 4: Thuật toán sắp xếp cơ bản](#-bài-4-thuật-toán-sắp-xếp-cơ-bản)
  - [🧑‍🏫 Bài 5: Thuật toán tìm kiếm cơ bản](#-bài-5-thuật-toán-tìm-kiếm-cơ-bản)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN](#-bài-tập-lớn-cuối-phần)
    - [**Đề bài: Quản lý danh sách sinh viên**](#đề-bài-quản-lý-danh-sách-sinh-viên)
    - [**Kết quả chạy chương trình (Ví dụ):**](#kết-quả-chạy-chương-trình-ví-dụ)

## 🎯 Mục tiêu tổng quát

- Làm quen với khái niệm cấu trúc dữ liệu và thuật toán.
- Hiểu cách phân tích độ phức tạp thuật toán.
- Nắm vững các cấu trúc dữ liệu cơ bản và thuật toán sắp xếp, tìm kiếm.

---

## 🧑‍🏫 Bài 1: Giới thiệu về cấu trúc dữ liệu và thuật toán

**Khái niệm cấu trúc dữ liệu:**

- Cấu trúc dữ liệu là cách tổ chức và lưu trữ dữ liệu để có thể truy xuất và sử dụng hiệu quả.
- Cấu trúc dữ liệu giúp giải quyết các bài toán phức tạp một cách hiệu quả.

**Khái niệm thuật toán:**

- Thuật toán là tập hợp các bước tuần tự để giải quyết một vấn đề cụ thể.
- Thuật toán cần đảm bảo:
  - **Tính xác định**: Mỗi bước phải rõ ràng, chính xác
  - **Tính hữu hạn**: Kết thúc sau một số hữu hạn bước
  - **Tính hiệu quả**: Thực hiện trong thời gian và không gian hợp lý

**Mối quan hệ giữa cấu trúc dữ liệu và thuật toán:**

```text
Thuật toán + Cấu trúc dữ liệu = Chương trình
```

**Tầm quan trọng của DSA:**

1. Tối ưu hiệu năng chương trình
2. Giải quyết các bài toán phức tạp
3. Nền tảng cho việc phát triển phần mềm chuyên nghiệp
4. Yêu cầu phỏng vấn công việc lập trình

**Ví dụ minh họa:**

```java
// Sử dụng cấu trúc dữ liệu và thuật toán phù hợp
// để tìm phần tử lớn nhất trong mảng
public class FindMax {
    public static int findMax(int[] arr) {
        if (arr.length == 0) {
            throw new IllegalArgumentException("Mảng rỗng");
        }

        int max = arr[0];
        for (int i = 1; i < arr.length; i++) {
            if (arr[i] > max) {
                max = arr[i];
            }
        }
        return max;
    }

    public static void main(String[] args) {
        int[] numbers = {12, 45, 7, 23, 56, 89, 34};
        System.out.println("Giá trị lớn nhất: " + findMax(numbers));
        // Kết quả: Giá trị lớn nhất: 89
    }
}
```

---

## 🧑‍🏫 Bài 2: Phân tích độ phức tạp thuật toán

**Định nghĩa độ phức tạp thuật toán:**

- Độ phức tạp thuật toán là cách đo lường hiệu quả của thuật toán theo thời gian và không gian.
- Hai loại độ phức tạp chính:
  - **Độ phức tạp thời gian**: Số lượng phép tính cần thực hiện
  - **Độ phức tạp không gian**: Lượng bộ nhớ cần sử dụng

**Ký hiệu Big-O:**

- Big-O mô tả giới hạn trên của độ phức tạp thuật toán khi kích thước đầu vào tăng
- Một số ký hiệu Big-O phổ biến:
  - O(1): Độ phức tạp hằng số
  - O(log n): Độ phức tạp logarit
  - O(n): Độ phức tạp tuyến tính
  - O(n log n): Độ phức tạp log-tuyến tính
  - O(n²): Độ phức tạp bậc hai
  - O(2^n): Độ phức tạp hàm mũ
  - O(n!): Độ phức tạp giai thừa

**Phân tích thuật toán:**

```java
// Độ phức tạp O(1) - Hằng số
public int getFirstElement(int[] array) {
    return array[0];
}

// Độ phức tạp O(n) - Tuyến tính
public int sum(int[] array) {
    int total = 0;
    for (int i = 0; i < array.length; i++) {
        total += array[i];
    }
    return total;
}

// Độ phức tạp O(n²) - Bậc hai
public void printPairs(int[] array) {
    for (int i = 0; i < array.length; i++) {
        for (int j = 0; j < array.length; j++) {
            System.out.println(array[i] + ", " + array[j]);
        }
    }
}

// Độ phức tạp O(log n) - Logarit
public int binarySearch(int[] sortedArray, int target) {
    int left = 0;
    int right = sortedArray.length - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;

        if (sortedArray[mid] == target) {
            return mid;
        } else if (sortedArray[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return -1; // Không tìm thấy
}
```

**So sánh các độ phức tạp thuật toán:**

| Độ phức tạp | Tên gọi        | Đánh giá    | Ví dụ thuật toán            |
| ----------- | -------------- | ----------- | --------------------------- |
| O(1)        | Hằng số        | Rất nhanh   | Truy cập phần tử mảng       |
| O(log n)    | Logarit        | Nhanh       | Tìm kiếm nhị phân           |
| O(n)        | Tuyến tính     | Khá nhanh   | Tìm kiếm tuyến tính         |
| O(n log n)  | Log-tuyến tính | Trung bình  | Merge Sort, Quick Sort      |
| O(n²)       | Bậc hai        | Chậm        | Bubble Sort, Selection Sort |
| O(2^n)      | Hàm mũ         | Rất chậm    | Giải thuật đệ quy Fibonacci |
| O(n!)       | Giai thừa      | Cực kỳ chậm | Bài toán người du lịch      |

---

## 🧑‍🏫 Bài 3: Mảng và danh sách

**Mảng (Array):**

- Cấu trúc dữ liệu lưu trữ các phần tử liên tiếp trong bộ nhớ
- Truy cập ngẫu nhiên với độ phức tạp O(1)

```java
// Khai báo và khởi tạo mảng
int[] numbers = new int[5]; // Mảng 5 phần tử
int[] values = {10, 20, 30, 40, 50}; // Khởi tạo giá trị

// Truy cập phần tử
int firstValue = values[0]; // 10
int lastValue = values[4]; // 50

// Cập nhật phần tử
values[2] = 35; // Giá trị mới: {10, 20, 35, 40, 50}

// Duyệt mảng
for (int i = 0; i < values.length; i++) {
    System.out.println(values[i]);
}

// Duyệt với foreach
for (int value : values) {
    System.out.println(value);
}
```

**Mảng đa chiều:**

```java
// Mảng 2 chiều
int[][] matrix = new int[3][3];
matrix[0][0] = 1;
matrix[1][1] = 5;
matrix[2][2] = 9;

// Duyệt mảng 2 chiều
for (int i = 0; i < matrix.length; i++) {
    for (int j = 0; j < matrix[i].length; j++) {
        System.out.print(matrix[i][j] + " ");
    }
    System.out.println();
}
```

**Danh sách liên kết (Linked List):**

- Cấu trúc dữ liệu gồm các nút (node), mỗi nút chứa dữ liệu và tham chiếu đến nút tiếp theo
- Các loại: đơn, đôi, vòng

**Danh sách liên kết đơn:**

```java
class Node {
    int data;
    Node next;

    public Node(int data) {
        this.data = data;
        this.next = null;
    }
}

class LinkedList {
    Node head;

    // Thêm phần tử vào cuối danh sách
    public void append(int data) {
        Node newNode = new Node(data);

        // Nếu danh sách trống
        if (head == null) {
            head = newNode;
            return;
        }

        // Tìm nút cuối cùng
        Node last = head;
        while (last.next != null) {
            last = last.next;
        }

        // Gắn nút mới vào cuối
        last.next = newNode;
    }

    // In danh sách
    public void printList() {
        Node current = head;
        while (current != null) {
            System.out.print(current.data + " -> ");
            current = current.next;
        }
        System.out.println("null");
    }
}

// Sử dụng danh sách liên kết
LinkedList list = new LinkedList();
list.append(10);
list.append(20);
list.append(30);
list.printList(); // 10 -> 20 -> 30 -> null
```

**So sánh Mảng và Danh sách liên kết:**

| Tiêu chí      | Mảng                | Danh sách liên kết                             |
| ------------- | ------------------- | ---------------------------------------------- |
| Truy cập      | O(1) - Trực tiếp    | O(n) - Tuần tự                                 |
| Chèn/Xóa đầu  | O(n)                | O(1)                                           |
| Chèn/Xóa cuối | O(1) với mảng động  | O(n) với danh sách đơn, O(1) với danh sách đôi |
| Chèn/Xóa giữa | O(n)                | O(n)                                           |
| Bộ nhớ        | Liên tục            | Phân tán                                       |
| Kích thước    | Cố định (Java)      | Động                                           |
| Ứng dụng      | Truy cập ngẫu nhiên | Chèn/xóa thường xuyên                          |

---

## 🧑‍🏫 Bài 4: Thuật toán sắp xếp cơ bản

**Thuật toán sắp xếp nổi bọt (Bubble Sort):**

- Nguyên lý: So sánh và hoán đổi các cặp phần tử liền kề
- Độ phức tạp: O(n²)

```java
public static void bubbleSort(int[] arr) {
    int n = arr.length;
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                // Hoán đổi arr[j] và arr[j + 1]
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}
```

**Thuật toán sắp xếp chọn (Selection Sort):**

- Nguyên lý: Tìm phần tử nhỏ nhất (hoặc lớn nhất) và đặt vào vị trí đúng
- Độ phức tạp: O(n²)

```java
public static void selectionSort(int[] arr) {
    int n = arr.length;

    for (int i = 0; i < n - 1; i++) {
        // Tìm phần tử nhỏ nhất trong mảng chưa sắp xếp
        int minIdx = i;
        for (int j = i + 1; j < n; j++) {
            if (arr[j] < arr[minIdx]) {
                minIdx = j;
            }
        }

        // Hoán đổi phần tử nhỏ nhất với phần tử đầu tiên
        int temp = arr[minIdx];
        arr[minIdx] = arr[i];
        arr[i] = temp;
    }
}
```

**Thuật toán sắp xếp chèn (Insertion Sort):**

- Nguyên lý: Xây dựng mảng đã sắp xếp từng phần tử một
- Độ phức tạp: O(n²)

```java
public static void insertionSort(int[] arr) {
    int n = arr.length;

    for (int i = 1; i < n; i++) {
        int key = arr[i];
        int j = i - 1;

        // Di chuyển các phần tử lớn hơn key về sau
        while (j >= 0 && arr[j] > key) {
            arr[j + 1] = arr[j];
            j--;
        }
        arr[j + 1] = key;
    }
}
```

**So sánh các thuật toán sắp xếp cơ bản:**

| Thuật toán     | Thời gian trung bình | Thời gian tốt nhất | Thời gian xấu nhất | Bộ nhớ | Ổn định |
| -------------- | -------------------- | ------------------ | ------------------ | ------ | ------- |
| Bubble Sort    | O(n²)                | O(n)               | O(n²)              | O(1)   | Có      |
| Selection Sort | O(n²)                | O(n²)              | O(n²)              | O(1)   | Không   |
| Insertion Sort | O(n²)                | O(n)               | O(n²)              | O(1)   | Có      |

---

## 🧑‍🏫 Bài 5: Thuật toán tìm kiếm cơ bản

**Tìm kiếm tuyến tính (Linear Search):**

- Nguyên lý: Duyệt từng phần tử trong mảng
- Độ phức tạp: O(n)

```java
public static int linearSearch(int[] arr, int x) {
    for (int i = 0; i < arr.length; i++) {
        if (arr[i] == x) {
            return i;
        }
    }
    return -1; // Không tìm thấy
}
```

**Tìm kiếm nhị phân (Binary Search):**

- Yêu cầu: Mảng đã sắp xếp
- Nguyên lý: Chia đôi mảng và tìm kiếm trên nửa phù hợp
- Độ phức tạp: O(log n)

```java
public static int binarySearch(int[] arr, int x) {
    int left = 0, right = arr.length - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;

        // Nếu x ở giữa
        if (arr[mid] == x) {
            return mid;
        }

        // Nếu x lớn hơn, tìm bên phải
        if (arr[mid] < x) {
            left = mid + 1;
        }
        // Nếu x nhỏ hơn, tìm bên trái
        else {
            right = mid - 1;
        }
    }

    return -1; // Không tìm thấy
}
```

**Binary Search đệ quy:**

```java
public static int binarySearchRecursive(int[] arr, int left, int right, int x) {
    if (right >= left) {
        int mid = left + (right - left) / 2;

        // Nếu phần tử có ở vị trí giữa
        if (arr[mid] == x) {
            return mid;
        }

        // Nếu phần tử nhỏ hơn mid, tìm bên trái
        if (arr[mid] > x) {
            return binarySearchRecursive(arr, left, mid - 1, x);
        }

        // Ngược lại, tìm bên phải
        return binarySearchRecursive(arr, mid + 1, right, x);
    }

    // Không tìm thấy
    return -1;
}

// Hàm gọi ban đầu
public static int binarySearch(int[] arr, int x) {
    return binarySearchRecursive(arr, 0, arr.length - 1, x);
}
```

**So sánh thuật toán tìm kiếm:**

| Thuật toán          | Độ phức tạp | Yêu cầu         | Ưu điểm                    | Nhược điểm             |
| ------------------- | ----------- | --------------- | -------------------------- | ---------------------- |
| Tìm kiếm tuyến tính | O(n)        | Không           | Đơn giản, phù hợp mảng nhỏ | Chậm với mảng lớn      |
| Tìm kiếm nhị phân   | O(log n)    | Mảng đã sắp xếp | Nhanh với mảng lớn         | Cần mảng sắp xếp trước |

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Quản lý danh sách sinh viên**

Viết chương trình cho phép người dùng:

- Tạo một cấu trúc dữ liệu lưu trữ thông tin sinh viên (mã số, tên, tuổi, điểm trung bình)
- Thêm sinh viên mới vào danh sách
- Xóa sinh viên theo mã số
- Tìm kiếm sinh viên theo tên (tìm kiếm tuyến tính) và mã số (tìm kiếm nhị phân)
- Sắp xếp danh sách sinh viên theo điểm trung bình (sử dụng bubble sort, selection sort hoặc insertion sort)
- Hiển thị tất cả sinh viên trong danh sách

### **Kết quả chạy chương trình (Ví dụ):**

```text
CHƯƠNG TRÌNH QUẢN LÝ SINH VIÊN
-----------------------------------
1. Thêm sinh viên mới
2. Xóa sinh viên theo mã số
3. Tìm kiếm sinh viên theo tên
4. Tìm kiếm sinh viên theo mã số
5. Sắp xếp sinh viên theo điểm TB
6. Hiển thị danh sách sinh viên
0. Thoát

Chọn chức năng: 1
Nhập mã số: SV001
Nhập tên: Nguyễn Văn A
Nhập tuổi: 20
Nhập điểm TB: 8.5
Đã thêm sinh viên thành công!

Chọn chức năng: 1
Nhập mã số: SV002
Nhập tên: Trần Thị B
Nhập tuổi: 19
Nhập điểm TB: 9.0
Đã thêm sinh viên thành công!

Chọn chức năng: 6
DANH SÁCH SINH VIÊN
-----------------------------------
Mã số: SV001 | Tên: Nguyễn Văn A | Tuổi: 20 | Điểm TB: 8.5
Mã số: SV002 | Tên: Trần Thị B | Tuổi: 19 | Điểm TB: 9.0

Chọn chức năng: 5
Đã sắp xếp sinh viên theo điểm TB!

Chọn chức năng: 6
DANH SÁCH SINH VIÊN
-----------------------------------
Mã số: SV002 | Tên: Trần Thị B | Tuổi: 19 | Điểm TB: 9.0
Mã số: SV001 | Tên: Nguyễn Văn A | Tuổi: 20 | Điểm TB: 8.5

Chọn chức năng: 0
Cảm ơn bạn đã sử dụng chương trình!
```

---

[⬅️ Trở lại: JAVA/FINAL.md](../JAVA/FINAL.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: DSA/Part1.md](../DSA/Part1.md)
