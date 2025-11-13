# 📘 PHẦN 2: CON TRỎ VÀ MẢNG

## 🎯 Mục tiêu tổng quát

- Nắm vững cách sử dụng mảng
- Hiểu sâu về con trỏ và pointer arithmetic
- Biết cách quản lý bộ nhớ động
- Sử dụng con trỏ với hàm
- Xây dựng chương trình với dynamic data structures

## 🧑‍🏫 Bài 1: Mảng trong C

### Mảng một chiều

```c
#include <stdio.h>

int main() {
    // Khai báo và khởi tạo
    int numbers[5] = {1, 2, 3, 4, 5};
    
    // Khai báo không khởi tạo
    int scores[10];
    
    // Khởi tạo một phần (phần còn lại = 0)
    int arr[5] = {1, 2};  // {1, 2, 0, 0, 0}
    
    // Kích thước tự động
    int data[] = {10, 20, 30, 40};  // Size = 4
    
    // Truy cập phần tử
    printf("First element: %d\n", numbers[0]);
    printf("Last element: %d\n", numbers[4]);
    
    // Thay đổi giá trị
    numbers[2] = 100;
    printf("Modified: %d\n", numbers[2]);
    
    // Duyệt mảng
    printf("Array elements: ");
    for (int i = 0; i < 5; i++) {
        printf("%d ", numbers[i]);
    }
    printf("\n");
    
    // Tính kích thước
    int size = sizeof(numbers) / sizeof(numbers[0]);
    printf("Array size: %d\n", size);
    
    return 0;
}
```

**Các thao tác phổ biến:**

```c
#include <stdio.h>

// Tìm giá trị lớn nhất
int findMax(int arr[], int size) {
    int max = arr[0];
    for (int i = 1; i < size; i++) {
        if (arr[i] > max) {
            max = arr[i];
        }
    }
    return max;
}

// Tính tổng
int sum(int arr[], int size) {
    int total = 0;
    for (int i = 0; i < size; i++) {
        total += arr[i];
    }
    return total;
}

// Đảo ngược mảng
void reverse(int arr[], int size) {
    for (int i = 0; i < size / 2; i++) {
        int temp = arr[i];
        arr[i] = arr[size - 1 - i];
        arr[size - 1 - i] = temp;
    }
}

// Sắp xếp Bubble Sort
void bubbleSort(int arr[], int size) {
    for (int i = 0; i < size - 1; i++) {
        for (int j = 0; j < size - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}

int main() {
    int numbers[] = {5, 2, 8, 1, 9, 3};
    int size = sizeof(numbers) / sizeof(numbers[0]);
    
    printf("Max: %d\n", findMax(numbers, size));
    printf("Sum: %d\n", sum(numbers, size));
    
    reverse(numbers, size);
    printf("Reversed: ");
    for (int i = 0; i < size; i++) {
        printf("%d ", numbers[i]);
    }
    printf("\n");
    
    bubbleSort(numbers, size);
    printf("Sorted: ");
    for (int i = 0; i < size; i++) {
        printf("%d ", numbers[i]);
    }
    printf("\n");
    
    return 0;
}
```

### Mảng ký tự (Strings)

```c
#include <stdio.h>
#include <string.h>

int main() {
    // Cách 1: Mảng ký tự
    char str1[20] = "Hello";
    
    // Cách 2: String literal
    char str2[] = "World";
    
    // Cách 3: Khởi tạo từng ký tự
    char str3[6] = {'H', 'e', 'l', 'l', 'o', '\0'};
    
    printf("str1: %s\n", str1);
    printf("str2: %s\n", str2);
    printf("str3: %s\n", str3);
    
    // String functions
    char s1[50] = "Hello";
    char s2[50] = "World";
    
    // Length
    printf("Length of s1: %lu\n", strlen(s1));
    
    // Copy
    strcpy(s1, "Hi");
    printf("After strcpy: %s\n", s1);
    
    // Concatenate
    strcat(s1, " ");
    strcat(s1, s2);
    printf("After strcat: %s\n", s1);
    
    // Compare
    if (strcmp(s1, s2) == 0) {
        printf("Strings are equal\n");
    } else {
        printf("Strings are different\n");
    }
    
    // Character functions
    char ch = 'a';
    printf("Uppercase: %c\n", toupper(ch));
    printf("Is digit: %d\n", isdigit(ch));
    printf("Is alpha: %d\n", isalpha(ch));
    
    return 0;
}
```

