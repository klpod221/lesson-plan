---
prev:
  text: '🧮 Introduction to DSA'
  link: '/DSA/Part1'
next:
  text: '🧠 Advanced Algorithms'
  link: '/DSA/Part3'
---

# 📘 PART 2: ADVANCED DATA STRUCTURES

## 🎯 General Objectives

- Master advanced data structures such as Stack, Queue, Binary Tree, Hash Table.
- Understand how to implement and apply each data structure.
- Know how to choose the appropriate data structure for each problem.

## 🧑‍🏫 Lesson 1: Stack

### Concept of Stack

- Stack is a LIFO (Last In First Out) data structure.
- Basic operations: push (add to top), pop (remove from top), peek (view top).

### Stack Implementation using Array

```java
public class ArrayStack {
    private int maxSize;
    private int[] stackArray;
    private int top;

    // Initialize stack
    public ArrayStack(int size) {
        maxSize = size;
        stackArray = new int[maxSize];
        top = -1; // Stack is empty
    }

    // Add element to top of stack
    public void push(int value) {
        if (top == maxSize - 1) {
            System.out.println("Stack is full!");
            return;
        }
        stackArray[++top] = value;
    }

    // Remove element from top of stack
    public int pop() {
        if (top == -1) {
            System.out.println("Stack is empty!");
            return -1;
        }
        return stackArray[top--];
    }

    // View element at top without removing
    public int peek() {
        if (top == -1) {
            System.out.println("Stack is empty!");
            return -1;
        }
        return stackArray[top];
    }

    // Check if stack is empty
    public boolean isEmpty() {
        return (top == -1);
    }

    // Check if stack is full
    public boolean isFull() {
        return (top == maxSize - 1);
    }
}
```

### Stack Implementation using Linked List

```java
public class LinkedStack {
    private class Node {
        int data;
        Node next;

        public Node(int data) {
            this.data = data;
            this.next = null;
        }
    }

    private Node top;

    public LinkedStack() {
        top = null;
    }

    // Add to top of stack
    public void push(int value) {
        Node newNode = new Node(value);
        newNode.next = top;
        top = newNode;
    }

    // Remove from top of stack
    public int pop() {
        if (isEmpty()) {
            System.out.println("Stack is empty!");
            return -1;
        }

        int value = top.data;
        top = top.next;
        return value;
    }

    // View top of stack
    public int peek() {
        if (isEmpty()) {
            System.out.println("Stack is empty!");
            return -1;
        }
        return top.data;
    }

    // Check if stack is empty
    public boolean isEmpty() {
        return top == null;
    }
}
```

### Applications of Stack

#### Checking Balanced Parentheses

```java
public boolean isBalanced(String expression) {
    LinkedStack stack = new LinkedStack();

    for (char c : expression.toCharArray()) {
        if (c == '(' || c == '[' || c == '{') {
            stack.push(c);
        } else if (c == ')' || c == ']' || c == '}') {
            if (stack.isEmpty()) {
                return false;
            }

            char top = (char) stack.pop();

            if ((c == ')' && top != '(') ||
                (c == ']' && top != '[') ||
                (c == '}' && top != '{')) {
                return false;
            }
        }
    }

    return stack.isEmpty();
}
```

#### Reversing a String

```java
public String reverse(String str) {
    LinkedStack stack = new LinkedStack();

    // Push all characters to stack
    for (char c : str.toCharArray()) {
        stack.push(c);
    }

    // Pop each character from stack to create reversed string
    StringBuilder reversed = new StringBuilder();
    while (!stack.isEmpty()) {
        reversed.append((char)stack.pop());
    }

    return reversed.toString();
}
```

#### Converting Infix to Postfix Expression

