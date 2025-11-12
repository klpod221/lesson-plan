// Traits and generics

use std::fmt::{self, Display};

// Define a trait
trait Summary {
    fn summarize(&self) -> String;
    
    // Default implementation
    fn default_summary(&self) -> String {
        String::from("(Read more...)")
    }
}

struct NewsArticle {
    headline: String,
    location: String,
    author: String,
    content: String,
}

impl Summary for NewsArticle {
    fn summarize(&self) -> String {
        format!("{}, by {} ({})", self.headline, self.author, self.location)
    }
}

struct Tweet {
    username: String,
    content: String,
    reply: bool,
    retweet: bool,
}

impl Summary for Tweet {
    fn summarize(&self) -> String {
        format!("{}: {}", self.username, self.content)
    }
}

// Trait as parameter
fn notify(item: &impl Summary) {
    println!("Breaking news! {}", item.summarize());
}

// Trait bound syntax
fn notify2<T: Summary>(item: &T) {
    println!("Breaking news! {}", item.summarize());
}

// Multiple trait bounds
fn notify3<T: Summary + Display>(item: &T) {
    println!("{}", item);
}

// Generic functions
fn largest<T: PartialOrd>(list: &[T]) -> &T {
    let mut largest = &list[0];
    
    for item in list {
        if item > largest {
            largest = item;
        }
    }
    
    largest
}

// Generic struct
#[derive(Debug)]
struct Point<T> {
    x: T,
    y: T,
}

impl<T> Point<T> {
    fn new(x: T, y: T) -> Self {
        Point { x, y }
    }
}

impl Point<f64> {
    fn distance_from_origin(&self) -> f64 {
        (self.x.powi(2) + self.y.powi(2)).sqrt()
    }
}

// Generic with multiple types
#[derive(Debug)]
struct Pair<T, U> {
    first: T,
    second: U,
}

impl<T, U> Pair<T, U> {
    fn new(first: T, second: U) -> Self {
        Pair { first, second }
    }
    
    fn get_first(&self) -> &T {
        &self.first
    }
    
    fn get_second(&self) -> &U {
        &self.second
    }
}

// Trait for custom display
struct Rectangle {
    width: u32,
    height: u32,
}

impl Display for Rectangle {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "Rectangle({}x{})", self.width, self.height)
    }
}

fn main() {
    println!("=== Traits ===");
    
    let article = NewsArticle {
        headline: String::from("Rust 1.70 Released"),
        location: String::from("Internet"),
        author: String::from("Rust Team"),
        content: String::from("The Rust team is happy to announce..."),
    };
    
    let tweet = Tweet {
        username: String::from("rustlang"),
        content: String::from("Rust is awesome!"),
        reply: false,
        retweet: false,
    };
    
    println!("Article: {}", article.summarize());
    println!("Tweet: {}", tweet.summarize());
    
    notify(&article);
    notify(&tweet);
    
    println!("\n=== Generics ===");
    
    let numbers = vec![34, 50, 25, 100, 65];
    let result = largest(&numbers);
    println!("Largest number: {}", result);
    
    let chars = vec!['y', 'm', 'a', 'q'];
    let result = largest(&chars);
    println!("Largest char: {}", result);
    
    println!("\n=== Generic Structs ===");
    
    let int_point = Point::new(5, 10);
    let float_point = Point::new(1.5, 4.2);
    
    println!("int_point: {:?}", int_point);
    println!("float_point: {:?}", float_point);
    println!("Distance from origin: {:.2}", float_point.distance_from_origin());
    
    let pair1 = Pair::new(10, 3.14);
    let pair2 = Pair::new("Hello", 42);
    
    println!("pair1: {:?}", pair1);
    println!("pair2: {:?}", pair2);
    
    println!("\n=== Custom Display ===");
    
    let rect = Rectangle {
        width: 30,
        height: 50,
    };
    
    println!("{}", rect);
    
    println!("\n=== Practical Example: Comparable ===");
    
    trait Comparable {
        fn is_greater_than(&self, other: &Self) -> bool;
        fn is_less_than(&self, other: &Self) -> bool;
        fn is_equal_to(&self, other: &Self) -> bool;
    }
    
    impl Comparable for i32 {
        fn is_greater_than(&self, other: &Self) -> bool {
            self > other
        }
        
        fn is_less_than(&self, other: &Self) -> bool {
            self < other
        }
        
        fn is_equal_to(&self, other: &Self) -> bool {
            self == other
        }
    }
    
    let a = 10;
    let b = 20;
    
    println!("{} > {}: {}", a, b, a.is_greater_than(&b));
    println!("{} < {}: {}", a, b, a.is_less_than(&b));
    println!("{} == {}: {}", a, b, a.is_equal_to(&b));
}
