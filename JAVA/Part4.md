---
prev:
  text: '🧩 Lập Trình Hướng Đối Tượng'
  link: '/JAVA/Part3'
next:
  text: '🧵 Luồng, Đa Luồng và JDBC'
  link: '/JAVA/Part5'
---

# 📘 PHẦN 4: XỬ LÝ NGOẠI LỆ, FILE I/O VÀ COLLECTIONS

## 🎯 Mục tiêu tổng quát

- Hiểu và xử lý lỗi bằng cách sử dụng cơ chế ngoại lệ trong JAVA.
- Đọc ghi dữ liệu vào file văn bản.
- Làm việc với các cấu trúc dữ liệu động trong JAVA: List, Set, Map.

## 🧑‍🏫 Bài 1: Xử lý ngoại lệ (Exception Handling)

### Khái niệm ngoại lệ (Exception) và cơ chế xử lý

- Ngoại lệ là một sự kiện không mong muốn xảy ra trong quá trình thực thi chương trình, làm gián đoạn luồng thực thi bình thường.
- Cơ chế xử lý ngoại lệ giúp chương trình không bị dừng lại mà có thể xử lý lỗi một cách linh hoạt.
- Các loại ngoại lệ trong JAVA:
  - Checked Exception: Ngoại lệ đã được kiểm tra tại thời điểm biên dịch (ví dụ: IOException).
  - Unchecked Exception: Ngoại lệ không được kiểm tra tại thời điểm biên dịch (ví dụ: NullPointerException, ArithmeticException).
  - Error: Lỗi nghiêm trọng không thể xử lý (ví dụ: OutOfMemoryError).

   ```java
   // Cấu trúc try-catch cơ bản
   try {
       // Khối code có thể gây ra ngoại lệ
       int result = 10 / 0; // ArithmeticException
   } catch (ArithmeticException e) {
       // Xử lý ngoại lệ
       System.out.println("Lỗi chia cho 0: " + e.getMessage());
   }
   ```

### Try-catch-finally

   ```java
   try {
       // Khối code có thể gây ra ngoại lệ
       int[] numbers = {1, 2, 3};
       System.out.println(numbers[5]); // ArrayIndexOutOfBoundsException
   } catch (ArrayIndexOutOfBoundsException e) {
       // Xử lý ngoại lệ
       System.out.println("Lỗi truy cập phần tử không tồn tại trong mảng: " + e.getMessage());
   } finally {
       // Khối code luôn được thực thi, dù có ngoại lệ hay không
       System.out.println("Khối finally luôn được thực thi");
   }
   ```

### Đa catch và thứ tự catch

   ```java
   try {
       // Khối code có thể gây ra nhiều loại ngoại lệ
       String str = null;
       System.out.println(str.length()); // NullPointerException
   } catch (NullPointerException e) {
       System.out.println("Lỗi null pointer: " + e.getMessage());
   } catch (Exception e) {
       // Catch tổng quát - luôn đặt sau các catch cụ thể
       System.out.println("Lỗi chung: " + e.getMessage());
   }
   ```

### Throw và Throws

   ```java
   // Throws - khai báo method có thể ném ra ngoại lệ
   public static void checkAge(int age) throws IllegalArgumentException {
       if (age < 18) {
           // Throw - ném ra ngoại lệ
           throw new IllegalArgumentException("Tuổi phải từ 18 trở lên");
       }
       System.out.println("Tuổi hợp lệ");
   }

   // Sử dụng
   public static void main(String[] args) {
       try {
           checkAge(15);
       } catch (IllegalArgumentException e) {
           System.out.println("Lỗi: " + e.getMessage());
       }
   }
   ```

### Tạo Exception tùy chỉnh

   ```java
   // Định nghĩa exception tùy chỉnh
   class InvalidScoreException extends Exception {
       public InvalidScoreException(String message) {
           super(message);
       }
   }

   // Sử dụng exception tùy chỉnh
   public class CustomExceptionExample {
       public static void validateScore(double score) throws InvalidScoreException {
           if (score < 0 || score > 10) {
               throw new InvalidScoreException("Điểm phải nằm trong khoảng 0-10");
           }
           System.out.println("Điểm hợp lệ: " + score);
       }

       public static void main(String[] args) {
           try {
               validateScore(15);
           } catch (InvalidScoreException e) {
               System.out.println("Lỗi điểm: " + e.getMessage());
           }
       }
   }
   ```

## 🧑‍🏫 Bài 2: Đọc ghi file văn bản

