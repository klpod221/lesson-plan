---
prev:
  text: '📊 Advanced SQL'
  link: '/SQL/Part2'
next:
  text: '⚡ Expert SQL'
  link: '/SQL/Part4'
---

# 📘 PART 3: ADVANCED SQL AND APPLICATIONS

## 🎯 General Objectives

- Build complex functions with stored procedures.
- Understand and implement data constraint rules.
- Ensure data integrity in a multi-user environment.

## 🧑‍🏫 Lesson 1: Advanced Stored Procedures

### Stored Procedure with Parameters

```sql
-- Create stored procedure to add a new student
DELIMITER //
CREATE PROCEDURE sp_AddStudent(
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_date_of_birth DATE,
    IN p_gender CHAR(1),
    OUT p_student_id INT
)
BEGIN
    INSERT INTO Students(first_name, last_name, email, date_of_birth, gender)
    VALUES(p_first_name, p_last_name, p_email, p_date_of_birth, p_gender);

    SET p_student_id = LAST_INSERT_ID();
END //
DELIMITER ;

-- Call stored procedure
CALL sp_AddStudent('Hoang', 'Tran', 'hoang.tran@example.com', '2001-08-15', 'M', @new_id);
SELECT @new_id AS new_student_id;
```

### Error Handling in Stored Procedure

```sql
DELIMITER //
CREATE PROCEDURE sp_EnrollStudent(
    IN p_student_id INT,
    IN p_course_id INT
)
BEGIN
    DECLARE exit_handler BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET exit_handler = TRUE;
        ROLLBACK;
        SELECT 'Error occurred during course enrollment' AS error_message;
    END;

    START TRANSACTION;

    -- Check if student exists
    IF NOT EXISTS (SELECT 1 FROM Students WHERE student_id = p_student_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Student does not exist';
    END IF;

    -- Check if course exists
    IF NOT EXISTS (SELECT 1 FROM Courses WHERE course_id = p_course_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Course does not exist';
    END IF;

    -- Check if student already enrolled in this course
    IF EXISTS (SELECT 1 FROM Enrollments WHERE student_id = p_student_id AND course_id = p_course_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Student already enrolled in this course';
    END IF;

    -- Add new enrollment
    INSERT INTO Enrollments(student_id, course_id, enrollment_date)
    VALUES(p_student_id, p_course_id, CURDATE());

    IF exit_handler = FALSE THEN
        COMMIT;
        SELECT 'Course enrollment successful' AS success_message;
    END IF;
END //
DELIMITER ;
```

### Using Cursor to Process Data Row by Row

```sql
DELIMITER //
CREATE PROCEDURE sp_UpdateStudentRanks()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE s_id INT;
    DECLARE s_avg DECIMAL(4,2);

    -- Declare cursor
    DECLARE student_cursor CURSOR FOR
        SELECT student_id, (math_score + physics_score + chemistry_score)/3 AS avg_score
        FROM Students;

    -- Declare handler for cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open cursor
    OPEN student_cursor;

    -- Start loop
    student_loop: LOOP
        -- Read data row by row
        FETCH student_cursor INTO s_id, s_avg;

        -- Check if data is exhausted
        IF done THEN
            LEAVE student_loop;
        END IF;

        -- Update rank based on average score
        UPDATE Students SET
            average_score = s_avg,
            rank = CASE
                WHEN s_avg >= 8.0 THEN 'Excellent'
                WHEN s_avg >= 6.5 THEN 'Good'
                WHEN s_avg >= 5.0 THEN 'Average'
                ELSE 'Weak'
            END
        WHERE student_id = s_id;
    END LOOP;

    -- Close cursor
    CLOSE student_cursor;
END //
DELIMITER ;
```

### Stored Procedure Returning Value

```sql
DELIMITER //
CREATE FUNCTION fn_CalculateGPA(
    p_student_id INT
) RETURNS DECIMAL(4,2)
DETERMINISTIC
BEGIN
    DECLARE avg_grade DECIMAL(4,2);

    SELECT AVG(grade) INTO avg_grade
    FROM Enrollments
    WHERE student_id = p_student_id;

    -- If no grade (NULL), return 0
    IF avg_grade IS NULL THEN
        RETURN 0.0;
    ELSE
        RETURN avg_grade;
    END IF;
END //
DELIMITER ;

-- Use function
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS full_name,
    fn_CalculateGPA(s.student_id) AS gpa
FROM Students s;
```

