# 📘 PHẦN 4: GIỚI THIỆU C++ VÀ LẬP TRÌNH HƯỚNG ĐỐI TƯỢNG

## 🎯 Mục tiêu tổng quát

- Hiểu sự khác biệt giữa C và C++
- Nắm vững khái niệm OOP cơ bản
- Biết cách định nghĩa và sử dụng class
- Hiểu về constructors, destructors
- Áp dụng encapsulation và data hiding
- Sử dụng operator overloading cơ bản

## 🧑‍🏫 Bài 1: Từ C sang C++ - Những khác biệt cơ bản

### Hello World và namespace

```cpp
// C style
#include <stdio.h>

int main() {
    printf("Hello, World!\n");
    return 0;
}
```

```cpp
// C++ style
#include <iostream>

int main() {
    std::cout << "Hello, World!" << std::endl;
    return 0;
}
```

```cpp
// C++ với using namespace
#include <iostream>
using namespace std;

int main() {
    cout << "Hello, World!" << endl;
    return 0;
}
```

**Lưu ý:** Tránh dùng `using namespace std;` trong header files để tránh name collision.

### Input/Output với cin/cout

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    // Output
    cout << "Enter your name: ";
    
    // Input string
    string name;
    getline(cin, name);  // Đọc cả dòng, bao gồm space
    
    cout << "Enter your age: ";
    int age;
    cin >> age;
    
    cout << "Enter your score: ";
    float score;
    cin >> score;
    
    // Output với formatting
    cout << "Name: " << name << endl;
    cout << "Age: " << age << endl;
    cout << "Score: " << score << endl;
    
    // Chain output
    cout << "Summary: " << name << ", " << age << " years old, score: " << score << endl;
    
    return 0;
}
```

**So sánh C và C++:**

```cpp
// C
printf("Name: %s, Age: %d\n", name, age);
scanf("%d", &age);

// C++
cout << "Name: " << name << ", Age: " << age << endl;
cin >> age;  // Không cần &
```

### Biến và references

```cpp
#include <iostream>
using namespace std;

int main() {
    int x = 10;
    
    // Pointer (giống C)
    int *ptr = &x;
    cout << "Value via pointer: " << *ptr << endl;
    *ptr = 20;
    cout << "x after pointer modification: " << x << endl;
    
    // Reference (mới trong C++)
    int &ref = x;  // ref là alias của x
    cout << "Value via reference: " << ref << endl;
    ref = 30;  // Không cần dereference
    cout << "x after reference modification: " << x << endl;
    
    // Reference phải được khởi tạo ngay và không thể thay đổi
    // int &ref2;  // ERROR!
    
    return 0;
}
```

**Reference vs Pointer:**

```cpp
#include <iostream>
using namespace std;

