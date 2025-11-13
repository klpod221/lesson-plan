# 📘 PHẦN 5: TRAITS VÀ GENERICS

## 🎯 Mục tiêu tổng quát

- Master trait definitions và implementations
- Generic programming với type parameters
- Understand trait bounds và where clauses
- Work with trait objects và dynamic dispatch
- Implement common standard library traits
- Build flexible, reusable code with generics
- Create type-safe abstractions

## 🧑‍🏫 Bài 1: Traits cơ bản

### Defining traits

```rust
pub trait Summary {
    fn summarize(&self) -> String;
}
```

### Implementing traits

```rust
pub struct NewsArticle {
    pub headline: String,
    pub location: String,
    pub author: String,
    pub content: String,
}

impl Summary for NewsArticle {
    fn summarize(&self) -> String {
        format!("{}, by {} ({})", self.headline, self.author, self.location)
    }
}

pub struct Tweet {
    pub username: String,
    pub content: String,
    pub reply: bool,
    pub retweet: bool,
}

impl Summary for Tweet {
    fn summarize(&self) -> String {
        format!("{}: {}", self.username, self.content)
    }
}

fn main() {
    let article = NewsArticle {
        headline: String::from("Rust 2.0 Released"),
        location: String::from("San Francisco"),
        author: String::from("John Doe"),
        content: String::from("The Rust team is excited to announce..."),
    };
    
    let tweet = Tweet {
        username: String::from("rust_lang"),
        content: String::from("Announcing Rust 2.0!"),
        reply: false,
        retweet: false,
    };
    
    println!("Article: {}", article.summarize());
    println!("Tweet: {}", tweet.summarize());
}
```

### Default implementations

```rust
pub trait Summary {
    fn summarize_author(&self) -> String;
    
    fn summarize(&self) -> String {
        format!("(Read more from {}...)", self.summarize_author())
    }
}

impl Summary for Tweet {
    fn summarize_author(&self) -> String {
        format!("@{}", self.username)
    }
    
    // Can override default or use it
}

fn main() {
    let tweet = Tweet {
        username: String::from("rust_lang"),
        content: String::from("Announcing Rust 2.0!"),
        reply: false,
        retweet: false,
    };
    
    println!("{}", tweet.summarize());
}
```

### Trait bounds

```rust
pub fn notify(item: &impl Summary) {
    println!("Breaking news! {}", item.summarize());
}

// Equivalent to:
pub fn notify2<T: Summary>(item: &T) {
    println!("Breaking news! {}", item.summarize());
}

fn main() {
    let article = NewsArticle {
        headline: String::from("Rust 2.0 Released"),
        location: String::from("SF"),
        author: String::from("John"),
        content: String::from("..."),
    };
    
    notify(&article);
}
```

### Multiple traits

```rust
use std::fmt::{Display, Debug};

pub fn notify(item: &(impl Summary + Display)) {
    println!("Breaking news! {}", item.summarize());
}

// With generics
pub fn notify2<T: Summary + Display>(item: &T) {
    println!("Breaking news! {}", item.summarize());
}

// Where clause (cleaner)
pub fn some_function<T, U>(t: &T, u: &U) -> i32
where
    T: Display + Clone,
    U: Clone + Debug,
{
    // Function body
    0
}
```

**Returning traits:**

```rust
fn returns_summarizable() -> impl Summary {
    Tweet {
        username: String::from("rust_lang"),
        content: String::from("Rust is awesome!"),
        reply: false,
        retweet: false,
    }
}

// Can only return one type!
// This won't work:
// fn returns_summarizable(switch: bool) -> impl Summary {
//     if switch {
//         NewsArticle { ... }
//     } else {
//         Tweet { ... }  // ERROR: different types
//     }
// }
```

## 🧑‍🏫 Bài 2: Generic Types

### Generic functions

