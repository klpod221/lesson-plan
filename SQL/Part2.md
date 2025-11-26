---
prev:
  text: '💾 Introduction to SQL'
  link: '/SQL/Part1'
next:
  text: '🔄 SQL and Applications'
  link: '/SQL/Part3'
---

# 📘 PART 2: ADVANCED SQL

## 🎯 General Objectives

- Understand and use complex query techniques.
- Optimize query performance and database design.
- Know how to handle large data and ensure security.

---

## 🧑‍🏫 Lesson 1: Advanced Queries and Window Functions

### Subqueries

A subquery is a SQL query nested inside another query, which can appear in the WHERE, FROM, or SELECT clauses.

#### Example 1: Subquery in WHERE clause

```sql
-- Find students with scores higher than the average score of all students
SELECT student_id, fullname, score
FROM students
WHERE score > (SELECT AVG(score) FROM students);
```

#### Example 2: Subquery in FROM clause

```sql
-- Get information from the result of another query
SELECT dept_name, avg_salary
FROM (
    SELECT department_id, AVG(salary) as avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_salaries
JOIN departments d ON dept_salaries.department_id = d.id;
```

#### Example 3: Correlated Subquery

```sql
-- Find students with the highest score in each class
SELECT s.student_id, s.fullname, s.class_id, s.score
FROM students s
WHERE s.score = (
    SELECT MAX(score)
    FROM students s2
    WHERE s2.class_id = s.class_id
);
```

### Common Table Expressions (CTE) with WITH

CTE creates a temporary table that can be referenced multiple times in a query, making SQL code easier to read and maintain.

#### Example 1: Basic CTE

```sql
-- Find students with scores higher than the average score of their class
WITH class_avg_scores AS (
    SELECT class_id, AVG(score) AS avg_score
    FROM students
    GROUP BY class_id
)
SELECT s.student_id, s.fullname, s.score, c.avg_score
FROM students s
JOIN class_avg_scores c ON s.class_id = c.class_id
WHERE s.score > c.avg_score;
```

#### Example 2: Recursive CTE

```sql
-- Display employee hierarchy (manager - employee)
WITH RECURSIVE employee_hierarchy AS (
    -- Base case: top-level employees (no manager)
    SELECT id, fullname, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive case: find subordinates
    SELECT e.id, e.fullname, e.manager_id, eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.id
)
SELECT id, fullname, level
FROM employee_hierarchy
ORDER BY level, id;
```

### Set Operations: UNION, INTERSECT, EXCEPT

Set operations combine results from multiple SELECT queries.

#### Example 1: UNION

```sql
-- Combine list of students and teachers
SELECT 'Student' AS role, fullname, email
FROM students
UNION
SELECT 'Teacher' AS role, fullname, email
FROM teachers
ORDER BY role, fullname;
```

#### Example 2: INTERSECT

```sql
-- Find students taking both Math and Literature
-- (MySQL does not support INTERSECT directly, must use JOIN or IN)
-- Syntax with INTERSECT (PostgreSQL, SQL Server,...)
SELECT student_id
FROM course_registrations
WHERE course_id = 1  -- Math
INTERSECT
SELECT student_id
FROM course_registrations
WHERE course_id = 2;  -- Literature

-- Syntax with MySQL
SELECT cr1.student_id
FROM course_registrations cr1
JOIN course_registrations cr2 ON cr1.student_id = cr2.student_id
WHERE cr1.course_id = 1 AND cr2.course_id = 2;
```

#### Example 3: EXCEPT (MINUS)

```sql
-- Find students taking Math but not Literature
-- (MySQL does not support EXCEPT directly, must use LEFT JOIN or NOT IN)
-- Syntax with EXCEPT (PostgreSQL, SQL Server,...)
SELECT student_id
FROM course_registrations
WHERE course_id = 1  -- Math
EXCEPT
SELECT student_id
FROM course_registrations
WHERE course_id = 2;  -- Literature

-- Syntax with MySQL
SELECT DISTINCT cr1.student_id
FROM course_registrations cr1
LEFT JOIN course_registrations cr2 ON cr1.student_id = cr2.student_id AND cr2.course_id = 2
WHERE cr1.course_id = 1 AND cr2.student_id IS NULL;
```

### Window Functions

Window functions perform calculations across a set of table rows that are somehow related to the current row, but do not group rows into a single result.

#### Example 1: ROW_NUMBER()

```sql
-- Rank students by score from high to low
SELECT
    student_id,
    fullname,
    score,
    ROW_NUMBER() OVER (ORDER BY score DESC) AS rank
FROM students;
```

#### Example 2: PARTITION BY

```sql
-- Rank students by score within each class separately
SELECT
    student_id,
    fullname,
    class_id,
    score,
    ROW_NUMBER() OVER (PARTITION BY class_id ORDER BY score DESC) AS class_rank
FROM students;
```

