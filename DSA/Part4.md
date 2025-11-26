---
prev:
  text: '🧠 Advanced Algorithms'
  link: '/DSA/Part3'
next:
  text: '⚡ Applied Algorithms'
  link: '/DSA/Part5'
---

# 📘 PART 4: SPECIALIZED DATA STRUCTURES

## 🎯 General Objectives

- Understand and implement advanced data structures such as Balanced Trees, B/B+ Trees, Heaps, Tries, Segment Trees.
- Analyze the pros and cons of each structure and know how to choose the appropriate one for a problem.
- Apply specialized data structures to real-world problems.
- Optimize solutions using specific data structures.

## 🧑‍🏫 Lesson 1: Balanced Trees (AVL, Red-Black Trees)

### AVL Tree

AVL Tree is a self-balancing binary search tree, ensuring that the height difference between the left and right subtrees is no more than 1 unit.

#### Properties of AVL Tree

- Each node has a balance factor = height of left subtree - height of right subtree.
- The balance factor of each node must be -1, 0, or +1.
- Search, insert, and delete operations all have O(log n) complexity.

#### Rebalancing Operations

1. **Right Rotation:**

   ```java
   private Node rightRotate(Node y) {
       Node x = y.left;
       Node T2 = x.right;

       // Perform rotation
       x.right = y;
       y.left = T2;

       // Update heights
       y.height = Math.max(height(y.left), height(y.right)) + 1;
       x.height = Math.max(height(x.left), height(x.right)) + 1;

       return x;
   }
   ```

2. **Left Rotation:**

   ```java
   private Node leftRotate(Node x) {
       Node y = x.right;
       Node T2 = y.left;

       // Perform rotation
       y.left = x;
       x.right = T2;

       // Update heights
       x.height = Math.max(height(x.left), height(x.right)) + 1;
       y.height = Math.max(height(y.left), height(y.right)) + 1;

       return y;
   }
   ```

#### Full AVL Tree Implementation

```java
public class AVLTree {
    private class Node {
        int key, height;
        Node left, right;

        Node(int key) {
            this.key = key;
            this.height = 1; // New leaf node has height 1
        }
    }

    private Node root;

    // Get height of node
    private int height(Node node) {
        if (node == null)
            return 0;
        return node.height;
    }

    // Get balance factor of node
    private int getBalance(Node node) {
        if (node == null)
            return 0;
        return height(node.left) - height(node.right);
    }

    // Insert a new key into the tree
    public void insert(int key) {
        root = insert(root, key);
    }

    private Node insert(Node node, int key) {
        // 1. Perform normal BST insertion
        if (node == null)
            return new Node(key);

        if (key < node.key)
            node.left = insert(node.left, key);
        else if (key > node.key)
            node.right = insert(node.right, key);
        else // Duplicate keys not allowed
            return node;

        // 2. Update height of this ancestor node
        node.height = 1 + Math.max(height(node.left), height(node.right));

        // 3. Get the balance factor to check whether this node became unbalanced
        int balance = getBalance(node);

        // 4. If unbalanced, then there are 4 cases

        // Left Left Case
        if (balance > 1 && key < node.left.key)
            return rightRotate(node);

        // Right Right Case
        if (balance < -1 && key > node.right.key)
            return leftRotate(node);

        // Left Right Case
        if (balance > 1 && key > node.left.key) {
            node.left = leftRotate(node.left);
            return rightRotate(node);
        }

        // Right Left Case
        if (balance < -1 && key < node.right.key) {
            node.right = rightRotate(node.right);
            return leftRotate(node);
        }

        return node;
    }

    // Delete a key from the tree
    public void delete(int key) {
        root = delete(root, key);
    }

    private Node delete(Node root, int key) {
        // 1. Perform standard BST delete
        if (root == null)
            return root;

        if (key < root.key)
            root.left = delete(root.left, key);
        else if (key > root.key)
            root.right = delete(root.right, key);
        else {
            // Node with only one child or no child
            if (root.left == null || root.right == null) {
                Node temp = (root.left != null) ? root.left : root.right;

                // No child case
                if (temp == null) {
                    temp = root;
                    root = null;
                }
                // One child case
                else {
                    root = temp;
                }
            }
            // Node with two children
            else {
                // Get the inorder successor (smallest in the right subtree)
                Node temp = minValueNode(root.right);

                // Copy the inorder successor's content to this node
                root.key = temp.key;

                // Delete the inorder successor
                root.right = delete(root.right, temp.key);
            }
        }

        // If the tree had only one node then return
        if (root == null)
            return root;

        // 2. Update height of the current node
        root.height = 1 + Math.max(height(root.left), height(root.right));

        // 3. Get the balance factor
        int balance = getBalance(root);

        // 4. If unbalanced, then there are 4 cases

        // Left Left Case
        if (balance > 1 && getBalance(root.left) >= 0)
            return rightRotate(root);

        // Left Right Case
        if (balance > 1 && getBalance(root.left) < 0) {
            root.left = leftRotate(root.left);
            return rightRotate(root);
        }

        // Right Right Case
        if (balance < -1 && getBalance(root.right) <= 0)
            return leftRotate(root);

        // Right Left Case
        if (balance < -1 && getBalance(root.right) > 0) {
            root.right = rightRotate(root.right);
            return leftRotate(root);
        }

        return root;
    }

    private Node minValueNode(Node node) {
        Node current = node;

        // Find the leftmost leaf
        while (current.left != null)
            current = current.left;

        return current;
    }

    // Inorder traversal
    public void inorder() {
        inorder(root);
        System.out.println();
    }

    private void inorder(Node node) {
        if (node != null) {
            inorder(node.left);
            System.out.print(node.key + " ");
            inorder(node.right);
        }
    }
}
```

### Red-Black Tree

Red-Black Tree is a type of self-balancing binary search tree with special properties to ensure balance.

#### Properties of Red-Black Tree

1. Each node is either red or black.
2. The root is always black.
3. All leaves (NULL) are black.
4. If a node is red, then both its children are black (no two consecutive red nodes).
5. Every path from a node to any of its descendant NULL nodes contains the same number of black nodes.

#### Red-Black Tree Implementation

```java
public class RedBlackTree {
    private static final boolean RED = true;
    private static final boolean BLACK = false;

    private class Node {
        int key;
        Node left, right;
        boolean color; // true is RED, false is BLACK

        Node(int key) {
            this.key = key;
            this.color = RED; // New node is always RED
        }
    }

    private Node root;

    // Check color of node
    private boolean isRed(Node node) {
        if (node == null)
            return false; // NULL nodes are BLACK
        return node.color == RED;
    }

    // Rotate left
    private Node rotateLeft(Node h) {
        Node x = h.right;
        h.right = x.left;
        x.left = h;
        x.color = h.color;
        h.color = RED;
        return x;
    }

    // Rotate right
    private Node rotateRight(Node h) {
        Node x = h.left;
        h.left = x.right;
        x.right = h;
        x.color = h.color;
        h.color = RED;
        return x;
    }

    // Flip colors of node and its two children
    private void flipColors(Node h) {
        h.color = !h.color;
        h.left.color = !h.left.color;
        h.right.color = !h.right.color;
    }

    // Insert a key into the tree
    public void insert(int key) {
        root = insert(root, key);
        root.color = BLACK; // Ensure root is always black
    }

    private Node insert(Node h, int key) {
        if (h == null)
            return new Node(key);

        if (key < h.key)
            h.left = insert(h.left, key);
        else if (key > h.key)
            h.right = insert(h.right, key);
        else
            h.key = key; // Update if key exists

        // Balance the tree

        // If right child is red and left child is black: rotate left
        if (isRed(h.right) && !isRed(h.left))
            h = rotateLeft(h);

        // If left child is red and its left child is also red: rotate right
        if (isRed(h.left) && isRed(h.left.left))
            h = rotateRight(h);

        // If both left and right children are red: flip colors
        if (isRed(h.left) && isRed(h.right))
            flipColors(h);

        return h;
    }

    // Inorder traversal
    public void inorder() {
        inorder(root);
        System.out.println();
    }

    private void inorder(Node node) {
        if (node != null) {
            inorder(node.left);
            System.out.print(node.key + "(" + (node.color ? "R" : "B") + ") ");
            inorder(node.right);
        }
    }
}
```

