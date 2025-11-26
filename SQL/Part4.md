---
prev:
  text: '🔄 SQL and Applications'
  link: '/SQL/Part3'
next:
  text: '🏆 SQL Final Project'
  link: '/SQL/FINAL'
---

# 📘 PART 4: EXPERT SQL AND PERFORMANCE

## 🎯 General Objectives

- Optimize query performance and data structure.
- Handle large data efficiently.
- Implement complex data solutions.

## 🧑‍🏫 Lesson 1: Performance Optimization

### Query Execution Plan and Analysis

```sql
-- Use EXPLAIN to analyze query execution plan
EXPLAIN SELECT s.student_id, s.first_name, s.last_name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.department = 'Computer Science';

-- Detailed analysis with EXPLAIN FORMAT=JSON
EXPLAIN FORMAT=JSON
SELECT * FROM Students WHERE last_name LIKE 'Nguy%';

-- More detailed analysis with ANALYZE (PostgreSQL/MySQL 8.0+)
EXPLAIN ANALYZE
SELECT s.student_id, AVG(e.grade) as avg_grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id
HAVING AVG(e.grade) > 8.0;
```

### Advanced Indexing (Composite, Covering, Filtered)

```sql
-- Composite Index (multi-column)
CREATE INDEX idx_student_name ON Students(last_name, first_name);

-- Covering Index (includes all columns in query)
CREATE INDEX idx_enrollment_covering ON Enrollments(student_id, course_id, grade, enrollment_date);

-- Query using covering index (no table access needed)
SELECT student_id, course_id, grade FROM Enrollments WHERE student_id = 1001;

-- Filtered Index (SQL Server)
-- CREATE INDEX idx_active_students ON Students(student_id) WHERE is_active = 1;

-- Full-Text Index (for text search)
CREATE FULLTEXT INDEX ON Articles(content);

-- Search with Full-Text
SELECT * FROM Articles
WHERE MATCH(content) AGAINST('machine learning AI' IN NATURAL LANGUAGE MODE);
```

### Data Partitioning Strategies

```sql
-- Range Partitioning (MySQL)
CREATE TABLE Sales (
    sale_id INT NOT NULL,
    sale_date DATE NOT NULL,
    amount DECIMAL(10,2),
    customer_id INT,
    PRIMARY KEY (sale_id, sale_date)
)
PARTITION BY RANGE (YEAR(sale_date)) (
    PARTITION p2020 VALUES LESS THAN (2021),
    PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION pMax VALUES LESS THAN MAXVALUE
);

-- List Partitioning
CREATE TABLE RegionalSales (
    sale_id INT NOT NULL,
    region VARCHAR(20) NOT NULL,
    amount DECIMAL(10,2),
    PRIMARY KEY (sale_id, region)
)
PARTITION BY LIST (region) (
    PARTITION pNorth VALUES IN ('North', 'Northwest', 'Northeast'),
    PARTITION pSouth VALUES IN ('South', 'Southwest', 'Southeast'),
    PARTITION pCentral VALUES IN ('Central', 'Midwest'),
    PARTITION pOthers VALUES IN ('International', 'Unknown')
);

-- Hash Partitioning
CREATE TABLE UserActivity (
    user_id INT NOT NULL,
    activity_date DATE,
    activity_type VARCHAR(50),
    PRIMARY KEY (user_id, activity_date)
)
PARTITION BY HASH (user_id) PARTITIONS 8;
```

### Database Server Configuration Tuning

```sql
-- View current configuration variables
SHOW VARIABLES LIKE 'innodb_buffer_pool_size';
SHOW VARIABLES LIKE 'max_connections';
SHOW VARIABLES LIKE 'query_cache%';

-- Set temporary configuration
SET GLOBAL innodb_buffer_pool_size = 4294967296; -- 4GB

-- Monitor performance
SHOW STATUS LIKE 'Threads_connected';
SHOW STATUS LIKE 'Slow_queries';

-- Set slow query log
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 2.0; -- Log queries running > 2 seconds
```

