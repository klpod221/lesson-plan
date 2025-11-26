---
prev:
  text: '🧩 Object-Oriented Programming'
  link: '/JAVA/Part3'
next:
  text: '💾 Module 4: Introduction to SQL'
  link: '/SQL/Part1'
---

# 📘 PART 4: EXCEPTION HANDLING, FILE I/O AND COLLECTIONS

## 🎯 General Objectives

- Understand and handle errors using the exception mechanism in Java.
- Read and write data to text files.
- Work with dynamic data structures in Java: List, Set, Map.

## 🧑‍🏫 Lesson 1: Exception Handling

### Exception Concept and Handling Mechanism

- An exception is an unwanted event that occurs during program execution, disrupting the normal flow of instructions.
- The exception handling mechanism helps the program not to stop abruptly but handle errors flexibly.
- Types of exceptions in Java:
  - Checked Exception: Exceptions checked at compile time (e.g., IOException).
  - Unchecked Exception: Exceptions not checked at compile time (e.g., NullPointerException, ArithmeticException).
  - Error: Serious errors that cannot be handled (e.g., OutOfMemoryError).

   ```java
   // Basic try-catch structure
   try {
       // Code block that may cause exception
       int result = 10 / 0; // ArithmeticException
   } catch (ArithmeticException e) {
       // Handle exception
       System.out.println("Error dividing by zero: " + e.getMessage());
   }
   ```

### Try-catch-finally

   ```java
   try {
       // Code block that may cause exception
       int[] numbers = {1, 2, 3};
       System.out.println(numbers[5]); // ArrayIndexOutOfBoundsException
   } catch (ArrayIndexOutOfBoundsException e) {
       // Handle exception
       System.out.println("Error accessing non-existent element in array: " + e.getMessage());
   } finally {
       // Code block always executed, regardless of exception
       System.out.println("Finally block is always executed");
   }
   ```

### Multiple Catch and Catch Order

   ```java
   try {
       // Code block that may cause multiple types of exceptions
       String str = null;
       System.out.println(str.length()); // NullPointerException
   } catch (NullPointerException e) {
       System.out.println("Null pointer error: " + e.getMessage());
   } catch (Exception e) {
       // General catch - always placed after specific catches
       System.out.println("General error: " + e.getMessage());
   }
   ```

### Throw and Throws

   ```java
   // Throws - declare method that can throw exception
   public static void checkAge(int age) throws IllegalArgumentException {
       if (age < 18) {
           // Throw - throw an exception
           throw new IllegalArgumentException("Age must be 18 or older");
       }
       System.out.println("Valid age");
   }

   // Usage
   public static void main(String[] args) {
       try {
           checkAge(15);
       } catch (IllegalArgumentException e) {
           System.out.println("Error: " + e.getMessage());
       }
   }
   ```

### Creating Custom Exceptions

   ```java
   // Define custom exception
   class InvalidScoreException extends Exception {
       public InvalidScoreException(String message) {
           super(message);
       }
   }

   // Use custom exception
   public class CustomExceptionExample {
       public static void validateScore(double score) throws InvalidScoreException {
           if (score < 0 || score > 10) {
               throw new InvalidScoreException("Score must be between 0-10");
           }
           System.out.println("Valid score: " + score);
       }

       public static void main(String[] args) {
           try {
               validateScore(15);
           } catch (InvalidScoreException e) {
               System.out.println("Score error: " + e.getMessage());
           }
       }
   }
   ```

## 🧑‍🏫 Lesson 2: File I/O (Text Files)

### Reading Files with FileReader and BufferedReader

   ```java
   import java.io.BufferedReader;
   import java.io.FileReader;
   import java.io.IOException;

   public class FileReadExample {
       public static void main(String[] args) {
           // Path to file to read
           String filePath = "data.txt";

           try (FileReader fr = new FileReader(filePath);
                BufferedReader br = new BufferedReader(fr)) {

               String line;
               // Read each line in file
               while ((line = br.readLine()) != null) {
                   System.out.println(line);
               }

           } catch (IOException e) {
               System.out.println("Error reading file: " + e.getMessage());
           }
       }
   }
   ```