```java
public String infixToPostfix(String infix) {
    StringBuilder postfix = new StringBuilder();
    java.util.Stack<Character> stack = new java.util.Stack<>();

    for (char c : infix.toCharArray()) {
        // If operand, add to result string
        if (Character.isLetterOrDigit(c)) {
            postfix.append(c);
        }
        // If opening parenthesis, push to stack
        else if (c == '(') {
            stack.push(c);
        }
        // If closing parenthesis, pop from stack until opening parenthesis
        else if (c == ')') {
            while (!stack.isEmpty() && stack.peek() != '(') {
                postfix.append(stack.pop());
            }
            stack.pop(); // Remove '('
        }
        // If operator, compare precedence with operator at top of stack
        else {
            while (!stack.isEmpty() && precedence(c) <= precedence(stack.peek())) {
                postfix.append(stack.pop());
            }
            stack.push(c);
        }
    }

    // Pop remaining operators in stack to result string
    while (!stack.isEmpty()) {
        postfix.append(stack.pop());
    }

    return postfix.toString();
}

// Determine operator precedence
private int precedence(char ch) {
    switch (ch) {
        case '+':
        case '-':
            return 1;
        case '*':
        case '/':
            return 2;
        case '^':
            return 3;
    }
    return -1;
}
```

## 🧑‍🏫 Lesson 2: Queue

### Concept of Queue

- Queue is a FIFO (First In First Out) data structure.
- Basic operations: enqueue (add to rear), dequeue (remove from front), peek (view front).

### Queue Implementation using Array (Circular Queue)

```java
public class CircularQueue {
    private int maxSize;
    private int[] queueArray;
    private int front;
    private int rear;
    private int nItems;

    public CircularQueue(int size) {
        maxSize = size;
        queueArray = new int[maxSize];
        front = 0;
        rear = -1;
        nItems = 0;
    }

    // Add to rear of queue
    public void enqueue(int value) {
        if (isFull()) {
            System.out.println("Queue is full!");
            return;
        }
        // Increment rear and wrap around if needed
        rear = (rear + 1) % maxSize;
        queueArray[rear] = value;
        nItems++;
    }

    // Remove from front of queue
    public int dequeue() {
        if (isEmpty()) {
            System.out.println("Queue is empty!");
            return -1;
        }
        int temp = queueArray[front];
        front = (front + 1) % maxSize;
        nItems--;
        return temp;
    }

    // View element at front of queue
    public int peek() {
        if (isEmpty()) {
            System.out.println("Queue is empty!");
            return -1;
        }
        return queueArray[front];
    }

    // Check if queue is empty
    public boolean isEmpty() {
        return (nItems == 0);
    }

    // Check if queue is full
    public boolean isFull() {
        return (nItems == maxSize);
    }

    // Current size of queue
    public int size() {
        return nItems;
    }
}
```

### Queue Implementation using Linked List

```java
public class LinkedQueue {
    private class Node {
        int data;
        Node next;

        public Node(int data) {
            this.data = data;
            this.next = null;
        }
    }

    private Node front;
    private Node rear;

    public LinkedQueue() {
        front = null;
        rear = null;
    }

    // Add to rear of queue
    public void enqueue(int value) {
        Node newNode = new Node(value);

        // If queue is empty
        if (rear == null) {
            front = newNode;
            rear = newNode;
            return;
        }

        // Add after rear and update rear
        rear.next = newNode;
        rear = newNode;
    }

    // Remove from front of queue
    public int dequeue() {
        if (isEmpty()) {
            System.out.println("Queue is empty!");
            return -1;
        }

        // Store value to return
        int value = front.data;

        // Move front
        front = front.next;

        // If front becomes null, update rear as well
        if (front == null) {
            rear = null;
        }

        return value;
    }

    // View element at front of queue
    public int peek() {
        if (isEmpty()) {
            System.out.println("Queue is empty!");
            return -1;
        }
        return front.data;
    }

    // Check if queue is empty
    public boolean isEmpty() {
        return front == null;
    }
}
```

### Applications of Queue

#### BFS Algorithm (Breadth-First Search)

```java
public void BFS(Graph graph, int startVertex) {
    // Mark all vertices as not visited
    boolean[] visited = new boolean[graph.getVertexCount()];

    // Create queue
    LinkedQueue queue = new LinkedQueue();

    // Mark current vertex as visited
    visited[startVertex] = true;
    queue.enqueue(startVertex);

    while (!queue.isEmpty()) {
        // Dequeue a vertex and print it
        int vertex = queue.dequeue();
        System.out.print(vertex + " ");

        // Get all adjacent vertices of the dequeued vertex
        // If adjacent has not been visited, mark it visited and enqueue it
        for (int adjVertex : graph.getAdjVertices(vertex)) {
            if (!visited[adjVertex]) {
                visited[adjVertex] = true;
                queue.enqueue(adjVertex);
            }
        }
    }
}
```

