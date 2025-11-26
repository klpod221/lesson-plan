---
prev:
  text: '⚙️ Frameworks & Tools'
  link: '/WEB/Part4'
next:
  text: '🧩 OOP with PHP'
  link: '/PHP/Part2'
---

# 📘 PART 1: INTRODUCTION TO PHP

## 🎯 General Objectives

- Understand the basic concepts of PHP and how PHP works with the web.
- Master PHP syntax, variables, functions, and control structures.
- Know how to combine PHP with HTML to create dynamic web pages.
- Build a simple web application with PHP.

## 🧑‍🏫 Lesson 1: Introduction to PHP

### What is PHP?

- PHP (PHP: Hypertext Preprocessor) is a server-side scripting language.
- It is designed specifically for web development.
- PHP code is executed on the server, and the result is returned to the client as HTML.
- PHP can be embedded within HTML.

### First PHP File

```php
<!DOCTYPE html>
<html>
<head>
    <title>First PHP Page</title>
</head>
<body>
    <h1>Hello PHP</h1>
    
    <?php
        // This is a single-line comment
        
        /* This is a
        multi-line comment */
        
        echo "Hello, World!";
        
        // Print with information
        echo "<p>Today is " . date("d/m/Y") . "</p>";
    ?>
</body>
</html>
```

Create an `index.php` file and open your terminal to run the following command:

```bash
php -S localhost:8000
```

Access `http://localhost:8000` to see the result.

### Basic PHP Syntax

- PHP starts with `<?php` and ends with `?>`.
- Each statement ends with a semicolon (;).
- PHP is case-sensitive for variable names.
- You can embed multiple PHP blocks within a single HTML page.

## 🧑‍🏫 Lesson 2: Variables and Data Types in PHP

### Variables in PHP

- Variables start with the `$` sign.
- Variable names must start with a letter or an underscore.
- Variable names cannot start with a number.
- PHP is a loosely typed language (no need to declare types).

```php
<?php
    // Declare and assign values to variables
    $name = "John Doe";
    $age = 25;
    $isStudent = true;
    
    // Print variable values
    echo "Name: " . $name . "<br>";
    echo "Age: " . $age . "<br>";
    echo "Is Student: " . ($isStudent ? "Yes" : "No");
?>
```

### Basic Data Types

```php
<?php
    // String
    $str = "Hello PHP";
    echo gettype($str) . ": " . $str . "<br>";
    
    // Integer
    $int = 42;
    echo gettype($int) . ": " . $int . "<br>";
    
    // Float/Double
    $float = 3.14;
    echo gettype($float) . ": " . $float . "<br>";
    
    // Boolean
    $bool = true;
    echo gettype($bool) . ": " . ($bool ? "true" : "false") . "<br>";
    
    // Null
    $null = null;
    echo gettype($null) . ": null<br>";
    
    // Check data type
    var_dump($str);
    echo "<br>";
    var_dump($int);
    echo "<br>";
    var_dump($bool);
?>
```

### Constants

```php
<?php
    // Define a constant
    define("PI", 3.14159);
    define("APP_NAME", "My PHP Application");
    define("DEBUG_MODE", true);
    
    // Use constants
    echo "PI = " . PI . "<br>";
    echo "App Name: " . APP_NAME . "<br>";
    
    // Constants since PHP 7.0
    const DATABASE = "mysql";
    const DB_HOST = "localhost";
    
    echo "Database: " . DATABASE;
?>
```

## 🧑‍🏫 Lesson 3: Operators and Control Structures

### Operators in PHP

```php
<?php
    // Arithmetic Operators
    $a = 10;
    $b = 3;
    echo "Addition: " . ($a + $b) . "<br>";        // 13
    echo "Subtraction: " . ($a - $b) . "<br>";     // 7
    echo "Multiplication: " . ($a * $b) . "<br>";  // 30
    echo "Division: " . ($a / $b) . "<br>";        // 3.3333...
    echo "Modulus: " . ($a % $b) . "<br>";         // 1
    echo "Exponentiation: " . ($a ** $b) . "<br>"; // 10^3 = 1000
    
    // Assignment Operators
    $x = 5;
    $x += 3;  // $x = $x + 3
    echo "x = " . $x . "<br>";  // 8
    
    // Comparison Operators
    $p = 5;
    $q = "5";
    echo "p == q: " . ($p == $q ? "true" : "false") . "<br>";   // true (value comparison)
    echo "p === q: " . ($p === $q ? "true" : "false") . "<br>"; // false (value and type comparison)
    
    // Increment/Decrement Operators
    $i = 5;
    echo "i++ = " . $i++ . "<br>"; // 5 (use then increment)
    echo "i = " . $i . "<br>";     // 6
    echo "++i = " . ++$i . "<br>"; // 7 (increment then use)
    
    // String Operators
    $firstName = "John";
    $lastName = "Doe";
    $fullName = $firstName . " " . $lastName;
    echo "Full Name: " . $fullName;
?>
```