void swapPointer(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void swapReference(int &a, int &b) {
    int temp = a;
    a = b;
    b = temp;
}

int main() {
    int x = 5, y = 10;
    
    cout << "Before: x=" << x << ", y=" << y << endl;
    
    swapPointer(&x, &y);
    cout << "After pointer swap: x=" << x << ", y=" << y << endl;
    
    swapReference(x, y);
    cout << "After reference swap: x=" << x << ", y=" << y << endl;
    
    return 0;
}
```

### Function overloading

C++ cho phép nhiều hàm cùng tên nhưng khác tham số.

```cpp
#include <iostream>
using namespace std;

// Overload based on number of parameters
int add(int a, int b) {
    return a + b;
}

int add(int a, int b, int c) {
    return a + b + c;
}

// Overload based on parameter types
double add(double a, double b) {
    return a + b;
}

// Overload based on parameter types
string add(string a, string b) {
    return a + b;
}

int main() {
    cout << add(5, 10) << endl;           // Calls int add(int, int)
    cout << add(5, 10, 15) << endl;       // Calls int add(int, int, int)
    cout << add(5.5, 10.2) << endl;       // Calls double add(double, double)
    cout << add("Hello", "World") << endl; // Calls string add(string, string)
    
    return 0;
}
```

### Default parameters

```cpp
#include <iostream>
using namespace std;

void printInfo(string name, int age = 18, string city = "Unknown") {
    cout << "Name: " << name << ", Age: " << age << ", City: " << city << endl;
}

// Default parameters với math
int power(int base, int exp = 2) {
    int result = 1;
    for (int i = 0; i < exp; i++) {
        result *= base;
    }
    return result;
}

int main() {
    printInfo("Alice");                      // Uses defaults: 18, "Unknown"
    printInfo("Bob", 25);                    // Uses default: "Unknown"
    printInfo("Charlie", 30, "New York");    // No defaults used
    
    cout << power(5) << endl;      // 5^2 = 25
    cout << power(5, 3) << endl;   // 5^3 = 125
    
    return 0;
}
```

**Lưu ý:** Default parameters phải ở cuối danh sách tham số.

```cpp
// ĐÚNG
void func(int a, int b = 10, int c = 20);

// SAI
void func(int a = 10, int b, int c = 20);  // ERROR!
```

### Dynamic memory với new/delete

```cpp
#include <iostream>
using namespace std;

int main() {
    // C style
    int *arr1 = (int*)malloc(5 * sizeof(int));
    free(arr1);
    
    // C++ style - single variable
    int *ptr = new int;
    *ptr = 42;
    cout << *ptr << endl;
    delete ptr;
    
    // C++ style - array
    int *arr2 = new int[5];
    for (int i = 0; i < 5; i++) {
        arr2[i] = i * 10;
    }
    
    for (int i = 0; i < 5; i++) {
        cout << arr2[i] << " ";
    }
    cout << endl;
    
    delete[] arr2;  // Sử dụng delete[] cho array
    
    // Initialize with value
    int *ptr2 = new int(100);  // Allocate và khởi tạo = 100
    cout << *ptr2 << endl;
    delete ptr2;
    
    // Array initialization (C++11+)
    int *arr3 = new int[3]{10, 20, 30};
    delete[] arr3;
    
    return 0;
}
```

## 🧑‍🏫 Bài 2: Classes và Objects

### Định nghĩa class cơ bản

```cpp
#include <iostream>
#include <string>
using namespace std;

// Class definition
class Student {
public:
    // Data members (attributes)
    int id;
    string name;
    float score;
    
    // Member function (method)
    void display() {
        cout << "ID: " << id << ", Name: " << name << ", Score: " << score << endl;
    }
};

int main() {
    // Create object
    Student s1;
    s1.id = 1;
    s1.name = "Nguyen Van A";
    s1.score = 8.5f;
    s1.display();
    
    // Create another object
    Student s2;
    s2.id = 2;
    s2.name = "Tran Thi B";
    s2.score = 9.0f;
    s2.display();
    
    // Dynamic allocation
    Student *s3 = new Student;
    s3->id = 3;
    s3->name = "Le Van C";
    s3->score = 7.5f;
    s3->display();
    delete s3;
    
    return 0;
}
```

### Access specifiers

```cpp
#include <iostream>
#include <string>
using namespace std;

class BankAccount {
private:
    // Private members - chỉ truy cập được trong class
    string accountNumber;
    double balance;
    
public:
    // Public members - truy cập được từ bên ngoài
    string ownerName;
    
    void setAccountNumber(string accNum) {
        accountNumber = accNum;
    }
    
    string getAccountNumber() {
        return accountNumber;
    }
    
    void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
            cout << "Deposited: " << amount << endl;
        }
    }
    
    void withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            cout << "Withdrawn: " << amount << endl;
        } else {
            cout << "Insufficient balance!" << endl;
        }
    }
    
    double getBalance() {
        return balance;
    }
    
    void setBalance(double bal) {
        balance = bal;
    }
};

int main() {
    BankAccount acc;
    
    // OK - public member
    acc.ownerName = "John Doe";
    
    // ERROR - private member
    // acc.accountNumber = "123456";  // Compile error!
    // acc.balance = 1000.0;          // Compile error!
    
    // OK - through public methods
    acc.setAccountNumber("123456");
    acc.setBalance(1000.0);
    acc.deposit(500);
    acc.withdraw(200);
    
    cout << "Owner: " << acc.ownerName << endl;
    cout << "Account: " << acc.getAccountNumber() << endl;
    cout << "Balance: " << acc.getBalance() << endl;
    
    return 0;
}
```

**Ba loại access specifiers:**

- `public`: Truy cập được từ mọi nơi
- `private`: Chỉ truy cập được trong class (default cho class)
- `protected`: Truy cập được trong class và các class con (sẽ học ở Part 5)

### Member functions

```cpp
#include <iostream>
#include <string>
using namespace std;

