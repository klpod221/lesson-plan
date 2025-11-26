---
prev:
  text: '🐘 Introduction to PHP'
  link: '/PHP/Part1'
next:
  text: '💾 Advanced PHP'
  link: '/PHP/Part3'
---

# 📘 PART 2: OBJECT-ORIENTED PROGRAMMING WITH PHP

## 🎯 General Objectives

- Master object-oriented programming concepts in PHP.
- Understand and apply inheritance, polymorphism, interfaces, and abstract classes.
- Use magic methods, namespaces, and autoloading.
- Understand and follow PSR standards in PHP.
- Build applications using the object-oriented model.

## 🧑‍🏫 Lesson 6: Object-Oriented Programming in PHP

- Like Java, PHP also supports Object-Oriented Programming (OOP) from version 5 onwards. The difference is that PHP is not a purely object-oriented language, but it supports OOP as a part of the language.

### Creating Classes and Objects

```php
<?php
// Define a class
class Person {
    // Properties
    public $name;
    public $age;

    // Constructor
    public function __construct($name, $age) {
        $this->name = $name;
        $this->age = $age;
    }

    // Method
    public function sayHello() {
        return "Hello, I am {$this->name}, {$this->age} years old.";
    }

    public function getDetails() {
        return "Name: {$this->name}, Age: {$this->age}";
    }
}

// Initialize object from class
$person1 = new Person("John Doe", 25);
$person2 = new Person("Jane Smith", 30);

// Use methods
echo $person1->sayHello() . "<br>";
echo $person2->sayHello() . "<br>";

// Access properties
echo "Details: " . $person1->getDetails() . "<br>";

// Modify properties
$person1->age = 26;
echo "New age of {$person1->name}: {$person1->age} <br>";
?>
```

### Access Modifiers

```php
<?php
class User {
    // Public: can be accessed from anywhere
    public $username;

    // Protected: can only be accessed within the class and derived classes
    protected $email;

    // Private: can only be accessed within the class
    private $password;

    public function __construct($username, $email, $password) {
        $this->username = $username;
        $this->email = $email;
        $this->password = $password;
    }

    public function displayInfo() {
        echo "Username: {$this->username} <br>";
        echo "Email: {$this->email} <br>";
        // Password is protected and not shown
    }

    // Method to access protected property
    public function getEmail() {
        return $this->email;
    }

    // Method to access private property
    public function verifyPassword($inputPassword) {
        // In reality, you should use password_verify function
        return $this->password === $inputPassword;
    }
}

$user = new User("john_doe", "john@example.com", "secret123");
echo $user->username . "<br>"; // OK - Public property
// echo $user->email;    // Error - Protected property
// echo $user->password; // Error - Private property

$user->displayInfo(); // OK
echo "Email: " . $user->getEmail() . "<br>"; // OK - Accessed via method

if ($user->verifyPassword("secret123")) {
    echo "Password is correct!";
} else {
    echo "Password is incorrect!";
}
?>
```

### Static Properties and Methods

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

// Access static property and method without instantiating object
echo "Pi = " . MathHelper::$pi . "<br>";
echo "5 squared = " . MathHelper::square(5) . "<br>";
echo "3 cubed = " . MathHelper::cube(3) . "<br>";
echo "Area of circle with radius 7: " . MathHelper::circleArea(7) . "<br>";

// Modify static property
MathHelper::$pi = 3.14;
echo "New value of Pi = " . MathHelper::$pi . "<br>";
?>
```

### Class Constants

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

// Access constant without instantiating object
echo "App Name: " . Config::APP_NAME . "<br>";
echo "Version: " . Config::VERSION . "<br>";
echo "Debug Mode: " . (Config::DEBUG_MODE ? "On" : "Off") . "<br>";

// Access constant via object
$config = new Config();
echo "App Info: " . $config->getAppInfo() . "<br>";
?>
```

## 🧑‍🏫 Lesson 7: Inheritance and Polymorphism

### Inheritance

