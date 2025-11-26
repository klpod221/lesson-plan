---
prev:
  text: '☕ Introduction to Java'
  link: '/JAVA/Part1'
next:
  text: '🧩 Module 3: Object-Oriented Programming'
  link: '/JAVA/Part3'
---

# 📘 PART 2: ARRAYS, STRINGS AND FUNCTIONS

## 🎯 General Objectives

- Get familiar with using arrays to store and process data collections.
- Understand and work with strings in Java.
- Create and use functions to divide programs into independent logical blocks.

## 🧑‍🏫 Lesson 1: Arrays in Java

### Array concept

- **Array** is a data structure used to store multiple values of the same data type in a single variable.
- Array characteristics:
  - Fixed size after initialization
  - Elements are stored consecutively in memory
  - Elements can be accessed through index, starting from 0
  - Can be one-dimensional or multi-dimensional arrays

### Array declaration and initialization

```java
// Array declaration
int[] numbers;              // Method 1: data_type[] array_name;
int scores[];               // Method 2: data_type array_name[];

// Array initialization
numbers = new int[5];       // Initialize array with 5 elements, default is 0
scores = new int[]{90, 85, 75, 80, 95}; // Initialize and assign values

// Declare and initialize together
int[] grades = {92, 88, 78, 85, 90};  // Shorthand notation
```

### Multi-dimensional arrays

```java
// 2D array
int[][] matrix = new int[3][4]; // 3 rows, 4 columns array

// Initialize with values
int[][] grid = {
    {1, 2, 3},
    {4, 5, 6},
    {7, 8, 9}
};
```

### Array storage in memory

1. **One-dimensional array**:

   ```java
   int[] numbers = {10, 20, 30, 40, 50};
   ```

   ```text
   Variable numbers  →  [ Address ] → [ 10 | 20 | 30 | 40 | 50 ]
   (Reference)          (Heap)        [0]  [1]  [2]  [3]  [4]  (index)
   ```

2. **Two-dimensional array**:

   ```java
   int[][] matrix = {
       {1, 2, 3},
       {4, 5, 6},
       {7, 8, 9}
   };
   ```

   ```text
   Variable matrix    →  [ Address ] → [ Address row 0 ] → [ 1 | 2 | 3 ]
   (Reference)           (Heap)        [ Address row 1 ] → [ 4 | 5 | 6 ]
                                       [ Address row 2 ] → [ 7 | 8 | 9 ]
   ```

### Accessing and modifying elements

```java
int[] numbers = {10, 20, 30, 40, 50};

// Access element
System.out.println("3rd element: " + numbers[2]); // Result: 30

// Modify element
numbers[1] = 25; // Change value of 2nd element to 25

// Iterate array
for (int i = 0; i < numbers.length; i++) {
    System.out.println("Element " + i + ": " + numbers[i]);
}

// Iterate array using for-each
for (int num : numbers) {
    System.out.println(num);
}
```

### Real-world example - Calculate average score

```java
public class AverageCalculator {
    public static void main(String[] args) {
        double[] grades = {85.5, 90.0, 78.5, 92.5, 88.0};
        double sum = 0;

        for (double grade : grades) {
            sum += grade;
        }

        double average = sum / grades.length;
        System.out.println("Average score: " + average);
    }
}
```

## 🧑‍🏫 Lesson 2: Strings in Java

- Strings are objects in Java, not primitive data types.
- A string is an array of characters (char).
- Strings in Java are immutable, meaning the content of a string cannot be changed after creation.

### String declaration and initialization

   ```java
   // String declaration using literal
   String greeting = "Hello JAVA";

   // String declaration using constructor
   String message = new String("Learning JAVA is fun");
   ```

### Common String methods

   ```java
   String text = "Learn JAVA programming";

   // String length
   int length = text.length();  // length = 22

   // Get character at position
   char firstChar = text.charAt(0);  // 'L'

   // Substring extraction
   String subText = text.substring(6, 10);  // from position 6 to 9 => "JAVA"
    String subText2 = text.substring(6);     // from position 6 to end => "JAVA programming"

   // Find position of occurrence
   int position = text.indexOf("JAVA");  // 6

   // Convert to uppercase/lowercase
   String upperCase = text.toUpperCase();  // "LEARN JAVA PROGRAMMING"
   String lowerCase = text.toLowerCase();  // "learn java programming"

   // Concatenate strings
   String newText = text.concat(" basics");  // "Learn JAVA programming basics"

   // Replace string
   String replaced = text.replace("JAVA", "Python");  // "Learn Python programming"

   // Check starts/ends with
   boolean startsWith = text.startsWith("Learn");  // true
   boolean endsWith = text.endsWith("programming");    // true

   // Remove leading/trailing whitespace
   String trimmed = "  Hello  ".trim();  // "Hello"

   // Check if string is empty
   boolean empty = "".isEmpty();  // true
   ```