class Rectangle {
private:
    double width;
    double height;
    
public:
    // Inline member function
    void setWidth(double w) {
        width = w;
    }
    
    void setHeight(double h) {
        height = h;
    }
    
    // Declaration only
    double getArea();
    double getPerimeter();
    void display();
};

// Definition outside class
double Rectangle::getArea() {
    return width * height;
}

double Rectangle::getPerimeter() {
    return 2 * (width + height);
}

void Rectangle::display() {
    cout << "Rectangle: " << width << " x " << height << endl;
    cout << "Area: " << getArea() << endl;
    cout << "Perimeter: " << getPerimeter() << endl;
}

int main() {
    Rectangle rect;
    rect.setWidth(5.0);
    rect.setHeight(3.0);
    rect.display();
    
    return 0;
}
```

### Getters và Setters

```cpp
#include <iostream>
#include <string>
using namespace std;

class Student {
private:
    int id;
    string name;
    float score;
    
public:
    // Getters
    int getId() const {
        return id;
    }
    
    string getName() const {
        return name;
    }
    
    float getScore() const {
        return score;
    }
    
    // Setters with validation
    void setId(int i) {
        if (i > 0) {
            id = i;
        } else {
            cout << "Invalid ID!" << endl;
        }
    }
    
    void setName(string n) {
        if (!n.empty()) {
            name = n;
        } else {
            cout << "Invalid name!" << endl;
        }
    }
    
    void setScore(float s) {
        if (s >= 0 && s <= 10) {
            score = s;
        } else {
            cout << "Invalid score! Must be 0-10" << endl;
        }
    }
    
    void display() const {
        cout << "Student[ID=" << id << ", Name=" << name << ", Score=" << score << "]" << endl;
    }
};

int main() {
    Student s;
    
    s.setId(1);
    s.setName("Nguyen Van A");
    s.setScore(8.5f);
    s.display();
    
    // Validation in action
    s.setId(-1);       // Invalid ID!
    s.setScore(15.0f); // Invalid score!
    
    // Using getters
    cout << "Student name: " << s.getName() << endl;
    cout << "Student score: " << s.getScore() << endl;
    
    return 0;
}
```

## 🧑‍🏫 Bài 3: Constructors và Destructors

### Constructor

Constructor là hàm đặc biệt được gọi tự động khi tạo object.

```cpp
#include <iostream>
#include <string>
using namespace std;

class Student {
private:
    int id;
    string name;
    float score;
    
public:
    // Default constructor
    Student() {
        id = 0;
        name = "Unknown";
        score = 0.0f;
        cout << "Default constructor called" << endl;
    }
    
    void display() {
        cout << "ID: " << id << ", Name: " << name << ", Score: " << score << endl;
    }
};

int main() {
    Student s1;  // Constructor được gọi tự động
    s1.display();
    
    Student s2;  // Constructor được gọi lại
    s2.display();
    
    return 0;
}
```

### Constructor overloading

```cpp
#include <iostream>
#include <string>
using namespace std;

class Student {
private:
    int id;
    string name;
    float score;
    
public:
    // Default constructor
    Student() {
        id = 0;
        name = "Unknown";
        score = 0.0f;
        cout << "Default constructor" << endl;
    }
    
    // Parameterized constructor
    Student(int i, string n, float s) {
        id = i;
        name = n;
        score = s;
        cout << "Parameterized constructor" << endl;
    }
    
    // Constructor with partial parameters
    Student(int i, string n) {
        id = i;
        name = n;
        score = 0.0f;
        cout << "Partial constructor" << endl;
    }
    
    void display() {
        cout << "ID: " << id << ", Name: " << name << ", Score: " << score << endl;
    }
};

int main() {
    Student s1;                              // Calls default constructor
    Student s2(1, "Alice", 8.5f);           // Calls parameterized constructor
    Student s3(2, "Bob");                    // Calls partial constructor
    
    s1.display();
    s2.display();
    s3.display();
    
    return 0;
}
```

### Destructor

Destructor được gọi tự động khi object bị destroy.

```cpp
#include <iostream>
#include <string>
using namespace std;

