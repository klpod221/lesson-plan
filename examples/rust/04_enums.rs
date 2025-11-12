// Enums and pattern matching

#[derive(Debug)]
enum IpAddrKind {
    V4,
    V6,
}

#[derive(Debug)]
enum IpAddr {
    V4(u8, u8, u8, u8),
    V6(String),
}

#[derive(Debug)]
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(u8, u8, u8),
}

impl Message {
    fn call(&self) {
        match self {
            Message::Quit => println!("Quit message"),
            Message::Move { x, y } => println!("Move to ({}, {})", x, y),
            Message::Write(text) => println!("Write: {}", text),
            Message::ChangeColor(r, g, b) => println!("Change color to RGB({}, {}, {})", r, g, b),
        }
    }
}

fn main() {
    println!("=== Basic Enums ===");
    
    let four = IpAddrKind::V4;
    let six = IpAddrKind::V6;
    
    println!("{:?}", four);
    println!("{:?}", six);
    
    println!("\n=== Enums with Data ===");
    
    let home = IpAddr::V4(127, 0, 0, 1);
    let loopback = IpAddr::V6(String::from("::1"));
    
    println!("Home: {:?}", home);
    println!("Loopback: {:?}", loopback);
    
    println!("\n=== Complex Enums ===");
    
    let messages = vec![
        Message::Quit,
        Message::Move { x: 10, y: 20 },
        Message::Write(String::from("Hello")),
        Message::ChangeColor(255, 0, 0),
    ];
    
    for msg in messages {
        msg.call();
    }
    
    println!("\n=== Pattern Matching ===");
    
    let number = 7;
    match number {
        1 => println!("One"),
        2 | 3 | 5 | 7 | 11 => println!("Prime number"),
        13..=19 => println!("Teen"),
        _ => println!("Other"),
    }
    
    let ip = IpAddr::V4(192, 168, 1, 1);
    match ip {
        IpAddr::V4(a, b, c, d) => {
            println!("IPv4 address: {}.{}.{}.{}", a, b, c, d);
        }
        IpAddr::V6(addr) => {
            println!("IPv6 address: {}", addr);
        }
    }
    
    println!("\n=== Option<T> ===");
    
    let some_number = Some(5);
    let no_number: Option<i32> = None;
    
    println!("some_number: {:?}", some_number);
    println!("no_number: {:?}", no_number);
    
    // Pattern matching with Option
    match some_number {
        Some(n) => println!("Got a number: {}", n),
        None => println!("No number"),
    }
    
    // if let
    if let Some(n) = some_number {
        println!("Number is: {}", n);
    }
    
    // Using Option in functions
    let result = divide(10.0, 2.0);
    match result {
        Some(value) => println!("Result: {}", value),
        None => println!("Cannot divide by zero"),
    }
    
    let result = divide(10.0, 0.0);
    match result {
        Some(value) => println!("Result: {}", value),
        None => println!("Cannot divide by zero"),
    }
    
    println!("\n=== Result<T, E> ===");
    
    match parse_number("42") {
        Ok(n) => println!("Parsed number: {}", n),
        Err(e) => println!("Error: {}", e),
    }
    
    match parse_number("abc") {
        Ok(n) => println!("Parsed number: {}", n),
        Err(e) => println!("Error: {}", e),
    }
}

fn divide(a: f64, b: f64) -> Option<f64> {
    if b == 0.0 {
        None
    } else {
        Some(a / b)
    }
}

fn parse_number(s: &str) -> Result<i32, String> {
    match s.parse::<i32>() {
        Ok(n) => Ok(n),
        Err(_) => Err(String::from("Failed to parse number")),
    }
}