**Example settings in my.cnf (MySQL)**:

```ini
[mysqld]
# InnoDB Buffer Pool (50-70% RAM)
innodb_buffer_pool_size=4G

# Log file size
innodb_log_file_size=512M

# Lock wait timeout
innodb_lock_wait_timeout=50

# Query cache
query_cache_type=1
query_cache_size=128M

# Slow query log
slow_query_log=1
slow_query_log_file=/var/log/mysql/mysql-slow.log
long_query_time=2
```

## 🧑‍🏫 Lesson 2: Handling Large Data

### Techniques for Manipulating Tables with Millions of Rows

```sql
-- Pagination (instead of fetching all)
SELECT * FROM LargeTable
ORDER BY id
LIMIT 1000 OFFSET 10000;

-- Use batch query to process large data
-- Batch 1:
SELECT * FROM LargeTable WHERE id BETWEEN 1 AND 10000;
-- Batch 2:
SELECT * FROM LargeTable WHERE id BETWEEN 10001 AND 20000;

-- Batch UPDATE to avoid long table locks
UPDATE LargeTable SET status = 'archived'
WHERE create_date < '2022-01-01'
LIMIT 10000;

-- Use variables to track processing progress
SET @batch_size = 5000;
SET @total_processed = 0;

prepare_batch:
    UPDATE LargeTable SET processed = 1
    WHERE processed = 0
    LIMIT @batch_size;

    SET @total_processed = @total_processed + ROW_COUNT();

    -- Continue until no records processed
    IF ROW_COUNT() > 0 THEN
        -- Processing logic here
        SELECT CONCAT('Processed ', @total_processed, ' records') AS progress;
        -- Wait a bit to reduce DB load
        DO SLEEP(1);
        GOTO prepare_batch;
    END IF;
```

### Data Analysis with Advanced Window Functions

```sql
-- Calculate grade rank for each student in each course
SELECT
    e.student_id,
    s.first_name,
    s.last_name,
    e.course_id,
    c.course_name,
    e.grade,
    RANK() OVER (PARTITION BY e.course_id ORDER BY e.grade DESC) AS grade_rank
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- Calculate rolling average
SELECT
    sale_date,
    amount,
    AVG(amount) OVER (
        ORDER BY sale_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS weekly_moving_avg
FROM Sales
ORDER BY sale_date;

-- Calculate cumulative sum
SELECT
    sale_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY EXTRACT(YEAR FROM sale_date)
        ORDER BY sale_date
    ) AS yearly_cumulative_total
FROM Sales
ORDER BY sale_date;

-- Compare with previous and next values
SELECT
    sale_date,
    amount,
    LAG(amount, 1) OVER (ORDER BY sale_date) AS previous_day_amount,
    LEAD(amount, 1) OVER (ORDER BY sale_date) AS next_day_amount,
    amount - LAG(amount, 1) OVER (ORDER BY sale_date) AS day_over_day_change
FROM Sales
ORDER BY sale_date;
```

### Backup and Recovery Strategy for Large Data

```bash
# Backup entire database
mysqldump -u root -p --single-transaction --routines --triggers --events SchoolDB > schooldb_full_backup.sql

# Backup schema only
mysqldump -u root -p --no-data SchoolDB > schooldb_schema.sql

# Backup specific tables
mysqldump -u root -p SchoolDB Students > students_backup.sql
mysqldump -u root -p SchoolDB Enrollments > enrollments_backup.sql

# Scheduled backup (using crontab)
# 0 2 * * * mysqldump -u root -p'password' --single-transaction SchoolDB > /backup/schooldb_$(date +\%Y\%m\%d).sql

# Restore from backup
mysql -u root -p SchoolDB < schooldb_full_backup.sql

# Backup using Percona XtraBackup (for MySQL/MariaDB)
# xtrabackup --backup --target-dir=/backup/mysql/full

# Incremental backup
# xtrabackup --backup --target-dir=/backup/mysql/inc1 --incremental-basedir=/backup/mysql/full
```