class Student {
private:
    int id;
    string name;
    int *data;  // Dynamic memory
    
public:
    // Constructor
    Student(int i, string n) {
        id = i;
        name = n;
        data = new int[10];  // Allocate memory
        cout << "Constructor called for " << name << endl;
    }
    
    // Destructor
    ~Student() {
        delete[] data;  // Free memory
        cout << "Destructor called for " << name << endl;
    }
    
    void display() {
        cout << "Student: " << id << " - " << name << endl;
    }
};

int main() {
    {
        Student s1(1, "Alice");
        s1.display();
    }  // s1 goes out of scope - destructor called
    
    cout << "After inner block" << endl;
    
    Student *s2 = new Student(2, "Bob");
    s2->display();
    delete s2;  // Explicitly call destructor
    
    cout << "End of main" << endl;
    
    return 0;
}
```

### Copy constructor

```cpp
#include <iostream>
#include <string>
#include <cstring>
using namespace std;

class String {
private:
    char *data;
    int length;
    
public:
    // Constructor
    String(const char *str) {
        length = strlen(str);
        data = new char[length + 1];
        strcpy(data, str);
        cout << "Constructor: " << data << endl;
    }
    
    // Copy constructor (deep copy)
    String(const String &other) {
        length = other.length;
        data = new char[length + 1];
        strcpy(data, other.data);
        cout << "Copy constructor: " << data << endl;
    }
    
    // Destructor
    ~String() {
        cout << "Destructor: " << data << endl;
        delete[] data;
    }
    
    void display() {
        cout << "String: " << data << " (length: " << length << ")" << endl;
    }
};

int main() {
    String s1("Hello");
    s1.display();
    
    String s2 = s1;  // Copy constructor called
    s2.display();
    
    String s3(s1);   // Copy constructor called
    s3.display();
    
    return 0;
}
```

**Shallow copy vs Deep copy:**

```cpp
// Without copy constructor - compiler generates shallow copy
class String {
    char *data;
public:
    String(const char *str) {
        data = new char[strlen(str) + 1];
        strcpy(data, str);
    }
    // No copy constructor - DANGER!
    ~String() { delete[] data; }
};

// Problem:
String s1("Hello");
String s2 = s1;  // Shallow copy - both point to same memory
// When s1 and s2 are destroyed - DOUBLE FREE ERROR!
```

### Member initializer list

```cpp
#include <iostream>
#include <string>
using namespace std;

class Student {
private:
    const int id;       // const member
    string name;
    float &scoreRef;    // reference member
    static int count;
    
public:
    // Must use initializer list for const and reference members
    Student(int i, string n, float &s) : id(i), name(n), scoreRef(s) {
        count++;
        cout << "Constructor using initializer list" << endl;
    }
    
    // More efficient than assignment in body
    // This:
    // Student(int i, string n) : id(i), name(n) { }
    
    // Is better than:
    // Student(int i, string n) {
    //     id = i;     // Assignment
    //     name = n;   // Assignment
    // }
    
    void display() {
        cout << "ID: " << id << ", Name: " << name << ", Score: " << scoreRef << endl;
    }
    
    static int getCount() {
        return count;
    }
};

int Student::count = 0;

int main() {
    float score1 = 8.5f;
    float score2 = 9.0f;
    
    Student s1(1, "Alice", score1);
    Student s2(2, "Bob", score2);
    
    s1.display();
    s2.display();
    
    cout << "Total students: " << Student::getCount() << endl;
    
    return 0;
}
```

## 🧑‍🏫 Bài 4: Encapsulation và Data Hiding

### Encapsulation trong thực tế

```cpp
#include <iostream>
#include <string>
using namespace std;

class Employee {
private:
    int id;
    string name;
    double salary;
    string department;
    
    // Private helper function
    bool isValidSalary(double sal) {
        return sal > 0 && sal <= 100000;
    }
    
public:
    Employee(int i, string n, double sal, string dept) {
        id = i;
        name = n;
        setSalary(sal);  // Use setter for validation
        department = dept;
    }
    
    // Public interface
    void setSalary(double sal) {
        if (isValidSalary(sal)) {
            salary = sal;
        } else {
            cout << "Invalid salary!" << endl;
        }
    }
    
