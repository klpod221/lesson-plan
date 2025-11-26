---
prev:
  text: '📊 Arrays, Strings and Functions'
  link: '/JAVA/Part2'
next:
  text: '📁 File I/O and Collections'
  link: '/JAVA/Part4'
---

# 📘 PART 3: OBJECT-ORIENTED PROGRAMMING (OOP)

## 🎯 General Objectives

- Understand and apply Object-Oriented Programming principles in Java.
- Work with classes, objects, inheritance, encapsulation, and polymorphism.

## 🧑‍🏫 Lesson 1: Introduction to OOP

Object-Oriented Programming (OOP) is a popular programming paradigm based on the concept of "objects", helping to organize source code efficiently and intuitively. This model is not only present in Java but also in many other programming languages like C++, Python, C#, Ruby, etc. Therefore, mastering OOP is crucial for any programmer.

### Basic Concepts in OOP

#### Class

- Is a blueprint or template for objects
- Defines attributes (data) and methods (behavior)
- Example: Class `Car` has attributes like `color`, `brand`, `model` and methods like `start()`, `stop()`, `accelerate()`

```java
public class Car {
    // Attributes
    private String color;
    private String brand;
    private String model;

    // Methods
    public void start() {
        System.out.println("Car is starting");
    }

    public void stop() {
        System.out.println("Car has stopped");
    }
}
```

#### Object

- Is a specific instance of a class
- Each object has its own state (attribute values) and behavior (methods)
- Example: `myCar` is an object of class `Car`

```java
Car myCar = new Car();  // Create object from Car class
myCar.start();          // Call object's method
```

#### Four Pillars of OOP (You will learn in detail through examples below)

- **Encapsulation:**

  - Bundles data and methods that operate on that data into a single unit
  - Uses access modifiers to control data access
  - Protects data by using getters and setters

    ```java
    public class BankAccount {
            private double balance;  // Private attribute - protects data

            public double getBalance() {
                return balance;     // Getter - allows reading data
            }

            public void deposit(double amount) {
                if (amount > 0) {   // Control input data
                    balance += amount;
                }
            }
    }
    ```

- **Inheritance:**

  - Allows creating a new class that inherits attributes and methods from an existing class
  - Reuses code and creates hierarchical relationships between classes
  - Uses `extends` keyword to inherit and `@Override` to override methods

    ```java
    public class ElectricCar extends Car {
            private int batteryCapacity;

            public void charge() {
                System.out.println("Charging battery...");
            }

            @Override
            public void start() {
                System.out.println("Electric car starts silently");
            }
    }
    ```

- **Polymorphism:**

  - Allows objects to take on many "forms"
  - Can treat objects of a subclass as objects of the superclass
  - Includes compile-time polymorphism (method overloading) and runtime polymorphism (method overriding)

    ```java
    // Runtime polymorphism
    Car vehicle = new ElectricCar();  // Parent variable references child object

    vehicle.start();  // Calls overridden method of ElectricCar

    // Compile-time polymorphism
    public class Calculator {
            public int add(int a, int b) { return a + b; }
            public double add(double a, double b) { return a + b; }  // Method overloading
    }
    ```

- **Abstraction:**

  - Focuses on essential features, hiding complex details
  - Uses abstract classes and interfaces
  - Helps reduce complexity and increase reusability

    ```java
    abstract class Vehicle {
            abstract void start();  // Abstract method, no body

            public void stop() {    // Concrete method
                System.out.println("Vehicle has stopped");
            }
    }

    interface Drivable {
            void drive();           // All methods in interface are abstract
    }
    ```

### Why is OOP Important?

1. **Real-world Modeling**:
   - OOP allows representing real-world entities intuitively
   - Concepts like classes and objects map easily to real entities

2. **Efficient Code Organization**:
   - Source code is organized into small, manageable units
   - Makes dividing work for development teams easier

3. **Code Reusability**:
   - Through inheritance and encapsulation, code can be reused
   - Reduces code duplication, saving time and effort

4. **Maintainability and Extensibility**:
   - Easy to update or extend classes without affecting the rest
   - Internal implementation can be changed without affecting user interface

5. **Security and Stability**:
   - Encapsulation helps protect data and ensure integrity
   - Reduces impact of errors and increases application stability

### Comparing OOP with Procedural Programming

| Criteria | Object-Oriented Programming | Procedural Programming |
| -------- | --------------------------- | ---------------------- |
| Organization | Based on objects | Based on functions and procedures |
| Modularity | High | Low |
| Code Reuse | Easy through inheritance | Difficult, often requires copying code |
| Data Security | High thanks to encapsulation | Low, data often accessed globally |
| Complexity | Higher initially, more complex design | Simpler for small applications |
| Extensibility | Easy to extend | Hard to extend when application grows |

