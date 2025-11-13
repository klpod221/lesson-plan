---
prev:
  text: '💾 PHP Nâng Cao'
  link: '/PHP/Part3'
next:
  text: '🚀 Xu Hướng Hiện Đại'
  link: '/PHP/Part5'
---
# 📘 PHẦN 4: FRAMEWORK VÀ PHÁT TRIỂN ỨNG DỤNG WEB HIỆN ĐẠI

## 🎯 Mục tiêu tổng quát

- Hiểu và áp dụng mô hình MVC trong phát triển ứng dụng
- Nắm vững các khái niệm cơ bản của Laravel Framework
- Sử dụng thành thạo Composer để quản lý thư viện và dependencies
- Biết cách viết test và áp dụng TDD (Test-Driven Development)
- Triển khai ứng dụng PHP lên môi trường production an toàn

## 🧑‍🏫 Bài 17: Giới thiệu về MVC và Framework

### Mô hình MVC (Model-View-Controller)

- MVC là mô hình kiến trúc phần mềm chia ứng dụng thành 3 thành phần chính:
  - Model: Xử lý dữ liệu và logic nghiệp vụ
  - View: Hiển thị dữ liệu và giao diện người dùng
  - Controller: Điều khiển luồng xử lý, kết nối Model và View

### Cấu trúc mô hình MVC

```text
┌─────────────────────────────────────┐
│             CLIENT                  │
│  (Browser/Mobile App/API Consumer)  │
└───────────────────┬─────────────────┘
                    │
                    ▼
┌─────────────────────────────────────┐
│         HTTP REQUEST                │
└───────────────────┬─────────────────┘
                    │
                    ▼
┌─────────────────────────────────────┐
│             ROUTER                  │
│      Phân tích URL và chuyển        │
│        request đến Controller       │
└───────────────────┬─────────────────┘
                    │
                    ▼
┌─────────────────────────────────────┐
│          CONTROLLER                 │
│                                     │
│  ┌─────────────────────────────┐    │
│  │  Điều phối luồng xử lý      │    │
│  │  Nhận input từ Request      │    │
│  │  Tương tác với Model        │    │
│  │  Trả về View                │    │
│  └─────────────────────────────┘    │
└───────┬─────────────────────┬───────┘
        │                     │
        ▼                     ▼
┌───────────────┐     ┌───────────────┐
│    MODEL      │     │    VIEW       │
│               │     │               │
│  ┌─────────┐  │     │  ┌─────────┐  │
│  │ Quản lý │  │     │  │ Hiển thị│  │
│  │ dữ liệu │  │     │  │ dữ liệu │  │
│  │ và logic│◄─┼─────┼─►│ cho user│  │
│  │ nghiệp  │  │     │  │         │  │
│  │ vụ      │  │     │  │         │  │
│  └─────────┘  │     │  └─────────┘  │
│               │     │               │
└───────┬───────┘     └───────┬───────┘
        │                     │
        ▼                     │
┌───────────────┐             │
│  DATABASE     │             │
│               │             │
└───────────────┘             │
        │                     │
        └─────────┬───────────┘
                  │
                  ▼
┌─────────────────────────────────────┐
│         HTTP RESPONSE               │
└─────────────────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────┐
│             CLIENT                  │
└─────────────────────────────────────┘
```

#### Luồng xử lý trong MVC

1. **Client gửi request**: Người dùng tương tác với giao diện (click button, submit form...)
2. **Router phân tích URL**: Xác định controller và action cần xử lý
3. **Controller nhận request**:
   - Xử lý dữ liệu đầu vào
   - Gọi đến Model để thực hiện logic nghiệp vụ
4. **Model xử lý dữ liệu**:
   - Tương tác với Database
   - Thực hiện các quy tắc nghiệp vụ
   - Trả kết quả cho Controller
5. **Controller chọn View**:
   - Truyền dữ liệu từ Model vào View
6. **View render giao diện**:
   - Hiển thị dữ liệu
   - Tạo HTML/JSON response
7. **Response trả về Client**:
   - Người dùng nhận được kết quả

#### Vai trò của các thành phần

- **Model**: Đại diện cho dữ liệu và logic nghiệp vụ

  - Truy vấn database
  - Xử lý, tính toán dữ liệu
  - Áp dụng quy tắc nghiệp vụ
  - Độc lập với giao diện người dùng

- **View**: Hiển thị dữ liệu và giao diện người dùng

  - Template HTML/XML/JSON
  - Hiển thị dữ liệu từ Model
  - Không chứa logic nghiệp vụ
  - Có thể chứa logic hiển thị

