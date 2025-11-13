# 📘 PHẦN 3: STRUCTS VÀ FILE I/O

- [📘 PHẦN 3: STRUCTS VÀ FILE I/O](#-phần-3-structs-và-file-io)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Structs và typedef](#-bài-1-structs-và-typedef)
    - [Định nghĩa struct](#định-nghĩa-struct)
    - [Struct với hàm](#struct-với-hàm)
    - [Array of structs](#array-of-structs)
  - [🧑‍🏫 Bài 2: Nested struct và pointer to struct](#-bài-2-nested-struct-và-pointer-to-struct)
    - [Nested structs](#nested-structs)
    - [Pointer to struct](#pointer-to-struct)
    - [Array of pointers to struct](#array-of-pointers-to-struct)
  - [🧑‍🏫 Bài 3: Memory layout \& memcpy với struct](#-bài-3-memory-layout--memcpy-với-struct)
    - [Memory layout và padding](#memory-layout-và-padding)
    - [Copying structs](#copying-structs)
    - [Shallow copy vs Deep copy](#shallow-copy-vs-deep-copy)
    - [memcmp để so sánh struct](#memcmp-để-so-sánh-struct)
  - [🧑‍🏫 Bài 4: File I/O cơ bản (text \& binary)](#-bài-4-file-io-cơ-bản-text--binary)
    - [File operations cơ bản](#file-operations-cơ-bản)
    - [File modes](#file-modes)
    - [Binary file I/O](#binary-file-io)
    - [File positioning](#file-positioning)
    - [Error handling với file](#error-handling-với-file)
    - [CSV file operations](#csv-file-operations)
  - [🧑‍🏫 Bài 5: Lưu/đọc cấu trúc dữ liệu từ file](#-bài-5-lưuđọc-cấu-trúc-dữ-liệu-từ-file)
    - [Lưu/đọc binary với array of structs](#lưuđọc-binary-với-array-of-structs)
    - [Lưu/đọc text format (CSV)](#lưuđọc-text-format-csv)
    - [Append data vào file](#append-data-vào-file)
    - [Update specific record trong file](#update-specific-record-trong-file)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN: Hệ thống quản lý sinh viên với file persistence](#-bài-tập-lớn-cuối-phần-hệ-thống-quản-lý-sinh-viên-với-file-persistence)
    - [Mô tả bài toán](#mô-tả-bài-toán)
    - [Yêu cầu kỹ thuật](#yêu-cầu-kỹ-thuật)
    - [Code mẫu hoàn chỉnh](#code-mẫu-hoàn-chỉnh)
    - [Hướng dẫn sử dụng](#hướng-dẫn-sử-dụng)
    - [Yêu cầu mở rộng (tự làm)](#yêu-cầu-mở-rộng-tự-làm)

## 🎯 Mục tiêu tổng quát

- Hiểu cách định nghĩa và sử dụng `struct` trong C
- Làm việc với pointer to struct, truyền struct vào hàm
- Hiểu layout bộ nhớ của struct và khi nào cần `memcpy` hoặc padding
- Sử dụng `FILE*` API để đọc/ghi file text và binary
- Thiết kế chức năng lưu/khôi phục danh sách động của struct vào file an toàn

---

## 🧑‍🏫 Bài 1: Structs và typedef

### Định nghĩa struct

Struct là cách nhóm các biến có liên quan vào một kiểu dữ liệu mới.

```c
#include <stdio.h>
#include <string.h>

// Cách 1: Định nghĩa struct
struct Point {
    int x;
    int y;
};

// Cách 2: Sử dụng typedef để rút gọn
typedef struct {
    int id;
    char name[50];
    float score;
} Student;

// Cách 3: Kết hợp struct name và typedef
typedef struct Rectangle {
    int width;
    int height;
} Rectangle;

int main() {
    // Sử dụng struct Point
    struct Point p1;
    p1.x = 10;
    p1.y = 20;
    printf("Point: (%d, %d)\n", p1.x, p1.y);

    // Sử dụng Student (không cần từ khóa struct)
    Student s;
    s.id = 1;
    strcpy(s.name, "Nguyen Van A");
    s.score = 8.5f;
    printf("Student: %d, %s, %.2f\n", s.id, s.name, s.score);

    // Khởi tạo khi khai báo
    Student s2 = {2, "Tran Thi B", 9.0f};
    printf("%d %s %.2f\n", s2.id, s2.name, s2.score);
    
    // Khởi tạo với designated initializers (C99+)
    Student s3 = {.id = 3, .score = 7.5f, .name = "Le Van C"};
    printf("Student 3: ID=%d, Name=%s, Score=%.2f\n", s3.id, s3.name, s3.score);

    return 0;
}
```

### Struct với hàm

```c
#include <stdio.h>
#include <string.h>
#include <math.h>

typedef struct {
    float x;
    float y;
} Point;

typedef struct {
    int width;
    int height;
} Rectangle;

// Tính khoảng cách giữa 2 điểm
float distance(Point p1, Point p2) {
    float dx = p2.x - p1.x;
    float dy = p2.y - p1.y;
    return sqrt(dx * dx + dy * dy);
}

// Tính diện tích hình chữ nhật
int area(Rectangle rect) {
    return rect.width * rect.height;
}

// Tính chu vi
int perimeter(Rectangle rect) {
    return 2 * (rect.width + rect.height);
}

// So sánh 2 hình chữ nhật
int isLarger(Rectangle r1, Rectangle r2) {
    return area(r1) > area(r2);
}

int main() {
    Point p1 = {0, 0};
    Point p2 = {3, 4};
    printf("Distance: %.2f\n", distance(p1, p2));
    
    Rectangle r1 = {10, 20};
    Rectangle r2 = {15, 15};
    
    printf("Rectangle 1: Area=%d, Perimeter=%d\n", area(r1), perimeter(r1));
    printf("Rectangle 2: Area=%d, Perimeter=%d\n", area(r2), perimeter(r2));
    
    if (isLarger(r1, r2)) {
        printf("Rectangle 1 is larger\n");
    } else {
        printf("Rectangle 2 is larger\n");
    }
    
    return 0;
}
```

### Array of structs

```c
#include <stdio.h>
#include <string.h>

typedef struct {
    int id;
    char name[50];
    float score;
} Student;

void printStudent(Student s) {
    printf("ID: %d, Name: %s, Score: %.2f\n", s.id, s.name, s.score);
}

void printAllStudents(Student arr[], int size) {
    printf("\n=== STUDENT LIST ===\n");
    for (int i = 0; i < size; i++) {
        printf("%d. ", i + 1);
        printStudent(arr[i]);
    }
}

float averageScore(Student arr[], int size) {
    float total = 0;
    for (int i = 0; i < size; i++) {
        total += arr[i].score;
    }
    return total / size;
}

Student findTopStudent(Student arr[], int size) {
    Student top = arr[0];
    for (int i = 1; i < size; i++) {
        if (arr[i].score > top.score) {
            top = arr[i];
        }
    }
    return top;
}

int main() {
    Student students[5] = {
        {1, "Nguyen Van A", 8.5f},
        {2, "Tran Thi B", 9.0f},
        {3, "Le Van C", 7.5f},
        {4, "Pham Thi D", 8.8f},
        {5, "Hoang Van E", 9.2f}
    };
    
    printAllStudents(students, 5);
    
    printf("\nAverage Score: %.2f\n", averageScore(students, 5));
    
    Student top = findTopStudent(students, 5);
    printf("\nTop Student: ");
    printStudent(top);
    
    return 0;
}
```

**Lưu ý về sizeof:**

```c
#include <stdio.h>

typedef struct {
    char c;      // 1 byte
    int i;       // 4 bytes
    short s;     // 2 bytes
} Example;

int main() {
    printf("Size of char: %lu\n", sizeof(char));
    printf("Size of int: %lu\n", sizeof(int));
    printf("Size of short: %lu\n", sizeof(short));
    printf("Expected: %lu\n", sizeof(char) + sizeof(int) + sizeof(short));
    printf("Actual struct size: %lu\n", sizeof(Example));
    // Kết quả có thể là 12 bytes thay vì 7 do padding!
    
    return 0;
}
```

Các field trong `struct` có thể có padding do alignment. Kích thước `sizeof` không phải là tổng trực tiếp của kích thước các thành phần.

---

## 🧑‍🏫 Bài 2: Nested struct và pointer to struct

### Nested structs

```c
#include <stdio.h>
#include <string.h>

typedef struct {
    int day;
    int month;
    int year;
} Date;

typedef struct {
    char street[100];
    char city[50];
    char country[50];
} Address;

typedef struct {
    int id;
    char name[50];
    Date dob;        // Nested struct
    Address addr;    // Nested struct
    float score;
} Student;

void printDate(Date d) {
    printf("%02d/%02d/%04d", d.day, d.month, d.year);
}

void printAddress(Address a) {
    printf("%s, %s, %s", a.street, a.city, a.country);
}

void printStudent(Student s) {
    printf("\n=== STUDENT INFO ===\n");
    printf("ID: %d\n", s.id);
    printf("Name: %s\n", s.name);
    printf("DOB: ");
    printDate(s.dob);
    printf("\nAddress: ");
    printAddress(s.addr);
    printf("\nScore: %.2f\n", s.score);
}

int main() {
    Student s = {
        .id = 1,
        .name = "Nguyen Van A",
        .dob = {15, 5, 2000},
        .addr = {"123 Le Loi", "Ho Chi Minh", "Vietnam"},
        .score = 8.5f
    };
    
    printStudent(s);
    
    // Truy cập nested struct
    printf("\nBirth year: %d\n", s.dob.year);
    printf("City: %s\n", s.addr.city);
    
    // Thay đổi giá trị
    s.dob.year = 2001;
    strcpy(s.addr.city, "Hanoi");
    
    printf("\nAfter modification:\n");
    printf("Birth year: %d\n", s.dob.year);
    printf("City: %s\n", s.addr.city);
    
    return 0;
}
```

### Pointer to struct

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    char name[50];
    float score;
} Student;

// Pass by value - copy toàn bộ struct
void printByValue(Student s) {
    printf("ID: %d, Name: %s, Score: %.2f\n", s.id, s.name, s.score);
}

// Pass by reference - truyền con trỏ (hiệu quả hơn)
void printByReference(const Student *s) {
    // Sử dụng -> để truy cập member qua con trỏ
    printf("ID: %d, Name: %s, Score: %.2f\n", s->id, s->name, s->score);
}

// Modify struct qua con trỏ
void updateScore(Student *s, float newScore) {
    s->score = newScore;
}

// Tạo student mới trên heap
Student* createStudent(int id, const char *name, float score) {
    Student *s = (Student*)malloc(sizeof(Student));
    if (s == NULL) return NULL;
    
    s->id = id;
    strcpy(s->name, name);
    s->score = score;
    
    return s;
}

int main() {
    // Student trên stack
    Student s1 = {1, "Nguyen Van A", 8.5f};
    
    printf("Print by value:\n");
    printByValue(s1);
    
    printf("\nPrint by reference:\n");
    printByReference(&s1);
    
    // Sử dụng con trỏ
    Student *ptr = &s1;
    
    // Hai cách truy cập member:
    printf("\nUsing (*ptr).member: %d\n", (*ptr).id);
    printf("Using ptr->member: %d\n", ptr->id);  // Cách này ngắn gọn hơn
    
    // Thay đổi qua con trỏ
    updateScore(ptr, 9.0f);
    printf("After update: %.2f\n", s1.score);
    
    // Student trên heap
    Student *s2 = createStudent(2, "Tran Thi B", 7.5f);
    if (s2 == NULL) {
        printf("Failed to create student\n");
        return 1;
    }
    
    printf("\nStudent on heap:\n");
    printByReference(s2);
    
    free(s2);  // Đừng quên giải phóng!
    
    return 0;
}
```

### Array of pointers to struct

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    char name[50];
    float score;
} Student;

Student* createStudent(int id, const char *name, float score) {
    Student *s = (Student*)malloc(sizeof(Student));
    if (s) {
        s->id = id;
        strcpy(s->name, name);
        s->score = score;
    }
    return s;
}

void freeStudents(Student *arr[], int count) {
    for (int i = 0; i < count; i++) {
        free(arr[i]);
    }
}

void sortByScore(Student *arr[], int count) {
    for (int i = 0; i < count - 1; i++) {
        for (int j = 0; j < count - i - 1; j++) {
            if (arr[j]->score < arr[j + 1]->score) {
                Student *temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}

int main() {
    Student *students[3];
    
    students[0] = createStudent(1, "Nguyen Van A", 8.5f);
    students[1] = createStudent(2, "Tran Thi B", 9.0f);
    students[2] = createStudent(3, "Le Van C", 7.5f);
    
    // Check allocation
    for (int i = 0; i < 3; i++) {
        if (students[i] == NULL) {
            printf("Memory allocation failed!\n");
            freeStudents(students, i);
            return 1;
        }
    }
    
    printf("Before sorting:\n");
    for (int i = 0; i < 3; i++) {
        printf("%d. %s - %.2f\n", students[i]->id, students[i]->name, students[i]->score);
    }
    
    sortByScore(students, 3);
    
    printf("\nAfter sorting by score:\n");
    for (int i = 0; i < 3; i++) {
        printf("%d. %s - %.2f\n", students[i]->id, students[i]->name, students[i]->score);
    }
    
    freeStudents(students, 3);
    return 0;
}
```

---

## 🧑‍🏫 Bài 3: Memory layout & memcpy với struct

### Memory layout và padding

```c
#include <stdio.h>
#include <stddef.h>

// Struct không tối ưu - nhiều padding
typedef struct {
    char c;      // 1 byte + 3 bytes padding
    int i;       // 4 bytes
    char d;      // 1 byte + 3 bytes padding
    int j;       // 4 bytes
} BadAlign;      // Tổng: 16 bytes

// Struct tối ưu - ít padding
typedef struct {
    int i;       // 4 bytes
    int j;       // 4 bytes
    char c;      // 1 byte
    char d;      // 1 byte + 2 bytes padding
} GoodAlign;     // Tổng: 12 bytes

int main() {
    printf("BadAlign size: %lu bytes\n", sizeof(BadAlign));
    printf("GoodAlign size: %lu bytes\n", sizeof(GoodAlign));
    
    // Xem offset của từng field
    printf("\nBadAlign offsets:\n");
    printf("  c: %lu\n", offsetof(BadAlign, c));
    printf("  i: %lu\n", offsetof(BadAlign, i));
    printf("  d: %lu\n", offsetof(BadAlign, d));
    printf("  j: %lu\n", offsetof(BadAlign, j));
    
    printf("\nGoodAlign offsets:\n");
    printf("  i: %lu\n", offsetof(GoodAlign, i));
    printf("  j: %lu\n", offsetof(GoodAlign, j));
    printf("  c: %lu\n", offsetof(GoodAlign, c));
    printf("  d: %lu\n", offsetof(GoodAlign, d));
    
    return 0;
}
```

### Copying structs

```c
#include <stdio.h>
#include <string.h>

typedef struct {
    int id;
    char name[50];
    float score;
} Student;

int main() {
    Student s1 = {1, "Nguyen Van A", 8.5f};
    Student s2, s3;
    
    // Cách 1: Assignment operator (copy từng field)
    s2 = s1;
    
    // Cách 2: memcpy
    memcpy(&s3, &s1, sizeof(Student));
    
    printf("Original: %d %s %.2f\n", s1.id, s1.name, s1.score);
    printf("Copy (=): %d %s %.2f\n", s2.id, s2.name, s2.score);
    printf("Copy (memcpy): %d %s %.2f\n", s3.id, s3.name, s3.score);
    
    // Thay đổi s1 không ảnh hưởng đến s2, s3
    s1.id = 999;
    strcpy(s1.name, "Changed");
    s1.score = 10.0f;
    
    printf("\nAfter modifying s1:\n");
    printf("s1: %d %s %.2f\n", s1.id, s1.name, s1.score);
    printf("s2: %d %s %.2f\n", s2.id, s2.name, s2.score);
    printf("s3: %d %s %.2f\n", s3.id, s3.name, s3.score);
    
    return 0;
}
```

### Shallow copy vs Deep copy

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    char *name;  // Con trỏ đến dynamic memory
    float score;
} Student;

Student createStudent(int id, const char *name, float score) {
    Student s;
    s.id = id;
    s.name = (char*)malloc(strlen(name) + 1);
    strcpy(s.name, name);
    s.score = score;
    return s;
}

void freeStudent(Student *s) {
    if (s->name) {
        free(s->name);
        s->name = NULL;
    }
}

// Shallow copy - chỉ copy con trỏ
Student shallowCopy(Student s) {
    return s;  // NGUY HIỂM! Cả 2 struct cùng trỏ đến 1 vùng nhớ
}

// Deep copy - copy cả vùng nhớ được trỏ đến
Student deepCopy(Student s) {
    Student copy = s;
    copy.name = (char*)malloc(strlen(s.name) + 1);
    strcpy(copy.name, s.name);
    return copy;
}

int main() {
    Student s1 = createStudent(1, "Nguyen Van A", 8.5f);
    
    // Shallow copy - NGUY HIỂM
    Student s2 = shallowCopy(s1);
    printf("s1: %s\n", s1.name);
    printf("s2: %s\n", s2.name);
    
    // Nếu thay đổi s2.name, s1.name cũng thay đổi!
    strcpy(s2.name, "Changed");
    printf("After modifying s2:\n");
    printf("s1: %s (also changed!)\n", s1.name);
    printf("s2: %s\n", s2.name);
    
    // Deep copy - AN TOÀN
    Student s3 = deepCopy(s1);
    strcpy(s3.name, "Different");
    printf("\nWith deep copy:\n");
    printf("s1: %s\n", s1.name);
    printf("s3: %s (independent)\n", s3.name);
    
    // Free memory
    freeStudent(&s1);
    // freeStudent(&s2);  // KHÔNG free s2.name vì nó đã được free qua s1
    freeStudent(&s3);
    
    return 0;
}
```

### memcmp để so sánh struct

```c
#include <stdio.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    int id;
    char name[20];
} Item;

int main() {
    Point p1 = {10, 20};
    Point p2 = {10, 20};
    Point p3 = {30, 40};
    
    // So sánh struct không có padding - OK
    if (memcmp(&p1, &p2, sizeof(Point)) == 0) {
        printf("p1 and p2 are equal\n");
    }
    
    if (memcmp(&p1, &p3, sizeof(Point)) != 0) {
        printf("p1 and p3 are different\n");
    }
    
    // Với struct có padding - CẢNH BÁO!
    Item i1 = {1, "Apple"};
    Item i2 = {1, "Apple"};
    
    // memcmp có thể fail nếu padding chứa giá trị garbage khác nhau
    // Nên so sánh từng field:
    if (i1.id == i2.id && strcmp(i1.name, i2.name) == 0) {
        printf("i1 and i2 are equal (field by field)\n");
    }
    
    return 0;
}
```

**Lưu ý quan trọng:**

- `memcpy` và assignment operator (`=`) đều copy toàn bộ struct
- Với struct chứa con trỏ, cần implement deep copy manually
- `memcmp` không đáng tin cậy với struct có padding
- Sắp xếp lại thứ tự field để giảm padding và tiết kiệm bộ nhớ

---

## 🧑‍🏫 Bài 4: File I/O cơ bản (text & binary)

### File operations cơ bản

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    FILE *file;
    
    // 1. Ghi file text
    file = fopen("data.txt", "w");
    if (file == NULL) {
        perror("Error opening file for writing");
        return 1;
    }
    
    fprintf(file, "Hello, World!\n");
    fprintf(file, "Number: %d\n", 42);
    fprintf(file, "Float: %.2f\n", 3.14);
    
    fclose(file);
    printf("File written successfully\n");
    
    // 2. Đọc file text - fgets
    file = fopen("data.txt", "r");
    if (file == NULL) {
        perror("Error opening file for reading");
        return 1;
    }
    
    char line[256];
    printf("\nReading file line by line:\n");
    while (fgets(line, sizeof(line), file) != NULL) {
        printf("%s", line);
    }
    
    fclose(file);
    
    // 3. Đọc file text - fscanf
    file = fopen("data.txt", "r");
    if (file == NULL) {
        perror("Error opening file for reading");
        return 1;
    }
    
    char buffer[100];
    int num;
    float f;
    
    fscanf(file, "%s %s", buffer, buffer);  // "Hello," "World!"
    fscanf(file, "%s %d", buffer, &num);    // "Number:" 42
    fscanf(file, "%s %f", buffer, &f);      // "Float:" 3.14
    
    printf("\nParsed values: num=%d, float=%.2f\n", num, f);
    
    fclose(file);
    
    return 0;
}
```

### File modes

```c
#include <stdio.h>

/*
 * File modes:
 * "r"  - Read (file must exist)
 * "w"  - Write (create new or truncate existing)
 * "a"  - Append (create if not exist)
 * "r+" - Read/Write (file must exist)
 * "w+" - Read/Write (create new or truncate)
 * "a+" - Read/Append
 * 
 * Binary modes: add 'b'
 * "rb", "wb", "ab", "r+b", "w+b", "a+b"
 */

int main() {
    FILE *file;
    
    // Append mode
    file = fopen("log.txt", "a");
    if (file) {
        fprintf(file, "New log entry\n");
        fclose(file);
    }
    
    // Read/Write mode
    file = fopen("data.txt", "r+");
    if (file) {
        char buffer[100];
        fgets(buffer, sizeof(buffer), file);
        printf("First line: %s", buffer);
        
        // Seek to beginning and write
        fseek(file, 0, SEEK_SET);
        fprintf(file, "Modified");
        
        fclose(file);
    }
    
    return 0;
}
```

### Binary file I/O

```c
#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int id;
    char name[50];
    float score;
} Student;

int main() {
    // Write binary
    FILE *file = fopen("students.bin", "wb");
    if (!file) {
        perror("Cannot create binary file");
        return 1;
    }
    
    Student s1 = {1, "Nguyen Van A", 8.5f};
    Student s2 = {2, "Tran Thi B", 9.0f};
    
    fwrite(&s1, sizeof(Student), 1, file);
    fwrite(&s2, sizeof(Student), 1, file);
    
    fclose(file);
    printf("Binary file written\n");
    
    // Read binary
    file = fopen("students.bin", "rb");
    if (!file) {
        perror("Cannot open binary file");
        return 1;
    }
    
    Student temp;
    printf("\nReading from binary file:\n");
    
    while (fread(&temp, sizeof(Student), 1, file) == 1) {
        printf("ID: %d, Name: %s, Score: %.2f\n", temp.id, temp.name, temp.score);
    }
    
    fclose(file);
    
    return 0;
}
```

### File positioning

```c
#include <stdio.h>

int main() {
    FILE *file = fopen("test.txt", "w+");
    if (!file) return 1;
    
    fprintf(file, "ABCDEFGHIJ");
    
    // ftell - lấy vị trí hiện tại
    long pos = ftell(file);
    printf("Current position: %ld\n", pos);
    
    // fseek - di chuyển con trỏ file
    fseek(file, 0, SEEK_SET);  // Về đầu file
    printf("After SEEK_SET: %ld\n", ftell(file));
    
    fseek(file, 3, SEEK_SET);  // Di chuyển đến byte thứ 3
    char c;
    fread(&c, 1, 1, file);
    printf("Character at position 3: %c\n", c);
    
    fseek(file, -2, SEEK_END);  // 2 bytes từ cuối file
    printf("Position from end: %ld\n", ftell(file));
    
    fseek(file, 2, SEEK_CUR);  // Di chuyển 2 bytes từ vị trí hiện tại
    printf("After SEEK_CUR: %ld\n", ftell(file));
    
    // rewind - về đầu file
    rewind(file);
    printf("After rewind: %ld\n", ftell(file));
    
    fclose(file);
    return 0;
}
```

### Error handling với file

```c
#include <stdio.h>
#include <errno.h>
#include <string.h>

int main() {
    FILE *file = fopen("nonexistent.txt", "r");
    
    if (file == NULL) {
        // Cách 1: perror
        perror("Error opening file");
        
        // Cách 2: strerror và errno
        printf("Error: %s\n", strerror(errno));
        
        // Cách 3: Kiểm tra errno cụ thể
        if (errno == ENOENT) {
            printf("File does not exist\n");
        }
        
        return 1;
    }
    
    // Kiểm tra EOF và error
    char buffer[100];
    while (fgets(buffer, sizeof(buffer), file) != NULL) {
        printf("%s", buffer);
    }
    
    if (feof(file)) {
        printf("End of file reached\n");
    } else if (ferror(file)) {
        printf("Error reading file\n");
    }
    
    // Clear error indicator
    clearerr(file);
    
    fclose(file);
    return 0;
}
```

### CSV file operations

```c
#include <stdio.h>
#include <string.h>

typedef struct {
    int id;
    char name[50];
    float score;
} Student;

int writeCSV(const char *filename, Student students[], int count) {
    FILE *file = fopen(filename, "w");
    if (!file) return -1;
    
    // Header
    fprintf(file, "ID,Name,Score\n");
    
    // Data
    for (int i = 0; i < count; i++) {
        fprintf(file, "%d,%s,%.2f\n", 
                students[i].id, 
                students[i].name, 
                students[i].score);
    }
    
    fclose(file);
    return 0;
}

int readCSV(const char *filename, Student students[], int maxCount) {
    FILE *file = fopen(filename, "r");
    if (!file) return -1;
    
    char line[256];
    int count = 0;
    
    // Skip header
    fgets(line, sizeof(line), file);
    
    // Read data
    while (fgets(line, sizeof(line), file) && count < maxCount) {
        sscanf(line, "%d,%49[^,],%f", 
               &students[count].id,
               students[count].name,
               &students[count].score);
        count++;
    }
    
    fclose(file);
    return count;
}

int main() {
    Student students[] = {
        {1, "Nguyen Van A", 8.5f},
        {2, "Tran Thi B", 9.0f},
        {3, "Le Van C", 7.5f}
    };
    
    // Write CSV
    if (writeCSV("students.csv", students, 3) == 0) {
        printf("CSV written successfully\n");
    }
    
    // Read CSV
    Student loaded[10];
    int count = readCSV("students.csv", loaded, 10);
    
    if (count > 0) {
        printf("\nLoaded %d students:\n", count);
        for (int i = 0; i < count; i++) {
            printf("%d. %s - %.2f\n", 
                   loaded[i].id, 
                   loaded[i].name, 
                   loaded[i].score);
        }
    }
    
    return 0;
}
```

Lưu ý xử lý lỗi: luôn kiểm tra trả về của `fopen`, `fread`, `fwrite` để đảm bảo thao tác file thành công.

---

## 🧑‍🏫 Bài 5: Lưu/đọc cấu trúc dữ liệu từ file

### Lưu/đọc binary với array of structs

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    char name[50];
    float score;
} Student;

int saveStudentsBinary(const char *filename, Student *arr, size_t count) {
    FILE *file = fopen(filename, "wb");
    if (!file) {
        perror("Cannot open file for writing");
        return -1;
    }
    
    // Ghi số lượng trước
    if (fwrite(&count, sizeof(size_t), 1, file) != 1) {
        fclose(file);
        return -2;
    }
    
    // Ghi mảng struct
    if (fwrite(arr, sizeof(Student), count, file) != count) {
        fclose(file);
        return -3;
    }
    
    fclose(file);
    return 0;
}

Student* loadStudentsBinary(const char *filename, size_t *outCount) {
    FILE *file = fopen(filename, "rb");
    if (!file) {
        perror("Cannot open file for reading");
        return NULL;
    }
    
    size_t count;
    if (fread(&count, sizeof(size_t), 1, file) != 1) {
        fclose(file);
        return NULL;
    }
    
    Student *arr = (Student*)malloc(sizeof(Student) * count);
    if (!arr) {
        fclose(file);
        return NULL;
    }
    
    if (fread(arr, sizeof(Student), count, file) != count) {
        free(arr);
        fclose(file);
        return NULL;
    }
    
    fclose(file);
    *outCount = count;
    return arr;
}

int main() {
    // Tạo dữ liệu test
    Student students[] = {
        {1, "Nguyen Van A", 8.5f},
        {2, "Tran Thi B", 9.0f},
        {3, "Le Van C", 7.5f}
    };
    
    // Save
    printf("Saving students to binary file...\n");
    if (saveStudentsBinary("students.bin", students, 3) != 0) {
        printf("Save failed!\n");
        return 1;
    }
    printf("Saved successfully!\n");
    
    // Load
    printf("\nLoading students from binary file...\n");
    size_t count;
    Student *loaded = loadStudentsBinary("students.bin", &count);
    
    if (!loaded) {
        printf("Load failed!\n");
        return 1;
    }
    
    printf("Loaded %zu students:\n", count);
    for (size_t i = 0; i < count; i++) {
        printf("%d. ID=%d, Name=%s, Score=%.2f\n",
               (int)(i + 1), loaded[i].id, loaded[i].name, loaded[i].score);
    }
    
    free(loaded);
    return 0;
}
```

### Lưu/đọc text format (CSV)

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    char name[50];
    float score;
} Student;

int saveStudentsCSV(const char *filename, Student *arr, size_t count) {
    FILE *file = fopen(filename, "w");
    if (!file) {
        perror("Cannot create CSV file");
        return -1;
    }
    
    // Header
    fprintf(file, "ID,Name,Score\n");
    
    // Data rows
    for (size_t i = 0; i < count; i++) {
        fprintf(file, "%d,%s,%.2f\n", 
                arr[i].id, arr[i].name, arr[i].score);
    }
    
    fclose(file);
    return 0;
}

Student* loadStudentsCSV(const char *filename, size_t *outCount) {
    FILE *file = fopen(filename, "r");
    if (!file) {
        perror("Cannot open CSV file");
        return NULL;
    }
    
    // Allocate initial array
    size_t capacity = 10;
    size_t count = 0;
    Student *arr = (Student*)malloc(sizeof(Student) * capacity);
    
    if (!arr) {
        fclose(file);
        return NULL;
    }
    
    char line[256];
    
    // Skip header
    fgets(line, sizeof(line), file);
    
    // Read data
    while (fgets(line, sizeof(line), file)) {
        // Resize if needed
        if (count >= capacity) {
            capacity *= 2;
            Student *newArr = (Student*)realloc(arr, sizeof(Student) * capacity);
            if (!newArr) {
                free(arr);
                fclose(file);
                return NULL;
            }
            arr = newArr;
        }
        
        // Parse CSV line
        if (sscanf(line, "%d,%49[^,],%f",
                   &arr[count].id,
                   arr[count].name,
                   &arr[count].score) == 3) {
            count++;
        }
    }
    
    fclose(file);
    *outCount = count;
    return arr;
}

int main() {
    Student students[] = {
        {1, "Nguyen Van A", 8.5f},
        {2, "Tran Thi B", 9.0f},
        {3, "Le Van C", 7.5f}
    };
    
    // Save CSV
    printf("Saving to CSV...\n");
    if (saveStudentsCSV("students.csv", students, 3) == 0) {
        printf("CSV saved successfully!\n");
    }
    
    // Load CSV
    printf("\nLoading from CSV...\n");
    size_t count;
    Student *loaded = loadStudentsCSV("students.csv", &count);
    
    if (loaded) {
        printf("Loaded %zu students:\n", count);
        for (size_t i = 0; i < count; i++) {
            printf("%d. ID=%d, Name=%s, Score=%.2f\n",
                   (int)(i + 1), loaded[i].id, loaded[i].name, loaded[i].score);
        }
        free(loaded);
    }
    
    return 0;
}
```

### Append data vào file

```c
#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int id;
    char name[50];
    float score;
} Student;

int appendStudentBinary(const char *filename, Student s) {
    FILE *file = fopen(filename, "ab");
    if (!file) return -1;
    
    fwrite(&s, sizeof(Student), 1, file);
    fclose(file);
    return 0;
}

int appendStudentCSV(const char *filename, Student s) {
    FILE *file = fopen(filename, "a");
    if (!file) return -1;
    
    fprintf(file, "%d,%s,%.2f\n", s.id, s.name, s.score);
    fclose(file);
    return 0;
}

int countStudentsInBinaryFile(const char *filename) {
    FILE *file = fopen(filename, "rb");
    if (!file) return 0;
    
    fseek(file, 0, SEEK_END);
    long size = ftell(file);
    fclose(file);
    
    return (int)(size / sizeof(Student));
}

int main() {
    Student students[] = {
        {1, "Nguyen Van A", 8.5f},
        {2, "Tran Thi B", 9.0f}
    };
    
    // Create initial file
    FILE *file = fopen("students.bin", "wb");
    if (file) {
        fwrite(students, sizeof(Student), 2, file);
        fclose(file);
    }
    
    printf("Initial count: %d\n", countStudentsInBinaryFile("students.bin"));
    
    // Append new student
    Student newStudent = {3, "Le Van C", 7.5f};
    appendStudentBinary("students.bin", newStudent);
    
    printf("After append: %d\n", countStudentsInBinaryFile("students.bin"));
    
    // Verify by reading all
    file = fopen("students.bin", "rb");
    if (file) {
        Student temp;
        printf("\nAll students:\n");
        while (fread(&temp, sizeof(Student), 1, file) == 1) {
            printf("ID=%d, Name=%s, Score=%.2f\n", temp.id, temp.name, temp.score);
        }
        fclose(file);
    }
    
    return 0;
}
```

### Update specific record trong file

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    char name[50];
    float score;
} Student;

int updateStudentScore(const char *filename, int id, float newScore) {
    FILE *file = fopen(filename, "r+b");
    if (!file) return -1;
    
    Student temp;
    long position;
    int found = 0;
    
    while (fread(&temp, sizeof(Student), 1, file) == 1) {
        if (temp.id == id) {
            position = ftell(file) - sizeof(Student);
            temp.score = newScore;
            
            fseek(file, position, SEEK_SET);
            fwrite(&temp, sizeof(Student), 1, file);
            
            found = 1;
            break;
        }
    }
    
    fclose(file);
    return found ? 0 : -1;
}

int deleteStudent(const char *filename, int id) {
    FILE *file = fopen(filename, "rb");
    if (!file) return -1;
    
    FILE *temp = fopen("temp.bin", "wb");
    if (!temp) {
        fclose(file);
        return -1;
    }
    
    Student s;
    int found = 0;
    
    while (fread(&s, sizeof(Student), 1, file) == 1) {
        if (s.id != id) {
            fwrite(&s, sizeof(Student), 1, temp);
        } else {
            found = 1;
        }
    }
    
    fclose(file);
    fclose(temp);
    
    if (found) {
        remove(filename);
        rename("temp.bin", filename);
        return 0;
    } else {
        remove("temp.bin");
        return -1;
    }
}

int main() {
    // Create test file
    Student students[] = {
        {1, "Nguyen Van A", 8.5f},
        {2, "Tran Thi B", 9.0f},
        {3, "Le Van C", 7.5f}
    };
    
    FILE *file = fopen("students.bin", "wb");
    if (file) {
        fwrite(students, sizeof(Student), 3, file);
        fclose(file);
    }
    
    // Update score
    printf("Updating student ID=2 score to 9.5...\n");
    if (updateStudentScore("students.bin", 2, 9.5f) == 0) {
        printf("Updated successfully!\n");
    }
    
    // Delete student
    printf("\nDeleting student ID=3...\n");
    if (deleteStudent("students.bin", 3) == 0) {
        printf("Deleted successfully!\n");
    }
    
    // Verify
    file = fopen("students.bin", "rb");
    if (file) {
        Student temp;
        printf("\nRemaining students:\n");
        while (fread(&temp, sizeof(Student), 1, file) == 1) {
            printf("ID=%d, Name=%s, Score=%.2f\n", temp.id, temp.name, temp.score);
        }
        fclose(file);
    }
    
    return 0;
}
```

**Ghi chú quan trọng:**

- **Binary format:** Nhanh, compact nhưng không portable giữa các hệ thống khác nhau (endianness, struct padding)
- **Text format (CSV/JSON):** Dễ debug, portable, human-readable nhưng chậm hơn và tốn không gian hơn
- Luôn kiểm tra return value của file operations
- Đóng file sau khi sử dụng để tránh data corruption
- Xử lý realloc khi load dynamic data từ file

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Hệ thống quản lý sinh viên với file persistence

### Mô tả bài toán

Xây dựng chương trình quản lý danh sách sinh viên với các chức năng:

- Thêm sinh viên mới (tự động mở rộng mảng động)
- Xóa sinh viên theo ID
- Tìm kiếm sinh viên
- Sửa thông tin sinh viên
- Sắp xếp danh sách (theo ID, tên, điểm)
- Hiển thị danh sách
- **Lưu vào file** (cả binary và CSV)
- **Load từ file** khi khởi động
- Giải phóng bộ nhớ đúng cách

### Yêu cầu kỹ thuật

1. **Cấu trúc dữ liệu:**
   - Sử dụng `struct` để lưu thông tin sinh viên (ID, Name, DOB, Address, Score)
   - Sử dụng dynamic array để quản lý danh sách
   - Tự động resize khi cần

2. **File operations:**
   - Hỗ trợ lưu/đọc binary format (`students.bin`)
   - Hỗ trợ export/import CSV format (`students.csv`)
   - Tự động load khi khởi động nếu file tồn tại
   - Tự động save trước khi thoát

3. **Error handling:**
   - Kiểm tra NULL pointers
   - Xử lý lỗi file I/O
   - Validate input từ người dùng
   - Không memory leaks

### Code mẫu hoàn chỉnh

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INITIAL_CAPACITY 5
#define BINARY_FILE "students.bin"
#define CSV_FILE "students.csv"

typedef struct {
    int day;
    int month;
    int year;
} Date;

typedef struct {
    int id;
    char name[50];
    Date dob;
    char address[100];
    float score;
} Student;

typedef struct {
    Student *data;
    size_t size;
    size_t capacity;
} StudentList;

// ============ Dynamic Array Functions ============

StudentList* createList() {
    StudentList *list = (StudentList*)malloc(sizeof(StudentList));
    if (!list) return NULL;
    
    list->data = (Student*)malloc(sizeof(Student) * INITIAL_CAPACITY);
    if (!list->data) {
        free(list);
        return NULL;
    }
    
    list->size = 0;
    list->capacity = INITIAL_CAPACITY;
    return list;
}

void freeList(StudentList *list) {
    if (list) {
        free(list->data);
        free(list);
    }
}

int addStudent(StudentList *list, Student s) {
    if (list->size >= list->capacity) {
        size_t newCapacity = list->capacity * 2;
        Student *newData = (Student*)realloc(list->data, sizeof(Student) * newCapacity);
        if (!newData) return -1;
        
        list->data = newData;
        list->capacity = newCapacity;
    }
    
    list->data[list->size++] = s;
    return 0;
}

int removeStudent(StudentList *list, int id) {
    for (size_t i = 0; i < list->size; i++) {
        if (list->data[i].id == id) {
            for (size_t j = i; j < list->size - 1; j++) {
                list->data[j] = list->data[j + 1];
            }
            list->size--;
            return 0;
        }
    }
    return -1;
}

Student* findStudent(StudentList *list, int id) {
    for (size_t i = 0; i < list->size; i++) {
        if (list->data[i].id == id) {
            return &list->data[i];
        }
    }
    return NULL;
}

void sortByScore(StudentList *list) {
    for (size_t i = 0; i < list->size - 1; i++) {
        for (size_t j = 0; j < list->size - i - 1; j++) {
            if (list->data[j].score < list->data[j + 1].score) {
                Student temp = list->data[j];
                list->data[j] = list->data[j + 1];
                list->data[j + 1] = temp;
            }
        }
    }
}

void sortByName(StudentList *list) {
    for (size_t i = 0; i < list->size - 1; i++) {
        for (size_t j = 0; j < list->size - i - 1; j++) {
            if (strcmp(list->data[j].name, list->data[j + 1].name) > 0) {
                Student temp = list->data[j];
                list->data[j] = list->data[j + 1];
                list->data[j + 1] = temp;
            }
        }
    }
}

void printStudent(const Student *s) {
    printf("ID: %d | Name: %-20s | DOB: %02d/%02d/%04d | Score: %.2f\n",
           s->id, s->name, s->dob.day, s->dob.month, s->dob.year, s->score);
    printf("Address: %s\n", s->address);
}

void printList(const StudentList *list) {
    if (list->size == 0) {
        printf("No students in the list.\n");
        return;
    }
    
    printf("\n========== STUDENT LIST (Total: %zu) ==========\n", list->size);
    for (size_t i = 0; i < list->size; i++) {
        printf("\n[%zu] ", i + 1);
        printStudent(&list->data[i]);
    }
    printf("===============================================\n");
}

// ============ File I/O Functions ============

int saveBinary(const StudentList *list, const char *filename) {
    FILE *file = fopen(filename, "wb");
    if (!file) {
        perror("Cannot save binary file");
        return -1;
    }
    
    fwrite(&list->size, sizeof(size_t), 1, file);
    fwrite(list->data, sizeof(Student), list->size, file);
    
    fclose(file);
    return 0;
}

int loadBinary(StudentList *list, const char *filename) {
    FILE *file = fopen(filename, "rb");
    if (!file) return -1;
    
    size_t count;
    if (fread(&count, sizeof(size_t), 1, file) != 1) {
        fclose(file);
        return -1;
    }
    
    if (count > list->capacity) {
        Student *newData = (Student*)realloc(list->data, sizeof(Student) * count);
        if (!newData) {
            fclose(file);
            return -1;
        }
        list->data = newData;
        list->capacity = count;
    }
    
    if (fread(list->data, sizeof(Student), count, file) != count) {
        fclose(file);
        return -1;
    }
    
    list->size = count;
    fclose(file);
    return 0;
}

int saveCSV(const StudentList *list, const char *filename) {
    FILE *file = fopen(filename, "w");
    if (!file) {
        perror("Cannot save CSV file");
        return -1;
    }
    
    fprintf(file, "ID,Name,Day,Month,Year,Address,Score\n");
    
    for (size_t i = 0; i < list->size; i++) {
        const Student *s = &list->data[i];
        fprintf(file, "%d,%s,%d,%d,%d,%s,%.2f\n",
                s->id, s->name, s->dob.day, s->dob.month, s->dob.year,
                s->address, s->score);
    }
    
    fclose(file);
    return 0;
}

int loadCSV(StudentList *list, const char *filename) {
    FILE *file = fopen(filename, "r");
    if (!file) return -1;
    
    char line[512];
    fgets(line, sizeof(line), file);  // Skip header
    
    while (fgets(line, sizeof(line), file)) {
        Student s;
        char *token = strtok(line, ",");
        if (!token) continue;
        
        s.id = atoi(token);
        
        token = strtok(NULL, ",");
        if (!token) continue;
        strncpy(s.name, token, 49);
        s.name[49] = '\0';
        
        token = strtok(NULL, ",");
        if (!token) continue;
        s.dob.day = atoi(token);
        
        token = strtok(NULL, ",");
        if (!token) continue;
        s.dob.month = atoi(token);
        
        token = strtok(NULL, ",");
        if (!token) continue;
        s.dob.year = atoi(token);
        
        token = strtok(NULL, ",");
        if (!token) continue;
        strncpy(s.address, token, 99);
        s.address[99] = '\0';
        
        token = strtok(NULL, ",");
        if (!token) continue;
        s.score = atof(token);
        
        addStudent(list, s);
    }
    
    fclose(file);
    return 0;
}

// ============ Main Program ============

void showMenu() {
    printf("\n========== STUDENT MANAGEMENT SYSTEM ==========\n");
    printf("1. Add new student\n");
    printf("2. Remove student by ID\n");
    printf("3. Find student by ID\n");
    printf("4. Update student score\n");
    printf("5. Sort by score\n");
    printf("6. Sort by name\n");
    printf("7. Display all students\n");
    printf("8. Save to binary file\n");
    printf("9. Save to CSV file\n");
    printf("0. Exit\n");
    printf("===============================================\n");
    printf("Your choice: ");
}

int main() {
    StudentList *list = createList();
    if (!list) {
        printf("Failed to create student list!\n");
        return 1;
    }
    
    // Auto-load from binary file if exists
    if (loadBinary(list, BINARY_FILE) == 0) {
        printf("Loaded %zu students from %s\n", list->size, BINARY_FILE);
    }
    
    int choice;
    do {
        showMenu();
        scanf("%d", &choice);
        getchar();  // Clear newline
        
        switch (choice) {
            case 1: {
                Student s;
                printf("Enter ID: ");
                scanf("%d", &s.id);
                getchar();
                
                printf("Enter name: ");
                fgets(s.name, sizeof(s.name), stdin);
                s.name[strcspn(s.name, "\n")] = '\0';
                
                printf("Enter DOB (dd mm yyyy): ");
                scanf("%d %d %d", &s.dob.day, &s.dob.month, &s.dob.year);
                getchar();
                
                printf("Enter address: ");
                fgets(s.address, sizeof(s.address), stdin);
                s.address[strcspn(s.address, "\n")] = '\0';
                
                printf("Enter score: ");
                scanf("%f", &s.score);
                
                if (addStudent(list, s) == 0) {
                    printf("Student added successfully!\n");
                } else {
                    printf("Failed to add student!\n");
                }
                break;
            }
            
            case 2: {
                int id;
                printf("Enter ID to remove: ");
                scanf("%d", &id);
                
                if (removeStudent(list, id) == 0) {
                    printf("Student removed successfully!\n");
                } else {
                    printf("Student not found!\n");
                }
                break;
            }
            
            case 3: {
                int id;
                printf("Enter ID to find: ");
                scanf("%d", &id);
                
                Student *s = findStudent(list, id);
                if (s) {
                    printf("\nStudent found:\n");
                    printStudent(s);
                } else {
                    printf("Student not found!\n");
                }
                break;
            }
            
            case 4: {
                int id;
                float newScore;
                printf("Enter ID: ");
                scanf("%d", &id);
                printf("Enter new score: ");
                scanf("%f", &newScore);
                
                Student *s = findStudent(list, id);
                if (s) {
                    s->score = newScore;
                    printf("Score updated successfully!\n");
                } else {
                    printf("Student not found!\n");
                }
                break;
            }
            
            case 5:
                sortByScore(list);
                printf("Sorted by score!\n");
                break;
            
            case 6:
                sortByName(list);
                printf("Sorted by name!\n");
                break;
            
            case 7:
                printList(list);
                break;
            
            case 8:
                if (saveBinary(list, BINARY_FILE) == 0) {
                    printf("Saved to %s\n", BINARY_FILE);
                } else {
                    printf("Failed to save!\n");
                }
                break;
            
            case 9:
                if (saveCSV(list, CSV_FILE) == 0) {
                    printf("Saved to %s\n", CSV_FILE);
                } else {
                    printf("Failed to save!\n");
                }
                break;
            
            case 0:
                // Auto-save before exit
                saveBinary(list, BINARY_FILE);
                printf("Data saved. Goodbye!\n");
                break;
            
            default:
                printf("Invalid choice!\n");
        }
        
    } while (choice != 0);
    
    freeList(list);
    return 0;
}
```

### Hướng dẫn sử dụng

Compile và chạy:

```bash
gcc -o student_manager student_manager.c
./student_manager
```

### Yêu cầu mở rộng (tự làm)

1. Thêm chức năng import từ CSV
2. Thêm validation cho input (ID không trùng, điểm từ 0-10, v.v.)
3. Thêm chức năng backup/restore
4. Thêm thống kê (điểm trung bình, phân loại học lực)
5. Thêm tìm kiếm theo tên (partial match)
6. Implement undo/redo cho các thao tác
7. Thêm chức năng pagination khi hiển thị danh sách dài
