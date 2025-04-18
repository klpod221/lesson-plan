# 📘 PHẦN 4: SQL CHUYÊN SÂU VÀ HIỆU SUẤT

## Table of Contents

- [📘 PHẦN 4: SQL CHUYÊN SÂU VÀ HIỆU SUẤT](#-phần-4-sql-chuyên-sâu-và-hiệu-suất)
  - [Table of Contents](#table-of-contents)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Tối ưu hiệu suất](#-bài-1-tối-ưu-hiệu-suất)
    - [Kế hoạch thực thi truy vấn và cách phân tích](#kế-hoạch-thực-thi-truy-vấn-và-cách-phân-tích)
    - [Chỉ mục nâng cao (Composite, Covering, Filtered)](#chỉ-mục-nâng-cao-composite-covering-filtered)
    - [Chiến lược phân vùng dữ liệu](#chiến-lược-phân-vùng-dữ-liệu)
    - [Điều chỉnh cấu hình máy chủ cơ sở dữ liệu](#điều-chỉnh-cấu-hình-máy-chủ-cơ-sở-dữ-liệu)
  - [🧑‍🏫 Bài 2: Xử lý dữ liệu lớn](#-bài-2-xử-lý-dữ-liệu-lớn)
    - [Kỹ thuật thao tác với bảng có hàng triệu dòng](#kỹ-thuật-thao-tác-với-bảng-có-hàng-triệu-dòng)
    - [Phân tích dữ liệu với các hàm window nâng cao](#phân-tích-dữ-liệu-với-các-hàm-window-nâng-cao)
    - [Chiến lược sao lưu và phục hồi dữ liệu lớn](#chiến-lược-sao-lưu-và-phục-hồi-dữ-liệu-lớn)
    - [Truy vấn dữ liệu phân tán](#truy-vấn-dữ-liệu-phân-tán)
  - [🧑‍🏫 Bài 3: Thiết kế cơ sở dữ liệu nâng cao](#-bài-3-thiết-kế-cơ-sở-dữ-liệu-nâng-cao)
    - [Mô hình hóa dữ liệu phức tạp](#mô-hình-hóa-dữ-liệu-phức-tạp)
    - [Thiết kế kiến trúc microservices với cơ sở dữ liệu](#thiết-kế-kiến-trúc-microservices-với-cơ-sở-dữ-liệu)
    - [Cơ sở dữ liệu đa hình thái (Polyglot Persistence)](#cơ-sở-dữ-liệu-đa-hình-thái-polyglot-persistence)
    - [Cơ sở dữ liệu NoSQL và SQL](#cơ-sở-dữ-liệu-nosql-và-sql)
  - [🧑‍🏫 Bài 4: SQL và dữ liệu thực tế](#-bài-4-sql-và-dữ-liệu-thực-tế)
    - [Xử lý dữ liệu không đồng nhất](#xử-lý-dữ-liệu-không-đồng-nhất)
    - [Cleaning và chuyển đổi dữ liệu](#cleaning-và-chuyển-đổi-dữ-liệu)
    - [ETL và data warehouse](#etl-và-data-warehouse)
    - [Data mining với SQL](#data-mining-với-sql)
  - [🧑‍🏫 Bài 5: Quản trị và giám sát](#-bài-5-quản-trị-và-giám-sát)
    - [Công cụ giám sát và phân tích](#công-cụ-giám-sát-và-phân-tích)
    - [Xử lý sự cố hiệu suất](#xử-lý-sự-cố-hiệu-suất)
    - [Tự động hóa quản trị cơ sở dữ liệu](#tự-động-hóa-quản-trị-cơ-sở-dữ-liệu)
    - [Chiến lược mở rộng và nâng cấp](#chiến-lược-mở-rộng-và-nâng-cấp)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN](#-bài-tập-lớn-cuối-phần)
    - [**Đề bài: Hệ thống quản lý đăng ký môn học**](#đề-bài-hệ-thống-quản-lý-đăng-ký-môn-học)

## 🎯 Mục tiêu tổng quát

- Tối ưu hóa hiệu suất truy vấn và cấu trúc dữ liệu
- Xử lý dữ liệu lớn một cách hiệu quả
- Triển khai giải pháp dữ liệu phức tạp

---

## 🧑‍🏫 Bài 1: Tối ưu hiệu suất

### Kế hoạch thực thi truy vấn và cách phân tích

```sql
-- Sử dụng EXPLAIN để phân tích kế hoạch thực thi truy vấn
EXPLAIN SELECT s.student_id, s.first_name, s.last_name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.department = 'Computer Science';

-- Phân tích chi tiết với EXPLAIN FORMAT=JSON
EXPLAIN FORMAT=JSON
SELECT * FROM Students WHERE last_name LIKE 'Nguy%';

-- Phân tích chi tiết hơn với ANALYZE (PostgreSQL/MySQL 8.0+)
EXPLAIN ANALYZE
SELECT s.student_id, AVG(e.grade) as avg_grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id
HAVING AVG(e.grade) > 8.0;
```

### Chỉ mục nâng cao (Composite, Covering, Filtered)

```sql
-- Chỉ mục Composite (đa cột)
CREATE INDEX idx_student_name ON Students(last_name, first_name);

-- Chỉ mục Covering (bao gồm tất cả cột trong truy vấn)
CREATE INDEX idx_enrollment_covering ON Enrollments(student_id, course_id, grade, enrollment_date);

-- Truy vấn sử dụng covering index (không cần truy cập bảng)
SELECT student_id, course_id, grade FROM Enrollments WHERE student_id = 1001;

-- Chỉ mục Filtered (SQL Server)
-- CREATE INDEX idx_active_students ON Students(student_id) WHERE is_active = 1;

-- Chỉ mục Full-Text (cho tìm kiếm văn bản)
CREATE FULLTEXT INDEX ON Articles(content);

-- Tìm kiếm với Full-Text
SELECT * FROM Articles
WHERE MATCH(content) AGAINST('machine learning AI' IN NATURAL LANGUAGE MODE);
```

### Chiến lược phân vùng dữ liệu

```sql
-- Phân vùng theo phạm vi (MySQL)
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

-- Phân vùng theo danh sách
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

-- Phân vùng theo hàm băm (Hash)
CREATE TABLE UserActivity (
    user_id INT NOT NULL,
    activity_date DATE,
    activity_type VARCHAR(50),
    PRIMARY KEY (user_id, activity_date)
)
PARTITION BY HASH (user_id) PARTITIONS 8;
```

### Điều chỉnh cấu hình máy chủ cơ sở dữ liệu

```sql
-- Xem các biến cấu hình hiện tại
SHOW VARIABLES LIKE 'innodb_buffer_pool_size';
SHOW VARIABLES LIKE 'max_connections';
SHOW VARIABLES LIKE 'query_cache%';

-- Thiết lập cấu hình tạm thời
SET GLOBAL innodb_buffer_pool_size = 4294967296; -- 4GB

-- Theo dõi performance
SHOW STATUS LIKE 'Threads_connected';
SHOW STATUS LIKE 'Slow_queries';

-- Thiết lập slow query log
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 2.0; -- Log các truy vấn chạy > 2 giây
```

**Ví dụ cài đặt trong file cấu hình my.cnf (MySQL)**:

```ini
[mysqld]
# Bộ nhớ cache cho InnoDB (50-70% RAM)
innodb_buffer_pool_size=4G

# Kích thước file log
innodb_log_file_size=512M

# Thời gian tối đa để kiểm soát các giao dịch treo
innodb_lock_wait_timeout=50

# Bộ nhớ cache cho truy vấn
query_cache_type=1
query_cache_size=128M

# Slow query log
slow_query_log=1
slow_query_log_file=/var/log/mysql/mysql-slow.log
long_query_time=2
```

---

## 🧑‍🏫 Bài 2: Xử lý dữ liệu lớn

### Kỹ thuật thao tác với bảng có hàng triệu dòng

```sql
-- Phân trang dữ liệu (thay vì lấy tất cả)
SELECT * FROM LargeTable
ORDER BY id
LIMIT 1000 OFFSET 10000;

-- Sử dụng truy vấn theo batch với clôt ID
-- Batch 1:
SELECT * FROM LargeTable WHERE id BETWEEN 1 AND 10000;
-- Batch 2:
SELECT * FROM LargeTable WHERE id BETWEEN 10001 AND 20000;

-- UPDATE theo batch để tránh khóa bảng lâu
UPDATE LargeTable SET status = 'archived'
WHERE create_date < '2022-01-01'
LIMIT 10000;

-- Sử dụng biến số để theo dõi tiến trình xử lý
SET @batch_size = 5000;
SET @total_processed = 0;

prepare_batch:
    UPDATE LargeTable SET processed = 1
    WHERE processed = 0
    LIMIT @batch_size;

    SET @total_processed = @total_processed + ROW_COUNT();

    -- Tiếp tục cho đến khi không còn bản ghi nào được xử lý
    IF ROW_COUNT() > 0 THEN
        -- Logic xử lý ở đây
        SELECT CONCAT('Đã xử lý ', @total_processed, ' bản ghi') AS progress;
        -- Chờ một chút để giảm tải DB
        DO SLEEP(1);
        GOTO prepare_batch;
    END IF;
```

### Phân tích dữ liệu với các hàm window nâng cao

```sql
-- Tính thứ hạng điểm số cho từng sinh viên trong mỗi khóa học
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

-- Tính trung bình động (rolling average)
SELECT
    sale_date,
    amount,
    AVG(amount) OVER (
        ORDER BY sale_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS weekly_moving_avg
FROM Sales
ORDER BY sale_date;

-- Tính tổng tích lũy (cumulative sum)
SELECT
    sale_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY EXTRACT(YEAR FROM sale_date)
        ORDER BY sale_date
    ) AS yearly_cumulative_total
FROM Sales
ORDER BY sale_date;

-- So sánh với giá trị trước đó và tiếp theo
SELECT
    sale_date,
    amount,
    LAG(amount, 1) OVER (ORDER BY sale_date) AS previous_day_amount,
    LEAD(amount, 1) OVER (ORDER BY sale_date) AS next_day_amount,
    amount - LAG(amount, 1) OVER (ORDER BY sale_date) AS day_over_day_change
FROM Sales
ORDER BY sale_date;
```

### Chiến lược sao lưu và phục hồi dữ liệu lớn

```bash
# Sao lưu toàn bộ cơ sở dữ liệu
mysqldump -u root -p --single-transaction --routines --triggers --events SchoolDB > schooldb_full_backup.sql

# Sao lưu chỉ cấu trúc
mysqldump -u root -p --no-data SchoolDB > schooldb_schema.sql

# Sao lưu dữ liệu của từng bảng riêng biệt
mysqldump -u root -p SchoolDB Students > students_backup.sql
mysqldump -u root -p SchoolDB Enrollments > enrollments_backup.sql

# Sao lưu theo lịch (sử dụng crontab)
# 0 2 * * * mysqldump -u root -p'password' --single-transaction SchoolDB > /backup/schooldb_$(date +\%Y\%m\%d).sql

# Phục hồi từ bản sao lưu
mysql -u root -p SchoolDB < schooldb_full_backup.sql

# Sao lưu bằng công cụ Percona XtraBackup (cho MySQL/MariaDB)
# xtrabackup --backup --target-dir=/backup/mysql/full

# Sao lưu tăng dần (incremental)
# xtrabackup --backup --target-dir=/backup/mysql/inc1 --incremental-basedir=/backup/mysql/full
```

### Truy vấn dữ liệu phân tán

```sql
-- Ví dụ với MySQL Cluster: truy vấn dữ liệu phân tán như bình thường
SELECT * FROM distributed_table WHERE partition_key = 123;

-- Sử dụng Sharding trên ứng dụng (ví dụ truy vấn trên cơ sở dữ liệu cụ thể)
-- Trong ứng dụng:
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

-- Trong MariaDB với Spider Storage Engine
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

-- Sau đó truy vấn như bình thường
SELECT * FROM global_users WHERE user_id = 1500000;
*/
```

---

## 🧑‍🏫 Bài 3: Thiết kế cơ sở dữ liệu nâng cao

### Mô hình hóa dữ liệu phức tạp

```sql
-- Mô hình hóa cây phân cấp (Nested Set Model)
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    name VARCHAR(100),
    lft INT NOT NULL,  -- left position
    rgt INT NOT NULL,  -- right position
    depth INT NOT NULL,
    INDEX (lft, rgt)
);

-- Tìm tất cả danh mục con của một danh mục
SELECT child.*
FROM Categories AS node,
     Categories AS child
WHERE child.lft BETWEEN node.lft AND node.rgt
AND node.category_id = 5
ORDER BY child.lft;

-- Tìm cây phân cấp đến gốc
SELECT parent.*
FROM Categories AS node,
     Categories AS parent
WHERE node.lft BETWEEN parent.lft AND parent.rgt
AND node.category_id = 15
ORDER BY parent.lft;

-- Mô hình hóa quan hệ nhiều-nhiều với bảng trung gian có thuộc tính bổ sung
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

### Thiết kế kiến trúc microservices với cơ sở dữ liệu

```sql
-- Ví dụ bảng cho service Quản lý Người dùng
CREATE TABLE User_Service.Users (
    user_id UUID PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    password_hash VARCHAR(255),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Ví dụ bảng cho service Quản lý Sản phẩm
CREATE TABLE Product_Service.Products (
    product_id UUID PRIMARY KEY,
    name VARCHAR(200),
    description TEXT,
    price DECIMAL(10,2),
    stock_quantity INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Ví dụ bảng cho service Quản lý Đơn hàng
CREATE TABLE Order_Service.Orders (
    order_id UUID PRIMARY KEY,
    user_id UUID, -- Chỉ lưu ID, không phải foreign key thực thụ
    status VARCHAR(50),
    total_amount DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Order_Service.OrderItems (
    order_item_id UUID PRIMARY KEY,
    order_id UUID,
    product_id UUID, -- Chỉ lưu ID, không phải foreign key thực thụ
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Order_Service.Orders(order_id)
);
```

### Cơ sở dữ liệu đa hình thái (Polyglot Persistence)

**Ví dụ mô hình đa hình thái:**

1. **Dữ liệu giao dịch**: MySQL/PostgreSQL

```sql
-- Lưu trữ dữ liệu giao dịch tài chính trong PostgreSQL
CREATE TABLE transactions (
    transaction_id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    transaction_type VARCHAR(50) NOT NULL,
    status VARCHAR(30) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

2. **Dữ liệu thời gian thực** (nhật ký/log): Cassandra (CQL)

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

3. **Dữ liệu văn bản, tìm kiếm**: Elasticsearch

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

4. **Dữ liệu cache**: Redis

```bash
# Ví dụ lệnh Redis
SET session:1234 "{user_id: 5678, permissions: ['read', 'write']}" EX 3600
GET session:1234
```

5. **Dữ liệu biến đổi/document**: MongoDB

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

### Cơ sở dữ liệu NoSQL và SQL

**So sánh truy vấn giữa SQL và NoSQL:**

**SQL (MySQL):**

```sql
-- Tìm người dùng và đơn hàng của họ
SELECT u.user_id, u.username, o.order_id, o.total
FROM Users u
LEFT JOIN Orders o ON u.user_id = o.user_id
WHERE u.user_id = 12345;
```

**MongoDB:**

```javascript
// Phương pháp 1: Lưu trữ tách biệt
db.users.findOne({ user_id: 12345 });
db.orders.find({ user_id: 12345 });

// Phương pháp 2: Embedded document
db.users.findOne({ user_id: 12345 }, { username: 1, orders: 1 });

// Phương pháp 3: Sử dụng aggregation
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
# Lưu cache cho thông tin người dùng
HMSET user:12345 username "john_doe" email "john@example.com" status "active"
HGETALL user:12345

# Sử dụng sorted sets cho bảng xếp hạng
ZADD leaderboard 1000 "user:12345"
ZADD leaderboard 2500 "user:67890"
ZREVRANGE leaderboard 0 9 WITHSCORES  # Top 10 users
```

---

## 🧑‍🏫 Bài 4: SQL và dữ liệu thực tế

### Xử lý dữ liệu không đồng nhất

```sql
-- Chuẩn hóa dữ liệu email
UPDATE Customers
SET email = LOWER(TRIM(email))
WHERE email IS NOT NULL;

-- Xử lý giá trị NULL
SELECT
    COALESCE(phone_number, email, 'No contact') AS contact_method
FROM Customers;

-- Chuyển đổi kiểu dữ liệu
SELECT
    customer_id,
    CAST(registration_date AS DATE) AS reg_date
FROM Customers;

-- Xử lý ngày tháng không đồng nhất
UPDATE Orders
SET order_date = STR_TO_DATE(order_date_string, '%d/%m/%Y')
WHERE order_date IS NULL AND order_date_string IS NOT NULL;

-- Tìm và sửa các giá trị ngoài phạm vi hợp lệ
UPDATE Products
SET price = DEFAULT_PRICE
WHERE price <= 0 OR price > 10000;
```

### Cleaning và chuyển đổi dữ liệu

```sql
-- Xử lý dữ liệu trùng lặp
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

-- Phát hiện outliers (giá trị ngoại lai)
SELECT *
FROM Orders
WHERE amount > (
    SELECT AVG(amount) + 3 * STDDEV(amount)
    FROM Orders
);

-- Chuẩn hóa văn bản
UPDATE Products
SET
    name = INITCAP(name),  -- Viết hoa chữ cái đầu mỗi từ (PostgreSQL)
    description = REGEXP_REPLACE(description, '\s+', ' ')  -- Loại bỏ khoảng trắng thừa
WHERE category = 'Electronics';

-- Tạo dữ liệu mẫu
INSERT INTO TestData (random_value)
SELECT FLOOR(RAND() * 100)
FROM information_schema.columns
LIMIT 1000;
```

### ETL và data warehouse

```sql
-- Ví dụ về Extract trong ETL
-- Trích xuất dữ liệu từ DB nguồn và lưu vào staging
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

-- Transform: Làm sạch và chuyển đổi dữ liệu staging
UPDATE staging.daily_sales
SET total_revenue = 0
WHERE total_revenue < 0;  -- Sửa các giá trị không hợp lệ

-- Load: Tải dữ liệu vào Data Warehouse
INSERT INTO datawarehouse.fact_sales (date_key, product_key, quantity_sold, revenue)
SELECT
    d.date_key,
    p.product_key,
    s.total_quantity,
    s.total_revenue
FROM staging.daily_sales s
JOIN datawarehouse.dim_date d ON s.sale_date = d.full_date
JOIN datawarehouse.dim_product p ON s.product_id = p.source_product_id;

-- Ví dụ truy vấn Data Warehouse
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

### Data mining với SQL

```sql
-- Phân tích RFM (Recency, Frequency, Monetary)
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

-- Phân tích Basket (Market Basket Analysis)
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

-- Phát hiện bất thường (Anomaly Detection)
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

-- Phân cụm dữ liệu (Clustering) bằng SQL
-- Ví dụ: K-means đơn giản cho 3 nhóm dựa trên recency và frequency
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

---

## 🧑‍🏫 Bài 5: Quản trị và giám sát

### Công cụ giám sát và phân tích

```sql
-- Xem các biến trạng thái hệ thống
SHOW STATUS WHERE Variable_name LIKE 'Com_%'
OR Variable_name LIKE 'Connections'
OR Variable_name LIKE 'Threads_%'
OR Variable_name LIKE 'Questions';

-- Theo dõi các kết nối hiện tại
SHOW PROCESSLIST;

-- Tìm các truy vấn đang chạy lâu (> 5 giây)
SELECT * FROM information_schema.PROCESSLIST
WHERE COMMAND != 'Sleep' AND TIME > 5
ORDER BY TIME DESC;

-- Thông tin về các bảng
SELECT
    table_name,
    table_rows,
    data_length / 1024 / 1024 AS data_size_mb,
    index_length / 1024 / 1024 AS index_size_mb,
    (data_length + index_length) / 1024 / 1024 AS total_size_mb
FROM information_schema.TABLES
WHERE table_schema = 'your_database'
ORDER BY (data_length + index_length) DESC;

-- Phân tích sử dụng chỉ mục
SHOW INDEX FROM your_table;

-- Phân tích bản ghi INFORMATION_SCHEMA
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

### Xử lý sự cố hiệu suất

```sql
-- Xác định truy vấn chậm từ slow query log
-- Kiểm tra xem slow query log có được kích hoạt không
SHOW VARIABLES LIKE 'slow_query%';
SHOW VARIABLES LIKE 'long_query_time';

-- Bật slow query log
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 1.0; -- Log truy vấn chạy > 1 giây

-- Xóa cache để kiểm tra hiệu suất thực sự
FLUSH TABLES;
FLUSH QUERY CACHE;  -- Cho MySQL < 8.0

-- Tìm deadlock gần đây
SHOW ENGINE INNODB STATUS;

-- Thống kê hệ thống
-- Số lượng kết nối và thread
SHOW STATUS LIKE 'Threads_connected';
SHOW STATUS LIKE 'Threads_running';

-- Tỉ lệ cache hit
SHOW STATUS LIKE 'Qcache_hits';
SHOW STATUS LIKE 'Qcache_inserts';
SHOW STATUS LIKE 'Innodb_buffer_pool_read_requests';
SHOW STATUS LIKE 'Innodb_buffer_pool_reads';

-- Kiểm tra tình trạng khóa
SELECT * FROM performance_schema.data_locks;
```

### Tự động hóa quản trị cơ sở dữ liệu

```sql
-- Tạo event scheduler để thực hiện tác vụ định kỳ
-- Kiểm tra event scheduler có đang chạy không
SHOW VARIABLES LIKE 'event_scheduler';
SET GLOBAL event_scheduler = ON;

-- Ví dụ: tự động xóa dữ liệu cũ hàng ngày
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

-- Tạo stored procedure để tối ưu bảng
DELIMITER //
CREATE PROCEDURE optimize_tables()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE tbl_name VARCHAR(255);

    -- Tạo cursor để lặp qua các bảng
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

-- Tự động sao lưu (thực hiện bằng script bên ngoài hoặc crontab)
/*
#!/bin/bash
DATE=$(date +"%Y%m%d")
BACKUP_DIR="/backup/mysql"

# Sao lưu toàn bộ
mysqldump -u root -p --all-databases --triggers --routines --events > "$BACKUP_DIR/full_backup_$DATE.sql"

# Nén
gzip "$BACKUP_DIR/full_backup_$DATE.sql"

# Xóa bản sao lưu cũ hơn 30 ngày
find $BACKUP_DIR -name "full_backup_*.sql.gz" -mtime +30 -delete
*/
```

### Chiến lược mở rộng và nâng cấp

```sql
-- Kiểm tra phiên bản MySQL hiện tại
SELECT VERSION();

-- Chiến lược Scale-up: nâng cấp cấu hình server
-- Kiểm tra các giới hạn quan trọng
SHOW VARIABLES LIKE 'max_connections';
SHOW VARIABLES LIKE 'innodb_buffer_pool_size';
SHOW VARIABLES LIKE 'tmp_table_size';
SHOW VARIABLES LIKE 'max_heap_table_size';

-- Chiến lược Scale-out: thiết lập read replicas
-- Cấu hình Primary server
-- [mysqld] section trong my.cnf
/*
server-id = 1
log_bin = mysql-bin
binlog_format = ROW
*/

-- Cấu hình Replica server
-- [mysqld] section trong my.cnf
/*
server-id = 2
relay-log = relay-bin
read_only = ON
*/

-- Thiết lập tham số replikasi
-- Trên Primary:
/*
CREATE USER 'replication_user'@'replica_ip' IDENTIFIED BY 'password';
GRANT REPLICATION SLAVE ON *.* TO 'replication_user'@'replica_ip';
*/

-- Trên Replica:
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

-- Partitioning để cải thiện hiệu suất
ALTER TABLE large_table
PARTITION BY RANGE (YEAR(created_date)) (
    PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p9999 VALUES LESS THAN MAXVALUE
);

-- Vertical partitioning (chia bảng thành các bảng nhỏ hơn theo các cột)
-- Ví dụ: tách bảng products thành product_core và product_details
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

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Hệ thống quản lý đăng ký môn học**

Xây dựng cơ sở dữ liệu quản lý đăng ký môn học:

- `Students`: thông tin sinh viên
- `Courses`: thông tin khóa học
- `Enrollments`: đăng ký khóa học
- `CourseSchedules`: lịch học

Yêu cầu:

- Thiết kế cơ sở dữ liệu đầy đủ với các ràng buộc
- Tạo các stored procedure để:
  - Đăng ký khóa học (kiểm tra số lượng, đủ điều kiện)
  - Hủy đăng ký
  - Thay đổi lớp
- Triển khai xử lý transaction để đảm bảo tính toàn vẹn dữ liệu khi nhiều sinh viên cùng đăng ký một lớp (giới hạn số lượng)
- Tạo view và function để:
  - Hiển thị thời khóa biểu cho sinh viên
  - Kiểm tra xung đột lịch học khi đăng ký
