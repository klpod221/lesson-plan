---
prev:
  text: '🔍 Specialized Data Structures'
  link: '/DSA/Part4'
next:
  text: '📝 Module 6: Introduction to HTML'
  link: '/WEB/Part1'
---

# 📘 PART 5: APPLIED ALGORITHMS AND OPTIMIZATION

## 🎯 General Objectives

- Master string processing algorithms and their applications in real-world problems.
- Understand and proficiently apply Two Pointers and Sliding Window techniques.
- Master the Divide and Conquer method and apply it to solve complex problems.
- Master search techniques within a state space.
- Learn how to analyze and optimize algorithms effectively.
- Build a practical application using graph algorithms.

## 🧑‍🏫 Lesson 1: String Processing Algorithms

### 1. String Matching

#### a. Brute Force Algorithm

The simplest method to find a substring within a main string.

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
            return i; // Pattern found at position i
        }
    }
    return -1; // Not found
}
```

- **Complexity**: O(n\*m) where n is the length of the main text, m is the length of the pattern.

#### b. Knuth-Morris-Pratt (KMP) Algorithm

KMP is a more efficient string search algorithm that utilizes information from previous matches.

```java
public static int KMPSearch(String text, String pattern) {
    int n = text.length();
    int m = pattern.length();

    // Create lps[] to store the longest prefix which is also a suffix
    int[] lps = computeLPSArray(pattern);

    int i = 0; // index for text[]
    int j = 0; // index for pattern[]

    while (i < n) {
        if (pattern.charAt(j) == text.charAt(i)) {
            i++;
            j++;
        }

        if (j == m) {
            return i - j; // Pattern found
        } else if (i < n && pattern.charAt(j) != text.charAt(i)) {
            if (j != 0) {
                j = lps[j - 1];
            } else {
                i++;
            }
        }
    }
    return -1; // Not found
}

