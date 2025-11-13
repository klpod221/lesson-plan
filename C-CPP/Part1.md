# 📘 PHẦN 1: NHẬP MÔN C

- [📘 PHẦN 1: NHẬP MÔN C](#-phần-1-nhập-môn-c)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Giới thiệu ngôn ngữ C](#-bài-1-giới-thiệu-ngôn-ngữ-c)
    - [C là gì?](#c-là-gì)
    - [Cài đặt môi trường](#cài-đặt-môi-trường)
    - [Chương trình C đầu tiên](#chương-trình-c-đầu-tiên)
  - [🧑‍🏫 Bài 2: Biến và Kiểu dữ liệu](#-bài-2-biến-và-kiểu-dữ-liệu)
    - [Kiểu dữ liệu cơ bản](#kiểu-dữ-liệu-cơ-bản)
    - [Biến và hằng số](#biến-và-hằng-số)
    - [Toán tử](#toán-tử)
  - [🧑‍🏫 Bài 3: Nhập xuất dữ liệu](#-bài-3-nhập-xuất-dữ-liệu)
    - [Printf và format specifiers](#printf-và-format-specifiers)
    - [Scanf và nhập dữ liệu](#scanf-và-nhập-dữ-liệu)
  - [🧑‍🏫 Bài 4: Cấu trúc điều khiển](#-bài-4-cấu-trúc-điều-khiển)
    - [Câu lệnh if-else](#câu-lệnh-if-else)
    - [Switch-case](#switch-case)
    - [Vòng lặp](#vòng-lặp)
  - [🧑‍🏫 Bài 5: Hàm trong C](#-bài-5-hàm-trong-c)
    - [Định nghĩa và gọi hàm](#định-nghĩa-và-gọi-hàm)
    - [Tham số và giá trị trả về](#tham-số-và-giá-trị-trả-về)
    - [Scope và Storage Class](#scope-và-storage-class)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN: Quản lý sinh viên](#-bài-tập-lớn-cuối-phần-quản-lý-sinh-viên)
    - [Mô tả bài toán](#mô-tả-bài-toán)
    - [Yêu cầu](#yêu-cầu)

## 🎯 Mục tiêu tổng quát

- Hiểu được C là gì và tại sao nên học C
- Nắm vững cú pháp cơ bản, biến, kiểu dữ liệu
- Biết cách nhập xuất dữ liệu
- Sử dụng thành thạo cấu trúc điều khiển và hàm
- Xây dựng chương trình C hoàn chỉnh

---

## 🧑‍🏫 Bài 1: Giới thiệu ngôn ngữ C

### C là gì?

- C là ngôn ngữ lập trình mức trung (middle-level language)
- Được phát triển bởi Dennis Ritchie tại Bell Labs năm 1972
- Nền tảng cho nhiều ngôn ngữ khác: C++, Java, C#, JavaScript...
- Được sử dụng rộng rãi trong: Operating Systems, Embedded Systems, System Programming

**Đặc điểm:**

- Hiệu suất cao, gần với phần cứng
- Portable - chạy trên nhiều platform
- Cú pháp đơn giản nhưng mạnh mẽ
- Cho phép quản lý bộ nhớ trực tiếp

### Cài đặt môi trường

**Linux/macOS:**

```bash
# Linux (Ubuntu/Debian)
sudo apt-get install build-essential

# macOS (cần Xcode Command Line Tools)
xcode-select --install

# Kiểm tra
gcc --version
```

**Windows:**

- Cài đặt MinGW hoặc MSYS2
- Hoặc sử dụng Visual Studio

**IDE/Editor:**

- VS Code (khuyến nghị)
- Code::Blocks
- CLion
- Vim/Emacs

### Chương trình C đầu tiên

```c
// hello.c
#include <stdio.h>

int main() {
    printf("Hello, World!\n");
    printf("Welcome to C Programming!\n");
    return 0;
}
```

**Biên dịch và chạy:**

```bash
# Biên dịch
gcc hello.c -o hello

# Chạy
./hello
```

**Giải thích:**

- `#include <stdio.h>` - Include thư viện standard input/output
- `int main()` - Hàm main, điểm bắt đầu chương trình
- `printf()` - Hàm in ra màn hình
- `return 0` - Trả về 0 cho OS (thành công)
- `\n` - Ký tự xuống dòng

**Cấu trúc chương trình C:**

```c
// Preprocessor directives
#include <stdio.h>
#define PI 3.14159

// Global variables
int globalVar = 10;

// Function declarations
void greet();
int add(int a, int b);

// Main function
int main() {
    printf("Main function\n");
    greet();
    int result = add(5, 3);
    printf("Result: %d\n", result);
    return 0;
}

// Function definitions
void greet() {
    printf("Hello from greet function!\n");
}

int add(int a, int b) {
    return a + b;
}
```

---

## 🧑‍🏫 Bài 2: Biến và Kiểu dữ liệu

### Kiểu dữ liệu cơ bản

```c
#include <stdio.h>

int main() {
    // Integer types
    int age = 25;
    short smallNum = 100;
    long bigNum = 1000000L;
    long long veryBigNum = 9223372036854775807LL;
    
    // Unsigned types
    unsigned int positiveOnly = 100;
    
    // Character
    char letter = 'A';
    char grade = 'B';
    
    // Floating point
    float pi = 3.14159f;
    double precision = 3.14159265359;
    
    // Print sizes
    printf("Size of int: %lu bytes\n", sizeof(int));
    printf("Size of char: %lu bytes\n", sizeof(char));
    printf("Size of float: %lu bytes\n", sizeof(float));
    printf("Size of double: %lu bytes\n", sizeof(double));
    
    // Print values
    printf("Age: %d\n", age);
    printf("Letter: %c\n", letter);
    printf("Pi: %f\n", pi);
    printf("Precision: %.10lf\n", precision);
    
    return 0;
}
```

**Bảng kiểu dữ liệu:**

| Kiểu | Kích thước | Khoảng giá trị | Format |
|------|-----------|----------------|---------|
| char | 1 byte | -128 to 127 | %c, %d |
| unsigned char | 1 byte | 0 to 255 | %u |
| short | 2 bytes | -32,768 to 32,767 | %hd |
| int | 4 bytes | -2^31 to 2^31-1 | %d |
| unsigned int | 4 bytes | 0 to 2^32-1 | %u |
| long | 4/8 bytes | Platform dependent | %ld |
| long long | 8 bytes | -2^63 to 2^63-1 | %lld |
| float | 4 bytes | ~6-7 digits | %f |
| double | 8 bytes | ~15-16 digits | %lf |

### Biến và hằng số

```c
#include <stdio.h>

// Constant với #define
#define MAX_SIZE 100
#define PI 3.14159

int main() {
    // Khai báo biến
    int number;
    number = 10;
    
    // Khai báo và khởi tạo
    int age = 25;
    float height = 1.75f;
    char initial = 'K';
    
    // Nhiều biến cùng kiểu
    int x = 1, y = 2, z = 3;
    
    // Constant với const
    const int DAYS_IN_WEEK = 7;
    const float GRAVITY = 9.8f;
    
    // DAYS_IN_WEEK = 8;  // LỖI: không thể thay đổi
    
    printf("Max size: %d\n", MAX_SIZE);
    printf("Days in week: %d\n", DAYS_IN_WEEK);
    
    // Type casting
    int intNum = 10;
    float floatNum = (float)intNum;
    printf("Float: %f\n", floatNum);
    
    float f = 9.8f;
    int i = (int)f;  // Truncate
    printf("Truncated: %d\n", i);
    
    return 0;
}
```

### Toán tử

```c
#include <stdio.h>

int main() {
    int a = 10, b = 3;
    
    // Arithmetic operators
    printf("a + b = %d\n", a + b);    // 13
    printf("a - b = %d\n", a - b);    // 7
    printf("a * b = %d\n", a * b);    // 30
    printf("a / b = %d\n", a / b);    // 3 (integer division)
    printf("a %% b = %d\n", a % b);   // 1 (modulo)
    
    // Float division
    float x = 10.0f, y = 3.0f;
    printf("x / y = %.2f\n", x / y);  // 3.33
    
    // Increment/Decrement
    int i = 5;
    printf("i++ = %d\n", i++);  // 5, then i becomes 6
    printf("i = %d\n", i);      // 6
    printf("++i = %d\n", ++i);  // 7
    
    // Assignment operators
    int num = 10;
    num += 5;  // num = num + 5
    printf("num += 5: %d\n", num);
    num *= 2;  // num = num * 2
    printf("num *= 2: %d\n", num);
    
    // Relational operators
    printf("10 > 5: %d\n", 10 > 5);    // 1 (true)
    printf("10 < 5: %d\n", 10 < 5);    // 0 (false)
    printf("10 == 10: %d\n", 10 == 10); // 1
    printf("10 != 5: %d\n", 10 != 5);   // 1
    
    // Logical operators
    int p = 1, q = 0;
    printf("p && q: %d\n", p && q);  // 0 (AND)
    printf("p || q: %d\n", p || q);  // 1 (OR)
    printf("!p: %d\n", !p);          // 0 (NOT)
    
    // Bitwise operators
    printf("5 & 3: %d\n", 5 & 3);    // 1 (AND)
    printf("5 | 3: %d\n", 5 | 3);    // 7 (OR)
    printf("5 ^ 3: %d\n", 5 ^ 3);    // 6 (XOR)
    printf("~5: %d\n", ~5);          // -6 (NOT)
    printf("5 << 1: %d\n", 5 << 1);  // 10 (left shift)
    printf("5 >> 1: %d\n", 5 >> 1);  // 2 (right shift)
    
    return 0;
}
```

---

## 🧑‍🏫 Bài 3: Nhập xuất dữ liệu

### Printf và format specifiers

```c
#include <stdio.h>

int main() {
    int age = 25;
    float height = 1.75f;
    char grade = 'A';
    char name[] = "John";
    
    // Basic formatting
    printf("Name: %s\n", name);
    printf("Age: %d\n", age);
    printf("Height: %.2f\n", height);
    printf("Grade: %c\n", grade);
    
    // Width and alignment
    printf("|%10d|\n", 123);      // Right aligned, width 10
    printf("|%-10d|\n", 123);     // Left aligned
    printf("|%010d|\n", 123);     // Zero padded
    
    // Floating point formatting
    float pi = 3.14159265359f;
    printf("Pi: %f\n", pi);       // Default: 6 decimals
    printf("Pi: %.2f\n", pi);     // 2 decimals
    printf("Pi: %.10f\n", pi);    // 10 decimals
    printf("Pi: %e\n", pi);       // Scientific notation
    
    // Multiple values
    printf("Name: %s, Age: %d, Height: %.2f\n", name, age, height);
    
    // Special characters
    printf("Line 1\n");           // New line
    printf("Tab\there\n");        // Tab
    printf("Quote: \"Hello\"\n"); // Quote
    printf("Backslash: \\\n");    // Backslash
    printf("Percent: %%\n");      // Percent sign
    
    // Hexadecimal and octal
    int num = 255;
    printf("Decimal: %d\n", num);
    printf("Hexadecimal: %x\n", num);  // ff
    printf("Hexadecimal: %X\n", num);  // FF
    printf("Octal: %o\n", num);        // 377
    
    return 0;
}
```

### Scanf và nhập dữ liệu

```c
#include <stdio.h>

int main() {
    int age;
    float height;
    char grade;
    char name[50];
    
    // Nhập số nguyên
    printf("Enter your age: ");
    scanf("%d", &age);
    
    // Nhập số thực
    printf("Enter your height: ");
    scanf("%f", &height);
    
    // Nhập ký tự
    printf("Enter your grade: ");
    scanf(" %c", &grade);  // Space before %c để skip whitespace
    
    // Nhập chuỗi (không có khoảng trắng)
    printf("Enter your name: ");
    scanf("%s", name);
    
    // In kết quả
    printf("\n--- Your Information ---\n");
    printf("Name: %s\n", name);
    printf("Age: %d\n", age);
    printf("Height: %.2f\n", height);
    printf("Grade: %c\n", grade);
    
    return 0;
}
```

**Nhập chuỗi có khoảng trắng:**

```c
#include <stdio.h>

int main() {
    char name[50];
    int age;
    
    printf("Enter your age: ");
    scanf("%d", &age);
    
    // Clear input buffer
    while (getchar() != '\n');
    
    // Nhập chuỗi có khoảng trắng
    printf("Enter your full name: ");
    fgets(name, sizeof(name), stdin);
    
    // Remove newline if exists
    int len = strlen(name);
    if (len > 0 && name[len-1] == '\n') {
        name[len-1] = '\0';
    }
    
    printf("\nName: %s\n", name);
    printf("Age: %d\n", age);
    
    return 0;
}
```

**Error handling với scanf:**

```c
#include <stdio.h>

int main() {
    int num;
    int result;
    
    printf("Enter a number: ");
    result = scanf("%d", &num);
    
    if (result == 1) {
        printf("You entered: %d\n", num);
    } else {
        printf("Invalid input!\n");
        // Clear input buffer
        while (getchar() != '\n');
    }
    
    return 0;
}
```

---

## 🧑‍🏫 Bài 4: Cấu trúc điều khiển

### Câu lệnh if-else

```c
#include <stdio.h>

int main() {
    int score;
    
    printf("Enter your score: ");
    scanf("%d", &score);
    
    // Simple if
    if (score >= 90) {
        printf("Grade: A\n");
    } else if (score >= 80) {
        printf("Grade: B\n");
    } else if (score >= 70) {
        printf("Grade: C\n");
    } else if (score >= 60) {
        printf("Grade: D\n");
    } else {
        printf("Grade: F\n");
    }
    
    // Ternary operator
    int age = 20;
    char *status = (age >= 18) ? "Adult" : "Minor";
    printf("Status: %s\n", status);
    
    // Nested if
    if (score >= 60) {
        if (score >= 90) {
            printf("Excellent!\n");
        } else {
            printf("Good job!\n");
        }
    } else {
        printf("Need improvement\n");
    }
    
    // Logical operators
    int age2 = 25;
    int hasLicense = 1;
    
    if (age2 >= 18 && hasLicense) {
        printf("Can drive\n");
    }
    
    return 0;
}
```

### Switch-case

```c
#include <stdio.h>

int main() {
    int choice;
    
    printf("=== Menu ===\n");
    printf("1. Add\n");
    printf("2. Subtract\n");
    printf("3. Multiply\n");
    printf("4. Divide\n");
    printf("Enter choice: ");
    scanf("%d", &choice);
    
    switch (choice) {
        case 1:
            printf("You selected: Add\n");
            break;
        case 2:
            printf("You selected: Subtract\n");
            break;
        case 3:
            printf("You selected: Multiply\n");
            break;
        case 4:
            printf("You selected: Divide\n");
            break;
        default:
            printf("Invalid choice!\n");
    }
    
    // Switch with char
    char grade;
    printf("Enter grade (A-F): ");
    scanf(" %c", &grade);
    
    switch (grade) {
        case 'A':
        case 'a':
            printf("Excellent!\n");
            break;
        case 'B':
        case 'b':
            printf("Good!\n");
            break;
        case 'C':
        case 'c':
            printf("Fair\n");
            break;
        case 'D':
        case 'd':
            printf("Poor\n");
            break;
        case 'F':
        case 'f':
            printf("Fail\n");
            break;
        default:
            printf("Invalid grade!\n");
    }
    
    return 0;
}
```

### Vòng lặp

```c
#include <stdio.h>

int main() {
    // For loop
    printf("For loop:\n");
    for (int i = 1; i <= 5; i++) {
        printf("%d ", i);
    }
    printf("\n");
    
    // While loop
    printf("While loop:\n");
    int count = 1;
    while (count <= 5) {
        printf("%d ", count);
        count++;
    }
    printf("\n");
    
    // Do-while loop
    printf("Do-while loop:\n");
    int num = 1;
    do {
        printf("%d ", num);
        num++;
    } while (num <= 5);
    printf("\n");
    
    // Nested loops
    printf("Multiplication table:\n");
    for (int i = 1; i <= 3; i++) {
        for (int j = 1; j <= 3; j++) {
            printf("%d x %d = %d\t", i, j, i * j);
        }
        printf("\n");
    }
    
    // Break and continue
    printf("Break example:\n");
    for (int i = 1; i <= 10; i++) {
        if (i == 5) {
            break;  // Exit loop
        }
        printf("%d ", i);
    }
    printf("\n");
    
    printf("Continue example:\n");
    for (int i = 1; i <= 10; i++) {
        if (i % 2 == 0) {
            continue;  // Skip even numbers
        }
        printf("%d ", i);
    }
    printf("\n");
    
    return 0;
}
```

---

## 🧑‍🏫 Bài 5: Hàm trong C

### Định nghĩa và gọi hàm

```c
#include <stdio.h>

// Function declaration (prototype)
void greet();
void greetPerson(char name[]);
int add(int a, int b);
int max(int a, int b);

int main() {
    greet();
    greetPerson("Alice");
    
    int sum = add(5, 3);
    printf("Sum: %d\n", sum);
    
    int maximum = max(10, 20);
    printf("Maximum: %d\n", maximum);
    
    return 0;
}

// Function definitions
void greet() {
    printf("Hello, World!\n");
}

void greetPerson(char name[]) {
    printf("Hello, %s!\n", name);
}

int add(int a, int b) {
    return a + b;
}

int max(int a, int b) {
    return (a > b) ? a : b;
}
```

### Tham số và giá trị trả về

```c
#include <stdio.h>

// Pass by value
void modifyValue(int x) {
    x = 100;
    printf("Inside function: %d\n", x);
}

// Multiple return values using pointers
void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

// Return array through pointer
void getMinMax(int arr[], int size, int *min, int *max) {
    *min = arr[0];
    *max = arr[0];
    
    for (int i = 1; i < size; i++) {
        if (arr[i] < *min) *min = arr[i];
        if (arr[i] > *max) *max = arr[i];
    }
}

// Recursive function
int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

int fibonacci(int n) {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

int main() {
    // Pass by value
    int num = 10;
    modifyValue(num);
    printf("After function: %d\n", num);  // Still 10
    
    // Swap
    int x = 5, y = 10;
    printf("Before swap: x=%d, y=%d\n", x, y);
    swap(&x, &y);
    printf("After swap: x=%d, y=%d\n", x, y);
    
    // Get min max
    int arr[] = {5, 2, 8, 1, 9};
    int min, max;
    getMinMax(arr, 5, &min, &max);
    printf("Min: %d, Max: %d\n", min, max);
    
    // Factorial
    printf("5! = %d\n", factorial(5));
    
    // Fibonacci
    printf("Fibonacci(7) = %d\n", fibonacci(7));
    
    return 0;
}
```

### Scope và Storage Class

```c
#include <stdio.h>

// Global variable
int globalVar = 100;

void function1() {
    // Local variable
    int localVar = 10;
    printf("Local var: %d\n", localVar);
    printf("Global var: %d\n", globalVar);
}

void function2() {
    // Static variable - retains value between calls
    static int counter = 0;
    counter++;
    printf("Counter: %d\n", counter);
}

void function3() {
    // Register variable - stored in CPU register (if possible)
    register int i;
    for (i = 0; i < 5; i++) {
        printf("%d ", i);
    }
    printf("\n");
}

int main() {
    function1();
    
    // Static variable demo
    function2();  // Counter: 1
    function2();  // Counter: 2
    function2();  // Counter: 3
    
    function3();
    
    // Block scope
    {
        int blockVar = 50;
        printf("Block var: %d\n", blockVar);
    }
    // printf("%d\n", blockVar);  // LỖI: blockVar không tồn tại
    
    return 0;
}
```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Quản lý sinh viên

### Mô tả bài toán

Xây dựng chương trình quản lý điểm sinh viên với các chức năng:

- Nhập thông tin nhiều sinh viên (tên, điểm 3 môn)
- Tính điểm trung bình
- Xếp loại học lực
- Tìm sinh viên có điểm cao nhất/thấp nhất
- Hiển thị danh sách sinh viên

### Yêu cầu

1. Sử dụng mảng để lưu thông tin sinh viên
2. Tạo các hàm:
   - `inputStudent()` - Nhập thông tin sinh viên
   - `calculateAverage()` - Tính điểm trung bình
   - `getGrade()` - Xếp loại
   - `findTopStudent()` - Tìm sinh viên điểm cao nhất
   - `displayStudents()` - Hiển thị danh sách
3. Menu cho phép người dùng chọn chức năng
4. Validate input data

**Gợi ý cấu trúc:**

```c
#include <stdio.h>
#include <string.h>

#define MAX_STUDENTS 50
#define MAX_NAME 50

// Function prototypes
void displayMenu();
void inputStudent(char names[][MAX_NAME], float scores[][3], int *count);
float calculateAverage(float scores[]);
char getGrade(float average);
void displayStudents(char names[][MAX_NAME], float scores[][3], int count);
void findTopStudent(char names[][MAX_NAME], float scores[][3], int count);

int main() {
    char names[MAX_STUDENTS][MAX_NAME];
    float scores[MAX_STUDENTS][3];  // 3 subjects
    int studentCount = 0;
    int choice;
    
    do {
        displayMenu();
        printf("Enter choice: ");
        scanf("%d", &choice);
        
        switch (choice) {
            case 1:
                inputStudent(names, scores, &studentCount);
                break;
            case 2:
                displayStudents(names, scores, studentCount);
                break;
            case 3:
                findTopStudent(names, scores, studentCount);
                break;
            case 4:
                printf("Goodbye!\n");
                break;
            default:
                printf("Invalid choice!\n");
        }
    } while (choice != 4);
    
    return 0;
}

// TODO: Implement all functions
```

**Kết quả mong đợi:**

```text
=== STUDENT MANAGEMENT ===
1. Add Student
2. Display Students
3. Find Top Student
4. Exit
Enter choice: 1

Enter student name: John Doe
Enter Math score: 8.5
Enter Physics score: 7.5
Enter Chemistry score: 9.0
Student added successfully!

=== STUDENT LIST ===
Name: John Doe
Math: 8.50, Physics: 7.50, Chemistry: 9.00
Average: 8.33, Grade: A

Top Student: John Doe (Average: 8.33)
```