### Distributed Data Querying

```sql
-- Example with MySQL Cluster: query distributed data as normal
SELECT * FROM distributed_table WHERE partition_key = 123;

-- Using Sharding on application (e.g., query on specific database)
-- In application:
/*
if (user_id < 1000000) {
    // Connect to Shard 1
    $db = new PDO("mysql:host=shard1.example.com;dbname=users");
} else {
    // Connect to Shard 2
    $db = new PDO("mysql:host=shard2.example.com;dbname=users");
}
$stmt = $db->prepare("SELECT * FROM Users WHERE user_id = ?");
$stmt->execute([$user_id]);
*/

-- In MariaDB with Spider Storage Engine
/*
CREATE TABLE global_users (
    user_id INT,
    username VARCHAR(100),
    email VARCHAR(100)
) ENGINE=SPIDER
COMMENT='wrapper "mysql", table "users"'
PARTITION BY RANGE (user_id) (
    PARTITION p0 COMMENT = 'srv "shard1"' VALUES LESS THAN (1000000),
    PARTITION p1 COMMENT = 'srv "shard2"' VALUES LESS THAN MAXVALUE
);

-- Then query as normal
SELECT * FROM global_users WHERE user_id = 1500000;
*/
```

## 🧑‍🏫 Lesson 3: Advanced Database Design

### Complex Data Modeling

```sql
-- Nested Set Model for Hierarchy
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    name VARCHAR(100),
    lft INT NOT NULL,  -- left position
    rgt INT NOT NULL,  -- right position
    depth INT NOT NULL,
    INDEX (lft, rgt)
);

-- Find all subcategories of a category
SELECT child.*
FROM Categories AS node,
     Categories AS child
WHERE child.lft BETWEEN node.lft AND node.rgt
AND node.category_id = 5
ORDER BY child.lft;

-- Find hierarchy path to root
SELECT parent.*
FROM Categories AS node,
     Categories AS parent
WHERE node.lft BETWEEN parent.lft AND parent.rgt
AND node.category_id = 15
ORDER BY parent.lft;

-- Many-to-Many Relationship with intermediate table having additional attributes
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    title VARCHAR(200)
);

CREATE TABLE Enrollments (
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade DECIMAL(4,2),
    status ENUM('active', 'completed', 'withdrawn'),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
```

### Microservices Architecture with Database

```sql
-- Example table for User Management Service
CREATE TABLE User_Service.Users (
    user_id UUID PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    password_hash VARCHAR(255),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Example table for Product Management Service
CREATE TABLE Product_Service.Products (
    product_id UUID PRIMARY KEY,
    name VARCHAR(200),
    description TEXT,
    price DECIMAL(10,2),
    stock_quantity INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Example table for Order Management Service
CREATE TABLE Order_Service.Orders (
    order_id UUID PRIMARY KEY,
    user_id UUID, -- Store ID only, not a real foreign key
    status VARCHAR(50),
    total_amount DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Order_Service.OrderItems (
    order_item_id UUID PRIMARY KEY,
    order_id UUID,
    product_id UUID, -- Store ID only, not a real foreign key
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Order_Service.Orders(order_id)
);
```

### Polyglot Persistence

**Example Polyglot Model:**

1. **Transactional Data**: MySQL/PostgreSQL

   ```sql
   -- Store financial transaction data in PostgreSQL
   CREATE TABLE transactions (
       transaction_id UUID PRIMARY KEY,
       user_id UUID NOT NULL,
       amount DECIMAL(15,2) NOT NULL,
       transaction_type VARCHAR(50) NOT NULL,
       status VARCHAR(30) NOT NULL,
       created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
   );
   ```

2. **Real-time Data** (logs): Cassandra (CQL)

   ```sql
   -- Cassandra CQL
   CREATE TABLE activity_logs (
       user_id UUID,
       timestamp TIMESTAMP,
       activity_type TEXT,
       ip_address TEXT,
       device_info TEXT,
       PRIMARY KEY (user_id, timestamp)
   ) WITH CLUSTERING ORDER BY (timestamp DESC);
   ```

