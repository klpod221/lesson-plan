---
prev:
  text: '📈 Personal Development'
  link: '/SELF-LEARNING/Part4'
next:
  text: '📊 Arrays, Strings and Functions'
  link: '/JAVA/Part2'
---

# 📘 PART 1: INTRODUCTION TO JAVA

## 🎯 General Objectives

- Get familiar with Java syntax and program organization.
- Learn how to declare variables, use data types, conditional statements, and loops.

## 🧑‍🏫 Lesson 1: Java Program Structure

### Basic Java project organization

- Files with `.java` extension contain Java source code
- Each `.java` file contains at least one class
- File name must match the class name containing the `main` method

### The main method

```java
// file HelloWorld.java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```

### Explanation

- `public class HelloWorld`: Defines a class named HelloWorld
- `public static void main(String[] args)`: The main method - the entry point of the program
- `System.out.println()`: Statement to print to console

### Naming conventions

- Class: Capitalize the first letter of each word (PascalCase) - `HelloWorld`, `StudentManager`
- Variables and methods: First letter lowercase, subsequent words capitalized (camelCase) - `studentName`, `calculateTotal`
- Constants: All uppercase, words separated by underscores - `MAX_SIZE`, `PI_VALUE`

### Running the program

- Use `javac` command to compile source code into bytecode
- Use `java` command to run the program

```bash
javac HelloWorld.java  # Compile
java HelloWorld        # Run the program
```

- The result will be:

```text
Hello, World!
```

### Compiling and running programs from VS Code

