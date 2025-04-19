# 📘 PHẦN 2: CẤU TRÚC DỮ LIỆU NÂNG CAO

## Table of Contents

- [📘 PHẦN 2: CẤU TRÚC DỮ LIỆU NÂNG CAO](#-phần-2-cấu-trúc-dữ-liệu-nâng-cao)
  - [Table of Contents](#table-of-contents)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Ngăn xếp (Stack)](#-bài-1-ngăn-xếp-stack)
  - [🧑‍🏫 Bài 2: Hàng đợi (Queue)](#-bài-2-hàng-đợi-queue)
  - [🧑‍🏫 Bài 3: Danh sách liên kết đôi và vòng](#-bài-3-danh-sách-liên-kết-đôi-và-vòng)
  - [🧑‍🏫 Bài 4: Cây nhị phân](#-bài-4-cây-nhị-phân)
  - [🧑‍🏫 Bài 5: Bảng băm (Hash Table)](#-bài-5-bảng-băm-hash-table)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN](#-bài-tập-lớn-cuối-phần)
    - [**Đề bài: Bộ đánh giá biểu thức số học**](#đề-bài-bộ-đánh-giá-biểu-thức-số-học)
    - [**Kết quả chạy chương trình (Ví dụ):**](#kết-quả-chạy-chương-trình-ví-dụ)

## 🎯 Mục tiêu tổng quát

- Nắm vững các cấu trúc dữ liệu nâng cao như Stack, Queue, cây nhị phân, bảng băm.
- Hiểu cách cài đặt và ứng dụng của từng cấu trúc dữ liệu.
- Biết cách lựa chọn cấu trúc dữ liệu phù hợp cho từng bài toán.

---

## 🧑‍🏫 Bài 1: Ngăn xếp (Stack)

**Khái niệm về Stack:**

- Stack là cấu trúc dữ liệu dạng LIFO (Last In First Out) - Vào sau, ra trước
- Các thao tác cơ bản: push (thêm vào đỉnh), pop (lấy từ đỉnh), peek (xem đỉnh)

**Cài đặt Stack sử dụng mảng:**

```java
public class ArrayStack {
    private int maxSize;
    private int[] stackArray;
    private int top;

    // Khởi tạo stack
    public ArrayStack(int size) {
        maxSize = size;
        stackArray = new int[maxSize];
        top = -1; // Stack trống
    }

    // Thêm phần tử vào đỉnh stack
    public void push(int value) {
        if (top == maxSize - 1) {
            System.out.println("Stack đầy!");
            return;
        }
        stackArray[++top] = value;
    }

    // Lấy phần tử khỏi đỉnh stack
    public int pop() {
        if (top == -1) {
            System.out.println("Stack trống!");
            return -1;
        }
        return stackArray[top--];
    }

    // Xem phần tử ở đỉnh mà không xóa
    public int peek() {
        if (top == -1) {
            System.out.println("Stack trống!");
            return -1;
        }
        return stackArray[top];
    }

    // Kiểm tra stack có trống không
    public boolean isEmpty() {
        return (top == -1);
    }

    // Kiểm tra stack có đầy không
    public boolean isFull() {
        return (top == maxSize - 1);
    }
}
```

**Cài đặt Stack sử dụng danh sách liên kết:**

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

    // Thêm vào đỉnh stack
    public void push(int value) {
        Node newNode = new Node(value);
        newNode.next = top;
        top = newNode;
    }

    // Lấy từ đỉnh stack
    public int pop() {
        if (isEmpty()) {
            System.out.println("Stack trống!");
            return -1;
        }

        int value = top.data;
        top = top.next;
        return value;
    }

    // Xem đỉnh stack
    public int peek() {
        if (isEmpty()) {
            System.out.println("Stack trống!");
            return -1;
        }
        return top.data;
    }

    // Kiểm tra stack có trống không
    public boolean isEmpty() {
        return top == null;
    }
}
```

**Ứng dụng của Stack:**

1. **Kiểm tra chuỗi dấu ngoặc**:

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

2. **Đảo ngược chuỗi**:

```java
public String reverse(String str) {
    LinkedStack stack = new LinkedStack();

    // Đẩy tất cả ký tự vào stack
    for (char c : str.toCharArray()) {
        stack.push(c);
    }

    // Lấy từng ký tự khỏi stack để tạo chuỗi đảo ngược
    StringBuilder reversed = new StringBuilder();
    while (!stack.isEmpty()) {
        reversed.append((char)stack.pop());
    }

    return reversed.toString();
}
```

3. **Chuyển đổi biểu thức trung tố sang hậu tố**:

```java
public String infixToPostfix(String infix) {
    StringBuilder postfix = new StringBuilder();
    java.util.Stack<Character> stack = new java.util.Stack<>();

    for (char c : infix.toCharArray()) {
        // Nếu là toán hạng, thêm vào chuỗi kết quả
        if (Character.isLetterOrDigit(c)) {
            postfix.append(c);
        }
        // Nếu là dấu mở ngoặc, đẩy vào stack
        else if (c == '(') {
            stack.push(c);
        }
        // Nếu là dấu đóng ngoặc, lấy từ stack đến khi gặp dấu mở ngoặc
        else if (c == ')') {
            while (!stack.isEmpty() && stack.peek() != '(') {
                postfix.append(stack.pop());
            }
            stack.pop(); // Loại bỏ '('
        }
        // Nếu là toán tử, so sánh độ ưu tiên với toán tử ở đỉnh stack
        else {
            while (!stack.isEmpty() && precedence(c) <= precedence(stack.peek())) {
                postfix.append(stack.pop());
            }
            stack.push(c);
        }
    }

    // Đẩy các toán tử còn lại trong stack vào chuỗi kết quả
    while (!stack.isEmpty()) {
        postfix.append(stack.pop());
    }

    return postfix.toString();
}

// Xác định độ ưu tiên toán tử
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

---

## 🧑‍🏫 Bài 2: Hàng đợi (Queue)

**Khái niệm về Queue:**

- Queue là cấu trúc dữ liệu dạng FIFO (First In First Out) - Vào trước, ra trước
- Các thao tác cơ bản: enqueue (thêm vào cuối), dequeue (lấy từ đầu), peek (xem đầu)

**Cài đặt Queue sử dụng mảng (Queue vòng):**

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

    // Thêm vào cuối queue
    public void enqueue(int value) {
        if (isFull()) {
            System.out.println("Queue đầy!");
            return;
        }
        // Tăng rear và quay vòng nếu cần
        rear = (rear + 1) % maxSize;
        queueArray[rear] = value;
        nItems++;
    }

    // Lấy từ đầu queue
    public int dequeue() {
        if (isEmpty()) {
            System.out.println("Queue trống!");
            return -1;
        }
        int temp = queueArray[front];
        front = (front + 1) % maxSize;
        nItems--;
        return temp;
    }

    // Xem phần tử đầu queue
    public int peek() {
        if (isEmpty()) {
            System.out.println("Queue trống!");
            return -1;
        }
        return queueArray[front];
    }

    // Kiểm tra queue có trống không
    public boolean isEmpty() {
        return (nItems == 0);
    }

    // Kiểm tra queue có đầy không
    public boolean isFull() {
        return (nItems == maxSize);
    }

    // Kích thước hiện tại của queue
    public int size() {
        return nItems;
    }
}
```

**Cài đặt Queue sử dụng danh sách liên kết:**

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

    // Thêm vào cuối queue
    public void enqueue(int value) {
        Node newNode = new Node(value);

        // Nếu queue trống
        if (rear == null) {
            front = newNode;
            rear = newNode;
            return;
        }

        // Thêm vào sau rear và cập nhật rear
        rear.next = newNode;
        rear = newNode;
    }

    // Lấy từ đầu queue
    public int dequeue() {
        if (isEmpty()) {
            System.out.println("Queue trống!");
            return -1;
        }

        // Lưu giá trị cần trả về
        int value = front.data;

        // Di chuyển front
        front = front.next;

        // Nếu front trở thành null, cập nhật cả rear
        if (front == null) {
            rear = null;
        }

        return value;
    }

    // Xem phần tử đầu queue
    public int peek() {
        if (isEmpty()) {
            System.out.println("Queue trống!");
            return -1;
        }
        return front.data;
    }

    // Kiểm tra queue có trống không
    public boolean isEmpty() {
        return front == null;
    }
}
```

**Ứng dụng của Queue:**

1. **Thuật toán BFS (Breadth-First Search)**:

```java
public void BFS(Graph graph, int startVertex) {
    // Đánh dấu tất cả các đỉnh chưa thăm
    boolean[] visited = new boolean[graph.getVertexCount()];

    // Tạo queue
    LinkedQueue queue = new LinkedQueue();

    // Đánh dấu đỉnh hiện tại đã thăm
    visited[startVertex] = true;
    queue.enqueue(startVertex);

    while (!queue.isEmpty()) {
        // Lấy một đỉnh từ queue và in ra
        int vertex = queue.dequeue();
        System.out.print(vertex + " ");

        // Lấy tất cả các đỉnh kề của đỉnh lấy ra
        // Nếu đỉnh kề chưa được thăm, đánh dấu đã thăm và thêm vào queue
        for (int adjVertex : graph.getAdjVertices(vertex)) {
            if (!visited[adjVertex]) {
                visited[adjVertex] = true;
                queue.enqueue(adjVertex);
            }
        }
    }
}
```

2. **Mô phỏng hàng đợi dịch vụ**:

```java
public class CustomerService {
    private LinkedQueue queue;
    private int maxWaitTime;

    public CustomerService() {
        queue = new LinkedQueue();
        maxWaitTime = 0;
    }

    // Khách hàng mới đến
    public void customerArrival(int customerId, int arrivalTime) {
        System.out.println("Khách hàng " + customerId + " đến lúc " + arrivalTime);
        queue.enqueue(customerId);
    }

    // Phục vụ khách hàng
    public void serveCustomer(int currentTime) {
        if (!queue.isEmpty()) {
            int customerId = queue.dequeue();
            int waitTime = currentTime - customerId;
            maxWaitTime = Math.max(maxWaitTime, waitTime);

            System.out.println("Phục vụ khách hàng " + customerId + " lúc " + currentTime);
            System.out.println("Thời gian chờ: " + waitTime);
        } else {
            System.out.println("Không có khách hàng chờ.");
        }
    }

    // Lấy thời gian chờ tối đa
    public int getMaxWaitTime() {
        return maxWaitTime;
    }
}
```

3. **Level-order traversal trong cây nhị phân**:

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

---

## 🧑‍🏫 Bài 3: Danh sách liên kết đôi và vòng

**Danh sách liên kết đôi (Doubly Linked List):**

- Mỗi nút chứa dữ liệu và hai con trỏ: một trỏ đến nút trước, một trỏ đến nút sau
- Cho phép duyệt theo hai hướng

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

    // Thêm vào đầu danh sách
    public void insertAtFront(int data) {
        Node newNode = new Node(data);

        // Nếu danh sách trống
        if (head == null) {
            head = newNode;
            tail = newNode;
        } else {
            newNode.next = head;
            head.prev = newNode;
            head = newNode;
        }
    }

    // Thêm vào cuối danh sách
    public void insertAtEnd(int data) {
        Node newNode = new Node(data);

        // Nếu danh sách trống
        if (tail == null) {
            head = newNode;
            tail = newNode;
        } else {
            tail.next = newNode;
            newNode.prev = tail;
            tail = newNode;
        }
    }

    // Xóa nút từ đầu danh sách
    public int removeFromFront() {
        if (head == null) {
            System.out.println("Danh sách trống!");
            return -1;
        }

        int data = head.data;

        // Nếu chỉ có một nút
        if (head == tail) {
            head = null;
            tail = null;
        } else {
            head = head.next;
            head.prev = null;
        }

        return data;
    }

    // Xóa nút từ cuối danh sách
    public int removeFromEnd() {
        if (tail == null) {
            System.out.println("Danh sách trống!");
            return -1;
        }

        int data = tail.data;

        // Nếu chỉ có một nút
        if (head == tail) {
            head = null;
            tail = null;
        } else {
            tail = tail.prev;
            tail.next = null;
        }

        return data;
    }

    // In danh sách từ đầu đến cuối
    public void displayForward() {
        Node current = head;
        System.out.print("null <-> ");
        while (current != null) {
            System.out.print(current.data + " <-> ");
            current = current.next;
        }
        System.out.println("null");
    }

    // In danh sách từ cuối đến đầu
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

**Danh sách liên kết vòng (Circular Linked List):**

- Nút cuối trỏ về nút đầu, tạo thành vòng
- Hữu ích cho các ứng dụng cần duyệt liên tục

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

    // Thêm vào đầu danh sách
    public void insertAtFront(int data) {
        Node newNode = new Node(data);

        if (head == null) {
            head = newNode;
            tail = newNode;
            tail.next = head; // Tạo liên kết vòng
        } else {
            newNode.next = head;
            head = newNode;
            tail.next = head; // Cập nhật liên kết vòng
        }
    }

    // Thêm vào cuối danh sách
    public void insertAtEnd(int data) {
        Node newNode = new Node(data);

        if (tail == null) {
            head = newNode;
            tail = newNode;
            tail.next = head; // Tạo liên kết vòng
        } else {
            tail.next = newNode;
            tail = newNode;
            tail.next = head; // Cập nhật liên kết vòng
        }
    }

    // Xóa từ đầu danh sách
    public int removeFromFront() {
        if (head == null) {
            System.out.println("Danh sách trống!");
            return -1;
        }

        int data = head.data;

        // Nếu chỉ có một nút
        if (head == tail) {
            head = null;
            tail = null;
        } else {
            head = head.next;
            tail.next = head; // Cập nhật liên kết vòng
        }

        return data;
    }

    // In danh sách
    public void display() {
        if (head == null) {
            System.out.println("Danh sách trống!");
            return;
        }

        Node current = head;
        do {
            System.out.print(current.data + " -> ");
            current = current.next;
        } while (current != head);

        System.out.println(" (quay lại " + head.data + ")");
    }
}
```

**Ứng dụng của danh sách liên kết đôi và vòng:**

1. **Browser History (Danh sách liên kết đôi)**:

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

    // Truy cập trang mới
    public void visit(String url) {
        Node newPage = new Node(url);
        newPage.prev = currentPage;
        currentPage.next = newPage;
        currentPage = newPage;

        System.out.println("Đã truy cập: " + url);
    }

    // Quay lại trang trước
    public String back() {
        if (currentPage.prev != null) {
            currentPage = currentPage.prev;
            return currentPage.url;
        } else {
            return currentPage.url; // Không thể quay lại
        }
    }

    // Đi tới trang sau
    public String forward() {
        if (currentPage.next != null) {
            currentPage = currentPage.next;
            return currentPage.url;
        } else {
            return currentPage.url; // Không thể đi tiếp
        }
    }
}
```

2. **Round Robin Scheduling (Danh sách liên kết vòng)**:

```java
public class RoundRobinScheduler {
    private CircularLinkedList processes;

    public RoundRobinScheduler() {
        processes = new CircularLinkedList();
    }

    // Thêm tiến trình mới
    public void addProcess(int processId) {
        processes.insertAtEnd(processId);
        System.out.println("Đã thêm tiến trình " + processId);
    }

    // Chạy lập lịch round robin
    public void run(int timeQuantum) {
        System.out.println("Bắt đầu lập lịch Round-Robin với quantum thời gian = " + timeQuantum);

        // Mô phỏng 10 chu kỳ lập lịch
        for (int i = 0; i < 10; i++) {
            int processId = processes.removeFromFront();
            System.out.println("Chạy tiến trình " + processId + " trong " + timeQuantum + "ms");

            // Sau khi chạy, đưa tiến trình lại cuối hàng đợi
            processes.insertAtEnd(processId);

            // Mô phỏng thời gian chạy
            try {
                Thread.sleep(timeQuantum * 10); // Mô phỏng chậm
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
```

---

## 🧑‍🏫 Bài 4: Cây nhị phân

**Khái niệm về cây:**

- Cây là cấu trúc dữ liệu phân cấp, gồm các nút (node) và cạnh (edge)
- Cây nhị phân: mỗi nút có tối đa 2 nút con (trái và phải)

**Cây nhị phân tìm kiếm (Binary Search Tree - BST):**

- Với mọi nút: tất cả các giá trị trong cây con trái < giá trị nút, tất cả các giá trị trong cây con phải > giá trị nút
- Cho phép tìm kiếm nhanh: O(log n) nếu cân bằng, O(n) trong trường hợp xấu nhất

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

    // Thêm một giá trị vào BST
    public void insert(int value) {
        root = insertRec(root, value);
    }

    private Node insertRec(Node root, int value) {
        // Nếu cây rỗng, trả về nút mới
        if (root == null) {
            return new Node(value);
        }

        // Nếu không, đệ quy xuống cây
        if (value < root.data) {
            root.left = insertRec(root.left, value);
        } else if (value > root.data) {
            root.right = insertRec(root.right, value);
        }

        return root;
    }

    // Tìm kiếm một giá trị trong BST
    public boolean search(int value) {
        return searchRec(root, value);
    }

    private boolean searchRec(Node root, int value) {
        // Điều kiện cơ sở: cây rỗng hoặc tìm thấy giá trị
        if (root == null) {
            return false;
        }

        if (root.data == value) {
            return true;
        }

        // Giá trị nhỏ hơn -> tìm kiếm cây con bên trái
        if (value < root.data) {
            return searchRec(root.left, value);
        }

        // Ngược lại, tìm kiếm cây con bên phải
        return searchRec(root.right, value);
    }

    // Xóa một giá trị khỏi BST
    public void delete(int value) {
        root = deleteRec(root, value);
    }

    private Node deleteRec(Node root, int value) {
        // Điều kiện cơ sở
        if (root == null) {
            return root;
        }

        // Tìm nút cần xóa
        if (value < root.data) {
            root.left = deleteRec(root.left, value);
        } else if (value > root.data) {
            root.right = deleteRec(root.right, value);
        } else {
            // Nút có một hoặc không có con
            if (root.left == null) {
                return root.right;
            } else if (root.right == null) {
                return root.left;
            }

            // Nút có hai con: tìm phần tử nhỏ nhất của cây con bên phải
            root.data = minValue(root.right);

            // Xóa phần tử nhỏ nhất của cây con bên phải
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

    // Duyệt cây theo thứ tự trung (Inorder traversal): trái -> gốc -> phải
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

    // Duyệt cây theo thứ tự trước (Preorder traversal): gốc -> trái -> phải
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

    // Duyệt cây theo thứ tự sau (Postorder traversal): trái -> phải -> gốc
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

**Cân bằng cây nhị phân:**

- Cây nhị phân cân bằng có chiều cao ~log(n)
- Các loại cây cân bằng: AVL, Red-Black Tree, B-Tree

**Cây AVL (cây cân bằng):**

```java
public class AVLTree {
    private class Node {
        int data;
        Node left;
        Node right;
        int height;

        public Node(int data) {
            this.data = data;
            this.left = null;
            this.right = null;
            this.height = 1;
        }
    }

    private Node root;

    // Lấy chiều cao của nút
    private int height(Node N) {
        if (N == null) {
            return 0;
        }
        return N.height;
    }

    // Lấy hệ số cân bằng của nút
    private int getBalance(Node N) {
        if (N == null) {
            return 0;
        }
        return height(N.left) - height(N.right);
    }

    // Xoay phải
    private Node rightRotate(Node y) {
        Node x = y.left;
        Node T2 = x.right;

        // Xoay
        x.right = y;
        y.left = T2;

        // Cập nhật chiều cao
        y.height = Math.max(height(y.left), height(y.right)) + 1;
        x.height = Math.max(height(x.left), height(x.right)) + 1;

        return x;
    }

    // Xoay trái
    private Node leftRotate(Node x) {
        Node y = x.right;
        Node T2 = y.left;

        // Xoay
        y.left = x;
        x.right = T2;

        // Cập nhật chiều cao
        x.height = Math.max(height(x.left), height(x.right)) + 1;
        y.height = Math.max(height(y.left), height(y.right)) + 1;

        return y;
    }

    // Thêm một nút vào cây
    public void insert(int data) {
        root = insert(root, data);
    }

    private Node insert(Node node, int data) {
        // 1. Thực hiện chèn BST bình thường
        if (node == null) {
            return new Node(data);
        }

        if (data < node.data) {
            node.left = insert(node.left, data);
        } else if (data > node.data) {
            node.right = insert(node.right, data);
        } else {
            return node; // Không cho phép trùng lặp giá trị
        }

        // 2. Cập nhật chiều cao của nút hiện tại
        node.height = 1 + Math.max(height(node.left), height(node.right));

        // 3. Lấy hệ số cân bằng
        int balance = getBalance(node);

        // 4. Nếu nút mất cân bằng, có 4 trường hợp

        // Trường hợp Left Left
        if (balance > 1 && data < node.left.data) {
            return rightRotate(node);
        }

        // Trường hợp Right Right
        if (balance < -1 && data > node.right.data) {
            return leftRotate(node);
        }

        // Trường hợp Left Right
        if (balance > 1 && data > node.left.data) {
            node.left = leftRotate(node.left);
            return rightRotate(node);
        }

        // Trường hợp Right Left
        if (balance < -1 && data < node.right.data) {
            node.right = rightRotate(node.right);
            return leftRotate(node);
        }

        return node;
    }

    // In cây theo thứ tự inorder
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
}
```

**Ứng dụng của cây nhị phân:**

1. **Từ điển và bảng ký hiệu**
2. **Hệ thống tập tin**
3. **Đánh giá biểu thức**
4. **Mã hóa Huffman**
5. **Thuật toán tìm kiếm và sắp xếp**

---

## 🧑‍🏫 Bài 5: Bảng băm (Hash Table)

**Khái niệm về bảng băm:**

- Bảng băm là cấu trúc dữ liệu lưu trữ theo cặp khóa-giá trị (key-value)
- Sử dụng hàm băm (hash function) để chuyển đổi khóa thành chỉ số trong mảng
- Cho phép thêm, xóa, tìm kiếm với độ phức tạp O(1) trong trường hợp trung bình

**Hàm băm (Hash Function):**

- Chuyển đổi khóa thành chỉ số trong mảng
- Tính chất của hàm băm tốt:
  - Nhanh chóng tính toán
  - Phân phối đều các khóa trên phạm vi của bảng
  - Tối thiểu hóa va chạm (collision)

**Xử lý va chạm (Collision Resolution):**

1. **Chuỗi liên kết (Chaining):**

   - Mỗi vị trí trong bảng chứa danh sách liên kết các phần tử có cùng mã băm

2. **Địa chỉ mở (Open Addressing):**
   - Linear Probing: Tìm vị trí tiếp theo trong bảng
   - Quadratic Probing: Tìm vị trí theo bình phương khoảng cách
   - Double Hashing: Sử dụng hàm băm thứ hai để tính khoảng cách

**Cài đặt bảng băm sử dụng chuỗi liên kết:**

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

    // Hàm băm
    private int hashFunction(String key) {
        int hashCode = key.hashCode();
        return Math.abs(hashCode) % numBuckets;
    }

    // Kích thước bảng băm
    public int size() {
        return size;
    }

    // Kiểm tra bảng băm có trống không
    public boolean isEmpty() {
        return size() == 0;
    }

    // Thêm phần tử vào bảng băm
    public void put(String key, int value) {
        // Tìm chỉ số bucket từ khóa
        int bucketIndex = hashFunction(key);
        HashNode head = buckets[bucketIndex];

        // Kiểm tra nếu khóa đã tồn tại, thì cập nhật giá trị
        while (head != null) {
            if (head.key.equals(key)) {
                head.value = value;
                return;
            }
            head = head.next;
        }

        // Thêm nút mới vào đầu danh sách liên kết
        size++;
        head = buckets[bucketIndex];
        HashNode newNode = new HashNode(key, value);
        newNode.next = head;
        buckets[bucketIndex] = newNode;
    }

    // Lấy giá trị từ khóa
    public int get(String key) {
        // Tìm chỉ số bucket từ khóa
        int bucketIndex = hashFunction(key);
        HashNode head = buckets[bucketIndex];

        // Tìm kiếm khóa trong danh sách liên kết
        while (head != null) {
            if (head.key.equals(key)) {
                return head.value;
            }
            head = head.next;
        }

        // Khóa không tồn tại
        return -1;
    }

    // Xóa phần tử với khóa cụ thể
    public int remove(String key) {
        // Tìm chỉ số bucket từ khóa
        int bucketIndex = hashFunction(key);
        HashNode head = buckets[bucketIndex];
        HashNode prev = null;

        // Tìm kiếm khóa trong danh sách liên kết
        while (head != null) {
            if (head.key.equals(key)) {
                break;
            }
            prev = head;
            head = head.next;
        }

        // Nếu khóa không tồn tại
        if (head == null) {
            return -1;
        }

        // Giảm kích thước
        size--;

        // Xóa nút
        if (prev != null) {
            prev.next = head.next;
        } else {
            buckets[bucketIndex] = head.next;
        }

        return head.value;
    }

    // In bảng băm
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

**Ứng dụng của bảng băm:**

1. **Từ điển và bộ nhớ cache**
2. **Bảng ký hiệu trong trình biên dịch**
3. **Bảng tìm kiếm trong cơ sở dữ liệu**
4. **Cài đặt các tập hợp (Set) và bảng ánh xạ (Map)**
5. **Lưu trữ và tìm kiếm các tệp**

```java
// Ví dụ sử dụng bảng băm làm từ điển
public class Dictionary {
    private HashTable hashTable;

    public Dictionary() {
        hashTable = new HashTable(100);
    }

    // Thêm từ vào từ điển
    public void addWord(String word, int meaning) {
        hashTable.put(word, meaning);
        System.out.println("Đã thêm từ \"" + word + "\" vào từ điển.");
    }

    // Tra cứu từ
    public void lookupWord(String word) {
        int meaning = hashTable.get(word);
        if (meaning != -1) {
            System.out.println("Nghĩa của \"" + word + "\": " + meaning);
        } else {
            System.out.println("Từ \"" + word + "\" không có trong từ điển.");
        }
    }

    // Xóa từ
    public void removeWord(String word) {
        int result = hashTable.remove(word);
        if (result != -1) {
            System.out.println("Đã xóa từ \"" + word + "\" khỏi từ điển.");
        } else {
            System.out.println("Từ \"" + word + "\" không có trong từ điển.");
        }
    }

    // Hiển thị tất cả các từ
    public void displayDictionary() {
        System.out.println("Từ điển:");
        hashTable.display();
    }
}
```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Bộ đánh giá biểu thức số học**

Viết chương trình cho phép người dùng:

- Nhập một biểu thức số học dưới dạng chuỗi (ví dụ: "3 + 4 \* 2 - (6 / 3)")
- Chuyển đổi biểu thức từ dạng trung tố (infix) sang hậu tố (postfix)
- Đánh giá biểu thức và trả về kết quả
- Xử lý ngoại lệ như lỗi cú pháp, chia cho 0, v.v.
- Cho phép sử dụng các toán tử +, -, \*, /, ^, (), với các số nguyên

### **Kết quả chạy chương trình (Ví dụ):**

```text
BỘ ĐÁNH GIÁ BIỂU THỨC SỐ HỌC
-----------------------------------
Nhập biểu thức (nhập 'exit' để thoát): 3 + 4 * 2 - (6 / 3)

Biểu thức trung tố: 3 + 4 * 2 - (6 / 3)
Biểu thức hậu tố: 3 4 2 * + 6 3 / -
Kết quả: 9

Nhập biểu thức (nhập 'exit' để thoát): 5 * (3 + 2) - 4 ^ 2

Biểu thức trung tố: 5 * (3 + 2) - 4 ^ 2
Biểu thức hậu tố: 5 3 2 + * 4 2 ^ -
Kết quả: 9

Nhập biểu thức (nhập 'exit' để thoát): 10 / (3 - 3)

Biểu thức trung tố: 10 / (3 - 3)
Biểu thức hậu tố: 10 3 3 - /
Lỗi: Chia cho 0!

Nhập biểu thức (nhập 'exit' để thoát): exit
Cảm ơn bạn đã sử dụng chương trình!
```