### String comparison

   ```java
   String str1 = "Hello";
   String str2 = "Hello";
   String str3 = new String("Hello");

   // Compare reference (memory location)
   System.out.println(str1 == str2);  // true (same reference in String pool)
   System.out.println(str1 == str3);  // false (different reference)

   // Compare value (content)
   System.out.println(str1.equals(str2));  // true
   System.out.println(str1.equals(str3));  // true

   // Compare ignoring case
   System.out.println("hello".equalsIgnoreCase("HELLO"));  // true
   ```

### Real-world example - Count words in string

   ```java
   public class WordCounter {
       public static void main(String[] args) {
           String sentence = "JAVA is a popular object-oriented programming language";
           String[] words = sentence.split(" ");

           System.out.println("Number of words in sentence: " + words.length);

           // Print words
           for (String word : words) {
               System.out.println(word);
           }
       }
   }
   ```

## 🧑‍🏫 Lesson 3: Functions in Java

- Functions (or methods) are code blocks that can be called and executed multiple times in a program. They help organize code, enable reusability, and make programs more readable.

### Function declaration syntax

   ```java
   [modifier] [return_type] [method_name]([parameter_list]) {
       // Method body
       [return statement]
   }
   ```

   Example:

   ```java
   public static int sum(int a, int b) {
       return a + b;
   }
   ```

### Types of functions

   ```java
   // Function with no return value (void)
   public static void sayHello() {
       System.out.println("Hello!");
   }

   // Function returning primitive type
   public static int square(int number) {
       return number * number;
   }

   // Function returning object
   public static String formatName(String firstName, String lastName) {
       return lastName + " " + firstName;
   }

   // Function with multiple parameters
   public static double average(double a, double b, double c) {
       return (a + b + c) / 3;
   }
   ```

### Parameters and arguments

   ```java
   public class ParameterExample {
       public static void main(String[] args) {
           // value1, value2 are arguments
           int result = add(5, 3);  // 5, 3 are arguments
           System.out.println("Sum: " + result);
       }

       // a, b are parameters
       public static int add(int a, int b) {  // a, b are parameters
           return a + b;
       }
   }
   ```

### Variable scope

   ```java
   public class ScopeExample {
       // Global variable (class/instance variable)
       static int globalVar = 10;

       public static void main(String[] args) {
           // Local variable of main
           int localVar = 5;

           System.out.println(globalVar);  // Can access
           System.out.println(localVar);   // Can access

           // Call function and pass parameter
           testScope(20);
       }

       public static void testScope(int paramVar) {
           // paramVar is a parameter
           int anotherLocal = 15;

           System.out.println(globalVar);     // Can access
           System.out.println(paramVar);      // Can access
           System.out.println(anotherLocal);  // Can access

           // System.out.println(localVar);  // Error! Cannot access localVar from main
       }
   }
   ```

### Real-world example - Calculate bank interest

   ```java
   public class BankInterestCalculator {
       public static void main(String[] args) {
           double principal = 10000000;  // 10 million VND
           double rate = 0.06;          // 6% annual interest rate
           int years = 5;               // 5 years

           double result = calculateInterest(principal, rate, years);
           System.out.printf("After %d years, the amount is: %.2f VND\n", years, result);
       }

       // Function to calculate compound interest
       public static double calculateInterest(double principal, double rate, int years) {
           // Compound interest formula: A = P(1 + r)^t
           return principal * Math.pow(1 + rate, years);
       }
   }
   ```

## 🧑‍🏫 Lesson 4: Using arrays and strings together

### Declaring and initializing string arrays

   ```java
   // Declare string array
   String[] names;

   // Initialize array
   names = new String[5];

   // Assign values
   names[0] = "Nguyen Van A";
   names[1] = "Tran Thi B";
   names[2] = "Le Van C";
   names[3] = "Pham Thi D";
   names[4] = "Hoang Van E";

   // Declare and initialize together
   String[] fruits = {"Apple", "Banana", "Orange", "Mango", "Watermelon"};
   ```

