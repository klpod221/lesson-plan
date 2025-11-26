---
prev:
  text: '🧩 OOP with PHP'
  link: '/PHP/Part2'
next:
  text: '🏗️ Frameworks & Applications'
  link: '/PHP/Part4'
---

# 📘 PART 3: ADVANCED PHP AND DATABASE CONNECTION

## 🎯 General Objectives

- Understand and apply methods to connect to databases in PHP.
- Build RESTful APIs with PHP.
- Master security issues and prevention methods.
- Learn how to optimize PHP applications.
- Apply advanced knowledge to build complete web applications.

## 🧑‍🏫 Lesson 12: Connecting and Working with Databases

### Connecting to MySQL

```php
<?php
// Connection info
$servername = "localhost";
$username = "root";
$password = "password";
$dbname = "mydb";

// Method 1: MySQLi (Object-oriented)
$mysqli = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}
echo "Connected successfully (MySQLi Object-oriented)<br>";

// Method 2: MySQLi (Procedural)
$conn = mysqli_connect($servername, $username, $password, $dbname);

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}
echo "Connected successfully (MySQLi Procedural)<br>";

// Method 3: PDO
try {
    $pdo = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    // Set the PDO error mode to exception
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "Connected successfully (PDO)<br>";
} catch(PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
}
?>
```

### Basic Queries

```php
<?php
// Assuming $mysqli connection exists

// 1. Queries with MySQLi (Object-oriented)
echo "<h3>MySQLi (Object-oriented)</h3>";

// Create table
$sql = "CREATE TABLE IF NOT EXISTS users (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(30) NOT NULL,
    lastname VARCHAR(30) NOT NULL,
    email VARCHAR(50),
    reg_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)";

if ($mysqli->query($sql) === TRUE) {
    echo "Table users created successfully<br>";
} else {
    echo "Error creating table: " . $mysqli->error . "<br>";
}

// Insert data
$sql = "INSERT INTO users (firstname, lastname, email)
VALUES ('John', 'Doe', 'john@example.com')";

if ($mysqli->query($sql) === TRUE) {
    echo "New record created successfully. Last inserted ID: " . $mysqli->insert_id . "<br>";
} else {
    echo "Error: " . $sql . "<br>" . $mysqli->error . "<br>";
}

// Select data
$sql = "SELECT id, firstname, lastname FROM users";
$result = $mysqli->query($sql);

if ($result->num_rows > 0) {
    echo "<table border='1'><tr><th>ID</th><th>Name</th></tr>";
    // output data of each row
    while($row = $result->fetch_assoc()) {
        echo "<tr><td>".$row["id"]."</td><td>".$row["firstname"]." ".$row["lastname"]."</td></tr>";
    }
    echo "</table>";
} else {
    echo "0 results<br>";
}

// Update data
$sql = "UPDATE users SET lastname='Smith' WHERE id=1";

if ($mysqli->query($sql) === TRUE) {
    echo "Record updated successfully<br>";
} else {
    echo "Error updating record: " . $mysqli->error . "<br>";
}

// Delete data
$sql = "DELETE FROM users WHERE id=1";

if ($mysqli->query($sql) === TRUE) {
    echo "Record deleted successfully<br>";
} else {
    echo "Error deleting record: " . $mysqli->error . "<br>";
}

// Close connection
$mysqli->close();
?>
```

### Processing Query Results

```php
<?php
// PDO Connection
try {
    $pdo = new PDO("mysql:host=localhost;dbname=mydb", "root", "password");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Insert multiple records
    $pdo->exec("INSERT INTO users (firstname, lastname, email) VALUES
                ('Jane', 'Doe', 'jane@example.com'),
                ('Mike', 'Johnson', 'mike@example.com'),
                ('Sarah', 'Williams', 'sarah@example.com')");

    echo "Multiple records inserted<br>";

    // Prepared Statement with Parameters
    $stmt = $pdo->prepare("SELECT * FROM users WHERE lastname = ?");
    $stmt->execute(['Doe']);
    echo "<h4>Users with lastname 'Doe':</h4>";

    // Method 1: Fetch row by row
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo "Name: {$row['firstname']} {$row['lastname']}, Email: {$row['email']}<br>";
    }

    // Method 2: Fetch all rows
    $stmt = $pdo->prepare("SELECT * FROM users WHERE lastname LIKE ?");
    $stmt->execute(['%i%']); // Lastname containing 'i'

    echo "<h4>Users with 'i' in lastname:</h4>";
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);

    foreach ($users as $user) {
        echo "Name: {$user['firstname']} {$user['lastname']}, Email: {$user['email']}<br>";
    }

    // Method 3: Fetch into object
    $stmt = $pdo->query("SELECT * FROM users LIMIT 2");
    $stmt->setFetchMode(PDO::FETCH_OBJ);

    echo "<h4>First two users (as objects):</h4>";
    while ($user = $stmt->fetch()) {
        echo "Name: {$user->firstname} {$user->lastname}, Email: {$user->email}<br>";
    }
} catch(PDOException $e) {
    echo "Error: " . $e->getMessage();
}
?>
```

### Transactions

