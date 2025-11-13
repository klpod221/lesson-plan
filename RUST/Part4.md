# 📘 PHẦN 4: COLLECTIONS VÀ ERROR HANDLING

- [📘 PHẦN 4: COLLECTIONS VÀ ERROR HANDLING](#-phần-4-collections-và-error-handling)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Vectors](#-bài-1-vectors)
    - [Creating vectors](#creating-vectors)
    - [Updating vectors](#updating-vectors)
    - [Reading elements](#reading-elements)
    - [Iterating](#iterating)
    - [Storing enums](#storing-enums)
  - [🧑‍🏫 Bài 2: Strings](#-bài-2-strings)
    - [Creating strings](#creating-strings)
    - [Updating strings](#updating-strings)
    - [Indexing strings](#indexing-strings)
    - [Slicing strings](#slicing-strings)
    - [Iterating strings](#iterating-strings)
  - [🧑‍🏫 Bài 3: Hash Maps](#-bài-3-hash-maps)
    - [Creating hash maps](#creating-hash-maps)
    - [Accessing values](#accessing-values)
    - [Updating hash maps](#updating-hash-maps)
    - [Iterating hash maps](#iterating-hash-maps)
  - [🧑‍🏫 Bài 4: Advanced Error Handling](#-bài-4-advanced-error-handling)
    - [Recoverable errors](#recoverable-errors)
    - [Unrecoverable errors](#unrecoverable-errors)
    - [Custom error types](#custom-error-types)
    - [Error conversion](#error-conversion)
    - [Best practices](#best-practices)
  - [🧑‍🏫 Bài 5: Testing](#-bài-5-testing)
    - [Writing tests](#writing-tests)
    - [Test organization](#test-organization)
    - [Running tests](#running-tests)
    - [Test assertions](#test-assertions)
    - [Integration tests](#integration-tests)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN: Contact Management System](#-bài-tập-lớn-cuối-phần-contact-management-system)
    - [Mô tả bài toán](#mô-tả-bài-toán)
    - [Yêu cầu](#yêu-cầu)

## 🎯 Mục tiêu tổng quát

- Master các collection types: Vec, String, HashMap
- Hiểu ownership với collections
- Advanced error handling patterns
- Custom error types và conversion
- Writing effective tests
- Build real-world data management system

---

## 🧑‍🏫 Bài 1: Vectors

### Creating vectors

```rust
fn main() {
    // Empty vector
    let v: Vec<i32> = Vec::new();
    
    // Using vec! macro
    let v = vec![1, 2, 3, 4, 5];
    
    // With capacity
    let mut v: Vec<i32> = Vec::with_capacity(10);
    println!("Length: {}, Capacity: {}", v.len(), v.capacity());
}
```

### Updating vectors

```rust
fn main() {
    let mut v = Vec::new();
    
    // Push elements
    v.push(5);
    v.push(6);
    v.push(7);
    v.push(8);
    
    println!("{:?}", v);
    
    // Pop element
    if let Some(last) = v.pop() {
        println!("Popped: {}", last);
    }
    
    // Insert at position
    v.insert(1, 10);
    println!("{:?}", v);
    
    // Remove at position
    let removed = v.remove(1);
    println!("Removed: {}", removed);
    
    // Clear all
    v.clear();
    println!("After clear: {:?}", v);
}
```

### Reading elements

```rust
fn main() {
    let v = vec![1, 2, 3, 4, 5];
    
    // Indexing (panics if out of bounds)
    let third = v[2];
    println!("Third element: {}", third);
    
    // Get method (returns Option)
    match v.get(2) {
        Some(third) => println!("Third element: {}", third),
        None => println!("No third element"),
    }
    
    // Safe access
    match v.get(10) {
        Some(val) => println!("Value: {}", val),
        None => println!("Index out of bounds"),
    }
}
```

**Ownership rules:**

```rust
fn main() {
    let mut v = vec![1, 2, 3, 4, 5];
    
    let first = &v[0];
    
    // v.push(6);  // ERROR: cannot borrow as mutable
    
    println!("First: {}", first);
}
```

### Iterating

```rust
fn main() {
    let v = vec![100, 32, 57];
    
    // Immutable iteration
    for i in &v {
        println!("{}", i);
    }
    
    // Mutable iteration
    let mut v = vec![100, 32, 57];
    for i in &mut v {
        *i += 50;
    }
    println!("{:?}", v);
    
    // Take ownership
    for i in v {
        println!("{}", i);
    }
    // println!("{:?}", v);  // ERROR: v moved
}
```

**Iterator methods:**

```rust
fn main() {
    let v = vec![1, 2, 3, 4, 5];
    
    // Map
    let doubled: Vec<i32> = v.iter().map(|x| x * 2).collect();
    println!("{:?}", doubled);
    
    // Filter
    let evens: Vec<i32> = v.iter().filter(|x| *x % 2 == 0).copied().collect();
    println!("{:?}", evens);
    
    // Sum
    let sum: i32 = v.iter().sum();
    println!("Sum: {}", sum);
    
    // Any/All
    let has_three = v.iter().any(|x| *x == 3);
    let all_positive = v.iter().all(|x| *x > 0);
    println!("Has 3: {}, All positive: {}", has_three, all_positive);
}
```

### Storing enums

```rust
#[derive(Debug)]
enum SpreadsheetCell {
    Int(i32),
    Float(f64),
    Text(String),
}

fn main() {
    let row = vec![
        SpreadsheetCell::Int(3),
        SpreadsheetCell::Text(String::from("blue")),
        SpreadsheetCell::Float(10.12),
    ];
    
    for cell in &row {
        match cell {
            SpreadsheetCell::Int(i) => println!("Integer: {}", i),
            SpreadsheetCell::Float(f) => println!("Float: {}", f),
            SpreadsheetCell::Text(s) => println!("Text: {}", s),
        }
    }
}
```

---

## 🧑‍🏫 Bài 2: Strings

### Creating strings

```rust
fn main() {
    // New empty string
    let mut s = String::new();
    
    // From string literal
    let s = "initial contents".to_string();
    let s = String::from("initial contents");
    
    // From bytes
    let hello = String::from_utf8(vec![72, 101, 108, 108, 111]).unwrap();
    println!("{}", hello);
}
```

### Updating strings

```rust
fn main() {
    let mut s = String::from("foo");
    
    // Push string slice
    s.push_str("bar");
    println!("{}", s);
    
    // Push single char
    s.push('!');
    println!("{}", s);
    
    // Concatenation with +
    let s1 = String::from("Hello, ");
    let s2 = String::from("world!");
    let s3 = s1 + &s2;  // s1 moved here
    // println!("{}", s1);  // ERROR: s1 moved
    println!("{}", s3);
    
    // Concatenation with format!
    let s1 = String::from("tic");
    let s2 = String::from("tac");
    let s3 = String::from("toe");
    let s = format!("{}-{}-{}", s1, s2, s3);
    println!("{}", s);
    // s1, s2, s3 still valid
}
```

### Indexing strings

```rust
fn main() {
    let s = String::from("hello");
    
    // This doesn't work!
    // let h = s[0];  // ERROR: cannot index String
    
    // Why? UTF-8 encoding issues
    let hello = String::from("Здравствуйте");
    // Each Cyrillic character is 2 bytes
    println!("Length: {} bytes", hello.len());  // 24 bytes, not 12 chars
}
```

### Slicing strings

```rust
fn main() {
    let hello = "Здравствуйте";
    
    // Slice by bytes (dangerous!)
    let s = &hello[0..4];  // First 2 chars (4 bytes)
    println!("{}", s);
    
    // This would panic:
    // let s = &hello[0..1];  // Not a char boundary!
}
```

### Iterating strings

```rust
fn main() {
    // By characters
    for c in "नमस्ते".chars() {
        println!("{}", c);
    }
    
    // By bytes
    for b in "नमस्ते".bytes() {
        println!("{}", b);
    }
    
    // Count chars
    let s = String::from("नमस्ते");
    println!("Chars: {}", s.chars().count());
    println!("Bytes: {}", s.len());
}
```

**String methods:**

```rust
fn main() {
    let s = String::from("  Hello, World!  ");
    
    // Trim
    println!("'{}'", s.trim());
    
    // Replace
    let s2 = s.replace("World", "Rust");
    println!("{}", s2);
    
    // Split
    let words: Vec<&str> = "hello world".split(' ').collect();
    println!("{:?}", words);
    
    // Contains
    if s.contains("Hello") {
        println!("Found 'Hello'");
    }
    
    // Starts/ends with
    if s.trim().starts_with("Hello") {
        println!("Starts with 'Hello'");
    }
    
    // To lowercase/uppercase
    println!("{}", s.to_lowercase());
    println!("{}", s.to_uppercase());
}
```

---

## 🧑‍🏫 Bài 3: Hash Maps

### Creating hash maps

```rust
use std::collections::HashMap;

fn main() {
    // New empty map
    let mut scores = HashMap::new();
    scores.insert(String::from("Blue"), 10);
    scores.insert(String::from("Yellow"), 50);
    
    // From vectors
    let teams = vec![String::from("Blue"), String::from("Yellow")];
    let initial_scores = vec![10, 50];
    let scores: HashMap<_, _> = teams.iter().zip(initial_scores.iter()).collect();
    
    println!("{:?}", scores);
}
```

**Ownership:**

```rust
use std::collections::HashMap;

fn main() {
    let field_name = String::from("Favorite color");
    let field_value = String::from("Blue");
    
    let mut map = HashMap::new();
    map.insert(field_name, field_value);
    
    // field_name and field_value moved
    // println!("{}", field_name);  // ERROR
    
    // References not moved (but need lifetimes)
    let key = String::from("name");
    let value = String::from("Alice");
    
    let mut map: HashMap<&str, &str> = HashMap::new();
    map.insert(&key, &value);
    
    println!("{}, {}", key, value);  // Still valid
}
```

### Accessing values

```rust
use std::collections::HashMap;

fn main() {
    let mut scores = HashMap::new();
    scores.insert(String::from("Blue"), 10);
    scores.insert(String::from("Yellow"), 50);
    
    // Get (returns Option)
    let team_name = String::from("Blue");
    let score = scores.get(&team_name);
    match score {
        Some(&s) => println!("Score: {}", s),
        None => println!("Team not found"),
    }
    
    // Get with default
    let score = scores.get("Blue").copied().unwrap_or(0);
    println!("Score: {}", score);
}
```

### Updating hash maps

```rust
use std::collections::HashMap;

fn main() {
    let mut scores = HashMap::new();
    
    // Overwriting
    scores.insert(String::from("Blue"), 10);
    scores.insert(String::from("Blue"), 25);  // Overwrites
    println!("{:?}", scores);
    
    // Only insert if key doesn't exist
    scores.entry(String::from("Yellow")).or_insert(50);
    scores.entry(String::from("Blue")).or_insert(50);  // Doesn't change
    println!("{:?}", scores);
    
    // Update based on old value
    let text = "hello world wonderful world";
    let mut map = HashMap::new();
    
    for word in text.split_whitespace() {
        let count = map.entry(word).or_insert(0);
        *count += 1;
    }
    
    println!("{:?}", map);
}
```

### Iterating hash maps

```rust
use std::collections::HashMap;

fn main() {
    let mut scores = HashMap::new();
    scores.insert(String::from("Blue"), 10);
    scores.insert(String::from("Yellow"), 50);
    
    // Iterate key-value pairs
    for (key, value) in &scores {
        println!("{}: {}", key, value);
    }
    
    // Iterate keys
    for key in scores.keys() {
        println!("Key: {}", key);
    }
    
    // Iterate values
    for value in scores.values() {
        println!("Value: {}", value);
    }
    
    // Mutable iteration
    for (key, value) in &mut scores {
        *value += 10;
    }
    println!("{:?}", scores);
}
```

---

## 🧑‍🏫 Bài 4: Advanced Error Handling

### Recoverable errors

```rust
use std::fs::File;
use std::io::{self, Read};

fn read_username_from_file(filename: &str) -> Result<String, io::Error> {
    let mut file = File::open(filename)?;
    let mut username = String::new();
    file.read_to_string(&mut username)?;
    Ok(username)
}

fn main() {
    match read_username_from_file("username.txt") {
        Ok(username) => println!("Username: {}", username),
        Err(e) => println!("Error: {}", e),
    }
}
```

### Unrecoverable errors

```rust
fn main() {
    // panic! macro
    // panic!("crash and burn");
    
    // Out of bounds access
    let v = vec![1, 2, 3];
    // v[99];  // Will panic
    
    // Better: use get()
    match v.get(99) {
        Some(val) => println!("Value: {}", val),
        None => println!("Index out of bounds"),
    }
}
```

**Backtrace:**

```bash
# Set RUST_BACKTRACE=1 to see backtrace
# RUST_BACKTRACE=1 cargo run
```

### Custom error types

```rust
use std::fmt;

#[derive(Debug)]
enum MathError {
    DivisionByZero,
    NegativeSquareRoot,
    Overflow,
}

impl fmt::Display for MathError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            MathError::DivisionByZero => write!(f, "Cannot divide by zero"),
            MathError::NegativeSquareRoot => {
                write!(f, "Cannot take square root of negative number")
            }
            MathError::Overflow => write!(f, "Arithmetic overflow"),
        }
    }
}

impl std::error::Error for MathError {}

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

### Error conversion

```rust
use std::fs::File;
use std::io::{self, Read};
use std::num::ParseIntError;

#[derive(Debug)]
enum AppError {
    Io(io::Error),
    Parse(ParseIntError),
}

impl fmt::Display for AppError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            AppError::Io(e) => write!(f, "IO error: {}", e),
            AppError::Parse(e) => write!(f, "Parse error: {}", e),
        }
    }
}

impl From<io::Error> for AppError {
    fn from(error: io::Error) -> Self {
        AppError::Io(error)
    }
}

impl From<ParseIntError> for AppError {
    fn from(error: ParseIntError) -> Self {
        AppError::Parse(error)
    }
}

fn read_number_from_file(filename: &str) -> Result<i32, AppError> {
    let mut file = File::open(filename)?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;
    let number = contents.trim().parse::<i32>()?;
    Ok(number)
}

fn main() {
    match read_number_from_file("number.txt") {
        Ok(number) => println!("Number: {}", number),
        Err(e) => println!("Error: {}", e),
    }
}
```

### Best practices

```rust
use std::error::Error;
use std::fs::File;

// Use Box<dyn Error> for flexibility
fn run() -> Result<(), Box<dyn Error>> {
    let file = File::open("data.txt")?;
    // More operations...
    Ok(())
}

fn main() {
    if let Err(e) = run() {
        eprintln!("Application error: {}", e);
        std::process::exit(1);
    }
}
```

---

## 🧑‍🏫 Bài 5: Testing

### Writing tests

```rust
#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
    
    #[test]
    fn another_test() {
        assert!(true);
    }
    
    #[test]
    #[should_panic]
    fn this_should_panic() {
        panic!("Make this test fail");
    }
}
```

**Testing a function:**

```rust
pub fn add_two(a: i32) -> i32 {
    a + 2
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_add_two() {
        assert_eq!(add_two(2), 4);
        assert_eq!(add_two(0), 2);
        assert_eq!(add_two(-2), 0);
    }
}
```

### Test organization

**Unit tests (same file):**

```rust
pub fn add(a: i32, b: i32) -> i32 {
    a + b
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_add() {
        assert_eq!(add(2, 3), 5);
    }
}
```

**Module tests:**

```rust
// src/lib.rs
pub mod math {
    pub fn multiply(a: i32, b: i32) -> i32 {
        a * b
    }
    
    #[cfg(test)]
    mod tests {
        use super::*;
        
        #[test]
        fn test_multiply() {
            assert_eq!(multiply(3, 4), 12);
        }
    }
}
```

### Running tests

```bash
# Run all tests
cargo test

# Run specific test
cargo test test_add

# Run tests matching pattern
cargo test add

# Show output even for passing tests
cargo test -- --show-output

# Run tests in sequence (not parallel)
cargo test -- --test-threads=1

# Run ignored tests
cargo test -- --ignored
```

### Test assertions

```rust
#[cfg(test)]
mod tests {
    #[test]
    fn test_assert() {
        assert!(true);
        // assert!(false);  // Fails
    }
    
    #[test]
    fn test_assert_eq() {
        assert_eq!(2 + 2, 4);
        // assert_eq!(2 + 2, 5);  // Fails
    }
    
    #[test]
    fn test_assert_ne() {
        assert_ne!(2 + 2, 5);
        // assert_ne!(2 + 2, 4);  // Fails
    }
    
    #[test]
    fn test_with_message() {
        let result = 2 + 2;
        assert_eq!(
            result, 
            4, 
            "Expected 4, but got {}", 
            result
        );
    }
    
    #[test]
    #[should_panic(expected = "divide by zero")]
    fn test_panic_message() {
        panic!("attempt to divide by zero");
    }
    
    #[test]
    fn test_result() -> Result<(), String> {
        if 2 + 2 == 4 {
            Ok(())
        } else {
            Err(String::from("two plus two does not equal four"))
        }
    }
    
    #[test]
    #[ignore]
    fn expensive_test() {
        // Takes a long time
    }
}
```

### Integration tests

**tests/integration_test.rs:**

```rust
use my_crate;

#[test]
fn test_integration() {
    assert_eq!(my_crate::add(2, 3), 5);
}
```

**tests/common/mod.rs (shared code):**

```rust
pub fn setup() {
    // Setup code
}
```

**tests/integration_test.rs:**

```rust
mod common;

#[test]
fn test_with_setup() {
    common::setup();
    // Test code
}
```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Contact Management System

### Mô tả bài toán

Xây dựng hệ thống quản lý danh bạ với các tính năng:

- Thêm/sửa/xóa contacts
- Search và filter
- Groups và tags
- Import/export JSON
- Error handling toàn diện
- Unit tests và integration tests

### Yêu cầu

**1. Data structures:**

```rust
use std::collections::HashMap;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Contact {
    pub id: u32,
    pub name: String,
    pub email: String,
    pub phone: String,
    pub address: Option<String>,
    pub tags: Vec<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Group {
    pub name: String,
    pub contact_ids: Vec<u32>,
}

pub struct ContactBook {
    contacts: HashMap<u32, Contact>,
    groups: HashMap<String, Group>,
    next_id: u32,
}
```

**2. Error handling:**

```rust
use std::fmt;
use std::io;

#[derive(Debug)]
pub enum ContactError {
    NotFound(u32),
    DuplicateEmail(String),
    InvalidEmail(String),
    InvalidPhone(String),
    IoError(io::Error),
    SerdeError(serde_json::Error),
}

impl fmt::Display for ContactError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            ContactError::NotFound(id) => write!(f, "Contact with ID {} not found", id),
            ContactError::DuplicateEmail(email) => {
                write!(f, "Contact with email {} already exists", email)
            }
            ContactError::InvalidEmail(email) => write!(f, "Invalid email: {}", email),
            ContactError::InvalidPhone(phone) => write!(f, "Invalid phone: {}", phone),
            ContactError::IoError(e) => write!(f, "IO error: {}", e),
            ContactError::SerdeError(e) => write!(f, "Serialization error: {}", e),
        }
    }
}

impl std::error::Error for ContactError {}

impl From<io::Error> for ContactError {
    fn from(error: io::Error) -> Self {
        ContactError::IoError(error)
    }
}

impl From<serde_json::Error> for ContactError {
    fn from(error: serde_json::Error) -> Self {
        ContactError::SerdeError(error)
    }
}
```

**3. Core functionality:**

```rust
impl ContactBook {
    pub fn new() -> Self;
    
    pub fn add_contact(&mut self, name: String, email: String, phone: String, 
                       address: Option<String>, tags: Vec<String>) 
                       -> Result<u32, ContactError>;
    
    pub fn get_contact(&self, id: u32) -> Result<&Contact, ContactError>;
    
    pub fn update_contact(&mut self, id: u32, name: Option<String>, 
                         email: Option<String>, phone: Option<String>,
                         address: Option<String>, tags: Option<Vec<String>>) 
                         -> Result<(), ContactError>;
    
    pub fn delete_contact(&mut self, id: u32) -> Result<Contact, ContactError>;
    
    pub fn search_by_name(&self, name: &str) -> Vec<&Contact>;
    
    pub fn search_by_tag(&self, tag: &str) -> Vec<&Contact>;
    
    pub fn create_group(&mut self, name: String) -> Result<(), ContactError>;
    
    pub fn add_to_group(&mut self, group_name: &str, contact_id: u32) 
                       -> Result<(), ContactError>;
    
    pub fn save_to_file(&self, filename: &str) -> Result<(), ContactError>;
    
    pub fn load_from_file(&mut self, filename: &str) -> Result<(), ContactError>;
}
```

**4. Validation:**

```rust
fn validate_email(email: &str) -> Result<(), ContactError> {
    if email.contains('@') && email.contains('.') {
        Ok(())
    } else {
        Err(ContactError::InvalidEmail(email.to_string()))
    }
}

fn validate_phone(phone: &str) -> Result<(), ContactError> {
    if phone.chars().filter(|c| c.is_numeric()).count() >= 10 {
        Ok(())
    } else {
        Err(ContactError::InvalidPhone(phone.to_string()))
    }
}
```

**Template code:**

```rust
use std::collections::HashMap;
use std::fs::File;
use std::io::{Read, Write};
use serde::{Deserialize, Serialize};
use std::fmt;
use std::io;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Contact {
    pub id: u32,
    pub name: String,
    pub email: String,
    pub phone: String,
    pub address: Option<String>,
    pub tags: Vec<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Group {
    pub name: String,
    pub contact_ids: Vec<u32>,
}

#[derive(Debug)]
pub enum ContactError {
    NotFound(u32),
    DuplicateEmail(String),
    InvalidEmail(String),
    InvalidPhone(String),
    GroupNotFound(String),
    IoError(io::Error),
    SerdeError(serde_json::Error),
}

impl fmt::Display for ContactError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            ContactError::NotFound(id) => write!(f, "Contact with ID {} not found", id),
            ContactError::DuplicateEmail(email) => {
                write!(f, "Contact with email {} already exists", email)
            }
            ContactError::InvalidEmail(email) => write!(f, "Invalid email: {}", email),
            ContactError::InvalidPhone(phone) => write!(f, "Invalid phone: {}", phone),
            ContactError::GroupNotFound(name) => write!(f, "Group '{}' not found", name),
            ContactError::IoError(e) => write!(f, "IO error: {}", e),
            ContactError::SerdeError(e) => write!(f, "Serialization error: {}", e),
        }
    }
}

impl std::error::Error for ContactError {}

impl From<io::Error> for ContactError {
    fn from(error: io::Error) -> Self {
        ContactError::IoError(error)
    }
}

impl From<serde_json::Error> for ContactError {
    fn from(error: serde_json::Error) -> Self {
        ContactError::SerdeError(error)
    }
}

pub struct ContactBook {
    contacts: HashMap<u32, Contact>,
    groups: HashMap<String, Group>,
    next_id: u32,
}

impl ContactBook {
    pub fn new() -> Self {
        ContactBook {
            contacts: HashMap::new(),
            groups: HashMap::new(),
            next_id: 1,
        }
    }
    
    fn validate_email(email: &str) -> Result<(), ContactError> {
        if email.contains('@') && email.contains('.') {
            Ok(())
        } else {
            Err(ContactError::InvalidEmail(email.to_string()))
        }
    }
    
    fn validate_phone(phone: &str) -> Result<(), ContactError> {
        let digit_count = phone.chars().filter(|c| c.is_numeric()).count();
        if digit_count >= 10 {
            Ok(())
        } else {
            Err(ContactError::InvalidPhone(phone.to_string()))
        }
    }
    
    pub fn add_contact(
        &mut self, 
        name: String, 
        email: String, 
        phone: String,
        address: Option<String>,
        tags: Vec<String>
    ) -> Result<u32, ContactError> {
        // Validate
        Self::validate_email(&email)?;
        Self::validate_phone(&phone)?;
        
        // Check duplicate email
        for contact in self.contacts.values() {
            if contact.email == email {
                return Err(ContactError::DuplicateEmail(email));
            }
        }
        
        let id = self.next_id;
        let contact = Contact {
            id,
            name,
            email,
            phone,
            address,
            tags,
        };
        
        self.contacts.insert(id, contact);
        self.next_id += 1;
        
        Ok(id)
    }
    
    pub fn get_contact(&self, id: u32) -> Result<&Contact, ContactError> {
        self.contacts.get(&id).ok_or(ContactError::NotFound(id))
    }
    
    pub fn delete_contact(&mut self, id: u32) -> Result<Contact, ContactError> {
        self.contacts.remove(&id).ok_or(ContactError::NotFound(id))
    }
    
    pub fn search_by_name(&self, name: &str) -> Vec<&Contact> {
        let name_lower = name.to_lowercase();
        self.contacts
            .values()
            .filter(|c| c.name.to_lowercase().contains(&name_lower))
            .collect()
    }
    
    pub fn search_by_tag(&self, tag: &str) -> Vec<&Contact> {
        self.contacts
            .values()
            .filter(|c| c.tags.iter().any(|t| t == tag))
            .collect()
    }
    
    pub fn list_all(&self) -> Vec<&Contact> {
        self.contacts.values().collect()
    }
    
    pub fn create_group(&mut self, name: String) -> Result<(), ContactError> {
        let group = Group {
            name: name.clone(),
            contact_ids: Vec::new(),
        };
        self.groups.insert(name, group);
        Ok(())
    }
    
    pub fn add_to_group(&mut self, group_name: &str, contact_id: u32) 
                       -> Result<(), ContactError> {
        // Check contact exists
        if !self.contacts.contains_key(&contact_id) {
            return Err(ContactError::NotFound(contact_id));
        }
        
        let group = self.groups
            .get_mut(group_name)
            .ok_or_else(|| ContactError::GroupNotFound(group_name.to_string()))?;
        
        if !group.contact_ids.contains(&contact_id) {
            group.contact_ids.push(contact_id);
        }
        
        Ok(())
    }
    
    pub fn save_to_file(&self, filename: &str) -> Result<(), ContactError> {
        let json = serde_json::to_string_pretty(&self.contacts)?;
        let mut file = File::create(filename)?;
        file.write_all(json.as_bytes())?;
        Ok(())
    }
    
    pub fn load_from_file(&mut self, filename: &str) -> Result<(), ContactError> {
        let mut file = File::open(filename)?;
        let mut contents = String::new();
        file.read_to_string(&mut contents)?;
        
        let contacts: HashMap<u32, Contact> = serde_json::from_str(&contents)?;
        self.contacts = contacts;
        
        // Update next_id
        if let Some(&max_id) = self.contacts.keys().max() {
            self.next_id = max_id + 1;
        }
        
        Ok(())
    }
}

// Tests
#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_add_contact() {
        let mut book = ContactBook::new();
        let id = book.add_contact(
            "Alice".to_string(),
            "alice@example.com".to_string(),
            "1234567890".to_string(),
            None,
            vec!["friend".to_string()],
        ).unwrap();
        
        assert_eq!(id, 1);
        assert_eq!(book.contacts.len(), 1);
    }
    
    #[test]
    fn test_invalid_email() {
        let mut book = ContactBook::new();
        let result = book.add_contact(
            "Bob".to_string(),
            "invalid-email".to_string(),
            "1234567890".to_string(),
            None,
            vec![],
        );
        
        assert!(result.is_err());
    }
    
    #[test]
    fn test_duplicate_email() {
        let mut book = ContactBook::new();
        
        book.add_contact(
            "Alice".to_string(),
            "alice@example.com".to_string(),
            "1234567890".to_string(),
            None,
            vec![],
        ).unwrap();
        
        let result = book.add_contact(
            "Bob".to_string(),
            "alice@example.com".to_string(),
            "0987654321".to_string(),
            None,
            vec![],
        );
        
        assert!(matches!(result, Err(ContactError::DuplicateEmail(_))));
    }
    
    #[test]
    fn test_search_by_name() {
        let mut book = ContactBook::new();
        
        book.add_contact(
            "Alice Smith".to_string(),
            "alice@example.com".to_string(),
            "1234567890".to_string(),
            None,
            vec![],
        ).unwrap();
        
        book.add_contact(
            "Bob Jones".to_string(),
            "bob@example.com".to_string(),
            "0987654321".to_string(),
            None,
            vec![],
        ).unwrap();
        
        let results = book.search_by_name("Alice");
        assert_eq!(results.len(), 1);
        assert_eq!(results[0].name, "Alice Smith");
    }
    
    #[test]
    fn test_groups() {
        let mut book = ContactBook::new();
        
        let id = book.add_contact(
            "Alice".to_string(),
            "alice@example.com".to_string(),
            "1234567890".to_string(),
            None,
            vec![],
        ).unwrap();
        
        book.create_group("Friends".to_string()).unwrap();
        book.add_to_group("Friends", id).unwrap();
        
        let group = book.groups.get("Friends").unwrap();
        assert_eq!(group.contact_ids.len(), 1);
        assert_eq!(group.contact_ids[0], id);
    }
}

fn main() {
    let mut book = ContactBook::new();
    
    // Add contacts
    match book.add_contact(
        "Alice Johnson".to_string(),
        "alice@example.com".to_string(),
        "555-1234".to_string(),
        Some("123 Main St".to_string()),
        vec!["friend".to_string(), "work".to_string()],
    ) {
        Ok(id) => println!("Added contact with ID: {}", id),
        Err(e) => println!("Error: {}", e),
    }
    
    match book.add_contact(
        "Bob Smith".to_string(),
        "bob@example.com".to_string(),
        "555-5678".to_string(),
        None,
        vec!["family".to_string()],
    ) {
        Ok(id) => println!("Added contact with ID: {}", id),
        Err(e) => println!("Error: {}", e),
    }
    
    // List all
    println!("\nAll contacts:");
    for contact in book.list_all() {
        println!("{}: {} - {}", contact.id, contact.name, contact.email);
    }
    
    // Search
    println!("\nSearch 'Alice':");
    for contact in book.search_by_name("Alice") {
        println!("{}: {}", contact.id, contact.name);
    }
    
    // Save to file
    match book.save_to_file("contacts.json") {
        Ok(_) => println!("\nSaved to contacts.json"),
        Err(e) => println!("Error saving: {}", e),
    }
    
    // TODO: Implement remaining features
}
```

**Yêu cầu mở rộng:**

1. **Advanced search:**
   - Search by email, phone
   - Regex search
   - Multiple criteria
   - Sort results

2. **Contact updates:**
   - Update individual fields
   - Merge contacts
   - Batch operations

3. **Group management:**
   - Remove from group
   - Delete group
   - List group members
   - Group statistics

4. **Import/Export:**
   - CSV format support
   - vCard format
   - Backup/restore
   - Data migration

5. **Statistics:**
   - Total contacts
   - Contacts per tag
   - Most used tags
   - Growth over time

6. **CLI interface:**
   - Interactive menu
   - Command line arguments
   - Pretty formatting
   - Help system
