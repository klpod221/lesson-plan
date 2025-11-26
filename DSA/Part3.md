---
prev:
  text: '🌐 Advanced Data Structures'
  link: '/DSA/Part2'
next:
  text: '🔍 Specialized Data Structures'
  link: '/DSA/Part4'
---

# 📘 PART 3: ADVANCED ALGORITHMS

## 🎯 General Objectives

- Deeply understand and implement advanced algorithms.
- Know how to apply algorithm design techniques to real-world problems.
- Analyze the pros and cons of each algorithm and choose the appropriate one.
- Master the approach and solution to complex problems.

## 🧑‍🏫 Lesson 1: Recursive Algorithms

### Concept of Recursion

- Recursion is a technique where a function calls itself to solve smaller instances of the same problem.
- Structure of recursion consists of two parts:
  - **Base case**: The condition to stop recursion.
  - **Recursive case**: The way to reduce the problem.

#### Example 1: Factorial Calculation

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

#### Example 2: Fibonacci Sequence

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

#### Example 3: Tower of Hanoi

```java
public static void towerOfHanoi(int n, char source, char auxiliary, char destination) {
    // Base case
    if (n == 1) {
        System.out.println("Move disk 1 from " + source + " to " + destination);
        return;
    }

    // Recursive case
    towerOfHanoi(n - 1, source, destination, auxiliary);
    System.out.println("Move disk " + n + " from " + source + " to " + destination);
    towerOfHanoi(n - 1, auxiliary, source, destination);
}
```

### Tail Recursion

- Tail recursion is when the recursive call is the last operation in the function.
- Can be optimized by the compiler to avoid stack overflow.

```java
// Factorial without tail recursion
public static int factorial(int n) {
    if (n == 0) return 1;
    return n * factorial(n - 1); // Multiplication remains after recursive call
}

// Factorial with tail recursion
public static int factorialTail(int n, int acc) {
    if (n == 0) return acc;
    return factorialTail(n - 1, n * acc); // Recursive call is the last operation
}

// Wrapper function
public static int factorial(int n) {
    return factorialTail(n, 1);
}
```

### Pros and Cons of Recursion

| Pros | Cons |
|---------|------------|
| Concise code, easy to understand | High stack storage cost |
| Natural for some problems | Can cause stack overflow with large inputs |
| Easy to implement some algorithms (e.g., DFS) | Often slower than iterative solutions |

## 🧑‍🏫 Lesson 2: Advanced Sorting Algorithms

### Quick Sort

- Divide and conquer algorithm, using pivot strategy.
- Average complexity: O(n log n)
- Worst case complexity: O(n²)

```java
public static void quickSort(int[] arr, int low, int high) {
    if (low < high) {
        int pivotIndex = partition(arr, low, high);

        // Sort elements before and after pivot
        quickSort(arr, low, pivotIndex - 1);
        quickSort(arr, pivotIndex + 1, high);
    }
}

private static int partition(int[] arr, int low, int high) {
    int pivot = arr[high]; // Choose pivot as the last element
    int i = low - 1; // Index of smaller element

    for (int j = low; j < high; j++) {
        // If current element is smaller than or equal to pivot
        if (arr[j] <= pivot) {
            i++;
            // Swap arr[i] and arr[j]
            int temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
        }
    }

    // Swap arr[i+1] and arr[high] (place pivot in correct position)
    int temp = arr[i + 1];
    arr[i + 1] = arr[high];
    arr[high] = temp;

    return i + 1; // Return pivot position
}
```

### Merge Sort

- Divide and conquer algorithm, divides array in half and merges them.
- Complexity: O(n log n) in all cases.
- Stable sort (preserves order of equal elements).

```java
public static void mergeSort(int[] arr, int left, int right) {
    if (left < right) {
        // Find middle point
        int mid = left + (right - left) / 2;

        // Sort first half
        mergeSort(arr, left, mid);
        // Sort second half
        mergeSort(arr, mid + 1, right);

        // Merge the sorted halves
        merge(arr, left, mid, right);
    }
}

private static void merge(int[] arr, int left, int mid, int right) {
    // Sizes of two subarrays
    int n1 = mid - left + 1;
    int n2 = right - mid;

    // Create temp arrays
    int[] L = new int[n1];
    int[] R = new int[n2];

    // Copy data to temp arrays
    for (int i = 0; i < n1; i++)
        L[i] = arr[left + i];
    for (int j = 0; j < n2; j++)
        R[j] = arr[mid + 1 + j];

    // Merge the temp arrays
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

    // Copy remaining elements of L[] if any
    while (i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }

    // Copy remaining elements of R[] if any
    while (j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }
}
```