#### Example 3: Aggregate Functions over Window

```sql
-- Calculate class average and difference of each student from class average
SELECT
    student_id,
    fullname,
    class_id,
    score,
    AVG(score) OVER (PARTITION BY class_id) AS class_avg,
    score - AVG(score) OVER (PARTITION BY class_id) AS difference_from_avg
FROM students;
```

#### Example 4: NTILE() and others

```sql
-- Divide students into 4 groups (quartiles) by score
SELECT
    student_id,
    fullname,
    score,
    NTILE(4) OVER (ORDER BY score) AS quartile,
    LEAD(score, 1) OVER (ORDER BY score) AS next_higher_score,
    LAG(score, 1) OVER (ORDER BY score) AS next_lower_score
FROM students;
```

#### Example 5: RANK() and DENSE_RANK()

```sql
-- Compare RANK() and DENSE_RANK()
SELECT
    student_id,
    fullname,
    score,
    RANK() OVER (ORDER BY score DESC) AS rank,
    DENSE_RANK() OVER (ORDER BY score DESC) AS dense_rank,
    ROW_NUMBER() OVER (ORDER BY score DESC) AS row_num
FROM students;

-- Result explanation:
-- RANK(): Has gaps when there are ties (1, 2, 2, 4, 5)
-- DENSE_RANK(): No gaps (1, 2, 2, 3, 4)
-- ROW_NUMBER(): Always increasing, unique (1, 2, 3, 4, 5)
```

#### Example 6: Running Total

```sql
-- Calculate running total of scores over time
SELECT
    student_id,
    exam_date,
    score,
    SUM(score) OVER (
        PARTITION BY student_id 
        ORDER BY exam_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total,
    AVG(score) OVER (
        PARTITION BY student_id 
        ORDER BY exam_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_3_exams
FROM exam_results
ORDER BY student_id, exam_date;
```

### Practice Exercises Lesson 1

1. **Subqueries**: Write a query to find classes with an average score higher than the overall school average score.
2. **CTE**: Use CTE to calculate student rankings within each class, then get the top 3 students of each class.
3. **Set Operations**: Find students registered for all 3 subjects: Math, Literature, and English.
4. **Window Functions**:
   - Calculate the moving average of the last 3 tests for each student.
   - Rank students by score, displaying both the score of the person above and below.

---

## 🧑‍🏫 Lesson 2: Functions, Procedures, and Triggers

### Creating and Using User-Defined Functions

#### Example 1: Function to calculate age from birthdate

- DELIMITER is used to change the delimiter character between SQL statements, making it easier to write multiple statements in a function or procedure.

```sql
DELIMITER //
CREATE FUNCTION calculate_age(birthdate DATE)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE age INT;
    SET age = YEAR(CURRENT_DATE()) - YEAR(birthdate) -
              (DATE_FORMAT(CURRENT_DATE(), '%m%d') < DATE_FORMAT(birthdate, '%m%d'));
    RETURN age;
END //
DELIMITER ;

-- Use the function
SELECT
    student_id,
    fullname,
    date_of_birth,
    calculate_age(date_of_birth) AS age
FROM students;
```

#### Example 2: Function to calculate GPA

```sql
DELIMITER //
CREATE FUNCTION calculate_gpa(student_id INT)
RETURNS DECIMAL(4,2) READS SQL DATA
BEGIN
    DECLARE avg_score DECIMAL(4,2);

    SELECT AVG(score) INTO avg_score
    FROM student_scores
    WHERE student_id = student_id;

    RETURN IFNULL(avg_score, 0);
END //
DELIMITER ;

-- Use the function
SELECT
    s.student_id,
    s.fullname,
    calculate_gpa(s.student_id) AS gpa
FROM students s;
```

#### Example 3: Function to classify academic performance

```sql
DELIMITER //
CREATE FUNCTION get_grade_ranking(score DECIMAL(4,2))
RETURNS VARCHAR(20) DETERMINISTIC
BEGIN
    DECLARE ranking VARCHAR(20);

    IF score >= 9.0 THEN
        SET ranking = 'Excellent';
    ELSEIF score >= 8.0 THEN
        SET ranking = 'Good';
    ELSEIF score >= 7.0 THEN
        SET ranking = 'Fair';
    ELSEIF score >= 5.0 THEN
        SET ranking = 'Average';
    ELSE
        SET ranking = 'Weak';
    END IF;

    RETURN ranking;
END //
DELIMITER ;

-- Use the function
SELECT
    student_id,
    fullname,
    score,
    get_grade_ranking(score) AS ranking
FROM student_scores;
```

### Stored Procedures

Stored procedures are named collections of SQL statements stored in the database. Unlike functions, procedures may not return a value and can have multiple input/output parameters.

#### Example 1: Basic procedure to get student info

