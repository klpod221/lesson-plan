# 📘 PHẦN 2: OWNERSHIP VÀ BORROWING

- [📘 PHẦN 2: OWNERSHIP VÀ BORROWING](#-phần-2-ownership-và-borrowing)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Ownership - Khái niệm cốt lõi của Rust](#-bài-1-ownership---khái-niệm-cốt-lõi-của-rust)
    - [Memory management models](#memory-management-models)
    - [Ownership rules](#ownership-rules)
    - [Move semantics](#move-semantics)
    - [Copy trait](#copy-trait)
    - [Clone](#clone)
    - [Ownership và functions](#ownership-và-functions)
  - [🧑‍🏫 Bài 2: References và Borrowing](#-bài-2-references-và-borrowing)
    - [Immutable references](#immutable-references)
    - [Mutable references](#mutable-references)
    - [Borrowing rules](#borrowing-rules)
    - [Dangling references](#dangling-references)
    - [Reference scope](#reference-scope)
  - [🧑‍🏫 Bài 3: Slices](#-bài-3-slices)
    - [String slices](#string-slices)
    - [Array slices](#array-slices)
    - [Slice as parameters](#slice-as-parameters)
    - [String literals as slices](#string-literals-as-slices)
    - [Other slice types](#other-slice-types)
  - [🧑‍🏫 Bài 4: Lifetimes cơ bản](#-bài-4-lifetimes-cơ-bản)
    - [Lifetime concepts](#lifetime-concepts)
    - [Lifetime annotations](#lifetime-annotations)
    - [Lifetime elision](#lifetime-elision)
    - [Struct lifetimes](#struct-lifetimes)
    - [Common lifetime patterns](#common-lifetime-patterns)
  - [🧑‍🏫 Bài 5: Smart Pointers cơ bản](#-bài-5-smart-pointers-cơ-bản)
    - [Box`<T>`](#boxt)
    - [Rc`<T>` - Reference Counting](#rct---reference-counting)
    - [RefCell`<T>` - Interior Mutability](#refcellt---interior-mutability)
    - [Combining Rc và RefCell](#combining-rc-và-refcell)
    - [Memory leaks và prevention](#memory-leaks-và-prevention)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN: Hệ thống quản lý sinh viên](#-bài-tập-lớn-cuối-phần-hệ-thống-quản-lý-sinh-viên)
    - [Mô tả bài toán](#mô-tả-bài-toán)
    - [Yêu cầu](#yêu-cầu)

## 🎯 Mục tiêu tổng quát

- Hiểu sâu về ownership - đặc trưng quan trọng nhất của Rust
- Nắm vững move semantics và copy trait
- Biết cách sử dụng references và borrowing đúng cách
- Làm việc với slices hiệu quả
- Hiểu lifetimes và cách compiler kiểm tra
- Sử dụng smart pointers cơ bản: Box, Rc, RefCell
- Xây dựng ứng dụng memory-safe mà không có garbage collector

---

## 🧑‍🏫 Bài 1: Ownership - Khái niệm cốt lõi của Rust

### Memory management models

**Các cách quản lý memory:**

1. **Manual memory management (C/C++)**

   ```c
   // C code
   int* ptr = malloc(sizeof(int));
   *ptr = 42;
   free(ptr);  // Phải nhớ free
   ```

   - Ưu: Hiệu suất cao, kiểm soát hoàn toàn
   - Nhược: Dễ gây memory leaks, dangling pointers, double free

2. **Garbage Collection (Java, Python, Go)**

   ```java
   // Java code
   String s = new String("hello");
   // GC tự động thu hồi memory
   ```

   - Ưu: Dễ sử dụng, an toàn
   - Nhược: Runtime overhead, pause times, không predictable

3. **Ownership (Rust)**

   ```rust
   fn main() {
       let s = String::from("hello");
       // Compiler tự động drop khi out of scope
   }  // s dropped here
   ```

   - Ưu: Memory safe + Zero cost
   - Nhược: Learning curve cao

### Ownership rules

**Ba quy tắc vàng của Ownership:**

1. Each value in Rust has a variable that's called its **owner**
2. There can only be **one owner** at a time
3. When the owner goes out of scope, the value will be **dropped**

```rust
fn main() {
    {
        let s = String::from("hello");  // s is owner
        // s is valid here
    }  // s goes out of scope, memory freed automatically
    
    // println!("{}", s);  // ERROR: s no longer exists
}
```

**Stack vs Heap:**

```rust
fn main() {
    // Stack allocated (known size, fast)
    let x = 5;           // Copy on stack
    let y = x;           // Copy on stack
    println!("x={}, y={}", x, y);  // Both valid
    
    // Heap allocated (unknown size, slower)
    let s1 = String::from("hello");  // Heap allocated
    let s2 = s1;         // Move (not copy!)
    // println!("{}", s1);  // ERROR: s1 moved to s2
    println!("{}", s2);  // OK
}
```

**Visualizing memory:**

```text
Stack allocated:
x: 5     -> copied to y
y: 5

Heap allocated:
s1: [ptr, len, capacity] -> moved to s2
s2: [ptr, len, capacity] -> [h,e,l,l,o] on heap
```

### Move semantics

**Move khi assign:**

```rust
fn main() {
    let s1 = String::from("hello");
    let s2 = s1;  // s1 moved to s2
    
    // println!("{}", s1);  // ERROR: value borrowed after move
    println!("{}", s2);  // OK
}
```

**Tại sao move?**

- Prevent double free
- Ensure single owner
- Zero cost abstraction

**Move with functions:**

```rust
fn main() {
    let s = String::from("hello");
    takes_ownership(s);  // s moved into function
    
    // println!("{}", s);  // ERROR: s moved
}

fn takes_ownership(some_string: String) {
    println!("{}", some_string);
}  // some_string dropped here
```

**Return ownership:**

```rust
fn main() {
    let s1 = gives_ownership();         // Function gives ownership
    println!("{}", s1);
    
    let s2 = String::from("hello");
    let s3 = takes_and_gives_back(s2);  // s2 moved in, s3 gets it back
    // println!("{}", s2);  // ERROR
    println!("{}", s3);  // OK
}

fn gives_ownership() -> String {
    let some_string = String::from("hello");
    some_string  // Ownership moved to caller
}

fn takes_and_gives_back(a_string: String) -> String {
    a_string  // Return ownership
}
```

### Copy trait

**Types that implement Copy:**

```rust
fn main() {
    // All these types implement Copy trait
    let x = 5;              // i32
    let y = 3.14;           // f64
    let c = 'a';            // char
    let b = true;           // bool
    let t = (1, 2);         // tuple (if all elements implement Copy)
    let arr = [1, 2, 3];    // array (if element type implements Copy)
    
    // Copy happens
    let x2 = x;
    println!("x={}, x2={}", x, x2);  // Both valid
    
    // Tuple with Copy
    let point = (10, 20);
    let point2 = point;
    println!("point: {:?}, point2: {:?}", point, point2);
}
```

**Types that DON'T implement Copy:**

```rust
fn main() {
    let s1 = String::from("hello");    // String
    let v1 = vec![1, 2, 3];            // Vec
    let b1 = Box::new(5);              // Box
    
    // These are moved, not copied
    let s2 = s1;  // s1 moved
    let v2 = v1;  // v1 moved
    let b2 = b1;  // b1 moved
}
```

**Rule:** A type can't implement Copy if it or any of its parts implement Drop

### Clone

**Explicit deep copy:**

```rust
fn main() {
    let s1 = String::from("hello");
    let s2 = s1.clone();  // Explicit deep copy
    
    println!("s1={}, s2={}", s1, s2);  // Both valid
    
    // Clone can be expensive!
    let v1 = vec![1, 2, 3, 4, 5];
    let v2 = v1.clone();  // Copies all elements
    
    println!("v1: {:?}", v1);
    println!("v2: {:?}", v2);
}
```

**Clone vs Copy:**

| | Copy | Clone |
|---|------|-------|
| Implicit/Explicit | Implicit | Explicit (`clone()`) |
| Cost | Cheap (stack copy) | Can be expensive |
| Trait | `Copy` trait | `Clone` trait |
| Usage | Automatic | Manual call |

**When to clone:**

```rust
fn main() {
    let s1 = String::from("expensive data");
    
    // Avoid unnecessary clones
    process_string(&s1);    // Borrow instead
    println!("{}", s1);
    
    // Clone when needed
    let s2 = s1.clone();
    std::thread::spawn(move || {
        println!("{}", s2);  // s2 moved into thread
    });
    
    println!("{}", s1);  // s1 still valid
}

fn process_string(s: &String) {
    println!("{}", s);
}
```

### Ownership và functions

**Complete example:**

```rust
fn main() {
    let s = String::from("hello");
    
    // Move into function
    takes_ownership(s);
    // println!("{}", s);  // ERROR: moved
    
    let x = 5;
    makes_copy(x);
    println!("{}", x);  // OK: x implements Copy
    
    // Get ownership back
    let s1 = String::from("hello");
    let (s2, len) = calculate_length(s1);
    println!("String '{}' has length {}", s2, len);
}

fn takes_ownership(some_string: String) {
    println!("{}", some_string);
}  // some_string dropped

fn makes_copy(some_integer: i32) {
    println!("{}", some_integer);
}  // nothing special happens

fn calculate_length(s: String) -> (String, usize) {
    let length = s.len();
    (s, length)  // Return ownership
}
```

**Problem with ownership:**

```rust
fn main() {
    let s1 = String::from("hello");
    let len = calculate_length(s1);
    // Can't use s1 anymore!
    // println!("Length of '{}' is {}", s1, len);  // ERROR
}

fn calculate_length(s: String) -> usize {
    s.len()
}  // s dropped
```

**Solution: Use references!** (next lesson)

---

## 🧑‍🏫 Bài 2: References và Borrowing

### Immutable references

**Borrowing without taking ownership:**

```rust
fn main() {
    let s1 = String::from("hello");
    
    let len = calculate_length(&s1);  // Borrow s1
    
    println!("Length of '{}' is {}", s1, len);  // s1 still valid!
}

fn calculate_length(s: &String) -> usize {
    s.len()
}  // s goes out of scope, but doesn't drop (not owner)
```

**Visual representation:**

```text
s1 (owner) ──────> [String data on heap]
               ↑
               │
&s1 (reference) ─┘
```

**Multiple immutable references:**

```rust
fn main() {
    let s = String::from("hello");
    
    let r1 = &s;  // OK
    let r2 = &s;  // OK
    let r3 = &s;  // OK
    
    println!("{}, {}, {}", r1, r2, r3);  // All valid
}
```

**References are immutable by default:**

```rust
fn main() {
    let s = String::from("hello");
    let r = &s;
    
    // r.push_str(", world");  // ERROR: cannot mutate through immutable reference
    println!("{}", r);
}
```

### Mutable references

**Borrow mutably:**

```rust
fn main() {
    let mut s = String::from("hello");
    
    change(&mut s);  // Mutable borrow
    
    println!("{}", s);  // "hello, world"
}

fn change(some_string: &mut String) {
    some_string.push_str(", world");
}
```

**Only ONE mutable reference at a time:**

```rust
fn main() {
    let mut s = String::from("hello");
    
    let r1 = &mut s;
    // let r2 = &mut s;  // ERROR: cannot borrow as mutable more than once
    
    println!("{}", r1);
}
```

**Why this restriction?**

- Prevent data races at compile time
- Data race occurs when:
  1. Two or more pointers access same data
  2. At least one is writing
  3. No synchronization mechanism

**Can create multiple mutable references in different scopes:**

```rust
fn main() {
    let mut s = String::from("hello");
    
    {
        let r1 = &mut s;
        r1.push_str(" world");
    }  // r1 goes out of scope
    
    let r2 = &mut s;
    r2.push_str("!");
    
    println!("{}", s);  // "hello world!"
}
```

### Borrowing rules

**The Rules:**

1. You can have EITHER:
   - One mutable reference
   - Any number of immutable references
2. References must always be valid

**Cannot mix mutable and immutable:**

```rust
fn main() {
    let mut s = String::from("hello");
    
    let r1 = &s;      // OK
    let r2 = &s;      // OK
    // let r3 = &mut s;  // ERROR: cannot borrow as mutable
    
    println!("{}, {}", r1, r2);
}
```

**Why?**

```rust
// If this was allowed:
let mut s = String::from("hello");
let r1 = &s;
let r2 = &mut s;  // Hypothetically allowed
r2.push_str(" world");
println!("{}", r1);  // r1 would see unexpected change!
```

**Valid pattern:**

```rust
fn main() {
    let mut s = String::from("hello");
    
    let r1 = &s;
    let r2 = &s;
    println!("{}, {}", r1, r2);  // r1, r2 last used here
    
    let r3 = &mut s;  // OK: r1, r2 no longer used
    r3.push_str(" world");
    println!("{}", r3);
}
```

### Dangling references

**Rust prevents dangling references:**

```rust
fn main() {
    let reference_to_nothing = dangle();
}

fn dangle() -> &String {  // ERROR: returns a reference to data owned by function
    let s = String::from("hello");
    &s  // s will be dropped, reference would be dangling
}  // s goes out of scope and is dropped
```

**Correct version:**

```rust
fn main() {
    let string = no_dangle();
    println!("{}", string);
}

fn no_dangle() -> String {
    let s = String::from("hello");
    s  // Transfer ownership
}
```

**Another dangling example:**

```rust
fn main() {
    let r;
    {
        let x = 5;
        // r = &x;  // ERROR: x doesn't live long enough
    }
    // println!("{}", r);  // x dropped, r would be dangling
}
```

### Reference scope

**Non-Lexical Lifetimes (NLL):**

```rust
fn main() {
    let mut s = String::from("hello");
    
    let r1 = &s;
    let r2 = &s;
    println!("{} and {}", r1, r2);
    // r1 and r2 are no longer used after this point
    
    let r3 = &mut s;  // OK: no overlap with r1, r2
    println!("{}", r3);
}
```

**Before NLL (Rust 2015):**

```rust
// This would error in older Rust
fn main() {
    let mut s = String::from("hello");
    
    let r1 = &s;
    let r2 = &s;
    println!("{} and {}", r1, r2);
    
    // let r3 = &mut s;  // ERROR in Rust 2015
    // Scope of r1, r2 extends to end of block
}
```

**Practical example:**

```rust
fn main() {
    let mut data = vec![1, 2, 3];
    
    // Read-only access
    let first = &data[0];
    println!("First element: {}", first);
    
    // Modify
    data.push(4);  // OK: first no longer used
    
    println!("Data: {:?}", data);
}
```

---

## 🧑‍🏫 Bài 3: Slices

### String slices

**String slice type: `&str`**

```rust
fn main() {
    let s = String::from("hello world");
    
    let hello = &s[0..5];   // "hello"
    let world = &s[6..11];  // "world"
    
    println!("{} {}", hello, world);
}
```

**Slice syntax:**

```rust
fn main() {
    let s = String::from("hello world");
    
    let slice1 = &s[0..5];   // "hello"
    let slice2 = &s[..5];    // Same as [0..5]
    
    let slice3 = &s[6..11];  // "world"
    let slice4 = &s[6..];    // Same as [6..len]
    
    let slice5 = &s[..];     // Entire string
    let slice6 = &s[0..s.len()];  // Same as [..]
    
    println!("{}", slice1);
}
```

**Why slices?**

```rust
// Without slices
fn first_word(s: &String) -> usize {
    let bytes = s.as_bytes();
    
    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return i;
        }
    }
    
    s.len()
}

fn main() {
    let mut s = String::from("hello world");
    let word_length = first_word(&s);
    
    s.clear();  // s is now empty
    
    // word_length still has value 5, but s is empty!
    // Compiler can't catch this bug
}
```

**With slices:**

```rust
fn first_word(s: &String) -> &str {
    let bytes = s.as_bytes();
    
    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return &s[0..i];
        }
    }
    
    &s[..]
}

fn main() {
    let mut s = String::from("hello world");
    let word = first_word(&s);
    
    // s.clear();  // ERROR: can't borrow mutably while immutable borrow exists
    
    println!("First word: {}", word);
}
```

### Array slices

**Slice type: `&[T]`**

```rust
fn main() {
    let arr = [1, 2, 3, 4, 5];
    
    let slice = &arr[1..3];  // [2, 3]
    
    println!("Slice: {:?}", slice);
    println!("Slice length: {}", slice.len());
}
```

**Working with slices:**

```rust
fn main() {
    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    
    let first_half = &numbers[..5];
    let second_half = &numbers[5..];
    
    println!("First half: {:?}", first_half);
    println!("Second half: {:?}", second_half);
    
    print_slice(first_half);
    print_slice(second_half);
}

fn print_slice(slice: &[i32]) {
    print!("[");
    for (i, &item) in slice.iter().enumerate() {
        print!("{}", item);
        if i < slice.len() - 1 {
            print!(", ");
        }
    }
    println!("]");
}
```

### Slice as parameters

**Better function signatures:**

```rust
fn main() {
    let s = String::from("hello world");
    let literal = "hello world";
    let arr = [1, 2, 3, 4, 5];
    
    // Works with both String and string literal
    let word1 = first_word(&s);
    let word2 = first_word(literal);
    
    println!("{}, {}", word1, word2);
    
    // Works with both array and slice
    let sum1 = sum_slice(&arr);
    let sum2 = sum_slice(&arr[2..4]);
    
    println!("sum1={}, sum2={}", sum1, sum2);
}

// Use &str instead of &String for flexibility
fn first_word(s: &str) -> &str {
    let bytes = s.as_bytes();
    
    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return &s[0..i];
        }
    }
    
    &s[..]
}

// Use &[T] instead of &Vec<T> or &[T; N]
fn sum_slice(slice: &[i32]) -> i32 {
    let mut sum = 0;
    for &item in slice {
        sum += item;
    }
    sum
}
```

**Why `&str` is better than `&String`:**

```rust
// Bad: only accepts &String
fn process_bad(s: &String) {
    println!("{}", s);
}

// Good: accepts both &String and &str
fn process_good(s: &str) {
    println!("{}", s);
}

fn main() {
    let string = String::from("hello");
    let literal = "world";
    
    // process_bad(&string);     // OK
    // process_bad(literal);     // ERROR!
    
    process_good(&string);    // OK
    process_good(literal);    // OK
}
```

### String literals as slices

**String literals are slices:**

```rust
fn main() {
    // Type is &str
    let s: &str = "Hello, world!";
    
    // Stored in binary, immutable
    // &str is a reference to that immutable data
    
    println!("{}", s);
}
```

**String vs &str:**

```rust
fn main() {
    // String: owned, mutable, heap-allocated
    let mut s1 = String::from("hello");
    s1.push_str(" world");
    
    // &str: borrowed, immutable, can be stack or binary
    let s2: &str = "hello";
    // s2.push_str(" world");  // ERROR: can't modify
    
    // Convert String to &str
    let s3: &str = &s1;
    let s4: &str = s1.as_str();
    
    // Convert &str to String
    let s5: String = s2.to_string();
    let s6: String = String::from(s2);
    
    println!("{}, {}", s1, s2);
}
```

### Other slice types

**Generic slices:**

```rust
fn main() {
    let numbers: Vec<i32> = vec![1, 2, 3, 4, 5];
    let slice: &[i32] = &numbers[1..4];
    
    let chars: Vec<char> = vec!['a', 'b', 'c'];
    let char_slice: &[char] = &chars[..];
    
    println!("{:?}", slice);
    println!("{:?}", char_slice);
}
```

**Mutable slices:**

```rust
fn main() {
    let mut numbers = [1, 2, 3, 4, 5];
    
    let slice = &mut numbers[1..4];
    slice[0] = 10;
    slice[1] = 20;
    
    println!("{:?}", numbers);  // [1, 10, 20, 4, 5]
}

fn double_values(slice: &mut [i32]) {
    for item in slice {
        *item *= 2;
    }
}
```

---

## 🧑‍🏫 Bài 4: Lifetimes cơ bản

### Lifetime concepts

**Why lifetimes?**

```rust
fn main() {
    let string1 = String::from("long string");
    let result;
    
    {
        let string2 = String::from("short");
        result = longest(string1.as_str(), string2.as_str());
    }  // string2 dropped here
    
    // println!("{}", result);  // result might reference dropped data!
}

fn longest(x: &str, y: &str) -> &str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```

**Compiler error:**

```text
error[E0106]: missing lifetime specifier
 --> src/main.rs
  |
  | fn longest(x: &str, y: &str) -> &str {
  |               ----     ----     ^ expected named lifetime parameter
```

### Lifetime annotations

**Syntax:**

```rust
&i32        // Reference
&'a i32     // Reference with explicit lifetime
&'a mut i32 // Mutable reference with explicit lifetime
```

**Annotating longest:**

```rust
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```

**What this means:**

- Return value lives as long as the shorter of x or y
- Compiler will enforce this

**Valid usage:**

```rust
fn main() {
    let string1 = String::from("long string");
    let string2 = String::from("short");
    
    let result = longest(string1.as_str(), string2.as_str());
    println!("Longest: {}", result);
}  // Both string1 and string2 still valid
```

**Invalid usage:**

```rust
fn main() {
    let string1 = String::from("long string");
    let result;
    
    {
        let string2 = String::from("short");
        result = longest(string1.as_str(), string2.as_str());
    }  // ERROR: string2 doesn't live long enough
    
    println!("{}", result);
}
```

**Multiple lifetimes:**

```rust
fn main() {
    let s1 = String::from("hello");
    let s2 = String::from("world");
    
    let result = first_word_or_second(&s1, &s2);
    println!("{}", result);
}

// Return has lifetime of first parameter only
fn first_word_or_second<'a, 'b>(first: &'a str, second: &'b str) -> &'a str {
    if first.len() > 0 {
        first
    } else {
        second  // This would error if we try to return second
    }
}
```

### Lifetime elision

**Compiler can infer lifetimes in simple cases:**

**Before elision rules:**

```rust
fn first_word<'a>(s: &'a str) -> &'a str {
    let bytes = s.as_bytes();
    
    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return &s[0..i];
        }
    }
    
    &s[..]
}
```

**After elision rules (can omit):**

```rust
fn first_word(s: &str) -> &str {
    let bytes = s.as_bytes();
    
    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return &s[0..i];
        }
    }
    
    &s[..]
}
```

**Elision rules:**

1. Each parameter gets its own lifetime
2. If one input lifetime, assign to output
3. If multiple input lifetimes and one is `&self` or `&mut self`, assign self's lifetime to output

**Examples:**

```rust
// Rule 1 + 2
fn example1(s: &str) -> &str { s }
// Becomes: fn example1<'a>(s: &'a str) -> &'a str { s }

// Rule 1 only (can't infer output)
// fn example2(x: &str, y: &str) -> &str { x }  // ERROR: can't infer

// With explicit lifetime
fn example2<'a>(x: &'a str, y: &str) -> &'a str { x }

// Rule 3 (methods)
impl MyStruct {
    fn get_data(&self) -> &str {
        &self.data
    }
    // Becomes: fn get_data<'a>(&'a self) -> &'a str
}
```

### Struct lifetimes

**Struct holding references:**

```rust
struct ImportantExcerpt<'a> {
    part: &'a str,
}

fn main() {
    let novel = String::from("Call me Ishmael. Some years ago...");
    let first_sentence = novel.split('.').next().expect("Could not find '.'");
    
    let excerpt = ImportantExcerpt {
        part: first_sentence,
    };
    
    println!("Excerpt: {}", excerpt.part);
}  // excerpt must not outlive novel
```

**Invalid usage:**

```rust
fn main() {
    let excerpt;
    {
        let novel = String::from("Short story.");
        excerpt = ImportantExcerpt {
            part: &novel,
        };
    }  // ERROR: novel doesn't live long enough
    
    println!("{}", excerpt.part);
}
```

**Methods with lifetimes:**

```rust
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
    let novel = String::from("Once upon a time...");
    let first = novel.split(' ').next().unwrap();
    
    let excerpt = ImportantExcerpt { part: first };
    
    println!("Level: {}", excerpt.level());
    println!("Part: {}", excerpt.announce_and_return_part("Breaking news"));
}
```

### Common lifetime patterns

**The static lifetime:**

```rust
fn main() {
    // String literals have 'static lifetime
    let s: &'static str = "I have a static lifetime.";
    
    // Lives for entire duration of program
    // Stored in binary
    
    println!("{}", s);
}
```

**Don't overuse 'static:**

```rust
// Bad: unnecessarily restrictive
fn bad_example(x: &'static str) -> &'static str {
    x
}

// Good: more flexible
fn good_example<'a>(x: &'a str) -> &'a str {
    x
}
```

**Multiple lifetime parameters:**

```rust
fn longest_with_announcement<'a, 'b>(
    x: &'a str,
    y: &'a str,
    ann: &'b str,
) -> &'a str {
    println!("Announcement: {}", ann);
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```

---

## 🧑‍🏫 Bài 5: Smart Pointers cơ bản

### Box`<T>`

**Heap allocation:**

```rust
fn main() {
    // Store i32 on heap
    let b = Box::new(5);
    println!("b = {}", b);
    
    // Automatically dereferenced
    let x = *b + 10;
    println!("x = {}", x);
}  // b dropped, heap memory freed
```

**When to use Box:**

1. Unknown size at compile time
2. Transfer ownership of large data without copying
3. Trait objects

**Recursive types:**

```rust
// ERROR: infinite size
// enum List {
//     Cons(i32, List),
//     Nil,
// }

// OK: Box has known size
enum List {
    Cons(i32, Box<List>),
    Nil,
}

use List::{Cons, Nil};

fn main() {
    let list = Cons(1, Box::new(Cons(2, Box::new(Cons(3, Box::new(Nil))))));
    
    print_list(&list);
}

fn print_list(list: &List) {
    match list {
        Cons(value, next) => {
            print!("{} -> ", value);
            print_list(next);
        }
        Nil => println!("Nil"),
    }
}
```

**Large data on heap:**

```rust
fn main() {
    // Stack allocated (expensive to move)
    let large_array = [0; 1000000];
    
    // Heap allocated (cheap to move, just pointer)
    let boxed_array = Box::new([0; 1000000]);
    
    // Moving boxed_array just moves the pointer
    let moved = boxed_array;
}
```

### Rc`<T>` - Reference Counting

**Multiple ownership:**

```rust
use std::rc::Rc;

fn main() {
    let a = Rc::new(5);
    println!("Count: {}", Rc::strong_count(&a));  // 1
    
    let b = Rc::clone(&a);
    println!("Count: {}", Rc::strong_count(&a));  // 2
    
    {
        let c = Rc::clone(&a);
        println!("Count: {}", Rc::strong_count(&a));  // 3
    }
    
    println!("Count: {}", Rc::strong_count(&a));  // 2
}  // All cleaned up when count reaches 0
```

**Rc with list:**

```rust
use std::rc::Rc;

enum List {
    Cons(i32, Rc<List>),
    Nil,
}

use List::{Cons, Nil};

fn main() {
    let a = Rc::new(Cons(5, Rc::new(Cons(10, Rc::new(Nil)))));
    println!("Count after creating a: {}", Rc::strong_count(&a));
    
    let b = Cons(3, Rc::clone(&a));
    println!("Count after creating b: {}", Rc::strong_count(&a));
    
    {
        let c = Cons(4, Rc::clone(&a));
        println!("Count after creating c: {}", Rc::strong_count(&a));
    }
    
    println!("Count after c goes out of scope: {}", Rc::strong_count(&a));
}
```

**Rc limitations:**

- Single-threaded only (use `Arc` for multi-threaded)
- Immutable only (use `RefCell` for mutability)

### RefCell`<T>` - Interior Mutability

**Mutate through immutable reference:**

```rust
use std::cell::RefCell;

fn main() {
    let x = RefCell::new(5);
    
    // Borrow immutably
    {
        let borrowed = x.borrow();
        println!("Value: {}", *borrowed);
    }  // borrowed dropped
    
    // Borrow mutably
    {
        let mut borrowed_mut = x.borrow_mut();
        *borrowed_mut += 10;
    }  // borrowed_mut dropped
    
    println!("New value: {}", x.borrow());
}
```

**Runtime borrowing rules:**

```rust
use std::cell::RefCell;

fn main() {
    let x = RefCell::new(5);
    
    let a = x.borrow();
    let b = x.borrow();  // OK: multiple immutable borrows
    
    // let c = x.borrow_mut();  // PANIC! Can't borrow mutably while immutably borrowed
    
    drop(a);
    drop(b);
    
    let d = x.borrow_mut();  // OK: no other borrows
}
```

**When to use RefCell:**

- Need mutability through shared reference
- Testing/mocking
- Cache/memoization
- Complex data structures

### Combining Rc và RefCell

**Multiple ownership with mutability:**

```rust
use std::rc::Rc;
use std::cell::RefCell;

fn main() {
    let value = Rc::new(RefCell::new(5));
    
    let a = Rc::clone(&value);
    let b = Rc::clone(&value);
    
    *value.borrow_mut() += 10;
    
    println!("value: {}", value.borrow());
    println!("a: {}", a.borrow());
    println!("b: {}", b.borrow());
}
```

**Shared mutable list:**

```rust
use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug)]
enum List {
    Cons(Rc<RefCell<i32>>, Rc<List>),
    Nil,
}

use List::{Cons, Nil};

fn main() {
    let value = Rc::new(RefCell::new(5));
    
    let a = Rc::new(Cons(Rc::clone(&value), Rc::new(Nil)));
    let b = Cons(Rc::new(RefCell::new(3)), Rc::clone(&a));
    let c = Cons(Rc::new(RefCell::new(4)), Rc::clone(&a));
    
    *value.borrow_mut() += 10;
    
    println!("a: {:?}", a);
    println!("b: {:?}", b);
    println!("c: {:?}", c);
}
```

### Memory leaks và prevention

**Reference cycles cause leaks:**

```rust
use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug)]
struct Node {
    value: i32,
    next: RefCell<Option<Rc<Node>>>,
}

fn main() {
    let a = Rc::new(Node {
        value: 5,
        next: RefCell::new(None),
    });
    
    let b = Rc::new(Node {
        value: 10,
        next: RefCell::new(Some(Rc::clone(&a))),
    });
    
    // Create cycle
    *a.next.borrow_mut() = Some(Rc::clone(&b));
    
    // Memory leak! a and b reference each other
    // Neither will be dropped
}
```

**Prevention with Weak:**

```rust
use std::rc::{Rc, Weak};
use std::cell::RefCell;

#[derive(Debug)]
struct Node {
    value: i32,
    next: RefCell<Option<Rc<Node>>>,
    prev: RefCell<Weak<Node>>,  // Weak reference
}

fn main() {
    let a = Rc::new(Node {
        value: 5,
        next: RefCell::new(None),
        prev: RefCell::new(Weak::new()),
    });
    
    let b = Rc::new(Node {
        value: 10,
        next: RefCell::new(Some(Rc::clone(&a))),
        prev: RefCell::new(Weak::new()),
    });
    
    // Set prev with weak reference
    *a.prev.borrow_mut() = Rc::downgrade(&b);
    
    // No cycle! b -> a (strong), a -> b (weak)
    // When b dropped, a can be dropped too
}
```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Hệ thống quản lý sinh viên

### Mô tả bài toán

Xây dựng hệ thống quản lý sinh viên với các chức năng:

- Thêm, sửa, xóa sinh viên
- Quản lý điểm số (thêm, sửa, xóa môn học)
- Tính điểm trung bình
- Xếp loại sinh viên
- Tìm kiếm và lọc
- Lưu/load từ file
- Undo/Redo operations

**Yêu cầu đặc biệt về Ownership:**

- Sử dụng `Rc<RefCell<>>` cho shared mutable state
- Implement proper borrowing trong các methods
- Avoid memory leaks (no reference cycles)
- Use lifetimes cho các references
- Implement custom Drop trait

### Yêu cầu

**1. Data structures:**

```rust
use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, Clone)]
struct Student {
    id: u32,
    name: String,
    age: u8,
    grades: Vec<Grade>,
}

#[derive(Debug, Clone)]
struct Grade {
    subject: String,
    score: f32,
}

struct StudentManager {
    students: Vec<Rc<RefCell<Student>>>,
    next_id: u32,
    history: Vec<Operation>,  // For undo/redo
}

enum Operation {
    AddStudent(Rc<RefCell<Student>>),
    RemoveStudent(u32),
    UpdateStudent(u32, Student),
}
```

**2. Core methods:**

```rust
impl StudentManager {
    fn new() -> Self;
    fn add_student(&mut self, name: String, age: u8) -> Rc<RefCell<Student>>;
    fn remove_student(&mut self, id: u32) -> Result<(), String>;
    fn find_student(&self, id: u32) -> Option<Rc<RefCell<Student>>>;
    fn update_student(&mut self, id: u32, name: Option<String>, age: Option<u8>);
}

impl Student {
    fn add_grade(&mut self, subject: String, score: f32);
    fn update_grade(&mut self, subject: &str, score: f32) -> Result<(), String>;
    fn remove_grade(&mut self, subject: &str) -> Result<(), String>;
    fn average_grade(&self) -> f32;
    fn classification(&self) -> &str;  // Excellent/Good/Average/Poor
}
```

**3. Advanced features:**

- Iterator for students
- Filter by grade range
- Sort by name/grade
- Export to JSON
- Lifetime annotations cho search results

**Template code:**

```rust
use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, Clone)]
struct Student {
    id: u32,
    name: String,
    age: u8,
    grades: Vec<Grade>,
}

#[derive(Debug, Clone)]
struct Grade {
    subject: String,
    score: f32,
}

impl Student {
    fn new(id: u32, name: String, age: u8) -> Self {
        Student {
            id,
            name,
            age,
            grades: Vec::new(),
        }
    }
    
    fn add_grade(&mut self, subject: String, score: f32) {
        // TODO: Validate score (0-100)
        // TODO: Check if subject already exists
        self.grades.push(Grade { subject, score });
    }
    
    fn average_grade(&self) -> f32 {
        if self.grades.is_empty() {
            return 0.0;
        }
        
        let sum: f32 = self.grades.iter().map(|g| g.score).sum();
        sum / self.grades.len() as f32
    }
    
    fn classification(&self) -> &str {
        let avg = self.average_grade();
        match avg {
            90.0..=100.0 => "Excellent",
            80.0..=89.9 => "Good",
            70.0..=79.9 => "Average",
            60.0..=69.9 => "Below Average",
            _ => "Poor",
        }
    }
    
    fn display(&self) {
        println!("ID: {}", self.id);
        println!("Name: {}", self.name);
        println!("Age: {}", self.age);
        println!("Grades:");
        for grade in &self.grades {
            println!("  {}: {:.2}", grade.subject, grade.score);
        }
        println!("Average: {:.2}", self.average_grade());
        println!("Classification: {}", self.classification());
    }
}

struct StudentManager {
    students: Vec<Rc<RefCell<Student>>>,
    next_id: u32,
}

impl StudentManager {
    fn new() -> Self {
        StudentManager {
            students: Vec::new(),
            next_id: 1,
        }
    }
    
    fn add_student(&mut self, name: String, age: u8) -> Rc<RefCell<Student>> {
        let student = Rc::new(RefCell::new(Student::new(self.next_id, name, age)));
        self.next_id += 1;
        self.students.push(Rc::clone(&student));
        student
    }
    
    fn find_student(&self, id: u32) -> Option<Rc<RefCell<Student>>> {
        // TODO: Implement binary search if sorted
        for student in &self.students {
            if student.borrow().id == id {
                return Some(Rc::clone(student));
            }
        }
        None
    }
    
    fn remove_student(&mut self, id: u32) -> Result<(), String> {
        // TODO: Implement
        let index = self.students.iter()
            .position(|s| s.borrow().id == id)
            .ok_or("Student not found")?;
        
        self.students.remove(index);
        Ok(())
    }
    
    fn list_all(&self) {
        println!("\n=== All Students ===");
        for student in &self.students {
            student.borrow().display();
            println!("---");
        }
    }
    
    fn find_by_name<'a>(&'a self, name: &str) -> Vec<Rc<RefCell<Student>>> {
        // TODO: Use lifetime annotations
        self.students.iter()
            .filter(|s| s.borrow().name.contains(name))
            .map(|s| Rc::clone(s))
            .collect()
    }
    
    fn save_to_file(&self, filename: &str) {
        // TODO: Implement serialization
        unimplemented!()
    }
    
    fn load_from_file(&mut self, filename: &str) {
        // TODO: Implement deserialization
        unimplemented!()
    }
}

fn main() {
    let mut manager = StudentManager::new();
    
    // Add students
    let alice = manager.add_student(String::from("Alice"), 20);
    let bob = manager.add_student(String::from("Bob"), 21);
    
    // Add grades
    alice.borrow_mut().add_grade(String::from("Math"), 95.0);
    alice.borrow_mut().add_grade(String::from("Physics"), 88.0);
    alice.borrow_mut().add_grade(String::from("Chemistry"), 92.0);
    
    bob.borrow_mut().add_grade(String::from("Math"), 78.0);
    bob.borrow_mut().add_grade(String::from("Physics"), 85.0);
    
    // Display all
    manager.list_all();
    
    // Find student
    if let Some(student) = manager.find_student(1) {
        println!("\nFound student:");
        student.borrow().display();
    }
    
    // Search by name
    let results = manager.find_by_name("Alice");
    println!("\nSearch results for 'Alice': {} students", results.len());
    
    // TODO: Implement menu system with all features
}
```

**Yêu cầu mở rộng:**

1. **Undo/Redo:**
   - Lưu lại history của operations
   - Implement undo/redo stack

2. **Filtering & Sorting:**
   - Filter by grade range
   - Sort by multiple criteria
   - Iterator pattern

3. **Validation:**
   - Age range (15-100)
   - Score range (0-100)
   - Name không rỗng
   - Không duplicate subject trong grades

4. **Advanced ownership:**
   - Implement course sharing (nhiều students cùng course)
   - Use `Weak<>` để tránh cycles
   - Custom Drop trait để cleanup

5. **Performance:**
   - Use HashMap thay vì Vec để O(1) lookup
   - Lazy evaluation cho statistics
   - Benchmark các operations

6. **Persistence:**
   - Serialize với `serde_json`
   - Auto-save every N operations
   - Import/Export CSV