#### Service Queue Simulation

```java
public class CustomerService {
    private LinkedQueue queue;
    private int maxWaitTime;

    public CustomerService() {
        queue = new LinkedQueue();
        maxWaitTime = 0;
    }

    // New customer arrival
    public void customerArrival(int customerId, int arrivalTime) {
        System.out.println("Customer " + customerId + " arrived at " + arrivalTime);
        queue.enqueue(customerId);
    }

    // Serve customer
    public void serveCustomer(int currentTime) {
        if (!queue.isEmpty()) {
            int customerId = queue.dequeue();
            int waitTime = currentTime - customerId;
            maxWaitTime = Math.max(maxWaitTime, waitTime);

            System.out.println("Serving customer " + customerId + " at " + currentTime);
            System.out.println("Wait time: " + waitTime);
        } else {
            System.out.println("No customers waiting.");
        }
    }

    // Get max wait time
    public int getMaxWaitTime() {
        return maxWaitTime;
    }
}
```

#### Level-order traversal in Binary Tree

```java
public void levelOrderTraversal(Node root) {
    if (root == null) {
        return;
    }

    LinkedQueue queue = new LinkedQueue();
    queue.enqueue(root);

    while (!queue.isEmpty()) {
        Node current = (Node)queue.dequeue();
        System.out.print(current.data + " ");

        if (current.left != null) {
            queue.enqueue(current.left);
        }

        if (current.right != null) {
            queue.enqueue(current.right);
        }
    }
}
```

## 🧑‍🏫 Lesson 3: Doubly and Circular Linked Lists

### Doubly Linked List

- Each node contains data and two pointers: one to previous node, one to next node.
- Allows traversal in both directions.

```java
public class DoublyLinkedList {
    private class Node {
        int data;
        Node prev;
        Node next;

        public Node(int data) {
            this.data = data;
            this.prev = null;
            this.next = null;
        }
    }

    private Node head;
    private Node tail;

    public DoublyLinkedList() {
        head = null;
        tail = null;
    }

    // Insert at front
    public void insertAtFront(int data) {
        Node newNode = new Node(data);

        // If list is empty
        if (head == null) {
            head = newNode;
            tail = newNode;
        } else {
            newNode.next = head;
            head.prev = newNode;
            head = newNode;
        }
    }

    // Insert at end
    public void insertAtEnd(int data) {
        Node newNode = new Node(data);

        // If list is empty
        if (tail == null) {
            head = newNode;
            tail = newNode;
        } else {
            tail.next = newNode;
            newNode.prev = tail;
            tail = newNode;
        }
    }

    // Remove from front
    public int removeFromFront() {
        if (head == null) {
            System.out.println("List is empty!");
            return -1;
        }

        int data = head.data;

        // If only one node
        if (head == tail) {
            head = null;
            tail = null;
        } else {
            head = head.next;
            head.prev = null;
        }

        return data;
    }

    // Remove from end
    public int removeFromEnd() {
        if (tail == null) {
            System.out.println("List is empty!");
            return -1;
        }

        int data = tail.data;

        // If only one node
        if (head == tail) {
            head = null;
            tail = null;
        } else {
            tail = tail.prev;
            tail.next = null;
        }

        return data;
    }

    // Display list from front to end
    public void displayForward() {
        Node current = head;
        System.out.print("null <-> ");
        while (current != null) {
            System.out.print(current.data + " <-> ");
            current = current.next;
        }
        System.out.println("null");
    }

    // Display list from end to front
    public void displayBackward() {
        Node current = tail;
        System.out.print("null <-> ");
        while (current != null) {
            System.out.print(current.data + " <-> ");
            current = current.prev;
        }
        System.out.println("null");
    }
}
```

### Circular Linked List

- Last node points to first node, forming a circle.
- Useful for applications needing continuous traversal.