```sql
DELIMITER //
CREATE PROCEDURE get_student_info(IN student_id INT)
BEGIN
    SELECT *
    FROM students
    WHERE student_id = student_id;
END //
DELIMITER ;

-- Call the procedure
CALL get_student_info(101);
```

#### Example 2: Procedure with output parameters

```sql
DELIMITER //
CREATE PROCEDURE get_class_statistics(
    IN class_id INT,
    OUT total_students INT,
    OUT avg_score DECIMAL(4,2)
)
BEGIN
    -- Calculate total students
    SELECT COUNT(*) INTO total_students
    FROM students
    WHERE class_id = class_id;

    -- Calculate average score
    SELECT AVG(score) INTO avg_score
    FROM students
    WHERE class_id = class_id;
END //
DELIMITER ;

-- Call procedure with output parameters
CALL get_class_statistics(1, @total, @avg);
SELECT @total AS 'Total Students', @avg AS 'Average Score';
```

#### Example 3: Procedure to update data

```sql
DELIMITER //
CREATE PROCEDURE update_student_score(
    IN student_id INT,
    IN subject_id INT,
    IN new_score DECIMAL(4,2),
    OUT result VARCHAR(100)
)
BEGIN
    DECLARE current_score DECIMAL(4,2);
    DECLARE score_exists INT;

    -- Check if score already exists
    SELECT COUNT(*), IFNULL(score, 0)
    INTO score_exists, current_score
    FROM student_scores
    WHERE student_id = student_id AND subject_id = subject_id;

    -- Update or insert new score
    IF score_exists > 0 THEN
        UPDATE student_scores
        SET score = new_score
        WHERE student_id = student_id AND subject_id = subject_id;

        SET result = CONCAT('Updated score from ', current_score, ' to ', new_score);
    ELSE
        INSERT INTO student_scores (student_id, subject_id, score)
        VALUES (student_id, subject_id, new_score);

        SET result = CONCAT('Added new score: ', new_score);
    END IF;
END //
DELIMITER ;

-- Call update procedure
CALL update_student_score(101, 1, 8.5, @result);
SELECT @result;
```

### Triggers and Events

A Trigger is a block of SQL code that automatically executes when a specific event occurs (like INSERT, UPDATE, DELETE). An Event is a SQL task scheduled to run at a specific time.

#### Example 1: Trigger to check score before insert

```sql
DELIMITER //
CREATE TRIGGER before_score_insert
BEFORE INSERT ON student_scores
FOR EACH ROW
BEGIN
    -- Ensure score is within valid range
    IF NEW.score < 0 THEN
        SET NEW.score = 0;
    ELSEIF NEW.score > 10 THEN
        SET NEW.score = 10;
    END IF;
END //
DELIMITER ;
```

#### Example 2: Trigger to log history of changes

```sql
-- Create history table
CREATE TABLE student_score_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    old_score DECIMAL(4,2),
    new_score DECIMAL(4,2),
    changed_by VARCHAR(50),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER after_score_update
AFTER UPDATE ON student_scores
FOR EACH ROW
BEGIN
    INSERT INTO student_score_history
       (student_id, subject_id, old_score, new_score, changed_by)
    VALUES
       (NEW.student_id, NEW.subject_id, OLD.score, NEW.score, CURRENT_USER());
END //
DELIMITER ;
```

#### Example 3: Periodic Event to calculate statistics

```sql
-- Create statistics table
CREATE TABLE class_statistics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT,
    total_students INT,
    avg_score DECIMAL(4,2),
    calculated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE EVENT calculate_class_statistics
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    INSERT INTO class_statistics (class_id, total_students, avg_score)
    SELECT
        class_id,
        COUNT(*) as total_students,
        AVG(score) as avg_score
    FROM students s
    JOIN student_scores ss ON s.student_id = ss.student_id
    GROUP BY class_id;
END //
DELIMITER ;
```

### Transactions and Error Handling

Transactions ensure data integrity when performing multiple operations. Error handling helps the application react when errors occur.

#### Example 1: Basic Transaction

```sql
-- Transfer points from one student to another
START TRANSACTION;

-- Deduct points from source student
UPDATE student_scores
SET score = score - 2
WHERE student_id = 101 AND subject_id = 1;

-- Add points to target student
UPDATE student_scores
SET score = score + 2
WHERE student_id = 102 AND subject_id = 1;

-- Check if any score is negative, if so rollback
IF EXISTS (SELECT 1 FROM student_scores WHERE score < 0) THEN
    ROLLBACK;
    SELECT 'Transaction cancelled because score became negative';
ELSE
    COMMIT;
    SELECT 'Transaction completed successfully';
END IF;
```

#### Example 2: Error Handling with DECLARE...HANDLER

