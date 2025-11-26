---
prev:
  text: '🚀 Xu Hướng Hiện Đại'
  link: '/vi/PHP/Part5'
next:
  text: '🐳 Module 8: Docker - Nền Tảng'
  link: '/vi/DEVOPS/Docker1'
---

# 📘 PHẦN 6: PHÁT TRIỂN VÀ TRIỂN KHAI CHUYÊN NGHIỆP

## 🎯 Mục tiêu tổng quát

- Nắm vững quy trình phát triển phần mềm chuyên nghiệp và áp dụng vào dự án PHP
- Triển khai hệ thống CI/CD để tự động hóa việc kiểm thử và triển khai ứng dụng
- Hiểu và áp dụng các kỹ thuật giám sát, logging hiện đại cho ứng dụng PHP
- Tối ưu hiệu năng ứng dụng thông qua các công cụ profiling và kỹ thuật cải thiện performance
- Chuẩn bị kiến thức và kỹ năng cần thiết cho phỏng vấn và phát triển sự nghiệp trong lĩnh vực PHP

## 🧑‍🏫 Bài 26: Quy trình phát triển phần mềm chuyên nghiệp

### Git Flow và Quản lý phiên bản

```bash
# Cài đặt Git Flow
apt-get install git-flow

# Khởi tạo Git Flow trong repository
git flow init

# Làm việc với feature branch
git flow feature start new-feature
# Phát triển tính năng...
git flow feature finish new-feature

# Làm việc với release branch
git flow release start 1.0.0
# Chuẩn bị release...
git flow release finish '1.0.0'

# Hotfix cho vấn đề trên production
git flow hotfix start critical-bug
# Sửa lỗi...
git flow hotfix finish critical-bug
```

### Code Reviews và Pull Requests

```php
<?php
// Ví dụ về code được refactor sau review

// Trước khi review
function getData($id) {
    $db = new PDO('mysql:host=localhost;dbname=test', 'user', 'password');
    $stmt = $db->prepare("SELECT * FROM data WHERE id = ?");
    $stmt->execute([$id]);
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    return $result;
}

// Sau khi review - Áp dụng dependency injection, error handling, và logging
class DataRepository {
    private $db;
    private $logger;

    public function __construct(PDO $db, LoggerInterface $logger) {
        $this->db = $db;
        $this->logger = $logger;
    }

    public function getData(int $id): ?array {
        try {
            $stmt = $this->db->prepare("SELECT * FROM data WHERE id = ?");
            $stmt->execute([$id]);
            return $stmt->fetch(PDO::FETCH_ASSOC) ?: null;
        } catch (PDOException $e) {
            $this->logger->error("Database error: " . $e->getMessage(), ['id' => $id]);
            throw new RepositoryException("Could not fetch data", 0, $e);
        }
    }
}
?>
```

### Áp dụng TDD (Test-Driven Development)

```php
<?php
use PHPUnit\Framework\TestCase;

class UserServiceTest extends TestCase
{
    private $userRepository;
    private $userService;

    protected function setUp(): void
    {
        $this->userRepository = $this->createMock(UserRepository::class);
        $this->userService = new UserService($this->userRepository);
    }

    public function testRegisterUserWithValidData()
    {
        // Arrange
        $userData = [
            'name' => 'John Doe',
            'email' => 'john@example.com',
            'password' => 'SecurePassword123'
        ];

        $this->userRepository->expects($this->once())
            ->method('create')
            ->with(
                $this->equalTo($userData['name']),
                $this->equalTo($userData['email']),
                $this->callback(function($password) use ($userData) {
                    return password_verify($userData['password'], $password);
                })
            )
            ->willReturn(1);

        // Act
        $result = $this->userService->register($userData);

        // Assert
        $this->assertEquals(1, $result);
    }

    public function testRegisterUserWithInvalidEmail()
    {
        // Arrange
        $userData = [
            'name' => 'John Doe',
            'email' => 'invalid-email',
            'password' => 'SecurePassword123'
        ];

        // Assert exception
        $this->expectException(ValidationException::class);

        // Act
        $this->userService->register($userData);
    }
}
?>
```

### Áp dụng DDD (Domain-Driven Design)

