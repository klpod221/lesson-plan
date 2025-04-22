# 📘 PHẦN 2: LẬP TRÌNH HƯỚNG ĐỐI TƯỢNG VỚI PHP

- [📘 PHẦN 2: LẬP TRÌNH HƯỚNG ĐỐI TƯỢNG VỚI PHP](#-phần-2-lập-trình-hướng-đối-tượng-với-php)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 6: Lập trình hướng đối tượng trong PHP](#-bài-6-lập-trình-hướng-đối-tượng-trong-php)
  - [🧑‍🏫 Bài 7: Kế thừa và đa hình](#-bài-7-kế-thừa-và-đa-hình)
  - [🧑‍🏫 Bài 8: Interface và Abstract Class](#-bài-8-interface-và-abstract-class)
  - [🧑‍🏫 Bài 9: Magic Methods và Namespace](#-bài-9-magic-methods-và-namespace)
  - [🧑‍🏫 Bài 10: Auto loading và PSR Standards](#-bài-10-auto-loading-và-psr-standards)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN](#-bài-tập-lớn-cuối-phần)
    - [**Đề bài: Xây dựng hệ thống quản lý thư viện**](#đề-bài-xây-dựng-hệ-thống-quản-lý-thư-viện)
    - [**Yêu cầu:**](#yêu-cầu)
    - [**Cấu trúc dự án:**](#cấu-trúc-dự-án)

## 🎯 Mục tiêu tổng quát

- Nắm vững các khái niệm lập trình hướng đối tượng trong PHP
- Hiểu và áp dụng được các khái niệm về kế thừa, đa hình, interface, abstract class
- Sử dụng được các magic methods, namespace và autoloading
- Hiểu và tuân thủ các chuẩn PSR trong PHP
- Xây dựng được ứng dụng theo mô hình hướng đối tượng

---

## 🧑‍🏫 Bài 6: Lập trình hướng đối tượng trong PHP

**Giới thiệu lập trình hướng đối tượng trong PHP:**

- Lập trình hướng đối tượng (OOP) là một phương pháp lập trình dựa trên khái niệm về các "đối tượng"
- Đối tượng chứa dữ liệu (thuộc tính) và mã (phương thức)
- PHP hỗ trợ OOP từ phiên bản 5 trở lên

**Tạo Class và Object:**

```php
<?php
// Định nghĩa class
class Person {
    // Properties (thuộc tính)
    public $name;
    public $age;

    // Constructor (phương thức khởi tạo)
    public function __construct($name, $age) {
        $this->name = $name;
        $this->age = $age;
    }

    // Method (phương thức)
    public function sayHello() {
        return "Xin chào, tôi là {$this->name}, {$this->age} tuổi.";
    }

    public function getDetails() {
        return "Name: {$this->name}, Age: {$this->age}";
    }
}

// Khởi tạo đối tượng từ class
$person1 = new Person("Nguyễn Văn A", 25);
$person2 = new Person("Trần Thị B", 30);

// Sử dụng các phương thức
echo $person1->sayHello() . "<br>";
echo $person2->sayHello() . "<br>";

// Truy cập thuộc tính
echo "Chi tiết: " . $person1->getDetails() . "<br>";

// Thay đổi thuộc tính
$person1->age = 26;
echo "Tuổi mới của {$person1->name}: {$person1->age} <br>";
?>
```

**Access Modifiers (Phạm vi truy cập):**

```php
<?php
class User {
    // Public: có thể truy cập từ mọi nơi
    public $username;

    // Protected: chỉ có thể truy cập từ trong class và các class kế thừa
    protected $email;

    // Private: chỉ có thể truy cập từ trong class
    private $password;

    public function __construct($username, $email, $password) {
        $this->username = $username;
        $this->email = $email;
        $this->password = $password;
    }

    public function displayInfo() {
        echo "Username: {$this->username} <br>";
        echo "Email: {$this->email} <br>";
        // Password được bảo vệ và không hiển thị
    }

    // Method để truy cập thuộc tính protected
    public function getEmail() {
        return $this->email;
    }

    // Method để truy cập thuộc tính private
    public function verifyPassword($inputPassword) {
        // Trong thực tế, nên sử dụng hàm password_verify
        return $this->password === $inputPassword;
    }
}

$user = new User("john_doe", "john@example.com", "secret123");
echo $user->username . "<br>"; // OK - Public property
// echo $user->email;    // Error - Protected property
// echo $user->password; // Error - Private property

$user->displayInfo(); // OK
echo "Email: " . $user->getEmail() . "<br>"; // OK - Truy cập qua method

if ($user->verifyPassword("secret123")) {
    echo "Password is correct!";
} else {
    echo "Password is incorrect!";
}
?>
```

**Thuộc tính và phương thức tĩnh (Static):**

```php
<?php
class MathHelper {
    // Static property
    public static $pi = 3.14159;

    // Static method
    public static function square($number) {
        return $number * $number;
    }

    public static function cube($number) {
        return $number * $number * $number;
    }

    public static function circleArea($radius) {
        return self::$pi * self::square($radius);
    }
}

// Truy cập static property và method mà không cần khởi tạo đối tượng
echo "Pi = " . MathHelper::$pi . "<br>";
echo "5 bình phương = " . MathHelper::square(5) . "<br>";
echo "3 lập phương = " . MathHelper::cube(3) . "<br>";
echo "Diện tích hình tròn có bán kính 7: " . MathHelper::circleArea(7) . "<br>";

// Thay đổi static property
MathHelper::$pi = 3.14;
echo "Giá trị mới của Pi = " . MathHelper::$pi . "<br>";
?>
```

**Constant trong Class:**

```php
<?php
class Config {
    // Class constant
    const APP_NAME = "My PHP Application";
    const VERSION = "1.0.0";
    const DEBUG_MODE = true;

    public function getAppInfo() {
        return self::APP_NAME . " (v" . self::VERSION . ")";
    }
}

// Truy cập constant mà không cần khởi tạo đối tượng
echo "App Name: " . Config::APP_NAME . "<br>";
echo "Version: " . Config::VERSION . "<br>";
echo "Debug Mode: " . (Config::DEBUG_MODE ? "On" : "Off") . "<br>";

// Truy cập constant thông qua đối tượng
$config = new Config();
echo "App Info: " . $config->getAppInfo() . "<br>";
?>
```

---

## 🧑‍🏫 Bài 7: Kế thừa và đa hình

**Kế thừa (Inheritance):**

```php
<?php
// Lớp cơ sở (Base class / Parent class)
class Animal {
    protected $name;
    protected $age;

    public function __construct($name, $age) {
        $this->name = $name;
        $this->age = $age;
    }

    public function makeSound() {
        return "Some generic animal sound";
    }

    public function getInfo() {
        return "Name: {$this->name}, Age: {$this->age}";
    }
}

// Lớp con (Child class) kế thừa từ lớp cơ sở
class Dog extends Animal {
    private $breed;

    public function __construct($name, $age, $breed) {
        parent::__construct($name, $age); // Gọi constructor của lớp cha
        $this->breed = $breed;
    }

    // Override method của lớp cha
    public function makeSound() {
        return "Woof! Woof!";
    }

    public function getInfo() {
        return parent::getInfo() . ", Breed: {$this->breed}";
    }

    // Method mới trong lớp con
    public function fetch() {
        return "{$this->name} is fetching the ball!";
    }
}

// Lớp con khác kế thừa từ lớp Animal
class Cat extends Animal {
    private $color;

    public function __construct($name, $age, $color) {
        parent::__construct($name, $age);
        $this->color = $color;
    }

    // Override method của lớp cha
    public function makeSound() {
        return "Meow! Meow!";
    }

    public function getInfo() {
        return parent::getInfo() . ", Color: {$this->color}";
    }

    // Method mới trong lớp con
    public function climb() {
        return "{$this->name} is climbing the tree!";
    }
}

// Sử dụng các lớp
$animal = new Animal("Generic Animal", 5);
echo $animal->getInfo() . "<br>";
echo "Sound: " . $animal->makeSound() . "<br><br>";

$dog = new Dog("Buddy", 3, "Golden Retriever");
echo $dog->getInfo() . "<br>";
echo "Sound: " . $dog->makeSound() . "<br>";
echo $dog->fetch() . "<br><br>";

$cat = new Cat("Whiskers", 2, "Orange");
echo $cat->getInfo() . "<br>";
echo "Sound: " . $cat->makeSound() . "<br>";
echo $cat->climb() . "<br>";
?>
```

**Đa hình (Polymorphism):**

```php
<?php
// Với các class đã định nghĩa ở trên

// Function sử dụng đa hình
function makeAnimalSpeak(Animal $animal) {
    return $animal->makeSound();
}

// Với việc sử dụng kiểu Animal, hàm này có thể nhận bất kỳ
// đối tượng nào thuộc lớp Animal hoặc các lớp con của nó
$animal = new Animal("Generic Animal", 5);
$dog = new Dog("Buddy", 3, "Golden Retriever");
$cat = new Cat("Whiskers", 2, "Orange");

echo "Generic animal says: " . makeAnimalSpeak($animal) . "<br>";
echo "Dog says: " . makeAnimalSpeak($dog) . "<br>";
echo "Cat says: " . makeAnimalSpeak($cat) . "<br>";

// Ví dụ khác về đa hình với mảng chứa các đối tượng khác nhau
$animals = [
    new Animal("Generic Animal", 5),
    new Dog("Buddy", 3, "Golden Retriever"),
    new Cat("Whiskers", 2, "Orange"),
    new Dog("Rex", 5, "German Shepherd"),
    new Cat("Mittens", 1, "Black")
];

echo "<h3>Animal Sounds:</h3>";
foreach ($animals as $animal) {
    echo get_class($animal) . ": " . $animal->makeSound() . "<br>";
}
?>
```

**Final Keyword:**

```php
<?php
// Final class không thể được kế thừa
final class FinalClass {
    public function someMethod() {
        return "This is a method in a final class";
    }
}

// Lỗi khi cố gắng kế thừa từ final class
// class ChildClass extends FinalClass {}

// Class với final method
class BaseWithFinal {
    final public function finalMethod() {
        return "This method cannot be overridden";
    }

    public function normalMethod() {
        return "This method can be overridden";
    }
}

class ChildOfBaseWithFinal extends BaseWithFinal {
    // Lỗi khi cố gắng override final method
    /*
    public function finalMethod() {
        return "Trying to override";
    }
    */

    // OK - có thể override method thông thường
    public function normalMethod() {
        return "Overridden method";
    }
}

$finalClass = new FinalClass();
echo $finalClass->someMethod() . "<br>";

$child = new ChildOfBaseWithFinal();
echo $child->finalMethod() . "<br>";
echo $child->normalMethod() . "<br>";
?>
```

---

## 🧑‍🏫 Bài 8: Interface và Abstract Class

**Abstract Class:**

```php
<?php
// Abstract class không thể khởi tạo trực tiếp
abstract class Shape {
    protected $color;

    public function __construct($color = 'red') {
        $this->color = $color;
    }

    // Method thông thường
    public function getColor() {
        return $this->color;
    }

    // Abstract method - phải được định nghĩa lại trong các lớp con
    abstract public function getArea();
    abstract public function getPerimeter();
}

// Lớp con kế thừa từ abstract class phải định nghĩa tất cả abstract methods
class Circle extends Shape {
    private $radius;

    public function __construct($radius, $color = 'red') {
        parent::__construct($color);
        $this->radius = $radius;
    }

    public function getArea() {
        return pi() * $this->radius * $this->radius;
    }

    public function getPerimeter() {
        return 2 * pi() * $this->radius;
    }

    // Method đặc trưng của Circle
    public function getDiameter() {
        return 2 * $this->radius;
    }
}

class Rectangle extends Shape {
    private $width;
    private $height;

    public function __construct($width, $height, $color = 'blue') {
        parent::__construct($color);
        $this->width = $width;
        $this->height = $height;
    }

    public function getArea() {
        return $this->width * $this->height;
    }

    public function getPerimeter() {
        return 2 * ($this->width + $this->height);
    }
}

// $shape = new Shape(); // Lỗi: Không thể khởi tạo abstract class

$circle = new Circle(5, 'green');
echo "Circle - Color: " . $circle->getColor() . "<br>";
echo "Circle - Area: " . $circle->getArea() . "<br>";
echo "Circle - Perimeter: " . $circle->getPerimeter() . "<br>";
echo "Circle - Diameter: " . $circle->getDiameter() . "<br>";

$rect = new Rectangle(4, 6);
echo "Rectangle - Color: " . $rect->getColor() . "<br>";
echo "Rectangle - Area: " . $rect->getArea() . "<br>";
echo "Rectangle - Perimeter: " . $rect->getPerimeter() . "<br>";
?>
```

**Interface:**

```php
<?php
// Interface định nghĩa hợp đồng mà các class phải tuân theo
interface Drawable {
    public function draw(); // Phương thức không có thân hàm
}

interface Resizable {
    public function resize($percentage);
}

// Class thực thi nhiều interface
class Square implements Drawable, Resizable {
    private $side;

    public function __construct($side) {
        $this->side = $side;
    }

    // Triển khai phương thức từ interface Drawable
    public function draw() {
        return "Drawing a square with side length: {$this->side}";
    }

    // Triển khai phương thức từ interface Resizable
    public function resize($percentage) {
        $this->side = $this->side * $percentage / 100;
        return "Square resized to side length: {$this->side}";
    }

    public function getArea() {
        return $this->side * $this->side;
    }
}

class Triangle implements Drawable {
    private $base;
    private $height;

    public function __construct($base, $height) {
        $this->base = $base;
        $this->height = $height;
    }

    public function draw() {
        return "Drawing a triangle with base {$this->base} and height {$this->height}";
    }

    public function getArea() {
        return 0.5 * $this->base * $this->height;
    }
}

// Sử dụng các class có interface
$square = new Square(4);
echo $square->draw() . "<br>";
echo $square->resize(150) . "<br>";
echo "Square area: " . $square->getArea() . "<br>";

$triangle = new Triangle(5, 3);
echo $triangle->draw() . "<br>";
echo "Triangle area: " . $triangle->getArea() . "<br>";

// Đa hình với interface
function renderObject(Drawable $object) {
    echo "Rendering: " . $object->draw() . "<br>";
}

renderObject($square);
renderObject($triangle);
?>
```

**Sự khác biệt giữa Abstract Class và Interface:**

```php
<?php
// Abstract class có thể chứa logic chung và các thuộc tính
abstract class DatabaseConnection {
    protected $connection;
    protected $host;
    protected $username;
    protected $password;
    protected $database;

    public function __construct($host, $username, $password, $database) {
        $this->host = $host;
        $this->username = $username;
        $this->password = $password;
        $this->database = $database;
    }

    // Method chung cho tất cả các class con
    public function getConnectionInfo() {
        return "Connected to {$this->database} on {$this->host}";
    }

    // Abstract methods
    abstract public function connect();
    abstract public function disconnect();
    abstract public function query($sql);
}

// Interface chỉ định nghĩa các phương thức mà không có triển khai
interface Logger {
    public function logInfo($message);
    public function logError($message, $errorCode);
    public function logDebug($message);
}

// Class kế thừa từ abstract class và thực thi interface
class MySQLConnection extends DatabaseConnection implements Logger {
    public function connect() {
        $this->connection = "MySQL connection established";
        return $this->connection;
    }

    public function disconnect() {
        $this->connection = null;
        return "MySQL connection closed";
    }

    public function query($sql) {
        return "Executing MySQL query: $sql";
    }

    // Implement interface methods
    public function logInfo($message) {
        return "MySQL INFO: $message";
    }

    public function logError($message, $errorCode) {
        return "MySQL ERROR ($errorCode): $message";
    }

    public function logDebug($message) {
        return "MySQL DEBUG: $message";
    }
}

class PostgreSQLConnection extends DatabaseConnection implements Logger {
    public function connect() {
        $this->connection = "PostgreSQL connection established";
        return $this->connection;
    }

    public function disconnect() {
        $this->connection = null;
        return "PostgreSQL connection closed";
    }

    public function query($sql) {
        return "Executing PostgreSQL query: $sql";
    }

    public function logInfo($message) {
        return "PostgreSQL INFO: $message";
    }

    public function logError($message, $errorCode) {
        return "PostgreSQL ERROR ($errorCode): $message";
    }

    public function logDebug($message) {
        return "PostgreSQL DEBUG: $message";
    }
}

// Sử dụng các class
$mysql = new MySQLConnection('localhost', 'root', 'password', 'testdb');
echo $mysql->connect() . "<br>";
echo $mysql->getConnectionInfo() . "<br>";
echo $mysql->query("SELECT * FROM users") . "<br>";
echo $mysql->logInfo("Query executed successfully") . "<br>";
echo $mysql->disconnect() . "<br><br>";

$postgres = new PostgreSQLConnection('localhost', 'postgres', 'password', 'testdb');
echo $postgres->connect() . "<br>";
echo $postgres->getConnectionInfo() . "<br>";
echo $postgres->query("SELECT * FROM users") . "<br>";
echo $postgres->logError("Connection timeout", 1001) . "<br>";
echo $postgres->disconnect() . "<br>";
?>
```

---

## 🧑‍🏫 Bài 9: Magic Methods và Namespace

**Magic Methods trong PHP:**

```php
<?php
class Product {
    private $data = [];

    // __construct đã được đề cập trước đây
    public function __construct($name, $price) {
        $this->data['name'] = $name;
        $this->data['price'] = $price;
        $this->data['created_at'] = date('Y-m-d H:i:s');
    }

    // __get được gọi khi cố truy cập thuộc tính không tồn tại
    public function __get($name) {
        if (array_key_exists($name, $this->data)) {
            return $this->data[$name];
        }

        return null; // Hoặc có thể throw một exception
    }

    // __set được gọi khi cố gán giá trị cho thuộc tính không tồn tại
    public function __set($name, $value) {
        $this->data[$name] = $value;
    }

    // __isset được gọi khi isset() hoặc empty() được gọi trên thuộc tính
    public function __isset($name) {
        return isset($this->data[$name]);
    }

    // __unset được gọi khi unset() được gọi trên thuộc tính
    public function __unset($name) {
        unset($this->data[$name]);
    }

    // __toString được gọi khi đối tượng được sử dụng như một chuỗi
    public function __toString() {
        return "{$this->data['name']} - \${$this->data['price']}";
    }

    // __call được gọi khi gọi một phương thức không tồn tại
    public function __call($name, $arguments) {
        if (strpos($name, 'get') === 0) {
            $property = lcfirst(substr($name, 3));
            if (array_key_exists($property, $this->data)) {
                return $this->data[$property];
            }
        }

        if (strpos($name, 'set') === 0) {
            $property = lcfirst(substr($name, 3));
            $this->data[$property] = $arguments[0];
            return $this;
        }

        throw new Exception("Method $name does not exist");
    }

    // __callStatic được gọi khi gọi một phương thức tĩnh không tồn tại
    public static function __callStatic($name, $arguments) {
        echo "Static method $name called with arguments: " . implode(', ', $arguments) . "<br>";
    }

    // __clone được gọi khi đối tượng được sao chép
    public function __clone() {
        $this->data['created_at'] = date('Y-m-d H:i:s');
        $this->data['name'] = "Copy of " . $this->data['name'];
    }

    // __debugInfo được gọi bởi var_dump()
    public function __debugInfo() {
        return [
            'name' => $this->data['name'],
            'price' => $this->data['price'],
            'created' => $this->data['created_at']
        ];
    }
}

// Sử dụng magic methods
$product = new Product("Laptop", 999.99);

// __get và __set
echo "Name: " . $product->name . "<br>"; // Sử dụng __get
$product->description = "High-performance laptop"; // Sử dụng __set
echo "Description: " . $product->description . "<br>";

// __toString
echo "Product: " . $product . "<br>"; // Sử dụng __toString

// __call
echo "Price: " . $product->getPrice() . "<br>"; // Sử dụng __call
$product->setDiscount(10); // Sử dụng __call
echo "Discount: " . $product->discount . "<br>";

// __isset và __unset
echo "Has description? " . (isset($product->description) ? "Yes" : "No") . "<br>";
unset($product->description);
echo "Has description after unset? " . (isset($product->description) ? "Yes" : "No") . "<br>";

// __callStatic
Product::findById(1); // Sử dụng __callStatic

// __clone
$product2 = clone $product;
echo "Original: " . $product . "<br>";
echo "Clone: " . $product2 . "<br>";

// __debugInfo
var_dump($product);
?>
```

**Namespace trong PHP:**

```php
<?php
// File: app/Models/User.php
namespace App\Models;

class User {
    private $id;
    private $username;

    public function __construct($id, $username) {
        $this->id = $id;
        $this->username = $username;
    }

    public function getInfo() {
        return "User #{$this->id}: {$this->username}";
    }
}

// File: app/Services/UserService.php
namespace App\Services;

use App\Models\User;
use App\Helpers\Logger as LoggerHelper;

class UserService {
    private $user;
    private $logger;

    public function __construct(User $user) {
        $this->user = $user;
        $this->logger = new LoggerHelper();
    }

    public function processUser() {
        $this->logger->log("Processing user");
        return $this->user->getInfo();
    }
}

// File: app/Helpers/Logger.php
namespace App\Helpers;

class Logger {
    public function log($message) {
        echo "[LOG] " . date('Y-m-d H:i:s') . " - $message<br>";
    }
}

// File: index.php
// Trong các dự án thực tế, autoload sẽ tự động làm điều này
require_once 'app/Models/User.php';
require_once 'app/Helpers/Logger.php';
require_once 'app/Services/UserService.php';

// Sử dụng các class với namespace
$user = new \App\Models\User(1, 'john_doe');
echo $user->getInfo() . "<br>";

$service = new \App\Services\UserService($user);
echo $service->processUser() . "<br>";

// Sử dụng class từ namespace khác
$logger = new \App\Helpers\Logger();
$logger->log("Example message");

// Định nghĩa namespace cho đoạn code hiện tại
namespace MyApp;

// Sử dụng use để import class từ namespace khác
use App\Models\User as UserModel;
use App\Services\UserService;
use App\Helpers\Logger;

$user2 = new UserModel(2, 'jane_doe');
echo $user2->getInfo() . "<br>";

$service2 = new UserService($user2);
echo $service2->processUser() . "<br>";

$logger2 = new Logger();
$logger2->log("Another message");
?>
```

---

## 🧑‍🏫 Bài 10: Auto loading và PSR Standards

**Autoloading trong PHP:**

```php
<?php
// Autoloading là quá trình tự động nạp các file class khi cần thiết
// Thay vì phải require/include từng file thủ công

// Cách 1: spl_autoload_register (PHP 5.1.2+)
spl_autoload_register(function($className) {
    // Chuyển đổi tên class thành đường dẫn file
    $path = str_replace('\\', '/', $className) . '.php';

    if (file_exists($path)) {
        require_once $path;
        return true;
    }
    return false;
});

// Cách 2: Nhiều autoloader
spl_autoload_register(function($className) {
    // Autoloader cho các class trong thư mục Models
    $path = 'Models/' . $className . '.php';
    if (file_exists($path)) {
        require_once $path;
        return true;
    }
    return false;
});

spl_autoload_register(function($className) {
    // Autoloader cho các class trong thư mục Controllers
    $path = 'Controllers/' . $className . '.php';
    if (file_exists($path)) {
        require_once $path;
        return true;
    }
    return false;
});

// Cách 3: Autoloader tuân thủ PSR-4
spl_autoload_register(function($className) {
    // Base directory cho autoloader
    $baseDir = __DIR__ . '/src/';

    // Namespace prefix
    $prefix = 'MyApp\\';

    // Nếu tên class không bắt đầu với namespace prefix, bỏ qua
    $len = strlen($prefix);
    if (strncmp($prefix, $className, $len) !== 0) {
        return false;
    }

    // Lấy tên class tương đối so với namespace
    $relativeClass = substr($className, $len);

    // Chuyển namespace thành đường dẫn file
    $file = $baseDir . str_replace('\\', '/', $relativeClass) . '.php';

    // Nếu file tồn tại, load nó
    if (file_exists($file)) {
        require $file;
        return true;
    }

    return false;
});

// Sử dụng composer autoloader
// Trong thực tế, đây là cách được dùng phổ biến nhất
// 1. Tạo file composer.json với nội dung:
/*
{
    "autoload": {
        "psr-4": {
            "MyApp\\": "src/"
        }
    }
}
*/
// 2. Chạy lệnh: composer dump-autoload
// 3. Thêm dòng sau vào file PHP:
// require 'vendor/autoload.php';

// Sau khi cài đặt autoloader, bạn có thể sử dụng các class mà không cần require
// $user = new MyApp\Models\User();
// $post = new MyApp\Models\Post();
?>
```

**PSR Standards (PHP Standards Recommendations):**

PSR là các tiêu chuẩn được đề xuất bởi PHP Framework Interoperability Group (PHP-FIG) để thống nhất cách viết code PHP giữa các framework và thư viện.

```php
<?php
// PSR-1: Basic Coding Standard

// 1. Files PHẢI sử dụng thẻ <?php hoặc <?= (không dùng <?)
// 2. Files PHẢI sử dụng mã UTF-8 without BOM cho code PHP
// 3. Files NÊN hoặc khai báo symbol (classes, functions, constants, etc.) hoặc side effects (như output, thay đổi .ini, etc.), nhưng KHÔNG NÊN làm cả hai
// 4. Namespaces và classes PHẢI tuân theo PSR-0 hoặc PSR-4
// 5. Tên class PHẢI sử dụng PascalCase (TênClass)
// 6. Class constants PHẢI được khai báo dạng chữ hoa và underscore (ALL_CAPS)
// 7. Tên method PHẢI sử dụng camelCase (tênMethod)

// Ví dụ về PSR-1:
namespace Vendor\Package;

class ClassName
{
    const VERSION = '1.0';
    const DATE_APPROVED = '2020-01-01';

    public function methodName($parameter)
    {
        // method code
    }
}

// PSR-2: Coding Style Guide
// 1. Code PHẢI tuân theo PSR-1
// 2. Code PHẢI sử dụng 4 spaces cho việc thụt lề, không phải tabs
// 3. Line length KHÔNG NÊN vượt quá 80 ký tự, KHÔNG ĐƯỢC vượt quá 120 ký tự
// 4. PHẢI có 1 dòng trống sau namespace và PHẢI có 1 dòng trống sau khối use
// 5. Opening braces cho classes PHẢI trên dòng mới, closing braces PHẢI trên dòng mới tiếp theo
// 6. Opening braces cho methods PHẢI trên dòng mới, closing braces PHẢI trên dòng mới tiếp theo
// 7. Visibility PHẢI được khai báo trên tất cả properties và methods
// 8. abstract và final PHẢI được khai báo trước visibility
// 9. static PHẢI được khai báo sau visibility
// 10. Control structures keywords PHẢI có 1 space sau chúng, gọi method và function KHÔNG ĐƯỢC có space

// Ví dụ về PSR-2:
namespace Vendor\Package;

use FooInterface;
use BarClass as Bar;
use OtherVendor\OtherPackage\BazClass;

class Foo extends Bar implements FooInterface
{
    public function sampleFunction($a, $b = null)
    {
        if ($a === $b) {
            bar();
        } elseif ($a > $b) {
            $foo->bar($arg1);
        } else {
            BazClass::bar($arg2, $arg3);
        }
    }

    final public static function bar()
    {
        // method body
    }
}

// PSR-4: Autoloader
// 1. Fully qualified class name PHẢI có cấu trúc: <NamespaceName>(<SubNamespaceNames>)*<ClassName>
// 2. Top-level namespace name là "vendor namespace"
// 3. Sub-namespace names tương ứng với thư mục trong file system
// 4. Class name tương ứng với filename.php
// 5. Autoloader PHẢI có thể load bất kỳ file nào khớp với quy tắc trên

// Ví dụ: PSR-4 autoloader
// Cấu trúc thư mục:
// vendor/
//   composer/
//     autoload.php
//   acme/
//     foo/
//       src/
//         Foo.php
//       tests/
//         FooTest.php

// composer.json:
/*
{
    "autoload": {
        "psr-4": {
            "Acme\\Foo\\": "src/",
            "Acme\\Foo\\Tests\\": "tests/"
        }
    }
}
*/

// File: src/Foo.php
namespace Acme\Foo;

class Foo
{
}

// File: tests/FooTest.php
namespace Acme\Foo\Tests;

class FooTest
{
}

// Trong code:
require 'vendor/autoload.php';

$foo = new \Acme\Foo\Foo();
$test = new \Acme\Foo\Tests\FooTest();
?>
```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Xây dựng hệ thống quản lý thư viện**

Xây dựng một ứng dụng PHP hướng đối tượng để quản lý thư viện, áp dụng các nguyên tắc OOP và các tiêu chuẩn PSR.

### **Yêu cầu:**

1. Thiết kế các class sau:

   - `Book`: lưu trữ thông tin sách (id, title, author, isbn, published_year)
   - `Member`: lưu trữ thông tin thành viên (id, name, email, joined_date)
   - `Borrowing`: quản lý việc mượn sách (book_id, member_id, borrow_date, return_date)
   - `Library`: quản lý toàn bộ hệ thống

2. Triển khai các tính năng:

   - Thêm/sửa/xóa/tìm kiếm sách
   - Thêm/sửa/xóa/tìm kiếm thành viên
   - Quản lý mượn trả sách
   - Kiểm tra tình trạng sách (có sẵn hay đang được mượn)
   - Thống kê danh sách sách đang được mượn
   - Tính toán tiền phạt nếu trả sách trễ

3. Áp dụng những kiến thức đã học:
   - Tổ chức code theo namespace
   - Sử dụng abstract class và interface
   - Triển khai tính kế thừa và đa hình
   - Sử dụng autoloading
   - Tuân thủ các tiêu chuẩn PSR-1, PSR-2, và PSR-4

### **Cấu trúc dự án:**

```text
library-management/
├── src/
│   ├── Models/
│   │   ├── Book.php
│   │   ├── Member.php
│   │   └── Borrowing.php
│   ├── Services/
│   │   ├── LibraryService.php
│   │   ├── BookService.php
│   │   └── MemberService.php
│   ├── Interfaces/
│   │   ├── SearchableInterface.php
│   │   └── ReportGeneratorInterface.php
│   └── Library.php
├── public/
│   └── index.php
├── composer.json
└── README.md
```

---

[⬅️ Trở lại: PHP/Part1.md](../PHP/Part1.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: PHP/Part2.md](../PHP/Part2.md)