## 🧑‍🏫 Lesson 2: Classes and Objects

### Declaring Classes and Creating Objects

```java
// Person.java
// Declare Person class
public class Person {
    // Attributes
    String name;
    int age;
    String address;

    // No-argument constructor (default constructor)
    public Person() {
        name = "Unknown";
        age = 0;
        address = "Unknown";
    }

    // Parameterized constructor
    public Person(String name, int age, String address) {
        this.name = name;
        this.age = age;
        this.address = address;
    }

    // Methods
    public void displayInfo() {
        System.out.println("Name: " + name);
        System.out.println("Age: " + age);
        System.out.println("Address: " + address);
    }
}
```

### Creating and Using Objects

```java
// PersonDemo.java
public class PersonDemo {
    public static void main(String[] args) {
        // Create object using no-argument constructor
        Person person1 = new Person();
        System.out.println("Info person1:");
        person1.displayInfo();

        // Create object using parameterized constructor
        Person person2 = new Person("Nguyen Van A", 30, "Hanoi");
        System.out.println("\nInfo person2:");
        person2.displayInfo();

        // Change object attributes
        person1.name = "Tran Thi B";
        person1.age = 25;
        person1.address = "Ho Chi Minh";

        System.out.println("\nInfo person1 after update:");
        person1.displayInfo();
    }
}
```

### Real-world Example - Product Management Class

```java
public class Product {
    // Attributes
    private String id;
    private String name;
    private double price;
    private int quantity;

    // Constructor
    public Product(String id, String name, double price, int quantity) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
    }

    // Methods
    public double calculateTotal() {
        return price * quantity;
    }

    public void increaseQuantity(int amount) {
        if (amount > 0) {
            quantity += amount;
        }
    }

    public void decreaseQuantity(int amount) {
        if (amount > 0 && amount <= quantity) {
            quantity -= amount;
        }
    }

    public void displayProductInfo() {
        System.out.println("Product ID: " + id);
        System.out.println("Product Name: " + name);
        System.out.println("Price: " + price);
        System.out.println("Quantity: " + quantity);
        System.out.println("Total Value: " + calculateTotal());
    }
}

public class ProductDemo {
    public static void main(String[] args) {
        // Create product objects
        Product product1 = new Product("SP001", "Laptop Dell XPS", 25000000, 5);
        Product product2 = new Product("SP002", "iPhone 13", 20000000, 10);

        // Display product info
        System.out.println("Product 1 Info:");
        product1.displayProductInfo();

        System.out.println("\nProduct 2 Info:");
        product2.displayProductInfo();

        // Adjust quantity
        product1.increaseQuantity(3);
        product2.decreaseQuantity(2);

        System.out.println("\nInfo after quantity update:");
        System.out.println("Product 1:");
        product1.displayProductInfo();

        System.out.println("\nProduct 2:");
        product2.displayProductInfo();
    }
}
```

## 🧑‍🏫 Lesson 3: Inheritance

### Inheritance Basics

```java
// Animal.java
// Parent class
public class Animal {
    protected String name;
    protected int age;

    public Animal(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public void eat() {
        System.out.println(name + " is eating.");
    }

    public void sleep() {
        System.out.println(name + " is sleeping.");
    }

    public void makeSound() {
        System.out.println("Animal sound");
    }
}

// Dog.java
// Child class inheriting from Animal
public class Dog extends Animal {
    private String breed;

    public Dog(String name, int age, String breed) {
        super(name, age); // Call parent constructor
        this.breed = breed;
    }

    // Override makeSound method
    @Override
    public void makeSound() {
        System.out.println(name + " barks: Woof woof!");
    }

    // Add new method
    public void fetch() {
        System.out.println(name + " is fetching the ball!");
    }
}
```

### Using Inheritance

```java
// InheritanceDemo.java
public class InheritanceDemo {
    public static void main(String[] args) {
        // Create object from parent class
        Animal animal = new Animal("Animal", 5);
        animal.eat();
        animal.sleep();
        animal.makeSound();

        System.out.println("------------------------");

        // Create object from child class
        Dog myDog = new Dog("Buddy", 3, "Labrador");
        myDog.eat();        // Inherited from Animal
        myDog.sleep();      // Inherited from Animal
        myDog.makeSound();  // Overridden in Dog
        myDog.fetch();      // New method in Dog
    }
}
```

### Super Keyword in Inheritance