```php
<?php
try {
    $pdo = new PDO("mysql:host=localhost;dbname=mydb", "root", "password");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Start transaction
    $pdo->beginTransaction();

    // SQL Statements
    $pdo->exec("INSERT INTO users (firstname, lastname, email)
                VALUES ('Transaction', 'Test', 'transaction@example.com')");
    $pdo->exec("UPDATE users SET email='updated@example.com' WHERE lastname='Johnson'");

    // Commit transaction
    $pdo->commit();

    echo "Transaction completed successfully<br>";
} catch(PDOException $e) {
    // Rollback transaction on error
    $pdo->rollBack();
    echo "Transaction failed: " . $e->getMessage();
}
?>
```

## 🧑‍🏫 Lesson 13: PHP Data Objects (PDO)

### Introduction to PDO

- PDO (PHP Data Objects) is an extension that provides a consistent interface for accessing databases in PHP.
- Advantages of PDO:
  - Supports multiple databases (MySQL, PostgreSQL, SQLite, Oracle, SQL Server, ...).
  - Uses prepared statements to prevent SQL Injection.
  - Better error handling with exceptions.
  - Consistent interface, database independent.

```php
<?php
// Supported drivers
$drivers = PDO::getAvailableDrivers();
echo "Available PDO drivers: " . implode(', ', $drivers) . "<br>";

// Connect to different databases
try {
    // MySQL
    $mysqlPdo = new PDO('mysql:host=localhost;dbname=mydb;charset=utf8mb4', 'username', 'password');

    // SQLite
    $sqlitePdo = new PDO('sqlite:/path/to/database.sqlite');

    // PostgreSQL
    $pgPdo = new PDO('pgsql:host=localhost;port=5432;dbname=mydb;', 'username', 'password');

    // SQL Server
    $mssqlPdo = new PDO('sqlsrv:Server=localhost;Database=mydb', 'username', 'password');
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}
?>
```

### Configuring PDO and Error Handling

```php
<?php
try {
    $pdo = new PDO('mysql:host=localhost;dbname=mydb;charset=utf8mb4', 'username', 'password', [
        // Configure PDO attributes
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,      // Report errors via exceptions
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, // Return data as associative array
        PDO::ATTR_EMULATE_PREPARES => false,              // Disable emulated prepared statements
        PDO::MYSQL_ATTR_FOUND_ROWS => true                // Return found rows instead of affected rows
    ]);

    // Set attributes after connection
    $pdo->setAttribute(PDO::ATTR_CASE, PDO::CASE_LOWER); // Lowercase column names
} catch (PDOException $e) {
    // Error Handling
    echo "Connection failed: " . $e->getMessage() . "<br>";
    echo "Error code: " . $e->getCode() . "<br>";

    // Detailed error info
    if ($e->errorInfo) {
        echo "SQLSTATE error code: " . $e->errorInfo[0] . "<br>";
        echo "Driver-specific error code: " . $e->errorInfo[1] . "<br>";
        echo "Driver-specific error message: " . $e->errorInfo[2] . "<br>";
    }

    // Log error to file
    error_log("Database error: " . $e->getMessage(), 3, "errors.log");

    // Show user-friendly message
    die("Sorry, a database error occurred. Our team has been notified.");
}
?>
```

### Prepared Statements

```php
<?php
try {
    $pdo = new PDO('mysql:host=localhost;dbname=mydb', 'username', 'password');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Example 1: Prepared Statement with named parameters
    $stmt = $pdo->prepare("SELECT * FROM users WHERE firstname = :fname AND lastname = :lname");

    // Bind parameters
    $stmt->bindParam(':fname', $firstname, PDO::PARAM_STR);
    $stmt->bindParam(':lname', $lastname, PDO::PARAM_STR);

    // Set values
    $firstname = "John";
    $lastname = "Doe";

    // Execute
    $stmt->execute();
    $users = $stmt->fetchAll();

    // Display results
    echo "<h4>Users found (Example 1):</h4>";
    foreach ($users as $user) {
        echo "{$user['firstname']} {$user['lastname']} - {$user['email']}<br>";
    }

    // Example 2: Bind values directly in execute
    $stmt = $pdo->prepare("SELECT * FROM users WHERE email LIKE :email");
    $stmt->execute([':email' => '%example.com%']);

    $users = $stmt->fetchAll();
    echo "<h4>Users with example.com email (Example 2):</h4>";
    foreach ($users as $user) {
        echo "{$user['firstname']} {$user['lastname']} - {$user['email']}<br>";
    }

    // Example 3: Using positional parameters
    $stmt = $pdo->prepare("INSERT INTO users (firstname, lastname, email) VALUES (?, ?, ?)");
    $stmt->execute(["Alice", "Smith", "alice@example.com"]);

    echo "New user added (Example 3). ID: " . $pdo->lastInsertId() . "<br>";

    // Example 4: Reusing prepared statement
    $stmt = $pdo->prepare("INSERT INTO users (firstname, lastname, email) VALUES (:fname, :lname, :email)");

    // Execute multiple times with different data
    $users = [
        ['fname' => 'Robert', 'lname' => 'Johnson', 'email' => 'robert@example.com'],
        ['fname' => 'Lisa', 'lname' => 'Brown', 'email' => 'lisa@example.com'],
        ['fname' => 'Michael', 'lname' => 'Davis', 'email' => 'michael@example.com']
    ];

    foreach ($users as $user) {
        $stmt->execute($user);
        echo "Added user: {$user['fname']} {$user['lname']}<br>";
    }
} catch(PDOException $e) {
    die("Error: " . $e->getMessage());
}
?>
```