### Comparison of AVL and Red-Black Trees

| Criteria | AVL Tree | Red-Black Tree |
| ------------- | -------------------------------------- | --------------------- |
| Balance | Strict (balance factor <= 1) | Less strict |
| Height | ~ 1.44 log(n) | ~ 2 log(n) |
| Insertion | Max 2 rotations | Max 2 rotations |
| Deletion | Max log(n) rotations | Max 3 rotations |
| Memory | 1 bit balance factor/height per node | 1 bit color per node |
| Search | Faster due to better balance | Slightly slower |
| Application | Frequent lookups | Frequent insertions/deletions |

## 🧑‍🏫 Lesson 2: B-Trees and B+ Trees

### B-Tree

B-Tree is a self-balancing tree structure where each node can contain multiple keys and have multiple children. B-Trees are commonly used in file systems and databases.

#### Properties of B-Tree of Order M

1. Every node except the root contains between ⌈M/2⌉-1 and M-1 keys.
2. The root contains between 1 and M-1 keys.
3. A node with k keys will have k+1 children.
4. All leaf nodes are at the same level.

#### Node Structure in B-Tree

```java
class BTreeNode {
    int[] keys;        // Array of keys
    int t;             // Minimum degree (minimum keys is t-1)
    BTreeNode[] children; // Array of children
    int n;             // Current number of keys
    boolean leaf;      // true if leaf node

    public BTreeNode(int t, boolean leaf) {
        this.t = t;
        this.leaf = leaf;
        this.keys = new int[2*t - 1]; // Each node can contain max 2t-1 keys
        this.children = new BTreeNode[2*t]; // Each node has max 2t children
        this.n = 0; // Initialize with 0 keys
    }
}
```

#### B-Tree Implementation

```java
public class BTree {
    private BTreeNode root;
    private int t; // Minimum degree

    public BTree(int t) {
        this.root = null;
        this.t = t;
    }

    // Search for a key in the tree
    public BTreeNode search(int key) {
        if (root == null)
            return null;
        return search(root, key);
    }

    private BTreeNode search(BTreeNode node, int key) {
        // Find position of key in current node
        int i = 0;
        while (i < node.n && key > node.keys[i])
            i++;

        // If key found
        if (i < node.n && key == node.keys[i])
            return node;

        // If leaf node and not found
        if (node.leaf)
            return null;

        // Continue searching in child node
        return search(node.children[i], key);
    }

    // Insert a key into the tree
    public void insert(int key) {
        // If tree is empty
        if (root == null) {
            root = new BTreeNode(t, true);
            root.keys[0] = key;
            root.n = 1;
        } else {
            // If root is full, tree height increases
            if (root.n == 2*t - 1) {
                BTreeNode s = new BTreeNode(t, false);
                s.children[0] = root;
                // Split old root and move one key up
                splitChild(s, 0);
                // New root has 2 children, decide which one will hold new key
                int i = 0;
                if (s.keys[0] < key)
                    i++;
                insertNonFull(s.children[i], key);

                // Change root
                root = s;
            } else {
                insertNonFull(root, key);
            }
        }
    }

    // Insert key into non-full node
    private void insertNonFull(BTreeNode node, int key) {
        // Initialize index of rightmost key
        int i = node.n - 1;

        // If leaf node
        if (node.leaf) {
            // Find location of new key and move greater keys
            while (i >= 0 && key < node.keys[i]) {
                node.keys[i+1] = node.keys[i];
                i--;
            }

            // Insert new key
            node.keys[i+1] = key;
            node.n++;
        } else { // If not leaf node
            // Find child which is going to have the new key
            while (i >= 0 && key < node.keys[i])
                i--;

            i++;
            // If child is full, split it
            if (node.children[i].n == 2*t - 1) {
                splitChild(node, i);

                // After split, the middle key of child goes up and child is split into two
                if (key > node.keys[i])
                    i++;
            }
            insertNonFull(node.children[i], key);
        }
    }

    // Split child i of node
    private void splitChild(BTreeNode node, int i) {
        BTreeNode y = node.children[i]; // Child to split
        BTreeNode z = new BTreeNode(t, y.leaf); // New node

        z.n = t - 1;

        // Copy last t-1 keys of y to z
        for (int j = 0; j < t-1; j++)
            z.keys[j] = y.keys[j+t];

        // Copy corresponding children if not leaf
        if (!y.leaf) {
            for (int j = 0; j < t; j++)
                z.children[j] = y.children[j+t];
        }

        // Reduce number of keys in y
        y.n = t - 1;

        // Shift children of node to accommodate z
        for (int j = node.n; j > i; j--)
            node.children[j+1] = node.children[j];

        // Link new child
        node.children[i+1] = z;

        // Shift keys of node to insert key from y
        for (int j = node.n-1; j >= i; j--)
            node.keys[j+1] = node.keys[j];

        // Copy middle key from y to node
        node.keys[i] = y.keys[t-1];

        // Increment count of keys in node
        node.n++;
    }

    // Traverse tree
    public void traverse() {
        if (root != null)
            traverse(root);
        System.out.println();
    }

    private void traverse(BTreeNode node) {
        int i;
        for (i = 0; i < node.n; i++) {
            // Traverse subtree before key i
            if (!node.leaf)
                traverse(node.children[i]);
            System.out.print(node.keys[i] + " ");
        }

        // Traverse last subtree
        if (!node.leaf)
            traverse(node.children[i]);
    }
}
```

### B+ Tree

B+ Tree is a variation of B-Tree, but with some important differences:

1. All keys are stored in leaf nodes, which are linked to form a linked list.
2. Keys in internal nodes are only copies of keys in leaf nodes.
3. Leaf nodes contain all keys and pointers to actual data.

#### Node Structure in B+ Tree

```java
class BPlusTreeNode {
    boolean isLeaf; // true if leaf node
    int[] keys; // Array of keys
    int t; // Minimum degree
    BPlusTreeNode[] children; // Array of children (internal nodes)
    BPlusTreeNode next; // Pointer to next leaf node (only for leaf nodes)
    int n; // Current number of keys

    public BPlusTreeNode(int t, boolean isLeaf) {
        this.t = t;
        this.isLeaf = isLeaf;
        this.keys = new int[2*t - 1];
        this.children = new BPlusTreeNode[2*t];
        this.next = null;
        this.n = 0;
    }
}
```

#### B+ Tree Implementation (Simplified)