- `super` is used to call the parent class constructor

  ```java
  // Cat.java
  public class Cat extends Animal {
      private boolean isIndoor;

      public Cat(String name, int age, boolean isIndoor) {
          super(name, age);
          this.isIndoor = isIndoor;
      }

      @Override
      public void makeSound() {
          System.out.println(name + " meows: Meow meow!");
      }

      @Override
      public void eat() {
          // Call parent eat method
          super.eat();
          System.out.println(name + " likes eating fish.");
      }

      public void scratch() {
          System.out.println(name + " is scratching objects.");
      }
  }
  ```

### Real-world Example - Employee Management System

```java
// Employee class (parent)
public class Employee {
    protected String id;
    protected String name;
    protected double baseSalary;

    public Employee(String id, String name, double baseSalary) {
        this.id = id;
        this.name = name;
        this.baseSalary = baseSalary;
    }

    public double calculateSalary() {
        return baseSalary;
    }

    public void displayInfo() {
        System.out.println("Employee ID: " + id);
        System.out.println("Employee Name: " + name);
        System.out.println("Base Salary: " + baseSalary);
        System.out.println("Total Salary: " + calculateSalary());
    }
}

// Manager class inherits from Employee
public class Manager extends Employee {
    private double bonusRate;

    public Manager(String id, String name, double baseSalary, double bonusRate) {
        super(id, name, baseSalary);
        this.bonusRate = bonusRate;
    }

    @Override
    public double calculateSalary() {
        return baseSalary + (baseSalary * bonusRate);
    }

    @Override
    public void displayInfo() {
        super.displayInfo();
        System.out.println("Bonus Rate: " + (bonusRate * 100) + "%");
    }
}

// Developer class inherits from Employee
public class Developer extends Employee {
    private int overtimeHours;
    private double hourlyRate;

    public Developer(String id, String name, double baseSalary, int overtimeHours, double hourlyRate) {
        super(id, name, baseSalary);
        this.overtimeHours = overtimeHours;
        this.hourlyRate = hourlyRate;
    }

    @Override
    public double calculateSalary() {
        return baseSalary + (overtimeHours * hourlyRate);
    }

    @Override
    public void displayInfo() {
        super.displayInfo();
        System.out.println("Overtime Hours: " + overtimeHours);
        System.out.println("Overtime Rate: " + hourlyRate);
    }
}

// Demo using classes
public class EmployeeDemo {
    public static void main(String[] args) {
        // Create regular employee
        Employee emp = new Employee("E001", "Nguyen Van A", 10000000);

        // Create manager
        Manager manager = new Manager("M001", "Tran Thi B", 20000000, 0.2);

        // Create developer
        Developer dev = new Developer("D001", "Le Van C", 15000000, 30, 200000);

        // Display info
        System.out.println("Employee Info:");
        emp.displayInfo();

        System.out.println("\nManager Info:");
        manager.displayInfo();

        System.out.println("\nDeveloper Info:");
        dev.displayInfo();
    }
}
```

## 🧑‍🏫 Lesson 4: Encapsulation

### Data Encapsulation

```java
// BankAccount.java
public class BankAccount {
    // Private attributes - cannot be accessed directly from outside
    private String accountNumber;
    private String accountName;
    private double balance;

    // Constructor
    public BankAccount(String accountNumber, String accountName, double initialBalance) {
        this.accountNumber = accountNumber;
        this.accountName = accountName;
        if (initialBalance >= 0) {
            this.balance = initialBalance;
        } else {
            this.balance = 0;
        }
    }

    // Getter methods - allow reading data
    public String getAccountNumber() {
        return accountNumber;
    }

    public String getAccountName() {
        return accountName;
    }

    public double getBalance() {
        return balance;
    }

    // Setter method - allow controlled data modification
    public void setAccountName(String accountName) {
        if (accountName != null && !accountName.isEmpty()) {
            this.accountName = accountName;
        }
    }

    // No setter for accountNumber as we don't want it changed after creation
    // No direct setter for balance, use business methods instead

    // Business methods
    public void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
            System.out.println("Deposited " + amount + " successfully.");
        } else {
            System.out.println("Invalid deposit amount.");
        }
    }

    public void withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            System.out.println("Withdrew " + amount + " successfully.");
        } else {
            System.out.println("Invalid withdrawal amount or insufficient balance.");
        }
    }

    public void displayAccountInfo() {
        System.out.println("Account Number: " + accountNumber);
        System.out.println("Account Name: " + accountName);
        System.out.println("Balance: " + balance);
    }
}
```

### Using Encapsulated Class