### Đọc file với FileReader và BufferedReader

   ```java
   import java.io.BufferedReader;
   import java.io.FileReader;
   import java.io.IOException;

   public class FileReadExample {
       public static void main(String[] args) {
           // Đường dẫn đến file cần đọc
           String filePath = "data.txt";

           try (FileReader fr = new FileReader(filePath);
                BufferedReader br = new BufferedReader(fr)) {

               String line;
               // Đọc từng dòng trong file
               while ((line = br.readLine()) != null) {
                   System.out.println(line);
               }

           } catch (IOException e) {
               System.out.println("Lỗi khi đọc file: " + e.getMessage());
           }
       }
   }
   ```

### Ghi file với FileWriter và BufferedWriter

   ```java
   import java.io.BufferedWriter;
   import java.io.FileWriter;
   import java.io.IOException;

   public class FileWriteExample {
       public static void main(String[] args) {
           String filePath = "output.txt";

           // Ghi đè lên file (false) hoặc nối tiếp vào file (true)
           boolean append = false;

           try (FileWriter fw = new FileWriter(filePath, append);
                BufferedWriter bw = new BufferedWriter(fw)) {

               bw.write("Dòng 1: Học JAVA cơ bản");
               bw.newLine(); // Xuống dòng
               bw.write("Dòng 2: Học đọc ghi file trong JAVA");
               bw.newLine();
               bw.write("Dòng 3: Kết thúc bài học");

               System.out.println("Ghi file thành công!");

           } catch (IOException e) {
               System.out.println("Lỗi khi ghi file: " + e.getMessage());
           }
       }
   }
   ```

### Kiểm tra và thao tác với File

   ```java
   import java.io.File;
   import java.io.IOException;

   public class FileOperationsExample {
       public static void main(String[] args) {
           // Tạo đối tượng File
           File file = new File("test.txt");

           // Kiểm tra file có tồn tại không
           if (file.exists()) {
               System.out.println("File đã tồn tại");
               System.out.println("Tên file: " + file.getName());
               System.out.println("Đường dẫn tuyệt đối: " + file.getAbsolutePath());
               System.out.println("Kích thước: " + file.length() + " bytes");
               System.out.println("Có thể đọc: " + file.canRead());
               System.out.println("Có thể ghi: " + file.canWrite());
           } else {
               System.out.println("File chưa tồn tại, đang tạo file mới...");
               try {
                   if (file.createNewFile()) {
                       System.out.println("Đã tạo file thành công");
                   } else {
                       System.out.println("Không thể tạo file");
                   }
               } catch (IOException e) {
                   System.out.println("Lỗi: " + e.getMessage());
               }
           }

           // Xóa file
           // if (file.delete()) {
           //     System.out.println("Đã xóa file");
           // } else {
           //     System.out.println("Không thể xóa file");
           // }
       }
   }
   ```

### Đọc ghi file với try-with-resources

   ```java
   import java.io.*;

   public class TryWithResourcesExample {
       public static void main(String[] args) {
           String inputFile = "input.txt";
           String outputFile = "output.txt";

           // Try-with-resources tự động đóng tài nguyên
           try (BufferedReader reader = new BufferedReader(new FileReader(inputFile));
                BufferedWriter writer = new BufferedWriter(new FileWriter(outputFile))) {

               String line;
               while ((line = reader.readLine()) != null) {
                   // Chuyển thành chữ hoa và ghi vào file output
                   writer.write(line.toUpperCase());
                   writer.newLine();
               }

               System.out.println("Đã sao chép và chuyển đổi file thành công");

           } catch (IOException e) {
               System.out.println("Lỗi xử lý file: " + e.getMessage());
           }
       }
   }
   ```

### Ví dụ thực tế - Đọc dữ liệu CSV

   ```java
   import java.io.BufferedReader;
   import java.io.FileReader;
   import java.io.IOException;
   import java.util.ArrayList; // Bạn sẽ học về ArrayList trong phần Collections
   import java.util.List; // Bạn sẽ học về List trong phần Collections

   class Student {
       private String id;
       private String name;
       private double score;

       public Student(String id, String name, double score) {
           this.id = id;
           this.name = name;
           this.score = score;
       }

       @Override
       public String toString() {
           return "Student{id='" + id + "', name='" + name + "', score=" + score + "}";
       }
   }

   public class CSVReaderExample {
       public static void main(String[] args) {
           String csvFile = "students.csv";
           String line;
           String csvSplitBy = ",";
           List<Student> students = new ArrayList<>();

           try (BufferedReader br = new BufferedReader(new FileReader(csvFile))) {
               // Bỏ qua dòng tiêu đề
               br.readLine();

               while ((line = br.readLine()) != null) {
                   String[] data = line.split(csvSplitBy);

                   // Tạo đối tượng Student từ dữ liệu CSV
                   Student student = new Student(
                       data[0],
                       data[1],
                       Double.parseDouble(data[2])
                   );

                   students.add(student);
               }

               // In danh sách học sinh
               for (Student student : students) {
                   System.out.println(student);
               }

           } catch (IOException e) {
               System.out.println("Lỗi đọc file CSV: " + e.getMessage());
           }
       }
   }
   ```