```php
<?php
// Domain Layer: Entities & Value Objects
class User {
    private UserId $id;
    private string $name;
    private Email $email;
    private HashedPassword $password;

    public function __construct(UserId $id, string $name, Email $email, HashedPassword $password) {
        $this->id = $id;
        $this->name = $name;
        $this->email = $email;
        $this->password = $password;
    }

    public function changePassword(string $newPassword): void {
        $this->password = new HashedPassword($newPassword);
    }

    // Getters...
}

// Value Objects
class Email {
    private string $value;

    public function __construct(string $email) {
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            throw new InvalidArgumentException("Invalid email address");
        }
        $this->value = $email;
    }

    public function __toString(): string {
        return $this->value;
    }
}

// Application Layer: Services
class UserService {
    private UserRepository $repository;

    public function __construct(UserRepository $repository) {
        $this->repository = $repository;
    }

    public function registerUser(string $name, string $email, string $password): UserId {
        $user = new User(
            UserId::generate(),
            $name,
            new Email($email),
            new HashedPassword($password)
        );

        return $this->repository->save($user);
    }
}

// Infrastructure Layer: Repositories
interface UserRepository {
    public function save(User $user): UserId;
    public function findById(UserId $id): ?User;
}

class MySqlUserRepository implements UserRepository {
    private PDO $connection;

    public function __construct(PDO $connection) {
        $this->connection = $connection;
    }

    public function save(User $user): UserId {
        // Implementation...
    }

    public function findById(UserId $id): ?User {
        // Implementation...
    }
}
?>
```

### Quy trình làm việc với Jira/Trello

1. **Backlog**:

   - Tạo User Stories/Tasks
   - Ước tính Story Points/Effort

2. **Sprint Planning**:

   - Chọn User Stories cho sprint
   - Phân chia tasks

3. **Daily Standup**:

   - Đã làm gì hôm qua?
   - Sẽ làm gì hôm nay?
   - Có blockers nào không?

4. **Sprint Review**:

   - Demo các tính năng đã hoàn thành
   - Lấy feedback

5. **Sprint Retrospective**:

   - Điều gì đã làm tốt?
   - Điều gì cần cải thiện?
   - Các hành động cho sprint tiếp theo

## 🧑‍🏫 Bài 27: CI/CD cho ứng dụng PHP

### Giới thiệu CI/CD

- **Continuous Integration (CI)**: Tự động hóa việc kiểm tra mã nguồn khi có thay đổi. Mỗi lần commit sẽ trigger build và test.
- **Continuous Deployment (CD)**: Tự động hóa việc triển khai ứng dụng lên môi trường production sau khi CI hoàn tất.

```yaml
# .github/workflows/php-ci.yml
name: PHP CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  build-test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Setup PHP
        uses: shivammathur/setup-php@v2
        with:
          php-version: "8.1"
          extensions: mbstring, intl, pdo_mysql
          coverage: xdebug

      - name: Validate composer.json and composer.lock
        run: composer validate --strict

      - name: Cache Composer packages
        uses: actions/cache@v3
        with:
          path: vendor
          key: ${{ runner.os }}-php-${{ hashFiles('**/composer.lock') }}
          restore-keys: ${{ runner.os }}-php-

      - name: Install dependencies
        run: composer install --prefer-dist --no-progress

      - name: Run code style check
        run: vendor/bin/phpcs

      - name: Run static analysis
        run: vendor/bin/phpstan analyse src tests

      - name: Run test suite
        run: vendor/bin/phpunit --coverage-clover coverage.xml

      - name: Upload coverage to Codecov
        uses: codecov/codecov-action@v3
        with:
          file: ./coverage.xml
```

### Thiết lập PHPUnit trong dự án

```php
<?php
// phpunit.xml.dist
?>
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<phpunit xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="https://schema.phpunit.de/9.5/phpunit.xsd"
         colors="true"
         bootstrap="vendor/autoload.php">
  <testsuites>
    <testsuite name="Unit Tests">
      <directory>tests/Unit</directory>
    </testsuite>
    <testsuite name="Integration Tests">
      <directory>tests/Integration</directory>
    </testsuite>
    <testsuite name="Feature Tests">
      <directory>tests/Feature</directory>
    </testsuite>
  </testsuites>

  <coverage processUncoveredFiles="true">
    <include>
      <directory suffix=".php">src</directory>
    </include>
    <report>
      <clover outputFile="coverage.xml"/>
      <html outputDirectory="coverage-report"/>
    </report>
  </coverage>

  <php>
    <env name="APP_ENV" value="testing"/>
    <env name="DB_CONNECTION" value="sqlite"/>
    <env name="DB_DATABASE" value=":memory:"/>
  </php>
</phpunit>
```

### Code Quality Tools

```php
<?php
// phpcs.xml
?>
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ruleset name="PHP_CodeSniffer">
    <description>PHP Coding Standards</description>

    <!-- Scan these files -->
    <file>src</file>
    <file>tests</file>

    <!-- Show progress -->
    <arg value="p"/>
    <arg name="colors"/>

    <!-- Use PSR-12 -->
    <rule ref="PSR12"/>

    <!-- Específic rules -->
    <rule ref="Generic.Files.LineLength">
        <properties>
            <property name="lineLimit" value="120"/>
            <property name="absoluteLineLimit" value="120"/>
        </properties>
    </rule>
</ruleset>
```

