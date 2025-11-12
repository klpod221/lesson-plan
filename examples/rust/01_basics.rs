// Basic Rust program demonstrating variables, data types, and control flow

fn main() {
    println!("=== Variables and Data Types ===");
    
    // Immutable by default
    let x = 5;
    println!("x = {}", x);
    
    // Mutable variable
    let mut y = 10;
    println!("y = {}", y);
    y = 20;
    println!("y after mutation = {}", y);
    
    // Type annotation
    let z: i32 = 30;
    let pi: f64 = 3.14;
    let is_rust_awesome: bool = true;
    let letter: char = 'R';
    
    println!("z = {}, pi = {}, awesome = {}, letter = {}", z, pi, is_rust_awesome, letter);
    
    // Tuples
    let person: (&str, i32) = ("Alice", 25);
    println!("Name: {}, Age: {}", person.0, person.1);
    
    // Arrays
    let numbers = [1, 2, 3, 4, 5];
    println!("First number: {}", numbers[0]);
    println!("Array length: {}", numbers.len());
    
    println!("\n=== Control Flow ===");
    
    // If-else
    let number = 7;
    if number < 5 {
        println!("{} is less than 5", number);
    } else if number == 5 {
        println!("{} equals 5", number);
    } else {
        println!("{} is greater than 5", number);
    }
    
    // Loop
    println!("\nLoop 5 times:");
    let mut counter = 0;
    loop {
        counter += 1;
        println!("  Counter: {}", counter);
        if counter >= 5 {
            break;
        }
    }
    
    // While loop
    println!("\nWhile loop:");
    let mut n = 3;
    while n > 0 {
        println!("  {}", n);
        n -= 1;
    }
    println!("  Liftoff!");
    
    // For loop
    println!("\nFor loop:");
    for i in 1..=5 {
        println!("  {}", i);
    }
    
    // For with array
    println!("\nIterating array:");
    let fruits = ["Apple", "Banana", "Orange"];
    for fruit in fruits.iter() {
        println!("  {}", fruit);
    }
    
    println!("\n=== Functions ===");
    greet("Bob");
    let sum = add(10, 20);
    println!("Sum: {}", sum);
    
    let (min, max) = find_min_max(&[5, 2, 8, 1, 9]);
    println!("Min: {}, Max: {}", min, max);
}

fn greet(name: &str) {
    println!("Hello, {}!", name);
}

fn add(a: i32, b: i32) -> i32 {
    a + b  // No semicolon means return
}

fn find_min_max(numbers: &[i32]) -> (i32, i32) {
    let mut min = numbers[0];
    let mut max = numbers[0];
    
    for &num in numbers {
        if num < min {
            min = num;
        }
        if num > max {
            max = num;
        }
    }
    
    (min, max)
}
