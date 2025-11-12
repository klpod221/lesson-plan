# 📘 PHẦN 1: NHẬP MÔN RUST

- [📘 PHẦN 1: NHẬP MÔN RUST](#-phần-1-nhập-môn-rust)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Giới thiệu Rust](#-bài-1-giới-thiệu-rust)
    - [Rust là gì?](#rust-là-gì)
    - [Tại sao học Rust?](#tại-sao-học-rust)
    - [Cài đặt Rust](#cài-đặt-rust)
    - [Rust Toolchain](#rust-toolchain)
    - [Chương trình đầu tiên](#chương-trình-đầu-tiên)
    - [Cấu trúc Cargo project](#cấu-trúc-cargo-project)
  - [🧑‍🏫 Bài 2: Biến và Kiểu dữ liệu](#-bài-2-biến-và-kiểu-dữ-liệu)
    - [Biến trong Rust](#biến-trong-rust)
    - [Mutability](#mutability)
    - [Constants và Static](#constants-và-static)
    - [Shadowing](#shadowing)
    - [Kiểu dữ liệu số](#kiểu-dữ-liệu-số)
    - [Boolean và Character](#boolean-và-character)
    - [Compound types](#compound-types)
  - [🧑‍🏫 Bài 3: Hàm và Control Flow](#-bài-3-hàm-và-control-flow)
    - [Định nghĩa hàm](#định-nghĩa-hàm)
    - [Parameters và Arguments](#parameters-và-arguments)
    - [Return values](#return-values)
    - [Expressions vs Statements](#expressions-vs-statements)
    - [If expressions](#if-expressions)
    - [Loop và iteration](#loop-và-iteration)
  - [🧑‍🏫 Bài 4: String và Input/Output](#-bài-4-string-và-inputoutput)
    - [String types](#string-types)
    - [String operations](#string-operations)
    - [Print formatting](#print-formatting)
    - [Reading input](#reading-input)
    - [Error handling cơ bản](#error-handling-cơ-bản)
  - [🧑‍🏫 Bài 5: Modules và Crates](#-bài-5-modules-và-crates)
    - [Module system](#module-system)
    - [Paths và visibility](#paths-và-visibility)
    - [Use keyword](#use-keyword)
    - [External crates](#external-crates)
    - [Organizing code](#organizing-code)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN: Chương trình quản lý công việc (Todo App)](#-bài-tập-lớn-cuối-phần-chương-trình-quản-lý-công-việc-todo-app)
    - [Mô tả bài toán](#mô-tả-bài-toán)
    - [Yêu cầu](#yêu-cầu)

## 🎯 Mục tiêu tổng quát

- Hiểu được Rust là gì và tại sao nên sử dụng Rust
- Nắm vững cú pháp cơ bản: biến, kiểu dữ liệu, hàm
- Biết cách sử dụng control flow: if, loop, while, for
- Làm việc với String và I/O operations
- Hiểu module system và cách tổ chức code
- Xây dựng ứng dụng console hoàn chỉnh

---

## 🧑‍🏫 Bài 1: Giới thiệu Rust

### Rust là gì?

Rust là ngôn ngữ lập trình **systems programming** hiện đại, được thiết kế để đảm bảo:
- **Memory safety** - Không có null pointers, buffer overflows, data races
- **Performance** - Hiệu suất ngang C/C++
- **Concurrency** - Thread-safe tại compile time

**Lịch sử:**
- Bắt đầu năm 2006 bởi Graydon Hoare
- Mozilla bắt đầu sponsor từ 2009
- Phiên bản 1.0 ra mắt năm 2015
- Rust Foundation được thành lập năm 2021

**Ứng dụng:**
- Operating systems (Linux kernel modules, Redox OS)
- Web browsers (Firefox components)
- Game engines (Bevy, Amethyst)
- CLI tools (ripgrep, bat, exa)
- WebAssembly
- Embedded systems
- Blockchain và cryptocurrency

### Tại sao học Rust?

**Ưu điểm:**
1. **Memory safety without garbage collector**
   - Không có segmentation faults
   - Không có data races
   - Compiler kiểm tra tại compile time

2. **Zero-cost abstractions**
   - High-level code nhưng performance như low-level
   - Không có runtime overhead

3. **Fearless concurrency**
   - Type system đảm bảo thread safety
   - Prevent data races tại compile time

4. **Great tooling**
   - Cargo: Build system và package manager tuyệt vời
   - Rustfmt: Code formatter
   - Clippy: Linter thông minh
   - Rust Analyzer: IDE support tốt

5. **Growing ecosystem**
   - Crates.io: Hơn 100,000+ packages
   - Active community
   - Excellent documentation

**Nhược điểm:**
- Learning curve cao (ownership, borrowing, lifetimes)
- Compile time chậm hơn
- Không phù hợp cho rapid prototyping

### Cài đặt Rust

**Linux/macOS:**
```bash
# Cài đặt rustup (Rust installer)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Follow the prompts, sau đó:
source $HOME/.cargo/env

# Kiểm tra cài đặt
rustc --version
cargo --version
rustup --version
```

**Windows:**
- Download rustup-init.exe từ https://rustup.rs/
- Chạy installer và follow instructions
- Có thể cần cài Visual Studio C++ Build Tools

**Cập nhật:**
```bash
rustup update
```

**Gỡ cài đặt:**
```bash
rustup self uninstall
```

### Rust Toolchain

**rustc** - Rust compiler:
```bash
# Compile file
rustc main.rs

# Với optimization
rustc -O main.rs

# Check syntax không compile
rustc --check main.rs
```

**cargo** - Build system và package manager:
```bash
# Tạo project mới
cargo new my_project
cargo new my_lib --lib

# Build project
cargo build              # Debug mode
cargo build --release    # Release mode (optimized)

# Run project
cargo run
cargo run --release

# Check code (faster than build)
cargo check

# Run tests
cargo test

# Build documentation
cargo doc --open

# Format code
cargo fmt

# Lint code
cargo clippy
```

**rustup** - Toolchain manager:
```bash
# Xem toolchain hiện tại
rustup show

# Cài đặt nightly/beta
rustup install nightly
rustup install beta

# Switch toolchain
rustup default nightly
rustup default stable

# Update components
rustup component add rustfmt
rustup component add clippy
```

### Chương trình đầu tiên

**Cách 1: Sử dụng rustc trực tiếp**

```rust
// main.rs
fn main() {
    println!("Hello, World!");
    println!("Welcome to Rust programming!");
}
```

```bash
rustc main.rs
./main
```

**Cách 2: Sử dụng Cargo (khuyến nghị)**

```bash
# Tạo project
cargo new hello_world
cd hello_world

# Cấu trúc thư mục:
# hello_world/
# ├── Cargo.toml
# └── src/
#     └── main.rs

# Run
cargo run
```

**Giải thích code:**
```rust
fn main() {           // Hàm main - entry point
    println!(         // Macro (chú ý dấu !)
        "Hello, {}!", // Format string
        "Rust"        // Argument
    );
}
```

**Điểm cần lưu ý:**
- `fn` - keyword để định nghĩa function
- `main()` - hàm đặc biệt, điểm bắt đầu chương trình
- `println!` - macro (có dấu `!`), không phải function
- Rust sử dụng `;` để kết thúc statement
- Indentation: 4 spaces (theo convention)

### Cấu trúc Cargo project

```
my_project/
├── Cargo.toml          # Project configuration
├── Cargo.lock          # Dependency lock file
├── src/
│   ├── main.rs         # Entry point cho binary
│   └── lib.rs          # Entry point cho library
├── tests/              # Integration tests
│   └── integration_test.rs
├── benches/            # Benchmarks
│   └── benchmark.rs
├── examples/           # Example code
│   └── example.rs
└── target/             # Build output (gitignore)
    ├── debug/
    └── release/
```

**Cargo.toml:**
```toml
[package]
name = "my_project"
version = "0.1.0"
edition = "2021"
authors = ["Your Name <you@example.com>"]

[dependencies]
# serde = "1.0"
# tokio = { version = "1.0", features = ["full"] }

[dev-dependencies]
# criterion = "0.5"

[profile.release]
opt-level = 3
lto = true
```

---

## 🧑‍🏫 Bài 2: Biến và Kiểu dữ liệu

### Biến trong Rust

**Immutable by default:**
```rust
fn main() {
    let x = 5;
    println!("x = {}", x);
    
    // x = 6;  // ERROR! Cannot assign twice to immutable variable
}
```

**Tại sao immutable by default?**
- Prevents bugs (accidental mutations)
- Easier to reason about code
- Enables compiler optimizations
- Thread safety

### Mutability

```rust
fn main() {
    let mut y = 5;
    println!("y = {}", y);
    
    y = 6;  // OK!
    println!("y = {}", y);
    
    y += 10;
    println!("y = {}", y);
}
```

**Type annotations:**
```rust
fn main() {
    // Compiler can infer types
    let x = 5;                    // i32 (default)
    let y = 3.14;                 // f64 (default)
    
    // Explicit type annotation
    let a: i32 = 42;
    let b: f64 = 2.718;
    let c: bool = true;
    let d: char = '🦀';
    
    // Multiple declarations
    let (x, y, z) = (1, 2, 3);
    println!("x={}, y={}, z={}", x, y, z);
}
```

### Constants và Static

**Constants:**
```rust
// Global scope
const MAX_POINTS: u32 = 100_000;
const PI: f64 = 3.14159;

fn main() {
    const BUFFER_SIZE: usize = 1024;
    
    println!("Max points: {}", MAX_POINTS);
    println!("Buffer size: {}", BUFFER_SIZE);
}
```

**Static variables:**
```rust
static LANGUAGE: &str = "Rust";
static mut COUNTER: u32 = 0;  // Mutable static (unsafe!)

fn main() {
    println!("Language: {}", LANGUAGE);
    
    // Accessing mutable static requires unsafe
    unsafe {
        COUNTER += 1;
        println!("Counter: {}", COUNTER);
    }
}
```

**Khác biệt const vs static:**
| Feature | const | static |
|---------|-------|--------|
| Memory address | Inlined | Has fixed address |
| Mutable | No | Yes (unsafe) |
| Scope | Any | Only global |
| Usage | Values | Variables |

### Shadowing

```rust
fn main() {
    let x = 5;
    println!("x = {}", x);  // 5
    
    let x = x + 1;
    println!("x = {}", x);  // 6
    
    let x = x * 2;
    println!("x = {}", x);  // 12
    
    // Can change type
    let spaces = "   ";
    let spaces = spaces.len();
    println!("Number of spaces: {}", spaces);  // 3
}
```

**Shadowing vs Mutability:**
```rust
fn main() {
    // Shadowing - OK
    let x = "hello";
    let x = x.len();
    
    // Mutability - ERROR!
    // let mut y = "hello";
    // y = y.len();  // Type mismatch!
}
```

**Shadowing trong scopes:**
```rust
fn main() {
    let x = 5;
    
    {
        let x = x * 2;
        println!("Inner x = {}", x);  // 10
    }
    
    println!("Outer x = {}", x);  // 5
}
```

### Kiểu dữ liệu số

**Integer types:**
| Length | Signed | Unsigned |
|--------|--------|----------|
| 8-bit  | i8     | u8       |
| 16-bit | i16    | u16      |
| 32-bit | i32    | u32      |
| 64-bit | i64    | u64      |
| 128-bit| i128   | u128     |
| arch   | isize  | usize    |

```rust
fn main() {
    // Integer literals
    let decimal = 98_222;           // 98222
    let hex = 0xff;                 // 255
    let octal = 0o77;               // 63
    let binary = 0b1111_0000;       // 240
    let byte = b'A';                // 65 (u8 only)
    
    // Different sizes
    let a: i8 = -128;               // -128 to 127
    let b: u8 = 255;                // 0 to 255
    let c: i32 = -2_147_483_648;    // Default integer type
    let d: u64 = 18_446_744_073_709_551_615;
    
    // isize/usize (depends on architecture)
    let ptr_size: usize = 64;       // 32-bit or 64-bit
    
    println!("decimal: {}", decimal);
    println!("hex: {}", hex);
    println!("binary: {}", binary);
}
```

**Integer overflow:**
```rust
fn main() {
    let mut x: u8 = 255;
    
    // Debug mode: panic!
    // Release mode: wrap around
    // x += 1;  // Would wrap to 0
    
    // Explicit handling
    x = x.wrapping_add(1);      // 0
    x = x.saturating_add(10);   // 10
    
    match x.checked_add(250) {
        Some(result) => println!("Result: {}", result),
        None => println!("Overflow!"),
    }
}
```

**Floating-point types:**
```rust
fn main() {
    let x = 2.0;        // f64 (default)
    let y: f32 = 3.0;   // f32
    
    // Operations
    let sum = x + 3.5;
    let difference = 95.5 - 4.3;
    let product = 4.0 * 30.0;
    let quotient = 56.7 / 32.2;
    let remainder = 43.0 % 5.0;
    
    // Special values
    let inf = std::f64::INFINITY;
    let neg_inf = std::f64::NEG_INFINITY;
    let nan = std::f64::NAN;
    
    println!("sum: {}", sum);
    println!("quotient: {}", quotient);
}
```

**Numeric operations:**
```rust
fn main() {
    // Arithmetic
    let sum = 5 + 10;
    let difference = 95 - 4;
    let product = 4 * 30;
    let quotient = 56 / 32;        // Integer division: 1
    let float_quotient = 56.7 / 32.2;
    let remainder = 43 % 5;
    
    // Compound assignment
    let mut x = 5;
    x += 10;   // x = x + 10
    x -= 3;    // x = x - 3
    x *= 2;    // x = x * 2
    x /= 4;    // x = x / 4
    x %= 3;    // x = x % 3
    
    println!("Final x: {}", x);
}
```

### Boolean và Character

**Boolean type:**
```rust
fn main() {
    let t = true;
    let f: bool = false;
    
    // Boolean operations
    let and = t && f;       // false
    let or = t || f;        // true
    let not = !t;           // false
    
    // Comparisons
    let greater = 5 > 3;    // true
    let less = 2.5 < 1.0;   // false
    let equal = 10 == 10;   // true
    let not_equal = 5 != 3; // true
    
    println!("t && f = {}", and);
    println!("5 > 3 = {}", greater);
}
```

**Character type:**
```rust
fn main() {
    let c = 'z';
    let z: char = 'ℤ';
    let heart_eyed_cat = '😻';
    let vietnamese = 'Ế';
    
    // char is 4 bytes (Unicode Scalar Value)
    println!("Size of char: {} bytes", std::mem::size_of::<char>());
    
    println!("Characters: {}, {}, {}, {}", c, z, heart_eyed_cat, vietnamese);
}
```

### Compound types

**Tuples:**
```rust
fn main() {
    // Define tuple
    let tup: (i32, f64, u8) = (500, 6.4, 1);
    
    // Destructuring
    let (x, y, z) = tup;
    println!("x={}, y={}, z={}", x, y, z);
    
    // Access by index
    let five_hundred = tup.0;
    let six_point_four = tup.1;
    let one = tup.2;
    
    println!("tup.0 = {}", five_hundred);
    
    // Unit type (empty tuple)
    let unit: () = ();
    
    // Tuple as return value
    let (min, max) = find_min_max(vec![5, 2, 8, 1, 9]);
    println!("min={}, max={}", min, max);
}

fn find_min_max(numbers: Vec<i32>) -> (i32, i32) {
    let mut min = numbers[0];
    let mut max = numbers[0];
    
    for &num in &numbers {
        if num < min { min = num; }
        if num > max { max = num; }
    }
    
    (min, max)
}
```

**Arrays:**
```rust
fn main() {
    // Fixed size, same type
    let arr = [1, 2, 3, 4, 5];
    let months = ["January", "February", "March", "April"];
    
    // Type annotation: [type; size]
    let a: [i32; 5] = [1, 2, 3, 4, 5];
    
    // Initialize with same value
    let zeros = [0; 10];  // [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    // Access elements
    let first = arr[0];
    let second = arr[1];
    
    println!("First: {}", first);
    println!("Array length: {}", arr.len());
    
    // Iterate
    for element in arr.iter() {
        println!("{}", element);
    }
    
    // Index out of bounds (runtime error!)
    // let element = arr[10];  // panic!
}
```

**Slices:**
```rust
fn main() {
    let arr = [1, 2, 3, 4, 5, 6];
    
    // Slice: view into array
    let slice = &arr[1..4];  // [2, 3, 4]
    let slice2 = &arr[..3];  // [1, 2, 3]
    let slice3 = &arr[3..];  // [4, 5, 6]
    let slice4 = &arr[..];   // [1, 2, 3, 4, 5, 6]
    
    println!("Slice: {:?}", slice);
    println!("Slice length: {}", slice.len());
    
    // Pass slice to function
    print_slice(&arr[2..5]);
}

fn print_slice(slice: &[i32]) {
    println!("Slice contents:");
    for item in slice {
        println!("  {}", item);
    }
}
```

---

## 🧑‍🏫 Bài 3: Hàm và Control Flow

### Định nghĩa hàm

```rust
fn main() {
    println!("Hello from main!");
    greet();
    greet_person("Alice");
    greet_person_twice("Bob", 2);
}

// Function without parameters
fn greet() {
    println!("Hello, World!");
}

// Function with parameter
fn greet_person(name: &str) {
    println!("Hello, {}!", name);
}

// Multiple parameters
fn greet_person_twice(name: &str, times: i32) {
    for _ in 0..times {
        println!("Hello, {}!", name);
    }
}
```

**Naming convention:**
- Functions: `snake_case`
- Types: `PascalCase`
- Constants: `SCREAMING_SNAKE_CASE`

### Parameters và Arguments

```rust
fn main() {
    let result = add(5, 10);
    println!("5 + 10 = {}", result);
    
    let (sum, product) = calculate(3, 4);
    println!("sum={}, product={}", sum, product);
    
    // Pass by value (copy for primitives)
    let x = 5;
    print_value(x);
    println!("x is still valid: {}", x);
    
    // Pass by reference
    let s = String::from("hello");
    print_string(&s);
    println!("s is still valid: {}", s);
}

fn add(x: i32, y: i32) -> i32 {
    x + y  // No semicolon = return value
}

fn calculate(a: i32, b: i32) -> (i32, i32) {
    (a + b, a * b)
}

fn print_value(x: i32) {
    println!("Value: {}", x);
}

fn print_string(s: &String) {
    println!("String: {}", s);
}
```

### Return values

```rust
fn main() {
    let x = five();
    println!("five() returns: {}", x);
    
    let y = plus_one(5);
    println!("plus_one(5) returns: {}", y);
    
    // Early return
    let grade = get_grade(85);
    println!("Grade: {}", grade);
}

// Return without return keyword
fn five() -> i32 {
    5  // No semicolon!
}

fn plus_one(x: i32) -> i32 {
    x + 1  // Expression, not statement
}

// Explicit return
fn multiply(x: i32, y: i32) -> i32 {
    return x * y;  // With semicolon OK
}

// Early return
fn get_grade(score: i32) -> char {
    if score >= 90 {
        return 'A';
    }
    if score >= 80 {
        return 'B';
    }
    if score >= 70 {
        return 'C';
    }
    'F'
}

// Unit type (no return value)
fn print_info() {
    println!("This function returns ()");
}

fn print_info_explicit() -> () {
    println!("Explicit unit return type");
}
```

### Expressions vs Statements

```rust
fn main() {
    // Statement: không trả về giá trị
    let x = 5;
    
    // Expression: trả về giá trị
    let y = {
        let x = 3;
        x + 1  // No semicolon = expression
    };
    println!("y = {}", y);  // 4
    
    // If as expression
    let number = 6;
    let description = if number % 2 == 0 {
        "even"
    } else {
        "odd"
    };
    println!("{} is {}", number, description);
    
    // Match as expression
    let grade = match 85 {
        90..=100 => 'A',
        80..=89 => 'B',
        70..=79 => 'C',
        60..=69 => 'D',
        _ => 'F',
    };
    println!("Grade: {}", grade);
}
```

**Statement có `;` - Expression không có `;`:**
```rust
fn example() -> i32 {
    let x = 5;     // Statement
    x + 1          // Expression (return value)
}

fn wrong() -> i32 {
    let x = 5;     // Statement
    x + 1;         // Statement! Returns ()
}  // ERROR: expected i32, found ()
```

### If expressions

```rust
fn main() {
    let number = 7;
    
    // Basic if-else
    if number < 5 {
        println!("condition was true");
    } else {
        println!("condition was false");
    }
    
    // Multiple conditions
    if number % 4 == 0 {
        println!("divisible by 4");
    } else if number % 3 == 0 {
        println!("divisible by 3");
    } else if number % 2 == 0 {
        println!("divisible by 2");
    } else {
        println!("not divisible by 4, 3, or 2");
    }
    
    // If in let statement
    let condition = true;
    let number = if condition { 5 } else { 6 };
    println!("number = {}", number);
    
    // Complex conditions
    let age = 20;
    let has_license = true;
    
    if age >= 18 && has_license {
        println!("Can drive");
    } else if age >= 18 {
        println!("Need license");
    } else {
        println!("Too young");
    }
}
```

### Loop và iteration

**Infinite loop:**
```rust
fn main() {
    let mut counter = 0;
    
    loop {
        counter += 1;
        println!("Counter: {}", counter);
        
        if counter >= 5 {
            break;
        }
    }
    
    // Return value from loop
    let result = loop {
        counter += 1;
        
        if counter == 10 {
            break counter * 2;
        }
    };
    println!("Result: {}", result);
}
```

**While loop:**
```rust
fn main() {
    let mut number = 3;
    
    while number != 0 {
        println!("{}!", number);
        number -= 1;
    }
    println!("LIFTOFF!");
    
    // While with condition
    let mut stack = vec![1, 2, 3, 4, 5];
    while let Some(top) = stack.pop() {
        println!("{}", top);
    }
}
```

**For loop:**
```rust
fn main() {
    // Iterate over array
    let arr = [10, 20, 30, 40, 50];
    for element in arr.iter() {
        println!("Value: {}", element);
    }
    
    // Range
    for number in 1..5 {
        println!("{}", number);  // 1, 2, 3, 4
    }
    
    // Inclusive range
    for number in 1..=5 {
        println!("{}", number);  // 1, 2, 3, 4, 5
    }
    
    // Reverse
    for number in (1..5).rev() {
        println!("{}", number);  // 4, 3, 2, 1
    }
    
    // With index
    let arr = ['a', 'b', 'c'];
    for (index, value) in arr.iter().enumerate() {
        println!("arr[{}] = {}", index, value);
    }
}
```

**Loop labels:**
```rust
fn main() {
    let mut count = 0;
    
    'outer: loop {
        println!("count = {}", count);
        let mut remaining = 10;
        
        loop {
            println!("remaining = {}", remaining);
            if remaining == 5 {
                break;  // Break inner loop
            }
            if count == 2 {
                break 'outer;  // Break outer loop
            }
            remaining -= 1;
        }
        
        count += 1;
    }
    
    println!("End count = {}", count);
}
```

---

## 🧑‍🏫 Bài 4: String và Input/Output

### String types

**Two main string types:**
1. `String` - Owned, growable, heap-allocated
2. `&str` - String slice, borrowed, often stack-allocated

```rust
fn main() {
    // String literal (type: &str)
    let s1 = "Hello";
    let s2: &str = "World";
    
    // String (heap-allocated)
    let mut s3 = String::from("Hello");
    let s4 = "World".to_string();
    let s5 = String::new();
    
    println!("s1: {}", s1);
    println!("s3: {}", s3);
    
    // String is mutable
    s3.push_str(", World");
    println!("s3 after push_str: {}", s3);
}
```

**When to use which?**
- Use `&str` for:
  - Function parameters (more flexible)
  - String literals
  - Read-only operations
  
- Use `String` for:
  - Owned data
  - Dynamic/growing strings
  - Return values

### String operations

```rust
fn main() {
    let mut s = String::from("Hello");
    
    // Append
    s.push_str(", World");
    s.push('!');
    println!("After push: {}", s);
    
    // Concatenation
    let s1 = String::from("Hello");
    let s2 = String::from(" World");
    let s3 = s1 + &s2;  // s1 moved here
    println!("s3: {}", s3);
    // println!("s1: {}", s1);  // ERROR: s1 was moved
    
    // format! macro (doesn't take ownership)
    let s1 = String::from("Hello");
    let s2 = String::from("World");
    let s3 = format!("{}, {}!", s1, s2);
    println!("s3: {}", s3);
    println!("s1 still valid: {}", s1);
    
    // Substring
    let hello = "Hello, World!";
    let hello_slice = &hello[0..5];
    let world_slice = &hello[7..12];
    println!("Slices: {} {}", hello_slice, world_slice);
    
    // Common methods
    let s = String::from("  Hello, World!  ");
    println!("Length: {}", s.len());
    println!("Is empty: {}", s.is_empty());
    println!("Trimmed: '{}'", s.trim());
    println!("Uppercase: {}", s.to_uppercase());
    println!("Lowercase: {}", s.to_lowercase());
    println!("Contains 'World': {}", s.contains("World"));
    println!("Starts with 'Hello': {}", s.trim().starts_with("Hello"));
    
    // Replace
    let s = String::from("I like apples");
    let new_s = s.replace("apples", "oranges");
    println!("{}", new_s);
    
    // Split
    let data = "apple,banana,orange";
    for fruit in data.split(',') {
        println!("Fruit: {}", fruit);
    }
    
    // Chars
    for c in "Hello".chars() {
        println!("{}", c);
    }
    
    // Bytes
    for b in "Hello".bytes() {
        println!("{}", b);
    }
}
```

**String conversion:**
```rust
fn main() {
    // &str to String
    let s1: String = "hello".to_string();
    let s2: String = String::from("hello");
    
    // String to &str
    let s3 = String::from("hello");
    let s4: &str = &s3;
    let s5: &str = s3.as_str();
    
    // Number to String
    let n = 42;
    let s = n.to_string();
    let s2 = format!("{}", n);
    
    // String to number
    let s = "42";
    let n: i32 = s.parse().unwrap();
    let n2: Result<i32, _> = s.parse();
    
    println!("Parsed: {}", n);
}
```

### Print formatting

```rust
fn main() {
    // Basic print
    println!("Hello, World!");
    
    // Positional arguments
    println!("{} is {} years old", "Alice", 25);
    
    // Named arguments
    println!("{name} is {age} years old", name="Bob", age=30);
    
    // Positional with index
    println!("{0} {1} {0}", "A", "B");  // A B A
    
    // Debug printing
    let arr = [1, 2, 3];
    println!("Array: {:?}", arr);
    println!("Pretty print: {:#?}", arr);
    
    // Number formatting
    let pi = 3.14159;
    println!("Pi: {:.2}", pi);  // 2 decimal places
    println!("Pi: {:.*}", 3, pi);  // 3 decimal places
    
    // Width and alignment
    println!("|{:5}|", "hi");     // |hi   |
    println!("|{:<5}|", "hi");    // |hi   | (left)
    println!("|{:>5}|", "hi");    // |   hi| (right)
    println!("|{:^5}|", "hi");    // | hi  | (center)
    
    // Padding
    println!("{:0>5}", 42);       // 00042
    println!("{:*<5}", 42);       // 42***
    
    // Different bases
    let n = 255;
    println!("Binary: {:b}", n);       // 11111111
    println!("Octal: {:o}", n);        // 377
    println!("Hex: {:x}", n);          // ff
    println!("Hex upper: {:X}", n);    // FF
    
    // Print without newline
    print!("Loading");
    for _ in 0..3 {
        print!(".");
    }
    println!(" Done!");
    
    // eprint/eprintln for stderr
    eprintln!("This is an error message");
}
```

### Reading input

```rust
use std::io;

fn main() {
    println!("Enter your name:");
    
    let mut name = String::new();
    io::stdin()
        .read_line(&mut name)
        .expect("Failed to read line");
    
    // Trim whitespace and newline
    let name = name.trim();
    println!("Hello, {}!", name);
}
```

**Reading numbers:**
```rust
use std::io;

fn main() {
    println!("Enter your age:");
    
    let mut input = String::new();
    io::stdin()
        .read_line(&mut input)
        .expect("Failed to read line");
    
    let age: i32 = input.trim().parse()
        .expect("Please enter a valid number");
    
    println!("You are {} years old", age);
}
```

**Better error handling:**
```rust
use std::io;

fn main() {
    loop {
        println!("Enter a number:");
        
        let mut input = String::new();
        io::stdin()
            .read_line(&mut input)
            .expect("Failed to read line");
        
        match input.trim().parse::<i32>() {
            Ok(num) => {
                println!("You entered: {}", num);
                break;
            }
            Err(_) => {
                println!("Invalid number, try again!");
                continue;
            }
        }
    }
}
```

### Error handling cơ bản

**Result type:**
```rust
use std::fs::File;
use std::io::ErrorKind;

fn main() {
    // Using match
    let f = File::open("hello.txt");
    
    let f = match f {
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
    
    println!("File opened successfully");
}
```

**Using unwrap and expect:**
```rust
use std::fs::File;

fn main() {
    // unwrap: panic on error
    // let f = File::open("hello.txt").unwrap();
    
    // expect: panic with custom message
    let f = File::open("hello.txt")
        .expect("Failed to open hello.txt");
}
```

**Propagating errors:**
```rust
use std::fs::File;
use std::io::{self, Read};

fn read_username_from_file() -> Result<String, io::Error> {
    let mut f = File::open("username.txt")?;
    let mut s = String::new();
    f.read_to_string(&mut s)?;
    Ok(s)
}

fn main() {
    match read_username_from_file() {
        Ok(username) => println!("Username: {}", username),
        Err(e) => println!("Error: {}", e),
    }
}
```

---

## 🧑‍🏫 Bài 5: Modules và Crates

### Module system

**Defining modules:**
```rust
// lib.rs or main.rs

// Inline module
mod greetings {
    pub fn hello() {
        println!("Hello!");
    }
    
    pub fn goodbye() {
        println!("Goodbye!");
    }
    
    // Private function
    fn secret() {
        println!("This is secret");
    }
}

// Nested modules
mod math {
    pub mod geometry {
        pub fn area_circle(radius: f64) -> f64 {
            std::f64::consts::PI * radius * radius
        }
    }
    
    pub mod algebra {
        pub fn square(x: i32) -> i32 {
            x * x
        }
    }
}

fn main() {
    greetings::hello();
    greetings::goodbye();
    // greetings::secret();  // ERROR: private
    
    let area = math::geometry::area_circle(5.0);
    let sq = math::algebra::square(10);
    
    println!("Area: {}", area);
    println!("Square: {}", sq);
}
```

### Paths và visibility

**File structure:**
```
src/
├── main.rs
├── lib.rs
├── utils/
│   ├── mod.rs
│   ├── math.rs
│   └── string_ops.rs
└── models/
    ├── mod.rs
    ├── user.rs
    └── post.rs
```

**src/utils/mod.rs:**
```rust
pub mod math;
pub mod string_ops;

// Re-export
pub use math::add;
pub use string_ops::capitalize;
```

**src/utils/math.rs:**
```rust
pub fn add(a: i32, b: i32) -> i32 {
    a + b
}

pub fn multiply(a: i32, b: i32) -> i32 {
    a * b
}

// Private function
fn internal_helper() {
    // ...
}
```

**src/utils/string_ops.rs:**
```rust
pub fn capitalize(s: &str) -> String {
    let mut chars = s.chars();
    match chars.next() {
        None => String::new(),
        Some(first) => first.to_uppercase().chain(chars).collect(),
    }
}

pub fn reverse(s: &str) -> String {
    s.chars().rev().collect()
}
```

**src/main.rs:**
```rust
mod utils;

fn main() {
    // Using full path
    let sum = utils::math::add(5, 10);
    
    // Using re-exported items
    let sum2 = utils::add(3, 7);
    let cap = utils::capitalize("hello");
    
    println!("Sum: {}", sum);
    println!("Capitalized: {}", cap);
}
```

### Use keyword

```rust
// Import single item
use std::collections::HashMap;

// Import multiple items
use std::io::{self, Read, Write};

// Import all items (not recommended)
use std::collections::*;

// Aliasing
use std::io::Result as IoResult;
use std::fmt::Result as FmtResult;

// Re-exporting
pub use std::collections::HashMap;

fn main() {
    let mut map = HashMap::new();
    map.insert("key", "value");
    
    println!("{:?}", map);
}
```

**Nested paths:**
```rust
// Instead of:
// use std::io;
// use std::io::Write;
// use std::io::Read;

// Use:
use std::io::{self, Write, Read};

// Instead of:
// use std::cmp::Ordering;
// use std::fmt::Display;

// Use:
use std::{cmp::Ordering, fmt::Display};
```

### External crates

**Cargo.toml:**
```toml
[dependencies]
rand = "0.8"
serde = { version = "1.0", features = ["derive"] }
tokio = { version = "1", features = ["full"] }
```

**Using external crate:**
```rust
use rand::Rng;

fn main() {
    let mut rng = rand::thread_rng();
    
    let n: u32 = rng.gen();
    let n_range: i32 = rng.gen_range(1..=100);
    
    println!("Random number: {}", n);
    println!("Random in range: {}", n_range);
}
```

**Popular crates:**
- `serde` - Serialization/deserialization
- `tokio` - Async runtime
- `reqwest` - HTTP client
- `clap` - Command-line argument parser
- `regex` - Regular expressions
- `chrono` - Date and time
- `log` - Logging
- `anyhow` - Error handling

### Organizing code

**Best practices:**
1. One module per file
2. Use mod.rs for module directories
3. Keep related functionality together
4. Use visibility modifiers appropriately
5. Re-export commonly used items

**Example structure:**
```
my_app/
├── Cargo.toml
├── src/
│   ├── main.rs           # Binary entry point
│   ├── lib.rs            # Library entry point
│   ├── config.rs         # Configuration
│   ├── models/
│   │   ├── mod.rs
│   │   ├── user.rs
│   │   └── post.rs
│   ├── services/
│   │   ├── mod.rs
│   │   ├── auth.rs
│   │   └── database.rs
│   └── utils/
│       ├── mod.rs
│       ├── validation.rs
│       └── formatting.rs
└── tests/
    ├── integration_test.rs
    └── common/
        └── mod.rs
```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Chương trình quản lý công việc (Todo App)

### Mô tả bài toán

Xây dựng ứng dụng quản lý công việc (Todo List) trong terminal với các chức năng:
- Thêm công việc mới
- Xem danh sách công việc
- Đánh dấu công việc hoàn thành
- Xóa công việc
- Lọc công việc (tất cả/hoàn thành/chưa hoàn thành)
- Lưu và load từ file

### Yêu cầu

1. **Cấu trúc dữ liệu:**
   - Struct `Todo` với các field: id, title, completed, created_at
   - Vec để lưu danh sách todos

2. **Chức năng cơ bản:**
   ```
   Todo Manager
   1. Add todo
   2. List todos
   3. Complete todo
   4. Delete todo
   5. Filter todos
   6. Save to file
   7. Load from file
   0. Exit
   ```

3. **Validation:**
   - Title không được rỗng
   - ID phải hợp lệ khi complete/delete
   - Xử lý lỗi khi đọc/ghi file

4. **Format hiển thị:**
   ```
   ID | Title                    | Status    | Created
   ---+-------------------------+-----------+-------------------
   1  | Learn Rust              | ✓ Done    | 2024-01-15 10:30
   2  | Build Todo App          | ✗ Pending | 2024-01-15 11:00
   3  | Practice ownership      | ✗ Pending | 2024-01-15 12:00
   ```

**Template code:**

```rust
use std::io::{self, Write};

#[derive(Debug)]
struct Todo {
    id: u32,
    title: String,
    completed: bool,
    created_at: String,
}

impl Todo {
    fn new(id: u32, title: String) -> Self {
        Todo {
            id,
            title,
            completed: false,
            created_at: get_current_time(),
        }
    }
    
    fn display(&self) {
        let status = if self.completed { "✓ Done" } else { "✗ Pending" };
        println!("{:<3} | {:<25} | {:<9} | {}", 
                 self.id, self.title, status, self.created_at);
    }
}

struct TodoManager {
    todos: Vec<Todo>,
    next_id: u32,
}

impl TodoManager {
    fn new() -> Self {
        TodoManager {
            todos: Vec::new(),
            next_id: 1,
        }
    }
    
    fn add_todo(&mut self, title: String) {
        // TODO: Implement
    }
    
    fn list_todos(&self) {
        // TODO: Implement
    }
    
    fn complete_todo(&mut self, id: u32) {
        // TODO: Implement
    }
    
    fn delete_todo(&mut self, id: u32) {
        // TODO: Implement
    }
    
    fn filter_todos(&self, show_completed: bool, show_pending: bool) {
        // TODO: Implement
    }
    
    fn save_to_file(&self, filename: &str) {
        // TODO: Implement
    }
    
    fn load_from_file(&mut self, filename: &str) {
        // TODO: Implement
    }
}

fn get_current_time() -> String {
    // Simplified - use chrono crate for real apps
    String::from("2024-01-15 10:00")
}

fn read_input(prompt: &str) -> String {
    print!("{}", prompt);
    io::stdout().flush().unwrap();
    
    let mut input = String::new();
    io::stdin().read_line(&mut input).unwrap();
    input.trim().to_string()
}

fn main() {
    let mut manager = TodoManager::new();
    
    loop {
        println!("\n=== Todo Manager ===");
        println!("1. Add todo");
        println!("2. List todos");
        println!("3. Complete todo");
        println!("4. Delete todo");
        println!("5. Filter todos");
        println!("6. Save to file");
        println!("7. Load from file");
        println!("0. Exit");
        
        let choice = read_input("Enter choice: ");
        
        match choice.as_str() {
            "1" => {
                let title = read_input("Enter todo title: ");
                manager.add_todo(title);
            }
            "2" => {
                manager.list_todos();
            }
            "3" => {
                let id = read_input("Enter todo ID: ");
                if let Ok(id) = id.parse::<u32>() {
                    manager.complete_todo(id);
                }
            }
            "4" => {
                let id = read_input("Enter todo ID: ");
                if let Ok(id) = id.parse::<u32>() {
                    manager.delete_todo(id);
                }
            }
            "5" => {
                println!("1. All");
                println!("2. Completed");
                println!("3. Pending");
                let filter = read_input("Choose filter: ");
                match filter.as_str() {
                    "1" => manager.filter_todos(true, true),
                    "2" => manager.filter_todos(true, false),
                    "3" => manager.filter_todos(false, true),
                    _ => println!("Invalid filter"),
                }
            }
            "6" => {
                let filename = read_input("Enter filename: ");
                manager.save_to_file(&filename);
            }
            "7" => {
                let filename = read_input("Enter filename: ");
                manager.load_from_file(&filename);
            }
            "0" => {
                println!("Goodbye!");
                break;
            }
            _ => {
                println!("Invalid choice!");
            }
        }
    }
}
```

**Yêu cầu mở rộng:**

1. Thêm priority (High/Medium/Low) cho mỗi todo
2. Thêm due date và cảnh báo khi quá hạn
3. Thêm category/tags cho todos
4. Search todos by keyword
5. Sort todos (by date, priority, status)
6. Export to JSON/CSV
7. Statistics (total, completed, pending)
8. Undo/Redo operations
9. Recurring todos (daily/weekly/monthly)
10. Color-coded output (using crate `colored`)

**Gợi ý implementation:**
- Sử dụng `serde` crate để serialize/deserialize
- Sử dụng `chrono` crate để xử lý date/time
- Sử dụng `colored` crate để tô màu output
- Tổ chức code thành modules: models, services, utils
- Thêm unit tests cho các functions

---

[⏭️ Tiếp theo: RUST/Part2.md - Ownership & Borrowing](Part2.md) |
[🏠 Home](../README.md)