```sql
DELIMITER //
CREATE PROCEDURE transfer_score(
    IN source_student_id INT,
    IN target_student_id INT,
    IN subject_id INT,
    IN points DECIMAL(4,2),
    OUT message VARCHAR(100)
)
BEGIN
    -- Declare variables
    DECLARE source_score DECIMAL(4,2);
    DECLARE exit_handler BOOLEAN DEFAULT FALSE;

    -- Declare handler for errors
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET exit_handler = TRUE;
        SET message = 'SQL Error occurred during score transfer';
        ROLLBACK;
    END;

    -- Start transaction
    START TRANSACTION;

    -- Get current score of source student
    SELECT score INTO source_score
    FROM student_scores
    WHERE student_id = source_student_id AND subject_id = subject_id;

    -- Check if enough points to transfer
    IF source_score IS NULL OR source_score < points THEN
        SET message = 'Not enough points to transfer';
        ROLLBACK;
    ELSE
        -- Deduct points from source student
        UPDATE student_scores
        SET score = score - points
        WHERE student_id = source_student_id AND subject_id = subject_id;

        -- Add points to target student
        IF EXISTS (SELECT 1 FROM student_scores WHERE student_id = target_student_id AND subject_id = subject_id) THEN
            UPDATE student_scores
            SET score = score + points
            WHERE student_id = target_student_id AND subject_id = subject_id;
        ELSE
            INSERT INTO student_scores (student_id, subject_id, score)
            VALUES (target_student_id, subject_id, points);
        END IF;

        -- If no error, commit transaction
        IF exit_handler = FALSE THEN
            COMMIT;
            SET message = CONCAT('Successfully transferred ', points, ' points');
        END IF;
    END IF;
END //
DELIMITER ;

-- Call procedure
CALL transfer_score(101, 102, 1, 2.5, @message);
SELECT @message;
```

#### Example 3: Error Control with SIGNAL

```sql
DELIMITER //
CREATE PROCEDURE insert_new_student(
    IN p_fullname VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_class_id INT
)
BEGIN
    -- Check if email already exists
    IF EXISTS (SELECT 1 FROM students WHERE email = p_email) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Email already exists in the system';
    END IF;

    -- Check if class exists
    IF NOT EXISTS (SELECT 1 FROM classes WHERE class_id = p_class_id) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Class does not exist';
    END IF;

    -- If data is valid, insert new student
    INSERT INTO students (fullname, email, class_id)
    VALUES (p_fullname, p_email, p_class_id);

    SELECT LAST_INSERT_ID() AS new_student_id;
END //
DELIMITER ;

-- Call procedure
CALL insert_new_student('Nguyen Van A', 'nguyenvana@example.com', 1);
```

## 🧑‍🏫 Lesson 3: Query Optimization

### Indexes and How They Work

An index is a data structure that improves the speed of data retrieval operations on a database table by creating a quick lookup table for one or more columns.

#### Example 1: Creating Basic Indexes

```sql
-- Create index for student fullname column for fast search
CREATE INDEX idx_student_fullname ON students(fullname);

-- Create unique index for email column
CREATE UNIQUE INDEX idx_student_email ON students(email);
```

#### Example 2: Composite Index

```sql
-- Create index for both class and score for efficient search
CREATE INDEX idx_class_score ON students(class_id, score);

-- Search using composite index
-- Efficiently uses index
SELECT * FROM students WHERE class_id = 2 AND score > 8;

-- Also efficiently uses index
SELECT * FROM students WHERE class_id = 2;

-- Does NOT efficiently use index (skips first column in index)
SELECT * FROM students WHERE score > 8;
```

#### Example 3: Removing Indexes

```sql
-- Drop unnecessary index
DROP INDEX idx_student_fullname ON students;
```

#### Example 4: Fulltext Index

```sql
-- Create fulltext index for course description column
CREATE FULLTEXT INDEX idx_course_description ON courses(description);

-- Search text using fulltext index
SELECT * FROM courses
WHERE MATCH(description) AGAINST('programming' IN NATURAL LANGUAGE MODE);
```

### Analyzing Query Execution Plans

To optimize effectively, you need to understand how MySQL executes a query. The EXPLAIN command provides information about how the query is executed.

#### Example 1: Using EXPLAIN

```sql
-- Analyze query execution
EXPLAIN SELECT * FROM students WHERE score > 8.5;
```

Result:

```text
+----+-------------+----------+------+---------------+------+---------+------+------+-------------+
| id | select_type | table    | type | possible_keys | key  | key_len | ref  | rows | Extra       |
+----+-------------+----------+------+---------------+------+---------+------+------+-------------+
|  1 | SIMPLE      | students | ALL  | NULL          | NULL | NULL    | NULL | 1000 | Using where |
+----+-------------+----------+------+---------------+------+---------+------+------+-------------+
```

Analysis:

- `type = ALL`: full table scan required
- `possible_keys = NULL`: no suitable index to use
- `rows = 1000`: estimated number of rows to scan

#### Example 2: EXPLAIN with Index

```sql
-- Create index for score column
CREATE INDEX idx_score ON students(score);

-- Re-analyze query
EXPLAIN SELECT * FROM students WHERE score > 8.5;
```