```rust
fn largest<T: PartialOrd>(list: &[T]) -> &T {
    let mut largest = &list[0];
    
    for item in list {
        if item > largest {
            largest = item;
        }
    }
    
    largest
}

fn main() {
    let numbers = vec![34, 50, 25, 100, 65];
    println!("Largest: {}", largest(&numbers));
    
    let chars = vec!['y', 'm', 'a', 'q'];
    println!("Largest: {}", largest(&chars));
}
```

### Generic structs

```rust
#[derive(Debug)]
struct Point<T> {
    x: T,
    y: T,
}

impl<T> Point<T> {
    fn x(&self) -> &T {
        &self.x
    }
}

// Specific implementation for f32
impl Point<f32> {
    fn distance_from_origin(&self) -> f32 {
        (self.x.powi(2) + self.y.powi(2)).sqrt()
    }
}

fn main() {
    let integer = Point { x: 5, y: 10 };
    let float = Point { x: 1.0, y: 4.0 };
    
    println!("{:?}", integer);
    println!("Distance: {}", float.distance_from_origin());
}
```

**Multiple type parameters:**

```rust
#[derive(Debug)]
struct Point<T, U> {
    x: T,
    y: U,
}

fn main() {
    let both_integer = Point { x: 5, y: 10 };
    let both_float = Point { x: 1.0, y: 4.0 };
    let integer_and_float = Point { x: 5, y: 4.0 };
    
    println!("{:?}", integer_and_float);
}
```

### Generic enums

```rust
enum Option<T> {
    Some(T),
    None,
}

enum Result<T, E> {
    Ok(T),
    Err(E),
}
```

### Generic methods

```rust
struct Point<T> {
    x: T,
    y: T,
}

impl<T> Point<T> {
    fn new(x: T, y: T) -> Self {
        Point { x, y }
    }
}

impl<T, U> Point<T, U> {
    fn mixup<V, W>(self, other: Point<V, W>) -> Point<T, W> {
        Point {
            x: self.x,
            y: other.y,
        }
    }
}

fn main() {
    let p1 = Point::new(5, 10);
    let p2 = Point { x: "Hello", y: 'c' };
    
    let p3 = p1.mixup(p2);
    println!("p3.x = {}, p3.y = {}", p3.x, p3.y);
}
```

### Constraints

```rust
use std::fmt::Display;

struct Pair<T> {
    x: T,
    y: T,
}

impl<T> Pair<T> {
    fn new(x: T, y: T) -> Self {
        Self { x, y }
    }
}

impl<T: Display + PartialOrd> Pair<T> {
    fn cmp_display(&self) {
        if self.x >= self.y {
            println!("The largest member is x = {}", self.x);
        } else {
            println!("The largest member is y = {}", self.y);
        }
    }
}

fn main() {
    let pair = Pair::new(10, 20);
    pair.cmp_display();
}
```

## 🧑‍🏫 Bài 3: Advanced Traits

### Associated types

```rust
pub trait Iterator {
    type Item;  // Associated type
    
    fn next(&mut self) -> Option<Self::Item>;
}

struct Counter {
    count: u32,
}

impl Iterator for Counter {
    type Item = u32;
    
    fn next(&mut self) -> Option<Self::Item> {
        self.count += 1;
        
        if self.count < 6 {
            Some(self.count)
        } else {
            None
        }
    }
}

fn main() {
    let mut counter = Counter { count: 0 };
    
    while let Some(value) = counter.next() {
        println!("{}", value);
    }
}
```

### Operator overloading

```rust
use std::ops::Add;

#[derive(Debug, PartialEq)]
struct Point {
    x: i32,
    y: i32,
}

impl Add for Point {
    type Output = Point;
    
    fn add(self, other: Point) -> Point {
        Point {
            x: self.x + other.x,
            y: self.y + other.y,
        }
    }
}

fn main() {
    let p1 = Point { x: 1, y: 2 };
    let p2 = Point { x: 3, y: 4 };
    
    let p3 = p1 + p2;
    println!("{:?}", p3);
}
```