### PHP Static Analysis Tool (PHPStan)

```php
<?php
// phpstan.neon
?>
```

```yaml
parameters:
  level: 8
  paths:
    - src
    - tests
  excludePaths:
    - vendor/*
  checkMissingIterableValueType: false
  checkGenericClassInNonGenericObjectType: false
```

### Triển khai tự động với Laravel Forge/Envoyer

Quy trình triển khai của Laravel Forge

1. Connect to repository (GitHub/GitLab/Bitbucket)
2. Khi có commit mới vào branch cần deploy (main/master)
   - Pull changes from repository
   - Run composer install --no-dev
   - Run npm ci && npm run build (nếu có frontend)
   - Run migrations: php artisan migrate --force
   - Reload PHP-FPM
   - Clear cache: php artisan cache:clear
   - Restart queues: php artisan queue:restart

Hoặc cấu hình deploy script tùy chỉnh

```bash
composer install --no-dev
php artisan migrate --force
php artisan optimize
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

### Zero-Downtime Deployment

Quy trình Zero-Downtime Deployment:

1. **Chuẩn bị**:

   - Tạo thư mục release mới
   - Sao chép code mới vào release directory

2. **Cài đặt dependencies**:

   - composer install --no-dev

3. **Cấu hình**:

   - Sao chép/symlink các file cấu hình và .env

4. **Tối ưu**:

   - php artisan optimize
   - php artisan config:cache
   - php artisan route:cache
   - php artisan view:cache

5. **Migrations**:

   - php artisan migrate --force
     (Đảm bảo migrations không gây downtime)

6. **Cập nhật symlink**:

   - Point symlink "current" vào release mới
     (Đây là "atomic switch" - gần như ngay lập tức và không downtime)

7. **Restart các services**:

   - php-fpm reload
   - php artisan queue:restart

8. **Dọn dẹp**:

   - Giữ X releases gần nhất, xóa các release cũ

## 🧑‍🏫 Bài 28: Giám sát và logging ứng dụng PHP

### Monolog trong PHP

```php
<?php
// Cấu hình logging với Monolog
use Monolog\Logger;
use Monolog\Handler\StreamHandler;
use Monolog\Handler\SlackHandler;
use Monolog\Formatter\JsonFormatter;
use Monolog\Processor\IntrospectionProcessor;
use Monolog\Processor\WebProcessor;

// Tạo logger chính
$logger = new Logger('app');

// Thêm file handler
$fileHandler = new StreamHandler('logs/app.log', Logger::DEBUG);
$fileHandler->setFormatter(new JsonFormatter());
$logger->pushHandler($fileHandler);

// Thêm Slack handler cho lỗi nghiêm trọng
$slackHandler = new SlackHandler(
    'slack-token',
    '#errors',
    'ErrorBot',
    true,
    null,
    Logger::ERROR
);
$logger->pushHandler($slackHandler);

// Thêm processors để ghi lại thêm thông tin
$logger->pushProcessor(new IntrospectionProcessor());
$logger->pushProcessor(new WebProcessor());

// Sử dụng logger
$logger->info('User logged in', ['user_id' => 123]);
$logger->error('Payment failed', [
    'user_id' => 123,
    'amount' => 99.95,
    'error_code' => 'CARD_DECLINED'
]);
?>
```

### Giám sát với ELK Stack (Elasticsearch, Logstash, Kibana)

```yml
# docker-compose.yml cho ELK stack
version: "3"

services:
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.17.0
    environment:
      - discovery.type=single-node
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    ports:
      - "9200:9200"
    volumes:
      - elasticsearch-data:/usr/share/elasticsearch/data

  logstash:
    image: docker.elastic.co/logstash/logstash:7.17.0
    depends_on:
      - elasticsearch
    volumes:
      - ./logstash-config:/usr/share/logstash/pipeline
    ports:
      - "5000:5000"

  kibana:
    image: docker.elastic.co/kibana/kibana:7.17.0
    depends_on:
      - elasticsearch
    ports:
      - "5601:5601"
    environment:
      ELASTICSEARCH_HOSTS: http://elasticsearch:9200

volumes:
  elasticsearch-data:
```

### Cấu hình Logstash

```conf
# logstash-config/logstash.conf
input {
  file {
    type => "php-logs"
    path => "/var/log/php/app.log"
    codec => "json"
  }
  tcp {
    port => 5000
    codec => "json"
  }
}

filter {
  if [type] == "php-logs" {
    grok {
      match => { "message" => "%{COMBINEDAPACHELOG}" }
    }
    date {
      match => [ "timestamp", "dd/MMM/yyyy:HH:mm:ss Z" ]
    }
  }
}