Result:

```text
+----+-------------+----------+-------+---------------+----------+---------+------+------+-----------------------+
| id | select_type | table    | type  | possible_keys | key      | key_len | ref  | rows | Extra                 |
+----+-------------+----------+-------+---------------+----------+---------+------+------+-----------------------+
|  1 | SIMPLE      | students | range | idx_score     | idx_score| 4       | NULL |  200 | Using index condition |
+----+-------------+----------+-------+---------------+----------+---------+------+------+-----------------------+
```

Analysis:

- `type = range`: uses index to search within a range
- `possible_keys = idx_score`: possible index to use
- `key = idx_score`: index actually used
- `rows = 200`: estimated number of rows to scan (significantly reduced)

#### Example 3: Analyzing JOIN

```sql
-- Analyze complex JOIN query
EXPLAIN SELECT s.student_id, s.fullname, c.class_name
FROM students s
JOIN classes c ON s.class_id = c.class_id
WHERE s.score > 8.0
ORDER BY s.fullname;
```

### SQL Statement Optimization Techniques

#### Example 1: Select Only Necessary Columns

```sql
-- BAD: Select all columns
SELECT * FROM students JOIN classes ON students.class_id = classes.class_id;

-- BETTER: Select only necessary columns
SELECT students.student_id, students.fullname, classes.class_name
FROM students
JOIN classes ON students.class_id = classes.class_id;
```

#### Example 2: Use Efficient Filtering Conditions

```sql
-- BAD: Condition not using index
SELECT * FROM students WHERE YEAR(date_of_birth) = 2000;

-- BETTER: Condition allows using index
SELECT * FROM students
WHERE date_of_birth >= '2000-01-01' AND date_of_birth <= '2000-12-31';
```

#### Example 3: Avoid Using Functions on Columns in WHERE Clause

```sql
-- BAD: Using function on column prevents index usage
SELECT * FROM students WHERE LOWER(email) = 'student@example.com';

-- BETTER: Do not use function on column in WHERE
SELECT * FROM students WHERE email = 'student@example.com';
```

#### Example 4: Use LIMIT to Restrict Results

```sql
-- BAD: Get all results when only a few are needed
SELECT * FROM students ORDER BY score DESC;

-- BETTER: Limit number of returned results
SELECT * FROM students ORDER BY score DESC LIMIT 10;
```

#### Example 5: Use EXISTS Instead of IN for Subquery

```sql
-- BAD when many results: Use IN with subquery
SELECT * FROM classes
WHERE class_id IN (SELECT class_id FROM students WHERE score > 9);

-- BETTER: Use EXISTS
SELECT * FROM classes c
WHERE EXISTS (SELECT 1 FROM students s WHERE s.class_id = c.class_id AND s.score > 9);
```

### Monitoring and Evaluating Performance

#### Example 1: Monitoring Slow Queries

```sql
-- Enable log for slow queries
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL slow_query_log_file = '/var/log/mysql/slow-queries.log';
SET GLOBAL long_query_time = 1; -- Log queries running > 1 second
```

#### Example 2: Viewing System Status

```sql
-- View status variables
SHOW STATUS LIKE 'Com_%'; -- Show number of times each command is executed

-- View InnoDB status
SHOW ENGINE INNODB STATUS;

-- View running queries
SHOW PROCESSLIST;

-- Check long-running queries
SELECT * FROM information_schema.PROCESSLIST
WHERE TIME > 60; -- Queries running more than 60 seconds
```

#### Example 3: Analyzing Table with ANALYZE

```sql
-- Analyze table to update statistics
ANALYZE TABLE students, classes, student_scores;
```

#### Example 4: Optimizing SQL Statements

```sql
-- Use EXPLAIN FORMAT=JSON for more details on execution plan
EXPLAIN FORMAT=JSON
SELECT s.student_id, s.fullname, AVG(ss.score) as avg_score
FROM students s
JOIN student_scores ss ON s.student_id = ss.student_id
WHERE s.class_id = 3
GROUP BY s.student_id, s.fullname
HAVING avg_score > 7.5
ORDER BY avg_score DESC;
```

### Practice Exercises Lesson 3

1. Create a Students table with 100,000 sample records.
2. Execute different queries and use EXPLAIN to analyze.
3. Create indexes and measure query time before and after creating indexes.
4. Rewrite inefficient queries to improve performance.

---

## 🧑‍🏫 Lesson 4: Database Design

### Normalization and Denormalization

Normalization is the process of structuring a database to minimize redundancy and ensure data consistency. Denormalization is the reverse process, adding redundancy intentionally to optimize performance.

#### Example 1: Unnormalized Data

Initial `student_courses` table:

