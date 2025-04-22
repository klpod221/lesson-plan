# 📘 PHẦN 1: NHẬP MÔN PHP

- [📘 PHẦN 1: NHẬP MÔN PHP](#-phần-1-nhập-môn-php)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Giới thiệu PHP](#-bài-1-giới-thiệu-php)
  - [🧑‍🏫 Bài 2: Biến và kiểu dữ liệu trong PHP](#-bài-2-biến-và-kiểu-dữ-liệu-trong-php)
  - [🧑‍🏫 Bài 3: Toán tử và cấu trúc điều khiển](#-bài-3-toán-tử-và-cấu-trúc-điều-khiển)
  - [🧑‍🏫 Bài 4: Hàm và Array trong PHP](#-bài-4-hàm-và-array-trong-php)
  - [🧑‍🏫 Bài 5: PHP và HTML](#-bài-5-php-và-html)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN](#-bài-tập-lớn-cuối-phần)
    - [**Đề bài: Tạo trang quản lý sản phẩm đơn giản**](#đề-bài-tạo-trang-quản-lý-sản-phẩm-đơn-giản)
    - [**Yêu cầu:**](#yêu-cầu)
    - [**Kết quả chạy chương trình (Ví dụ):**](#kết-quả-chạy-chương-trình-ví-dụ)

## 🎯 Mục tiêu tổng quát

- Hiểu được khái niệm cơ bản về PHP và cách PHP hoạt động với web
- Nắm vững cú pháp PHP, biến, hàm và cấu trúc điều khiển
- Biết cách kết hợp PHP với HTML để tạo trang web động
- Xây dựng được ứng dụng web đơn giản với PHP

---

## 🧑‍🏫 Bài 1: Giới thiệu PHP

**PHP là gì?**

- PHP (PHP: Hypertext Preprocessor) là ngôn ngữ lập trình kịch bản phía server
- Được thiết kế dành riêng cho phát triển web
- Mã PHP được thực thi trên server và kết quả được trả về client dưới dạng HTML
- Có thể nhúng PHP vào trong HTML

**File PHP đầu tiên:**

```php
<!DOCTYPE html>
<html>
<head>
    <title>Trang PHP đầu tiên</title>
</head>
<body>
    <h1>Hello PHP</h1>
    
    <?php
        // Đây là comment một dòng
        
        /* Đây là comment
        nhiều dòng */
        
        echo "Hello, World!";
        
        // In ra với thông tin
        echo "<p>Hôm nay là " . date("d/m/Y") . "</p>";
    ?>
</body>
</html>
```

Tạo file `index.php` và mở terminal chạy lệnh sau:

```bash
php -S localhost:8000
```

Truy cập vào `http://localhost:8000` để xem kết quả.

**Cú pháp PHP cơ bản:**

- PHP bắt đầu với `<?php` và kết thúc với `?>`
- Mỗi câu lệnh kết thúc bằng dấu chấm phẩy (;)
- PHP phân biệt chữ hoa và chữ thường trong tên biến
- Có thể nhúng nhiều block PHP trong một trang HTML

---

## 🧑‍🏫 Bài 2: Biến và kiểu dữ liệu trong PHP

**Biến trong PHP:**

- Biến bắt đầu với ký tự `$`
- Tên biến phải bắt đầu bằng một chữ cái hoặc dấu gạch dưới
- Tên biến không được bắt đầu bằng số
- PHP là ngôn ngữ có kiểu dữ liệu động (không cần khai báo kiểu)

```php
<?php
    // Khai báo và gán giá trị cho biến
    $name = "Nguyễn Văn A";
    $age = 25;
    $isStudent = true;
    
    // In ra giá trị biến
    echo "Tên: " . $name . "<br>";
    echo "Tuổi: " . $age . "<br>";
    echo "Là sinh viên: " . ($isStudent ? "Có" : "Không");
?>
```

**Kiểu dữ liệu cơ bản:**

```php
<?php
    // Kiểu chuỗi (String)
    $str = "Hello PHP";
    echo gettype($str) . ": " . $str . "<br>";
    
    // Kiểu số nguyên (Integer)
    $int = 42;
    echo gettype($int) . ": " . $int . "<br>";
    
    // Kiểu số thực (Float/Double)
    $float = 3.14;
    echo gettype($float) . ": " . $float . "<br>";
    
    // Kiểu boolean
    $bool = true;
    echo gettype($bool) . ": " . ($bool ? "true" : "false") . "<br>";
    
    // Kiểu null
    $null = null;
    echo gettype($null) . ": null<br>";
    
    // Kiểm tra kiểu dữ liệu
    var_dump($str);
    echo "<br>";
    var_dump($int);
    echo "<br>";
    var_dump($bool);
?>
```

**Hằng số:**

```php
<?php
    // Định nghĩa hằng
    define("PI", 3.14159);
    define("APP_NAME", "My PHP Application");
    define("DEBUG_MODE", true);
    
    // Sử dụng hằng
    echo "PI = " . PI . "<br>";
    echo "Tên ứng dụng: " . APP_NAME . "<br>";
    
    // Hằng số từ PHP 7.0
    const DATABASE = "mysql";
    const DB_HOST = "localhost";
    
    echo "Database: " . DATABASE;
?>
```

---

## 🧑‍🏫 Bài 3: Toán tử và cấu trúc điều khiển

**Các toán tử trong PHP:**

```php
<?php
    // Toán tử số học
    $a = 10;
    $b = 3;
    echo "Cộng: " . ($a + $b) . "<br>";        // 13
    echo "Trừ: " . ($a - $b) . "<br>";         // 7
    echo "Nhân: " . ($a * $b) . "<br>";        // 30
    echo "Chia: " . ($a / $b) . "<br>";        // 3.3333...
    echo "Chia lấy dư: " . ($a % $b) . "<br>"; // 1
    echo "Lũy thừa: " . ($a ** $b) . "<br>";   // 10^3 = 1000
    
    // Toán tử gán
    $x = 5;
    $x += 3;  // $x = $x + 3
    echo "x = " . $x . "<br>";  // 8
    
    // Toán tử so sánh
    $p = 5;
    $q = "5";
    echo "p == q: " . ($p == $q ? "true" : "false") . "<br>";   // true (so sánh giá trị)
    echo "p === q: " . ($p === $q ? "true" : "false") . "<br>"; // false (so sánh giá trị và kiểu)
    
    // Toán tử tăng/giảm
    $i = 5;
    echo "i++ = " . $i++ . "<br>"; // 5 (dùng rồi mới tăng)
    echo "i = " . $i . "<br>";     // 6
    echo "++i = " . ++$i . "<br>"; // 7 (tăng trước rồi mới dùng)
    
    // Toán tử chuỗi
    $firstName = "Nguyễn";
    $lastName = "Văn A";
    $fullName = $firstName . " " . $lastName;
    echo "Họ tên: " . $fullName;
?>
```

**Cấu trúc điều kiện:**

```php
<?php
    $score = 75;
    
    // Câu lệnh if-else
    if ($score >= 90) {
        echo "Xuất sắc";
    } elseif ($score >= 80) {
        echo "Giỏi";
    } elseif ($score >= 70) {
        echo "Khá";
    } elseif ($score >= 60) {
        echo "Trung bình";
    } else {
        echo "Yếu";
    }
    echo "<br>";
    
    // Cú pháp viết tắt if-else
    echo ($score >= 60) ? "Đạt" : "Không đạt";
    echo "<br>";
    
    // Switch-case
    $day = 3;
    switch ($day) {
        case 1:
            echo "Chủ nhật";
            break;
        case 2:
            echo "Thứ hai";
            break;
        case 3:
            echo "Thứ ba";
            break;
        case 4:
            echo "Thứ tư";
            break;
        case 5:
            echo "Thứ năm";
            break;
        case 6:
            echo "Thứ sáu";
            break;
        case 7:
            echo "Thứ bảy";
            break;
        default:
            echo "Ngày không hợp lệ";
    }
?>
```

**Vòng lặp:**

```php
<?php
    // Vòng lặp for
    echo "<h3>Vòng lặp for</h3>";
    echo "<ul>";
    for ($i = 1; $i <= 5; $i++) {
        echo "<li>Item $i</li>";
    }
    echo "</ul>";
    
    // Vòng lặp while
    echo "<h3>Vòng lặp while</h3>";
    $count = 1;
    echo "<ul>";
    while ($count <= 5) {
        echo "<li>Count: $count</li>";
        $count++;
    }
    echo "</ul>";
    
    // Vòng lặp do-while
    echo "<h3>Vòng lặp do-while</h3>";
    $num = 1;
    echo "<ul>";
    do {
        echo "<li>Number: $num</li>";
        $num++;
    } while ($num <= 5);
    echo "</ul>";
    
    // Lệnh break và continue
    echo "<h3>Break và Continue</h3>";
    echo "<p>Các số lẻ từ 1-10:</p>";
    for ($i = 1; $i <= 10; $i++) {
        if ($i % 2 == 0) {
            continue; // Bỏ qua số chẵn
        }
        echo "$i ";
        
        if ($i == 7) {
            break; // Dừng khi gặp số 7
        }
    }
?>
```

---

## 🧑‍🏫 Bài 4: Hàm và Array trong PHP

**Hàm trong PHP:**

```php
<?php
    // Hàm không có tham số
    function sayHello() {
        echo "Hello from PHP function! <br>";
    }
    
    // Gọi hàm
    sayHello();
    
    // Hàm có tham số
    function greet($name) {
        echo "Xin chào, $name! <br>";
    }
    
    greet("Nguyễn Văn A");
    
    // Hàm với tham số mặc định
    function calculateTotal($price, $taxRate = 0.1) {
        $tax = $price * $taxRate;
        $total = $price + $tax;
        return $total;
    }
    
    $amount = calculateTotal(100);  // Sử dụng tax rate mặc định
    echo "Tổng: $amount <br>";
    
    $amount2 = calculateTotal(100, 0.05);  // Chỉ định tax rate
    echo "Tổng với thuế 5%: $amount2 <br>";
    
    // Hàm với nhiều giá trị trả về (sử dụng array)
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

**Array trong PHP:**

```php
<?php
    // Mảng số nguyên (indexed array)
    $numbers = [1, 2, 3, 4, 5];
    // hoặc: $numbers = array(1, 2, 3, 4, 5);
    
    echo "Phần tử thứ 3: " . $numbers[2] . "<br>"; // Index bắt đầu từ 0
    
    // Duyệt mảng với for
    echo "Duyệt mảng với for: ";
    for ($i = 0; $i < count($numbers); $i++) {
        echo $numbers[$i] . " ";
    }
    echo "<br>";
    
    // Duyệt mảng với foreach
    echo "Duyệt mảng với foreach: ";
    foreach ($numbers as $value) {
        echo $value . " ";
    }
    echo "<br>";
    
    // Mảng kết hợp (associative array)
    $student = [
        'name' => 'Nguyễn Văn A',
        'age' => 20,
        'major' => 'Computer Science',
        'gpa' => 3.8
    ];
    
    echo "Tên sinh viên: " . $student['name'] . "<br>";
    echo "Chuyên ngành: " . $student['major'] . "<br>";
    
    // Duyệt mảng kết hợp
    echo "<h3>Thông tin sinh viên:</h3>";
    echo "<ul>";
    foreach ($student as $key => $value) {
        echo "<li>$key: $value</li>";
    }
    echo "</ul>";
    
    // Mảng đa chiều
    $students = [
        [
            'name' => 'Nguyễn Văn A',
            'age' => 20,
            'scores' => [85, 90, 78]
        ],
        [
            'name' => 'Trần Thị B',
            'age' => 21,
            'scores' => [92, 88, 95]
        ],
        [
            'name' => 'Lê Văn C',
            'age' => 22,
            'scores' => [75, 80, 82]
        ]
    ];
    
    // Truy cập mảng đa chiều
    echo "Sinh viên thứ 2: " . $students[1]['name'] . "<br>";
    echo "Điểm môn thứ 3 của sinh viên thứ 2: " . $students[1]['scores'][2] . "<br>";
    
    // Duyệt mảng đa chiều
    echo "<h3>Danh sách sinh viên:</h3>";
    foreach ($students as $student) {
        echo "<p><strong>" . $student['name'] . "</strong>, " . $student['age'] . " tuổi</p>";
        echo "<p>Điểm: ";
        foreach ($student['scores'] as $score) {
            echo $score . " ";
        }
        echo "</p>";
        echo "<hr>";
    }
    
    // Một số hàm xử lý mảng
    $fruits = ['apple', 'banana', 'orange', 'grape'];
    
    echo "Số phần tử: " . count($fruits) . "<br>";
    
    // Thêm phần tử vào mảng
    $fruits[] = 'mango';
    array_push($fruits, 'strawberry', 'kiwi');
    
    // Sắp xếp mảng
    sort($fruits);
    echo "Mảng sau khi sắp xếp: ";
    print_r($fruits);
    echo "<br>";
    
    // Đảo ngược mảng
    $reversed = array_reverse($fruits);
    echo "Mảng sau khi đảo ngược: ";
    print_r($reversed);
    echo "<br>";
    
    // Chuyển mảng thành chuỗi
    $fruitString = implode(", ", $fruits);
    echo "Chuỗi từ mảng: " . $fruitString . "<br>";
    
    // Chuyển chuỗi thành mảng
    $colors = "red,green,blue,yellow";
    $colorArray = explode(",", $colors);
    echo "Mảng từ chuỗi: ";
    print_r($colorArray);
?>
```

---

## 🧑‍🏫 Bài 5: PHP và HTML

**Kết hợp PHP với HTML:**

```php
<!DOCTYPE html>
<html>
<head>
    <title>PHP và HTML</title>
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
    <h1>Danh sách sản phẩm</h1>
    
    <?php
    // Dữ liệu sản phẩm (thường sẽ lấy từ database)
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
    
    // Hiển thị dữ liệu trong bảng HTML
    if (count($products) > 0) {
        echo '<table>';
        echo '<tr><th>ID</th><th>Tên sản phẩm</th><th>Giá</th><th>Tồn kho</th><th>Trạng thái</th></tr>';
        
        foreach ($products as $product) {
            echo '<tr>';
            echo '<td>' . $product['id'] . '</td>';
            echo '<td>' . $product['name'] . '</td>';
            echo '<td>$' . number_format($product['price'], 2) . '</td>';
            echo '<td>' . $product['stock'] . '</td>';
            
            // Biểu thức điều kiện để hiển thị trạng thái
            if ($product['stock'] > 10) {
                echo '<td style="color: green;">Còn nhiều</td>';
            } elseif ($product['stock'] > 0) {
                echo '<td style="color: orange;">Sắp hết</td>';
            } else {
                echo '<td style="color: red;">Hết hàng</td>';
            }
            
            echo '</tr>';
        }
        
        echo '</table>';
    } else {
        echo '<p>Không có sản phẩm nào.</p>';
    }
    ?>
    
    <h2>Form thêm sản phẩm</h2>
    <form method="post" action="">
        <div>
            <label for="name">Tên sản phẩm:</label>
            <input type="text" id="name" name="name" required>
        </div>
        <div>
            <label for="price">Giá:</label>
            <input type="number" id="price" name="price" step="0.01" required>
        </div>
        <div>
            <label for="stock">Tồn kho:</label>
            <input type="number" id="stock" name="stock" required>
        </div>
        <div>
            <button type="submit">Thêm sản phẩm</button>
        </div>
    </form>
    
    <?php
    // Xử lý form khi submit
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        if (isset($_POST["name"]) && isset($_POST["price"]) && isset($_POST["stock"])) {
            $name = $_POST["name"];
            $price = $_POST["price"];
            $stock = $_POST["stock"];
            
            echo "<h3>Sản phẩm vừa thêm:</h3>";
            echo "<p>Tên: $name</p>";
            echo "<p>Giá: $price</p>";
            echo "<p>Tồn kho: $stock</p>";
            
            // Trong thực tế, tại đây sẽ thêm dữ liệu vào database
        }
    }
    ?>
</body>
</html>
```

**Xử lý form với PHP:**

```php
<!DOCTYPE html>
<html>
<head>
    <title>Xử lý Form với PHP</title>
    <style>
        .error { color: red; }
        .success { color: green; }
        form { margin-bottom: 20px; }
        label { display: block; margin-top: 10px; }
    </style>
</head>
<body>
    <h1>Đăng ký tài khoản</h1>
    
    <?php
    // Khởi tạo biến lỗi và biến lưu dữ liệu
    $nameErr = $emailErr = $passwordErr = "";
    $name = $email = $password = "";
    $formValid = true;
    
    // Kiểm tra xem form đã được submit chưa
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Kiểm tra và lấy giá trị tên
        if (empty($_POST["name"])) {
            $nameErr = "Họ tên không được để trống";
            $formValid = false;
        } else {
            $name = test_input($_POST["name"]);
            // Kiểm tra tên chỉ chứa chữ và khoảng trắng
            if (!preg_match("/^[a-zA-Z ]*$/", $name)) {
                $nameErr = "Họ tên chỉ được chứa chữ cái và khoảng trắng";
                $formValid = false;
            }
        }
        
        // Kiểm tra và lấy giá trị email
        if (empty($_POST["email"])) {
            $emailErr = "Email không được để trống";
            $formValid = false;
        } else {
            $email = test_input($_POST["email"]);
            // Kiểm tra định dạng email hợp lệ
            if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
                $emailErr = "Định dạng email không hợp lệ";
                $formValid = false;
            }
        }
        
        // Kiểm tra và lấy giá trị mật khẩu
        if (empty($_POST["password"])) {
            $passwordErr = "Mật khẩu không được để trống";
            $formValid = false;
        } else {
            $password = test_input($_POST["password"]);
            // Kiểm tra độ dài mật khẩu
            if (strlen($password) < 6) {
                $passwordErr = "Mật khẩu phải có ít nhất 6 ký tự";
                $formValid = false;
            }
        }
        
        // Nếu form hợp lệ, hiển thị thông tin
        if ($formValid) {
            echo '<div class="success">';
            echo '<h3>Đăng ký thành công!</h3>';
            echo '<p>Họ tên: ' . $name . '</p>';
            echo '<p>Email: ' . $email . '</p>';
            echo '</div>';
            
            // Trong thực tế, tại đây sẽ lưu dữ liệu vào database
        }
    }
    
    // Hàm xử lý và làm sạch dữ liệu đầu vào
    function test_input($data) {
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }
    ?>
    
    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
        <div>
            <label for="name">Họ tên:</label>
            <input type="text" id="name" name="name" value="<?php echo $name; ?>">
            <span class="error"><?php echo $nameErr; ?></span>
        </div>
        
        <div>
            <label for="email">Email:</label>
            <input type="text" id="email" name="email" value="<?php echo $email; ?>">
            <span class="error"><?php echo $emailErr; ?></span>
        </div>
        
        <div>
            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password">
            <span class="error"><?php echo $passwordErr; ?></span>
        </div>
        
        <div style="margin-top: 20px;">
            <input type="submit" value="Đăng ký">
        </div>
    </form>
</body>
</html>
```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Tạo trang quản lý sản phẩm đơn giản**

Xây dựng trang web đơn giản cho phép:

- Hiển thị danh sách sản phẩm
- Thêm sản phẩm mới
- Tìm kiếm sản phẩm theo tên
- Lọc sản phẩm theo giá

### **Yêu cầu:**

- Tạo cấu trúc dữ liệu lưu trữ sản phẩm (mảng PHP)
- Thiết kế giao diện hiển thị danh sách sản phẩm (bảng)
- Tạo form thêm sản phẩm mới với các trường: tên, mô tả, giá, số lượng
- Xây dựng chức năng tìm kiếm và lọc sản phẩm
- Tổ chức code theo cấu trúc rõ ràng, dễ bảo trì

### **Kết quả chạy chương trình (Ví dụ):**

```text
TRANG QUẢN LÝ SẢN PHẨM

- Form tìm kiếm/lọc với các tùy chọn
- Bảng hiển thị danh sách sản phẩm với thông tin chi tiết
- Form thêm sản phẩm mới
- Thông báo kết quả sau khi thực hiện các thao tác
```

---

[⬅️ Trở lại: WEB/Part4.md](../WEB/Part4.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: PHP/Part1.md](../PHP/Part1.md)