- **Controller**: Điều phối luồng xử lý
  - Nhận và xử lý request
  - Tương tác với Model để lấy/xử lý dữ liệu
  - Chọn View thích hợp
  - Truyền dữ liệu từ Model vào View

### Ví dụ MVC đơn giản

#### Cấu trúc thư mục

```text
my-mvc-app/
├── config/
│   └── database.php         # Cấu hình kết nối database
├── controllers/
│   └── UserController.php   # Controller xử lý các action liên quan đến user
├── models/
│   └── User.php             # Model tương tác với bảng users
├── views/
│   └── users/
│       ├── index.php        # Hiển thị danh sách người dùng
│       ├── show.php         # Hiển thị chi tiết một người dùng
│       ├── create.php       # Form tạo người dùng mới
│       └── edit.php         # Form chỉnh sửa người dùng
├── public/
│   ├── index.php            # Entry point của ứng dụng
│   ├── css/
│   │   └── style.css
│   └── js/
│       └── app.js
└── core/
    ├── Router.php          # Xử lý route
    ├── Database.php        # Kết nối database
    └── App.php             # Khởi tạo ứng dụng
```

#### Nội dung các file

1. **public/index.php** - Entry point:

   ```php
   <?php
   // Bootloader
   require_once '../core/App.php';
   require_once '../core/Router.php';
   require_once '../core/Database.php';

   // Autoload classes
   spl_autoload_register(function($className) {
       // Convert namespace to file path
       if (file_exists('../controllers/' . $className . '.php')) {
           require_once '../controllers/' . $className . '.php';
       } else if (file_exists('../models/' . $className . '.php')) {
           require_once '../models/' . $className . '.php';
       } else if (file_exists('../core/' . $className . '.php')) {
           require_once '../core/' . $className . '.php';
       }
   });

   // Khởi tạo ứng dụng
   $app = new App();
   $app->run();
   ```

2. **core/App.php** - Khởi tạo ứng dụng:

   ```php
   <?php
   class App {
       protected $controller = 'UserController';
       protected $action = 'index';
       protected $params = [];

       public function __construct() {
           $url = $this->parseUrl();

           // Xác định controller
           if (isset($url[0]) && file_exists('../controllers/' . $url[0] . 'Controller.php')) {
               $this->controller = $url[0] . 'Controller';
               unset($url[0]);
           }

           require_once '../controllers/' . $this->controller . '.php';
           $this->controller = new $this->controller;

           // Xác định action
           if (isset($url[1])) {
               if (method_exists($this->controller, $url[1])) {
                   $this->action = $url[1];
                   unset($url[1]);
               }
           }

           // Lấy params
           $this->params = $url ? array_values($url) : [];
       }

       public function run() {
           call_user_func_array([$this->controller, $this->action], $this->params);
       }

       protected function parseUrl() {
           if (isset($_GET['url'])) {
               return explode('/', filter_var(rtrim($_GET['url'], '/'), FILTER_SANITIZE_URL));
           }
       }
   }
   ```

3. **core/Database.php** - Kết nối database:

   ```php
   <?php
   class Database {
       private $host = 'localhost';
       private $user = 'root';
       private $pass = '';
       private $dbname = 'mvc_example';

       private $conn;
       private $statement;

       public function __construct() {
           // Tạo kết nối PDO
           try {
               $this->conn = new PDO('mysql:host=' . $this->host . ';dbname=' . $this->dbname,
                                   $this->user, $this->pass);
               $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
           } catch(PDOException $e) {
               die('Database connection failed: ' . $e->getMessage());
           }
       }

       public function query($sql) {
           $this->statement = $this->conn->prepare($sql);
           return $this;
       }

       public function bind($param, $value, $type = null) {
           if (is_null($type)) {
               switch(true) {
                   case is_int($value):
                       $type = PDO::PARAM_INT;
                       break;
                   case is_bool($value):
                       $type = PDO::PARAM_BOOL;
                       break;
                   case is_null($value):
                       $type = PDO::PARAM_NULL;
                       break;
                   default:
                       $type = PDO::PARAM_STR;
               }
           }

           $this->statement->bindValue($param, $value, $type);
           return $this;
       }

       public function execute() {
           return $this->statement->execute();
       }

       public function fetchAll() {
           $this->execute();
           return $this->statement->fetchAll(PDO::FETCH_OBJ);
       }

       public function fetch() {
           $this->execute();
           return $this->statement->fetch(PDO::FETCH_OBJ);
       }

       public function rowCount() {
           return $this->statement->rowCount();
       }
   }
   ```