// Function to compute the lps (longest prefix suffix) array
public static int[] computeLPSArray(String pattern) {
    int m = pattern.length();
    int[] lps = new int[m];

    int len = 0; // length of the previous longest prefix suffix
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

- **Complexity**: O(n+m) in the best and average cases.

#### c. Boyer-Moore Algorithm

An efficient string search algorithm, especially when the search pattern is long.

```java
public static int boyerMooreSearch(String text, String pattern) {
    int n = text.length();
    int m = pattern.length();

    // Create bad character table
    Map<Character, Integer> badChar = new HashMap<>();

    // Initialize bad character table
    for (int i = 0; i < m; i++) {
        badChar.put(pattern.charAt(i), i);
    }

    int s = 0; // s is the shift of the pattern with respect to text

    while (s <= (n - m)) {
        int j = m - 1;

        // Check from right to left
        while (j >= 0 && pattern.charAt(j) == text.charAt(s + j)) {
            j--;
        }

        if (j < 0) {
            return s; // Found
        } else {
            // Shift the pattern based on the bad character rule
            char badCharacter = text.charAt(s + j);
            int shift = badChar.containsKey(badCharacter) ?
                        Math.max(1, j - badChar.get(badCharacter)) : j + 1;
            s += shift;
        }
    }

    return -1; // Not found
}
```

- **Complexity**: O(n\*m) in the worst case, but typically much faster in practice.

#### d. Rabin-Karp Algorithm

Uses hashing to compare strings efficiently.

```java
public static int rabinKarpSearch(String text, String pattern) {
    int n = text.length();
    int m = pattern.length();
    int d = 256; // Number of characters in the input alphabet
    int q = 101; // A prime number

    int p = 0; // Hash value for pattern
    int t = 0; // Hash value for text
    int h = 1;

    // The value of h would be "pow(d, m-1)%q"
    for (int i = 0; i < m - 1; i++) {
        h = (h * d) % q;
    }

    // Calculate the hash value of pattern and first window of text
    for (int i = 0; i < m; i++) {
        p = (d * p + pattern.charAt(i)) % q;
        t = (d * t + text.charAt(i)) % q;
    }

    // Slide the pattern over text one by one
    for (int i = 0; i <= n - m; i++) {
        // If the hash values match then only check for characters one by one
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

        // Calculate hash value for next window of text: Remove leading digit, add trailing digit
        if (i < n - m) {
            t = (d * (t - text.charAt(i) * h) + text.charAt(i + m)) % q;
            if (t < 0) t += q;
        }
    }

    return -1; // Not found
}
```

- **Complexity**: O(n+m) in best and average cases, O(n\*m) in worst case.

### 2. Advanced String Processing

#### a. Z Algorithm

The Z algorithm finds all occurrences of a pattern in a text by constructing a Z-array.

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

// Find all occurrences of pattern in text
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

- **Complexity**: O(n+m) where n is text length, m is pattern length.

#### b. Manacher's Algorithm (Longest Palindromic Substring)

Manacher's algorithm finds the longest palindromic substring in linear time.

```java
public static String longestPalindrome(String s) {
    // Process string by adding '#' characters between letters
    StringBuilder sb = new StringBuilder();
    sb.append('#');
    for (char c : s.toCharArray()) {
        sb.append(c).append('#');
    }
    String t = sb.toString();

    int n = t.length();
    int[] p = new int[n]; // p[i] is the radius of the palindrome at center i

    int c = 0, r = 0; // c is the center, r is the right boundary
    int maxLen = 0, centerIndex = 0;

    for (int i = 0; i < n; i++) {
        // Exploit symmetry
        if (r > i) {
            p[i] = Math.min(r - i, p[2 * c - i]);
        }

        // Expand palindrome
        while (i + p[i] + 1 < n && i - p[i] - 1 >= 0 &&
               t.charAt(i + p[i] + 1) == t.charAt(i - p[i] - 1)) {
            p[i]++;
        }

        // Update center and right boundary
        if (i + p[i] > r) {
            c = i;
            r = i + p[i];
        }

        // Update result
        if (p[i] > maxLen) {
            maxLen = p[i];
            centerIndex = i;
        }
    }

    int start = (centerIndex - maxLen) / 2;
    return s.substring(start, start + maxLen);
}
```

- **Complexity**: O(n) where n is the length of the string.

#### c. Suffix Array and LCP Array

Suffix Array is a sorted array of all suffixes of a string. LCP Array (Longest Common Prefix) stores the length of the longest common prefix between consecutive suffixes in the suffix array.

```java
public class SuffixArray {
    public static int[] buildSuffixArray(String s) {
        int n = s.length();
        Suffix[] suffixes = new Suffix[n];

        // Store suffixes and their indexes
        for (int i = 0; i < n; i++) {
            suffixes[i] = new Suffix(i, s.substring(i));
        }

        // Sort suffixes
        Arrays.sort(suffixes);

        // Store indexes of sorted suffixes
        int[] suffixArr = new int[n];
        for (int i = 0; i < n; i++) {
            suffixArr[i] = suffixes[i].index;
        }

        return suffixArr;
    }

    // Build LCP Array
    public static int[] buildLCPArray(String s, int[] suffixArr) {
        int n = s.length();
        int[] lcp = new int[n];

        // Rank array to store the rank of each suffix in suffix array
        int[] rank = new int[n];
        for (int i = 0; i < n; i++) {
            rank[suffixArr[i]] = i;
        }

        int h = 0; // Current LCP length
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

- **Complexity**: O(n log n) for building suffix array, O(n) for LCP array.

### 3. Applications of String Algorithms

#### a. Pattern Matching in Text and DNA

```java
public static List<Integer> findPatternInDNA(String dnaSequence, String pattern) {
    // Use KMP to find all occurrences
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

#### b. Longest Common Substring

```java
public static String longestCommonSubstring(String s1, String s2) {
    int m = s1.length();
    int n = s2.length();
    int[][] dp = new int[m + 1][n + 1];

    // Variables to track max length and ending position
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

    // Extract substring
    return s1.substring(endIndex - maxLength + 1, endIndex + 1);
}
```

- **Complexity**: O(m \* n) where m, n are lengths of the two strings.

#### c. Longest Common Substring for Multiple Strings

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

#### d. Run-Length Encoding

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

    // Handle the last part
    compressed.append(currentChar);
    if (count > 1) {
        compressed.append(count);
    }

    return compressed.length() < s.length() ? compressed.toString() : s;
}
```

### 4. Comparison of String Search Algorithms

| Algorithm | Preprocessing | Searching | Best Case | Pros | Cons |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Brute Force | None | O(n\*m) | O(n) | Simple, easy to implement | Slow with long patterns/text |
| KMP | O(m) | O(n) | O(n) | Efficient for all pattern types | Complex to implement correctly |
| Boyer-Moore | O(m + alphabet) | O(n/m) -> O(n\*m) | O(n/m) | Very fast in practice | Complex, requires memory for tables |
| Rabin-Karp | O(m) | O(n\*m) -> O(n+m) | O(n+m) | Good for multiple pattern search | Potential hash collisions |

Where n is the length of the main text and m is the length of the search pattern.

## 🧑‍🏫 Lesson 2: Two Pointers and Sliding Window Techniques

### 1. Two Pointers Technique

The Two Pointers technique involves using two pointers (or indices) to traverse a data structure, typically an array or a linked list.

#### a. Same Direction

Two pointers move in the same direction, but at different speeds.

Example 1: Remove duplicates from sorted array

```java
public static int removeDuplicates(int[] nums) {
    if (nums.length == 0) return 0;

    int slow = 0; // Slow pointer (write position)

    for (int fast = 1; fast < nums.length; fast++) {
        if (nums[fast] != nums[slow]) {
            slow++;
            nums[slow] = nums[fast];
        }
    }

    return slow + 1; // New array length
}
```

- **Time Complexity**: O(n)
- **Space Complexity**: O(1)

Example 2: Move Zeroes to the end

```java
public static void moveZeroes(int[] nums) {
    int nonZeroPtr = 0;

    // Move all non-zero elements to the start
    for (int i = 0; i < nums.length; i++) {
        if (nums[i] != 0) {
            nums[nonZeroPtr++] = nums[i];
        }
    }

    // Fill remaining positions with 0
    while (nonZeroPtr < nums.length) {
        nums[nonZeroPtr++] = 0;
    }
}
```

- **Time Complexity**: O(n)
- **Space Complexity**: O(1)

#### b. Opposite Direction

One pointer starts from the beginning, the other starts from the end.

Example 1: Reverse Array

```java
public static void reverseArray(int[] nums) {
    int left = 0;
    int right = nums.length - 1;

    while (left < right) {
        // Swap elements at both ends
        int temp = nums[left];
        nums[left] = nums[right];
        nums[right] = temp;

        // Move pointers
        left++;
        right--;
    }
}
```

- **Time Complexity**: O(n)
- **Space Complexity**: O(1)

Example 2: Two Sum - Input array is sorted

```java
public static boolean hasPairWithSum(int[] nums, int target) {
    int left = 0;
    int right = nums.length - 1;

    while (left < right) {
        int sum = nums[left] + nums[right];

        if (sum == target) {
            return true; // Pair found
        } else if (sum < target) {
            left++; // Increase sum by moving left pointer
        } else {
            right--; // Decrease sum by moving right pointer
        }
    }

    return false; // No pair found
}
```

- **Time Complexity**: O(n)
- **Space Complexity**: O(1)

Example 3: Valid Palindrome

```java
public static boolean isPalindrome(String s) {
    // Remove non-alphanumeric characters, convert to lowercase
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

- **Time Complexity**: O(n)
- **Space Complexity**: O(n) due to creating a new string

#### c. Two Pointers on Two Arrays

Each pointer traverses a different array.

Example: Merge Sorted Arrays

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

    // Copy remaining elements if any
    while (i < n) {
        result[k++] = nums1[i++];
    }

    while (j < m) {
        result[k++] = nums2[j++];
    }

    return result;
}
```

- **Time Complexity**: O(n+m)
- **Space Complexity**: O(n+m)

### 2. Sliding Window Technique

The sliding window technique involves maintaining a "window" of elements in an array or string and sliding this window over the data.

#### a. Fixed Size Window

The window size remains constant during traversal.

Example 1: Max Sum Subarray of size K

```java
public static int maxSumSubarrayOfSizeK(int[] arr, int k) {
    if (arr.length < k) {
        return -1; // Array smaller than window size
    }

    // Calculate sum of first k elements
    int windowSum = 0;
    for (int i = 0; i < k; i++) {
        windowSum += arr[i];
    }

    int maxSum = windowSum;

    // Slide window and update sum
    for (int i = k; i < arr.length; i++) {
        windowSum = windowSum + arr[i] - arr[i - k];
        maxSum = Math.max(maxSum, windowSum);
    }

    return maxSum;
}
```

- **Time Complexity**: O(n)
- **Space Complexity**: O(1)

Example 2: Averages of Subarrays of Size K

```java
public static double[] findAverages(int[] arr, int k) {
    double[] result = new double[arr.length - k + 1];

    double windowSum = 0;
    int windowStart = 0;

    for (int windowEnd = 0; windowEnd < arr.length; windowEnd++) {
        windowSum += arr[windowEnd]; // Add to window

        // When size k is reached
        if (windowEnd >= k - 1) {
            result[windowStart] = windowSum / k; // Calculate average
            windowSum -= arr[windowStart]; // Remove first element
            windowStart++; // Slide window
        }
    }

    return result;
}
```

- **Time Complexity**: O(n)
- **Space Complexity**: O(n-k+1) for result array

#### b. Variable Size Window

The window size changes dynamically based on certain conditions.

Example 1: Smallest Subarray with a given sum

```java
public static int smallestSubarrayWithSum(int[] arr, int targetSum) {
    int windowSum = 0;
    int windowStart = 0;
    int minLength = Integer.MAX_VALUE;

    for (int windowEnd = 0; windowEnd < arr.length; windowEnd++) {
        windowSum += arr[windowEnd]; // Add to window

        // Shrink window while sum >= targetSum
        while (windowSum >= targetSum) {
            minLength = Math.min(minLength, windowEnd - windowStart + 1);
            windowSum -= arr[windowStart];
            windowStart++;
        }
    }

    return minLength == Integer.MAX_VALUE ? 0 : minLength;
}
```

- **Time Complexity**: O(n)
- **Space Complexity**: O(1)

Example 2: Longest Substring Without Repeating Characters

```java
public static int lengthOfLongestSubstring(String s) {
    int[] charIndex = new int[128]; // Store character indices
    Arrays.fill(charIndex, -1); // Initialize all to -1

    int maxLength = 0;
    int windowStart = 0;

    for (int windowEnd = 0; windowEnd < s.length(); windowEnd++) {
        char rightChar = s.charAt(windowEnd);

        // If char already appeared after current window start
        if (charIndex[rightChar] >= windowStart) {
            // Move window start to after the character's last position
            windowStart = charIndex[rightChar] + 1;
        }

        // Update character position
        charIndex[rightChar] = windowEnd;

        // Update max length
        maxLength = Math.max(maxLength, windowEnd - windowStart + 1);
    }

    return maxLength;
}
```

- **Time Complexity**: O(n)
- **Space Complexity**: O(1) assuming fixed ASCII charset

Example 3: Longest Substring with K Distinct Characters

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

        // Shrink window when distinct characters > k
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

- **Time Complexity**: O(n)
- **Space Complexity**: O(k)

### 3. Applications and Real-world Problems

#### a. Partition Equal Subset Sum

```java
public static boolean canPartitionArray(int[] nums) {
    int totalSum = 0;
    for (int num : nums) {
        totalSum += num;
    }

    // If sum is odd, cannot be divided into 2 equal parts
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

- **Time Complexity**: O(n \* sum/2)
- **Space Complexity**: O(sum/2)

#### b. 3Sum (Find three numbers that sum to 0)

```java
public static List<List<Integer>> threeSum(int[] nums) {
    List<List<Integer>> result = new ArrayList<>();
    if (nums.length < 3) return result;

    Arrays.sort(nums);

    for (int i = 0; i < nums.length - 2; i++) {
        // Skip duplicates
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
                // Triplet found
                result.add(Arrays.asList(nums[i], nums[left], nums[right]));

                // Skip duplicates
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

- **Time Complexity**: O(n²)
- **Space Complexity**: O(n) for result list

#### c. Find All Anagrams in a String

```java
public static List<Integer> findAnagrams(String s, String p) {
    List<Integer> result = new ArrayList<>();
    if (s.length() < p.length()) return result;

    int[] charCount = new int[26]; // Count chars in p
    for (char c : p.toCharArray()) {
        charCount[c - 'a']++;
    }

    int windowStart = 0;
    int matched = 0; // Number of matched characters

    for (int windowEnd = 0; windowEnd < s.length(); windowEnd++) {
        char rightChar = s.charAt(windowEnd);

        // Decrease count for char entering window
        charCount[rightChar - 'a']--;

        // If count >= 0, it matched a character from p
        if (charCount[rightChar - 'a'] >= 0) {
            matched++;
        }

        // If all characters matched
        if (matched == p.length()) {
            result.add(windowStart);
        }

        // When window reaches size p.length()
        if (windowEnd >= p.length() - 1) {
            char leftChar = s.charAt(windowStart);
            windowStart++;

            // If character leaving window was a match
            if (charCount[leftChar - 'a'] >= 0) {
                matched--;
            }

            // Increase count as char leaves window
            charCount[leftChar - 'a']++;
        }
    }

    return result;
}
```

- **Time Complexity**: O(n)
- **Space Complexity**: O(1) since we use a fixed array of size 26

### 4. Comparison of Two Techniques

| Criteria | Two Pointers | Sliding Window |
| :--- | :--- | :--- |
| **Main Application** | Find pairs, reverse array/string | Find contiguous subarrays satisfying a condition |
| **Approach** | Uses two distinct indices | Uses two indices defining start and end of a window |
| **Movement** | Can be same or opposite direction | Always one direction (forward) |
| **Size** | Does not maintain fixed size | Can be fixed or variable |
| **Complexity** | Typically O(n) | Typically O(n) |
| **Suitable Problems** | Sorted arrays, sum search... | Contiguous subarrays, substrings... |

## 🧑‍🏫 Lesson 3: Divide and Conquer Algorithms

### 1. Divide and Conquer Principle

Divide and Conquer is an algorithm design paradigm based on:

1.  **Divide**: Break the problem into smaller sub-problems of the same type.
2.  **Conquer**: Solve the sub-problems recursively.
3.  **Combine**: Merge the solutions of sub-problems to create the solution for the original problem.

#### General Structure of Divide and Conquer Algorithm

```java
public Type divideAndConquer(Problem problem) {
    if (problem.size() <= threshold) {
        return solveDirectly(problem);
    }

    // Divide into sub-problems
    Problem[] subproblems = divideIntoParts(problem);

    // Solve each sub-problem
    Type[] subresults = new Type[subproblems.length];
    for (int i = 0; i < subproblems.length; i++) {
        subresults[i] = divideAndConquer(subproblems[i]);
    }

    // Combine results
    return combineResults(subresults);
}
```

### 2. Basic Divide and Conquer Algorithms

#### a. Merge Sort

Merge Sort divides the array into two halves, sorts each half, and then merges them back together.

```java
public static void mergeSort(int[] arr, int left, int right) {
    if (left < right) {
        // Find the middle point
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

    // Merge arrays
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

- **Time Complexity**: O(n log n)
- **Space Complexity**: O(n)

#### b. Quick Sort

Quick Sort picks an element as a "pivot" and partitions the array around the picked pivot so that elements smaller than the pivot are on the left and elements greater are on the right.

```java
public static void quickSort(int[] arr, int low, int high) {
    if (low < high) {
        // Get pivot index after partitioning
        int pi = partition(arr, low, high);

        // Sort elements before and after pivot
        quickSort(arr, low, pi - 1);
        quickSort(arr, pi + 1, high);
    }
}

private static int partition(int[] arr, int low, int high) {
    int pivot = arr[high]; // Choose last element as pivot
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

    // Swap arr[i+1] and arr[high] (pivot)
    int temp = arr[i + 1];
    arr[i + 1] = arr[high];
    arr[high] = temp;

    return i + 1; // Return pivot index
}
```

- **Time Complexity**: Average O(n log n), Worst case O(n²)
- **Space Complexity**: O(log n) for recursion stack

#### c. Binary Search

Efficiently searches a sorted array by repeatedly dividing the search interval in half.

```java
public static int binarySearch(int[] arr, int target) {
    return binarySearchRecursive(arr, target, 0, arr.length - 1);
}

private static int binarySearchRecursive(int[] arr, int target, int left, int right) {
    if (left > right) {
        return -1; // Not found
    }

    int mid = left + (right - left) / 2;

    // If element is present at the middle itself
    if (arr[mid] == target) {
        return mid;
    }

    // If element is smaller than mid, then it can only be present in left subarray
    if (arr[mid] < target) {
        return binarySearchRecursive(arr, target, mid + 1, right);
    }

    // Else the element can only be present in right subarray
    return binarySearchRecursive(arr, target, left, mid - 1);
}
```

- **Time Complexity**: O(log n)
- **Space Complexity**: O(log n) for recursion stack (or O(1) if iterative)

### 3. Advanced Divide and Conquer

#### a. Majority Element

Finding an element that appears more than n/2 times in an array (using D&C approach).

```java
public static int majorityElement(int[] nums) {
    return majorityElementRec(nums, 0, nums.length - 1);
}

private static int majorityElementRec(int[] nums, int lo, int hi) {
    // Base case: only one element
    if (lo == hi) {
        return nums[lo];
    }

    // Divide array into two halves
    int mid = lo + (hi - lo) / 2;
    int left = majorityElementRec(nums, lo, mid);
    int right = majorityElementRec(nums, mid + 1, hi);

    // If two halves agree on the majority element
    if (left == right) {
        return left;
    }

    // Count occurrences of left and right candidates
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

- **Time Complexity**: O(n log n)
- **Space Complexity**: O(log n) for recursion stack

#### b. Closest Pair of Points

Finding the pair of points with the smallest distance in a set of 2D points.

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
    // Sort points by x-coordinate
    Arrays.sort(points, Comparator.comparingDouble(p -> p.x));

    return closestPairRec(points, 0, points.length - 1);
}

private static double closestPairRec(Point[] points, int start, int end) {
    // If fewer than 4 points, use brute force
    if (end - start <= 3) {
        return bruteForceClosest(points, start, end);
    }

    // Find middle point
    int mid = start + (end - start) / 2;
    Point midPoint = points[mid];

    // Find smallest distance in left and right halves
    double dl = closestPairRec(points, start, mid);
    double dr = closestPairRec(points, mid + 1, end);

    // Get the minimum distance
    double d = Math.min(dl, dr);

    // Create a strip of points where |x - mid.x| < d
    List<Point> strip = new ArrayList<>();
    for (int i = start; i <= end; i++) {
        if (Math.abs(points[i].x - midPoint.x) < d) {
            strip.add(points[i]);
        }
    }

    // Sort strip points by y
    strip.sort(Comparator.comparingDouble(p -> p.y));

    // Find closest points in strip
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

- **Time Complexity**: O(n log² n)
- **Space Complexity**: O(n)

#### c. Strassen Matrix Multiplication

An improvement over standard matrix multiplication, reducing complexity from O(n³) to O(n^log₂7) ≈ O(n^2.81) by reducing the number of multiplications.

```java
public static int[][] strassenMatrixMultiply(int[][] A, int[][] B) {
    int n = A.length;
    int[][] result = new int[n][n];

    // Base case
    if (n == 1) {
        result[0][0] = A[0][0] * B[0][0];
        return result;
    }

    // Divide matrices into 4 parts
    int mid = n / 2;
    int[][] A11 = new int[mid][mid];
    int[][] A12 = new int[mid][mid];
    int[][] A21 = new int[mid][mid];
    int[][] A22 = new int[mid][mid];
    int[][] B11 = new int[mid][mid];
    int[][] B12 = new int[mid][mid];
    int[][] B21 = new int[mid][mid];
    int[][] B22 = new int[mid][mid];

    // Split matrices A and B
    splitMatrix(A, A11, A12, A21, A22);
    splitMatrix(B, B11, B12, B21, B22);

    // Step 1: Calculate 7 product matrices P1 to P7
    int[][] P1 = strassenMatrixMultiply(addMatrices(A11, A22), addMatrices(B11, B22));
    int[][] P2 = strassenMatrixMultiply(addMatrices(A21, A22), B11);
    int[][] P3 = strassenMatrixMultiply(A11, subtractMatrices(B12, B22));
    int[][] P4 = strassenMatrixMultiply(A22, subtractMatrices(B21, B11));
    int[][] P5 = strassenMatrixMultiply(addMatrices(A11, A12), B22);
    int[][] P6 = strassenMatrixMultiply(subtractMatrices(A21, A11), addMatrices(B11, B12));
    int[][] P7 = strassenMatrixMultiply(subtractMatrices(A12, A22), addMatrices(B21, B22));

    // Step 2: Calculate parts of result matrix
    int[][] C11 = addMatrices(subtractMatrices(addMatrices(P1, P4), P5), P7);
    int[][] C12 = addMatrices(P3, P5);
    int[][] C21 = addMatrices(P2, P4);
    int[][] C22 = addMatrices(subtractMatrices(addMatrices(P1, P3), P2), P6);

    // Step 3: Combine parts into result matrix
    combineMatrices(result, C11, C12, C21, C22);

    return result;
}

// Helper method to split matrix
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

// Helper method to combine matrix
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

// Helper method to add two matrices
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

// Helper method to subtract two matrices
private static int[][] subtractMatrices(int[][] A, int[][] B) {
    int n = A.length;
    int[][] result = new int[n][n];

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            result[i][j] = A[i][j] - B[i][j];
        }
    }

    return result;
}
```

## 🧑‍🏫 Lesson 4: State Space Search

### 1. Introduction to State Space

State space is the set of all possible states of a problem, where:

- Each node represents a state.
- Edges represent actions transitioning from one state to another.

### 2. Uninformed Search

#### a. Breadth-First Search (BFS)

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
            if (!visited.contains(neighbor)) {
                visited.add(neighbor);
                parent.put(neighbor, currentState);
                queue.add(new Node<>(neighbor, currentState));
            }
        }
    }

    return null; // Path not found
}
```

- **Time Complexity**: O(b^d), where b is average branching factor and d is depth of goal.
- **Space Complexity**: O(b^d).
- **Properties**: Finds the shortest path, complete if b is finite.

#### b. Depth-First Search (DFS)

```java
public static <T> List<T> depthFirstSearch(Graph<T> graph, T start, T goal) {
    Set<T> visited = new HashSet<>();
    Map<T, T> parent = new HashMap<>();

    boolean found = dfsRecursive(graph, start, goal, visited, parent);

    if (found) {
        return reconstructPath(start, goal, parent);
    }

    return null; // Path not found
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

- **Time Complexity**: O(b^m), where b is average branching factor and m is maximum depth.
- **Space Complexity**: O(bm).
- **Properties**: Does not guarantee shortest path, complete if state space is finite.

#### c. Depth-Limited Search

```java
public static <T> List<T> depthLimitedSearch(Graph<T> graph, T start, T goal, int depthLimit) {
    Set<T> visited = new HashSet<>();
    Map<T, T> parent = new HashMap<>();

    Result result = dfsLimited(graph, start, goal, depthLimit, visited, parent);

    if (result == Result.FOUND) {
        return reconstructPath(start, goal, parent);
    }

    return null; // Not found or cutoff
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

- **Time Complexity**: O(b^L), where b is branching factor and L is depth limit.
- **Space Complexity**: O(bL).
- **Properties**: Does not guarantee shortest path, complete if goal is within depth limit.

#### d. Iterative Deepening DFS

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

    return null; // Not found within max depth limit
}
```

- **Time Complexity**: O(b^d), where b is branching factor and d is depth of goal.
- **Space Complexity**: O(bd).
- **Properties**: Combines advantages of DFS (memory efficiency) and BFS (shortest path).

### 3. Informed Search Algorithms

#### a. Best-First Search

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

    return null; // Path not found
}

interface Heuristic<T> {
    double estimate(T current, T goal);
}
```

- **Time Complexity**: O(b^m), where b is branching factor and m is max depth.
- **Properties**: Does not guarantee shortest path, but usually faster than uninformed methods.

#### b. A\* Search Algorithm

```java
public static <T> List<T> aStarSearch(Graph<T> graph, T start, T goal, Heuristic<T> heuristic, CostFunction<T> costFn) {
    PriorityQueue<Node<T>> openSet = new PriorityQueue<>(
        Comparator.comparingDouble(node -> node.priority)
    );
    Set<T> closedSet = new HashSet<>();
    Map<T, T> parent = new HashMap<>();
    Map<T, Double> gScore = new HashMap<>(); // Cost from start to current node

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

            // Calculate cost from start to neighbor via currentState
            double tentativeGScore = gScore.get(currentState) +
                                     costFn.getCost(currentState, neighbor);

            if (!gScore.containsKey(neighbor) || tentativeGScore < gScore.get(neighbor)) {
                // Found a better path
                parent.put(neighbor, currentState);
                gScore.put(neighbor, tentativeGScore);

                // f(n) = g(n) + h(n)
                double fScore = tentativeGScore + heuristic.estimate(neighbor, goal);

                // Update or add to openSet
                openSet.add(new Node<>(neighbor, currentState, fScore));
            }
        }
    }

    return null; // Path not found
}

interface CostFunction<T> {
    double getCost(T current, T neighbor);
}
```

- **Time Complexity**: O(b^d), where b is branching factor and d is depth of goal.
- **Properties**: Guarantees shortest path if heuristic is admissible (never overestimates the cost to reach the goal).

### 4. Common Heuristic Strategies

#### a. Manhattan Distance

Used for grid movement with 4 directions (up, down, left, right).

```java
public static int manhattanDistance(Point p1, Point p2) {
    return Math.abs(p1.x - p2.x) + Math.abs(p1.y - p2.y);
}
```

#### b. Euclidean Distance

Used for movement in 2D or 3D space.

```java
public static double euclideanDistance(Point p1, Point p2) {
    return Math.sqrt(Math.pow(p1.x - p2.x, 2) + Math.pow(p1.y - p2.y, 2));
}
```

#### c. Misplaced Tiles (for N-puzzle)

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

### 5. Real-world Applications

#### a. 8-Puzzle Problem (Sliding Puzzle)

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
        int zeroRow, zeroCol; // Position of empty tile (value 0)

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

        // Valid moves
        List<PuzzleState> getNeighbors() {
            List<PuzzleState> neighbors = new ArrayList<>();
            int[][] dirs = { {-1, 0}, {1, 0}, {0, -1}, {0, 1} }; // Up, Down, Left, Right

            for (int[] dir : dirs) {
                int newRow = zeroRow + dir[0];
                int newCol = zeroCol + dir[1];

                if (newRow >= 0 && newRow < N && newCol >= 0 && newCol < N) {
                    // Create new state by swapping
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
                    // Calculate goal position of this number
                    int goalRow = (value - 1) / N;
                    int goalCol = (value - 1) % N;

                    // Add Manhattan distance
                    distance += Math.abs(i - goalRow) + Math.abs(j - goalCol);
                }
            }
        }
        return distance;
    }

    public static List<PuzzleState> solvePuzzle(int[][] initialBoard) {
        PuzzleState initialState = new PuzzleState(initialBoard);
        PuzzleState goalState = new PuzzleState(GOAL_STATE);
        
        PriorityQueue<Node> openSet = new PriorityQueue<>(
            Comparator.comparingInt(n -> n.fScore)
        );

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

                int tentativeGScore = gScore.get(current) + 1; // Each step costs 1

                if (!gScore.containsKey(neighbor) || tentativeGScore < gScore.get(neighbor)) {
                    parent.put(neighbor, current);
                    gScore.put(neighbor, tentativeGScore);
                    int fScore = tentativeGScore + manhattanDistance(neighbor);

                    openSet.add(new Node(neighbor, fScore));
                }
            }
        }

        return null; // Solution not found
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