```java
// BankDemo.java
public class BankDemo {
    public static void main(String[] args) {
        // Create new account
        BankAccount account = new BankAccount("123456789", "Nguyen Van A", 1000000);

        // Display account info
        System.out.println("Initial account info:");
        account.displayAccountInfo();

        // Try changing account name
        account.setAccountName("Nguyen Van B");

        // Perform transactions
        account.deposit(500000);
        account.withdraw(200000);

        // Display account info after transactions
        System.out.println("\nAccount info after updates:");
        account.displayAccountInfo();

        // Cannot access balance directly:
        // account.balance = 10000000; // Compile error

        // Cannot change account number after creation
        // account.accountNumber = "987654321"; // Compile error
    }
}
```

### Access Modifiers in Java

| Access Modifier | Same Class | Same Package | Subclass (diff package) | Everywhere |
| --------------- | ---------- | ------------ | ----------------------- | ---------- |
| private         | ✅         | ❌           | ❌                      | ❌         |
| default         | ✅         | ✅           | ❌                      | ❌         |
| protected       | ✅         | ✅           | ✅                      | ❌         |
| public          | ✅         | ✅           | ✅                      | ✅         |

```java
// AccessModifierDemo.java
public class AccessModifierDemo {
    // public: accessible from everywhere
    public String publicVar = "Public - accessible everywhere";

    // protected: accessible in same package and subclasses
    protected String protectedVar = "Protected - accessible in package and subclasses";

    // default (no modifier): accessible in same package
    String defaultVar = "Default - accessible in same package";

    // private: accessible only in this class
    private String privateVar = "Private - accessible only in this class";

    // Public method
    public void publicMethod() {
        System.out.println("Public method");
        // Can access all variables from inside the class
        System.out.println(publicVar);
        System.out.println(protectedVar);
        System.out.println(defaultVar);
        System.out.println(privateVar);
    }

    // Protected method
    protected void protectedMethod() {
        System.out.println("Protected method");
    }

    // Default method
    void defaultMethod() {
        System.out.println("Default method");
    }

    // Private method
    private void privateMethod() {
        System.out.println("Private method");
    }
}
```

### Real-world Example - Student Class with Encapsulation

```java
public class Student {
    private String id;
    private String name;
    private int age;
    private double[] scores;

    public Student(String id, String name, int age) {
        this.id = id;
        this.name = name;
        setAge(age); // Use setter to validate
        this.scores = new double[0];
    }

    // Getters
    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public double[] getScores() {
        // Return copy of array to avoid direct modification
        return scores.clone();
    }

    // Setters
    public void setName(String name) {
        if (name != null && !name.trim().isEmpty()) {
            this.name = name;
        }
    }

    public void setAge(int age) {
        if (age > 0 && age < 100) {
            this.age = age;
        } else {
            System.out.println("Invalid age.");
        }
    }

    // ID has no setter as we don't want it changed after creation

    // Business methods
    public void addScore(double score) {
        if (score >= 0 && score <= 10) {
            // Create new array larger by 1 element
            double[] newScores = new double[scores.length + 1];

            // Copy elements from old array
            for (int i = 0; i < scores.length; i++) {
                newScores[i] = scores[i];
            }

            // Add new score to end
            newScores[scores.length] = score;

            // Assign new array to scores
            scores = newScores;
        } else {
            System.out.println("Invalid score. Score must be between 0 and 10.");
        }
    }

    public double calculateAverage() {
        if (scores.length == 0) {
            return 0;
        }

        double sum = 0;
        for (double score : scores) {
            sum += score;
        }

        return sum / scores.length;
    }

    public void displayInfo() {
        System.out.println("Student ID: " + id);
        System.out.println("Student Name: " + name);
        System.out.println("Age: " + age);
        System.out.println("Scores: ");

        if (scores.length == 0) {
            System.out.println("No scores yet");
        } else {
            for (int i = 0; i < scores.length; i++) {
                System.out.println("  Subject " + (i + 1) + ": " + scores[i]);
            }
            System.out.println("Average Score: " + calculateAverage());
        }
    }
}

public class StudentDemo {
    public static void main(String[] args) {
        // Create new student
        Student student = new Student("SV001", "Nguyen Van A", 20);

        // Add scores
        student.addScore(8.5);
        student.addScore(7.5);
        student.addScore(9.0);

        // Display info
        student.displayInfo();

        // Try adding invalid score
        student.addScore(11.0); // Will show error message

        // Try setting invalid age
        student.setAge(-5); // Will show error message

        // Change name
        student.setName("Nguyen Van B");

        System.out.println("\nInfo after update:");
        student.displayInfo();
    }
}
```