**Generic Add:**

```rust
use std::ops::Add;

#[derive(Debug)]
struct Millimeters(u32);
struct Meters(u32);

impl Add<Meters> for Millimeters {
    type Output = Millimeters;
    
    fn add(self, other: Meters) -> Millimeters {
        Millimeters(self.0 + (other.0 * 1000))
    }
}

fn main() {
    let mm = Millimeters(1000);
    let m = Meters(2);
    
    let total = mm + m;
    println!("{:?}", total);
}
```

### Supertraits

```rust
use std::fmt;

trait OutlinePrint: fmt::Display {
    fn outline_print(&self) {
        let output = self.to_string();
        let len = output.len();
        println!("{}", "*".repeat(len + 4));
        println!("*{}*", " ".repeat(len + 2));
        println!("* {} *", output);
        println!("*{}*", " ".repeat(len + 2));
        println!("{}", "*".repeat(len + 4));
    }
}

struct Point {
    x: i32,
    y: i32,
}

impl fmt::Display for Point {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "({}, {})", self.x, self.y)
    }
}

impl OutlinePrint for Point {}

fn main() {
    let p = Point { x: 1, y: 3 };
    p.outline_print();
}
```

### Trait objects

```rust
pub trait Draw {
    fn draw(&self);
}

pub struct Button {
    pub width: u32,
    pub height: u32,
    pub label: String,
}

impl Draw for Button {
    fn draw(&self) {
        println!("Drawing button: {}", self.label);
    }
}

pub struct SelectBox {
    pub width: u32,
    pub height: u32,
    pub options: Vec<String>,
}

impl Draw for SelectBox {
    fn draw(&self) {
        println!("Drawing select box with {} options", self.options.len());
    }
}

pub struct Screen {
    pub components: Vec<Box<dyn Draw>>,
}

impl Screen {
    pub fn run(&self) {
        for component in self.components.iter() {
            component.draw();
        }
    }
}

fn main() {
    let screen = Screen {
        components: vec![
            Box::new(Button {
                width: 50,
                height: 10,
                label: String::from("OK"),
            }),
            Box::new(SelectBox {
                width: 75,
                height: 10,
                options: vec![
                    String::from("Yes"),
                    String::from("No"),
                ],
            }),
        ],
    };
    
    screen.run();
}
```

### Dynamic dispatch

```rust
// Static dispatch (compile-time)
fn static_dispatch<T: Draw>(item: &T) {
    item.draw();
}

// Dynamic dispatch (runtime)
fn dynamic_dispatch(item: &dyn Draw) {
    item.draw();
}

// Trait object in return position
fn get_drawable(choice: bool) -> Box<dyn Draw> {
    if choice {
        Box::new(Button {
            width: 50,
            height: 10,
            label: String::from("OK"),
        })
    } else {
        Box::new(SelectBox {
            width: 75,
            height: 10,
            options: vec![String::from("Yes")],
        })
    }
}
```

## 🧑‍🏫 Bài 4: Lifetimes với Generics

### Generic lifetime parameters

```rust
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}

fn main() {
    let string1 = String::from("long string is long");
    
    {
        let string2 = String::from("xyz");
        let result = longest(string1.as_str(), string2.as_str());
        println!("Longest: {}", result);
    }
}
```

### Lifetime bounds

```rust
use std::fmt::Display;

fn longest_with_announcement<'a, T>(
    x: &'a str,
    y: &'a str,
    ann: T,
) -> &'a str
where
    T: Display,
{
    println!("Announcement! {}", ann);
    if x.len() > y.len() {
        x
    } else {
        y
    }
}

fn main() {
    let s1 = "hello";
    let s2 = "world";
    
    let result = longest_with_announcement(s1, s2, "Comparing strings");
    println!("Longest: {}", result);
}
```

### Struct lifetimes