## 🧑‍🏫 Bài 3: Giới thiệu Collections Framework

### Tổng quan về Collections Framework

- Collections Framework là một kiến trúc được thiết kế để lưu trữ và thao tác với nhóm các đối tượng trong Java.
- Nó cung cấp các cấu trúc dữ liệu như List, Set, Map và các thuật toán để thao tác với chúng.
- Collections Framework giải quyết nhu cầu tổ chức và xử lý dữ liệu theo cách linh hoạt và hiệu quả.

**Các thành phần chính của Collections Framework:**

1. **Interfaces (Giao diện):**
   - `Collection`: Giao diện cơ sở cho hầu hết các collections, định nghĩa các phương thức như add(), remove(), contains()
   - `List`: Danh sách có thứ tự, cho phép phần tử trùng lặp (ArrayList, LinkedList)
   - `Set`: Tập hợp không chứa phần tử trùng lặp (HashSet, TreeSet)
   - `Queue`: Hàng đợi, các phần tử được xử lý theo thứ tự FIFO (First-In-First-Out)
   - `Map`: Lưu trữ dữ liệu dạng key-value, key không được trùng lặp (HashMap, TreeMap)

2. **Implementations (Các lớp thực thi):**
   - Các lớp triển khai các giao diện trên, mỗi lớp có đặc điểm và ứng dụng riêng
   - Ví dụ: ArrayList (mảng động), LinkedList (danh sách liên kết), HashSet, TreeSet, HashMap, TreeMap

3. **Algorithms (Thuật toán):**
   - Các phương thức tĩnh của lớp `Collections` cung cấp các thuật toán như sắp xếp, tìm kiếm, xáo trộn...
   - Ví dụ: Collections.sort(), Collections.binarySearch(), Collections.shuffle()

**Lợi ích của Collections Framework:**

- **Tái sử dụng**: Không cần tự viết các cấu trúc dữ liệu phức tạp
- **Hiệu suất**: Các triển khai đã được tối ưu hóa
- **Tính linh hoạt**: Dễ dàng chuyển đổi giữa các cấu trúc dữ liệu
- **Chuẩn hóa**: API nhất quán giữa các cấu trúc dữ liệu khác nhau
- **Tích hợp**: Hoạt động tốt với các thành phần khác của Java như Stream API

**Lựa chọn cấu trúc dữ liệu phù hợp:**

- **ArrayList**: Khi cần truy cập ngẫu nhiên nhanh và ít thao tác thêm/xóa ở giữa danh sách
- **LinkedList**: Khi cần thêm/xóa nhiều ở đầu/cuối/giữa danh sách
- **HashSet**: Khi cần tìm kiếm nhanh và không quan tâm đến thứ tự
- **TreeSet**: Khi cần duy trì thứ tự sắp xếp của phần tử
- **HashMap**: Khi cần tìm kiếm nhanh dựa trên key và không quan tâm đến thứ tự của key
- **TreeMap**: Khi cần duy trì thứ tự sắp xếp của key

### Collection vs Map

   ```java
   import java.util.*;

   public class CollectionVsMap {
       public static void main(String[] args) {
           // Collection là interface dành cho các nhóm đối tượng
           System.out.println("=== Collection Examples ===");

           // List - Collection với thứ tự, cho phép trùng lặp
           List<String> names = new ArrayList<>();
           names.add("Alice");
           names.add("Bob");
           names.add("Charlie");
           names.add("Alice"); // Cho phép trùng lặp

           System.out.println("List: " + names);
           System.out.println("Phần tử ở vị trí 1: " + names.get(1));

           // Set - Collection không thứ tự, không trùng lặp
           Set<String> uniqueNames = new HashSet<>();
           uniqueNames.add("Alice");
           uniqueNames.add("Bob");
           uniqueNames.add("Charlie");
           uniqueNames.add("Alice"); // Không thêm vào

           System.out.println("\nSet: " + uniqueNames);
           // uniqueNames.get(0); // Lỗi: Set không có phương thức get(index)

           // Map là interface dành cho cặp key-value
           System.out.println("\n=== Map Examples ===");

           Map<String, Integer> ages = new HashMap<>();
           ages.put("Alice", 25);
           ages.put("Bob", 30);
           ages.put("Charlie", 22);

           System.out.println("Map: " + ages);
           System.out.println("Tuổi của Bob: " + ages.get("Bob"));

           // Duyệt Map
           System.out.println("\nDuyệt Map:");
           for (Map.Entry<String, Integer> entry : ages.entrySet()) {
               System.out.println(entry.getKey() + " có tuổi là " + entry.getValue());
           }
       }
   }
   ```