```java
public class CircularLinkedList {
    private class Node {
        int data;
        Node next;

        public Node(int data) {
            this.data = data;
            this.next = null;
        }
    }

    private Node head;
    private Node tail;

    public CircularLinkedList() {
        head = null;
        tail = null;
    }

    // Insert at front
    public void insertAtFront(int data) {
        Node newNode = new Node(data);

        if (head == null) {
            head = newNode;
            tail = newNode;
            tail.next = head; // Create circular link
        } else {
            newNode.next = head;
            head = newNode;
            tail.next = head; // Update circular link
        }
    }

    // Insert at end
    public void insertAtEnd(int data) {
        Node newNode = new Node(data);

        if (tail == null) {
            head = newNode;
            tail = newNode;
            tail.next = head; // Create circular link
        } else {
            tail.next = newNode;
            tail = newNode;
            tail.next = head; // Update circular link
        }
    }

    // Remove from front
    public int removeFromFront() {
        if (head == null) {
            System.out.println("List is empty!");
            return -1;
        }

        int data = head.data;

        // If only one node
        if (head == tail) {
            head = null;
            tail = null;
        } else {
            head = head.next;
            tail.next = head; // Update circular link
        }

        return data;
    }

    // Display list
    public void display() {
        if (head == null) {
            System.out.println("List is empty!");
            return;
        }

        Node current = head;
        do {
            System.out.print(current.data + " -> ");
            current = current.next;
        } while (current != head);

        System.out.println(" (back to " + head.data + ")");
    }
}
```

### Applications of Doubly and Circular Linked Lists

#### Browser History (Doubly Linked List)

```java
public class BrowserHistory {
    private DoublyLinkedList history;
    private Node currentPage;

    private class Node {
        String url;
        Node prev;
        Node next;

        public Node(String url) {
            this.url = url;
            this.prev = null;
            this.next = null;
        }
    }

    public BrowserHistory(String homepage) {
        currentPage = new Node(homepage);
    }

    // Visit new page
    public void visit(String url) {
        Node newPage = new Node(url);
        newPage.prev = currentPage;
        currentPage.next = newPage;
        currentPage = newPage;

        System.out.println("Visited: " + url);
    }

    // Go back
    public String back() {
        if (currentPage.prev != null) {
            currentPage = currentPage.prev;
            return currentPage.url;
        } else {
            return currentPage.url; // Cannot go back
        }
    }

    // Go forward
    public String forward() {
        if (currentPage.next != null) {
            currentPage = currentPage.next;
            return currentPage.url;
        } else {
            return currentPage.url; // Cannot go forward
        }
    }
}
```

#### Round Robin Scheduling (Circular Linked List)

```java
public class RoundRobinScheduler {
    private CircularLinkedList processes;

    public RoundRobinScheduler() {
        processes = new CircularLinkedList();
    }

    // Add new process
    public void addProcess(int processId) {
        processes.insertAtEnd(processId);
        System.out.println("Added process " + processId);
    }

    // Run round robin scheduling
    public void run(int timeQuantum) {
        System.out.println("Starting Round-Robin scheduling with time quantum = " + timeQuantum);

        // Simulate 10 scheduling cycles
        for (int i = 0; i < 10; i++) {
            int processId = processes.removeFromFront();
            System.out.println("Running process " + processId + " for " + timeQuantum + "ms");

            // After running, put process back to end of queue
            processes.insertAtEnd(processId);

            // Simulate running time
            try {
                Thread.sleep(timeQuantum * 10); // Simulate slow
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
```

## 🧑‍🏫 Lesson 4: Binary Tree

### Concept of Tree

- Tree is a hierarchical data structure, consisting of nodes and edges.
- Binary Tree: each node has at most 2 children (left and right).

### Binary Search Tree (BST)

- For every node: all values in left subtree < node value, all values in right subtree > node value.
- Allows fast search: O(log n) if balanced, O(n) in worst case.