### Heap Sort

- Uses heap data structure.
- Complexity: O(n log n) in all cases.
- In-place sorting (no extra memory needed).

```java
public static void heapSort(int[] arr) {
    int n = arr.length;

    // Build max heap
    for (int i = n / 2 - 1; i >= 0; i--)
        heapify(arr, n, i);

    // Extract elements from heap one by one
    for (int i = n - 1; i > 0; i--) {
        // Move root (largest) to end
        int temp = arr[0];
        arr[0] = arr[i];
        arr[i] = temp;

        // Call heapify on reduced heap
        heapify(arr, i, 0);
    }
}

// Heapify a subtree rooted at node i
private static void heapify(int[] arr, int n, int i) {
    int largest = i; // Initialize largest as root
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    // If left child is larger than root
    if (left < n && arr[left] > arr[largest])
        largest = left;

    // If right child is larger than largest so far
    if (right < n && arr[right] > arr[largest])
        largest = right;

    // If largest is not root
    if (largest != i) {
        int swap = arr[i];
        arr[i] = arr[largest];
        arr[largest] = swap;

        // Recursively heapify the affected sub-tree
        heapify(arr, n, largest);
    }
}
```

### Comparison of Advanced Sorting Algorithms

| Algorithm | Average Time | Worst Time | Memory | Stable | Note |
| ---------- | -------------------- | ------------------ | -------- | ------- | --------------------------------------------------- |
| Quick Sort | O(n log n) | O(n²) | O(log n) | No | Fastest in practice with random data |
| Merge Sort | O(n log n) | O(n log n) | O(n) | Yes | Efficient for linked lists, guarantees O(n log n) |
| Heap Sort | O(n log n) | O(n log n) | O(1) | No | No auxiliary memory needed, less used in practice |

## 🧑‍🏫 Lesson 3: Graph Algorithms

### Graph Representation

#### Adjacency Matrix

- 2D array where A\[i\]\[j\] = 1 if there is an edge from i to j, otherwise A\[i\]\[j\] = 0.
- Suitable for dense graphs.

```java
public class AdjacencyMatrix {
    private int V; // Number of vertices
    private int[][] matrix;

    public AdjacencyMatrix(int v) {
        V = v;
        matrix = new int[v][v];
    }

    // Add edge for undirected graph
    public void addEdge(int source, int destination) {
        matrix[source][destination] = 1;
        matrix[destination][source] = 1; // Remove this line if directed graph
    }

    // Print graph
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

#### Adjacency List

- Array of lists, each element containing adjacent vertices.
- Suitable for sparse graphs.

```java
public class AdjacencyList {
    private int V; // Number of vertices
    private LinkedList<Integer>[] adjList;

    @SuppressWarnings("unchecked")
    public AdjacencyList(int v) {
        V = v;
        adjList = new LinkedList[v];
        for (int i = 0; i < v; i++) {
            adjList[i] = new LinkedList<>();
        }
    }

    // Add edge for undirected graph
    public void addEdge(int source, int destination) {
        adjList[source].add(destination);
        adjList[destination].add(source); // Remove this line if directed graph
    }

    // Print graph
    public void printGraph() {
        for (int i = 0; i < V; i++) {
            System.out.print("Vertex " + i + " is connected to: ");
            for (Integer vertex : adjList[i]) {
                System.out.print(vertex + " ");
            }
            System.out.println();
        }
    }
}
```

### Graph Traversal

#### Depth-First Search (DFS)

- Uses Stack (implicitly via recursion) to traverse.
- Prioritizes going deep before backtracking.

```java
public class GraphDFS {
    private int V; // Number of vertices
    private LinkedList<Integer>[] adjList;

    @SuppressWarnings("unchecked")
    public GraphDFS(int v) {
        V = v;
        adjList = new LinkedList[v];
        for (int i = 0; i < v; i++) {
            adjList[i] = new LinkedList<>();
        }
    }

