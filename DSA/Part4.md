# 📘 PHẦN 4: CÁC CẤU TRÚC DỮ LIỆU CHUYÊN BIỆT

- [📘 PHẦN 4: CÁC CẤU TRÚC DỮ LIỆU CHUYÊN BIỆT](#-phần-4-các-cấu-trúc-dữ-liệu-chuyên-biệt)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Cây cân bằng (AVL, Red-Black Trees)](#-bài-1-cây-cân-bằng-avl-red-black-trees)
    - [Cây AVL](#cây-avl)
      - [Các tính chất của cây AVL](#các-tính-chất-của-cây-avl)
      - [Các thao tác tái cân bằng](#các-thao-tác-tái-cân-bằng)
      - [Cài đặt cây AVL đầy đủ](#cài-đặt-cây-avl-đầy-đủ)
    - [Cây Red-Black](#cây-red-black)
      - [Tính chất của cây Red-Black](#tính-chất-của-cây-red-black)
      - [Cài đặt cây Red-Black](#cài-đặt-cây-red-black)
    - [So sánh cây AVL và cây Red-Black](#so-sánh-cây-avl-và-cây-red-black)
  - [🧑‍🏫 Bài 2: Cây B và B+](#-bài-2-cây-b-và-b)
    - [Cây B](#cây-b)
      - [Tính chất của cây B bậc M](#tính-chất-của-cây-b-bậc-m)
      - [Cấu trúc nút trong cây B](#cấu-trúc-nút-trong-cây-b)
      - [Cài đặt cây B](#cài-đặt-cây-b)
    - [Cây B+](#cây-b-1)
      - [Cấu trúc nút trong cây B+](#cấu-trúc-nút-trong-cây-b-1)
      - [Cài đặt cây B+ (phiên bản đơn giản)](#cài-đặt-cây-b-phiên-bản-đơn-giản)
  - [🧑‍🏫 Bài 3: Heap và Priority Queue](#-bài-3-heap-và-priority-queue)
    - [Cấu trúc Heap](#cấu-trúc-heap)
    - [Cài đặt Heap](#cài-đặt-heap)
      - [Max Heap](#max-heap)
      - [Min Heap](#min-heap)
    - [Priority Queue](#priority-queue)
      - [Cài đặt Priority Queue sử dụng Heap](#cài-đặt-priority-queue-sử-dụng-heap)
    - [Heap Sort](#heap-sort)
    - [5. Ứng dụng của Heap và Priority Queue](#5-ứng-dụng-của-heap-và-priority-queue)
    - [6. Bài tập](#6-bài-tập)
      - [Bài tập 1: Cài đặt thuật toán tìm k phần tử lớn nhất trong một mảng sử dụng min-heap](#bài-tập-1-cài-đặt-thuật-toán-tìm-k-phần-tử-lớn-nhất-trong-một-mảng-sử-dụng-min-heap)
      - [Bài tập 2: Sử dụng priority queue để lập lịch CPU (xử lý các tiến trình theo độ ưu tiên)](#bài-tập-2-sử-dụng-priority-queue-để-lập-lịch-cpu-xử-lý-các-tiến-trình-theo-độ-ưu-tiên)
    - [7. Phân tích hiệu năng](#7-phân-tích-hiệu-năng)
  - [🧑‍🏫 Bài 4: Trie và ứng dụng](#-bài-4-trie-và-ứng-dụng)
    - [Cấu trúc dữ liệu Trie](#cấu-trúc-dữ-liệu-trie)
      - [Đặc điểm của Trie](#đặc-điểm-của-trie)
      - [Cấu trúc nút của Trie](#cấu-trúc-nút-của-trie)
    - [Cài đặt cơ bản của Trie](#cài-đặt-cơ-bản-của-trie)
    - [Ứng dụng của Trie](#ứng-dụng-của-trie)
      - [Tự động hoàn thành (Autocomplete)](#tự-động-hoàn-thành-autocomplete)
      - [Kiểm tra tiền tố (Prefix checking)](#kiểm-tra-tiền-tố-prefix-checking)
      - [Tìm kiếm từ trong ma trận (Word Search)](#tìm-kiếm-từ-trong-ma-trận-word-search)
      - [Từ điển (Dictionary)](#từ-điển-dictionary)
    - [Trie với bảng băm (Hash Trie)](#trie-với-bảng-băm-hash-trie)
    - [Trie nén (Compressed Trie)](#trie-nén-compressed-trie)
    - [Phân tích hiệu năng của Trie](#phân-tích-hiệu-năng-của-trie)
    - [So sánh với các cấu trúc dữ liệu khác](#so-sánh-với-các-cấu-trúc-dữ-liệu-khác)
    - [Bài tập](#bài-tập)
      - [Bài tập 1: Đếm số từ có tiền tố chung](#bài-tập-1-đếm-số-từ-có-tiền-tố-chung)
      - [Bài tập 2: Tìm từ dài nhất có tất cả tiền tố trong từ điển](#bài-tập-2-tìm-từ-dài-nhất-có-tất-cả-tiền-tố-trong-từ-điển)
      - [Bài tập 3: Xây dựng trò chơi tìm từ (Word Boggle)](#bài-tập-3-xây-dựng-trò-chơi-tìm-từ-word-boggle)
  - [🧑‍🏫 Bài 5: Segment Tree và Fenwick Tree](#-bài-5-segment-tree-và-fenwick-tree)
    - [Segment Tree](#segment-tree)
      - [Tính chất của Segment Tree](#tính-chất-của-segment-tree)
      - [Cài đặt Segment Tree](#cài-đặt-segment-tree)
    - [Lazy Propagation trong Segment Tree](#lazy-propagation-trong-segment-tree)
    - [Fenwick Tree (Binary Indexed Tree)](#fenwick-tree-binary-indexed-tree)
      - [Tính chất của Fenwick Tree](#tính-chất-của-fenwick-tree)
      - [Cài đặt Fenwick Tree](#cài-đặt-fenwick-tree)
    - [Fenwick Tree 2D](#fenwick-tree-2d)
    - [So sánh Segment Tree và Fenwick Tree](#so-sánh-segment-tree-và-fenwick-tree)
    - [Ứng dụng của Segment Tree và Fenwick Tree](#ứng-dụng-của-segment-tree-và-fenwick-tree)
    - [Bài luyện tập](#bài-luyện-tập)
      - [Bài tập 1: Truy vấn tổng đoạn và cập nhật phần tử](#bài-tập-1-truy-vấn-tổng-đoạn-và-cập-nhật-phần-tử)
      - [Bài tập 2: Truy vấn giá trị nhỏ nhất đoạn](#bài-tập-2-truy-vấn-giá-trị-nhỏ-nhất-đoạn)
      - [Bài tập 3: Đếm số phần tử lớn hơn hoặc bằng k trong đoạn \[l, r\]](#bài-tập-3-đếm-số-phần-tử-lớn-hơn-hoặc-bằng-k-trong-đoạn-l-r)
  - [🧑‍💻 Bài tập lớn: Xây dựng hệ thống tìm kiếm văn bản đơn giản](#-bài-tập-lớn-xây-dựng-hệ-thống-tìm-kiếm-văn-bản-đơn-giản)
    - [Mô tả bài toán](#mô-tả-bài-toán)
    - [Các thành phần cần triển khai](#các-thành-phần-cần-triển-khai)
    - [Các tính năng mở rộng có thể thêm vào](#các-tính-năng-mở-rộng-có-thể-thêm-vào)

## 🎯 Mục tiêu tổng quát

- Hiểu và cài đặt được các cấu trúc dữ liệu nâng cao như cây cân bằng, cây B/B+, Heap, Trie, Segment Tree.
- Phân tích được ưu nhược điểm của từng cấu trúc và biết lựa chọn cấu trúc phù hợp với bài toán.
- Áp dụng các cấu trúc dữ liệu chuyên biệt vào các bài toán thực tế.
- Tối ưu hóa giải pháp sử dụng các cấu trúc dữ liệu đặc thù.

---

## 🧑‍🏫 Bài 1: Cây cân bằng (AVL, Red-Black Trees)

### Cây AVL

Cây AVL là cây nhị phân tìm kiếm tự cân bằng, đảm bảo chiều cao của hai cây con lệch nhau không quá 1 đơn vị.

#### Các tính chất của cây AVL

- Mỗi nút có hệ số cân bằng (balance factor) = chiều cao cây con trái - chiều cao cây con phải
- Hệ số cân bằng của mỗi nút phải là -1, 0, hoặc +1
- Các thao tác tìm kiếm, chèn, xóa đều có độ phức tạp O(log n)

#### Các thao tác tái cân bằng

1. Xoay phải (Right rotation):

   ```java
   private Node rightRotate(Node y) {
       Node x = y.left;
       Node T2 = x.right;

       // Thực hiện xoay
       x.right = y;
       y.left = T2;

       // Cập nhật chiều cao
       y.height = Math.max(height(y.left), height(y.right)) + 1;
       x.height = Math.max(height(x.left), height(x.right)) + 1;

       return x;
   }
   ```

2. **Xoay trái (Left rotation):**

   ```java
   private Node leftRotate(Node x) {
       Node y = x.right;
       Node T2 = y.left;

       // Thực hiện xoay
       y.left = x;
       x.right = T2;

       // Cập nhật chiều cao
       x.height = Math.max(height(x.left), height(x.right)) + 1;
       y.height = Math.max(height(y.left), height(y.right)) + 1;

       return y;
   }
   ```

#### Cài đặt cây AVL đầy đủ

```java
public class AVLTree {
    private class Node {
        int key, height;
        Node left, right;

        Node(int key) {
            this.key = key;
            this.height = 1; // Nút lá mới có chiều cao là 1
        }
    }

    private Node root;

    // Lấy chiều cao của nút
    private int height(Node node) {
        if (node == null)
            return 0;
        return node.height;
    }

    // Lấy hệ số cân bằng của nút
    private int getBalance(Node node) {
        if (node == null)
            return 0;
        return height(node.left) - height(node.right);
    }

    // Chèn một khóa mới vào cây
    public void insert(int key) {
        root = insert(root, key);
    }

    private Node insert(Node node, int key) {
        // 1. Thực hiện chèn BST thông thường
        if (node == null)
            return new Node(key);

        if (key < node.key)
            node.left = insert(node.left, key);
        else if (key > node.key)
            node.right = insert(node.right, key);
        else // Không cho phép trùng khóa
            return node;

        // 2. Cập nhật chiều cao của nút hiện tại
        node.height = 1 + Math.max(height(node.left), height(node.right));

        // 3. Lấy hệ số cân bằng để kiểm tra xem nút này có mất cân bằng không
        int balance = getBalance(node);

        // 4. Nếu mất cân bằng, có 4 trường hợp

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

    // Xóa một khóa khỏi cây
    public void delete(int key) {
        root = delete(root, key);
    }

    private Node delete(Node root, int key) {
        // 1. Thực hiện xóa BST thông thường
        if (root == null)
            return root;

        if (key < root.key)
            root.left = delete(root.left, key);
        else if (key > root.key)
            root.right = delete(root.right, key);
        else {
            // Nút có 0 hoặc 1 con
            if (root.left == null || root.right == null) {
                Node temp = (root.left != null) ? root.left : root.right;

                // Không có con
                if (temp == null) {
                    temp = root;
                    root = null;
                }
                // Một con
                else {
                    root = temp;
                }
            }
            // Nút có 2 con
            else {
                // Tìm nút kế tiếp theo thứ tự (nhỏ nhất trong cây con phải)
                Node temp = minValueNode(root.right);

                // Sao chép giá trị kế tiếp vào nút hiện tại
                root.key = temp.key;

                // Xóa nút kế tiếp
                root.right = delete(root.right, temp.key);
            }
        }

        // Nếu cây chỉ có một nút thì return
        if (root == null)
            return root;

        // 2. Cập nhật chiều cao
        root.height = 1 + Math.max(height(root.left), height(root.right));

        // 3. Kiểm tra hệ số cân bằng
        int balance = getBalance(root);

        // 4. Nếu mất cân bằng, tái cân bằng

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

        // Tìm nút trái nhất (nhỏ nhất)
        while (current.left != null)
            current = current.left;

        return current;
    }

    // Duyệt cây theo thứ tự
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

### Cây Red-Black

Cây Red-Black là một loại cây nhị phân tìm kiếm tự cân bằng với các tính chất đặc biệt để đảm bảo cân bằng.

#### Tính chất của cây Red-Black

1. Mỗi nút có màu đỏ hoặc đen
2. Nút gốc luôn có màu đen
3. Các nút lá NULL đều có màu đen
4. Nút đỏ không thể có con đỏ (không có 2 nút đỏ liên tiếp)
5. Mọi đường đi từ nút bất kỳ đến các nút lá đều có cùng số lượng nút đen

#### Cài đặt cây Red-Black

```java
public class RedBlackTree {
    private static final boolean RED = true;
    private static final boolean BLACK = false;

    private class Node {
        int key;
        Node left, right;
        boolean color; // true là RED, false là BLACK

        Node(int key) {
            this.key = key;
            this.color = RED; // Nút mới luôn là RED
        }
    }

    private Node root;

    // Kiểm tra màu của nút
    private boolean isRed(Node node) {
        if (node == null)
            return false; // NULL nodes are BLACK
        return node.color == RED;
    }

    // Xoay trái
    private Node rotateLeft(Node h) {
        Node x = h.right;
        h.right = x.left;
        x.left = h;
        x.color = h.color;
        h.color = RED;
        return x;
    }

    // Xoay phải
    private Node rotateRight(Node h) {
        Node x = h.left;
        h.left = x.right;
        x.right = h;
        x.color = h.color;
        h.color = RED;
        return x;
    }

    // Đảo màu của nút và hai con
    private void flipColors(Node h) {
        h.color = !h.color;
        h.left.color = !h.left.color;
        h.right.color = !h.right.color;
    }

    // Chèn một khóa vào cây
    public void insert(int key) {
        root = insert(root, key);
        root.color = BLACK; // Đảm bảo gốc luôn đen
    }

    private Node insert(Node h, int key) {
        if (h == null)
            return new Node(key);

        if (key < h.key)
            h.left = insert(h.left, key);
        else if (key > h.key)
            h.right = insert(h.right, key);
        else
            h.key = key; // Cập nhật nếu trùng khóa

        // Cân bằng cây

        // Nếu nút phải đỏ và nút trái đen: xoay trái
        if (isRed(h.right) && !isRed(h.left))
            h = rotateLeft(h);

        // Nếu nút trái đỏ và con trái của nó cũng đỏ: xoay phải
        if (isRed(h.left) && isRed(h.left.left))
            h = rotateRight(h);

        // Nếu cả nút trái và nút phải đều đỏ: đảo màu
        if (isRed(h.left) && isRed(h.right))
            flipColors(h);

        return h;
    }

    // Duyệt cây theo thứ tự
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

### So sánh cây AVL và cây Red-Black

| Tiêu chí      | Cây AVL                                | Cây Red-Black         |
| ------------- | -------------------------------------- | --------------------- |
| Cân bằng      | Nghiêm ngặt (hệ số cân bằng <= 1)      | Ít nghiêm ngặt hơn    |
| Chiều cao     | ~ 1.44 log(n)                          | ~ 2 log(n)            |
| Thao tác chèn | Tối đa 2 xoay                          | Tối đa 2 xoay         |
| Thao tác xóa  | Tối đa log(n) xoay                     | Tối đa 3 xoay         |
| Bộ nhớ        | 1 bit hệ số cân bằng/chiều cao mỗi nút | 1 bit màu mỗi nút     |
| Tìm kiếm      | Nhanh hơn do cân bằng tốt              | Chậm hơn một chút     |
| Ứng dụng      | Tra cứu thường xuyên                   | Chèn/xóa thường xuyên |

---

## 🧑‍🏫 Bài 2: Cây B và B+

### Cây B

Cây B là một cấu trúc cây tự cân bằng, mỗi nút có thể chứa nhiều khóa và có nhiều con. Cây B thường được sử dụng trong các hệ thống tập tin và cơ sở dữ liệu.

#### Tính chất của cây B bậc M

1. Mọi nút trừ nút gốc đều chứa từ ⌈M/2⌉-1 đến M-1 khóa
2. Nút gốc chứa từ 1 đến M-1 khóa
3. Nút có k khóa sẽ có k+1 con
4. Tất cả các nút lá đều nằm ở cùng một mức

#### Cấu trúc nút trong cây B

```java
class BTreeNode {
    int[] keys;        // Mảng các khóa
    int t;             // Bậc tối thiểu (số khóa tối thiểu là t-1)
    BTreeNode[] children; // Mảng các con
    int n;             // Số khóa hiện tại
    boolean leaf;      // true nếu là nút lá

    public BTreeNode(int t, boolean leaf) {
        this.t = t;
        this.leaf = leaf;
        this.keys = new int[2*t - 1]; // Mỗi nút có thể chứa tối đa 2t-1 khóa
        this.children = new BTreeNode[2*t]; // Mỗi nút có tối đa 2t con
        this.n = 0; // Khởi tạo với 0 khóa
    }
}
```

#### Cài đặt cây B

```java
public class BTree {
    private BTreeNode root;
    private int t; // Bậc tối thiểu

    public BTree(int t) {
        this.root = null;
        this.t = t;
    }

    // Tìm kiếm một khóa trong cây
    public BTreeNode search(int key) {
        if (root == null)
            return null;
        return search(root, key);
    }

    private BTreeNode search(BTreeNode node, int key) {
        // Tìm vị trí của khóa trong nút hiện tại
        int i = 0;
        while (i < node.n && key > node.keys[i])
            i++;

        // Nếu tìm thấy khóa
        if (i < node.n && key == node.keys[i])
            return node;

        // Nếu là nút lá và không tìm thấy
        if (node.leaf)
            return null;

        // Tiếp tục tìm kiếm ở nút con
        return search(node.children[i], key);
    }

    // Chèn một khóa vào cây
    public void insert(int key) {
        // Nếu cây rỗng
        if (root == null) {
            root = new BTreeNode(t, true);
            root.keys[0] = key;
            root.n = 1;
        } else {
            // Nếu gốc đầy, cây sẽ tăng chiều cao
            if (root.n == 2*t - 1) {
                BTreeNode s = new BTreeNode(t, false);
                s.children[0] = root;
                // Tách gốc cũ và di chuyển một khóa lên
                splitChild(s, 0);
                // Gốc mới có 2 con, quyết định con nào sẽ chứa khóa mới
                int i = 0;
                if (s.keys[0] < key)
                    i++;
                insertNonFull(s.children[i], key);

                // Đổi gốc
                root = s;
            } else {
                insertNonFull(root, key);
            }
        }
    }

    // Chèn khóa vào nút chưa đầy
    private void insertNonFull(BTreeNode node, int key) {
        // Khởi tạo vị trí của khóa cuối cùng
        int i = node.n - 1;

        // Nếu là nút lá
        if (node.leaf) {
            // Tìm vị trí của khóa mới và dịch chuyển các khóa lớn hơn
            while (i >= 0 && key < node.keys[i]) {
                node.keys[i+1] = node.keys[i];
                i--;
            }

            // Chèn khóa mới
            node.keys[i+1] = key;
            node.n++;
        } else { // Nếu không phải nút lá
            // Tìm nút con sẽ chứa khóa mới
            while (i >= 0 && key < node.keys[i])
                i--;

            i++;
            // Nếu nút con đầy, tách nó
            if (node.children[i].n == 2*t - 1) {
                splitChild(node, i);

                // Sau khi tách, khóa giữa được đẩy lên và nút con được chia đôi
                if (key > node.keys[i])
                    i++;
            }
            insertNonFull(node.children[i], key);
        }
    }

    // Tách nút con thứ i của node
    private void splitChild(BTreeNode node, int i) {
        BTreeNode y = node.children[i]; // Nút con cần tách
        BTreeNode z = new BTreeNode(t, y.leaf); // Nút mới

        z.n = t - 1;

        // Sao chép nửa sau của y vào z
        for (int j = 0; j < t-1; j++)
            z.keys[j] = y.keys[j+t];

        // Sao chép các con tương ứng nếu không phải nút lá
        if (!y.leaf) {
            for (int j = 0; j < t; j++)
                z.children[j] = y.children[j+t];
        }

        // Giảm số khóa trong y
        y.n = t - 1;

        // Dịch chuyển các con của node để chứa z
        for (int j = node.n; j > i; j--)
            node.children[j+1] = node.children[j];

        // Liên kết nút con mới
        node.children[i+1] = z;

        // Dịch chuyển các khóa của node để chèn khóa từ y
        for (int j = node.n-1; j >= i; j--)
            node.keys[j+1] = node.keys[j];

        // Sao chép khóa giữa từ y vào node
        node.keys[i] = y.keys[t-1];

        // Tăng số khóa trong node
        node.n++;
    }

    // In cây
    public void traverse() {
        if (root != null)
            traverse(root);
        System.out.println();
    }

    private void traverse(BTreeNode node) {
        int i;
        for (i = 0; i < node.n; i++) {
            // In cây con trước khóa thứ i
            if (!node.leaf)
                traverse(node.children[i]);
            System.out.print(node.keys[i] + " ");
        }

        // In cây con cuối cùng
        if (!node.leaf)
            traverse(node.children[i]);
    }
}
```

### Cây B+

Cây B+ là một biến thể của cây B, nhưng có một số khác biệt quan trọng:

1. Tất cả khóa đều được lưu trữ ở các nút lá, được liên kết tạo thành một danh sách liên kết
2. Các khóa trong nút nội bộ chỉ là bản sao của khóa ở nút lá
3. Nút lá chứa tất cả các khóa và con trỏ đến dữ liệu thực

#### Cấu trúc nút trong cây B+

```java
class BPlusTreeNode {
    boolean isLeaf; // true nếu là nút lá
    int[] keys; // Mảng các khóa
    int t; // Bậc tối thiểu
    BPlusTreeNode[] children; // Mảng các con (nút nội)
    BPlusTreeNode next; // Con trỏ tới nút lá kế tiếp (chỉ cho nút lá)
    int n; // Số khóa hiện tại

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

#### Cài đặt cây B+ (phiên bản đơn giản)

```java
public class BPlusTree {
    private BPlusTreeNode root;
    private int t; // Bậc tối thiểu
    private static final int DEFAULT_T = 3; // Bậc mặc định

    public BPlusTree() {
        this(DEFAULT_T);
    }

    public BPlusTree(int t) {
        this.t = t;
        root = new BPlusTreeNode(t, true);
    }

    // Tìm kiếm một khóa trong cây
    public boolean search(int key) {
        if (root == null)
            return false;

        BPlusTreeNode node = findLeafNode(root, key);

        // Tìm khóa trong nút lá
        for (int i = 0; i < node.n; i++) {
            if (node.keys[i] == key)
                return true;
        }

        return false;
    }

    // Tìm nút lá có thể chứa khóa
    private BPlusTreeNode findLeafNode(BPlusTreeNode node, int key) {
        if (node.isLeaf)
            return node;

        int i = 0;
        while (i < node.n && key >= node.keys[i])
            i++;

        return findLeafNode(node.children[i], key);
    }

    // Chèn một khóa vào cây
    public void insert(int key) {
        // Nếu gốc đầy, cần tách gốc
        if (root.n == 2 * t - 1) {
            BPlusTreeNode newRoot = new BPlusTreeNode(t, false);
            newRoot.children[0] = root;

            // Tách gốc cũ
            splitChild(newRoot, 0);

            // Cập nhật gốc mới
            root = newRoot;
        }

        insertNonFull(root, key);
    }

    // Chèn khóa vào nút không đầy
    private void insertNonFull(BPlusTreeNode node, int key) {
        int i = node.n - 1;

        // Nếu là nút lá
        if (node.isLeaf) {
            // Tìm vị trí để chèn và dịch các khóa lớn hơn
            while (i >= 0 && key < node.keys[i]) {
                node.keys[i + 1] = node.keys[i];
                i--;
            }


            // Chèn khóa mới
            node.keys[i + 1] = key;
            node.n++;
        } else {
            // Nếu không phải nút lá, tìm nút con để chèn
            while (i >= 0 && key < node.keys[i])
                i--;

            i++;

            // Nếu nút con đầy, tách nó trước
            if (node.children[i].n == 2 * t - 1) {
                splitChild(node, i);

                // Sau khi tách, khóa ở giữa được đẩy lên
                // Xác định lại nút con cần chèn
                if (key > node.keys[i])
                    i++;
            }

            insertNonFull(node.children[i], key);
        }
    }

    // Tách nút con thứ i của node
    private void splitChild(BPlusTreeNode parent, int i) {
        BPlusTreeNode child = parent.children[i];
        BPlusTreeNode newChild = new BPlusTreeNode(t, child.isLeaf);

        // Sao chép nửa sau của khóa từ child sang newChild
        for (int j = 0; j < t - 1; j++)
            newChild.keys[j] = child.keys[j + t];

        // Sao chép nửa sau của con từ child sang newChild nếu không phải nút lá
        if (!child.isLeaf) {
            for (int j = 0; j < t; j++)
                newChild.children[j] = child.children[j + t];
        }

        // Cập nhật số khóa
        newChild.n = t - 1;
        child.n = t;

        // Dịch chuyển con của parent để chèn newChild
        for (int j = parent.n; j > i; j--)
            parent.children[j + 1] = parent.children[j];

        parent.children[i + 1] = newChild;

        // Dịch chuyển khóa của parent
        for (int j = parent.n - 1; j >= i; j--)
            parent.keys[j + 1] = parent.keys[j];

        // Khóa ở giữa của child được đẩy lên parent
        parent.keys[i] = child.keys[t - 1];

        parent.n++;

        // Thiết lập liên kết giữa các nút lá
        if (child.isLeaf) {
            newChild.next = child.next;
            child.next = newChild;

            // Trong cây B+, chúng ta giữ lại khóa trong nút lá
            child.keys[t - 1] = child.keys[t - 1]; // Giữ lại khóa ở nút lá
        }
    }

    // Duyệt cây theo thứ tự
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

    // Duyệt qua các nút lá (theo thứ tự)
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

    // Tìm nút lá trái nhất
    private BPlusTreeNode findLeftmostLeaf(BPlusTreeNode node) {
        if (node == null)
            return null;

        if (node.isLeaf)
            return node;

        return findLeftmostLeaf(node.children[0]);
    }

    // Tìm khoảng giá trị [start, end]
    public List<Integer> rangeSearch(int start, int end) {
        List<Integer> result = new ArrayList<>();

        if (root == null)
            return result;

        BPlusTreeNode startLeaf = findLeafNode(root, start);

        // Duyệt qua các nút lá và thu thập các khóa trong khoảng
        BPlusTreeNode current = startLeaf;
        boolean found = false;

        while (current != null) {
            for (int i = 0; i < current.n; i++) {
                if (current.keys[i] >= start && current.keys[i] <= end) {
                    result.add(current.keys[i]);
                    found = true;
                } else if (found && current.keys[i] > end) {
                    // Đã vượt quá khoảng, dừng tìm kiếm
                    return result;
                }
            }
            current = current.next;
        }

        return result;
    }
}
```

## 🧑‍🏫 Bài 3: Heap và Priority Queue

### Cấu trúc Heap

Heap là một cấu trúc dữ liệu dạng cây thỏa mãn tính chất heap: nút cha luôn lớn hơn hoặc bằng (Max Heap) hoặc nhỏ hơn hoặc bằng (Min Heap) các nút con.

- Tính chất của Heap:
  - Heap là cây nhị phân hoàn chỉnh: tất cả các mức đều được lấp đầy trừ mức cuối cùng, và các nút ở mức cuối cùng luôn được đặt từ trái sang phải.
  - Các nút cha luôn lớn hơn hoặc bằng các nút con (trong Max-Heap).
  - Các nút cha luôn nhỏ hơn hoặc bằng các nút con (trong Min-Heap).
  - Chiều cao của heap với n phần tử luôn là O(log n).

### Cài đặt Heap

Heap thường được cài đặt bằng mảng. Với node ở vị trí `i`:

- Con trái ở vị trí `2*i + 1`
- Con phải ở vị trí `2*i + 2`
- Cha ở vị trí `(i-1)/2`

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

    // Chèn một phần tử mới vào heap
    public void insert(int key) {
        if (size == capacity) {
            System.out.println("Heap đã đầy");
            return;
        }

        // Chèn vào cuối rồi sàng lên
        size++;
        int i = size - 1;
        heap[i] = key;

        // Sàng lên để duy trì tính chất của heap
        while (i != 0 && heap[parent(i)] < heap[i]) {
            swap(i, parent(i));
            i = parent(i);
        }
    }

    // Sàng xuống từ vị trí i
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

    // Lấy giá trị lớn nhất
    public int extractMax() {
        if (size <= 0)
            throw new RuntimeException("Heap rỗng");

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

    // Tăng giá trị của phần tử
    public void increaseKey(int i, int newValue) {
        if (newValue < heap[i])
            throw new RuntimeException("Giá trị mới nhỏ hơn giá trị hiện tại");

        heap[i] = newValue;
        while (i != 0 && heap[parent(i)] < heap[i]) {
            swap(i, parent(i));
            i = parent(i);
        }
    }

    // Xóa phần tử tại vị trí i
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

    // Chèn một phần tử mới vào heap
    public void insert(int key) {
        if (size == capacity) {
            System.out.println("Heap đã đầy");
            return;
        }

        // Chèn vào cuối rồi sàng lên
        size++;
        int i = size - 1;
        heap[i] = key;

        // Sàng lên để duy trì tính chất của heap
        while (i != 0 && heap[parent(i)] > heap[i]) {
            swap(i, parent(i));
            i = parent(i);
        }
    }

    // Sàng xuống từ vị trí i
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

    // Lấy giá trị nhỏ nhất
    public int extractMin() {
        if (size <= 0)
            throw new RuntimeException("Heap rỗng");

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

    // Giảm giá trị của phần tử
    public void decreaseKey(int i, int newValue) {
        if (newValue > heap[i])
            throw new RuntimeException("Giá trị mới lớn hơn giá trị hiện tại");

        heap[i] = newValue;
        while (i != 0 && heap[parent(i)] > heap[i]) {
            swap(i, parent(i));
            i = parent(i);
        }
    }

    // Xóa phần tử tại vị trí i
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

Priority Queue (Hàng đợi ưu tiên) là một cấu trúc dữ liệu cho phép:

- Chèn phần tử với độ ưu tiên
- Lấy ra phần tử có độ ưu tiên cao nhất

#### Cài đặt Priority Queue sử dụng Heap

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

    // Kiểm tra xem hàng đợi có rỗng không
    public boolean isEmpty() {
        return size == 0;
    }

    // Kiểm tra xem hàng đợi có đầy không
    public boolean isFull() {
        return size == capacity;
    }

    // Chèn một phần tử vào hàng đợi với độ ưu tiên
    public void enqueue(T data, int priority) {
        if (isFull()) {
            System.out.println("Hàng đợi đã đầy");
            return;
        }

        // Tạo nút mới và chèn vào cuối
        Node newNode = new Node(data, priority);
        heap[size] = newNode;
        size++;

        // Sàng lên để duy trì tính chất của heap
        int i = size - 1;
        while (i > 0 && heap[parent(i)].priority < heap[i].priority) {
            swap(i, parent(i));
            i = parent(i);
        }
    }

    // Lấy phần tử có độ ưu tiên cao nhất
    public T dequeue() {
        if (isEmpty()) {
            throw new RuntimeException("Hàng đợi rỗng");
        }

        Node root = heap[0];
        heap[0] = heap[size - 1];
        size--;

        heapify(0);

        return root.data;
    }

    // Xem phần tử có độ ưu tiên cao nhất mà không xóa
    public T peek() {
        if (isEmpty()) {
            throw new RuntimeException("Hàng đợi rỗng");
        }
        return heap[0].data;
    }

    // Sàng xuống từ vị trí i
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

Heap Sort là một thuật toán sắp xếp hiệu quả dựa trên cấu trúc heap.

```java
public class HeapSort {
    public void sort(int[] arr) {
        int n = arr.length;

        // Xây dựng heap (sắp xếp lại mảng)
        for (int i = n/2 - 1; i >= 0; i--) {
            heapify(arr, n, i);
        }

        // Trích xuất từng phần tử từ heap
        for (int i = n-1; i >= 0; i--) {
            // Di chuyển root hiện tại đến cuối
            int temp = arr[0];
            arr[0] = arr[i];
            arr[i] = temp;

            // Gọi heapify trên heap đã giảm kích thước
            heapify(arr, i, 0);
        }
    }

    // Để sàng xuống một subtree có root tại node i
    void heapify(int[] arr, int n, int i) {
        int largest = i; // Khởi tạo largest là root
        int left = 2*i + 1;
        int right = 2*i + 2;

        // Nếu con trái lớn hơn root
        if (left < n && arr[left] > arr[largest])
            largest = left;

        // Nếu con phải lớn hơn largest hiện tại
        if (right < n && arr[right] > arr[largest])
            largest = right;

        // Nếu largest không phải root
        if (largest != i) {
            int swap = arr[i];
            arr[i] = arr[largest];
            arr[largest] = swap;

            // Tiếp tục heapify subtree bị ảnh hưởng
            heapify(arr, n, largest);
        }
    }
}
```

### 5. Ứng dụng của Heap và Priority Queue

1. **Giải thuật Dijkstra**: Tìm đường đi ngắn nhất trong đồ thị.
2. **Giải thuật Prim**: Tìm cây khung nhỏ nhất trong đồ thị.
3. **Hệ thống quản lý tác vụ**: Xử lý tác vụ theo độ ưu tiên.
4. **Thuật toán nén Huffman**: Xây dựng cây Huffman sử dụng min-heap.
5. **Heap Sort**: Thuật toán sắp xếp với độ phức tạp O(n log n).
6. **Tìm k phần tử lớn nhất/nhỏ nhất**: Sử dụng min-heap hoặc max-heap.

### 6. Bài tập

#### Bài tập 1: Cài đặt thuật toán tìm k phần tử lớn nhất trong một mảng sử dụng min-heap

```java
public static int[] findKLargest(int[] nums, int k) {
    // Tạo min-heap với kích thước k
    PriorityQueue<Integer> minHeap = new PriorityQueue<>(k);

    // Thêm k phần tử đầu tiên vào heap
    for (int i = 0; i < k; i++) {
        minHeap.add(nums[i]);
    }

    // So sánh và thay thế các phần tử còn lại
    for (int i = k; i < nums.length; i++) {
        if (nums[i] > minHeap.peek()) {
            minHeap.poll(); // Loại bỏ phần tử nhỏ nhất
            minHeap.add(nums[i]); // Thêm phần tử mới
        }
    }

    // Chuyển kết quả từ heap sang mảng
    int[] result = new int[k];
    for (int i = k-1; i >= 0; i--) {
        result[i] = minHeap.poll();
    }

    return result;
}
```

#### Bài tập 2: Sử dụng priority queue để lập lịch CPU (xử lý các tiến trình theo độ ưu tiên)

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
        // Tạo priority queue dựa trên độ ưu tiên của tiến trình
        PriorityQueue<Process> queue = new PriorityQueue<>(
            (p1, p2) -> p2.priority - p1.priority
        );

        // Thêm tất cả tiến trình vào queue
        for (Process process : processes) {
            queue.add(process);
        }

        // Xử lý các tiến trình theo thứ tự độ ưu tiên
        System.out.println("Lịch CPU:");
        while (!queue.isEmpty()) {
            Process process = queue.poll();
            System.out.println("Xử lý tiến trình: " + process.name +
                              " (Độ ưu tiên: " + process.priority +
                              ", Thời gian xử lý: " + process.burstTime + ")");
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

### 7. Phân tích hiệu năng

| Thao tác             | Thời gian trung bình | Thời gian xấu nhất |
| -------------------- | -------------------- | ------------------ |
| Chèn                 | O(1)                 | O(log n)           |
| Xóa tối đa/tối thiểu | O(log n)             | O(log n)           |
| Xây dựng heap        | O(n)                 | O(n)               |
| Tăng/giảm khóa       | O(log n)             | O(log n)           |
| Tìm tối đa/tối thiểu | O(1)                 | O(1)               |
| Xóa                  | O(log n)             | O(log n)           |

Heap là cấu trúc dữ liệu tuyệt vời cho các bài toán cần truy xuất phần tử lớn nhất/nhỏ nhất nhanh chóng và cần thay đổi tập dữ liệu thường xuyên.

## 🧑‍🏫 Bài 4: Trie và ứng dụng

### Cấu trúc dữ liệu Trie

Trie (hay cây tiền tố) là một cấu trúc dữ liệu dạng cây được dùng để lưu trữ và tìm kiếm các chuỗi ký tự một cách hiệu quả.

#### Đặc điểm của Trie

- Mỗi nút trong trie có thể lưu trữ nhiều con trỏ đến các nút con (thường là 26 con trỏ cho các chữ cái tiếng Anh)
- Đường đi từ gốc đến một nút biểu diễn một tiền tố (prefix)
- Các nút lá hoặc nút được đánh dấu đặc biệt biểu diễn một từ/chuỗi hoàn chỉnh
- Tất cả các nút con của một nút đều có tiền tố chung

#### Cấu trúc nút của Trie

```java
class TrieNode {
    boolean isEndOfWord; // Đánh dấu kết thúc của một từ
    TrieNode[] children; // Các nút con, thường là 26 cho 'a' đến 'z'

    public TrieNode() {
        isEndOfWord = false;
        children = new TrieNode[26]; // Cho 26 chữ cái tiếng Anh
        for (int i = 0; i < 26; i++)
            children[i] = null;
    }
}
```

### Cài đặt cơ bản của Trie

```java
public class Trie {
    private TrieNode root;

    public Trie() {
        root = new TrieNode();
    }

    // Chèn một từ vào trie
    public void insert(String word) {
        TrieNode current = root;

        for (int i = 0; i < word.length(); i++) {
            int index = word.charAt(i) - 'a';
            if (current.children[index] == null)
                current.children[index] = new TrieNode();

            current = current.children[index];
        }

        // Đánh dấu nút cuối cùng là kết thúc của từ
        current.isEndOfWord = true;
    }

    // Tìm kiếm một từ trong trie
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

    // Kiểm tra xem có từ nào bắt đầu bằng tiền tố prefix không
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

    // Xóa một từ khỏi trie
    public void delete(String word) {
        delete(root, word, 0);
    }

    private boolean delete(TrieNode current, String word, int index) {
        if (index == word.length()) {
            // Nếu từ không tồn tại
            if (!current.isEndOfWord) {
                return false;
            }

            // Đánh dấu từ đã bị xóa
            current.isEndOfWord = false;

            // Trả về true nếu nút không có con nào
            return hasNoChildren(current);
        }

        int charIndex = word.charAt(index) - 'a';
        TrieNode child = current.children[charIndex];

        if (child == null) {
            return false; // Từ không tồn tại
        }

        boolean shouldDeleteChild = delete(child, word, index + 1);

        // Nếu cần xóa nút con và nút con không phải kết thúc của từ khác
        if (shouldDeleteChild) {
            current.children[charIndex] = null;

            // Trả về true nếu nút hiện tại không có từ nào kết thúc tại đó
            // và không có con nào
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

### Ứng dụng của Trie

#### Tự động hoàn thành (Autocomplete)

```java
// Cài đặt tính năng tự động hoàn thành
public List<String> autocomplete(String prefix) {
    List<String> result = new ArrayList<>();
    TrieNode current = root;

    // Duyệt đến nút cuối của tiền tố
    for (int i = 0; i < prefix.length(); i++) {
        int index = prefix.charAt(i) - 'a';
        if (current.children[index] == null)
            return result; // Không có từ nào bắt đầu bằng tiền tố này

        current = current.children[index];
    }

    // Tìm tất cả các từ bắt đầu bằng tiền tố
    findAllWords(current, prefix, result);

    return result;
}

private void findAllWords(TrieNode node, String prefix, List<String> result) {
    // Nếu nút hiện tại là kết thúc của một từ, thêm từ vào kết quả
    if (node.isEndOfWord) {
        result.add(prefix);
    }

    // Duyệt qua tất cả các con
    for (int i = 0; i < 26; i++) {
        if (node.children[i] != null) {
            char ch = (char) (i + 'a');
            findAllWords(node.children[i], prefix + ch, result);
        }
    }
}
```

#### Kiểm tra tiền tố (Prefix checking)

```java
// Kiểm tra xem một từ có phải là tiền tố của bất kỳ từ nào trong từ điển
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

#### Tìm kiếm từ trong ma trận (Word Search)

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
    // Nếu đã tìm thấy tất cả các ký tự
    if (index == word.length())
        return true;

    // Kiểm tra biên và ký tự
    if (i < 0 || i >= board.length || j < 0 || j >= board[0].length ||
        board[i][j] != word.charAt(index) || visited[i][j])
        return false;

    // Đánh dấu ô đã thăm
    visited[i][j] = true;

    // Kiểm tra 4 hướng
    boolean result = search(board, word, i+1, j, index+1, visited) ||
                     search(board, word, i-1, j, index+1, visited) ||
                     search(board, word, i, j+1, index+1, visited) ||
                     search(board, word, i, j-1, index+1, visited);

    // Bỏ đánh dấu
    visited[i][j] = false;

    return result;
}
```

#### Từ điển (Dictionary)

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

### Trie với bảng băm (Hash Trie)

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

### Trie nén (Compressed Trie)

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
        // Nếu từ rỗng, đánh dấu nút hiện tại là kết thúc từ
        if (word.isEmpty()) {
            node.isEndOfWord = true;
            return;
        }

        char firstChar = word.charAt(0);
        CompressedTrieNode child = node.children.get(firstChar);

        // Nếu không có nút con bắt đầu bằng ký tự này
        if (child == null) {
            child = new CompressedTrieNode(word);
            node.children.put(firstChar, child);
            child.isEndOfWord = true;
            return;
        }

        // Tìm điểm khác nhau đầu tiên giữa từ mới và tiền tố của nút con
        int i = 0;
        String childPrefix = child.prefix;
        while (i < word.length() && i < childPrefix.length() && word.charAt(i) == childPrefix.charAt(i)) {
            i++;
        }

        // Nếu từ mới là tiền tố của nút con
        if (i == word.length()) {
            // Tách nút con
            CompressedTrieNode newChild = new CompressedTrieNode(childPrefix.substring(i));
            newChild.children = child.children;
            newChild.isEndOfWord = child.isEndOfWord;

            // Cập nhật nút con cũ
            child.prefix = word;
            child.children = new HashMap<>();
            child.children.put(childPrefix.charAt(i), newChild);
            child.isEndOfWord = true;
        }
        // Nếu nút con là tiền tố của từ mới
        else if (i == childPrefix.length()) {
            insert(child, word.substring(i));
        }
        // Nếu từ mới và nút con có tiền tố chung
        else {
            // Tạo nút tiền tố chung
            CompressedTrieNode commonPrefixNode = new CompressedTrieNode(word.substring(0, i));
            node.children.put(firstChar, commonPrefixNode);

            // Tạo nút cho phần còn lại của từ mới
            CompressedTrieNode newWordNode = new CompressedTrieNode(word.substring(i));
            newWordNode.isEndOfWord = true;

            // Tạo nút cho phần còn lại của tiền tố nút con
            CompressedTrieNode remainingPrefixNode = new CompressedTrieNode(childPrefix.substring(i));
            remainingPrefixNode.children = child.children;
            remainingPrefixNode.isEndOfWord = child.isEndOfWord;

            // Liên kết các nút
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

        // Nếu từ không bắt đầu bằng tiền tố của nút con
        if (!word.startsWith(childPrefix))
            return false;

        // Nếu từ là tiền tố của nút con
        if (word.equals(childPrefix))
            return child.isEndOfWord;

        // Kiểm tra phần còn lại của từ
        return search(child, word.substring(childPrefix.length()));
    }
}
```

### Phân tích hiệu năng của Trie

| Thao tác           | Thời gian | Không gian |
| ------------------ | --------- | ---------- |
| Chèn               | O(m)      | O(m)       |
| Tìm kiếm           | O(m)      | O(1)       |
| Xóa                | O(m)      | O(1)       |
| Tiền tố            | O(p)      | O(1)       |
| Hoàn thành tự động | O(n)      | O(n)       |

Trong đó:

- m là độ dài từ cần chèn/tìm kiếm/xóa
- p là độ dài tiền tố
- n là số từ trong Trie

### So sánh với các cấu trúc dữ liệu khác

| Cấu trúc dữ liệu   | Ưu điểm                     | Nhược điểm                        |
| ------------------ | --------------------------- | --------------------------------- |
| Trie               | - Tìm kiếm nhanh O(m)       | - Tốn nhiều bộ nhớ                |
|                    | - Tìm tiền tố hiệu quả      | - Cài đặt phức tạp hơn            |
|                    | - Hỗ trợ tự động hoàn thành |                                   |
| Hash Table         | - Tìm kiếm nhanh O(1)       | - Không hỗ trợ tìm tiền tố        |
|                    | - Ít tốn bộ nhớ hơn         | - Không hỗ trợ tự động hoàn thành |
| Binary Search Tree | - Cân bằng tốt về bộ nhớ    | - Tìm kiếm chậm hơn O(log n)      |
|                    | - Dễ cài đặt                | - Không hiệu quả cho tìm tiền tố  |

### Bài tập

#### Bài tập 1: Đếm số từ có tiền tố chung

```java
public int countWordsWithPrefix(String prefix) {
    TrieNode current = root;

    // Duyệt đến nút cuối của tiền tố
    for (int i = 0; i < prefix.length(); i++) {
        int index = prefix.charAt(i) - 'a';
        if (current.children[index] == null)
            return 0;

        current = current.children[index];
    }

    // Đếm tất cả các từ bắt đầu từ nút này
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

#### Bài tập 2: Tìm từ dài nhất có tất cả tiền tố trong từ điển

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

            // Chỉ xem xét từ có tất cả tiền tố trong từ điển
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

#### Bài tập 3: Xây dựng trò chơi tìm từ (Word Boggle)

```java
public List<String> findWords(char[][] board, String[] words) {
    List<String> result = new ArrayList<>();
    Trie trie = new Trie();

    // Thêm tất cả các từ vào trie
    for (String word : words)
        trie.insert(word);

    int m = board.length;
    int n = board[0].length;
    boolean[][] visited = new boolean[m][n];
    Set<String> foundWords = new HashSet<>();

    // Duyệt qua tất cả các ô trên bảng
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
    // Kiểm tra biên
    if (i < 0 || i >= board.length || j < 0 || j >= board[0].length || visited[i][j])
        return;

    char ch = board[i][j];
    int index = ch - 'a';

    // Nếu không có nút con cho ký tự này
    if (node.children[index] == null)
        return;

    // Cập nhật tiền tố và nút
    prefix += ch;
    node = node.children[index];

    // Nếu đây là một từ hoàn chỉnh, thêm vào kết quả
    if (node.isEndOfWord)
        result.add(prefix);

    // Đánh dấu ô hiện tại đã thăm
    visited[i][j] = true;

    // Duyệt 8 hướng
    int[] dx = {-1, -1, -1, 0, 0, 1, 1, 1};
    int[] dy = {-1, 0, 1, -1, 1, -1, 0, 1};

    for (int k = 0; k < 8; k++) {
        findWordsUtil(board, i + dx[k], j + dy[k], node, prefix, visited, result);
    }

    // Bỏ đánh dấu ô hiện tại
    visited[i][j] = false;
}
```

## 🧑‍🏫 Bài 5: Segment Tree và Fenwick Tree

### Segment Tree

Segment Tree (Cây phân đoạn) là một cấu trúc dữ liệu được sử dụng để giải quyết các bài toán truy vấn khoảng và cập nhật các phần tử trong mảng một cách hiệu quả.

#### Tính chất của Segment Tree

- Nút gốc đại diện cho toàn bộ mảng
- Mỗi nút lá đại diện cho một phần tử đơn lẻ
- Mỗi nút nội bộ có hai nút con, đại diện cho hai nửa đoạn của nút cha

#### Cài đặt Segment Tree

```java
public class SegmentTree {
    int[] tree;
    int n; // Kích thước mảng ban đầu

    // Xây dựng segment tree từ mảng đầu vào
    public SegmentTree(int[] arr) {
        n = arr.length;
        // Chiều cao của cây = ceil(log2(n))
        int height = (int) Math.ceil(Math.log(n) / Math.log(2));
        // Số nút tối đa = 2*2^h - 1
        int maxSize = 2 * (int) Math.pow(2, height) - 1;

        tree = new int[maxSize];
        buildSegmentTree(arr, 0, n - 1, 0);
    }

    // Hàm xây dựng segment tree
    private int buildSegmentTree(int[] arr, int start, int end, int index) {
        // Nếu là nút lá (start == end)
        if (start == end) {
            tree[index] = arr[start];
            return tree[index];
        }

        int mid = start + (end - start) / 2;

        // Xây dựng cây con trái và phải
        int leftSum = buildSegmentTree(arr, start, mid, 2 * index + 1);
        int rightSum = buildSegmentTree(arr, mid + 1, end, 2 * index + 2);

        // Tổng của đoạn hiện tại là tổng của hai đoạn con
        tree[index] = leftSum + rightSum;

        return tree[index];
    }

    // Truy vấn tổng trong đoạn [qStart, qEnd]
    public int getSum(int qStart, int qEnd) {
        if (qStart < 0 || qEnd >= n || qStart > qEnd) {
            System.out.println("Truy vấn không hợp lệ");
            return -1;
        }

        return getSumUtil(0, n - 1, qStart, qEnd, 0);
    }

    private int getSumUtil(int start, int end, int qStart, int qEnd, int index) {
        // Nếu đoạn hiện tại nằm hoàn toàn trong đoạn truy vấn
        if (qStart <= start && qEnd >= end)
            return tree[index];

        // Nếu đoạn hiện tại nằm hoàn toàn ngoài đoạn truy vấn
        if (end < qStart || start > qEnd)
            return 0;

        // Nếu đoạn hiện tại và đoạn truy vấn giao nhau
        int mid = start + (end - start) / 2;

        int leftSum = getSumUtil(start, mid, qStart, qEnd, 2 * index + 1);
        int rightSum = getSumUtil(mid + 1, end, qStart, qEnd, 2 * index + 2);

        return leftSum + rightSum;
    }

    // Cập nhật giá trị của phần tử
    public void update(int pos, int newValue) {
        if (pos < 0 || pos >= n) {
            System.out.println("Vị trí không hợp lệ");
            return;
        }

        // Tính toán sự chênh lệch
        int diff = newValue - getSum(pos, pos);

        // Cập nhật segment tree
        updateUtil(0, n - 1, pos, diff, 0);
    }

    private void updateUtil(int start, int end, int pos, int diff, int index) {
        // Nếu vị trí cần cập nhật không nằm trong đoạn hiện tại
        if (pos < start || pos > end)
            return;

        // Cập nhật giá trị của nút hiện tại
        tree[index] += diff;

        // Nếu không phải nút lá, cập nhật các nút con
        if (start != end) {
            int mid = start + (end - start) / 2;

            updateUtil(start, mid, pos, diff, 2 * index + 1);
            updateUtil(mid + 1, end, pos, diff, 2 * index + 2);
        }
    }

    // Cập nhật giá trị trong đoạn [uStart, uEnd]
    public void updateRange(int uStart, int uEnd, int diff) {
        if (uStart < 0 || uEnd >= n || uStart > uEnd) {
            System.out.println("Truy vấn không hợp lệ");
            return;
        }

        updateRangeUtil(0, n - 1, uStart, uEnd, diff, 0);
    }

    private void updateRangeUtil(int start, int end, int uStart, int uEnd, int diff, int index) {
        // Nếu đoạn hiện tại nằm ngoài đoạn cập nhật
        if (end < uStart || start > uEnd)
            return;

        // Nếu nút lá
        if (start == end) {
            tree[index] += diff;
            return;
        }

        // Cập nhật cây con
        int mid = start + (end - start) / 2;

        updateRangeUtil(start, mid, uStart, uEnd, diff, 2 * index + 1);
        updateRangeUtil(mid + 1, end, uStart, uEnd, diff, 2 * index + 2);

        // Cập nhật nút cha sau khi cập nhật các nút con
        tree[index] = tree[2 * index + 1] + tree[2 * index + 2];
    }

    // Tìm giá trị nhỏ nhất trong đoạn [qStart, qEnd]
    public int getMin(int qStart, int qEnd) {
        if (qStart < 0 || qEnd >= n || qStart > qEnd) {
            System.out.println("Truy vấn không hợp lệ");
            return Integer.MAX_VALUE;
        }

        return getMinUtil(0, n - 1, qStart, qEnd, 0);
    }

    private int getMinUtil(int start, int end, int qStart, int qEnd, int index) {
        // Nếu đoạn hiện tại nằm hoàn toàn trong đoạn truy vấn
        if (qStart <= start && qEnd >= end)
            return tree[index];

        // Nếu đoạn hiện tại nằm hoàn toàn ngoài đoạn truy vấn
        if (end < qStart || start > qEnd)
            return Integer.MAX_VALUE;

        // Nếu đoạn hiện tại và đoạn truy vấn giao nhau
        int mid = start + (end - start) / 2;

        int leftMin = getMinUtil(start, mid, qStart, qEnd, 2 * index + 1);
        int rightMin = getMinUtil(mid + 1, end, qStart, qEnd, 2 * index + 2);

        return Math.min(leftMin, rightMin);
    }
}
```

### Lazy Propagation trong Segment Tree

Lazy Propagation là một kỹ thuật tối ưu cho Segment Tree khi có nhiều thao tác cập nhật trên đoạn.

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
        lazy = new int[maxSize]; // Mảng lazy để trì hoãn cập nhật

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

    // Truy vấn tổng với lazy propagation
    public int getSum(int qStart, int qEnd) {
        if (qStart < 0 || qEnd >= n || qStart > qEnd) {
            return -1;
        }

        return getSumUtil(0, n - 1, qStart, qEnd, 0);
    }

    private int getSumUtil(int start, int end, int qStart, int qEnd, int index) {
        // Lan truyền lazy cập nhật trước khi truy vấn
        if (lazy[index] != 0) {
            tree[index] += (end - start + 1) * lazy[index]; // Cập nhật nút hiện tại

            if (start != end) { // Nếu không phải nút lá
                lazy[2 * index + 1] += lazy[index]; // Lan truyền xuống con trái
                lazy[2 * index + 2] += lazy[index]; // Lan truyền xuống con phải
            }

            lazy[index] = 0; // Đã lan truyền xong
        }

        // Nếu đoạn hiện tại nằm hoàn toàn ngoài đoạn truy vấn
        if (end < qStart || start > qEnd)
            return 0;

        // Nếu đoạn hiện tại nằm hoàn toàn trong đoạn truy vấn
        if (qStart <= start && qEnd >= end)
            return tree[index];

        // Nếu đoạn hiện tại và đoạn truy vấn giao nhau
        int mid = start + (end - start) / 2;

        int leftSum = getSumUtil(start, mid, qStart, qEnd, 2 * index + 1);
        int rightSum = getSumUtil(mid + 1, end, qStart, qEnd, 2 * index + 2);

        return leftSum + rightSum;
    }

    // Cập nhật đoạn với lazy propagation
    public void updateRange(int uStart, int uEnd, int diff) {
        if (uStart < 0 || uEnd >= n || uStart > uEnd) {
            System.out.println("Truy vấn không hợp lệ");
            return;
        }

        updateRangeUtil(0, n - 1, uStart, uEnd, diff, 0);
    }

    private void updateRangeUtil(int start, int end, int uStart, int uEnd, int diff, int index) {
        // Lan truyền lazy cập nhật trước khi cập nhật
        if (lazy[index] != 0) {
            tree[index] += (end - start + 1) * lazy[index];

            if (start != end) {
                lazy[2 * index + 1] += lazy[index];
                lazy[2 * index + 2] += lazy[index];
            }

            lazy[index] = 0;
        }

        // Nếu đoạn hiện tại nằm ngoài đoạn cập nhật
        if (end < uStart || start > uEnd)
            return;

        // Nếu đoạn hiện tại nằm hoàn toàn trong đoạn cập nhật
        if (uStart <= start && uEnd >= end) {
            tree[index] += (end - start + 1) * diff;

            if (start != end) {
                lazy[2 * index + 1] += diff;
                lazy[2 * index + 2] += diff;
            }

            return;
        }

        // Nếu đoạn hiện tại và đoạn cập nhật giao nhau
        int mid = start + (end - start) / 2;

        updateRangeUtil(start, mid, uStart, uEnd, diff, 2 * index + 1);
        updateRangeUtil(mid + 1, end, uStart, uEnd, diff, 2 * index + 2);

        tree[index] = tree[2 * index + 1] + tree[2 * index + 2];
    }
}
```

### Fenwick Tree (Binary Indexed Tree)

Fenwick Tree hoặc Binary Indexed Tree là một cấu trúc dữ liệu hiệu quả cho các thao tác cập nhật và truy vấn tổng tiền tố.

#### Tính chất của Fenwick Tree

- Sử dụng bit cuối cùng (LSB - Least Significant Bit) của chỉ số để xác định phạm vi phụ trách của mỗi nút
- Thao tác cập nhật và truy vấn có độ phức tạp O(log n)
- Chiếm ít bộ nhớ hơn Segment Tree

#### Cài đặt Fenwick Tree

```java
public class FenwickTree {
    private int[] bit; // Binary Indexed Tree
    private int n;

    public FenwickTree(int n) {
        this.n = n;
        bit = new int[n + 1]; // Chỉ số bắt đầu từ 1
    }

    // Xây dựng BIT từ mảng đầu vào
    public FenwickTree(int[] arr) {
        this.n = arr.length;
        bit = new int[n + 1];

        for (int i = 0; i < n; i++) {
            update(i, arr[i]);
        }
    }

    // Cập nhật giá trị: thêm val vào index
    public void update(int index, int val) {
        index++; // Chuyển sang chỉ số 1-based

        while (index <= n) {
            bit[index] += val;
            index += index & -index; // Cộng với bit cuối cùng là 1
        }
    }

    // Truy vấn tổng tiền tố: tính tổng từ arr[0] đến arr[index]
    public int getSum(int index) {
        int sum = 0;
        index++; // Chuyển sang chỉ số 1-based

        while (index > 0) {
            sum += bit[index];
            index -= index & -index; // Trừ đi bit cuối cùng là 1
        }

        return sum;
    }

    // Truy vấn tổng trong đoạn [left, right]
    public int getSumRange(int left, int right) {
        return getSum(right) - getSum(left - 1);
    }

    // Lấy giá trị tại vị trí index
    public int getValue(int index) {
        return getSumRange(index, index);
    }

    // Tìm chỉ số đầu tiên sao cho tổng tiền tố >= sum
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

### Fenwick Tree 2D

Mở rộng Fenwick Tree để hỗ trợ truy vấn và cập nhật trên ma trận 2D:

```java
public class FenwickTree2D {
    private int[][] bit;
    private int n, m; // Kích thước ma trận

    public FenwickTree2D(int n, int m) {
        this.n = n;
        this.m = m;
        bit = new int[n + 1][m + 1]; // Chỉ số bắt đầu từ 1
    }

    // Cập nhật giá trị tại vị trí (x, y)
    public void update(int x, int y, int val) {
        x++; y++; // Chuyển sang chỉ số 1-based

        for (int i = x; i <= n; i += i & -i) {
            for (int j = y; j <= m; j += j & -j) {
                bit[i][j] += val;
            }
        }
    }

    // Truy vấn tổng từ (0,0) đến (x,y)
    public int getSum(int x, int y) {
        x++; y++; // Chuyển sang chỉ số 1-based
        int sum = 0;

        for (int i = x; i > 0; i -= i & -i) {
            for (int j = y; j > 0; j -= j & -j) {
                sum += bit[i][j];
            }
        }

        return sum;
    }

    // Truy vấn tổng trong hình chữ nhật [(x1,y1), (x2,y2)]
    public int getSumRange(int x1, int y1, int x2, int y2) {
        return getSum(x2, y2) - getSum(x2, y1 - 1) - getSum(x1 - 1, y2) + getSum(x1 - 1, y1 - 1);
    }
}
```

### So sánh Segment Tree và Fenwick Tree

| Tiêu chí             | Segment Tree              | Fenwick Tree          |
| -------------------- | ------------------------- | --------------------- |
| Độ phức tạp truy vấn | O(log n)                  | O(log n)              |
| Độ phức tạp cập nhật | O(log n)                  | O(log n)              |
| Không gian bộ nhớ    | O(n) (2n-1 nút)           | O(n) (n nút)          |
| Triển khai           | Phức tạp hơn              | Đơn giản hơn          |
| Hỗ trợ truy vấn      | Min, Max, Sum, GCD, ...   | Chủ yếu là Sum        |
| Hỗ trợ cập nhật đoạn | Có (với lazy propagation) | Không trực tiếp       |
| Ứng dụng             | Đa dạng các loại truy vấn | Truy vấn tổng tiền tố |

### Ứng dụng của Segment Tree và Fenwick Tree

1. **Truy vấn tổng đoạn (Range Sum Query)**: Tính tổng của các phần tử trong một đoạn.
2. **Truy vấn giá trị nhỏ nhất/lớn nhất đoạn (Range Min/Max Query)**.
3. **Truy vấn GCD/LCM đoạn**: Tìm ước chung lớn nhất hoặc bội chung nhỏ nhất của các phần tử trong đoạn.
4. **Truy vấn đếm (Range Count Query)**: Đếm số phần tử thỏa mãn một điều kiện trong đoạn.
5. **Cấu trúc dữ liệu trong cơ sở dữ liệu**: Để tối ưu các truy vấn tổng hợp dữ liệu.
6. **Các bài toán hình học tính toán**: Như đếm số điểm nằm trong một hình chữ nhật.

### Bài luyện tập

#### Bài tập 1: Truy vấn tổng đoạn và cập nhật phần tử

```java
public static void main(String[] args) {
    int[] arr = {1, 3, 5, 7, 9, 11};
    SegmentTree segTree = new SegmentTree(arr);

    // Truy vấn tổng đoạn [1, 3]
    System.out.println("Tổng đoạn [1, 3]: " + segTree.getSum(1, 3)); // Kết quả: 15

    // Cập nhật phần tử arr[1] thành 10
    segTree.update(1, 10);

    // Truy vấn lại tổng đoạn [1, 3]
    System.out.println("Tổng đoạn [1, 3] sau cập nhật: " + segTree.getSum(1, 3)); // Kết quả: 22
}
```

#### Bài tập 2: Truy vấn giá trị nhỏ nhất đoạn

```java
// Segment Tree cho truy vấn nhỏ nhất
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

// Sử dụng:
int[] arr = {5, 2, 8, 1, 9, 3};
MinSegmentTree minTree = new MinSegmentTree(arr);
System.out.println("Giá trị nhỏ nhất trong đoạn [1, 4]: " + minTree.getMin(1, 4)); // Kết quả: 1
```

#### Bài tập 3: Đếm số phần tử lớn hơn hoặc bằng k trong đoạn [l, r]

```java
// Xây dựng Segment Tree đặc biệt
class CountSegmentTree {
    class Node {
        int count; // Số phần tử trong đoạn
        int[] frequency; // Tần suất của các giá trị (giả sử giá trị từ 0-100)

        public Node() {
            count = 0;
            frequency = new int[101]; // Giả sử giá trị từ 0-100
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

        // Cộng tần suất từ các nút con
        for (int i = 0; i <= 100; i++) {
            tree[index].frequency[i] = tree[2 * index + 1].frequency[i] + tree[2 * index + 2].frequency[i];
        }
    }

    // Đếm số phần tử >= k trong đoạn [qStart, qEnd]
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

## 🧑‍💻 Bài tập lớn: Xây dựng hệ thống tìm kiếm văn bản đơn giản

### Mô tả bài toán

Xây dựng một hệ thống tìm kiếm văn bản đơn giản có thể:

1. Lập chỉ mục cho một tập văn bản (indexing)
2. Tìm kiếm các tài liệu chứa từ khóa (keyword search)
3. Tìm kiếm các tài liệu chứa nhiều từ khóa theo độ phù hợp (ranking)
4. Gợi ý từ khóa khi người dùng nhập (autocomplete)

### Các thành phần cần triển khai

1. **Document Manager**: Quản lý và lưu trữ các tài liệu
2. **Tokenizer**: Phân tách văn bản thành các từ
3. **Inverted Index**: Cấu trúc dữ liệu lưu trữ ánh xạ từ từ khóa đến các tài liệu
4. **Trie**: Hỗ trợ chức năng gợi ý từ khóa
5. **Search Engine**: Xử lý truy vấn và xếp hạng kết quả

### Các tính năng mở rộng có thể thêm vào

1. **Stemming**: Chuyển đổi các từ về dạng gốc (ví dụ: "running" -> "run")
2. **Phrase Search**: Tìm kiếm cụm từ chính xác, không chỉ là các từ riêng lẻ
3. **Boolean Search**: Hỗ trợ các toán tử logic như AND, OR, NOT
4. **Fuzzy Search**: Tìm kiếm các từ gần giống với từ khóa
5. **Highlighting**: Đánh dấu các từ khóa trong kết quả tìm kiếm
6. **Pagination**: Phân trang kết quả tìm kiếm
7. **Filtering**: Lọc kết quả theo các tiêu chí khác nhau