### Advanced Queries with PDO

```php
<?php
try {
    $pdo = new PDO('mysql:host=localhost;dbname=mydb', 'username', 'password');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Example 1: JOIN query
    $stmt = $pdo->prepare("
        SELECT o.id as order_id, o.order_date, u.firstname, u.lastname, u.email
        FROM orders o
        JOIN users u ON o.user_id = u.id
        WHERE o.order_date > :date
        ORDER BY o.order_date DESC
    ");

    $date = '2023-01-01';
    $stmt->execute([':date' => $date]);

    echo "<h4>Recent Orders:</h4>";
    echo "<table border='1'>
        <tr><th>Order ID</th><th>Date</th><th>Customer</th><th>Email</th></tr>";

    while ($row = $stmt->fetch()) {
        echo "<tr>
            <td>{$row['order_id']}</td>
            <td>{$row['order_date']}</td>
            <td>{$row['firstname']} {$row['lastname']}</td>
            <td>{$row['email']}</td>
        </tr>";
    }

    echo "</table>";

    // Example 2: GROUP BY and aggregate functions
    $stmt = $pdo->query("
        SELECT
            YEAR(order_date) as year,
            MONTH(order_date) as month,
            COUNT(*) as order_count,
            SUM(total_amount) as total_sales
        FROM orders
        GROUP BY YEAR(order_date), MONTH(order_date)
        ORDER BY year DESC, month DESC
    ");

    echo "<h4>Monthly Sales Summary:</h4>";
    echo "<table border='1'>
        <tr><th>Year</th><th>Month</th><th>Orders</th><th>Total Sales</th></tr>";

    while ($row = $stmt->fetch()) {
        $monthName = date('F', mktime(0, 0, 0, $row['month'], 1));
        echo "<tr>
            <td>{$row['year']}</td>
            <td>{$monthName}</td>
            <td>{$row['order_count']}</td>
            <td>\${$row['total_sales']}</td>
        </tr>";
    }

    echo "</table>";

    // Example 3: Subqueries and IN operator
    $stmt = $pdo->prepare("
        SELECT * FROM users
        WHERE id IN (
            SELECT DISTINCT user_id FROM orders
            WHERE total_amount > :min_amount
        )
        ORDER BY lastname, firstname
    ");

    $stmt->execute([':min_amount' => 1000]);

    echo "<h4>Premium Customers (Orders > $1000):</h4>";
    while ($row = $stmt->fetch()) {
        echo "{$row['firstname']} {$row['lastname']} - {$row['email']}<br>";
    }

} catch(PDOException $e) {
    die("Error: " . $e->getMessage());
}
?>
```

## 🧑‍🏫 Lesson 14: RESTful API with PHP

### Introduction to REST API

RESTful API is a software architectural style used to design web services:

- REST = Representational State Transfer
- Uses HTTP methods (GET, POST, PUT, DELETE) to manipulate resources.
- Resources are identified by URIs (Uniform Resource Identifiers).
- Usually returns data in JSON or XML format.
- Stateless: each request contains enough information to be processed.

```php
<?php
// Set basic headers for REST API
header("Content-Type: application/json; charset=UTF-8");

// Define API response structure
function sendResponse($data, $statusCode = 200) {
    http_response_code($statusCode);
    echo json_encode($data);
    exit;
}

// Example response
$data = [
    "message" => "Welcome to our REST API",
    "version" => "1.0",
    "documentation" => "https://example.com/api-docs",
];

sendResponse($data);
?>
```

### Building a Basic REST API