## 🧑‍🏫 Lesson 5: Polymorphism

### Polymorphism with Method Overloading

```java
// Calculator.java
public class Calculator {
    // Overload add method with different parameters
    public int add(int a, int b) {
        return a + b;
    }

    public int add(int a, int b, int c) {
        return a + b + c;
    }

    public double add(double a, double b) {
        return a + b;
    }

    public String add(String a, String b) {
        return a + b; // String concatenation
    }
}

// OverloadingDemo.java
public class OverloadingDemo {
    public static void main(String[] args) {
        Calculator calc = new Calculator();

        System.out.println("5 + 10 = " + calc.add(5, 10));
        System.out.println("5 + 10 + 15 = " + calc.add(5, 10, 15));
        System.out.println("5.5 + 10.5 = " + calc.add(5.5, 10.5));
        System.out.println("'Hello' + 'World' = " + calc.add("Hello", "World"));
    }
}
```

### Polymorphism with Method Overriding

```java
// Parent class
class Shape {
    protected String name;

    public Shape(String name) {
        this.name = name;
    }

    public double calculateArea() {
        return 0.0; // Default method
    }

    public void display() {
        System.out.println("This is a " + name);
        System.out.println("Area: " + calculateArea());
    }
}

// Child class: Circle
class Circle extends Shape {
    private double radius;

    public Circle(double radius) {
        super("circle");
        this.radius = radius;
    }

    @Override
    public double calculateArea() {
        return Math.PI * radius * radius;
    }
}

// Child class: Rectangle
class Rectangle extends Shape {
    private double length;
    private double width;

    public Rectangle(double length, double width) {
        super("rectangle");
        this.length = length;
        this.width = width;
    }

    @Override
    public double calculateArea() {
        return length * width;
    }
}

// Child class: Triangle
class Triangle extends Shape {
    private double base;
    private double height;

    public Triangle(double base, double height) {
        super("triangle");
        this.base = base;
        this.height = height;
    }

    @Override
    public double calculateArea() {
        return 0.5 * base * height;
    }
}

public class OverridingDemo {
    public static void main(String[] args) {
        // Create objects
        Shape circle = new Circle(5.0);
        Shape rectangle = new Rectangle(4.0, 6.0);
        Shape triangle = new Triangle(3.0, 8.0);

        // Call display method (will use overridden calculateArea)
        circle.display();
        rectangle.display();
        triangle.display();

        // Use array to demonstrate polymorphism
        System.out.println("\n--- Using Object Array ---");
        Shape[] shapes = {circle, rectangle, triangle};

        for (Shape shape : shapes) {
            shape.display();
            System.out.println();
        }
    }
}
```

### Polymorphism with Abstract Class

```java
// Animal.java
// Abstract class
abstract class Animal {
    protected String name;

    public Animal(String name) {
        this.name = name;
    }

    // Abstract method - no body
    public abstract void makeSound();

    // Regular method
    public void sleep() {
        System.out.println(name + " is sleeping.");
    }
}

// Dog.java
class Dog extends Animal {
    public Dog(String name) {
        super(name);
    }

    @Override
    public void makeSound() {
        System.out.println(name + " barks: Woof woof!");
    }

    public void fetch() {
        System.out.println(name + " is fetching the ball!");
    }
}

// Cat.java
class Cat extends Animal {
    public Cat(String name) {
        super(name);
    }

    @Override
    public void makeSound() {
        System.out.println(name + " meows: Meow meow!");
    }

    public void scratch() {
        System.out.println(name + " is scratching objects.");
    }
}

// AbstractClassDemo.java
public class AbstractClassDemo {
    public static void main(String[] args) {
        // Animal animal = new Animal("Animal"); // Error: cannot instantiate abstract class

        // Create objects from child classes
        Animal dog = new Dog("Buddy");
        Animal cat = new Cat("Whiskers");

        // Call methods
        dog.makeSound();
        dog.sleep();

        cat.makeSound();
        cat.sleep();

        // Need casting to call subclass-specific methods
        ((Dog) dog).fetch();
        ((Cat) cat).scratch();

        // Demonstrate polymorphism
        System.out.println("\n--- Polymorphism with Array ---");
        Animal[] animals = {dog, cat};

        for (Animal animal : animals) {
            animal.makeSound();
            animal.sleep();
            System.out.println();
        }
    }
}
```

### Real-world Example - Payment System

