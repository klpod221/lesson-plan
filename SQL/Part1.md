---
prev:
  text: '📁 File I/O and Collections'
  link: '/JAVA/Part4'
next:
  text: '📊 Advanced SQL'
  link: '/SQL/Part2'
---

# 📘 PART 1: INTRODUCTION TO SQL

## 🎯 General Objectives

- Get familiar with SQL syntax and usage.
- Know how to create databases, tables, and manipulate data.
- Understand query statements and data joining.

## 🧑‍🏫 Lesson 1: Introduction to SQL and Databases

### Relational Database Concepts

- A Relational Database Management System (RDBMS) is a system that stores data in tables with columns and rows.
- Each table has columns representing attributes and rows representing data records.
- Tables can be linked to each other via primary keys and foreign keys.

### Common RDBMS

| System      | Pros                                         | Cons                                         |
| ----------- | -------------------------------------------- | -------------------------------------------- |
| MySQL       | Free, popular, easy to use                   | Lower performance compared to some other DBMS|
| PostgreSQL  | Powerful, many advanced features             | More complex to configure                    |
| SQL Server  | Good integration with Microsoft products     | High licensing cost                          |
| Oracle      | High stability, many enterprise features     | Very expensive and complex                   |
| SQLite      | Lightweight, serverless, embeddable          | Not suitable for large multi-user apps       |

### Management Tools

