DROP DATABASE IF EXISTS xyz;
CREATE DATABASE xyz;
USE xyz;
CREATE TABLE customers(
CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    LastName VARCHAR(50),
    Country VARCHAR(50),
    Age INT CHECK (Age >= 0 AND Age <= 99),
    Phone int(10)
);

DESCRIBE customers;

SHOW COLUMNS FROM customers;

ALTER TABLE customers
ADD SignupDate DATE;

ALTER TABLE customers
MODIFY Phone VARCHAR(15);

INSERT INTO customers (CustomerID, CustomerName, LastName, Country, Age, Phone, SignupDate)
VALUES
(4, 'Bob', 'Lee', 'Canada', 40, '3456789012', '2024-01-15');

SELECT * FROM customers;

DELETE FROM customers WHERE CustomerID > 0;

SELECT Country, COUNT(*) AS NumCustomers, AVG(Age) AS AvgAge
FROM customers
GROUP BY Country;

CREATE TABLE orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID)
);

SELECT * FROM customers;

INSERT INTO customers (CustomerID, CustomerName, LastName, Country, Age, Phone, SignupDate)
VALUES (4, 'Bob', 'Lee', 'Canada', 40, '3456789012', '2024-01-15');

INSERT INTO orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(101, 4, '2024-02-15', 250.00),
(102, 4, '2024-03-10', 150.00);

SELECT c.CustomerName, o.OrderID, o.TotalAmount
FROM customers c
INNER JOIN orders o ON c.CustomerID = o.CustomerID;

SELECT c.CustomerName, o.OrderID, o.TotalAmount
FROM customers c
LEFT JOIN orders o ON c.CustomerID = o.CustomerID;

SELECT c.CustomerName, o.OrderID, o.TotalAmount
FROM orders o
RIGHT JOIN customers c ON c.CustomerID = o.CustomerID;

SELECT CustomerName
FROM customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM orders
    GROUP BY CustomerID
    HAVING COUNT(*) > 1
);

SELECT c.CustomerName, COUNT(o.OrderID) AS TotalOrders, SUM(o.TotalAmount) AS TotalSpent, AVG(o.TotalAmount) AS AvgOrderValue
FROM customers c
JOIN orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;

CREATE VIEW customer_summary AS
SELECT c.CustomerID, c.CustomerName, COUNT(o.OrderID) AS Orders, SUM(o.TotalAmount) AS TotalSpent
FROM customers c
JOIN orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName;

SELECT * FROM customer_summary;