#### b. Maze Solving

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

        // Check for valid input
        if (start.x < 0 || start.x >= rows || start.y < 0 || start.y >= cols ||
            maze[start.x][start.y] == 1 || maze[goal.x][goal.y] == 1) {
            return null; // Invalid start or end point
        }

        // Priority Queue for A*
        PriorityQueue<Node> openSet = new PriorityQueue<>(
            Comparator.comparingDouble(node -> node.fScore)
        );

        // Visited set
        Set<Point> closedSet = new HashSet<>();

        // Store path
        Map<Point, Point> parent = new HashMap<>();

        // Cost from start to current point
        Map<Point, Double> gScore = new HashMap<>();
        gScore.put(start, 0.0);

        // Add start point to queue
        openSet.add(new Node(start, manhattanDistance(start, goal)));

        while (!openSet.isEmpty()) {
            Node current = openSet.poll();
            Point currentPos = current.position;

            if (currentPos.equals(goal)) {
                return reconstructPath(start, goal, parent);
            }

            closedSet.add(currentPos);

            // Check all movement directions
            for (int[] dir : DIRECTIONS) {
                int newX = currentPos.x + dir[0];
                int newY = currentPos.y + dir[1];
                Point neighborPos = new Point(newX, newY);

                // Check validity
                if (newX < 0 || newX >= rows || newY < 0 || newY >= cols ||
                    maze[newX][newY] == 1 || closedSet.contains(neighborPos)) {
                    continue;
                }

                double tentativeGScore = gScore.get(currentPos) + 1; // Each step costs 1

                if (!gScore.containsKey(neighborPos) || tentativeGScore < gScore.get(neighborPos)) {
                    parent.put(neighborPos, currentPos);
                    gScore.put(neighborPos, tentativeGScore);

                    double fScore = tentativeGScore + manhattanDistance(neighborPos, goal);
                    openSet.add(new Node(neighborPos, fScore));
                }
            }
        }

        return null; // Path not found
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