```php
<?php
// api/index.php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Origin: *");

// Database Connection
try {
    $pdo = new PDO('mysql:host=localhost;dbname=api_db', 'username', 'password');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    sendResponse(["error" => "Database connection failed: " . $e->getMessage()], 500);
}

// Helper functions
function sendResponse($data, $statusCode = 200) {
    http_response_code($statusCode);
    echo json_encode($data);
    exit;
}

// Get HTTP method and request URI
$method = $_SERVER['REQUEST_METHOD'];
$request = explode('/', trim($_SERVER['REQUEST_URI'], '/'));

// URL Pattern: /api/resource/id
$resource = isset($request[1]) ? $request[1] : null;
$id = isset($request[2]) ? $request[2] : null;

// Handle API endpoints
switch ($resource) {
    case 'products':
        handleProducts($method, $id, $pdo);
        break;

    case 'users':
        handleUsers($method, $id, $pdo);
        break;

    default:
        sendResponse(["error" => "Invalid resource"], 404);
}

// Handler for "products" resource
function handleProducts($method, $id, $pdo) {
    switch ($method) {
        case 'GET':
            if ($id) {
                // GET /api/products/{id} - Get single product
                $stmt = $pdo->prepare("SELECT * FROM products WHERE id = ?");
                $stmt->execute([$id]);
                $product = $stmt->fetch(PDO::FETCH_ASSOC);

                if ($product) {
                    sendResponse($product);
                } else {
                    sendResponse(["error" => "Product not found"], 404);
                }
            } else {
                // GET /api/products - Get product list
                $stmt = $pdo->query("SELECT * FROM products");
                $products = $stmt->fetchAll(PDO::FETCH_ASSOC);
                sendResponse($products);
            }
            break;

        case 'POST':
            // POST /api/products - Add new product
            $data = json_decode(file_get_contents("php://input"), true);

            // Validate data
            if (!isset($data['name']) || !isset($data['price'])) {
                sendResponse(["error" => "Missing required fields"], 400);
            }

            $stmt = $pdo->prepare("INSERT INTO products (name, price, description) VALUES (?, ?, ?)");
            $stmt->execute([
                $data['name'],
                $data['price'],
                isset($data['description']) ? $data['description'] : null
            ]);

            sendResponse([
                "message" => "Product created",
                "id" => $pdo->lastInsertId()
            ], 201);
            break;

        case 'PUT':
            // PUT /api/products/{id} - Update product
            if (!$id) {
                sendResponse(["error" => "ID is required"], 400);
            }

            $data = json_decode(file_get_contents("php://input"), true);

            // Check if product exists
            $check = $pdo->prepare("SELECT id FROM products WHERE id = ?");
            $check->execute([$id]);
            if (!$check->fetch()) {
                sendResponse(["error" => "Product not found"], 404);
            }

            // Build update query based on provided fields
            $fields = [];
            $values = [];

            foreach (['name', 'price', 'description'] as $field) {
                if (isset($data[$field])) {
                    $fields[] = "$field = ?";
                    $values[] = $data[$field];
                }
            }

            if (empty($fields)) {
                sendResponse(["error" => "No fields to update"], 400);
            }

            $values[] = $id; // Add ID for WHERE clause
            $sql = "UPDATE products SET " . implode(", ", $fields) . " WHERE id = ?";

            $stmt = $pdo->prepare($sql);
            $stmt->execute($values);

            sendResponse(["message" => "Product updated", "id" => $id]);
            break;

        case 'DELETE':
            // DELETE /api/products/{id} - Delete product
            if (!$id) {
                sendResponse(["error" => "ID is required"], 400);
            }

            $stmt = $pdo->prepare("DELETE FROM products WHERE id = ?");
            $stmt->execute([$id]);

            if ($stmt->rowCount() > 0) {
                sendResponse(["message" => "Product deleted", "id" => $id]);
            } else {
                sendResponse(["error" => "Product not found"], 404);
            }
            break;

        default:
            sendResponse(["error" => "Method not allowed"], 405);
    }
}

// Handler for "users" resource (similar to products)
function handleUsers($method, $id, $pdo) {
    // Implementation similar to handleProducts
    sendResponse(["message" => "Users endpoint not fully implemented yet"]);
}
?>
```

### API Authentication with JWT

- JWT (JSON Web Token) is an open standard (RFC 7519) that defines a compact and self-contained way for securely transmitting information between parties as a JSON object.

```php
<?php
// api/auth.php

// Include Firebase JWT library if using Composer
// require 'vendor/autoload.php';
// use Firebase\JWT\JWT;

// Simple JWT Implementation without external library
class JWTHandler {
    private $secretKey;
    private $issuedAt;
    private $expire;

    public function __construct($secretKey = 'your-secret-key') {
        $this->secretKey = $secretKey;
        $this->issuedAt = time();
        $this->expire = $this->issuedAt + 3600; // 1 hour
    }

    public function generateToken($userData) {
        $payload = [
            'iat' => $this->issuedAt,    // Issued at time
            'iss' => 'PHP_API',          // Issuer
            'exp' => $this->expire,      // Expire time
            'user' => $userData          // User data
        ];

        return $this->encodeToken($payload);
    }

    private function encodeToken($payload) {
        $header = [
            'typ' => 'JWT',
            'alg' => 'HS256'
        ];

        // Encode Header
        $base64UrlHeader = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode(json_encode($header)));

        // Encode Payload
        $base64UrlPayload = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode(json_encode($payload)));

        // Create Signature
        $signature = hash_hmac('sha256', $base64UrlHeader . "." . $base64UrlPayload, $this->secretKey, true);
        $base64UrlSignature = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($signature));

        // Create JWT
        $jwt = $base64UrlHeader . "." . $base64UrlPayload . "." . $base64UrlSignature;

        return $jwt;
    }

    public function validateToken($jwt) {
        try {
            $tokenParts = explode('.', $jwt);
            if (count($tokenParts) != 3) {
                return false;
            }

            $header = base64_decode(str_replace(['-', '_'], ['+', '/'], $tokenParts[0]));
            $payload = base64_decode(str_replace(['-', '_'], ['+', '/'], $tokenParts[1]));
            $signatureProvided = $tokenParts[2];

            // Check the expiration time
            $payloadObj = json_decode($payload);
            if (isset($payloadObj->exp) && $payloadObj->exp < time()) {
                return false;
            }

            // Verify signature
            $base64UrlHeader = $tokenParts[0];
            $base64UrlPayload = $tokenParts[1];
            $signature = hash_hmac('sha256', $base64UrlHeader . "." . $base64UrlPayload, $this->secretKey, true);
            $base64UrlSignature = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($signature));

            if ($base64UrlSignature !== $signatureProvided) {
                return false;
            }

            return json_decode($payload, true);
        } catch (Exception $e) {
            return false;
        }
    }
}

// API endpoint for authentication
header("Content-Type: application/json; charset=UTF-8");

// Handle login request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);

    // Validate credentials (replace with database check)
    if (isset($data['username']) && isset($data['password'])) {
        // In a real application, verify against database
        if ($data['username'] === 'admin' && $data['password'] === 'password123') {
            $jwt = new JWTHandler();
            $token = $jwt->generateToken([
                'id' => 1,
                'username' => $data['username'],
                'role' => 'admin'
            ]);

            echo json_encode([
                'status' => 'success',
                'message' => 'Login successful',
                'token' => $token
            ]);
        } else {
            http_response_code(401);
            echo json_encode([
                'status' => 'error',
                'message' => 'Invalid credentials'
            ]);
        }
    } else {
        http_response_code(400);
        echo json_encode([
            'status' => 'error',
            'message' => 'Username and password required'
        ]);
    }
} else {
    http_response_code(405);
    echo json_encode([
        'status' => 'error',
        'message' => 'Method not allowed'
    ]);
}
?>
```

