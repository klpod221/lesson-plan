---
prev:
  text: '🚀 Modern Trends'
  link: '/PHP/Part5'
next:
  text: '🐳 Module 8: Docker - Fundamentals'
  link: '/DEVOPS/Docker1'
---

# 📘 PART 6: PROFESSIONAL DEVELOPMENT AND DEPLOYMENT

## 🎯 General Objectives

- Master professional software development processes and apply them to PHP projects.
- Implement CI/CD systems to automate testing and deployment.
- Understand and apply modern monitoring and logging techniques for PHP applications.
- Optimize application performance through profiling tools and performance improvement techniques.
- Prepare knowledge and skills necessary for interviews and career development in the PHP field.

## 🧑‍🏫 Lesson 26: Professional Software Development Process

### Git Flow and Version Management

```bash
# Install Git Flow
apt-get install git-flow

# Initialize Git Flow in repository
git flow init

# Work with feature branch
git flow feature start new-feature
# Develop feature...
git flow feature finish new-feature

# Work with release branch
git flow release start 1.0.0
# Prepare release...
git flow release finish '1.0.0'

# Hotfix for production issues
git flow hotfix start critical-bug
# Fix bug...
git flow hotfix finish critical-bug
```

### Code Reviews and Pull Requests

```php
<?php
// Example of code refactored after review

// Before review
function getData($id) {
    $db = new PDO('mysql:host=localhost;dbname=test', 'user', 'password');
    $stmt = $db->prepare("SELECT * FROM data WHERE id = ?");
    $stmt->execute([$id]);
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    return $result;
}

// After review - Applying dependency injection, error handling, and logging
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

### Applying TDD (Test-Driven Development)

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

### Applying DDD (Domain-Driven Design)

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

### Workflow with Jira/Trello

1. **Backlog**:

   - Create User Stories/Tasks.
   - Estimate Story Points/Effort.

2. **Sprint Planning**:

   - Select User Stories for sprint.
   - Break down tasks.

3. **Daily Standup**:

   - What did you do yesterday?
   - What will you do today?
   - Any blockers?

4. **Sprint Review**:

   - Demo completed features.
   - Get feedback.

5. **Sprint Retrospective**:

   - What went well?
   - What needs improvement?
   - Actions for next sprint.

## 🧑‍🏫 Lesson 27: CI/CD for PHP Applications

### Introduction to CI/CD

- **Continuous Integration (CI)**: Automatically verifying source code upon changes. Each commit triggers build and test.
- **Continuous Deployment (CD)**: Automatically deploying the application to production environment after CI completes.

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

### Configuring PHPUnit in Project

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

### Automated Deployment with Laravel Forge/Envoyer

Laravel Forge Deployment Process

1. Connect to repository (GitHub/GitLab/Bitbucket).
2. When a new commit is pushed to the deploy branch (main/master):
   - Pull changes from repository.
   - Run `composer install --no-dev`.
   - Run `npm ci && npm run build` (if frontend exists).
   - Run migrations: `php artisan migrate --force`.
   - Reload PHP-FPM.
   - Clear cache: `php artisan cache:clear`.
   - Restart queues: `php artisan queue:restart`.

Or custom deploy script configuration:

```bash
composer install --no-dev
php artisan migrate --force
php artisan optimize
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

### Zero-Downtime Deployment

Zero-Downtime Deployment Process:

1. **Preparation**:

   - Create new release directory.
   - Copy new code to release directory.

2. **Install dependencies**:

   - `composer install --no-dev`

3. **Configuration**:

   - Copy/symlink config files and .env.

4. **Optimization**:

   - `php artisan optimize`
   - `php artisan config:cache`
   - `php artisan route:cache`
   - `php artisan view:cache`

5. **Migrations**:

   - `php artisan migrate --force`
     (Ensure migrations do not cause downtime)

6. **Update symlink**:

   - Point "current" symlink to new release.
     (This is an "atomic switch" - almost instant and no downtime)

