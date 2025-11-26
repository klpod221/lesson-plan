---
prev:
  text: '🏗️ Frameworks & Applications'
  link: '/PHP/Part4'
next:
  text: '🌐 Professional Deployment'
  link: '/PHP/Part6'
---

# 📘 PART 5: MODERN TRENDS AND NEW TECHNOLOGIES IN PHP

## 🎯 General Objectives

- Master deploying PHP applications in containers with Docker.
- Understand and apply Microservices architecture in PHP projects.
- Know how to build Progressive Web Apps with PHP APIs.
- Master GraphQL for modern API development.
- Optimize application performance with new features of PHP 8+.

## 🧑‍🏫 Lesson 21: PHP and Containers (Docker)

### Introduction to Docker and Containers

```bash
# Install Docker on Ubuntu
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce docker-compose

# Verify installation
docker --version
docker-compose --version

# Run first container
docker run hello-world
```

### Basic Dockerfile for PHP

```dockerfile
# Dockerfile
FROM php:8.1-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy source code to container
COPY . /var/www

# Install Composer dependencies
RUN composer install --optimize-autoloader --no-dev

# Set permissions for storage and cache
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Expose port
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]
```

### Docker Compose for LEMP Stack (Linux, Nginx, MySQL, PHP)

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

### Configure Nginx in Docker

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

### Deploy and Manage PHP Containers

```bash
# Start stack
docker-compose up -d

# Check running containers
docker-compose ps

# Access PHP container
docker-compose exec php bash

# Run commands in PHP container
docker-compose exec php php artisan migrate

# View container logs
docker-compose logs -f nginx

# Stop and remove containers
docker-compose down

# Stop, remove containers and volumes
docker-compose down -v
```

### Docker and PHP Best Practices

```bash
# 1. Use multi-stage builds to reduce image size
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

# 2. Use Docker layers cache efficiently
# Order commands from least changing to most changing
COPY composer.json composer.lock ./
RUN composer install --no-scripts
COPY . .

# 3. Use Docker Volumes for persistent data
docker run -v $(pwd):/var/www my-php-app

# 4. Optimize healthchecks
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

## 🧑‍🏫 Lesson 22: Microservices with PHP

### Introduction to Microservices Architecture

Microservices is a software development method, a variant of the Service-Oriented Architecture (SOA).

- Characteristics:

  - Divides the application into small, independent services.
  - Each service is responsible for a specific function.
  - Services communicate via API, message queues.
  - Easy to scale services individually.
  - Can use different technologies for different services.

- Comparison with Monolithic:

  - Monolithic: Entire application is a single unit, hard to scale, hard to maintain when large.
  - Microservice: Split up, easy to maintain, easy to scale, but more complex to manage.

```php
<?php
// Simple example of services in microservice architecture
// UserService: User Management
namespace App\Services\User;

use App\Models\User;

class UserService
{
    public function getUser($id)
    {
        // Get user info
        return User::findOrFail($id);
    }

    public function createUser(array $data)
    {
        // Create new user
        return User::create($data);
    }

    // Other user-related functions...
}

// OrderService: Order Management
namespace App\Services\Order;

use App\Models\Order;

class OrderService
{
    public function createOrder($userId, array $items)
    {
        // Create order
        $order = new Order();
        $order->user_id = $userId;
        $order->save();

        // Add items to order
        $order->items()->createMany($items);

        return $order;
    }

    // Other order-related functions...
}
?>
```

### Building RESTful Microservices with PHP

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

### Communication Between Microservices

```php
<?php
// OrderService.php - Service communicating with UserService

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
        // First, check if user exists
        $user = $this->getUserById($userId);

        if (!$user) {
            throw new \Exception("User not found");
        }

        // Create order in database
        $order = new \App\Models\Order();
        $order->user_id = $userId;
        $order->total = array_sum(array_column($items, 'price'));
        $order->save();

        // Add items
        foreach ($items as $item) {
            $order->items()->create($item);
        }

        // Send notification to NotificationService
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

### Service Discovery and API Gateway

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

### Event-driven architecture and Queues

```php
<?php
// Using RabbitMQ to communicate between services

// 1. Publisher (OrderService)
// When an order is created, publish a message to the queue

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

## 🧑‍🏫 Lesson 23: Progressive Web Apps and PHP

### Introduction to Progressive Web Apps (PWA)

- Progressive Web Apps are web applications that can:
  - Run offline or on slow connections.
  - Be installed on the device home screen.
  - Send push notifications.
  - Load fast and perform smoothly.
  - Be secure (HTTPS).

Key components of PWA:

1. **Service Workers** - allow caching and offline work.
2. **Web App Manifest** - provides metadata for PWA installation.
3. **HTTPS** - security.
4. **Responsive Design** - works on all devices.
5. **Push Notifications** - engage users to return.

PHP acts as the backend API for PWA.

```php
<?php
// Focus on PHP part for PWA - no special PHP code
// PHP provides API endpoints that PWA will call to get data
header('Content-Type: application/json');

// Allow CORS for PWA
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}

// API endpoint for PWA to fetch data
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

// Other endpoints...
?>
```

### Web App Manifest and Service Workers

```html
<!-- This is index.html served by PHP -->
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

### Manifest and Service Worker files

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

### PHP to Handle Push Notifications

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

### Offline First Strategy

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

## 🧑‍🏫 Lesson 24: GraphQL API in PHP

### Introduction to GraphQL

- GraphQL is a query language for APIs and a runtime for fulfilling those queries.

  - Advantages over REST:
  - Get exactly the data needed (no over-fetching).
  - Get multiple related resources in a single request (no under-fetching).
  - Strong typing system.
  - API evolution without versioning.
  - Introspection - Self-describing API.

