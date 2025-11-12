// Structs and methods

#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    // Associated function (constructor)
    fn new(width: u32, height: u32) -> Rectangle {
        Rectangle { width, height }
    }
    
    fn square(size: u32) -> Rectangle {
        Rectangle {
            width: size,
            height: size,
        }
    }
    
    // Method
    fn area(&self) -> u32 {
        self.width * self.height
    }
    
    fn perimeter(&self) -> u32 {
        2 * (self.width + self.height)
    }
    
    fn can_hold(&self, other: &Rectangle) -> bool {
        self.width > other.width && self.height > other.height
    }
    
    fn scale(&mut self, factor: u32) {
        self.width *= factor;
        self.height *= factor;
    }
}

#[derive(Debug)]
struct Point {
    x: i32,
    y: i32,
}

impl Point {
    fn new(x: i32, y: i32) -> Point {
        Point { x, y }
    }
    
    fn distance_from_origin(&self) -> f64 {
        ((self.x.pow(2) + self.y.pow(2)) as f64).sqrt()
    }
}

// Tuple structs
#[derive(Debug)]
struct Color(u8, u8, u8);

fn main() {
    println!("=== Creating Structs ===");
    
    let rect1 = Rectangle {
        width: 30,
        height: 50,
    };
    
    println!("rect1: {:?}", rect1);
    println!("Area: {}", rect1.area());
    println!("Perimeter: {}", rect1.perimeter());
    
    // Using associated function
    let rect2 = Rectangle::new(20, 40);
    let square = Rectangle::square(25);
    
    println!("\n=== Comparing Rectangles ===");
    println!("rect1 can hold rect2: {}", rect1.can_hold(&rect2));
    println!("rect2 can hold rect1: {}", rect2.can_hold(&rect1));
    
    println!("\n=== Mutable Structs ===");
    let mut rect3 = Rectangle::new(10, 20);
    println!("Before scale: {:?}", rect3);
    rect3.scale(2);
    println!("After scale: {:?}", rect3);
    
    println!("\n=== Points ===");
    let p1 = Point::new(3, 4);
    let p2 = Point::new(0, 0);
    
    println!("p1: {:?}", p1);
    println!("Distance from origin: {:.2}", p1.distance_from_origin());
    println!("p2: {:?}", p2);
    println!("Distance from origin: {:.2}", p2.distance_from_origin());
    
    println!("\n=== Tuple Structs ===");
    let red = Color(255, 0, 0);
    let green = Color(0, 255, 0);
    let blue = Color(0, 0, 255);
    
    println!("Red: {:?}", red);
    println!("Green: {:?}", green);
    println!("Blue: {:?}", blue);
    
    // Access tuple struct fields
    println!("Red RGB: ({}, {}, {})", red.0, red.1, red.2);
}