### Writing Files with FileWriter and BufferedWriter

   ```java
   import java.io.BufferedWriter;
   import java.io.FileWriter;
   import java.io.IOException;

   public class FileWriteExample {
       public static void main(String[] args) {
           String filePath = "output.txt";

           // Overwrite file (false) or append to file (true)
           boolean append = false;

           try (FileWriter fw = new FileWriter(filePath, append);
                BufferedWriter bw = new BufferedWriter(fw)) {

               bw.write("Line 1: Learning Basic Java");
               bw.newLine(); // New line
               bw.write("Line 2: Learning file I/O in Java");
               bw.newLine();
               bw.write("Line 3: End of lesson");

               System.out.println("File written successfully!");

           } catch (IOException e) {
               System.out.println("Error writing file: " + e.getMessage());
           }
       }
   }
   ```

### Checking and Manipulating Files

   ```java
   import java.io.File;
   import java.io.IOException;

   public class FileOperationsExample {
       public static void main(String[] args) {
           // Create File object
           File file = new File("test.txt");

           // Check if file exists
           if (file.exists()) {
               System.out.println("File exists");
               System.out.println("File name: " + file.getName());
               System.out.println("Absolute path: " + file.getAbsolutePath());
               System.out.println("Size: " + file.length() + " bytes");
               System.out.println("Readable: " + file.canRead());
               System.out.println("Writable: " + file.canWrite());
           } else {
               System.out.println("File does not exist, creating new file...");
               try {
                   if (file.createNewFile()) {
                       System.out.println("File created successfully");
                   } else {
                       System.out.println("Cannot create file");
                   }
               } catch (IOException e) {
                   System.out.println("Error: " + e.getMessage());
               }
           }

           // Delete file
           // if (file.delete()) {
           //     System.out.println("File deleted");
           // } else {
           //     System.out.println("Cannot delete file");
           // }
       }
   }
   ```

### Reading/Writing Files with try-with-resources

   ```java
   import java.io.*;

   public class TryWithResourcesExample {
       public static void main(String[] args) {
           String inputFile = "input.txt";
           String outputFile = "output.txt";

           // Try-with-resources automatically closes resources
           try (BufferedReader reader = new BufferedReader(new FileReader(inputFile));
                BufferedWriter writer = new BufferedWriter(new FileWriter(outputFile))) {

               String line;
               while ((line = reader.readLine()) != null) {
                   // Convert to uppercase and write to output file
                   writer.write(line.toUpperCase());
                   writer.newLine();
               }

               System.out.println("File copied and converted successfully");

           } catch (IOException e) {
               System.out.println("File processing error: " + e.getMessage());
           }
       }
   }
   ```

### Real-world Example - Reading CSV Data

   ```java
   import java.io.BufferedReader;
   import java.io.FileReader;
   import java.io.IOException;
   import java.util.ArrayList; // You will learn about ArrayList in Collections section
   import java.util.List; // You will learn about List in Collections section

   class Student {
       private String id;
       private String name;
       private double score;

       public Student(String id, String name, double score) {
           this.id = id;
           this.name = name;
           this.score = score;
       }

       @Override
       public String toString() {
           return "Student{id='" + id + "', name='" + name + "', score=" + score + "}";
       }
   }

   public class CSVReaderExample {
       public static void main(String[] args) {
           String csvFile = "students.csv";
           String line;
           String csvSplitBy = ",";
           List<Student> students = new ArrayList<>();

           try (BufferedReader br = new BufferedReader(new FileReader(csvFile))) {
               // Skip header line
               br.readLine();

               while ((line = br.readLine()) != null) {
                   String[] data = line.split(csvSplitBy);

                   // Create Student object from CSV data
                   Student student = new Student(
                       data[0],
                       data[1],
                       Double.parseDouble(data[2])
                   );

                   students.add(student);
               }

               // Print student list
               for (Student student : students) {
                   System.out.println(student);
               }

           } catch (IOException e) {
               System.out.println("Error reading CSV file: " + e.getMessage());
           }
       }
   }
   ```