4. **models/User.php** - Model:

   ```php
   <?php
   class User {
       private $db;

       public function __construct() {
           $this->db = new Database();
       }

       public function getAllUsers() {
           $this->db->query('SELECT * FROM users ORDER BY created_at DESC');
           return $this->db->fetchAll();
       }

       public function getUserById($id) {
           $this->db->query('SELECT * FROM users WHERE id = :id');
           $this->db->bind(':id', $id);
           return $this->db->fetch();
       }

       public function createUser($data) {
           $this->db->query('INSERT INTO users (name, email, password) VALUES(:name, :email, :password)');
           $this->db->bind(':name', $data['name']);
           $this->db->bind(':email', $data['email']);
           $this->db->bind(':password', password_hash($data['password'], PASSWORD_DEFAULT));

           return $this->db->execute();
       }

       public function updateUser($data) {
           $this->db->query('UPDATE users SET name = :name, email = :email WHERE id = :id');
           $this->db->bind(':id', $data['id']);
           $this->db->bind(':name', $data['name']);
           $this->db->bind(':email', $data['email']);

           return $this->db->execute();
       }

       public function deleteUser($id) {
           $this->db->query('DELETE FROM users WHERE id = :id');
           $this->db->bind(':id', $id);

           return $this->db->execute();
       }
   }
   ```

5. **controllers/UserController.php** - Controller:

   ```php
   <?php
   class UserController {
       private $userModel;

       public function __construct() {
           $this->userModel = new User();
       }

       // Hiển thị tất cả người dùng
       public function index() {
           $users = $this->userModel->getAllUsers();
           require_once '../views/users/index.php';
       }

       // Hiển thị chi tiết người dùng
       public function show($id) {
           $user = $this->userModel->getUserById($id);
           require_once '../views/users/show.php';
       }

       // Hiển thị form tạo người dùng
       public function create() {
           require_once '../views/users/create.php';
       }

       // Xử lý lưu người dùng mới
       public function store() {
           if ($_SERVER['REQUEST_METHOD'] == 'POST') {
               $data = [
                   'name' => trim($_POST['name']),
                   'email' => trim($_POST['email']),
                   'password' => trim($_POST['password'])
               ];

               if ($this->userModel->createUser($data)) {
                   header('Location: /users');
               } else {
                   die('Something went wrong');
               }
           }
       }

       // Hiển thị form chỉnh sửa
       public function edit($id) {
           $user = $this->userModel->getUserById($id);
           require_once '../views/users/edit.php';
       }

       // Xử lý cập nhật
       public function update() {
           if ($_SERVER['REQUEST_METHOD'] == 'POST') {
               $data = [
                   'id' => $_POST['id'],
                   'name' => trim($_POST['name']),
                   'email' => trim($_POST['email']),
               ];

               if ($this->userModel->updateUser($data)) {
                   header('Location: /users');
               } else {
                   die('Something went wrong');
               }
           }
       }

       // Xử lý xóa
       public function delete($id) {
           if ($this->userModel->deleteUser($id)) {
               header('Location: /users');
           } else {
               die('Something went wrong');
           }
       }
   }
   ```

6. **views/users/index.php** - View hiển thị danh sách:

   ```php
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>User List</title>
       <link rel="stylesheet" href="/css/style.css">
   </head>
   <body>
       <div class="container">
           <h1>User List</h1>
           <a href="/users/create" class="btn">Add New User</a>

           <table>
               <thead>
                   <tr>
                       <th>ID</th>
                       <th>Name</th>
                       <th>Email</th>
                       <th>Actions</th>
                   </tr>
               </thead>
               <tbody>
                   <?php foreach($users as $user) : ?>
                   <tr>
                       <td><?php echo $user->id; ?></td>
                       <td><?php echo $user->name; ?></td>
                       <td><?php echo $user->email; ?></td>
                       <td>
                           <a href="/users/show/<?php echo $user->id; ?>" class="btn-view">View</a>
                           <a href="/users/edit/<?php echo $user->id; ?>" class="btn-edit">Edit</a>
                           <a href="/users/delete/<?php echo $user->id; ?>" class="btn-delete"
                           onclick="return confirm('Are you sure?')">Delete</a>
                       </td>
                   </tr>
                   <?php endforeach; ?>
               </tbody>
           </table>
       </div>
   </body>
   </html>
   ```