    // Add edge
    public void addEdge(int source, int destination) {
        adjList[source].add(destination);
    }

    // DFS from a source vertex
    public void DFS(int startVertex) {
        // Mark all vertices as not visited
        boolean[] visited = new boolean[V];

        // Call recursive DFS function
        DFSUtil(startVertex, visited);
    }

    // Recursive function for DFS
    private void DFSUtil(int vertex, boolean[] visited) {
        // Mark current vertex as visited and print it
        visited[vertex] = true;
        System.out.print(vertex + " ");

        // Recur for all the vertices adjacent to this vertex
        for (Integer neighbor : adjList[vertex]) {
            if (!visited[neighbor]) {
                DFSUtil(neighbor, visited);
            }
        }
    }
}
```

#### Breadth-First Search (BFS)

- Uses Queue to traverse.
- Prioritizes visiting all adjacent vertices before going deeper.

```java
public class GraphBFS {
    private int V; // Number of vertices
    private LinkedList<Integer>[] adjList;

    @SuppressWarnings("unchecked")
    public GraphBFS(int v) {
        V = v;
        adjList = new LinkedList[v];
        for (int i = 0; i < v; i++) {
            adjList[i] = new LinkedList<>();
        }
    }

    // Add edge
    public void addEdge(int source, int destination) {
        adjList[source].add(destination);
    }