## 🧑‍🏫 Lesson 3: Introduction to Collections Framework

### Overview of Collections Framework

- Collections Framework is an architecture designed to store and manipulate groups of objects in Java.
- It provides data structures like List, Set, Map and algorithms to manipulate them.
- Collections Framework addresses the need to organize and process data flexibly and efficiently.

**Main components of Collections Framework:**

1. **Interfaces:**
   - `Collection`: Base interface for most collections, defining methods like add(), remove(), contains()
   - `List`: Ordered list, allows duplicate elements (ArrayList, LinkedList)
   - `Set`: Collection containing no duplicate elements (HashSet, TreeSet)
   - `Queue`: Queue, elements processed in FIFO (First-In-First-Out) order
   - `Map`: Stores data as key-value pairs, keys cannot be duplicate (HashMap, TreeMap)

2. **Implementations:**
   - Classes implementing the above interfaces, each with its own characteristics and applications
   - Example: ArrayList (dynamic array), LinkedList (linked list), HashSet, TreeSet, HashMap, TreeMap

3. **Algorithms:**
   - Static methods of `Collections` class provide algorithms like sorting, searching, shuffling...
   - Example: Collections.sort(), Collections.binarySearch(), Collections.shuffle()

**Benefits of Collections Framework:**

- **Reusability**: No need to write complex data structures yourself
- **Performance**: Implementations are optimized
- **Flexibility**: Easy to switch between data structures
- **Standardization**: Consistent API across different data structures
- **Integration**: Works well with other Java components like Stream API

**Choosing the right data structure:**

- **ArrayList**: When fast random access is needed and few insertions/deletions in the middle
- **LinkedList**: When frequent insertions/deletions at beginning/end/middle are needed
- **HashSet**: When fast search is needed and order doesn't matter
- **TreeSet**: When sorted order of elements needs to be maintained
- **HashMap**: When fast search based on key is needed and key order doesn't matter
- **TreeMap**: When sorted order of keys needs to be maintained

### Collection vs Map

   ```java
   import java.util.*;

   public class CollectionVsMap {
       public static void main(String[] args) {
           // Collection is interface for groups of objects
           System.out.println("=== Collection Examples ===");

           // List - Collection with order, allows duplicates
           List<String> names = new ArrayList<>();
           names.add("Alice");
           names.add("Bob");
           names.add("Charlie");
           names.add("Alice"); // Allows duplicates

           System.out.println("List: " + names);
           System.out.println("Element at position 1: " + names.get(1));

           // Set - Collection without order, no duplicates
           Set<String> uniqueNames = new HashSet<>();
           uniqueNames.add("Alice");
           uniqueNames.add("Bob");
           uniqueNames.add("Charlie");
           uniqueNames.add("Alice"); // Not added

           System.out.println("\nSet: " + uniqueNames);
           // uniqueNames.get(0); // Error: Set has no get(index) method

           // Map is interface for key-value pairs
           System.out.println("\n=== Map Examples ===");

           Map<String, Integer> ages = new HashMap<>();
           ages.put("Alice", 25);
           ages.put("Bob", 30);
           ages.put("Charlie", 22);

           System.out.println("Map: " + ages);
           System.out.println("Bob's age: " + ages.get("Bob"));

           // Iterate Map
           System.out.println("\nIterating Map:");
           for (Map.Entry<String, Integer> entry : ages.entrySet()) {
               System.out.println(entry.getKey() + " is " + entry.getValue() + " years old");
           }
       }
   }
   ```