7. **Restart services**:

   - `php-fpm reload`
   - `php artisan queue:restart`

8. **Cleanup**:

   - Keep X most recent releases, delete old ones.

## 🧑‍🏫 Lesson 28: Monitoring and Logging PHP Applications

### Monolog in PHP

```php
<?php
// Logging configuration with Monolog
use Monolog\Logger;
use Monolog\Handler\StreamHandler;
use Monolog\Handler\SlackHandler;
use Monolog\Formatter\JsonFormatter;
use Monolog\Processor\IntrospectionProcessor;
use Monolog\Processor\WebProcessor;

// Create main logger
$logger = new Logger('app');

// Add file handler
$fileHandler = new StreamHandler('logs/app.log', Logger::DEBUG);
$fileHandler->setFormatter(new JsonFormatter());
$logger->pushHandler($fileHandler);

// Add Slack handler for critical errors
$slackHandler = new SlackHandler(
    'slack-token',
    '#errors',
    'ErrorBot',
    true,
    null,
    Logger::ERROR
);
$logger->pushHandler($slackHandler);

// Add processors to log extra info
$logger->pushProcessor(new IntrospectionProcessor());
$logger->pushProcessor(new WebProcessor());

// Use logger
$logger->info('User logged in', ['user_id' => 123]);
$logger->error('Payment failed', [
    'user_id' => 123,
    'amount' => 99.95,
    'error_code' => 'CARD_DECLINED'
]);
?>
```

### Monitoring with ELK Stack (Elasticsearch, Logstash, Kibana)

```yml
# docker-compose.yml for ELK stack
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

### Logstash Configuration

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

### Monitoring with Prometheus and Grafana

```php
<?php
// Use Prometheus PHP Client
// composer require promphp/prometheus_client_php

use Prometheus\CollectorRegistry;
use Prometheus\Storage\Redis;

// Connect to Redis instance
$adapter = new Redis(['host' => 'redis', 'port' => 6379]);
$registry = new CollectorRegistry($adapter);

// Count requests
$counter = $registry->getOrRegisterCounter('app', 'requests_total', 'Total request count', ['endpoint']);
$counter->incBy(1, [$_SERVER['REQUEST_URI']]);

// Measure execution time
$histogram = $registry->getOrRegisterHistogram(
    'app',
    'request_duration_seconds',
    'Request duration in seconds',
    ['endpoint'],
    [0.01, 0.05, 0.1, 0.5, 1, 2, 5]
);

$start = microtime(true);
// Process request...
$duration = microtime(true) - $start;
$histogram->observe($duration, [$_SERVER['REQUEST_URI']]);

// Set gauge for database connections
$gauge = $registry->getOrRegisterGauge('app', 'db_connections', 'Current database connections');
$gauge->set(DB::getConnectionCount());
?>
```

### Prometheus Metrics Endpoint

```php
<?php
// metrics.php - Endpoint for Prometheus scrape metrics

// Header
header('Content-Type: text/plain; version=0.0.4');

// Get registry
$adapter = new Prometheus\Storage\Redis(['host' => 'redis', 'port' => 6379]);
$registry = new Prometheus\CollectorRegistry($adapter);

// Output metrics
$renderer = new Prometheus\RenderTextFormat();
echo $renderer->render($registry->getMetricFamilySamples());
?>
```

### Exception Handling and Error Tracking

```php
<?php
// Set custom error handler
set_error_handler(function($severity, $message, $file, $line) {
    if (!(error_reporting() & $severity)) {
        // Error not in error_reporting
        return;
    }
    throw new ErrorException($message, 0, $severity, $file, $line);
});

// Set exception handler
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

    // Notify Slack for critical errors
    if ($exception instanceof FatalErrorException) {
        notifySlack($exception);
    }

    // Display user-friendly error in production
    if (getenv('APP_ENV') === 'production') {
        http_response_code(500);
        echo json_encode([
            'error' => 'Server Error',
            'message' => 'Something went wrong. Our team has been notified.'
        ]);
    } else {
        // Display detailed error in development
        http_response_code(500);
        echo '<h1>Error</h1>';
        echo '<p>' . htmlspecialchars($exception->getMessage()) . '</p>';
        echo '<pre>' . htmlspecialchars($exception->getTraceAsString()) . '</pre>';
    }
});

