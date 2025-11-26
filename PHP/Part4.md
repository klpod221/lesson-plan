---
prev:
  text: '💾 Advanced PHP'
  link: '/PHP/Part3'
next:
  text: '🚀 Modern Trends'
  link: '/PHP/Part5'
---
# 📘 PART 4: FRAMEWORKS AND MODERN WEB APPLICATION DEVELOPMENT

## 🎯 General Objectives

- Understand and apply the MVC model in application development.
- Master the basic concepts of the Laravel Framework.
- Proficiently use Composer to manage libraries and dependencies.
- Know how to write tests and apply TDD (Test-Driven Development).
- Deploy PHP applications to a production environment securely.

## 🧑‍🏫 Lesson 17: Introduction to MVC and Frameworks

### MVC Model (Model-View-Controller)

- MVC is a software architectural pattern that divides an application into 3 main components:
  - Model: Handles data and business logic.
  - View: Displays data and user interface.
  - Controller: Controls the flow of execution, connects Model and View.

### MVC Structure

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
│      Parses URL and forwards        │
│        request to Controller        │
└───────────────────┬─────────────────┘
                    │
                    ▼
┌─────────────────────────────────────┐
│          CONTROLLER                 │
│                                     │
│  ┌─────────────────────────────┐    │
│  │  Coordinates execution flow │    │
│  │  Receives input from Request│    │
│  │  Interacts with Model       │    │
│  │  Returns View               │    │
│  └─────────────────────────────┘    │
└───────┬─────────────────────┬───────┘
        │                     │
        ▼                     ▼
┌───────────────┐     ┌───────────────┐
│    MODEL      │     │    VIEW       │
│               │     │               │
│  ┌─────────┐  │     │  ┌─────────┐  │
│  │ Manages │  │     │  │ Displays│  │
│  │ data    │  │     │  │ data    │  │
│  │ and     │◄─┼─────┼─►│ for user│  │
│  │ business│  │     │  │         │  │
│  │ logic   │  │     │  │         │  │
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

#### Processing Flow in MVC

1. **Client sends request**: User interacts with the interface (clicks button, submits form...).
2. **Router parses URL**: Determines the controller and action needed to handle the request.
3. **Controller receives request**:
   - Processes input data.
   - Calls Model to execute business logic.
4. **Model processes data**:
   - Interacts with Database.
   - Applies business rules.
   - Returns results to Controller.
5. **Controller selects View**:
   - Passes data from Model to View.
6. **View renders interface**:
   - Displays data.
   - Generates HTML/JSON response.
7. **Response returned to Client**:
   - User receives the result.

#### Roles of Components

- **Model**: Represents data and business logic.

  - Queries database.
  - Processes, calculates data.
  - Applies business rules.
  - Independent of user interface.

- **View**: Displays data and user interface.

  - HTML/XML/JSON templates.
  - Displays data from Model.
  - Does not contain business logic.
  - May contain presentation logic.

- **Controller**: Coordinates execution flow.
  - Receives and processes requests.
  - Interacts with Model to get/process data.
  - Selects appropriate View.
  - Passes data from Model to View.

### Simple MVC Example

#### Directory Structure

```text
my-mvc-app/
├── config/
│   └── database.php         # Database connection configuration
├── controllers/
│   └── UserController.php   # Controller handling user-related actions
├── models/
│   └── User.php             # Model interacting with users table
├── views/
│   └── users/
│       ├── index.php        # Display list of users
│       ├── show.php         # Display user details
│       ├── create.php       # Create new user form
│       └── edit.php         # Edit user form
├── public/
│   ├── index.php            # Application entry point
│   ├── css/
│   │   └── style.css
│   └── js/
│       └── app.js
└── core/
    ├── Router.php          # Route handling
    ├── Database.php        # Database connection
    └── App.php             # Application initialization
```