- Basic Concepts:
  - Schema: Defines available data to query.
  - Types: Defines data structures (like models).
  - Queries: Fetch data (similar to GET in REST).
  - Mutations: Modify data (similar to POST, PUT, DELETE in REST).
  - Resolvers: Functions to return data.

To implement GraphQL in PHP, we need a library like webonyx/graphql-php.

- This library provides tools to define schema, types, queries, and mutations.
- Install the library:

```bash
composer require webonyx/graphql-php
```

### Building a Simple GraphQL Server

```php
<?php
// index.php
require_once __DIR__ . '/vendor/autoload.php';

use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;
use GraphQL\Type\Schema;
use GraphQL\GraphQL;
use GraphQL\Error\FormattedError;

// Database Connection (in reality, use repository pattern)
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

### GraphQL with Laravel

```php
<?php
// Use package rebing/graphql-laravel
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

### GraphQL Queries and Mutations

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

### Authentication and Authorization in GraphQL

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

### N+1 Problem and Batch Loading

```php
<?php
// Handling N+1 problem with Dataloader in PHP
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

## 🧑‍🏫 Lesson 25: JIT in PHP 8 and Beyond

### Introduction to JIT (Just-In-Time) Compiler in PHP 8

- JIT (Just-In-Time) Compilation in PHP 8:

  - Traditional PHP: interprets code at runtime.
  - JIT: compiles PHP code into machine code at runtime.
  - Purpose: increase execution speed, especially with computationally intensive code.

JIT Modes in PHP 8:

- disabled: JIT off.
- function: Compiles entire function.
- tracing: Compiles execution paths (trace) within function.

- How to enable JIT in php.ini

```ini
zend_extension=opcache
opcache.enable=1
opcache.enable_cli=1
opcache.jit_buffer_size=100M  ; JIT memory size
opcache.jit=1255              ; JIT mode (tracing)
```

- Check if JIT is enabled

```php
<?php

var_dump(opcache_get_status()['jit']);
```

### Performance with JIT

```php
<?php
// JIT performance benchmark example
// Large number calculation function - benefits from JIT
function calculate_sum_of_squares($n) {
    $sum = 0;
    for ($i = 0; $i < $n; $i++) {
        $sum += $i * $i;
    }
    return $sum;
}

// Measure execution time
function benchmark($function, $iterations, ...$args) {
    $start = microtime(true);

    for ($i = 0; $i < $iterations; $i++) {
        $function(...$args);
    }

    $end = microtime(true);
    return $end - $start;
}

// Run benchmark
$iterations = 1000;
$time = benchmark('calculate_sum_of_squares', $iterations, 1000000);
echo "Time taken for {$iterations} iterations: {$time} seconds\n";
echo "Average time per call: " . ($time / $iterations) . " seconds\n";

// Perform benchmark with different JIT modes
// JIT disabled: opcache.jit=0
// JIT function: opcache.jit=1255
// JIT tracing: opcache.jit=1205
?>
```

### Maximizing JIT

- Optimize code for JIT to work more effectively.

```php
<?php
// Use simple data types
function calculate_sum_of_squares_optimized(int $n): int {
    $sum = 0;
    for ($i = 0; $i < $n; $i++) {
        $sum += $i * $i;
    }
    return $sum;
}
// Use native PHP functions
function calculate_sum_of_squares_native(int $n): int {
    return array_sum(array_map(fn($i) => $i * $i, range(0, $n - 1)));
}
// Use more optimized algorithms
function calculate_sum_of_squares_optimized_v2(int $n): int {
    return ($n * ($n - 1) * (2 * $n - 1)) / 6; // Sum of squares formula
}
// Measure execution time
function benchmark_optimized($function, $iterations, ...$args) {
    $start = microtime(true);

    for ($i = 0; $i < $iterations; $i++) {
        $function(...$args);
    }

    $end = microtime(true);
    return $end - $start;
}
// Run benchmark
$iterations = 1000;
$time = benchmark_optimized('calculate_sum_of_squares_optimized', $iterations, 1000000);
echo "Time taken for {$iterations} iterations: {$time} seconds\n";
echo "Average time per call: " . ($time / $iterations) . " seconds\n";
// Run benchmark with native PHP functions
$time = benchmark_optimized('calculate_sum_of_squares_native', $iterations, 1000000);
echo "Time taken for {$iterations} iterations (native): {$time} seconds\n";
echo "Average time per call (native): " . ($time / $iterations) . " seconds\n";
// Run benchmark with more optimized algorithms
$time = benchmark_optimized('calculate_sum_of_squares_optimized_v2', $iterations, 1000000);
echo "Time taken for {$iterations} iterations (optimized v2): {$time} seconds\n";
echo "Average time per call (optimized v2): " . ($time / $iterations) . " seconds\n";
?>
```

## 🧪 FINAL PROJECT: Build Microservice System with PHP and Docker

### Requirements

1. Build a system with 3 microservices:

   - User Service: User management (registration, login, personal info).
   - Order Service: Order management (create order, payment, history).
   - Product Service: Product management (list, details, search).
   - Each service must have:
     - Separate database (MySQL).
     - RESTful API or GraphQL.
     - Containerized with Docker.
     - Logging and monitoring.

2. API Gateway:

   - Create gateway to route requests to the correct service.
   - Handle centralized authentication/authorization.

3. Communication between services:

   - Use RabbitMQ or Redis for asynchronous communication.
   - Implement event-driven architecture.

4. Frontend:

   - Build a simple SPA using API from services.
   - Apply Progressive Web App principles.

### Project Structure

```text
e-commerce-microservices/
├── docker-compose.yml
├── api-gateway/
│   ├── Dockerfile
│   └── src/
├── user-service/
│   ├── Dockerfile
│   ├── src/
│   └── database/
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