### Searching in string arrays

   ```java
   public class StringArraySearch {
       public static void main(String[] args) {
           String[] fruits = {"Apple", "Banana", "Orange", "Mango", "Watermelon"};
           String searchFor = "Orange";

           // Linear search
           boolean found = false;
           for (int i = 0; i < fruits.length; i++) {
               if (fruits[i].equals(searchFor)) {
                   System.out.println("Found '" + searchFor + "' at position " + i);
                   found = true;
                   break;
               }
           }

           if (!found) {
               System.out.println("'" + searchFor + "' not found in array");
           }
       }
   }
   ```

### Sorting string arrays

   ```java
   import java.util.Arrays;

   public class StringArraySort {
       public static void main(String[] args) {
           String[] names = {"Nam", "An", "Hoa", "Binh", "Mai"};

           System.out.println("Original array:");
           for (String name : names) {
               System.out.print(name + " ");
           }

           // Sort array (alphabetically)
           Arrays.sort(names);

           System.out.println("\nSorted array:");
           for (String name : names) {
               System.out.print(name + " ");
           }
       }
   }
   ```

### Processing strings in arrays

   ```java
   public class StringArrayProcessing {
       public static void main(String[] args) {
           String[] sentences = {
               "JAVA is a programming language",
               "Python is very popular nowadays",
               "JavaScript is used for web",
               "JAVA can build many applications"
           };

           // Count sentences containing "JAVA"
           int javaCount = 0;
           for (String sentence : sentences) {
               if (sentence.contains("JAVA")) {
                   javaCount++;
               }
           }
           System.out.println("Number of sentences containing 'JAVA': " + javaCount);

           // Convert all sentences to uppercase
           System.out.println("\nSentences converted to uppercase:");
           for (int i = 0; i < sentences.length; i++) {
               sentences[i] = sentences[i].toUpperCase();
               System.out.println(sentences[i]);
           }
       }
   }
   ```

### Real-world example - Student list analysis

   ```java
   public class StudentAnalysis {
       public static void main(String[] args) {
           // Student list with format: "Name:Score"
           String[] students = {
               "Nguyen Van An:8.5",
               "Tran Thi Binh:9.0",
               "Le Van Cuong:7.5",
               "Pham Thi Diep:6.5",
               "Hoang Van Em:5.0"
           };

           // Separate name and score information
           String[] names = new String[students.length];
           double[] scores = new double[students.length];

           for (int i = 0; i < students.length; i++) {
               String[] parts = students[i].split(":");
               names[i] = parts[0];
               scores[i] = Double.parseDouble(parts[1]);
           }

           // Calculate average score
           double sum = 0;
           for (double score : scores) {
               sum += score;
           }
           double average = sum / scores.length;

           // Find student with highest score
           double maxScore = scores[0];
           int maxIndex = 0;

           for (int i = 1; i < scores.length; i++) {
               if (scores[i] > maxScore) {
                   maxScore = scores[i];
                   maxIndex = i;
               }
           }

           // Display results
           System.out.printf("Class average score: %.2f\n", average);
           System.out.println("Student with highest score: " + names[maxIndex] +
                              " with score " + scores[maxIndex]);
       }
   }
   ```

## 🧑‍🏫 Lesson 5: Functions and arrays

### Passing arrays to functions

   ```java
   public class ArrayAsParameter {
       public static void main(String[] args) {
           int[] numbers = {5, 10, 15, 20, 25};

           // Call function and pass array as parameter
           printArray(numbers);

           // Arrays are references, so changes in function will affect original array
           modifyArray(numbers);

           System.out.println("\nArray after modification:");
           printArray(numbers);
       }

       // Function to print array
       public static void printArray(int[] arr) {
           for (int num : arr) {
               System.out.print(num + " ");
           }
           System.out.println();
       }

       // Function to modify array
       public static void modifyArray(int[] arr) {
           for (int i = 0; i < arr.length; i++) {
               arr[i] *= 2; // Double each element
           }
       }
   }
   ```