output {
  elasticsearch {
    hosts => ["elasticsearch:9200"]
    index => "php-logs-%{+YYYY.MM.dd}"
  }
}
```

### Monitoring với Prometheus và Grafana

```php
<?php
// Sử dụng Prometheus PHP Client
// composer require promphp/prometheus_client_php

use Prometheus\CollectorRegistry;
use Prometheus\Storage\Redis;

// Kết nối với Redis instance
$adapter = new Redis(['host' => 'redis', 'port' => 6379]);
$registry = new CollectorRegistry($adapter);

// Đếm số request
$counter = $registry->getOrRegisterCounter('app', 'requests_total', 'Total request count', ['endpoint']);
$counter->incBy(1, [$_SERVER['REQUEST_URI']]);

// Đo thời gian thực thi
$histogram = $registry->getOrRegisterHistogram(
    'app',
    'request_duration_seconds',
    'Request duration in seconds',
    ['endpoint'],
    [0.01, 0.05, 0.1, 0.5, 1, 2, 5]
);

$start = microtime(true);
// Xử lý request...
$duration = microtime(true) - $start;
$histogram->observe($duration, [$_SERVER['REQUEST_URI']]);

// Đặt gauge cho số kết nối database
$gauge = $registry->getOrRegisterGauge('app', 'db_connections', 'Current database connections');
$gauge->set(DB::getConnectionCount());
?>
```

### Prometheus Metrics Endpoint

```php
<?php
// metrics.php - Endpoint để Prometheus scrape metrics

// Header
header('Content-Type: text/plain; version=0.0.4');

// Lấy registry
$adapter = new Prometheus\Storage\Redis(['host' => 'redis', 'port' => 6379]);
$registry = new Prometheus\CollectorRegistry($adapter);

// Output metrics
$renderer = new Prometheus\RenderTextFormat();
echo $renderer->render($registry->getMetricFamilySamples());
?>
```

### Xử lý Exception và Error Tracking

```php
<?php
// Thiết lập error handler tùy chỉnh
set_error_handler(function($severity, $message, $file, $line) {
    if (!(error_reporting() & $severity)) {
        // Error không nằm trong error_reporting
        return;
    }
    throw new ErrorException($message, 0, $severity, $file, $line);
});

// Thiết lập exception handler
set_exception_handler(function(Throwable $exception) {
    global $logger;

    // Log exception
    $logger->error('Uncaught exception: ' . $exception->getMessage(), [
        'exception' => [
            'class' => get_class($exception),
            'message' => $exception->getMessage(),
            'code' => $exception->getCode(),
            'file' => $exception->getFile(),
            'line' => $exception->getLine(),
            'trace' => $exception->getTraceAsString(),
        ]
    ]);

    // Thông báo cho Slack về lỗi nghiêm trọng
    if ($exception instanceof FatalErrorException) {
        notifySlack($exception);
    }

    // Hiển thị lỗi thân thiện với người dùng trong production
    if (getenv('APP_ENV') === 'production') {
        http_response_code(500);
        echo json_encode([
            'error' => 'Server Error',
            'message' => 'Something went wrong. Our team has been notified.'
        ]);
    } else {
        // Hiển thị chi tiết lỗi trong development
        http_response_code(500);
        echo '<h1>Error</h1>';
        echo '<p>' . htmlspecialchars($exception->getMessage()) . '</p>';
        echo '<pre>' . htmlspecialchars($exception->getTraceAsString()) . '</pre>';
    }
});

// Tích hợp với dịch vụ Error Tracking như Sentry
// composer require sentry/sdk
Sentry\init([
    'dsn' => 'https://examplePublicKey@o0.ingest.sentry.io/0',
    'environment' => getenv('APP_ENV'),
    'release' => '1.0.0',
]);

try {
    // Code có thể gây exception
    processOrder($orderId);
} catch (Throwable $exception) {
    Sentry\captureException($exception);
    // Handle exception
}
?>
```

## 🧑‍🏫 Bài 29: Performance tuning và profiling

### Công cụ Profiling cho PHP

```php
<?php
// Sử dụng Xdebug profiling
// php.ini configuration
/*
[xdebug]
xdebug.mode=profile
xdebug.output_dir=/tmp/xdebug
xdebug.profiler_output_name=cachegrind.out.%p
*/

// Sử dụng Tideways XHProf
// composer require tideways/php-xhprof-extension

// Bắt đầu profiling
tideways_xhprof_enable(TIDEWAYS_XHPROF_FLAGS_CPU | TIDEWAYS_XHPROF_FLAGS_MEMORY);

// Code cần profile
$result = complexCalculation();