### Conditional Structures

```php
<?php
    $score = 75;
    
    // if-else statement
    if ($score >= 90) {
        echo "Excellent";
    } elseif ($score >= 80) {
        echo "Good";
    } elseif ($score >= 70) {
        echo "Fair";
    } elseif ($score >= 60) {
        echo "Average";
    } else {
        echo "Poor";
    }
    echo "<br>";
    
    // Ternary Operator
    echo ($score >= 60) ? "Passed" : "Failed";
    echo "<br>";
    
    // Switch-case
    $day = 3;
    switch ($day) {
        case 1:
            echo "Sunday";
            break;
        case 2:
            echo "Monday";
            break;
        case 3:
            echo "Tuesday";
            break;
        case 4:
            echo "Wednesday";
            break;
        case 5:
            echo "Thursday";
            break;
        case 6:
            echo "Friday";
            break;
        case 7:
            echo "Saturday";
            break;
        default:
            echo "Invalid day";
    }
?>
```

### Loops

```php
<?php
    // For loop
    echo "<h3>For Loop</h3>";
    echo "<ul>";
    for ($i = 1; $i <= 5; $i++) {
        echo "<li>Item $i</li>";
    }
    echo "</ul>";
    
    // While loop
    echo "<h3>While Loop</h3>";
    $count = 1;
    echo "<ul>";
    while ($count <= 5) {
        echo "<li>Count: $count</li>";
        $count++;
    }
    echo "</ul>";
    
    // Do-while loop
    echo "<h3>Do-while Loop</h3>";
    $num = 1;
    echo "<ul>";
    do {
        echo "<li>Number: $num</li>";
        $num++;
    } while ($num <= 5);
    echo "</ul>";
    
    // Break and Continue
    echo "<h3>Break and Continue</h3>";
    echo "<p>Odd numbers from 1-10:</p>";
    for ($i = 1; $i <= 10; $i++) {
        if ($i % 2 == 0) {
            continue; // Skip even numbers
        }
        echo "$i ";
        
        if ($i == 7) {
            break; // Stop when hitting 7
        }
    }
?>
```

## 🧑‍🏫 Lesson 4: Functions and Arrays in PHP

### Functions in PHP

```php
<?php
    // Function without parameters
    function sayHello() {
        echo "Hello from PHP function! <br>";
    }
    
    // Call function
    sayHello();
    
    // Function with parameters
    function greet($name) {
        echo "Hello, $name! <br>";
    }
    
    greet("John Doe");
    
    // Function with default parameters
    function calculateTotal($price, $taxRate = 0.1) {
        $tax = $price * $taxRate;
        $total = $price + $tax;
        return $total;
    }
    
    $amount = calculateTotal(100);  // Use default tax rate
    echo "Total: $amount <br>";
    
    $amount2 = calculateTotal(100, 0.05);  // Specify tax rate
    echo "Total with 5% tax: $amount2 <br>";
    
    // Function returning multiple values (using array)
    function getMinMax($numbers) {
        return [
            'min' => min($numbers),
            'max' => max($numbers)
        ];
    }
    
    $result = getMinMax([10, 5, 8, 20, 3]);
    echo "Min: " . $result['min'] . ", Max: " . $result['max'] . "<br>";
?>
```

### Arrays in PHP