### Basic Operations with Collections

   ```java
   import java.util.*;

   public class CollectionsOperations {
       public static void main(String[] args) {
           List<String> languages = new ArrayList<>();

           // Add elements
           languages.add("JAVA");
           languages.add("Python");
           languages.add("C#");
           languages.add("JavaScript");

           System.out.println("Initial list: " + languages);

           // Size
           System.out.println("Number of elements: " + languages.size());

           // Check existence
           System.out.println("Contains 'JAVA'? " + languages.contains("JAVA"));
           System.out.println("Contains 'Ruby'? " + languages.contains("Ruby"));

           // Get element by index
           System.out.println("2nd element: " + languages.get(1));

           // Remove element
           languages.remove("C#");
           System.out.println("After removing 'C#': " + languages);

           // Remove by index
           languages.remove(0);
           System.out.println("After removing first element: " + languages);

           // Iterate collection
           System.out.println("\nIterate using for-each:");
           for (String lang : languages) {
               System.out.println("- " + lang);
           }

           // Iterate using Iterator
           System.out.println("\nIterate using Iterator:");
           Iterator<String> iterator = languages.iterator();
           while (iterator.hasNext()) {
               System.out.println("+ " + iterator.next());
           }

           // Sort
           Collections.sort(languages);
           System.out.println("\nAfter sorting: " + languages);

           // Clear all
           languages.clear();
           System.out.println("After clearing all: " + languages);
           System.out.println("Is list empty? " + languages.isEmpty());
       }
   }
   ```

## 🧑‍🏫 Lesson 4: List, Set and Map

### ArrayList and LinkedList

- `ArrayList`: dynamic array, fast access by index.
- `LinkedList`: linked list, fast insertion/deletion at head/tail.

   ```java
   import java.util.ArrayList;
   import java.util.LinkedList;
   import java.util.List;

   public class ListExample {
       public static void main(String[] args) {
           // ArrayList - fast random access
           List<String> arrayList = new ArrayList<>();
           arrayList.add("Apple");
           arrayList.add("Banana");
           arrayList.add("Orange");

           System.out.println("ArrayList: " + arrayList);

           // Add element at specific position
           arrayList.add(1, "Mango");
           System.out.println("After adding 'Mango' at pos 1: " + arrayList);

           // Update element
           arrayList.set(0, "Green Apple");
           System.out.println("After update: " + arrayList);

           // LinkedList - fast add/remove at head/tail
           List<String> linkedList = new LinkedList<>();
           linkedList.add("Dog");
           linkedList.add("Cat");
           linkedList.add("Bird");

           System.out.println("\nLinkedList: " + linkedList);

           // Add first and last (LinkedList specific methods)
           ((LinkedList<String>) linkedList).addFirst("Lion");
           ((LinkedList<String>) linkedList).addLast("Tiger");

           System.out.println("After adding first and last: " + linkedList);

           // Performance comparison (concept)
           System.out.println("\nComparing ArrayList and LinkedList:");
           System.out.println("- ArrayList good for: random access, iterating list");
           System.out.println("- LinkedList good for: frequent add/remove at head or tail");
       }
   }
   ```

### HashSet and TreeSet