```php
<?php
// Base class (Parent class)
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

// Child class inheriting from Base class
class Dog extends Animal {
    private $breed;

    public function __construct($name, $age, $breed) {
        parent::__construct($name, $age); // Call parent constructor
        $this->breed = $breed;
    }

    // Override parent method
    public function makeSound() {
        return "Woof! Woof!";
    }

    public function getInfo() {
        return parent::getInfo() . ", Breed: {$this->breed}";
    }

    // New method in child class
    public function fetch() {
        return "{$this->name} is fetching the ball!";
    }
}

// Another child class inheriting from Animal
class Cat extends Animal {
    private $color;

    public function __construct($name, $age, $color) {
        parent::__construct($name, $age);
        $this->color = $color;
    }

    // Override parent method
    public function makeSound() {
        return "Meow! Meow!";
    }

    public function getInfo() {
        return parent::getInfo() . ", Color: {$this->color}";
    }

    // New method in child class
    public function climb() {
        return "{$this->name} is climbing the tree!";
    }
}

// Using the classes
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

### Polymorphism

```php
<?php
// Using the classes defined above

// Function using polymorphism
function makeAnimalSpeak(Animal $animal) {
    return $animal->makeSound();
}

// By using the Animal type hint, this function can accept any
// object belonging to the Animal class or its subclasses
$animal = new Animal("Generic Animal", 5);
$dog = new Dog("Buddy", 3, "Golden Retriever");
$cat = new Cat("Whiskers", 2, "Orange");

echo "Generic animal says: " . makeAnimalSpeak($animal) . "<br>";
echo "Dog says: " . makeAnimalSpeak($dog) . "<br>";
echo "Cat says: " . makeAnimalSpeak($cat) . "<br>";

// Another example of polymorphism with array containing different objects
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

### Final Keyword

```php
<?php
// Final class cannot be inherited
final class FinalClass {
    public function someMethod() {
        return "This is a method in a final class";
    }
}

// Error when trying to inherit from final class
// class ChildClass extends FinalClass {}

// Class with final method
class BaseWithFinal {
    final public function finalMethod() {
        return "This method cannot be overridden";
    }

    public function normalMethod() {
        return "This method can be overridden";
    }
}

class ChildOfBaseWithFinal extends BaseWithFinal {
    // Error when trying to override final method
    /*
    public function finalMethod() {
        return "Trying to override";
    }
    */

    // OK - can override normal method
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

## 🧑‍🏫 Lesson 8: Interfaces and Abstract Classes

### Abstract Class

```php
<?php
// Abstract class cannot be instantiated directly
abstract class Shape {
    protected $color;

    public function __construct($color = 'red') {
        $this->color = $color;
    }

    // Normal method
    public function getColor() {
        return $this->color;
    }

    // Abstract method - must be defined in subclasses
    abstract public function getArea();
    abstract public function getPerimeter();
}

// Subclass inheriting from abstract class must define all abstract methods
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

    // Method specific to Circle
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

// $shape = new Shape(); // Error: Cannot instantiate abstract class

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

### Interface

```php
<?php
// Interface defines a contract that classes must follow
interface Drawable {
    public function draw(); // Method without body
}

interface Resizable {
    public function resize($percentage);
}

// Class implementing multiple interfaces
class Square implements Drawable, Resizable {
    private $side;

    public function __construct($side) {
        $this->side = $side;
    }

    // Implement method from Drawable interface
    public function draw() {
        return "Drawing a square with side length: {$this->side}";
    }

    // Implement method from Resizable interface
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

// Using classes with interfaces
$square = new Square(4);
echo $square->draw() . "<br>";
echo $square->resize(150) . "<br>";
echo "Square area: " . $square->getArea() . "<br>";

$triangle = new Triangle(5, 3);
echo $triangle->draw() . "<br>";
echo "Triangle area: " . $triangle->getArea() . "<br>";

// Polymorphism with interfaces
function renderObject(Drawable $object) {
    echo "Rendering: " . $object->draw() . "<br>";
}

renderObject($square);
renderObject($triangle);
?>
```

### Difference between Abstract Class and Interface

```php
<?php
// Abstract class can contain common logic and properties
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

    // Common method for all subclasses
    public function getConnectionInfo() {
        return "Connected to {$this->database} on {$this->host}";
    }

    // Abstract methods
    abstract public function connect();
    abstract public function disconnect();
    abstract public function query($sql);
}

// Interface only defines methods without implementation
interface Logger {
    public function logInfo($message);
    public function logError($message, $errorCode);
    public function logDebug($message);
}

// Class inheriting from abstract class and implementing interface
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

// Using the classes
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

## 🧑‍🏫 Lesson 9: Magic Methods and Namespaces

### Magic Methods in PHP

```php
<?php
class Product {
    private $data = [];

