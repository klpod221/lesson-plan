# 📘 PHẦN 5: OOP NÂNG CAO - INHERITANCE VÀ POLYMORPHISM

- [📘 PHẦN 5: OOP NÂNG CAO - INHERITANCE VÀ POLYMORPHISM](#-phần-5-oop-nâng-cao---inheritance-và-polymorphism)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Inheritance (Kế thừa)](#-bài-1-inheritance-kế-thừa)
    - [Single Inheritance](#single-inheritance)
    - [Protected members](#protected-members)
    - [Constructor và Destructor trong inheritance](#constructor-và-destructor-trong-inheritance)
    - [Method overriding](#method-overriding)
  - [🧑‍🏫 Bài 2: Access Control trong Inheritance](#-bài-2-access-control-trong-inheritance)
    - [Public inheritance](#public-inheritance)
    - [Protected inheritance](#protected-inheritance)
    - [Private inheritance](#private-inheritance)
  - [🧑‍🏫 Bài 3: Polymorphism (Đa hình)](#-bài-3-polymorphism-đa-hình)
    - [Compile-time Polymorphism](#compile-time-polymorphism)
    - [Runtime Polymorphism với Virtual Functions](#runtime-polymorphism-với-virtual-functions)
    - [Pure Virtual Functions và Abstract Classes](#pure-virtual-functions-và-abstract-classes)
    - [Virtual Destructors](#virtual-destructors)
  - [🧑‍🏫 Bài 4: Multiple Inheritance](#-bài-4-multiple-inheritance)
    - [Cơ bản về Multiple Inheritance](#cơ-bản-về-multiple-inheritance)
    - [Diamond Problem và Virtual Inheritance](#diamond-problem-và-virtual-inheritance)
  - [🧑‍🏫 Bài 5: Advanced OOP Concepts](#-bài-5-advanced-oop-concepts)
    - [Abstract classes và Interfaces](#abstract-classes-và-interfaces)
    - [Object slicing](#object-slicing)
    - [Dynamic casting](#dynamic-casting)
    - [Operator overloading trong inheritance](#operator-overloading-trong-inheritance)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN: Hệ thống quản lý hình học](#-bài-tập-lớn-cuối-phần-hệ-thống-quản-lý-hình-học)
    - [Mô tả bài toán](#mô-tả-bài-toán)
    - [Yêu cầu](#yêu-cầu)
    - [Yêu cầu mở rộng](#yêu-cầu-mở-rộng)

## 🎯 Mục tiêu tổng quát

- Hiểu và áp dụng inheritance trong C++
- Nắm vững polymorphism (compile-time và runtime)
- Sử dụng virtual functions và pure virtual functions
- Hiểu về abstract classes và interfaces
- Xử lý multiple inheritance và diamond problem
- Áp dụng advanced OOP concepts trong thực tế

---

## 🧑‍🏫 Bài 1: Inheritance (Kế thừa)

### Single Inheritance

```cpp
#include <iostream>
#include <string>
using namespace std;

// Base class (Parent class)
class Person {
private:
    string name;
    int age;
    
public:
    Person(string n, int a) : name(n), age(a) {
        cout << "Person constructor called" << endl;
    }
    
    void display() {
        cout << "Name: " << name << ", Age: " << age << endl;
    }
    
    string getName() { return name; }
    int getAge() { return age; }
};

// Derived class (Child class)
class Student : public Person {
private:
    int studentId;
    float gpa;
    
public:
    Student(string n, int a, int id, float g) : Person(n, a), studentId(id), gpa(g) {
        cout << "Student constructor called" << endl;
    }
    
    void display() {
        Person::display();  // Call base class method
        cout << "Student ID: " << studentId << ", GPA: " << gpa << endl;
    }
    
    void study() {
        cout << getName() << " is studying..." << endl;
    }
};

// Another derived class
class Employee : public Person {
private:
    int employeeId;
    double salary;
    
public:
    Employee(string n, int a, int id, double s) : Person(n, a), employeeId(id), salary(s) {
        cout << "Employee constructor called" << endl;
    }
    
    void display() {
        Person::display();
        cout << "Employee ID: " << employeeId << ", Salary: $" << salary << endl;
    }
    
    void work() {
        cout << getName() << " is working..." << endl;
    }
};

int main() {
    cout << "=== Creating Student ===" << endl;
    Student s("Alice", 20, 12345, 3.8f);
    s.display();
    s.study();
    
    cout << "\n=== Creating Employee ===" << endl;
    Employee e("Bob", 30, 67890, 5000.0);
    e.display();
    e.work();
    
    return 0;
}
```

### Protected members

```cpp
#include <iostream>
#include <string>
using namespace std;

class Vehicle {
protected:  // Accessible in derived classes
    string brand;
    int year;
    
private:
    string engineNumber;  // Not accessible in derived classes
    
public:
    Vehicle(string b, int y, string eng) : brand(b), year(y), engineNumber(eng) {}
    
    void displayBasic() {
        cout << "Brand: " << brand << ", Year: " << year << endl;
    }
    
    string getEngineNumber() { return engineNumber; }
};

class Car : public Vehicle {
private:
    int doors;
    
public:
    Car(string b, int y, string eng, int d) : Vehicle(b, y, eng), doors(d) {}
    
    void display() {
        // Can access protected members
        cout << "Car: " << brand << " " << year << ", Doors: " << doors << endl;
        
        // Cannot access private members directly
        // cout << engineNumber;  // ERROR!
        
        // Must use public getter
        cout << "Engine: " << getEngineNumber() << endl;
    }
};

int main() {
    Car car("Toyota", 2023, "ENG123456", 4);
    car.display();
    
    return 0;
}
```

### Constructor và Destructor trong inheritance

```cpp
#include <iostream>
#include <string>
using namespace std;

class Base {
private:
    string name;
    
public:
    Base(string n) : name(n) {
        cout << "Base constructor: " << name << endl;
    }
    
    ~Base() {
        cout << "Base destructor: " << name << endl;
    }
};

class Derived : public Base {
private:
    int value;
    
public:
    Derived(string n, int v) : Base(n), value(v) {
        cout << "Derived constructor: " << value << endl;
    }
    
    ~Derived() {
        cout << "Derived destructor: " << value << endl;
    }
};

int main() {
    cout << "Creating object:" << endl;
    {
        Derived obj("MyObject", 42);
    }  // Object destroyed here
    cout << "Object destroyed" << endl;
    
    /*
     * Output:
     * Creating object:
     * Base constructor: MyObject
     * Derived constructor: 42
     * Derived destructor: 42
     * Base destructor: MyObject
     * Object destroyed
     */
    
    return 0;
}
```

### Method overriding

```cpp
#include <iostream>
#include <string>
using namespace std;

class Animal {
protected:
    string name;
    
public:
    Animal(string n) : name(n) {}
    
    void eat() {
        cout << name << " is eating" << endl;
    }
    
    void makeSound() {
        cout << name << " makes a sound" << endl;
    }
};

class Dog : public Animal {
public:
    Dog(string n) : Animal(n) {}
    
    // Override makeSound method
    void makeSound() {
        cout << name << " barks: Woof! Woof!" << endl;
    }
    
    void fetch() {
        cout << name << " is fetching the ball" << endl;
    }
};

class Cat : public Animal {
public:
    Cat(string n) : Animal(n) {}
    
    // Override makeSound method
    void makeSound() {
        cout << name << " meows: Meow! Meow!" << endl;
    }
    
    void scratch() {
        cout << name << " is scratching" << endl;
    }
};

int main() {
    Animal animal("Generic Animal");
    animal.makeSound();
    
    Dog dog("Buddy");
    dog.eat();        // Inherited from Animal
    dog.makeSound();  // Overridden in Dog
    dog.fetch();      // Specific to Dog
    
    Cat cat("Whiskers");
    cat.eat();        // Inherited from Animal
    cat.makeSound();  // Overridden in Cat
    cat.scratch();    // Specific to Cat
    
    return 0;
}
```

---

## 🧑‍🏫 Bài 2: Access Control trong Inheritance

### Public inheritance

```cpp
#include <iostream>
using namespace std;

class Base {
public:
    int publicVar;
protected:
    int protectedVar;
private:
    int privateVar;
    
public:
    Base() : publicVar(1), protectedVar(2), privateVar(3) {}
};

// Public inheritance: public -> public, protected -> protected
class PublicDerived : public Base {
public:
    void display() {
        cout << "publicVar: " << publicVar << endl;      // OK
        cout << "protectedVar: " << protectedVar << endl; // OK
        // cout << privateVar;  // ERROR - not accessible
    }
};

int main() {
    PublicDerived obj;
    obj.display();
    
    cout << "From main: " << obj.publicVar << endl;  // OK
    // cout << obj.protectedVar;  // ERROR - protected
    
    return 0;
}
```

### Protected inheritance

```cpp
#include <iostream>
using namespace std;

class Base {
public:
    int publicVar;
protected:
    int protectedVar;
    
public:
    Base() : publicVar(1), protectedVar(2) {}
};

// Protected inheritance: public -> protected, protected -> protected
class ProtectedDerived : protected Base {
public:
    void display() {
        cout << "publicVar: " << publicVar << endl;      // OK (now protected)
        cout << "protectedVar: " << protectedVar << endl; // OK
    }
};

int main() {
    ProtectedDerived obj;
    obj.display();
    
    // cout << obj.publicVar;  // ERROR - now protected in derived class
    
    return 0;
}
```

### Private inheritance

```cpp
#include <iostream>
using namespace std;

class Base {
public:
    int publicVar;
protected:
    int protectedVar;
    
public:
    Base() : publicVar(1), protectedVar(2) {}
    
    void baseMethod() {
        cout << "Base method" << endl;
    }
};

// Private inheritance: public -> private, protected -> private
class PrivateDerived : private Base {
public:
    void display() {
        cout << "publicVar: " << publicVar << endl;      // OK (now private)
        cout << "protectedVar: " << protectedVar << endl; // OK (now private)
        baseMethod();  // OK
    }
};

// Further derived class
class FurtherDerived : public PrivateDerived {
public:
    void test() {
        // Cannot access Base members - they are private in PrivateDerived
        // cout << publicVar;  // ERROR
        // baseMethod();       // ERROR
    }
};

int main() {
    PrivateDerived obj;
    obj.display();
    
    // Cannot access Base members from outside
    // obj.publicVar;   // ERROR
    // obj.baseMethod(); // ERROR
    
    return 0;
}
```

**Tóm tắt:**

| Base Access | Public Inheritance | Protected Inheritance | Private Inheritance |
|-------------|-------------------|----------------------|---------------------|
| public      | public            | protected            | private             |
| protected   | protected         | protected            | private             |
| private     | not accessible    | not accessible       | not accessible      |

---

## 🧑‍🏫 Bài 3: Polymorphism (Đa hình)

### Compile-time Polymorphism

Function overloading và operator overloading (đã học ở Part 4).

```cpp
#include <iostream>
using namespace std;

class Calculator {
public:
    // Function overloading
    int add(int a, int b) {
        return a + b;
    }
    
    double add(double a, double b) {
        return a + b;
    }
    
    int add(int a, int b, int c) {
        return a + b + c;
    }
};

int main() {
    Calculator calc;
    
    cout << calc.add(5, 10) << endl;        // Calls int version
    cout << calc.add(5.5, 10.2) << endl;    // Calls double version
    cout << calc.add(1, 2, 3) << endl;      // Calls 3-parameter version
    
    return 0;
}
```

### Runtime Polymorphism với Virtual Functions

```cpp
#include <iostream>
#include <string>
using namespace std;

class Shape {
protected:
    string name;
    
public:
    Shape(string n) : name(n) {}
    
    // Virtual function - can be overridden
    virtual void draw() {
        cout << "Drawing " << name << endl;
    }
    
    // Virtual function
    virtual double getArea() {
        return 0.0;
    }
    
    // Non-virtual function
    void display() {
        cout << "Shape: " << name << endl;
    }
};

class Circle : public Shape {
private:
    double radius;
    
public:
    Circle(double r) : Shape("Circle"), radius(r) {}
    
    // Override virtual function
    void draw() override {
        cout << "Drawing a circle with radius " << radius << endl;
    }
    
    double getArea() override {
        return 3.14159 * radius * radius;
    }
};

class Rectangle : public Shape {
private:
    double width, height;
    
public:
    Rectangle(double w, double h) : Shape("Rectangle"), width(w), height(h) {}
    
    void draw() override {
        cout << "Drawing a rectangle " << width << " x " << height << endl;
    }
    
    double getArea() override {
        return width * height;
    }
};

int main() {
    // Polymorphism in action
    Shape *shapes[3];
    
    shapes[0] = new Shape("Generic Shape");
    shapes[1] = new Circle(5.0);
    shapes[2] = new Rectangle(4.0, 6.0);
    
    cout << "=== Polymorphic behavior ===" << endl;
    for (int i = 0; i < 3; i++) {
        shapes[i]->draw();      // Calls appropriate version
        cout << "Area: " << shapes[i]->getArea() << endl;
        cout << endl;
    }
    
    // Cleanup
    for (int i = 0; i < 3; i++) {
        delete shapes[i];
    }
    
    return 0;
}
```

### Pure Virtual Functions và Abstract Classes

```cpp
#include <iostream>
#include <string>
using namespace std;

// Abstract class - has at least one pure virtual function
class Animal {
protected:
    string name;
    
public:
    Animal(string n) : name(n) {}
    
    // Pure virtual function - must be overridden
    virtual void makeSound() = 0;
    
    // Pure virtual function
    virtual void move() = 0;
    
    // Normal virtual function
    virtual void eat() {
        cout << name << " is eating" << endl;
    }
    
    // Non-virtual function
    void sleep() {
        cout << name << " is sleeping" << endl;
    }
};

class Dog : public Animal {
public:
    Dog(string n) : Animal(n) {}
    
    // Must implement pure virtual functions
    void makeSound() override {
        cout << name << " says: Woof! Woof!" << endl;
    }
    
    void move() override {
        cout << name << " runs on four legs" << endl;
    }
};

class Bird : public Animal {
public:
    Bird(string n) : Animal(n) {}
    
    void makeSound() override {
        cout << name << " says: Tweet! Tweet!" << endl;
    }
    
    void move() override {
        cout << name << " flies in the sky" << endl;
    }
    
    // Override optional virtual function
    void eat() override {
        cout << name << " pecks at seeds" << endl;
    }
};

int main() {
    // Cannot instantiate abstract class
    // Animal animal("Generic");  // ERROR!
    
    // Can use pointers to abstract class
    Animal *animals[2];
    
    animals[0] = new Dog("Buddy");
    animals[1] = new Bird("Tweety");
    
    for (int i = 0; i < 2; i++) {
        animals[i]->makeSound();
        animals[i]->move();
        animals[i]->eat();
        animals[i]->sleep();
        cout << endl;
    }
    
    // Cleanup
    for (int i = 0; i < 2; i++) {
        delete animals[i];
    }
    
    return 0;
}
```

### Virtual Destructors

```cpp
#include <iostream>
using namespace std;

class Base {
public:
    Base() {
        cout << "Base constructor" << endl;
    }
    
    // Virtual destructor - IMPORTANT for proper cleanup
    virtual ~Base() {
        cout << "Base destructor" << endl;
    }
};

class Derived : public Base {
private:
    int *data;
    
public:
    Derived() {
        data = new int[10];
        cout << "Derived constructor" << endl;
    }
    
    ~Derived() {
        delete[] data;
        cout << "Derived destructor" << endl;
    }
};

int main() {
    cout << "=== With virtual destructor ===" << endl;
    Base *ptr = new Derived();
    delete ptr;  // Calls both destructors correctly
    
    /*
     * Output:
     * Base constructor
     * Derived constructor
     * Derived destructor  <- Called!
     * Base destructor
     */
    
    return 0;
}
```

**Lưu ý quan trọng:** Luôn khai báo destructor là `virtual` trong base class nếu dự định sử dụng polymorphism!

---

## 🧑‍🏫 Bài 4: Multiple Inheritance

### Cơ bản về Multiple Inheritance

```cpp
#include <iostream>
#include <string>
using namespace std;

class Flyable {
public:
    void fly() {
        cout << "Flying in the sky" << endl;
    }
};

class Swimmable {
public:
    void swim() {
        cout << "Swimming in water" << endl;
    }
};

// Multiple inheritance
class Duck : public Flyable, public Swimmable {
private:
    string name;
    
public:
    Duck(string n) : name(n) {}
    
    void quack() {
        cout << name << " says: Quack! Quack!" << endl;
    }
};

class Fish : public Swimmable {
private:
    string name;
    
public:
    Fish(string n) : name(n) {}
    
    void bubble() {
        cout << name << " blows bubbles" << endl;
    }
};

int main() {
    Duck duck("Donald");
    duck.quack();
    duck.fly();   // From Flyable
    duck.swim();  // From Swimmable
    
    cout << endl;
    
    Fish fish("Nemo");
    fish.bubble();
    fish.swim();  // From Swimmable
    
    return 0;
}
```

### Diamond Problem và Virtual Inheritance

```cpp
#include <iostream>
using namespace std;

// Diamond problem
class Animal {
protected:
    string name;
    
public:
    Animal(string n) : name(n) {
        cout << "Animal constructor: " << name << endl;
    }
    
    void eat() {
        cout << name << " is eating" << endl;
    }
};

class Mammal : public Animal {
public:
    Mammal(string n) : Animal(n) {
        cout << "Mammal constructor" << endl;
    }
};

class Bird : public Animal {
public:
    Bird(string n) : Animal(n) {
        cout << "Bird constructor" << endl;
    }
};

// Problem: Bat has TWO copies of Animal!
class Bat : public Mammal, public Bird {
public:
    Bat(string n) : Mammal(n), Bird(n) {
        cout << "Bat constructor" << endl;
    }
    
    void fly() {
        cout << "Bat is flying" << endl;
    }
};

int main() {
    Bat bat("Batty");
    
    // Ambiguous - which Animal's eat()?
    // bat.eat();  // ERROR: ambiguous!
    
    // Must specify which parent
    bat.Mammal::eat();
    bat.Bird::eat();
    
    return 0;
}
```

**Giải quyết với Virtual Inheritance:**

```cpp
#include <iostream>
using namespace std;

class Animal {
protected:
    string name;
    
public:
    Animal(string n) : name(n) {
        cout << "Animal constructor: " << name << endl;
    }
    
    void eat() {
        cout << name << " is eating" << endl;
    }
};

// Virtual inheritance
class Mammal : virtual public Animal {
public:
    Mammal(string n) : Animal(n) {
        cout << "Mammal constructor" << endl;
    }
};

// Virtual inheritance
class Bird : virtual public Animal {
public:
    Bird(string n) : Animal(n) {
        cout << "Bird constructor" << endl;
    }
};

// Now Bat has only ONE copy of Animal
class Bat : public Mammal, public Bird {
public:
    // Must call Animal constructor directly
    Bat(string n) : Animal(n), Mammal(n), Bird(n) {
        cout << "Bat constructor" << endl;
    }
    
    void fly() {
        cout << name << " is flying" << endl;
    }
};

int main() {
    Bat bat("Batty");
    
    // No ambiguity now!
    bat.eat();
    bat.fly();
    
    return 0;
}
```

---

## 🧑‍🏫 Bài 5: Advanced OOP Concepts

### Abstract classes và Interfaces

```cpp
#include <iostream>
#include <string>
using namespace std;

// Interface (pure abstract class)
class IDrawable {
public:
    virtual void draw() = 0;
    virtual ~IDrawable() {}
};

class IPrintable {
public:
    virtual void print() = 0;
    virtual ~IPrintable() {}
};

// Concrete class implementing multiple interfaces
class Document : public IDrawable, public IPrintable {
private:
    string content;
    
public:
    Document(string c) : content(c) {}
    
    void draw() override {
        cout << "Drawing document: " << content << endl;
    }
    
    void print() override {
        cout << "Printing document: " << content << endl;
    }
};

class Image : public IDrawable, public IPrintable {
private:
    string filename;
    
public:
    Image(string f) : filename(f) {}
    
    void draw() override {
        cout << "Drawing image: " << filename << endl;
    }
    
    void print() override {
        cout << "Printing image: " << filename << endl;
    }
};

// Function that works with any IDrawable
void displayItem(IDrawable *item) {
    item->draw();
}

// Function that works with any IPrintable
void printItem(IPrintable *item) {
    item->print();
}

int main() {
    Document doc("Report.pdf");
    Image img("photo.jpg");
    
    displayItem(&doc);
    displayItem(&img);
    
    cout << endl;
    
    printItem(&doc);
    printItem(&img);
    
    return 0;
}
```

### Object slicing

```cpp
#include <iostream>
using namespace std;

class Base {
protected:
    int x;
    
public:
    Base(int val) : x(val) {}
    
    virtual void display() {
        cout << "Base: x = " << x << endl;
    }
};

class Derived : public Base {
private:
    int y;
    
public:
    Derived(int val1, int val2) : Base(val1), y(val2) {}
    
    void display() override {
        cout << "Derived: x = " << x << ", y = " << y << endl;
    }
};

// Pass by value - SLICING occurs!
void displayByValue(Base obj) {
    obj.display();  // Always calls Base::display()
}

// Pass by reference - NO slicing
void displayByReference(Base &obj) {
    obj.display();  // Calls appropriate version
}

// Pass by pointer - NO slicing
void displayByPointer(Base *obj) {
    obj->display();  // Calls appropriate version
}

int main() {
    Derived d(10, 20);
    
    cout << "Direct call:" << endl;
    d.display();
    
    cout << "\nPass by value (SLICING):" << endl;
    displayByValue(d);  // Only Base part is copied!
    
    cout << "\nPass by reference (NO slicing):" << endl;
    displayByReference(d);
    
    cout << "\nPass by pointer (NO slicing):" << endl;
    displayByPointer(&d);
    
    return 0;
}
```

### Dynamic casting

```cpp
#include <iostream>
#include <string>
using namespace std;

class Animal {
public:
    virtual void makeSound() {
        cout << "Animal sound" << endl;
    }
    
    virtual ~Animal() {}
};

class Dog : public Animal {
public:
    void makeSound() override {
        cout << "Woof!" << endl;
    }
    
    void fetch() {
        cout << "Dog is fetching" << endl;
    }
};

class Cat : public Animal {
public:
    void makeSound() override {
        cout << "Meow!" << endl;
    }
    
    void scratch() {
        cout << "Cat is scratching" << endl;
    }
};

int main() {
    Animal *animals[3];
    animals[0] = new Dog();
    animals[1] = new Cat();
    animals[2] = new Animal();
    
    for (int i = 0; i < 3; i++) {
        animals[i]->makeSound();
        
        // Try to cast to Dog
        Dog *dog = dynamic_cast<Dog*>(animals[i]);
        if (dog != nullptr) {
            cout << "This is a dog!" << endl;
            dog->fetch();
        }
        
        // Try to cast to Cat
        Cat *cat = dynamic_cast<Cat*>(animals[i]);
        if (cat != nullptr) {
            cout << "This is a cat!" << endl;
            cat->scratch();
        }
        
        cout << endl;
    }
    
    // Cleanup
    for (int i = 0; i < 3; i++) {
        delete animals[i];
    }
    
    return 0;
}
```

### Operator overloading trong inheritance

```cpp
#include <iostream>
using namespace std;

class Vector2D {
protected:
    double x, y;
    
public:
    Vector2D(double x = 0, double y = 0) : x(x), y(y) {}
    
    virtual Vector2D operator+(const Vector2D &other) const {
        return Vector2D(x + other.x, y + other.y);
    }
    
    virtual void display() const {
        cout << "(" << x << ", " << y << ")";
    }
};

class Vector3D : public Vector2D {
private:
    double z;
    
public:
    Vector3D(double x = 0, double y = 0, double z = 0) : Vector2D(x, y), z(z) {}
    
    // Override operator+ for 3D vectors
    Vector3D operator+(const Vector3D &other) const {
        return Vector3D(x + other.x, y + other.y, z + other.z);
    }
    
    void display() const override {
        cout << "(" << x << ", " << y << ", " << z << ")";
    }
};

int main() {
    Vector2D v1(1, 2);
    Vector2D v2(3, 4);
    Vector2D v3 = v1 + v2;
    
    cout << "2D: ";
    v1.display();
    cout << " + ";
    v2.display();
    cout << " = ";
    v3.display();
    cout << endl;
    
    Vector3D v4(1, 2, 3);
    Vector3D v5(4, 5, 6);
    Vector3D v6 = v4 + v5;
    
    cout << "3D: ";
    v4.display();
    cout << " + ";
    v5.display();
    cout << " = ";
    v6.display();
    cout << endl;
    
    return 0;
}
```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Hệ thống quản lý hình học

### Mô tả bài toán

Xây dựng hệ thống quản lý các hình học 2D với hierarchy đầy đủ:

- Abstract base class `Shape`
- Derived classes: `Circle`, `Rectangle`, `Triangle`, `Polygon`
- Tính toán diện tích, chu vi
- Vẽ hình (text-based)
- So sánh các hình
- Lưu/load từ file

### Yêu cầu

1. **Class hierarchy:**
   - `Shape` (abstract base class)
     - Pure virtual: `getArea()`, `getPerimeter()`, `draw()`
     - Virtual: `display()`, destructor
   - `Circle`, `Rectangle`, `Triangle` kế thừa từ `Shape`
   - `Square` kế thừa từ `Rectangle`

2. **Polymorphism:**
   - Sử dụng virtual functions
   - Dynamic casting khi cần
   - Operator overloading: `<<`, `==`, `<`, `>`

3. **Advanced features:**
   - Container để quản lý nhiều shapes
   - Sort shapes by area
   - Find largest/smallest shape
   - Calculate total area

4. **File I/O:**
   - Save shapes to file
   - Load shapes from file
   - Different formats for different shapes

**Code template:**

```cpp
#include <iostream>
#include <vector>
#include <string>
#include <cmath>
using namespace std;

// Abstract base class
class Shape {
protected:
    string name;
    string color;
    
public:
    Shape(string n, string c) : name(n), color(c) {}
    virtual ~Shape() {}
    
    // Pure virtual functions
    virtual double getArea() const = 0;
    virtual double getPerimeter() const = 0;
    virtual void draw() const = 0;
    
    // Virtual functions
    virtual void display() const {
        cout << "Shape: " << name << ", Color: " << color << endl;
    }
    
    // Getters
    string getName() const { return name; }
    string getColor() const { return color; }
    
    // Operator overloading
    bool operator<(const Shape &other) const {
        return getArea() < other.getArea();
    }
    
    bool operator>(const Shape &other) const {
        return getArea() > other.getArea();
    }
};

// Circle class
class Circle : public Shape {
private:
    double radius;
    
public:
    Circle(string c, double r) : Shape("Circle", c), radius(r) {}
    
    double getArea() const override {
        return 3.14159 * radius * radius;
    }
    
    double getPerimeter() const override {
        return 2 * 3.14159 * radius;
    }
    
    void draw() const override {
        cout << "Drawing a circle with radius " << radius << endl;
    }
    
    void display() const override {
        Shape::display();
        cout << "Radius: " << radius << endl;
        cout << "Area: " << getArea() << ", Perimeter: " << getPerimeter() << endl;
    }
};

// Rectangle class
class Rectangle : public Shape {
protected:
    double width, height;
    
public:
    Rectangle(string c, double w, double h) : Shape("Rectangle", c), width(w), height(h) {}
    
    double getArea() const override {
        return width * height;
    }
    
    double getPerimeter() const override {
        return 2 * (width + height);
    }
    
    void draw() const override {
        cout << "Drawing a rectangle " << width << " x " << height << endl;
    }
    
    void display() const override {
        Shape::display();
        cout << "Width: " << width << ", Height: " << height << endl;
        cout << "Area: " << getArea() << ", Perimeter: " << getPerimeter() << endl;
    }
};

// Square inherits from Rectangle
class Square : public Rectangle {
public:
    Square(string c, double side) : Rectangle(c, side, side) {
        name = "Square";
    }
    
    void draw() const override {
        cout << "Drawing a square with side " << width << endl;
    }
};

// Triangle class
class Triangle : public Shape {
private:
    double a, b, c;  // Three sides
    
public:
    Triangle(string col, double side1, double side2, double side3) 
        : Shape("Triangle", col), a(side1), b(side2), c(side3) {}
    
    double getArea() const override {
        double s = (a + b + c) / 2;
        return sqrt(s * (s - a) * (s - b) * (s - c));
    }
    
    double getPerimeter() const override {
        return a + b + c;
    }
    
    void draw() const override {
        cout << "Drawing a triangle with sides " << a << ", " << b << ", " << c << endl;
    }
    
    void display() const override {
        Shape::display();
        cout << "Sides: " << a << ", " << b << ", " << c << endl;
        cout << "Area: " << getArea() << ", Perimeter: " << getPerimeter() << endl;
    }
};

// ShapeManager class
class ShapeManager {
private:
    vector<Shape*> shapes;
    
public:
    ~ShapeManager() {
        for (Shape *s : shapes) {
            delete s;
        }
    }
    
    void addShape(Shape *shape) {
        shapes.push_back(shape);
    }
    
    void displayAll() const {
        cout << "\n=== ALL SHAPES ===" << endl;
        for (const Shape *s : shapes) {
            s->display();
            cout << endl;
        }
    }
    
    void drawAll() const {
        cout << "\n=== DRAWING ALL SHAPES ===" << endl;
        for (const Shape *s : shapes) {
            s->draw();
        }
    }
    
    double getTotalArea() const {
        double total = 0;
        for (const Shape *s : shapes) {
            total += s->getArea();
        }
        return total;
    }
    
    Shape* getLargestShape() const {
        if (shapes.empty()) return nullptr;
        
        Shape *largest = shapes[0];
        for (Shape *s : shapes) {
            if (*s > *largest) {
                largest = s;
            }
        }
        return largest;
    }
};

int main() {
    ShapeManager manager;
    
    manager.addShape(new Circle("Red", 5.0));
    manager.addShape(new Rectangle("Blue", 4.0, 6.0));
    manager.addShape(new Square("Green", 5.0));
    manager.addShape(new Triangle("Yellow", 3.0, 4.0, 5.0));
    
    manager.displayAll();
    manager.drawAll();
    
    cout << "\nTotal area: " << manager.getTotalArea() << endl;
    
    Shape *largest = manager.getLargestShape();
    if (largest) {
        cout << "\nLargest shape:" << endl;
        largest->display();
    }
    
    return 0;
}
```

### Yêu cầu mở rộng

1. Thêm các hình khác: `Ellipse`, `Hexagon`, `Pentagon`
2. Implement sorting shapes by area or perimeter
3. Thêm method `isInside(x, y)` để kiểm tra điểm có nằm trong hình không
4. Thêm collision detection giữa các hình
5. Save/load shapes to/from file (text hoặc binary)
6. Implement copy constructor và assignment operator đúng cách
7. Thêm move constructor và move assignment (C++11)