```php
<?php
    // Indexed array
    $numbers = [1, 2, 3, 4, 5];
    // or: $numbers = array(1, 2, 3, 4, 5);
    
    echo "Element at index 2: " . $numbers[2] . "<br>"; // Index starts at 0
    
    // Iterate array with for
    echo "Iterate with for: ";
    for ($i = 0; $i < count($numbers); $i++) {
        echo $numbers[$i] . " ";
    }
    echo "<br>";
    
    // Iterate array with foreach
    echo "Iterate with foreach: ";
    foreach ($numbers as $value) {
        echo $value . " ";
    }
    echo "<br>";
    
    // Associative array
    $student = [
        'name' => 'John Doe',
        'age' => 20,
        'major' => 'Computer Science',
        'gpa' => 3.8
    ];
    
    echo "Student Name: " . $student['name'] . "<br>";
    echo "Major: " . $student['major'] . "<br>";
    
    // Iterate associative array
    echo "<h3>Student Info:</h3>";
    echo "<ul>";
    foreach ($student as $key => $value) {
        echo "<li>$key: $value</li>";
    }
    echo "</ul>";
    
    // Multidimensional array
    $students = [
        [
            'name' => 'John Doe',
            'age' => 20,
            'scores' => [85, 90, 78]
        ],
        [
            'name' => 'Jane Smith',
            'age' => 21,
            'scores' => [92, 88, 95]
        ],
        [
            'name' => 'Bob Wilson',
            'age' => 22,
            'scores' => [75, 80, 82]
        ]
    ];
    
    // Access multidimensional array
    echo "Second student: " . $students[1]['name'] . "<br>";
    echo "Third score of second student: " . $students[1]['scores'][2] . "<br>";
    
    // Iterate multidimensional array
    echo "<h3>Student List:</h3>";
    foreach ($students as $student) {
        echo "<p><strong>" . $student['name'] . "</strong>, " . $student['age'] . " years old</p>";
        echo "<p>Scores: ";
        foreach ($student['scores'] as $score) {
            echo $score . " ";
        }
        echo "</p>";
        echo "<hr>";
    }
    
    // Some array functions
    $fruits = ['apple', 'banana', 'orange', 'grape'];
    
    echo "Count: " . count($fruits) . "<br>";
    
    // Add element to array
    $fruits[] = 'mango';
    array_push($fruits, 'strawberry', 'kiwi');
    
    // Sort array
    sort($fruits);
    echo "Sorted array: ";
    print_r($fruits);
    echo "<br>";
    
    // Reverse array
    $reversed = array_reverse($fruits);
    echo "Reversed array: ";
    print_r($reversed);
    echo "<br>";
    
    // Convert array to string
    $fruitString = implode(", ", $fruits);
    echo "String from array: " . $fruitString . "<br>";
    
    // Convert string to array
    $colors = "red,green,blue,yellow";
    $colorArray = explode(",", $colors);
    echo "Array from string: ";
    print_r($colorArray);
?>
```

## 🧑‍🏫 Lesson 5: PHP and HTML

### Combining PHP with HTML

```php
<!DOCTYPE html>
<html>
<head>
    <title>PHP and HTML</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
    <h1>Product List</h1>
    
    <?php
    // Product data (usually fetched from a database)
    $products = [
        [
            'id' => 1,
            'name' => 'Laptop Dell XPS 13',
            'price' => 1299.99,
            'stock' => 10
        ],
        [
            'id' => 2,
            'name' => 'iPhone 13 Pro',
            'price' => 999.99,
            'stock' => 15
        ],
        [
            'id' => 3,
            'name' => 'Samsung Galaxy S21',
            'price' => 799.99,
            'stock' => 8
        ],
        [
            'id' => 4,
            'name' => 'Apple MacBook Pro',
            'price' => 1499.99,
            'stock' => 5
        ],
    ];
    
    // Display data in HTML table
    if (count($products) > 0) {
        echo '<table>';
        echo '<tr><th>ID</th><th>Product Name</th><th>Price</th><th>Stock</th><th>Status</th></tr>';
        
        foreach ($products as $product) {
            echo '<tr>';
            echo '<td>' . $product['id'] . '</td>';
            echo '<td>' . $product['name'] . '</td>';
            echo '<td>$' . number_format($product['price'], 2) . '</td>';
            echo '<td>' . $product['stock'] . '</td>';
            
            // Conditional expression to display status
            if ($product['stock'] > 10) {
                echo '<td style="color: green;">In Stock</td>';
            } elseif ($product['stock'] > 0) {
                echo '<td style="color: orange;">Low Stock</td>';
            } else {
                echo '<td style="color: red;">Out of Stock</td>';
            }
            
            echo '</tr>';
        }
        
        echo '</table>';
    } else {
        echo '<p>No products available.</p>';
    }
    ?>
    
    <h2>Add Product Form</h2>
    <form method="post" action="">
        <div>
            <label for="name">Product Name:</label>
            <input type="text" id="name" name="name" required>
        </div>
        <div>
            <label for="price">Price:</label>
            <input type="number" id="price" name="price" step="0.01" required>
        </div>
        <div>
            <label for="stock">Stock:</label>
            <input type="number" id="stock" name="stock" required>
        </div>
        <div>
            <button type="submit">Add Product</button>
        </div>
    </form>
    
    <?php
    // Handle form submission
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        if (isset($_POST["name"]) && isset($_POST["price"]) && isset($_POST["stock"])) {
            $name = $_POST["name"];
            $price = $_POST["price"];
            $stock = $_POST["stock"];
            
            echo "<h3>Product Added:</h3>";
            echo "<p>Name: $name</p>";
            echo "<p>Price: $price</p>";
            echo "<p>Stock: $stock</p>";
            
            // In reality, you would add data to the database here
        }
    }
    ?>
</body>
</html>
```