    double getSalary() const {
        return salary;
    }
    
    void giveRaise(double percentage) {
        double newSalary = salary * (1 + percentage / 100);
        setSalary(newSalary);
    }
    
    void display() const {
        cout << "Employee[ID=" << id << ", Name=" << name 
             << ", Salary=" << salary << ", Dept=" << department << "]" << endl;
    }
    
    // Read-only access
    int getId() const { return id; }
    string getName() const { return name; }
    string getDepartment() const { return department; }
};

int main() {
    Employee emp(1, "John Doe", 50000, "IT");
    emp.display();
    
    emp.giveRaise(10);  // 10% raise
    emp.display();
    
    // Direct salary access not allowed
    // emp.salary = 1000000;  // ERROR - private member
    
    // Must use public interface
    emp.setSalary(60000);
    cout << "New salary: " << emp.getSalary() << endl;
    
    return 0;
}
```

### Friend functions và friend classes

```cpp
#include <iostream>
using namespace std;

class Box {
private:
    double width;
    double height;
    
public:
    Box(double w, double h) : width(w), height(h) {}
    
    // Friend function can access private members
    friend double calculateArea(const Box &b);
    friend void printBox(const Box &b);
    
    // Friend class
    friend class BoxPrinter;
};

// Friend function definition
double calculateArea(const Box &b) {
    return b.width * b.height;  // Can access private members
}

void printBox(const Box &b) {
    cout << "Box: " << b.width << " x " << b.height << endl;
}

// Friend class
class BoxPrinter {
public:
    void print(const Box &b) {
        cout << "BoxPrinter: " << b.width << " x " << b.height << endl;
    }
};

int main() {
    Box box(5.0, 3.0);
    
    cout << "Area: " << calculateArea(box) << endl;
    printBox(box);
    
    BoxPrinter printer;
    printer.print(box);
    
    return 0;
}
```

**Lưu ý:** Friend functions phá vỡ encapsulation, nên sử dụng cẩn thận.

### Static members

```cpp
#include <iostream>
#include <string>
using namespace std;

class Student {
private:
    int id;
    string name;
    
    // Static data member - shared by all objects
    static int totalStudents;
    static double totalScore;
    
public:
    Student(int i, string n) : id(i), name(n) {
        totalStudents++;
    }
    
    ~Student() {
        totalStudents--;
    }
    
    void addScore(double score) {
        totalScore += score;
    }
    
    // Static member function - can only access static members
    static int getTotalStudents() {
        return totalStudents;
    }
    
    static double getAverageScore() {
        return totalStudents > 0 ? totalScore / totalStudents : 0;
    }
    
    void display() const {
        cout << "Student[ID=" << id << ", Name=" << name << "]" << endl;
    }
};

// Initialize static members
int Student::totalStudents = 0;
double Student::totalScore = 0;

int main() {
    cout << "Initial students: " << Student::getTotalStudents() << endl;
    
    Student s1(1, "Alice");
    s1.addScore(8.5);
    
    Student s2(2, "Bob");
    s2.addScore(9.0);
    
    cout << "Total students: " << Student::getTotalStudents() << endl;
    cout << "Average score: " << Student::getAverageScore() << endl;
    
    {
        Student s3(3, "Charlie");
        s3.addScore(7.5);
        cout << "With s3: " << Student::getTotalStudents() << endl;
    }  // s3 destroyed
    
    cout << "After s3 destroyed: " << Student::getTotalStudents() << endl;
    
    return 0;
}
```

### Const members

```cpp
#include <iostream>
#include <string>
using namespace std;

class Student {
private:
    int id;
    string name;
    float score;
    
public:
    Student(int i, string n, float s) : id(i), name(n), score(s) {}
    
    // Const member function - cannot modify member variables
    int getId() const {
        return id;
    }
    
    string getName() const {
        return name;
    }
    
    float getScore() const {
        return score;
    }
    
    void display() const {
        cout << "Student[ID=" << id << ", Name=" << name << ", Score=" << score << "]" << endl;
    }
    
    // Non-const member function
    void setScore(float s) {
        score = s;
    }
};

// Function with const reference parameter
void printStudent(const Student &s) {
    s.display();  // OK - display() is const
    // s.setScore(10);  // ERROR - setScore() is not const
}