**String operations:**

```c
#include <stdio.h>
#include <string.h>
#include <ctype.h>

// Custom strlen
int myStrlen(char str[]) {
    int i = 0;
    while (str[i] != '\0') {
        i++;
    }
    return i;
}

// Custom strcpy
void myStrcpy(char dest[], char src[]) {
    int i = 0;
    while (src[i] != '\0') {
        dest[i] = src[i];
        i++;
    }
    dest[i] = '\0';
}

// To uppercase
void toUpper(char str[]) {
    for (int i = 0; str[i] != '\0'; i++) {
        str[i] = toupper(str[i]);
    }
}

// Reverse string
void reverseString(char str[]) {
    int len = strlen(str);
    for (int i = 0; i < len / 2; i++) {
        char temp = str[i];
        str[i] = str[len - 1 - i];
        str[len - 1 - i] = temp;
    }
}

int main() {
    char str[50] = "hello world";
    
    printf("Length: %d\n", myStrlen(str));
    
    toUpper(str);
    printf("Uppercase: %s\n", str);
    
    reverseString(str);
    printf("Reversed: %s\n", str);
    
    return 0;
}
```

### Mảng nhiều chiều

```c
#include <stdio.h>

int main() {
    // Mảng 2 chiều
    int matrix[3][4] = {
        {1, 2, 3, 4},
        {5, 6, 7, 8},
        {9, 10, 11, 12}
    };
    
    // Truy cập phần tử
    printf("Element [1][2]: %d\n", matrix[1][2]);  // 7
    
    // Duyệt mảng 2 chiều
    printf("Matrix:\n");
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 4; j++) {
            printf("%3d ", matrix[i][j]);
        }
        printf("\n");
    }
    
    // Mảng 3 chiều
    int cube[2][3][4] = {
        {
            {1, 2, 3, 4},
            {5, 6, 7, 8},
            {9, 10, 11, 12}
        },
        {
            {13, 14, 15, 16},
            {17, 18, 19, 20},
            {21, 22, 23, 24}
        }
    };
    
    printf("Cube[1][2][3]: %d\n", cube[1][2][3]);  // 24
    
    return 0;
}
```

**Ma trận operations:**

```c
#include <stdio.h>

#define ROWS 3
#define COLS 3

void printMatrix(int mat[][COLS], int rows) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < COLS; j++) {
            printf("%3d ", mat[i][j]);
        }
        printf("\n");
    }
}

void addMatrix(int a[][COLS], int b[][COLS], int result[][COLS], int rows) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < COLS; j++) {
            result[i][j] = a[i][j] + b[i][j];
        }
    }
}

void multiplyMatrix(int a[][COLS], int b[][COLS], int result[][COLS], int rows) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < COLS; j++) {
            result[i][j] = 0;
            for (int k = 0; k < COLS; k++) {
                result[i][j] += a[i][k] * b[k][j];
            }
        }
    }
}

void transpose(int mat[][COLS], int result[][ROWS], int rows) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < COLS; j++) {
            result[j][i] = mat[i][j];
        }
    }
}

int main() {
    int a[ROWS][COLS] = {% raw %}{{1, 2, 3}, {4, 5, 6}, {7, 8, 9}}{% endraw %};
    int b[ROWS][COLS] = {% raw %}{{9, 8, 7}, {6, 5, 4}, {3, 2, 1}}{% endraw %};
    int result[ROWS][COLS];
    
    printf("Matrix A:\n");
    printMatrix(a, ROWS);
    
    printf("\nMatrix B:\n");
    printMatrix(b, ROWS);
    
    addMatrix(a, b, result, ROWS);
    printf("\nA + B:\n");
    printMatrix(result, ROWS);
    
    multiplyMatrix(a, b, result, ROWS);
    printf("\nA * B:\n");
    printMatrix(result, ROWS);
    
    return 0;
}
```

## 🧑‍🏫 Bài 2: Con trỏ cơ bản

### Khái niệm con trỏ

Con trỏ là biến lưu trữ địa chỉ của biến khác trong bộ nhớ.