| student_id | student_name | course_id | course_name | teacher_name | score |
| ---------- | ------------ | --------- | ----------- | ------------ | ----- |
| 101        | Nguyen Van A | C001      | Basic SQL   | Tran Van X   | 8.5   |
| 102        | Le Thi B     | C001      | Basic SQL   | Tran Van X   | 9.0   |
| 101        | Nguyen Van A | C002      | HTML/CSS    | Pham Thi Y   | 7.5   |
| 102        | Le Thi B     | C002      | HTML/CSS    | Pham Thi Y   | 8.0   |

**Issues**:

- Repetition of student, course, teacher information.
- Difficult to update (e.g., changing course name requires updating multiple rows).
- Risk of data inconsistency.

#### Example 2: Normalization to 1NF

Data in each column must be atomic (cannot be further divided).

```sql
-- Example table violating 1NF
CREATE TABLE contacts (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    phone_numbers VARCHAR(255) -- Stores multiple phone numbers in one column "098765432, 012345678"
);

-- Fix to 1NF: Split into 2 tables
CREATE TABLE contacts (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE contact_phones (
    contact_id INT,
    phone_number VARCHAR(15),
    PRIMARY KEY (contact_id, phone_number),
    FOREIGN KEY (contact_id) REFERENCES contacts(id)
);
```

#### Example 3: Normalization to 2NF

Must be 1NF and every non-key column must be fully dependent on the primary key (not dependent on part of the primary key).

```sql
-- Example table violating 2NF
CREATE TABLE student_courses (
    student_id INT,
    course_id INT,
    student_name VARCHAR(100), -- Depends on student_id (part of primary key)
    course_name VARCHAR(100), -- Depends on course_id (part of primary key)
    score DECIMAL(4,2),
    PRIMARY KEY (student_id, course_id)
);

-- Fix to 2NF: Split into 3 tables
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE courses (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    score DECIMAL(4,2),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);
```

#### Example 4: Normalization to 3NF

Must be 2NF and no non-key column depends on another non-key column (transitive dependency).

```sql
-- Example table violating 3NF
CREATE TABLE courses (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    teacher_id INT,
    teacher_name VARCHAR(100) -- Depends on teacher_id (not primary key)
);

-- Fix to 3NF: Split into 2 tables
CREATE TABLE teachers (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE courses (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);
```

#### Example 5: Intentional Denormalization

```sql
-- Store aggregated data to increase query performance
CREATE TABLE classes (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    student_count INT, -- Calculated redundancy
    avg_score DECIMAL(4,2) -- Calculated redundancy
);

-- Procedure to update aggregated data
DELIMITER //
CREATE PROCEDURE update_class_statistics(IN class_id INT)
BEGIN
    -- Update student count
    UPDATE classes c
    SET student_count = (
        SELECT COUNT(*) FROM students s WHERE s.class_id = c.id
    )
    WHERE c.id = class_id;

    -- Update average score
    UPDATE classes c
    SET avg_score = (
        SELECT AVG(score)
        FROM students s
        WHERE s.class_id = c.id
    )
    WHERE c.id = class_id;
END //
DELIMITER ;
```

### Data Modeling: Concepts and Applications

#### Example 1: Entity-Relationship (ER) Model

ER model is a way to represent entities and relationships between them in a database.

```text
+----------------+          +----------------+
|    Students    |          |     Courses    |
+----------------+          +----------------+
| id (PK)        |          | id (PK)        |
| fullname       |          | course_code    |
| email          |          | title          |
| date_of_birth  |          | description    |
| address        |          | credits        |
+----------------+          +----------------+
         |                          |
         |                          |
         +--------------------------+
         | Enrollments              |
         +--------------------------+
         | student_id (FK)          |
         | course_id (FK)           |
         | enrollment_date          |
         | grade                    |
         +--------------------------+
```

```sql
-- Implement ER model into tables
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    date_of_birth DATE,
    address VARCHAR(255)
);

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    credits INT
);

CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    grade DECIMAL(4,2),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);
```

#### Example 2: One-to-Many Relationship

```sql
-- One teacher manages multiple courses
CREATE TABLE teachers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department VARCHAR(50)
);

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);
```

#### Example 3: Many-to-Many Relationship

```sql
-- Students can register for multiple courses and each course has multiple students
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL
);

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL
);

CREATE TABLE student_courses (
    student_id INT,
    course_id INT,
    registration_date DATE,
    grade DECIMAL(4,2),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);
```

#### Example 4: One-to-One Relationship

```sql
-- Each student has one detailed profile
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE student_profiles (
    student_id INT PRIMARY KEY,
    bio TEXT,
    address VARCHAR(255),
    phone VARCHAR(15),
    avatar_url VARCHAR(255),
    FOREIGN KEY (student_id) REFERENCES students(id)
);
```

### Integrity Constraints and Relationships

#### Example 1: PRIMARY KEY Constraint

```sql
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Ensures each student has a unique id
    student_code VARCHAR(10) UNIQUE NOT NULL, -- Student code must also be unique
    fullname VARCHAR(100) NOT NULL
);
```