### Common array processing functions

   ```java
   public class ArrayHelperFunctions {
       // Function to calculate array sum
       public static int sum(int[] arr) {
           int total = 0;
           for (int num : arr) {
               total += num;
           }
           return total;
       }

       // Function to find maximum value
       public static int findMax(int[] arr) {
           if (arr.length == 0) {
               throw new IllegalArgumentException("Empty array");
           }

           int max = arr[0];
           for (int i = 1; i < arr.length; i++) {
               if (arr[i] > max) {
                   max = arr[i];
               }
           }
           return max;
       }

       // Function to find minimum value
       public static int findMin(int[] arr) {
           if (arr.length == 0) {
               throw new IllegalArgumentException("Empty array");
           }

           int min = arr[0];
           for (int i = 1; i < arr.length; i++) {
               if (arr[i] < min) {
                   min = arr[i];
               }
           }
           return min;
       }

       // Function to calculate average
       public static double average(int[] arr) {
           if (arr.length == 0) {
               throw new IllegalArgumentException("Empty array");
           }

           return (double) sum(arr) / arr.length;
       }

       // Function to sort array (using Bubble Sort algorithm)
       public static void bubbleSort(int[] arr) {
           int n = arr.length;
           boolean swapped;

           for (int i = 0; i < n - 1; i++) {
               swapped = false;

               for (int j = 0; j < n - i - 1; j++) {
                   if (arr[j] > arr[j + 1]) {
                       // Swap arr[j] and arr[j+1]
                       int temp = arr[j];
                       arr[j] = arr[j + 1];
                       arr[j + 1] = temp;
                       swapped = true;
                   }
               }

               // If no elements were swapped, array is sorted
               if (!swapped) {
                   break;
               }
           }
       }
   }
   ```

### Real-world example - Sales data analysis

   ```java
   public class SalesAnalysis {
       public static void main(String[] args) {
           // Monthly sales data (in millions)
           double[] monthlySales = {120.5, 115.2, 130.8, 140.3, 175.2, 168.7,
                                    155.4, 160.1, 190.3, 185.6, 178.4, 220.5};

           System.out.printf("Total annual sales: %.2f million\n", sumSales(monthlySales));
           System.out.printf("Average monthly sales: %.2f million\n", averageSales(monthlySales));
           System.out.printf("Highest sales month: %d with %.2f million\n",
                           findHighestMonth(monthlySales) + 1, monthlySales[findHighestMonth(monthlySales)]);
           System.out.printf("Lowest sales month: %d with %.2f million\n",
                           findLowestMonth(monthlySales) + 1, monthlySales[findLowestMonth(monthlySales)]);

           // Trend analysis
           analyzeTrend(monthlySales);
       }

       // Calculate total sales
       public static double sumSales(double[] sales) {
           double total = 0;
           for (double sale : sales) {
               total += sale;
           }
           return total;
       }

       // Calculate average sales
       public static double averageSales(double[] sales) {
           return sumSales(sales) / sales.length;
       }

       // Find highest sales month
       public static int findHighestMonth(double[] sales) {
           int highestMonth = 0;
           for (int i = 1; i < sales.length; i++) {
               if (sales[i] > sales[highestMonth]) {
                   highestMonth = i;
               }
           }
           return highestMonth;
       }

       // Find lowest sales month
       public static int findLowestMonth(double[] sales) {
           int lowestMonth = 0;
           for (int i = 1; i < sales.length; i++) {
               if (sales[i] < sales[lowestMonth]) {
                   lowestMonth = i;
               }
           }
           return lowestMonth;
       }

       // Analyze trend
       public static void analyzeTrend(double[] sales) {
           // Calculate change between months
           System.out.println("\nSales trend analysis:");

           for (int i = 1; i < sales.length; i++) {
               double change = sales[i] - sales[i-1];
               double percentChange = (change / sales[i-1]) * 100;

               System.out.printf("Month %d to month %d: %.2f%% ", i, i+1, percentChange);

               if (change > 0) {
                   System.out.println("(Increase)");
               } else if (change < 0) {
                   System.out.println("(Decrease)");
               } else {
                   System.out.println("(No change)");
               }
           }
       }
   }
   ```

## 🧪 FINAL PROJECT: Student grade management with arrays

### Problem Description

Write a program that:

- Declares an array containing student score information (3 subjects: Math, Physics, Chemistry).
- Calculates each student's average score and classifies academic performance.
- Displays the student list and their average scores.

Required functions:

- Function to input scores for students and store in array.
- Function to calculate student's average score.
- Function to classify academic performance based on average score.
- Function to display results for all students.

### Program Output (Example)

```text
Enter number of students: 3
Enter student 1 name: Nguyen Van A
Enter Math score: 8.5
Enter Physics score: 7.5
Enter Chemistry score: 9.0

Enter student 2 name: Tran Thi B
Enter Math score: 6.5
Enter Physics score: 7.0
Enter Chemistry score: 8.0

Enter student 3 name: Le Van C
Enter Math score: 5.0
Enter Physics score: 6.0
Enter Chemistry score: 7.0

-----------------------------------
Student list and average scores:
Nguyen Van A - Average score: 8.67 - Classification: Excellent
Tran Thi B - Average score: 7.17 - Classification: Very Good
Le Van C - Average score: 6.00 - Classification: Average
```