7. **views/users/create.php** - View tạo người dùng:

   ```php
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>Create User</title>
       <link rel="stylesheet" href="/css/style.css">
   </head>
   <body>
       <div class="container">
           <h1>Create New User</h1>
           <a href="/users" class="btn">Back to Users</a>

           <form action="/users/store" method="post">
               <div class="form-group">
                   <label for="name">Name:</label>
                   <input type="text" name="name" id="name" required>
               </div>
               <div class="form-group">
                   <label for="email">Email:</label>
                   <input type="email" name="email" id="email" required>
               </div>
               <div class="form-group">
                   <label for="password">Password:</label>
                   <input type="password" name="password" id="password" required>
               </div>
               <button type="submit" class="btn">Create User</button>
           </form>
       </div>
   </body>
   </html>
   ```

8. **.htaccess** trong thư mục public - Rewrite URLs:

   ```apache
   <IfModule mod_rewrite.c>
       Options -Multiviews
       RewriteEngine On
       RewriteBase /public
       RewriteCond %{REQUEST_FILENAME} !-d
       RewriteCond %{REQUEST_FILENAME} !-f
       RewriteRule ^(.+)$ index.php?url=$1 [QSA,L]
   </IfModule>
   ```

Trên đây là một ví dụ đơn giản về cấu trúc MVC với các thành phần chính:

- **Model**: Quản lý dữ liệu và logic nghiệp vụ (User.php)
- **View**: Hiển thị giao diện người dùng (các file trong thư mục views/)
- **Controller**: Điều phối luồng xử lý (UserController.php)
- **Router/App**: Phân tích URL và chuyển về controller phù hợp

Ứng dụng này cho phép thực hiện đầy đủ các thao tác CRUD (Create, Read, Update, Delete) với entity User theo mô hình MVC.

### Giới thiệu về Framework PHP phổ biến

1. Laravel - <https://laravel.com/>

   - Full-stack framework phổ biến nhất hiện nay
   - Cú pháp rõ ràng, dễ đọc
   - Hệ sinh thái phong phú

2. Symfony - <https://symfony.com/>

   - Framework mạnh mẽ với nhiều component có thể tái sử dụng
   - Được sử dụng bởi nhiều framework và CMS khác

3. CodeIgniter - <https://codeigniter.com/>

   - Nhẹ, nhanh, footprint nhỏ
   - Dễ học cho người mới bắt đầu

4. Slim - <https://www.slimframework.com/>

   - Micro-framework tập trung vào routing và middleware
   - Lý tưởng cho API nhỏ và ứng dụng đơn giản

5. Yii - <https://www.yiiframework.com/>

   - Framework hiệu suất cao
   - Tích hợp AJAX và jQuery

6. CakePHP - <https://cakephp.org/>

   - Convention over Configuration
   - Scaffolding và code generation

7. Zend/Laminas - <https://getlaminas.org/>

   - Enterprise-ready
   - Modular architecture

8. Phalcon - <https://phalcon.io/>
   - Framework hiệu suất cao được viết bằng C
   - Được cài đặt như một extension PHP

## 🧑‍🏫 Bài 18: Laravel Framework

- Ở giáo trình này, chúng ta sẽ tìm hiểu về Laravel - một trong những framework PHP phổ biến nhất hiện nay. Và bởi vì Laravel rất lớn và phong phú, nên chúng ta sẽ chỉ tập trung vào các khái niệm cơ bản và những gì cần thiết để bắt đầu phát triển ứng dụng với Laravel.

- Đây cũng là một framework có phần documentation mà bản thân tôi đánh giá là tốt nhất trong tất cả những framework mà tôi đã từng sử dụng. Vì vậy, tôi khuyên các bạn nên nghiên cứu tài liệu chính thức của Laravel tại <https://laravel.com/docs> và sử dụng phần lộ trình này của tôi như một tài liệu tham khảo.

### Cài đặt và Cấu hình Laravel

```bash
# Tạo project Laravel mới
composer create-project laravel/laravel my-laravel-app

# Hoặc sử dụng Laravel Installer
composer global require laravel/installer
laravel new my-laravel-app

# Chạy development server
cd my-laravel-app
php artisan serve
```

### Cấu trúc thư mục Laravel

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

### Routing và Controller trong Laravel

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

### Controller trong Laravel

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

### Model và Eloquent ORM

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

### Blade Templating System

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

### Migrations và Database

