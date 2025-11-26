---
prev:
  text: '🏆 Java Final Project'
  link: '/JAVA/FINAL'
next:
  text: '🌐 Advanced Data Structures'
  link: '/DSA/Part2'
---

# 📘 PART 1: INTRODUCTION TO DATA STRUCTURES AND ALGORITHMS

## 🎯 General Objectives

- Get familiar with the concepts of data structures and algorithms.
- Understand how to analyze algorithm complexity.
- Master basic data structures and sorting, searching algorithms.

## 🧑‍🏫 Lesson 1: Introduction to Data Structures and Algorithms

### Concept of Data Structure

- Data structure is a way of organizing and storing data so that it can be accessed and used efficiently.
- Data structures help solve complex problems effectively.

### Concept of Algorithm

- An algorithm is a set of sequential steps to solve a specific problem.
- An algorithm needs to ensure:
  - **Definiteness**: Each step must be clear and precise.
  - **Finiteness**: Terminates after a finite number of steps.
  - **Effectiveness**: Executed in reasonable time and space.

### Relationship between Data Structure and Algorithm

```text
Algorithm + Data Structure = Program
```

### Importance of DSA

1. Optimize program performance.
2. Solve complex problems.
3. Foundation for professional software development.
4. Requirement for programming job interviews.

### Illustrative Example

```java
// Using appropriate data structure and algorithm
// to find the largest element in an array
public class FindMax {
    public static int findMax(int[] arr) {
        if (arr.length == 0) {
            throw new IllegalArgumentException("Array is empty");
        }

        int max = arr[0];
        for (int i = 1; i < arr.length; i++) {
            if (arr[i] > max) {
                max = arr[i];
            }
        }
        return max;
    }

    public static void main(String[] args) {
        int[] numbers = {12, 45, 7, 23, 56, 89, 34};
        System.out.println("Max value: " + findMax(numbers));
        // Result: Max value: 89
    }
}
```

## 🧑‍🏫 Lesson 2: Algorithm Complexity Analysis

### Definition of Algorithm Complexity

- Algorithm complexity is a way to measure the efficiency of an algorithm in terms of time and space.
- Two main types of complexity:
  - **Time Complexity**: Number of operations to be performed.
  - **Space Complexity**: Amount of memory needed to use.

### Big-O Notation

- Big-O describes the upper bound of algorithm complexity as the input size increases.
- Some common Big-O notations:
  - O(1): Constant complexity
  - O(log n): Logarithmic complexity
  - O(n): Linear complexity
  - O(n log n): Log-linear complexity
  - O(n²): Quadratic complexity
  - O(2^n): Exponential complexity
  - O(n!): Factorial complexity

### Algorithm Analysis

```java
// Complexity O(1) - Constant
public int getFirstElement(int[] array) {
    return array[0];
}

// Complexity O(n) - Linear
public int sum(int[] array) {
    int total = 0;
    for (int i = 0; i < array.length; i++) {
        total += array[i];
    }
    return total;
}

// Complexity O(n²) - Quadratic
public void printPairs(int[] array) {
    for (int i = 0; i < array.length; i++) {
        for (int j = 0; j < array.length; j++) {
            System.out.println(array[i] + ", " + array[j]);
        }
    }
}

// Complexity O(log n) - Logarithmic
public int binarySearch(int[] sortedArray, int target) {
    int left = 0;
    int right = sortedArray.length - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;

        if (sortedArray[mid] == target) {
            return mid;
        } else if (sortedArray[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return -1; // Not found
}
```

### Comparison of Algorithm Complexities

| Complexity  | Name           | Evaluation  | Algorithm Example           |
| ----------- | -------------- | ----------- | --------------------------- |
| O(1)        | Constant       | Very Fast   | Array element access        |
| O(log n)    | Logarithmic    | Fast        | Binary Search               |
| O(n)        | Linear         | Fairly Fast | Linear Search               |
| O(n log n)  | Log-Linear     | Average     | Merge Sort, Quick Sort      |
| O(n²)       | Quadratic      | Slow        | Bubble Sort, Selection Sort |
| O(2^n)      | Exponential    | Very Slow   | Recursive Fibonacci         |
| O(n!)       | Factorial      | Extremely Slow | Traveling Salesman Problem |