### API Middleware Protection

```php
<?php
// api/middleware/auth.php

require_once 'api/auth.php';

class AuthMiddleware {
    private $jwt;

    public function __construct() {
        $this->jwt = new JWTHandler();
    }

    public function authenticate() {
        // Get authorization header
        $headers = getallheaders();
        $authHeader = isset($headers['Authorization']) ? $headers['Authorization'] : '';

        // Check for Bearer token
        if (!$authHeader || !preg_match('/Bearer\s(\S+)/', $authHeader, $matches)) {
            http_response_code(401);
            echo json_encode([
                'status' => 'error',
                'message' => 'Unauthorized: No token provided'
            ]);
            exit;
        }

        $token = $matches[1];
        $payload = $this->jwt->validateToken($token);

        if (!$payload) {
            http_response_code(401);
            echo json_encode([
                'status' => 'error',
                'message' => 'Unauthorized: Invalid token'
            ]);
            exit;
        }

        // Add user data to request for further use
        $_REQUEST['user'] = $payload['user'];
        return true;
    }

    public function hasRole($requiredRole) {
        if (!isset($_REQUEST['user']) || !isset($_REQUEST['user']['role'])) {
            return false;
        }

        return $_REQUEST['user']['role'] === $requiredRole;
    }
}

// Usage in API endpoints
// $auth = new AuthMiddleware();
// $auth->authenticate();
//
// if ($auth->hasRole('admin')) {
//     // Proceed with admin actions
// } else {
//     http_response_code(403);
//     echo json_encode(['status' => 'error', 'message' => 'Forbidden']);
//     exit;
// }
?>
```

## 🧑‍🏫 Lesson 15: Security in PHP

### Preventing SQL Injection

```php
<?php
// Examples of SQL Injection and prevention

// BAD: Vulnerable to SQL Injection
$username = $_POST['username'];
$query = "SELECT * FROM users WHERE username = '$username'";
// Attacker input: admin' --
// Query becomes: SELECT * FROM users WHERE username = 'admin' --'

// GOOD: Using Prepared Statements
$pdo = new PDO('mysql:host=localhost;dbname=mydb', 'username', 'password');
$stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
$stmt->execute([$_POST['username']]);
$user = $stmt->fetch();

// GOOD: Using Prepared Statements with named parameters
$stmt = $pdo->prepare("SELECT * FROM users WHERE username = :username");
$stmt->bindParam(':username', $_POST['username'], PDO::PARAM_STR);
$stmt->execute();
$user = $stmt->fetch();

// GOOD: Using MySQLi Prepared Statements
$mysqli = new mysqli('localhost', 'username', 'password', 'mydb');
$stmt = $mysqli->prepare("SELECT * FROM users WHERE username = ?");
$stmt->bind_param("s", $_POST['username']);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();
?>
```

### Preventing XSS (Cross-Site Scripting)

```php
<?php
// Examples of XSS and prevention

// BAD: Vulnerable to XSS
$name = $_GET['name'];
echo "Hello, $name!";
// Attacker input: <script>alert('XSS')</script>

// GOOD: Escaping output
$name = htmlspecialchars($_GET['name'], ENT_QUOTES, 'UTF-8');
echo "Hello, $name!";

// Filter input before processing
$email = filter_input(INPUT_POST, 'email', FILTER_VALIDATE_EMAIL);
if ($email) {
    echo "Valid email: $email";
} else {
    echo "Invalid email provided";
}

// Content Security Policy (CSP)
// Add to HTTP header
header("Content-Security-Policy: default-src 'self'; script-src 'self' https://trusted-cdn.com;");
?>
```

### Preventing CSRF (Cross-Site Request Forgery)

```php
<?php
// Anti-CSRF Token implementation
session_start();

function generateCSRFToken() {
    if (!isset($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }

    return $_SESSION['csrf_token'];
}

function validateCSRFToken($token) {
    if (!isset($_SESSION['csrf_token']) || $token !== $_SESSION['csrf_token']) {
        return false;
    }

    return true;
}

// In form
$csrf_token = generateCSRFToken();
echo '<form method="post">';
echo '<input type="hidden" name="csrf_token" value="' . $csrf_token . '">';
echo '<input type="text" name="username" placeholder="Username">';
echo '<button type="submit">Submit</button>';
echo '</form>';

// On form processing
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!isset($_POST['csrf_token']) || !validateCSRFToken($_POST['csrf_token'])) {
        die('CSRF token validation failed');
    }

    // Process form normally
    echo "Form processed successfully";
}
?>
```

