-- Chuẩn hóa bảng sales thành các dạng 1NF, 2NF và 3NF

-- Tạo database và bảng chưa chuẩn hóa
CREATE DATABASE IF NOT EXISTS normalization_example;
USE normalization_example;

CREATE TABLE sales (
    order_id INT,
    customer_name VARCHAR(100),
    product_name VARCHAR(100),
    quantity INT,
    price DECIMAL(10,2),
    order_date DATE
);

-- Chèn dữ liệu mẫu
INSERT INTO sales VALUES
(1, 'Nguyễn Văn A', 'Laptop Dell XPS', 2, 25000000, '2023-01-15'),
(1, 'Nguyễn Văn A', 'Chuột Logitech', 1, 500000, '2023-01-15'),
(2, 'Trần Thị B', 'Laptop Dell XPS', 1, 25000000, '2023-02-10'),
(3, 'Lê Văn C', 'Bàn phím Corsair', 2, 1500000, '2023-02-25'),
(3, 'Lê Văn C', 'Tai nghe Sony', 1, 2000000, '2023-02-25'),
(4, 'Nguyễn Văn A', 'Màn hình LG', 1, 3500000, '2023-03-05');

-- Chuẩn hóa thành 1NF, 2NF và 3NF

-- 1. Đảm bảo 1NF (đã đạt vì mỗi ô chỉ chứa một giá trị nguyên tử)

-- 2. Chuyển sang 2NF
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Chèn dữ liệu vào bảng chuẩn hóa
INSERT INTO customers (customer_name) VALUES 
('Nguyễn Văn A'), ('Trần Thị B'), ('Lê Văn C');

INSERT INTO products (product_name, price) VALUES 
('Laptop Dell XPS', 25000000), 
('Chuột Logitech', 500000), 
('Bàn phím Corsair', 1500000), 
('Tai nghe Sony', 2000000), 
('Màn hình LG', 3500000);

INSERT INTO orders (order_id, customer_id, order_date) VALUES 
(1, 1, '2023-01-15'),
(2, 2, '2023-02-10'),
(3, 3, '2023-02-25'),
(4, 1, '2023-03-05');

INSERT INTO order_items (order_id, product_id, quantity) VALUES 
(1, 1, 2),  -- Nguyễn Văn A mua 2 Laptop Dell XPS
(1, 2, 1),  -- Nguyễn Văn A mua 1 Chuột Logitech
(2, 1, 1),  -- Trần Thị B mua 1 Laptop Dell XPS
(3, 3, 2),  -- Lê Văn C mua 2 Bàn phím Corsair
(3, 4, 1),  -- Lê Văn C mua 1 Tai nghe Sony
(4, 5, 1);  -- Nguyễn Văn A mua 1 Màn hình LG

-- Tạo các chỉ mục cần thiết
CREATE INDEX idx_order_customer ON orders(customer_id);
CREATE INDEX idx_product_name ON products(product_name);

-- Truy vấn tương đương với dữ liệu ban đầu nhưng từ cấu trúc đã chuẩn hóa
SELECT 
    o.order_id,
    c.customer_name,
    p.product_name,
    oi.quantity,
    p.price,
    o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
ORDER BY o.order_id, p.product_name;