```text
Memory:
┌─────────┬─────────┬─────────┬─────────┐
│  ...    │  0x100  │  0x104  │  ...    │
├─────────┼─────────┼─────────┼─────────┤
│         │   42    │  0x100  │         │
└─────────┴─────────┴─────────┴─────────┘
            num       ptr
```

### Khai báo và sử dụng con trỏ

```c
#include <stdio.h>

int main() {
    int num = 42;
    int *ptr;  // Khai báo con trỏ
    
    ptr = &num;  // Lấy địa chỉ của num
    
    printf("Value of num: %d\n", num);
    printf("Address of num: %p\n", (void*)&num);
    printf("Value of ptr: %p\n", (void*)ptr);
    printf("Value pointed by ptr: %d\n", *ptr);  // Dereference
    
    // Thay đổi giá trị qua con trỏ
    *ptr = 100;
    printf("New value of num: %d\n", num);
    
    // Con trỏ với các kiểu khác
    float f = 3.14f;
    float *fp = &f;
    printf("Float value: %.2f\n", *fp);
    
    char c = 'A';
    char *cp = &c;
    printf("Char value: %c\n", *cp);
    
    return 0;
}
```

**Các thao tác con trỏ:**

```c
#include <stdio.h>

int main() {
    int x = 10, y = 20;
    int *p1, *p2;
    
    p1 = &x;
    p2 = &y;
    
    printf("*p1 = %d, *p2 = %d\n", *p1, *p2);
    
    // Swap values using pointers
    int temp = *p1;
    *p1 = *p2;
    *p2 = temp;
    
    printf("After swap: x = %d, y = %d\n", x, y);
    
    // Pointer comparison
    if (p1 == &x) {
        printf("p1 points to x\n");
    }
    
    // Pointer arithmetic (will cover in next section)
    p1++;  // Move to next int location
    printf("After p1++: %p\n", (void*)p1);
    
    return 0;
}
```

### Con trỏ NULL và void

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    // NULL pointer
    int *ptr = NULL;
    
    if (ptr == NULL) {
        printf("Pointer is NULL\n");
    }
    
    // Dereferencing NULL causes crash
    // printf("%d\n", *ptr);  // KHÔNG BAO GIỜ LÀM ĐIỀU NÀY!
    
    // Always check before dereferencing
    if (ptr != NULL) {
        printf("Value: %d\n", *ptr);
    } else {
        printf("Cannot dereference NULL pointer\n");
    }
    
    // void pointer - generic pointer
    void *vptr;
    int num = 42;
    float f = 3.14f;
    
    vptr = &num;
    printf("Int value: %d\n", *(int*)vptr);  // Cast to int*
    
    vptr = &f;
    printf("Float value: %.2f\n", *(float*)vptr);  // Cast to float*
    
    return 0;
}
```

## 🧑‍🏫 Bài 3: Con trỏ và Mảng

### Mối quan hệ giữa con trỏ và mảng

```c
#include <stdio.h>

int main() {
    int arr[] = {10, 20, 30, 40, 50};
    int *ptr = arr;  // arr tự động chuyển thành pointer to first element
    
    // Các cách truy cập giống nhau
    printf("arr[0] = %d\n", arr[0]);
    printf("*arr = %d\n", *arr);
    printf("*ptr = %d\n", *ptr);
    printf("ptr[0] = %d\n", ptr[0]);
    
    // arr và ptr đều trỏ đến phần tử đầu
    printf("arr = %p\n", (void*)arr);
    printf("ptr = %p\n", (void*)ptr);
    printf("&arr[0] = %p\n", (void*)&arr[0]);
    
    // Truy cập phần tử thứ i
    for (int i = 0; i < 5; i++) {
        printf("arr[%d] = %d = *(arr+%d) = %d\n", 
               i, arr[i], i, *(arr + i));
    }
    
    return 0;
}
```

### Pointer Arithmetic

```c
#include <stdio.h>