## 🧑‍🏫 Lesson 5: Algorithm Analysis and Optimization

### 1. Algorithm Complexity Analysis

#### a. Asymptotic Notation

- **Big O (O)**: Upper bound of complexity.
- **Big Omega (Ω)**: Lower bound of complexity.
- **Big Theta (Θ)**: Tight bound (both upper and lower) of complexity.

```java
// O(1) - Constant Time
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

#### b. Best, Average, and Worst Case Analysis

```java
// Example: Linear Search
public static int linearSearch(int[] array, int key) {
    for (int i = 0; i < array.length; i++) {
        if (array[i] == key) {
            return i;
        }
    }
    return -1;
}
```

- **Best Case**: O(1) - element is at the first position.
- **Average Case**: O(n/2) ~ O(n) - element is in the middle.
- **Worst Case**: O(n) - element is at the end or not present.

#### c. Space and Time Analysis

```java
// Time and Space analysis for recursive algorithm
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
  - Time Complexity: O(n)
  - Space Complexity: O(1)

- **factorialRecursive**:
  - Time Complexity: O(n)
  - Space Complexity: O(n) due to recursion stack

### 2. Algorithm Optimization Techniques

#### a. Memoization and Dynamic Programming

```java
// Naive Fibonacci
public static int fibNaive(int n) {
    if (n <= 1) return n;
    return fibNaive(n - 1) + fibNaive(n - 2);
}

// Fibonacci with Memoization
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

// Fibonacci with Dynamic Programming (bottom-up)
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

- **fibNaive**: O(2^n) time, O(n) space.
- **fibMemoization**: O(n) time, O(n) space.
- **fibDP**: O(n) time, O(n) space.

#### b. Loop and Condition Optimization

```java
// Before optimization
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