    // __construct was mentioned before
    public function __construct($name, $price) {
        $this->data['name'] = $name;
        $this->data['price'] = $price;
        $this->data['created_at'] = date('Y-m-d H:i:s');
    }

    // __get is called when trying to access inaccessible properties
    public function __get($name) {
        if (array_key_exists($name, $this->data)) {
            return $this->data[$name];
        }

        return null; // Or throw an exception
    }

    // __set is called when trying to assign value to inaccessible properties
    public function __set($name, $value) {
        $this->data[$name] = $value;
    }

    // __isset is called when isset() or empty() is called on properties
    public function __isset($name) {
        return isset($this->data[$name]);
    }

    // __unset is called when unset() is called on properties
    public function __unset($name) {
        unset($this->data[$name]);
    }

    // __toString is called when object is treated as a string
    public function __toString() {
        return "{$this->data['name']} - \${$this->data['price']}";
    }

    // __call is called when calling inaccessible methods
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

    // __callStatic is called when calling inaccessible static methods
    public static function __callStatic($name, $arguments) {
        echo "Static method $name called with arguments: " . implode(', ', $arguments) . "<br>";
    }

    // __clone is called when object is copied
    public function __clone() {
        $this->data['created_at'] = date('Y-m-d H:i:s');
        $this->data['name'] = "Copy of " . $this->data['name'];
    }

    // __debugInfo is called by var_dump()
    public function __debugInfo() {
        return [
            'name' => $this->data['name'],
            'price' => $this->data['price'],
            'created' => $this->data['created_at']
        ];
    }
}

// Using magic methods
$product = new Product("Laptop", 999.99);

// __get and __set
echo "Name: " . $product->name . "<br>"; // Uses __get
$product->description = "High-performance laptop"; // Uses __set
echo "Description: " . $product->description . "<br>";

// __toString
echo "Product: " . $product . "<br>"; // Uses __toString

// __call
echo "Price: " . $product->getPrice() . "<br>"; // Uses __call
$product->setDiscount(10); // Uses __call
echo "Discount: " . $product->discount . "<br>";

// __isset and __unset
echo "Has description? " . (isset($product->description) ? "Yes" : "No") . "<br>";
unset($product->description);
echo "Has description after unset? " . (isset($product->description) ? "Yes" : "No") . "<br>";

// __callStatic
Product::findById(1); // Uses __callStatic

// __clone
$product2 = clone $product;
echo "Original: " . $product . "<br>";
echo "Clone: " . $product2 . "<br>";

// __debugInfo
var_dump($product);
?>
```

### Namespaces in PHP

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
// In real projects, autoload will handle this
require_once 'app/Models/User.php';
require_once 'app/Helpers/Logger.php';
require_once 'app/Services/UserService.php';

// Using classes with namespaces
$user = new \App\Models\User(1, 'john_doe');
echo $user->getInfo() . "<br>";

$service = new \App\Services\UserService($user);
echo $service->processUser() . "<br>";

// Using class from another namespace
$logger = new \App\Helpers\Logger();
$logger->log("Example message");

// Define namespace for current code block
namespace MyApp;

// Use 'use' to import classes from other namespaces
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

## 🧑‍🏫 Lesson 10: Autoloading and PSR Standards

### Autoloading in PHP

```php
<?php
// Autoloading is the process of automatically loading class files when needed
// Instead of manually requiring/including each file

// Method 1: spl_autoload_register (PHP 5.1.2+)
spl_autoload_register(function($className) {
    // Convert class name to file path
    $path = str_replace('\\', '/', $className) . '.php';

    if (file_exists($path)) {
        require_once $path;
        return true;
    }
    return false;
});

// Method 2: Multiple autoloaders
spl_autoload_register(function($className) {
    // Autoloader for classes in Models directory
    $path = 'Models/' . $className . '.php';
    if (file_exists($path)) {
        require_once $path;
        return true;
    }
    return false;
});

spl_autoload_register(function($className) {
    // Autoloader for classes in Controllers directory
    $path = 'Controllers/' . $className . '.php';
    if (file_exists($path)) {
        require_once $path;
        return true;
    }
    return false;
});