### Các thao tác cơ bản với Collections

   ```java
   import java.util.*;

   public class CollectionsOperations {
       public static void main(String[] args) {
           List<String> languages = new ArrayList<>();

           // Thêm phần tử
           languages.add("JAVA");
           languages.add("Python");
           languages.add("C#");
           languages.add("JavaScript");

           System.out.println("Danh sách ban đầu: " + languages);

           // Kích thước
           System.out.println("Số phần tử: " + languages.size());

           // Kiểm tra tồn tại
           System.out.println("Có chứa 'JAVA'? " + languages.contains("JAVA"));
           System.out.println("Có chứa 'Ruby'? " + languages.contains("Ruby"));

           // Lấy phần tử theo index
           System.out.println("Phần tử thứ 2: " + languages.get(1));

           // Xóa phần tử
           languages.remove("C#");
           System.out.println("Sau khi xóa 'C#': " + languages);

           // Xóa theo index
           languages.remove(0);
           System.out.println("Sau khi xóa phần tử đầu tiên: " + languages);

           // Duyệt tập hợp
           System.out.println("\nDuyệt bằng for-each:");
           for (String lang : languages) {
               System.out.println("- " + lang);
           }

           // Duyệt bằng Iterator
           System.out.println("\nDuyệt bằng Iterator:");
           Iterator<String> iterator = languages.iterator();
           while (iterator.hasNext()) {
               System.out.println("+ " + iterator.next());
           }

           // Sắp xếp
           Collections.sort(languages);
           System.out.println("\nSau khi sắp xếp: " + languages);

           // Xóa tất cả
           languages.clear();
           System.out.println("Sau khi xóa tất cả: " + languages);
           System.out.println("Danh sách rỗng? " + languages.isEmpty());
       }
   }
   ```

## 🧑‍🏫 Bài 4: List, Set và Map

### ArrayList và LinkedList

- `ArrayList`: danh sách động, truy cập nhanh theo chỉ số.
- `LinkedList`: danh sách liên kết, thêm/xóa nhanh ở đầu/cuối.

   ```java
   import java.util.ArrayList;
   import java.util.LinkedList;
   import java.util.List;

   public class ListExample {
       public static void main(String[] args) {
           // ArrayList - truy cập ngẫu nhiên nhanh
           List<String> arrayList = new ArrayList<>();
           arrayList.add("Apple");
           arrayList.add("Banana");
           arrayList.add("Orange");

           System.out.println("ArrayList: " + arrayList);

           // Thêm phần tử vào vị trí cụ thể
           arrayList.add(1, "Mango");
           System.out.println("Sau khi thêm 'Mango' vào vị trí 1: " + arrayList);

           // Cập nhật phần tử
           arrayList.set(0, "Green Apple");
           System.out.println("Sau khi cập nhật: " + arrayList);

           // LinkedList - thêm/xóa đầu và cuối nhanh
           List<String> linkedList = new LinkedList<>();
           linkedList.add("Dog");
           linkedList.add("Cat");
           linkedList.add("Bird");

           System.out.println("\nLinkedList: " + linkedList);

           // Thêm đầu và cuối (phương thức riêng của LinkedList)
           ((LinkedList<String>) linkedList).addFirst("Lion");
           ((LinkedList<String>) linkedList).addLast("Tiger");

           System.out.println("Sau khi thêm đầu và cuối: " + linkedList);

           // So sánh hiệu năng (khái niệm)
           System.out.println("\nSo sánh ArrayList và LinkedList:");
           System.out.println("- ArrayList tốt cho: truy cập ngẫu nhiên, duyệt danh sách");
           System.out.println("- LinkedList tốt cho: thêm/xóa nhiều ở đầu hoặc cuối danh sách");
       }
   }
   ```

### HashSet và TreeSet