#### File Contents

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

   // Initialize application
   $app = new App();
   $app->run();
   ```

2. **core/App.php** - Application initialization:

   ```php
   <?php
   class App {
       protected $controller = 'UserController';
       protected $action = 'index';
       protected $params = [];

       public function __construct() {
           $url = $this->parseUrl();

           // Determine controller
           if (isset($url[0]) && file_exists('../controllers/' . $url[0] . 'Controller.php')) {
               $this->controller = $url[0] . 'Controller';
               unset($url[0]);
           }

           require_once '../controllers/' . $this->controller . '.php';
           $this->controller = new $this->controller;

           // Determine action
           if (isset($url[1])) {
               if (method_exists($this->controller, $url[1])) {
                   $this->action = $url[1];
                   unset($url[1]);
               }
           }

           // Get params
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

3. **core/Database.php** - Database connection:

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
           // Create PDO connection
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

       // Display all users
       public function index() {
           $users = $this->userModel->getAllUsers();
           require_once '../views/users/index.php';
       }

       // Display user details
       public function show($id) {
           $user = $this->userModel->getUserById($id);
           require_once '../views/users/show.php';
       }

       // Display create user form
       public function create() {
           require_once '../views/users/create.php';
       }

       // Handle saving new user
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

       // Display edit form
       public function edit($id) {
           $user = $this->userModel->getUserById($id);
           require_once '../views/users/edit.php';
       }

       // Handle update
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

       // Handle delete
       public function delete($id) {
           if ($this->userModel->deleteUser($id)) {
               header('Location: /users');
           } else {
               die('Something went wrong');
           }
       }
   }
   ```

6. **views/users/index.php** - View displaying list:

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

7. **views/users/create.php** - View create user:

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

8. **.htaccess** in public directory - Rewrite URLs:

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

Above is a simple example of MVC structure with main components:

- **Model**: Manages data and business logic (User.php)
- **View**: Displays user interface (files in views/ directory)
- **Controller**: Coordinates execution flow (UserController.php)
- **Router/App**: Parses URL and forwards to appropriate controller

This application allows performing full CRUD operations (Create, Read, Update, Delete) with User entity following MVC model.

### Introduction to Popular PHP Frameworks

1. Laravel - <https://laravel.com/>

   - Most popular full-stack framework today
   - Clear, readable syntax
   - Rich ecosystem

2. Symfony - <https://symfony.com/>

   - Powerful framework with many reusable components
   - Used by many other frameworks and CMSs

3. CodeIgniter - <https://codeigniter.com/>

   - Light, fast, small footprint
   - Easy to learn for beginners

4. Slim - <https://www.slimframework.com/>

   - Micro-framework focusing on routing and middleware
   - Ideal for small APIs and simple applications

5. Yii - <https://www.yiiframework.com/>

   - High-performance framework
   - Integrates AJAX and jQuery

6. CakePHP - <https://cakephp.org/>

   - Convention over Configuration
   - Scaffolding and code generation

7. Zend/Laminas - <https://getlaminas.org/>

   - Enterprise-ready
   - Modular architecture

8. Phalcon - <https://phalcon.io/>
   - High-performance framework written in C
   - Installed as a PHP extension

## 🧑‍🏫 Lesson 18: Laravel Framework

- In this curriculum, we will explore Laravel - one of the most popular PHP frameworks today. Because Laravel is very large and extensive, we will only focus on basic concepts and what is needed to start developing applications with Laravel.

- This is also a framework with documentation that I personally rate as the best among all frameworks I have used. Therefore, I recommend you to study the official Laravel documentation at <https://laravel.com/docs> and use this roadmap as a reference.

### Installation and Configuration of Laravel

```bash
# Create new Laravel project
composer create-project laravel/laravel my-laravel-app

# Or use Laravel Installer
composer global require laravel/installer
laravel new my-laravel-app

# Run development server
cd my-laravel-app
php artisan serve
```

### Laravel Directory Structure

```text
my-laravel-app/
├── app/                     # Contains core application code
│   ├── Console/              # Contains custom Artisan commands
│   ├── Exceptions/          # Handles exceptions
│   ├── Http/                # Controllers, Middleware, Requests
│   ├── Models/              # Eloquent models
│   └── Providers/           # Service providers
├── bootstrap/              # Framework bootstrap
├── config/                 # Configuration files
├── database/               # Database migrations, factories, seeds
├── lang/                   # Localization files
├── public/                 # Document root, entrypoint (index.php)
├── resources/              # Views, assets, language files
│   ├── js/                  # JavaScript files
│   ├── sass/                # SASS files
│   └── views/               # Templates
├── routes/                 # Define routes
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

### Routing and Controller in Laravel

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

// Use named route in view or code
// <a href="{{ route('profile') }}">Profile</a>

// Automatically create all CRUD routes
Route::resource('photos', PhotoController::class);

// API routes (routes/api.php)
Route::get('/users', [UserApiController::class, 'index']);
Route::post('/users', [UserApiController::class, 'store']);
?>
```

### Controller in Laravel

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
     * Display a listing of users
     */
    public function index()
    {
        $users = User::all();
        return view('users.index', compact('users'));
    }

    /**
     * Show the form for creating a new user
     */
    public function create()
    {
        return view('users.create');
    }

    /**
     * Store a newly created user in storage
     */
    public function store(StoreUserRequest $request)
    {
        // Form validation is handled in StoreUserRequest

        // Create new user
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password),
        ]);

        return redirect()->route('users.show', $user->id)
                         ->with('success', 'User created successfully');
    }

    /**
     * Display the specified user
     */
    public function show($id)
    {
        $user = User::findOrFail($id);
        return view('users.show', compact('user'));
    }

    /**
     * Show the form for editing the specified user
     */
    public function edit($id)
    {
        $user = User::findOrFail($id);
        return view('users.edit', compact('user'));
    }

    /**
     * Update the specified user in storage
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
     * Remove the specified user from storage
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

### Model and Eloquent ORM

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

### Migrations and Database

- Instead of creating tables using SQL, Laravel uses migrations to manage database schema.

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

// Create new migration using Artisan
// php artisan make:migration create_posts_table

// Run migrations
// php artisan migrate

// Other migrate commands
// php artisan migrate:rollback
// php artisan migrate:reset
// php artisan migrate:refresh
// php artisan migrate:fresh
?>
```

## 🧑‍🏫 Lesson 19: Testing in PHP

### Unit Testing with PHPUnit

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

// Run tests
// vendor/bin/phpunit
?>
```

### Feature Testing in Laravel

```php
<?php
// In Laravel, create Feature Test
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

### Mock Objects and Testing with Dependencies

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

### Code Coverage and Best Practices

#### Code Coverage

- Code coverage is a metric that shows the percentage of source code that is tested by your tests. PHPUnit supports this feature.

```bash
# Run PHPUnit with code coverage report (HTML)
vendor/bin/phpunit --coverage-html coverage

# Run tests with specific test file
vendor/bin/phpunit tests/UserServiceTest.php

# Run tests with specific test method
vendor/bin/phpunit --filter testRegisterWithValidData tests/UserServiceTest.php
```

#### Best Practices for Testing

1. Follow AAA pattern

   - **Arrange**: Set up test environment.
   - **Act**: Execute code to test.
   - **Assert**: Verify result matches expectation.

2. Each test method should test only one functionality.

3. Use clear naming conventions

   - `testShouldDoSomethingWhenSomething`
   - `testMethodNameWhenStateUnderTest`

4. Use Data Provider to test same logic with multiple inputs.

5. Keep tests independent – don't let tests depend on each other.

6. Avoid over-mocking – if you mock everything, you are not testing anything.

7. Test edge cases and error conditions, not just the happy path.

8. Write both Unit Tests and Integration Tests.

9. Use `setUp()` and `tearDown()` to initialize and clean up shared data for tests.

10. Use appropriate assertion methods

    - `assertEquals`: check value equality.
    - `assertSame`: check value and type equality (`===`).
    - `assertTrue` / `assertFalse`.
    - `assertNull`.
    - `assertArrayHasKey`.
    - `assertCount`.
    - `assertInstanceOf`.
    - etc.

11. For Laravel, use factories to create test data.

12. Use test doubles appropriately

    - **Mocks**: Verify method calls.
    - **Stubs**: Provide canned answers to calls.
    - **Spies**: Record method calls.
    - **Dummies**: Required parameters but not used.
    - **Fakes**: Replace real implementation with simpler one.

## 🧑‍🏫 Lesson 20: Optimizing Laravel for Production

### Laravel cache and autoloader optimization

```bash
composer install --optimize-autoloader --no-dev
php artisan config:cache # Cache config files
php artisan route:cache # Cache routes
php artisan view:cache # Cache views
php artisan optimize # Optimize the framework for speed
```

### PHP Configuration Optimization

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

1. Use eager loading to avoid N+1 problem

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

3. Cache heavy queries

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

4. Use Memcache or Redis for cache

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

5. Use pagination instead of fetching all data

   ```php
   <?php
   // Pagination with Eloquent
   $users = App\Models\User::paginate(15);

   // Pagination with query builder
   $users = DB::table('users')->paginate(15);

   // Custom pagination view
   $users = App\Models\User::paginate(15, ['*'], 'page', 2);
   ```

6. Use queues for heavy tasks (like sending emails, processing images) (see more in Laravel documentation)

   ```php
   <?php
   // Queue a job
   use App\Jobs\SendEmailJob;
   SendEmailJob::dispatch($user);
   ```

7. Use database chunking to process large datasets

   ```php
   <?php
   // Process large dataset in chunks
   DB::table('users')->chunk(100, function ($users) {
       foreach ($users as $user) {
           // Process each user
       }
   });
   ```

### Monitoring and Logging

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

### Security in Production

1. Escape output data to prevent XSS

   ```php
   <?php
   // Escape output to prevent XSS
   $name = htmlspecialchars($user->name, ENT_QUOTES, 'UTF-8');
   echo "Welcome, " . $name;
   ?>
   ```

2. Use Prepared Statements / Parameterized Queries for database operations

   ```php
   <?php
   // Prepared statements to prevent SQL injection
   $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
   $stmt->execute([$username]);
   $user = $stmt->fetch();
   ?>
   ```

3. Set security HTTP headers

   ```php
   <?php
   // Set proper HTTP headers
   header('X-Content-Type-Options: nosniff');
   header('X-XSS-Protection: 1; mode=block');
   header('X-Frame-Options: DENY');
   header('Content-Security-Policy: default-src \'self\'');
   ?>
   ```

4. Session security

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

5. Use CSRF protection

   ```php
   <?php
   // Laravel already includes CSRF protection
   // In your forms:
   @csrf

   // In your controller:
   protected $middleware = ['csrf'];
   ?>
   ```

6. Validate all input data

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

7. Update dependencies regularly

   ```bash
   # Update dependencies
   composer update
   ```

8. Store sensitive data securely

   ```text
    // Store sensitive data securely
    // .env file (outside web root)
    DB_PASSWORD=secret
    MAIL_PASSWORD=another_secret
    API_KEY=some_api_key
    ?>
   ```

9. Rate limiting for APIs

   ```php
   <?php
   // Laravel example:
   Route::middleware(['throttle:60,1'])->group(function () {
        Route::get('/api/data', 'ApiController@getData');
   });
   ?>
   ```

10. Configure error display in production environment

    ```php
    <?php
    // php.ini or runtime
    ini_set('display_errors', 0);
    ini_set('display_startup_errors', 0);
    ini_set('log_errors', 1);
    error_reporting(E_ALL);
    ?>
    ```

## 🧪 FINAL PROJECT: Building a Web Application with Laravel

### Project Description

Build a Project Management application with Laravel, applying learned concepts about frameworks, MVC architecture, testing, and best practices.

### Requirements

1. User features:

   - Registration, login, password recovery.
   - Roles: Admin, Project Manager, Developer.
   - User profile, password change.

2. Project management features:

   - CRUD for Projects.
   - Assign users to projects.
   - Add tasks to projects.
   - Track project status.

3. Task management features:

   - CRUD for Tasks.
   - Assign executors.
   - Update task status.
   - Comment on tasks.
   - File attachments.

4. Dashboard and reporting:

   - Project and task statistics by status.
   - Project progress charts.
   - Export reports (PDF/Excel).

5. Technical requirements:
   - Use Laravel 9+.
   - Eloquent ORM for database interaction.
   - Migrations and seeding for database.
   - Authentication and Authorization with Laravel.
   - Blade templates and Laravel Mix for frontend.
   - Unit & Feature Testing.
   - RESTful API for some features.
   - Use Laravel Queue for email sending tasks.
   - Deploy on a real web server.

### Suggested Project Structure

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
