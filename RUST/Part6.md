# 📘 PHẦN 6: ADVANCED TOPICS

- [📘 PHẦN 6: ADVANCED TOPICS](#-phần-6-advanced-topics)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Concurrency](#-bài-1-concurrency)
    - [Threads](#threads)
    - [Message passing](#message-passing)
    - [Shared state](#shared-state)
    - [Sync và Send traits](#sync-và-send-traits)
  - [🧑‍🏫 Bài 2: Async/Await](#-bài-2-asyncawait)
    - [Async basics](#async-basics)
    - [Futures](#futures)
    - [Async runtime](#async-runtime)
    - [Tokio framework](#tokio-framework)
  - [🧑‍🏫 Bài 3: Macros](#-bài-3-macros)
    - [Declarative macros](#declarative-macros)
    - [Procedural macros](#procedural-macros)
    - [Custom derive](#custom-derive)
  - [🧑‍🏫 Bài 4: Unsafe Rust](#-bài-4-unsafe-rust)
    - [Unsafe superpowers](#unsafe-superpowers)
    - [Raw pointers](#raw-pointers)
    - [Unsafe functions](#unsafe-functions)
    - [FFI](#ffi)
  - [🧑‍🏫 Bài 5: Advanced Patterns](#-bài-5-advanced-patterns)
    - [Smart pointers](#smart-pointers)
    - [Interior mutability](#interior-mutability)
    - [Type aliases](#type-aliases)
    - [Never type](#never-type)
    - [Function pointers](#function-pointers)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN: Concurrent Web Scraper](#-bài-tập-lớn-cuối-phần-concurrent-web-scraper)
    - [Mô tả bài toán](#mô-tả-bài-toán)
    - [Yêu cầu](#yêu-cầu)

## 🎯 Mục tiêu tổng quát

- Master concurrent programming với threads
- Async/await và asynchronous programming
- Macro programming for code generation
- Understand unsafe Rust và FFI
- Advanced type system features
- Build high-performance concurrent applications
- Real-world async web scraping project

---

## 🧑‍🏫 Bài 1: Concurrency

### Threads

```rust
use std::thread;
use std::time::Duration;

fn main() {
    let handle = thread::spawn(|| {
        for i in 1..10 {
            println!("Number {} from spawned thread", i);
            thread::sleep(Duration::from_millis(1));
        }
    });
    
    for i in 1..5 {
        println!("Number {} from main thread", i);
        thread::sleep(Duration::from_millis(1));
    }
    
    handle.join().unwrap();
}
```

**Moving data into threads:**

```rust
use std::thread;

fn main() {
    let v = vec![1, 2, 3];
    
    let handle = thread::spawn(move || {
        println!("Vector: {:?}", v);
    });
    
    // println!("{:?}", v);  // ERROR: v moved
    
    handle.join().unwrap();
}
```

### Message passing

```rust
use std::sync::mpsc;
use std::thread;
use std::time::Duration;

fn main() {
    let (tx, rx) = mpsc::channel();
    
    thread::spawn(move || {
        let vals = vec![
            String::from("hi"),
            String::from("from"),
            String::from("the"),
            String::from("thread"),
        ];
        
        for val in vals {
            tx.send(val).unwrap();
            thread::sleep(Duration::from_secs(1));
        }
    });
    
    for received in rx {
        println!("Got: {}", received);
    }
}
```

**Multiple producers:**

```rust
use std::sync::mpsc;
use std::thread;

fn main() {
    let (tx, rx) = mpsc::channel();
    let tx1 = tx.clone();
    
    thread::spawn(move || {
        let vals = vec![
            String::from("hi"),
            String::from("from"),
            String::from("thread 1"),
        ];
        
        for val in vals {
            tx1.send(val).unwrap();
        }
    });
    
    thread::spawn(move || {
        let vals = vec![
            String::from("more"),
            String::from("messages"),
            String::from("from thread 2"),
        ];
        
        for val in vals {
            tx.send(val).unwrap();
        }
    });
    
    for received in rx {
        println!("Got: {}", received);
    }
}
```

### Shared state

```rust
use std::sync::{Arc, Mutex};
use std::thread;

fn main() {
    let counter = Arc::new(Mutex::new(0));
    let mut handles = vec![];
    
    for _ in 0..10 {
        let counter = Arc::clone(&counter);
        let handle = thread::spawn(move || {
            let mut num = counter.lock().unwrap();
            *num += 1;
        });
        handles.push(handle);
    }
    
    for handle in handles {
        handle.join().unwrap();
    }
    
    println!("Result: {}", *counter.lock().unwrap());
}
```

**RwLock for read-heavy workloads:**

```rust
use std::sync::{Arc, RwLock};
use std::thread;

fn main() {
    let data = Arc::new(RwLock::new(vec![1, 2, 3]));
    let mut handles = vec![];
    
    // Multiple readers
    for i in 0..5 {
        let data = Arc::clone(&data);
        let handle = thread::spawn(move || {
            let r = data.read().unwrap();
            println!("Reader {}: {:?}", i, *r);
        });
        handles.push(handle);
    }
    
    // One writer
    let data = Arc::clone(&data);
    let handle = thread::spawn(move || {
        let mut w = data.write().unwrap();
        w.push(4);
        println!("Writer: {:?}", *w);
    });
    handles.push(handle);
    
    for handle in handles {
        handle.join().unwrap();
    }
}
```

### Sync và Send traits

```rust
// Send: can be transferred between threads
// Sync: can be referenced from multiple threads

// Almost all types are Send
// Types composed of Send types are Send

// Sync types can be safely shared
// &T is Send if T is Sync
// &mut T is Send if T is Send

use std::rc::Rc;
use std::sync::Arc;

fn main() {
    // Rc is not Send or Sync
    // let rc = Rc::new(5);
    // thread::spawn(move || {
    //     println!("{}", rc);  // ERROR
    // });
    
    // Arc is Send and Sync
    let arc = Arc::new(5);
    let arc_clone = Arc::clone(&arc);
    
    std::thread::spawn(move || {
        println!("{}", arc_clone);  // OK
    });
}
```

---

## 🧑‍🏫 Bài 2: Async/Await

### Async basics

```rust
async fn hello_world() {
    println!("Hello, world!");
}

async fn learn_song() {
    println!("Learning song...");
}

async fn sing_song() {
    println!("Singing song...");
}

async fn dance() {
    println!("Dancing...");
}

async fn async_main() {
    let song = learn_song();
    let dance_future = dance();
    
    // Doesn't execute yet
    song.await;
    dance_future.await;
}
```

### Futures

```rust
use std::future::Future;
use std::pin::Pin;
use std::task::{Context, Poll};

struct MyFuture {
    count: u32,
}

impl Future for MyFuture {
    type Output = u32;
    
    fn poll(mut self: Pin<&mut Self>, cx: &mut Context<'_>) -> Poll<Self::Output> {
        self.count += 1;
        
        if self.count < 5 {
            cx.waker().wake_by_ref();
            Poll::Pending
        } else {
            Poll::Ready(self.count)
        }
    }
}

#[tokio::main]
async fn main() {
    let future = MyFuture { count: 0 };
    let result = future.await;
    println!("Result: {}", result);
}
```

### Async runtime

**Add to Cargo.toml:**

```toml
[dependencies]
tokio = { version = "1", features = ["full"] }
```

```rust
use tokio::time::{sleep, Duration};

#[tokio::main]
async fn main() {
    println!("Starting...");
    
    sleep(Duration::from_secs(1)).await;
    
    println!("Done!");
}
```

**Concurrent execution:**

```rust
use tokio::time::{sleep, Duration};

async fn task1() {
    println!("Task 1 start");
    sleep(Duration::from_secs(2)).await;
    println!("Task 1 done");
}

async fn task2() {
    println!("Task 2 start");
    sleep(Duration::from_secs(1)).await;
    println!("Task 2 done");
}

#[tokio::main]
async fn main() {
    tokio::join!(task1(), task2());
}
```

### Tokio framework

```rust
use tokio::io::{AsyncReadExt, AsyncWriteExt};
use tokio::net::TcpListener;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let listener = TcpListener::bind("127.0.0.1:8080").await?;
    println!("Server running on port 8080");
    
    loop {
        let (mut socket, _) = listener.accept().await?;
        
        tokio::spawn(async move {
            let mut buf = [0; 1024];
            
            loop {
                let n = match socket.read(&mut buf).await {
                    Ok(n) if n == 0 => return,
                    Ok(n) => n,
                    Err(e) => {
                        eprintln!("Failed to read: {}", e);
                        return;
                    }
                };
                
                if socket.write_all(&buf[0..n]).await.is_err() {
                    eprintln!("Failed to write");
                    return;
                }
            }
        });
    }
}
```

**Async HTTP client:**

```rust
use reqwest;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let response = reqwest::get("https://www.rust-lang.org")
        .await?
        .text()
        .await?;
    
    println!("Body length: {}", response.len());
    
    Ok(())
}
```

---

## 🧑‍🏫 Bài 3: Macros

### Declarative macros

```rust
macro_rules! say_hello {
    () => {
        println!("Hello!");
    };
}

macro_rules! create_function {
    ($func_name:ident) => {
        fn $func_name() {
            println!("Function {:?} was called", stringify!($func_name));
        }
    };
}

macro_rules! print_result {
    ($expression:expr) => {
        println!("{:?} = {:?}", stringify!($expression), $expression);
    };
}

fn main() {
    say_hello!();
    
    create_function!(foo);
    foo();
    
    print_result!(1 + 1);
    print_result!({
        let x = 1;
        x + 1
    });
}
```

**Pattern matching:**

```rust
macro_rules! test {
    ($left:expr; and $right:expr) => {
        println!("{:?} and {:?} is {:?}",
            stringify!($left),
            stringify!($right),
            $left && $right)
    };
    ($left:expr; or $right:expr) => {
        println!("{:?} or {:?} is {:?}",
            stringify!($left),
            stringify!($right),
            $left || $right)
    };
}

fn main() {
    test!(1 == 1; and 2 == 2);
    test!(true; or false);
}
```

**Repetition:**

```rust
macro_rules! vec_strs {
    ($($element:expr),*) => {{
        let mut v = Vec::new();
        $(
            v.push(format!("{}", $element));
        )*
        v
    }};
}

fn main() {
    let v = vec_strs![1, "hello", true, 3.14];
    println!("{:?}", v);
}
```

### Procedural macros

**Cargo.toml:**

```toml
[lib]
proc-macro = true

[dependencies]
syn = "2.0"
quote = "1.0"
proc-macro2 = "1.0"
```

**lib.rs:**

```rust
use proc_macro::TokenStream;
use quote::quote;
use syn;

#[proc_macro_derive(HelloMacro)]
pub fn hello_macro_derive(input: TokenStream) -> TokenStream {
    let ast = syn::parse(input).unwrap();
    impl_hello_macro(&ast)
}

fn impl_hello_macro(ast: &syn::DeriveInput) -> TokenStream {
    let name = &ast.ident;
    let gen = quote! {
        impl HelloMacro for #name {
            fn hello_macro() {
                println!("Hello, Macro! My name is {}!", stringify!(#name));
            }
        }
    };
    gen.into()
}
```

### Custom derive

```rust
use hello_macro::HelloMacro;
use hello_macro_derive::HelloMacro;

#[derive(HelloMacro)]
struct Pancakes;

fn main() {
    Pancakes::hello_macro();
}
```

---

## 🧑‍🏫 Bài 4: Unsafe Rust

### Unsafe superpowers

```rust
fn main() {
    let mut num = 5;
    
    // Create raw pointers (safe)
    let r1 = &num as *const i32;
    let r2 = &mut num as *mut i32;
    
    // Dereference raw pointers (unsafe)
    unsafe {
        println!("r1: {}", *r1);
        println!("r2: {}", *r2);
    }
}
```

### Raw pointers

```rust
fn main() {
    let mut num = 5;
    
    let r1 = &num as *const i32;
    let r2 = &mut num as *mut i32;
    
    unsafe {
        *r2 = 10;
        println!("num: {}", *r1);
    }
}
```

**Arbitrary memory:**

```rust
fn main() {
    let address = 0x012345usize;
    let r = address as *const i32;
    
    // Extremely dangerous!
    // unsafe {
    //     println!("{}", *r);  // Undefined behavior
    // }
}
```

### Unsafe functions

```rust
unsafe fn dangerous() {
    println!("This is dangerous!");
}

fn main() {
    unsafe {
        dangerous();
    }
}
```

**Safe abstraction:**

```rust
use std::slice;

fn split_at_mut(values: &mut [i32], mid: usize) -> (&mut [i32], &mut [i32]) {
    let len = values.len();
    let ptr = values.as_mut_ptr();
    
    assert!(mid <= len);
    
    unsafe {
        (
            slice::from_raw_parts_mut(ptr, mid),
            slice::from_raw_parts_mut(ptr.add(mid), len - mid),
        )
    }
}

fn main() {
    let mut v = vec![1, 2, 3, 4, 5, 6];
    let (left, right) = split_at_mut(&mut v, 3);
    
    println!("Left: {:?}", left);
    println!("Right: {:?}", right);
}
```

### FFI

```rust
extern "C" {
    fn abs(input: i32) -> i32;
}

fn main() {
    unsafe {
        println!("Absolute value of -3: {}", abs(-3));
    }
}
```

**Calling Rust from C:**

```rust
#[no_mangle]
pub extern "C" fn call_from_c() {
    println!("Just called a Rust function from C!");
}
```

---

## 🧑‍🏫 Bài 5: Advanced Patterns

### Smart pointers

```rust
use std::ops::Deref;

struct MyBox<T>(T);

impl<T> MyBox<T> {
    fn new(x: T) -> MyBox<T> {
        MyBox(x)
    }
}

impl<T> Deref for MyBox<T> {
    type Target = T;
    
    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

fn main() {
    let x = 5;
    let y = MyBox::new(x);
    
    assert_eq!(5, x);
    assert_eq!(5, *y);
}
```

### Interior mutability

```rust
use std::cell::RefCell;

fn main() {
    let data = RefCell::new(5);
    
    {
        let mut borrowed = data.borrow_mut();
        *borrowed += 1;
    }
    
    println!("data: {:?}", data.borrow());
}
```

**Mock object pattern:**

```rust
pub trait Messenger {
    fn send(&self, msg: &str);
}

pub struct LimitTracker<'a, T: Messenger> {
    messenger: &'a T,
    value: usize,
    max: usize,
}

impl<'a, T> LimitTracker<'a, T>
where
    T: Messenger,
{
    pub fn new(messenger: &'a T, max: usize) -> LimitTracker<'a, T> {
        LimitTracker {
            messenger,
            value: 0,
            max,
        }
    }
    
    pub fn set_value(&mut self, value: usize) {
        self.value = value;
        
        let percentage = self.value as f64 / self.max as f64;
        
        if percentage >= 1.0 {
            self.messenger.send("Error: Over quota!");
        } else if percentage >= 0.9 {
            self.messenger.send("Warning: 90% of quota used");
        } else if percentage >= 0.75 {
            self.messenger.send("Warning: 75% of quota used");
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::cell::RefCell;
    
    struct MockMessenger {
        sent_messages: RefCell<Vec<String>>,
    }
    
    impl MockMessenger {
        fn new() -> MockMessenger {
            MockMessenger {
                sent_messages: RefCell::new(vec![]),
            }
        }
    }
    
    impl Messenger for MockMessenger {
        fn send(&self, message: &str) {
            self.sent_messages.borrow_mut().push(String::from(message));
        }
    }
    
    #[test]
    fn it_sends_an_over_75_percent_warning_message() {
        let mock_messenger = MockMessenger::new();
        let mut limit_tracker = LimitTracker::new(&mock_messenger, 100);
        
        limit_tracker.set_value(80);
        
        assert_eq!(mock_messenger.sent_messages.borrow().len(), 1);
    }
}
```

### Type aliases

```rust
type Kilometers = i32;

fn main() {
    let x: i32 = 5;
    let y: Kilometers = 5;
    
    println!("x + y = {}", x + y);
}

// Reduce repetition
type Thunk = Box<dyn Fn() + Send + 'static>;

fn takes_long_type(f: Thunk) {
    // --snip--
}

fn returns_long_type() -> Thunk {
    Box::new(|| println!("hi"))
}
```

### Never type

```rust
fn bar() -> ! {
    panic!("This function never returns!");
}

fn main() {
    let guess: u32 = match "123".parse() {
        Ok(num) => num,
        Err(_) => {
            // continue has type !
            // continue
            panic!("Error!")
        }
    };
}
```

### Function pointers

```rust
fn add_one(x: i32) -> i32 {
    x + 1
}

fn do_twice(f: fn(i32) -> i32, arg: i32) -> i32 {
    f(arg) + f(arg)
}

fn main() {
    let answer = do_twice(add_one, 5);
    println!("Answer: {}", answer);
}
```

**Returning closures:**

```rust
fn returns_closure() -> Box<dyn Fn(i32) -> i32> {
    Box::new(|x| x + 1)
}

fn main() {
    let f = returns_closure();
    println!("{}", f(5));
}
```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Concurrent Web Scraper

### Mô tả bài toán

Xây dựng web scraper đa luồng với các tính năng:

- Async HTTP requests
- Concurrent URL fetching
- HTML parsing
- Rate limiting
- Error handling và retries
- Data export
- Progress tracking

### Yêu cầu

**Cargo.toml:**

```toml
[dependencies]
tokio = { version = "1", features = ["full"] }
reqwest = "0.11"
scraper = "0.17"
url = "2.4"
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"
thiserror = "1.0"
```

**1. Data structures:**

```rust
use serde::{Deserialize, Serialize};
use std::collections::{HashSet, HashMap};
use std::sync::Arc;
use tokio::sync::Mutex;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Page {
    pub url: String,
    pub title: String,
    pub links: Vec<String>,
    pub content_length: usize,
}

#[derive(Debug)]
pub struct Scraper {
    visited: Arc<Mutex<HashSet<String>>>,
    results: Arc<Mutex<Vec<Page>>>,
    max_depth: usize,
    max_pages: usize,
}
```

**2. Error handling:**

```rust
use thiserror::Error;

#[derive(Error, Debug)]
pub enum ScraperError {
    #[error("HTTP request failed: {0}")]
    HttpError(#[from] reqwest::Error),
    
    #[error("Invalid URL: {0}")]
    InvalidUrl(String),
    
    #[error("Parsing error: {0}")]
    ParseError(String),
    
    #[error("Max pages reached")]
    MaxPagesReached,
}
```

**3. Core functionality:**

```rust
impl Scraper {
    pub fn new(max_depth: usize, max_pages: usize) -> Self;
    
    pub async fn scrape(&self, start_url: &str) -> Result<Vec<Page>, ScraperError>;
    
    async fn fetch_page(&self, url: &str) -> Result<Page, ScraperError>;
    
    async fn extract_links(&self, html: &str, base_url: &str) -> Vec<String>;
    
    pub async fn save_results(&self, filename: &str) -> Result<(), ScraperError>;
    
    pub fn get_statistics(&self) -> Statistics;
}

#[derive(Debug)]
pub struct Statistics {
    pub total_pages: usize,
    pub unique_domains: usize,
    pub average_links: f64,
}
```

**Template code:**

```rust
use scraper::{Html, Selector};
use serde::{Deserialize, Serialize};
use std::collections::{HashSet, VecDeque};
use std::sync::Arc;
use std::time::Duration;
use thiserror::Error;
use tokio::sync::Mutex;
use tokio::time::sleep;
use url::Url;

#[derive(Error, Debug)]
pub enum ScraperError {
    #[error("HTTP request failed: {0}")]
    HttpError(#[from] reqwest::Error),
    
    #[error("Invalid URL: {0}")]
    InvalidUrl(String),
    
    #[error("Parsing error: {0}")]
    ParseError(String),
    
    #[error("Max pages reached")]
    MaxPagesReached,
    
    #[error("IO error: {0}")]
    IoError(#[from] std::io::Error),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Page {
    pub url: String,
    pub title: String,
    pub links: Vec<String>,
    pub content_length: usize,
    pub depth: usize,
}

pub struct Scraper {
    visited: Arc<Mutex<HashSet<String>>>,
    results: Arc<Mutex<Vec<Page>>>,
    max_depth: usize,
    max_pages: usize,
    client: reqwest::Client,
}

impl Scraper {
    pub fn new(max_depth: usize, max_pages: usize) -> Self {
        Scraper {
            visited: Arc::new(Mutex::new(HashSet::new())),
            results: Arc::new(Mutex::new(Vec::new())),
            max_depth,
            max_pages,
            client: reqwest::Client::builder()
                .timeout(Duration::from_secs(10))
                .build()
                .unwrap(),
        }
    }
    
    pub async fn scrape(&self, start_url: &str) -> Result<Vec<Page>, ScraperError> {
        let mut queue = VecDeque::new();
        queue.push_back((start_url.to_string(), 0));
        
        while let Some((url, depth)) = queue.pop_front() {
            // Check limits
            {
                let results = self.results.lock().await;
                if results.len() >= self.max_pages {
                    break;
                }
            }
            
            if depth > self.max_depth {
                continue;
            }
            
            // Check if already visited
            {
                let mut visited = self.visited.lock().await;
                if visited.contains(&url) {
                    continue;
                }
                visited.insert(url.clone());
            }
            
            println!("Scraping: {} (depth: {})", url, depth);
            
            // Fetch page
            match self.fetch_page(&url, depth).await {
                Ok(page) => {
                    // Add links to queue
                    for link in &page.links {
                        queue.push_back((link.clone(), depth + 1));
                    }
                    
                    let mut results = self.results.lock().await;
                    results.push(page);
                }
                Err(e) => {
                    eprintln!("Error fetching {}: {}", url, e);
                }
            }
            
            // Rate limiting
            sleep(Duration::from_millis(100)).await;
        }
        
        let results = self.results.lock().await;
        Ok(results.clone())
    }
    
    async fn fetch_page(&self, url: &str, depth: usize) -> Result<Page, ScraperError> {
        let response = self.client.get(url).send().await?;
        let html = response.text().await?;
        
        let document = Html::parse_document(&html);
        
        // Extract title
        let title_selector = Selector::parse("title").unwrap();
        let title = document
            .select(&title_selector)
            .next()
            .map(|el| el.inner_html())
            .unwrap_or_else(|| "No title".to_string());
        
        // Extract links
        let links = self.extract_links(&html, url).await;
        
        Ok(Page {
            url: url.to_string(),
            title,
            links,
            content_length: html.len(),
            depth,
        })
    }
    
    async fn extract_links(&self, html: &str, base_url: &str) -> Vec<String> {
        let document = Html::parse_document(html);
        let selector = Selector::parse("a[href]").unwrap();
        
        let base = match Url::parse(base_url) {
            Ok(url) => url,
            Err(_) => return vec![],
        };
        
        document
            .select(&selector)
            .filter_map(|el| el.value().attr("href"))
            .filter_map(|href| {
                // Resolve relative URLs
                match base.join(href) {
                    Ok(url) => Some(url.to_string()),
                    Err(_) => None,
                }
            })
            .filter(|url| url.starts_with("http"))
            .take(50)  // Limit links per page
            .collect()
    }
    
    pub async fn save_results(&self, filename: &str) -> Result<(), ScraperError> {
        let results = self.results.lock().await;
        let json = serde_json::to_string_pretty(&*results)?;
        tokio::fs::write(filename, json).await?;
        Ok(())
    }
    
    pub async fn get_statistics(&self) -> Statistics {
        let results = self.results.lock().await;
        
        let total_pages = results.len();
        
        let mut domains = HashSet::new();
        for page in results.iter() {
            if let Ok(url) = Url::parse(&page.url) {
                if let Some(domain) = url.domain() {
                    domains.insert(domain.to_string());
                }
            }
        }
        
        let total_links: usize = results.iter().map(|p| p.links.len()).sum();
        let average_links = if total_pages > 0 {
            total_links as f64 / total_pages as f64
        } else {
            0.0
        };
        
        Statistics {
            total_pages,
            unique_domains: domains.len(),
            average_links,
        }
    }
}

#[derive(Debug)]
pub struct Statistics {
    pub total_pages: usize,
    pub unique_domains: usize,
    pub average_links: f64,
}

#[tokio::main]
async fn main() -> Result<(), ScraperError> {
    let scraper = Scraper::new(2, 20);
    
    println!("Starting web scraper...");
    println!("Max depth: {}", 2);
    println!("Max pages: {}", 20);
    println!();
    
    let start_url = "https://example.com";
    
    let pages = scraper.scrape(start_url).await?;
    
    println!("\n=== Results ===");
    for page in &pages {
        println!("URL: {}", page.url);
        println!("Title: {}", page.title);
        println!("Links: {}", page.links.len());
        println!("Depth: {}", page.depth);
        println!();
    }
    
    // Save results
    scraper.save_results("scraper_results.json").await?;
    println!("Results saved to scraper_results.json");
    
    // Statistics
    let stats = scraper.get_statistics().await;
    println!("\n=== Statistics ===");
    println!("Total pages: {}", stats.total_pages);
    println!("Unique domains: {}", stats.unique_domains);
    println!("Average links per page: {:.2}", stats.average_links);
    
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[tokio::test]
    async fn test_scraper_creation() {
        let scraper = Scraper::new(2, 10);
        assert_eq!(scraper.max_depth, 2);
        assert_eq!(scraper.max_pages, 10);
    }
    
    #[tokio::test]
    async fn test_extract_links() {
        let scraper = Scraper::new(1, 10);
        let html = r#"
            <html>
                <body>
                    <a href="https://example.com/page1">Link 1</a>
                    <a href="/page2">Link 2</a>
                    <a href="https://other.com">External</a>
                </body>
            </html>
        "#;
        
        let links = scraper.extract_links(html, "https://example.com").await;
        assert!(!links.is_empty());
    }
}
```

**Yêu cầu mở rộng:**

1. **Advanced features:**
   - Parallel requests với tokio::spawn
   - Request retry logic
   - Custom headers và authentication
   - Cookie handling
   - Robots.txt respect

2. **Data extraction:**
   - CSS selector queries
   - XPath support
   - Regex pattern matching
   - Metadata extraction
   - Image/file download

3. **Performance:**
   - Connection pooling
   - Request batching
   - Caching
   - Compression
   - Timeout handling

4. **Output formats:**
   - JSON export
   - CSV export
   - Database storage
   - Real-time streaming
   - Progress reporting

5. **Filtering:**
   - URL patterns
   - Domain whitelist/blacklist
   - Content-type filtering
   - Depth limits per domain
   - Custom predicates

6. **Monitoring:**
   - Request statistics
   - Error tracking
   - Performance metrics
   - Resource usage
   - Logging system

---

**🎉 CHÚC MỪNG! Bạn đã hoàn thành toàn bộ khóa học Rust!**

Những gì đã học:

- ✅ Basics: Variables, functions, control flow
- ✅ Ownership: Borrowing, references, lifetimes
- ✅ Structs & Enums: Pattern matching, Option, Result
- ✅ Collections: Vec, String, HashMap, error handling
- ✅ Traits & Generics: Type system, polymorphism
- ✅ Advanced: Concurrency, async/await, macros, unsafe

Next steps:

1. Build real-world projects
2. Contribute to open source
3. Explore Rust ecosystem (web, CLI, embedded)
4. Master advanced patterns
5. Join Rust community

---

[⬅️ Trở lại: RUST/Part5.md](Part5.md) |
[🏠 Home](../README.md)