- Thay vì tạo bảng bằng SQL, Laravel sử dụng migrations để quản lý schema của database.

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

## 🧑‍🏫 Bài 19: Testing trong PHP

### Unit Testing với PHPUnit

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

### Feature Testing trong Laravel

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

### Mock Objects và Testing với Dependencies

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

### Code Coverage và Best Practices

#### Code Coverage

- Code coverage là một chỉ số cho biết phần trăm mã nguồn đã được kiểm tra bởi các bài test. PHPUnit hỗ trợ tính năng này.

```bash
# Chạy PHPUnit với code coverage report (HTML)
vendor/bin/phpunit --coverage-html coverage

# Chạy tests với specific test file
vendor/bin/phpunit tests/UserServiceTest.php

# Chạy tests với specific test method
vendor/bin/phpunit --filter testRegisterWithValidData tests/UserServiceTest.php
```

#### Best Practices cho Testing

1. Tuân theo mô hình AAA

   - **Arrange**: Thiết lập môi trường kiểm thử
   - **Act**: Thực thi đoạn mã cần kiểm thử
   - **Assert**: Kiểm tra kết quả có đúng như mong đợi

2. Mỗi phương thức kiểm thử chỉ nên kiểm tra một chức năng duy nhất

3. Sử dụng quy tắc đặt tên rõ ràng

   - `testShouldDoSomethingWhenSomething`
   - `testMethodNameWhenStateUnderTest`

4. Sử dụng Data Provider để kiểm thử cùng logic với nhiều input khác nhau

5. Giữ cho các test độc lập – không để các test phụ thuộc vào nhau

6. Tránh sử dụng mock quá mức – nếu bạn mock mọi thứ thì bạn không đang kiểm thử gì cả

7. Kiểm thử các trường hợp biên và tình huống lỗi, không chỉ kiểm thử đường đi lý tưởng (happy path)

8. Viết cả Unit Test và Integration Test

9. Sử dụng `setUp()` và `tearDown()` để khởi tạo và dọn dẹp dữ liệu dùng chung cho các test

10. Sử dụng phương thức assert phù hợp

    - `assertEquals`: kiểm tra bằng giá trị
    - `assertSame`: kiểm tra bằng giá trị và kiểu (`===`)
    - `assertTrue` / `assertFalse`
    - `assertNull`
    - `assertArrayHasKey`
    - `assertCount`
    - `assertInstanceOf`
    - v.v.

11. Đối với Laravel, sử dụng factory để tạo dữ liệu kiểm thử

12. Sử dụng test double một cách hợp lý

    - **Mocks**: Kiểm tra phương thức có được gọi đúng không
    - **Stubs**: Cung cấp giá trị trả về định sẵn
    - **Spies**: Ghi nhận phương thức đã được gọi
    - **Dummies**: Tham số bắt buộc nhưng không sử dụng
    - **Fakes**: Thay thế implementation thật bằng bản đơn giản hơn

## 🧑‍🏫 Bài 20: Tối ưu Laravel cho Product

### Laravel cache và tối ưu hóa autoloader

```bash
composer install --optimize-autoloader --no-dev
php artisan config:cache # Cache config files
php artisan route:cache # Cache routes
php artisan view:cache # Cache views
php artisan optimize # Optimize the framework để tăng tốc độ
```