// Dừng profiling và lưu kết quả
$profile_data = tideways_xhprof_disable();
file_put_contents(
    '/tmp/profile_data_' . uniqid() . '.json',
    json_encode($profile_data)
);
?>
```

### Blackfire.io Integration

Tích hợp Blackfire.io

1. Cài đặt Blackfire Agent và PHP Probe theo [hướng dẫn](https://blackfire.io/docs/integrations/php)

2. Sử dụng Blackfire SDK để profile code cụ thể

   ```bash
   composer require blackfire/php-sdk
   ```

   ```php
   <?php
   \BlackfireProbe::getMainInstance()->enable();

   // Code cần profile
   $result = complexCalculation();

   \BlackfireProbe::getMainInstance()->disable();

   // 3. Web UI cho tương tác với dashboard
   // Sử dụng Chrome extension để trigger profile
   ?>
   ```

### Database Query Optimization

```php
<?php
// Phân tích và tối ưu query

// 1. Enable MySQL Slow Query Log
// my.cnf configuration
/*
[mysqld]
slow_query_log = 1
slow_query_log_file = /var/log/mysql/mysql-slow.log
long_query_time = 1
*/

// 2. Phân tích query với EXPLAIN
$stmt = $pdo->prepare("EXPLAIN SELECT * FROM users JOIN orders ON users.id = orders.user_id WHERE users.status = ?");
$stmt->execute(['active']);
$explainResults = $stmt->fetchAll(PDO::FETCH_ASSOC);
print_r($explainResults);

// 3. Tối ưu queries
// Bad query
$stmt = $pdo->prepare("SELECT * FROM products WHERE category_id = ? ORDER BY price DESC");

// Optimized query - chỉ lấy dữ liệu cần thiết
$stmt = $pdo->prepare("SELECT id, name, price FROM products WHERE category_id = ? ORDER BY price DESC");

// 4. Sử dụng indexes
// Tạo index
$pdo->exec("CREATE INDEX idx_products_category_price ON products (category_id, price)");

// 5. Tránh N+1 query problem
// Bad approach - N+1 queries
$users = $pdo->query("SELECT * FROM users LIMIT 100")->fetchAll();
foreach ($users as $user) {
    $orders = $pdo->prepare("SELECT * FROM orders WHERE user_id = ?");
    $orders->execute([$user['id']]);
    // Process orders...
}

// Good approach - 1 query with JOIN
$stmt = $pdo->query(
    "SELECT users.*, orders.*
     FROM users
     LEFT JOIN orders ON users.id = orders.user_id
     WHERE users.id IN (SELECT id FROM users LIMIT 100)"
);
?>
```

### Caching Strategies

```php
<?php
// 1. Cài đặt và kết nối Redis
$redis = new Redis();
$redis->connect('redis', 6379);

// 2. Caching data
function getUserData($userId) {
    global $redis, $pdo;

    // Cache key
    $cacheKey = "user:{$userId}:data";

    // Try to get from cache
    $cachedData = $redis->get($cacheKey);
    if ($cachedData) {
        return json_decode($cachedData, true);
    }

    // Cache miss - fetch from database
    $stmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
    $stmt->execute([$userId]);
    $userData = $stmt->fetch(PDO::FETCH_ASSOC);

    // Store in cache with TTL (1 hour)
    $redis->setex($cacheKey, 3600, json_encode($userData));

    return $userData;
}

// 3. Caching query results
function getActiveProducts($categoryId) {
    global $redis, $pdo;

    // Cache key
    $cacheKey = "category:{$categoryId}:active_products";

    // Try to get from cache
    $cachedData = $redis->get($cacheKey);
    if ($cachedData) {
        return json_decode($cachedData, true);
    }

    // Cache miss - fetch from database
    $stmt = $pdo->prepare(
        "SELECT id, name, price, stock
         FROM products
         WHERE category_id = ? AND active = 1"
    );
    $stmt->execute([$categoryId]);
    $products = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Store in cache with TTL (5 minutes)
    $redis->setex($cacheKey, 300, json_encode($products));

    return $products;
}

// 4. Cache invalidation when data changes
function updateProduct($productId, $data) {
    global $redis, $pdo;

    // Update in database
    $stmt = $pdo->prepare(
        "UPDATE products SET name = ?, price = ?, stock = ? WHERE id = ?"
    );
    $stmt->execute([$data['name'], $data['price'], $data['stock'], $productId]);

    // Get category for cache invalidation
    $stmt = $pdo->prepare("SELECT category_id FROM products WHERE id = ?");
    $stmt->execute([$productId]);
    $product = $stmt->fetch(PDO::FETCH_ASSOC);

    // Invalidate cache
    $redis->del("category:{$product['category_id']}:active_products");
    $redis->del("product:{$productId}:data");
}
?>
```

### Load Testing với k6

```js
// load-test.js - k6 script
import http from "k6/http";
import { sleep, check } from "k6";