// Method 3: PSR-4 compliant Autoloader
spl_autoload_register(function($className) {
    // Base directory for autoloader
    $baseDir = __DIR__ . '/src/';

    // Namespace prefix
    $prefix = 'MyApp\\';

    // If the class name does not use the namespace prefix, move to next
    $len = strlen($prefix);
    if (strncmp($prefix, $className, $len) !== 0) {
        return false;
    }

    // Get the relative class name
    $relativeClass = substr($className, $len);

    // Replace namespace separators with directory separators
    $file = $baseDir . str_replace('\\', '/', $relativeClass) . '.php';

    // If the file exists, require it
    if (file_exists($file)) {
        require $file;
        return true;
    }

    return false;
});
?>
```

### Using Composer Autoloader

- In reality, this is the most common method.
- Composer is a dependency manager for PHP that automatically handles loading of classes and libraries you use in your project.

### PSR Standards (PHP Standards Recommendations)

PSR are standards proposed by the PHP Framework Interoperability Group (PHP-FIG) to unify PHP coding styles across frameworks and libraries.

#### PSR-1: Basic Coding Standard

- Files MUST use `<?php` or `<?=` tags.
- Files MUST use UTF-8 without BOM for PHP code.
- Files SHOULD either declare symbols (classes, functions, constants, etc.) or cause side effects (e.g. generate output, change .ini settings, etc.) but SHOULD NOT do both.
- Namespaces and classes MUST follow an "autoloading" PSR: [PSR-0, PSR-4].
- Class names MUST be declared in `PascalCase`.
- Class constants MUST be declared in all upper case with underscore separators (`ALL_CAPS`).
- Method names MUST be declared in `camelCase`.

```php
<?php
// Example of PSR-1:
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
```

### PSR-2: Coding Style Guide

- Code MUST follow PSR-1.
- Code MUST use 4 spaces for indentation, not tabs.
- Line length SHOULD NOT be hard limited to 80 characters; line length MUST NOT exceed 120 characters.
- There MUST be one blank line after the namespace declaration, and there MUST be one blank line after the block of use declarations.
- Opening braces for classes MUST go on the next line, and closing braces MUST go on the next line after the body.
- Opening braces for methods MUST go on the next line, and closing braces MUST go on the next line after the body.
- Visibility MUST be declared on all properties and methods.
- `abstract` and `final` MUST be declared before the visibility declaration.
- `static` MUST be declared after the visibility declaration.
- Control structure keywords MUST have one space after them; method and function calls MUST NOT.

```php
// Example of PSR-2:
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
```

### PSR-4: Autoloader

- A fully qualified class name has the following form: `<NamespaceName>(<SubNamespaceNames>)*<ClassName>`
- The fully qualified class name MUST have a top-level namespace name, also known as a "vendor namespace".
- Sub-namespace names correspond to sub-directories.
- The terminating class name corresponds to a file ending in `.php`.
- Autoloader implementations MUST NOT throw exceptions, MUST NOT raise errors of any level, and SHOULD NOT return a value.

## 🧑‍🏫 Lesson 11: Composer and Package Management

### Introduction to Composer

- Composer is a dependency manager for PHP. It allows you to declare the libraries your project depends on and it will manage (install/update) them for you.

### Creating and Using a Package

```php
<?php
// composer.json
{
    "name": "myvendor/mypackage",
    "description": "My first package",
    "type": "library",
    "license": "MIT",
    "authors": [
        {
            "name": "Your Name",
            "email": "your.email@example.com"
        }
    ],
    "minimum-stability": "dev",
    "require": {
        "php": "^7.4|^8.0"
    },
    "require-dev": {
        "phpunit/phpunit": "^9.0"
    },
    "autoload": {
        "psr-4": {
            "MyVendor\\MyPackage\\": "src/"
        }
    },
    "autoload-dev": {
        "psr-4": {
            "MyVendor\\MyPackage\\Tests\\": "tests/"
        }
    }
}

// src/Calculator.php
namespace MyVendor\MyPackage;

class Calculator
{
    public function add($a, $b)
    {
        return $a + $b;
    }

    public function subtract($a, $b)
    {
        return $a - $b;
    }
}

// tests/CalculatorTest.php
namespace MyVendor\MyPackage\Tests;

use PHPUnit\Framework\TestCase;
use MyVendor\MyPackage\Calculator;

class CalculatorTest extends TestCase
{
    public function testAdd()
    {
        $calc = new Calculator();
        $this->assertEquals(4, $calc->add(2, 2));
    }

    public function testSubtract()
    {
        $calc = new Calculator();
        $this->assertEquals(3, $calc->subtract(5, 2));
    }
}

