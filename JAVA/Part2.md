# 📘 PHẦN 2: MẢNG, CHUỖI VÀ HÀM

## Nội dung

- [📘 PHẦN 2: MẢNG, CHUỖI VÀ HÀM](#-phần-2-mảng-chuỗi-và-hàm)
  - [Nội dung](#nội-dung)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Mảng trong Java](#-bài-1-mảng-trong-java)
  - [🧑‍🏫 Bài 2: Chuỗi trong Java](#-bài-2-chuỗi-trong-java)
  - [🧑‍🏫 Bài 3: Hàm trong Java](#-bài-3-hàm-trong-java)
  - [🧑‍🏫 Bài 4: Cách sử dụng mảng và chuỗi kết hợp](#-bài-4-cách-sử-dụng-mảng-và-chuỗi-kết-hợp)
  - [🧑‍🏫 Bài 5: Hàm và mảng](#-bài-5-hàm-và-mảng)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN](#-bài-tập-lớn-cuối-phần)
    - [**Đề bài: Quản lý điểm sinh viên với mảng**](#đề-bài-quản-lý-điểm-sinh-viên-với-mảng)
    - [**Kết quả chạy chương trình (Ví dụ):**](#kết-quả-chạy-chương-trình-ví-dụ)

## 🎯 Mục tiêu tổng quát

- Làm quen với việc sử dụng mảng để lưu trữ và xử lý tập hợp dữ liệu.
- Hiểu và làm việc với chuỗi trong Java.
- Tạo và sử dụng hàm để tách chương trình thành các khối logic độc lập.

---

## 🧑‍🏫 Bài 1: Mảng trong Java

- Khái niệm mảng và cách khai báo mảng một chiều, hai chiều.
- Cách truy cập và sửa đổi phần tử mảng.
- Mảng trong Java là đối tượng, có thuộc tính `length`.
- Mảng trong Java có thể chứa các kiểu dữ liệu bất kỳ, kể cả đối tượng.

1. **Khai báo và khởi tạo mảng:**

   ```java
   // Khai báo mảng
   int[] numbers;              // Cách 1: kiểu_dữ_liệu[] tên_mảng;
   int scores[];               // Cách 2: kiểu_dữ_liệu tên_mảng[];

   // Khởi tạo mảng
   numbers = new int[5];       // Khởi tạo mảng với 5 phần tử, mặc định là 0
   scores = new int[]{90, 85, 75, 80, 95}; // Khởi tạo và gán giá trị

   // Khai báo và khởi tạo cùng lúc
   int[] grades = {92, 88, 78, 85, 90};  // Cách viết tắt
   ```

2. **Mảng đa chiều:**

   ```java
   // Mảng 2 chiều
   int[][] matrix = new int[3][4]; // Mảng 3 hàng, 4 cột

   // Khởi tạo với giá trị
   int[][] grid = {
       {1, 2, 3},
       {4, 5, 6},
       {7, 8, 9}
   };
   ```

3. **Truy cập và sửa đổi phần tử:**

   ```java
   int[] numbers = {10, 20, 30, 40, 50};

   // Truy cập phần tử
   System.out.println("Phần tử thứ 3: " + numbers[2]); // Kết quả: 30

   // Sửa đổi phần tử
   numbers[1] = 25; // Thay đổi giá trị phần tử thứ 2 thành 25

   // Duyệt mảng
   for (int i = 0; i < numbers.length; i++) {
       System.out.println("Phần tử " + i + ": " + numbers[i]);
   }

   // Duyệt mảng bằng for-each
   for (int num : numbers) {
       System.out.println(num);
   }
   ```

4. **Ví dụ thực tế - Tính điểm trung bình:**

   ```java
   public class AverageCalculator {
       public static void main(String[] args) {
           double[] grades = {85.5, 90.0, 78.5, 92.5, 88.0};
           double sum = 0;

           for (double grade : grades) {
               sum += grade;
           }

           double average = sum / grades.length;
           System.out.println("Điểm trung bình: " + average);
       }
   }
   ```

---

## 🧑‍🏫 Bài 2: Chuỗi trong Java

- Khái niệm chuỗi (String) và cách sử dụng.
- Các phương thức phổ biến của lớp `String`: `length()`, `substring()`, `equals()`, `indexOf()`, `toUpperCase()`, `toLowerCase()`, v.v.
- So sánh chuỗi với toán tử `==` và phương thức `equals()` của `String`.
- Các cách tạo chuỗi: thông qua constructor, hoặc trực tiếp sử dụng ký tự nháy kép (`" "`).

1. **Khai báo và khởi tạo chuỗi:**

   ```java
   // Khai báo chuỗi sử dụng literal
   String greeting = "Xin chào Java";

   // Khai báo chuỗi sử dụng constructor
   String message = new String("Học Java thật vui");
   ```

2. **Các phương thức phổ biến của String:**

   ```java
   String text = "Học lập trình Java";

   // Độ dài chuỗi
   int length = text.length();  // length = 19

   // Lấy ký tự tại vị trí
   char firstChar = text.charAt(0);  // 'H'

   // Cắt chuỗi con
   String subText = text.substring(4, 14);  // "lập trình"

   // Tìm vị trí xuất hiện
   int position = text.indexOf("Java");  // 15

   // Chuyển đổi chữ hoa/thường
   String upperCase = text.toUpperCase();  // "HỌC LẬP TRÌNH JAVA"
   String lowerCase = text.toLowerCase();  // "học lập trình java"

   // Nối chuỗi
   String newText = text.concat(" cơ bản");  // "Học lập trình Java cơ bản"

   // Thay thế chuỗi
   String replaced = text.replace("Java", "Python");  // "Học lập trình Python"

   // Kiểm tra bắt đầu/kết thúc
   boolean startsWith = text.startsWith("Học");  // true
   boolean endsWith = text.endsWith("Java");    // true

   // Loại bỏ khoảng trắng đầu/cuối
   String trimmed = "  Hello  ".trim();  // "Hello"

   // Kiểm tra chuỗi rỗng
   boolean empty = "".isEmpty();  // true
   ```

3. **So sánh chuỗi:**

   ```java
   String str1 = "Hello";
   String str2 = "Hello";
   String str3 = new String("Hello");

   // So sánh tham chiếu (vị trí trong bộ nhớ)
   System.out.println(str1 == str2);  // true (cùng tham chiếu trong String pool)
   System.out.println(str1 == str3);  // false (khác tham chiếu)

   // So sánh giá trị (nội dung)
   System.out.println(str1.equals(str2));  // true
   System.out.println(str1.equals(str3));  // true

   // So sánh không phân biệt hoa/thường
   System.out.println("hello".equalsIgnoreCase("HELLO"));  // true
   ```

4. **Ví dụ thực tế - Đếm từ trong chuỗi:**

   ```java
   public class WordCounter {
       public static void main(String[] args) {
           String sentence = "Java là ngôn ngữ lập trình hướng đối tượng phổ biến";
           String[] words = sentence.split(" ");

           System.out.println("Số từ trong câu: " + words.length);

           // In ra các từ
           for (String word : words) {
               System.out.println(word);
           }
       }
   }
   ```

---

## 🧑‍🏫 Bài 3: Hàm trong Java

- Khái niệm hàm (method) và cú pháp khai báo.
- Các kiểu giá trị trả về của hàm: `void`, kiểu dữ liệu cơ bản (int, double, boolean,...), đối tượng.
- Cách truyền tham số vào hàm.
- Phạm vi của biến (local variable, parameter, global variable).

1. **Cú pháp khai báo hàm:**

   ```java
   [modifier] [return_type] [method_name]([parameter_list]) {
       // Method body
       [return statement]
   }
   ```

   Ví dụ:

   ```java
   public static int sum(int a, int b) {
       return a + b;
   }
   ```

2. **Các loại hàm:**

   ```java
   // Hàm không có giá trị trả về (void)
   public static void sayHello() {
       System.out.println("Xin chào!");
   }

   // Hàm trả về kiểu nguyên thủy
   public static int square(int number) {
       return number * number;
   }

   // Hàm trả về đối tượng
   public static String formatName(String firstName, String lastName) {
       return lastName + " " + firstName;
   }

   // Hàm có nhiều tham số
   public static double average(double a, double b, double c) {
       return (a + b + c) / 3;
   }
   ```

3. **Tham số và đối số:**

   ```java
   public class ParameterExample {
       public static void main(String[] args) {
           // value1, value2 là đối số
           int result = add(5, 3);  // 5, 3 là arguments - đối số
           System.out.println("Tổng: " + result);
       }

       // a, b là tham số
       public static int add(int a, int b) {  // a, b là parameters - tham số
           return a + b;
       }
   }
   ```

4. **Phạm vi biến:**

   ```java
   public class ScopeExample {
       // Biến toàn cục (class/instance variable)
       static int globalVar = 10;

       public static void main(String[] args) {
           // Biến cục bộ của main
           int localVar = 5;

           System.out.println(globalVar);  // Có thể truy cập
           System.out.println(localVar);   // Có thể truy cập

           // Gọi hàm và truyền tham số
           testScope(20);
       }

       public static void testScope(int paramVar) {
           // paramVar là tham số
           int anotherLocal = 15;

           System.out.println(globalVar);     // Có thể truy cập
           System.out.println(paramVar);      // Có thể truy cập
           System.out.println(anotherLocal);  // Có thể truy cập

           // System.out.println(localVar);  // Lỗi! Không thể truy cập biến localVar từ main
       }
   }
   ```

5. **Ví dụ thực tế - Tính tiền lãi ngân hàng:**

   ```java
   public class BankInterestCalculator {
       public static void main(String[] args) {
           double principal = 10000000;  // 10 triệu VND
           double rate = 0.06;          // 6% lãi suất năm
           int years = 5;               // 5 năm

           double result = calculateInterest(principal, rate, years);
           System.out.printf("Sau %d năm, số tiền là: %.2f VND\n", years, result);
       }

       // Hàm tính lãi kép
       public static double calculateInterest(double principal, double rate, int years) {
           // Công thức lãi kép: A = P(1 + r)^t
           return principal * Math.pow(1 + rate, years);
       }
   }
   ```

---

## 🧑‍🏫 Bài 4: Cách sử dụng mảng và chuỗi kết hợp

- Làm việc với mảng chuỗi (array of strings).
- Xử lý chuỗi trong mảng: tìm kiếm, sắp xếp, thay thế.
- Thực hành với các thao tác trên mảng và chuỗi trong các tình huống thực tế.

1. **Khai báo và khởi tạo mảng chuỗi:**

   ```java
   // Khai báo mảng chuỗi
   String[] names;

   // Khởi tạo mảng
   names = new String[5];

   // Gán giá trị
   names[0] = "Nguyễn Văn A";
   names[1] = "Trần Thị B";
   names[2] = "Lê Văn C";
   names[3] = "Phạm Thị D";
   names[4] = "Hoàng Văn E";

   // Khai báo và khởi tạo cùng lúc
   String[] fruits = {"Táo", "Chuối", "Cam", "Xoài", "Dưa hấu"};
   ```

2. **Tìm kiếm trong mảng chuỗi:**

   ```java
   public class StringArraySearch {
       public static void main(String[] args) {
           String[] fruits = {"Táo", "Chuối", "Cam", "Xoài", "Dưa hấu"};
           String searchFor = "Cam";

           // Tìm kiếm tuyến tính
           boolean found = false;
           for (int i = 0; i < fruits.length; i++) {
               if (fruits[i].equals(searchFor)) {
                   System.out.println("Tìm thấy '" + searchFor + "' tại vị trí " + i);
                   found = true;
                   break;
               }
           }

           if (!found) {
               System.out.println("Không tìm thấy '" + searchFor + "' trong mảng");
           }
       }
   }
   ```

3. **Sắp xếp mảng chuỗi:**

   ```java
   import java.util.Arrays;

   public class StringArraySort {
       public static void main(String[] args) {
           String[] names = {"Nam", "An", "Hoa", "Bình", "Mai"};

           System.out.println("Mảng ban đầu:");
           for (String name : names) {
               System.out.print(name + " ");
           }

           // Sắp xếp mảng (theo thứ tự từ điển)
           Arrays.sort(names);

           System.out.println("\nMảng sau khi sắp xếp:");
           for (String name : names) {
               System.out.print(name + " ");
           }
       }
   }
   ```

4. **Xử lý chuỗi trong mảng:**

   ```java
   public class StringArrayProcessing {
       public static void main(String[] args) {
           String[] sentences = {
               "Java là ngôn ngữ lập trình",
               "Python rất phổ biến hiện nay",
               "JavaScript dùng cho web",
               "Java có thể làm nhiều ứng dụng"
           };

           // Đếm số câu chứa từ "Java"
           int javaCount = 0;
           for (String sentence : sentences) {
               if (sentence.contains("Java")) {
                   javaCount++;
               }
           }
           System.out.println("Số câu chứa từ 'Java': " + javaCount);

           // Chuyển tất cả câu sang chữ hoa
           System.out.println("\nCâu chuyển sang chữ hoa:");
           for (int i = 0; i < sentences.length; i++) {
               sentences[i] = sentences[i].toUpperCase();
               System.out.println(sentences[i]);
           }
       }
   }
   ```

5. **Ví dụ thực tế - Phân tích danh sách học sinh:**

   ```java
   public class StudentAnalysis {
       public static void main(String[] args) {
           // Danh sách học sinh với định dạng: "Tên:Điểm"
           String[] students = {
               "Nguyễn Văn An:8.5",
               "Trần Thị Bình:9.0",
               "Lê Văn Cường:7.5",
               "Phạm Thị Diệp:6.5",
               "Hoàng Văn Em:5.0"
           };

           // Tách thông tin tên và điểm
           String[] names = new String[students.length];
           double[] scores = new double[students.length];

           for (int i = 0; i < students.length; i++) {
               String[] parts = students[i].split(":");
               names[i] = parts[0];
               scores[i] = Double.parseDouble(parts[1]);
           }

           // Tính điểm trung bình
           double sum = 0;
           for (double score : scores) {
               sum += score;
           }
           double average = sum / scores.length;

           // Tìm học sinh có điểm cao nhất
           double maxScore = scores[0];
           int maxIndex = 0;

           for (int i = 1; i < scores.length; i++) {
               if (scores[i] > maxScore) {
                   maxScore = scores[i];
                   maxIndex = i;
               }
           }

           // Hiển thị kết quả
           System.out.printf("Điểm trung bình của lớp: %.2f\n", average);
           System.out.println("Học sinh có điểm cao nhất: " + names[maxIndex] +
                              " với điểm " + scores[maxIndex]);
       }
   }
   ```

---

## 🧑‍🏫 Bài 5: Hàm và mảng

- Tạo các hàm thao tác với mảng: tính tổng mảng, tìm giá trị lớn nhất, nhỏ nhất, sắp xếp mảng.
- Cách sử dụng mảng trong các hàm và truyền mảng vào như tham số.
- Lợi ích của việc chia chương trình thành các hàm trong lập trình.

1. **Truyền mảng vào hàm:**

   ```java
   public class ArrayAsParameter {
       public static void main(String[] args) {
           int[] numbers = {5, 10, 15, 20, 25};

           // Gọi hàm và truyền mảng làm tham số
           printArray(numbers);

           // Mảng là tham chiếu, nên thay đổi trong hàm sẽ ảnh hưởng đến mảng gốc
           modifyArray(numbers);

           System.out.println("\nMảng sau khi thay đổi:");
           printArray(numbers);
       }

       // Hàm in mảng
       public static void printArray(int[] arr) {
           for (int num : arr) {
               System.out.print(num + " ");
           }
           System.out.println();
       }

       // Hàm thay đổi mảng
       public static void modifyArray(int[] arr) {
           for (int i = 0; i < arr.length; i++) {
               arr[i] *= 2; // Nhân đôi mỗi phần tử
           }
       }
   }
   ```

2. **Các hàm xử lý mảng phổ biến:**

   ```java
   public class ArrayHelperFunctions {
       // Hàm tính tổng mảng
       public static int sum(int[] arr) {
           int total = 0;
           for (int num : arr) {
               total += num;
           }
           return total;
       }

       // Hàm tìm giá trị lớn nhất
       public static int findMax(int[] arr) {
           if (arr.length == 0) {
               throw new IllegalArgumentException("Mảng rỗng");
           }

           int max = arr[0];
           for (int i = 1; i < arr.length; i++) {
               if (arr[i] > max) {
                   max = arr[i];
               }
           }
           return max;
       }

       // Hàm tìm giá trị nhỏ nhất
       public static int findMin(int[] arr) {
           if (arr.length == 0) {
               throw new IllegalArgumentException("Mảng rỗng");
           }

           int min = arr[0];
           for (int i = 1; i < arr.length; i++) {
               if (arr[i] < min) {
                   min = arr[i];
               }
           }
           return min;
       }

       // Hàm tính giá trị trung bình
       public static double average(int[] arr) {
           if (arr.length == 0) {
               throw new IllegalArgumentException("Mảng rỗng");
           }

           return (double) sum(arr) / arr.length;
       }

       // Hàm sắp xếp mảng (sử dụng thuật toán Bubble Sort)
       public static void bubbleSort(int[] arr) {
           int n = arr.length;
           boolean swapped;

           for (int i = 0; i < n - 1; i++) {
               swapped = false;

               for (int j = 0; j < n - i - 1; j++) {
                   if (arr[j] > arr[j + 1]) {
                       // Hoán đổi arr[j] và arr[j+1]
                       int temp = arr[j];
                       arr[j] = arr[j + 1];
                       arr[j + 1] = temp;
                       swapped = true;
                   }
               }

               // Nếu không có phần tử nào được hoán đổi, mảng đã sắp xếp
               if (!swapped) {
                   break;
               }
           }
       }
   }
   ```

3. **Ví dụ thực tế - Phân tích dữ liệu bán hàng:**

   ```java
   public class SalesAnalysis {
       public static void main(String[] args) {
           // Dữ liệu bán hàng theo tháng (triệu đồng)
           double[] monthlySales = {120.5, 115.2, 130.8, 140.3, 175.2, 168.7,
                                    155.4, 160.1, 190.3, 185.6, 178.4, 220.5};

           System.out.printf("Tổng doanh số năm: %.2f triệu đồng\n", sumSales(monthlySales));
           System.out.printf("Doanh số trung bình mỗi tháng: %.2f triệu đồng\n", averageSales(monthlySales));
           System.out.printf("Tháng có doanh số cao nhất: %d với %.2f triệu đồng\n",
                           findHighestMonth(monthlySales) + 1, monthlySales[findHighestMonth(monthlySales)]);
           System.out.printf("Tháng có doanh số thấp nhất: %d với %.2f triệu đồng\n",
                           findLowestMonth(monthlySales) + 1, monthlySales[findLowestMonth(monthlySales)]);

           // Phân tích xu hướng
           analyzeTrend(monthlySales);
       }

       // Tính tổng doanh số
       public static double sumSales(double[] sales) {
           double total = 0;
           for (double sale : sales) {
               total += sale;
           }
           return total;
       }

       // Tính doanh số trung bình
       public static double averageSales(double[] sales) {
           return sumSales(sales) / sales.length;
       }

       // Tìm tháng có doanh số cao nhất
       public static int findHighestMonth(double[] sales) {
           int highestMonth = 0;
           for (int i = 1; i < sales.length; i++) {
               if (sales[i] > sales[highestMonth]) {
                   highestMonth = i;
               }
           }
           return highestMonth;
       }

       // Tìm tháng có doanh số thấp nhất
       public static int findLowestMonth(double[] sales) {
           int lowestMonth = 0;
           for (int i = 1; i < sales.length; i++) {
               if (sales[i] < sales[lowestMonth]) {
                   lowestMonth = i;
               }
           }
           return lowestMonth;
       }

       // Phân tích xu hướng
       public static void analyzeTrend(double[] sales) {
           // Tính sự thay đổi giữa các tháng
           System.out.println("\nPhân tích xu hướng doanh số:");

           for (int i = 1; i < sales.length; i++) {
               double change = sales[i] - sales[i-1];
               double percentChange = (change / sales[i-1]) * 100;

               System.out.printf("Tháng %d đến tháng %d: %.2f%% ", i, i+1, percentChange);

               if (change > 0) {
                   System.out.println("(Tăng)");
               } else if (change < 0) {
                   System.out.println("(Giảm)");
               } else {
                   System.out.println("(Không đổi)");
               }
           }
       }
   }
   ```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Quản lý điểm sinh viên với mảng**

Viết chương trình:

- Khai báo một mảng chứa thông tin điểm của sinh viên (3 môn học: Toán, Lý, Hóa).
- Tính toán điểm trung bình của từng sinh viên và xếp loại học lực.
- Hiển thị danh sách sinh viên và điểm trung bình của họ.

Các chức năng cần có:

- Hàm nhập điểm cho các sinh viên và lưu vào mảng.
- Hàm tính điểm trung bình của sinh viên.
- Hàm xếp loại học lực dựa trên điểm trung bình.
- Hàm hiển thị kết quả cho tất cả sinh viên.

### **Kết quả chạy chương trình (Ví dụ):**

```text
Nhập số lượng sinh viên: 3
Nhập tên sinh viên 1: Nguyễn Văn A
Nhập điểm Toán: 8.5
Nhập điểm Lý: 7.5
Nhập điểm Hóa: 9.0

Nhập tên sinh viên 2: Trần Thị B
Nhập điểm Toán: 6.5
Nhập điểm Lý: 7.0
Nhập điểm Hóa: 8.0

Nhập tên sinh viên 3: Lê Văn C
Nhập điểm Toán: 5.0
Nhập điểm Lý: 6.0
Nhập điểm Hóa: 7.0

-----------------------------------
Danh sách sinh viên và điểm trung bình:
Nguyễn Văn A - Điểm trung bình: 8.67 - Xếp loại: Giỏi
Trần Thị B - Điểm trung bình: 7.17 - Xếp loại: Khá
Lê Văn C - Điểm trung bình: 6.00 - Xếp loại: Trung bình
```

---

[⬅️ Trở lại: JAVA/Part1.md](../JAVA/Part1.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: JAVA/Part3.md](../JAVA/Part3.md)