// After optimization
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

- **containsDuplicate**: O(n²) time, O(1) space.
- **containsDuplicateOptimized**: O(n) time, O(n) space.

#### c. Using Appropriate Data Structures

```java
// Not optimized: Search in List
public static boolean containsElement(List<Integer> list, int target) {
    for (int num : list) {
        if (num == target) {
            return true;
        }
    }
    return false;
}

// Optimized: Search in HashSet
public static boolean containsElementOptimized(Set<Integer> set, int target) {
    return set.contains(target);
}
```

- **containsElement**: O(n) time.
- **containsElementOptimized**: O(1) average time.

#### d. Time-Space Trade-off

```java
// Sum of numbers from 1 to n
// Approach 1: O(n) time, O(1) space
public static int sumToN(int n) {
    int sum = 0;
    for (int i = 1; i <= n; i++) {
        sum += i;
    }
    return sum;
}

// Approach 2: O(1) time, O(1) space (Mathematical formula)
public static int sumToNFormula(int n) {
    return n * (n + 1) / 2;
}
```

### 3. Profiling and Benchmarking Techniques

#### a. Measuring Execution Time

```java
public static void benchmarkAlgorithm(Runnable algorithm, String name, int iterations) {
    // Warm-up JVM
    for (int i = 0; i < 5; i++) {
        algorithm.run();
    }

    // Measure execution time
    long startTime = System.nanoTime();

    for (int i = 0; i < iterations; i++) {
        algorithm.run();
    }

    long endTime = System.nanoTime();
    double avgTime = (endTime - startTime) / (double)iterations;

    System.out.printf("%s: %.3f ms per operation%n", name, avgTime / 1_000_000);
}
```