3. **Text/Search Data**: Elasticsearch

   ```json
   // Elasticsearch mapping
   {
     "mappings": {
       "properties": {
         "product_name": { "type": "text" },
         "description": { "type": "text" },
         "category": { "type": "keyword" },
         "price": { "type": "float" },
         "available": { "type": "boolean" },
         "created_at": { "type": "date" }
       }
     }
   }
   ```

4. **Cache Data**: Redis

   ```bash
   # Example Redis commands
   SET session:1234 "{user_id: 5678, permissions: ['read', 'write']}" EX 3600
   GET session:1234
   ```

5. **Variable/Document Data**: MongoDB

   ```javascript
   // MongoDB schema
   db.createCollection("products", {
     validator: {
       $jsonSchema: {
         bsonType: "object",
         required: ["name", "price", "attributes"],
         properties: {
           name: { bsonType: "string" },
           price: { bsonType: "decimal" },
           attributes: { bsonType: "object" },
         },
       },
     },
   });
   ```

### NoSQL vs SQL

**Comparison of queries between SQL and NoSQL:**

**SQL (MySQL):**

```sql
-- Find user and their orders
SELECT u.user_id, u.username, o.order_id, o.total
FROM Users u
LEFT JOIN Orders o ON u.user_id = o.user_id
WHERE u.user_id = 12345;
```

**MongoDB:**

```javascript
// Method 1: Separate storage
db.users.findOne({ user_id: 12345 });
db.orders.find({ user_id: 12345 });

// Method 2: Embedded document
db.users.findOne({ user_id: 12345 }, { username: 1, orders: 1 });

// Method 3: Using aggregation
db.users.aggregate([
  { $match: { user_id: 12345 } },
  {
    $lookup: {
      from: "orders",
      localField: "user_id",
      foreignField: "user_id",
      as: "user_orders",
    },
  },
]);
```

**Redis:**

```bash
# Cache user info
HMSET user:12345 username "john_doe" email "john@example.com" status "active"
HGETALL user:12345

# Use sorted sets for leaderboard
ZADD leaderboard 1000 "user:12345"
ZADD leaderboard 2500 "user:67890"
ZREVRANGE leaderboard 0 9 WITHSCORES  # Top 10 users
```

## 🧑‍🏫 Lesson 4: SQL and Real-World Data

### Handling Heterogeneous Data

```sql
-- Standardize email data
UPDATE Customers
SET email = LOWER(TRIM(email))
WHERE email IS NOT NULL;

-- Handle NULL values
SELECT
    COALESCE(phone_number, email, 'No contact') AS contact_method
FROM Customers;

-- Convert data types
SELECT
    customer_id,
    CAST(registration_date AS DATE) AS reg_date
FROM Customers;

-- Handle inconsistent dates
UPDATE Orders
SET order_date = STR_TO_DATE(order_date_string, '%d/%m/%Y')
WHERE order_date IS NULL AND order_date_string IS NOT NULL;

-- Find and fix out-of-range values
UPDATE Products
SET price = DEFAULT_PRICE
WHERE price <= 0 OR price > 10000;
```

### Data Cleaning and Transformation

```sql
-- Handle duplicate data
WITH DuplicateEmails AS (
    SELECT
        email,
        ROW_NUMBER() OVER (PARTITION BY email ORDER BY created_at) AS rn
    FROM Customers
)
DELETE FROM Customers
WHERE email IN (
    SELECT email FROM DuplicateEmails WHERE rn > 1
);

-- Detect outliers
SELECT *
FROM Orders
WHERE amount > (
    SELECT AVG(amount) + 3 * STDDEV(amount)
    FROM Orders
);

-- Normalize text
UPDATE Products
SET
    name = INITCAP(name),  -- Capitalize first letter of each word (PostgreSQL)
    description = REGEXP_REPLACE(description, '\s+', ' ')  -- Remove extra spaces
WHERE category = 'Electronics';

-- Generate sample data
INSERT INTO TestData (random_value)
SELECT FLOOR(RAND() * 100)
FROM information_schema.columns
LIMIT 1000;
```

