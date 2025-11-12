// Ownership and borrowing examples

fn main() {
    println!("=== Ownership ===");
    
    // Move semantics
    let s1 = String::from("hello");
    let s2 = s1;  // s1 is moved to s2
    // println!("{}", s1);  // ERROR: s1 is no longer valid
    println!("s2: {}", s2);
    
    // Clone for deep copy
    let s3 = String::from("world");
    let s4 = s3.clone();
    println!("s3: {}, s4: {}", s3, s4);
    
    // Copy trait for stack data
    let x = 5;
    let y = x;  // x is copied, not moved
    println!("x: {}, y: {}", x, y);
    
    println!("\n=== Functions and Ownership ===");
    
    let text = String::from("Rust");
    takes_ownership(text);
    // println!("{}", text);  // ERROR: text was moved
    
    let number = 42;
    makes_copy(number);
    println!("number is still valid: {}", number);
    
    let s5 = gives_ownership();
    println!("s5: {}", s5);
    
    let s6 = String::from("hello");
    let s7 = takes_and_gives_back(s6);
    println!("s7: {}", s7);
    
    println!("\n=== References and Borrowing ===");
    
    let s = String::from("Rust programming");
    let len = calculate_length(&s);  // Borrow s
    println!("Length of '{}' is {}", s, len);  // s is still valid
    
    // Mutable reference
    let mut s = String::from("hello");
    change(&mut s);
    println!("Changed: {}", s);
    
    // Multiple immutable references
    let s = String::from("test");
    let r1 = &s;
    let r2 = &s;
    println!("r1: {}, r2: {}", r1, r2);
    
    // Only one mutable reference
    let mut s = String::from("test");
    let r1 = &mut s;
    // let r2 = &mut s;  // ERROR: cannot borrow as mutable more than once
    println!("r1: {}", r1);
    
    println!("\n=== Slices ===");
    
    let s = String::from("hello world");
    let hello = &s[0..5];
    let world = &s[6..11];
    println!("{} {}", hello, world);
    
    let first = first_word(&s);
    println!("First word: {}", first);
    
    // Array slices
    let arr = [1, 2, 3, 4, 5];
    let slice = &arr[1..4];
    println!("Array slice: {:?}", slice);
}

fn takes_ownership(s: String) {
    println!("takes_ownership: {}", s);
}  // s goes out of scope and is dropped

fn makes_copy(n: i32) {
    println!("makes_copy: {}", n);
}  // n goes out of scope, nothing special happens

fn gives_ownership() -> String {
    String::from("yours")
}

fn takes_and_gives_back(s: String) -> String {
    s
}

fn calculate_length(s: &String) -> usize {
    s.len()
}  // s goes out of scope, but nothing is dropped

fn change(s: &mut String) {
    s.push_str(", world");
}

fn first_word(s: &String) -> &str {
    let bytes = s.as_bytes();
    
    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return &s[0..i];
        }
    }
    
    &s[..]
}