```java
// Abstract class for payment method
abstract class PaymentMethod {
    protected String name;
    protected String description;

    public PaymentMethod(String name, String description) {
        this.name = name;
        this.description = description;
    }

    // Abstract method
    public abstract boolean processPayment(double amount);

    // Regular method
    public void displayInfo() {
        System.out.println("Payment Method: " + name);
        System.out.println("Description: " + description);
    }
}

// Child class: CreditCardPayment
class CreditCardPayment extends PaymentMethod {
    private String cardNumber;
    private String cardHolderName;
    private String expiryDate;

    public CreditCardPayment(String cardNumber, String cardHolderName, String expiryDate) {
        super("Credit Card", "Payment via Credit Card");
        this.cardNumber = cardNumber;
        this.cardHolderName = cardHolderName;
        this.expiryDate = expiryDate;
    }

    @Override
    public boolean processPayment(double amount) {
        // Simulate credit card payment processing
        System.out.println("Processing payment of " + amount + " via Credit Card...");
        System.out.println("Card Info: " + maskCardNumber() + ", " + cardHolderName);
        return true; // Assume success
    }

    private String maskCardNumber() {
        // Mask card number, show only last 4 digits
        return "XXXX-XXXX-XXXX-" + cardNumber.substring(cardNumber.length() - 4);
    }

    @Override
    public void displayInfo() {
        super.displayInfo();
        System.out.println("Card Number: " + maskCardNumber());
        System.out.println("Card Holder: " + cardHolderName);
    }
}

// Child class: BankTransferPayment
class BankTransferPayment extends PaymentMethod {
    private String accountNumber;
    private String bankName;

    public BankTransferPayment(String accountNumber, String bankName) {
        super("Bank Transfer", "Payment via Bank Transfer");
        this.accountNumber = accountNumber;
        this.bankName = bankName;
    }

    @Override
    public boolean processPayment(double amount) {
        // Simulate bank transfer processing
        System.out.println("Processing transfer of " + amount + "...");
        System.out.println("Account Info: " + accountNumber + ", " + bankName);
        return true; // Assume success
    }

    @Override
    public void displayInfo() {
        super.displayInfo();
        System.out.println("Account Number: " + accountNumber);
        System.out.println("Bank: " + bankName);
    }
}

// Order processing class
class Order {
    private String orderId;
    private double amount;
    private PaymentMethod paymentMethod;

    public Order(String orderId, double amount) {
        this.orderId = orderId;
        this.amount = amount;
    }

    public void setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public boolean checkout() {
        if (paymentMethod == null) {
            System.out.println("Please select a payment method!");
            return false;
        }

        System.out.println("Processing Order: " + orderId);
        System.out.println("Amount: " + amount);

        // Call payment method - demonstrating polymorphism
        boolean success = paymentMethod.processPayment(amount);

        if (success) {
            System.out.println("Payment Successful!");
        } else {
            System.out.println("Payment Failed!");
        }

        return success;
    }
}

public class PaymentSystemDemo {
    public static void main(String[] args) {
        // Create order
        Order order1 = new Order("ORD001", 1500000);

        // Create credit card payment method
        PaymentMethod creditCard = new CreditCardPayment("1234567890123456", "Nguyen Van A", "12/25");

        // Set payment method for order
        order1.setPaymentMethod(creditCard);

        // Process payment
        order1.checkout();

        System.out.println("\n--- Second Order ---");

        // Create another order
        Order order2 = new Order("ORD002", 2500000);

        // Create bank transfer payment method
        PaymentMethod bankTransfer = new BankTransferPayment("9876543210", "ABC Bank");

        // Set payment method for order
        order2.setPaymentMethod(bankTransfer);

        // Process payment
        order2.checkout();
    }
}
```

## 🧑‍🏫 Lesson 6: Interface and Abstract Class

### Interface in Java

