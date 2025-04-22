# 📘 PHẦN 5: THUẬT TOÁN ỨNG DỤNG VÀ TỐI ƯU HÓA

- [📘 PHẦN 5: THUẬT TOÁN ỨNG DỤNG VÀ TỐI ƯU HÓA](#-phần-5-thuật-toán-ứng-dụng-và-tối-ưu-hóa)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Thuật toán xử lý chuỗi](#-bài-1-thuật-toán-xử-lý-chuỗi)
    - [1. Tìm kiếm chuỗi con (String Matching)](#1-tìm-kiếm-chuỗi-con-string-matching)
      - [a. Thuật toán Brute Force](#a-thuật-toán-brute-force)
      - [b. Thuật toán Knuth-Morris-Pratt (KMP)](#b-thuật-toán-knuth-morris-pratt-kmp)
      - [c. Thuật toán Boyer-Moore](#c-thuật-toán-boyer-moore)
      - [d. Thuật toán Rabin-Karp](#d-thuật-toán-rabin-karp)
    - [2. Xử lý chuỗi nâng cao](#2-xử-lý-chuỗi-nâng-cao)
      - [a. Thuật toán Z](#a-thuật-toán-z)
      - [b. Thuật toán Manacher (tìm chuỗi đối xứng)](#b-thuật-toán-manacher-tìm-chuỗi-đối-xứng)
      - [c. Thuật toán Suffix Array và LCP Array](#c-thuật-toán-suffix-array-và-lcp-array)
    - [3. Ứng dụng của thuật toán xử lý chuỗi](#3-ứng-dụng-của-thuật-toán-xử-lý-chuỗi)
      - [a. Tìm kiếm mẫu trong văn bản và DNA](#a-tìm-kiếm-mẫu-trong-văn-bản-và-dna)
      - [b. Tìm chuỗi con chung dài nhất (Longest Common Substring)](#b-tìm-chuỗi-con-chung-dài-nhất-longest-common-substring)
      - [c. Tìm chuỗi con chung dài nhất cho nhiều chuỗi](#c-tìm-chuỗi-con-chung-dài-nhất-cho-nhiều-chuỗi)
      - [d. Nén chuỗi (Run-Length Encoding)](#d-nén-chuỗi-run-length-encoding)
    - [4. So sánh các thuật toán tìm kiếm chuỗi](#4-so-sánh-các-thuật-toán-tìm-kiếm-chuỗi)
  - [🧑‍🏫 Bài 2: Kỹ thuật hai con trỏ và cửa sổ trượt](#-bài-2-kỹ-thuật-hai-con-trỏ-và-cửa-sổ-trượt)
    - [1. Kỹ thuật hai con trỏ (Two Pointers)](#1-kỹ-thuật-hai-con-trỏ-two-pointers)
      - [a. Hai con trỏ cùng hướng (Same Direction)](#a-hai-con-trỏ-cùng-hướng-same-direction)
        - [**Ví dụ 1: Xóa các phần tử trùng lặp trong mảng đã sắp xếp**](#ví-dụ-1-xóa-các-phần-tử-trùng-lặp-trong-mảng-đã-sắp-xếp)
        - [**Ví dụ 2: Tìm phần tử không bằng 0 trong mảng**](#ví-dụ-2-tìm-phần-tử-không-bằng-0-trong-mảng)
      - [b. Hai con trỏ ngược hướng (Opposite Direction)](#b-hai-con-trỏ-ngược-hướng-opposite-direction)
        - [**Ví dụ 1: Đảo ngược mảng**](#ví-dụ-1-đảo-ngược-mảng)
        - [**Ví dụ 2: Tìm cặp số có tổng bằng một giá trị cho trước (trong mảng đã sắp xếp)**](#ví-dụ-2-tìm-cặp-số-có-tổng-bằng-một-giá-trị-cho-trước-trong-mảng-đã-sắp-xếp)
        - [**Ví dụ 3: Kiểm tra chuỗi palindrome**](#ví-dụ-3-kiểm-tra-chuỗi-palindrome)
      - [c. Hai con trỏ trên hai mảng](#c-hai-con-trỏ-trên-hai-mảng)
        - [**Ví dụ: Hợp nhất hai mảng đã sắp xếp**](#ví-dụ-hợp-nhất-hai-mảng-đã-sắp-xếp)
    - [2. Kỹ thuật cửa sổ trượt (Sliding Window)](#2-kỹ-thuật-cửa-sổ-trượt-sliding-window)
      - [a. Cửa sổ cố định (Fixed Size Window)](#a-cửa-sổ-cố-định-fixed-size-window)
        - [**Ví dụ 1: Tìm tổng lớn nhất của cửa sổ kích thước k**](#ví-dụ-1-tìm-tổng-lớn-nhất-của-cửa-sổ-kích-thước-k)
        - [**Ví dụ 2: Tìm giá trị trung bình của tất cả các cửa sổ kích thước k**](#ví-dụ-2-tìm-giá-trị-trung-bình-của-tất-cả-các-cửa-sổ-kích-thước-k)
      - [b. Cửa sổ thay đổi kích thước (Variable Size Window)](#b-cửa-sổ-thay-đổi-kích-thước-variable-size-window)
        - [**Ví dụ 1: Tìm dãy con ngắn nhất có tổng \>= S**](#ví-dụ-1-tìm-dãy-con-ngắn-nhất-có-tổng--s)
        - [**Ví dụ 2: Chuỗi con dài nhất không có ký tự lặp lại**](#ví-dụ-2-chuỗi-con-dài-nhất-không-có-ký-tự-lặp-lại)
        - [**Ví dụ 3: Chuỗi con dài nhất với không quá k ký tự khác nhau**](#ví-dụ-3-chuỗi-con-dài-nhất-với-không-quá-k-ký-tự-khác-nhau)
    - [3. Ứng dụng và bài toán thực tế](#3-ứng-dụng-và-bài-toán-thực-tế)
      - [a. Tìm tập con có tổng bằng một giá trị cho trước](#a-tìm-tập-con-có-tổng-bằng-một-giá-trị-cho-trước)
      - [b. Tìm ba số có tổng bằng 0](#b-tìm-ba-số-có-tổng-bằng-0)
      - [c. Tìm tất cả các anagram trong chuỗi](#c-tìm-tất-cả-các-anagram-trong-chuỗi)
    - [4. So sánh hai kỹ thuật](#4-so-sánh-hai-kỹ-thuật)
  - [🧑‍🏫 Bài 3: Thuật toán chia để trị](#-bài-3-thuật-toán-chia-để-trị)
    - [1. Nguyên lý chia để trị](#1-nguyên-lý-chia-để-trị)
      - [Cấu trúc chung của thuật toán chia để trị](#cấu-trúc-chung-của-thuật-toán-chia-để-trị)
    - [2. Các thuật toán chia để trị cơ bản](#2-các-thuật-toán-chia-để-trị-cơ-bản)
      - [a. Merge Sort](#a-merge-sort)
      - [b. Quick Sort](#b-quick-sort)
      - [c. Binary Search](#c-binary-search)
    - [3. Thuật toán chia để trị nâng cao](#3-thuật-toán-chia-để-trị-nâng-cao)
      - [a. Bài toán tìm số đa số (Majority Element)](#a-bài-toán-tìm-số-đa-số-majority-element)
      - [b. Bài toán tìm cặp điểm gần nhất (Closest Pair of Points)](#b-bài-toán-tìm-cặp-điểm-gần-nhất-closest-pair-of-points)
      - [c. Thuật toán Strassen nhân ma trận](#c-thuật-toán-strassen-nhân-ma-trận)
  - [🧑‍🏫 Bài 4: Tìm kiếm theo không gian trạng thái](#-bài-4-tìm-kiếm-theo-không-gian-trạng-thái)
    - [1. Giới thiệu về không gian trạng thái](#1-giới-thiệu-về-không-gian-trạng-thái)
    - [2. Tìm kiếm không thông báo (Uninformed Search)](#2-tìm-kiếm-không-thông-báo-uninformed-search)
      - [a. Tìm kiếm theo chiều rộng (BFS)](#a-tìm-kiếm-theo-chiều-rộng-bfs)
      - [b. Tìm kiếm theo chiều sâu (DFS)](#b-tìm-kiếm-theo-chiều-sâu-dfs)
      - [c. Tìm kiếm theo chiều sâu có giới hạn (Depth-Limited Search)](#c-tìm-kiếm-theo-chiều-sâu-có-giới-hạn-depth-limited-search)
      - [d. Tìm kiếm theo chiều sâu lặp (Iterative Deepening DFS)](#d-tìm-kiếm-theo-chiều-sâu-lặp-iterative-deepening-dfs)
    - [3. Các thuật toán tìm kiếm được thông báo (Informed Search)](#3-các-thuật-toán-tìm-kiếm-được-thông-báo-informed-search)
      - [a. Tìm kiếm tốt nhất đầu tiên (Best-First Search)](#a-tìm-kiếm-tốt-nhất-đầu-tiên-best-first-search)
      - [b. Thuật toán A\* Search](#b-thuật-toán-a-search)
    - [4. Các chiến lược heuristic phổ biến](#4-các-chiến-lược-heuristic-phổ-biến)
      - [a. Khoảng cách Manhattan](#a-khoảng-cách-manhattan)
      - [b. Khoảng cách Euclidean](#b-khoảng-cách-euclidean)
      - [c. Số ô sai vị trí (cho bài toán N-puzzle)](#c-số-ô-sai-vị-trí-cho-bài-toán-n-puzzle)
    - [5. Ứng dụng trong các bài toán thực tế](#5-ứng-dụng-trong-các-bài-toán-thực-tế)
      - [a. Bài toán 8-puzzle (8-sliding puzzle)](#a-bài-toán-8-puzzle-8-sliding-puzzle)
      - [b. Bài toán tìm đường đi trong mê cung](#b-bài-toán-tìm-đường-đi-trong-mê-cung)
  - [🧑‍🏫 Bài 5: Phân tích và tối ưu hóa thuật toán](#-bài-5-phân-tích-và-tối-ưu-hóa-thuật-toán)
    - [1. Phân tích độ phức tạp thuật toán](#1-phân-tích-độ-phức-tạp-thuật-toán)
      - [a. Các ký hiệu tiệm cận (Asymptotic notation)](#a-các-ký-hiệu-tiệm-cận-asymptotic-notation)
      - [b. Phân tích trường hợp tốt nhất, trung bình và xấu nhất](#b-phân-tích-trường-hợp-tốt-nhất-trung-bình-và-xấu-nhất)
      - [c. Phân tích không gian và thời gian](#c-phân-tích-không-gian-và-thời-gian)
    - [2. Các kỹ thuật tối ưu hóa thuật toán](#2-các-kỹ-thuật-tối-ưu-hóa-thuật-toán)
      - [a. Memoization và Dynamic Programming](#a-memoization-và-dynamic-programming)
      - [b. Tối ưu hóa vòng lặp và điều kiện](#b-tối-ưu-hóa-vòng-lặp-và-điều-kiện)
      - [c. Sử dụng cấu trúc dữ liệu thích hợp](#c-sử-dụng-cấu-trúc-dữ-liệu-thích-hợp)
      - [d. Trao đổi giữa thời gian và không gian](#d-trao-đổi-giữa-thời-gian-và-không-gian)
    - [3. Kỹ thuật profile và benchmark](#3-kỹ-thuật-profile-và-benchmark)
      - [a. Đo thời gian thực thi](#a-đo-thời-gian-thực-thi)
      - [b. Đo lường sử dụng bộ nhớ](#b-đo-lường-sử-dụng-bộ-nhớ)
      - [c. Xác định bottlenecks](#c-xác-định-bottlenecks)
    - [4. Các nguyên tắc tối ưu hóa thuật toán](#4-các-nguyên-tắc-tối-ưu-hóa-thuật-toán)
      - [a. Nguyên tắc "profile trước khi tối ưu"](#a-nguyên-tắc-profile-trước-khi-tối-ưu)
      - [b. Cân nhắc giữa khả năng đọc và hiệu suất](#b-cân-nhắc-giữa-khả-năng-đọc-và-hiệu-suất)
      - [c. Tránh tối ưu hóa quá sớm](#c-tránh-tối-ưu-hóa-quá-sớm)
      - [d. Tối ưu theo trường hợp sử dụng thực tế](#d-tối-ưu-theo-trường-hợp-sử-dụng-thực-tế)
  - [**🧑‍💻 Bài tập lớn: Xây dựng ứng dụng GPS đơn giản dựa trên thuật toán đồ thị**](#-bài-tập-lớn-xây-dựng-ứng-dụng-gps-đơn-giản-dựa-trên-thuật-toán-đồ-thị)
    - [1. Mô tả dự án](#1-mô-tả-dự-án)
    - [2. Các thành phần chính](#2-các-thành-phần-chính)
      - [a. Mô hình hóa bản đồ thành đồ thị](#a-mô-hình-hóa-bản-đồ-thành-đồ-thị)
      - [b. Thuật toán tìm đường đi ngắn nhất](#b-thuật-toán-tìm-đường-đi-ngắn-nhất)
      - [c. Giao diện người dùng đơn giản](#c-giao-diện-người-dùng-đơn-giản)
    - [3. Các cải tiến và mở rộng](#3-các-cải-tiến-và-mở-rộng)

## 🎯 Mục tiêu tổng quát

- Nắm vững các thuật toán xử lý chuỗi và ứng dụng trong các bài toán thực tế
- Hiểu và áp dụng thành thạo kỹ thuật hai con trỏ và cửa sổ trượt
- Làm chủ phương pháp chia để trị và áp dụng giải quyết các bài toán phức tạp
- Nắm vững các kỹ thuật tìm kiếm trong không gian trạng thái
- Biết cách phân tích và tối ưu hóa thuật toán hiệu quả
- Xây dựng được ứng dụng thực tế sử dụng các thuật toán đồ thị

---

## 🧑‍🏫 Bài 1: Thuật toán xử lý chuỗi

### 1. Tìm kiếm chuỗi con (String Matching)

#### a. Thuật toán Brute Force

Phương pháp đơn giản nhất để tìm kiếm một chuỗi con trong chuỗi chính.

```java
public static int bruteForceSearch(String text, String pattern) {
    int n = text.length();
    int m = pattern.length();

    for (int i = 0; i <= n - m; i++) {
        int j;
        for (j = 0; j < m; j++) {
            if (text.charAt(i + j) != pattern.charAt(j)) {
                break;
            }
        }
        if (j == m) {
            return i; // Tìm thấy pattern tại vị trí i
        }
    }
    return -1; // Không tìm thấy
}
```

- **Độ phức tạp**: O(n\*m) trong đó n là độ dài của chuỗi chính, m là độ dài của chuỗi mẫu

#### b. Thuật toán Knuth-Morris-Pratt (KMP)

KMP là thuật toán tìm kiếm chuỗi hiệu quả hơn bằng cách tận dụng thông tin từ các lần so khớp trước đó.

```java
public static int KMPSearch(String text, String pattern) {
    int n = text.length();
    int m = pattern.length();

    // Tạo bảng lps[] để lưu prefix dài nhất cũng là suffix
    int[] lps = computeLPSArray(pattern);

    int i = 0; // chỉ số cho text[]
    int j = 0; // chỉ số cho pattern[]

    while (i < n) {
        if (pattern.charAt(j) == text.charAt(i)) {
            i++;
            j++;
        }

        if (j == m) {
            return i - j; // Tìm thấy pattern
        } else if (i < n && pattern.charAt(j) != text.charAt(i)) {
            if (j != 0) {
                j = lps[j - 1];
            } else {
                i++;
            }
        }
    }
    return -1; // Không tìm thấy
}

// Hàm tính bảng lps (longest prefix suffix)
public static int[] computeLPSArray(String pattern) {
    int m = pattern.length();
    int[] lps = new int[m];

    int len = 0; // độ dài của chuỗi tiền tố-hậu tố trước đó
    int i = 1;

    while (i < m) {
        if (pattern.charAt(i) == pattern.charAt(len)) {
            len++;
            lps[i] = len;
            i++;
        } else {
            if (len != 0) {
                len = lps[len - 1];
            } else {
                lps[i] = 0;
                i++;
            }
        }
    }
    return lps;
}
```

- **Độ phức tạp**: O(n+m) trong trường hợp tốt nhất và trung bình

#### c. Thuật toán Boyer-Moore

Thuật toán tìm kiếm chuỗi hiệu quả, đặc biệt khi mẫu tìm kiếm dài.

```java
public static int boyerMooreSearch(String text, String pattern) {
    int n = text.length();
    int m = pattern.length();

    // Tạo bảng bad character
    Map<Character, Integer> badChar = new HashMap<>();

    // Khởi tạo bảng bad character
    for (int i = 0; i < m; i++) {
        badChar.put(pattern.charAt(i), i);
    }

    int s = 0; // s là vị trí dịch của pattern so với text

    while (s <= (n - m)) {
        int j = m - 1;

        // Kiểm tra từ phải sang trái
        while (j >= 0 && pattern.charAt(j) == text.charAt(s + j)) {
            j--;
        }

        if (j < 0) {
            return s; // Tìm thấy
        } else {
            // Dịch chuyển mẫu dựa trên quy tắc bad character
            char badCharacter = text.charAt(s + j);
            int shift = badChar.containsKey(badCharacter) ?
                        Math.max(1, j - badChar.get(badCharacter)) : j + 1;
            s += shift;
        }
    }

    return -1; // Không tìm thấy
}
```

- **Độ phức tạp**: O(n\*m) trong trường hợp xấu nhất, nhưng thường nhanh hơn trong thực tế

#### d. Thuật toán Rabin-Karp

Sử dụng hàm băm để so sánh các chuỗi một cách hiệu quả.

```java
public static int rabinKarpSearch(String text, String pattern) {
    int n = text.length();
    int m = pattern.length();
    int d = 256; // Số ký tự có thể có
    int q = 101; // Một số nguyên tố

    int p = 0; // Giá trị hash của pattern
    int t = 0; // Giá trị hash của đoạn text hiện tại
    int h = 1;

    // Tính h = d^(m-1) % q
    for (int i = 0; i < m - 1; i++) {
        h = (h * d) % q;
    }

    // Tính giá trị hash ban đầu của pattern và đoạn text đầu tiên
    for (int i = 0; i < m; i++) {
        p = (d * p + pattern.charAt(i)) % q;
        t = (d * t + text.charAt(i)) % q;
    }

    // Duyệt qua text
    for (int i = 0; i <= n - m; i++) {
        // Nếu hash trùng nhau, kiểm tra từng ký tự
        if (p == t) {
            boolean isMatch = true;
            for (int j = 0; j < m; j++) {
                if (text.charAt(i + j) != pattern.charAt(j)) {
                    isMatch = false;
                    break;
                }
            }
            if (isMatch) {
                return i;
            }
        }

        // Tính hash cho đoạn text tiếp theo
        if (i < n - m) {
            t = (d * (t - text.charAt(i) * h) + text.charAt(i + m)) % q;
            if (t < 0) t += q;
        }
    }

    return -1; // Không tìm thấy
}
```

- **Độ phức tạp**: O(n+m) trong trường hợp tốt nhất và trung bình, O(n\*m) trong trường hợp xấu nhất

### 2. Xử lý chuỗi nâng cao

#### a. Thuật toán Z

Thuật toán Z tìm tất cả các lần xuất hiện của một mẫu trong văn bản bằng cách xây dựng mảng Z.

```java
public static int[] computeZArray(String str) {
    int n = str.length();
    int[] Z = new int[n];
    int L = 0, R = 0;

    for (int i = 1; i < n; i++) {
        if (i > R) {
            L = R = i;
            while (R < n && str.charAt(R - L) == str.charAt(R)) {
                R++;
            }
            Z[i] = R - L;
            R--;
        } else {
            int k = i - L;
            if (Z[k] < R - i + 1) {
                Z[i] = Z[k];
            } else {
                L = i;
                while (R < n && str.charAt(R - L) == str.charAt(R)) {
                    R++;
                }
                Z[i] = R - L;
                R--;
            }
        }
    }
    return Z;
}

// Tìm tất cả các lần xuất hiện của pattern trong text
public static List<Integer> findAllOccurrences(String text, String pattern) {
    String concat = pattern + "$" + text;
    int[] Z = computeZArray(concat);
    List<Integer> result = new ArrayList<>();

    for (int i = 0; i < Z.length; i++) {
        if (Z[i] == pattern.length()) {
            result.add(i - pattern.length() - 1);
        }
    }

    return result;
}
```

- **Độ phức tạp**: O(n+m) trong đó n là độ dài text, m là độ dài pattern

#### b. Thuật toán Manacher (tìm chuỗi đối xứng)

Thuật toán Manacher dùng để tìm chuỗi đối xứng dài nhất trong một chuỗi với độ phức tạp tuyến tính.

```java
public static String longestPalindrome(String s) {
    // Xử lý chuỗi bằng cách thêm các ký tự # vào giữa
    StringBuilder sb = new StringBuilder();
    sb.append('#');
    for (char c : s.toCharArray()) {
        sb.append(c).append('#');
    }
    String t = sb.toString();

    int n = t.length();
    int[] p = new int[n]; // p[i] là độ dài palindrome tính từ vị trí i

    int c = 0, r = 0; // c là tâm của palindrome, r là biên phải
    int maxLen = 0, centerIndex = 0;

    for (int i = 0; i < n; i++) {
        // Tận dụng tính đối xứng
        if (r > i) {
            p[i] = Math.min(r - i, p[2 * c - i]);
        }

        // Mở rộng palindrome
        while (i + p[i] + 1 < n && i - p[i] - 1 >= 0 &&
               t.charAt(i + p[i] + 1) == t.charAt(i - p[i] - 1)) {
            p[i]++;
        }

        // Cập nhật tâm và biên phải
        if (i + p[i] > r) {
            c = i;
            r = i + p[i];
        }

        // Cập nhật kết quả
        if (p[i] > maxLen) {
            maxLen = p[i];
            centerIndex = i;
        }
    }

    int start = (centerIndex - maxLen) / 2;
    return s.substring(start, start + maxLen);
}
```

- **Độ phức tạp**: O(n) trong đó n là độ dài của chuỗi

#### c. Thuật toán Suffix Array và LCP Array

Suffix Array là mảng các hậu tố của một chuỗi được sắp xếp theo thứ tự từ điển. LCP Array (Longest Common Prefix) lưu trữ độ dài tiền tố chung dài nhất giữa các hậu tố liên tiếp trong suffix array.

```java
public class SuffixArray {
    public static int[] buildSuffixArray(String s) {
        int n = s.length();
        Suffix[] suffixes = new Suffix[n];

        // Lưu trữ các hậu tố và vị trí
        for (int i = 0; i < n; i++) {
            suffixes[i] = new Suffix(i, s.substring(i));
        }

        // Sắp xếp các hậu tố
        Arrays.sort(suffixes);

        // Lưu trữ chỉ số của các hậu tố đã sắp xếp
        int[] suffixArr = new int[n];
        for (int i = 0; i < n; i++) {
            suffixArr[i] = suffixes[i].index;
        }

        return suffixArr;
    }

    // Xây dựng LCP Array
    public static int[] buildLCPArray(String s, int[] suffixArr) {
        int n = s.length();
        int[] lcp = new int[n];

        // Mảng rank để lưu vị trí của mỗi hậu tố trong suffix array
        int[] rank = new int[n];
        for (int i = 0; i < n; i++) {
            rank[suffixArr[i]] = i;
        }

        int h = 0; // độ dài LCP hiện tại
        for (int i = 0; i < n; i++) {
            if (rank[i] > 0) {
                int j = suffixArr[rank[i] - 1];
                while (i + h < n && j + h < n && s.charAt(i + h) == s.charAt(j + h)) {
                    h++;
                }
                lcp[rank[i]] = h;
                if (h > 0) h--;
            }
        }

        return lcp;
    }

    static class Suffix implements Comparable<Suffix> {
        int index;
        String suffix;

        Suffix(int index, String suffix) {
            this.index = index;
            this.suffix = suffix;
        }

        @Override
        public int compareTo(Suffix other) {
            return this.suffix.compareTo(other.suffix);
        }
    }
}
```

- **Độ phức tạp**: O(n log n) cho việc xây dựng suffix array, O(n) cho LCP array

### 3. Ứng dụng của thuật toán xử lý chuỗi

#### a. Tìm kiếm mẫu trong văn bản và DNA

```java
public static List<Integer> findPatternInDNA(String dnaSequence, String pattern) {
    // Sử dụng KMP để tìm tất cả các lần xuất hiện
    List<Integer> occurrences = new ArrayList<>();

    int[] lps = computeLPSArray(pattern);
    int i = 0, j = 0;

    while (i < dnaSequence.length()) {
        if (pattern.charAt(j) == dnaSequence.charAt(i)) {
            i++;
            j++;
        }

        if (j == pattern.length()) {
            occurrences.add(i - j);
            j = lps[j - 1];
        } else if (i < dnaSequence.length() && pattern.charAt(j) != dnaSequence.charAt(i)) {
            if (j != 0) {
                j = lps[j - 1];
            } else {
                i++;
            }
        }
    }

    return occurrences;
}
```

#### b. Tìm chuỗi con chung dài nhất (Longest Common Substring)

```java
public static String longestCommonSubstring(String s1, String s2) {
    int m = s1.length();
    int n = s2.length();
    int[][] dp = new int[m + 1][n + 1];

    // Biến để theo dõi độ dài tối đa và vị trí kết thúc
    int maxLength = 0;
    int endIndex = 0;

    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            if (s1.charAt(i - 1) == s2.charAt(j - 1)) {
                dp[i][j] = dp[i - 1][j - 1] + 1;

                if (dp[i][j] > maxLength) {
                    maxLength = dp[i][j];
                    endIndex = i - 1;
                }
            }
        }
    }

    // Trích xuất chuỗi con
    return s1.substring(endIndex - maxLength + 1, endIndex + 1);
}
```

- **Độ phức tạp**: O(m \* n) trong đó m, n là độ dài của hai chuỗi

#### c. Tìm chuỗi con chung dài nhất cho nhiều chuỗi

```java
public static String longestCommonSubstring(String[] strings) {
    if (strings.length == 0) return "";
    if (strings.length == 1) return strings[0];

    String result = strings[0];

    for (int i = 1; i < strings.length; i++) {
        result = longestCommonSubstring(result, strings[i]);
        if (result.isEmpty()) break;
    }

    return result;
}
```

#### d. Nén chuỗi (Run-Length Encoding)

```java
public static String compress(String s) {
    if (s == null || s.isEmpty()) return s;

    StringBuilder compressed = new StringBuilder();
    char currentChar = s.charAt(0);
    int count = 1;

    for (int i = 1; i < s.length(); i++) {
        if (s.charAt(i) == currentChar) {
            count++;
        } else {
            compressed.append(currentChar);
            if (count > 1) {
                compressed.append(count);
            }
            currentChar = s.charAt(i);
            count = 1;
        }
    }

    // Xử lý phần cuối cùng
    compressed.append(currentChar);
    if (count > 1) {
        compressed.append(count);
    }

    return compressed.length() < s.length() ? compressed.toString() : s;
}
```

### 4. So sánh các thuật toán tìm kiếm chuỗi

| Thuật toán  | Tiền xử lý      | Tìm kiếm          | Trường hợp tốt nhất | Ưu điểm                   | Nhược điểm                    |
| ----------- | --------------- | ----------------- | ------------------- | ------------------------- | ----------------------------- |
| Brute Force | Không cần       | O(n\*m)           | O(n)                | Đơn giản, dễ cài đặt      | Chậm với mẫu và chuỗi dài     |
| KMP         | O(m)            | O(n)              | O(n)                | Hiệu quả với mọi loại mẫu | Phức tạp để cài đặt chính xác |
| Boyer-Moore | O(m + alphabet) | O(n/m) -> O(n\*m) | O(n/m)              | Rất nhanh trong thực tế   | Phức tạp, cần bộ nhớ cho bảng |
| Rabin-Karp  | O(m)            | O(n\*m) -> O(n+m) | O(n+m)              | Tốt cho tìm nhiều mẫu     | Có thể có va chạm hash        |

Với n là độ dài chuỗi chính và m là độ dài mẫu tìm kiếm.

---

## 🧑‍🏫 Bài 2: Kỹ thuật hai con trỏ và cửa sổ trượt

### 1. Kỹ thuật hai con trỏ (Two Pointers)

Kỹ thuật hai con trỏ là phương pháp sử dụng hai con trỏ (hoặc chỉ số) để duyệt qua một cấu trúc dữ liệu, thường là mảng hoặc danh sách liên kết.

#### a. Hai con trỏ cùng hướng (Same Direction)

Hai con trỏ cùng di chuyển theo một hướng, nhưng với tốc độ khác nhau.

##### **Ví dụ 1: Xóa các phần tử trùng lặp trong mảng đã sắp xếp**

```java
public static int removeDuplicates(int[] nums) {
    if (nums.length == 0) return 0;

    int slow = 0; // Con trỏ chậm (vị trí để ghi)

    for (int fast = 1; fast < nums.length; fast++) {
        if (nums[fast] != nums[slow]) {
            slow++;
            nums[slow] = nums[fast];
        }
    }

    return slow + 1; // Độ dài mảng mới
}
```

- **Độ phức tạp thời gian**: O(n)
- **Độ phức tạp không gian**: O(1)

##### **Ví dụ 2: Tìm phần tử không bằng 0 trong mảng**

```java
public static void moveZeroes(int[] nums) {
    int nonZeroPtr = 0;

    // Di chuyển tất cả phần tử khác 0 lên đầu mảng
    for (int i = 0; i < nums.length; i++) {
        if (nums[i] != 0) {
            nums[nonZeroPtr++] = nums[i];
        }
    }

    // Điền 0 vào các vị trí còn lại
    while (nonZeroPtr < nums.length) {
        nums[nonZeroPtr++] = 0;
    }
}
```

- **Độ phức tạp thời gian**: O(n)
- **Độ phức tạp không gian**: O(1)

#### b. Hai con trỏ ngược hướng (Opposite Direction)

Một con trỏ bắt đầu từ đầu mảng, con trỏ kia bắt đầu từ cuối mảng.

##### **Ví dụ 1: Đảo ngược mảng**

```java
public static void reverseArray(int[] nums) {
    int left = 0;
    int right = nums.length - 1;

    while (left < right) {
        // Đổi chỗ phần tử ở hai đầu
        int temp = nums[left];
        nums[left] = nums[right];
        nums[right] = temp;

        // Di chuyển hai con trỏ
        left++;
        right--;
    }
}
```

- **Độ phức tạp thời gian**: O(n)
- **Độ phức tạp không gian**: O(1)

##### **Ví dụ 2: Tìm cặp số có tổng bằng một giá trị cho trước (trong mảng đã sắp xếp)**

```java
public static boolean hasPairWithSum(int[] nums, int target) {
    int left = 0;
    int right = nums.length - 1;

    while (left < right) {
        int sum = nums[left] + nums[right];

        if (sum == target) {
            return true; // Tìm thấy cặp số
        } else if (sum < target) {
            left++; // Tăng tổng bằng cách di chuyển con trỏ trái
        } else {
            right--; // Giảm tổng bằng cách di chuyển con trỏ phải
        }
    }

    return false; // Không tìm thấy cặp số nào
}
```

- **Độ phức tạp thời gian**: O(n)
- **Độ phức tạp không gian**: O(1)

##### **Ví dụ 3: Kiểm tra chuỗi palindrome**

```java
public static boolean isPalindrome(String s) {
    // Loại bỏ kí tự không phải chữ cái và số, chuyển thành chữ thường
    String cleaned = s.replaceAll("[^a-zA-Z0-9]", "").toLowerCase();

    int left = 0;
    int right = cleaned.length() - 1;

    while (left < right) {
        if (cleaned.charAt(left) != cleaned.charAt(right)) {
            return false;
        }
        left++;
        right--;
    }

    return true;
}
```

- **Độ phức tạp thời gian**: O(n)
- **Độ phức tạp không gian**: O(n) do tạo chuỗi mới

#### c. Hai con trỏ trên hai mảng

Mỗi con trỏ duyệt một mảng khác nhau.

##### **Ví dụ: Hợp nhất hai mảng đã sắp xếp**

```java
public static int[] mergeSortedArrays(int[] nums1, int[] nums2) {
    int n = nums1.length;
    int m = nums2.length;
    int[] result = new int[n + m];

    int i = 0, j = 0, k = 0;

    while (i < n && j < m) {
        if (nums1[i] <= nums2[j]) {
            result[k++] = nums1[i++];
        } else {
            result[k++] = nums2[j++];
        }
    }

    // Sao chép phần còn lại nếu có
    while (i < n) {
        result[k++] = nums1[i++];
    }

    while (j < m) {
        result[k++] = nums2[j++];
    }

    return result;
}
```

- **Độ phức tạp thời gian**: O(n+m)
- **Độ phức tạp không gian**: O(n+m)

### 2. Kỹ thuật cửa sổ trượt (Sliding Window)

Kỹ thuật cửa sổ trượt là phương pháp duy trì một "cửa sổ" các phần tử trong một mảng hoặc chuỗi và trượt cửa sổ này qua dữ liệu.

#### a. Cửa sổ cố định (Fixed Size Window)

Kích thước cửa sổ không thay đổi trong quá trình duyệt.

##### **Ví dụ 1: Tìm tổng lớn nhất của cửa sổ kích thước k**

```java
public static int maxSumSubarrayOfSizeK(int[] arr, int k) {
    if (arr.length < k) {
        return -1; // Mảng nhỏ hơn kích thước cửa sổ
    }

    // Tính tổng của k phần tử đầu tiên
    int windowSum = 0;
    for (int i = 0; i < k; i++) {
        windowSum += arr[i];
    }

    int maxSum = windowSum;

    // Trượt cửa sổ và cập nhật tổng
    for (int i = k; i < arr.length; i++) {
        windowSum = windowSum + arr[i] - arr[i - k];
        maxSum = Math.max(maxSum, windowSum);
    }

    return maxSum;
}
```

- **Độ phức tạp thời gian**: O(n)
- **Độ phức tạp không gian**: O(1)

##### **Ví dụ 2: Tìm giá trị trung bình của tất cả các cửa sổ kích thước k**

```java
public static double[] findAverages(int[] arr, int k) {
    double[] result = new double[arr.length - k + 1];

    double windowSum = 0;
    int windowStart = 0;

    for (int windowEnd = 0; windowEnd < arr.length; windowEnd++) {
        windowSum += arr[windowEnd]; // Thêm vào cửa sổ

        // Khi đã đủ kích thước k
        if (windowEnd >= k - 1) {
            result[windowStart] = windowSum / k; // Tính trung bình
            windowSum -= arr[windowStart]; // Loại bỏ phần tử đầu tiên
            windowStart++; // Di chuyển cửa sổ
        }
    }

    return result;
}
```

- **Độ phức tạp thời gian**: O(n)
- **Độ phức tạp không gian**: O(n-k+1) cho mảng kết quả

#### b. Cửa sổ thay đổi kích thước (Variable Size Window)

Kích thước cửa sổ thay đổi động theo điều kiện nào đó.

##### **Ví dụ 1: Tìm dãy con ngắn nhất có tổng >= S**

```java
public static int smallestSubarrayWithSum(int[] arr, int targetSum) {
    int windowSum = 0;
    int windowStart = 0;
    int minLength = Integer.MAX_VALUE;

    for (int windowEnd = 0; windowEnd < arr.length; windowEnd++) {
        windowSum += arr[windowEnd]; // Thêm vào cửa sổ

        // Thu nhỏ cửa sổ khi tổng >= targetSum
        while (windowSum >= targetSum) {
            minLength = Math.min(minLength, windowEnd - windowStart + 1);
            windowSum -= arr[windowStart];
            windowStart++;
        }
    }

    return minLength == Integer.MAX_VALUE ? 0 : minLength;
}
```

- **Độ phức tạp thời gian**: O(n)
- **Độ phức tạp không gian**: O(1)

##### **Ví dụ 2: Chuỗi con dài nhất không có ký tự lặp lại**

```java
public static int lengthOfLongestSubstring(String s) {
    int[] charIndex = new int[128]; // Lưu chỉ số của ký tự
    Arrays.fill(charIndex, -1); // Khởi tạo tất cả là -1

    int maxLength = 0;
    int windowStart = 0;

    for (int windowEnd = 0; windowEnd < s.length(); windowEnd++) {
        char rightChar = s.charAt(windowEnd);

        // Nếu ký tự đã xuất hiện sau điểm bắt đầu cửa sổ hiện tại
        if (charIndex[rightChar] >= windowStart) {
            // Di chuyển cửa sổ bắt đầu sau vị trí ký tự đã xuất hiện
            windowStart = charIndex[rightChar] + 1;
        }

        // Cập nhật vị trí của ký tự
        charIndex[rightChar] = windowEnd;

        // Cập nhật độ dài tối đa
        maxLength = Math.max(maxLength, windowEnd - windowStart + 1);
    }

    return maxLength;
}
```

- **Độ phức tạp thời gian**: O(n)
- **Độ phức tạp không gian**: O(1) nếu giả sử bảng mã ASCII cố định

##### **Ví dụ 3: Chuỗi con dài nhất với không quá k ký tự khác nhau**

```java
public static int lengthOfLongestSubstringKDistinct(String s, int k) {
    if (s == null || s.isEmpty() || k == 0) {
        return 0;
    }

    int windowStart = 0;
    int maxLength = 0;
    Map<Character, Integer> charFrequency = new HashMap<>();

    for (int windowEnd = 0; windowEnd < s.length(); windowEnd++) {
        char rightChar = s.charAt(windowEnd);
        charFrequency.put(rightChar, charFrequency.getOrDefault(rightChar, 0) + 1);

        // Thu nhỏ cửa sổ khi có quá k ký tự khác nhau
        while (charFrequency.size() > k) {
            char leftChar = s.charAt(windowStart);
            charFrequency.put(leftChar, charFrequency.get(leftChar) - 1);
            if (charFrequency.get(leftChar) == 0) {
                charFrequency.remove(leftChar);
            }
            windowStart++;
        }

        maxLength = Math.max(maxLength, windowEnd - windowStart + 1);
    }

    return maxLength;
}
```

- **Độ phức tạp thời gian**: O(n)
- **Độ phức tạp không gian**: O(k)

### 3. Ứng dụng và bài toán thực tế

#### a. Tìm tập con có tổng bằng một giá trị cho trước

```java
public static boolean canPartitionArray(int[] nums) {
    int totalSum = 0;
    for (int num : nums) {
        totalSum += num;
    }

    // Nếu tổng lẻ, không thể chia thành 2 phần bằng nhau
    if (totalSum % 2 != 0) {
        return false;
    }

    int target = totalSum / 2;
    boolean[] dp = new boolean[target + 1];
    dp[0] = true;

    for (int num : nums) {
        for (int i = target; i >= num; i--) {
            dp[i] = dp[i] || dp[i - num];
        }
    }

    return dp[target];
}
```

- **Độ phức tạp thời gian**: O(n \* sum/2)
- **Độ phức tạp không gian**: O(sum/2)

#### b. Tìm ba số có tổng bằng 0

```java
public static List<List<Integer>> threeSum(int[] nums) {
    List<List<Integer>> result = new ArrayList<>();
    if (nums.length < 3) return result;

    Arrays.sort(nums);

    for (int i = 0; i < nums.length - 2; i++) {
        // Bỏ qua các giá trị trùng lặp
        if (i > 0 && nums[i] == nums[i - 1]) continue;

        int left = i + 1;
        int right = nums.length - 1;

        while (left < right) {
            int sum = nums[i] + nums[left] + nums[right];

            if (sum < 0) {
                left++;
            } else if (sum > 0) {
                right--;
            } else {
                // Tìm thấy bộ ba
                result.add(Arrays.asList(nums[i], nums[left], nums[right]));

                // Bỏ qua các giá trị trùng lặp
                while (left < right && nums[left] == nums[left + 1]) left++;
                while (left < right && nums[right] == nums[right - 1]) right--;

                left++;
                right--;
            }
        }
    }

    return result;
}
```

- **Độ phức tạp thời gian**: O(n²)
- **Độ phức tạp không gian**: O(n) cho danh sách kết quả

#### c. Tìm tất cả các anagram trong chuỗi

```java
public static List<Integer> findAnagrams(String s, String p) {
    List<Integer> result = new ArrayList<>();
    if (s.length() < p.length()) return result;

    int[] charCount = new int[26]; // Đếm số lần xuất hiện của các ký tự trong p
    for (char c : p.toCharArray()) {
        charCount[c - 'a']++;
    }

    int windowStart = 0;
    int matched = 0; // Số ký tự đã khớp

    for (int windowEnd = 0; windowEnd < s.length(); windowEnd++) {
        char rightChar = s.charAt(windowEnd);

        // Giảm số đếm của ký tự vào cửa sổ
        charCount[rightChar - 'a']--;

        // Nếu số đếm >= 0, đã khớp một ký tự từ p
        if (charCount[rightChar - 'a'] >= 0) {
            matched++;
        }

        // Nếu khớp tất cả ký tự
        if (matched == p.length()) {
            result.add(windowStart);
        }

        // Khi cửa sổ đạt kích thước p.length()
        if (windowEnd >= p.length() - 1) {
            char leftChar = s.charAt(windowStart);
            windowStart++;

            // Nếu ký tự rời khỏi cửa sổ là ký tự khớp
            if (charCount[leftChar - 'a'] >= 0) {
                matched--;
            }

            // Tăng số đếm khi ký tự rời khỏi cửa sổ
            charCount[leftChar - 'a']++;
        }
    }

    return result;
}
```

- **Độ phức tạp thời gian**: O(n)
- **Độ phức tạp không gian**: O(1) vì chúng ta chỉ sử dụng một mảng cố định 26 phần tử

### 4. So sánh hai kỹ thuật

| Tiêu chí             | Kỹ thuật hai con trỏ                  | Kỹ thuật cửa sổ trượt                          |
| -------------------- | ------------------------------------- | ---------------------------------------------- |
| **Ứng dụng chính**   | Tìm cặp phần tử, đảo ngược mảng/chuỗi | Tìm dãy con liên tiếp thỏa mãn điều kiện       |
| **Cách tiếp cận**    | Sử dụng hai chỉ số riêng biệt         | Sử dụng hai chỉ số xác định đầu và cuối cửa sổ |
| **Di chuyển**        | Có thể cùng hướng hoặc ngược hướng    | Luôn theo một hướng                            |
| **Kích thước**       | Không duy trì kích thước cố định      | Có thể cố định hoặc thay đổi                   |
| **Độ phức tạp**      | Thường là O(n)                        | Thường là O(n)                                 |
| **Bài toán phù hợp** | Mảng đã sắp xếp, tìm tổng...          | Dãy con liên tiếp, chuỗi con...                |

---

## 🧑‍🏫 Bài 3: Thuật toán chia để trị

### 1. Nguyên lý chia để trị

Chia để trị là một phương pháp thiết kế thuật toán dựa trên việc:

1. **Chia (Divide)**: Chia bài toán thành các bài toán con nhỏ hơn cùng dạng
2. **Trị (Conquer)**: Giải quyết các bài toán con một cách đệ quy
3. **Kết hợp (Combine)**: Kết hợp lời giải của các bài toán con để tạo lời giải cho bài toán ban đầu

#### Cấu trúc chung của thuật toán chia để trị

```java
public Type divideAndConquer(Problem problem) {
    if (problem.size() <= threshold) {
        return solveDirectly(problem);
    }

    // Chia thành các bài toán con
    Problem[] subproblems = divideIntoParts(problem);

    // Giải quyết từng bài toán con
    Type[] subresults = new Type[subproblems.length];
    for (int i = 0; i < subproblems.length; i++) {
        subresults[i] = divideAndConquer(subproblems[i]);
    }

    // Kết hợp kết quả
    return combineResults(subresults);
}
```

### 2. Các thuật toán chia để trị cơ bản

#### a. Merge Sort

Thuật toán sắp xếp trộn chia mảng thành hai nửa, sắp xếp từng nửa và sau đó trộn chúng lại.

```java
public static void mergeSort(int[] arr, int left, int right) {
    if (left < right) {
        // Tìm điểm giữa
        int mid = left + (right - left) / 2;

        // Sắp xếp nửa đầu
        mergeSort(arr, left, mid);

        // Sắp xếp nửa sau
        mergeSort(arr, mid + 1, right);

        // Trộn hai nửa đã sắp xếp
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

    // Trộn mảng
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

    // Sao chép phần còn lại của L[] nếu có
    while (i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }

    // Sao chép phần còn lại của R[] nếu có
    while (j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }
}
```

- **Độ phức tạp thời gian**: O(n log n)
- **Độ phức tạp không gian**: O(n)

#### b. Quick Sort

Thuật toán sắp xếp nhanh chọn một phần tử là "pivot" và phân vùng mảng sao cho các phần tử nhỏ hơn pivot nằm bên trái và các phần tử lớn hơn pivot nằm bên phải.

```java
public static void quickSort(int[] arr, int low, int high) {
    if (low < high) {
        // Lấy vị trí chốt sau khi sắp xếp
        int pi = partition(arr, low, high);

        // Sắp xếp các phần tử trước và sau chốt
        quickSort(arr, low, pi - 1);
        quickSort(arr, pi + 1, high);
    }
}

private static int partition(int[] arr, int low, int high) {
    int pivot = arr[high]; // Chọn phần tử cuối làm pivot
    int i = low - 1; // Chỉ số của phần tử nhỏ hơn

    for (int j = low; j < high; j++) {
        // Nếu phần tử hiện tại nhỏ hơn hoặc bằng pivot
        if (arr[j] <= pivot) {
            i++;

            // Đổi chỗ arr[i] và arr[j]
            int temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
        }
    }

    // Đổi chỗ arr[i+1] và arr[high] (pivot)
    int temp = arr[i + 1];
    arr[i + 1] = arr[high];
    arr[high] = temp;

    return i + 1; // Trả về vị trí chốt
}
```

- **Độ phức tạp thời gian**: Trung bình O(n log n), xấu nhất O(n²)
- **Độ phức tạp không gian**: O(log n) cho stack đệ quy

#### c. Binary Search

Tìm kiếm nhị phân hiệu quả trên mảng đã sắp xếp bằng cách liên tục chia đôi phạm vi tìm kiếm.

```java
public static int binarySearch(int[] arr, int target) {
    return binarySearchRecursive(arr, target, 0, arr.length - 1);
}

private static int binarySearchRecursive(int[] arr, int target, int left, int right) {
    if (left > right) {
        return -1; // Không tìm thấy
    }

    int mid = left + (right - left) / 2;

    // Nếu phần tử ở giữa là giá trị cần tìm
    if (arr[mid] == target) {
        return mid;
    }

    // Nếu phần tử nhỏ hơn giá trị cần tìm, tìm ở nửa bên phải
    if (arr[mid] < target) {
        return binarySearchRecursive(arr, target, mid + 1, right);
    }

    // Ngược lại, tìm ở nửa bên trái
    return binarySearchRecursive(arr, target, left, mid - 1);
}
```

- **Độ phức tạp thời gian**: O(log n)
- **Độ phức tạp không gian**: O(log n) cho stack đệ quy (hoặc O(1) nếu cài đặt lặp)

### 3. Thuật toán chia để trị nâng cao

#### a. Bài toán tìm số đa số (Majority Element)

Tìm phần tử xuất hiện nhiều hơn n/2 lần trong mảng dùng thuật toán Boyer-Moore Majority Vote.

```java
public static int majorityElement(int[] nums) {
    return majorityElementRec(nums, 0, nums.length - 1);
}

private static int majorityElementRec(int[] nums, int lo, int hi) {
    // Trường hợp cơ sở: chỉ một phần tử
    if (lo == hi) {
        return nums[lo];
    }

    // Chia mảng làm hai
    int mid = lo + (hi - lo) / 2;
    int left = majorityElementRec(nums, lo, mid);
    int right = majorityElementRec(nums, mid + 1, hi);

    // Nếu hai nửa có cùng phần tử đa số
    if (left == right) {
        return left;
    }

    // Đếm số lần xuất hiện của left và right
    int leftCount = countInRange(nums, left, lo, hi);
    int rightCount = countInRange(nums, right, lo, hi);

    return leftCount > rightCount ? left : right;
}

private static int countInRange(int[] nums, int num, int lo, int hi) {
    int count = 0;
    for (int i = lo; i <= hi; i++) {
        if (nums[i] == num) {
            count++;
        }
    }
    return count;
}
```

- **Độ phức tạp thời gian**: O(n log n)
- **Độ phức tạp không gian**: O(log n) cho stack đệ quy

#### b. Bài toán tìm cặp điểm gần nhất (Closest Pair of Points)

Tìm cặp điểm có khoảng cách gần nhất trong một tập hợp điểm 2D.

```java
public static class Point {
    double x, y;

    Point(double x, double y) {
        this.x = x;
        this.y = y;
    }

    public static double distance(Point p1, Point p2) {
        return Math.sqrt(Math.pow(p1.x - p2.x, 2) + Math.pow(p1.y - p2.y, 2));
    }
}

public static double closestPair(Point[] points) {
    // Sắp xếp điểm theo tọa độ x
    Arrays.sort(points, Comparator.comparingDouble(p -> p.x));

    return closestPairRec(points, 0, points.length - 1);
}

private static double closestPairRec(Point[] points, int start, int end) {
    // Nếu có ít hơn 4 điểm, sử dụng brute force
    if (end - start <= 3) {
        return bruteForceClosest(points, start, end);
    }

    // Tìm điểm giữa
    int mid = start + (end - start) / 2;
    Point midPoint = points[mid];

    // Tìm khoảng cách nhỏ nhất ở nửa trái và nửa phải
    double dl = closestPairRec(points, start, mid);
    double dr = closestPairRec(points, mid + 1, end);

    // Lấy khoảng cách nhỏ nhất
    double d = Math.min(dl, dr);

    // Tạo dải điểm có khoảng cách x đến đường phân chia <= d
    List<Point> strip = new ArrayList<>();
    for (int i = start; i <= end; i++) {
        if (Math.abs(points[i].x - midPoint.x) < d) {
            strip.add(points[i]);
        }
    }

    // Sắp xếp dải điểm theo y
    strip.sort(Comparator.comparingDouble(p -> p.y));

    // Tìm điểm gần nhất trong dải
    double stripMin = d;
    for (int i = 0; i < strip.size(); i++) {
        for (int j = i + 1; j < strip.size() && (strip.get(j).y - strip.get(i).y) < d; j++) {
            stripMin = Math.min(stripMin, Point.distance(strip.get(i), strip.get(j)));
        }
    }

    return Math.min(d, stripMin);
}

private static double bruteForceClosest(Point[] points, int start, int end) {
    double minDist = Double.MAX_VALUE;
    for (int i = start; i <= end; i++) {
        for (int j = i + 1; j <= end; j++) {
            double dist = Point.distance(points[i], points[j]);
            if (dist < minDist) {
                minDist = dist;
            }
        }
    }
    return minDist;
}
```

- **Độ phức tạp thời gian**: O(n log² n)
- **Độ phức tạp không gian**: O(n)

#### c. Thuật toán Strassen nhân ma trận

Cải tiến nhân ma trận từ O(n³) xuống O(n^log₂7) ≈ O(n^2.81) bằng cách giảm số phép nhân cần thực hiện.

````java
public static int[][] strassenMatrixMultiply(int[][] A, int[][] B) {
    int n = A.length;
    int[][] result = new int[n][n];

    // Trường hợp cơ sở
    if (n == 1) {
        result[0][0] = A[0][0] * B[0][0];
        return result;
    }

    // Chia ma trận thành 4 phần
    int mid = n / 2;
    int[][] A11 = new int[mid][mid];
    int[][] A12 = new int[mid][mid];
    int[][] A21 = new int[mid][mid];
    int[][] A22 = new int[mid][mid];
    int[][] B11 = new int[mid][mid];
    int[][] B12 = new int[mid][mid];
    int[][] B21 = new int[mid][mid];
    int[][] B22 = new int[mid][mid];

    // Chia ma trận A và B
    splitMatrix(A, A11, A12, A21, A22);
    splitMatrix(B, B11, B12, B21, B22);

    // Bước 1: Tính 7 ma trận tích P1 đến P7
    int[][] P1 = strassenMatrixMultiply(addMatrices(A11, A22), addMatrices(B11, B22));
    int[][] P2 = strassenMatrixMultiply(addMatrices(A21, A22), B11);
    int[][] P3 = strassenMatrixMultiply(A11, subtractMatrices(B12, B22));
    int[][] P4 = strassenMatrixMultiply(A22, subtractMatrices(B21, B11));
    int[][] P5 = strassenMatrixMultiply(addMatrices(A11, A12), B22);
    int[][] P6 = strassenMatrixMultiply(subtractMatrices(A21, A11), addMatrices(B11, B12));
    int[][] P7 = strassenMatrixMultiply(subtractMatrices(A12, A22), addMatrices(B21, B22));

    // Bước 2: Tính các phần của ma trận kết quả
    int[][] C11 = addMatrices(subtractMatrices(addMatrices(P1, P4), P5), P7);
    int[][] C12 = addMatrices(P3, P5);
    int[][] C21 = addMatrices(P2, P4);
    int[][] C22 = addMatrices(subtractMatrices(addMatrices(P1, P3), P2), P6);

    // Bước 3: Kết hợp các phần của ma trận kết quả
    combineMatrices(result, C11, C12, C21, C22);

    return result;
}

// Phương thức hỗ trợ để chia ma trận
private static void splitMatrix(int[][] A, int[][] A11, int[][] A12, int[][] A21, int[][] A22) {
    int n = A.length / 2;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            A11[i][j] = A[i][j];
            A12[i][j] = A[i][j + n];
            A21[i][j] = A[i + n][j];
            A22[i][j] = A[i + n][j + n];
        }
    }
}

// Phương thức hỗ trợ để kết hợp ma trận
private static void combineMatrices(int[][] C, int[][] C11, int[][] C12, int[][] C21, int[][] C22) {
    int n = C11.length;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            C[i][j] = C11[i][j];
            C[i][j + n] = C12[i][j];
            C[i + n][j] = C21[i][j];
            C[i + n][j + n] = C22[i][j];
        }
    }
}

// Phương thức hỗ trợ để cộng hai ma trận
private static int[][] addMatrices(int[][] A, int[][] B) {
    int n = A.length;
    int[][] result = new int[n][n];

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            result[i][j] = A[i][j] + B[i][j];
        }
    }

    return result;
}

// Phương thức hỗ trợ để trừ hai ma trận
private static int[][] subtractMatrices(int[][]<!-- filepath: /home/klpod221/Develop/lesson-plan/DSA/Part5.md -->
# 📘 PHẦN 5: THUẬT TOÁN ỨNG DỤNG VÀ TỐI ƯU HÓA


- [📘 PHẦN 5: THUẬT TOÁN ỨNG DỤNG VÀ TỐI ƯU HÓA](#-phần-5-thuật-toán-ứng-dụng-và-tối-ưu-hóa)
  - [Nội dung](#nội-dung)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Thuật toán xử lý chuỗi](#-bài-1-thuật-toán-xử-lý-chuỗi)
  - [🧑‍🏫 Bài 2: Kỹ thuật hai con trỏ và cửa sổ trượt](#-bài-2-kỹ-thuật-hai-con-trỏ-và-cửa-sổ-trượt)
  - [🧑‍🏫 Bài 3: Thuật toán chia để trị](#-bài-3-thuật-toán-chia-để-trị)
  - [🧑‍🏫 Bài 4: Tìm kiếm theo không gian trạng thái](#-bài-4-tìm-kiếm-theo-không-gian-trạng-thái)
  - [🧑‍🏫 Bài 5: Phân tích và tối ưu hóa thuật toán](#-bài-5-phân-tích-và-tối-ưu-hóa-thuật-toán)
  - [🧑‍💻 Bài tập lớn: Xây dựng ứng dụng GPS đơn giản dựa trên thuật toán đồ thị](#-bài-tập-lớn-xây-dựng-ứng-dụng-gps-đơn-giản-dựa-trên-thuật-toán-đồ-thị)

## 🎯 Mục tiêu tổng quát

- Nắm vững các thuật toán xử lý chuỗi và ứng dụng trong các bài toán thực tế
- Hiểu và áp dụng thành thạo kỹ thuật hai con trỏ và cửa sổ trượt
- Làm chủ phương pháp chia để trị và áp dụng giải quyết các bài toán phức tạp
- Nắm vững các kỹ thuật tìm kiếm trong không gian trạng thái
- Biết cách phân tích và tối ưu hóa thuật toán hiệu quả
- Xây dựng được ứng dụng thực tế sử dụng các thuật toán đồ thị

---

## 🧑‍🏫 Bài 1: Thuật toán xử lý chuỗi

### 1. Tìm kiếm chuỗi con (String Matching)

#### a. Thuật toán Brute Force

Phương pháp đơn giản nhất để tìm kiếm một chuỗi con trong chuỗi chính.

```java
public static int bruteForceSearch(String text, String pattern) {
    int n = text.length();
    int m = pattern.length();

    for (int i = 0; i <= n - m; i++) {
        int j;
        for (j = 0; j < m; j++) {
            if (text.charAt(i + j) != pattern.charAt(j)) {
                break;
            }
        }
        if (j == m) {
            return i; // Tìm thấy pattern tại vị trí i
        }
    }
    return -1; // Không tìm thấy
}
````

- **Độ phức tạp**: O(n\*m) trong đó n là độ dài của chuỗi chính, m là độ dài của chuỗi mẫu

## 🧑‍🏫 Bài 4: Tìm kiếm theo không gian trạng thái

### 1. Giới thiệu về không gian trạng thái

Không gian trạng thái là tập hợp tất cả các trạng thái có thể của một bài toán, trong đó:

- Mỗi nút đại diện cho một trạng thái
- Các cạnh đại diện cho các hành động chuyển từ trạng thái này sang trạng thái khác

### 2. Tìm kiếm không thông báo (Uninformed Search)

#### a. Tìm kiếm theo chiều rộng (BFS)

```java
public static <T> List<T> breadthFirstSearch(Graph<T> graph, T start, T goal) {
    Queue<Node<T>> queue = new LinkedList<>();
    Set<T> visited = new HashSet<>();
    Map<T, T> parent = new HashMap<>();

    queue.add(new Node<>(start, null));
    visited.add(start);

    while (!queue.isEmpty()) {
        Node<T> current = queue.poll();
        T currentState = current.state;

        if (currentState.equals(goal)) {
            return reconstructPath(start, goal, parent);
        }

        for (T neighbor : graph.getNeighbors(currentState)) {
            if (!visited.contains(neig
                parent.put(neighbor, currentState);
                queue.add(new Node<>(neighbor, currentState));
            }
        }
    }

    return null; // Không tìm thấy đường đi
}
```

- **Độ phức tạp thời gian**: O(b^d), với b là số nhánh trung bình và d là độ sâu của đích
- **Độ phức tạp không gian**: O(b^d)
- **Tính chất**: Tìm đường đi ngắn nhất, đầy đủ nếu b hữu hạn

#### b. Tìm kiếm theo chiều sâu (DFS)

```java
public static <T> List<T> depthFirstSearch(Graph<T> graph, T start, T goal) {
    Set<T> visited = new HashSet<>();

    boolean found = dfsRecursive(graph, start, goal, visited, parent);

    if (found) {
        return reconstructPath(start, goal, parent);
    }

    return null; // Không tìm thấy đường đi
}

private static <T> boolean dfsRecursive(Graph<T> graph, T current, T goal,
                                      Set<T> visited, Map<T, T> parent) {
    if (current.equals(goal)) {
        return true;
    }

    visited.add(current);

    for (T neighbor : graph.getNeighbors(current)) {
        if (!visited.contains(neighbor)) {
            parent.put(neighbor, current);

            if (dfsRecursive(graph, neighbor, goal, visited, parent)) {
                return true;
            }
        }
    }

    return false;
}
```

- **Độ phức tạp thời gian**: O(b^m), với b là số nhánh trung bình và m là độ sâu tối đa
- **Độ phức tạp không gian**: O(bm)
- **Tính chất**: Không đảm bảo tìm đường đi ngắn nhất, đầy đủ nếu không gian trạng thái hữu hạn

#### c. Tìm kiếm theo chiều sâu có giới hạn (Depth-Limited Search)

```java
public static <T> List<T> depthLimitedSearch(Graph<T> graph, T start, T goal, int depthLimit) {
    Set<T> visited = new HashSet<>();

    Result result = dfsLimited(graph, start, goal, depthLimit, visited, parent);

    if (result == Result.FOUND) {
        return reconstructPath(start, goal, parent);
    }

    return null; // Không tìm thấy hoặc cắt bỏ
}

enum Result { FOUND, NOT_FOUND, CUTOFF }

private static <T> Result dfsLimited(Graph<T> graph, T current, T goal, int limit,
                                   Set<T> visited, Map<T, T> parent) {
    if (current.equals(goal)) {
        return Result.FOUND;
    }

    if (limit == 0) {
        return Result.CUTOFF;
    }

    visited.add(current);
    boolean cutoffOccurred = false;

    for (T neighbor : graph.getNeighbors(current)) {
        if (!visited.contains(neighbor)) {
            parent.put(neighbor, current);

            Result result = dfsLimited(graph, neighbor, goal, limit - 1, visited, parent);

            if (result == Result.FOUND) {
                return Result.FOUND;
            } else if (result == Result.CUTOFF) {
                cutoffOccurred = true;
            }

            visited.remove(neighbor); // Backtrack
        }
    }

    return cutoffOccurred ? Result.CUTOFF : Result.NOT_FOUND;
}
```

- **Độ phức tạp thời gian**: O(b^L), với b là số nhánh trung bình và L là giới hạn độ sâu
- **Độ phức tạp không gian**: O(bL)
- **Tính chất**: Không đảm bảo tìm đường đi ngắn nhất, đầy đủ nếu đích nằm trong giới hạn độ sâu

#### d. Tìm kiếm theo chiều sâu lặp (Iterative Deepening DFS)

```java
public static <T> List<T> iterativeDeepeningSearch(Graph<T> graph, T start, T goal, int maxDepth) {
    for (int depth = 0; depth <= maxDepth; depth++) {
        Set<T> visited = new HashSet<>();
        Map<T, T> parent = new HashMap<>();

        Result result = dfsLimited(graph, start, goal, depth, visited, parent);

        if (result == Result.FOUND) {
            return reconstructPath(start, goal, parent);
        }
    }

    return null; // Không tìm thấy trong giới hạn độ sâu tối đa
}
```

- **Độ phức tạp thời gian**: O(b^d), với b là số nhánh trung bình và d là độ sâu của đích
- **Độ phức tạp không gian**: O(bd)
- **Tính chất**: Kết hợp ưu điểm của DFS (tiết kiệm bộ nhớ) và BFS (tìm đường đi ngắn nhất)

### 3. Các thuật toán tìm kiếm được thông báo (Informed Search)

#### a. Tìm kiếm tốt nhất đầu tiên (Best-First Search)

```java
public static <T> List<T> bestFirstSearch(Graph<T> graph, T start, T goal, Heuristic<T> heuristic) {
    PriorityQueue<Node<T>> queue = new PriorityQueue<>(
        Comparator.comparingDouble(node -> node.priority)
    );
    Set<T> visited = new HashSet<>();
    Map<T, T> parent = new HashMap<>();

    queue.add(new Node<>(start, null, heuristic.estimate(start, goal)));

    while (!queue.isEmpty()) {
        Node<T> current = queue.poll();
        T currentState = current.state;

        if (currentState.equals(goal)) {
            return reconstructPath(start, goal, parent);
        }

        if (visited.contains(currentState)) {
            continue;
        }

        visited.add(currentState);

        for (T neighbor : graph.getNeighbors(currentState)) {
            if (!visited.contains(neighbor)) {
                parent.put(neighbor, currentState);
                double priority = heuristic.estimate(neighbor, goal);
                queue.add(new Node<>(neighbor, currentState, priority));
            }
        }
    }

    return null; // Không tìm thấy đường đi

}

interface Heuristic<T> {
double estimate(T current, T goal);
}

```

- **Độ phức tạp thời gian**: O(b^m), với b là số nhánh trung bình và m là độ sâu tối đa
- **Tính chất**: Không đảm bảo tìm đường đi ngắn nhất, nhưng thường nhanh hơn các phương pháp không được thông báo

#### b. Thuật toán A\* Search

```java
public static <T> List<T> aStarSearch(Graph<T> graph, T start, T goal,
    PriorityQueue<Node<T>> openSet = new PriorityQueue<>(
        Comparator.comparingDouble(node -> node.priority)
    );
    Set<T> closedSet = new HashSet<>();
    Map<T, T> parent = new HashMap<>();
    Map<T, Double> gScore = new HashMap<>(); // Chi phí từ start đến node hiện tại

    gScore.put(start, 0.0);
    openSet.add(new Node<>(start, null, heuristic.estimate(start, goal)));

    while (!openSet.isEmpty()) {
        Node<T> current = openSet.poll();
        T currentState = current.state;

        if (currentState.equals(goal)) {
            return reconstructPath(start, goal, parent);
        }

        closedSet.add(currentState);

        for (T neighbor : graph.getNeighbors(currentState)) {
            if (closedSet.contains(neighbor)) {
                continue;
            }

            // Tính chi phí từ start đến neighbor qua currentState
            double tentativeGScore = gScore.get(currentState) +
                                     costFn.getCost(currentState, neighbor);

            if (!gScore.containsKey(neighbor) || tentativeGScore < gScore.get(neighbor)) {
                // Tìm thấy đường đi tốt hơn
                parent.put(neighbor, currentState);
                gScore.put(neighbor, tentativeGScore);

                // f(n) = g(n) + h(n)
                double fScore = tentativeGScore + heuristic.estimate(neighbor, goal);

                // Cập nhật hoặc thêm vào openSet
                openSet.add(new Node<>(neighbor, currentState, fScore));
            }
        }
    }

    return null; // Không tìm thấy đường đi
}

interface CostFunction<T> {
    double getCost(T current, T neighbor);
}
```

- **Độ phức tạp thời gian**: O(b^d), với b là số nhánh trung bình và d là độ sâu của đích
- **Tính chất**: Đảm bảo tìm đường đi ngắn nhất nếu heuristic là admissible (không bao giờ ước lượng quá chi phí thực tế đến đích)

### 4. Các chiến lược heuristic phổ biến

#### a. Khoảng cách Manhattan

Dùng cho các bài toán di chuyển trên lưới với 4 hướng (lên, xuống, trái, phải)

```java
    return Math.abs(p1.x - p2.x) + Math.abs(p1.y - p2.y);
}
```

#### b. Khoảng cách Euclidean

Dùng cho các bài toán di chuyển trên không gian 2D hoặc 3D

```java
public static double euclideanDistance(Point p1, Point p2) {
    return Math.sqrt(Math.pow(p1.x - p2.x, 2) + Math.pow(p1.y - p2.y, 2));
}
```

#### c. Số ô sai vị trí (cho bài toán N-puzzle)

```java
public static int misplacedTiles(int[][] currentState, int[][] goalState, int n) {
    int count = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (currentState[i][j] != goalState[i][j] && currentState[i][j] != 0) {
                count++;
            }
        }
    }

    return count;
}
```

### 5. Ứng dụng trong các bài toán thực tế

#### a. Bài toán 8-puzzle (8-sliding puzzle)

```java
public class EightPuzzle {
    private static final int N = 3;
    private static final int[][] GOAL_STATE = {
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 0}
    };

    private static class PuzzleState {
        int[][] board;
        int zeroRow, zeroCol; // Vị trí của ô trống (giá trị 0)

        PuzzleState(int[][] board) {
            this.board = new int[N][N];
            for (int i = 0; i < N; i++) {
                for (int j = 0; j < N; j++) {
                    this.board[i][j] = board[i][j];
                    if (board[i][j] == 0) {
                        zeroRow = i;
                        zeroCol = j;
                    }
                }
            }
        }

        // Các di chuyển hợp lệ
        List<PuzzleState> getNeighbors() {
            List<PuzzleState> neighbors = new ArrayList<>();
            int[][] dirs = { {-1, 0}, {1, 0}, {0, -1}, {0, 1} }; // Up, Down, Left, Right

            for (int[] dir : dirs) {
                int newRow = zeroRow + dir[0];
                int newCol = zeroCol + dir[1];

                if (newRow >= 0 && newRow < N && newCol >= 0 && newCol < N) {
                    // Tạo trạng thái mới bằng cách đổi chỗ
                    int[][] newBoard = cloneBoard(board);
                    newBoard[zeroRow][zeroCol] = newBoard[newRow][newCol];
                    newBoard[newRow][newCol] = 0;

                    neighbors.add(new PuzzleState(newBoard));
                }
            }

            return neighbors;
        }

        private int[][] cloneBoard(int[][] board) {
            int[][] clone = new int[N][N];
            for (int i = 0; i < N; i++) {
                clone[i] = Arrays.copyOf(board[i], N);
            }
            return clone;
        }

        @Override
        public boolean equals(Object obj) {
            if (this == obj) return true;
            if (!(obj instanceof PuzzleState)) return false;

            PuzzleState other = (PuzzleState) obj;
            for (int i = 0; i < N; i++) {
                for (int j = 0; j < N; j++) {
                    if (board[i][j] != other.board[i][j]) {
                        return false;
                    }
                }
            }
            return true;
        }

        @Override
        public int hashCode() {
            return Arrays.deepHashCode(board);
        }
    }

    // Heuristic: Manhattan distance
    private static int manhattanDistance(PuzzleState state) {
        int distance = 0;
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                int value = state.board[i][j];
                if (value != 0) {
                    // Tính vị trí đích của số này
                    int goalRow = (value - 1) / N;
                    int goalCol = (value - 1) % N;

                    // Cộng khoảng cách Manhattan
                    distance += Math.abs(i - goalRow) + Math.abs(j - goalCol);
                }
            }
        }
        return distance;
    }

    public static List<PuzzleState> solvePuzzle(int[][] initialBoard) {
        PuzzleState initialState = new PuzzleState(initialBoard);
        PuzzleState goalState = new PuzzleState(GOAL_STATE);

        Set<PuzzleState> closedSet = new HashSet<>();
        Map<PuzzleState, PuzzleState> parent = new HashMap<>();
        Map<PuzzleState, Integer> gScore = new HashMap<>();

        gScore.put(initialState, 0);
        openSet.add(new Node(initialState, 0 + manhattanDistance(initialState)));

        while (!openSet.isEmpty()) {
            Node currentNode = openSet.poll();
            PuzzleState current = currentNode.state;

            if (current.equals(goalState)) {
                return reconstructPath(initialState, current, parent);
            }

            closedSet.add(current);

            for (PuzzleState neighbor : current.getNeighbors()) {
                if (closedSet.contains(neighbor)) {
                    continue;
                }

                int tentativeGScore = gScore.get(current) + 1; // Mỗi bước có chi phí 1

                if (!gScore.containsKey(neighbor) || tentativeGScore < gScore.get(neighbor)) {
                    parent.put(neighbor, current);
                    gScore.put(neighbor, tentativeGScore);
                    int fScore = tentativeGScore + manhattanDistance(neighbor);

                    openSet.add(new Node(neighbor, fScore));
                }
            }
        }

        return null; // Không tìm thấy lời giải
    }

    private static class Node {
        PuzzleState state;
        int fScore;

        Node(PuzzleState state, int fScore) {
            this.state = state;
            this.fScore = fScore;
        }
    }

    private static List<PuzzleState> reconstructPath(PuzzleState start, PuzzleState goal,
                                                   Map<PuzzleState, PuzzleState> parent) {
        List<PuzzleState> path = new ArrayList<>();
        PuzzleState current = goal;

        while (!current.equals(start)) {
            path.add(current);
            current = parent.get(current);
        }
        path.add(start);

        Collections.reverse(path);
        return path;
    }
}
```

#### b. Bài toán tìm đường đi trong mê cung

```java
public class MazeSolver {
    private static final int[][] DIRECTIONS = { {-1, 0}, {1, 0}, {0, -1}, {0, 1} }; // Up, Down, Left, Right

    private static class Point {
        int x, y;

        Point(int x, int y) {
            this.x = x;
            this.y = y;
        }

        @Override
        public boolean equals(Object obj) {
            if (this == obj) return true;
            if (!(obj instanceof Point)) return false;
            Point other = (Point) obj;
            return x == other.x && y == other.y;
        }

        @Override
        public int hashCode() {
            return 31 * x + y;
        }
    }

    public static List<Point> solveMaze(int[][] maze, Point start, Point goal) {
        int rows = maze.length;
        int cols = maze[0].length;

        // Kiểm tra đầu vào hợp lệ
        if (start.x < 0 || start.x >= rows || start.y < 0 || start.y >= col
            maze[start.x][start.y] == 1 || maze[goal.x][goal.y] == 1) {
            return null; // Điểm bắt đầu hoặc kết thúc không hợp lệ
        }

        // Hàng đợi ưu tiên cho A*
        PriorityQueue<Node> openSet = new PriorityQueue<>(
            Comparator.comparingDouble(node -> node.fScore)
        );

        // Tập đã thăm
        Set<Point> closedSet = new HashSet<>();

        // Lưu trữ đường đi
        Map<Point, Point> parent = new HashMap<>();

        // Chi phí từ điểm bắt đầu đến điểm hiện tại
        Map<Point, Double> gScore = new HashMap<>();
        gScore.put(start, 0.0);

        // Thêm điểm bắt đầu vào hàng đợi
        openSet.add(new Node(start, manhattanDistance(start, goal)));

        while (!openSet.isEmpty()) {
            Node current = openSet.poll();
            Point currentPos = current.position;

            if (currentPos.equals(goal)) {
                return reconstructPath(start, goal, parent);
            }

            closedSet.add(currentPos);

            // Xét tất cả các hướng di chuyển
            for (int[] dir : DIRECTIONS) {
                int newX = currentPos.x + dir[0];
                int newY = currentPos.y + dir[1];
                Point neighborPos = new Point(newX, newY);

                // Kiểm tra tính hợp lệ
                if (newX < 0 || newX >= rows || newY < 0 || newY >= cols ||
                    maze[newX][newY] == 1 || closedSet.contains(neighborPos)) {
                    continue;
                }

                double tentativeGScore = gScore.get(currentPos) + 1; // Mỗi bước có chi phí 1

                if (!gScore.containsKey(neighborPos) || tentativeGScore < gScore.get(neighborPos)) {
                    parent.put(neighborPos, currentPos);
                    gScore.put(neighborPos, tentativeGScore);

                    double fScore = tentativeGScore + manhattanDistance(neighborPos, goal);
                    openSet.add(new Node(neighborPos, fScore));
                }
            }
        }

        return null; // Không tìm thấy đường đi
    }

    private static double manhattanDistance(Point p1, Point p2) {
        return Math.abs(p1.x - p2.x) + Math.abs(p1.y - p2.y);
    }

    private static class Node {
        Point position;
        double fScore;

        Node(Point position, double fScore) {
            this.position = position;
            this.fScore = fScore;
        }
    }

    private static List<Point> reconstructPath(Point start, Point goal, Map<Point, Point> parent) {
        List<Point> path = new ArrayList<>();
        Point current = goal;

        while (!current.equals(start)) {
            path.add(current);
            current = parent.get(current);
        }
        path.add(start);

        Collections.reverse(path);
        return path;
    }
}
```

## 🧑‍🏫 Bài 5: Phân tích và tối ưu hóa thuật toán

### 1. Phân tích độ phức tạp thuật toán

#### a. Các ký hiệu tiệm cận (Asymptotic notation)

- **Big O (O)**: Giới hạn trên của độ phức tạp
- **Big Omega (Ω)**: Giới hạn dưới của độ phức tạp
- **Big Theta (Θ)**: Giới hạn chặt (cả trên và dưới) của độ phức tạp

```java
// O(1) - Thời gian hằng số
public static int getFirstElement(int[] array) {
    return array[0];
}

// O(log n) - Logarithmic
public static int binarySearch(int[] sortedArray, int key) {
    int low = 0;
    int high = sortedArray.length - 1;

    while (low <= high) {
        int mid = low + (high - low) / 2;

        if (sortedArray[mid] == key)
            return mid;
        else if (sortedArray[mid] < key)
            low = mid + 1;
        else
            high = mid - 1;
    }

    return -1;
}

// O(n) - Linear
public static int findMax(int[] array) {
    int max = array[0];
    for (int i = 1; i < array.length; i++) {
        if (array[i] > max) {
            max = array[i];
        }
    }
    return max;
}

// O(n log n) - Linearithmic
public static void mergeSort(int[] array) {
    // Implementation...
}

// O(n²) - Quadratic
public static void bubbleSort(int[] array) {
    for (int i = 0; i < array.length; i++) {
        for (int j = 0; j < array.length - 1; j++) {
            if (array[j] > array[j + 1]) {
                // Swap elements
                int temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }
}

// O(2^n) - Exponential
public static int fibonacci(int n) {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}
```

#### b. Phân tích trường hợp tốt nhất, trung bình và xấu nhất

```java
// Ví dụ: Tìm kiếm tuyến tính
public static int linearSearch(int[] array, int key) {
    for (int i = 0; i < array.length; i++) {
        if (array[i] == key) {
            return i;
        }
    }
    return -1;
}
```

- **Trường hợp tốt nhất**: O(1) - phần tử ở vị trí đầu tiên
- **Trường hợp trung bình**: O(n/2) ~ O(n) - phần tử ở giữa mảng
- **Trường hợp xấu nhất**: O(n) - phần tử ở cuối mảng hoặc không tồn tại

#### c. Phân tích không gian và thời gian

```java
// Phân tích thời gian và không gian cho thuật toán đệ quy
public static int factorialIterative(int n) {
    int result = 1;
    for (int i = 2; i <= n; i++) {
        result *= i;
    }
    return result;
}

public static int factorialRecursive(int n) {
    if (n <= 1) return 1;
    return n * factorialRecursive(n - 1);
}
```

- **factorialIterative**:

  - Độ phức tạp thời gian: O(n)
  - Độ phức tạp không gian: O(1)

- **factorialRecursive**:
  - Độ phức tạp thời gian: O(n)
  - Độ phức tạp không gian: O(n) do stack đệ quy

### 2. Các kỹ thuật tối ưu hóa thuật toán

#### a. Memoization và Dynamic Programming

```java
// Fibonacci không tối ưu
public static int fibNaive(int n) {
    if (n <= 1) return n;
    return fibNaive(n - 1) + fibNaive(n - 2);
}

// Fibonacci với memoization
public static int fibMemoization(int n) {
    int[] memo = new int[n + 1];
    Arrays.fill(memo, -1);
    return fibMemoHelper(n, memo);
}

private static int fibMemoHelper(int n, int[] memo) {
    if (n <= 1) return n;

    if (memo[n] != -1) return memo[n];

    memo[n] = fibMemoHelper(n - 1, memo) + fibMemoHelper(n - 2, memo);
    return memo[n];
}

// Fibonacci với dynamic programming (bottom-up)
public static int fibDP(int n) {
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

- **fibNaive**: O(2^n) thời gian, O(n) không gian
- **fibMemoization**: O(n) thời gian, O(n) không gian
- **fibDP**: O(n) thời gian, O(n) không gian

#### b. Tối ưu hóa vòng lặp và điều kiện

```java
// Trước khi tối ưu
public static boolean containsDuplicate(int[] nums) {
    for (int i = 0; i < nums.length; i++) {
        for (int j = 0; j < nums.length; j++) {
            if (i != j && nums[i] == nums[j]) {
                return true;
            }
        }
    }
    return false;
}

// Sau khi tối ưu
public static boolean containsDuplicateOptimized(int[] nums) {
    Set<Integer> seen = new HashSet<>();
    for (int num : nums) {
        if (seen.contains(num)) {
            return true;
        }
        seen.add(num);
    }
    return false;
}
```

- **containsDuplicate**: O(n²) thời gian, O(1) không gian
- **containsDuplicateOptimized**: O(n) thời gian, O(n) không gian

#### c. Sử dụng cấu trúc dữ liệu thích hợp

```java
// Không tối ưu: Tìm kiếm phần tử trong danh sách
public static boolean containsElement(List<Integer> list, int target) {
    for (int num : list) {
        if (num == target) {
            return true;
        }
    }
    return false;
    }
    return set.contains(target);
}
```

- **containsElement**: O(n) thời gian
- **containsElementOptimized**: O(1) thời gian trung bình (với HashSet)

#### d. Trao đổi giữa thời gian và không gian

```java
// Tính tổng các số từ 1 đến n
// Cách 1: O(n) thời gian, O(1) không gian
public static int sumToN(int n) {
    int sum = 0;
    for (int i = 1; i <= n; i++) {
        sum += i;
    }
    return sum;
}

// Cách 2: O(1) thời gian, O(1) không gian (công thức toán học)
public static int sumToNFormula(int n) {
    return n * (n + 1) / 2;
}
```

### 3. Kỹ thuật profile và benchmark

#### a. Đo thời gian thực thi

```java
public static void benchmarkAlgorithm(Runnable algorithm, String name, int iterations) {
    // Warm-up JVM
    for (int i = 0; i < 5; i++) {
        algorithm.run();
    }

    // Đo thời gian thực thi
    long startTime = System.nanoTime();

    for (int i = 0; i < iterations; i++) {
        algorithm.run();
    }

    long endTime = System.nanoTime();
    double avgTime = (endTime - startTime) / (double)iterations;

    System.out.printf("%s: %.3f ms per operation%n", name, avgTime / 1_000_000);
}
```

#### b. Đo lường sử dụng bộ nhớ

```java
public static void measureMemory(Supplier<?> factory, String name) {
    // Gọi garbage collector
    System.gc();

    long beforeMemory = Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory();

    // Tạo đối tượng
    Object obj = factory.get();

    // Đo lại bộ nhớ
    long afterMemory = Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory();

    System.out.printf("%s: ~%d bytes%n", name, afterMemory - beforeMemory);
}
```

#### c. Xác định bottlenecks

```java
public static void identifyBottlenecks(int[] sizes, Consumer<Integer> algorithm) {
    for (int size : sizes) {
        long startTime = System.nanoTime();
        algorithm.accept(size);
        long endTime = System.nanoTime();

        System.out.printf("Size %d: %.3f ms%n", size, (endTime - startTime) / 1_000_000.0);
    }
}
```

### 4. Các nguyên tắc tối ưu hóa thuật toán

#### a. Nguyên tắc "profile trước khi tối ưu"

- Xác định thực sự phần nào của thuật toán cần tối ưu
- Tập trung vào các phần chiếm nhiều tài nguyên nhất
- Sử dụng công cụ profiling để phân tích

#### b. Cân nhắc giữa khả năng đọc và hiệu suất

```java
// Phiên bản dễ đọc
public static Map<Character, Integer> countCharacters(String text) {
    Map<Character, Integer> charCount = new HashMap<>();
    for (char c : text.toCharArray()) {
        if (charCount.containsKey(c)) {
            charCount.put(c, charCount.get(c) + 1);
        } else {
            charCount.put(c, 1);
        }
    }

    return charCount;

}

// Phiên bản hiệu suất cao hơn nhưng ít dễ đọc hơn
public static Map<Character, Integer> countCharactersOptimized(String text) {
Map<Character, Integer> charCount = new HashMap<>();

    for (int i = 0; i < text.length(); i++) {
        char c = text.charAt(i);
        charCount.merge(c, 1, Integer::sum);
    }

    return charCount;

}

```

#### c. Tránh tối ưu hóa quá sớm

- Viết code đúng và dễ đọc trước
- Xác định yêu cầu hiệu suất cụ thể
- Chỉ tối ưu khi cần thiết

#### d. Tối ưu theo trường hợp sử dụng thực tế

- Hiểu rõ phân phối dữ liệu đầu vào
- Tối ưu cho trường hợp phổ biến nhất
- Cân nhắc các trường hợp biên và xấu nhất

Xây dựng một ứng dụng tìm đường đi ngắn nhất giữa các địa điểm trên bản đồ, sử dụng thuật toán Dijkstra hoặc A\* để xác định lộ trình tối ưu.

## **🧑‍💻 Bài tập lớn: Xây dựng ứng dụng GPS đơn giản dựa trên thuật toán đồ thị**

### 1. Mô tả dự án

Xây dựng một ứng dụng tìm đường đi ngắn nhất giữa các địa điểm trên bản đồ, sử dụng thuật toán Dijkstra hoặc A\* để xác định lộ trình tối ưu.

### 2. Các thành phần chính

#### a. Mô hình hóa bản đồ thành đồ thị

```java
public class MapGraph {
    private final Map<String, Map<String, Double>> adjacencyList;
    private final Map<String, Location> locations;

    public MapGraph() {
        this.adjacencyList = new HashMap<>();
        this.locations = new HashMap<>();
    }

    // Thêm một địa điểm mới vào bản đồ
    public void addLocation(String name, double latitude, double longitude) {
        Location location = new Location(name, latitude, longitude);
        locations.put(name, location);
        adjacencyList.putIfAbsent(name, new HashMap<>());
    }

    // Thêm đường đi giữa hai địa điểm
    public void addRoad(String from, String to, double distance) {
        if (!adjacencyList.containsKey(from) || !adjacencyList.containsKey(to))
            throw new IllegalArgumentException("Locations do not exist");

        // Đồ thị vô hướng - thêm cạnh hai chiều
        adjacencyList.get(from).put(to, distance);
        adjacencyList.get(to).put(from, distance);
    }

    // Lấy tất cả các địa điểm kề
    public Map<String, Double> getNeighbors(String location) {
        return adjacencyList.getOrDefault(location, Collections.emptyMap());
    }

    // Tính khoảng cách Haversine giữa hai địa điểm (heuristic cho A*)
    public double calculateDistance(String from, String to) {
        Location loc1 = locations.get(from);
        Location loc2 = locations.get(to);

        return haversineDistance(loc1.latitude, loc1.longitude,
                               loc2.latitude, loc2.longitude);
    }

    private double haversineDistance(double lat1, double lon1, double lat2, double lon2) {
        // Bán kính trái đất (km)
        final double R = 6371.0;

        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);

        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                   Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) *
                   Math.sin(dLon / 2) * Math.sin(dLon / 2);

        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

        return R * c;
    }
}
```

#### b. Thuật toán tìm đường đi ngắn nhất

```java
public class RouteFinder {
    private final MapGraph map;

    public RouteFinder(MapGraph map) {
        this.map = map;
    }

    // Thuật toán Dijkstra
    public List<String> findShortestPath(String start, String destination) {
        // Priority queue để lưu các điểm với khoảng cách nhỏ nhất
        PriorityQueue<Node> queue = new PriorityQueue<>(
            Comparator.comparingDouble(node -> node.distance)
        );

        Map<String, Double> distances = new HashMap<>();
        Map<String, String> previousNodes = new HashMap<>();
        Set<String> visited = new HashSet<>();

        // Khởi tạo
        distances.put(start, 0.0);
        queue.add(new Node(start, 0.0));

        while (!queue.isEmpty()) {
            Node current = queue.poll();
            String currentLocation = current.location;

            if (currentLocation.equals(destination)) {
                break;
            }

            if (visited.contains(currentLocation)) continue;
            visited.add(currentLocation);

            // Xét tất cả các địa điểm kề
            for (Map.Entry<String, Double> neighbor : map.getNeighbors(currentLocation).entrySet()) {
                String nextLocation = neighbor.getKey();
                double edgeWeight = neighbor.getValue();

                if (visited.contains(nextLocation)) continue;

                double newDistance = distances.get(currentLocation) + edgeWeight;

                if (!distances.containsKey(nextLocation) || newDistance < distances.get(nextLocation)) {
                    distances.put(nextLocation, newDistance);
                    previousNodes.put(nextLocation, currentLocation);
                    queue.add(new Node(nextLocation, newDistance));
                }
            }
        }

        // Không tìm thấy đường đi
        if (!previousNodes.containsKey(destination)) return null;

        // Xây dựng đường đi
        return reconstructPath(start, destination, previousNodes);
    }

    // Thuật toán A*
    public List<String> findShortestPathAStar(String start, String destination) {
        PriorityQueue<Node> openSet = new PriorityQueue<>(
            Comparator.comparingDouble(node -> node.fScore)
        );

        Map<String, Double> gScore = new HashMap<>();
        Map<String, Double> fScore = new HashMap<>();
        Map<String, String> previousNodes = new HashMap<>();
        Set<String> closedSet = new HashSet<>();

        // Khởi tạo
        gScore.put(start, 0.0);
        fScore.put(start, map.calculateDistance(start, destination));
        openSet.add(new Node(start, 0.0, fScore.get(start)));

        while (!openSet.isEmpty()) {
            Node current = openSet.poll();
            String currentLocation = current.location;

            if (currentLocation.equals(destination)) {
                return reconstructPath(start, destination, previousNodes);
            }

            closedSet.add(currentLocation);

            for (Map.Entry<String, Double> neighbor : map.getNeighbors(currentLocation).entrySet()) {
                String nextLocation = neighbor.getKey();
                double edgeWeight = neighbor.getValue();

                if (closedSet.contains(nextLocation)) continue;

                double tentativeGScore = gScore.get(currentLocation) + edgeWeight;

                if (!gScore.containsKey(nextLocation) || tentativeGScore < gScore.get(nextLocation)) {
                    previousNodes.put(nextLocation, currentLocation);
                    gScore.put(nextLocation, tentativeGScore);

                    double hScore = map.calculateDistance(nextLocation, destination);
                    fScore.put(nextLocation, tentativeGScore + hScore);

                    // Kiểm tra xem đã có trong openSet chưa
                    boolean inOpenSet = false;
                    for (Node node : openSet) {
                        if (node.location.equals(nextLocation)) {
                            inOpenSet = true;
                            break;
                        }
                    }

                    if (!inOpenSet) {
                        openSet.add(new Node(nextLocation, tentativeGScore, fScore.get(nextLocation)));
                    }
                }
            }
        }

        return null; // Không tìm thấy đường đi
    }

    private List<String> reconstructPath(String start, String destination, Map<String, String> previousNodes) {
        List<String> path = new ArrayList<>();
        String current = destination;

        while (!current.equals(start)) {
            path.add(current);
            current = previousNodes.get(current);
        }

        path.add(start);
        Collections.reverse(path);
        return path;
    }
}
```

#### c. Giao diện người dùng đơn giản

```java
public class GPSApplication {
    private final MapGraph map;
    private final RouteFinder routeFinder;
    private final Scanner scanner;

    public GPSApplication() {
        this.map = new MapGraph();
        this.routeFinder = new RouteFinder(map);
        this.scanner = new Scanner(System.in);

        // Khởi tạo dữ liệu bản đồ mẫu
        initializeMap();
    }

    private void initializeMap() {
        // Thêm các địa điểm
        map.addLocation("A", 10.762622, 106.660172); // TP.HCM
        map.addLocation("B", 21.028511, 105.804817); // Hà Nội
        map.addLocation("C", 16.047079, 108.206230); // Đà Nẵng
        map.addLocation("D", 12.248430, 109.192932); // Nha Trang
        map.addLocation("E", 11.935642, 108.442329); // Đà Lạt

        // Thêm các đường đi
        map.addRoad("A", "C", 850.0);
        map.addRoad("A", "D", 450.0);
        map.addRoad("A", "E", 300.0);
        map.addRoad("B", "C", 790.0);
        map.addRoad("C", "D", 520.0);
        map.addRoad("C", "E", 670.0);
        map.addRoad("D", "E", 180.0);
    }

    public void start() {
        System.out.println("---- Ứng dụng GPS đơn giản ----");

        while (true) {
            System.out.println("\nCác địa điểm có sẵn: A, B, C, D, E");

            System.out.print("Nhập điểm xuất phát (hoặc 'thoat' để kết thúc): ");
            String start = scanner.nextLine().trim().toUpperCase();

            if (start.equalsIgnoreCase("thoat")) {
                break;
            }

            System.out.print("Nhập điểm đến: ");
            String destination = scanner.nextLine().trim().toUpperCase();

            System.out.println("Chọn thuật toán:");
            System.out.println("1. Dijkstra");
            System.out.println("2. A*");
            System.out.print("Lựa chọn của bạn: ");
            int choice = Integer.parseInt(scanner.nextLine().trim());

            List<String> path;
            if (choice == 1) {
                path = routeFinder.findShortestPath(start, destination);
            } else {
                path = routeFinder.findShortestPathAStar(start, destination);
            }

            if (path == null || path.isEmpty()) {
                System.out.println("Không tìm thấy đường đi từ " + start + " đến " + destination);
            } else {
                System.out.println("Đường đi ngắn nhất từ " + start + " đến " + destination + ":");
                System.out.println(String.join(" -> ", path));

                // Tính tổng khoảng cách
                double totalDistance = calculatePathDistance(path);
                System.out.printf("Tổng khoảng cách: %.2f km\n", totalDistance);
            }
        }

        System.out.println("Cảm ơn bạn đã sử dụng ứng dụng!");
        scanner.close();
    }

    private double calculatePathDistance(List<String> path) {
        double distance = 0.0;
        for (int i = 0; i < path.size() - 1; i++) {
            String current = path.get(i);
            String next = path.get(i + 1);

            Map<String, Double> neighbors = map.getNeighbors(current);
            distance += neighbors.get(next);
        }
        return distance;
    }
}
```

### 3. Các cải tiến và mở rộng

- Thêm dữ liệu về thời gian di chuyển và giao thông
- Cho phép người dùng thêm địa điểm mới
- Tích hợp với bản đồ thực tế (OpenStreetMap API)
- Xây dựng giao diện đồ họa
- Tối ưu hóa tính toán với các cấu trúc dữ liệu nâng cao

---

[⬅️ Trở lại: DSA/Part4.md](../DSA/Part4.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: WEB/Part1.md](../WEB/Part1.md)