int main() {
    int arr[] = {10, 20, 30, 40, 50};
    int *ptr = arr;
    
    printf("Initial ptr: %p, value: %d\n", (void*)ptr, *ptr);
    
    // Increment
    ptr++;
    printf("After ptr++: %p, value: %d\n", (void*)ptr, *ptr);
    
    // ptr += 2
    ptr += 2;
    printf("After ptr+=2: %p, value: %d\n", (void*)ptr, *ptr);
    
    // Decrement
    ptr--;
    printf("After ptr--: %p, value: %d\n", (void*)ptr, *ptr);
    
    // Difference between pointers
    int *start = arr;
    int *end = &arr[4];
    printf("Difference: %ld elements\n", end - start);
    
    // Duyệt mảng bằng con trỏ
    printf("Array elements: ");
    for (ptr = arr; ptr < arr + 5; ptr++) {
        printf("%d ", *ptr);
    }
    printf("\n");
    
    return 0;
}
```

### Con trỏ và chuỗi

```c
#include <stdio.h>
#include <string.h>

int main() {
    // String literal - con trỏ constant
    char *str1 = "Hello";  // Stored in read-only memory
    // str1[0] = 'h';  // LỖI: cannot modify
    
    // Array - có thể modify
    char str2[] = "World";
    str2[0] = 'w';  // OK
    
    printf("str1: %s\n", str1);
    printf("str2: %s\n", str2);
    
    // Duyệt chuỗi bằng con trỏ
    char *p = str2;
    while (*p != '\0') {
        printf("%c ", *p);
        p++;
    }
    printf("\n");
    
    // Array of strings
    char *fruits[] = {
        "Apple",
        "Banana",
        "Orange",
        "Mango"
    };
    
    int count = sizeof(fruits) / sizeof(fruits[0]);
    for (int i = 0; i < count; i++) {
        printf("%s\n", fruits[i]);
    }
    
    return 0;
}
```

## 🧑‍🏫 Bài 4: Con trỏ và Hàm

### Pass by reference

```c
#include <stdio.h>

// Pass by value - không thay đổi original
void incrementValue(int x) {
    x++;
    printf("Inside function: %d\n", x);
}

// Pass by reference - thay đổi original
void incrementReference(int *x) {
    (*x)++;
    printf("Inside function: %d\n", *x);
}

// Swap function
void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

// Modify array
void fillArray(int arr[], int size, int value) {
    for (int i = 0; i < size; i++) {
        arr[i] = value;
    }
}

// Return multiple values
void getCircleProperties(float radius, float *area, float *circumference) {
    *area = 3.14159f * radius * radius;
    *circumference = 2 * 3.14159f * radius;
}

int main() {
    int num = 10;
    
    incrementValue(num);
    printf("After incrementValue: %d\n", num);  // Still 10
    
    incrementReference(&num);
    printf("After incrementReference: %d\n", num);  // Now 11
    
    int x = 5, y = 10;
    printf("Before swap: x=%d, y=%d\n", x, y);
    swap(&x, &y);
    printf("After swap: x=%d, y=%d\n", x, y);
    
    int arr[5];
    fillArray(arr, 5, 99);
    printf("Array: ");
    for (int i = 0; i < 5; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
    
    float area, circumference;
    getCircleProperties(5.0f, &area, &circumference);
    printf("Area: %.2f, Circumference: %.2f\n", area, circumference);
    
    return 0;
}
```

### Con trỏ hàm

```c
#include <stdio.h>

// Các hàm toán học
int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }
int multiply(int a, int b) { return a * b; }
int divide(int a, int b) { return b != 0 ? a / b : 0; }

// Hàm sử dụng function pointer
int calculate(int a, int b, int (*operation)(int, int)) {
    return operation(a, b);
}

// Callback function example
void forEach(int arr[], int size, void (*callback)(int)) {
    for (int i = 0; i < size; i++) {
        callback(arr[i]);
    }
}

void printElement(int x) {
    printf("%d ", x);
}

void printSquare(int x) {
    printf("%d ", x * x);
}

int main() {
    // Khai báo function pointer
    int (*funcPtr)(int, int);
    
    funcPtr = add;
    printf("10 + 5 = %d\n", funcPtr(10, 5));
    
    funcPtr = multiply;
    printf("10 * 5 = %d\n", funcPtr(10, 5));
    
    // Sử dụng với hàm khác
    printf("Calculate (add): %d\n", calculate(10, 5, add));
    printf("Calculate (subtract): %d\n", calculate(10, 5, subtract));
    
    // Array of function pointers
    int (*operations[])(int, int) = {add, subtract, multiply, divide};
    char *names[] = {"Add", "Subtract", "Multiply", "Divide"};
    
    for (int i = 0; i < 4; i++) {
        printf("%s: %d\n", names[i], operations[i](10, 5));
    }
    
    // Callback example
    int arr[] = {1, 2, 3, 4, 5};
    
    printf("Elements: ");
    forEach(arr, 5, printElement);
    printf("\n");
    
    printf("Squares: ");
    forEach(arr, 5, printSquare);
    printf("\n");
    
    return 0;
}
```

### Trả về con trỏ từ hàm

```c
#include <stdio.h>
#include <stdlib.h>