- `HashSet`: không có thứ tự, không cho phép phần tử trùng lặp.
- `TreeSet`: tự động sắp xếp theo thứ tự tự nhiên hoặc theo Comparator.

   ```java
   import java.util.HashSet;
   import java.util.Set;
   import java.util.TreeSet;

   public class SetExample {
       public static void main(String[] args) {
           // HashSet - không có thứ tự, nhanh nhất
           Set<String> hashSet = new HashSet<>();
           hashSet.add("Banana");
           hashSet.add("Apple");
           hashSet.add("Orange");
           hashSet.add("Apple"); // Không thêm vào (trùng lặp)

           System.out.println("HashSet (không có thứ tự): " + hashSet);

           // Kiểm tra phần tử tồn tại
           System.out.println("Có chứa 'Apple'? " + hashSet.contains("Apple"));

           // Xóa phần tử
           hashSet.remove("Banana");
           System.out.println("Sau khi xóa 'Banana': " + hashSet);

           // TreeSet - sắp xếp tự động
           Set<String> treeSet = new TreeSet<>();
           treeSet.add("Zebra");
           treeSet.add("Dog");
           treeSet.add("Cat");
           treeSet.add("Apple");

           System.out.println("\nTreeSet (tự động sắp xếp): " + treeSet);

           // Thêm phần tử trùng
           treeSet.add("Cat"); // Không thay đổi
           System.out.println("Sau khi thêm 'Cat' lần nữa: " + treeSet);

           // So sánh hiệu năng (khái niệm)
           System.out.println("\nSo sánh HashSet và TreeSet:");
           System.out.println("- HashSet tốt cho: thao tác thêm/xóa/tìm kiếm nhanh");
           System.out.println("- TreeSet tốt cho: khi cần duy trì thứ tự sắp xếp");
       }
   }
   ```

### HashMap và TreeMap

- `HashMap`: không có thứ tự, cho phép key null, nhanh nhất.
- `TreeMap`: tự động sắp xếp theo key, không cho phép key null.

   ```java
   import java.util.HashMap;
   import java.util.Map;
   import java.util.TreeMap;

   public class MapExample {
       public static void main(String[] args) {
           // HashMap - không có thứ tự, nhanh nhất
           Map<String, Integer> hashMap = new HashMap<>();
           hashMap.put("John", 25);
           hashMap.put("Alice", 22);
           hashMap.put("Bob", 30);

           System.out.println("HashMap (không có thứ tự): " + hashMap);

           // Truy cập giá trị
           System.out.println("Tuổi của Alice: " + hashMap.get("Alice"));

           // Kiểm tra key tồn tại
           System.out.println("Có chứa 'Bob'? " + hashMap.containsKey("Bob"));

           // Kiểm tra value tồn tại
           System.out.println("Có chứa tuổi 40? " + hashMap.containsValue(40));

           // Cập nhật giá trị
           hashMap.put("John", 26); // Ghi đè giá trị cũ
           System.out.println("Sau khi cập nhật tuổi của John: " + hashMap);

           // TreeMap - sắp xếp theo key
           Map<String, String> treeMap = new TreeMap<>();
           treeMap.put("US", "United States");
           treeMap.put("VN", "Vietnam");
           treeMap.put("FR", "France");
           treeMap.put("JP", "Japan");

           System.out.println("\nTreeMap (sắp xếp theo key): " + treeMap);

           // Duyệt Map - Cách 1: dùng entrySet
           System.out.println("\nDuyệt Map bằng entrySet:");
           for (Map.Entry<String, String> entry : treeMap.entrySet()) {
               System.out.println(entry.getKey() + " -> " + entry.getValue());
           }

           // Duyệt Map - Cách 2: dùng keySet
           System.out.println("\nDuyệt Map bằng keySet:");
           for (String key : treeMap.keySet()) {
               System.out.println(key + " --> " + treeMap.get(key));
           }

           // Xóa phần tử
           treeMap.remove("FR");
           System.out.println("\nSau khi xóa 'FR': " + treeMap);
       }
   }
   ```