## 🧑‍🏫 Lesson 3: Arrays and Lists

### Array

- Data structure storing consecutive elements in memory.
- Random access with O(1) complexity.

```java
// Declare and initialize array
int[] numbers = new int[5]; // Array of 5 elements
int[] values = {10, 20, 30, 40, 50}; // Initialize values

// Access element
int firstValue = values[0]; // 10
int lastValue = values[4]; // 50

// Update element
values[2] = 35; // New values: {10, 20, 35, 40, 50}

// Iterate array
for (int i = 0; i < values.length; i++) {
    System.out.println(values[i]);
}

// Iterate with foreach
for (int value : values) {
    System.out.println(value);
}
```

### Multidimensional Array

```java
// 2D Array
int[][] matrix = new int[3][3];
matrix[0][0] = 1;
matrix[1][1] = 5;
matrix[2][2] = 9;

// Iterate 2D array
for (int i = 0; i < matrix.length; i++) {
    for (int j = 0; j < matrix[i].length; j++) {
        System.out.print(matrix[i][j] + " ");
    }
    System.out.println();
}
```

### Linked List

- Data structure consisting of nodes, each node containing data and a reference to the next node.
- Types: singly, doubly, circular.

### Singly Linked List

```java
class Node {
    int data;
    Node next;

    public Node(int data) {
        this.data = data;
        this.next = null;
    }
}

class LinkedList {
    Node head;

    // Add element to the end of the list
    public void append(int data) {
        Node newNode = new Node(data);

        // If list is empty
        if (head == null) {
            head = newNode;
            return;
        }

        // Find the last node
        Node last = head;
        while (last.next != null) {
            last = last.next;
        }

        // Attach new node to the end
        last.next = newNode;
    }

    // Print list
    public void printList() {
        Node current = head;
        while (current != null) {
            System.out.print(current.data + " -> ");
            current = current.next;
        }
        System.out.println("null");
    }
}

// Use linked list
LinkedList list = new LinkedList();
list.append(10);
list.append(20);
list.append(30);
list.printList(); // 10 -> 20 -> 30 -> null
```

### Comparison of Array and Linked List

| Criteria      | Array               | Linked List                                    |
| ------------- | ------------------- | ---------------------------------------------- |
| Access        | O(1) - Direct       | O(n) - Sequential                              |
| Insert/Delete Start | O(n)          | O(1)                                           |
| Insert/Delete End   | O(1) with dynamic array | O(n) with singly list, O(1) with doubly list |
| Insert/Delete Middle| O(n)          | O(n)                                           |
| Memory        | Contiguous          | Scattered                                      |
| Size          | Fixed (JAVA)        | Dynamic                                        |
| Application   | Random access       | Frequent insertion/deletion                    |

## 🧑‍🏫 Lesson 4: Basic Sorting Algorithms

### Bubble Sort

- Principle: Compare and swap adjacent pairs of elements.
- Complexity: O(n²)

```java
public static void bubbleSort(int[] arr) {
    int n = arr.length;
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                // Swap arr[j] and arr[j + 1]
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}
```

### Selection Sort

- Principle: Find the smallest (or largest) element and place it in the correct position.
- Complexity: O(n²)

```java
public static void selectionSort(int[] arr) {
    int n = arr.length;

    for (int i = 0; i < n - 1; i++) {
        // Find the smallest element in unsorted array
        int minIdx = i;
        for (int j = i + 1; j < n; j++) {
            if (arr[j] < arr[minIdx]) {
                minIdx = j;
            }
        }

        // Swap the smallest element with the first element
        int temp = arr[minIdx];
        arr[minIdx] = arr[i];
        arr[i] = temp;
    }
}
```

### Insertion Sort

- Principle: Build the sorted array one element at a time.
- Complexity: O(n²)

```java
public static void insertionSort(int[] arr) {
    int n = arr.length;

    for (int i = 1; i < n; i++) {
        int key = arr[i];
        int j = i - 1;

        // Move elements greater than key to the back
        while (j >= 0 && arr[j] > key) {
            arr[j + 1] = arr[j];
            j--;
        }
        arr[j + 1] = key;
    }
}
```