// CẢNH BÁO: Không trả về con trỏ đến biến local
int* dangerousFunction() {
    int x = 10;
    return &x;  // NGUY HIỂM! x sẽ bị destroy
}

// ĐÚNG: Trả về con trỏ đến static variable
int* safeFunction1() {
    static int x = 10;
    return &x;  // OK - static variable persists
}

// ĐÚNG: Trả về con trỏ đến dynamic memory
int* safeFunction2() {
    int *ptr = (int*)malloc(sizeof(int));
    *ptr = 10;
    return ptr;  // OK - must free later
}

// Trả về pointer to array element
int* findElement(int arr[], int size, int value) {
    for (int i = 0; i < size; i++) {
        if (arr[i] == value) {
            return &arr[i];
        }
    }
    return NULL;
}

int main() {
    // Using safe functions
    int *p1 = safeFunction1();
    printf("Value: %d\n", *p1);
    
    int *p2 = safeFunction2();
    printf("Value: %d\n", *p2);
    free(p2);  // Don't forget to free!
    
    int arr[] = {10, 20, 30, 40, 50};
    int *found = findElement(arr, 5, 30);
    if (found != NULL) {
        printf("Found: %d at address %p\n", *found, (void*)found);
    }
    
    return 0;
}
```

## 🧑‍🏫 Bài 5: Quản lý bộ nhớ động

### malloc, calloc, realloc, free

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    // malloc - allocate memory (uninitialized)
    int *ptr1 = (int*)malloc(5 * sizeof(int));
    if (ptr1 == NULL) {
        printf("Memory allocation failed!\n");
        return 1;
    }
    
    // Initialize values
    for (int i = 0; i < 5; i++) {
        ptr1[i] = i * 10;
    }
    
    printf("malloc array: ");
    for (int i = 0; i < 5; i++) {
        printf("%d ", ptr1[i]);
    }
    printf("\n");
    
    // calloc - allocate and initialize to 0
    int *ptr2 = (int*)calloc(5, sizeof(int));
    if (ptr2 == NULL) {
        printf("Memory allocation failed!\n");
        free(ptr1);
        return 1;
    }
    
    printf("calloc array: ");
    for (int i = 0; i < 5; i++) {
        printf("%d ", ptr2[i]);  // All zeros
    }
    printf("\n");
    
    // realloc - resize memory
    ptr1 = (int*)realloc(ptr1, 10 * sizeof(int));
    if (ptr1 == NULL) {
        printf("Reallocation failed!\n");
        free(ptr2);
        return 1;
    }
    
    // Initialize new elements
    for (int i = 5; i < 10; i++) {
        ptr1[i] = i * 10;
    }
    
    printf("After realloc: ");
    for (int i = 0; i < 10; i++) {
        printf("%d ", ptr1[i]);
    }
    printf("\n");
    
    // Free memory
    free(ptr1);
    free(ptr2);
    
    // ptr1 = NULL;  // Good practice
    // ptr2 = NULL;
    
    return 0;
}
```

### Memory leaks và best practices

```c
#include <stdio.h>
#include <stdlib.h>

// Memory leak example
void memoryLeak() {
    int *ptr = (int*)malloc(sizeof(int));
    *ptr = 42;
    // Forgot to free! - MEMORY LEAK
}

// Correct way
void noMemoryLeak() {
    int *ptr = (int*)malloc(sizeof(int));
    if (ptr == NULL) return;
    
    *ptr = 42;
    printf("Value: %d\n", *ptr);
    free(ptr);
    ptr = NULL;  // Good practice
}

// Double free error
void doubleFreeError() {
    int *ptr = (int*)malloc(sizeof(int));
    free(ptr);
    // free(ptr);  // ERROR: Double free!
}

// Dangling pointer
void danglingPointer() {
    int *ptr = (int*)malloc(sizeof(int));
    *ptr = 42;
    free(ptr);
    // printf("%d\n", *ptr);  // DANGER: Use after free!
    ptr = NULL;  // Prevent dangling pointer
}

int main() {
    printf("Demonstrating correct memory management:\n");
    noMemoryLeak();
    
    return 0;
}
```