### Ví dụ thực tế - Quản lý danh bạ

   ```java
   import java.util.*;

   public class ContactManager {
       public static void main(String[] args) {
           // Sử dụng TreeMap để lưu danh bạ sắp xếp theo tên
           Map<String, String> contacts = new TreeMap<>();

           // Thêm liên hệ
           contacts.put("John Doe", "0987654321");
           contacts.put("Alice Smith", "0123456789");
           contacts.put("Bob Johnson", "0369852147");
           contacts.put("Cindy Williams", "0741258963");

           // Hiển thị tất cả liên hệ
           System.out.println("=== DANH BẠ ===");
           displayContacts(contacts);

           // Tìm kiếm số điện thoại
           String name = "Alice Smith";
           String phone = findContact(contacts, name);
           if (phone != null) {
               System.out.println("\nSố điện thoại của " + name + ": " + phone);
           } else {
               System.out.println("\nKhông tìm thấy " + name + " trong danh bạ");
           }

           // Cập nhật liên hệ
           updateContact(contacts, "Bob Johnson", "0999888777");
           System.out.println("\n=== DANH BẠ SAU KHI CẬP NHẬT ===");
           displayContacts(contacts);

           // Xóa liên hệ
           removeContact(contacts, "Cindy Williams");
           System.out.println("\n=== DANH BẠ SAU KHI XÓA ===");
           displayContacts(contacts);
       }

       // Hiển thị tất cả liên hệ
       public static void displayContacts(Map<String, String> contacts) {
           for (Map.Entry<String, String> entry : contacts.entrySet()) {
               System.out.println(entry.getKey() + ": " + entry.getValue());
           }
       }

       // Tìm liên hệ
       public static String findContact(Map<String, String> contacts, String name) {
           return contacts.get(name);
       }

       // Cập nhật liên hệ
       public static void updateContact(Map<String, String> contacts, String name, String newPhone) {
           if (contacts.containsKey(name)) {
               contacts.put(name, newPhone);
               System.out.println("Đã cập nhật số điện thoại cho " + name);
           } else {
               System.out.println("Không tìm thấy " + name + " trong danh bạ");
           }
       }

       // Xóa liên hệ
       public static void removeContact(Map<String, String> contacts, String name) {
           if (contacts.containsKey(name)) {
               contacts.remove(name);
               System.out.println("Đã xóa " + name + " khỏi danh bạ");
           } else {
               System.out.println("Không tìm thấy " + name + " trong danh bạ");
           }
       }
   }
   ```

## 🧑‍🏫 Bài 5: Kết hợp File và Collections

### Đọc file và lưu vào List

   ```java
   import java.io.BufferedReader;
   import java.io.FileReader;
   import java.io.IOException;
   import java.util.ArrayList;
   import java.util.List;

   public class ReadToCollection {
       public static void main(String[] args) {
           String filePath = "names.txt";
           List<String> names = new ArrayList<>();

           try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
               String line;
               while ((line = br.readLine()) != null) {
                   names.add(line.trim());
               }

               System.out.println("Đã đọc " + names.size() + " tên từ file");
               System.out.println("Danh sách tên:");
               for (String name : names) {
                   System.out.println("- " + name);
               }

           } catch (IOException e) {
               System.out.println("Lỗi khi đọc file: " + e.getMessage());
           }
       }
   }
   ```

### Ghi List ra file

   ```java
   import java.io.BufferedWriter;
   import java.io.FileWriter;
   import java.io.IOException;
   import java.util.ArrayList;
   import java.util.List;

   public class WriteCollectionToFile {
       public static void main(String[] args) {
           List<String> cities = new ArrayList<>();
           cities.add("Hà Nội");
           cities.add("Hồ Chí Minh");
           cities.add("Đà Nẵng");
           cities.add("Huế");
           cities.add("Cần Thơ");

           String outputFile = "cities.txt";

           try (BufferedWriter writer = new BufferedWriter(new FileWriter(outputFile))) {
               for (String city : cities) {
                   writer.write(city);
                   writer.newLine();
               }

               System.out.println("Đã ghi " + cities.size() + " thành phố vào file " + outputFile);

           } catch (IOException e) {
               System.out.println("Lỗi khi ghi file: " + e.getMessage());
           }
       }
   }
   ```

### Đọc file CSV vào List đối tượng

   ```java
   import java.io.BufferedReader;
   import java.io.FileReader;
   import java.io.IOException;
   import java.util.ArrayList;
   import java.util.List;

   class Product {
       private String id;
       private String name;
       private double price;
       private int quantity;

       public Product(String id, String name, double price, int quantity) {
           this.id = id;
           this.name = name;
           this.price = price;
           this.quantity = quantity;
       }

       @Override
       public String toString() {
           return "Product{id='" + id + "', name='" + name + "', price=" + price + ", quantity=" + quantity + "}";
       }

       // Phương thức để chuyển đối tượng thành dòng CSV
       public String toCSV() {
           return id + "," + name + "," + price + "," + quantity;
       }
   }

   public class ProductCSVReader {
       public static void main(String[] args) {
           String csvFile = "products.csv";
           String line;
           String csvSplitBy = ",";
           List<Product> products = new ArrayList<>();

           try (BufferedReader br = new BufferedReader(new FileReader(csvFile))) {
               // Bỏ qua dòng tiêu đề
               br.readLine();

               while ((line = br.readLine()) != null) {
                   String[] data = line.split(csvSplitBy);

                   Product product = new Product(
                       data[0],
                       data[1],
                       Double.parseDouble(data[2]),
                       Integer.parseInt(data[3])
                   );

                   products.add(product);
               }

               System.out.println("Đã đọc " + products.size() + " sản phẩm");
               for (Product product : products) {
                   System.out.println(product);
               }

           } catch (IOException e) {
               System.out.println("Lỗi đọc file: " + e.getMessage());
           }
       }
   }
   ```