## 🧑‍🏫 Lesson 2: Triggers and Constraints

### Trigger BEFORE INSERT

- Executed before a record is inserted into the table.

```sql
DELIMITER //
CREATE TRIGGER before_student_insert
BEFORE INSERT ON Students
FOR EACH ROW
BEGIN
    -- Convert email to lowercase
    SET NEW.email = LOWER(NEW.email);

    -- Check email format
    IF NEW.email NOT LIKE '%@%.%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid email format';
    END IF;

    -- Check age (must be 16 or older)
    IF NEW.date_of_birth > DATE_SUB(CURDATE(), INTERVAL 16 YEAR) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Student must be 16 years or older';
    END IF;
END //
DELIMITER ;
```

### Trigger AFTER UPDATE

- Executed after a record is updated.

```sql
DELIMITER //
CREATE TRIGGER after_grade_update
AFTER UPDATE ON Enrollments
FOR EACH ROW
BEGIN
    -- If grade changes, log it
    IF OLD.grade <> NEW.grade THEN
        INSERT INTO GradeChangeLog(
            student_id,
            course_id,
            old_grade,
            new_grade,
            changed_at,
            changed_by
        )
        VALUES(
            NEW.student_id,
            NEW.course_id,
            OLD.grade,
            NEW.grade,
            NOW(),
            CURRENT_USER()
        );
    END IF;
END //
DELIMITER ;
```

### Trigger BEFORE DELETE

- Executed before a record is deleted.

```sql
DELIMITER //
CREATE TRIGGER before_course_delete
BEFORE DELETE ON Courses
FOR EACH ROW
BEGIN
    -- Do not allow deleting course with enrolled students
    DECLARE student_count INT;

    SELECT COUNT(*) INTO student_count
    FROM Enrollments
    WHERE course_id = OLD.course_id;

    IF student_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete course with enrolled students';
    END IF;
END //
DELIMITER ;
```

### Trigger to Maintain Data Integrity

```sql
DELIMITER //
CREATE TRIGGER after_enrollment_insert
AFTER INSERT ON Enrollments
FOR EACH ROW
BEGIN
    -- Update enrolled student count in Courses table
    UPDATE Courses
    SET enrolled_students = (
        SELECT COUNT(*)
        FROM Enrollments
        WHERE course_id = NEW.course_id
    )
    WHERE course_id = NEW.course_id;
END //
DELIMITER ;

-- Similar for DELETE and UPDATE
CREATE TRIGGER after_enrollment_delete
AFTER DELETE ON Enrollments
FOR EACH ROW
BEGIN
    UPDATE Courses
    SET enrolled_students = (
        SELECT COUNT(*)
        FROM Enrollments
        WHERE course_id = OLD.course_id
    )
    WHERE course_id = OLD.course_id;
END //
DELIMITER ;
```

### Transaction Management

```sql
-- Example of transaction when transferring points from one student to another
START TRANSACTION;

-- Deduct points from source student
UPDATE Students
SET bonus_points = bonus_points - 10
WHERE student_id = 101;

-- Check for error (e.g., negative points)
IF (SELECT bonus_points FROM Students WHERE student_id = 101) < 0 THEN
    ROLLBACK;
    SELECT 'Not enough points to transfer' AS message;
ELSE
    -- Add points to target student
    UPDATE Students
    SET bonus_points = bonus_points + 10
    WHERE student_id = 102;

    COMMIT;
    SELECT 'Points transferred successfully' AS message;
END IF;
```

### Isolation Levels

```sql
-- READ UNCOMMITTED (lowest level, allows reading uncommitted data)
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- READ COMMITTED (only read committed data)
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- REPEATABLE READ (default level in MySQL, ensures repeatable reads)
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- SERIALIZABLE (highest level, all transactions executed sequentially)
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Example transaction with REPEATABLE READ level
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;

-- Read data
SELECT * FROM Students WHERE student_id = 1;

-- Perform other operations...

-- Read data again, ensuring result is same as first read
SELECT * FROM Students WHERE student_id = 1;

COMMIT;
```