### Comparison of Basic Sorting Algorithms

| Algorithm      | Average Time         | Best Time          | Worst Time         | Memory | Stable |
| -------------- | -------------------- | ------------------ | ------------------ | ------ | ------- |
| Bubble Sort    | O(n²)                | O(n)               | O(n²)              | O(1)   | Yes     |
| Selection Sort | O(n²)                | O(n²)              | O(n²)              | O(1)   | No      |
| Insertion Sort | O(n²)                | O(n)               | O(n²)              | O(1)   | Yes     |

## 🧑‍🏫 Lesson 5: Basic Searching Algorithms

### Linear Search

- Principle: Iterate through each element in the array.
- Complexity: O(n)

```java
public static int linearSearch(int[] arr, int x) {
    for (int i = 0; i < arr.length; i++) {
        if (arr[i] == x) {
            return i;
        }
    }
    return -1; // Not found
}
```

### Binary Search

- Requirement: Sorted array.
- Principle: Divide the array in half and search on the appropriate half.
- Complexity: O(log n)

```java
public static int binarySearch(int[] arr, int x) {
    int left = 0, right = arr.length - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;

        // If x is in the middle
        if (arr[mid] == x) {
            return mid;
        }

        // If x is greater, search right
        if (arr[mid] < x) {
            left = mid + 1;
        }
        // If x is smaller, search left
        else {
            right = mid - 1;
        }
    }

    return -1; // Not found
}
```

### Recursive Binary Search

```java
public static int binarySearchRecursive(int[] arr, int left, int right, int x) {
    if (right >= left) {
        int mid = left + (right - left) / 2;

        // If element is at middle position
        if (arr[mid] == x) {
            return mid;
        }

        // If element is smaller than mid, search left
        if (arr[mid] > x) {
            return binarySearchRecursive(arr, left, mid - 1, x);
        }

        // Otherwise, search right
        return binarySearchRecursive(arr, mid + 1, right, x);
    }

    // Not found
    return -1;
}

// Initial call function
public static int binarySearch(int[] arr, int x) {
    return binarySearchRecursive(arr, 0, arr.length - 1, x);
}
```

### Comparison of Searching Algorithms

| Algorithm           | Complexity  | Requirement     | Pros                       | Cons                   |
| ------------------- | ----------- | --------------- | -------------------------- | ---------------------- |
| Linear Search       | O(n)        | None            | Simple, suitable for small arrays | Slow with large arrays      |
| Binary Search       | O(log n)    | Sorted Array    | Fast with large arrays         | Requires sorted array |

## 🧪 FINAL PROJECT: Student List Management

### Problem Description

Write a program that allows users to:

- Create a data structure to store student information (ID, name, age, GPA).
- Add new student to the list.
- Delete student by ID.
- Search student by name (linear search) and ID (binary search).
- Sort student list by GPA (using bubble sort, selection sort, or insertion sort).
- Display all students in the list.

### Program Output (Example)

```text
STUDENT MANAGEMENT PROGRAM
-----------------------------------
1. Add new student
2. Delete student by ID
3. Search student by name
4. Search student by ID
5. Sort students by GPA
6. Display student list
0. Exit

Select function: 1
Enter ID: SV001
Enter name: Nguyen Van A
Enter age: 20
Enter GPA: 8.5
Student added successfully!

Select function: 1
Enter ID: SV002
Enter name: Tran Thi B
Enter age: 19
Enter GPA: 9.0
Student added successfully!

Select function: 6
STUDENT LIST
-----------------------------------
ID: SV001 | Name: Nguyen Van A | Age: 20 | GPA: 8.5
ID: SV002 | Name: Tran Thi B | Age: 19 | GPA: 9.0

Select function: 5
Students sorted by GPA!

Select function: 6
STUDENT LIST
-----------------------------------
ID: SV002 | Name: Tran Thi B | Age: 19 | GPA: 9.0
ID: SV001 | Name: Nguyen Van A | Age: 20 | GPA: 8.5

Select function: 0
Thank you for using the program!
```