#### b. Measuring Memory Usage

```java
public static void measureMemory(Supplier<?> factory, String name) {
    // Call garbage collector
    System.gc();

    long beforeMemory = Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory();

    // Create object
    Object obj = factory.get();

    // Measure memory again
    long afterMemory = Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory();

    System.out.printf("%s: ~%d bytes%n", name, afterMemory - beforeMemory);
}
```

#### c. Identifying Bottlenecks

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

### 4. Algorithm Optimization Principles

#### a. "Profile Before Optimization" Principle

- Identify which part of the algorithm actually needs optimization.
- Focus on parts consuming the most resources.
- Use profiling tools for analysis.

#### b. Balance Between Readability and Performance

```java
// Readable version
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

// Higher performance but less readable version
public static Map<Character, Integer> countCharactersOptimized(String text) {
    Map<Character, Integer> charCount = new HashMap<>();

    for (int i = 0; i < text.length(); i++) {
        char c = text.charAt(i);
        charCount.merge(c, 1, Integer::sum);
    }

    return charCount;
}
```

#### c. Avoid Premature Optimization

- Write correct and readable code first.
- Define specific performance requirements.
- Only optimize when necessary.

#### d. Optimize Based on Real-World Use Cases

- Understand input data distribution.
- Optimize for the most common cases.
- Consider edge cases and worst-case scenarios.