```java
public class BPlusTree {
    private BPlusTreeNode root;
    private int t; // Minimum degree
    private static final int DEFAULT_T = 3; // Default degree

    public BPlusTree() {
        this(DEFAULT_T);
    }

    public BPlusTree(int t) {
        this.t = t;
        root = new BPlusTreeNode(t, true);
    }

    // Search for a key in the tree
    public boolean search(int key) {
        if (root == null)
            return false;

        BPlusTreeNode node = findLeafNode(root, key);

        // Find key in leaf node
        for (int i = 0; i < node.n; i++) {
            if (node.keys[i] == key)
                return true;
        }

        return false;
    }

    // Find leaf node that could contain the key
    private BPlusTreeNode findLeafNode(BPlusTreeNode node, int key) {
        if (node.isLeaf)
            return node;

        int i = 0;
        while (i < node.n && key >= node.keys[i])
            i++;

        return findLeafNode(node.children[i], key);
    }

    // Insert a key into the tree
    public void insert(int key) {
        // If root is full, need to split root
        if (root.n == 2 * t - 1) {
            BPlusTreeNode newRoot = new BPlusTreeNode(t, false);
            newRoot.children[0] = root;

            // Split old root
            splitChild(newRoot, 0);

            // Update new root
            root = newRoot;
        }

        insertNonFull(root, key);
    }

    // Insert key into non-full node
    private void insertNonFull(BPlusTreeNode node, int key) {
        int i = node.n - 1;

        // If leaf node
        if (node.isLeaf) {
            // Find position to insert and shift greater keys
            while (i >= 0 && key < node.keys[i]) {
                node.keys[i + 1] = node.keys[i];
                i--;
            }


            // Insert new key
            node.keys[i + 1] = key;
            node.n++;
        } else {
            // If not leaf node, find child to insert
            while (i >= 0 && key < node.keys[i])
                i--;

            i++;

            // If child is full, split it first
            if (node.children[i].n == 2 * t - 1) {
                splitChild(node, i);

                // After split, middle key is pushed up
                // Re-determine child to insert
                if (key > node.keys[i])
                    i++;
            }

            insertNonFull(node.children[i], key);
        }
    }

    // Split child i of parent
    private void splitChild(BPlusTreeNode parent, int i) {
        BPlusTreeNode child = parent.children[i];
        BPlusTreeNode newChild = new BPlusTreeNode(t, child.isLeaf);

        // Copy second half of keys from child to newChild
        for (int j = 0; j < t - 1; j++)
            newChild.keys[j] = child.keys[j + t];

        // Copy second half of children from child to newChild if not leaf
        if (!child.isLeaf) {
            for (int j = 0; j < t; j++)
                newChild.children[j] = child.children[j + t];
        }

        // Update number of keys
        newChild.n = t - 1;
        child.n = t;

        // Shift children of parent to insert newChild
        for (int j = parent.n; j > i; j--)
            parent.children[j + 1] = parent.children[j];

        parent.children[i + 1] = newChild;

        // Shift keys of parent
        for (int j = parent.n - 1; j >= i; j--)
            parent.keys[j + 1] = parent.keys[j];

        // Middle key of child is pushed up to parent
        parent.keys[i] = child.keys[t - 1];

        parent.n++;

        // Set link between leaf nodes
        if (child.isLeaf) {
            newChild.next = child.next;
            child.next = newChild;

            // In B+ Tree, we keep the key in leaf node
            child.keys[t - 1] = child.keys[t - 1]; // Keep key in leaf
        }
    }

    // Traverse tree
    public void traverse() {
        if (root != null) {
            traverseInternal(root);
        }
    }

    private void traverseInternal(BPlusTreeNode node) {
        if (node.isLeaf) {
            for (int i = 0; i < node.n; i++) {
                System.out.print(node.keys[i] + " ");
            }
        } else {
            int i;
            for (i = 0; i < node.n; i++) {
                traverseInternal(node.children[i]);
                System.out.print(node.keys[i] + " ");
            }
            traverseInternal(node.children[i]);
        }
    }

    // Traverse through leaf nodes (in order)
    public void traverseLeaves() {
        BPlusTreeNode current = findLeftmostLeaf(root);

        while (current != null) {
            for (int i = 0; i < current.n; i++) {
                System.out.print(current.keys[i] + " ");
            }
            current = current.next;
        }
        System.out.println();
    }

    // Find leftmost leaf node
    private BPlusTreeNode findLeftmostLeaf(BPlusTreeNode node) {
        if (node == null)
            return null;

        if (node.isLeaf)
            return node;

        return findLeftmostLeaf(node.children[0]);
    }

    // Range search [start, end]
    public List<Integer> rangeSearch(int start, int end) {
        List<Integer> result = new ArrayList<>();

        if (root == null)
            return result;

        BPlusTreeNode startLeaf = findLeafNode(root, start);

        // Traverse leaf nodes and collect keys in range
        BPlusTreeNode current = startLeaf;
        boolean found = false;

        while (current != null) {
            for (int i = 0; i < current.n; i++) {
                if (current.keys[i] >= start && current.keys[i] <= end) {
                    result.add(current.keys[i]);
                    found = true;
                } else if (found && current.keys[i] > end) {
                    // Exceeded range, stop searching
                    return result;
                }
            }
            current = current.next;
        }

        return result;
    }
}
```

## 🧑‍🏫 Lesson 3: Heap and Priority Queue

### Heap Structure

Heap is a tree-based data structure that satisfies the heap property: parent node is always greater than or equal to (Max Heap) or less than or equal to (Min Heap) its children.

- Heap Properties:
  - Heap is a complete binary tree: all levels are filled except possibly the last level, and the last level is filled from left to right.
  - Parent nodes are always greater than or equal to children (in Max-Heap).
  - Parent nodes are always less than or equal to children (in Min-Heap).
  - Height of heap with n elements is always O(log n).

### Heap Implementation

Heap is usually implemented using an array. For a node at position `i`:

- Left child at `2*i + 1`
- Right child at `2*i + 2`
- Parent at `(i-1)/2`

#### Max Heap

```java
public class MaxHeap {
    private int[] heap;
    private int size;
    private int capacity;

    public MaxHeap(int capacity) {
        this.capacity = capacity;
        this.size = 0;
        this.heap = new int[capacity];
    }

    private int parent(int i) {
        return (i - 1) / 2;
    }

    private int leftChild(int i) {
        return 2 * i + 1;
    }

    private int rightChild(int i) {
        return 2 * i + 2;
    }

    private void swap(int i, int j) {
        int temp = heap[i];
        heap[i] = heap[j];
        heap[j] = temp;
    }

    // Insert a new element into heap
    public void insert(int key) {
        if (size == capacity) {
            System.out.println("Heap is full");
            return;
        }

        // Insert at end then sift up
        size++;
        int i = size - 1;
        heap[i] = key;

        // Sift up to maintain heap property
        while (i != 0 && heap[parent(i)] < heap[i]) {
            swap(i, parent(i));
            i = parent(i);
        }
    }

    // Sift down from position i
    private void heapify(int i) {
        int left = leftChild(i);
        int right = rightChild(i);
        int largest = i;

        if (left < size && heap[left] > heap[largest])
            largest = left;

        if (right < size && heap[right] > heap[largest])
            largest = right;

        if (largest != i) {
            swap(i, largest);
            heapify(largest);
        }
    }

    // Extract max value
    public int extractMax() {
        if (size <= 0)
            throw new RuntimeException("Heap is empty");

        if (size == 1) {
            size--;
            return heap[0];
        }

        int root = heap[0];
        heap[0] = heap[size - 1];
        size--;
        heapify(0);

        return root;
    }

    // Increase value of element
    public void increaseKey(int i, int newValue) {
        if (newValue < heap[i])
            throw new RuntimeException("New value is smaller than current value");

        heap[i] = newValue;
        while (i != 0 && heap[parent(i)] < heap[i]) {
            swap(i, parent(i));
            i = parent(i);
        }
    }

    // Delete element at position i
    public void delete(int i) {
        increaseKey(i, Integer.MAX_VALUE);
        extractMax();
    }

    public void printHeap() {
        for (int i = 0; i < size; i++) {
            System.out.print(heap[i] + " ");
        }
        System.out.println();
    }
}
```

#### Min Heap

```java
public class MinHeap {
    private int[] heap;
    private int size;
    private int capacity;

    public MinHeap(int capacity) {
        this.capacity = capacity;
        this.size = 0;
        this.heap = new int[capacity];
    }

    private int parent(int i) {
        return (i - 1) / 2;
    }

    private int leftChild(int i) {
        return 2 * i + 1;
    }

    private int rightChild(int i) {
        return 2 * i + 2;
    }

    private void swap(int i, int j) {
        int temp = heap[i];
        heap[i] = heap[j];
        heap[j] = temp;
    }

    // Insert a new element into heap
    public void insert(int key) {
        if (size == capacity) {
            System.out.println("Heap is full");
            return;
        }

        // Insert at end then sift up
        size++;
        int i = size - 1;
        heap[i] = key;

        // Sift up to maintain heap property
        while (i != 0 && heap[parent(i)] > heap[i]) {
            swap(i, parent(i));
            i = parent(i);
        }
    }

    // Sift down from position i
    private void heapify(int i) {
        int left = leftChild(i);
        int right = rightChild(i);
        int smallest = i;

        if (left < size && heap[left] < heap[smallest])
            smallest = left;

        if (right < size && heap[right] < heap[smallest])
            smallest = right;

        if (smallest != i) {
            swap(i, smallest);
            heapify(smallest);
        }
    }

    // Extract min value
    public int extractMin() {
        if (size <= 0)
            throw new RuntimeException("Heap is empty");

        if (size == 1) {
            size--;
            return heap[0];
        }

        int root = heap[0];
        heap[0] = heap[size - 1];
        size--;
        heapify(0);

        return root;
    }

    // Decrease value of element
    public void decreaseKey(int i, int newValue) {
        if (newValue > heap[i])
            throw new RuntimeException("New value is larger than current value");

        heap[i] = newValue;
        while (i != 0 && heap[parent(i)] > heap[i]) {
            swap(i, parent(i));
            i = parent(i);
        }
    }

    // Delete element at position i
    public void delete(int i) {
        decreaseKey(i, Integer.MIN_VALUE);
        extractMin();
    }

    public void printHeap() {
        for (int i = 0; i < size; i++) {
            System.out.print(heap[i] + " ");
        }
        System.out.println();
    }
}
```