- `HashSet`: unordered, no duplicate elements.
- `TreeSet`: automatically sorted by natural order or Comparator.

   ```java
   import java.util.HashSet;
   import java.util.Set;
   import java.util.TreeSet;

   public class SetExample {
       public static void main(String[] args) {
           // HashSet - unordered, fastest
           Set<String> hashSet = new HashSet<>();
           hashSet.add("Banana");
           hashSet.add("Apple");
           hashSet.add("Orange");
           hashSet.add("Apple"); // Not added (duplicate)

           System.out.println("HashSet (unordered): " + hashSet);

           // Check element existence
           System.out.println("Contains 'Apple'? " + hashSet.contains("Apple"));

           // Remove element
           hashSet.remove("Banana");
           System.out.println("After removing 'Banana': " + hashSet);

           // TreeSet - automatically sorted
           Set<String> treeSet = new TreeSet<>();
           treeSet.add("Zebra");
           treeSet.add("Dog");
           treeSet.add("Cat");
           treeSet.add("Apple");

           System.out.println("\nTreeSet (automatically sorted): " + treeSet);

           // Add duplicate
           treeSet.add("Cat"); // No change
           System.out.println("After adding 'Cat' again: " + treeSet);

           // Performance comparison (concept)
           System.out.println("\nComparing HashSet and TreeSet:");
           System.out.println("- HashSet good for: fast add/remove/search operations");
           System.out.println("- TreeSet good for: when sorted order needs to be maintained");
       }
   }
   ```

### HashMap and TreeMap

- `HashMap`: unordered, allows null keys, fastest.
- `TreeMap`: automatically sorted by key, does not allow null keys.

   ```java
   import java.util.HashMap;
   import java.util.Map;
   import java.util.TreeMap;

   public class MapExample {
       public static void main(String[] args) {
           // HashMap - unordered, fastest
           Map<String, Integer> hashMap = new HashMap<>();
           hashMap.put("John", 25);
           hashMap.put("Alice", 22);
           hashMap.put("Bob", 30);

           System.out.println("HashMap (unordered): " + hashMap);

           // Access value
           System.out.println("Alice's age: " + hashMap.get("Alice"));

           // Check key existence
           System.out.println("Contains 'Bob'? " + hashMap.containsKey("Bob"));

           // Check value existence
           System.out.println("Contains age 40? " + hashMap.containsValue(40));

           // Update value
           hashMap.put("John", 26); // Overwrite old value
           System.out.println("After updating John's age: " + hashMap);

           // TreeMap - sorted by key
           Map<String, String> treeMap = new TreeMap<>();
           treeMap.put("US", "United States");
           treeMap.put("VN", "Vietnam");
           treeMap.put("FR", "France");
           treeMap.put("JP", "Japan");

           System.out.println("\nTreeMap (sorted by key): " + treeMap);

           // Iterate Map - Method 1: using entrySet
           System.out.println("\nIterating Map using entrySet:");
           for (Map.Entry<String, String> entry : treeMap.entrySet()) {
               System.out.println(entry.getKey() + " -> " + entry.getValue());
           }

           // Iterate Map - Method 2: using keySet
           System.out.println("\nIterating Map using keySet:");
           for (String key : treeMap.keySet()) {
               System.out.println(key + " --> " + treeMap.get(key));
           }

           // Remove element
           treeMap.remove("FR");
           System.out.println("\nAfter removing 'FR': " + treeMap);
       }
   }
   ```

### Real-world Example - Contact Manager

   ```java
   import java.util.*;

   public class ContactManager {
       public static void main(String[] args) {
           // Use TreeMap to store contacts sorted by name
           Map<String, String> contacts = new TreeMap<>();

           // Add contacts
           contacts.put("John Doe", "0987654321");
           contacts.put("Alice Smith", "0123456789");
           contacts.put("Bob Johnson", "0369852147");
           contacts.put("Cindy Williams", "0741258963");

           // Display all contacts
           System.out.println("=== CONTACTS ===");
           displayContacts(contacts);

           // Search phone number
           String name = "Alice Smith";
           String phone = findContact(contacts, name);
           if (phone != null) {
               System.out.println("\nPhone number of " + name + ": " + phone);
           } else {
               System.out.println("\n" + name + " not found in contacts");
           }

           // Update contact
           updateContact(contacts, "Bob Johnson", "0999888777");
           System.out.println("\n=== CONTACTS AFTER UPDATE ===");
           displayContacts(contacts);

           // Remove contact
           removeContact(contacts, "Cindy Williams");
           System.out.println("\n=== CONTACTS AFTER DELETION ===");
           displayContacts(contacts);
       }

       // Display all contacts
       public static void displayContacts(Map<String, String> contacts) {
           for (Map.Entry<String, String> entry : contacts.entrySet()) {
               System.out.println(entry.getKey() + ": " + entry.getValue());
           }
       }

       // Find contact
       public static String findContact(Map<String, String> contacts, String name) {
           return contacts.get(name);
       }

       // Update contact
       public static void updateContact(Map<String, String> contacts, String name, String newPhone) {
           if (contacts.containsKey(name)) {
               contacts.put(name, newPhone);
               System.out.println("Updated phone number for " + name);
           } else {
               System.out.println(name + " not found in contacts");
           }
       }

       // Remove contact
       public static void removeContact(Map<String, String> contacts, String name) {
           if (contacts.containsKey(name)) {
               contacts.remove(name);
               System.out.println("Removed " + name + " from contacts");
           } else {
               System.out.println(name + " not found in contacts");
           }
       }
   }
   ```