### Password Protection

```php
<?php
// Password hashing and verifying examples

// NEVER store passwords in plain text!
// BAD:
$password = $_POST['password'];
// $query = "INSERT INTO users (username, password) VALUES (?, ?)";
// $stmt->execute([$username, $password]);

// GOOD: Hash password before storage
$password = $_POST['password'];
$hash = password_hash($password, PASSWORD_DEFAULT);
// $query = "INSERT INTO users (username, password_hash) VALUES (?, ?)";
// $stmt->execute([$username, $hash]);

// Verify password when user logs in
function verifyUserPassword($username, $password) {
    // Get user from database
    $pdo = new PDO('mysql:host=localhost;dbname=mydb', 'username', 'password');
    $stmt = $pdo->prepare("SELECT password_hash FROM users WHERE username = ?");
    $stmt->execute([$username]);
    $user = $stmt->fetch();

    if ($user && password_verify($password, $user['password_hash'])) {
        return true; // Password matches
    }

    return false; // Either user not found or password doesn't match
}

// Example usage
if (verifyUserPassword('john_doe', $_POST['password'])) {
    echo "Login successful!";
    // Start session, etc.
} else {
    echo "Invalid username or password";
}

// Password policy enforcement
function isValidPassword($password) {
    // At least 8 characters
    if (strlen($password) < 8) {
        return false;
    }

    // At least one uppercase letter
    if (!preg_match('/[A-Z]/', $password)) {
        return false;
    }

    // At least one lowercase letter
    if (!preg_match('/[a-z]/', $password)) {
        return false;
    }

    // At least one number
    if (!preg_match('/[0-9]/', $password)) {
        return false;
    }

    // At least one special character
    if (!preg_match('/[^A-Za-z0-9]/', $password)) {
        return false;
    }

    return true;
}

// Example usage
if (isValidPassword($_POST['password'])) {
    echo "Password meets security requirements";
} else {
    echo "Password must be at least 8 characters and include uppercase, lowercase, number, and special character";
}
?>
```

### File Upload Security

```php
<?php
// Secure file upload

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['file'])) {
    $file = $_FILES['file'];

    // 1. Verify file size
    $maxFileSize = 2 * 1024 * 1024; // 2MB
    if ($file['size'] > $maxFileSize) {
        die('File too large (max 2MB)');
    }

    // 2. Verify file type/extension
    $allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
    $fileInfo = finfo_open(FILEINFO_MIME_TYPE);
    $uploadedFileType = finfo_file($fileInfo, $file['tmp_name']);
    finfo_close($fileInfo);

    if (!in_array($uploadedFileType, $allowedTypes)) {
        die('Invalid file type. Only JPEG, PNG and GIF allowed');
    }

    // 3. Verify file extension
    $fileExtension = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
    $allowedExtensions = ['jpg', 'jpeg', 'png', 'gif'];

    if (!in_array($fileExtension, $allowedExtensions)) {
        die('Invalid file extension. Only JPG, JPEG, PNG and GIF allowed');
    }

    // 4. Create safe filename
    $newFilename = md5(time() . rand(1000, 9999)) . '.' . $fileExtension;

    // 5. Use a separate directory for uploads
    $uploadDir = 'uploads/';
    if (!file_exists($uploadDir)) {
        mkdir($uploadDir, 0755, true);
    }

    // 6. Move file to final location
    $destination = $uploadDir . $newFilename;
    if (move_uploaded_file($file['tmp_name'], $destination)) {
        echo "File uploaded successfully: $destination";
    } else {
        echo "Error uploading file";
    }

    // 7. For extra security, you might want to check contents (for images)
    // Check if file is really an image
    if (!getimagesize($destination)) {
        // If not a real image, delete it and return error
        unlink($destination);
        die('Invalid image file');
    }
}
?>

<form method="post" enctype="multipart/form-data">
    <input type="file" name="file">
    <button type="submit">Upload</button>
</form>
```

## 🧑‍🏫 Lesson 16: Caching and Optimization

### Output Buffering and Page Caching

```php
<?php
// Output buffering for page caching

// Create page cache function
function cachePage($cacheDuration = 3600) {
    $cacheFile = 'cache/' . md5($_SERVER['REQUEST_URI']) . '.html';

    // Check if cache exists and is fresh
    if (file_exists($cacheFile) && time() - filemtime($cacheFile) < $cacheDuration) {
        readfile($cacheFile);
        exit;
    }

    // Start output buffering if cache doesn't exist or expired
    ob_start();
}

function endCache() {
    $cacheFile = 'cache/' . md5($_SERVER['REQUEST_URI']) . '.html';

    // Create cache directory if not exists
    if (!is_dir('cache')) {
        mkdir('cache', 0755, true);
    }

    // Save output to cache file
    $cachedContent = ob_get_contents();
    file_put_contents($cacheFile, $cachedContent);

    // Send content to browser
    ob_end_flush();
}

// Use cache
cachePage();

// Content of your page
echo "<h1>Welcome to the cached page</h1>";
echo "<p>This content is generated at: " . date('Y-m-d H:i:s') . "</p>";

// Database queries, logic, etc...
sleep(1); // Simulate processing time

echo "<p>This page will be cached for 1 hour.</p>";

// End and save cache
endCache();
?>
```