### Priority Queue

Priority Queue is a data structure that allows:

- Inserting element with priority
- Removing element with highest priority

#### Priority Queue Implementation using Heap

```java
public class PriorityQueue<T extends Comparable<T>> {
    private class Node {
        T data;
        int priority;

        Node(T data, int priority) {
            this.data = data;
            this.priority = priority;
        }
    }

    private Node[] heap;
    private int size;
    private int capacity;

    @SuppressWarnings("unchecked")
    public PriorityQueue(int capacity) {
        this.capacity = capacity;
        this.size = 0;
        this.heap = new Node[capacity];
    }

    private int parent(int i) {
        return (i - 1) / 2;
    }

    private int leftChild(int i) {
        return 2 * i + 1;
    }

    private int rightChild(int i) {
        return 2 * i + 2;
    }

    private void swap(int i, int j) {
        Node temp = heap[i];
        heap[i] = heap[j];
        heap[j] = temp;
    }

    // Check if queue is empty
    public boolean isEmpty() {
        return size == 0;
    }

    // Check if queue is full
    public boolean isFull() {
        return size == capacity;
    }

    // Enqueue element with priority
    public void enqueue(T data, int priority) {
        if (isFull()) {
            System.out.println("Queue is full");
            return;
        }

        // Create new node and insert at end
        Node newNode = new Node(data, priority);
        heap[size] = newNode;
        size++;

        // Sift up to maintain heap property
        int i = size - 1;
        while (i > 0 && heap[parent(i)].priority < heap[i].priority) {
            swap(i, parent(i));
            i = parent(i);
        }
    }

    // Dequeue element with highest priority
    public T dequeue() {
        if (isEmpty()) {
            throw new RuntimeException("Queue is empty");
        }

        Node root = heap[0];
        heap[0] = heap[size - 1];
        size--;

        heapify(0);

        return root.data;
    }

    // Peek element with highest priority
    public T peek() {
        if (isEmpty()) {
            throw new RuntimeException("Queue is empty");
        }
        return heap[0].data;
    }

    // Sift down from position i
    private void heapify(int i) {
        int left = leftChild(i);
        int right = rightChild(i);
        int highest = i;

        if (left < size && heap[left].priority > heap[highest].priority)
            highest = left;

        if (right < size && heap[right].priority > heap[highest].priority)
            highest = right;

        if (highest != i) {
            swap(i, highest);
            heapify(highest);
        }
    }
}
```

### Heap Sort

Heap Sort is an efficient sorting algorithm based on heap structure.

```java
public class HeapSort {
    public void sort(int[] arr) {
        int n = arr.length;

        // Build heap (rearrange array)
        for (int i = n/2 - 1; i >= 0; i--) {
            heapify(arr, n, i);
        }

        // Extract elements from heap one by one
        for (int i = n-1; i >= 0; i--) {
            // Move current root to end
            int temp = arr[0];
            arr[0] = arr[i];
            arr[i] = temp;

            // Call max heapify on the reduced heap
            heapify(arr, i, 0);
        }
    }

    // To heapify a subtree rooted with node i which is an index in arr[]. n is size of heap
    void heapify(int[] arr, int n, int i) {
        int largest = i; // Initialize largest as root
        int left = 2*i + 1;
        int right = 2*i + 2;

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
}
```

### 5. Applications of Heap and Priority Queue

1. **Dijkstra's Algorithm**: Finding shortest paths in graphs.
2. **Prim's Algorithm**: Finding minimum spanning tree in graphs.
3. **Task Management System**: Processing tasks based on priority.
4. **Huffman Coding**: Building Huffman tree using min-heap.
5. **Heap Sort**: Sorting algorithm with O(n log n) complexity.
6. **Finding k largest/smallest elements**: Using min-heap or max-heap.

### 6. Exercises

#### Exercise 1: Find k largest elements in an array using min-heap

```java
public static int[] findKLargest(int[] nums, int k) {
    // Create min-heap of size k
    PriorityQueue<Integer> minHeap = new PriorityQueue<>(k);

    // Add first k elements to heap
    for (int i = 0; i < k; i++) {
        minHeap.add(nums[i]);
    }

    // Compare and replace remaining elements
    for (int i = k; i < nums.length; i++) {
        if (nums[i] > minHeap.peek()) {
            minHeap.poll(); // Remove smallest element
            minHeap.add(nums[i]); // Add new element
        }
    }

    // Convert result from heap to array
    int[] result = new int[k];
    for (int i = k-1; i >= 0; i--) {
        result[i] = minHeap.poll();
    }

    return result;
}
```

#### Exercise 2: CPU Scheduling using Priority Queue

```java
class Process {
    String name;
    int priority;
    int burstTime;

    Process(String name, int priority, int burstTime) {
        this.name = name;
        this.priority = priority;
        this.burstTime = burstTime;
    }
}

public class CPUScheduler {
    public static void schedule(Process[] processes) {
        // Create priority queue based on process priority
        PriorityQueue<Process> queue = new PriorityQueue<>(
            (p1, p2) -> p2.priority - p1.priority
        );

        // Add all processes to queue
        for (Process process : processes) {
            queue.add(process);
        }

        // Process tasks in order of priority
        System.out.println("CPU Schedule:");
        while (!queue.isEmpty()) {
            Process process = queue.poll();
            System.out.println("Processing: " + process.name +
                              " (Priority: " + process.priority +
                              ", Burst Time: " + process.burstTime + ")");
        }
    }

    public static void main(String[] args) {
        Process[] processes = {
            new Process("P1", 10, 5),
            new Process("P2", 15, 3),
            new Process("P3", 7, 8),
            new Process("P4", 12, 2)
        };

        schedule(processes);
    }
}
```

### 7. Performance Analysis

| Operation | Average Time | Worst Time |
| -------------------- | -------------------- | ------------------ |
| Insert | O(1) | O(log n) |
| Delete Max/Min | O(log n) | O(log n) |
| Build Heap | O(n) | O(n) |
| Increase/Decrease Key | O(log n) | O(log n) |
| Find Max/Min | O(1) | O(1) |
| Delete | O(log n) | O(log n) |

Heap is an excellent data structure for problems requiring fast access to the largest/smallest element and frequent updates to the dataset.

## 🧑‍🏫 Lesson 4: Trie and Applications

### Trie Data Structure

Trie (or Prefix Tree) is a tree-based data structure used to store and search for strings efficiently.

#### Characteristics of Trie

- Each node in the trie can store multiple pointers to child nodes (usually 26 pointers for English letters).
- The path from the root to a node represents a prefix.
- Leaf nodes or specially marked nodes represent a complete word/string.
- All children of a node share a common prefix.

#### Trie Node Structure

```java
class TrieNode {
    boolean isEndOfWord; // Marks the end of a word
    TrieNode[] children; // Child nodes, usually 26 for 'a' to 'z'

    public TrieNode() {
        isEndOfWord = false;
        children = new TrieNode[26]; // For 26 English letters
        for (int i = 0; i < 26; i++)
            children[i] = null;
    }
}
```

### Basic Trie Implementation