// Integrate with Error Tracking service like Sentry
// composer require sentry/sdk
Sentry\init([
    'dsn' => 'https://examplePublicKey@o0.ingest.sentry.io/0',
    'environment' => getenv('APP_ENV'),
    'release' => '1.0.0',
]);

try {
    // Code might cause exception
    processOrder($orderId);
} catch (Throwable $exception) {
    Sentry\captureException($exception);
    // Handle exception
}
?>
```

## 🧑‍🏫 Lesson 29: Performance Tuning and Profiling

### Profiling Tools for PHP

```php
<?php
// Use Xdebug profiling
// php.ini configuration
/*
[xdebug]
xdebug.mode=profile
xdebug.output_dir=/tmp/xdebug
xdebug.profiler_output_name=cachegrind.out.%p
*/

// Use Tideways XHProf
// composer require tideways/php-xhprof-extension

// Start profiling
tideways_xhprof_enable(TIDEWAYS_XHPROF_FLAGS_CPU | TIDEWAYS_XHPROF_FLAGS_MEMORY);

// Code to profile
$result = complexCalculation();

// Stop profiling and save results
$profile_data = tideways_xhprof_disable();
file_put_contents(
    '/tmp/profile_data_' . uniqid() . '.json',
    json_encode($profile_data)
);
?>
```

### Blackfire.io Integration

Integrating Blackfire.io

1. Install Blackfire Agent and PHP Probe following [instructions](https://blackfire.io/docs/integrations/php).

2. Use Blackfire SDK to profile specific code.

   ```bash
   composer require blackfire/php-sdk
   ```

   ```php
   <?php
   \BlackfireProbe::getMainInstance()->enable();

   // Code to profile
   $result = complexCalculation();

   \BlackfireProbe::getMainInstance()->disable();

   // 3. Web UI for interacting with dashboard
   // Use Chrome extension to trigger profile
   ?>
   ```

### Database Query Optimization

```php
<?php
// Analyze and optimize queries

// 1. Enable MySQL Slow Query Log
// my.cnf configuration
/*
[mysqld]
slow_query_log = 1
slow_query_log_file = /var/log/mysql/mysql-slow.log
long_query_time = 1
*/

// 2. Analyze query with EXPLAIN
$stmt = $pdo->prepare("EXPLAIN SELECT * FROM users JOIN orders ON users.id = orders.user_id WHERE users.status = ?");
$stmt->execute(['active']);
$explainResults = $stmt->fetchAll(PDO::FETCH_ASSOC);
print_r($explainResults);

// 3. Optimize queries
// Bad query
$stmt = $pdo->prepare("SELECT * FROM products WHERE category_id = ? ORDER BY price DESC");

// Optimized query - only fetch needed data
$stmt = $pdo->prepare("SELECT id, name, price FROM products WHERE category_id = ? ORDER BY price DESC");

// 4. Use indexes
// Create index
$pdo->exec("CREATE INDEX idx_products_category_price ON products (category_id, price)");

// 5. Avoid N+1 query problem
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
// 1. Install and connect Redis
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

### Load Testing with k6

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

### Best Practices for Performance

1. Use Opcode Cache (OPcache)

   - Improves PHP code execution speed by storing precompiled bytecode.
   - Configure OPcache in php.ini

   ```ini
   [opcache]
   opcache.enable=1
   opcache.memory_consumption=128
   opcache.interned_strings_buffer=8
   opcache.max_accelerated_files=10000
   opcache.validate_timestamps=0 # in production
   opcache.save_comments=1
   opcache.fast_shutdown=1
   opcache.enable_file_override=1
   opcache.jit=1255
   opcache.jit_buffer_size=100M
   ```