```java
public class BinarySearchTree {
    private class Node {
        int data;
        Node left;
        Node right;

        public Node(int data) {
            this.data = data;
            this.left = null;
            this.right = null;
        }
    }

    private Node root;

    public BinarySearchTree() {
        root = null;
    }

    // Insert a value into BST
    public void insert(int value) {
        root = insertRec(root, value);
    }

    private Node insertRec(Node root, int value) {
        // If tree is empty, return new node
        if (root == null) {
            return new Node(value);
        }

        // Otherwise, recur down the tree
        if (value < root.data) {
            root.left = insertRec(root.left, value);
        } else if (value > root.data) {
            root.right = insertRec(root.right, value);
        }

        return root;
    }

    // Search a value in BST
    public boolean search(int value) {
        return searchRec(root, value);
    }

    private boolean searchRec(Node root, int value) {
        // Base condition: tree is empty or value found
        if (root == null) {
            return false;
        }

        if (root.data == value) {
            return true;
        }

        // Value is smaller -> search left subtree
        if (value < root.data) {
            return searchRec(root.left, value);
        }

        // Otherwise, search right subtree
        return searchRec(root.right, value);
    }

    // Delete a value from BST
    public void delete(int value) {
        root = deleteRec(root, value);
    }

    private Node deleteRec(Node root, int value) {
        // Base condition
        if (root == null) {
            return root;
        }

        // Find node to delete
        if (value < root.data) {
            root.left = deleteRec(root.left, value);
        } else if (value > root.data) {
            root.right = deleteRec(root.right, value);
        } else {
            // Node with only one child or no child
            if (root.left == null) {
                return root.right;
            } else if (root.right == null) {
                return root.left;
            }

            // Node with two children: Get the inorder successor (smallest in the right subtree)
            root.data = minValue(root.right);

            // Delete the inorder successor
            root.right = deleteRec(root.right, root.data);
        }

        return root;
    }

    private int minValue(Node root) {
        int minValue = root.data;
        while (root.left != null) {
            minValue = root.left.data;
            root = root.left;
        }
        return minValue;
    }

    // Inorder traversal: left -> root -> right
    public void inorder() {
        inorderRec(root);
        System.out.println();
    }

    private void inorderRec(Node root) {
        if (root != null) {
            inorderRec(root.left);
            System.out.print(root.data + " ");
            inorderRec(root.right);
        }
    }

    // Preorder traversal: root -> left -> right
    public void preorder() {
        preorderRec(root);
        System.out.println();
    }

    private void preorderRec(Node root) {
        if (root != null) {
            System.out.print(root.data + " ");
            preorderRec(root.left);
            preorderRec(root.right);
        }
    }

    // Postorder traversal: left -> right -> root
    public void postorder() {
        postorderRec(root);
        System.out.println();
    }

    private void postorderRec(Node root) {
        if (root != null) {
            postorderRec(root.left);
            postorderRec(root.right);
            System.out.print(root.data + " ");
        }
    }
}
```

### Balancing Binary Tree (we will learn about balanced trees in later part)

- Balanced binary tree has height ~log(n).
- Types of balanced trees: AVL, Red-Black Tree, B-Tree.

## Applications of Binary Tree

1. Dictionaries and symbol tables.
2. File systems.
3. Expression evaluation.
4. Huffman coding.
5. Search and sort algorithms.

## 🧑‍🏫 Lesson 5: Hash Table

### Concept of Hash Table

- Hash table is a data structure that stores key-value pairs.
- Uses a hash function to convert key into an index in an array.
- Allows insert, delete, search with O(1) complexity in average case.

### Hash Function

- Converts key to index in array.
- Properties of a good hash function:
  - Fast computation.
  - Uniform distribution of keys across table range.
  - Minimize collisions.

### Collision Resolution

#### Chaining

- Each position in the table contains a linked list of elements with the same hash code.

#### Open Addressing

- Linear Probing: Find next position in table.
- Quadratic Probing: Find position by squared distance.
- Double Hashing: Use second hash function to calculate distance.

### Hash Table Implementation using Chaining