```java
public class Trie {
    private TrieNode root;

    public Trie() {
        root = new TrieNode();
    }

    // Insert a word into trie
    public void insert(String word) {
        TrieNode current = root;

        for (int i = 0; i < word.length(); i++) {
            int index = word.charAt(i) - 'a';
            if (current.children[index] == null)
                current.children[index] = new TrieNode();

            current = current.children[index];
        }

        // Mark the last node as end of word
        current.isEndOfWord = true;
    }

    // Search for a word in trie
    public boolean search(String word) {
        TrieNode current = root;

        for (int i = 0; i < word.length(); i++) {
            int index = word.charAt(i) - 'a';
            if (current.children[index] == null)
                return false;

            current = current.children[index];
        }

        return current.isEndOfWord;
    }

    // Check if there is any word starting with prefix
    public boolean startsWith(String prefix) {
        TrieNode current = root;

        for (int i = 0; i < prefix.length(); i++) {
            int index = prefix.charAt(i) - 'a';
            if (current.children[index] == null)
                return false;

            current = current.children[index];
        }

        return true;
    }

    // Delete a word from trie
    public void delete(String word) {
        delete(root, word, 0);
    }

    private boolean delete(TrieNode current, String word, int index) {
        if (index == word.length()) {
            // If word does not exist
            if (!current.isEndOfWord) {
                return false;
            }

            // Mark word as deleted
            current.isEndOfWord = false;

            // Return true if node has no children
            return hasNoChildren(current);
        }

        int charIndex = word.charAt(index) - 'a';
        TrieNode child = current.children[charIndex];

        if (child == null) {
            return false; // Word does not exist
        }

        boolean shouldDeleteChild = delete(child, word, index + 1);

        // If child needs to be deleted and child is not end of another word
        if (shouldDeleteChild) {
            current.children[charIndex] = null;

            // Return true if current node has no word ending there
            // and has no children
            return !current.isEndOfWord && hasNoChildren(current);
        }

        return false;
    }

    private boolean hasNoChildren(TrieNode node) {
        for (int i = 0; i < 26; i++) {
            if (node.children[i] != null)
                return false;
        }
        return true;
    }
}
```

### Applications of Trie

#### Autocomplete

```java
// Implement autocomplete feature
public List<String> autocomplete(String prefix) {
    List<String> result = new ArrayList<>();
    TrieNode current = root;

    // Traverse to the end node of prefix
    for (int i = 0; i < prefix.length(); i++) {
        int index = prefix.charAt(i) - 'a';
        if (current.children[index] == null)
            return result; // No word starts with this prefix

        current = current.children[index];
    }

    // Find all words starting with prefix
    findAllWords(current, prefix, result);

    return result;
}

private void findAllWords(TrieNode node, String prefix, List<String> result) {
    // If current node is end of a word, add word to result
    if (node.isEndOfWord) {
        result.add(prefix);
    }

    // Traverse all children
    for (int i = 0; i < 26; i++) {
        if (node.children[i] != null) {
            char ch = (char) (i + 'a');
            findAllWords(node.children[i], prefix + ch, result);
        }
    }
}
```

#### Prefix Checking

```java
// Check if a word is a prefix of any word in dictionary
public boolean isPrefix(String word) {
    TrieNode current = root;

    for (int i = 0; i < word.length(); i++) {
        int index = word.charAt(i) - 'a';
        if (current.children[index] == null)
            return false;

        current = current.children[index];
    }

    return true;
}
```

#### Word Search

```java
public boolean exist(char[][] board, String word) {
    if (board == null || board.length == 0 || word == null)
        return false;

    int m = board.length;
    int n = board[0].length;
    boolean[][] visited = new boolean[m][n];

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (board[i][j] == word.charAt(0) && search(board, word, i, j, 0, visited))
                return true;
        }
    }

    return false;
}

private boolean search(char[][] board, String word, int i, int j, int index, boolean[][] visited) {
    // If all characters found
    if (index == word.length())
        return true;

    // Check boundaries and character
    if (i < 0 || i >= board.length || j < 0 || j >= board[0].length ||
        board[i][j] != word.charAt(index) || visited[i][j])
        return false;

    // Mark cell as visited
    visited[i][j] = true;

    // Check 4 directions
    boolean result = search(board, word, i+1, j, index+1, visited) ||
                     search(board, word, i-1, j, index+1, visited) ||
                     search(board, word, i, j+1, index+1, visited) ||
                     search(board, word, i, j-1, index+1, visited);

    // Unmark
    visited[i][j] = false;

    return result;
}
```

#### Dictionary

```java
public class Dictionary {
    private Trie trie;

    public Dictionary() {
        trie = new Trie();
    }

    public void addWord(String word) {
        trie.insert(word.toLowerCase());
    }

    public boolean isValidWord(String word) {
        return trie.search(word.toLowerCase());
    }

    public List<String> getWordsStartingWith(String prefix) {
        return trie.autocomplete(prefix.toLowerCase());
    }

    public void removeWord(String word) {
        trie.delete(word.toLowerCase());
    }
}
```

### Hash Trie

```java
class HashTrieNode {
    boolean isEndOfWord;
    HashMap<Character, HashTrieNode> children;

    public HashTrieNode() {
        isEndOfWord = false;
        children = new HashMap<>();
    }
}

public class HashTrie {
    private HashTrieNode root;

    public HashTrie() {
        root = new HashTrieNode();
    }

    public void insert(String word) {
        HashTrieNode current = root;

        for (int i = 0; i < word.length(); i++) {
            char ch = word.charAt(i);
            HashTrieNode node = current.children.get(ch);
            if (node == null) {
                node = new HashTrieNode();
                current.children.put(ch, node);
            }
            current = node;
        }

        current.isEndOfWord = true;
    }

    public boolean search(String word) {
        HashTrieNode current = root;

        for (int i = 0; i < word.length(); i++) {
            char ch = word.charAt(i);
            HashTrieNode node = current.children.get(ch);
            if (node == null)
                return false;
            current = node;
        }

        return current.isEndOfWord;
    }

    public boolean startsWith(String prefix) {
        HashTrieNode current = root;

        for (int i = 0; i < prefix.length(); i++) {
            char ch = prefix.charAt(i);
            HashTrieNode node = current.children.get(ch);
            if (node == null)
                return false;
            current = node;
        }

        return true;
    }
}
```

### Compressed Trie

```java
class CompressedTrieNode {
    String prefix;
    boolean isEndOfWord;
    HashMap<Character, CompressedTrieNode> children;

    public CompressedTrieNode(String prefix) {
        this.prefix = prefix;
        this.isEndOfWord = false;
        this.children = new HashMap<>();
    }
}

public class CompressedTrie {
    private CompressedTrieNode root;

    public CompressedTrie() {
        root = new CompressedTrieNode("");
    }

    public void insert(String word) {
        insert(root, word);
    }

    private void insert(CompressedTrieNode node, String word) {
        // If word is empty, mark current node as end of word
        if (word.isEmpty()) {
            node.isEndOfWord = true;
            return;
        }

        char firstChar = word.charAt(0);
        CompressedTrieNode child = node.children.get(firstChar);

        // If no child starts with this character
        if (child == null) {
            child = new CompressedTrieNode(word);
            node.children.put(firstChar, child);
            child.isEndOfWord = true;
            return;
        }

        // Find first difference between new word and child prefix
        int i = 0;
        String childPrefix = child.prefix;
        while (i < word.length() && i < childPrefix.length() && word.charAt(i) == childPrefix.charAt(i)) {
            i++;
        }

        // If new word is a prefix of child
        if (i == word.length()) {
            // Split child
            CompressedTrieNode newChild = new CompressedTrieNode(childPrefix.substring(i));
            newChild.children = child.children;
            newChild.isEndOfWord = child.isEndOfWord;

            // Update old child
            child.prefix = word;
            child.children = new HashMap<>();
            child.children.put(childPrefix.charAt(i), newChild);
            child.isEndOfWord = true;
        }
        // If child is a prefix of new word
        else if (i == childPrefix.length()) {
            insert(child, word.substring(i));
        }
        // If new word and child share a common prefix
        else {
            // Create common prefix node
            CompressedTrieNode commonPrefixNode = new CompressedTrieNode(word.substring(0, i));
            node.children.put(firstChar, commonPrefixNode);

            // Create node for rest of new word
            CompressedTrieNode newWordNode = new CompressedTrieNode(word.substring(i));
            newWordNode.isEndOfWord = true;

            // Create node for rest of child prefix
            CompressedTrieNode remainingPrefixNode = new CompressedTrieNode(childPrefix.substring(i));
            remainingPrefixNode.children = child.children;
            remainingPrefixNode.isEndOfWord = child.isEndOfWord;

            // Link nodes
            commonPrefixNode.children.put(word.charAt(i), newWordNode);
            commonPrefixNode.children.put(childPrefix.charAt(i), remainingPrefixNode);
        }
    }

    public boolean search(String word) {
        return search(root, word);
    }

    private boolean search(CompressedTrieNode node, String word) {
        if (word.isEmpty())
            return node.isEndOfWord;

        char firstChar = word.charAt(0);
        CompressedTrieNode child = node.children.get(firstChar);

        if (child == null)
            return false;

        String childPrefix = child.prefix;

        // If word does not start with child prefix
        if (!word.startsWith(childPrefix))
            return false;

        // If word equals child prefix
        if (word.equals(childPrefix))
            return child.isEndOfWord;

        // Check rest of the word
        return search(child, word.substring(childPrefix.length()));
    }
}
```