### Tối ưu hóa cấu hình PHP

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
```

### Laravel Performance Tips

1. Sử dụng eager loading để tránh N+1 problem

   ```php
   <?php
   // Good
   $posts = App\Models\Post::with('author', 'comments')->get();

   // Bad
   $posts = App\Models\Post::all();
   foreach ($posts as $post) {
       // This causes N+1 queries
       echo $post->author->name;
   }
   ```

2. Index database columns

   ```php
   // In migration:
   $table->index('user_id');
   $table->index(['status', 'created_at']);
   ```

3. Cache những query nặng

   ```php
   <?php
   // Cache the result of a query for 60 seconds
   $seconds = 60;
   $value = Cache::remember('users', $seconds, function () {
       return DB::table('users')->get();
   });

   // Cache with tags
   Cache::tags(['user', 'posts'])->put('user_posts', $posts, $seconds);

   // Cache with a unique key
   $key = 'user_' . auth()->id();
   Cache::remember($key, $seconds, function () {
       return DB::table('users')->where('id', auth()->id())->first();
   });
   ```

4. Sử dụng Memcache hoặc Redis cho cache

   ```php
   <?php
   // config/cache.php
   'default' => env('CACHE_DRIVER', 'redis'),

   // .env
   CACHE_DRIVER=redis

   // Redis configuration
   'redis' => [
       'client' => 'predis',
       'default' => [
           'host' => env('REDIS_HOST', 'localhost'),
           'password' => env('REDIS_PASSWORD', null),
           'port' => env('REDIS_PORT', 6379),
           'database' => env('REDIS_DB', 0),
       ],
   ],
   // Using Redis cache
   Cache::put('key', 'value', 60);
   $value = Cache::get('key');
   ```

5. Sử dụng phân trang (pagination) thay vì lấy tất cả dữ liệu

   ```php
   <?php
   // Pagination with Eloquent
   $users = App\Models\User::paginate(15);

   // Pagination with query builder
   $users = DB::table('users')->paginate(15);

   // Custom pagination view
   $users = App\Models\User::paginate(15, ['*'], 'page', 2);
   ```

6. Sử dụng queue cho các tác vụ nặng (như gửi email, xử lý ảnh) (xem thêm ở documentation của Laravel)

   ```php
   <?php
   // Queue a job
   use App\Jobs\SendEmailJob;
   SendEmailJob::dispatch($user);
   ```

7. Sử dụng database chunking để xử lý dữ liệu lớn

   ```php
   <?php
   // Process large dataset in chunks
   DB::table('users')->chunk(100, function ($users) {
       foreach ($users as $user) {
           // Process each user
       }
   });
   ```

### Monitoring và Logging

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

### Security trong Production

1. Escape dữ liệu đầu ra để phòng chống XSS

   ```php
   <?php
   // Escape output to prevent XSS
   $name = htmlspecialchars($user->name, ENT_QUOTES, 'UTF-8');
   echo "Welcome, " . $name;
   ?>
   ```

2. Sử dụng Prepared Statements / Truy vấn tham số hóa để làm việc với database

   ```php
   <?php
   // Prepared statements to prevent SQL injection
   $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
   $stmt->execute([$username]);
   $user = $stmt->fetch();
   ?>
   ```

3. Thiết lập các HTTP header bảo mật

   ```php
   <?php
   // Set proper HTTP headers
   header('X-Content-Type-Options: nosniff');
   header('X-XSS-Protection: 1; mode=block');
   header('X-Frame-Options: DENY');
   header('Content-Security-Policy: default-src \'self\'');
   ?>
   ```

4. Bảo mật session

   ```php
   <?php
   // Session security settings in php.ini
   session.cookie_httponly = 1
   session.cookie_secure = 1
   session.use_only_cookies = 1
   session.cookie_samesite = "Lax"

   // In code
   ini_set('session.cookie_httponly', 1);
   session_start();
   ?>
   ```

5. Sử dụng CSRF protection

   ```php
   <?php
   // Laravel already includes CSRF protection
   // In your forms:
   @csrf

   // In your controller:
   protected $middleware = ['csrf'];
   ?>
   ```

6. Validate tất cả dữ liệu đầu vào

   ```php
   <?php
   // Validate input data
   $validatedData = $request->validate([
        'email' => 'required|email',
        'name' => 'required|string|max:255',
        'age' => 'required|integer|min:18|max:120',
   ]);
   ?>
   ```

7. Cập nhật các dependencies thường xuyên

   ```bash
   # Update dependencies
   composer update
   ```

8. Lưu trữ dữ liệu nhạy cảm một cách an toàn

   ```text
    // Store sensitive data securely
    // .env file (outside web root)
    DB_PASSWORD=secret
    MAIL_PASSWORD=another_secret
    API_KEY=some_api_key
    ?>
   ```

9. Rate limiting cho các API

   ```php
   <?php
   // Laravel example:
   Route::middleware(['throttle:60,1'])->group(function () {
        Route::get('/api/data', 'ApiController@getData');
   });
   ?>
   ```

10. Cấu hình hiển thị lỗi trong môi trường production

    ```php
    <?php
    // php.ini or runtime
    ini_set('display_errors', 0);
    ini_set('display_startup_errors', 0);
    ini_set('log_errors', 1);
    error_reporting(E_ALL);
    ?>
    ```

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Xây dựng ứng dụng web bằng Laravel

### Mô tả bài toán

Xây dựng một ứng dụng quản lý dự án (Project Management) với Laravel, áp dụng các kiến thức đã học về framework, kiến trúc MVC, testing và best practices.

### Yêu cầu

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

### Cấu trúc dự án đề xuất

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