#### Example 2: FOREIGN KEY Constraint

```sql
CREATE TABLE enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(id)
        ON DELETE CASCADE -- Automatically delete when student is deleted
        ON UPDATE CASCADE, -- Automatically update when student id changes
    FOREIGN KEY (course_id) REFERENCES courses(id)
        ON DELETE RESTRICT -- Do not allow deleting course if students are enrolled
);
```

#### Example 3: CHECK Constraint

```sql
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    age INT CHECK (age >= 18), -- Ensure age >= 18
    email VARCHAR(100) UNIQUE CHECK (email LIKE '%@%.%') -- Ensure email has valid format
);

-- For MySQL < 8.0.16 not supporting CHECK directly, can use TRIGGER
DELIMITER //
CREATE TRIGGER check_student_age
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
    IF NEW.age < 18 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Age must be greater than or equal to 18';
    END IF;
END //
DELIMITER ;
```

#### Example 4: DEFAULT Constraint

```sql
CREATE TABLE enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE DEFAULT (CURRENT_DATE), -- Automatically set current date
    status VARCHAR(20) DEFAULT 'Active', -- Default status
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);
```

#### Example 5: NOT NULL Constraint

```sql
CREATE TABLE teachers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL, -- Cannot be empty
    email VARCHAR(100) NOT NULL UNIQUE, -- Cannot be empty and must be unique
    department VARCHAR(50)
);
```

### Performance-Oriented Design

#### Example 1: Choosing Appropriate Data Types

```sql
-- Inefficient
CREATE TABLE products (
    id VARCHAR(255) PRIMARY KEY, -- Using VARCHAR for id
    name VARCHAR(255), -- Using VARCHAR too large for product name
    price VARCHAR(50), -- Storing money as string
    description TEXT -- Using TEXT for all descriptions
);

-- More Efficient
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Using INT saves more space for ID
    name VARCHAR(100), -- Reasonable size limit
    price DECIMAL(10,2), -- Using DECIMAL for money
    description VARCHAR(1000) -- Size limit for short description
);
```

#### Example 2: Table Partitioning

```sql
-- Partition data by year to improve query performance
CREATE TABLE orders (
    id INT AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    PRIMARY KEY(id, order_date)
)
PARTITION BY RANGE (YEAR(order_date)) (
    PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION pOthers VALUES LESS THAN MAXVALUE
);

-- Efficient query only scans one partition
SELECT * FROM orders WHERE order_date BETWEEN '2022-01-01' AND '2022-12-31';
```

#### Example 3: Efficient Indexing

- Index columns frequently used in WHERE or JOIN conditions

```sql
-- Create single index for columns often used in WHERE
CREATE INDEX idx_student_email ON students(email);

-- Create composite index for columns often used together
CREATE INDEX idx_course_dept_semester ON courses(department_id, semester);

-- Create covering index to avoid data lookup
CREATE INDEX idx_student_list ON students(class_id, fullname, email);
-- Allows the following query to use only index without accessing table:
-- SELECT fullname, email FROM students WHERE class_id = 5;
```

#### Example 4: Using Materialized Views (Aggregated Tables)

```sql
-- Create table for aggregated statistics
CREATE TABLE class_statistics (
    class_id INT PRIMARY KEY,
    total_students INT,
    avg_score DECIMAL(4,2),
    highest_score DECIMAL(4,2),
    lowest_score DECIMAL(4,2),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Procedure to update aggregated table
DELIMITER //
CREATE PROCEDURE refresh_class_statistics()
BEGIN
    -- Clear old data
    TRUNCATE TABLE class_statistics;

    -- Insert new data
    INSERT INTO class_statistics (class_id, total_students, avg_score, highest_score, lowest_score)
    SELECT
        class_id,
        COUNT(*) AS total_students,
        AVG(score) AS avg_score,
        MAX(score) AS highest_score,
        MIN(score) AS lowest_score
    FROM students
    GROUP BY class_id;

    -- Update time
    UPDATE class_statistics SET last_updated = CURRENT_TIMESTAMP;
END //
DELIMITER ;

-- Schedule daily update
CREATE EVENT refresh_class_statistics
ON SCHEDULE EVERY 1 DAY
DO
CALL refresh_class_statistics();
```

#### Example 5: Proper Schema Design

```sql
-- Hierarchical schema design
CREATE DATABASE school_management;

USE school_management;

-- Departments table
CREATE TABLE departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Staff table (placed in main schema)
CREATE TABLE staff (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- Create separate schema for academic data
CREATE DATABASE school_management_academic;

USE school_management_academic;

-- Students table
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL
);

-- Set access permissions
GRANT SELECT, INSERT, UPDATE ON school_management.staff TO 'admin_user'@'localhost';
GRANT SELECT ON school_management_academic.students TO 'teacher_user'@'localhost';
```