```rust
#[derive(Debug)]
struct ImportantExcerpt<'a> {
    part: &'a str,
}

impl<'a> ImportantExcerpt<'a> {
    fn level(&self) -> i32 {
        3
    }
    
    fn announce_and_return_part(&self, announcement: &str) -> &str {
        println!("Attention: {}", announcement);
        self.part
    }
}

fn main() {
    let novel = String::from("Call me Ishmael. Some years ago...");
    let first_sentence = novel.split('.').next().expect("Could not find a '.'");
    
    let excerpt = ImportantExcerpt {
        part: first_sentence,
    };
    
    println!("{:?}", excerpt);
    println!("Level: {}", excerpt.level());
}
```

### Static lifetime

```rust
fn main() {
    // String literals have 'static lifetime
    let s: &'static str = "I have a static lifetime.";
    
    println!("{}", s);
}
```

## 🧑‍🏫 Bài 5: Common Traits

### Debug và Display

```rust
use std::fmt;

#[derive(Debug)]
struct Point {
    x: i32,
    y: i32,
}

impl fmt::Display for Point {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "({}, {})", self.x, self.y)
    }
}

fn main() {
    let p = Point { x: 3, y: 4 };
    
    println!("{:?}", p);      // Debug
    println!("{:#?}", p);     // Pretty Debug
    println!("{}", p);        // Display
}
```

### Clone và Copy

```rust
#[derive(Clone, Debug)]
struct Person {
    name: String,
    age: u8,
}

#[derive(Copy, Clone, Debug)]
struct Point {
    x: i32,
    y: i32,
}

fn main() {
    let person1 = Person {
        name: String::from("Alice"),
        age: 30,
    };
    
    let person2 = person1.clone();
    println!("{:?}", person1);  // Still valid
    println!("{:?}", person2);
    
    let p1 = Point { x: 1, y: 2 };
    let p2 = p1;  // Copy
    println!("{:?}", p1);  // Still valid
    println!("{:?}", p2);
}
```

### Iterator

```rust
struct Counter {
    count: u32,
}

impl Counter {
    fn new() -> Counter {
        Counter { count: 0 }
    }
}

impl Iterator for Counter {
    type Item = u32;
    
    fn next(&mut self) -> Option<Self::Item> {
        if self.count < 5 {
            self.count += 1;
            Some(self.count)
        } else {
            None
        }
    }
}

fn main() {
    let mut counter = Counter::new();
    
    while let Some(val) = counter.next() {
        println!("{}", val);
    }
    
    // Or use for loop
    for val in Counter::new() {
        println!("{}", val);
    }
    
    // Chain iterator methods
    let sum: u32 = Counter::new()
        .zip(Counter::new().skip(1))
        .map(|(a, b)| a * b)
        .filter(|x| x % 3 == 0)
        .sum();
    
    println!("Sum: {}", sum);
}
```

### From và Into

```rust
#[derive(Debug)]
struct Number {
    value: i32,
}

impl From<i32> for Number {
    fn from(item: i32) -> Self {
        Number { value: item }
    }
}

fn main() {
    let num = Number::from(30);
    println!("{:?}", num);
    
    // Into automatically available
    let num: Number = 40.into();
    println!("{:?}", num);
}
```

**String conversions:**

```rust
fn main() {
    let my_str = "hello";
    let my_string = String::from(my_str);
    
    let my_string2: String = my_str.into();
    
    println!("{}", my_string);
    println!("{}", my_string2);
}
```

### Drop

```rust
struct CustomSmartPointer {
    data: String,
}

impl Drop for CustomSmartPointer {
    fn drop(&mut self) {
        println!("Dropping CustomSmartPointer with data `{}`!", self.data);
    }
}

fn main() {
    let c = CustomSmartPointer {
        data: String::from("my stuff"),
    };
    
    let d = CustomSmartPointer {
        data: String::from("other stuff"),
    };
    
    println!("CustomSmartPointers created.");
    
    // Explicit drop
    drop(c);
    println!("CustomSmartPointer dropped before end of main.");
    
    // d dropped automatically at end of scope
}
```

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Generic Data Processing Library