### Ghi Map ra file

   ```java
   import java.io.BufferedWriter;
   import java.io.FileWriter;
   import java.io.IOException;
   import java.util.HashMap;
   import java.util.Map;

   public class WriteMapToFile {
       public static void main(String[] args) {
           Map<String, Double> exchangeRates = new HashMap<>();
           exchangeRates.put("USD", 23000.0);
           exchangeRates.put("EUR", 27000.0);
           exchangeRates.put("JPY", 210.0);
           exchangeRates.put("GBP", 31500.0);
           exchangeRates.put("AUD", 17500.0);

           String outputFile = "exchange_rates.txt";

           try (BufferedWriter writer = new BufferedWriter(new FileWriter(outputFile))) {
               writer.write("Currency,Rate");
               writer.newLine();

               for (Map.Entry<String, Double> entry : exchangeRates.entrySet()) {
                   String line = entry.getKey() + "," + entry.getValue();
                   writer.write(line);
                   writer.newLine();
               }

               System.out.println("Đã ghi tỷ giá tiền tệ vào file " + outputFile);

           } catch (IOException e) {
               System.out.println("Lỗi khi ghi file: " + e.getMessage());
           }
       }
   }
   ```

### Ví dụ thực tế - Hệ thống quản lý sách đơn giản

   ```java
   import java.io.*;
   import java.util.ArrayList;
   import java.util.List;
   import java.util.Scanner;

   class Book {
       private String isbn;
       private String title;
       private String author;
       private int year;

       public Book(String isbn, String title, String author, int year) {
           this.isbn = isbn;
           this.title = title;
           this.author = author;
           this.year = year;
       }

       // Getters
       public String getIsbn() { return isbn; }
       public String getTitle() { return title; }
       public String getAuthor() { return author; }
       public int getYear() { return year; }

       @Override
       public String toString() {
           return "Book{isbn='" + isbn + "', title='" + title + "', author='" + author + "', year=" + year + "}";
       }

       // Chuyển đối tượng thành dòng CSV
       public String toCSV() {
           return isbn + "," + title + "," + author + "," + year;
       }
   }

   public class BookManager {
       private static final String FILE_PATH = "books.csv";
       private List<Book> books = new ArrayList<>();
       private Scanner scanner = new Scanner(System.in);

       public static void main(String[] args) {
           BookManager manager = new BookManager();
           manager.loadBooksFromFile();
           manager.showMenu();
       }

       private void showMenu() {
           int choice;
           do {
               System.out.println("\n==== QUẢN LÝ SÁCH ====");
               System.out.println("1. Hiển thị tất cả sách");
               System.out.println("2. Thêm sách mới");
               System.out.println("3. Tìm sách theo ISBN");
               System.out.println("4. Tìm sách theo tác giả");
               System.out.println("5. Lưu và thoát");
               System.out.print("Nhập lựa chọn của bạn: ");

               choice = scanner.nextInt();
               scanner.nextLine(); // Consume newline

               switch (choice) {
                   case 1:
                       displayAllBooks();
                       break;
                   case 2:
                       addNewBook();
                       break;
                   case 3:
                       findBookByISBN();
                       break;
                   case 4:
                       findBooksByAuthor();
                       break;
                   case 5:
                       saveBooksToFile();
                       System.out.println("Tạm biệt!");
                       break;
                   default:
                       System.out.println("Lựa chọn không hợp lệ. Vui lòng thử lại.");
               }

           } while (choice != 5);
       }

       private void loadBooksFromFile() {
           File file = new File(FILE_PATH);
           if (!file.exists()) {
               System.out.println("File không tồn tại. Tạo danh sách mới.");
               return;
           }

           try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
               String line;
               // Bỏ qua dòng tiêu đề nếu có
               reader.readLine();

               while ((line = reader.readLine()) != null) {
                   String[] data = line.split(",");
                   if (data.length == 4) {
                       Book book = new Book(
                           data[0],
                           data[1],
                           data[2],
                           Integer.parseInt(data[3])
                       );
                       books.add(book);
                   }
               }

               System.out.println("Đã nạp " + books.size() + " sách từ file.");

           } catch (IOException e) {
               System.out.println("Lỗi khi đọc file: " + e.getMessage());
           }
       }

       private void saveBooksToFile() {
           try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
               // Ghi dòng tiêu đề
               writer.write("ISBN,Title,Author,Year");
               writer.newLine();

               // Ghi dữ liệu sách
               for (Book book : books) {
                   writer.write(book.toCSV());
                   writer.newLine();
               }

               System.out.println("Đã lưu " + books.size() + " sách vào file " + FILE_PATH);

           } catch (IOException e) {
               System.out.println("Lỗi khi ghi file: " + e.getMessage());
           }
       }

       private void displayAllBooks() {
           if (books.isEmpty()) {
               System.out.println("Không có sách nào trong thư viện.");
               return;
           }

           System.out.println("\n==== DANH SÁCH SÁCH ====");
           System.out.println("ISBN\t\tTiêu đề\t\tTác giả\t\tNăm xuất bản");
           System.out.println("---------------------------------------------------");

           for (Book book : books) {
               System.out.printf("%s\t%s\t%s\t%d\n",
                   book.getIsbn(), book.getTitle(), book.getAuthor(), book.getYear());
           }
       }

       private void addNewBook() {
           System.out.println("\n==== THÊM SÁCH MỚI ====");

           System.out.print("Nhập ISBN: ");
           String isbn = scanner.nextLine();

           // Kiểm tra ISBN đã tồn tại chưa
           for (Book book : books) {
               if (book.getIsbn().equals(isbn)) {
                   System.out.println("ISBN đã tồn tại. Vui lòng thử lại.");
                   return;
               }
           }

           System.out.print("Nhập tiêu đề: ");
           String title = scanner.nextLine();

           System.out.print("Nhập tác giả: ");
           String author = scanner.nextLine();

           System.out.print("Nhập năm xuất bản: ");
           int year = scanner.nextInt();
           scanner.nextLine(); // Consume newline

           Book newBook = new Book(isbn, title, author, year);
           books.add(newBook);

           System.out.println("Đã thêm sách thành công!");
       }

       private void findBookByISBN() {
           System.out.print("Nhập ISBN cần tìm: ");
           String isbn = scanner.nextLine();

           for (Book book : books) {
               if (book.getIsbn().equals(isbn)) {
                   System.out.println("\nTìm thấy sách:");
                   System.out.println(book);
                   return;
               }
           }

           System.out.println("Không tìm thấy sách với ISBN: " + isbn);
       }

       private void findBooksByAuthor() {
           System.out.print("Nhập tên tác giả cần tìm: ");
           String authorName = scanner.nextLine().toLowerCase();

           List<Book> result = new ArrayList<>();

           for (Book book : books) {
               if (book.getAuthor().toLowerCase().contains(authorName)) {
                   result.add(book);
               }
           }

           if (result.isEmpty()) {
               System.out.println("Không tìm thấy sách của tác giả: " + authorName);
           } else {
               System.out.println("\nTìm thấy " + result.size() + " sách của tác giả " + authorName + ":");
               for (Book book : result) {
                   System.out.println(book);
               }
           }
       }
   }
   ```

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Hệ thống quản lý khóa học