## 🧑‍🏫 Lesson 5: Combining File and Collections

### Reading File into List

   ```java
   import java.io.BufferedReader;
   import java.io.FileReader;
   import java.io.IOException;
   import java.util.ArrayList;
   import java.util.List;

   public class ReadToCollection {
       public static void main(String[] args) {
           String filePath = "names.txt";
           List<String> names = new ArrayList<>();

           try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
               String line;
               while ((line = br.readLine()) != null) {
                   names.add(line.trim());
               }

               System.out.println("Read " + names.size() + " names from file");
               System.out.println("List of names:");
               for (String name : names) {
                   System.out.println("- " + name);
               }

           } catch (IOException e) {
               System.out.println("Error reading file: " + e.getMessage());
           }
       }
   }
   ```

### Writing List to File

   ```java
   import java.io.BufferedWriter;
   import java.io.FileWriter;
   import java.io.IOException;
   import java.util.ArrayList;
   import java.util.List;

   public class WriteCollectionToFile {
       public static void main(String[] args) {
           List<String> cities = new ArrayList<>();
           cities.add("Hanoi");
           cities.add("Ho Chi Minh City");
           cities.add("Da Nang");
           cities.add("Hue");
           cities.add("Can Tho");

           String outputFile = "cities.txt";

           try (BufferedWriter writer = new BufferedWriter(new FileWriter(outputFile))) {
               for (String city : cities) {
                   writer.write(city);
                   writer.newLine();
               }

               System.out.println("Written " + cities.size() + " cities to file " + outputFile);

           } catch (IOException e) {
               System.out.println("Error writing file: " + e.getMessage());
           }
       }
   }
   ```

### Reading CSV File into Object List

   ```java
   import java.io.BufferedReader;
   import java.io.FileReader;
   import java.io.IOException;
   import java.util.ArrayList;
   import java.util.List;

   class Product {
       private String id;
       private String name;
       private double price;
       private int quantity;

       public Product(String id, String name, double price, int quantity) {
           this.id = id;
           this.name = name;
           this.price = price;
           this.quantity = quantity;
       }

       @Override
       public String toString() {
           return "Product{id='" + id + "', name='" + name + "', price=" + price + ", quantity=" + quantity + "}";
       }

       // Method to convert object to CSV line
       public String toCSV() {
           return id + "," + name + "," + price + "," + quantity;
       }
   }

   public class ProductCSVReader {
       public static void main(String[] args) {
           String csvFile = "products.csv";
           String line;
           String csvSplitBy = ",";
           List<Product> products = new ArrayList<>();

           try (BufferedReader br = new BufferedReader(new FileReader(csvFile))) {
               // Skip header line
               br.readLine();

               while ((line = br.readLine()) != null) {
                   String[] data = line.split(csvSplitBy);

                   Product product = new Product(
                       data[0],
                       data[1],
                       Double.parseDouble(data[2]),
                       Integer.parseInt(data[3])
                   );

                   products.add(product);
               }

               System.out.println("Read " + products.size() + " products");
               for (Product product : products) {
                   System.out.println(product);
               }

           } catch (IOException e) {
               System.out.println("Error reading file: " + e.getMessage());
           }
       }
   }
   ```