### Mô tả bài toán

Xây dựng thư viện xử lý dữ liệu generic với:

- Generic data structures (List, Stack, Queue)
- Data transformations (Map, Filter, Reduce)
- Statistical operations
- Custom iterators
- Trait-based polymorphism
- Type-safe operations

### Yêu cầu

**1. Generic data structures:**

```rust
pub trait Collection<T> {
    fn add(&mut self, item: T);
    fn remove(&mut self) -> Option<T>;
    fn is_empty(&self) -> bool;
    fn size(&self) -> usize;
}

pub struct Stack<T> {
    items: Vec<T>,
}

pub struct Queue<T> {
    items: Vec<T>,
}

pub struct List<T> {
    items: Vec<T>,
}
```

**2. Data transformation traits:**

```rust
pub trait Transformable<T> {
    fn map<F, U>(self, f: F) -> Vec<U>
    where
        F: FnMut(T) -> U;
    
    fn filter<F>(self, predicate: F) -> Vec<T>
    where
        F: FnMut(&T) -> bool;
    
    fn reduce<F>(self, initial: T, f: F) -> T
    where
        F: FnMut(T, T) -> T;
}

impl<T> Transformable<T> for Vec<T> {
    // Implement methods
}
```

**3. Statistical operations:**

```rust
pub trait Statistics {
    fn mean(&self) -> f64;
    fn median(&self) -> f64;
    fn mode(&self) -> Vec<Self>
    where
        Self: Sized;
    fn std_dev(&self) -> f64;
}

impl Statistics for Vec<f64> {
    // Implement for numeric types
}
```

**4. Custom iterator:**

```rust
pub struct RangeIterator<T> {
    current: T,
    end: T,
    step: T,
}

impl<T> Iterator for RangeIterator<T>
where
    T: Copy + PartialOrd + std::ops::Add<Output = T>,
{
    type Item = T;
    
    fn next(&mut self) -> Option<Self::Item> {
        // Implement
    }
}
```

**Template code:**