- If you have installed the [Java Extension Pack](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack), you can open a `.java` file and press `Ctrl + F5` to compile and run the program.
- The result will be displayed in the VS Code integrated terminal.
- You can refer to [debugging Java in VS Code](https://code.visualstudio.com/docs/java/java-debugging) to learn how to debug Java programs.

### Reading input from keyboard

- Java provides the `Scanner` class from the `java.util` package to read input data:

```java
import java.util.Scanner;

public class InputExample {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter name: ");
        String name = scanner.nextLine();

        System.out.print("Enter age: ");
        int age = scanner.nextInt();

        System.out.println("Your name is: " + name);
        System.out.println("Your age is: " + age);

        scanner.close(); // Close Scanner to release resources
    }
}
```

Result:

```text
Enter name: Nguyen Van A
Enter age: 25
Your name is: Nguyen Van A
Your age is: 25
```

#### Basic input methods

| Method | Data Type | Description |
|--------|-----------|-------------|
| `nextInt()` | `int` | Read integer |
| `nextDouble()` | `double` | Read floating-point number |
| `nextBoolean()` | `boolean` | Read boolean value (true/false) |
| `next()` | `String` | Read one word (until whitespace) |
| `nextLine()` | `String` | Read a complete line |

#### Common issues and solutions

1. **Buffer line feed issue**:

   When using `nextInt()`, `nextDouble()` or similar methods, the newline character (`\n`) remains in the input buffer. If you then call `nextLine()`, it will read this newline character instead of new input.

   ```java
   int number = scanner.nextInt();     // Enter number
   scanner.nextLine();                 // Read remaining newline character
   String text = scanner.nextLine();    // Enter new text
   ```

2. **Reading multiple values on one line**:

   ```java
   // Method 1: Input string and split
   String input = scanner.nextLine();          // Example: "10 20 30"
   String[] values = input.split(" ");         // Split string into array
   int a = Integer.parseInt(values[0]);        // 10
   int b = Integer.parseInt(values[1]);        // 20
   
   // Method 2: Use next() consecutively
   int x = scanner.nextInt();                  // Read first number
   int y = scanner.nextInt();                  // Read next number
   ```

3. **Exception handling**:

   When user input doesn't match the expected format, handle it to prevent program crashes:

   ```java
   try {
       int number = scanner.nextInt();
   } catch (InputMismatchException e) {
       System.out.println("Please enter an integer!");
       scanner.nextLine(); // Clear invalid input
   }
   ```

4. **Safe input method**:

   ```java
   Scanner scanner = new Scanner(System.in);
   int number = 0;
   boolean validInput = false;
   
   while (!validInput) {
       System.out.print("Enter an integer: ");
       try {
           number = Integer.parseInt(scanner.nextLine());
           validInput = true;
       } catch (NumberFormatException e) {
           System.out.println("Error: Please enter a valid integer!");
       }
   }
   ```

**Important note**: Always close Scanner using the `close()` method when no longer needed to avoid resource leaks.

### Displaying data to screen

Java provides multiple ways to display data to the console:

#### Basic display methods

```java
// Print with newline
System.out.println("Hello World");    // Print "Hello World" and add newline

// Print without newline
System.out.print("Hello ");           // Print "Hello " without newline
System.out.print("World");            // Print "World" continues after "Hello "

// Formatted print (similar to printf in C)
System.out.printf("Hello %s, you are %d years old", "Nam", 25);
```

#### Displaying different data types

```java
int age = 25;
double height = 1.75;
String name = "Nguyen Van A";

// String concatenation with +
System.out.println("Name: " + name + ", Age: " + age + ", Height: " + height + "m");

// Using String.format
String info = String.format("Name: %s, Age: %d, Height: %.2fm", name, age, height);
System.out.println(info);

// Using printf
System.out.printf("Name: %s, Age: %d, Height: %.2fm\n", name, age, height);
```

#### Special format specifiers

| Format | Description | Example |
|--------|-------------|---------|
| `%d` | Integer | `%d` → `123` |
| `%f` | Float | `%f` → `123.456000` |
| `%.2f` | Float (limit decimal places) | `%.2f` → `123.46` |
| `%s` | String | `%s` → `Hello` |
| `%c` | Character | `%c` → `A` |
| `%b` | Boolean | `%b` → `true` |
| `%n` | Newline | `%n` → newline |
| `%%` | Percent sign | `%%` → `%` |

#### Advanced formatting examples

```java
// Number formatting
System.out.printf("Integer: %d\n", 1234);             // 1234
System.out.printf("Integer (right-aligned 8 chars): %8d\n", 1234);  // "    1234"
System.out.printf("Integer (left-aligned 8 chars): %-8d\n", 1234); // "1234    "
System.out.printf("Integer (padded with zeros): %08d\n", 1234);  // "00001234"

// Float formatting
System.out.printf("Float: %f\n", 12.34);              // 12.340000
System.out.printf("Float (rounded to 2 decimals): %.2f\n", 12.34567); // 12.35
System.out.printf("Currency: %,.2f đ\n", 1234567.89);    // 1,234,567.89 đ

// String formatting
System.out.printf("String: %s\n", "Hello");              // Hello
System.out.printf("String (uppercase): %S\n", "Hello");   // HELLO
System.out.printf("String (right-aligned 10 chars): %10s\n", "Hello"); // "     Hello"
System.out.printf("String (left-aligned 10 chars): %-10s\n", "Hello"); // "Hello     "
```

#### Format Method

Java also provides the `Formatter` class for string formatting:

```java
String formatted = String.format("Hello %s, you scored %.1f points", "Nam", 8.5);
System.out.println(formatted);  // Hello Nam, you scored 8.5 points

// Date formatting
import java.util.Date;
System.out.printf("Today is: %tD\n", new Date());  // MM/dd/yy format
```

**Note**: From Java 15 onwards, you can use text blocks (multi-line strings) with the `"""..."""` syntax:

```java
// From Java 15+
String html = """
              <html>
                  <body>
                      <h1>Hello!</h1>
                  </body>
              </html>
              """;
System.out.println(html);
```

## 🧑‍🏫 Lesson 2: Variables and Data Types

### Variable concept in Java

- Variables are memory locations to store data
- Each variable has a name, data type, and value

### Primitive data types

```java
int age = 25;                // Integer
double salary = 5000.50;     // Floating-point
char grade = 'A';            // Character
boolean isActive = true;     // Boolean value
```

### Reference data types

```java
String name = "Nguyen Van A";  // String
int[] numbers = {1, 2, 3, 4};  // Integer array
```

### Data storage in memory

For primitive types, the value is stored directly in the variable.
For reference types, the variable stores an address pointing to the actual data.

```text
┌─────────────┐
│  Variable: age  │
├─────────────┤
│     25      │  ◄── Value is stored in memory cell
└─────────────┘

┌───────────────┐
│ Variable: salary  │
├───────────────┤
│    5000.50    │
└───────────────┘

┌───────────────┐
│ Variable: name    │
├───────────────┤
│  0x12AB34CD   │  ◄── Address (reference) to another memory region
└───────────────┘
    │
    ▼
┌───────────────────────┐
│  "Nguyen Van A"       │  ◄── Actual data is located in another memory region
└───────────────────────┘
```

### Variable declaration and initialization

```java
// Declare and initialize later
int count;
count = 10;

// Declare and initialize together
double price = 19.99;

// Declare multiple variables of the same type
int x = 1, y = 2, z = 3;
```

### Type casting

```java
// Implicit casting (widening) - no data loss
int num = 10;
double numDouble = num;  // 10.0

// Explicit casting (narrowing) - may lose data
double pi = 3.14;
int wholePi = (int) pi;  // 3
```

## 🧑‍🏫 Lesson 3: Operators and Expressions

- Arithmetic operators: `+`, `-`, `*`, `/`, `%`
- Comparison operators: `==`, `!=`, `>`, `<`, `>=`, `<=`
- Logical operators: `&&`, `||`, `!`

### Arithmetic operators

```java
int a = 10, b = 3;
int sum = a + b;        // 13
int difference = a - b; // 7
int product = a * b;    // 30
int quotient = a / b;   // 3 (integer division)
int remainder = a % b;  // 1 (remainder)

// Increment/decrement operators
int i = 5;
i++;                   // i = 6 (post-increment)
++i;                   // i = 7 (pre-increment)
i--;                   // i = 6 (post-decrement)
--i;                   // i = 5 (pre-decrement)
```

### Assignment operators

```java
int x = 10;
x += 5;  // x = x + 5 = 15
x -= 3;  // x = x - 3 = 12
x *= 2;  // x = x * 2 = 24
x /= 4;  // x = x / 4 = 6
x %= 4;  // x = x % 4 = 2
```

### Comparison operators

```java
int p = 10, q = 20;
boolean isEqual = (p == q);       // false
boolean isNotEqual = (p != q);    // true
boolean isGreater = (p > q);      // false
boolean isLess = (p < q);         // true
boolean isGreaterOrEqual = (p >= q); // false
boolean isLessOrEqual = (p <= q);    // true
```

### Logical operators

```java
boolean condition1 = true;
boolean condition2 = false;

boolean andResult = condition1 && condition2;  // false
boolean orResult = condition1 || condition2;   // true
boolean notResult = !condition1;               // false
```

### Operator precedence

- Like in mathematics, operators have different precedence levels:
  - Inside parentheses before outside
  - Multiplication and division before addition and subtraction

1. Increment/decrement (`++`, `--`), negation (`!`)
2. Multiplication, division, modulus (`*`, `/`, `%`)
3. Addition, subtraction (`+`, `-`)
4. Comparison operators (`<`, `>`, `<=`, `>=`)
5. Equality operators (`==`, `!=`)
6. Logical AND (`&&`)
7. Logical OR (`||`)
8. Assignment operators (`=`, `+=`, `-=`, `*=`, `/=`, `%=`)

### Precedence examples

```java
int result = 5 + 3 * 2;  // 5 + 6 = 11 (multiply first, then add)
int result2 = (5 + 3) * 2;  // 8 * 2 = 16 (parentheses have highest precedence)
```

## 🧑‍🏫 Lesson 4: Conditional Statements

### If statement

```java
int age = 18;

// Simple if statement
if (age >= 18) {
    System.out.println("You are eligible to vote");
}

// If-else statement
if (age >= 18) {
    System.out.println("You are eligible to vote");
} else {
    System.out.println("You are not eligible to vote");
}

// If-else if-else statement
int score = 75;
if (score >= 90) {
    System.out.println("Excellent");
} else if (score >= 80) {
    System.out.println("Very Good");
} else if (score >= 70) {
    System.out.println("Good");
} else if (score >= 60) {
    System.out.println("Average");
} else {
    System.out.println("Poor");
}
```

### Switch-case statement

```java
int day = 3;
String dayName;

switch (day) {
    case 1:
        dayName = "Sunday";
        break;
    case 2:
        dayName = "Monday";
        break;
    case 3:
        dayName = "Tuesday";
        break;
    case 4:
        dayName = "Wednesday";
        break;
    case 5:
        dayName = "Thursday";
        break;
    case 6:
        dayName = "Friday";
        break;
    case 7:
        dayName = "Saturday";
        break;
    default:
        dayName = "Invalid day";
}
System.out.println("Today is " + dayName);  // Today is Tuesday
```

### Switch with Java 12+ (new syntax)

```java
int day = 3;
String dayType = switch (day) {
    case 1, 7 -> "Weekend";
    case 2, 3, 4, 5, 6 -> "Weekday";
    default -> "Invalid day";
};
```

### Complex conditional expressions

```java
int age = 25;
boolean hasID = true;
boolean isResident = true;

// Using AND (&&)
if (age >= 18 && hasID) {
    System.out.println("You can vote");
}

// Using OR (||)
if (isResident || age >= 65) {
    System.out.println("You get a ticket discount");
}

// Combining multiple conditions
if ((age >= 18 && hasID) || (isResident && age >= 65)) {
    System.out.println("You have special privileges");
}
```

### Ternary operator

```java
int age = 20;
String status = (age >= 18) ? "Adult" : "Minor";
System.out.println(status);  // Adult
```

## 🧑‍🏫 Lesson 5: Loop Statements

### For loop

```java
// Print numbers from 1 to 5
for (int i = 1; i <= 5; i++) {
    System.out.println(i);
}

// Calculate sum of numbers from 1 to 10
int sum = 0;
for (int i = 1; i <= 10; i++) {
    sum += i;
}
System.out.println("Sum: " + sum);  // Sum: 55

// Enhanced for loop (for-each) - iterate array/collection
int[] numbers = {1, 2, 3, 4, 5};
for (int num : numbers) {
    System.out.println(num);
}
```

- Step-by-step explanation using for loop to calculate sum from 1 to 10:
- Initial values: sum = 0, i = 1
- Loop condition: i <= 10
  - Iteration 1: i = 1, sum = 0 + 1 = 1, i++
  - Iteration 2: i = 2, sum = 1 + 2 = 3, i++
  - Iteration 3: i = 3, sum = 3 + 3 = 6, i++
  - Iteration 4: i = 4, sum = 6 + 4 = 10, i++
  - Iteration 5: i = 5, sum = 10 + 5 = 15, i++
  - Iteration 6: i = 6, sum = 15 + 6 = 21, i++
  - Iteration 7: i = 7, sum = 21 + 7 = 28, i++
  - Iteration 8: i = 8, sum = 28 + 8 = 36, i++
  - Iteration 9: i = 9, sum = 36 + 9 = 45, i++
  - Iteration 10: i = 10, sum = 45 + 10 = 55, i++
  - Iteration 11: i = 11, condition not met, exit loop
- Final result: Sum = 55

### While loop

```java
// Print numbers from 1 to 5
int i = 1;
while (i <= 5) {
    System.out.println(i);
    i++;
}

// Find first number divisible by both 3 and 5
int num = 1;
// Check condition first, then execute
while (num <= 100) {
    if (num % 3 == 0 && num % 5 == 0) {
        System.out.println("First number divisible by both 3 and 5: " + num);
        break;
    }
    num++;
}
```

### Do-while loop

```java
// Print numbers from 1 to 5
int i = 1;
do {
    System.out.println(i);
    i++;
} while (i <= 5);

// Simulate menu selection
int choice;
// Execute at least once, then check condition
do {
    System.out.println("\nMenu:");
    System.out.println("1. View list");
    System.out.println("2. Add new");
    System.out.println("3. Delete");
    System.out.println("0. Exit");

    choice = 1; // Assume user selects 1

    switch (choice) {
        case 1:
            System.out.println("Displaying list...");
            break;
        case 2:
            System.out.println("Adding new...");
            break;
        case 3:
            System.out.println("Deleting...");
            break;
        case 0:
            System.out.println("Exiting...");
            break;
        default:
            System.out.println("Invalid choice!");
    }
} while (choice != 0);
```

### Break and continue keywords

```java
// Using break to exit loop
for (int i = 1; i <= 10; i++) {
    if (i == 5) {
        break;  // Exit loop when i = 5
    }
    System.out.println(i);  // Print: 1, 2, 3, 4
}

// Using continue to skip current iteration
for (int i = 1; i <= 5; i++) {
    if (i == 3) {
        continue;  // Skip iteration when i = 3
    }
    System.out.println(i);  // Print: 1, 2, 4, 5
}

// Nested loops with label
outerLoop: for (int i = 1; i <= 3; i++) {
    for (int j = 1; j <= 3; j++) {
        if (i * j > 5) {
            break outerLoop;  // Exit outer loop
        }
        System.out.println(i + " * " + j + " = " + (i * j));
    }
}
```

## 🧪 Final Project: Student Grade Management

### Problem Description

Write a program that allows users to:

- Enter student name and scores for 3 subjects (Math, Physics, Chemistry)
- Calculate average score
- Classify academic performance according to criteria:
  - AVG >= 8.0 → Excellent
  - 6.5 <= AVG < 8.0 → Very Good
  - 5.0 <= AVG < 6.5 → Average
  - < 5.0 → Poor
- Print student information table and classification result

### Program Output (Example)

```text
STUDENT GRADE MANAGEMENT PROGRAM
-----------------------------------
Enter student name: Nguyen Van A
Enter Math score: 8.5
Enter Physics score: 7.5
Enter Chemistry score: 9.0

CLASSIFICATION RESULT
-----------------------------------
Student: Nguyen Van A
Math score: 8.5
Physics score: 7.5
Chemistry score: 9.0
Average score: 8.33
Classification: Excellent
```