```java
public class HashTable {
    private class HashNode {
        String key;
        int value;
        HashNode next;

        public HashNode(String key, int value) {
            this.key = key;
            this.value = value;
            this.next = null;
        }
    }

    private HashNode[] buckets;
    private int numBuckets;
    private int size;

    public HashTable() {
        this(10); // Default size
    }

    public HashTable(int capacity) {
        numBuckets = capacity;
        buckets = new HashNode[numBuckets];
        size = 0;
    }

    // Hash function
    private int hashFunction(String key) {
        int hashCode = key.hashCode();
        return Math.abs(hashCode) % numBuckets;
    }

    // Hash table size
    public int size() {
        return size;
    }

    // Check if hash table is empty
    public boolean isEmpty() {
        return size() == 0;
    }

    // Add element to hash table
    public void put(String key, int value) {
        // Find bucket index from key
        int bucketIndex = hashFunction(key);
        HashNode head = buckets[bucketIndex];

        // Check if key already exists, then update value
        while (head != null) {
            if (head.key.equals(key)) {
                head.value = value;
                return;
            }
            head = head.next;
        }

        // Add new node to head of linked list
        size++;
        head = buckets[bucketIndex];
        HashNode newNode = new HashNode(key, value);
        newNode.next = head;
        buckets[bucketIndex] = newNode;
    }

    // Get value from key
    public int get(String key) {
        // Find bucket index from key
        int bucketIndex = hashFunction(key);
        HashNode head = buckets[bucketIndex];

        // Search key in linked list
        while (head != null) {
            if (head.key.equals(key)) {
                return head.value;
            }
            head = head.next;
        }

        // Key not found
        return -1;
    }

    // Remove element with specific key
    public int remove(String key) {
        // Find bucket index from key
        int bucketIndex = hashFunction(key);
        HashNode head = buckets[bucketIndex];
        HashNode prev = null;

        // Search key in linked list
        while (head != null) {
            if (head.key.equals(key)) {
                break;
            }
            prev = head;
            head = head.next;
        }

        // If key not found
        if (head == null) {
            return -1;
        }

        // Decrease size
        size--;

        // Remove node
        if (prev != null) {
            prev.next = head.next;
        } else {
            buckets[bucketIndex] = head.next;
        }

        return head.value;
    }

    // Display hash table
    public void display() {
        for (int i = 0; i < numBuckets; i++) {
            System.out.print("Bucket " + i + ": ");
            HashNode current = buckets[i];
            while (current != null) {
                System.out.print("(" + current.key + ":" + current.value + ") ");
                current = current.next;
            }
            System.out.println();
        }
    }
}
```

### Applications of Hash Table

1. Dictionaries and caches.
2. Symbol tables in compilers.
3. Database indexing.
4. Implementing Sets and Maps.
5. File storage and retrieval.

```java
// Example using hash table as dictionary
public class Dictionary {
    private HashTable hashTable;

    public Dictionary() {
        hashTable = new HashTable(100);
    }

    // Add word to dictionary
    public void addWord(String word, int meaning) {
        hashTable.put(word, meaning);
        System.out.println("Added word \"" + word + "\" to dictionary.");
    }

    // Lookup word
    public void lookupWord(String word) {
        int meaning = hashTable.get(word);
        if (meaning != -1) {
            System.out.println("Meaning of \"" + word + "\": " + meaning);
        } else {
            System.out.println("Word \"" + word + "\" not found in dictionary.");
        }
    }

    // Remove word
    public void removeWord(String word) {
        int result = hashTable.remove(word);
        if (result != -1) {
            System.out.println("Removed word \"" + word + "\" from dictionary.");
        } else {
            System.out.println("Word \"" + word + "\" not found in dictionary.");
        }
    }

    // Display all words
    public void displayDictionary() {
        System.out.println("Dictionary:");
        hashTable.display();
    }
}
```

## 🧪 FINAL PROJECT: Arithmetic Expression Evaluator

### Problem Description

Write a program that allows users to:

- Input an arithmetic expression as a string (e.g., "3 + 4 \* 2 - (6 / 3)")
- Convert expression from infix to postfix notation
- Evaluate expression and return result
- Handle exceptions like syntax errors, division by zero, etc.
- Support operators +, -, \*, /, ^, (), with integers

### Program Output (Example)

```text
ARITHMETIC EXPRESSION EVALUATOR
-----------------------------------
Enter expression (type 'exit' to quit): 3 + 4 * 2 - (6 / 3)

Infix Expression: 3 + 4 * 2 - (6 / 3)
Postfix Expression: 3 4 2 * + 6 3 / -
Result: 9

Enter expression (type 'exit' to quit): 5 * (3 + 2) - 4 ^ 2

Infix Expression: 5 * (3 + 2) - 4 ^ 2
Postfix Expression: 5 3 2 + * 4 2 ^ -
Result: 9

Enter expression (type 'exit' to quit): 10 / (3 - 3)

Infix Expression: 10 / (3 - 3)
Postfix Expression: 10 3 3 - /
Error: Division by zero!

Enter expression (type 'exit' to quit): exit
Thank you for using the program!
```