### Practice Exercises: Database Design

1. Given unnormalized sales data, analyze and redesign according to 1NF, 2NF, and 3NF standards.

   ```sql
    -- Unnormalized table
    CREATE TABLE sales (
        order_id INT,
        customer_name VARCHAR(100),
        product_name VARCHAR(100),
        quantity INT,
        price DECIMAL(10,2),
        order_date DATE
    );
   ```

    - **Requirement**: Split into separate tables for customers, products, and orders. Ensure no redundant data and all tables meet 3NF.

2. Design an ER model for a library management system, including books, readers, borrowing/returning; Convert ER model to SQL tables with full constraints; Identify necessary indexes to improve query performance.

---

## 🧑‍🏫 Lesson 5: Security and Administration

1. User Management and Permissions

   - **Create User**:

     ```sql
     CREATE USER 'student_user'@'localhost' IDENTIFIED BY 'secure_password';
     ```

   - **Grant Specific Permissions**:

     ```sql
     -- Grant SELECT on a specific table
     GRANT SELECT ON school_management.students TO 'student_user'@'localhost';

     -- Grant multiple permissions
     GRANT SELECT, INSERT, UPDATE ON school_management.* TO 'teacher_user'@'localhost';

     -- Grant all privileges (only for admin)
     GRANT ALL PRIVILEGES ON school_management.* TO 'admin_user'@'localhost';
     ```

   - **Revoke Permissions**:

     ```sql
     REVOKE INSERT, UPDATE ON school_management.students FROM 'student_user'@'localhost';
     ```

   - **View User Permissions**:

     ```sql
     SHOW GRANTS FOR 'student_user'@'localhost';
     ```

2. Backup and Recovery

   - **Backup Database**:

   ```bash
   # Use mysqldump to create backup
   mysqldump -u root -p school_management > school_backup.sql

   # Backup only table structure (no data)
   mysqldump -u root -p --no-data school_management > schema_backup.sql

   # Backup specific tables
   mysqldump -u root -p school_management students courses > tables_backup.sql
   ```

   - **Restore Data**:

   ```bash
   # Restore from backup file
   mysql -u root -p school_management < school_backup.sql

   # Execute from within MySQL client
   SOURCE /path/to/school_backup.sql;
   ```

   - **Schedule Automatic Backup** (Linux crontab):

   ```bash
   # Daily backup at 01:00 AM
   0 1 * * * mysqldump -u root -p'password' school_management > /backup/school_$(date +\%Y\%m\%d).sql
   ```

3. Security and SQL Injection Prevention

   - **SQL Injection Issue**:

   ```sql
   -- Dangerous example (DO NOT DO THIS):
   $username = $_POST['username'];
   $query = "SELECT * FROM users WHERE username = '$username'";
   -- If user enters: admin' --
   -- Query becomes: SELECT * FROM users WHERE username = 'admin' --'
   ```

   - **How to Prevent SQL Injection**:

   1. **Use Prepared Statements**:

      ```php
      // PHP with PDO
      $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
      $stmt->execute([$username]);

      // JAVA with JDBC
      PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE username = ?");
      stmt->setString(1, username);
      ```

   2. **Validate and Sanitize Input**:

      ```php
      $username = mysqli_real_escape_string($conn, $_POST['username']);
      ```

   3. **Use ORM (Object-Relational Mapping)**:

      ```java
      // Use Hibernate in JAVA
      User user = session.createQuery("from User where username = :username")
          .setParameter("username", username)
          .uniqueResult();
      ```

### Monitoring and Tuning System

- **Monitor Slow Queries**:

  ```sql
  -- Enable slow query log in MySQL
  SET GLOBAL slow_query_log = 'ON';
  SET GLOBAL slow_query_log_file = '/var/log/mysql/slow-queries.log';
  SET GLOBAL long_query_time = 2; -- Log queries running > 2 seconds
  ```

- **View System Status**:

  ```sql
  -- View system status variables
  SHOW STATUS;

  -- View configuration variables
  SHOW VARIABLES;

  -- View active connections
  SHOW PROCESSLIST;
  ```

- **Optimize MySQL Configuration**:

  ```ini
  # Example configuration in my.cnf
  [mysqld]
  # Buffer pool size for InnoDB
  innodb_buffer_pool_size = 1G

  # Query cache
  query_cache_size = 64M

  # Log file size
  max_binlog_size = 100M
  ```

---

## 🧪 FINAL PROJECT: Student and Class Management

### Problem Description

Expand the student management database:

- Create `classes` table to store class information.
- Create one-to-many relationship between `classes` and `students`.
- Add `subjects` table to store subject information.

### Requirements

- Design tables with appropriate primary and foreign keys.
- Write queries to:
  - Search students by name or code.
  - List students by class.
  - Calculate average score of each class.
  - Sort students by average score.
  - Find students with the highest score in each class.
- Query data from multiple tables using various JOIN types.