2. Avoid eager loading of unnecessary code

   - Use composer autoloader optimization

   ```bash
   composer dump-autoload --optimize
   ```

3. Use connection pooling for database

   - Use PgBouncer or ProxySQL to reduce overhead when creating new connections.
   - Configure PgBouncer

   ```ini
   [databases]
   mydb = host=localhost dbname=mydb user=myuser password=mypassword
   ```

4. Optimize file size
   - Minify & Combine CSS/JS for frontend.
   - Enable HTTP/2 to reduce latency.
   - Enable Gzip compression to reduce response size.
5. Use CDN for static assets.
6. Use queues for heavy processing.

   - Example: email, file processing, report generation.
   - Use RabbitMQ or Redis for queue processing.

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

   // Worker to process queue
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
               // Log error and reject message
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

## 🧑‍🏫 Lesson 30: PHP Interview Preparation and Career Development

### Common PHP Interview Questions

1. PHP Basics:

   - Difference between "==" and "==="?
   - Data types in PHP?
   - Magic methods in PHP?
   - What are superglobals?
   - Scope in PHP (global/local)?

2. OOP in PHP:

   - What is encapsulation, inheritance, polymorphism?
   - Interface vs Abstract class?
   - Type hinting in PHP?
   - What are Traits in PHP and when to use them?
   - Namespaces and their purpose?

3. Design Patterns:

   - What is Singleton pattern and when to use?
   - MVC pattern and role of each component?
   - Factory pattern and when to apply?
   - What is Repository pattern?
   - Dependency Injection and benefits?

4. Database and SQL:

   - What are prepared statements and why use them?
   - MySQL vs PostgreSQL - when to use which?
   - Indexing in database?
   - INNER JOIN vs LEFT JOIN?
   - What are transactions and when are they needed?

5. Security:

   - Cross-site scripting (XSS) and prevention?
   - SQL Injection and prevention?
   - What is CSRF and how to protect against it?
   - Password security in PHP?
   - Session security best practices?

6. Modern PHP:

   - What is Composer and how to manage dependencies?
   - What are PSR standards?
   - New features in PHP 8?
   - Async programming in PHP?
   - Docker and containerization in PHP?

7. Testing:

   - Unit testing vs Integration testing?
   - What is PHPUnit and how to use it?
   - Mocking in testing?
   - What is TDD and why apply it?

8. Performance:

   - How to optimize PHP performance?
   - Caching strategies in PHP?
   - What is Opcache and how to configure it?
   - JIT in PHP 8?
   - When to use queues?

### Portfolio and Open Source

Building a PHP Developer Portfolio:

1. Projects to include in portfolio:

   - CRUD application using MVC framework.
   - RESTful API or GraphQL API.
   - Application with authentication/authorization.
   - Project using complex database relationships.
   - Third-party API integration.

2. Open Source Contributions:

   - Find suitable PHP repositories on GitHub.
   - Start with "good first issues".
   - Contribute documentation.
   - Fix simple bugs.
   - Create small PHP packages.

3. Technical Blog:

   - Write about PHP concepts you just learned.
   - Share case studies from projects.
   - Tutorials on new PHP technologies.
   - Analysis of performance and security issues.

### Career Path in PHP

1. Junior PHP Developer (0-2 years):

   - Solid grasp of basic PHP and OOP.
   - Familiar with at least one framework (Laravel/Symfony).
   - Understand basic database and SQL.
   - Basic knowledge of HTML, CSS, JavaScript.

2. Mid-level PHP Developer (2-5 years):

   - Deep understanding of framework.
   - Design patterns and architectural patterns.
   - Unit testing and CI/CD.
   - Performance optimization.
   - REST APIs and API design.
   - Caching strategies.
   - Professional Git workflow.

3. Senior PHP Developer (5+ years):

   - System design and architecture.
   - Microservices and distributed systems.
   - Infrastructure and DevOps.
   - Database optimization and scaling.
   - Security best practices.
   - Mentoring and code reviews.
   - Cross-functional collaboration.