- Interface is a special data type in Java, allowing definition of methods without body. Other classes can implement this interface and provide body for defined methods.

  ```java
  // Drawable.java
  // Declare interface
  interface Drawable {
     // Constants (default public static final)
     String TOOL = "Drawing Tool";

     // Abstract methods (default public abstract)
     void draw();

     // Java 8+: default method
     default void displayInfo() {
         System.out.println("Drawing with " + TOOL);
     }

     // Java 8+: static method
     static void description() {
         System.out.println("Interface for drawable objects");
     }
  }

  // Circle.java
  // Implement interface
  class Circle implements Drawable {
     private double radius;

     public Circle(double radius) {
         this.radius = radius;
     }

     @Override
     public void draw() {
         System.out.println("Drawing circle with radius " + radius);
     }
  }

  // Rectangle.java
  class Rectangle implements Drawable {
     private double length;
     private double width;

     public Rectangle(double length, double width) {
         this.length = length;
         this.width = width;
     }

     @Override
     public void draw() {
         System.out.println("Drawing rectangle with length " + length + " and width " + width);
     }

     // Override default method
     @Override
     public void displayInfo() {
         System.out.println("Rectangle is being drawn with special tool");
     }
  }

  // InterfaceDemo.java
  public class InterfaceDemo {
     public static void main(String[] args) {
         // Use static method of interface
         Drawable.description();

         // Create objects
         Drawable circle = new Circle(5.0);
         Drawable rectangle = new Rectangle(4.0, 6.0);

         // Call draw method
         circle.draw();
         circle.displayInfo(); // Use default method

         rectangle.draw();
         rectangle.displayInfo(); // Use overridden method

         // Use interface to create polymorphic array
         Drawable[] shapes = {circle, rectangle};

         System.out.println("\n--- Using Interface Array ---");
         for (Drawable shape : shapes) {
             shape.draw();
         }
     }
  }
  ```

### Multiple Interfaces

```java
// Flyable.java
interface Flyable {
    void fly();
}

// Swimmable.java
interface Swimmable {
    void swim();
}

// Duck.java
// Class implementing multiple interfaces
class Duck implements Flyable, Swimmable {
    private String name;

    public Duck(String name) {
        this.name = name;
    }

    @Override
    public void fly() {
        System.out.println(name + " is flying.");
    }

    @Override
    public void swim() {
        System.out.println(name + " is swimming.");
    }
}

// Airplane.java
// Class implementing one interface
class Airplane implements Flyable {
    private String model;

    public Airplane(String model) {
        this.model = model;
    }

    @Override
    public void fly() {
        System.out.println("Airplane " + model + " is flying at high altitude.");
    }
}

// Fish.java
// Class implementing one interface
class Fish implements Swimmable {
    private String species;

    public Fish(String species) {
        this.species = species;
    }

    @Override
    public void swim() {
        System.out.println("Fish " + species + " is swimming.");
    }
}

// MultipleInterfaceDemo.java
public class MultipleInterfaceDemo {
    public static void main(String[] args) {
        Duck duck = new Duck("Donald Duck");
        Airplane airplane = new Airplane("Boeing 747");
        Fish fish = new Fish("Goldfish");

        // Call methods
        duck.fly();
        duck.swim();

        airplane.fly();

        fish.swim();

        // Use interface for classification
        System.out.println("\n--- Flyable Objects ---");
        Flyable[] flyingObjects = {duck, airplane};
        for (Flyable obj : flyingObjects) {
            obj.fly();
        }

        System.out.println("\n--- Swimmable Objects ---");
        Swimmable[] swimmingObjects = {duck, fish};
        for (Swimmable obj : swimmingObjects) {
            obj.swim();
        }
    }
}
```

### Abstract Class vs Interface

- Can have both abstract and non-abstract methods.
- Can have attributes (fields).
- Can only inherit one abstract class (single inheritance).

  ```java
  // Animal.java
  // Abstract Class
  abstract class Animal {
      protected String name;

      // Constructor
      public Animal(String name) {
          this.name = name;
      }

      // Abstract method
      public abstract void makeSound();

      // Non-abstract method
      public void sleep() {
          System.out.println(name + " is sleeping.");
      }
  }

  // Pet.java
  // Interface
  interface Pet {
      void play();
      void beGroomed();
  }

  // Dog.java
  // Class inheriting abstract class and implementing interface
  class Dog extends Animal implements Pet {
      private String breed;

      public Dog(String name, String breed) {
          super(name);
          this.breed = breed;
      }

      @Override
      public void makeSound() {
          System.out.println(name + " barks: Woof woof!");
      }

      @Override
      public void play() {
          System.out.println(name + " is playing with owner.");
      }

      @Override
      public void beGroomed() {
          System.out.println(name + " is being bathed and groomed.");
      }
  }

  // AbstractVsInterfaceDemo.java
  public class AbstractVsInterfaceDemo {
      public static void main(String[] args) {
          // Create Dog object
          Dog dog = new Dog("Buddy", "Labrador");

          // Use methods from abstract class
          dog.makeSound();
          dog.sleep();

          // Use methods from interface
          dog.play();
          dog.beGroomed();

          // Use polymorphism with abstract class
          Animal animal = dog;
          animal.makeSound();

          // Use polymorphism with interface
          Pet pet = dog;
          pet.play();
      }
  }
  ```

### Real-world Example - Notification System

