CREATE DATABASE amazon_db;

USE amazon_db;

CREATE TABLE Users (
user_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
email_id VARCHAR(150) UNIQUE NOT NULL,
registered_date DATE NOT NULL,
membership ENUM('Basic','Prime') DEFAULT 'Basic'
);
SELECT * FROM Users;
INSERT INTO Users (name,email_id,registered_date,membership)
VALUES 
('Alice Johnson', 'alice.j@example.com', '2024-01-15', 'Prime'),
('Bob Smith', 'bob.s@example.com', '2024-02-01', 'Basic'),
('Charlie Brown', 'charlie.b@example.com', '2024-03-10', 'Prime'),
('Daisy Ridley', 'daisy.r@example.com', '2024-04-12', 'Basic');

CREATE TABLE Products (
product_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(200) NOT NULL,
price DECIMAL(10,2) NOT NULL,
category VARCHAR(100) NOT NULL,
stock INT NOT NULL
);

ALTER TABLE Products
MODIFY price DECIMAL(20,10) NOT NULL;

SELECT * FROM Products;
INSERT INTO Products (name,price,category,stock)
VALUES
('Echo Dot', 49.99, 'Electronics', 120),
('Kindle Paperwhite', 129.99, 'Books', 50),
('Fire Stick', 39.99, 'Electronics', 80),
('Yoga Mat', 19.99, 'Fitness', 200),
('Wireless Mouse', 24.99, 'Electronics', 150);

CREATE TABLE Orders (
order_id INT AUTO_INCREMENT PRIMARY KEY,
user_id INT,
FOREIGN KEY (user_id) REFERENCES Users(user_id),
order_date DATE NOT NULL,
total_amount DECIMAL(10,2) NOT NULL
);
SELECT * FROM Orders;
INSERT INTO Orders (user_id,order_date,total_amount)
VALUES
(1, '2024-05-01', 79.98),
(2, '2024-05-03', 129.99),
(1, '2024-05-04', 49.99),
(3, '2024-05-05', 24.99);

CREATE TABLE OrderDetails (
order_details_id INT AUTO_INCREMENT PRIMARY KEY,
order_id INT,
FOREIGN KEY (order_id) REFERENCES Orders (order_id),
product_id INT,
FOREIGN KEY (product_id) REFERENCES Products (product_id),
quantity INT NOT NULL
);
SELECT * FROM OrderDetails;
INSERT INTO OrderDetails(order_id,product_id,quantity)
VALUES 
(1, 1, 2),
(2, 2, 1),
(3, 1, 1),
(4, 5, 1);