### ETL and Data Warehouse

```sql
-- Example Extract in ETL
-- Extract data from source DB and save to staging
CREATE TABLE staging.daily_sales AS
SELECT
    DATE(order_date) AS sale_date,
    product_id,
    SUM(quantity) AS total_quantity,
    SUM(quantity * unit_price) AS total_revenue
FROM source_db.orders o
JOIN source_db.order_items oi ON o.order_id = oi.order_id
WHERE order_date >= CURRENT_DATE - INTERVAL 1 DAY
GROUP BY DATE(order_date), product_id;

-- Transform: Clean and transform staging data
UPDATE staging.daily_sales
SET total_revenue = 0
WHERE total_revenue < 0;  -- Fix invalid values

-- Load: Load data into Data Warehouse
INSERT INTO datawarehouse.fact_sales (date_key, product_key, quantity_sold, revenue)
SELECT
    d.date_key,
    p.product_key,
    s.total_quantity,
    s.total_revenue
FROM staging.daily_sales s
JOIN datawarehouse.dim_date d ON s.sale_date = d.full_date
JOIN datawarehouse.dim_product p ON s.product_id = p.source_product_id;

-- Example Data Warehouse Query
SELECT
    d.year,
    d.quarter,
    p.category,
    SUM(f.quantity_sold) AS total_quantity,
    SUM(f.revenue) AS total_revenue
FROM datawarehouse.fact_sales f
JOIN datawarehouse.dim_date d ON f.date_key = d.date_key
JOIN datawarehouse.dim_product p ON f.product_key = p.product_key
GROUP BY d.year, d.quarter, p.category
ORDER BY d.year, d.quarter, total_revenue DESC;
```

### Data Mining with SQL

```sql
-- RFM Analysis (Recency, Frequency, Monetary)
WITH customer_rfm AS (
    SELECT
        customer_id,
        DATEDIFF(CURRENT_DATE, MAX(order_date)) AS recency,
        COUNT(order_id) AS frequency,
        SUM(total_amount) AS monetary
    FROM Orders
    WHERE order_date >= DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR)
    GROUP BY customer_id
),
rfm_scores AS (
    SELECT
        customer_id,
        NTILE(5) OVER (ORDER BY recency DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,
        NTILE(5) OVER (ORDER BY monetary ASC) AS m_score
    FROM customer_rfm
)
SELECT
    customer_id,
    r_score, f_score, m_score,
    CONCAT(r_score, f_score, m_score) AS rfm_segment
FROM rfm_scores;

-- Market Basket Analysis
WITH product_pairs AS (
    SELECT
        o1.order_id,
        i1.product_id AS product1,
        i2.product_id AS product2
    FROM Orders o1
    JOIN OrderItems i1 ON o1.order_id = i1.order_id
    JOIN OrderItems i2 ON o1.order_id = i2.order_id
    WHERE i1.product_id < i2.product_id
)
SELECT
    p1.name AS product1_name,
    p2.name AS product2_name,
    COUNT(*) AS pair_count
FROM product_pairs pp
JOIN Products p1 ON pp.product1 = p1.product_id
JOIN Products p2 ON pp.product2 = p2.product_id
GROUP BY product1_name, product2_name
HAVING COUNT(*) > 10
ORDER BY pair_count DESC;

-- Anomaly Detection
SELECT
    transaction_id,
    customer_id,
    amount,
    transaction_date
FROM Transactions
WHERE amount > (
    SELECT AVG(amount) + 3 * STDDEV(amount)
    FROM Transactions
    WHERE customer_id = Transactions.customer_id
);

-- Data Clustering with SQL
-- Example: Simple K-means for 3 groups based on recency and frequency
WITH customer_metrics AS (
    SELECT
        customer_id,
        DATEDIFF(CURRENT_DATE, MAX(order_date)) AS recency,
        COUNT(order_id) AS frequency
    FROM Orders
    GROUP BY customer_id
),
min_max_values AS (
    SELECT
        MIN(recency) AS min_recency,
        MAX(recency) AS max_recency,
        MIN(frequency) AS min_frequency,
        MAX(frequency) AS max_frequency
    FROM customer_metrics
),
normalized_metrics AS (
    SELECT
        cm.*,
        (recency - min_recency) / (max_recency - min_recency) AS normalized_recency,
        (frequency - min_frequency) / (max_frequency - min_frequency) AS normalized_frequency
    FROM customer_metrics cm, min_max_values
)
SELECT
    customer_id,
    recency,
    frequency,
    CASE
        WHEN normalized_recency < 0.33 AND normalized_frequency > 0.67 THEN 'High Value'
        WHEN normalized_recency > 0.67 AND normalized_frequency < 0.33 THEN 'At Risk'
        ELSE 'Medium Value'
    END AS customer_segment
FROM normalized_metrics;
```