int main() {
    Student s1(1, "Alice", 8.5f);
    
    // Const object
    const Student s2(2, "Bob", 9.0f);
    
    cout << s2.getName() << endl;  // OK - getName() is const
    s2.display();                   // OK - display() is const
    // s2.setScore(10);             // ERROR - setScore() is not const
    
    printStudent(s1);
    printStudent(s2);
    
    return 0;
}
```

## 🧑‍🏫 Bài 5: Operator Overloading cơ bản

### Overloading arithmetic operators

```cpp
#include <iostream>
using namespace std;

class Complex {
private:
    double real;
    double imag;
    
public:
    Complex(double r = 0, double i = 0) : real(r), imag(i) {}
    
    // Overload + operator
    Complex operator+(const Complex &other) const {
        return Complex(real + other.real, imag + other.imag);
    }
    
    // Overload - operator
    Complex operator-(const Complex &other) const {
        return Complex(real - other.real, imag - other.imag);
    }
    
    // Overload * operator
    Complex operator*(const Complex &other) const {
        return Complex(
            real * other.real - imag * other.imag,
            real * other.imag + imag * other.real
        );
    }
    
    // Overload unary - operator
    Complex operator-() const {
        return Complex(-real, -imag);
    }
    
    void display() const {
        cout << real;
        if (imag >= 0) cout << " + " << imag << "i";
        else cout << " - " << -imag << "i";
        cout << endl;
    }
};

int main() {
    Complex c1(3, 4);
    Complex c2(1, 2);
    
    cout << "c1 = "; c1.display();
    cout << "c2 = "; c2.display();
    
    Complex c3 = c1 + c2;
    cout << "c1 + c2 = "; c3.display();
    
    Complex c4 = c1 - c2;
    cout << "c1 - c2 = "; c4.display();
    
    Complex c5 = c1 * c2;
    cout << "c1 * c2 = "; c5.display();
    
    Complex c6 = -c1;
    cout << "-c1 = "; c6.display();
    
    return 0;
}
```

### Overloading comparison operators

```cpp
#include <iostream>
#include <string>
using namespace std;

class Student {
private:
    int id;
    string name;
    float score;
    
public:
    Student(int i, string n, float s) : id(i), name(n), score(s) {}
    
    // Overload == operator
    bool operator==(const Student &other) const {
        return id == other.id;
    }
    
    // Overload != operator
    bool operator!=(const Student &other) const {
        return !(*this == other);
    }
    
    // Overload < operator (compare by score)
    bool operator<(const Student &other) const {
        return score < other.score;
    }
    
    // Overload > operator
    bool operator>(const Student &other) const {
        return score > other.score;
    }
    
    // Overload <= operator
    bool operator<=(const Student &other) const {
        return !(*this > other);
    }
    
    // Overload >= operator
    bool operator>=(const Student &other) const {
        return !(*this < other);
    }
    
    void display() const {
        cout << "Student[ID=" << id << ", Name=" << name << ", Score=" << score << "]" << endl;
    }
};

int main() {
    Student s1(1, "Alice", 8.5f);
    Student s2(2, "Bob", 9.0f);
    Student s3(1, "Alice Clone", 7.0f);
    
    if (s1 == s3) {
        cout << "s1 and s3 have same ID" << endl;
    }
    
    if (s1 < s2) {
        cout << "s1 score < s2 score" << endl;
    }
    
    if (s2 > s1) {
        cout << "s2 score > s1 score" << endl;
    }
    
    return 0;
}
```

### Overloading stream operators

```cpp
#include <iostream>
#include <string>
using namespace std;

class Point {
private:
    int x;
    int y;
    
public:
    Point(int x = 0, int y = 0) : x(x), y(y) {}
    
    // Overload << operator (must be friend)
    friend ostream& operator<<(ostream &out, const Point &p);
    
    // Overload >> operator (must be friend)
    friend istream& operator>>(istream &in, Point &p);
};

ostream& operator<<(ostream &out, const Point &p) {
    out << "(" << p.x << ", " << p.y << ")";
    return out;
}

istream& operator>>(istream &in, Point &p) {
    cout << "Enter x: ";
    in >> p.x;
    cout << "Enter y: ";
    in >> p.y;
    return in;
}

