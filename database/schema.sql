CREATE DATABASE ai_sales_analytics;

USE ai_sales_analytics;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(100),
    state VARCHAR(100),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO customers
(customer_id, customer_name, city, state, signup_date)
VALUES
(1, 'Rahul Kumar', 'Bengaluru', 'Karnataka', '2024-01-15'),
(2, 'Priya Sharma', 'Mumbai', 'Maharashtra', '2024-03-20'),
(3, 'Aman Khan', 'Hyderabad', 'Telangana', '2024-05-10'),
(4, 'Sneha Reddy', 'Chennai', 'Tamil Nadu', '2024-07-12'),
(5, 'Arjun Mehta', 'Delhi', 'Delhi', '2024-09-05'),
(6, 'Neha Singh', 'Pune', 'Maharashtra', '2025-01-18'),
(7, 'Vikram Rao', 'Bengaluru', 'Karnataka', '2025-02-10'),
(8, 'Anjali Patel', 'Ahmedabad', 'Gujarat', '2025-03-25'),
(9, 'Karan Verma', 'Noida', 'Uttar Pradesh', '2025-04-15'),
(10, 'Pooja Nair', 'Kochi', 'Kerala', '2025-05-30');

INSERT INTO products
(product_id, product_name, category, price)
VALUES
(101, 'Wireless Headphones', 'Electronics', 2499.00),
(102, 'Mechanical Keyboard', 'Electronics', 4999.00),
(103, 'USB-C Hub', 'Accessories', 1799.00),
(104, 'Laptop Stand', 'Accessories', 2299.00),
(105, 'Smart Watch', 'Wearables', 6999.00),
(106, 'Bluetooth Speaker', 'Electronics', 3499.00),
(107, 'Webcam', 'Electronics', 2999.00),
(108, 'Wireless Mouse', 'Accessories', 1299.00);

INSERT INTO orders
(order_id, customer_id, order_date, status)
VALUES
(1001, 1, '2025-01-05', 'Delivered'),
(1002, 2, '2025-01-12', 'Delivered'),
(1003, 3, '2025-01-20', 'Delivered'),
(1004, 1, '2025-02-03', 'Delivered'),
(1005, 4, '2025-02-15', 'Delivered'),
(1006, 5, '2025-02-25', 'Cancelled'),
(1007, 6, '2025-03-04', 'Delivered'),
(1008, 7, '2025-03-18', 'Delivered'),
(1009, 8, '2025-04-02', 'Delivered'),
(1010, 9, '2025-04-16', 'Delivered'),
(1011, 10, '2025-05-05', 'Delivered'),
(1012, 1, '2025-05-20', 'Delivered'),
(1013, 2, '2025-06-10', 'Delivered'),
(1014, 3, '2025-07-08', 'Delivered'),
(1015, 4, '2025-08-12', 'Delivered'),
(1016, 5, '2025-09-01', 'Delivered'),
(1017, 6, '2025-10-15', 'Delivered'),
(1018, 7, '2025-11-05', 'Delivered'),
(1019, 8, '2025-12-10', 'Delivered'),
(1020, 9, '2025-12-20', 'Delivered');

INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, unit_price)
VALUES
(1, 1001, 101, 2, 2499),
(2, 1001, 103, 1, 1799),

(3, 1002, 102, 1, 4999),
(4, 1002, 108, 2, 1299),

(5, 1003, 105, 1, 6999),
(6, 1003, 101, 1, 2499),

(7, 1004, 106, 2, 3499),
(8, 1004, 104, 1, 2299),

(9, 1005, 107, 1, 2999),
(10, 1005, 108, 2, 1299),

(11, 1006, 102, 1, 4999),

(12, 1007, 105, 2, 6999),
(13, 1007, 103, 1, 1799),

(14, 1008, 101, 3, 2499),

(15, 1009, 102, 2, 4999),
(16, 1009, 108, 1, 1299),

(17, 1010, 106, 2, 3499),
(18, 1010, 103, 2, 1799),

(19, 1011, 105, 1, 6999),
(20, 1011, 107, 1, 2999),

(21, 1012, 101, 2, 2499),
(22, 1012, 104, 2, 2299),

(23, 1013, 102, 1, 4999),
(24, 1013, 106, 1, 3499),

(25, 1014, 105, 2, 6999),
(26, 1014, 108, 3, 1299),

(27, 1015, 107, 2, 2999),
(28, 1015, 103, 1, 1799),

(29, 1016, 102, 2, 4999),
(30, 1016, 101, 1, 2499),

(31, 1017, 106, 3, 3499),
(32, 1017, 104, 1, 2299),

(33, 1018, 105, 1, 6999),
(34, 1018, 108, 2, 1299),

(35, 1019, 101, 2, 2499),
(36, 1019, 107, 1, 2999),

(37, 1020, 102, 1, 4999),
(38, 1020, 103, 2, 1799);