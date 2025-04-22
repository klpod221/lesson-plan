# 📘 PHẦN 5: XU HƯỚNG HIỆN ĐẠI VÀ CÔNG NGHỆ MỚI TRONG PHP

- [📘 PHẦN 5: XU HƯỚNG HIỆN ĐẠI VÀ CÔNG NGHỆ MỚI TRONG PHP](#-phần-5-xu-hướng-hiện-đại-và-công-nghệ-mới-trong-php)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 21: PHP và Containers (Docker)](#-bài-21-php-và-containers-docker)
  - [🧑‍🏫 Bài 22: Microservices với PHP](#-bài-22-microservices-với-php)
  - [🧑‍🏫 Bài 23: Progressive Web Apps và PHP](#-bài-23-progressive-web-apps-và-php)
  - [🧑‍🏫 Bài 24: GraphQL API trong PHP](#-bài-24-graphql-api-trong-php)
  - [🧑‍🏫 Bài 25: JIT trong PHP 8 và Beyond](#-bài-25-jit-trong-php-8-và-beyond)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN](#-bài-tập-lớn-cuối-phần)
    - [**Đề bài: Xây dựng hệ thống Microservice với PHP và Docker**](#đề-bài-xây-dựng-hệ-thống-microservice-với-php-và-docker)
    - [**Yêu cầu:**](#yêu-cầu)
    - [**Cấu trúc dự án:**](#cấu-trúc-dự-án)

## 🎯 Mục tiêu tổng quát

- Nắm vững việc triển khai ứng dụng PHP trong container với Docker
- Hiểu và áp dụng kiến trúc Microservices trong dự án PHP
- Biết cách xây dựng Progressive Web Apps với API PHP
- Làm chủ GraphQL để phát triển API hiện đại
- Tối ưu hiệu năng ứng dụng với các tính năng mới của PHP 8+

---

## 🧑‍🏫 Bài 21: PHP và Containers (Docker)

**Giới thiệu về Docker và containers:**

```bash
# Cài đặt Docker trên Ubuntu
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce docker-compose

# Kiểm tra cài đặt
docker --version
docker-compose --version

# Chạy container đầu tiên
docker run hello-world
```

**Dockerfile cơ bản cho PHP:**

```dockerfile
# Dockerfile
FROM php:8.1-fpm

# Cài đặt các dependencies hệ thống
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev

# Cài đặt các PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Cài đặt Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Thiết lập thư mục làm việc
WORKDIR /var/www

# Sao chép source code vào container
COPY . /var/www

# Cài đặt các dependencies từ Composer
RUN composer install --optimize-autoloader --no-dev

# Thiết lập quyền cho storage và cache
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Mở cổng để kết nối
EXPOSE 9000

# Khởi động PHP-FPM
CMD ["php-fpm"]
```

**Docker Compose cho stack LEMP (Linux, Nginx, MySQL, PHP):**

```yaml
# docker-compose.yml
version: "3"

services:
  # PHP Service
  php:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: app_php
    restart: unless-stopped
    volumes:
      - ./:/var/www
      - ./docker/php/local.ini:/usr/local/etc/php/conf.d/local.ini
    networks:
      - app-network

  # Nginx Service
  nginx:
    image: nginx:alpine
    container_name: app_nginx
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./:/var/www
      - ./docker/nginx/conf.d/:/etc/nginx/conf.d/
      - ./docker/nginx/ssl/:/etc/nginx/ssl/
    networks:
      - app-network

  # MySQL Service
  mysql:
    image: mysql:5.7
    container_name: app_mysql
    restart: unless-stopped
    ports:
      - "3306:3306"
    environment:
      MYSQL_DATABASE: ${DB_DATABASE}
      MYSQL_ROOT_PASSWORD: ${DB_PASSWORD}
      MYSQL_PASSWORD: ${DB_PASSWORD}
      MYSQL_USER: ${DB_USERNAME}
      SERVICE_TAGS: dev
      SERVICE_NAME: mysql
    volumes:
      - dbdata:/var/lib/mysql
      - ./docker/mysql/my.cnf:/etc/mysql/my.cnf
    networks:
      - app-network

  # Redis Service
  redis:
    image: redis:alpine
    container_name: app_redis
    restart: unless-stopped
    ports:
      - "6379:6379"
    networks:
      - app-network

networks:
  app-network:
    driver: bridge

volumes:
  dbdata:
    driver: local
```

**Cấu hình Nginx trong Docker:**

```nginx
# docker/nginx/conf.d/default.conf
server {
    listen 80;
    server_name localhost;
    root /var/www/public;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-XSS-Protection "1; mode=block";
    add_header X-Content-Type-Options "nosniff";

    index index.php index.html index.htm;

    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    error_page 404 /index.php;

    location ~ \.php$ {
        fastcgi_pass php:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}
```

**Triển khai và quản lý container PHP:**

```bash
# Khởi động stack
docker-compose up -d

# Kiểm tra các container đang chạy
docker-compose ps

# Truy cập vào container PHP
docker-compose exec php bash

# Chạy các lệnh trong container PHP
docker-compose exec php php artisan migrate

# Xem logs của container
docker-compose logs -f nginx

# Dừng và xóa các containers
docker-compose down

# Dừng, xóa containers và cả volumes
docker-compose down -v
```

**Thực hành tốt nhất với Docker và PHP:**

```bash
# 1. Sử dụng multi-stage builds để giảm kích thước image
# Dockerfile.optimized
FROM composer:2.0 as build
WORKDIR /app
COPY . /app
RUN composer install --optimize-autoloader --no-dev

FROM php:8.1-fpm-alpine
WORKDIR /var/www
COPY --from=build /app /var/www
EXPOSE 9000
CMD ["php-fpm"]

# 2. Sử dụng Docker layers cache hiệu quả
# Sắp xếp các lệnh từ ít thay đổi đến nhiều thay đổi
COPY composer.json composer.lock ./
RUN composer install --no-scripts
COPY . .

# 3. Sử dụng Docker Volumes cho dữ liệu cần lưu trữ
docker run -v $(pwd):/var/www my-php-app

# 4. Tối ưu hóa healthchecks
# docker-compose.yml
services:
  php:
    # ...
    healthcheck:
      test: ["CMD", "php", "-r", "if(mysqli_connect('mysql', 'root', 'password')) {exit(0);} else {exit(1);}"]
      interval: 30s
      timeout: 10s
      retries: 3
```

---

## 🧑‍🏫 Bài 22: Microservices với PHP

**Giới thiệu về kiến trúc Microservices:**

```php
<?php
/*
Microservices là một phương pháp phát triển phần mềm, một biến thể của kiến trúc hướng dịch vụ (SOA).
Đặc điểm:
- Chia ứng dụng thành các services nhỏ, độc lập
- Mỗi service chịu trách nhiệm cho một chức năng cụ thể
- Các services giao tiếp qua API, message queues
- Dễ dàng scale riêng từng service
- Có thể sử dụng công nghệ khác nhau cho các service

So sánh với Monolithic:
- Monolithic: Toàn bộ ứng dụng là một đơn vị, khó scale, khó maintain khi lớn
- Microservice: Chia nhỏ, dễ maintain, dễ scale, nhưng phức tạp hơn trong quản lý
*/

// Ví dụ đơn giản về service trong kiến trúc microservice
// UserService: Quản lý người dùng
namespace App\Services\User;

use App\Models\User;

class UserService
{
    public function getUser($id)
    {
        // Lấy thông tin người dùng
        return User::findOrFail($id);
    }

    public function createUser(array $data)
    {
        // Tạo người dùng mới
        return User::create($data);
    }

    // Các chức năng khác liên quan đến user...
}

// OrderService: Quản lý đơn hàng
namespace App\Services\Order;

use App\Models\Order;

class OrderService
{
    public function createOrder($userId, array $items)
    {
        // Tạo đơn hàng
        $order = new Order();
        $order->user_id = $userId;
        $order->save();

        // Thêm các items vào đơn hàng
        $order->items()->createMany($items);

        return $order;
    }

    // Các chức năng khác liên quan đến order...
}
?>
```

**Xây dựng RESTful microservices với PHP:**

```php
<?php
// api/users/index.php - User Microservice
header('Content-Type: application/json');

// Connect to user database
$pdo = new PDO('mysql:host=users-db;dbname=users', 'user', 'password');
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

// Router
$method = $_SERVER['REQUEST_METHOD'];
$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

// Routes for the User service
if (preg_match('/\/api\/users\/(\d+)/', $path, $matches) && $method === 'GET') {
    // Get user by ID
    $userId = $matches[1];
    $stmt = $pdo->prepare('SELECT id, name, email, created_at FROM users WHERE id = ?');
    $stmt->execute([$userId]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user) {
        echo json_encode($user);
    } else {
        http_response_code(404);
        echo json_encode(['error' => 'User not found']);
    }
} elseif ($path === '/api/users' && $method === 'GET') {
    // List users
    $stmt = $pdo->query('SELECT id, name, email, created_at FROM users LIMIT 100');
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($users);
} elseif ($path === '/api/users' && $method === 'POST') {
    // Create user
    $data = json_decode(file_get_contents('php://input'), true);

    // Validate input
    if (!isset($data['name']) || !isset($data['email']) || !isset($data['password'])) {
        http_response_code(400);
        echo json_encode(['error' => 'Missing required fields']);
        exit;
    }

    try {
        $stmt = $pdo->prepare('INSERT INTO users (name, email, password) VALUES (?, ?, ?)');
        $stmt->execute([
            $data['name'],
            $data['email'],
            password_hash($data['password'], PASSWORD_DEFAULT)
        ]);

        $userId = $pdo->lastInsertId();
        $user = [
            'id' => $userId,
            'name' => $data['name'],
            'email' => $data['email'],
            'created_at' => date('Y-m-d H:i:s')
        ];

        http_response_code(201);
        echo json_encode($user);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to create user']);
    }
} else {
    http_response_code(404);
    echo json_encode(['error' => 'Endpoint not found']);
}
```

**Giao tiếp giữa các microservices:**

```php
<?php
// OrderService.php - Service giao tiếp với UserService

namespace App\Services;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\GuzzleException;

class OrderService
{
    private $httpClient;
    private $userServiceUrl;

    public function __construct()
    {
        $this->httpClient = new Client();
        $this->userServiceUrl = env('USER_SERVICE_URL', 'http://user-service:8000');
    }

    public function createOrder($userId, array $items)
    {
        // Đầu tiên, kiểm tra xem user có tồn tại không
        $user = $this->getUserById($userId);

        if (!$user) {
            throw new \Exception("User not found");
        }

        // Tạo order trong database
        $order = new \App\Models\Order();
        $order->user_id = $userId;
        $order->total = array_sum(array_column($items, 'price'));
        $order->save();

        // Thêm các items
        foreach ($items as $item) {
            $order->items()->create($item);
        }

        // Gửi thông báo đến NotificationService
        $this->sendOrderNotification($user, $order);

        return $order;
    }

    private function getUserById($userId)
    {
        try {
            $response = $this->httpClient->get("{$this->userServiceUrl}/api/users/{$userId}");
            return json_decode($response->getBody(), true);
        } catch (GuzzleException $e) {
            // Log error
            \Log::error("Failed to fetch user: " . $e->getMessage());
            return null;
        }
    }

    private function sendOrderNotification($user, $order)
    {
        try {
            $notificationServiceUrl = env('NOTIFICATION_SERVICE_URL');
            $this->httpClient->post("{$notificationServiceUrl}/api/notifications", [
                'json' => [
                    'user_id' => $user['id'],
                    'email' => $user['email'],
                    'type' => 'order_created',
                    'data' => [
                        'order_id' => $order->id,
                        'total' => $order->total
                    ]
                ]
            ]);
        } catch (GuzzleException $e) {
            // Log error but don't fail the order process
            \Log::error("Failed to send notification: " . $e->getMessage());
        }
    }
}
```

**Service Discovery và API Gateway:**

```php
<?php
// api-gateway/index.php
header('Content-Type: application/json');

// Configuration for services
$services = [
    'users' => [
        'host' => 'user-service',
        'port' => 8001,
    ],
    'orders' => [
        'host' => 'order-service',
        'port' => 8002,
    ],
    'products' => [
        'host' => 'product-service',
        'port' => 8003,
    ],
    'notifications' => [
        'host' => 'notification-service',
        'port' => 8004,
    ],
];

// Parse request
$path = $_SERVER['REQUEST_URI'];
$method = $_SERVER['REQUEST_METHOD'];

// Extract service from path
if (preg_match('|^/api/([^/]+)(/.*)$|', $path, $matches)) {
    $serviceName = $matches[1];
    $servicePath = $matches[2];

    if (!isset($services[$serviceName])) {
        http_response_code(404);
        echo json_encode(['error' => 'Service not found']);
        exit;
    }

    $serviceConfig = $services[$serviceName];
    $serviceUrl = "http://{$serviceConfig['host']}:{$serviceConfig['port']}{$servicePath}";

    // Forward request to appropriate service
    $ch = curl_init($serviceUrl);

    // Set method
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, $method);

    // Forward headers
    $headers = getallheaders();
    $curlHeaders = [];
    foreach ($headers as $key => $value) {
        if ($key !== 'Host') {
            $curlHeaders[] = "$key: $value";
        }
    }
    curl_setopt($ch, CURLOPT_HTTPHEADER, $curlHeaders);

    // Forward request body for POST, PUT, PATCH
    if ($method === 'POST' || $method === 'PUT' || $method === 'PATCH') {
        $body = file_get_contents('php://input');
        curl_setopt($ch, CURLOPT_POSTFIELDS, $body);
    }

    // Return the response
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    // Forward status code and response
    http_response_code($httpCode);
    echo $response;
} else {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid API request']);
}
```

**Event-driven architecture và Queues:**

```php
<?php
// Sử dụng RabbitMQ để giao tiếp giữa các services

// 1. Publisher (OrderService)
// Khi một đơn hàng được tạo, publish một message vào queue

require_once __DIR__ . '/vendor/autoload.php';
use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Message\AMQPMessage;

class OrderEventPublisher
{
    private $connection;
    private $channel;

    public function __construct()
    {
        $this->connection = new AMQPStreamConnection(
            'rabbitmq', // host
            5672,        // port
            'guest',     // user
            'guest'      // password
        );
        $this->channel = $this->connection->channel();

        // Declare exchanges
        $this->channel->exchange_declare('orders', 'topic', false, true, false);
    }

    public function publishOrderCreated($order)
    {
        $routingKey = 'order.created';
        $message = new AMQPMessage(
            json_encode([
                'id' => $order->id,
                'user_id' => $order->user_id,
                'total' => $order->total,
                'items' => $order->items,
                'created_at' => $order->created_at->toIso8601String()
            ]),
            ['content_type' => 'application/json', 'delivery_mode' => AMQPMessage::DELIVERY_MODE_PERSISTENT]
        );

        $this->channel->basic_publish($message, 'orders', $routingKey);
        echo " [x] Sent order.created message\n";
    }

    public function close()
    {
        $this->channel->close();
        $this->connection->close();
    }
}

// Usage in OrderController
$publisher = new OrderEventPublisher();
$publisher->publishOrderCreated($order);
$publisher->close();


// 2. Consumer (NotificationService)
// Listen for messages and process them

require_once __DIR__ . '/vendor/autoload.php';
use PhpAmqpLib\Connection\AMQPStreamConnection;

class OrderEventConsumer
{
    private $connection;
    private $channel;
    private $emailService;

    public function __construct()
    {
        $this->connection = new AMQPStreamConnection(
            'rabbitmq', // host
            5672,        // port
            'guest',     // user
            'guest'      // password
        );
        $this->channel = $this->connection->channel();

        // Declare exchanges
        $this->channel->exchange_declare('orders', 'topic', false, true, false);

        // Declare queue
        $this->channel->queue_declare('notification_queue', false, true, false, false);

        // Bind queue to exchange
        $this->channel->queue_bind('notification_queue', 'orders', 'order.created');

        $this->emailService = new EmailService();
    }

    public function consume()
    {
        echo " [*] Waiting for order messages. To exit press CTRL+C\n";

        $this->channel->basic_consume(
            'notification_queue',    // queue
            '',                     // consumer tag
            false,                  // no local
            false,                  // no ack
            false,                  // exclusive
            false,                  // no wait
            function ($message) {   // callback
                $data = json_decode($message->body, true);
                echo " [x] Received order.created: {$data['id']}\n";

                // Process the order - send notification
                $this->processOrderCreated($data);

                // Acknowledge message
                $message->delivery_info['channel']->basic_ack($message->delivery_info['delivery_tag']);
            }
        );

        // Keep consuming messages until the script is stopped
        while (count($this->channel->callbacks)) {
            $this->channel->wait();
        }
    }

    private function processOrderCreated($orderData)
    {
        // Fetch user information
        $userApiClient = new UserApiClient();
        $user = $userApiClient->getUser($orderData['user_id']);

        if ($user) {
            // Send email notification
            $this->emailService->sendOrderConfirmation(
                $user['email'],
                $user['name'],
                $orderData['id'],
                $orderData['total']
            );

            echo " [x] Sent order confirmation email to {$user['email']}\n";
        } else {
            echo " [!] User not found: {$orderData['user_id']}\n";
        }
    }

    public function close()
    {
        $this->channel->close();
        $this->connection->close();
    }
}

// Run consumer
$consumer = new OrderEventConsumer();
$consumer->consume();
// This script will run continuously, processing messages as they arrive
```

---

## 🧑‍🏫 Bài 23: Progressive Web Apps và PHP

**Giới thiệu về Progressive Web Apps (PWA):**

```php
<?php
/*
Progressive Web Apps là các ứng dụng web có thể:
- Chạy offline hoặc khi kết nối chậm
- Được cài đặt lên màn hình home của thiết bị
- Gửi push notifications
- Tải nhanh và hoạt động mượt mà
- An toàn (HTTPS)

Các thành phần chính của PWA:
1. Service Workers - cho phép cache và làm việc offline
2. Web App Manifest - cung cấp metadata để cài đặt PWA
3. HTTPS - bảo mật
4. Responsive Design - hoạt động trên mọi thiết bị
5. Push Notifications - thu hút người dùng quay lại

PHP đóng vai trò làm backend API cho PWA
*/

// Tập trung vào phần PHP cho PWA - không có code PHP đặc biệt nào
// PHP cung cấp API endpoints mà PWA sẽ gọi để lấy dữ liệu
header('Content-Type: application/json');

// Cho phép CORS cho PWA
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}

// API endpoint để PWA có thể fetch dữ liệu
if ($_SERVER['REQUEST_METHOD'] === 'GET' && $_SERVER['REQUEST_URI'] === '/api/products') {
    $products = [
        ['id' => 1, 'name' => 'Product 1', 'price' => 19.99],
        ['id' => 2, 'name' => 'Product 2', 'price' => 29.99],
        // more products...
    ];

    // Return JSON response
    echo json_encode([
        'success' => true,
        'data' => $products
    ]);
    exit;
}

// Endpoint khác...
?>
```

**Web App Manifest và Service Workers:**

```html
<!-- Đây là file index.html phục vụ bởi PHP -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>PHP PWA Demo</title>

    <!-- Link to manifest file -->
    <link rel="manifest" href="/manifest.json" />

    <!-- Icons -->
    <link rel="icon" href="/images/icons/favicon.ico" type="image/x-icon" />
    <link rel="apple-touch-icon" href="/images/icons/icon-192x192.png" />
    <meta name="theme-color" content="#4285f4" />

    <style>
      /* Your styles here */
      body {
        font-family: Arial, sans-serif;
        padding: 20px;
        max-width: 800px;
        margin: 0 auto;
      }

      .product {
        border: 1px solid #ddd;
        padding: 10px;
        margin: 10px 0;
        border-radius: 5px;
      }

      .offline-message {
        background-color: #ff5252;
        color: white;
        padding: 10px;
        text-align: center;
        display: none;
      }
    </style>
  </head>
  <body>
    <div class="offline-message">
      You are currently offline. Some features might be unavailable.
    </div>

    <h1>PHP PWA Demo</h1>

    <div id="products-container">Loading products...</div>

    <button id="notification-button">Enable notifications</button>

    <script>
      // Check if service workers are supported
      if ("serviceWorker" in navigator) {
        window.addEventListener("load", function () {
          navigator.serviceWorker
            .register("/service-worker.js")
            .then(function (registration) {
              console.log(
                "ServiceWorker registration successful with scope: ",
                registration.scope
              );
            })
            .catch(function (error) {
              console.log("ServiceWorker registration failed: ", error);
            });
        });
      }

      // Check online status
      function updateOnlineStatus() {
        const offlineMessage = document.querySelector(".offline-message");
        if (navigator.onLine) {
          offlineMessage.style.display = "none";
          fetchProducts(); // Refresh data when back online
        } else {
          offlineMessage.style.display = "block";
        }
      }

      window.addEventListener("online", updateOnlineStatus);
      window.addEventListener("offline", updateOnlineStatus);
      updateOnlineStatus();

      // Fetch products from API
      function fetchProducts() {
        fetch("/api/products")
          .then((response) => response.json())
          .then((data) => {
            const container = document.getElementById("products-container");

            if (data.success) {
              container.innerHTML = "";
              data.data.forEach((product) => {
                const div = document.createElement("div");
                div.className = "product";
                div.innerHTML = `
                                <h3>${product.name}</h3>
                                <p>Price: $${product.price}</p>
                                <button onclick="addToCart(${product.id})">Add to cart</button>
                            `;
                container.appendChild(div);
              });
            } else {
              container.innerHTML = "<p>Failed to load products</p>";
            }
          })
          .catch((error) => {
            console.error("Error fetching products:", error);
            document.getElementById("products-container").innerHTML =
              "<p>Failed to load products. You might be offline.</p>";
          });
      }

      // Add to cart function
      function addToCart(productId) {
        // In a real app, this would save to local storage and sync when online
        alert(`Product ${productId} added to cart!`);
      }

      // Load products on page load
      fetchProducts();

      // Handle notifications
      document
        .getElementById("notification-button")
        .addEventListener("click", () => {
          Notification.requestPermission().then((permission) => {
            if (permission === "granted") {
              registerPushSubscription();
            }
          });
        });

      function registerPushSubscription() {
        // This would register with your server for push notifications
        console.log("Would register for push notifications here");
      }
    </script>
  </body>
</html>
```

**Manifest và Service Worker files:**

```json
// manifest.json
{
  "name": "PHP PWA Example",
  "short_name": "PHP PWA",
  "description": "A Progressive Web App example with PHP backend",
  "start_url": "/index.php",
  "display": "standalone",
  "background_color": "#ffffff",
  "theme_color": "#4285f4",
  "icons": [
    {
      "src": "/images/icons/icon-72x72.png",
      "sizes": "72x72",
      "type": "image/png"
    },
    {
      "src": "/images/icons/icon-96x96.png",
      "sizes": "96x96",
      "type": "image/png"
    },
    {
      "src": "/images/icons/icon-128x128.png",
      "sizes": "128x128",
      "type": "image/png"
    },
    {
      "src": "/images/icons/icon-144x144.png",
      "sizes": "144x144",
      "type": "image/png"
    },
    {
      "src": "/images/icons/icon-152x152.png",
      "sizes": "152x152",
      "type": "image/png"
    },
    {
      "src": "/images/icons/icon-192x192.png",
      "sizes": "192x192",
      "type": "image/png"
    },
    {
      "src": "/images/icons/icon-384x384.png",
      "sizes": "384x384",
      "type": "image/png"
    },
    {
      "src": "/images/icons/icon-512x512.png",
      "sizes": "512x512",
      "type": "image/png"
    }
  ]
}
```

```javascript
// service-worker.js
const CACHE_NAME = "php-pwa-v1";
const urlsToCache = [
  "/",
  "/index.php",
  "/css/style.css",
  "/js/app.js",
  "/offline.html",
  "/images/logo.png",
];

// Install event - cache assets
self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      console.log("Opened cache");
      return cache.addAll(urlsToCache);
    })
  );
});

// Activate event - clean up old caches
self.addEventListener("activate", (event) => {
  const cacheWhitelist = [CACHE_NAME];
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheWhitelist.indexOf(cacheName) === -1) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});

// Fetch event - serve from cache first, then network
self.addEventListener("fetch", (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => {
      // Cache hit - return response
      if (response) {
        return response;
      }

      // Clone the request because it's a one-time use stream
      const fetchRequest = event.request.clone();

      return fetch(fetchRequest)
        .then((response) => {
          // Check if we received a valid response
          if (
            !response ||
            response.status !== 200 ||
            response.type !== "basic"
          ) {
            return response;
          }

          // Clone the response because it's a one-time use stream
          const responseToCache = response.clone();

          // Open a cache and write the response to it
          caches.open(CACHE_NAME).then((cache) => {
            // Don't cache API responses - these should be fresh
            if (!event.request.url.includes("/api/")) {
              cache.put(event.request, responseToCache);
            }
          });

          return response;
        })
        .catch(() => {
          // If fetch fails (offline), try to serve the offline page
          if (event.request.mode === "navigate") {
            return caches.match("/offline.html");
          }
        });
    })
  );
});

// Handle push notifications
self.addEventListener("push", (event) => {
  const data = event.data.json();
  const options = {
    body: data.body,
    icon: "/images/icons/icon-192x192.png",
    badge: "/images/icons/badge-72x72.png",
    data: {
      url: data.url,
    },
  };

  event.waitUntil(self.registration.showNotification(data.title, options));
});

// Handle notification clicks
self.addEventListener("notificationclick", (event) => {
  event.notification.close();

  if (event.notification.data && event.notification.data.url) {
    event.waitUntil(clients.openWindow(event.notification.data.url));
  }
});
```

**PHP để handle Push Notifications:**

```php
<?php
// push-notification.php
header('Content-Type: application/json');

// In production, you would use a library like web-push-php
// https://github.com/web-push-libs/web-push-php

require __DIR__ . '/vendor/autoload.php';

use Minishlink\WebPush\WebPush;
use Minishlink\WebPush\Subscription;

// Endpoint to save subscription
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $_SERVER['REQUEST_URI'] === '/api/subscribe') {
    $subscription = json_decode(file_get_contents('php://input'), true);

    if (!isset($subscription['endpoint'])) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Subscription data invalid']);
        exit;
    }

    // In production, you would save this subscription in a database
    // For this example, we just write it to a file
    $subscriptions = json_decode(file_get_contents('subscriptions.json'), true) ?: [];
    $subscriptions[] = $subscription;
    file_put_contents('subscriptions.json', json_encode($subscriptions));

    echo json_encode(['success' => true, 'message' => 'Subscription saved']);
    exit;
}

// Endpoint to send push notification to all subscribers
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $_SERVER['REQUEST_URI'] === '/api/send-notification') {
    $auth = [
        'VAPID' => [
            'subject' => 'mailto:admin@example.com',
            'publicKey' => 'YOUR_PUBLIC_KEY',
            'privateKey' => 'YOUR_PRIVATE_KEY',
        ],
    ];

    $webPush = new WebPush($auth);

    $subscriptions = json_decode(file_get_contents('subscriptions.json'), true) ?: [];
    $payload = json_encode([
        'title' => 'New Notification',
        'body' => 'This is a test notification from our PHP backend!',
        'url' => 'https://yoursite.com/some-page'
    ]);

    $results = [];

    foreach ($subscriptions as $subscription) {
        $webPush->sendNotification(
            Subscription::create($subscription),
            $payload
        );
        $results[] = $webPush->flush();
    }

    echo json_encode(['success' => true, 'results' => $results]);
    exit;
}

// Invalid endpoint
http_response_code(404);
echo json_encode(['success' => false, 'message' => 'Endpoint not found']);
```

**Offline First Strategy:**

```php
<?php
// offline.html - Served by the service worker when offline
// This would be delivered by PHP when the user is online
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>You Are Offline</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            text-align: center;
        }
        .offline-banner {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
        .cached-data {
            border: 1px solid #ddd;
            padding: 15px;
            margin-top: 20px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="offline-banner">
        <h1>You are currently offline</h1>
        <p>Please check your internet connection and try again.</p>
    </div>

    <div class="cached-data">
        <h2>Your previously loaded data:</h2>
        <div id="cached-content">
            <!-- This will be filled with cached content via JS -->
        </div>
    </div>

    <script>
        // When offline, try to display any data we've cached
        document.addEventListener('DOMContentLoaded', () => {
            // Check for cached products
            if ('caches' in window) {
                caches.match('/api/products')
                    .then(response => {
                        if (response) {
                            return response.json();
                        }
                        return {success: false};
                    })
                    .then(data => {
                        const container = document.getElementById('cached-content');

                        if (data.success) {
                            let html = '<ul>';
                            data.data.forEach(product => {
                                html += `<li>${product.name} - $${product.price}</li>`;
                            });
                            html += '</ul>';
                            container.innerHTML = html;
                        } else {
                            container.innerHTML = '<p>No cached content available.</p>';
                        }
                    })
                    .catch(error => {
                        document.getElementById('cached-content').innerHTML =
                            '<p>No cached content available.</p>';
                    });
            }
        });
    </script>
</body>
</html>
```

---

## 🧑‍🏫 Bài 24: GraphQL API trong PHP

**Giới thiệu về GraphQL:**

```php
<?php
/*
GraphQL là một ngôn ngữ truy vấn dành cho API và một runtime để thực hiện các truy vấn đó.

Ưu điểm so với REST:
- Lấy chính xác dữ liệu cần thiết (không over-fetching)
- Lấy nhiều tài nguyên liên quan trong một request (không under-fetching)
- Mạnh mẽ với type system rõ ràng
- API tiến hóa mà không cần versioning
- Introspection - API tự mô tả

Các khái niệm cơ bản:
- Schema: Định nghĩa dữ liệu có sẵn để truy vấn
- Types: Định nghĩa cấu trúc dữ liệu (như model)
- Queries: Lấy dữ liệu (tương tự GET trong REST)
- Mutations: Thay đổi dữ liệu (tương tự POST, PUT, DELETE trong REST)
- Resolvers: Hàm xử lý để trả về dữ liệu
*/

// Để triển khai GraphQL trong PHP, chúng ta cần một thư viện như webonyx/graphql-php
// composer require webonyx/graphql-php
```

**Xây dựng GraphQL server đơn giản:**

```php
<?php
// index.php
require_once __DIR__ . '/vendor/autoload.php';

use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;
use GraphQL\Type\Schema;
use GraphQL\GraphQL;
use GraphQL\Error\FormattedError;

// Kết nối database (trong thực tế sẽ dùng repository pattern)
try {
    $pdo = new PDO('mysql:host=localhost;dbname=graphql_demo', 'root', 'password');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Database connection failed: " . $e->getMessage());
}

// Define Types
$userType = new ObjectType([
    'name' => 'User',
    'description' => 'A user in our system',
    'fields' => [
        'id' => Type::id(),
        'name' => Type::string(),
        'email' => Type::string(),
        'posts' => [
            'type' => Type::listOf(new ObjectType([
                'name' => 'Post',
                'fields' => [
                    'id' => Type::id(),
                    'title' => Type::string(),
                    'content' => Type::string(),
                    'created_at' => Type::string()
                ]
            ])),
            'resolve' => function($user) use ($pdo) {
                $stmt = $pdo->prepare("SELECT * FROM posts WHERE user_id = ?");
                $stmt->execute([$user['id']]);
                return $stmt->fetchAll(PDO::FETCH_ASSOC);
            }
        ]
    ]
]);

// Define Query Type
$queryType = new ObjectType([
    'name' => 'Query',
    'fields' => [
        'user' => [
            'type' => $userType,
            'args' => [
                'id' => Type::nonNull(Type::id())
            ],
            'resolve' => function($root, $args) use ($pdo) {
                $stmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
                $stmt->execute([$args['id']]);
                return $stmt->fetch(PDO::FETCH_ASSOC);
            }
        ],
        'users' => [
            'type' => Type::listOf($userType),
            'resolve' => function($root, $args) use ($pdo) {
                $stmt = $pdo->query("SELECT * FROM users LIMIT 100");
                return $stmt->fetchAll(PDO::FETCH_ASSOC);
            }
        ]
    ]
]);

// Define Mutation Type
$mutationType = new ObjectType([
    'name' => 'Mutation',
    'fields' => [
        'createUser' => [
            'type' => $userType,
            'args' => [
                'name' => Type::nonNull(Type::string()),
                'email' => Type::nonNull(Type::string())
            ],
            'resolve' => function($root, $args) use ($pdo) {
                $stmt = $pdo->prepare("INSERT INTO users (name, email) VALUES (?, ?)");
                $stmt->execute([$args['name'], $args['email']]);

                $id = $pdo->lastInsertId();

                return [
                    'id' => $id,
                    'name' => $args['name'],
                    'email' => $args['email']
                ];
            }
        ]
    ]
]);

// Create Schema
$schema = new Schema([
    'query' => $queryType,
    'mutation' => $mutationType
]);

// Handle incoming GraphQL request
$rawInput = file_get_contents('php://input');
$input = json_decode($rawInput, true);
$query = $input['query'] ?? null;
$variableValues = $input['variables'] ?? null;

try {
    $result = GraphQL::executeQuery(
        $schema,
        $query,
        null,
        null,
        $variableValues
    );
    $output = $result->toArray();
} catch (Exception $e) {
    $output = [
        'errors' => [FormattedError::createFromException($e)]
    ];
}

// Return response
header('Content-Type: application/json');
echo json_encode($output);
```

**GraphQL với Laravel:**

```php
<?php
// Sử dụng package rebing/graphql-laravel
// composer require rebing/graphql-laravel

// config/graphql.php
return [
    'route' => [
        'prefix' => 'graphql',
        'middleware' => [
            \App\Http\Middleware\EncryptCookies::class,
            \Illuminate\Cookie\Middleware\AddQueuedCookiesToResponse::class,
            \Illuminate\Session\Middleware\StartSession::class,
            \Illuminate\View\Middleware\ShareErrorsFromSession::class,
            \App\Http\Middleware\VerifyCsrfToken::class,
        ],
    ],

    'schemas' => [
        'default' => [
            'query' => [
                'users' => \App\GraphQL\Queries\UsersQuery::class,
                'user' => \App\GraphQL\Queries\UserQuery::class,
            ],
            'mutation' => [
                'createUser' => \App\GraphQL\Mutations\CreateUserMutation::class,
                'updateUser' => \App\GraphQL\Mutations\UpdateUserMutation::class,
            ],
        ],
    ],

    'types' => [
        'User' => \App\GraphQL\Types\UserType::class,
        'Post' => \App\GraphQL\Types\PostType::class,
    ],
];

// app/GraphQL/Types/UserType.php
namespace App\GraphQL\Types;

use App\Models\User;
use GraphQL\Type\Definition\Type;
use Rebing\GraphQL\Support\Type as GraphQLType;
use Rebing\GraphQL\Support\Facades\GraphQL;

class UserType extends GraphQLType
{
    protected $attributes = [
        'name' => 'User',
        'description' => 'A user',
        'model' => User::class,
    ];

    public function fields(): array
    {
        return [
            'id' => [
                'type' => Type::nonNull(Type::id()),
                'description' => 'The id of the user',
            ],
            'name' => [
                'type' => Type::string(),
                'description' => 'The name of user',
            ],
            'email' => [
                'type' => Type::string(),
                'description' => 'The email of user',
            ],
            'posts' => [
                'type' => Type::listOf(GraphQL::type('Post')),
                'description' => 'The user\'s posts',
            ],
        ];
    }
}

// app/GraphQL/Queries/UserQuery.php
namespace App\GraphQL\Queries;

use App\Models\User;
use GraphQL\Type\Definition\Type;
use Rebing\GraphQL\Support\Facades\GraphQL;
use Rebing\GraphQL\Support\Query;

class UserQuery extends Query
{
    protected $attributes = [
        'name' => 'user',
    ];

    public function type(): Type
    {
        return GraphQL::type('User');
    }

    public function args(): array
    {
        return [
            'id' => [
                'name' => 'id',
                'type' => Type::nonNull(Type::id()),
            ],
        ];
    }

    public function resolve($root, $args)
    {
        return User::findOrFail($args['id']);
    }
}

// app/GraphQL/Mutations/CreateUserMutation.php
namespace App\GraphQL\Mutations;

use App\Models\User;
use GraphQL\Type\Definition\Type;
use Rebing\GraphQL\Support\Facades\GraphQL;
use Rebing\GraphQL\Support\Mutation;

class CreateUserMutation extends Mutation
{
    protected $attributes = [
        'name' => 'createUser',
    ];

    public function type(): Type
    {
        return GraphQL::type('User');
    }

    public function args(): array
    {
        return [
            'name' => [
                'name' => 'name',
                'type' => Type::nonNull(Type::string()),
            ],
            'email' => [
                'name' => 'email',
                'type' => Type::nonNull(Type::string()),
            ],
            'password' => [
                'name' => 'password',
                'type' => Type::nonNull(Type::string()),
            ],
        ];
    }

    public function resolve($root, $args)
    {
        $user = new User();
        $user->name = $args['name'];
        $user->email = $args['email'];
        $user->password = bcrypt($args['password']);
        $user->save();

        return $user;
    }
}
```

**GraphQL Queries and Mutations:**

```graphql
# Example GraphQL query to fetch a user with their posts
query {
  user(id: 1) {
    id
    name
    email
    posts {
      id
      title
      content
    }
  }
}

# Query with variables
query GetUser($id: ID!) {
  user(id: $id) {
    id
    name
    email
  }
}
# Variables: { "id": 1 }

# Mutation to create a user
mutation {
  createUser(
    name: "John Doe"
    email: "john@example.com"
    password: "secret123"
  ) {
    id
    name
    email
  }
}

# Complex query with multiple fields and nested objects
query {
  users {
    id
    name
    posts {
      id
      title
      comments {
        id
        content
        user {
          name
        }
      }
    }
  }
}
```

**Authentication và Authorization trong GraphQL:**

```php
<?php
// Authentication middleware in Laravel
// app/GraphQL/Mutations/CreatePostMutation.php
namespace App\GraphQL\Mutations;

use App\Models\Post;
use GraphQL\Type\Definition\Type;
use Rebing\GraphQL\Support\Facades\GraphQL;
use Rebing\GraphQL\Support\Mutation;

class CreatePostMutation extends Mutation
{
    protected $attributes = [
        'name' => 'createPost',
    ];

    public function type(): Type
    {
        return GraphQL::type('Post');
    }

    public function args(): array
    {
        return [
            'title' => [
                'name' => 'title',
                'type' => Type::nonNull(Type::string()),
            ],
            'content' => [
                'name' => 'content',
                'type' => Type::nonNull(Type::string()),
            ],
        ];
    }

    // Middleware to ensure user is authenticated
    public function authorize($root, array $args, $ctx, $resolveInfo): bool
    {
        // Get currently authenticated user
        $user = auth()->user();

        // Check if user is logged in
        if (!$user) {
            return false;
        }

        return true;
    }

    public function getAuthorizationMessage(): string
    {
        return 'You must be logged in to create a post';
    }

    public function resolve($root, $args)
    {
        $user = auth()->user();

        $post = new Post();
        $post->title = $args['title'];
        $post->content = $args['content'];
        $post->user_id = $user->id;
        $post->save();

        return $post;
    }
}

// Using authorization in query to check permissions
// app/GraphQL/Queries/AdminStatsQuery.php
namespace App\GraphQL\Queries;

use GraphQL\Type\Definition\Type;
use Rebing\GraphQL\Support\Query;

class AdminStatsQuery extends Query
{
    protected $attributes = [
        'name' => 'adminStats',
    ];

    public function type(): Type
    {
        return Type::nonNull(Type::string());
    }

    public function authorize($root, array $args, $ctx, $resolveInfo): bool
    {
        $user = auth()->user();

        // Check if user is an admin
        return $user && $user->isAdmin();
    }

    public function resolve($root, $args)
    {
        // Only admins can access this data
        return json_encode([
            'totalUsers' => \App\Models\User::count(),
            'totalPosts' => \App\Models\Post::count(),
            'activeUsers' => \App\Models\User::where('active', true)->count(),
        ]);
    }
}
```

**N+1 Problem và Batch Loading:**

```php
<?php
// Xử lý vấn đề N+1 với Dataloader trong PHP
// composer require overblog/dataloader-php

use Overblog\DataLoader\DataLoader;

// Setup batch loading for users
$userLoader = new DataLoader(function($userIds) use ($pdo) {
    // Load all users at once instead of one by one
    $placeholders = implode(',', array_fill(0, count($userIds), '?'));
    $stmt = $pdo->prepare("SELECT * FROM users WHERE id IN ($placeholders)");
    $stmt->execute($userIds);
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Index users by ID for easy lookup
    $indexedUsers = [];
    foreach ($users as $user) {
        $indexedUsers[$user['id']] = $user;
    }

    // Return users in the same order they were requested
    return array_map(function($userId) use ($indexedUsers) {
        return $indexedUsers[$userId] ?? null;
    }, $userIds);
});

// GraphQL resolver that uses the batch loader
$postType = new ObjectType([
    'name' => 'Post',
    'fields' => [
        'id' => Type::id(),
        'title' => Type::string(),
        'content' => Type::string(),
        'user' => [
            'type' => $userType,
            'resolve' => function($post) use ($userLoader) {
                return $userLoader->load($post['user_id']);
            }
        ]
    ]
]);

// Using in Laravel with a custom directive
// Create a custom directive for batch loading
// app/GraphQL/Directives/UserDirective.php
namespace App\GraphQL\Directives;

use Nuwave\Lighthouse\Schema\Directives\BaseDirective;
use Nuwave\Lighthouse\Schema\Values\FieldValue;
use Nuwave\Lighthouse\Support\Contracts\FieldResolver;
use Nuwave\Lighthouse\Support\DataLoader\BatchLoader;

class UserDirective extends BaseDirective implements FieldResolver
{
    public function resolveField(FieldValue $fieldValue)
    {
        return $fieldValue->setResolver(function ($post, array $args, $context, $info) {
            // Get the batch loader with a unique key for this field
            $loader = BatchLoader::instance('users', function ($userIds, $context, $info) {
                // Load all users at once
                return \App\Models\User::whereIn('id', $userIds)->get()->keyBy('id');
            });

            // Load the user by ID
            return $loader->load($post->user_id);
        });
    }
}
```

---

## 🧑‍🏫 Bài 25: JIT trong PHP 8 và Beyond

**Giới thiệu về JIT (Just-In-Time) Compiler trong PHP 8:**

```php
<?php
/*
JIT (Just-In-Time) Compilation trong PHP 8 là gì?

- PHP truyền thống: interprets (thông dịch) code khi chạy
- JIT: biên dịch code PHP thành mã máy khi chạy
- Mục đích: tăng tốc độ thực thi, đặc biệt với code tính toán nhiều

Các mode JIT trong PHP 8:
- disabled: Tắt JIT
- function: Biên dịch toàn bộ hàm
- tracing: Biên dịch các đường dẫn thực thi (trace) bên trong hàm
*/

// Cách bật JIT trong php.ini
/*
zend_extension=opcache
opcache.enable=1
opcache.enable_cli=1
opcache.jit_buffer_size=100M  ; Kích thước bộ nhớ JIT
opcache.jit=1255              ; Mode JIT (tracing)
*/

// Kiểm tra JIT có được bật hay không
var_dump(opcache_get_status()['jit']);
?>
```

**Hiệu suất với JIT:**

```php
<?php
// Ví dụ benchmark hiệu suất JIT
// Hàm tính toán số lớn - được hưởng lợi từ JIT
function calculate_sum_of_squares($n) {
    $sum = 0;
    for ($i = 0; $i < $n; $i++) {
        $sum += $i * $i;
    }
    return $sum;
}

// Đo thời gian thực thi
function benchmark($function, $iterations, ...$args) {
    $start = microtime(true);

    for ($i = 0; $i < $iterations; $i++) {
        $function(...$args);
    }

    $end = microtime(true);
    return $end - $start;
}

// Chạy benchmark
$iterations = 1000;
$time = benchmark('calculate_sum_of_squares', $iterations, 1000000);
echo "Time taken for {$iterations} iterations: {$time} seconds\n";
echo "Average time per call: " . ($time / $iterations) . " seconds\n";

// Thực hiện benchmark với các mode JIT khác nhau
// JIT disabled: opcache.jit=0
// JIT function: opcache.jit=1255
// JIT tracing: opcache.jit=1205
?>
```

**Tận dụng tối đa JIT:**

````php
<?php
// JIT giúp tăng tốc độ code nặng về tính toán
// Ví dụ: thuật toán Mandelbrot set
function mandelbrot($w, $h, $max_iteration) {
    $result = [];

    for ($y = 0; $y < $h; $y++) {
        for ($x = 0; $x < $w; $x++) {
            $c_re = (($x * 3.5) / $w) - 2.5;
            $c_im = (($y *<!-- filepath: /home/klpod221/Develop/lesson-plan/PHP/Part5.md -->
# 📘 PHẦN 5: XU HƯỚNG HIỆN ĐẠI VÀ CÔNG NGHỆ MỚI TRONG PHP


- [📘 PHẦN 5: XU HƯỚNG HIỆN ĐẠI VÀ CÔNG NGHỆ MỚI TRONG PHP](#-phần-5-xu-hướng-hiện-đại-và-công-nghệ-mới-trong-php)
  - [Nội dung](#nội-dung)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 21: PHP và Containers (Docker)](#-bài-21-php-và-containers-docker)
  - [🧑‍🏫 Bài 22: Microservices với PHP](#-bài-22-microservices-với-php)
  - [🧑‍🏫 Bài 23: Progressive Web Apps và PHP](#-bài-23-progressive-web-apps-và-php)
  - [🧑‍🏫 Bài 24: GraphQL API trong PHP](#-bài-24-graphql-api-trong-php)
  - [🧑‍🏫 Bài 25: JIT trong PHP 8 và Beyond](#-bài-25-jit-trong-php-8-và-beyond)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN](#-bài-tập-lớn-cuối-phần)
    - [**Đề bài: Xây dựng hệ thống Microservice với PHP và Docker**](#đề-bài-xây-dựng-hệ-thống-microservice-với-php-và-docker)
    - [**Yêu cầu:**](#yêu-cầu)
    - [**Cấu trúc dự án:**](#cấu-trúc-dự-án)

## 🎯 Mục tiêu tổng quát

- Nắm vững việc triển khai ứng dụng PHP trong container với Docker
- Hiểu và áp dụng kiến trúc Microservices trong dự án PHP
- Biết cách xây dựng Progressive Web Apps với API PHP
- Làm chủ GraphQL để phát triển API hiện đại
- Tối ưu hiệu năng ứng dụng với các tính năng mới của PHP 8+

---

## 🧑‍🏫 Bài 21: PHP và Containers (Docker)

**Giới thiệu về Docker và containers:**

```bash
# Cài đặt Docker trên Ubuntu
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce docker-compose

# Kiểm tra cài đặt
docker --version
docker-compose --version

# Chạy container đầu tiên
docker run hello-world
````

**Dockerfile cơ bản cho PHP:**

```dockerfile
# Dockerfile
FROM php:8.1-fpm

# Cài đặt các dependencies hệ thống
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev

# Cài đặt các PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Cài đặt Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Thiết lập thư mục làm việc
WORKDIR /var/www

# Sao chép source code vào container
COPY . /var/www

# Cài đặt các dependencies từ Composer
RUN composer install --optimize-autoloader --no-dev

# Thiết lập quyền cho storage và cache
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Mở cổng để kết nối
EXPOSE 9000

# Khởi động PHP-FPM
CMD ["php-fpm"]
```

**Docker Compose cho stack LEMP (Linux, Nginx, MySQL, PHP):**

```yaml
# docker-compose.yml
version: "3"

services:
  # PHP Service
  php:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: app_php
    restart: unless-stopped
    volumes:
      - ./:/var/www
      - ./docker/php/local.ini:/usr/local/etc/php/conf.d/local.ini
    networks:
      - app-network

  # Nginx Service
  nginx:
    image: nginx:alpine
    container_name: app_nginx
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./:/var/www
      - ./docker/nginx/conf.d/:/etc/nginx/conf.d/
      - ./docker/nginx/ssl/:/etc/nginx/ssl/
    networks:
      - app-network

  # MySQL Service
  mysql:
    image: mysql:5.7
    container_name: app_mysql
    restart: unless-stopped
    ports:
      - "3306:3306"
    environment:
      MYSQL_DATABASE: ${DB_DATABASE}
      MYSQL_ROOT_PASSWORD: ${DB_PASSWORD}
      MYSQL_PASSWORD: ${DB_PASSWORD}
      MYSQL_USER: ${DB_USERNAME}
      SERVICE_TAGS: dev
      SERVICE_NAME: mysql
    volumes:
      - dbdata:/var/lib/mysql
      - ./docker/mysql/my.cnf:/etc/mysql/my.cnf
    networks:
      - app-network

  # Redis Service
  redis:
    image: redis:alpine
    container_name: app_redis
    restart: unless-stopped
    ports:
      - "6379:6379"
    networks:
      - app-network

networks:
  app-network:
    driver: bridge

volumes:
  dbdata:
    driver: local
```

**Cấu hình Nginx trong Docker:**

```nginx
# docker/nginx/conf.d/default.conf
server {
    listen 80;
    server_name localhost;
    root /var/www/public;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-XSS-Protection "1; mode=block";
    add_header X-Content-Type-Options "nosniff";

    index index.php index.html index.htm;

    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    error_page 404 /index.php;

    location ~ \.php$ {
        fastcgi_pass php:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}
```

**Triển khai và quản lý container PHP:**

```bash
# Khởi động stack
docker-compose up -d

# Kiểm tra các container đang chạy
docker-compose ps

# Truy cập vào container PHP
docker-compose exec php bash

# Chạy các lệnh trong container PHP
docker-compose exec php php artisan migrate

# Xem logs của container
docker-compose logs -f nginx

# Dừng và xóa các containers
docker-compose down

# Dừng, xóa containers và cả volumes
docker-compose down -v
```

**Thực hành tốt nhất với Docker và PHP:**

```bash
# 1. Sử dụng multi-stage builds để giảm kích thước image
# Dockerfile.optimized
FROM composer:2.0 as build
WORKDIR /app
COPY . /app
RUN composer install --optimize-autoloader --no-dev

FROM php:8.1-fpm-alpine
WORKDIR /var/www
COPY --from=build /app /var/www
EXPOSE 9000
CMD ["php-fpm"]

# 2. Sử dụng Docker layers cache hiệu quả
# Sắp xếp các lệnh từ ít thay đổi đến nhiều thay đổi
COPY composer.json composer.lock ./
RUN composer install --no-scripts
COPY . .

# 3. Sử dụng Docker Volumes cho dữ liệu cần lưu trữ
docker run -v $(pwd):/var/www my-php-app

# 4. Tối ưu hóa healthchecks
# docker-compose.yml
services:
  php:
    # ...
    healthcheck:
      test: ["CMD", "php", "-r", "if(mysqli_connect('mysql', 'root', 'password')) {exit(0);} else {exit(1);}"]
      interval: 30s
      timeout: 10s

    retries: 3
```

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Xây dựng hệ thống Microservice với PHP và Docker**

### **Yêu cầu:**

1. **Xây dựng hệ thống gồm 3 microservices:**

**User Service:** Quản lý người dùng (đăng ký, đăng nhập, thông tin cá nhân)

- **Order Service:** Quản lý đơn hàng (tạo đơn, thanh toán, lịch sử)

  **Mỗi service phải có:**

- Cơ sở dữ liệu riêng (MySQL)
- API RESTful hoặc GraphQL

Được containerized với Docker
Logging và monitoring

3. **API Gateway:**

- Tạo gateway để điều hướng request đến đúng service
- Xử lý authentication/authorization tập trung

4. **Giao tiếp giữa các services:**

- Sử dụng RabbitMQ hoặc Redis để giao tiếp bất đồng bộ
- Triển khai event-driven architecture

5. **Frontend:**

- Xây dựng một SPA đơn giản sử dụng API từ các services
- Áp dụng các nguyên tắc Progressive Web App

### **Cấu trúc dự án:**

```text
e-commerce-microservices/
├── docker-compose.yml
├── api-gateway/
│   ├── Dockerfile
│   └── src/
├── user-service/
│   ├── Dockerfile
│   ├── src/

  └── database/
├── product-service/
│   ├── Dockerfile
│   ├── src/
│   └── database/
├── order-service/
│   ├── Dockerfile
│   ├── src/
│   └── database/
├── frontend/
│   ├── Dockerfile
│   └── src/
└── message-broker/
   └── rabbitmq/
```

- **Product Service:** Quản lý sản phẩm (danh sách, chi tiết, tìm kiếm)
- **Order Service:** Quản lý đơn hàng (tạo đơn, thanh toán, lịch sử)
- **Message Broker:** RabbitMQ hoặc Redis
- **Frontend:** SPA sử dụng React/Vue/Angular
- **API Gateway:** Nginx hoặc Kong
- **Database:** MySQL cho mỗi service

---

[⬅️ Trở lại: PHP/Part4.md](../PHP/Part4.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: PHP/Part6.md](../PHP/Part6.md)