### Form Handling with PHP

```php
<!DOCTYPE html>
<html>
<head>
    <title>Form Handling with PHP</title>
    <style>
        .error { color: red; }
        .success { color: green; }
        form { margin-bottom: 20px; }
        label { display: block; margin-top: 10px; }
    </style>
</head>
<body>
    <h1>Register Account</h1>
    
    <?php
    // Initialize error variables and data variables
    $nameErr = $emailErr = $passwordErr = "";
    $name = $email = $password = "";
    $formValid = true;
    
    // Check if form is submitted
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Check and retrieve name
        if (empty($_POST["name"])) {
            $nameErr = "Name is required";
            $formValid = false;
        } else {
            $name = test_input($_POST["name"]);
            // Check if name only contains letters and whitespace
            if (!preg_match("/^[a-zA-Z ]*$/", $name)) {
                $nameErr = "Only letters and white space allowed";
                $formValid = false;
            }
        }
        
        // Check and retrieve email
        if (empty($_POST["email"])) {
            $emailErr = "Email is required";
            $formValid = false;
        } else {
            $email = test_input($_POST["email"]);
            // Check if e-mail address is well-formed
            if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
                $emailErr = "Invalid email format";
                $formValid = false;
            }
        }
        
        // Check and retrieve password
        if (empty($_POST["password"])) {
            $passwordErr = "Password is required";
            $formValid = false;
        } else {
            $password = test_input($_POST["password"]);
            // Check password length
            if (strlen($password) < 6) {
                $passwordErr = "Password must be at least 6 characters";
                $formValid = false;
            }
        }
        
        // If form is valid, display info
        if ($formValid) {
            echo '<div class="success">';
            echo '<h3>Registration Successful!</h3>';
            echo '<p>Name: ' . $name . '</p>';
            echo '<p>Email: ' . $email . '</p>';
            echo '</div>';
            
            // In reality, you would save data to the database here
        }
    }
    
    // Function to sanitize input data
    function test_input($data) {
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }
    ?>
    
    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
        <div>
            <label for="name">Full Name:</label>
            <input type="text" id="name" name="name" value="<?php echo $name; ?>">
            <span class="error"><?php echo $nameErr; ?></span>
        </div>
        
        <div>
            <label for="email">Email:</label>
            <input type="text" id="email" name="email" value="<?php echo $email; ?>">
            <span class="error"><?php echo $emailErr; ?></span>
        </div>
        
        <div>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password">
            <span class="error"><?php echo $passwordErr; ?></span>
        </div>
        
        <div style="margin-top: 20px;">
            <input type="submit" value="Register">
        </div>
    </form>
</body>
</html>
```

## 🧪 FINAL PROJECT: Simple Product Management Page

### Project Description

Build a simple webpage that allows:

- Displaying a list of products
- Adding a new product
- Searching for products by name
- Filtering products by price

### Requirements

- Create a data structure to store products (PHP array).
- Design a UI to display the product list (table).
- Create a form to add a new product with fields: name, description, price, quantity.
- Implement search and filter functionality.
- Organize code in a clear, maintainable structure.
