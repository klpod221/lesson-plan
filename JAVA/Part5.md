# 📘 PHẦN 5: LUỒNG, ĐA LUỒNG VÀ JDBC

## Nội dung

- [📘 PHẦN 5: LUỒNG, ĐA LUỒNG VÀ JDBC](#-phần-5-luồng-đa-luồng-và-jdbc)
  - [Table of Contents](#table-of-contents)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Java I/O Streams](#-bài-1-java-io-streams)
  - [🧑‍🏫 Bài 2: Đa luồng trong Java](#-bài-2-đa-luồng-trong-java)
  - [🧑‍🏫 Bài 3: Lập trình đồng thời (Concurrency)](#-bài-3-lập-trình-đồng-thời-concurrency)
  - [🧑‍🏫 Bài 4: Kết nối cơ sở dữ liệu với JDBC](#-bài-4-kết-nối-cơ-sở-dữ-liệu-với-jdbc)
  - [🧑‍🏫 Bài 5: Thao tác CRUD với JDBC](#-bài-5-thao-tác-crud-với-jdbc)
  - [🧑‍🏫 Bài 6: Thực hành viết ứng dụng với JDBC](#-bài-6-thực-hành-viết-ứng-dụng-với-jdbc)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN](#-bài-tập-lớn-cuối-phần)
    - [**Đề bài: Hệ thống quản lý sinh viên với cơ sở dữ liệu**](#đề-bài-hệ-thống-quản-lý-sinh-viên-với-cơ-sở-dữ-liệu)

## 🎯 Mục tiêu tổng quát

- Hiểu cách xử lý nhập/xuất dữ liệu bằng luồng (Streams).
- Làm quen với lập trình đa luồng (Multithreading).
- Kết nối và thao tác dữ liệu với cơ sở dữ liệu sử dụng JDBC.

---

## 🧑‍🏫 Bài 1: Java I/O Streams

- Khái niệm luồng trong Java: `InputStream`, `OutputStream`, `Reader`, `Writer`.
- Phân biệt luồng nhị phân và luồng ký tự.
- Các lớp thường dùng: `FileInputStream`, `FileOutputStream`, `BufferedReader`, `BufferedWriter`.
- Đọc và ghi file bằng stream với xử lý ngoại lệ.

---

## 🧑‍🏫 Bài 2: Đa luồng trong Java

- Khái niệm Thread và lợi ích của đa luồng.
- Tạo thread bằng kế thừa `Thread` hoặc triển khai `Runnable`.
- Quản lý luồng bằng `start()`, `join()`, `sleep()`.
- Vấn đề đồng bộ (synchronization), sử dụng từ khóa `synchronized`.

---

## 🧑‍🏫 Bài 3: Lập trình đồng thời (Concurrency)

- Quản lý thread nâng cao với `ExecutorService`.
- Giới thiệu `Callable`, `Future`.
- Đồng bộ dữ liệu trong môi trường đa luồng.
- Ứng dụng thực tế: tải song song dữ liệu, xử lý đa nhiệm.

---

## 🧑‍🏫 Bài 4: Kết nối cơ sở dữ liệu với JDBC

- Tổng quan về JDBC và các bước kết nối:
  1. Tải driver JDBC.
  2. Tạo kết nối (`Connection`).
  3. Thực thi truy vấn (`Statement`, `PreparedStatement`).
  4. Đọc kết quả (`ResultSet`).
- Kết nối với MySQL (hoặc SQLite).
- Cách dùng `try-with-resources` khi làm việc với JDBC.

1. **Tải Driver và tạo kết nối:**

   ```java
   // Tải driver (chỉ cần làm một lần)
   try {
       Class.forName("com.mysql.cj.jdbc.Driver");
       // Hoặc với SQLite: Class.forName("org.sqlite.JDBC");
   } catch (ClassNotFoundException e) {
       System.out.println("Không tìm thấy Driver JDBC");
       e.printStackTrace();
   }

   // Tạo kết nối
   String url = "jdbc:mysql://localhost:3306/mydatabase";
   String username = "root";
   String password = "password";

   try (Connection connection = DriverManager.getConnection(url, username, password)) {
       System.out.println("Kết nối thành công đến cơ sở dữ liệu!");
       // Thao tác với database
   } catch (SQLException e) {
       System.out.println("Kết nối thất bại!");
       e.printStackTrace();
   }
   ```

2. **Sử dụng Statement để thực thi truy vấn:**

   ```java
   public static void executeSimpleQuery(Connection conn) throws SQLException {
       // Tạo Statement
       try (Statement stmt = conn.createStatement()) {
           // Thực thi truy vấn SQL
           String sql = "SELECT id, name, email FROM users";
           ResultSet rs = stmt.executeQuery(sql);

           // Xử lý kết quả
           while (rs.next()) {
               int id = rs.getInt("id");
               String name = rs.getString("name");
               String email = rs.getString("email");

               System.out.println("ID: " + id + ", Tên: " + name + ", Email: " + email);
           }
       }
   }
   ```

3. **Sử dụng PreparedStatement để thực thi truy vấn an toàn:**

   ```java
   public static void findUserById(Connection conn, int userId) throws SQLException {
       String sql = "SELECT id, name, email FROM users WHERE id = ?";

       // Tạo PreparedStatement
       try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
           // Đặt tham số
           pstmt.setInt(1, userId);

           // Thực thi truy vấn
           ResultSet rs = pstmt.executeQuery();

           // Xử lý kết quả
           if (rs.next()) {
               String name = rs.getString("name");
               String email = rs.getString("email");

               System.out.println("Tìm thấy người dùng:");
               System.out.println("ID: " + userId + ", Tên: " + name + ", Email: " + email);
           } else {
               System.out.println("Không tìm thấy người dùng với ID: " + userId);
           }
       }
   }
   ```

4. **Sử dụng try-with-resources với JDBC:**

   ```java
   public static void safeDatabaseOperation() {
       String url = "jdbc:mysql://localhost:3306/mydatabase";
       String username = "root";
       String password = "password";

       // try-with-resources sẽ tự động đóng Connection, Statement và ResultSet
       try (
           Connection conn = DriverManager.getConnection(url, username, password);
           Statement stmt = conn.createStatement();
           ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS user_count FROM users")
       ) {
           if (rs.next()) {
               int count = rs.getInt("user_count");
               System.out.println("Tổng số người dùng: " + count);
           }
       } catch (SQLException e) {
           System.out.println("Lỗi khi thao tác với cơ sở dữ liệu:");
           e.printStackTrace();
       }
   }
   ```

5. **Ví dụ thực tế - Kết nối và truy vấn cơ sở dữ liệu:**

   ```java
   import java.sql.*;

   public class JDBCExample {
       public static void main(String[] args) {
           String url = "jdbc:mysql://localhost:3306/library_db";
           String username = "root";
           String password = "password";

           try (Connection conn = DriverManager.getConnection(url, username, password)) {
               System.out.println("Kết nối thành công đến cơ sở dữ liệu!");

               // Tìm tất cả sách xuất bản sau năm 2020
               findBooksByYear(conn, 2020);

               // Tìm sách theo tác giả
               findBooksByAuthor(conn, "Nguyễn Nhật Ánh");

           } catch (SQLException e) {
               System.out.println("Lỗi kết nối: " + e.getMessage());
               e.printStackTrace();
           }
       }

       public static void findBooksByYear(Connection conn, int year) throws SQLException {
           String sql = "SELECT id, title, author, published_year FROM books WHERE published_year > ?";

           try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
               pstmt.setInt(1, year);
               ResultSet rs = pstmt.executeQuery();

               System.out.println("\nSách xuất bản sau năm " + year + ":");
               while (rs.next()) {
                   System.out.printf("ID: %d, Tiêu đề: %s, Tác giả: %s, Năm: %d\n",
                       rs.getInt("id"),
                       rs.getString("title"),
                       rs.getString("author"),
                       rs.getInt("published_year"));
               }
           }
       }

       public static void findBooksByAuthor(Connection conn, String authorName) throws SQLException {
           String sql = "SELECT id, title, published_year FROM books WHERE author LIKE ?";

           try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
               pstmt.setString(1, "%" + authorName + "%");  // Tìm kiếm mờ
               ResultSet rs = pstmt.executeQuery();

               System.out.println("\nSách của tác giả có tên '" + authorName + "':");
               boolean found = false;

               while (rs.next()) {
                   found = true;
                   System.out.printf("ID: %d, Tiêu đề: %s, Năm xuất bản: %d\n",
                       rs.getInt("id"),
                       rs.getString("title"),
                       rs.getInt("published_year"));
               }

               if (!found) {
                   System.out.println("Không tìm thấy sách nào của tác giả này.");
               }
           }
       }
   }
   ```

---

## 🧑‍🏫 Bài 5: Thao tác CRUD với JDBC

- Tạo bảng và thêm dữ liệu từ Java.
- Truy vấn dữ liệu và hiển thị kết quả.
- Cập nhật và xóa dữ liệu với `PreparedStatement`.
- Xử lý lỗi và đóng kết nối đúng cách.

1. **Tạo bảng trong cơ sở dữ liệu:**

   ```java
   public static void createTable(Connection conn) throws SQLException {
       String sql = "CREATE TABLE IF NOT EXISTS students (" +
                   "id INT AUTO_INCREMENT PRIMARY KEY," +
                   "name VARCHAR(100) NOT NULL," +
                   "email VARCHAR(100) UNIQUE," +
                   "age INT," +
                   "gpa DOUBLE" +
                   ")";

       try (Statement stmt = conn.createStatement()) {
           stmt.execute(sql);
           System.out.println("Bảng 'students' đã được tạo hoặc đã tồn tại");
       }
   }
   ```

2. **Thêm dữ liệu (Create):**

   ```java
   public static void addStudent(Connection conn, String name, String email, int age, double gpa)
           throws SQLException {
       String sql = "INSERT INTO students (name, email, age, gpa) VALUES (?, ?, ?, ?)";

       try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
           pstmt.setString(1, name);
           pstmt.setString(2, email);
           pstmt.setInt(3, age);
           pstmt.setDouble(4, gpa);

           int rowsInserted = pstmt.executeUpdate();
           if (rowsInserted > 0) {
               System.out.println("Đã thêm thành công sinh viên: " + name);
           }
       }
   }
   ```

3. **Truy vấn dữ liệu (Read):**

   ```java
   public static void getAllStudents(Connection conn) throws SQLException {
       String sql = "SELECT id, name, email, age, gpa FROM students";

       try (Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql)) {

           if (!rs.isBeforeFirst()) {
               System.out.println("Không có sinh viên nào trong cơ sở dữ liệu");
               return;
           }

           System.out.println("\n----- DANH SÁCH SINH VIÊN -----");
           System.out.printf("%-5s %-20s %-25s %-5s %-5s\n",
                           "ID", "Họ tên", "Email", "Tuổi", "GPA");
           System.out.println("-----------------------------------------------------------");

           while (rs.next()) {
               System.out.printf("%-5d %-20s %-25s %-5d %-5.2f\n",
                               rs.getInt("id"),
                               rs.getString("name"),
                               rs.getString("email"),
                               rs.getInt("age"),
                               rs.getDouble("gpa"));
           }
       }
   }

   public static void findStudentByName(Connection conn, String searchName) throws SQLException {
       String sql = "SELECT id, name, email, age, gpa FROM students WHERE name LIKE ?";

       try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
           pstmt.setString(1, "%" + searchName + "%");

           try (ResultSet rs = pstmt.executeQuery()) {
               boolean found = false;

               System.out.println("\n----- TÌM KIẾM SINH VIÊN -----");
               System.out.printf("%-5s %-20s %-25s %-5s %-5s\n",
                               "ID", "Họ tên", "Email", "Tuổi", "GPA");
               System.out.println("-----------------------------------------------------------");

               while (rs.next()) {
                   found = true;
                   System.out.printf("%-5d %-20s %-25s %-5d %-5.2f\n",
                                   rs.getInt("id"),
                                   rs.getString("name"),
                                   rs.getString("email"),
                                   rs.getInt("age"),
                                   rs.getDouble("gpa"));
               }

               if (!found) {
                   System.out.println("Không tìm thấy sinh viên nào có tên \"" + searchName + "\"");
               }
           }
       }
   }
   ```

4. **Cập nhật dữ liệu (Update):**

   ```java
   public static void updateStudentGPA(Connection conn, int studentId, double newGPA)
           throws SQLException {
       String sql = "UPDATE students SET gpa = ? WHERE id = ?";

       try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
           pstmt.setDouble(1, newGPA);
           pstmt.setInt(2, studentId);

           int rowsUpdated = pstmt.executeUpdate();
           if (rowsUpdated > 0) {
               System.out.println("Đã cập nhật GPA của sinh viên có ID = " + studentId);
           } else {
               System.out.println("Không tìm thấy sinh viên có ID = " + studentId);
           }
       }
   }
   ```

5. **Xóa dữ liệu (Delete):**

   ```java
   public static void deleteStudent(Connection conn, int studentId) throws SQLException {
       // Trước tiên, kiểm tra xem sinh viên có tồn tại không
       String checkSql = "SELECT name FROM students WHERE id = ?";
       try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
           checkStmt.setInt(1, studentId);

           try (ResultSet rs = checkStmt.executeQuery()) {
               if (rs.next()) {
                   String studentName = rs.getString("name");

                   // Sinh viên tồn tại, tiến hành xóa
                   String deleteSql = "DELETE FROM students WHERE id = ?";
                   try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                       deleteStmt.setInt(1, studentId);

                       int rowsDeleted = deleteStmt.executeUpdate();
                       System.out.println("Đã xóa sinh viên: " + studentName);
                   }
               } else {
                   System.out.println("Không tìm thấy sinh viên có ID = " + studentId);
               }
           }
       }
   }
   ```

6. **Ví dụ thực tế - Quản lý sinh viên CRUD hoàn chỉnh:**

   ```java
   import java.sql.*;
   import java.util.Scanner;

   public class StudentManagementSystem {
       // Thông tin kết nối CSDL
       private static final String URL = "jdbc:mysql://localhost:3306/school_db";
       private static final String USERNAME = "root";
       private static final String PASSWORD = "password";

       private static Scanner scanner = new Scanner(System.in);

       public static void main(String[] args) {
           try {
               // Tải driver
               Class.forName("com.mysql.cj.jdbc.Driver");

               // Tạo kết nối
               try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD)) {
                   // Tạo bảng nếu chưa tồn tại
                   createTable(conn);

                   boolean running = true;
                   while (running) {
                       displayMenu();
                       int choice = scanner.nextInt();
                       scanner.nextLine(); // Đọc newline

                       switch (choice) {
                           case 1:
                               addNewStudent(conn);
                               break;
                           case 2:
                               viewAllStudents(conn);
                               break;
                           case 3:
                               searchStudent(conn);
                               break;
                           case 4:
                               updateStudent(conn);
                               break;
                           case 5:
                               deleteStudentRecord(conn);
                               break;
                           case 0:
                               running = false;
                               System.out.println("Cảm ơn bạn đã sử dụng chương trình!");
                               break;
                           default:
                               System.out.println("Lựa chọn không hợp lệ!");
                       }
                   }
               }
           } catch (ClassNotFoundException e) {
               System.out.println("Không tìm thấy Driver JDBC: " + e.getMessage());
           } catch (SQLException e) {
               System.out.println("Lỗi SQL: " + e.getMessage());
               e.printStackTrace();
           }
       }

       private static void displayMenu() {
           System.out.println("\n----- HỆ THỐNG QUẢN LÝ SINH VIÊN -----");
           System.out.println("1. Thêm sinh viên mới");
           System.out.println("2. Xem tất cả sinh viên");
           System.out.println("3. Tìm kiếm sinh viên theo tên");
           System.out.println("4. Cập nhật GPA của sinh viên");
           System.out.println("5. Xóa sinh viên");
           System.out.println("0. Thoát");
           System.out.print("Chọn chức năng: ");
       }

       private static void addNewStudent(Connection conn) throws SQLException {
           System.out.println("\n----- THÊM SINH VIÊN MỚI -----");

           System.out.print("Nhập tên sinh viên: ");
           String name = scanner.nextLine();

           System.out.print("Nhập email: ");
           String email = scanner.nextLine();

           System.out.print("Nhập tuổi: ");
           int age = scanner.nextInt();

           System.out.print("Nhập GPA: ");
           double gpa = scanner.nextDouble();
           scanner.nextLine(); // Đọc newline

           addStudent(conn, name, email, age, gpa);
       }

       private static void viewAllStudents(Connection conn) throws SQLException {
           getAllStudents(conn);
       }

       private static void searchStudent(Connection conn) throws SQLException {
           System.out.print("\nNhập tên sinh viên cần tìm: ");
           String searchName = scanner.nextLine();

           findStudentByName(conn, searchName);
       }

       private static void updateStudent(Connection conn) throws SQLException {
           System.out.print("\nNhập ID của sinh viên cần cập nhật: ");
           int id = scanner.nextInt();

           System.out.print("Nhập GPA mới: ");
           double newGPA = scanner.nextDouble();
           scanner.nextLine(); // Đọc newline

           updateStudentGPA(conn, id, newGPA);
       }

       private static void deleteStudentRecord(Connection conn) throws SQLException {
           System.out.print("\nNhập ID của sinh viên cần xóa: ");
           int id = scanner.nextInt();
           scanner.nextLine(); // Đọc newline

           System.out.print("Bạn có chắc muốn xóa sinh viên này? (y/n): ");
           String confirm = scanner.nextLine();

           if (confirm.equalsIgnoreCase("y")) {
               deleteStudent(conn, id);
           } else {
               System.out.println("Đã hủy thao tác xóa");
           }
       }

       // Phương thức CRUD khác đã được định nghĩa ở trên...
   }
   ```

7. **Xử lý lỗi và Transaction:**

   ```java
   public static void registerStudentWithCourses(Connection conn, String studentName,
                                              String email, int[] courseIds) throws SQLException {
       // Vô hiệu hóa auto-commit để sử dụng transaction
       boolean autoCommit = conn.getAutoCommit();
       conn.setAutoCommit(false);

       try {
           // 1. Thêm sinh viên mới
           String insertStudentSql = "INSERT INTO students (name, email) VALUES (?, ?)";
           int studentId;

           try (PreparedStatement pstmt = conn.prepareStatement(insertStudentSql,
                                                           Statement.RETURN_GENERATED_KEYS)) {
               pstmt.setString(1, studentName);
               pstmt.setString(2, email);
               pstmt.executeUpdate();

               // Lấy ID của sinh viên vừa thêm
               try (ResultSet rs = pstmt.getGeneratedKeys()) {
                   if (rs.next()) {
                       studentId = rs.getInt(1);
                   } else {
                       throw new SQLException("Không thể lấy ID của sinh viên vừa thêm");
                   }
               }
           }

           // 2. Đăng ký sinh viên vào các khóa học
           String registerCourseSql = "INSERT INTO student_courses (student_id, course_id) VALUES (?, ?)";

           try (PreparedStatement pstmt = conn.prepareStatement(registerCourseSql)) {
               for (int courseId : courseIds) {
                   pstmt.setInt(1, studentId);
                   pstmt.setInt(2, courseId);
                   pstmt.executeUpdate();
               }
           }

           // Nếu mọi thứ OK, commit transaction
           conn.commit();
           System.out.println("Đã đăng ký sinh viên " + studentName + " với " +
                              courseIds.length + " khóa học");

       } catch (SQLException e) {
           // Nếu có lỗi, rollback
           try {
               System.out.println("Transaction bị lỗi, đang rollback...");
               conn.rollback();
           } catch (SQLException ex) {
               System.out.println("Lỗi khi rollback: " + ex.getMessage());
           }
           throw e;
       } finally {
           // Khôi phục trạng thái auto-commit
           conn.setAutoCommit(autoCommit);
       }
   }
   ```

---

## 🧑‍🏫 Bài 6: Thực hành viết ứng dụng với JDBC

- Thiết kế cơ sở dữ liệu cho ứng dụng quản lý.
- Tạo lớp DAO (Data Access Object) cho các thao tác dữ liệu.
- Kết hợp kiến thức về luồng, đa luồng và JDBC.
- Xây dựng ứng dụng quản lý hoàn chỉnh với nhiều chức năng.

1. **Thiết kế cơ sở dữ liệu đơn giản:**

   ```sql
   CREATE TABLE students (
       id INT AUTO_INCREMENT PRIMARY KEY,
       student_id VARCHAR(10) UNIQUE NOT NULL,
       name VARCHAR(100) NOT NULL,
       birth_date DATE,
       email VARCHAR(100) UNIQUE,
       phone VARCHAR(15)
   );

   CREATE TABLE courses (
       id INT AUTO_INCREMENT PRIMARY KEY,
       course_code VARCHAR(10) UNIQUE NOT NULL,
       course_name VARCHAR(100) NOT NULL,
       credits INT
   );

   CREATE TABLE enrollments (
       id INT AUTO_INCREMENT PRIMARY KEY,
       student_id INT,
       course_id INT,
       enrollment_date DATE,
       grade DOUBLE,
       FOREIGN KEY (student_id) REFERENCES students(id),
       FOREIGN KEY (course_id) REFERENCES courses(id),
       UNIQUE (student_id, course_id)
   );
   ```

2. **Lớp kết nối cơ sở dữ liệu:**

   ```java
   public class DatabaseConnection {
       private static final String URL = "jdbc:mysql://localhost:3306/school_management";
       private static final String USERNAME = "root";
       private static final String PASSWORD = "password";

       private static Connection connection = null;

       public static Connection getConnection() throws SQLException {
           if (connection == null || connection.isClosed()) {
               try {
                   Class.forName("com.mysql.cj.jdbc.Driver");
                   connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
               } catch (ClassNotFoundException e) {
                   throw new SQLException("JDBC Driver không tìm thấy", e);
               }
           }
           return connection;
       }

       public static void closeConnection() {
           if (connection != null) {
               try {
                   connection.close();
               } catch (SQLException e) {
                   System.out.println("Lỗi khi đóng kết nối: " + e.getMessage());
               }
           }
       }
   }
   ```

3. **Lớp DAO cho Student:**

   ```java
   public class StudentDAO {
       private Connection conn;

       public StudentDAO() throws SQLException {
           this.conn = DatabaseConnection.getConnection();
       }

       // Thêm sinh viên mới
       public boolean addStudent(Student student) throws SQLException {
           String sql = "INSERT INTO students (student_id, name, birth_date, email, phone) " +
                       "VALUES (?, ?, ?, ?, ?)";

           try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
               pstmt.setString(1, student.getStudentId());
               pstmt.setString(2, student.getName());
               pstmt.setDate(3, new java.sql.Date(student.getBirthDate().getTime()));
               pstmt.setString(4, student.getEmail());
               pstmt.setString(5, student.getPhone());

               int rowsInserted = pstmt.executeUpdate();
               return rowsInserted > 0;
           }
       }

       // Lấy tất cả sinh viên
       public List<Student> getAllStudents() throws SQLException {
           List<Student> students = new ArrayList<>();
           String sql = "SELECT id, student_id, name, birth_date, email, phone FROM students";

           try (Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

               while (rs.next()) {
                   Student student = new Student();
                   student.setId(rs.getInt("id"));
                   student.setStudentId(rs.getString("student_id"));
                   student.setName(rs.getString("name"));
                   student.setBirthDate(rs.getDate("birth_date"));
                   student.setEmail(rs.getString("email"));
                   student.setPhone(rs.getString("phone"));

                   students.add(student);
               }
           }

           return students;
       }

       // Tìm sinh viên theo mã
       public Student findByStudentId(String studentId) throws SQLException {
           String sql = "SELECT id, student_id, name, birth_date, email, phone " +
                       "FROM students WHERE student_id = ?";

           try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
               pstmt.setString(1, studentId);

               try (ResultSet rs = pstmt.executeQuery()) {
                   if (rs.next()) {
                       Student student = new Student();
                       student.setId(rs.getInt("id"));
                       student.setStudentId(rs.getString("student_id"));
                       student.setName(rs.getString("name"));
                       student.setBirthDate(rs.getDate("birth_date"));
                       student.setEmail(rs.getString("email"));
                       student.setPhone(rs.getString("phone"));

                       return student;
                   }
               }
           }

           return null; // Không tìm thấy
       }

       // Cập nhật thông tin sinh viên
       public boolean updateStudent(Student student) throws SQLException {
           String sql = "UPDATE students SET name = ?, birth_date = ?, email = ?, phone = ? " +
                       "WHERE student_id = ?";

           try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
               pstmt.setString(1, student.getName());
               pstmt.setDate(2, new java.sql.Date(student.getBirthDate().getTime()));
               pstmt.setString(3, student.getEmail());
               pstmt.setString(4, student.getPhone());
               pstmt.setString(5, student.getStudentId());

               int rowsUpdated = pstmt.executeUpdate();
               return rowsUpdated > 0;
           }
       }

       // Xóa sinh viên
       public boolean deleteStudent(String studentId) throws SQLException {
           String sql = "DELETE FROM students WHERE student_id = ?";

           try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
               pstmt.setString(1, studentId);

               int rowsDeleted = pstmt.executeUpdate();
               return rowsDeleted > 0;
           }
       }
   }
   ```

4. **Lớp Student:**

   ```java
   import java.util.Date;

   public class Student {
       private int id;
       private String studentId;  // Mã sinh viên
       private String name;
       private Date birthDate;
       private String email;
       private String phone;

       // Constructor mặc định
       public Student() {
       }

       // Constructor với tham số
       public Student(String studentId, String name, Date birthDate, String email, String phone) {
           this.studentId = studentId;
           this.name = name;
           this.birthDate = birthDate;
           this.email = email;
           this.phone = phone;
       }

       // Getters và Setters
       public int getId() {
           return id;
       }

       public void setId(int id) {
           this.id = id;
       }

       public String getStudentId() {
           return studentId;
       }

       public void setStudentId(String studentId) {
           this.studentId = studentId;
       }

       public String getName() {
           return name;
       }

       public void setName(String name) {
           this.name = name;
       }

       public Date getBirthDate() {
           return birthDate;
       }

       public void setBirthDate(Date birthDate) {
           this.birthDate = birthDate;
       }

       public String getEmail() {
           return email;
       }

       public void setEmail(String email) {
           this.email = email;
       }

       public String getPhone() {
           return phone;
       }

       public void setPhone(String phone) {
           this.phone = phone;
       }

       @Override
       public String toString() {
           return "Student [id=" + id + ", studentId=" + studentId + ", name=" + name +
                  ", birthDate=" + birthDate + ", email=" + email + ", phone=" + phone + "]";
       }
   }
   ```

5. **Ứng dụng hoàn chỉnh với đa luồng:**

   ```java
   import java.sql.SQLException;
   import java.text.ParseException;
   import java.text.SimpleDateFormat;
   import java.util.*;
   import java.util.concurrent.ExecutorService;
   import java.util.concurrent.Executors;

   public class StudentManagementApp {
       private static Scanner scanner = new Scanner(System.in);
       private static StudentDAO studentDAO;
       private static ExecutorService executor = Executors.newFixedThreadPool(3);
       private static SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

       public static void main(String[] args) {
           try {
               // Khởi tạo DAO
               studentDAO = new StudentDAO();

               boolean running = true;
               while (running) {
                   displayMenu();
                   int choice = scanner.nextInt();
                   scanner.nextLine(); // Đọc newline

                   switch (choice) {
                       case 1:
                           addNewStudent();
                           break;
                       case 2:
                           displayAllStudents();
                           break;
                       case 3:
                           findStudentById();
                           break;
                       case 4:
                           updateStudentInfo();
                           break;
                       case 5:
                           deleteStudentRecord();
                           break;
                       case 6:
                           backupDataToFile();
                           break;
                       case 0:
                           running = false;
                           executor.shutdown();
                           DatabaseConnection.closeConnection();
                           System.out.println("Cảm ơn bạn đã sử dụng chương trình!");
                           break;
                       default:
                           System.out.println("Lựa chọn không hợp lệ!");
                   }
               }
           } catch (SQLException e) {
               System.out.println("Lỗi kết nối cơ sở dữ liệu: " + e.getMessage());
           } finally {
               if (executor != null && !executor.isShutdown()) {
                   executor.shutdown();
               }
           }
       }

       private static void displayMenu() {
           System.out.println("\n=== HỆ THỐNG QUẢN LÝ SINH VIÊN ===");
           System.out.println("1. Thêm sinh viên mới");
           System.out.println("2. Xem tất cả sinh viên");
           System.out.println("3. Tìm sinh viên theo mã");
           System.out.println("4. Cập nhật thông tin sinh viên");
           System.out.println("5. Xóa sinh viên");
           System.out.println("6. Sao lưu dữ liệu vào file");
           System.out.println("0. Thoát");
           System.out.print("Chọn chức năng: ");
       }

       private static void addNewStudent() {
           System.out.println("\n=== THÊM SINH VIÊN MỚI ===");

           try {
               System.out.print("Nhập mã sinh viên: ");
               String studentId = scanner.nextLine();

               System.out.print("Nhập tên sinh viên: ");
               String name = scanner.nextLine();

               System.out.print("Nhập ngày sinh (dd/MM/yyyy): ");
               String birthDateStr = scanner.nextLine();
               Date birthDate = dateFormat.parse(birthDateStr);

               System.out.print("Nhập email: ");
               String email = scanner.nextLine();

               System.out.print("Nhập số điện thoại: ");
               String phone = scanner.nextLine();

               Student student = new Student(studentId, name, birthDate, email, phone);

               // Thực hiện thêm sinh viên trong thread riêng
               executor.submit(() -> {
                   try {
                       boolean success = studentDAO.addStudent(student);
                       if (success) {
                           System.out.println("Đã thêm sinh viên thành công!");
                       } else {
                           System.out.println("Thêm sinh viên thất bại!");
                       }
                   } catch (SQLException e) {
                       System.out.println("Lỗi: " + e.getMessage());
                   }
               });

           } catch (ParseException e) {
               System.out.println("Định dạng ngày không hợp lệ. Vui lòng nhập theo định dạng dd/MM/yyyy");
           }
       }

       private static void displayAllStudents() {
           System.out.println("\n=== DANH SÁCH SINH VIÊN ===");

           executor.submit(() -> {
               try {
                   List<Student> students = studentDAO.getAllStudents();

                   if (students.isEmpty()) {
                       System.out.println("Không có sinh viên nào trong cơ sở dữ liệu");
                       return;
                   }

                   System.out.printf("%-10s %-30s %-15s %-25s %-15s\n",
                                  "Mã SV", "Họ và tên", "Ngày sinh", "Email", "Số điện thoại");
                   System.out.println("--------------------------------------------------------------------------------------------------------");

                   for (Student student : students) {
                       System.out.printf("%-10s %-30s %-15s %-25s %-15s\n",
                                      student.getStudentId(),
                                      student.getName(),
                                      dateFormat.format(student.getBirthDate()),
                                      student.getEmail(),
                                      student.getPhone());
                   }
               } catch (SQLException e) {
                   System.out.println("Lỗi khi lấy danh sách sinh viên: " + e.getMessage());
               }
           });
       }

       private static void findStudentById() {
           System.out.print("\nNhập mã sinh viên cần tìm: ");
           String studentId = scanner.nextLine();

           executor.submit(() -> {
               try {
                   Student student = studentDAO.findByStudentId(studentId);

                   if (student != null) {
                       System.out.println("\n=== THÔNG TIN SINH VIÊN ===");
                       System.out.println("Mã sinh viên: " + student.getStudentId());
                       System.out.println("Họ và tên: " + student.getName());
                       System.out.println("Ngày sinh: " + dateFormat.format(student.getBirthDate()));
                       System.out.println("Email: " + student.getEmail());
                       System.out.println("Số điện thoại: " + student.getPhone());
                   } else {
                       System.out.println("Không tìm thấy sinh viên có mã " + studentId);
                   }
               } catch (SQLException e) {
                   System.out.println("Lỗi khi tìm sinh viên: " + e.getMessage());
               }
           });
       }

       private static void updateStudentInfo() {
           System.out.print("\nNhập mã sinh viên cần cập nhật: ");
           String studentId = scanner.nextLine();

           executor.submit(() -> {
               try {
                   Student student = studentDAO.findByStudentId(studentId);

                   if (student != null) {
                       System.out.println("\n=== CẬP NHẬT THÔNG TIN SINH VIÊN ===");
                       System.out.println("Sinh viên hiện tại: " + student.getName());

                       System.out.print("Nhập tên mới (Enter để giữ nguyên): ");
                       String name = scanner.nextLine();
                       if (!name.isEmpty()) {
                           student.setName(name);
                       }

                       System.out.print("Nhập ngày sinh mới (dd/MM/yyyy) (Enter để giữ nguyên): ");
                       String birthDateStr = scanner.nextLine();
                       if (!birthDateStr.isEmpty()) {
                           try {
                               Date birthDate = dateFormat.parse(birthDateStr);
                               student.setBirthDate(birthDate);
                           } catch (ParseException e) {
                               System.out.println("Định dạng ngày không hợp lệ, giữ nguyên ngày sinh cũ");
                           }
                       }

                       System.out.print("Nhập email mới (Enter để giữ nguyên): ");
                       String email = scanner.nextLine();
                       if (!email.isEmpty()) {
                           student.setEmail(email);
                       }

                       System.out.print("Nhập số điện thoại mới (Enter để giữ nguyên): ");
                       String phone = scanner.nextLine();
                       if (!phone.isEmpty()) {
                           student.setPhone(phone);
                       }

                       boolean success = studentDAO.updateStudent(student);
                       if (success) {
                           System.out.println("Cập nhật thông tin sinh viên thành công!");
                       } else {
                           System.out.println("Cập nhật thông tin sinh viên thất bại!");
                       }
                   } else {
                       System.out.println("Không tìm thấy sinh viên có mã " + studentId);
                   }
               } catch (SQLException e) {
                   System.out.println("Lỗi khi cập nhật thông tin sinh viên: " + e.getMessage());
               }
           });
       }

       private static void deleteStudentRecord() {
           System.out.print("\nNhập mã sinh viên cần xóa: ");
           String studentId = scanner.nextLine();

           System.out.print("Bạn có chắc muốn xóa sinh viên này? (y/n): ");
           String confirm = scanner.nextLine();

           if (confirm.equalsIgnoreCase("y")) {
               executor.submit(() -> {
                   try {
                       boolean success = studentDAO.deleteStudent(studentId);
                       if (success) {
                           System.out.println("Đã xóa sinh viên thành công!");
                       } else {
                           System.out.println("Không tìm thấy sinh viên có mã " + studentId);
                       }
                   } catch (SQLException e) {
                       System.out.println("Lỗi khi xóa sinh viên: " + e.getMessage());
                   }
               });
           } else {
               System.out.println("Đã hủy thao tác xóa");
           }
       }

       private static void backupDataToFile() {
           System.out.println("\n=== SAO LƯU DỮ LIỆU ===");
           System.out.print("Nhập đường dẫn file để lưu: ");
           String filePath = scanner.nextLine();

           executor.submit(() -> {
               try {
                   List<Student> students = studentDAO.getAllStudents();

                   // Tạo một thread khác để ghi file
                   Runnable backupTask = () -> {
                       try (java.io.PrintWriter writer = new java.io.PrintWriter(new java.io.FileWriter(filePath))) {
                           writer.println("Mã SV,Họ và tên,Ngày sinh,Email,Số điện thoại");

                           for (Student student : students) {
                               writer.printf("%s,%s,%s,%s,%s\n",
                                          student.getStudentId(),
                                          student.getName(),
                                          dateFormat.format(student.getBirthDate()),
                                          student.getEmail(),
                                          student.getPhone());
                           }

                           System.out.println("Đã sao lưu dữ liệu thành công vào file: " + filePath);
                       } catch (java.io.IOException e) {
                           System.out.println("Lỗi khi ghi file: " + e.getMessage());
                       }
                   };

                   // Sử dụng executor để thực hiện công việc sao lưu
                   executor.submit(backupTask);

               } catch (SQLException e) {
                   System.out.println("Lỗi khi lấy dữ liệu để sao lưu: " + e.getMessage());
               }
           });
       }
   }
   ```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Hệ thống quản lý sinh viên với cơ sở dữ liệu**

Xây dựng ứng dụng Java với các chức năng:

- Kết nối đến cơ sở dữ liệu (MySQL hoặc SQLite).
- Cho phép:
  - Thêm sinh viên (mã, tên, ngày sinh, email).
  - Xem danh sách sinh viên.
  - Sửa, xóa sinh viên.
  - Tìm sinh viên theo tên hoặc mã.
- Giao diện dòng lệnh, menu tùy chọn.

Yêu cầu:

- Sử dụng JDBC để thao tác dữ liệu.
- Xử lý đa luồng khi đọc/ghi dữ liệu từ/đến file backup song song với thao tác người dùng.
- Đảm bảo dữ liệu không bị xung đột khi có nhiều thao tác đồng thời.

---

[⬅️ Trở lại: JAVA/Part4.md](../JAVA/Part4.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: SQL/Part1.md](../SQL/Part1.md)