### Handling Locks and Deadlocks

```sql
-- Set lock wait timeout
SET innodb_lock_wait_timeout = 50; -- 50 seconds

-- Example transaction with FOR UPDATE (creates row-level lock)
START TRANSACTION;

-- Lock row for reading
SELECT * FROM Enrollments WHERE enrollment_id = 101 FOR UPDATE;

-- Perform update
UPDATE Enrollments SET grade = 9.5 WHERE enrollment_id = 101;

COMMIT;

-- Handling deadlock with timeout
START TRANSACTION;

-- Try to lock data with timeout
SELECT * FROM Students WHERE student_id = 1 FOR UPDATE NOWAIT; -- Error immediately if locked
-- or
SELECT * FROM Students WHERE student_id = 1 FOR UPDATE WAIT 10; -- Wait max 10 seconds

-- If deadlock occurs, MySQL will automatically rollback one transaction
-- We can handle this in application code

COMMIT;
```

## 🧑‍🏫 Lesson 4: Data Security

### User Management and Permissions

```sql
-- Create user with encrypted password
CREATE USER 'teacher_user'@'localhost' IDENTIFIED BY 'Strong_P@ssw0rd!';

-- Create role (MySQL 8.0+)
CREATE ROLE 'app_read', 'app_write', 'app_admin';

-- Grant permissions to role
GRANT SELECT ON SchoolManagement.* TO 'app_read';
GRANT SELECT, INSERT, UPDATE ON SchoolManagement.* TO 'app_write';
GRANT ALL PRIVILEGES ON SchoolManagement.* TO 'app_admin';

-- Grant role to user
GRANT 'app_write' TO 'teacher_user'@'localhost';

-- Set default role
SET DEFAULT ROLE 'app_write' TO 'teacher_user'@'localhost';

-- Grant permissions directly on specific tables
GRANT SELECT ON SchoolManagement.Students TO 'student_user'@'localhost';
GRANT SELECT, UPDATE (first_name, last_name, email) ON SchoolManagement.Students
TO 'student_user'@'localhost';

-- Revoke permissions
REVOKE UPDATE ON SchoolManagement.Students FROM 'student_user'@'localhost';
```

### Encryption and Data Security

```sql
-- Encrypt sensitive data
-- 1. Use built-in encryption function
UPDATE Users SET
    password_hash = SHA2(CONCAT(password, salt), 256)
WHERE user_id = 101;

-- 2. Use AES for data needing decryption
SET @key = 'my_secure_key';

-- Encrypt
UPDATE Students SET
    encrypted_ssn = AES_ENCRYPT(social_security_number, @key)
WHERE student_id = 1;

-- Decrypt
SELECT
    student_id,
    first_name,
    CONVERT(AES_DECRYPT(encrypted_ssn, @key) USING utf8) as ssn
FROM Students;
```

### SQL Injection Prevention

```sql
-- Unsafe way (DO NOT USE)
-- PHP code: $query = "SELECT * FROM Users WHERE username = '$username' AND password = '$password'";

-- Safe way using Prepared Statements
-- PHP with PDO
/*
$stmt = $pdo->prepare("SELECT * FROM Users WHERE username = ? AND password_hash = ?");
$stmt->execute([$username, hash('sha256', $password . $salt)]);
*/

-- Java with JDBC
/*
PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM Users WHERE username = ? AND password_hash = ?");
pstmt.setString(1, username);
pstmt.setString(2, hash("SHA-256", password + salt));
ResultSet rs = pstmt.executeQuery();
if (rs.next()) {
    // Login successful
}
*/

-- Or use stored procedure
DELIMITER //
CREATE PROCEDURE sp_AuthenticateUser(
    IN p_username VARCHAR(100),
    IN p_password VARCHAR(100)
)
BEGIN
    DECLARE p_salt VARCHAR(32);

    -- Get user salt
    SELECT salt INTO p_salt FROM Users WHERE username = p_username;

    -- Check authentication
    SELECT user_id, username, email, role
    FROM Users
    WHERE username = p_username
    AND password_hash = SHA2(CONCAT(p_password, p_salt), 256);
END //
DELIMITER ;

-- Call procedure to authenticate
CALL sp_AuthenticateUser('user1', 'password123');
```