## 🧑‍🏫 Lesson 5: Administration and Monitoring

### Monitoring and Analysis Tools

```sql
-- View system status variables
SHOW STATUS WHERE Variable_name LIKE 'Com_%'
OR Variable_name LIKE 'Connections'
OR Variable_name LIKE 'Threads_%'
OR Variable_name LIKE 'Questions';

-- Monitor current connections
SHOW PROCESSLIST;

-- Find long-running queries (> 5 seconds)
SELECT * FROM information_schema.PROCESSLIST
WHERE COMMAND != 'Sleep' AND TIME > 5
ORDER BY TIME DESC;

-- Table information
SELECT
    table_name,
    table_rows,
    data_length / 1024 / 1024 AS data_size_mb,
    index_length / 1024 / 1024 AS index_size_mb,
    (data_length + index_length) / 1024 / 1024 AS total_size_mb
FROM information_schema.TABLES
WHERE table_schema = 'your_database'
ORDER BY (data_length + index_length) DESC;

-- Analyze index usage
SHOW INDEX FROM your_table;

-- Analyze INFORMATION_SCHEMA records
SELECT
    t.TABLE_NAME,
    t.TABLE_ROWS,
    ROUND((t.DATA_LENGTH + t.INDEX_LENGTH) / 1024 / 1024, 2) AS total_size_mb,
    ROUND(t.DATA_LENGTH / 1024 / 1024, 2) AS data_size_mb,
    ROUND(t.INDEX_LENGTH / 1024 / 1024, 2) AS index_size_mb
FROM information_schema.TABLES t
WHERE t.TABLE_SCHEMA = 'your_database'
ORDER BY total_size_mb DESC
LIMIT 10;
```

### Performance Troubleshooting

```sql
-- Identify slow queries from slow query log
-- Check if slow query log is enabled
SHOW VARIABLES LIKE 'slow_query%';
SHOW VARIABLES LIKE 'long_query_time';

-- Enable slow query log
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 1.0; -- Log queries running > 1 second

-- Clear cache to test real performance
FLUSH TABLES;
FLUSH QUERY CACHE;  -- For MySQL < 8.0

-- Find recent deadlocks
SHOW ENGINE INNODB STATUS;

-- System statistics
-- Number of connections and threads
SHOW STATUS LIKE 'Threads_connected';
SHOW STATUS LIKE 'Threads_running';

-- Cache hit ratio
SHOW STATUS LIKE 'Qcache_hits';
SHOW STATUS LIKE 'Qcache_inserts';
SHOW STATUS LIKE 'Innodb_buffer_pool_read_requests';
SHOW STATUS LIKE 'Innodb_buffer_pool_reads';

-- Check lock status
SELECT * FROM performance_schema.data_locks;
```

### Automating Database Administration