### Writing Map to File

   ```java
   import java.io.BufferedWriter;
   import java.io.FileWriter;
   import java.io.IOException;
   import java.util.HashMap;
   import java.util.Map;

   public class WriteMapToFile {
       public static void main(String[] args) {
           Map<String, Double> exchangeRates = new HashMap<>();
           exchangeRates.put("USD", 23000.0);
           exchangeRates.put("EUR", 27000.0);
           exchangeRates.put("JPY", 210.0);
           exchangeRates.put("GBP", 31500.0);
           exchangeRates.put("AUD", 17500.0);

           String outputFile = "exchange_rates.txt";

           try (BufferedWriter writer = new BufferedWriter(new FileWriter(outputFile))) {
               writer.write("Currency,Rate");
               writer.newLine();

               for (Map.Entry<String, Double> entry : exchangeRates.entrySet()) {
                   String line = entry.getKey() + "," + entry.getValue();
                   writer.write(line);
                   writer.newLine();
               }

               System.out.println("Written currency rates to file " + outputFile);

           } catch (IOException e) {
               System.out.println("Error writing file: " + e.getMessage());
           }
       }
   }
   ```

### Real-world Example - Simple Book Management System

   ```java
   import java.io.*;
   import java.util.ArrayList;
   import java.util.List;
   import java.util.Scanner;

   class Book {
       private String isbn;
       private String title;
       private String author;
       private int year;

       public Book(String isbn, String title, String author, int year) {
           this.isbn = isbn;
           this.title = title;
           this.author = author;
           this.year = year;
       }

       // Getters
       public String getIsbn() { return isbn; }
       public String getTitle() { return title; }
       public String getAuthor() { return author; }
       public int getYear() { return year; }

       @Override
       public String toString() {
           return "Book{isbn='" + isbn + "', title='" + title + "', author='" + author + "', year=" + year + "}";
       }

       // Convert object to CSV line
       public String toCSV() {
           return isbn + "," + title + "," + author + "," + year;
       }
   }

   public class BookManager {
       private static final String FILE_PATH = "books.csv";
       private List<Book> books = new ArrayList<>();
       private Scanner scanner = new Scanner(System.in);

       public static void main(String[] args) {
           BookManager manager = new BookManager();
           manager.loadBooksFromFile();
           manager.showMenu();
       }

       private void showMenu() {
           int choice;
           do {
               System.out.println("\n==== BOOK MANAGEMENT ====");
               System.out.println("1. Display all books");
               System.out.println("2. Add new book");
               System.out.println("3. Find book by ISBN");
               System.out.println("4. Find books by author");
               System.out.println("5. Save and exit");
               System.out.print("Enter your choice: ");

               choice = scanner.nextInt();
               scanner.nextLine(); // Consume newline

               switch (choice) {
                   case 1:
                       displayAllBooks();
                       break;
                   case 2:
                       addNewBook();
                       break;
                   case 3:
                       findBookByISBN();
                       break;
                   case 4:
                       findBooksByAuthor();
                       break;
                   case 5:
                       saveBooksToFile();
                       System.out.println("Goodbye!");
                       break;
                   default:
                       System.out.println("Invalid choice. Please try again.");
               }

           } while (choice != 5);
       }

       private void loadBooksFromFile() {
           File file = new File(FILE_PATH);
           if (!file.exists()) {
               System.out.println("File does not exist. Creating new list.");
               return;
           }

           try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
               String line;
               // Skip header if exists
               reader.readLine();

               while ((line = reader.readLine()) != null) {
                   String[] data = line.split(",");
                   if (data.length == 4) {
                       Book book = new Book(
                           data[0],
                           data[1],
                           data[2],
                           Integer.parseInt(data[3])
                       );
                       books.add(book);
                   }
               }

               System.out.println("Loaded " + books.size() + " books from file.");

           } catch (IOException e) {
               System.out.println("Error reading file: " + e.getMessage());
           }
       }

       private void saveBooksToFile() {
           try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
               // Write header
               writer.write("ISBN,Title,Author,Year");
               writer.newLine();

               // Write book data
               for (Book book : books) {
                   writer.write(book.toCSV());
                   writer.newLine();
               }

               System.out.println("Saved " + books.size() + " books to file " + FILE_PATH);

           } catch (IOException e) {
               System.out.println("Error writing file: " + e.getMessage());
           }
       }

       private void displayAllBooks() {
           if (books.isEmpty()) {
               System.out.println("No books in library.");
               return;
           }

           System.out.println("\n==== BOOK LIST ====");
           System.out.println("ISBN\t\tTitle\t\tAuthor\t\tYear");
           System.out.println("---------------------------------------------------");

           for (Book book : books) {
               System.out.printf("%s\t%s\t%s\t%d\n",
                   book.getIsbn(), book.getTitle(), book.getAuthor(), book.getYear());
           }
       }

       private void addNewBook() {
           System.out.println("\n==== ADD NEW BOOK ====");

           System.out.print("Enter ISBN: ");
           String isbn = scanner.nextLine();

           // Check if ISBN exists
           for (Book book : books) {
               if (book.getIsbn().equals(isbn)) {
                   System.out.println("ISBN already exists. Please try again.");
                   return;
               }
           }

           System.out.print("Enter Title: ");
           String title = scanner.nextLine();

           System.out.print("Enter Author: ");
           String author = scanner.nextLine();

           System.out.print("Enter Year: ");
           int year = scanner.nextInt();
           scanner.nextLine(); // Consume newline

           Book newBook = new Book(isbn, title, author, year);
           books.add(newBook);

           System.out.println("Book added successfully!");
       }

       private void findBookByISBN() {
           System.out.print("Enter ISBN to find: ");
           String isbn = scanner.nextLine();

           for (Book book : books) {
               if (book.getIsbn().equals(isbn)) {
                   System.out.println("\nBook found:");
                   System.out.println(book);
                   return;
               }
           }

           System.out.println("Book not found with ISBN: " + isbn);
       }

       private void findBooksByAuthor() {
           System.out.print("Enter author name to find: ");
           String authorName = scanner.nextLine().toLowerCase();

           List<Book> result = new ArrayList<>();

           for (Book book : books) {
               if (book.getAuthor().toLowerCase().contains(authorName)) {
                   result.add(book);
               }
           }

           if (result.isEmpty()) {
               System.out.println("No books found for author: " + authorName);
           } else {
               System.out.println("\nFound " + result.size() + " books by author " + authorName + ":");
               for (Book book : result) {
                   System.out.println(book);
               }
           }
       }
   }
   ```

## 🧪 FINAL PROJECT: Course Management System

### Problem Description

Write a program to manage a list of courses:

- Each course has a code, name, instructor, and number of enrolled students.
- Allow users to:
  - Add, edit, delete courses.
  - Save and load list from file.
  - Search course by code or name.
  - Print course list by instructor name.

### Requirements

- Use `ArrayList` or `HashMap` to store course list.
- Store data in a file (can be csv) and reload when program starts.
- Handle error cases like duplicate course code, file not found,...

After completing this part, you have mastered the foundational concepts of JAVA - from syntax, control structures, object-oriented programming to Collections Framework. The real-world examples in the lessons have also helped you apply theory to specific situations.

Here, we will temporarily pause the journey with JAVA to enter the world of SQL - the most widely used database query language today. This will not only expand your knowledge but also help you understand deeper how applications interact with databases - an essential skill in most real-world software development projects.