### Trie Performance Analysis

| Operation | Time | Space |
| ------------------ | --------- | ---------- |
| Insert | O(m) | O(m) |
| Search | O(m) | O(1) |
| Delete | O(m) | O(1) |
| Prefix | O(p) | O(1) |
| Autocomplete | O(n) | O(n) |

Where:

- m is length of word to insert/search/delete
- p is length of prefix
- n is number of words in Trie

### Comparison with Other Data Structures

| Data Structure | Pros | Cons |
| ------------------ | --------------------------- | --------------------------------- |
| Trie | - Fast search O(m) | - High memory usage |
| | - Efficient prefix search | - Complex implementation |
| | - Supports autocomplete | |
| Hash Table | - Fast search O(1) | - No prefix search support |
| | - Less memory usage | - No autocomplete support |
| Binary Search Tree | - Memory efficient | - Slower search O(log n) |
| | - Easy to implement | - Not efficient for prefix search |

### Exercises

#### Exercise 1: Count words with common prefix

```java
public int countWordsWithPrefix(String prefix) {
    TrieNode current = root;

    // Traverse to end node of prefix
    for (int i = 0; i < prefix.length(); i++) {
        int index = prefix.charAt(i) - 'a';
        if (current.children[index] == null)
            return 0;

        current = current.children[index];
    }

    // Count all words starting from this node
    return countWords(current);
}

private int countWords(TrieNode node) {
    int count = 0;

    if (node.isEndOfWord)
        count++;

    for (int i = 0; i < 26; i++) {
        if (node.children[i] != null)
            count += countWords(node.children[i]);
    }

    return count;
}
```

#### Exercise 2: Find longest word with all prefixes in dictionary

```java
public String findLongestWordWithAllPrefixes() {
    return findLongestWord(root, "");
}

private String findLongestWord(TrieNode node, String prefix) {
    String maxWord = node.isEndOfWord ? prefix : "";

    for (int i = 0; i < 26; i++) {
        if (node.children[i] != null) {
            char ch = (char) (i + 'a');
            String word = findLongestWord(node.children[i], prefix + ch);

            // Only consider word if all prefixes exist
            if (word.length() > maxWord.length() &&
                allPrefixesExist(word))
                maxWord = word;
        }
    }

    return maxWord;
}

private boolean allPrefixesExist(String word) {
    for (int i = 1; i < word.length(); i++) {
        if (!search(word.substring(0, i)))
            return false;
    }
    return true;
}
```

#### Exercise 3: Build Word Boggle Game

```java
public List<String> findWords(char[][] board, String[] words) {
    List<String> result = new ArrayList<>();
    Trie trie = new Trie();

    // Add all words to trie
    for (String word : words)
        trie.insert(word);

    int m = board.length;
    int n = board[0].length;
    boolean[][] visited = new boolean[m][n];
    Set<String> foundWords = new HashSet<>();

    // Traverse all cells on board
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            findWordsUtil(board, i, j, trie.root, "", visited, foundWords);
        }
    }

    result.addAll(foundWords);
    return result;
}

private void findWordsUtil(char[][] board, int i, int j, TrieNode node,
                          String prefix, boolean[][] visited, Set<String> result) {
    // Check boundaries
    if (i < 0 || i >= board.length || j < 0 || j >= board[0].length || visited[i][j])
        return;

    char ch = board[i][j];
    int index = ch - 'a';

    // If no child node for this character
    if (node.children[index] == null)
        return;

    // Update prefix and node
    prefix += ch;
    node = node.children[index];

    // If this is a complete word, add to result
    if (node.isEndOfWord)
        result.add(prefix);

    // Mark current cell as visited
    visited[i][j] = true;

    // Traverse 8 directions
    int[] dx = {-1, -1, -1, 0, 0, 1, 1, 1};
    int[] dy = {-1, 0, 1, -1, 1, -1, 0, 1};

    for (int k = 0; k < 8; k++) {
        findWordsUtil(board, i + dx[k], j + dy[k], node, prefix, visited, result);
    }

    // Unmark current cell
    visited[i][j] = false;
}
```

## 🧑‍🏫 Lesson 5: Segment Tree and Fenwick Tree

### Segment Tree

Segment Tree is a data structure used to solve range query problems and update elements in an array efficiently.

#### Properties of Segment Tree

- Root node represents the entire array.
- Each leaf node represents a single element.
- Each internal node has two children, representing two halves of the parent's segment.

#### Segment Tree Implementation

```java
public class SegmentTree {
    int[] tree;
    int n; // Initial array size

    // Build segment tree from input array
    public SegmentTree(int[] arr) {
        n = arr.length;
        // Height of tree = ceil(log2(n))
        int height = (int) Math.ceil(Math.log(n) / Math.log(2));
        // Max nodes = 2*2^h - 1
        int maxSize = 2 * (int) Math.pow(2, height) - 1;

        tree = new int[maxSize];
        buildSegmentTree(arr, 0, n - 1, 0);
    }

    // Function to build segment tree
    private int buildSegmentTree(int[] arr, int start, int end, int index) {
        // If leaf node (start == end)
        if (start == end) {
            tree[index] = arr[start];
            return tree[index];
        }

        int mid = start + (end - start) / 2;

        // Build left and right subtrees
        int leftSum = buildSegmentTree(arr, start, mid, 2 * index + 1);
        int rightSum = buildSegmentTree(arr, mid + 1, end, 2 * index + 2);

        // Sum of current segment is sum of two child segments
        tree[index] = leftSum + rightSum;

        return tree[index];
    }

    // Query sum in range [qStart, qEnd]
    public int getSum(int qStart, int qEnd) {
        if (qStart < 0 || qEnd >= n || qStart > qEnd) {
            System.out.println("Invalid query");
            return -1;
        }

        return getSumUtil(0, n - 1, qStart, qEnd, 0);
    }

    private int getSumUtil(int start, int end, int qStart, int qEnd, int index) {
        // If current segment is completely inside query range
        if (qStart <= start && qEnd >= end)
            return tree[index];

        // If current segment is completely outside query range
        if (end < qStart || start > qEnd)
            return 0;

        // If current segment overlaps with query range
        int mid = start + (end - start) / 2;

        int leftSum = getSumUtil(start, mid, qStart, qEnd, 2 * index + 1);
        int rightSum = getSumUtil(mid + 1, end, qStart, qEnd, 2 * index + 2);

        return leftSum + rightSum;
    }

    // Update value of element
    public void update(int pos, int newValue) {
        if (pos < 0 || pos >= n) {
            System.out.println("Invalid position");
            return;
        }

        // Calculate difference
        int diff = newValue - getSum(pos, pos);

        // Update segment tree
        updateUtil(0, n - 1, pos, diff, 0);
    }

    private void updateUtil(int start, int end, int pos, int diff, int index) {
        // If position to update is not in current segment
        if (pos < start || pos > end)
            return;

        // Update value of current node
        tree[index] += diff;

        // If not leaf node, update children
        if (start != end) {
            int mid = start + (end - start) / 2;

            updateUtil(start, mid, pos, diff, 2 * index + 1);
            updateUtil(mid + 1, end, pos, diff, 2 * index + 2);
        }
    }

    // Update value in range [uStart, uEnd]
    public void updateRange(int uStart, int uEnd, int diff) {
        if (uStart < 0 || uEnd >= n || uStart > uEnd) {
            System.out.println("Invalid query");
            return;
        }

        updateRangeUtil(0, n - 1, uStart, uEnd, diff, 0);
    }

    private void updateRangeUtil(int start, int end, int uStart, int uEnd, int diff, int index) {
        // If current segment is outside update range
        if (end < uStart || start > uEnd)
            return;

        // If leaf node
        if (start == end) {
            tree[index] += diff;
            return;
        }

        // Update subtree
        int mid = start + (end - start) / 2;

        updateRangeUtil(start, mid, uStart, uEnd, diff, 2 * index + 1);
        updateRangeUtil(mid + 1, end, uStart, uEnd, diff, 2 * index + 2);

        // Update parent node after updating children
        tree[index] = tree[2 * index + 1] + tree[2 * index + 2];
    }

    // Find minimum value in range [qStart, qEnd]
    public int getMin(int qStart, int qEnd) {
        if (qStart < 0 || qEnd >= n || qStart > qEnd) {
            System.out.println("Invalid query");
            return Integer.MAX_VALUE;
        }

        return getMinUtil(0, n - 1, qStart, qEnd, 0);
    }

    private int getMinUtil(int start, int end, int qStart, int qEnd, int index) {
        // If current segment is completely inside query range
        if (qStart <= start && qEnd >= end)
            return tree[index];

        // If current segment is completely outside query range
        if (end < qStart || start > qEnd)
            return Integer.MAX_VALUE;

        // If current segment overlaps with query range
        int mid = start + (end - start) / 2;

        int leftMin = getMinUtil(start, mid, qStart, qEnd, 2 * index + 1);
        int rightMin = getMinUtil(mid + 1, end, qStart, qEnd, 2 * index + 2);

        return Math.min(leftMin, rightMin);
    }
}
```

