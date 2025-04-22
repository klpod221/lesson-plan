# 📘 PHẦN 3: THUẬT TOÁN NÂNG CAO

## Table of Contents

- [📘 PHẦN 3: THUẬT TOÁN NÂNG CAO](#-phần-3-thuật-toán-nâng-cao)
  - [Table of Contents](#table-of-contents)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Thuật toán đệ quy](#-bài-1-thuật-toán-đệ-quy)
    - [**Ví dụ 1: Tính giai thừa**](#ví-dụ-1-tính-giai-thừa)
    - [**Ví dụ 2: Dãy Fibonacci**](#ví-dụ-2-dãy-fibonacci)
    - [**Ví dụ 3: Tháp Hà Nội**](#ví-dụ-3-tháp-hà-nội)
  - [🧑‍🏫 Bài 2: Thuật toán sắp xếp nâng cao](#-bài-2-thuật-toán-sắp-xếp-nâng-cao)
  - [🧑‍🏫 Bài 3: Các thuật toán Graph](#-bài-3-các-thuật-toán-graph)
  - [🧑‍🏫 Bài 4: Thuật toán tham lam (Greedy Algorithms)](#-bài-4-thuật-toán-tham-lam-greedy-algorithms)
  - [🧑‍🏫 Bài 5: Quy hoạch động (Dynamic Programming)](#-bài-5-quy-hoạch-động-dynamic-programming)
  - [🧑‍💻 Bài tập lớn cuối phần](#-bài-tập-lớn-cuối-phần)
    - [**Đề bài: Xây dựng ứng dụng tìm đường đi ngắn nhất**](#đề-bài-xây-dựng-ứng-dụng-tìm-đường-đi-ngắn-nhất)
    - [**Kết quả chạy chương trình (Ví dụ):**](#kết-quả-chạy-chương-trình-ví-dụ)

## 🎯 Mục tiêu tổng quát

- Hiểu sâu và cài đặt được các thuật toán nâng cao.
- Biết cách áp dụng các kỹ thuật thiết kế thuật toán vào bài toán thực tế.
- Phân tích được ưu nhược điểm của mỗi thuật toán và lựa chọn thuật toán phù hợp.
- Nắm vững cách tiếp cận và giải quyết các bài toán phức tạp.

---

## 🧑‍🏫 Bài 1: Thuật toán đệ quy

**Khái niệm về đệ quy:**

- Đệ quy là kỹ thuật một hàm gọi lại chính nó để giải quyết các bài toán nhỏ hơn của cùng dạng.
- Cấu trúc của đệ quy gồm hai phần:
  - **Điều kiện cơ sở (Base case)**: Điều kiện dừng đệ quy
  - **Công thức đệ quy (Recursive case)**: Cách thu nhỏ bài toán

### **Ví dụ 1: Tính giai thừa**

```java
public static int factorial(int n) {
    // Base case
    if (n == 0 || n == 1) {
        return 1;
    }
    // Recursive case
    return n * factorial(n - 1);
}
```

### **Ví dụ 2: Dãy Fibonacci**

```java
public static int fibonacci(int n) {
    // Base case
    if (n <= 1) {
        return n;
    }
    // Recursive case
    return fibonacci(n - 1) + fibonacci(n - 2);
}
```

### **Ví dụ 3: Tháp Hà Nội**

```java
public static void towerOfHanoi(int n, char source, char auxiliary, char destination) {
    // Base case
    if (n == 1) {
        System.out.println("Di chuyển đĩa 1 từ " + source + " đến " + destination);
        return;
    }

    // Recursive case
    towerOfHanoi(n - 1, source, destination, auxiliary);
    System.out.println("Di chuyển đĩa " + n + " từ " + source + " đến " + destination);
    towerOfHanoi(n - 1, auxiliary, source, destination);
}
```

**Đệ quy đuôi (Tail Recursion):**

- Đệ quy đuôi là khi lời gọi đệ quy là thao tác cuối cùng trong hàm.
- Có thể tối ưu hóa bởi trình biên dịch, tránh tràn ngăn xếp.

```java
// Factorial không phải đệ quy đuôi
public static int factorial(int n) {
    if (n == 0) return 1;
    return n * factorial(n - 1); // Còn phép nhân sau lời gọi đệ quy
}

// Factorial với đệ quy đuôi
public static int factorialTail(int n, int acc) {
    if (n == 0) return acc;
    return factorialTail(n - 1, n * acc); // Lời gọi đệ quy là thao tác cuối cùng
}

// Hàm wrapper
public static int factorial(int n) {
    return factorialTail(n, 1);
}
```

**Ưu và nhược điểm của đệ quy:**

| Ưu điểm                                                                                                           | Nhược điểm                                                                                                     |
| ----------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| - Mã nguồn ngắn gọn, dễ hiểu<br>- Tự nhiên cho một số bài toán<br>- Dễ dàng cài đặt một số thuật toán (ví dụ DFS) | - Chi phí lưu trữ stack cao<br>- Có thể gây tràn stack với đầu vào lớn<br>- Thường chậm hơn giải pháp vòng lặp |

---

## 🧑‍🏫 Bài 2: Thuật toán sắp xếp nâng cao

**1. Quick Sort:**

- Thuật toán chia để trị, sử dụng chiến lược pivot
- Độ phức tạp trung bình: O(n log n)
- Độ phức tạp xấu nhất: O(n²)

```java
public static void quickSort(int[] arr, int low, int high) {
    if (low < high) {
        int pivotIndex = partition(arr, low, high);

        // Sắp xếp các phần tử trước và sau pivot
        quickSort(arr, low, pivotIndex - 1);
        quickSort(arr, pivotIndex + 1, high);
    }
}

private static int partition(int[] arr, int low, int high) {
    int pivot = arr[high]; // Chọn pivot là phần tử cuối
    int i = low - 1; // Index của phần tử nhỏ hơn

    for (int j = low; j < high; j++) {
        // Nếu phần tử hiện tại nhỏ hơn hoặc bằng pivot
        if (arr[j] <= pivot) {
            i++;
            // Swap arr[i] và arr[j]
            int temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
        }
    }

    // Swap arr[i+1] và arr[high] (đặt pivot vào vị trí đúng)
    int temp = arr[i + 1];
    arr[i + 1] = arr[high];
    arr[high] = temp;

    return i + 1; // Trả về vị trí của pivot
}
```

**2. Merge Sort:**

- Thuật toán chia để trị, chia đôi mảng và gộp lại
- Độ phức tạp: O(n log n) trong mọi trường hợp
- Stable sort (giữ nguyên thứ tự các phần tử bằng nhau)

```java
public static void mergeSort(int[] arr, int left, int right) {
    if (left < right) {
        // Tìm điểm giữa
        int mid = left + (right - left) / 2;

        // Sắp xếp nửa đầu
        mergeSort(arr, left, mid);
        // Sắp xếp nửa sau
        mergeSort(arr, mid + 1, right);

        // Gộp hai nửa đã sắp xếp
        merge(arr, left, mid, right);
    }
}

private static void merge(int[] arr, int left, int mid, int right) {
    // Kích thước của hai mảng con
    int n1 = mid - left + 1;
    int n2 = right - mid;

    // Tạo mảng tạm
    int[] L = new int[n1];
    int[] R = new int[n2];

    // Sao chép dữ liệu vào mảng tạm
    for (int i = 0; i < n1; i++)
        L[i] = arr[left + i];
    for (int j = 0; j < n2; j++)
        R[j] = arr[mid + 1 + j];

    // Gộp hai mảng tạm lại
    int i = 0, j = 0;
    int k = left;

    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) {
            arr[k] = L[i];
            i++;
        } else {
            arr[k] = R[j];
            j++;
        }
        k++;
    }

    // Sao chép các phần tử còn lại của L[] nếu có
    while (i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }

    // Sao chép các phần tử còn lại của R[] nếu có
    while (j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }
}
```

**3. Heap Sort:**

- Sử dụng cấu trúc dữ liệu heap (đống)
- Độ phức tạp: O(n log n) trong mọi trường hợp
- In-place sorting (không cần thêm bộ nhớ)

```java
public static void heapSort(int[] arr) {
    int n = arr.length;

    // Xây dựng max heap
    for (int i = n / 2 - 1; i >= 0; i--)
        heapify(arr, n, i);

    // Trích xuất từng phần tử từ heap
    for (int i = n - 1; i > 0; i--) {
        // Di chuyển root (lớn nhất) xuống cuối
        int temp = arr[0];
        arr[0] = arr[i];
        arr[i] = temp;

        // Gọi heapify trên heap đã giảm kích thước
        heapify(arr, i, 0);
    }
}

// Heapify một cây con có root là i
private static void heapify(int[] arr, int n, int i) {
    int largest = i; // Khởi tạo largest là root
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    // Nếu con bên trái lớn hơn root
    if (left < n && arr[left] > arr[largest])
        largest = left;

    // Nếu con bên phải lớn hơn largest hiện tại
    if (right < n && arr[right] > arr[largest])
        largest = right;

    // Nếu largest không phải root
    if (largest != i) {
        int swap = arr[i];
        arr[i] = arr[largest];
        arr[largest] = swap;

        // Tiếp tục heapify cây con bị ảnh hưởng
        heapify(arr, n, largest);
    }
}
```

**So sánh các thuật toán sắp xếp nâng cao:**

| Thuật toán | Thời gian trung bình | Thời gian xấu nhất | Bộ nhớ   | Ổn định | Ghi chú                                             |
| ---------- | -------------------- | ------------------ | -------- | ------- | --------------------------------------------------- |
| Quick Sort | O(n log n)           | O(n²)              | O(log n) | Không   | Nhanh nhất trên thực tế với dữ liệu ngẫu nhiên      |
| Merge Sort | O(n log n)           | O(n log n)         | O(n)     | Có      | Hiệu quả với danh sách liên kết, đảm bảo O(n log n) |
| Heap Sort  | O(n log n)           | O(n log n)         | O(1)     | Không   | Không cần bộ nhớ phụ, ít sử dụng trong thực tế      |

---

## 🧑‍🏫 Bài 3: Các thuật toán Graph

**1. Biểu diễn đồ thị:**

**a. Ma trận kề (Adjacency Matrix):**

- Mảng 2 chiều với A[i][j] = 1 nếu có cạnh từ i đến j, ngược lại A[i][j] = 0
- Phù hợp cho đồ thị dày đặc (dense graph)

```java
public class AdjacencyMatrix {
    private int V; // Số đỉnh
    private int[][] matrix;

    public AdjacencyMatrix(int v) {
        V = v;
        matrix = new int[v][v];
    }

    // Thêm cạnh cho đồ thị vô hướng
    public void addEdge(int source, int destination) {
        matrix[source][destination] = 1;
        matrix[destination][source] = 1; // Bỏ dòng này nếu là đồ thị có hướng
    }

    // In đồ thị
    public void printGraph() {
        for (int i = 0; i < V; i++) {
            for (int j = 0; j < V; j++) {
                System.out.print(matrix[i][j] + " ");
            }
            System.out.println();
        }
    }
}
```

**b. Danh sách kề (Adjacency List):**

- Mảng các danh sách, mỗi phần tử chứa các đỉnh kề
- Phù hợp cho đồ thị thưa (sparse graph)

```java
public class AdjacencyList {
    private int V; // Số đỉnh
    private LinkedList<Integer>[] adjList;

    @SuppressWarnings("unchecked")
    public AdjacencyList(int v) {
        V = v;
        adjList = new LinkedList[v];
        for (int i = 0; i < v; i++) {
            adjList[i] = new LinkedList<>();
        }
    }

    // Thêm cạnh cho đồ thị vô hướng
    public void addEdge(int source, int destination) {
        adjList[source].add(destination);
        adjList[destination].add(source); // Bỏ dòng này nếu là đồ thị có hướng
    }

    // In đồ thị
    public void printGraph() {
        for (int i = 0; i < V; i++) {
            System.out.print("Đỉnh " + i + " kề với: ");
            for (Integer vertex : adjList[i]) {
                System.out.print(vertex + " ");
            }
            System.out.println();
        }
    }
}
```

**2. Duyệt đồ thị:**

**a. Duyệt theo chiều sâu (DFS - Depth-First Search):**

- Sử dụng Stack (ngầm định thông qua đệ quy) để duyệt
- Ưu tiên duyệt sâu trước khi quay lại

```java
public class GraphDFS {
    private int V; // Số đỉnh
    private LinkedList<Integer>[] adjList;

    @SuppressWarnings("unchecked")
    public GraphDFS(int v) {
        V = v;
        adjList = new LinkedList[v];
        for (int i = 0; i < v; i++) {
            adjList[i] = new LinkedList<>();
        }
    }

    // Thêm cạnh
    public void addEdge(int source, int destination) {
        adjList[source].add(destination);
    }

    // DFS từ một đỉnh nguồn
    public void DFS(int startVertex) {
        // Đánh dấu tất cả các đỉnh là chưa thăm
        boolean[] visited = new boolean[V];

        // Gọi hàm DFS đệ quy
        DFSUtil(startVertex, visited);
    }

    // Hàm đệ quy cho DFS
    private void DFSUtil(int vertex, boolean[] visited) {
        // Đánh dấu đỉnh hiện tại là đã thăm và in ra
        visited[vertex] = true;
        System.out.print(vertex + " ");

        // Duyệt tất cả các đỉnh kề với đỉnh hiện tại
        for (Integer neighbor : adjList[vertex]) {
            if (!visited[neighbor]) {
                DFSUtil(neighbor, visited);
            }
        }
    }
}
```

**b. Duyệt theo chiều rộng (BFS - Breadth-First Search):**

- Sử dụng Queue để duyệt
- Ưu tiên duyệt tất cả các đỉnh liền kề trước khi đi sâu hơn

```java
public class GraphBFS {
    private int V; // Số đỉnh
    private LinkedList<Integer>[] adjList;

    @SuppressWarnings("unchecked")
    public GraphBFS(int v) {
        V = v;
        adjList = new LinkedList[v];
        for (int i = 0; i < v; i++) {
            adjList[i] = new LinkedList<>();
        }
    }

    // Thêm cạnh
    public void addEdge(int source, int destination) {
        adjList[source].add(destination);
    }

    // BFS từ một đỉnh nguồn
    public void BFS(int startVertex) {
        // Đánh dấu tất cả các đỉnh là chưa thăm
        boolean[] visited = new boolean[V];

        // Tạo một queue cho BFS
        LinkedList<Integer> queue = new LinkedList<>();

        // Đánh dấu đỉnh hiện tại là đã thăm và thêm vào queue
        visited[startVertex] = true;
        queue.add(startVertex);

        while (!queue.isEmpty()) {
            // Lấy một đỉnh từ queue và in ra
            startVertex = queue.poll();
            System.out.print(startVertex + " ");

            // Lấy tất cả các đỉnh kề của đỉnh vừa lấy
            // Nếu đỉnh chưa được thăm, đánh dấu và thêm vào queue
            for (Integer neighbor : adjList[startVertex]) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    queue.add(neighbor);
                }
            }
        }
    }
}
```

**3. Thuật toán tìm đường đi ngắn nhất:**

**a. Thuật toán Dijkstra:**

- Tìm đường đi ngắn nhất từ một đỉnh đến tất cả các đỉnh còn lại
- Sử dụng priority queue để chọn đỉnh có khoảng cách nhỏ nhất

```java
public class Dijkstra {
    static class Edge {
        int destination;
        int weight;

        Edge(int destination, int weight) {
            this.destination = destination;
            this.weight = weight;
        }
    }

    static class Graph {
        int vertices;
        LinkedList<Edge>[] adjList;

        @SuppressWarnings("unchecked")
        Graph(int vertices) {
            this.vertices = vertices;
            adjList = new LinkedList[vertices];
            for (int i = 0; i < vertices; i++) {
                adjList[i] = new LinkedList<>();
            }
        }

        void addEdge(int source, int destination, int weight) {
            Edge edge = new Edge(destination, weight);
            adjList[source].addFirst(edge);
        }

        void dijkstra(int sourceVertex) {
            int[] distance = new int[vertices];
            boolean[] visited = new boolean[vertices];

            // Khởi tạo khoảng cách với giá trị vô cùng
            Arrays.fill(distance, Integer.MAX_VALUE);
            distance[sourceVertex] = 0;

            // Priority Queue để chọn đỉnh có khoảng cách nhỏ nhất
            PriorityQueue<Edge> pq = new PriorityQueue<>(
                (e1, e2) -> Integer.compare(e1.weight, e2.weight)
            );

            pq.add(new Edge(sourceVertex, 0));

            while (!pq.isEmpty()) {
                // Chọn đỉnh có khoảng cách nhỏ nhất
                Edge current = pq.poll();
                int u = current.destination;

                // Nếu đỉnh đã thăm, bỏ qua
                if (visited[u])
                    continue;

                visited[u] = true;

                // Cập nhật khoảng cách cho các đỉnh kề
                for (Edge e : adjList[u]) {
                    int v = e.destination;
                    int weight = e.weight;

                    if (!visited[v] && distance[u] != Integer.MAX_VALUE &&
                        distance[u] + weight < distance[v]) {
                        distance[v] = distance[u] + weight;
                        pq.add(new Edge(v, distance[v]));
                    }
                }
            }

            // In kết quả
            printDijkstra(distance, sourceVertex);
        }

        void printDijkstra(int[] distance, int sourceVertex) {
            System.out.println("Khoảng cách từ đỉnh " + sourceVertex + " đến các đỉnh khác:");
            for (int i = 0; i < vertices; i++) {
                System.out.println(sourceVertex + " đến " + i + " = " +
                                   (distance[i] == Integer.MAX_VALUE ? "∞" : distance[i]));
            }
        }
    }

    public static void main(String[] args) {
        int vertices = 6;
        Graph graph = new Graph(vertices);

        graph.addEdge(0, 1, 4);
        graph.addEdge(0, 2, 3);
        graph.addEdge(1, 2, 1);
        graph.addEdge(1, 3, 2);
        graph.addEdge(2, 3, 4);
        graph.addEdge(3, 4, 2);
        graph.addEdge(4, 5, 6);

        graph.dijkstra(0);
    }
}
```

**b. Thuật toán Bellman-Ford:**

- Tìm đường đi ngắn nhất từ một đỉnh đến tất cả các đỉnh còn lại
- Xử lý được cạnh có trọng số âm
- Phát hiện chu trình âm

```java
public class BellmanFord {
    class Edge {
        int src, dest, weight;

        Edge() {
            src = dest = weight = 0;
        }
    }

    int V, E;
    Edge[] edges;

    BellmanFord(int v, int e) {
        V = v;
        E = e;
        edges = new Edge[e];
        for (int i = 0; i < e; i++) {
            edges[i] = new Edge();
        }
    }

    void addEdge(int index, int src, int dest, int weight) {
        edges[index].src = src;
        edges[index].dest = dest;
        edges[index].weight = weight;
    }

    void bellmanFord(int src) {
        int[] dist = new int[V];

        // Khởi tạo khoảng cách
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[src] = 0;

        // Relax all edges V-1 times
        for (int i = 1; i < V; i++) {
            for (int j = 0; j < E; j++) {
                int u = edges[j].src;
                int v = edges[j].dest;
                int weight = edges[j].weight;

                if (dist[u] != Integer.MAX_VALUE && dist[u] + weight < dist[v]) {
                    dist[v] = dist[u] + weight;
                }
            }
        }

        // Kiểm tra chu trình âm
        for (int j = 0; j < E; j++) {
            int u = edges[j].src;
            int v = edges[j].dest;
            int weight = edges[j].weight;

            if (dist[u] != Integer.MAX_VALUE && dist[u] + weight < dist[v]) {
                System.out.println("Đồ thị chứa chu trình âm");
                return;
            }
        }

        // In kết quả
        printBellmanFord(dist, src);
    }

    void printBellmanFord(int[] dist, int src) {
        System.out.println("Khoảng cách từ đỉnh " + src + " đến các đỉnh khác:");
        for (int i = 0; i < V; i++) {
            System.out.println(src + " đến " + i + " = " +
                               (dist[i] == Integer.MAX_VALUE ? "∞" : dist[i]));
        }
    }
}
```

**c. Thuật toán Floyd-Warshall:**

- Tìm đường đi ngắn nhất giữa tất cả các cặp đỉnh
- Độ phức tạp O(V³)

```java
public class FloydWarshall {
    final static int INF = 99999;
    private int V; // Số đỉnh

    void floydWarshall(int[][] graph) {
        V = graph.length;
        int[][] dist = new int[V][V];

        // Khởi tạo ma trận khoảng cách
        for (int i = 0; i < V; i++) {
            for (int j = 0; j < V; j++) {
                dist[i][j] = graph[i][j];
            }
        }

        // Cập nhật ma trận khoảng cách
        for (int k = 0; k < V; k++) {
            for (int i = 0; i < V; i++) {
                for (int j = 0; j < V; j++) {
                    if (dist[i][k] != INF && dist[k][j] != INF &&
                        dist[i][k] + dist[k][j] < dist[i][j]) {
                        dist[i][j] = dist[i][k] + dist[k][j];
                    }
                }
            }
        }

        // In kết quả
        printFloydWarshall(dist);
    }

    void printFloydWarshall(int[][] dist) {
        System.out.println("Ma trận khoảng cách ngắn nhất giữa tất cả các cặp đỉnh:");
        for (int i = 0; i < V; i++) {
            for (int j = 0; j < V; j++) {
                if (dist[i][j] == INF)
                    System.out.print("∞ ");
                else
                    System.out.print(dist[i][j] + " ");
            }
            System.out.println();
        }
    }
}
```

**So sánh các thuật toán tìm đường đi ngắn nhất:**

| Thuật toán     | Độ phức tạp | Xử lý cạnh trọng số âm | Phát hiện chu trình âm | Ứng dụng                                               |
| -------------- | ----------- | ---------------------- | ---------------------- | ------------------------------------------------------ |
| Dijkstra       | O(E log V)  | Không                  | Không                  | GPS, mạng lưới đường, định tuyến mạng                  |
| Bellman-Ford   | O(V\*E)     | Có                     | Có                     | Định tuyến mạng, forex trading                         |
| Floyd-Warshall | O(V³)       | Có                     | Có                     | Tất cả các cặp đường đi ngắn nhất, ma trận khoảng cách |

---

## 🧑‍🏫 Bài 4: Thuật toán tham lam (Greedy Algorithms)

**Khái niệm thuật toán tham lam:**

- Thuật toán tham lam là một kỹ thuật giải quyết vấn đề bằng cách luôn chọn lựa tốt nhất tại mỗi bước
- Mỗi lựa chọn tối ưu cục bộ với hy vọng đạt được lời giải tối ưu toàn cục
- Không phải lúc nào cũng cho kết quả tối ưu toàn cục

**Ứng dụng của thuật toán tham lam:**

**1. Bài toán tìm số đồng xu tối thiểu:**

- Cho một tập hợp các mệnh giá tiền, tìm số lượng đồng xu tối thiểu để tạo ra một số tiền cụ thể

```java
public static int minCoins(int[] coins, int amount) {
    // Sắp xếp mảng theo thứ tự giảm dần
    Arrays.sort(coins);
    int[] reversedCoins = new int[coins.length];
    for (int i = 0; i < coins.length; i++) {
        reversedCoins[i] = coins[coins.length - 1 - i];
    }

    int coinCount = 0;
    int remainingAmount = amount;

    for (int coin : reversedCoins) {
        // Sử dụng đồng xu có giá trị lớn nhất có thể
        int count = remainingAmount / coin;
        coinCount += count;
        remainingAmount -= count * coin;

        // Nếu đã đủ số tiền, thoát vòng lặp
        if (remainingAmount == 0) {
            break;
        }
    }

    // Nếu còn số tiền dư, không có giải pháp
    if (remainingAmount > 0) {
        return -1;
    }

    return coinCount;
}
```

**2. Bài toán lập lịch công việc:**

- Sắp xếp các công việc để tối đa hóa lợi ích

```java
class Job {
    char id;      // ID của công việc
    int deadline; // Thời hạn (thời điểm kết thúc muộn nhất)
    int profit;   // Lợi nhuận nếu hoàn thành công việc

    Job(char id, int deadline, int profit) {
        this.id = id;
        this.deadline = deadline;
        this.profit = profit;
    }
}

public static ArrayList<Character> scheduleJobs(Job[] jobs, int n) {
    // Sắp xếp công việc theo lợi nhuận giảm dần
    Arrays.sort(jobs, Comparator.comparingInt((Job job) -> job.profit).reversed());

    // Tìm deadline lớn nhất
    int maxDeadline = 0;
    for (int i = 0; i < n; i++) {
        if (jobs[i].deadline > maxDeadline) {
            maxDeadline = jobs[i].deadline;
        }
    }

    // Tạo mảng để lưu lịch công việc
    char[] result = new char[maxDeadline];
    boolean[] slot = new boolean[maxDeadline];

    // Khởi tạo tất cả các slot đều trống
    for (int i = 0; i < maxDeadline; i++) {
        slot[i] = false;
    }

    // Lập lịch từng công việc
    for (int i = 0; i < n; i++) {
        // Tìm slot trống gần nhất
        for (int j = Math.min(maxDeadline - 1, jobs[i].deadline - 1); j >= 0; j--) {
            // Nếu slot trống
            if (!slot[j]) {
                result[j] = jobs[i].id;
                slot[j] = true;
                break;
            }
        }
    }

    // Tạo danh sách công việc đã lên lịch
    ArrayList<Character> scheduledJobs = new ArrayList<>();
    for (int i = 0; i < maxDeadline; i++) {
        if (slot[i]) {
            scheduledJobs.add(result[i]);
        }
    }

    return scheduledJobs;
}
```

**3. Thuật toán Huffman Coding:**

- Nén dữ liệu không mất mát bằng cách sử dụng mã có độ dài thay đổi

```java
class HuffmanNode {
    int data;
    char c;
    HuffmanNode left;
    HuffmanNode right;
}

// So sánh các nút Huffman dựa trên tần suất
class MyComparator implements Comparator<HuffmanNode> {
    public int compare(HuffmanNode x, HuffmanNode y) {
        return x.data - y.data;
    }
}

public class HuffmanCoding {
    // In mã Huffman
    public static void printCode(HuffmanNode root, String s) {
        if (root.left == null && root.right == null && Character.isLetter(root.c)) {
            System.out.println(root.c + ": " + s);
            return;
        }

        printCode(root.left, s + "0");
        printCode(root.right, s + "1");
    }

    public static void huffmanCoding(char[] charArray, int[] charFreq, int n) {
        // Tạo một hàng đợi ưu tiên
        PriorityQueue<HuffmanNode> q = new PriorityQueue<>(n, new MyComparator());

        // Tạo nút leaf cho mỗi ký tự và thêm vào hàng đợi ưu tiên
        for (int i = 0; i < n; i++) {
            HuffmanNode hn = new HuffmanNode();
            hn.c = charArray[i];
            hn.data = charFreq[i];
            hn.left = null;
            hn.right = null;
            q.add(hn);
        }

        // Tạo cây Huffman
        HuffmanNode root = null;

        while (q.size() > 1) {
            // Lấy hai nút có tần suất thấp nhất
            HuffmanNode x = q.poll();
            HuffmanNode y = q.poll();

            // Tạo nút nội bộ mới với hai nút này làm con
            HuffmanNode hn = new HuffmanNode();
            hn.data = x.data + y.data;
            hn.c = '-';
            hn.left = x;
            hn.right = y;

            root = hn;
            q.add(hn);
        }

        // In mã Huffman
        printCode(root, "");
    }
}
```

**Đặc điểm của thuật toán tham lam:**

| Ưu điểm                                                                        | Nhược điểm                                                                                                          |
| ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------- |
| - Đơn giản và dễ cài đặt<br>- Chạy nhanh<br>- Phù hợp cho một số vấn đề tối ưu | - Không luôn cho kết quả tối ưu toàn cục<br>- Khó chứng minh tính đúng đắn<br>- Phụ thuộc vào cấu trúc của bài toán |

**Các bài toán phù hợp với thuật toán tham lam:**

- Kruskal và Prim (cây khung nhỏ nhất)
- Dijkstra (đường đi ngắn nhất)
- Huffman Coding (nén dữ liệu)
- Bài toán lập lịch công việc
- Bài toán đổi tiền với một số hệ thống tiền tệ

---

## 🧑‍🏫 Bài 5: Quy hoạch động (Dynamic Programming)

**Khái niệm quy hoạch động (DP):**

- Kỹ thuật giải quyết vấn đề bằng cách chia nhỏ thành các bài toán con, lưu trữ kết quả của các bài toán con để tránh tính toán lại
- Áp dụng cho các bài toán có cấu trúc con tối ưu (optimal substructure) và chồng chéo các bài toán con (overlapping subproblems)
- Hai cách tiếp cận chính: Top-down (đệ quy có nhớ) và Bottom-up (lặp)

**1. Bài toán Fibonacci:**

**a. Fibonacci với đệ quy thông thường:**

```java
public static int fibRecursive(int n) {
    if (n <= 1) return n;
    return fibRecursive(n - 1) + fibRecursive(n - 2);
}
```

**b. Fibonacci với quy hoạch động (memoization - top-down):**

```java
public static int fibMemoization(int n) {
    int[] memo = new int[n + 1];
    Arrays.fill(memo, -1);
    return fibMemo(n, memo);
}

private static int fibMemo(int n, int[] memo) {
    if (memo[n] != -1) {
        return memo[n];
    }
    if (n <= 1) {
        memo[n] = n;
    } else {
        memo[n] = fibMemo(n - 1, memo) + fibMemo(n - 2, memo);
    }
    return memo[n];
}
```

**c. Fibonacci với quy hoạch động (tabulation - bottom-up):**

```java
public static int fibTabulation(int n) {
    if (n <= 1) return n;

    int[] dp = new int[n + 1];
    dp[0] = 0;
    dp[1] = 1;

    for (int i = 2; i <= n; i++) {
        dp[i] = dp[i - 1] + dp[i - 2];
    }

    return dp[n];
}
```

**2. Bài toán dãy con tăng dài nhất (Longest Increasing Subsequence - LIS):**

```java
public static int longestIncreasingSubsequence(int[] nums) {
    if (nums.length == 0) return 0;

    int n = nums.length;
    int[] dp = new int[n];
    Arrays.fill(dp, 1); // Mỗi phần tử tự nó là một dãy con tăng

    for (int i = 1; i < n; i++) {
        for (int j = 0; j < i; j++) {
            if (nums[i] > nums[j]) {
                dp[i] = Math.max(dp[i], dp[j] + 1);
            }
        }
    }

    // Tìm giá trị lớn nhất trong mảng dp
    int maxLength = 0;
    for (int length : dp) {
        maxLength = Math.max(maxLength, length);
    }

    return maxLength;
}
```

**3. Bài toán balo (Knapsack Problem):**

```java
public static int knapsack(int W, int[] weights, int[] values, int n) {
    // Bảng DP[i][w] lưu giá trị tối đa khi chọn từ i món đầu với trọng lượng tối đa w
    int[][] dp = new int[n + 1][W + 1];

    // Xây dựng bảng dp[][] theo bottom-up
    for (int i = 0; i <= n; i++) {
        for (int w = 0; w <= W; w++) {
            if (i == 0 || w == 0) {
                dp[i][w] = 0;
            } else if (weights[i-1] <= w) {
                // Chọn max giữa việc lấy và không lấy vật i
                dp[i][w] = Math.max(values[i-1] + dp[i-1][w-weights[i-1]], dp[i-1][w]);
            } else {
                // Nếu không thể lấy vật i do vượt trọng lượng
                dp[i][w] = dp[i-1][w];
            }
        }
    }

    return dp[n][W];
}
```

**4. Bài toán tìm đường đi xa nhất (Longest Path in DAG):**

```java
public static int longestPath(int[][] graph, int n) {
    // dp[i] lưu độ dài đường đi dài nhất từ bất kỳ đỉnh nào đến đỉnh i
    int[] dp = new int[n];

    // Khởi tạo mảng dp
    Arrays.fill(dp, Integer.MIN_VALUE);

    // Đỉnh nguồn có độ dài đường đi là 0
    dp[0] = 0;

    // Tìm thứ tự tô pô của đồ thị
    List<Integer> topoOrder = topologicalSort(graph, n);

    // Tính độ dài đường đi dài nhất cho mỗi đỉnh
    for (int i : topoOrder) {
        if (dp[i] != Integer.MIN_VALUE) {
            for (int j = 0; j < n; j++) {
                if (graph[i][j] != 0) { // Có cạnh từ i đến j
                    dp[j] = Math.max(dp[j], dp[i] + graph[i][j]);
                }
            }
        }
    }

    // Tìm đường đi dài nhất
    int max = Integer.MIN_VALUE;
    for (int pathLength : dp) {
        max = Math.max(max, pathLength);
    }

    return max;
}

private static List<Integer> topologicalSort(int[][] graph, int n) {
    boolean[] visited = new boolean[n];
    Stack<Integer> stack = new Stack<>();

    // DFS để tạo thứ tự tô pô
    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            topologicalSortUtil(i, visited, stack, graph, n);
        }
    }

    List<Integer> order = new ArrayList<>();
    while (!stack.isEmpty()) {
        order.add(stack.pop());
    }

    return order;
}

private static void topologicalSortUtil(int v, boolean[] visited, Stack<Integer> stack, int[][] graph, int n) {
    visited[v] = true;

    for (int i = 0; i < n; i++) {
        if (graph[v][i] != 0 && !visited[i]) {
            topologicalSortUtil(i, visited, stack, graph, n);
        }
    }

    stack.push(v);
}
```

**So sánh quy hoạch động và thuật toán tham lam:**

| Tiêu chí     | Quy hoạch động                               | Thuật toán tham lam                         |
| ------------ | -------------------------------------------- | ------------------------------------------- |
| Phương pháp  | Xem xét tất cả các khả năng                  | Chọn lựa tốt nhất tại mỗi bước              |
| Tối ưu       | Luôn đảm bảo kết quả tối ưu toàn cục         | Không đảm bảo kết quả tối ưu toàn cục       |
| Phức tạp     | Thường cao hơn (thời gian và không gian)     | Thường đơn giản và nhanh hơn                |
| Bài toán con | Giải quyết và lưu trữ kết quả bài toán con   | Không quan tâm đến các bài toán con đã giải |
| Ứng dụng     | Fibonacci, Knapsack, LCS, đường đi ngắn nhất | Dijkstra, Prim, Kruskal, lập lịch công việc |

**Các bước giải quyết bài toán bằng quy hoạch động:**

1. Xác định cấu trúc con tối ưu
2. Định nghĩa đệ quy về giá trị của lời giải tối ưu
3. Tính toán giá trị của lời giải tối ưu (bottom-up hoặc top-down)
4. Xây dựng lời giải tối ưu từ thông tin đã tính toán (nếu cần)

---

## 🧑‍💻 Bài tập lớn cuối phần

### **Đề bài: Xây dựng ứng dụng tìm đường đi ngắn nhất**

Viết chương trình cho phép người dùng:

- Tạo một đồ thị có hướng có trọng số (biểu diễn một mạng lưới giao thông)
- Thêm các đỉnh (thành phố, địa điểm) và cạnh (con đường) vào đồ thị
- Tìm đường đi ngắn nhất giữa hai địa điểm bất kỳ bằng thuật toán Dijkstra
- Tìm đường đi ngắn nhất từ một địa điểm đến tất cả các địa điểm khác
- Kiểm tra xem có thể đi từ địa điểm A đến địa điểm B không
- Hiển thị kết quả dưới dạng văn bản và đồ họa (tùy chọn)

### **Kết quả chạy chương trình (Ví dụ):**

```text
ỨNG DỤNG TÌM ĐƯỜNG ĐI NGẮN NHẤT
-----------------------------------
1. Thêm địa điểm mới
2. Thêm đường đi
3. Tìm đường đi ngắn nhất giữa hai địa điểm
4. Tìm đường đi ngắn nhất từ một địa điểm đến tất cả
5. Kiểm tra khả năng đi từ địa điểm A đến B
6. Hiển thị bản đồ
0. Thoát

Chọn chức năng: 1
Nhập tên địa điểm: Hà Nội
Đã thêm địa điểm thành công!

Chọn chức năng: 1
Nhập tên địa điểm: Hải Phòng
Đã thêm địa điểm thành công!

Chọn chức năng: 1
Nhập tên địa điểm: Đà Nẵng
Đã thêm địa điểm thành công!

Chọn chức năng: 1
Nhập tên địa điểm: TP. Hồ Chí Minh
Đã thêm địa điểm thành công!

Chọn chức năng: 2
Nhập địa điểm gốc: Hà Nội
Nhập địa điểm đích: Hải Phòng
Nhập khoảng cách (km): 120
Đã thêm đường đi thành công!

Chọn chức năng: 2
Nhập địa điểm gốc: Hà Nội
Nhập địa điểm đích: Đà Nẵng
Nhập khoảng cách (km): 760
Đã thêm đường đi thành công!

Chọn chức năng: 2
Nhập địa điểm gốc: Hải Phòng
Nhập địa điểm đích: Đà Nẵng
Nhập khoảng cách (km): 830
Đã thêm đường đi thành công!

Chọn chức năng: 2
Nhập địa điểm gốc: Đà Nẵng
Nhập địa điểm đích: TP. Hồ Chí Minh
Nhập khoảng cách (km): 850
Đã thêm đường đi thành công!

Chọn chức năng: 3
Nhập địa điểm xuất phát: Hà Nội
Nhập địa điểm đích: TP. Hồ Chí Minh

Đường đi ngắn nhất từ Hà Nội đến TP. Hồ Chí Minh:
Hà Nội -> Đà Nẵng -> TP. Hồ Chí Minh
Tổng khoảng cách: 1610 km

Chọn chức năng: 4
Nhập địa điểm xuất phát: Hà Nội

Đường đi ngắn nhất từ Hà Nội đến các địa điểm khác:
- Đến Hải Phòng: 120 km (Hà Nội -> Hải Phòng)
- Đến Đà Nẵng: 760 km (Hà Nội -> Đà Nẵng)
- Đến TP. Hồ Chí Minh: 1610 km (Hà Nội -> Đà Nẵng -> TP. Hồ Chí Minh)

Chọn chức năng: 5
Nhập địa điểm xuất phát: Hải Phòng
Nhập địa điểm đích: TP. Hồ Chí Minh
Có thể đi từ Hải Phòng đến TP. Hồ Chí Minh!
Đường đi: Hải Phòng -> Đà Nẵng -> TP. Hồ Chí Minh
Khoảng cách: 1680 km

Chọn chức năng: 0
Cảm ơn bạn đã sử dụng chương trình!
```

---

[⬅️ Trở lại: DSA/Part2.md](../DSA/Part2.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: DSA/Part4.md](../DSA/Part4.md)
