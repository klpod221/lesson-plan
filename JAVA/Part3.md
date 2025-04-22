# 📘 PHẦN 3: LẬP TRÌNH HƯỚNG ĐỐI TƯỢNG (OOP)

## Nội dung

- [📘 PHẦN 3: LẬP TRÌNH HƯỚNG ĐỐI TƯỢNG (OOP)](#-phần-3-lập-trình-hướng-đối-tượng-oop)
  - [Table of Contents](#table-of-contents)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Lớp và Đối tượng](#-bài-1-lớp-và-đối-tượng)
  - [🧑‍🏫 Bài 2: Kế thừa](#-bài-2-kế-thừa)
  - [🧑‍🏫 Bài 3: Đóng gói (Encapsulation)](#-bài-3-đóng-gói-encapsulation)
  - [🧑‍🏫 Bài 4: Đa hình (Polymorphism)](#-bài-4-đa-hình-polymorphism)
  - [🧑‍🏫 Bài 5: Interface và Abstract Class](#-bài-5-interface-và-abstract-class)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN](#-bài-tập-lớn-cuối-phần)
    - [**Đề bài: Quản lý sinh viên, giảng viên và khóa học**](#đề-bài-quản-lý-sinh-viên-giảng-viên-và-khóa-học)

## 🎯 Mục tiêu tổng quát

- Hiểu và áp dụng các nguyên lý của lập trình hướng đối tượng trong Java.
- Làm việc với các lớp, đối tượng, kế thừa, đóng gói, và đa hình.

---

## 🧑‍🏫 Bài 1: Lớp và Đối tượng

- Khái niệm lớp (class) và đối tượng (object).
- Cách khai báo lớp và tạo đối tượng.
- Phương thức khởi tạo (constructor) và cách sử dụng chúng để tạo đối tượng.
- Cách sử dụng phương thức trong lớp.

1. **Khai báo lớp và tạo đối tượng:**

   ```java
   // Khai báo lớp Person
   public class Person {
       // Thuộc tính (attributes)
       String name;
       int age;
       String address;

       // Phương thức khởi tạo không tham số (default constructor)
       public Person() {
           name = "Chưa xác định";
           age = 0;
           address = "Chưa xác định";
       }

       // Phương thức khởi tạo có tham số (parameterized constructor)
       public Person(String name, int age, String address) {
           this.name = name;
           this.age = age;
           this.address = address;
       }

       // Phương thức (methods)
       public void displayInfo() {
           System.out.println("Tên: " + name);
           System.out.println("Tuổi: " + age);
           System.out.println("Địa chỉ: " + address);
       }
   }
   ```

2. **Tạo và sử dụng đối tượng:**

   ```java
   public class PersonDemo {
       public static void main(String[] args) {
           // Tạo đối tượng sử dụng constructor không tham số
           Person person1 = new Person();
           System.out.println("Thông tin person1:");
           person1.displayInfo();

           // Tạo đối tượng sử dụng constructor có tham số
           Person person2 = new Person("Nguyễn Văn A", 30, "Hà Nội");
           System.out.println("\nThông tin person2:");
           person2.displayInfo();

           // Thay đổi thuộc tính của đối tượng
           person1.name = "Trần Thị B";
           person1.age = 25;
           person1.address = "Hồ Chí Minh";

           System.out.println("\nThông tin person1 sau khi cập nhật:");
           person1.displayInfo();
       }
   }
   ```

3. **Ví dụ thực tế - Lớp quản lý sản phẩm:**

   ```java
   public class Product {
       // Thuộc tính
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

       // Các phương thức
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
           System.out.println("Mã sản phẩm: " + id);
           System.out.println("Tên sản phẩm: " + name);
           System.out.println("Giá: " + price);
           System.out.println("Số lượng: " + quantity);
           System.out.println("Tổng giá trị: " + calculateTotal());
       }
   }

   public class ProductDemo {
       public static void main(String[] args) {
           // Tạo các đối tượng sản phẩm
           Product product1 = new Product("SP001", "Laptop Dell XPS", 25000000, 5);
           Product product2 = new Product("SP002", "Điện thoại iPhone 13", 20000000, 10);

           // Hiển thị thông tin sản phẩm
           System.out.println("Thông tin sản phẩm 1:");
           product1.displayProductInfo();

           System.out.println("\nThông tin sản phẩm 2:");
           product2.displayProductInfo();

           // Điều chỉnh số lượng
           product1.increaseQuantity(3);
           product2.decreaseQuantity(2);

           System.out.println("\nThông tin sau khi cập nhật số lượng:");
           System.out.println("Sản phẩm 1:");
           product1.displayProductInfo();

           System.out.println("\nSản phẩm 2:");
           product2.displayProductInfo();
       }
   }
   ```

---

## 🧑‍🏫 Bài 2: Kế thừa

- Khái niệm kế thừa (inheritance) và tại sao nó quan trọng trong OOP.
- Cách sử dụng từ khóa `extends` để kế thừa lớp.
- Kế thừa các phương thức và thuộc tính của lớp cha.
- Sử dụng từ khóa `super` để truy cập các thành phần của lớp cha.
- Kế thừa và ghi đè phương thức (method overriding).

1. **Cơ bản về kế thừa:**

   ```java
   // Lớp cha (parent class)
   public class Animal {
       protected String name;
       protected int age;

       public Animal(String name, int age) {
           this.name = name;
           this.age = age;
       }

       public void eat() {
           System.out.println(name + " đang ăn.");
       }

       public void sleep() {
           System.out.println(name + " đang ngủ.");
       }

       public void makeSound() {
           System.out.println("Âm thanh của động vật");
       }
   }

   // Lớp con (child class) kế thừa từ lớp Animal
   public class Dog extends Animal {
       private String breed;

       public Dog(String name, int age, String breed) {
           super(name, age); // Gọi constructor của lớp cha
           this.breed = breed;
       }

       // Ghi đè (override) phương thức makeSound
       @Override
       public void makeSound() {
           System.out.println(name + " sủa: Gâu gâu!");
       }

       // Thêm phương thức mới
       public void fetch() {
           System.out.println(name + " đang đuổi theo bóng!");
       }
   }
   ```

2. **Sử dụng kế thừa:**

   ```java
   public class InheritanceDemo {
       public static void main(String[] args) {
           // Tạo đối tượng từ lớp cha
           Animal animal = new Animal("Động vật", 5);
           animal.eat();
           animal.sleep();
           animal.makeSound();

           System.out.println("------------------------");

           // Tạo đối tượng từ lớp con
           Dog myDog = new Dog("Buddy", 3, "Labrador");
           myDog.eat();        // Được kế thừa từ lớp Animal
           myDog.sleep();      // Được kế thừa từ lớp Animal
           myDog.makeSound();  // Được ghi đè trong lớp Dog
           myDog.fetch();      // Phương thức mới trong lớp Dog
       }
   }
   ```

3. **Từ khóa super trong kế thừa:**

   ```java
   public class Cat extends Animal {
       private boolean isIndoor;

       public Cat(String name, int age, boolean isIndoor) {
           super(name, age);
           this.isIndoor = isIndoor;
       }

       @Override
       public void makeSound() {
           System.out.println(name + " kêu: Meo meo!");
       }

       @Override
       public void eat() {
           // Gọi phương thức eat của lớp cha
           super.eat();
           System.out.println(name + " thích ăn cá.");
       }

       public void scratch() {
           System.out.println(name + " đang cào đồ vật.");
       }
   }
   ```

4. **Ví dụ thực tế - Hệ thống quản lý nhân viên:**

   ```java
   // Lớp Employee (lớp cha)
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
           System.out.println("Mã nhân viên: " + id);
           System.out.println("Tên nhân viên: " + name);
           System.out.println("Lương cơ bản: " + baseSalary);
           System.out.println("Tổng lương: " + calculateSalary());
       }
   }

   // Lớp Manager kế thừa từ Employee
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
           System.out.println("Tỷ lệ thưởng: " + (bonusRate * 100) + "%");
       }
   }

   // Lớp Developer kế thừa từ Employee
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
           System.out.println("Số giờ làm thêm: " + overtimeHours);
           System.out.println("Lương theo giờ làm thêm: " + hourlyRate);
       }
   }

   // Demo sử dụng các lớp
   public class EmployeeDemo {
       public static void main(String[] args) {
           // Tạo đối tượng nhân viên thông thường
           Employee emp = new Employee("E001", "Nguyễn Văn A", 10000000);

           // Tạo đối tượng quản lý
           Manager manager = new Manager("M001", "Trần Thị B", 20000000, 0.2);

           // Tạo đối tượng lập trình viên
           Developer dev = new Developer("D001", "Lê Văn C", 15000000, 30, 200000);

           // Hiển thị thông tin
           System.out.println("Thông tin nhân viên:");
           emp.displayInfo();

           System.out.println("\nThông tin quản lý:");
           manager.displayInfo();

           System.out.println("\nThông tin lập trình viên:");
           dev.displayInfo();
       }
   }
   ```

---

## 🧑‍🏫 Bài 3: Đóng gói (Encapsulation)

- Khái niệm đóng gói và tại sao nó quan trọng.
- Quy tắc sử dụng `private`, `protected`, và `public` để hạn chế quyền truy cập.
- Getter và Setter để truy cập và thay đổi thuộc tính của đối tượng.
- Đảm bảo tính an toàn và kiểm tra dữ liệu trong quá trình thay đổi trạng thái đối tượng.

1. **Đóng gói dữ liệu:**

   ```java
   public class BankAccount {
       // Thuộc tính private - không thể truy cập trực tiếp từ bên ngoài
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

       // Getter methods - cho phép đọc dữ liệu
       public String getAccountNumber() {
           return accountNumber;
       }

       public String getAccountName() {
           return accountName;
       }

       public double getBalance() {
           return balance;
       }

       // Setter method - cho phép thay đổi dữ liệu có kiểm soát
       public void setAccountName(String accountName) {
           if (accountName != null && !accountName.isEmpty()) {
               this.accountName = accountName;
           }
       }

       // Không có setter cho accountNumber vì không muốn thay đổi sau khi tạo
       // Không có setter trực tiếp cho balance, thay vào đó sử dụng các phương thức nghiệp vụ

       // Các phương thức nghiệp vụ
       public void deposit(double amount) {
           if (amount > 0) {
               balance += amount;
               System.out.println("Nạp " + amount + " vào tài khoản thành công.");
           } else {
               System.out.println("Số tiền nạp không hợp lệ.");
           }
       }

       public void withdraw(double amount) {
           if (amount > 0 && amount <= balance) {
               balance -= amount;
               System.out.println("Rút " + amount + " từ tài khoản thành công.");
           } else {
               System.out.println("Số tiền rút không hợp lệ hoặc vượt quá số dư.");
           }
       }

       public void displayAccountInfo() {
           System.out.println("Số tài khoản: " + accountNumber);
           System.out.println("Tên tài khoản: " + accountName);
           System.out.println("Số dư: " + balance);
       }
   }
   ```

2. **Sử dụng lớp đã đóng gói:**

   ```java
   public class BankDemo {
       public static void main(String[] args) {
           // Tạo tài khoản mới
           BankAccount account = new BankAccount("123456789", "Nguyễn Văn A", 1000000);

           // Hiển thị thông tin tài khoản
           System.out.println("Thông tin tài khoản ban đầu:");
           account.displayAccountInfo();

           // Thử thay đổi tên tài khoản
           account.setAccountName("Nguyễn Văn B");

           // Thực hiện các giao dịch
           account.deposit(500000);
           account.withdraw(200000);

           // Hiển thị thông tin tài khoản sau khi thực hiện giao dịch
           System.out.println("\nThông tin tài khoản sau khi cập nhật:");
           account.displayAccountInfo();

           // Không thể truy cập trực tiếp vào balance:
           // account.balance = 10000000; // Lỗi biên dịch

           // Không thể thay đổi số tài khoản sau khi tạo
           // account.accountNumber = "987654321"; // Lỗi biên dịch
       }
   }
   ```

3. **Các mức độ truy cập trong Java:**

   ```java
   public class AccessModifierDemo {
       // public: truy cập từ bất kỳ đâu
       public String publicVar = "Public - truy cập từ mọi nơi";

       // protected: truy cập trong cùng package và các lớp con kế thừa
       protected String protectedVar = "Protected - truy cập trong package và lớp con";

       // default (không có modifier): truy cập trong cùng package
       String defaultVar = "Default - truy cập trong cùng package";

       // private: chỉ truy cập trong cùng lớp
       private String privateVar = "Private - chỉ truy cập trong lớp này";

       // Phương thức public
       public void publicMethod() {
           System.out.println("Phương thức public");
           // Có thể truy cập tất cả các biến từ bên trong lớp
           System.out.println(publicVar);
           System.out.println(protectedVar);
           System.out.println(defaultVar);
           System.out.println(privateVar);
       }

       // Phương thức protected
       protected void protectedMethod() {
           System.out.println("Phương thức protected");
       }

       // Phương thức default
       void defaultMethod() {
           System.out.println("Phương thức default");
       }

       // Phương thức private
       private void privateMethod() {
           System.out.println("Phương thức private");
       }
   }
   ```

4. **Ví dụ thực tế - Lớp Student với đóng gói:**

   ```java
   public class Student {
       private String id;
       private String name;
       private int age;
       private double[] scores;

       public Student(String id, String name, int age) {
           this.id = id;
           this.name = name;
           setAge(age); // Sử dụng setter để kiểm tra tính hợp lệ
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
           // Trả về bản sao của mảng để tránh thay đổi trực tiếp
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
               System.out.println("Tuổi không hợp lệ.");
           }
       }

       // ID không có setter vì không muốn thay đổi sau khi tạo

       // Các phương thức nghiệp vụ
       public void addScore(double score) {
           if (score >= 0 && score <= 10) {
               // Tạo mảng mới lớn hơn 1 phần tử
               double[] newScores = new double[scores.length + 1];

               // Sao chép các phần tử từ mảng cũ
               for (int i = 0; i < scores.length; i++) {
                   newScores[i] = scores[i];
               }

               // Thêm điểm mới vào cuối
               newScores[scores.length] = score;

               // Gán mảng mới cho scores
               scores = newScores;
           } else {
               System.out.println("Điểm không hợp lệ. Điểm phải từ 0 đến 10.");
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
           System.out.println("Mã sinh viên: " + id);
           System.out.println("Tên sinh viên: " + name);
           System.out.println("Tuổi: " + age);
           System.out.println("Điểm số: ");

           if (scores.length == 0) {
               System.out.println("Chưa có điểm");
           } else {
               for (int i = 0; i < scores.length; i++) {
                   System.out.println("  Môn " + (i + 1) + ": " + scores[i]);
               }
               System.out.println("Điểm trung bình: " + calculateAverage());
           }
       }
   }

   public class StudentDemo {
       public static void main(String[] args) {
           // Tạo sinh viên mới
           Student student = new Student("SV001", "Nguyễn Văn A", 20);

           // Thêm điểm
           student.addScore(8.5);
           student.addScore(7.5);
           student.addScore(9.0);

           // Hiển thị thông tin
           student.displayInfo();

           // Thử thêm điểm không hợp lệ
           student.addScore(11.0); // Sẽ hiển thị thông báo lỗi

           // Thử đặt tuổi không hợp lệ
           student.setAge(-5); // Sẽ hiển thị thông báo lỗi

           // Thay đổi tên
           student.setName("Nguyễn Văn B");

           System.out.println("\nThông tin sau khi cập nhật:");
           student.displayInfo();
       }
   }
   ```

---

## 🧑‍🏫 Bài 4: Đa hình (Polymorphism)

- Khái niệm đa hình và tại sao nó hữu ích.
- Đa hình thời gian biên dịch (method overloading) và đa hình thời gian chạy (method overriding).
- Sử dụng interface và abstract class để thực hiện đa hình.
- Các phương thức trừu tượng (abstract methods) và cách sử dụng lớp trừu tượng (abstract class).

1. **Đa hình với nạp chồng phương thức (Method Overloading):**

   ```java
   public class Calculator {
       // Nạp chồng phương thức add với các tham số khác nhau
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
           return a + b; // Nối chuỗi
       }
   }

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

2. **Đa hình với ghi đè phương thức (Method Overriding):**

   ```java
   // Lớp cha
   class Shape {
       protected String name;

       public Shape(String name) {
           this.name = name;
       }

       public double calculateArea() {
           return 0.0; // Phương thức mặc định
       }

       public void display() {
           System.out.println("Đây là hình " + name);
           System.out.println("Diện tích: " + calculateArea());
       }
   }

   // Lớp con: Circle
   class Circle extends Shape {
       private double radius;

       public Circle(double radius) {
           super("tròn");
           this.radius = radius;
       }

       @Override
       public double calculateArea() {
           return Math.PI * radius * radius;
       }
   }

   // Lớp con: Rectangle
   class Rectangle extends Shape {
       private double length;
       private double width;

       public Rectangle(double length, double width) {
           super("chữ nhật");
           this.length = length;
           this.width = width;
       }

       @Override
       public double calculateArea() {
           return length * width;
       }
   }

   // Lớp con: Triangle
   class Triangle extends Shape {
       private double base;
       private double height;

       public Triangle(double base, double height) {
           super("tam giác");
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
           // Tạo các đối tượng
           Shape circle = new Circle(5.0);
           Shape rectangle = new Rectangle(4.0, 6.0);
           Shape triangle = new Triangle(3.0, 8.0);

           // Gọi phương thức display (sẽ sử dụng calculateArea đã ghi đè)
           circle.display();
           rectangle.display();
           triangle.display();

           // Dùng mảng để minh họa đa hình
           System.out.println("\n--- Sử dụng mảng đối tượng ---");
           Shape[] shapes = {circle, rectangle, triangle};

           for (Shape shape : shapes) {
               shape.display();
               System.out.println();
           }
       }
   }
   ```

3. **Đa hình với lớp trừu tượng (Abstract Class):**

   ```java
   // Lớp trừu tượng
   abstract class Animal {
       protected String name;

       public Animal(String name) {
           this.name = name;
       }

       // Phương thức trừu tượng - không có thân hàm
       public abstract void makeSound();

       // Phương thức thông thường
       public void sleep() {
           System.out.println(name + " đang ngủ.");
       }
   }

   class Dog extends Animal {
       public Dog(String name) {
           super(name);
       }

       @Override
       public void makeSound() {
           System.out.println(name + " sủa: Gâu gâu!");
       }

       public void fetch() {
           System.out.println(name + " đang đuổi theo bóng!");
       }
   }

   class Cat extends Animal {
       public Cat(String name) {
           super(name);
       }

       @Override
       public void makeSound() {
           System.out.println(name + " kêu: Meo meo!");
       }

       public void scratch() {
           System.out.println(name + " đang cào đồ vật.");
       }
   }

   public class AbstractClassDemo {
       public static void main(String[] args) {
           // Animal animal = new Animal("Động vật"); // Lỗi: không thể tạo đối tượng từ lớp trừu tượng

           // Tạo các đối tượng từ lớp con
           Animal dog = new Dog("Buddy");
           Animal cat = new Cat("Whiskers");

           // Gọi phương thức
           dog.makeSound();
           dog.sleep();

           cat.makeSound();
           cat.sleep();

           // Cần ép kiểu để gọi phương thức đặc thù của lớp con
           ((Dog) dog).fetch();
           ((Cat) cat).scratch();

           // Minh họa đa hình
           System.out.println("\n--- Đa hình với mảng ---");
           Animal[] animals = {dog, cat};

           for (Animal animal : animals) {
               animal.makeSound();
               animal.sleep();
               System.out.println();
           }
       }
   }
   ```

4. **Ví dụ thực tế - Hệ thống thanh toán:**

   ```java
   // Lớp trừu tượng cho phương thức thanh toán
   abstract class PaymentMethod {
       protected String name;
       protected String description;

       public PaymentMethod(String name, String description) {
           this.name = name;
           this.description = description;
       }

       // Phương thức trừu tượng
       public abstract boolean processPayment(double amount);

       // Phương thức thông thường
       public void displayInfo() {
           System.out.println("Phương thức thanh toán: " + name);
           System.out.println("Mô tả: " + description);
       }
   }

   // Lớp con: CreditCardPayment
   class CreditCardPayment extends PaymentMethod {
       private String cardNumber;
       private String cardHolderName;
       private String expiryDate;

       public CreditCardPayment(String cardNumber, String cardHolderName, String expiryDate) {
           super("Thẻ tín dụng", "Thanh toán bằng thẻ tín dụng");
           this.cardNumber = cardNumber;
           this.cardHolderName = cardHolderName;
           this.expiryDate = expiryDate;
       }

       @Override
       public boolean processPayment(double amount) {
           // Giả lập xử lý thanh toán thẻ tín dụng
           System.out.println("Đang xử lý thanh toán " + amount + " bằng thẻ tín dụng...");
           System.out.println("Thông tin thẻ: " + maskCardNumber() + ", " + cardHolderName);
           return true; // Giả sử luôn thành công
       }

       private String maskCardNumber() {
           // Che giấu số thẻ, chỉ hiển thị 4 số cuối
           return "XXXX-XXXX-XXXX-" + cardNumber.substring(cardNumber.length() - 4);
       }

       @Override
       public void displayInfo() {
           super.displayInfo();
           System.out.println("Số thẻ: " + maskCardNumber());
           System.out.println("Chủ thẻ: " + cardHolderName);
       }
   }

   // Lớp con: BankTransferPayment
   class BankTransferPayment extends PaymentMethod {
       private String accountNumber;
       private String bankName;

       public BankTransferPayment(String accountNumber, String bankName) {
           super("Chuyển khoản ngân hàng", "Thanh toán bằng chuyển khoản ngân hàng");
           this.accountNumber = accountNumber;
           this.bankName = bankName;
       }

       @Override
       public boolean processPayment(double amount) {
           // Giả lập xử lý thanh toán chuyển khoản
           System.out.println("Đang xử lý chuyển khoản " + amount + "...");
           System.out.println("Thông tin tài khoản: " + accountNumber + ", " + bankName);
           return true; // Giả sử luôn thành công
       }

       @Override
       public void displayInfo() {
           super.displayInfo();
           System.out.println("Số tài khoản: " + accountNumber);
           System.out.println("Ngân hàng: " + bankName);
       }
   }

   // Lớp xử lý đơn hàng
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
               System.out.println("Vui lòng chọn phương thức thanh toán!");
               return false;
           }

           System.out.println("Xử lý đơn hàng: " + orderId);
           System.out.println("Số tiền: " + amount);

           // Gọi phương thức thanh toán - thể hiện tính đa hình
           boolean success = paymentMethod.processPayment(amount);

           if (success) {
               System.out.println("Thanh toán thành công!");
           } else {
               System.out.println("Thanh toán thất bại!");
           }

           return success;
       }
   }

   public class PaymentSystemDemo {
       public static void main(String[] args) {
           // Tạo đơn hàng
           Order order1 = new Order("ORD001", 1500000);

           // Tạo phương thức thanh toán thẻ tín dụng
           PaymentMethod creditCard = new CreditCardPayment("1234567890123456", "Nguyễn Văn A", "12/25");

           // Đặt phương thức thanh toán cho đơn hàng
           order1.setPaymentMethod(creditCard);

           // Xử lý thanh toán
           order1.checkout();

           System.out.println("\n--- Đơn hàng thứ hai ---");

           // Tạo đơn hàng khác
           Order order2 = new Order("ORD002", 2500000);

           // Tạo phương thức thanh toán chuyển khoản
           PaymentMethod bankTransfer = new BankTransferPayment("9876543210", "Ngân hàng ABC");

           // Đặt phương thức thanh toán cho đơn hàng
           order2.setPaymentMethod(bankTransfer);

           // Xử lý thanh toán
           order2.checkout();
       }
   }
   ```

---

## 🧑‍🏫 Bài 5: Interface và Abstract Class

- Sự khác biệt giữa Interface và Abstract Class.
- Khi nào sử dụng Interface, khi nào sử dụng Abstract Class.
- Tạo và triển khai Interface.
- Tạo và kế thừa Abstract Class.
- Đặc điểm và ứng dụng thực tế của Interface và Abstract Class.

1. **Interface trong Java:**

   ```java
   // Khai báo interface
   interface Drawable {
       // Các constant (mặc định là public static final)
       String TOOL = "Bút vẽ";

       // Các phương thức trừu tượng (mặc định là public abstract)
       void draw();

       // Java 8 trở lên: default method
       default void displayInfo() {
           System.out.println("Đang vẽ bằng " + TOOL);
       }

       // Java 8 trở lên: static method
       static void description() {
           System.out.println("Interface cho các đối tượng có thể vẽ được");
       }
   }

   // Triển khai interface
   class Circle implements Drawable {
       private double radius;

       public Circle(double radius) {
           this.radius = radius;
       }

       @Override
       public void draw() {
           System.out.println("Vẽ hình tròn với bán kính " + radius);
       }
   }

   class Rectangle implements Drawable {
       private double length;
       private double width;

       public Rectangle(double length, double width) {
           this.length = length;
           this.width = width;
       }

       @Override
       public void draw() {
           System.out.println("Vẽ hình chữ nhật với chiều dài " + length + " và chiều rộng " + width);
       }

       // Ghi đè phương thức default
       @Override
       public void displayInfo() {
           System.out.println("Hình chữ nhật đang được vẽ với công cụ đặc biệt");
       }
   }

   public class InterfaceDemo {
       public static void main(String[] args) {
           // Sử dụng static method của interface
           Drawable.description();

           // Tạo đối tượng
           Drawable circle = new Circle(5.0);
           Drawable rectangle = new Rectangle(4.0, 6.0);

           // Gọi phương thức draw
           circle.draw();
           circle.displayInfo(); // Sử dụng default method

           rectangle.draw();
           rectangle.displayInfo(); // Sử dụng phương thức đã ghi đè

           // Sử dụng interface để tạo mảng đa hình
           Drawable[] shapes = {circle, rectangle};

           System.out.println("\n--- Sử dụng mảng interface ---");
           for (Drawable shape : shapes) {
               shape.draw();
           }
       }
   }
   ```

2. **Multiple Interface:**

   ```java
   interface Flyable {
       void fly();
   }

   interface Swimmable {
       void swim();
   }

   // Lớp triển khai nhiều interface
   class Duck implements Flyable, Swimmable {
       private String name;

       public Duck(String name) {
           this.name = name;
       }

       @Override
       public void fly() {
           System.out.println(name + " đang bay.");
       }

       @Override
       public void swim() {
           System.out.println(name + " đang bơi.");
       }
   }

   // Lớp chỉ triển khai một interface
   class Airplane implements Flyable {
       private String model;

       public Airplane(String model) {
           this.model = model;
       }

       @Override
       public void fly() {
           System.out.println("Máy bay " + model + " đang bay ở độ cao lớn.");
       }
   }

   // Lớp chỉ triển khai một interface
   class Fish implements Swimmable {
       private String species;

       public Fish(String species) {
           this.species = species;
       }

       @Override
       public void swim() {
           System.out.println("Cá " + species + " đang bơi.");
       }
   }

   public class MultipleInterfaceDemo {
       public static void main(String[] args) {
           Duck duck = new Duck("Vịt Donald");
           Airplane airplane = new Airplane("Boeing 747");
           Fish fish = new Fish("Cá vàng");

           // Gọi phương thức
           duck.fly();
           duck.swim();

           airplane.fly();

           fish.swim();

           // Sử dụng interface để phân loại
           System.out.println("\n--- Đối tượng có thể bay ---");
           Flyable[] flyingObjects = {duck, airplane};
           for (Flyable obj : flyingObjects) {
               obj.fly();
           }

           System.out.println("\n--- Đối tượng có thể bơi ---");
           Swimmable[] swimmingObjects = {duck, fish};
           for (Swimmable obj : swimmingObjects) {
               obj.swim();
           }
       }
   }
   ```

3. **Abstract Class vs Interface:**

   ```java
   // Abstract Class
   abstract class Animal {
       protected String name;

       // Constructor
       public Animal(String name) {
           this.name = name;
       }

       // Phương thức trừu tượng
       public abstract void makeSound();

       // Phương thức non-abstract
       public void sleep() {
           System.out.println(name + " đang ngủ.");
       }
   }

   // Interface
   interface Pet {
       void play();
       void beGroomed();
   }

   // Lớp kế thừa abstract class và triển khai interface
   class Dog extends Animal implements Pet {
       private String breed;

       public Dog(String name, String breed) {
           super(name);
           this.breed = breed;
       }

       @Override
       public void makeSound() {
           System.out.println(name + " sủa: Gâu gâu!");
       }

       @Override
       public void play() {
           System.out.println(name + " đang chơi đùa với chủ.");
       }

       @Override
       public void beGroomed() {
           System.out.println(name + " đang được tắm và chải lông.");
       }
   }

   public class AbstractVsInterfaceDemo {
       public static void main(String[] args) {
           // Tạo đối tượng Dog
           Dog dog = new Dog("Buddy", "Labrador");

           // Sử dụng phương thức từ abstract class
           dog.makeSound();
           dog.sleep();

           // Sử dụng phương thức từ interface
           dog.play();
           dog.beGroomed();

           // Sử dụng tính đa hình với abstract class
           Animal animal = dog;
           animal.makeSound();

           // Sử dụng tính đa hình với interface
           Pet pet = dog;
           pet.play();
       }
   }
   ```

4. **Ví dụ thực tế - Hệ thống thông báo:**

   ```java
   // Interface cho các dịch vụ thông báo
   interface NotificationService {
       void sendNotification(String message);
       boolean isServiceAvailable();
   }

   // Lớp trừu tượng cho thông báo
   abstract class Notification {
       protected String sender;
       protected String content;

       public Notification(String sender, String content) {
           this.sender = sender;
           this.content = content;
       }

       // Phương thức trừu tượng
       public abstract void display();

       // Phương thức thông thường
       public String getSummary() {
           return "Thông báo từ " + sender + ": " + content.substring(0, Math.min(content.length(), 20)) + "...";
       }
   }

   // Triển khai interface
   class EmailService implements NotificationService {
       private String smtpServer;
       private boolean online;

       public EmailService(String smtpServer) {
           this.smtpServer = smtpServer;
           this.online = true; // Giả sử luôn online
       }

       @Override
       public void sendNotification(String message) {
           if (isServiceAvailable()) {
               System.out.println("Gửi email thông qua " + smtpServer + ": " + message);
           } else {
               System.out.println("Dịch vụ email không khả dụng!");
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
           this.active = true; // Giả sử luôn hoạt động
       }

       @Override
       public void sendNotification(String message) {
           if (isServiceAvailable()) {
               System.out.println("Gửi SMS qua " + providerName + ": " + message);
           } else {
               System.out.println("Dịch vụ SMS không khả dụng!");
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

   // Kế thừa lớp trừu tượng
   class EmailNotification extends Notification {
       private String recipientEmail;

       public EmailNotification(String sender, String content, String recipientEmail) {
           super(sender, content);
           this.recipientEmail = recipientEmail;
       }

       @Override
       public void display() {
           System.out.println("Email Notification");
           System.out.println("Từ: " + sender);
           System.out.println("Đến: " + recipientEmail);
           System.out.println("Nội dung: " + content);
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
           System.out.println("Từ: " + sender);
           System.out.println("Đến: " + phoneNumber);
           System.out.println("Nội dung: " + content);
       }
   }

   // Lớp quản lý thông báo
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
           // Tạo các dịch vụ thông báo
           EmailService emailService = new EmailService("smtp.gmail.com");
           SMSService smsService = new SMSService("Viettel");

           // Tạo mảng dịch vụ thông báo
           NotificationService[] services = {emailService, smsService};

           // Tạo quản lý thông báo
           NotificationManager manager = new NotificationManager(services);

           // Gửi thông báo qua tất cả dịch vụ khả dụng
           manager.sendNotificationToAll("Hệ thống sẽ bảo trì vào 22:00 tối nay.");

           // Đánh dấu dịch vụ email là không khả dụng
           emailService.setOnlineStatus(false);

           // Gửi lại thông báo
           System.out.println("\n--- Sau khi dịch vụ email bị ngắt ---");
           manager.sendNotificationToAll("Thông báo khẩn: Bảo trì hệ thống bị hoãn đến 23:00.");

           // Tạo các thông báo cụ thể
           Notification[] notifications = {
               new EmailNotification("admin@system.com", "Báo cáo hàng tháng đã sẵn sàng.", "user@example.com"),
               new SMSNotification("System", "Mã OTP của bạn là 123456.", "+84987654321")
           };

           // Hiển thị thông báo
           System.out.println("\n--- Các thông báo trong hệ thống ---");
           manager.displayNotifications(notifications);
       }
   }
   ```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Quản lý sinh viên, giảng viên và khóa học**

Viết chương trình:

- Tạo lớp `Person` với các thuộc tính chung như tên, tuổi.
- Tạo lớp `Student` và `Teacher` kế thừa từ lớp `Person` với các đặc điểm riêng.
- Tạo lớp `Course` để quản lý các khóa học.
- Mỗi `Student` và `Teacher` có thể tham gia vào nhiều khóa học.
- Cung cấp phương thức để đăng ký, hủy đăng ký khóa học.

Các chức năng cần có:

- Lớp `Person` với các thuộc tính cơ bản (tên, tuổi).
- Lớp `Student` và `Teacher` kế thừa từ `Person`, với phương thức đặc thù.
- Lớp `Course` quản lý các thông tin khóa học và người tham gia.
- Phương thức đăng ký và hủy khóa học trong lớp `Student`.

---

[⬅️ Trở lại: JAVA/Part2.md](../JAVA/Part2.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: JAVA/Part4.md](../JAVA/Part4.md)