### Lazy Propagation in Segment Tree

Lazy Propagation is an optimization technique for Segment Tree when there are multiple range updates.

```java
public class LazySegmentTree {
    int[] tree;
    int[] lazy;
    int n;

    public LazySegmentTree(int[] arr) {
        n = arr.length;
        int height = (int) Math.ceil(Math.log(n) / Math.log(2));
        int maxSize = 2 * (int) Math.pow(2, height) - 1;

        tree = new int[maxSize];
        lazy = new int[maxSize]; // Lazy array to postpone updates

        buildSegmentTree(arr, 0, n - 1, 0);
    }

    private int buildSegmentTree(int[] arr, int start, int end, int index) {
        if (start == end) {
            tree[index] = arr[start];
            return tree[index];
        }

        int mid = start + (end - start) / 2;
        int leftSum = buildSegmentTree(arr, start, mid, 2 * index + 1);
        int rightSum = buildSegmentTree(arr, mid + 1, end, 2 * index + 2);

        tree[index] = leftSum + rightSum;

        return tree[index];
    }

    // Query sum with lazy propagation
    public int getSum(int qStart, int qEnd) {
        if (qStart < 0 || qEnd >= n || qStart > qEnd) {
            return -1;
        }

        return getSumUtil(0, n - 1, qStart, qEnd, 0);
    }

    private int getSumUtil(int start, int end, int qStart, int qEnd, int index) {
        // Propagate lazy update before query
        if (lazy[index] != 0) {
            tree[index] += (end - start + 1) * lazy[index]; // Update current node

            if (start != end) { // If not leaf node
                lazy[2 * index + 1] += lazy[index]; // Propagate to left child
                lazy[2 * index + 2] += lazy[index]; // Propagate to right child
            }

            lazy[index] = 0; // Propagation done
        }

        // If current segment is completely outside query range
        if (end < qStart || start > qEnd)
            return 0;

        // If current segment is completely inside query range
        if (qStart <= start && qEnd >= end)
            return tree[index];

        // If current segment overlaps with query range
        int mid = start + (end - start) / 2;

        int leftSum = getSumUtil(start, mid, qStart, qEnd, 2 * index + 1);
        int rightSum = getSumUtil(mid + 1, end, qStart, qEnd, 2 * index + 2);

        return leftSum + rightSum;
    }

    // Update range with lazy propagation
    public void updateRange(int uStart, int uEnd, int diff) {
        if (uStart < 0 || uEnd >= n || uStart > uEnd) {
            System.out.println("Invalid query");
            return;
        }

        updateRangeUtil(0, n - 1, uStart, uEnd, diff, 0);
    }

    private void updateRangeUtil(int start, int end, int uStart, int uEnd, int diff, int index) {
        // Propagate lazy update before update
        if (lazy[index] != 0) {
            tree[index] += (end - start + 1) * lazy[index];

            if (start != end) {
                lazy[2 * index + 1] += lazy[index];
                lazy[2 * index + 2] += lazy[index];
            }

            lazy[index] = 0;
        }

        // If current segment is outside update range
        if (end < uStart || start > uEnd)
            return;

        // If current segment is completely inside update range
        if (uStart <= start && uEnd >= end) {
            tree[index] += (end - start + 1) * diff;

            if (start != end) {
                lazy[2 * index + 1] += diff;
                lazy[2 * index + 2] += diff;
            }

            return;
        }

        // If current segment overlaps with update range
        int mid = start + (end - start) / 2;

        updateRangeUtil(start, mid, uStart, uEnd, diff, 2 * index + 1);
        updateRangeUtil(mid + 1, end, uStart, uEnd, diff, 2 * index + 2);

        tree[index] = tree[2 * index + 1] + tree[2 * index + 2];
    }
}
```

### Fenwick Tree (Binary Indexed Tree)

Fenwick Tree or Binary Indexed Tree is an efficient data structure for prefix sum updates and queries.

#### Properties of Fenwick Tree

- Uses Least Significant Bit (LSB) of index to determine the range covered by each node.
- Update and query operations have O(log n) complexity.
- Uses less memory than Segment Tree.

#### Fenwick Tree Implementation

```java
public class FenwickTree {
    private int[] bit; // Binary Indexed Tree
    private int n;

    public FenwickTree(int n) {
        this.n = n;
        bit = new int[n + 1]; // Index starts from 1
    }

    // Build BIT from input array
    public FenwickTree(int[] arr) {
        this.n = arr.length;
        bit = new int[n + 1];

        for (int i = 0; i < n; i++) {
            update(i, arr[i]);
        }
    }

    // Update value: add val to index
    public void update(int index, int val) {
        index++; // Convert to 1-based index

        while (index <= n) {
            bit[index] += val;
            index += index & -index; // Add last set bit
        }
    }

    // Query prefix sum: calculate sum from arr[0] to arr[index]
    public int getSum(int index) {
        int sum = 0;
        index++; // Convert to 1-based index

        while (index > 0) {
            sum += bit[index];
            index -= index & -index; // Subtract last set bit
        }

        return sum;
    }

    // Query sum in range [left, right]
    public int getSumRange(int left, int right) {
        return getSum(right) - getSum(left - 1);
    }

    // Get value at index
    public int getValue(int index) {
        return getSumRange(index, index);
    }

    // Find first index such that prefix sum >= sum
    public int findIndex(int sum) {
        int index = 0;
        int bitMask = Integer.highestOneBit(n);

        while (bitMask != 0) {
            int tIndex = index + bitMask;

            bitMask >>= 1;

            if (tIndex > n) continue;

            if (sum == bit[tIndex]) return tIndex;

            if (sum > bit[tIndex]) {
                sum -= bit[tIndex];
                index = tIndex;
            }
        }

        return index + 1;
    }
}
```

### 2D Fenwick Tree

Extend Fenwick Tree to support queries and updates on 2D matrix:

```java
public class FenwickTree2D {
    private int[][] bit;
    private int n, m; // Matrix dimensions

    public FenwickTree2D(int n, int m) {
        this.n = n;
        this.m = m;
        bit = new int[n + 1][m + 1]; // Index starts from 1
    }

    // Update value at position (x, y)
    public void update(int x, int y, int val) {
        x++; y++; // Convert to 1-based index

        for (int i = x; i <= n; i += i & -i) {
            for (int j = y; j <= m; j += j & -j) {
                bit[i][j] += val;
            }
        }
    }

    // Query sum from (0,0) to (x,y)
    public int getSum(int x, int y) {
        x++; y++; // Convert to 1-based index
        int sum = 0;

        for (int i = x; i > 0; i -= i & -i) {
            for (int j = y; j > 0; j -= j & -j) {
                sum += bit[i][j];
            }
        }

        return sum;
    }

    // Query sum in rectangle [(x1,y1), (x2,y2)]
    public int getSumRange(int x1, int y1, int x2, int y2) {
        return getSum(x2, y2) - getSum(x2, y1 - 1) - getSum(x1 - 1, y2) + getSum(x1 - 1, y1 - 1);
    }
}
```

### Comparison of Segment Tree and Fenwick Tree

| Criteria | Segment Tree | Fenwick Tree |
| -------------------- | ------------------------- | --------------------- |
| Query Complexity | O(log n) | O(log n) |
| Update Complexity | O(log n) | O(log n) |
| Memory Space | O(n) (2n-1 nodes) | O(n) (n nodes) |
| Implementation | More complex | Simpler |
| Supported Queries | Min, Max, Sum, GCD, ... | Mainly Sum |
| Range Update | Yes (with lazy propagation) | Not directly |
| Application | Diverse types of queries | Prefix sum queries |

### Applications of Segment Tree and Fenwick Tree

1. **Range Sum Query**: Calculate sum of elements in a range.
2. **Range Min/Max Query**.
3. **Range GCD/LCM Query**: Find GCD or LCM of elements in a range.
4. **Range Count Query**: Count elements satisfying a condition in a range.
5. **Data Structures in Databases**: To optimize data aggregation queries.
6. **Computational Geometry Problems**: Such as counting points in a rectangle.

### Practice Exercises

#### Exercise 1: Range Sum Query and Element Update

```java
public static void main(String[] args) {
    int[] arr = {1, 3, 5, 7, 9, 11};
    SegmentTree segTree = new SegmentTree(arr);

    // Query sum range [1, 3]
    System.out.println("Sum range [1, 3]: " + segTree.getSum(1, 3)); // Result: 15

    // Update element arr[1] to 10
    segTree.update(1, 10);

    // Query sum range [1, 3] again
    System.out.println("Sum range [1, 3] after update: " + segTree.getSum(1, 3)); // Result: 22
}
```

#### Exercise 2: Range Minimum Query

```java
// Segment Tree for Minimum Query
class MinSegmentTree {
    int[] tree;
    int n;

    public MinSegmentTree(int[] arr) {
        n = arr.length;
        int height = (int) Math.ceil(Math.log(n) / Math.log(2));
        int maxSize = 2 * (int) Math.pow(2, height) - 1;

        tree = new int[maxSize];
        buildSegmentTree(arr, 0, n - 1, 0);
    }

    private int buildSegmentTree(int[] arr, int start, int end, int index) {
        if (start == end) {
            tree[index] = arr[start];
            return tree[index];
        }

        int mid = start + (end - start) / 2;
        int leftMin = buildSegmentTree(arr, start, mid, 2 * index + 1);
        int rightMin = buildSegmentTree(arr, mid + 1, end, 2 * index + 2);

        tree[index] = Math.min(leftMin, rightMin);

        return tree[index];
    }

    public int getMin(int qStart, int qEnd) {
        if (qStart < 0 || qEnd >= n || qStart > qEnd)
            return Integer.MAX_VALUE;

        return getMinUtil(0, n - 1, qStart, qEnd, 0);
    }

    private int getMinUtil(int start, int end, int qStart, int qEnd, int index) {
        if (qStart <= start && qEnd >= end)
            return tree[index];

        if (end < qStart || start > qEnd)
            return Integer.MAX_VALUE;

        int mid = start + (end - start) / 2;

        int leftMin = getMinUtil(start, mid, qStart, qEnd, 2 * index + 1);
        int rightMin = getMinUtil(mid + 1, end, qStart, qEnd, 2 * index + 2);

        return Math.min(leftMin, rightMin);
    }
}

// Usage:
int[] arr = {5, 2, 8, 1, 9, 3};
MinSegmentTree minTree = new MinSegmentTree(arr);
System.out.println("Minimum value in range [1, 4]: " + minTree.getMin(1, 4)); // Result: 1
```

#### Exercise 3: Count elements greater than or equal to k in range [l, r]

```java
// Build special Segment Tree
class CountSegmentTree {
    class Node {
        int count; // Number of elements in range
        int[] frequency; // Frequency of values (assuming values 0-100)

        public Node() {
            count = 0;
            frequency = new int[101]; // Assuming values 0-100
        }
    }

    Node[] tree;
    int n;

    public CountSegmentTree(int[] arr) {
        n = arr.length;
        int height = (int) Math.ceil(Math.log(n) / Math.log(2));
        int maxSize = 2 * (int) Math.pow(2, height) - 1;

        tree = new Node[maxSize];
        for (int i = 0; i < maxSize; i++)
            tree[i] = new Node();

        buildSegmentTree(arr, 0, n - 1, 0);
    }

    private void buildSegmentTree(int[] arr, int start, int end, int index) {
        if (start == end) {
            tree[index].count = 1;
            tree[index].frequency[arr[start]]++;
            return;
        }

        int mid = start + (end - start) / 2;

        buildSegmentTree(arr, start, mid, 2 * index + 1);
        buildSegmentTree(arr, mid + 1, end, 2 * index + 2);

        tree[index].count = tree[2 * index + 1].count + tree[2 * index + 2].count;

        // Add frequencies from child nodes
        for (int i = 0; i <= 100; i++) {
            tree[index].frequency[i] = tree[2 * index + 1].frequency[i] + tree[2 * index + 2].frequency[i];
        }
    }

    // Count elements >= k in range [qStart, qEnd]
    public int countGreaterOrEqual(int qStart, int qEnd, int k) {
        if (qStart < 0 || qEnd >= n || qStart > qEnd)
            return 0;

        return countGreaterOrEqualUtil(0, n - 1, qStart, qEnd, k, 0);
    }

    private int countGreaterOrEqualUtil(int start, int end, int qStart, int qEnd, int k, int index) {
        if (qStart <= start && qEnd >= end) {
            int count = 0;
            for (int i = k; i <= 100; i++) {
                count += tree[index].frequency[i];
            }
            return count;
        }

        if (end < qStart || start > qEnd)
            return 0;

        int mid = start + (end - start) / 2;

        return countGreaterOrEqualUtil(start, mid, qStart, qEnd, k, 2 * index + 1) +
               countGreaterOrEqualUtil(mid + 1, end, qStart, qEnd, k, 2 * index + 2);
    }
}
```

## 🧑‍💻 Final Project: Simple Text Search Engine

### Problem Description

Build a simple text search engine that can:

1. Index a set of documents (indexing).
2. Search for documents containing keywords (keyword search).
3. Search for documents containing multiple keywords by relevance (ranking).
4. Suggest keywords as user types (autocomplete).

### Components to Implement

1. **Document Manager**: Manage and store documents.
2. **Tokenizer**: Split text into words.
3. **Inverted Index**: Data structure mapping keywords to documents.
4. **Trie**: Support keyword suggestion.
5. **Search Engine**: Process queries and rank results.

### Optional Features

1. **Stemming**: Convert words to root form (e.g., "running" -> "run").
2. **Phrase Search**: Search for exact phrases, not just individual words.
3. **Boolean Search**: Support logic operators like AND, OR, NOT.
4. **Fuzzy Search**: Search for words similar to keyword.
5. **Highlighting**: Highlight keywords in search results.
6. **Pagination**: Paginate search results.
7. **Filtering**: Filter results by various criteria.