### Dynamic arrays

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Dynamic array structure
typedef struct {
    int *data;
    int size;
    int capacity;
} DynamicArray;

// Initialize dynamic array
DynamicArray* createArray(int initialCapacity) {
    DynamicArray *arr = (DynamicArray*)malloc(sizeof(DynamicArray));
    if (arr == NULL) return NULL;
    
    arr->data = (int*)malloc(initialCapacity * sizeof(int));
    if (arr->data == NULL) {
        free(arr);
        return NULL;
    }
    
    arr->size = 0;
    arr->capacity = initialCapacity;
    return arr;
}

// Add element
void append(DynamicArray *arr, int value) {
    if (arr->size >= arr->capacity) {
        // Resize
        int newCapacity = arr->capacity * 2;
        int *newData = (int*)realloc(arr->data, newCapacity * sizeof(int));
        if (newData == NULL) {
            printf("Reallocation failed!\n");
            return;
        }
        arr->data = newData;
        arr->capacity = newCapacity;
    }
    
    arr->data[arr->size] = value;
    arr->size++;
}

// Print array
void printArray(DynamicArray *arr) {
    printf("Array (size=%d, capacity=%d): ", arr->size, arr->capacity);
    for (int i = 0; i < arr->size; i++) {
        printf("%d ", arr->data[i]);
    }
    printf("\n");
}

// Free array
void freeArray(DynamicArray *arr) {
    if (arr != NULL) {
        free(arr->data);
        free(arr);
    }
}

int main() {
    DynamicArray *arr = createArray(2);
    if (arr == NULL) {
        printf("Failed to create array!\n");
        return 1;
    }
    
    // Add elements
    for (int i = 1; i <= 10; i++) {
        append(arr, i * 10);
        printArray(arr);
    }
    
    freeArray(arr);
    return 0;
}
```

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Quản lý danh sách động

### Mô tả bài toán

Xây dựng chương trình quản lý danh sách sinh viên động với các chức năng:

- Thêm sinh viên mới (tự động mở rộng mảng khi cần)
- Xóa sinh viên theo ID
- Tìm kiếm sinh viên
- Sắp xếp danh sách theo điểm
- Hiển thị danh sách
- Giải phóng bộ nhớ đúng cách

### Yêu cầu

1. Sử dụng dynamic memory allocation
2. Implement các hàm:
   - `createList()` - Tạo danh sách
   - `addStudent()` - Thêm sinh viên
   - `removeStudent()` - Xóa sinh viên
   - `findStudent()` - Tìm sinh viên
   - `sortStudents()` - Sắp xếp
   - `printList()` - Hiển thị
   - `freeList()` - Giải phóng bộ nhớ
3. Xử lý reallocation khi mảng đầy
4. Kiểm tra NULL pointers
5. Không có memory leaks

**Gợi ý cấu trúc:**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INITIAL_CAPACITY 2

typedef struct {
    int id;
    char name[50];
    float score;
} Student;

typedef struct {
    Student *students;
    int size;
    int capacity;
} StudentList;

// Function prototypes
StudentList* createList();
int addStudent(StudentList *list, int id, char name[], float score);
int removeStudent(StudentList *list, int id);
Student* findStudent(StudentList *list, int id);
void sortStudents(StudentList *list);
void printList(StudentList *list);
void freeList(StudentList *list);

int main() {
    StudentList *list = createList();
    if (list == NULL) {
        printf("Failed to create list!\n");
        return 1;
    }
    
    // Menu
    int choice;
    do {
        printf("\n=== STUDENT MANAGEMENT ===\n");
        printf("1. Add Student\n");
        printf("2. Remove Student\n");
        printf("3. Find Student\n");
        printf("4. Sort by Score\n");
        printf("5. Display All\n");
        printf("6. Exit\n");
        printf("Choice: ");
        scanf("%d", &choice);
        
        // TODO: Implement menu handlers
        
    } while (choice != 6);
    
    freeList(list);
    return 0;
}

// TODO: Implement all functions
```