### Memcached

- Memcached is a distributed memory caching system used to speed up dynamic database-driven websites by caching data and objects in RAM.

```bash
# Install Memcached on Ubuntu
sudo apt-get update
sudo apt-get install memcached libmemcached-tools
```

```bash
# Start Memcached
memcached -m 64 -u nobody -p 11211 -vv
```

```php
<?php
// Use Memcached for data caching

// Initialize Memcached connection
$memcached = new Memcached();
$memcached->addServer('localhost', 11211);

// Function to get data with cache
function getCachedData($key, $ttl = 600, $dataCallback) {
    global $memcached;

    // Try to get from cache
    $cachedData = $memcached->get($key);

    if ($memcached->getResultCode() === Memcached::RES_SUCCESS) {
        // Data found in cache
        return $cachedData;
    }

    // Data not in cache, call callback to generate data
    $data = $dataCallback();

    // Save to cache
    $memcached->set($key, $data, $ttl);

    return $data;
}

// Usage examples:

// 1. Caching database query results
function getProductsFromDatabase() {
    // Simulate slow DB query
    sleep(2);

    return [
        ['id' => 1, 'name' => 'Product 1', 'price' => 99.99],
        ['id' => 2, 'name' => 'Product 2', 'price' => 149.99],
        ['id' => 3, 'name' => 'Product 3', 'price' => 199.99]
    ];
}

$products = getCachedData('products_list', 300, 'getProductsFromDatabase');
echo "<pre>";
print_r($products);
echo "</pre>";

// 2. Caching API call results
function getWeatherData() {
    // Simulate external API call
    sleep(1);

    return [
        'city' => 'New York',
        'temperature' => 22,
        'condition' => 'Sunny',
        'updated' => date('Y-m-d H:i:s')
    ];
}

$weather = getCachedData('weather_nyc', 1800, 'getWeatherData');
echo "<pre>";
print_r($weather);
echo "</pre>";

// 3. Delete cache when data changes
function updateProduct($productId, $data) {
    // Update database

    // Delete related cache
    global $memcached;
    $memcached->delete('products_list');
    $memcached->delete('product_' . $productId);

    return true;
}

// 4. Increment/Decrement counter
$memcached->increment('page_views', 1, 0); // Increase, init with 0 if not exists
$views = $memcached->get('page_views');
echo "Page views: $views<br>";
?>
```

### Redis

- Redis is an open-source, in-memory data structure store, used as a database, cache, and message broker. Supports strings, hashes, lists, sets, sorted sets.

```bash
# Install Redis on Ubuntu
sudo apt-get update
sudo apt-get install redis-server
```

```bash
# Start Redis
redis-server
```

```php
<?php
// Use Redis for caching and data storage

// Connect to Redis
$redis = new Redis();
$redis->connect('127.0.0.1', 6379);

// Set simple value
$redis->set('welcome_message', 'Hello from Redis!');
echo $redis->get('welcome_message') . "<br>";

// Set value with TTL
$redis->setex('session_token', 3600, 'user123_token_value');

// Check remaining TTL
$ttl = $redis->ttl('session_token');
echo "Token expires in $ttl seconds<br>";

// Store hash (object)
$redis->hMset('user:1001', [
    'username' => 'johndoe',
    'email' => 'john@example.com',
    'visits' => 5
]);

// Get all hash fields
$user = $redis->hGetAll('user:1001');
echo "User data: ";
print_r($user);
echo "<br>";

// Increment counter
$redis->hIncrBy('user:1001', 'visits', 1);
$visits = $redis->hGet('user:1001', 'visits');
echo "User visits: $visits<br>";

// Store list
$redis->rPush('recent_products', 'product:1001');
$redis->rPush('recent_products', 'product:1002');
$redis->rPush('recent_products', 'product:1003');
$redis->lTrim('recent_products', 0, 9);  // Keep last 10 products

// Get whole list
$recentProducts = $redis->lRange('recent_products', 0, -1);
echo "Recent products: ";
print_r($recentProducts);
echo "<br>";

// Store set (unique items)
$redis->sAdd('user:1001:roles', 'editor', 'subscriber');
$redis->sAdd('user:1002:roles', 'admin', 'editor');

// Check membership
$isEditor = $redis->sIsMember('user:1001:roles', 'editor') ? 'Yes' : 'No';
echo "Is user 1001 an editor? $isEditor<br>";

// Set Intersection
$commonRoles = $redis->sInter('user:1001:roles', 'user:1002:roles');
echo "Common roles: ";
print_r($commonRoles);
echo "<br>";

// Use Redis for rate limiting
$ip = $_SERVER['REMOTE_ADDR'];
$rateKey = "rate:$ip:".floor(time() / 60); // Key for current minute

// Allow 10 requests per minute
$requests = $redis->incr($rateKey);
$redis->expire($rateKey, 70); // Expire after 70 seconds

if ($requests > 10) {
    http_response_code(429);
    echo "Too many requests";
    exit;
}

echo "Request $requests of 10 allowed per minute<br>";

// Redis Pub/Sub (in a real app, this would be in separate scripts)
if (false) { // Disable for this example
    // Publisher:
    $redis->publish('notifications', json_encode([
        'type' => 'new_message',
        'user_id' => 1001,
        'message' => 'Hello Redis!'
    ]));

    // Subscriber:
    $redis->subscribe(['notifications'], function ($redis, $channel, $message) {
        echo "Received $message on channel $channel";
    });
}

// Pipeline for sending multiple commands
$redis->multi();
$redis->set('pipeline_test', 'value1');
$redis->incr('counter');
$redis->lPush('mylist', 'value2');
$responses = $redis->exec();

echo "Pipeline responses: ";
print_r($responses);
?>
```

