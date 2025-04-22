# 📘 PHẦN 3: PHP NÂNG CAO VÀ KẾT NỐI DATABASE

## Nội dung

- [📘 PHẦN 3: PHP NÂNG CAO VÀ KẾT NỐI DATABASE](#-phần-3-php-nâng-cao-và-kết-nối-database)
  - [Nội dung](#nội-dung)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 11: Kết nối và thao tác với Database](#-bài-11-kết-nối-và-thao-tác-với-database)
  - [🧑‍🏫 Bài 12: PHP Data Objects (PDO)](#-bài-12-php-data-objects-pdo)
  - [🧑‍🏫 Bài 13: RESTful API với PHP](#-bài-13-restful-api-với-php)
  - [🧑‍🏫 Bài 14: Bảo mật trong PHP](#-bài-14-bảo-mật-trong-php)
  - [🧑‍🏫 Bài 15: Caching và Optimization](#-bài-15-caching-và-optimization)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN](#-bài-tập-lớn-cuối-phần)
    - [**Đề bài: Xây dựng hệ thống API cho ứng dụng blog**](#đề-bài-xây-dựng-hệ-thống-api-cho-ứng-dụng-blog)
    - [**Yêu cầu:**](#yêu-cầu)
    - [**Cấu trúc dự án:**](#cấu-trúc-dự-án)

## 🎯 Mục tiêu tổng quát

- Hiểu và áp dụng được các phương thức kết nối cơ sở dữ liệu trong PHP
- Xây dựng được RESTful API với PHP
- Nắm vững các vấn đề bảo mật và cách phòng tránh
- Biết cách tối ưu hóa ứng dụng PHP
- Áp dụng các kiến thức nâng cao để xây dựng ứng dụng web hoàn chỉnh

---

## 🧑‍🏫 Bài 11: Kết nối và thao tác với Database

**Kết nối với MySQL:**

```php
<?php
// Thông tin kết nối
$servername = "localhost";
$username = "root";
$password = "password";
$dbname = "mydb";

// Cách 1: Kết nối bằng MySQLi (Hướng đối tượng)
$mysqli = new mysqli($servername, $username, $password, $dbname);

// Kiểm tra kết nối
if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}
echo "Connected successfully (MySQLi Object-oriented)<br>";

// Cách 2: Kết nối bằng MySQLi (Thủ tục)
$conn = mysqli_connect($servername, $username, $password, $dbname);

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}
echo "Connected successfully (MySQLi Procedural)<br>";

// Cách 3: Kết nối bằng PDO
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

**Thực hiện truy vấn cơ bản:**

```php
<?php
// Giả sử đã có kết nối $mysqli, $conn, $pdo từ ví dụ trước

// 1. Truy vấn với MySQLi (Hướng đối tượng)
echo "<h3>MySQLi (Object-oriented)</h3>";

// Tạo bảng
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

// Thêm dữ liệu
$sql = "INSERT INTO users (firstname, lastname, email)
VALUES ('John', 'Doe', 'john@example.com')";

if ($mysqli->query($sql) === TRUE) {
    echo "New record created successfully. Last inserted ID: " . $mysqli->insert_id . "<br>";
} else {
    echo "Error: " . $sql . "<br>" . $mysqli->error . "<br>";
}

// Truy vấn dữ liệu
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

// Cập nhật dữ liệu
$sql = "UPDATE users SET lastname='Smith' WHERE id=1";

if ($mysqli->query($sql) === TRUE) {
    echo "Record updated successfully<br>";
} else {
    echo "Error updating record: " . $mysqli->error . "<br>";
}

// Xóa dữ liệu
$sql = "DELETE FROM users WHERE id=1";

if ($mysqli->query($sql) === TRUE) {
    echo "Record deleted successfully<br>";
} else {
    echo "Error deleting record: " . $mysqli->error . "<br>";
}

// Đóng kết nối
$mysqli->close();
?>
```

**Xử lý kết quả truy vấn:**

```php
<?php
// Kết nối PDO
try {
    $pdo = new PDO("mysql:host=localhost;dbname=mydb", "root", "password");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // Thêm nhiều bản ghi
    $pdo->exec("INSERT INTO users (firstname, lastname, email) VALUES 
                ('Jane', 'Doe', 'jane@example.com'),
                ('Mike', 'Johnson', 'mike@example.com'),
                ('Sarah', 'Williams', 'sarah@example.com')");
    
    echo "Multiple records inserted<br>";
    
    // Truy vấn có tham số
    $stmt = $pdo->prepare("SELECT * FROM users WHERE lastname = ?");
    $stmt->execute(['Doe']);
    echo "<h4>Users with lastname 'Doe':</h4>";
    
    // Cách 1: Fetch từng dòng
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo "Name: {$row['firstname']} {$row['lastname']}, Email: {$row['email']}<br>";
    }
    
    // Cách 2: Fetch tất cả dòng một lúc
    $stmt = $pdo->prepare("SELECT * FROM users WHERE lastname LIKE ?");
    $stmt->execute(['%i%']); // Lastname chứa chữ 'i'
    
    echo "<h4>Users with 'i' in lastname:</h4>";
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    foreach ($users as $user) {
        echo "Name: {$user['firstname']} {$user['lastname']}, Email: {$user['email']}<br>";
    }
    
    // Cách 3: Fetch vào object
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

**Transactions:**

```php
<?php
try {
    $pdo = new PDO("mysql:host=localhost;dbname=mydb", "root", "password");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // Bắt đầu transaction
    $pdo->beginTransaction();
    
    // Thực hiện các câu lệnh SQL
    $pdo->exec("INSERT INTO users (firstname, lastname, email) 
                VALUES ('Transaction', 'Test', 'transaction@example.com')");
    $pdo->exec("UPDATE users SET email='updated@example.com' WHERE lastname='Johnson'");
    
    // Commit transaction
    $pdo->commit();
    
    echo "Transaction completed successfully<br>";
} catch(PDOException $e) {
    // Rollback transaction nếu có lỗi
    $pdo->rollBack();
    echo "Transaction failed: " . $e->getMessage();
}
?>
```

---

## 🧑‍🏫 Bài 12: PHP Data Objects (PDO)

**Giới thiệu về PDO:**

```php
<?php
/*
PDO (PHP Data Objects) là một extension cung cấp interface nhất quán để truy cập database trong PHP.
Ưu điểm của PDO:
- Hỗ trợ nhiều loại database (MySQL, PostgreSQL, SQLite, Oracle, SQL Server, ...)
- Sử dụng prepared statements để chống SQL Injection
- Xử lý lỗi tốt hơn với exceptions
- Interface nhất quán, không phụ thuộc vào database cụ thể
*/

// Các driver được hỗ trợ
$drivers = PDO::getAvailableDrivers();
echo "Available PDO drivers: " . implode(', ', $drivers) . "<br>";

// Kết nối với các cơ sở dữ liệu khác nhau
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

**Cấu hình PDO và xử lý lỗi:**

```php
<?php
try {
    $pdo = new PDO('mysql:host=localhost;dbname=mydb;charset=utf8mb4', 'username', 'password', [
        // Cấu hình các thuộc tính của PDO
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,      // Báo lỗi bằng exceptions
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, // Dữ liệu trả về dạng associative array
        PDO::ATTR_EMULATE_PREPARES => false,              // Tắt prepared statements emulation
        PDO::MYSQL_ATTR_FOUND_ROWS => true                // Trả về số dòng đã tìm thấy thay vì số dòng được thay đổi
    ]);
    
    // Cách thiết lập các thuộc tính sau khi kết nối
    $pdo->setAttribute(PDO::ATTR_CASE, PDO::CASE_LOWER); // Chuyển tên cột thành chữ thường
} catch (PDOException $e) {
    // Xử lý lỗi
    echo "Connection failed: " . $e->getMessage() . "<br>";
    echo "Error code: " . $e->getCode() . "<br>";
    
    // Thêm thông tin lỗi chi tiết
    if ($e->errorInfo) {
        echo "SQLSTATE error code: " . $e->errorInfo[0] . "<br>";
        echo "Driver-specific error code: " . $e->errorInfo[1] . "<br>";
        echo "Driver-specific error message: " . $e->errorInfo[2] . "<br>";
    }
    
    // Ghi lỗi vào file log thay vì hiển thị
    error_log("Database error: " . $e->getMessage(), 3, "errors.log");
    
    // Hiển thị thông báo thân thiện với người dùng
    die("Sorry, a database error occurred. Our team has been notified.");
}
?>
```

**Prepared Statements:**

```php
<?php
try {
    $pdo = new PDO('mysql:host=localhost;dbname=mydb', 'username', 'password');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // Ví dụ 1: Prepared Statement với named parameters
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
    
    // Hiển thị kết quả
    echo "<h4>Users found (Example 1):</h4>";
    foreach ($users as $user) {
        echo "{$user['firstname']} {$user['lastname']} - {$user['email']}<br>";
    }
    
    // Ví dụ 2: Bind values trực tiếp trong execute
    $stmt = $pdo->prepare("SELECT * FROM users WHERE email LIKE :email");
    $stmt->execute([':email' => '%example.com%']);
    
    $users = $stmt->fetchAll();
    echo "<h4>Users with example.com email (Example 2):</h4>";
    foreach ($users as $user) {
        echo "{$user['firstname']} {$user['lastname']} - {$user['email']}<br>";
    }
    
    // Ví dụ 3: Sử dụng positional parameters
    $stmt = $pdo->prepare("INSERT INTO users (firstname, lastname, email) VALUES (?, ?, ?)");
    $stmt->execute(["Alice", "Smith", "alice@example.com"]);
    
    echo "New user added (Example 3). ID: " . $pdo->lastInsertId() . "<br>";
    
    // Ví dụ 4: Prepared statement có thể tái sử dụng nhiều lần
    $stmt = $pdo->prepare("INSERT INTO users (firstname, lastname, email) VALUES (:fname, :lname, :email)");
    
    // Thực thi nhiều lần với dữ liệu khác nhau
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

**Truy vấn nâng cao với PDO:**

```php
<?php
try {
    $pdo = new PDO('mysql:host=localhost;dbname=mydb', 'username', 'password');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // Ví dụ 1: JOIN query
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
    
    // Ví dụ 2: GROUP BY và aggregate functions
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
    
    // Ví dụ 3: Subqueries và IN operator
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

---

## 🧑‍🏫 Bài 13: RESTful API với PHP

**Giới thiệu về REST API:**

```php
<?php
/*
RESTful API là một kiến trúc phần mềm dùng để thiết kế các web service:
- REST = Representational State Transfer
- Sử dụng các HTTP methods (GET, POST, PUT, DELETE) để thao tác với tài nguyên
- Tài nguyên được xác định bằng URIs (Uniform Resource Identifiers)
- Thường trả về dữ liệu dạng JSON hoặc XML
- Stateless: mỗi request chứa đủ thông tin để xử lý
*/

// Thiết lập các header cơ bản cho REST API
header("Content-Type: application/json; charset=UTF-8");

// Định nghĩa cấu trúc API response
function sendResponse($data, $statusCode = 200) {
    http_response_code($statusCode);
    echo json_encode($data);
    exit;
}

// Ví dụ về response
$data = [
    "message" => "Welcome to our REST API",
    "version" => "1.0",
    "documentation" => "https://example.com/api-docs",
];

sendResponse($data);
?>
```

**Xây dựng REST API cơ bản:**

```php
<?php
// api/index.php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Origin: *");

// Kết nối database
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

// Lấy HTTP method và request URI
$method = $_SERVER['REQUEST_METHOD'];
$request = explode('/', trim($_SERVER['REQUEST_URI'], '/'));

// Mẫu URL: /api/resource/id
$resource = isset($request[1]) ? $request[1] : null;
$id = isset($request[2]) ? $request[2] : null;

// Xử lý API endpoints
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

// Handler cho resource "products"
function handleProducts($method, $id, $pdo) {
    switch ($method) {
        case 'GET':
            if ($id) {
                // GET /api/products/{id} - Lấy thông tin một sản phẩm
                $stmt = $pdo->prepare("SELECT * FROM products WHERE id = ?");
                $stmt->execute([$id]);
                $product = $stmt->fetch(PDO::FETCH_ASSOC);
                
                if ($product) {
                    sendResponse($product);
                } else {
                    sendResponse(["error" => "Product not found"], 404);
                }
            } else {
                // GET /api/products - Lấy danh sách sản phẩm
                $stmt = $pdo->query("SELECT * FROM products");
                $products = $stmt->fetchAll(PDO::FETCH_ASSOC);
                sendResponse($products);
            }
            break;
            
        case 'POST':
            // POST /api/products - Thêm sản phẩm mới
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
            // PUT /api/products/{id} - Cập nhật sản phẩm
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
            // DELETE /api/products/{id} - Xóa sản phẩm
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

// Handler cho resource "users" (tương tự products)
function handleUsers($method, $id, $pdo) {
    // Triển khai tương tự như handleProducts
    sendResponse(["message" => "Users endpoint not fully implemented yet"]);
}
?>
```

**Xác thực API với JWT:**

```php
<?php
// api/auth.php

// Thêm thư viện Firebase JWT
// require 'vendor/autoload.php'; // Nếu sử dụng Composer
// use Firebase\JWT\JWT;

// Triển khai JWT đơn giản không dùng thư viện
class JWTHandler {
    private $secretKey;
    private $issuedAt;
    private $expire;
    
    public function __construct($secretKey = 'your-secret-key') {
        $this->secretKey = $secretKey;
        $this->issuedAt = time();
        $this->expire = $this->issuedAt + 3600; // 1 giờ
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

**Middleware bảo vệ API:**

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

---

## 🧑‍🏫 Bài 14: Bảo mật trong PHP

**Ngăn chặn SQL Injection:**

```php
<?php
// Ví dụ về SQL Injection và cách phòng tránh

// BAD: Vulnerable to SQL Injection
$username = $_POST['username'];
$query = "SELECT * FROM users WHERE username = '$username'";
// Attacker có thể nhập: admin' --
// Query trở thành: SELECT * FROM users WHERE username = 'admin' --'

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

**Ngăn chặn XSS (Cross-Site Scripting):**

```php
<?php
// Ví dụ về XSS và cách phòng tránh

// BAD: Vulnerable to XSS
$name = $_GET['name'];
echo "Hello, $name!";
// Attacker có thể nhập: <script>alert('XSS')</script>

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
// Thêm vào header HTTP
header("Content-Security-Policy: default-src 'self'; script-src 'self' https://trusted-cdn.com;");
?>
```

**Ngăn chặn CSRF (Cross-Site Request Forgery):**

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

// Trong form
$csrf_token = generateCSRFToken();
echo '<form method="post">';
echo '<input type="hidden" name="csrf_token" value="' . $csrf_token . '">';
echo '<input type="text" name="username" placeholder="Username">';
echo '<button type="submit">Submit</button>';
echo '</form>';

// Khi xử lý form
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!isset($_POST['csrf_token']) || !validateCSRFToken($_POST['csrf_token'])) {
        die('CSRF token validation failed');
    }
    
    // Process form normally
    echo "Form processed successfully";
}
?>
```

**Bảo vệ mật khẩu:**

```php
<?php
// Ví dụ về hash và verify mật khẩu

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

**Bảo mật file upload:**

```php
<?php
// Bảo mật cho chức năng upload file

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

---

## 🧑‍🏫 Bài 15: Caching và Optimization

**Output Buffering và Page Caching:**

```php
<?php
// Output buffering để cache nội dung trang

// Tạo hàm cache trang
function cachePage($cacheDuration = 3600) {
    $cacheFile = 'cache/' . md5($_SERVER['REQUEST_URI']) . '.html';
    
    // Kiểm tra nếu cache tồn tại và còn hạn
    if (file_exists($cacheFile) && time() - filemtime($cacheFile) < $cacheDuration) {
        readfile($cacheFile);
        exit;
    }
    
    // Bắt đầu output buffering nếu cache không tồn tại hoặc hết hạn
    ob_start();
}

function endCache() {
    $cacheFile = 'cache/' . md5($_SERVER['REQUEST_URI']) . '.html';
    
    // Tạo thư mục cache nếu chưa tồn tại
    if (!is_dir('cache')) {
        mkdir('cache', 0755, true);
    }
    
    // Lưu output vào file cache
    $cachedContent = ob_get_contents();
    file_put_contents($cacheFile, $cachedContent);
    
    // Gửi nội dung đến browser
    ob_end_flush();
}

// Sử dụng cache
cachePage();

// Content of your page
echo "<h1>Welcome to the cached page</h1>";
echo "<p>This content is generated at: " . date('Y-m-d H:i:s') . "</p>";

// Các truy vấn database, xử lý logic, v.v...
sleep(1); // Giả lập thời gian xử lý

echo "<p>This page will be cached for 1 hour.</p>";

// Kết thúc và lưu cache
endCache();
?>
```

**Memcached:**

```php
<?php
// Sử dụng Memcached để caching dữ liệu

// Khởi tạo kết nối Memcached
$memcached = new Memcached();
$memcached->addServer('localhost', 11211);

// Hàm lấy dữ liệu với cache
function getCachedData($key, $ttl = 600, $dataCallback) {
    global $memcached;
    
    // Thử lấy từ cache
    $cachedData = $memcached->get($key);
    
    if ($memcached->getResultCode() === Memcached::RES_SUCCESS) {
        // Dữ liệu tìm thấy trong cache
        return $cachedData;
    }
    
    // Dữ liệu không có trong cache, gọi callback để sinh dữ liệu
    $data = $dataCallback();
    
    // Lưu vào cache
    $memcached->set($key, $data, $ttl);
    
    return $data;
}

// Ví dụ sử dụng:

// 1. Caching kết quả truy vấn database
function getProductsFromDatabase() {
    // Mô phỏng truy vấn database tốn thời gian
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

// 2. Caching kết quả của API call
function getWeatherData() {
    // Mô phỏng gọi API bên ngoài
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

// 3. Xóa cache khi dữ liệu thay đổi
function updateProduct($productId, $data) {
    // Update database
    
    // Xóa cache liên quan
    global $memcached;
    $memcached->delete('products_list');
    $memcached->delete('product_' . $productId);
    
    return true;
}

// 4. Increment/Decrement counter
$memcached->increment('page_views', 1, 0); // Tăng giá trị, khởi tạo 0 nếu chưa tồn tại
$views = $memcached->get('page_views');
echo "Page views: $views<br>";
?>
```

**Redis:**

```php
<?php
// Sử dụng Redis để caching và lưu trữ dữ liệu

// Kết nối đến Redis
$redis = new Redis();
$redis->connect('127.0.0.1', 6379);

// Đặt giá trị đơn giản
$redis->set('welcome_message', 'Hello from Redis!');
echo $redis->get('welcome_message') . "<br>";

// Đặt giá trị với thời gian tồn tại (TTL)
$redis->setex('session_token', 3600, 'user123_token_value');

// Kiểm tra thời gian còn lại
$ttl = $redis->ttl('session_token');
echo "Token expires in $ttl seconds<br>";

// Lưu trữ hash (đối tượng)
$redis->hMset('user:1001', [
    'username' => 'johndoe',
    'email' => 'john@example.com',
    'visits' => 5
]);

// Lấy toàn bộ hash
$user = $redis->hGetAll('user:1001');
echo "User data: ";
print_r($user);
echo "<br>";

// Tăng counter
$redis->hIncrBy('user:1001', 'visits', 1);
$visits = $redis->hGet('user:1001', 'visits');
echo "User visits: $visits<br>";

// Lưu trữ list
$redis->rPush('recent_products', 'product:1001');
$redis->rPush('recent_products', 'product:1002');
$redis->rPush('recent_products', 'product:1003');
$redis->lTrim('recent_products', 0, 9);  // Giữ 10 sản phẩm gần đây nhất

// Lấy toàn bộ list
$recentProducts = $redis->lRange('recent_products', 0, -1);
echo "Recent products: ";
print_r($recentProducts);
echo "<br>";

// Lưu trữ set (tập hợp không trùng lặp)
$redis->sAdd('user:1001:roles', 'editor', 'subscriber');
$redis->sAdd('user:1002:roles', 'admin', 'editor');

// Kiểm tra thành viên trong set
$isEditor = $redis->sIsMember('user:1001:roles', 'editor') ? 'Yes' : 'No';
echo "Is user 1001 an editor? $isEditor<br>";

// Intersection của các set
$commonRoles = $redis->sInter('user:1001:roles', 'user:1002:roles');
echo "Common roles: ";
print_r($commonRoles);
echo "<br>";

// Sử dụng Redis cho rate limiting
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

// Sử dụng Redis Pub/Sub (in a real app, this would be in separate scripts)
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

// Pipeline để gửi nhiều lệnh cùng lúc
$redis->multi();
$redis->set('pipeline_test', 'value1');
$redis->incr('counter');
$redis->lPush('mylist', 'value2');
$responses = $redis->exec();

echo "Pipeline responses: ";
print_r($responses);
?>
```

**Tối ưu hóa code PHP:**

```php
<?php
// Tips tối ưu hóa PHP

// 1. Sử dụng các hàm có sẵn thay vì vòng lặp khi có thể
$numbers = range(1, 1000);

// Bad: Manual iteration
$sum = 0;
foreach ($numbers as $number) {
    $sum += $number;
}

// Good: Use built-in function
$sum = array_sum($numbers);

// 2. Sử dụng single quotes khi không cần string interpolation
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

// 10. Optimize database queries
// - Use indexes
// - Retrieve only needed columns
// - Use JOIN instead of separate queries
// - Limit result sets
// - Use prepared statements
?>
```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Xây dựng hệ thống API cho ứng dụng blog**

Xây dựng một RESTful API hoàn chỉnh cho ứng dụng blog, sử dụng các kỹ thuật bảo mật và tối ưu hiệu suất.

### **Yêu cầu:**

1. Thiết kế RESTful API cho các tài nguyên sau:
   - Bài viết (posts)
   - Bình luận (comments)
   - Người dùng (users)
   - Danh mục (categories)

2. Triển khai các tính năng:
   - Xác thực người dùng sử dụng JWT
   - Phân quyền: Admin, Author, Reader
   - CRUD operations cho mỗi tài nguyên
   - Tìm kiếm và lọc dữ liệu
   - Pagination và sorting
   - File upload (cho ảnh bài viết)

3. Bảo mật API:
   - Sử dụng HTTPS
   - Rate limiting
   - Validate input
   - Phòng chống SQL Injection, XSS
   - Bảo vệ các route yêu cầu quyền admin

4. Tối ưu hiệu suất:
   - Caching (Redis hoặc Memcached)
   - Index database hợp lý
   - Lazy loading cho các quan hệ
   - Compression của response data

### **Cấu trúc dự án:**

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

---

[⬅️ Trở lại: PHP/Part2.md](../PHP/Part2.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: PHP/Part3.md](../PHP/Part3.md)