## 🧑‍💻 Final Project: Build a Simple GPS Application Based on Graph Algorithms

### 1. Project Description

Build an application to find the shortest path between locations on a map using Dijkstra's or A\* algorithm to determine the optimal route.

### 2. Main Components

#### a. Modeling the Map as a Graph

```java
public class MapGraph {
    private final Map<String, Map<String, Double>> adjacencyList;
    private final Map<String, Location> locations;

    public MapGraph() {
        this.adjacencyList = new HashMap<>();
        this.locations = new HashMap<>();
    }

    // Add a new location to the map
    public void addLocation(String name, double latitude, double longitude) {
        Location location = new Location(name, latitude, longitude);
        locations.put(name, location);
        adjacencyList.putIfAbsent(name, new HashMap<>());
    }

    // Add a road between two locations
    public void addRoad(String from, String to, double distance) {
        if (!adjacencyList.containsKey(from) || !adjacencyList.containsKey(to))
            throw new IllegalArgumentException("Locations do not exist");

        // Undirected graph - add edge both ways
        adjacencyList.get(from).put(to, distance);
        adjacencyList.get(to).put(from, distance);
    }

    // Get all adjacent locations
    public Map<String, Double> getNeighbors(String location) {
        return adjacencyList.getOrDefault(location, Collections.emptyMap());
    }

    // Calculate Haversine distance between two locations (heuristic for A*)
    public double calculateDistance(String from, String to) {
        Location loc1 = locations.get(from);
        Location loc2 = locations.get(to);

        return haversineDistance(loc1.latitude, loc1.longitude,
                               loc2.latitude, loc2.longitude);
    }

    private double haversineDistance(double lat1, double lon1, double lat2, double lon2) {
        // Earth radius (km)
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

#### b. Shortest Path Algorithms

```java
public class RouteFinder {
    private final MapGraph map;

