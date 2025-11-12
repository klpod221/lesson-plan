// Collections: Vec, String, HashMap

use std::collections::HashMap;

fn main() {
    println!("=== Vectors ===");
    
    // Create vector
    let mut vec: Vec<i32> = Vec::new();
    vec.push(1);
    vec.push(2);
    vec.push(3);
    
    // Vector with macro
    let vec2 = vec![4, 5, 6];
    
    println!("vec: {:?}", vec);
    println!("vec2: {:?}", vec2);
    
    // Access elements
    let first = vec[0];
    println!("First element: {}", first);
    
    // Using get (returns Option)
    match vec.get(10) {
        Some(value) => println!("Value: {}", value),
        None => println!("Index out of bounds"),
    }
    
    // Iterate
    println!("Iterate:");
    for i in &vec {
        print!("{} ", i);
    }
    println!();
    
    // Mutable iterate
    let mut vec3 = vec![1, 2, 3, 4, 5];
    for i in &mut vec3 {
        *i *= 2;
    }
    println!("After doubling: {:?}", vec3);
    
    // Enum in vector for different types
    #[derive(Debug)]
    enum SpreadsheetCell {
        Int(i32),
        Float(f64),
        Text(String),
    }
    
    let row = vec![
        SpreadsheetCell::Int(3),
        SpreadsheetCell::Float(10.12),
        SpreadsheetCell::Text(String::from("blue")),
    ];
    println!("Row: {:?}", row);
    
    println!("\n=== Strings ===");
    
    let mut s = String::new();
    s.push_str("Hello");
    s.push(' ');
    s.push_str("World");
    println!("s: {}", s);
    
    // String from literal
    let s2 = String::from("Rust");
    let s3 = "Programming".to_string();
    
    // Concatenation
    let s4 = s2 + " " + &s3;  // s2 is moved
    println!("s4: {}", s4);
    
    // format! macro
    let s5 = String::from("Hello");
    let s6 = String::from("Rust");
    let s7 = format!("{} {}", s5, s6);  // s5 and s6 not moved
    println!("s7: {}", s7);
    
    // Iterating over strings
    println!("\nCharacters:");
    for c in "नमस्ते".chars() {
        print!("{} ", c);
    }
    println!();
    
    println!("Bytes:");
    for b in "नमस्ते".bytes() {
        print!("{} ", b);
    }
    println!();
    
    println!("\n=== HashMaps ===");
    
    let mut scores = HashMap::new();
    scores.insert(String::from("Blue"), 10);
    scores.insert(String::from("Red"), 50);
    
    println!("scores: {:?}", scores);
    
    // Access values
    let team_name = String::from("Blue");
    let score = scores.get(&team_name);
    match score {
        Some(s) => println!("Blue team score: {}", s),
        None => println!("Team not found"),
    }
    
    // Iterate
    println!("\nAll scores:");
    for (key, value) in &scores {
        println!("{}: {}", key, value);
    }
    
    // Overwriting
    scores.insert(String::from("Blue"), 25);
    println!("\nAfter update: {:?}", scores);
    
    // Only insert if key has no value
    scores.entry(String::from("Yellow")).or_insert(50);
    scores.entry(String::from("Blue")).or_insert(50);  // Won't overwrite
    println!("After entry: {:?}", scores);
    
    // Update based on old value
    let text = "hello world wonderful world";
    let mut map = HashMap::new();
    
    for word in text.split_whitespace() {
        let count = map.entry(word).or_insert(0);
        *count += 1;
    }
    
    println!("\nWord count: {:?}", map);
    
    println!("\n=== Practical Example: Student Grades ===");
    
    let mut student_grades: HashMap<String, Vec<i32>> = HashMap::new();
    
    student_grades.insert(String::from("Alice"), vec![85, 90, 92]);
    student_grades.insert(String::from("Bob"), vec![78, 82, 88]);
    student_grades.insert(String::from("Charlie"), vec![95, 97, 93]);
    
    for (name, grades) in &student_grades {
        let sum: i32 = grades.iter().sum();
        let avg = sum as f64 / grades.len() as f64;
        println!("{}: grades = {:?}, average = {:.2}", name, grades, avg);
    }
}