    // BFS from a source vertex
    public void BFS(int startVertex) {
        // Mark all vertices as not visited
        boolean[] visited = new boolean[V];

        // Create a queue for BFS
        LinkedList<Integer> queue = new LinkedList<>();

        // Mark the current node as visited and enqueue it
        visited[startVertex] = true;
        queue.add(startVertex);

        while (!queue.isEmpty()) {
            // Dequeue a vertex from queue and print it
            startVertex = queue.poll();
            System.out.print(startVertex + " ");

            // Get all adjacent vertices of the dequeued vertex
            // If a adjacent has not been visited, then mark it visited and enqueue it
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

### Shortest Path Algorithms

#### Dijkstra's Algorithm

- Finds shortest path from a source vertex to all other vertices.
- Uses priority queue to select vertex with smallest distance.

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

            // Initialize distances with infinity
            Arrays.fill(distance, Integer.MAX_VALUE);
            distance[sourceVertex] = 0;

            // Priority Queue to select vertex with smallest distance
            PriorityQueue<Edge> pq = new PriorityQueue<>(
                (e1, e2) -> Integer.compare(e1.weight, e2.weight)
            );

            pq.add(new Edge(sourceVertex, 0));

            while (!pq.isEmpty()) {
                // Select vertex with smallest distance
                Edge current = pq.poll();
                int u = current.destination;

                // If vertex already visited, skip
                if (visited[u])
                    continue;

                visited[u] = true;

                // Update distance for adjacent vertices
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

            // Print result
            printDijkstra(distance, sourceVertex);
        }

        void printDijkstra(int[] distance, int sourceVertex) {
            System.out.println("Distance from vertex " + sourceVertex + " to other vertices:");
            for (int i = 0; i < vertices; i++) {
                System.out.println(sourceVertex + " to " + i + " = " +
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

#### Bellman-Ford Algorithm

- Finds shortest path from a source vertex to all other vertices.
- Handles negative weight edges.
- Detects negative cycles.

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

        // Initialize distances
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

        // Check for negative weight cycles
        for (int j = 0; j < E; j++) {
            int u = edges[j].src;
            int v = edges[j].dest;
            int weight = edges[j].weight;

            if (dist[u] != Integer.MAX_VALUE && dist[u] + weight < dist[v]) {
                System.out.println("Graph contains negative weight cycle");
                return;
            }
        }

        // Print result
        printBellmanFord(dist, src);
    }

    void printBellmanFord(int[] dist, int src) {
        System.out.println("Distance from vertex " + src + " to other vertices:");
        for (int i = 0; i < V; i++) {
            System.out.println(src + " to " + i + " = " +
                               (dist[i] == Integer.MAX_VALUE ? "∞" : dist[i]));
        }
    }
}
```

#### Floyd-Warshall Algorithm

- Finds shortest paths between all pairs of vertices.
- Complexity O(V³).

```java
public class FloydWarshall {
    final static int INF = 99999;
    private int V; // Number of vertices

    void floydWarshall(int[][] graph) {
        V = graph.length;
        int[][] dist = new int[V][V];

        // Initialize distance matrix
        for (int i = 0; i < V; i++) {
            for (int j = 0; j < V; j++) {
                dist[i][j] = graph[i][j];
            }
        }

        // Update distance matrix
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

        // Print result
        printFloydWarshall(dist);
    }

    void printFloydWarshall(int[][] dist) {
        System.out.println("Shortest distance matrix between all pairs of vertices:");
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

### Comparison of Shortest Path Algorithms

| Algorithm | Complexity | Handles Negative Weights | Detects Negative Cycles | Application |
| -------------- | ----------- | ---------------------- | ---------------------- | ------------------------------------------------------ |
| Dijkstra | O(E log V) | No | No | GPS, road networks, network routing |
| Bellman-Ford | O(V\*E) | Yes | Yes | Network routing, forex trading |
| Floyd-Warshall | O(V³) | Yes | Yes | All-pairs shortest paths, distance matrix |

## 🧑‍🏫 Lesson 4: Greedy Algorithms

### Concept of Greedy Algorithm

- Greedy algorithm is a technique to solve problems by always making the best choice at each step.
- Each choice is locally optimal with the hope of achieving a globally optimal solution.
- Does not always yield a globally optimal result.

### Applications of Greedy Algorithms

#### Coin Change Problem (Minimum Coins)

- Given a set of coin denominations, find the minimum number of coins to make a specific amount.

```java
public static int minCoins(int[] coins, int amount) {
    // Sort array in descending order
    Arrays.sort(coins);
    int[] reversedCoins = new int[coins.length];
    for (int i = 0; i < coins.length; i++) {
        reversedCoins[i] = coins[coins.length - 1 - i];
    }

    int coinCount = 0;
    int remainingAmount = amount;

    for (int coin : reversedCoins) {
        // Use largest possible coin value
        int count = remainingAmount / coin;
        coinCount += count;
        remainingAmount -= count * coin;

        // If amount is reached, break loop
        if (remainingAmount == 0) {
            break;
        }
    }

    // If remaining amount > 0, no solution
    if (remainingAmount > 0) {
        return -1;
    }

    return coinCount;
}
```

#### Job Sequencing Problem

- Schedule jobs to maximize profit.

```java
class Job {
    char id;      // Job ID
    int deadline; // Deadline
    int profit;   // Profit if job is completed

    Job(char id, int deadline, int profit) {
        this.id = id;
        this.deadline = deadline;
        this.profit = profit;
    }
}

public static ArrayList<Character> scheduleJobs(Job[] jobs, int n) {
    // Sort jobs by profit in descending order
    Arrays.sort(jobs, Comparator.comparingInt((Job job) -> job.profit).reversed());

    // Find max deadline
    int maxDeadline = 0;
    for (int i = 0; i < n; i++) {
        if (jobs[i].deadline > maxDeadline) {
            maxDeadline = jobs[i].deadline;
        }
    }

    // Create array to store job schedule
    char[] result = new char[maxDeadline];
    boolean[] slot = new boolean[maxDeadline];

    // Initialize all slots as free
    for (int i = 0; i < maxDeadline; i++) {
        slot[i] = false;
    }

    // Schedule each job
    for (int i = 0; i < n; i++) {
        // Find nearest free slot
        for (int j = Math.min(maxDeadline - 1, jobs[i].deadline - 1); j >= 0; j--) {
            // If slot is free
            if (!slot[j]) {
                result[j] = jobs[i].id;
                slot[j] = true;
                break;
            }
        }
    }

    // Create list of scheduled jobs
    ArrayList<Character> scheduledJobs = new ArrayList<>();
    for (int i = 0; i < maxDeadline; i++) {
        if (slot[i]) {
            scheduledJobs.add(result[i]);
        }
    }

    return scheduledJobs;
}
```

### Huffman Coding Algorithm

- Lossless data compression using variable-length codes.

```java
class HuffmanNode {
    int data;
    char c;
    HuffmanNode left;
    HuffmanNode right;
}

// Compare Huffman nodes based on frequency
class MyComparator implements Comparator<HuffmanNode> {
    public int compare(HuffmanNode x, HuffmanNode y) {
        return x.data - y.data;
    }
}

public class HuffmanCoding {
    // Print Huffman code
    public static void printCode(HuffmanNode root, String s) {
        if (root.left == null && root.right == null && Character.isLetter(root.c)) {
            System.out.println(root.c + ": " + s);
            return;
        }

        printCode(root.left, s + "0");
        printCode(root.right, s + "1");
    }

    public static void huffmanCoding(char[] charArray, int[] charFreq, int n) {
        // Create a priority queue
        PriorityQueue<HuffmanNode> q = new PriorityQueue<>(n, new MyComparator());

        // Create leaf node for each character and add to priority queue
        for (int i = 0; i < n; i++) {
            HuffmanNode hn = new HuffmanNode();
            hn.c = charArray[i];
            hn.data = charFreq[i];
            hn.left = null;
            hn.right = null;
            q.add(hn);
        }

        // Create Huffman tree
        HuffmanNode root = null;

        while (q.size() > 1) {
            // Extract two nodes with lowest frequency
            HuffmanNode x = q.poll();
            HuffmanNode y = q.poll();

            // Create new internal node with these two nodes as children
            HuffmanNode hn = new HuffmanNode();
            hn.data = x.data + y.data;
            hn.c = '-';
            hn.left = x;
            hn.right = y;

            root = hn;
            q.add(hn);
        }

        // Print Huffman code
        printCode(root, "");
    }
}
```

### Characteristics of Greedy Algorithms

| Pros | Cons |
|---------|------------|
| - Simple and easy to implement | - Not always globally optimal |
| - Fast execution | - Hard to prove correctness |
| - Suitable for some optimization problems | - Depends on problem structure |

**Problems suitable for Greedy Algorithms:**

- Kruskal and Prim (Minimum Spanning Tree)
- Dijkstra (Shortest Path)
- Huffman Coding (Data Compression)
- Job Sequencing Problem
- Coin Change Problem (with certain currency systems)

## 🧑‍🏫 Lesson 5: Dynamic Programming

### Concept of Dynamic Programming (DP)

- Technique to solve problems by breaking them down into subproblems, storing results of subproblems to avoid re-computation.
- Applies to problems with optimal substructure and overlapping subproblems.
- Two main approaches: Top-down (Memoization) and Bottom-up (Tabulation).

### Fibonacci Problem

#### Fibonacci with Regular Recursion

```java
public static int fibRecursive(int n) {
    if (n <= 1) return n;
    return fibRecursive(n - 1) + fibRecursive(n - 2);
}
```

#### Fibonacci with Dynamic Programming (Memoization - Top-down)

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

#### Fibonacci with Dynamic Programming (Tabulation - Bottom-up)

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

### Longest Increasing Subsequence (LIS)

```java
public static int longestIncreasingSubsequence(int[] nums) {
    if (nums.length == 0) return 0;

    int n = nums.length;
    int[] dp = new int[n];
    Arrays.fill(dp, 1); // Each element itself is an increasing subsequence

    for (int i = 1; i < n; i++) {
        for (int j = 0; j < i; j++) {
            if (nums[i] > nums[j]) {
                dp[i] = Math.max(dp[i], dp[j] + 1);
            }
        }
    }

    // Find max value in dp array
    int maxLength = 0;
    for (int length : dp) {
        maxLength = Math.max(maxLength, length);
    }

    return maxLength;
}
```

### Knapsack Problem

```java
public static int knapsack(int W, int[] weights, int[] values, int n) {
    // DP[i][w] stores max value when choosing from first i items with max weight w
    int[][] dp = new int[n + 1][W + 1];

    // Build dp[][] table bottom-up
    for (int i = 0; i <= n; i++) {
        for (int w = 0; w <= W; w++) {
            if (i == 0 || w == 0) {
                dp[i][w] = 0;
            } else if (weights[i-1] <= w) {
                // Choose max between taking and not taking item i
                dp[i][w] = Math.max(values[i-1] + dp[i-1][w-weights[i-1]], dp[i-1][w]);
            } else {
                // If cannot take item i due to weight limit
                dp[i][w] = dp[i-1][w];
            }
        }
    }

    return dp[n][W];
}
```

### Longest Path in DAG

```java
public static int longestPath(int[][] graph, int n) {
    // dp[i] stores length of longest path from any vertex to vertex i
    int[] dp = new int[n];

    // Initialize dp array
    Arrays.fill(dp, Integer.MIN_VALUE);

    // Source vertex has path length 0
    dp[0] = 0;

    // Find topological order of graph
    List<Integer> topoOrder = topologicalSort(graph, n);

    // Calculate longest path length for each vertex
    for (int i : topoOrder) {
        if (dp[i] != Integer.MIN_VALUE) {
            for (int j = 0; j < n; j++) {
                if (graph[i][j] != 0) { // Edge from i to j
                    dp[j] = Math.max(dp[j], dp[i] + graph[i][j]);
                }
            }
        }
    }

    // Find longest path
    int max = Integer.MIN_VALUE;
    for (int pathLength : dp) {
        max = Math.max(max, pathLength);
    }

    return max;
}

private static List<Integer> topologicalSort(int[][] graph, int n) {
    boolean[] visited = new boolean[n];
    Stack<Integer> stack = new Stack<>();

    // DFS to create topological order
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

### Comparison of Dynamic Programming and Greedy Algorithms

| Criteria | Dynamic Programming | Greedy Algorithm |
| ------------ | -------------------------------------------- | ------------------------------------------- |
| Method | Consider all possibilities | Choose best at each step |
| Optimality | Always guarantees global optimum | Does not guarantee global optimum |
| Complexity | Often higher (time and space) | Often simpler and faster |
| Subproblems | Solve and store subproblem results | Does not care about solved subproblems |
| Applications | Fibonacci, Knapsack, LCS, Shortest Path | Dijkstra, Prim, Kruskal, Job Scheduling |

### Steps to Solve Problems using Dynamic Programming

1. Identify optimal substructure.
2. Define recursive value of optimal solution.
3. Compute value of optimal solution (bottom-up or top-down).
4. Construct optimal solution from computed information (if needed).

## 🧑‍💻 Final Project: Shortest Path Finder Application

### Problem Description

Write a program that allows users to:

- Create a directed weighted graph (representing a traffic network).
- Add vertices (cities, locations) and edges (roads) to the graph.
- Find shortest path between any two locations using Dijkstra's algorithm.
- Find shortest path from one location to all others.
- Check if it is possible to go from location A to location B.
- Display results in text and graphics (optional).

### Program Output (Example)

```text
SHORTEST PATH FINDER APPLICATION
-----------------------------------
1. Add new location
2. Add road
3. Find shortest path between two locations
4. Find shortest path from one location to all
5. Check reachability from A to B
6. Display map
0. Exit

Select function: 1
Enter location name: Hanoi
Location added successfully!

Select function: 1
Enter location name: Haiphong
Location added successfully!

Select function: 1
Enter location name: Danang
Location added successfully!

Select function: 1
Enter location name: Ho Chi Minh City
Location added successfully!

Select function: 2
Enter source location: Hanoi
Enter destination location: Haiphong
Enter distance (km): 120
Road added successfully!

Select function: 2
Enter source location: Hanoi
Enter destination location: Danang
Enter distance (km): 760
Road added successfully!

Select function: 2
Enter source location: Haiphong
Enter destination location: Danang
Enter distance (km): 830
Road added successfully!

Select function: 2
Enter source location: Danang
Enter destination location: Ho Chi Minh City
Enter distance (km): 850
Road added successfully!

Select function: 3
Enter start location: Hanoi
Enter end location: Ho Chi Minh City

Shortest path from Hanoi to Ho Chi Minh City:
Hanoi -> Danang -> Ho Chi Minh City
Total distance: 1610 km

Select function: 4
Enter start location: Hanoi

Shortest path from Hanoi to other locations:
- To Haiphong: 120 km (Hanoi -> Haiphong)
- To Danang: 760 km (Hanoi -> Danang)
- To Ho Chi Minh City: 1610 km (Hanoi -> Danang -> Ho Chi Minh City)

Select function: 5
Enter start location: Haiphong
Enter end location: Ho Chi Minh City
Possible to go from Haiphong to Ho Chi Minh City!
Path: Haiphong -> Danang -> Ho Chi Minh City
Distance: 1680 km

Select function: 0
Thank you for using the program!
```