export const options = {
  stages: [
    { duration: "30s", target: 50 }, // Ramp-up to 50 users over 30s
    { duration: "1m", target: 50 }, // Stay at 50 users for 1 minute
    { duration: "30s", target: 100 }, // Ramp-up to 100 users
    { duration: "1m", target: 100 }, // Stay at 100 users for 1 minute
    { duration: "30s", target: 0 }, // Ramp-down to 0 users
  ],
  thresholds: {
    http_req_duration: ["p(95)<500"], // 95% of requests should finish within 500ms
    "http_req_duration{status:200}": ["max<600"], // Maximum duration of 200 responses should be below 600ms
  },
};

export default function () {
  // Test homepage
  const homeRes = http.get("https://example.com/");
  check(homeRes, {
    "homepage status is 200": (r) => r.status === 200,
    "homepage load time < 500ms": (r) => r.timings.duration < 500,
  });

  sleep(1);

  // Test API endpoint
  const apiRes = http.get("https://example.com/api/products");
  check(apiRes, {
    "api status is 200": (r) => r.status === 200,
    "api response is JSON": (r) =>
      r.headers["Content-Type"].includes("application/json"),
  });

  sleep(2);
}
```

### Best Practices cho Performance

1. Sử dụng Opcode Cache (OPcache)

   - Tăng tốc độ thực thi mã PHP bằng cách lưu trữ bytecode đã biên dịch.
   - Cấu hình OPcache trong php.ini

   ```ini
   [opcache]
   opcache.enable=1
   opcache.memory_consumption=128
   opcache.interned_strings_buffer=8
   opcache.max_accelerated_files=10000
   opcache.validate_timestamps=0 # trong production
   opcache.save_comments=1
   opcache.fast_shutdown=1
   opcache.enable_file_override=1
   opcache.jit=1255
   opcache.jit_buffer_size=100M
   ```

2. Tránh eager loading của các đoạn mã không cần thiết

   - Sử dụng composer autoloader optimization

   ```bash
   composer dump-autoload --optimize
   ```

3. Sử dụng connection pooling cho database

   - Sử dụng PgBouncer hoặc ProxySQL để giảm overhead khi tạo kết nối mới.
   - Cấu hình PgBouncer

   ```ini
   [databases]
   mydb = host=localhost dbname=mydb user=myuser password=mypassword
   ```

4. Tối ưu file size
   - Minify & Combine CSS/JS cho frontend.
   - Enable HTTP/2 để giảm latency.
   - Enable Gzip compression để giảm kích thước response.
5. Sử dụng CDN cho static assets
6. Sử dụng queues cho heavy processing

   - Ví dụ: email, file processing, report generation.
   - Sử dụng RabbitMQ hoặc Redis để xử lý queue.

   ```php
   // Publish job to queue
   function queueEmailJob($emailData) {
       $connection = new AMQPStreamConnection('localhost', 5672, 'guest', 'guest');
       $channel = $connection->channel();

       $channel->queue_declare('email_queue', false, true, false, false);

       $msg = new AMQPMessage(
           json_encode($emailData),
           ['delivery_mode' => AMQPMessage::DELIVERY_MODE_PERSISTENT]
       );

       $channel->basic_publish($msg, '', 'email_queue');

       $channel->close();
       $connection->close();
   }

   // Worker để xử lý queue
   function startEmailWorker() {
       $connection = new AMQPStreamConnection('localhost', 5672, 'guest', 'guest');
       $channel = $connection->channel();

       $channel->queue_declare('email_queue', false, true, false, false);

       $callback = function($msg) {
           $emailData = json_decode($msg->body, true);

           try {
               // Process email
               sendEmail($emailData);
               $msg->delivery_info['channel']->basic_ack($msg->delivery_info['delivery_tag']);
           } catch (Exception $e) {
               // Log error và reject message
               $msg->delivery_info['channel']->basic_reject($msg->delivery_info['delivery_tag'], false);
           }
       };

       $channel->basic_qos(null, 1, null);
       $channel->basic_consume('email_queue', '', false, false, false, false, $callback);

       while(count($channel->callbacks)) {
           $channel->wait();
       }
   }
   ?>
   ```

## 🧑‍🏫 Bài 30: Chuẩn bị cho phỏng vấn PHP và phát triển sự nghiệp

### Câu hỏi phỏng vấn PHP thường gặp

1. PHP Cơ bản:

   - Sự khác biệt giữa "==" và "==="?
   - Các kiểu dữ liệu trong PHP?
   - Magic methods trong PHP?
   - Các superglobals là gì?
   - Scope trong PHP (global/local)?

2. OOP trong PHP:

   - Tính đóng gói, kế thừa, đa hình là gì?
   - Interface vs Abstract class?
   - Type hinting trong PHP?
   - Traits trong PHP là gì và khi nào nên dùng?
   - Namespaces và mục đích sử dụng?

3. Design Patterns:

   - Singleton pattern là gì và khi nào sử dụng?
   - MVC pattern và vai trò của mỗi thành phần?
   - Factory pattern và khi nào nên áp dụng?
   - Repository pattern là gì?
   - Dependency Injection và lợi ích?

4. Database và SQL:

   - Prepared statements là gì và tại sao nên dùng?
   - MySQL vs PostgreSQL - khi nào nên dùng?
   - Indexing trong database?
   - INNER JOIN vs LEFT JOIN?
   - Transactions là gì và khi nào cần dùng?

5. Security:

   - Cross-site scripting (XSS) và cách phòng chống?
   - SQL Injection và cách ngăn chặn?
   - CSRF là gì và làm thế nào để bảo vệ?
   - Bảo mật password trong PHP?
   - Session security best practices?

6. Modern PHP:

   - Composer là gì và làm thế nào để quản lý dependencies?
   - PSR standards là gì?
   - PHP 8 features mới?
   - Async programming trong PHP?
   - Docker và containerization trong PHP?

7. Testing:

   - Unit testing vs Integration testing?
   - PHPUnit là gì và cách sử dụng?
   - Mocking trong testing?
   - TDD là gì và tại sao nên áp dụng?

8. Performance:

   - Cách tối ưu hiệu năng PHP?
   - Caching strategies trong PHP?
   - Opcache là gì và cách cấu hình?
   - JIT trong PHP 8?
   - Khi nào cần sử dụng queues?

### Porfolio và Open Source

Xây dựng Portfolio Developer PHP:

1. Các dự án nên có trong portfolio:

   - CRUD application sử dụng MVC framework
   - RESTful API hoặc GraphQL API
   - Ứng dụng với authentication/authorization
   - Project sử dụng database relationships phức tạp
   - Tích hợp third-party APIs

2. Đóng góp open source:

   - Tìm các repositories PHP phù hợp trên GitHub
   - Bắt đầu với "good first issues"
   - Đóng góp documentation
   - Fix bugs đơn giản
   - Tạo các packages PHP nhỏ

3. Blog kỹ thuật:

   - Viết về các khái niệm PHP bạn vừa học
   - Chia sẻ case studies từ các dự án
   - Tutorials về các công nghệ PHP mới
   - Phân tích performance và security issues

### Career Path trong PHP

1. Junior PHP Developer (0-2 năm):

   - Nắm vững PHP cơ bản và OOP
   - Làm quen với ít nhất một framework (Laravel/Symfony)
   - Hiểu database và SQL cơ bản
   - Kiến thức cơ bản về HTML, CSS, JavaScript

2. Mid-level PHP Developer (2-5 năm):

   - Hiểu sâu về framework
   - Design patterns và architectural patterns
   - Unit testing và CI/CD
   - Performance optimization
   - REST APIs và API design
   - Caching strategies
   - Git workflow chuyên nghiệp

3. Senior PHP Developer (5+ năm):

   - System design và architecture
   - Microservices và distributed systems
   - Infrastructure và DevOps
   - Database optimization và scaling
   - Security best practices
   - Mentoring và code reviews
   - Cross-functional collaboration

4. Tech Lead / Architect:

   - Định hướng kiến trúc hệ thống
   - Lựa chọn công nghệ và technical roadmap
   - Quản lý technical debt
   - Đào tạo và phát triển team
   - Tham gia vào quá trình tuyển dụng
   - Giao tiếp với stakeholders

5. Specialized paths:

   - DevOps Engineer
   - Security Specialist
   - Performance Engineer
   - API Architect
   - Open Source Contributor

### Technical Interview Preparation

1. Coding challenges:
   - Thực hành trên LeetCode/HackerRank
   - Implement các thuật toán cơ bản
   - Giải quyết các bài toán design pattern

2. Whiteboard/system design:
   - Practice thiết kế databases
   - Vẽ architecture diagrams
   - Giải thích trade-offs trong các quyết định

3. Mock interviews:
   - Pair programming với đồng nghiệp
   - Online mock interviews
   - Review và cải thiện từ feedback

4. Chuẩn bị câu hỏi cho nhà tuyển dụng:
   - Tech stack và challenges
   - Engineering culture và processes
   - Career growth và mentorship
   - Work-life balance

```php
<?php
// Ví dụ: Bài tập Coding Challenge thường gặp
function isPalindrome(string $str): bool {
    $str = preg_replace('/[^a-z0-9]/i', '', strtolower($str));
    return $str === strrev($str);
}