// Test command
// vendor/bin/phpunit tests/
?>
```

### Using Autoloading with Composer

```php
<?php
// composer.json
{
    "autoload": {
        "psr-4": {
            "App\\": "app/"
        },
        "files": [
            "app/helpers.php"
        ],
        "classmap": [
            "database/seeds",
            "database/factories"
        ]
    }
}

// After editing autoload, update the autoloader
// composer dump-autoload

// Use autoload
// app/Models/User.php
namespace App\Models;

class User
{
    // Class implementation
}

// index.php
require_once 'vendor/autoload.php';

use App\Models\User;

$user = new User();
?>
```

### Using Some Popular Packages

#### Installation Syntax

```bash
composer require <vendor>/<package>

# Install specific version
composer require <vendor>/<package>:<version>

# Install as dev dependency
composer require --dev <vendor>/<package>

```

- The difference between `require` and `require --dev`:
  - `require`: Packages required for the application to run.
  - `require --dev`: Packages only required for development (e.g., testing tools), not needed in production.
- Example: PHPUnit is a testing package, needed during development but not in production.
- You can search for packages on [Packagist](https://packagist.org/), the main Composer repository.

#### Example of Using Common Packages

```php
<?php
// 1. Carbon - DateTime manipulation
// composer require nesbot/carbon

use Carbon\Carbon;

$now = Carbon::now();
echo $now->format('Y-m-d H:i:s');
echo $now->addDays(5)->format('Y-m-d');
echo Carbon::createFromFormat('Y-m-d', '2021-01-01')->diffForHumans();

// 2. Guzzle - HTTP client
// composer require guzzlehttp/guzzle

use GuzzleHttp\Client;

$client = new Client();
$response = $client->request('GET', 'https://api.github.com/repos/guzzle/guzzle');
$data = json_decode($response->getBody(), true);
echo "Guzzle GitHub Stars: " . $data['stargazers_count'];

// 3. Faker - Generate fake data
// composer require fakerphp/faker

$faker = \Faker\Factory::create();
echo $faker->name();
echo $faker->email();
echo $faker->address();
echo $faker->text();

// 4. Monolog - Logging
// composer require monolog/monolog

use Monolog\Logger;
use Monolog\Handler\StreamHandler;

$log = new Logger('app');
$log->pushHandler(new StreamHandler('logs/app.log', Logger::WARNING));
$log->warning('This is a warning');
$log->error('This is an error');

// 5. PHPMailer - Sending emails
// composer require phpmailer/phpmailer

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

$mail = new PHPMailer(true);
try {
    $mail->isSMTP();
    $mail->Host       = 'smtp.example.com';
    $mail->SMTPAuth   = true;
    $mail->Username   = 'user@example.com';
    $mail->Password   = 'secret';
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port       = 587;

    $mail->setFrom('from@example.com', 'Sender Name');
    $mail->addAddress('recipient@example.com', 'Recipient Name');
    $mail->addReplyTo('reply@example.com', 'Reply Name');

    $mail->isHTML(true);
    $mail->Subject = 'Here is the subject';
    $mail->Body    = 'This is the HTML message body <b>in bold!</b>';
    $mail->AltBody = 'This is the plain text body for non-HTML mail clients';

    $mail->send();
    echo 'Message has been sent';
} catch (Exception $e) {
    echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
}
?>
```

## 🧪 FINAL PROJECT: Library Management System

### Project Description

Build an object-oriented PHP application to manage a library, applying OOP principles and PSR standards.

### Requirements

1. **Design the following classes**:

   - `Book`: stores book information (id, title, author, isbn, published_year).
   - `Member`: stores member information (id, name, email, joined_date).
   - `Borrowing`: manages book lending (book_id, member_id, borrow_date, return_date).
   - `Library`: manages the entire system.

2. **Implement features**:

   - Add/Edit/Delete/Search books.
   - Add/Edit/Delete/Search members.
   - Manage borrowing/returning books.
   - Check book status (available or borrowed).
   - Report list of currently borrowed books.
   - Calculate overdue fines.

3. **Apply learned concepts**:
   - Organize code using namespaces.
   - Use abstract classes and interfaces.
   - Implement inheritance and polymorphism.
   - Use autoloading.
   - Follow PSR-1, PSR-2, and PSR-4 standards.

### Suggested Directory Structure

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
