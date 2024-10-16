-- Create a new database named ecommerce
-- Use the ecommerce database

--Create tables Required 
CREATE TABLE customers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    address VARCHAR(255)
);
CREATE TABLE orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);
CREATE TABLE products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT
);
CREATE TABLE order_items (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);


-- Insert sample data into the customers table
INSERT INTO customers (name, email, address)
VALUES 
('sterin', 'sterin@gmail.com', 'nathan St'),
('Jane', 'jane@gmail.com', 'marshal St'),
('jack', 'jack@gmail.com', 'Abirami St');
--select * FROM customers 


-- Insert sample data into the products table
INSERT INTO products (name, price, description)
VALUES
('Product A', 30.00, 'Description for Product A'),
('Product B', 55.00, 'Description for Product B'),
('Product C', 40.00, 'Description for Product C');
--select * FROM products


-- Insert sample data into the orders table
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES 
(1, '2024-09-28', 100.00),
(2, '2024-10-01', 150.00),
(1, '2024-10-05', 250.00),
(3, '2024-10-02', 200.00);
--select *from orders


-- Insert sample data into the order_items table
INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES
(1, 1, 2, 30.00), 
(2, 2, 1, 55.00),  
(3, 3, 1, 40.00),  
(3, 1, 1, 30.00);  
--select *from order_items


--Queries to Write:


-- 1)Retrieves customers who have placed an order in the last 30 days
SELECT DISTINCT c.*
FROM customers c
JOIN orders o ON c.id = o.customer_id
WHERE o.order_date >= GETDATE() - 30;

-- 2)Retrieves the total amount of all orders placed by each customer
SELECT c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.name;

-- 3)Updates the price of the product named 'Product C' to 45.00
UPDATE products
SET price = 45.00
WHERE name = 'Product C';
select *from products

-- 4)Adds a new column named 'discount' to the products table with a default value of 0.00
ALTER TABLE products
ADD discount DECIMAL(5, 2) DEFAULT 0.00;
select * from products


--5) Retrieves the top 3 products with the highest price
SELECT TOP 3 *
FROM products
ORDER BY price DESC;


-- 6)Retrieves the names of customers who have ordered 'Product A'
SELECT DISTINCT c.name
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE p.name = 'Product A';

--7) Retrieves the customer's name and order date for each order
SELECT c.name, o.order_date
FROM customers c
JOIN orders o ON c.id = o.customer_id;

--8)Retrieves the orders with a total amount greater than 150.00
SELECT *
FROM orders
WHERE total_amount > 150.00;

--9)Retrieves order details along with product information
SELECT o.id AS order_id, c.name AS customer_name, p.name AS product_name, oi.quantity, oi.price
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id;

--10) Retrieves the average total of all orders
SELECT AVG(total_amount) AS average_order_total
FROM orders;