```rust
use std::fmt::{Debug, Display};
use std::ops::{Add, Div};
use std::collections::HashMap;

// ============ Collection Trait ============
pub trait Collection<T> {
    fn add(&mut self, item: T);
    fn remove(&mut self) -> Option<T>;
    fn is_empty(&self) -> bool;
    fn size(&self) -> usize;
    fn clear(&mut self);
}

// ============ Stack ============
#[derive(Debug)]
pub struct Stack<T> {
    items: Vec<T>,
}

impl<T> Stack<T> {
    pub fn new() -> Self {
        Stack { items: Vec::new() }
    }
    
    pub fn peek(&self) -> Option<&T> {
        self.items.last()
    }
}

impl<T> Collection<T> for Stack<T> {
    fn add(&mut self, item: T) {
        self.items.push(item);
    }
    
    fn remove(&mut self) -> Option<T> {
        self.items.pop()
    }
    
    fn is_empty(&self) -> bool {
        self.items.is_empty()
    }
    
    fn size(&self) -> usize {
        self.items.len()
    }
    
    fn clear(&mut self) {
        self.items.clear();
    }
}

// ============ Queue ============
#[derive(Debug)]
pub struct Queue<T> {
    items: Vec<T>,
}

impl<T> Queue<T> {
    pub fn new() -> Self {
        Queue { items: Vec::new() }
    }
    
    pub fn peek(&self) -> Option<&T> {
        self.items.first()
    }
}

impl<T> Collection<T> for Queue<T> {
    fn add(&mut self, item: T) {
        self.items.push(item);
    }
    
    fn remove(&mut self) -> Option<T> {
        if self.items.is_empty() {
            None
        } else {
            Some(self.items.remove(0))
        }
    }
    
    fn is_empty(&self) -> bool {
        self.items.is_empty()
    }
    
    fn size(&self) -> usize {
        self.items.len()
    }
    
    fn clear(&mut self) {
        self.items.clear();
    }
}

// ============ Transformable Trait ============
pub trait Transformable<T> {
    fn transform_map<F, U>(self, f: F) -> Vec<U>
    where
        F: FnMut(T) -> U;
    
    fn transform_filter<F>(self, predicate: F) -> Vec<T>
    where
        F: FnMut(&T) -> bool;
}

impl<T> Transformable<T> for Vec<T> {
    fn transform_map<F, U>(self, mut f: F) -> Vec<U>
    where
        F: FnMut(T) -> U,
    {
        let mut result = Vec::new();
        for item in self {
            result.push(f(item));
        }
        result
    }
    
    fn transform_filter<F>(self, mut predicate: F) -> Vec<T>
    where
        F: FnMut(&T) -> bool,
    {
        let mut result = Vec::new();
        for item in self {
            if predicate(&item) {
                result.push(item);
            }
        }
        result
    }
}

// ============ Statistics Trait ============
pub trait Statistics {
    fn mean(&self) -> f64;
    fn median(&self) -> f64;
    fn std_dev(&self) -> f64;
    fn min(&self) -> f64;
    fn max(&self) -> f64;
}

impl Statistics for Vec<f64> {
    fn mean(&self) -> f64 {
        if self.is_empty() {
            return 0.0;
        }
        self.iter().sum::<f64>() / self.len() as f64
    }
    
    fn median(&self) -> f64 {
        if self.is_empty() {
            return 0.0;
        }
        
        let mut sorted = self.clone();
        sorted.sort_by(|a, b| a.partial_cmp(b).unwrap());
        
        let mid = sorted.len() / 2;
        if sorted.len() % 2 == 0 {
            (sorted[mid - 1] + sorted[mid]) / 2.0
        } else {
            sorted[mid]
        }
    }
    
    fn std_dev(&self) -> f64 {
        if self.is_empty() {
            return 0.0;
        }
        
        let mean = self.mean();
        let variance = self.iter()
            .map(|x| (x - mean).powi(2))
            .sum::<f64>() / self.len() as f64;
        
        variance.sqrt()
    }
    
    fn min(&self) -> f64 {
        self.iter()
            .copied()
            .min_by(|a, b| a.partial_cmp(b).unwrap())
            .unwrap_or(0.0)
    }
    
    fn max(&self) -> f64 {
        self.iter()
            .copied()
            .max_by(|a, b| a.partial_cmp(b).unwrap())
            .unwrap_or(0.0)
    }
}

// ============ Custom Iterator ============
pub struct RangeIterator<T> {
    current: T,
    end: T,
    step: T,
}

impl<T> RangeIterator<T> {
    pub fn new(start: T, end: T, step: T) -> Self {
        RangeIterator {
            current: start,
            end,
            step,
        }
    }
}

impl<T> Iterator for RangeIterator<T>
where
    T: Copy + PartialOrd + Add<Output = T>,
{
    type Item = T;
    
    fn next(&mut self) -> Option<Self::Item> {
        if self.current < self.end {
            let result = self.current;
            self.current = self.current + self.step;
            Some(result)
        } else {
            None
        }
    }
}

// ============ Pair struct for combining types ============
#[derive(Debug, Clone)]
pub struct Pair<T, U> {
    pub first: T,
    pub second: U,
}

impl<T, U> Pair<T, U> {
    pub fn new(first: T, second: U) -> Self {
        Pair { first, second }
    }
    
    pub fn swap(self) -> Pair<U, T> {
        Pair {
            first: self.second,
            second: self.first,
        }
    }
}

impl<T: Display, U: Display> Display for Pair<T, U> {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(f, "({}, {})", self.first, self.second)
    }
}

// ============ Tests ============
#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_stack() {
        let mut stack = Stack::new();
        stack.add(1);
        stack.add(2);
        stack.add(3);
        
        assert_eq!(stack.size(), 3);
        assert_eq!(stack.remove(), Some(3));
        assert_eq!(stack.remove(), Some(2));
    }
    
    #[test]
    fn test_queue() {
        let mut queue = Queue::new();
        queue.add(1);
        queue.add(2);
        queue.add(3);
        
        assert_eq!(queue.remove(), Some(1));
        assert_eq!(queue.remove(), Some(2));
    }
    
    #[test]
    fn test_transformable() {
        let numbers = vec![1, 2, 3, 4, 5];
        
        let doubled = numbers.clone().transform_map(|x| x * 2);
        assert_eq!(doubled, vec![2, 4, 6, 8, 10]);
        
        let evens = numbers.transform_filter(|x| x % 2 == 0);
        assert_eq!(evens, vec![2, 4]);
    }
    
    #[test]
    fn test_statistics() {
        let numbers = vec![1.0, 2.0, 3.0, 4.0, 5.0];
        
        assert_eq!(numbers.mean(), 3.0);
        assert_eq!(numbers.median(), 3.0);
        assert_eq!(numbers.min(), 1.0);
        assert_eq!(numbers.max(), 5.0);
    }
    
    #[test]
    fn test_range_iterator() {
        let range = RangeIterator::new(0, 10, 2);
        let values: Vec<i32> = range.collect();
        
        assert_eq!(values, vec![0, 2, 4, 6, 8]);
    }
}

// ============ Example Usage ============
fn main() {
    println!("=== Stack Example ===");
    let mut stack = Stack::new();
    stack.add(1);
    stack.add(2);
    stack.add(3);
    
    println!("Stack size: {}", stack.size());
    while let Some(item) = stack.remove() {
        println!("Popped: {}", item);
    }
    
    println!("\n=== Queue Example ===");
    let mut queue = Queue::new();
    queue.add("first");
    queue.add("second");
    queue.add("third");
    
    while let Some(item) = queue.remove() {
        println!("Dequeued: {}", item);
    }
    
    println!("\n=== Transformations ===");
    let numbers = vec![1, 2, 3, 4, 5];
    
    let squared = numbers.clone().transform_map(|x| x * x);
    println!("Squared: {:?}", squared);
    
    let evens = numbers.clone().transform_filter(|x| x % 2 == 0);
    println!("Evens: {:?}", evens);
    
    println!("\n=== Statistics ===");
    let data = vec![1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0];
    println!("Mean: {:.2}", data.mean());
    println!("Median: {:.2}", data.median());
    println!("Std Dev: {:.2}", data.std_dev());
    println!("Min: {:.2}", data.min());
    println!("Max: {:.2}", data.max());
    
    println!("\n=== Custom Iterator ===");
    let range = RangeIterator::new(0.0, 5.0, 0.5);
    for value in range {
        println!("{:.1}", value);
    }
    
    println!("\n=== Pair Example ===");
    let pair = Pair::new("Hello", 42);
    println!("Pair: {}", pair);
    
    let swapped = pair.clone().swap();
    println!("Swapped: {} {}", swapped.first, swapped.second);
}
```

**Yêu cầu mở rộng:**

1. **Additional data structures:**
   - Binary tree
   - Hash table
   - Linked list
   - Priority queue

2. **More transformations:**
   - FlatMap
   - Take/Skip
   - Zip
   - Partition
   - Group by

3. **Advanced statistics:**
   - Percentiles
   - Correlation
   - Regression
   - Moving averages

4. **Parallel processing:**
   - Parallel map/filter
   - Thread pool
   - Work stealing

5. **Serialization:**
   - JSON support
   - CSV export
   - Binary format

6. **Visualization:**
   - ASCII charts
   - Data export for plotting
   - Summary reports