    public RouteFinder(MapGraph map) {
        this.map = map;
    }

    // Dijkstra Algorithm
    public List<String> findShortestPath(String start, String destination) {
        // Priority queue to store nodes with smallest distance
        PriorityQueue<Node> queue = new PriorityQueue<>(
            Comparator.comparingDouble(node -> node.distance)
        );

        Map<String, Double> distances = new HashMap<>();
        Map<String, String> previousNodes = new HashMap<>();
        Set<String> visited = new HashSet<>();

        // Initialize
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

            // Visit all adjacent locations
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

        // Path not found
        if (!previousNodes.containsKey(destination)) return null;

        // Reconstruct path
        return reconstructPath(start, destination, previousNodes);
    }

    // A* Algorithm
    public List<String> findShortestPathAStar(String start, String destination) {
        PriorityQueue<Node> openSet = new PriorityQueue<>(
            Comparator.comparingDouble(node -> node.fScore)
        );

        Map<String, Double> gScore = new HashMap<>();
        Map<String, Double> fScore = new HashMap<>();
        Map<String, String> previousNodes = new HashMap<>();
        Set<String> closedSet = new HashSet<>();

        // Initialize
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

                    // Check if already in openSet
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

        return null; // Path not found
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

#### c. Simple User Interface

```java
public class GPSApplication {
    private final MapGraph map;
    private final RouteFinder routeFinder;
    private final Scanner scanner;

    public GPSApplication() {
        this.map = new MapGraph();
        this.routeFinder = new RouteFinder(map);
        this.scanner = new Scanner(System.in);

        // Initialize sample map data
        initializeMap();
    }

    private void initializeMap() {
        // Add locations
        map.addLocation("A", 10.762622, 106.660172); // Ho Chi Minh City
        map.addLocation("B", 21.028511, 105.804817); // Hanoi
        map.addLocation("C", 16.047079, 108.206230); // Da Nang
        map.addLocation("D", 12.248430, 109.192932); // Nha Trang
        map.addLocation("E", 11.935642, 108.442329); // Da Lat

        // Add roads
        map.addRoad("A", "C", 850.0);
        map.addRoad("A", "D", 450.0);
        map.addRoad("A", "E", 300.0);
        map.addRoad("B", "C", 790.0);
        map.addRoad("C", "D", 520.0);
        map.addRoad("C", "E", 670.0);
        map.addRoad("D", "E", 180.0);
    }

    public void start() {
        System.out.println("---- Simple GPS Application ----");

        while (true) {
            System.out.println("\nAvailable locations: A, B, C, D, E");

            System.out.print("Enter start location (or 'exit' to finish): ");
            String start = scanner.nextLine().trim().toUpperCase();

            if (start.equalsIgnoreCase("exit")) {
                break;
            }

            System.out.print("Enter destination: ");
            String destination = scanner.nextLine().trim().toUpperCase();

            System.out.println("Choose algorithm:");
            System.out.println("1. Dijkstra");
            System.out.println("2. A*");
            System.out.print("Your choice: ");
            int choice = Integer.parseInt(scanner.nextLine().trim());

            List<String> path;
            if (choice == 1) {
                path = routeFinder.findShortestPath(start, destination);
            } else {
                path = routeFinder.findShortestPathAStar(start, destination);
            }

            if (path == null || path.isEmpty()) {
                System.out.println("No path found from " + start + " to " + destination);
            } else {
                System.out.println("Shortest path from " + start + " to " + destination + ":");
                System.out.println(String.join(" -> ", path));

                // Calculate total distance
                double totalDistance = calculatePathDistance(path);
                System.out.printf("Total distance: %.2f km\n", totalDistance);
            }
        }

        System.out.println("Thank you for using the application!");
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

### 3. Improvements and Extensions

- Add travel time and traffic data.
- Allow users to add new locations.
- Integrate with real maps (OpenStreetMap API).
- Build a graphical user interface (GUI).
- Optimize calculations with advanced data structures.