### Mô tả bài toán

Viết chương trình quản lý danh sách khóa học:

- Mỗi khóa học có mã, tên, giảng viên, và số lượng sinh viên đăng ký.
- Cho phép người dùng:
  - Thêm, sửa, xóa khóa học.
  - Lưu và tải danh sách từ file.
  - Tìm kiếm khóa học theo mã hoặc tên.
  - In danh sách khóa học theo tên giảng viên.

### Yêu cầu

- Sử dụng `ArrayList` hoặc `HashMap` để lưu danh sách khóa học.
- Lưu trữ dữ liệu vào file (có thể là csv) và nạp lại khi khởi động chương trình.
- Xử lý các trường hợp lỗi như trùng mã khóa học, file không tồn tại,...

Sau khi hoàn thành phần này, bạn đã nắm vững các khái niệm nền tảng của JAVA - từ cú pháp, cấu trúc điều khiển, lập trình hướng đối tượng đến Collections Framework. Các ví dụ thực tế trong bài học cũng đã giúp bạn có cơ hội áp dụng lý thuyết vào những tình huống cụ thể.

Đến đây, chúng ta sẽ tạm gác lại hành trình với JAVA để bước vào thế giới của SQL - ngôn ngữ truy vấn cơ sở dữ liệu được sử dụng rộng rãi nhất hiện nay. Việc này không chỉ mở rộng kiến thức cho bạn mà còn giúp bạn hiểu sâu hơn về cách thức ứng dụng tương tác với cơ sở dữ liệu - một kỹ năng thiết yếu trong hầu hết các dự án phát triển phần mềm thực tế.
