# 📘 PHẦN 4: FRAMEWORK VÀ PHÁT TRIỂN ỨNG DỤNG WEB HIỆN ĐẠI

## Nội dung

- [📘 PHẦN 4: FRAMEWORK VÀ PHÁT TRIỂN ỨNG DỤNG WEB HIỆN ĐẠI](#-phần-4-framework-và-phát-triển-ứng-dụng-web-hiện-đại)
  - [Nội dung](#nội-dung)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 16: Giới thiệu về MVC và Framework](#-bài-16-giới-thiệu-về-mvc-và-framework)
  - [🧑‍🏫 Bài 17: Laravel Framework](#-bài-17-laravel-framework)
  - [🧑‍🏫 Bài 18: Composer và Package Management](#-bài-18-composer-và-package-management)
  - [🧑‍🏫 Bài 19: Testing trong PHP](#-bài-19-testing-trong-php)
  - [🧑‍🏫 Bài 20: DevOps và Deployment](#-bài-20-devops-và-deployment)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN](#-bài-tập-lớn-cuối-phần)
    - [**Đề bài: Xây dựng ứng dụng web bằng Laravel**](#đề-bài-xây-dựng-ứng-dụng-web-bằng-laravel)
    - [**Yêu cầu:**](#yêu-cầu)
    - [**Cấu trúc dự án:**](#cấu-trúc-dự-án)

## 🎯 Mục tiêu tổng quát

- Hiểu và áp dụng mô hình MVC trong phát triển ứng dụng
- Nắm vững các khái niệm cơ bản của Laravel Framework
- Sử dụng thành thạo Composer để quản lý thư viện và dependencies
- Biết cách viết test và áp dụng TDD (Test-Driven Development)
- Triển khai ứng dụng PHP lên môi trường production an toàn

---

## 🧑‍🏫 Bài 16: Giới thiệu về MVC và Framework

**Mô hình MVC (Model-View-Controller):**

```php
<?php
/*
MVC là mô hình kiến trúc phần mềm chia ứng dụng thành 3 thành phần chính:
- Model: Xử lý dữ liệu và logic nghiệp vụ
- View: Hiển thị dữ liệu và giao diện người dùng
- Controller: Điều khiển luồng xử lý, kết nối Model và View
*/

// Ví dụ MVC đơn giản

// Model
class UserModel {
    private $db;

    public function __construct($db) {
        $this->db = $db;
    }

    public function getAll() {
        // Truy vấn database để lấy tất cả người dùng
        $stmt = $this->db->query("SELECT id, name, email FROM users");
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getById($id) {
        $stmt = $this->db->prepare("SELECT id, name, email FROM users WHERE id = ?");
        $stmt->execute([$id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function create($data) {
        $stmt = $this->db->prepare("INSERT INTO users (name, email, password) VALUES (?, ?, ?)");
        $stmt->execute([
            $data['name'],
            $data['email'],
            password_hash($data['password'], PASSWORD_DEFAULT)
        ]);
        return $this->db->lastInsertId();
    }
}

// Controller
class UserController {
    private $model;

    public function __construct($model) {
        $this->model = $model;
    }

    public function index() {
        // Xử lý yêu cầu hiển thị danh sách users
        $users = $this->model->getAll();

        // Truyền dữ liệu cho view
        include 'views/users/index.php';
    }

    public function show($id) {
        // Xử lý yêu cầu hiển thị chi tiết một user
        $user = $this->model->getById($id);

        if (!$user) {
            header('HTTP/1.0 404 Not Found');
            include 'views/errors/404.php';
            return;
        }

        include 'views/users/show.php';
    }

    public function create() {
        // Hiển thị form tạo mới
        include 'views/users/create.php';
    }

    public function store() {
        // Xử lý dữ liệu từ form và tạo user mới
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            // Validate input
            $errors = [];

            if (empty($_POST['name'])) {
                $errors[] = 'Name is required';
            }

            if (empty($_POST['email'])) {
                $errors[] = 'Email is required';
            } elseif (!filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
                $errors[] = 'Email is not valid';
            }

            if (empty($_POST['password'])) {
                $errors[] = 'Password is required';
            }

            if (!empty($errors)) {
                // Hiển thị lỗi và form
                include 'views/users/create.php';
                return;
            }

            // Tạo user mới
            $userId = $this->model->create($_POST);

            // Redirect to user detail page
            header("Location: /users/{$userId}");
        }
    }
}

// View (users/index.php)
/*
<!DOCTYPE html>
<html>
<head>
    <title>User List</title>
</head>
<body>
    <h1>User List</h1>
    <a href="/users/create">Add New User</a>

    <table border="1">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Actions</th>
        </tr>
        <?php foreach ($users as $user): ?>
        <tr>
            <td><?php echo $user['id']; ?></td>
            <td><?php echo htmlspecialchars($user['name']); ?></td>
            <td><?php echo htmlspecialchars($user['email']); ?></td>
            <td>
                <a href="/users/<?php echo $user['id']; ?>">View</a>
                <a href="/users/<?php echo $user['id']; ?>/edit">Edit</a>
                <a href="/users/<?php echo $user['id']; ?>/delete"
                   onclick="return confirm('Are you sure?')">Delete</a>
            </td>
        </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>
*/

// Routing đơn giản
$db = new PDO('mysql:host=localhost;dbname=myapp', 'username', 'password');
$userModel = new UserModel($db);
$userController = new UserController($userModel);

$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

if ($uri === '/users' || $uri === '/users/') {
    $userController->index();
} elseif ($uri === '/users/create') {
    $userController->create();
} elseif ($uri === '/users/store' && $_SERVER['REQUEST_METHOD'] === 'POST') {
    $userController->store();
} elseif (preg_match('/^\/users\/(\d+)$/', $uri, $matches)) {
    $userController->show($matches[1]);
}
?>
```

**Giới thiệu về Framework PHP phổ biến:**

```php
<?php
/*
Framework cung cấp cấu trúc và các công cụ để xây dựng ứng dụng web nhanh chóng và an toàn.
Các framework PHP phổ biến:

1. Laravel - https://laravel.com/
   - Full-stack framework phổ biến nhất hiện nay
   - Cú pháp rõ ràng, dễ đọc
   - Hệ sinh thái phong phú

2. Symfony - https://symfony.com/
   - Framework mạnh mẽ với nhiều component có thể tái sử dụng
   - Được sử dụng bởi nhiều framework và CMS khác

3. CodeIgniter - https://codeigniter.com/
   - Nhẹ, nhanh, footprint nhỏ
   - Dễ học cho người mới bắt đầu

4. Slim - https://www.slimframework.com/
   - Micro-framework tập trung vào routing và middleware
   - Lý tưởng cho API nhỏ và ứng dụng đơn giản

5. Yii - https://www.yiiframework.com/
   - Framework hiệu suất cao
   - Tích hợp AJAX và jQuery

6. CakePHP - https://cakephp.org/
   - Convention over Configuration
   - Scaffolding và code generation

7. Zend/Laminas - https://getlaminas.org/
   - Enterprise-ready
   - Modular architecture

8. Phalcon - https://phalcon.io/
   - Framework hiệu suất cao được viết bằng C
   - Được cài đặt như một extension PHP
*/

// So sánh cấu trúc cơ bản của một số framework

// Laravel (routes/web.php)
/*
Route::get('/users', 'UserController@index');
Route::get('/users/create', 'UserController@create');
Route::post('/users', 'UserController@store');
Route::get('/users/{id}', 'UserController@show');
*/

// Symfony (config/routes.yaml)
/*
users_index:
    path: /users
    controller: App\Controller\UserController::index

users_create:
    path: /users/create
    controller: App\Controller\UserController::create

users_store:
    path: /users
    controller: App\Controller\UserController::store
    methods: [POST]

users_show:
    path: /users/{id}
    controller: App\Controller\UserController::show
*/

// CodeIgniter (app/Config/Routes.php)
/*
$routes->get('users', 'UserController::index');
$routes->get('users/create', 'UserController::create');
$routes->post('users', 'UserController::store');
$routes->get('users/(:num)', 'UserController::show/$1');
*/

// Slim
/*
$app->get('/users', 'UserController:index');
$app->get('/users/create', 'UserController:create');
$app->post('/users', 'UserController:store');
$app->get('/users/{id}', 'UserController:show');
*/

?>
```

**Xây dựng MVC Framework đơn giản:**

```php
<?php
// Một Mini MVC Framework đơn giản

// index.php (Front Controller)
require_once 'config.php';
require_once 'core/Router.php';
require_once 'core/Controller.php';
require_once 'core/Model.php';
require_once 'core/View.php';
require_once 'core/Database.php';

// Autoload classes
function autoload($class) {
    // Tự động load class từ các thư mục controllers, models, etc.
    $paths = [
        'app/controllers/',
        'app/models/',
        'app/core/'
    ];

    foreach ($paths as $path) {
        $file = $path . $class . '.php';
        if (file_exists($file)) {
            require_once $file;
            return;
        }
    }
}

spl_autoload_register('autoload');

// Khởi tạo router và xử lý request
$router = new Router();
$router->dispatch();

// core/Router.php
class Router {
    private $routes = [];

    public function __construct() {
        // Load routes from routes.php
        require 'app/routes.php';
    }

    public function add($method, $url, $controller, $action) {
        $this->routes[] = [
            'method' => $method,
            'url' => $url,
            'controller' => $controller,
            'action' => $action
        ];
    }

    public function dispatch() {
        $method = $_SERVER['REQUEST_METHOD'];
        $url = $_SERVER['REQUEST_URI'];
        $url = parse_url($url, PHP_URL_PATH);

        // Xử lý route
        foreach ($this->routes as $route) {
            // Convert route URL to regex pattern
            $pattern = $this->convertRouteToRegex($route['url']);

            if ($route['method'] === $method && preg_match($pattern, $url, $matches)) {
                array_shift($matches); // Remove the full match

                // Create controller instance
                $controllerName = $route['controller'] . 'Controller';
                $controller = new $controllerName();

                // Call the action with parameters
                call_user_func_array([$controller, $route['action']], $matches);
                return;
            }
        }

        // No route found
        header('HTTP/1.0 404 Not Found');
        echo '404 Page Not Found';
    }

    private function convertRouteToRegex($route) {
        // Convert parameters like {id} to regex capture groups
        $pattern = preg_replace('/\{([a-zA-Z0-9_]+)\}/', '([^/]+)', $route);
        return '/^' . str_replace('/', '\/', $pattern) . '$/';
    }
}

// core/Controller.php
class Controller {
    protected function view($view, $data = []) {
        // Extract data to make variables available in view
        extract($data);

        // Load view file
        require_once 'app/views/' . $view . '.php';
    }

    protected function redirect($url) {
        header('Location: ' . $url);
        exit;
    }
}

// core/Model.php
class Model {
    protected $db;
    protected $table;

    public function __construct() {
        $this->db = Database::getInstance();
    }

    public function all() {
        $query = "SELECT * FROM {$this->table}";
        return $this->db->query($query)->fetchAll(PDO::FETCH_ASSOC);
    }

    public function find($id) {
        $query = "SELECT * FROM {$this->table} WHERE id = ?";
        return $this->db->prepare($query)->execute([$id])->fetch(PDO::FETCH_ASSOC);
    }

    // Thêm các methods khác: create, update, delete...
}

// core/Database.php
class Database {
    private static $instance = null;
    private $pdo;

    private function __construct() {
        try {
            $this->pdo = new PDO(
                'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME,
                DB_USER,
                DB_PASS,
                [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
            );
        } catch (PDOException $e) {
            die('Database connection failed: ' . $e->getMessage());
        }
    }

    public static function getInstance() {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance->pdo;
    }

    // Prevent cloning
    private function __clone() {}
}

// Example routes.php
/*
$router->add('GET', '/', 'Home', 'index');
$router->add('GET', '/users', 'User', 'index');
$router->add('GET', '/users/{id}', 'User', 'show');
$router->add('GET', '/users/create', 'User', 'create');
$router->add('POST', '/users', 'User', 'store');
*/

// Example UserController.php
/*
class UserController extends Controller {
    private $userModel;

    public function __construct() {
        $this->userModel = new UserModel();
    }

    public function index() {
        $users = $this->userModel->all();
        $this->view('users/index', ['users' => $users]);
    }

    public function show($id) {
        $user = $this->userModel->find($id);
        $this->view('users/show', ['user' => $user]);
    }

    // Other methods...
}
*/
?>
```

---

## 🧑‍🏫 Bài 17: Laravel Framework

**Cài đặt và Cấu hình Laravel:**

```bash
# Cài đặt Composer (nếu chưa có)
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Tạo project Laravel mới
composer create-project laravel/laravel my-laravel-app

# Hoặc sử dụng Laravel Installer
composer global require laravel/installer
laravel new my-laravel-app

# Chạy development server
cd my-laravel-app
php artisan serve
```

**Cấu trúc thư mục Laravel:**

```text
my-laravel-app/
├── app/                     # Chứa code cốt lõi của ứng dụng
│   ├── Console/              # Chứa các lệnh Artisan custom
│   ├── Exceptions/          # Xử lý exceptions
│   ├── Http/                # Controllers, Middleware, Requests
│   ├── Models/              # Các model Eloquent
│   └── Providers/           # Service providers
├── bootstrap/              # Khởi động framework
├── config/                 # Configuration files
├── database/               # Database migrations, factories, seeds
├── lang/                   # Localization files
├── public/                 # Document root, entrypoint (index.php)
├── resources/              # Views, assets, language files
│   ├── js/                  # JavaScript files
│   ├── sass/                # SASS files
│   └── views/               # Templates
├── routes/                 # Định nghĩa các routes
│   ├── api.php              # API routes
│   ├── channels.php         # Broadcasting channels
│   ├── console.php          # Console routes
│   └── web.php              # Web routes
├── storage/                # Compiled templates, file uploads, logs
├── tests/                  # Automated tests
├── vendor/                 # Composer dependencies
├── .env                    # Environment variables
├── artisan                 # Command-line tool
└── composer.json           # Composer dependencies
```

**Routing và Controller trong Laravel:**

```php
<?php
// routes/web.php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;

// Basic route
Route::get('/', function () {
    return view('welcome');
});

// Route to controller
Route::get('/users', [UserController::class, 'index']);
Route::get('/users/create', [UserController::class, 'create']);
Route::post('/users', [UserController::class, 'store']);
Route::get('/users/{id}', [UserController::class, 'show']);
Route::get('/users/{id}/edit', [UserController::class, 'edit']);
Route::put('/users/{id}', [UserController::class, 'update']);
Route::delete('/users/{id}', [UserController::class, 'destroy']);

// Route groups
Route::prefix('admin')->middleware(['auth', 'admin'])->group(function () {
    Route::get('/dashboard', [AdminController::class, 'dashboard']);
    Route::resource('posts', AdminPostController::class);
});

// Named routes
Route::get('/user/profile', [ProfileController::class, 'show'])->name('profile');

// Sử dụng named route trong view hoặc code
// <a href="{{ route('profile') }}">Profile</a>

// Tự động tạo tất cả các routes CRUD
Route::resource('photos', PhotoController::class);

// API routes (routes/api.php)
Route::get('/users', [UserApiController::class, 'index']);
Route::post('/users', [UserApiController::class, 'store']);
?>
```

**Controller trong Laravel:**

```php
<?php
// app/Http/Controllers/UserController.php
namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Requests\StoreUserRequest;

class UserController extends Controller
{
    /**
     * Hiển thị danh sách người dùng
     */
    public function index()
    {
        $users = User::all();
        return view('users.index', compact('users'));
    }

    /**
     * Hiển thị form tạo người dùng mới
     */
    public function create()
    {
        return view('users.create');
    }

    /**
     * Lưu người dùng mới vào database
     */
    public function store(StoreUserRequest $request)
    {
        // Form validation được xử lý trong StoreUserRequest

        // Tạo user mới
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password),
        ]);

        return redirect()->route('users.show', $user->id)
                         ->with('success', 'User created successfully');
    }

    /**
     * Hiển thị thông tin của một người dùng
     */
    public function show($id)
    {
        $user = User::findOrFail($id);
        return view('users.show', compact('user'));
    }

    /**
     * Hiển thị form sửa thông tin người dùng
     */
    public function edit($id)
    {
        $user = User::findOrFail($id);
        return view('users.edit', compact('user'));
    }

    /**
     * Cập nhật thông tin người dùng
     */
    public function update(Request $request, $id)
    {
        $user = User::findOrFail($id);

        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email,' . $id,
        ]);

        $user->update($validated);

        return redirect()->route('users.show', $user->id)
                         ->with('success', 'User updated successfully');
    }

    /**
     * Xóa người dùng
     */
    public function destroy($id)
    {
        $user = User::findOrFail($id);
        $user->delete();

        return redirect()->route('users.index')
                         ->with('success', 'User deleted successfully');
    }
}
?>
```

**Model và Eloquent ORM:**

```php
<?php
// app/Models/User.php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class User extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    /**
     * Get the posts for the user.
     */
    public function posts()
    {
        return $this->hasMany(Post::class);
    }

    /**
     * Get the profile associated with the user.
     */
    public function profile()
    {
        return $this->hasOne(Profile::class);
    }

    /**
     * The roles that belong to the user.
     */
    public function roles()
    {
        return $this->belongsToMany(Role::class);
    }
}
?>
```

**Blade Templating System:**

```php
// resources/views/layouts/app.blade.php
<!DOCTYPE html>
<html>
<head>
    <title>@yield('title', 'My App')</title>
    <link href="{{ asset('css/app.css') }}" rel="stylesheet">
</head>
<body>
    <header>
        @include('partials.nav')
    </header>

    <div class="container">
        @yield('content')
    </div>

    <footer>
        @include('partials.footer')
    </footer>

    <script src="{{ asset('js/app.js') }}"></script>
    @stack('scripts')
</body>
</html>

// resources/views/users/index.blade.php
@extends('layouts.app')

@section('title', 'User List')

@section('content')
    <h1>User List</h1>

    @if (session('success'))
        <div class="alert alert-success">
            {{ session('success') }}
        </div>
    @endif

    <a href="{{ route('users.create') }}" class="btn btn-primary">Add New User</a>

    <table class="table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($users as $user)
                <tr>
                    <td>{{ $user->id }}</td>
                    <td>{{ $user->name }}</td>
                    <td>{{ $user->email }}</td>
                    <td>
                        <a href="{{ route('users.show', $user->id) }}" class="btn btn-info btn-sm">View</a>
                        <a href="{{ route('users.edit', $user->id) }}" class="btn btn-warning btn-sm">Edit</a>

                        <form action="{{ route('users.destroy', $user->id) }}" method="POST" style="display: inline;">
                            @csrf
                            @method('DELETE')
                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</button>
                        </form>
                    </td>
                </tr>
            @empty
                <tr>
                    <td colspan="4">No users found</td>
                </tr>
            @endforelse
        </tbody>
    </table>
@endsection

@push('scripts')
    <script>
        console.log('User list page loaded');
    </script>
@endpush
```

**Migrations và Database:**

```php
<?php
// database/migrations/2014_10_12_000000_create_users_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->rememberToken();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
}

// Tạo migration mới bằng Artisan
// php artisan make:migration create_posts_table

// Chạy migrations
// php artisan migrate

// Các lệnh migrate khác
// php artisan migrate:rollback
// php artisan migrate:reset
// php artisan migrate:refresh
// php artisan migrate:fresh
?>
```

---

## 🧑‍🏫 Bài 18: Composer và Package Management

**Giới thiệu về Composer:**

```bash
# Cài đặt Composer (Linux/macOS)
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Kiểm tra cài đặt
composer --version

# Khởi tạo dự án mới
composer init

# Cài đặt package
composer require monolog/monolog

# Cài đặt package cho môi trường development
composer require --dev phpunit/phpunit

# Cập nhật tất cả packages
composer update

# Cài đặt packages từ composer.json
composer install
```

**Tạo và sử dụng package:**

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

// Câu lệnh test
// vendor/bin/phpunit tests/
?>
```

**Autoloading trong PHP:**

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

// Sau khi chỉnh sửa autoload, cập nhật lại autoloader
// composer dump-autoload

// Sử dụng autoload
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

**Sử dụng packages phổ biến:**

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

---

## 🧑‍🏫 Bài 19: Testing trong PHP

**Unit Testing với PHPUnit:**

```php
<?php
// composer require --dev phpunit/phpunit

// src/Calculator.php
namespace App;

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

    public function multiply($a, $b)
    {
        return $a * $b;
    }

    public function divide($a, $b)
    {
        if ($b == 0) {
            throw new \InvalidArgumentException("Cannot divide by zero");
        }

        return $a / $b;
    }
}

// tests/CalculatorTest.php
namespace Tests;

use PHPUnit\Framework\TestCase;
use App\Calculator;

class CalculatorTest extends TestCase
{
    protected $calculator;

    protected function setUp(): void
    {
        $this->calculator = new Calculator();
    }

    public function testAdd()
    {
        $this->assertEquals(4, $this->calculator->add(2, 2));
        $this->assertEquals(0, $this->calculator->add(-2, 2));
    }

    public function testSubtract()
    {
        $this->assertEquals(0, $this->calculator->subtract(2, 2));
        $this->assertEquals(-4, $this->calculator->subtract(2, 6));
    }

    public function testMultiply()
    {
        $this->assertEquals(4, $this->calculator->multiply(2, 2));
        $this->assertEquals(-4, $this->calculator->multiply(2, -2));
        $this->assertEquals(0, $this->calculator->multiply(0, 5));
    }

    public function testDivide()
    {
        $this->assertEquals(1, $this->calculator->divide(2, 2));
        $this->assertEquals(2.5, $this->calculator->divide(5, 2));
    }

    public function testDivideByZero()
    {
        $this->expectException(\InvalidArgumentException::class);
        $this->calculator->divide(5, 0);
    }

    // Data Provider example
    public function additionProvider()
    {
        return [
            [0, 0, 0],
            [0, 1, 1],
            [1, 0, 1],
            [1, 1, 2],
            [-1, 1, 0],
        ];
    }

    /**
     * @dataProvider additionProvider
     */
    public function testAddWithDataProvider($a, $b, $expected)
    {
        $this->assertEquals($expected, $this->calculator->add($a, $b));
    }
}

// phpunit.xml
/*
<?xml version="1.0" encoding="UTF-8"?>
<phpunit bootstrap="vendor/autoload.php"
         colors="true"
         verbose="true">
    <testsuites>
        <testsuite name="Application Test Suite">
            <directory>tests</directory>
        </testsuite>
    </testsuites>
    <php>
        <env name="APP_ENV" value="testing"/>
    </php>
</phpunit>
*/

// Chạy tests
// vendor/bin/phpunit
?>
```

**Feature Testing trong Laravel:**

```php
<?php
// Trong Laravel, tạo Feature Test
// php artisan make:test UserTest

// tests/Feature/UserTest.php
namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class UserTest extends TestCase
{
    use RefreshDatabase;

    public function testUserCanViewLoginPage()
    {
        $response = $this->get('/login');
        $response->assertStatus(200);
    }

    public function testUserCanLogin()
    {
        // Create a user
        $user = User::factory()->create([
            'email' => 'test@example.com',
            'password' => bcrypt('password123'),
        ]);

        // Attempt login
        $response = $this->post('/login', [
            'email' => 'test@example.com',
            'password' => 'password123',
        ]);

        // Assert the user is authenticated and redirected
        $response->assertRedirect('/home');
        $this->assertAuthenticatedAs($user);
    }

    public function testUserCanViewUsersList()
    {
        // Create a user with admin role
        $admin = User::factory()->create();

        // Create some users to be listed
        User::factory()->count(5)->create();

        // Act as the admin and access users list
        $response = $this->actingAs($admin)->get('/users');

        // Assert response
        $response->assertStatus(200);
        $response->assertViewIs('users.index');
        $response->assertViewHas('users');
    }

    public function testUserCanCreateNewUser()
    {
        $admin = User::factory()->create();

        $response = $this->actingAs($admin)
                         ->post('/users', [
                            'name' => 'New User',
                            'email' => 'newuser@example.com',
                            'password' => 'password123',
                            'password_confirmation' => 'password123',
                         ]);

        $response->assertRedirect();

        // Verify the user was created in database
        $this->assertDatabaseHas('users', [
            'name' => 'New User',
            'email' => 'newuser@example.com',
        ]);
    }
}
?>
```

**Mock Objects và Testing với Dependencies:**

```php
<?php
// src/UserService.php
namespace App;

class UserService
{
    private $userRepository;
    private $mailer;

    public function __construct(UserRepository $userRepository, Mailer $mailer)
    {
        $this->userRepository = $userRepository;
        $this->mailer = $mailer;
    }

    public function register($email, $password)
    {
        // Validate email
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            throw new \InvalidArgumentException("Invalid email");
        }

        // Check if email is already registered
        if ($this->userRepository->findByEmail($email)) {
            throw new \RuntimeException("Email already registered");
        }

        // Create user
        $userId = $this->userRepository->create($email, $password);

        // Send welcome email
        $this->mailer->sendWelcomeEmail($email);

        return $userId;
    }
}

// tests/UserServiceTest.php
namespace Tests;

use PHPUnit\Framework\TestCase;
use App\UserService;
use App\UserRepository;
use App\Mailer;

class UserServiceTest extends TestCase
{
    private $userService;
    private $userRepository;
    private $mailer;

    protected function setUp(): void
    {
        // Create mock objects
        $this->userRepository = $this->createMock(UserRepository::class);
        $this->mailer = $this->createMock(Mailer::class);

        // Inject mocks into service
        $this->userService = new UserService($this->userRepository, $this->mailer);
    }

    public function testRegisterWithValidData()
    {
        // Arrange
        $email = 'test@example.com';
        $password = 'password123';

        // Mock userRepository->findByEmail to return null (user not found)
        $this->userRepository->expects($this->once())
                            ->method('findByEmail')
                            ->with($email)
                            ->willReturn(null);

        // Mock userRepository->create to return a user ID
        $this->userRepository->expects($this->once())
                            ->method('create')
                            ->with($email, $password)
                            ->willReturn(123);

        // Mock mailer->sendWelcomeEmail to be called once
        $this->mailer->expects($this->once())
                    ->method('sendWelcomeEmail')
                    ->with($email);

        // Act
        $userId = $this->userService->register($email, $password);

        // Assert
        $this->assertEquals(123, $userId);
    }

    public function testRegisterWithInvalidEmail()
    {
        // Arrange - no mock setup needed for this test

        // Assert that exception is thrown
        $this->expectException(\InvalidArgumentException::class);

        // Act
        $this->userService->register('invalid-email', 'password123');
    }

    public function testRegisterWithEmailAlreadyRegistered()
    {
        // Arrange
        $email = 'existing@example.com';

        // Mock userRepository->findByEmail to return a user (email exists)
        $this->userRepository->expects($this->once())
                            ->method('findByEmail')
                            ->with($email)
                            ->willReturn(['id' => 456, 'email' => $email]);

        // Assert that exception is thrown
        $this->expectException(\RuntimeException::class);

        // Act
        $this->userService->register($email, 'password123');
    }
}
?>
```

**Code Coverage và Best Practices:**

```bash
# Chạy PHPUnit với code coverage report (HTML)
vendor/bin/phpunit --coverage-html coverage

# Chạy tests với specific test file
vendor/bin/phpunit tests/UserServiceTest.php

# Chạy tests với specific test method
vendor/bin/phpunit --filter testRegisterWithValidData tests/UserServiceTest.php
```

```php
<?php
// Best Practices cho Testing

/*
1. Follow AAA pattern
   - Arrange: Set up the test environment
   - Act: Execute the code being tested
   - Assert: Verify the output is as expected

2. Test only one thing per test method

3. Use clear naming conventions
   - testShouldDoSomethingWhenSomething
   - testMethodNameWhenStateUnderTest

4. Use Data Providers for testing same logic with different inputs

5. Keep tests independent - don't make tests depend on each other

6. Avoid mocking too much - if you're mocking everything, you're testing nothing

7. Test edge cases and failure scenarios, not just the happy path

8. Write both Unit Tests and Integration Tests

9. Use setUp() and tearDown() for common test initialization and cleanup

10. Use assertion methods appropriately
    - assertEquals
    - assertSame (=== comparison)
    - assertTrue/assertFalse
    - assertNull
    - assertArrayHasKey
    - assertCount
    - assertInstanceOf
    - etc.

11. For Laravel, use factories to generate test data

12. Use test doubles appropriately
    - Mocks: For verifying method calls
    - Stubs: For providing canned answers
    - Spies: For recording method calls
    - Dummies: For filling parameter lists
    - Fakes: For replacing real implementations
*/
?>
```

---

## 🧑‍🏫 Bài 20: DevOps và Deployment

**Chuẩn bị môi trường Production:**

```bash
# Một số điểm cần chú ý khi deploy PHP

# 1. Production environment settings
# .env.production
APP_ENV=production
APP_DEBUG=false
APP_URL=https://your-production-domain.com

# In Laravel, optimize for production
composer install --optimize-autoloader --no-dev
php artisan config:cache
php artisan route:cache
php artisan view:cache

# 2. Web server configuration (Apache)
# .htaccess (Laravel)
<IfModule mod_rewrite.c>
    <IfModule mod_negotiation.c>
        Options -MultiViews -Indexes
    </IfModule>

    RewriteEngine On

    # Handle Authorization Header
    RewriteCond %{HTTP:Authorization} .
    RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]

    # Redirect Trailing Slashes If Not A Folder
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteCond %{REQUEST_URI} (.+)/$
    RewriteRule ^ %1 [L,R=301]

    # Send Requests To Front Controller
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^ index.php [L]
</IfModule>

# 3. Nginx configuration
# /etc/nginx/sites-available/your-app
server {
    listen 80;
    server_name your-domain.com;
    root /var/www/your-app/public;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-XSS-Protection "1; mode=block";
    add_header X-Content-Type-Options "nosniff";

    index index.php;

    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    error_page 404 /index.php;

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.0-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}

# 4. SSL Configuration with Let's Encrypt
sudo add-apt-repository ppa:certbot/certbot
sudo apt install python-certbot-nginx
sudo certbot --nginx -d your-domain.com
```

**Continuous Integration và Continuous Deployment:**

```yaml
# GitHub Actions workflow (.github/workflows/ci.yml)
name: PHP CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest

    services:
      mysql:
        image: mysql:5.7
        env:
          MYSQL_ROOT_PASSWORD: root
          MYSQL_DATABASE: test_db
        ports:
          - 3306:3306
        options: --health-cmd="mysqladmin ping" --health-interval=10s --health-timeout=5s --health-retries=3

    steps:
      - uses: actions/checkout@v2

      - name: Setup PHP
        uses: shivammathur/setup-php@v2
        with:
          php-version: "8.0"
          extensions: mbstring, intl, pdo_mysql, zip
          coverage: xdebug

      - name: Validate composer.json and composer.lock
        run: composer validate

      - name: Cache Composer packages
        id: composer-cache
        uses: actions/cache@v2
        with:
          path: vendor
          key: ${{ runner.os }}-php-${{ hashFiles('**/composer.lock') }}
          restore-keys: |
            ${{ runner.os }}-php-

      - name: Install dependencies
        run: composer install --prefer-dist --no-progress

      - name: Copy environment file
        run: cp .env.example .env

      - name: Generate app key
        run: php artisan key:generate

      - name: Run database migrations
        run: php artisan migrate
        env:
          DB_CONNECTION: mysql
          DB_HOST: 127.0.0.1
          DB_PORT: 3306
          DB_DATABASE: test_db
          DB_USERNAME: root
          DB_PASSWORD: root

      - name: Run tests
        run: vendor/bin/phpunit

      - name: Upload coverage report
        uses: codecov/codecov-action@v1
        with:
          token: ${{ secrets.CODECOV_TOKEN }}
          file: ./coverage.xml

  deploy:
    needs: test
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2

      - name: Deploy to production
        uses: appleboy/ssh-action@master
        with:
          host: ${{ secrets.HOST }}
          username: ${{ secrets.USERNAME }}
          key: ${{ secrets.SSH_PRIVATE_KEY }}
          script: |
            cd /var/www/your-app
            git pull
            composer install --no-dev --optimize-autoloader
            php artisan migrate --force
            php artisan config:cache
            php artisan route:cache
            php artisan view:cache
```

**Performance Tuning:**

```php
<?php
// .user.ini or php.ini settings
ini_set('max_execution_time', 30); // Limit script execution time
ini_set('memory_limit', '256M');   // Limit memory usage
ini_set('upload_max_filesize', '10M'); // Limit file upload size
ini_set('post_max_size', '10M');   // Limit POST request size

// opcache settings
ini_set('opcache.enable', 1);
ini_set('opcache.memory_consumption', 128);
ini_set('opcache.interned_strings_buffer', 8);
ini_set('opcache.max_accelerated_files', 4000);
ini_set('opcache.revalidate_freq', 60);
ini_set('opcache.fast_shutdown', 1);
ini_set('opcache.enable_cli', 1);
ini_set('opcache.jit', 1255);
ini_set('opcache.jit_buffer_size', '64M');

// Laravel Performance Tips

// 1. Use eager loading to avoid N+1 problem
$posts = App\Models\Post::with('author', 'comments')->get();

// Instead of:
$posts = App\Models\Post::all();
foreach ($posts as $post) {
    // This causes N+1 queries
    echo $post->author->name;
}

// 2. Index your database columns
// In migration:
$table->index('user_id');
$table->index(['status', 'created_at']);

// 3. Cache expensive operations
$value = Cache::remember('users', $seconds, function () {
    return DB::table('users')->get();
});

// 4. Use pagination instead of fetching all records
$users = App\Models\User::paginate(15);

// 5. Use queues for time-consuming tasks
// app/Jobs/ProcessPodcast.php
class ProcessPodcast implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $podcast;

    public function __construct(Podcast $podcast)
    {
        $this->podcast = $podcast;
    }

    public function handle()
    {
        // Process uploaded podcast...
    }
}

// Dispatch the job
ProcessPodcast::dispatch($podcast);

// 6. Use database chunking for large datasets
User::chunk(200, function ($users) {
    foreach ($users as $user) {
        // Process user
    }
});

// 7. Choose appropriate cache driver
// config/cache.php
'default' => env('CACHE_DRIVER', 'redis'),
?>
```

**Monitoring và Logging:**

```php
<?php
// Monolog configuration in Laravel
// config/logging.php
'channels' => [
    'stack' => [
        'driver' => 'stack',
        'channels' => ['single', 'slack'],
        'ignore_exceptions' => false,
    ],

    'single' => [
        'driver' => 'single',
        'path' => storage_path('logs/laravel.log'),
        'level' => env('LOG_LEVEL', 'debug'),
    ],

    'daily' => [
        'driver' => 'daily',
        'path' => storage_path('logs/laravel.log'),
        'level' => env('LOG_LEVEL', 'debug'),
        'days' => 14,
    ],

    'slack' => [
        'driver' => 'slack',
        'url' => env('LOG_SLACK_WEBHOOK_URL'),
        'username' => 'Laravel Log',
        'emoji' => ':boom:',
        'level' => env('LOG_LEVEL', 'critical'),
    ],
],

// Using the logger
use Illuminate\Support\Facades\Log;

Log::info('User has logged in', ['id' => $user->id]);
Log::warning('Payment failed', ['user' => $user->id, 'amount' => $amount]);
Log::error('Application error', ['exception' => $e]);

// Setting up error reporting with Sentry
// composer require sentry/sentry-laravel

// config/app.php
'providers' => [
    // ...
    Sentry\Laravel\ServiceProvider::class,
],

// config/sentry.php
return [
    'dsn' => env('SENTRY_LARAVEL_DSN', env('SENTRY_DSN')),
    'environment' => env('APP_ENV'),
    'breadcrumbs' => [
        'logs' => true,
        'sql_queries' => true,
        'sql_bindings' => true,
        'queue_info' => true,
    ],
    'tracing' => [
        'queue_job_transactions' => env('SENTRY_TRACE_QUEUE_ENABLED', false),
        'queue_jobs' => true,
        'sql_queries' => true,
        'sql_origin' => true,
        'views' => true,
    ],
];

// .env
SENTRY_LARAVEL_DSN=https://your-sentry-dsn@sentry.io/12345

// Test Sentry
try {
    throw new Exception('Test Sentry error reporting');
} catch (\Exception $e) {
    app('sentry')->captureException($e);
}
?>
```

**Security trong Production:**

```php
<?php
// Security best practices for PHP applications

// 1. Escape output to prevent XSS
$name = htmlspecialchars($user->name, ENT_QUOTES, 'UTF-8');
echo "Welcome, " . $name;

// 2. Use prepared statements/parameterized queries for database
$stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
$stmt->execute([$username]);
$user = $stmt->fetch();

// 3. Set proper HTTP headers
header('X-Content-Type-Options: nosniff');
header('X-XSS-Protection: 1; mode=block');
header('X-Frame-Options: DENY');
header('Content-Security-Policy: default-src \'self\'');

// 4. Session security
// php.ini
// session.cookie_httponly = 1
// session.cookie_secure = 1
// session.use_only_cookies = 1
// session.cookie_samesite = "Lax"

// In code
ini_set('session.cookie_httponly', 1);
session_start();

// 5. Use CSRF protection
// Laravel already includes CSRF protection
// In your forms:
@csrf

// In your controller:
protected $middleware = ['csrf'];

// 6. Validate all input data
$validatedData = $request->validate([
    'email' => 'required|email',
    'name' => 'required|string|max:255',
    'age' => 'required|integer|min:18|max:120',
]);

// 7. Keep dependencies updated
// composer update

// 8. Store sensitive data securely
// .env file (outside web root)
DB_PASSWORD=secret
MAIL_PASSWORD=another_secret
API_KEY=some_api_key

// 9. Rate limiting
// Laravel example:
Route::middleware(['throttle:60,1'])->group(function () {
    Route::get('/api/data', 'ApiController@getData');
});

// 10. Configure error display in production
// php.ini or runtime
ini_set('display_errors', 0);
ini_set('display_startup_errors', 0);
ini_set('log_errors', 1);
error_reporting(E_ALL);
?>
```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Xây dựng ứng dụng web bằng Laravel**

Xây dựng một ứng dụng quản lý dự án (Project Management) với Laravel, áp dụng các kiến thức đã học về framework, kiến trúc MVC, testing và best practices.

### **Yêu cầu:**

1. Chức năng người dùng:

   - Đăng ký, đăng nhập, quên mật khẩu
   - Quyền hạn: Admin, Project Manager, Developer
   - Hồ sơ người dùng, thay đổi mật khẩu

2. Chức năng quản lý dự án:

   - CRUD cho dự án (Projects)
   - Phân công người dùng vào dự án
   - Thêm công việc (Tasks) vào dự án
   - Theo dõi trạng thái dự án

3. Chức năng quản lý công việc:

   - CRUD cho công việc (Tasks)
   - Phân công người thực hiện
   - Cập nhật trạng thái công việc
   - Bình luận trên công việc
   - Đính kèm file

4. Dashboard và báo cáo:

   - Thống kê dự án, công việc theo trạng thái
   - Biểu đồ tiến độ dự án
   - Xuất báo cáo (PDF/Excel)

5. Yêu cầu kỹ thuật:
   - Sử dụng Laravel 9+
   - Eloquent ORM cho tương tác database
   - Migration và seeding cho database
   - Authenication và Authorization với Laravel
   - Blade templates và Laravel Mix cho frontend
   - Unit & Feature Testing
   - RESTful API cho một số chức năng
   - Sử dụng Laravel Queue cho tác vụ gửi email
   - Triển khai trên máy chủ web thực

### **Cấu trúc dự án:**

```text
project-management/
├── app/
│   ├── Http/
│   │   ├── Controllers/
│   │   │   ├── ProjectController.php
│   │   │   ├── TaskController.php
│   │   │   ├── UserController.php
│   │   │   └── DashboardController.php
│   │   ├── Middleware/
│   │   │   └── CheckRole.php
│   │   └── Requests/
│   │       ├── StoreProjectRequest.php
│   │       └── StoreTaskRequest.php
│   ├── Jobs/
│   │   └── SendProjectReportEmail.php
│   ├── Models/
│   │   ├── Project.php
│   │   ├── Task.php
│   │   ├── User.php
│   │   └── Comment.php
│   └── Services/
│       ├── ProjectService.php
│       └── ReportGeneratorService.php
├── database/
│   ├── migrations/
│   │   ├── 2023_10_01_000000_create_users_table.php
│   │   ├── 2023_10_01_000001_create_projects_table.php
│   │   ├── 2023_10_01_000002_create_tasks_table.php
│   │   └── 2023_10_01_000003_create_comments_table.php
│   └── seeders/
│       ├── UserSeeder.php
│       ├── ProjectSeeder.php
│       └── TaskSeeder.php
├── resources/
│   ├── views/
│   │   ├── auth/
│   │   ├── dashboard.blade.php
│   │   ├── projects/
│   │   ├── tasks/
│   │   └── layouts/
│   └── js/
│       ├── app.js
│       └── bootstrap.js
├── routes/
│   ├── api.php
│   ├── web.php
│   └── channels.php
├── tests/
│   ├── Feature/
│   │   ├── ProjectTest.php
│   │   ├── TaskTest.php
│   │   └── UserTest.php
│   └── Unit/
│       ├── ProjectServiceTest.php
│       └── ReportGeneratorServiceTest.php
├── .env
├── .env.example
├── .gitignore
├── artisan
├── composer.json
├── composer.lock
├── package.json
├── phpunit.xml
├── README.md
└── webpack.mix.js
```

---

[⬅️ Trở lại: PHP/Part3.md](../PHP/Part3.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: PHP/Part5.md](../PHP/Part5.md)