- [MySQL Workbench](https://www.mysql.com/products/workbench/): Official tool from MySQL, supports database design and management.
- [phpMyAdmin](https://www.phpmyadmin.net/): Web-based MySQL management tool, easy to use for beginners (recommended).
- [HeidiSQL](https://www.heidisql.com/): Free MySQL management tool on Windows, friendly interface.
- [DBeaver](https://dbeaver.io/): Cross-platform DB management tool, supports many different DBs.
- [DataGrip](https://www.jetbrains.com/datagrip/): DB management tool from JetBrains, supports many DBs, paid.
- [Navicat](https://www.navicat.com/products/navicat-for-mysql): Commercial DB management tool, beautiful interface and powerful features.

### Using phpMyAdmin to Manage Databases

- phpMyAdmin is a MySQL/MariaDB management tool written in PHP, allowing you to manage databases via a web browser. It is very popular, especially for beginners due to its intuitive and easy-to-use interface.
- I have guided the installation of phpMyAdmin in the [learning environment setup](../INSTALL.md) section. You can refer back to it for installation and configuration instructions.

#### Using phpMyAdmin

1. **Login**:
   - Username: usually "root"
   - Password: the password you set for MySQL

2. **Main Interface**:
   - Left side: List of databases
   - Right side: Options and information

3. **Basic Features**:
   - Create new database: Click "New" or "Database"
   - Create table: Select a database, click "Create table"
   - Execute queries: Click the "SQL" tab to enter and run SQL commands
   - Manage data: Click on a table name to view, add, edit, delete data
   - Export/Import data: Use the "Export" and "Import" options

4. **Pros of phpMyAdmin**:
   - Intuitive, easy-to-use interface
   - No need to install separate software (just a browser)
   - Supports many advanced features like user management, access rights
   - Can perform complex operations without writing SQL

### Using VSCode Extension to Connect to DB

- As mentioned in the [VSCode section](../INSTALL.md#installing-necessary-extensions) of the environment setup guide, you can use the [MySQL](https://marketplace.visualstudio.com/items?itemName=cweijan.vscode-mysql-client2) extension to connect and manage databases right within VSCode. The steps are as follows:

  1. Install the MySQL extension from VS Code Marketplace.
  2. After installation, you will see the MySQL icon in the left sidebar of VS Code.
  3. Click the MySQL icon, then click the "+" icon to create a new connection.
  4. Enter connection information:
     - **Connection name**: Name of the connection (custom)
     - **Select Type**: Select connection type (MySQL or MariaDB)
     - **Host**: Server address (usually localhost)
     - **Port**: Connection port (default is 3306)
     - **Username**: Username (usually root)
     - **Password**: User's password
     - **Database**: Database name (can be left empty to show all databases)
  5. Click "Connect" to test the connection.
     - If successful, you will see a list of databases and tables in the left sidebar.
     - If unsuccessful, check the connection info and ensure the MySQL server is running.
  6. Click "Save" to save the connection.
  7. After connecting successfully, you can:
     - View all databases in the system.
     - Expand databases to view tables, views, procedures, and other components.
     - Right-click on components to perform actions like editing data, exporting data, etc.
     - Create SQL files and run commands directly from VS Code.

  ```sql
  -- test.sql
  SHOW DATABASES; -- Show list of databases
  ```

## 🧑‍🏫 Lesson 2: Creating and Managing Databases

### Creating and Managing Databases

```sql
-- Create a new database
CREATE DATABASE school_management;

-- Use the database
USE school_management;

-- Delete database (be careful with this command)
DROP DATABASE school_management;
```

### Basic Data Types in SQL

- Like other programming languages, SQL has data types to store information. Here are some common data types in SQL:

  | Data Type    | Description                                      | Example               |
  | ------------ | ------------------------------------------------ | --------------------- |
  | INT          | Integer                                          | 10, -5, 0             |
  | DECIMAL(p,s) | Decimal number with p digits, s digits after dot | 123.45                |
  | VARCHAR(n)   | Variable length string, max n characters         | 'Hello'               |
  | CHAR(n)      | Fixed length string of n characters              | 'ABC'                 |
  | TEXT         | Long text string                                 | Long paragraph        |
  | DATE         | Date (YYYY-MM-DD)                                | '2023-05-25'          |
  | DATETIME     | Date and time                                    | '2023-05-25 10:30:00' |
  | BOOLEAN      | Logical value (TRUE/FALSE)                       | TRUE, FALSE           |
  | BLOB         | Large binary data                                | Images, files         |

### Some Constraints in SQL

- `PRIMARY KEY`: Ensures uniqueness for each record.
- `AUTO_INCREMENT`: Automatically increments value for a column (usually for primary key).
- `FOREIGN KEY`: Links to a primary key in another table.
- `NOT NULL`: Must have a value.
- `UNIQUE`: Ensures value is unique in the column.
- `DEFAULT`: Defines a default value.
- `CHECK`: Adds a validity condition for the value.

### Creating Tables and Constraints

```sql
-- Create students table
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    date_of_birth DATE,
    gender CHAR(1),
    admission_date DATE DEFAULT (CURRENT_DATE),
    is_active BOOLEAN DEFAULT TRUE
);

-- Create courses table
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    credits INT CHECK (credits > 0),
    department VARCHAR(50)
);

-- Create enrollments table with foreign keys
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade DECIMAL(4,1),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    UNIQUE (student_id, course_id) -- Do not allow a student to register for the same course twice
);
```

### Database Relationship Diagram

```text
+----------------+        +-----------------+        +-------------+
| students       |        | enrollments     |        | courses     |
+----------------+        +-----------------+        +-------------+
| student_id     |<-------| student_id      |        | course_id   |
| first_name     |        | course_id       |------->| course_name |
| last_name      |        | enrollment_id   |        | credits     |
| email          |        | enrollment_date |        | department  |
| date_of_birth  |        | grade           |        |             |
| gender         |        +-----------------+        +-------------+
| admission_date |
| is_active      |
+----------------+
```

- Relationship explanation:
  - A student (`students`) can register for multiple courses → 1-n relationship with `enrollments`.
  - A course (`courses`) can be registered by multiple students → 1-n relationship with `enrollments`.
  - The `enrollments` table is an intermediate table creating an n-n relationship between students and courses.

## 🧑‍🏫 Lesson 3: Data Manipulation

### Adding Data with INSERT INTO

```sql
-- Add a single record
INSERT INTO students (first_name, last_name, email, date_of_birth, gender)
VALUES ('Van', 'Nguyen', 'van.nguyen@example.com', '2000-05-15', 'M');

-- Add multiple records
INSERT INTO students (first_name, last_name, email, date_of_birth, gender)
VALUES
    ('Thi', 'Le', 'thi.le@example.com', '2001-03-21', 'F'),
    ('Minh', 'Tran', 'minh.tran@example.com', '1999-11-08', 'M'),
    ('Hoa', 'Pham', 'hoa.pham@example.com', '2002-07-30', 'F');

-- Add data from another table (copy data)
INSERT INTO archived_students (student_id, first_name, last_name, email)
SELECT student_id, first_name, last_name, email
FROM students
WHERE admission_date < '2022-01-01';
```

### Updating Data with UPDATE

```sql
-- Update a column for all records
UPDATE students SET is_active = TRUE;

-- Update a specific record
UPDATE students SET email = 'new.email@example.com'
WHERE student_id = 5;

-- Update multiple columns
UPDATE students
SET
    first_name = 'Thanh',
    last_name = 'Hoang',
    is_active = FALSE
WHERE student_id = 10;

-- Update based on complex condition
UPDATE enrollments
SET grade = grade + 0.5
WHERE grade < 5.0 AND course_id IN (SELECT course_id FROM courses WHERE department = 'Math');

-- Note: Always be careful when UPDATE without WHERE (it will update all records)
```

### Deleting Data with DELETE

```sql
-- Delete a specific record
DELETE FROM students WHERE student_id = 15;

-- Delete multiple records based on condition
DELETE FROM students WHERE is_active = FALSE;

-- Delete data based on subquery
DELETE FROM enrollments
WHERE student_id IN (SELECT student_id FROM students WHERE is_active = FALSE);

-- Delete all data in table (CAUTION!)
DELETE FROM enrollments;

-- Or faster (resets auto-increment too)
TRUNCATE TABLE enrollments;
```

### Changing Table Structure with ALTER TABLE

```sql
-- Add new column
ALTER TABLE students ADD COLUMN phone VARCHAR(20);

-- Add column with default value
ALTER TABLE students ADD COLUMN nationality VARCHAR(50) DEFAULT 'Vietnam';

-- Rename column
ALTER TABLE students CHANGE first_name given_name VARCHAR(50);
-- Or (depending on DBMS)
ALTER TABLE students RENAME COLUMN first_name TO given_name;

-- Change column data type
ALTER TABLE students MODIFY email VARCHAR(150);

-- Drop column
ALTER TABLE students DROP COLUMN phone;

-- Add primary key (if not exists)
ALTER TABLE students ADD PRIMARY KEY (student_id);

-- Add foreign key
ALTER TABLE enrollments ADD CONSTRAINT fk_student
FOREIGN KEY (student_id) REFERENCES students(student_id);

-- Drop foreign key
ALTER TABLE enrollments DROP FOREIGN KEY fk_student;

-- Rename table
ALTER TABLE students RENAME TO student_records;
```

## 🧑‍🏫 Lesson 4: Data Querying

### Basic Query with SELECT

```sql
-- Get all data from students table
SELECT * FROM students;

-- Get specific columns
SELECT first_name, last_name, email FROM students;

-- Rename columns in result
SELECT
    first_name AS 'First Name',
    last_name AS 'Last Name',
    date_of_birth AS 'Date of Birth'
FROM students;

-- Combine columns
SELECT
    CONCAT(first_name, ' ', last_name) AS 'Full Name',
    email
FROM students;
```

### Filtering Data with WHERE

```sql
-- Filter by condition
SELECT * FROM students WHERE gender = 'F';

-- Multiple conditions with AND and OR
SELECT * FROM students
WHERE gender = 'M' AND is_active = TRUE;

SELECT * FROM students
WHERE gender = 'F' OR date_of_birth > '2000-01-01';

-- Check for NULL values
SELECT * FROM students WHERE email IS NULL;
SELECT * FROM students WHERE email IS NOT NULL;

-- Search with LIKE
SELECT * FROM students WHERE last_name LIKE 'Nguy%'; -- Starts with "Nguy"
SELECT * FROM students WHERE email LIKE '%@gmail.com'; -- Ends with "@gmail.com"
SELECT * FROM students WHERE first_name LIKE '_an'; -- 3 characters, ends with "an"

-- Check value in set
SELECT * FROM courses WHERE department IN ('IT', 'Math', 'Physics');

-- Check value in range
SELECT * FROM enrollments WHERE grade BETWEEN 8.0 AND 10.0;
```

### Sorting Results with ORDER BY

```sql
-- Sort ascending by last name
SELECT * FROM students ORDER BY last_name ASC;

-- Sort descending by date of birth
SELECT * FROM students ORDER BY date_of_birth DESC;

-- Sort by multiple columns
SELECT * FROM students ORDER BY gender, last_name, first_name;

-- Combined sort ascending/descending
SELECT * FROM enrollments ORDER BY course_id ASC, grade DESC;
```

### Limiting Results with LIMIT (MySQL, PostgreSQL) or TOP (SQL Server)

- Usually used to limit the number of records returned in a query. Helps with data pagination or getting the first few records.

```sql
-- MySQL/PostgreSQL: Get first 5 students
SELECT * FROM students LIMIT 5;

-- MySQL/PostgreSQL: Get 5 students starting from 10th position
SELECT * FROM students LIMIT 5 OFFSET 10;

-- SQL Server: Get first 5 students
SELECT TOP 5 * FROM students;

-- Combine ORDER BY and LIMIT to get top 3 highest grades
SELECT * FROM enrollments ORDER BY grade DESC LIMIT 3;
```

## 🧑‍🏫 Lesson 5: Joining Data

### Joining Tables with JOIN

```sql
-- INNER JOIN: only get matching data in both tables
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_name,
    e.grade
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id;

-- LEFT JOIN: get all data from left table, and matching data from right table
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    COUNT(e.enrollment_id) AS enrolled_courses
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, student_name;

-- RIGHT JOIN: get all data from right table, and matching data from left table
SELECT
    c.course_id,
    c.course_name,
    COUNT(e.enrollment_id) AS student_count
FROM enrollments e
RIGHT JOIN courses c ON e.course_id = c.course_id
GROUP BY c.course_id, c.course_name;

-- FULL JOIN (not directly supported in MySQL)
-- PostgreSQL:
SELECT s.student_id, c.course_id
FROM students s
FULL JOIN enrollments e ON s.student_id = e.student_id
FULL JOIN courses c ON e.course_id = c.course_id;

-- Replace FULL JOIN in MySQL
SELECT s.student_id, c.course_id
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id
UNION
SELECT s.student_id, c.course_id
FROM students s
RIGHT JOIN enrollments e ON s.student_id = e.student_id
RIGHT JOIN courses c ON e.course_id = c.course_id;
```

### Grouping Data with GROUP BY

```sql
-- Count students by gender
SELECT
    gender,
    COUNT(*) AS student_count
FROM students
GROUP BY gender;

-- Calculate average grade for each course
SELECT
    c.course_id,
    c.course_name,
    AVG(e.grade) AS average_grade
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

-- Group by multiple columns
SELECT
    c.department,
    s.gender,
    COUNT(*) AS enrollment_count
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
JOIN students s ON e.student_id = s.student_id
GROUP BY c.department, s.gender;
```

### Aggregate Functions

```sql
-- COUNT: count number of records
SELECT COUNT(*) AS total_students FROM students;
SELECT COUNT(email) AS students_with_email FROM students; -- Does not count NULL

-- SUM: calculate sum
SELECT SUM(credits) AS total_credits FROM courses;

-- AVG: calculate average
SELECT AVG(grade) AS average_grade FROM enrollments;

-- MAX, MIN: find max, min values
SELECT
    MAX(grade) AS highest_grade,
    MIN(grade) AS lowest_grade
FROM enrollments;

-- Combine multiple aggregate functions
SELECT
    COUNT(*) AS enrollment_count,
    AVG(grade) AS average_grade,
    MAX(grade) AS highest_grade,
    MIN(grade) AS lowest_grade,
    SUM(grade) / COUNT(*) AS calculated_average
FROM enrollments;
```

### Filtering Grouped Data with HAVING

```sql
-- Find courses with more than 10 students enrolled
SELECT
    c.course_id,
    c.course_name,
    COUNT(e.student_id) AS student_count
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING student_count > 10;

-- Find students with average grade above 8.0
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    AVG(e.grade) AS average_grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, student_name
HAVING average_grade > 8.0
ORDER BY average_grade DESC;

-- Note the difference between WHERE and HAVING:
-- WHERE filters data before grouping
-- HAVING filters data after grouping
SELECT
    c.department,
    COUNT(*) AS course_count,
    AVG(credits) AS average_credits
FROM courses c
WHERE credits > 2 -- Filter before grouping
GROUP BY c.department
HAVING average_credits > 3 -- Filter after grouping
ORDER BY course_count DESC;
```

## 🧪 FINAL PROJECT: Student Management

### Problem Description

Build a database to store and manage student grades:

- Create database `student_management`
- Design `students` table with fields:
  - `student_id` (primary key)
  - `full_name`
  - `math_score`
  - `physics_score`
  - `chemistry_score`
  - `average_score` (can be calculated)
  - `classification` (academic classification)

### Requirements

- Write SQL commands to create database and table.
- Add sample data for 5 students.
- Write query to calculate average score for each student.
- Write query to update academic classification based on average score:
  - Avg >= 8.0 → Excellent (Giỏi)
  - 6.5 <= Avg < 8.0 → Good (Khá)
  - 5.0 <= Avg < 6.5 → Average (Trung bình)
  - < 5.0 → Weak (Yếu)
- Display list of students with average score and classification.

### Program Output (Example)

```text
+------------+---------------+------------+---------------+-----------------+---------------+----------------+
| student_id | full_name     | math_score | physics_score | chemistry_score | average_score | classification |
+------------+---------------+------------+---------------+-----------------+---------------+----------------+
|          4 | Pham Thi D    |        9.0 |           8.5 |             8.0 |          8.50 | Excellent      |
|          1 | Nguyen Van A  |        8.5 |           7.5 |             9.0 |          8.33 | Excellent      |
|          2 | Tran Thi B    |        6.5 |           7.0 |             8.0 |          7.17 | Good           |
|          3 | Le Van C      |        5.0 |           6.0 |             7.0 |          6.00 | Average        |
|          5 | Hoang Van E   |        4.0 |           5.0 |             4.5 |          4.50 | Weak           |
+------------+---------------+------------+---------------+-----------------+---------------+----------------+
```