## 🧑‍🏫 Lesson 5: SQL and Web Applications

### Connecting to Database from Application

```java
// Connecting from JAVA with JDBC
import java.sql.*;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/SchoolManagement";
    private static final String USER = "app_user";
    private static final String PASSWORD = "secure_password";

    public static void main(String[] args) {
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            System.out.println("Connection successful!");

            // Execute query
            try (Statement stmt = conn.createStatement()) {
                ResultSet rs = stmt.executeQuery("SELECT * FROM Students");

                while (rs.next()) {
                    System.out.println(rs.getInt("student_id") + " - " +
                                     rs.getString("first_name") + " " +
                                     rs.getString("last_name"));
                }
            }

            // Use Prepared Statement (safer)
            String query = "SELECT * FROM Students WHERE student_id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setInt(1, 1); // Set value for parameter
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    System.out.println("Found: " + rs.getString("first_name"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
```

```php
// Connecting from PHP with PDO
<?php
$host = 'localhost';
$db   = 'SchoolManagement';
$user = 'app_user';
$pass = 'secure_password';
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);

    // Simple query
    $stmt = $pdo->query('SELECT student_id, first_name, last_name FROM Students');
    while ($row = $stmt->fetch()) {
        echo $row['student_id'] . ' - ' . $row['first_name'] . ' ' . $row['last_name'] . '<br>';
    }

    // Prepared statement
    $stmt = $pdo->prepare('SELECT * FROM Students WHERE student_id = ?');
    $stmt->execute([1]);
    $student = $stmt->fetch();

    if ($student) {
        echo "Found: " . $student['first_name'];
    }

} catch (PDOException $e) {
    echo "Connection error: " . $e->getMessage();
}
?>
```

### Optimizing Queries for Web Applications

```sql
-- 1. Use INDEX for frequently searched columns
CREATE INDEX idx_students_email ON Students(email);
CREATE INDEX idx_enrollments_student ON Enrollments(student_id);
CREATE INDEX idx_enrollments_course ON Enrollments(course_id);

-- 2. Select only necessary columns
SELECT student_id, first_name, last_name FROM Students WHERE gender = 'F';
-- instead of
-- SELECT * FROM Students WHERE gender = 'F';

-- 3. Use LIMIT for pagination
SELECT * FROM Students LIMIT 10 OFFSET 20; -- Page 3, 10 items/page

-- 4. Use JOIN efficiently
-- Instead of multiple individual queries
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_name,
    e.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE s.student_id = 101;

-- 5. Use EXPLAIN to analyze query
EXPLAIN SELECT * FROM Students WHERE last_name LIKE 'Nguy%';
```

### Handling N+1 Problem and Performance

```java
// N+1 Problem (should not use)
List<Student> students = getStudents(); // 1 query to get student list
for (Student student : students) {
    List<Course> courses = getCoursesForStudent(student.getId()); // N queries
    // Process...
}

// Solution: use JOIN
// SQL: SELECT s.*, c.* FROM Students s JOIN Enrollments e ON ... JOIN Courses c ON ...
```

```sql
-- Optimized query to solve N+1 problem
-- Get students and enrolled courses in 1 query
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'course_id', c.course_id,
            'course_name', c.course_name,
            'grade', e.grade
        )
    ) AS enrolled_courses
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
LEFT JOIN Courses c ON e.course_id = c.course_id
GROUP BY s.student_id, s.first_name, s.last_name;
```

## 🧪 FINAL PROJECT: Library Book Borrowing Management

### Problem Description

Build a library management database with tables:

- `Books`: book information
- `Users`: user information
- `Borrowings`: borrowing transactions

### Requirements

- Design full data structure with constraints.
- Create stored procedures to:
  - Add new book.
  - Register user.
  - Handle book borrowing (check stock, record borrow date).
  - Handle book return (update status, calculate fine if overdue).
- Create triggers to:
  - Automatically update book quantity when borrowing/returning.
  - Check conditions before allowing book borrowing.
