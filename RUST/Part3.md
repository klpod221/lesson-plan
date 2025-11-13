# 📘 PHẦN 3: STRUCTS VÀ ENUMS

- [📘 PHẦN 3: STRUCTS VÀ ENUMS](#-phần-3-structs-và-enums)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Structs cơ bản](#-bài-1-structs-cơ-bản)
    - [Định nghĩa và khởi tạo](#định-nghĩa-và-khởi-tạo)
    - [Field init shorthand](#field-init-shorthand)
    - [Struct update syntax](#struct-update-syntax)
    - [Tuple structs](#tuple-structs)
    - [Unit-like structs](#unit-like-structs)
    - [Ownership trong structs](#ownership-trong-structs)
  - [🧑‍🏫 Bài 2: Methods và Associated Functions](#-bài-2-methods-và-associated-functions)
    - [Defining methods](#defining-methods)
    - [Self parameters](#self-parameters)
    - [Multiple impl blocks](#multiple-impl-blocks)
    - [Associated functions](#associated-functions)
    - [Method chaining](#method-chaining)
  - [🧑‍🏫 Bài 3: Enums và Pattern Matching](#-bài-3-enums-và-pattern-matching)
    - [Defining enums](#defining-enums)
    - [Enums với data](#enums-với-data)
    - [Match expression](#match-expression)
    - [If let](#if-let)
    - [While let](#while-let)
    - [Match guards](#match-guards)
  - [🧑‍🏫 Bài 4: Option và Result](#-bài-4-option-và-result)
    - [Option`<T>`](#optiont)
    - [Working with Option](#working-with-option)
    - [Result\<T, E\>](#resultt-e)
    - [Error propagation](#error-propagation)
    - [Custom error types](#custom-error-types)
  - [🧑‍🏫 Bài 5: Advanced Patterns](#-bài-5-advanced-patterns)
    - [Destructuring](#destructuring)
    - [Ignoring values](#ignoring-values)
    - [Match ranges](#match-ranges)
    - [@ bindings](#-bindings)
    - [Refutability](#refutability)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN: Hệ thống quản lý sản phẩm](#-bài-tập-lớn-cuối-phần-hệ-thống-quản-lý-sản-phẩm)
    - [Mô tả bài toán](#mô-tả-bài-toán)
    - [Yêu cầu](#yêu-cầu)

## 🎯 Mục tiêu tổng quát

- Nắm vững cách định nghĩa và sử dụng structs
- Implement methods và associated functions
- Hiểu và sử dụng enums hiệu quả
- Master pattern matching với match, if let, while let
- Làm việc với Option`<T>` và Result`<T, E>`
- Apply advanced patterns và destructuring
- Xây dựng ứng dụng với data structures phức tạp

---

## 🧑‍🏫 Bài 1: Structs cơ bản

### Định nghĩa và khởi tạo

**Classic struct:**

```rust
struct User {
    username: String,
    email: String,
    age: u8,
    active: bool,
}

fn main() {
    let user1 = User {
        username: String::from("alice123"),
        email: String::from("alice@example.com"),
        age: 25,
        active: true,
    };
    
    println!("Username: {}", user1.username);
    println!("Email: {}", user1.email);
}
```

**Mutable struct:**

```rust
fn main() {
    let mut user = User {
        username: String::from("bob456"),
        email: String::from("bob@example.com"),
        age: 30,
        active: true,
    };
    
    // Modify field
    user.email = String::from("bob.new@example.com");
    user.age += 1;
    
    println!("New email: {}", user.email);
}
```

### Field init shorthand

```rust
fn build_user(username: String, email: String) -> User {
    User {
        username,  // Shorthand instead of username: username
        email,     // Shorthand instead of email: email
        age: 0,
        active: true,
    }
}

fn main() {
    let user = build_user(
        String::from("charlie"),
        String::from("charlie@example.com")
    );
    
    println!("User: {}", user.username);
}
```

### Struct update syntax

```rust
fn main() {
    let user1 = User {
        username: String::from("alice"),
        email: String::from("alice@example.com"),
        age: 25,
        active: true,
    };
    
    // Create user2 based on user1
    let user2 = User {
        email: String::from("alice.work@example.com"),
        ..user1  // Copy remaining fields from user1
    };
    
    // Note: user1.username and user1.email moved to user2
    // println!("{}", user1.username);  // ERROR: moved
    println!("Age from user1: {}", user1.age);  // OK: Copy trait
}
```

### Tuple structs

```rust
struct Color(u8, u8, u8);
struct Point(i32, i32, i32);

fn main() {
    let black = Color(0, 0, 0);
    let origin = Point(0, 0, 0);
    
    // Access by index
    println!("Red: {}", black.0);
    println!("X: {}", origin.0);
    
    // Destructure
    let Color(r, g, b) = black;
    println!("RGB: ({}, {}, {})", r, g, b);
}
```

### Unit-like structs

```rust
struct AlwaysEqual;

fn main() {
    let subject = AlwaysEqual;
    
    // Useful for implementing traits without data
}
```

### Ownership trong structs

**Storing references requires lifetimes:**

```rust
// This won't compile without lifetimes
// struct User {
//     username: &str,  // ERROR: missing lifetime
//     email: &str,
// }

// Correct with lifetime
struct User<'a> {
    username: &'a str,
    email: &'a str,
}

fn main() {
    let name = String::from("alice");
    let email = String::from("alice@example.com");
    
    let user = User {
        username: &name,
        email: &email,
    };
    
    println!("{}", user.username);
}
```

**Prefer owned types:**

```rust
#[derive(Debug)]
struct User {
    username: String,  // Owned
    email: String,     // Owned
    age: u8,
}

fn main() {
    let user = User {
        username: String::from("bob"),
        email: String::from("bob@example.com"),
        age: 30,
    };
    
    // Debug print
    println!("{:?}", user);
    
    // Pretty print
    println!("{:#?}", user);
}
```

---

## 🧑‍🏫 Bài 2: Methods và Associated Functions

### Defining methods

```rust
#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    // Method takes &self
    fn area(&self) -> u32 {
        self.width * self.height
    }
    
    fn perimeter(&self) -> u32 {
        2 * (self.width + self.height)
    }
    
    fn can_hold(&self, other: &Rectangle) -> bool {
        self.width > other.width && self.height > other.height
    }
}

fn main() {
    let rect1 = Rectangle { width: 30, height: 50 };
    let rect2 = Rectangle { width: 10, height: 40 };
    
    println!("Area: {}", rect1.area());
    println!("Perimeter: {}", rect1.perimeter());
    println!("Can hold: {}", rect1.can_hold(&rect2));
}
```

### Self parameters

```rust
impl Rectangle {
    // Immutable borrow
    fn area(&self) -> u32 {
        self.width * self.height
    }
    
    // Mutable borrow
    fn scale(&mut self, factor: u32) {
        self.width *= factor;
        self.height *= factor;
    }
    
    // Takes ownership (rare)
    fn into_square(self) -> Rectangle {
        let size = self.width.max(self.height);
        Rectangle {
            width: size,
            height: size,
        }
    }
}

fn main() {
    let rect = Rectangle { width: 10, height: 20 };
    println!("Area: {}", rect.area());
    
    let mut rect2 = Rectangle { width: 5, height: 10 };
    rect2.scale(2);
    println!("After scale: {:?}", rect2);
    
    let rect3 = Rectangle { width: 15, height: 25 };
    let square = rect3.into_square();
    // println!("{:?}", rect3);  // ERROR: rect3 moved
    println!("Square: {:?}", square);
}
```

### Multiple impl blocks

```rust
impl Rectangle {
    fn area(&self) -> u32 {
        self.width * self.height
    }
}

impl Rectangle {
    fn perimeter(&self) -> u32 {
        2 * (self.width + self.height)
    }
}

// Can split implementations for organization
```

### Associated functions

```rust
impl Rectangle {
    // Associated function (constructor)
    fn new(width: u32, height: u32) -> Rectangle {
        Rectangle { width, height }
    }
    
    fn square(size: u32) -> Rectangle {
        Rectangle {
            width: size,
            height: size,
        }
    }
}

fn main() {
    let rect = Rectangle::new(30, 50);
    let square = Rectangle::square(25);
    
    println!("Rectangle: {:?}", rect);
    println!("Square: {:?}", square);
}
```

### Method chaining

```rust
#[derive(Debug)]
struct Builder {
    width: u32,
    height: u32,
    color: String,
}

impl Builder {
    fn new() -> Self {
        Builder {
            width: 0,
            height: 0,
            color: String::from("white"),
        }
    }
    
    fn width(mut self, width: u32) -> Self {
        self.width = width;
        self
    }
    
    fn height(mut self, height: u32) -> Self {
        self.height = height;
        self
    }
    
    fn color(mut self, color: &str) -> Self {
        self.color = String::from(color);
        self
    }
    
    fn build(self) -> Self {
        self
    }
}

fn main() {
    let builder = Builder::new()
        .width(100)
        .height(200)
        .color("blue")
        .build();
    
    println!("{:#?}", builder);
}
```

---

## 🧑‍🏫 Bài 3: Enums và Pattern Matching

### Defining enums

```rust
enum IpAddrKind {
    V4,
    V6,
}

fn main() {
    let four = IpAddrKind::V4;
    let six = IpAddrKind::V6;
    
    route(four);
    route(six);
}

fn route(ip_kind: IpAddrKind) {
    // Use the enum
}
```

### Enums với data

```rust
#[derive(Debug)]
enum IpAddr {
    V4(u8, u8, u8, u8),
    V6(String),
}

enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(u8, u8, u8),
}

fn main() {
    let home = IpAddr::V4(127, 0, 0, 1);
    let loopback = IpAddr::V6(String::from("::1"));
    
    println!("{:?}", home);
    println!("{:?}", loopback);
    
    let msg1 = Message::Quit;
    let msg2 = Message::Move { x: 10, y: 20 };
    let msg3 = Message::Write(String::from("Hello"));
    let msg4 = Message::ChangeColor(255, 0, 0);
}
```

**Methods on enums:**

```rust
impl Message {
    fn call(&self) {
        match self {
            Message::Quit => println!("Quit"),
            Message::Move { x, y } => println!("Move to ({}, {})", x, y),
            Message::Write(text) => println!("Write: {}", text),
            Message::ChangeColor(r, g, b) => println!("Color: RGB({}, {}, {})", r, g, b),
        }
    }
}

fn main() {
    let msg = Message::Write(String::from("Hello"));
    msg.call();
}
```

### Match expression

```rust
enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter,
}

fn value_in_cents(coin: Coin) -> u8 {
    match coin {
        Coin::Penny => 1,
        Coin::Nickel => 5,
        Coin::Dime => 10,
        Coin::Quarter => 25,
    }
}

fn main() {
    let coin = Coin::Quarter;
    println!("Value: {} cents", value_in_cents(coin));
}
```

**Match with data:**

```rust
#[derive(Debug)]
enum UsState {
    Alabama,
    Alaska,
    // ... etc
}

enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter(UsState),
}

fn value_in_cents(coin: Coin) -> u8 {
    match coin {
        Coin::Penny => {
            println!("Lucky penny!");
            1
        }
        Coin::Nickel => 5,
        Coin::Dime => 10,
        Coin::Quarter(state) => {
            println!("State quarter from {:?}!", state);
            25
        }
    }
}
```

**Catch-all:**

```rust
fn main() {
    let number = 7;
    
    match number {
        1 => println!("One"),
        2 => println!("Two"),
        3 => println!("Three"),
        _ => println!("Other"),  // Catch-all
    }
    
    // Or use the value
    match number {
        1 | 2 | 3 => println!("Small"),
        n @ 4..=9 => println!("Medium: {}", n),
        _ => println!("Large"),
    }
}
```

### If let

```rust
fn main() {
    let some_value = Some(3);
    
    // With match
    match some_value {
        Some(3) => println!("three"),
        _ => (),
    }
    
    // With if let (more concise)
    if let Some(3) = some_value {
        println!("three");
    }
    
    // With else
    if let Some(value) = some_value {
        println!("Got value: {}", value);
    } else {
        println!("No value");
    }
}
```

### While let

```rust
fn main() {
    let mut stack = Vec::new();
    stack.push(1);
    stack.push(2);
    stack.push(3);
    
    while let Some(top) = stack.pop() {
        println!("{}", top);
    }
}
```

### Match guards

```rust
fn main() {
    let num = Some(4);
    
    match num {
        Some(x) if x < 5 => println!("Less than five: {}", x),
        Some(x) => println!("{}", x),
        None => (),
    }
    
    let x = 4;
    let y = false;
    
    match x {
        4 | 5 | 6 if y => println!("yes"),
        _ => println!("no"),
    }
}
```

---

## 🧑‍🏫 Bài 4: Option và Result

### Option`<T>`

```rust
fn main() {
    let some_number = Some(5);
    let some_string = Some("a string");
    let absent_number: Option<i32> = None;
    
    // Must handle None case
    match some_number {
        Some(n) => println!("Number: {}", n),
        None => println!("No number"),
    }
}
```

**Why Option instead of null?**

```rust
// Rust doesn't have null!
// Option forces you to handle the None case

fn divide(a: f64, b: f64) -> Option<f64> {
    if b == 0.0 {
        None
    } else {
        Some(a / b)
    }
}

fn main() {
    match divide(10.0, 2.0) {
        Some(result) => println!("Result: {}", result),
        None => println!("Cannot divide by zero"),
    }
}
```

### Working with Option

```rust
fn main() {
    let x = Some(5);
    let y: Option<i32> = None;
    
    // unwrap - panic if None
    // println!("{}", y.unwrap());  // PANIC!
    
    // unwrap_or - provide default
    println!("{}", x.unwrap_or(0));  // 5
    println!("{}", y.unwrap_or(0));  // 0
    
    // unwrap_or_else - compute default
    let result = y.unwrap_or_else(|| {
        println!("Computing default");
        42
    });
    
    // expect - panic with custom message
    // let value = y.expect("Expected a value!");  // PANIC with message
    
    // is_some / is_none
    if x.is_some() {
        println!("x has a value");
    }
    
    if y.is_none() {
        println!("y is None");
    }
    
    // map
    let x = Some(5);
    let y = x.map(|n| n * 2);
    println!("{:?}", y);  // Some(10)
    
    // and_then
    let result = Some(4).and_then(|n| {
        if n < 5 {
            Some(n * 2)
        } else {
            None
        }
    });
    println!("{:?}", result);  // Some(8)
}
```

### Result<T, E>

```rust
use std::fs::File;
use std::io::ErrorKind;

fn main() {
    let file_result = File::open("hello.txt");
    
    let file = match file_result {
        Ok(file) => file,
        Err(error) => match error.kind() {
            ErrorKind::NotFound => {
                println!("File not found");
                return;
            }
            other_error => {
                panic!("Problem opening file: {:?}", other_error);
            }
        }
    };
}
```

**Shortcuts:**

```rust
use std::fs::File;

fn main() {
    // unwrap - panic if error
    // let file = File::open("hello.txt").unwrap();
    
    // expect - panic with message
    let file = File::open("hello.txt")
        .expect("Failed to open hello.txt");
}
```

### Error propagation

**The ? operator:**

```rust
use std::fs::File;
use std::io::{self, Read};

fn read_username_from_file() -> Result<String, io::Error> {
    let mut file = File::open("username.txt")?;
    let mut username = String::new();
    file.read_to_string(&mut username)?;
    Ok(username)
}

// Even shorter
fn read_username_short() -> Result<String, io::Error> {
    let mut username = String::new();
    File::open("username.txt")?.read_to_string(&mut username)?;
    Ok(username)
}

// Shortest
fn read_username_shortest() -> Result<String, io::Error> {
    std::fs::read_to_string("username.txt")
}

fn main() {
    match read_username_from_file() {
        Ok(username) => println!("Username: {}", username),
        Err(e) => println!("Error: {}", e),
    }
}
```

**? in main:**

```rust
use std::error::Error;
use std::fs::File;

fn main() -> Result<(), Box<dyn Error>> {
    let file = File::open("hello.txt")?;
    Ok(())
}
```

### Custom error types

```rust
use std::fmt;

#[derive(Debug)]
enum MathError {
    DivisionByZero,
    NegativeSquareRoot,
}

impl fmt::Display for MathError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            MathError::DivisionByZero => write!(f, "Cannot divide by zero"),
            MathError::NegativeSquareRoot => write!(f, "Cannot take square root of negative number"),
        }
    }
}

fn divide(a: f64, b: f64) -> Result<f64, MathError> {
    if b == 0.0 {
        Err(MathError::DivisionByZero)
    } else {
        Ok(a / b)
    }
}

fn sqrt(x: f64) -> Result<f64, MathError> {
    if x < 0.0 {
        Err(MathError::NegativeSquareRoot)
    } else {
        Ok(x.sqrt())
    }
}

fn main() {
    match divide(10.0, 2.0) {
        Ok(result) => println!("Result: {}", result),
        Err(e) => println!("Error: {}", e),
    }
    
    match sqrt(-4.0) {
        Ok(result) => println!("Result: {}", result),
        Err(e) => println!("Error: {}", e),
    }
}
```

---

## 🧑‍🏫 Bài 5: Advanced Patterns

### Destructuring

**Structs:**

```rust
struct Point {
    x: i32,
    y: i32,
}

fn main() {
    let p = Point { x: 0, y: 7 };
    
    let Point { x, y } = p;
    println!("x: {}, y: {}", x, y);
    
    // Rename
    let Point { x: a, y: b } = p;
    println!("a: {}, b: {}", a, b);
    
    // Match specific values
    match p {
        Point { x: 0, y } => println!("On y axis at {}", y),
        Point { x, y: 0 } => println!("On x axis at {}", x),
        Point { x, y } => println!("At ({}, {})", x, y),
    }
}
```

**Enums:**

```rust
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
}

fn process_message(msg: Message) {
    match msg {
        Message::Quit => println!("Quit"),
        Message::Move { x, y } => println!("Move to ({}, {})", x, y),
        Message::Write(text) => println!("Write: {}", text),
    }
}
```

**Nested destructuring:**

```rust
enum Color {
    Rgb(u8, u8, u8),
    Hsv(u8, u8, u8),
}

enum Message {
    Quit,
    ChangeColor(Color),
}

fn main() {
    let msg = Message::ChangeColor(Color::Rgb(255, 0, 0));
    
    match msg {
        Message::Quit => println!("Quit"),
        Message::ChangeColor(Color::Rgb(r, g, b)) => {
            println!("RGB: ({}, {}, {})", r, g, b);
        }
        Message::ChangeColor(Color::Hsv(h, s, v)) => {
            println!("HSV: ({}, {}, {})", h, s, v);
        }
    }
}
```

### Ignoring values

```rust
fn main() {
    let numbers = (1, 2, 3, 4, 5);
    
    // Ignore some values
    match numbers {
        (first, _, third, _, fifth) => {
            println!("First: {}, Third: {}, Fifth: {}", first, third, fifth);
        }
    }
    
    // Ignore remaining
    let (first, second, ..) = numbers;
    println!("{}, {}", first, second);
    
    // Ignore with _name (useful for debugging)
    let (_x, y) = (1, 2);
    println!("y: {}", y);
}
```

### Match ranges

```rust
fn main() {
    let x = 5;
    
    match x {
        1..=5 => println!("1 through 5"),
        _ => println!("Something else"),
    }
    
    let c = 'c';
    
    match c {
        'a'..='j' => println!("Early ASCII letter"),
        'k'..='z' => println!("Late ASCII letter"),
        _ => println!("Something else"),
    }
}
```

### @ bindings

```rust
enum Message {
    Hello { id: i32 },
}

fn main() {
    let msg = Message::Hello { id: 5 };
    
    match msg {
        Message::Hello { id: id_variable @ 3..=7 } => {
            println!("Found an id in range: {}", id_variable);
        }
        Message::Hello { id: 10..=12 } => {
            println!("Found an id in another range");
        }
        Message::Hello { id } => {
            println!("Found some other id: {}", id);
        }
    }
}
```

### Refutability

**Irrefutable patterns (always match):**

```rust
fn main() {
    let x = 5;  // Irrefutable
    let (x, y, z) = (1, 2, 3);  // Irrefutable
}
```

**Refutable patterns (can fail to match):**

```rust
fn main() {
    let some_value = Some(5);
    
    // if let with refutable pattern
    if let Some(x) = some_value {
        println!("{}", x);
    }
    
    // This won't compile:
    // let Some(x) = some_value;  // ERROR: refutable pattern in let
    
    // Use if let or match instead
}
```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Hệ thống quản lý sản phẩm

### Mô tả bài toán

Xây dựng hệ thống quản lý cửa hàng bán lẻ với nhiều loại sản phẩm:

- Electronics (laptop, phone, tablet)
- Clothing (shirt, pants, shoes)
- Food (fresh, packaged, frozen)

Mỗi loại có thuộc tính riêng và cách tính giá khác nhau.

### Yêu cầu

**1. Data structures:**

```rust
#[derive(Debug, Clone)]
enum ProductCategory {
    Electronics {
        brand: String,
        warranty_months: u8,
    },
    Clothing {
        size: String,
        material: String,
    },
    Food {
        expiry_date: String,
        storage_temp: i8,
    },
}

#[derive(Debug, Clone)]
struct Product {
    id: u32,
    name: String,
    category: ProductCategory,
    base_price: f64,
    quantity: u32,
}

enum DiscountType {
    Percentage(f64),
    FixedAmount(f64),
    BuyOneGetOne,
}

struct Cart {
    items: Vec<(Product, u32)>,  // (product, quantity)
}

enum PaymentMethod {
    Cash,
    CreditCard { number: String },
    MobilePayment { phone: String },
}

struct Transaction {
    id: u32,
    products: Vec<(Product, u32)>,
    total: f64,
    payment: PaymentMethod,
    date: String,
}
```

**2. Core functionality:**

```rust
impl Product {
    fn new(id: u32, name: String, category: ProductCategory, base_price: f64) -> Self;
    fn calculate_price(&self, discount: Option<DiscountType>) -> f64;
    fn is_available(&self) -> bool;
    fn add_stock(&mut self, quantity: u32);
    fn remove_stock(&mut self, quantity: u32) -> Result<(), String>;
}

impl Cart {
    fn new() -> Self;
    fn add_item(&mut self, product: Product, quantity: u32) -> Result<(), String>;
    fn remove_item(&mut self, product_id: u32) -> Result<(), String>;
    fn calculate_total(&self) -> f64;
    fn checkout(&self, payment: PaymentMethod) -> Result<Transaction, String>;
}
```

**3. Pattern matching requirements:**

- Match on ProductCategory để tính giá đặc biệt
- Match on DiscountType để apply discount
- Match on PaymentMethod để xử lý thanh toán
- Use Option<> cho optional fields
- Use Result<> cho error handling

**Template code:**

```rust
#[derive(Debug, Clone)]
enum ProductCategory {
    Electronics {
        brand: String,
        warranty_months: u8,
    },
    Clothing {
        size: String,
        material: String,
    },
    Food {
        expiry_date: String,
        storage_temp: i8,
    },
}

#[derive(Debug, Clone)]
struct Product {
    id: u32,
    name: String,
    category: ProductCategory,
    base_price: f64,
    quantity: u32,
}

impl Product {
    fn new(id: u32, name: String, category: ProductCategory, base_price: f64, quantity: u32) -> Self {
        Product {
            id,
            name,
            category,
            base_price,
            quantity,
        }
    }
    
    fn calculate_price(&self, discount: Option<DiscountType>) -> f64 {
        let mut price = self.base_price;
        
        // Category-based pricing
        match &self.category {
            ProductCategory::Electronics { warranty_months, .. } => {
                price += (*warranty_months as f64) * 2.0;  // Add warranty cost
            }
            ProductCategory::Clothing { material, .. } => {
                if material == "premium" {
                    price *= 1.5;
                }
            }
            ProductCategory::Food { storage_temp, .. } => {
                if *storage_temp < 0 {
                    price *= 1.2;  // Frozen food markup
                }
            }
        }
        
        // Apply discount
        if let Some(disc) = discount {
            match disc {
                DiscountType::Percentage(percent) => {
                    price *= 1.0 - (percent / 100.0);
                }
                DiscountType::FixedAmount(amount) => {
                    price -= amount;
                    if price < 0.0 {
                        price = 0.0;
                    }
                }
                DiscountType::BuyOneGetOne => {
                    // Implement BOGO logic
                    price *= 0.5;
                }
            }
        }
        
        price
    }
    
    fn is_available(&self) -> bool {
        self.quantity > 0
    }
    
    fn display(&self) {
        println!("ID: {}", self.id);
        println!("Name: {}", self.name);
        println!("Price: ${:.2}", self.base_price);
        println!("Quantity: {}", self.quantity);
        
        match &self.category {
            ProductCategory::Electronics { brand, warranty_months } => {
                println!("Category: Electronics");
                println!("Brand: {}", brand);
                println!("Warranty: {} months", warranty_months);
            }
            ProductCategory::Clothing { size, material } => {
                println!("Category: Clothing");
                println!("Size: {}", size);
                println!("Material: {}", material);
            }
            ProductCategory::Food { expiry_date, storage_temp } => {
                println!("Category: Food");
                println!("Expiry: {}", expiry_date);
                println!("Storage: {}°C", storage_temp);
            }
        }
    }
}

#[derive(Debug)]
enum DiscountType {
    Percentage(f64),
    FixedAmount(f64),
    BuyOneGetOne,
}

struct Cart {
    items: Vec<(Product, u32)>,
}

impl Cart {
    fn new() -> Self {
        Cart { items: Vec::new() }
    }
    
    fn add_item(&mut self, product: Product, quantity: u32) -> Result<(), String> {
        if !product.is_available() {
            return Err(String::from("Product out of stock"));
        }
        
        if quantity > product.quantity {
            return Err(format!("Only {} items available", product.quantity));
        }
        
        self.items.push((product, quantity));
        Ok(())
    }
    
    fn calculate_total(&self) -> f64 {
        self.items.iter()
            .map(|(product, quantity)| {
                product.calculate_price(None) * (*quantity as f64)
            })
            .sum()
    }
    
    fn display(&self) {
        println!("\n=== Shopping Cart ===");
        for (product, quantity) in &self.items {
            println!("{} x {} - ${:.2}", 
                product.name, 
                quantity, 
                product.calculate_price(None) * (*quantity as f64)
            );
        }
        println!("Total: ${:.2}", self.calculate_total());
    }
}

fn main() {
    // Create products
    let laptop = Product::new(
        1,
        String::from("Gaming Laptop"),
        ProductCategory::Electronics {
            brand: String::from("Dell"),
            warranty_months: 24,
        },
        1000.0,
        5,
    );
    
    let shirt = Product::new(
        2,
        String::from("Cotton Shirt"),
        ProductCategory::Clothing {
            size: String::from("L"),
            material: String::from("cotton"),
        },
        50.0,
        20,
    );
    
    let milk = Product::new(
        3,
        String::from("Fresh Milk"),
        ProductCategory::Food {
            expiry_date: String::from("2024-12-31"),
            storage_temp: 4,
        },
        5.0,
        50,
    );
    
    // Display products
    laptop.display();
    println!();
    shirt.display();
    println!();
    milk.display();
    
    // Create cart
    let mut cart = Cart::new();
    
    // Add items
    match cart.add_item(laptop.clone(), 1) {
        Ok(_) => println!("\nAdded laptop to cart"),
        Err(e) => println!("Error: {}", e),
    }
    
    match cart.add_item(shirt.clone(), 2) {
        Ok(_) => println!("Added shirts to cart"),
        Err(e) => println!("Error: {}", e),
    }
    
    cart.display();
    
    // TODO: Implement remaining features
}
```

**Yêu cầu mở rộng:**

1. **Inventory Management:**
   - Stock tracking
   - Low stock alerts
   - Reorder automation

2. **Advanced Discounts:**
   - Bulk discounts
   - Seasonal sales
   - Member discounts
   - Coupon codes

3. **Transaction History:**
   - Save transactions
   - Generate receipts
   - Sales reports
   - Revenue analytics

4. **Search & Filter:**
   - Search by name/category
   - Filter by price range
   - Sort by various criteria

5. **Payment Processing:**
   - Multiple payment methods
   - Payment validation
   - Refund handling

6. **Export/Import:**
   - Save to JSON/CSV
   - Load from file
   - Backup system

---

[⬅️ Trở lại: RUST/Part2.md](Part2.md) |
[⏭️ Tiếp theo: RUST/Part4.md](Part4.md) |
[🏠 Home](../README.md)