```sql
-- Create event scheduler for periodic tasks
-- Check if event scheduler is running
SHOW VARIABLES LIKE 'event_scheduler';
SET GLOBAL event_scheduler = ON;

-- Example: automatically delete old data daily
DELIMITER //
CREATE EVENT clean_old_logs
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_DATE + INTERVAL 1 DAY
DO
BEGIN
    DELETE FROM system_logs WHERE log_date < DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY);
    DELETE FROM user_activity WHERE activity_date < DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY);
END //
DELIMITER ;

-- Create stored procedure to optimize tables
DELIMITER //
CREATE PROCEDURE optimize_tables()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE tbl_name VARCHAR(255);

    -- Create cursor to loop through tables
    DECLARE cur CURSOR FOR
        SELECT table_name FROM information_schema.TABLES
        WHERE table_schema = DATABASE() AND table_type = 'BASE TABLE';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO tbl_name;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET @sql = CONCAT('OPTIMIZE TABLE ', tbl_name);
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END LOOP;

    CLOSE cur;
END //
DELIMITER ;

-- Automatic backup (executed by external script or crontab)
/*
#!/bin/bash
DATE=$(date +"%Y%m%d")
BACKUP_DIR="/backup/mysql"

# Full backup
mysqldump -u root -p --all-databases --triggers --routines --events > "$BACKUP_DIR/full_backup_$DATE.sql"

# Compress
gzip "$BACKUP_DIR/full_backup_$DATE.sql"

# Delete backups older than 30 days
find $BACKUP_DIR -name "full_backup_*.sql.gz" -mtime +30 -delete
*/
```

### Scaling and Upgrade Strategy

```sql
-- Check current MySQL version
SELECT VERSION();

-- Scale-up Strategy: upgrade server configuration
-- Check critical limits
SHOW VARIABLES LIKE 'max_connections';
SHOW VARIABLES LIKE 'innodb_buffer_pool_size';
SHOW VARIABLES LIKE 'tmp_table_size';
SHOW VARIABLES LIKE 'max_heap_table_size';

-- Scale-out Strategy: setup read replicas
-- Configure Primary server
-- [mysqld] section in my.cnf
/*
server-id = 1
log_bin = mysql-bin
binlog_format = ROW
*/

-- Configure Replica server
-- [mysqld] section in my.cnf
/*
server-id = 2
relay-log = relay-bin
read_only = ON
*/

-- Setup replication parameters
-- On Primary:
/*
CREATE USER 'replication_user'@'replica_ip' IDENTIFIED BY 'password';
GRANT REPLICATION SLAVE ON *.* TO 'replication_user'@'replica_ip';
*/

-- On Replica:
/*
CHANGE MASTER TO
  MASTER_HOST='primary_ip',
  MASTER_USER='replication_user',
  MASTER_PASSWORD='password',
  MASTER_LOG_FILE='mysql-bin.000001',
  MASTER_LOG_POS=0;

START SLAVE;
SHOW SLAVE STATUS\G
*/

-- Partitioning to improve performance
ALTER TABLE large_table
PARTITION BY RANGE (YEAR(created_date)) (
    PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p9999 VALUES LESS THAN MAXVALUE
);

-- Vertical partitioning (split table into smaller tables by columns)
-- Example: split products table into product_core and product_details
CREATE TABLE product_core (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    category_id INT
);

CREATE TABLE product_details (
    product_id INT PRIMARY KEY,
    description TEXT,
    specifications TEXT,
    images TEXT,
    FOREIGN KEY (product_id) REFERENCES product_core(product_id)
);
```

## 🧪 FINAL PROJECT: Course Registration Management System

### Problem

Build a course registration management database:

- `students`: student information
- `courses`: course information
- `enrollments`: course registration
- `course_schedules`: class schedule

### Requirements

- Design full database with constraints.
- Create stored procedures to:
  - Register course (check quantity, eligibility).
  - Cancel registration.
  - Change class.
- Implement transaction handling to ensure data integrity when multiple students register for the same class (limit quantity).
- Create views and functions to:
  - Display schedule for students.
  - Check schedule conflicts when registering.