4. Tech Lead / Architect:

   - Guide system architecture.
   - Select technology and technical roadmap.
   - Manage technical debt.
   - Train and develop team.
   - Participate in hiring process.
   - Communicate with stakeholders.

5. Specialized paths:

   - DevOps Engineer
   - Security Specialist
   - Performance Engineer
   - API Architect
   - Open Source Contributor

### Technical Interview Preparation

1. Coding challenges:
   - Practice on LeetCode/HackerRank.
   - Implement basic algorithms.
   - Solve design pattern problems.

2. Whiteboard/system design:
   - Practice designing databases.
   - Draw architecture diagrams.
   - Explain trade-offs in decisions.

3. Mock interviews:
   - Pair programming with colleagues.
   - Online mock interviews.
   - Review and improve from feedback.

4. Prepare questions for interviewers:
   - Tech stack and challenges.
   - Engineering culture and processes.
   - Career growth and mentorship.
   - Work-life balance.

```php
<?php
// Example: Common Coding Challenge
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
Follow and update PHP knowledge:

1. PHP RFC and GitHub:
   - https://wiki.php.net/rfc
   - https://github.com/php/php-src

2. Blogs and newsletters:
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

5. Online courses and platforms:
   - Laracasts
   - Symfonycasts
   - PHP The Right Way

6. Twitter accounts and social media:
   - @official_php
   - @laravelphp
   - @symfony
   - @nikita_ppv
*/
?>
```

## 🧪 FINAL COMPREHENSIVE PROJECT: Build a Complete E-Learning System

### Requirements

1. System Architecture:

   - Apply microservices architecture.
   - Use Docker to containerize services.
   - Implement CI/CD pipeline.

2. Core Modules:

   - Authentication Service (registration, login, user management).
   - Course Service (create courses, manage content).
   - Enrollment Service (enroll in courses, track progress).
   - Media Service (upload and stream lecture videos).
   - Analytics Service (statistics, reports).
   - Payment Service (course payments).

3. Technical Requirements:

   - Backend API: PHP 8.1+, Laravel/Symfony.
   - Database: MySQL/PostgreSQL.
   - Cache: Redis.
   - Message Queue: RabbitMQ.
   - Frontend: Vue.js/React.
   - Authentication: JWT/OAuth2.
   - API Gateway: Kong/Nginx.
   - Logging: ELK Stack.
   - Monitoring: Prometheus/Grafana.
   - Testing: PHPUnit, Jest.

4. Features:

   - Registration/Login (email, social).
   - User/Instructor dashboard.
   - Create and manage courses.
   - Upload and manage lecture videos.
   - Discussion forum for each course.
   - Online payment.
   - Reporting and data analysis.
   - Integrated notifications (email, push).
   - Admin panel to manage the whole system.

5. Advanced Features:

   - Real-time chat with instructors.
   - Video conferencing for live classes.
   - Recommendation system for courses.
   - Mobile-friendly responsive design.
   - Progressive Web App capabilities.
   - Multilingual support.
   - Content caching and CDN integration.

### Project Structure

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

### Evaluation Criteria

1. Code Quality:

   - Clean code and best practices.
   - Proper documentation.
   - Appropriate design patterns usage.
   - Code consistency and style standards (PSR).

2. Architecture:

   - Microservices communication.
   - System resilience.
   - Scaling capabilities.
   - Service boundaries.

3. Testing:

   - Unit tests (minimum 70% coverage).
   - Integration tests.
   - E2E tests for critical flows.

4. Performance:

   - Optimization techniques.
   - Caching strategy.
   - Response time (<300ms for APIs).

5. Security:

   - Authentication/Authorization.
   - Data protection.
   - Input validation.
   - CSRF/XSS prevention.

6. CI/CD:

   - Automated testing.
   - Deployment pipeline.
   - Environment configurations.
   - Monitoring integration.

7. Documentation:

   - API documentation.
   - System architecture diagrams.
   - Setup and deployment instructions.
   - User guides.