```java
// Interface for notification services
interface NotificationService {
    void sendNotification(String message);
    boolean isServiceAvailable();
}

// Abstract class for notification
abstract class Notification {
    protected String sender;
    protected String content;

    public Notification(String sender, String content) {
        this.sender = sender;
        this.content = content;
    }

    // Abstract method
    public abstract void display();

    // Regular method
    public String getSummary() {
        return "Notification from " + sender + ": " + content.substring(0, Math.min(content.length(), 20)) + "...";
    }
}

// Implement interface
class EmailService implements NotificationService {
    private String smtpServer;
    private boolean online;

    public EmailService(String smtpServer) {
        this.smtpServer = smtpServer;
        this.online = true; // Assume always online
    }

    @Override
    public void sendNotification(String message) {
        if (isServiceAvailable()) {
            System.out.println("Sending email via " + smtpServer + ": " + message);
        } else {
            System.out.println("Email service unavailable!");
        }
    }

    @Override
    public boolean isServiceAvailable() {
        return online;
    }

    public void setOnlineStatus(boolean status) {
        this.online = status;
    }
}

class SMSService implements NotificationService {
    private String providerName;
    private boolean active;

    public SMSService(String providerName) {
        this.providerName = providerName;
        this.active = true; // Assume always active
    }

    @Override
    public void sendNotification(String message) {
        if (isServiceAvailable()) {
            System.out.println("Sending SMS via " + providerName + ": " + message);
        } else {
            System.out.println("SMS service unavailable!");
        }
    }

    @Override
    public boolean isServiceAvailable() {
        return active;
    }

    public void setActiveStatus(boolean status) {
        this.active = status;
    }
}

// Inherit abstract class
class EmailNotification extends Notification {
    private String recipientEmail;

    public EmailNotification(String sender, String content, String recipientEmail) {
        super(sender, content);
        this.recipientEmail = recipientEmail;
    }

    @Override
    public void display() {
        System.out.println("Email Notification");
        System.out.println("From: " + sender);
        System.out.println("To: " + recipientEmail);
        System.out.println("Content: " + content);
    }
}

class SMSNotification extends Notification {
    private String phoneNumber;

    public SMSNotification(String sender, String content, String phoneNumber) {
        super(sender, content);
        this.phoneNumber = phoneNumber;
    }

    @Override
    public void display() {
        System.out.println("SMS Notification");
        System.out.println("From: " + sender);
        System.out.println("To: " + phoneNumber);
        System.out.println("Content: " + content);
    }
}

// Notification manager class
class NotificationManager {
    private NotificationService[] services;

    public NotificationManager(NotificationService[] services) {
        this.services = services;
    }

    public void sendNotificationToAll(String message) {
        for (NotificationService service : services) {
            if (service.isServiceAvailable()) {
                service.sendNotification(message);
            }
        }
    }

    public void displayNotifications(Notification[] notifications) {
        for (Notification notification : notifications) {
            System.out.println("-------------------");
            notification.display();
        }
    }
}

public class NotificationSystemDemo {
    public static void main(String[] args) {
        // Create notification services
        EmailService emailService = new EmailService("smtp.gmail.com");
        SMSService smsService = new SMSService("Viettel");

        // Create notification service array
        NotificationService[] services = {emailService, smsService};

        // Create notification manager
        NotificationManager manager = new NotificationManager(services);

        // Send notification via all available services
        manager.sendNotificationToAll("System maintenance at 22:00 tonight.");

        // Mark email service as unavailable
        emailService.setOnlineStatus(false);

        // Resend notification
        System.out.println("\n--- After email service down ---");
        manager.sendNotificationToAll("Urgent: Maintenance postponed to 23:00.");

        // Create specific notifications
        Notification[] notifications = {
            new EmailNotification("admin@system.com", "Monthly report ready.", "user@example.com"),
            new SMSNotification("System", "Your OTP is 123456.", "+84987654321")
        };

        // Display notifications
        System.out.println("\n--- System Notifications ---");
        manager.displayNotifications(notifications);
    }
}
```

## 🧪 FINAL PROJECT: Student, Teacher and Course Management

### Problem Description

Write a program:

- Create `Person` class with common attributes like name, age.
- Create `Student` and `Teacher` classes inheriting from `Person` with specific characteristics.
- Create `Course` class to manage courses.
- Each `Student` and `Teacher` can participate in multiple courses.
- Provide methods to register, unregister courses.

### Features to Implement

- `Person` class with basic attributes (name, age).
- `Student` and `Teacher` classes inheriting from `Person`, with specific methods.
- `Course` class managing course info and participants.
- Course registration and unregistration methods in `Student` class.