### Optimizing PHP Code

```php
<?php
// PHP Optimization Tips

// 1. Use built-in functions instead of manual loops
$numbers = range(1, 1000);

// Bad: Manual iteration
$sum = 0;
foreach ($numbers as $number) {
    $sum += $number;
}

// Good: Use built-in function
$sum = array_sum($numbers);

// 2. Use single quotes when string interpolation is not needed
$name = 'John';

// Slower
$greeting = "Hello $name";

// Faster (when no variables are needed)
$hello = 'Hello ';
$greeting = $hello . $name;

// 3. Avoid unnecessary function calls in loops
$arr = range(1, 1000);
$count = count($arr);

// Bad
for ($i = 0; $i < count($arr); $i++) {
    // count($arr) is called in each iteration
}

// Good
for ($i = 0; $i < $count; $i++) {
    // count() called only once
}

// 4. Use isset() instead of array_key_exists() for checking array keys
$array = ['key' => 'value', 'zero' => 0];

// Slower
if (array_key_exists('key', $array)) {
    // do something
}

// Faster
if (isset($array['key'])) {
    // do something
}

// Note: isset() returns false if the value is NULL
// array_key_exists() will return true even if value is NULL

// 5. Use foreach instead of for for arrays
$array = range(1, 1000);

// Slower
for ($i = 0; $i < $count; $i++) {
    echo $array[$i];
}

// Faster
foreach ($array as $value) {
    echo $value;
}

// 6. Use === instead of == when possible
$a = 0;
$b = '0';

// Slower (and potentially dangerous)
if ($a == $b) {
    // This will be true
}

// Faster and safer
if ($a === $b) {
    // This will be false
}

// 7. Use implode() instead of multiple concatenations
$array = ['Hello', 'World', 'from', 'PHP'];

// Slower
$string = '';
foreach ($array as $word) {
    $string .= $word . ' ';
}

// Faster
$string = implode(' ', $array);

// 8. Avoid unnecessary regex
$email = 'user@example.com';

// Slower
if (preg_match('/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/', $email)) {
    // Valid email
}

// Faster (when basic validation is enough)
if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
    // Valid email
}

// 9. Use strict comparisons in array functions
$numbers = [1, 2, '3', 4, '5'];

// Without strict comparison
$filtered = array_filter($numbers, function($number) {
    return $number > 2;
}); // Returns [3 => 4, 4 => '5']

// With strict comparison (better performance)
$filtered = array_filter($numbers, function($number) {
    return $number > 2 && is_int($number);
}); // Returns only [3 => 4]
?>
```

## 🧪 FINAL PROJECT: Blog API System

### Project Description

Build a complete RESTful API for a blog application, using security techniques and performance optimization.

### Requirements

1. **Design RESTful API for the following resources**:

   - Posts
   - Comments
   - Users
   - Categories

2. **Implement Features**:

   - User authentication using JWT.
   - Authorization: Admin, Author, Reader.
   - CRUD operations for each resource.
   - Search and filter data.
   - Pagination and sorting.
   - File upload (for post images).

3. **API Security**:

   - Use HTTPS.
   - Rate limiting.
   - Validate input.
   - Prevent SQL Injection, XSS.
   - Protect routes requiring admin privileges.

4. **Performance Optimization**:
   - Caching (Redis or Memcached).
   - Proper database indexing.
   - Lazy loading for relationships.
   - Compression of response data.

### Suggested Project Structure

```text
blog-api/
├── api/
│   ├── index.php               # Main entry point
│   ├── config/
│   │   ├── database.php        # Database connection
│   │   └── config.php          # General configuration
│   ├── middleware/
│   │   ├── auth.php            # Authentication middleware
│   │   ├── rate_limit.php      # Rate limiting middleware
│   │   └── cors.php            # CORS middleware
│   ├── controllers/
│   │   ├── PostController.php
│   │   ├── CommentController.php
│   │   ├── UserController.php
│   │   └── CategoryController.php
│   ├── models/
│   │   ├── Post.php
│   │   ├── Comment.php
│   │   ├── User.php
│   │   └── Category.php
│   └── utils/
│       ├── Response.php        # API response formatter
│       ├── JwtHandler.php      # JWT implementation
│       ├── Validator.php       # Input validation
│       └── Cache.php           # Caching utility
├── public/
│   ├── index.php               # Front controller
│   └── uploads/                # Uploaded files
├── vendor/                     # Composer dependencies
├── .htaccess
├── composer.json
└── README.md
```