function fizzbuzz(int $n): void {
    for ($i = 1; $i <= $n; $i++) {
        if ($i % 3 === 0 && $i % 5 === 0) {
            echo "FizzBuzz\n";
        } elseif ($i % 3 === 0) {
            echo "Fizz\n";
        } elseif ($i % 5 === 0) {
            echo "Buzz\n";
        } else {
            echo $i . "\n";
        }
    }
}
?>
```

**Keeping Up with PHP Ecosystem:**

```php
<?php
/*
Theo dõi và cập nhật kiến thức PHP:

1. PHP RFC và GitHub:
   - https://wiki.php.net/rfc
   - https://github.com/php/php-src

2. Blogs và newsletters:
   - PHP Weekly
   - PHP Annotated Monthly
   - Laravel News
   - Symfony Blog

3. Podcasts:
   - PHP Roundtable
   - Laravel Podcast
   - Full Stack Radio
   - PHP Architects Radio

4. Conferences:
   - PHP[tek]
   - Laracon
   - Symfony Con
   - PHP UK Conference

5. Online courses và platforms:
   - Laracasts
   - Symfonycasts
   - PHP The Right Way

6. Twitter accounts và social media:
   - @official_php
   - @laravelphp
   - @symfony
   - @nikita_ppv
*/
?>
```

## 🧪 DỰ ÁN TỔNG HỢP CUỐI KHÓA: Xây dựng hệ thống E-Learning hoàn chỉnh

### Yêu cầu

1. Kiến trúc hệ thống:

   - Áp dụng kiến trúc microservices
   - Sử dụng Docker để containerize các services
   - Triển khai CI/CD pipeline

2. Core Modules:

   - Authentication Service (đăng ký, đăng nhập, quản lý người dùng)
   - Course Service (tạo khóa học, quản lý nội dung)
   - Enrollment Service (đăng ký học, theo dõi tiến trình)
   - Media Service (upload và streaming video bài giảng)
   - Analytics Service (thống kê, báo cáo)
   - Payment Service (thanh toán khóa học)

3. Yêu cầu kỹ thuật:

   - Backend API: PHP 8.1+, Laravel/Symfony
   - Database: MySQL/PostgreSQL
   - Cache: Redis
   - Message Queue: RabbitMQ
   - Frontend: Vue.js/React
   - Authentication: JWT/OAuth2
   - API Gateway: Kong/Nginx
   - Logging: ELK Stack
   - Monitoring: Prometheus/Grafana
   - Testing: PHPUnit, Jest

4. Tính năng:

   - Đăng ký/đăng nhập (email, social)
   - Bảng điều khiển người dùng/giảng viên
   - Tạo và quản lý khóa học
   - Upload và quản lý video bài giảng
   - Forum thảo luận cho mỗi khóa học
   - Thanh toán trực tuyến
   - Báo cáo và phân tích dữ liệu
   - Tích hợp notifications (email, push)
   - Admin panel quản lý toàn hệ thống

5. Advanced Features:

   - Real-time chat với giảng viên
   - Video conferencing cho live classes
   - Recommendation system cho khóa học
   - Mobile-friendly responsive design
   - Progressive Web App capabilities
   - Multilingual support
   - Content caching và CDN integration

### Cấu trúc dự án

```text
e-learning-platform/
├── docker-compose.yml
├── api-gateway/
│   ├── Dockerfile
│   └── src/
├── auth-service/
│   ├── Dockerfile
│   ├── src/
│   └── database/
├── course-service/
│   ├── Dockerfile
│   ├── src/
│   └── database/
├── enrollment-service/
│   ├── Dockerfile
│   ├── src/
│   └── database/
├── media-service/
│   ├── Dockerfile
│   ├── src/
│   └── storage/
├── analytics-service/
│   ├── Dockerfile
│   ├── src/
│   └── database/
├── payment-service/
│   ├── Dockerfile
│   ├── src/
│   └── database/
├── frontend/
│   ├── Dockerfile
│   └── src/
├── admin-panel/
│   ├── Dockerfile
│   └── src/
├── message-broker/
│   └── rabbitmq/
├── cache/
│   └── redis/
├── monitoring/
│   ├── prometheus/
│   └── grafana/
└── logging/
    ├── elasticsearch/
    ├── logstash/
    └── kibana/
```

### Tiêu chí đánh giá

1. Code Quality:

   - Clean code và best practices
   - Proper documentation
   - Design patterns sử dụng phù hợp
   - Code consistency và style standards (PSR)

2. Architecture:

   - Microservices communication
   - System resilience
   - Scaling capabilities
   - Service boundaries

3. Testing:

   - Unit tests (minimum 70% coverage)
   - Integration tests
   - E2E tests cho critical flows

4. Performance:

   - Optimization techniques
   - Caching strategy
   - Response time (<300ms cho APIs)

5. Security:

   - Authentication/Authorization
   - Data protection
   - Input validation
   - CSRF/XSS prevention

6. CI/CD:

   - Automated testing
   - Deployment pipeline
   - Environment configurations
   - Monitoring integration

7. Documentation:

   - API documentation
   - System architecture diagrams
   - Setup and deployment instructions
   - User guides