int main() {
    Point p1(3, 4);
    
    cout << "p1 = " << p1 << endl;  // Using overloaded <<
    
    Point p2;
    cout << "Enter coordinates for p2:" << endl;
    cin >> p2;  // Using overloaded >>
    
    cout << "p2 = " << p2 << endl;
    
    return 0;
}
```

### Overloading subscript operator

```cpp
#include <iostream>
using namespace std;

class Array {
private:
    int *data;
    int size;
    
public:
    Array(int s) : size(s) {
        data = new int[size];
        for (int i = 0; i < size; i++) {
            data[i] = 0;
        }
    }
    
    ~Array() {
        delete[] data;
    }
    
    // Overload [] operator for read
    int operator[](int index) const {
        if (index >= 0 && index < size) {
            return data[index];
        }
        cout << "Index out of bounds!" << endl;
        return 0;
    }
    
    // Overload [] operator for write
    int& operator[](int index) {
        if (index >= 0 && index < size) {
            return data[index];
        }
        cout << "Index out of bounds!" << endl;
        return data[0];  // Return reference to first element
    }
    
    int getSize() const {
        return size;
    }
};

int main() {
    Array arr(5);
    
    // Write using []
    for (int i = 0; i < arr.getSize(); i++) {
        arr[i] = i * 10;
    }
    
    // Read using []
    cout << "Array elements: ";
    for (int i = 0; i < arr.getSize(); i++) {
        cout << arr[i] << " ";
    }
    cout << endl;
    
    // Bounds checking
    arr[10] = 100;  // Out of bounds
    
    return 0;
}
```

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Xây dựng lớp BankAccount

### Mô tả bài toán

Xây dựng hệ thống quản lý tài khoản ngân hàng với các chức năng:

- Tạo tài khoản mới
- Gửi tiền
- Rút tiền
- Chuyển tiền giữa các tài khoản
- Kiểm tra số dư
- Xem lịch sử giao dịch
- Tính lãi suất

### Yêu cầu

1. **Class BankAccount:**
   - Private members: accountNumber, ownerName, balance, transactionHistory
   - Constructors: default, parameterized, copy constructor
   - Destructor để cleanup
   - Getters/Setters với validation
   - Methods: deposit, withdraw, transfer, calculateInterest
   - Operator overloading: <<, >>, ==, <, >

2. **Encapsulation:**
   - Balance phải private, chỉ truy cập qua methods
   - Validate mọi transaction (số tiền > 0, đủ số dư)
   - Transaction history tự động update

3. **Static members:**
   - Đếm tổng số tài khoản
   - Tổng số tiền trong hệ thống

4. **File I/O:**
   - Save/Load accounts từ file
   - Export transaction history

**Gợi ý cấu trúc:**

```cpp
#include <iostream>
#include <string>
#include <vector>
using namespace std;

class Transaction {
private:
    string type;
    double amount;
    string date;
    double balanceAfter;
public:
    Transaction(string t, double amt, string d, double bal);
    void display() const;
};

class BankAccount {
private:
    string accountNumber;
    string ownerName;
    double balance;
    vector<Transaction> history;
    
    static int totalAccounts;
    static double totalMoney;
    
public:
    // Constructors
    BankAccount();
    BankAccount(string accNum, string owner, double initialBalance);
    BankAccount(const BankAccount &other);
    ~BankAccount();
    
    // Core operations
    bool deposit(double amount);
    bool withdraw(double amount);
    bool transfer(BankAccount &other, double amount);
    
    // Utilities
    double getBalance() const;
    void displayInfo() const;
    void displayHistory() const;
    double calculateInterest(double rate, int months) const;
    
    // Static methods
    static int getTotalAccounts();
    static double getTotalMoney();
    
    // Operator overloading
    friend ostream& operator<<(ostream &out, const BankAccount &acc);
    bool operator==(const BankAccount &other) const;
    bool operator<(const BankAccount &other) const;
};

int main() {
    // TODO: Implement menu-driven program
    // 1. Create account
    // 2. Deposit
    // 3. Withdraw
    // 4. Transfer
    // 5. Check balance
    // 6. View history
    // 7. Calculate interest
    // 8. Display all accounts
    // 0. Exit
    
    return 0;
}
```
