// C++ inheritance and polymorphism
#include <iostream>
#include <string>
#include <vector>
#include <memory>
using namespace std;

// Base class
class Animal {
protected:
    string name;
    int age;
    
public:
    Animal(string n, int a) : name(n), age(a) {}
    
    virtual ~Animal() {
        cout << "Animal destructor: " << name << endl;
    }
    
    virtual void makeSound() const {
        cout << name << " makes a sound" << endl;
    }
    
    virtual void display() const {
        cout << "Name: " << name << ", Age: " << age << endl;
    }
};

// Derived class - Dog
class Dog : public Animal {
private:
    string breed;
    
public:
    Dog(string n, int a, string b) : Animal(n, a), breed(b) {}
    
    ~Dog() {
        cout << "Dog destructor: " << name << endl;
    }
    
    void makeSound() const override {
        cout << name << " barks: Woof! Woof!" << endl;
    }
    
    void display() const override {
        Animal::display();
        cout << "Breed: " << breed << endl;
    }
};

// Derived class - Cat
class Cat : public Animal {
private:
    string color;
    
public:
    Cat(string n, int a, string c) : Animal(n, a), color(c) {}
    
    ~Cat() {
        cout << "Cat destructor: " << name << endl;
    }
    
    void makeSound() const override {
        cout << name << " meows: Meow! Meow!" << endl;
    }
    
    void display() const override {
        Animal::display();
        cout << "Color: " << color << endl;
    }
};

// Abstract class
class Shape {
public:
    virtual ~Shape() {}
    
    virtual double area() const = 0;  // Pure virtual function
    virtual double perimeter() const = 0;
    virtual void display() const = 0;
};

class Circle : public Shape {
private:
    double radius;
    const double PI = 3.14159;
    
public:
    Circle(double r) : radius(r) {}
    
    double area() const override {
        return PI * radius * radius;
    }
    
    double perimeter() const override {
        return 2 * PI * radius;
    }
    
    void display() const override {
        cout << "Circle - Radius: " << radius 
             << ", Area: " << area() 
             << ", Perimeter: " << perimeter() << endl;
    }
};

class Rectangle : public Shape {
private:
    double width;
    double height;
    
public:
    Rectangle(double w, double h) : width(w), height(h) {}
    
    double area() const override {
        return width * height;
    }
    
    double perimeter() const override {
        return 2 * (width + height);
    }
    
    void display() const override {
        cout << "Rectangle - Width: " << width << ", Height: " << height
             << ", Area: " << area()
             << ", Perimeter: " << perimeter() << endl;
    }
};

int main() {
    cout << "=== Inheritance and Polymorphism ===" << endl;
    
    // Polymorphism with animals
    vector<unique_ptr<Animal>> animals;
    animals.push_back(make_unique<Dog>("Buddy", 3, "Golden Retriever"));
    animals.push_back(make_unique<Cat>("Whiskers", 2, "Orange"));
    animals.push_back(make_unique<Dog>("Max", 5, "German Shepherd"));
    
    cout << "\nAll animals:" << endl;
    for (const auto &animal : animals) {
        animal->display();
        animal->makeSound();
        cout << endl;
    }
    
    cout << "\n=== Abstract Classes ===" << endl;
    
    // Polymorphism with shapes
    vector<unique_ptr<Shape>> shapes;
    shapes.push_back(make_unique<Circle>(5.0));
    shapes.push_back(make_unique<Rectangle>(4.0, 6.0));
    shapes.push_back(make_unique<Circle>(3.0));
    
    cout << "\nAll shapes:" << endl;
    double totalArea = 0;
    for (const auto &shape : shapes) {
        shape->display();
        totalArea += shape->area();
    }
    
    cout << "\nTotal area of all shapes: " << totalArea << endl;
    
    return 0;
}
