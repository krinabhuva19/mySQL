CREATE DATABASE DataDigger;

USE DataDigger;

CREATE TABLE Customers
(
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100),
    Address VARCHAR(100)
);

INSERT INTO Customers VALUES
(1,'Alice','alice@gmail.com','Rajkot'),
(2,'Rahul','rahul@gmail.com','Ahmedabad'),
(3,'Krina','krina@gmail.com','Surat'),
(4,'Priya','priya@gmail.com','Baroda'),
(5,'Amit','amit@gmail.com','Jamnagar'),
(6,'anju','anju@gmail.com','Rajkot'),
(7,'raj','raj@gmail.com','Ahmedabad'),
(8,'krish','krish@gmail.com','Surat'),
(9,'ayushi','ayushi@gmail.com','Baroda'),
(10,'vishva','vishv@gmail.com','Jamnagar');

SELECT * FROM Customers;

UPDATE Customers
SET Address='Mumbai'
WHERE CustomerID=3;

DELETE FROM Customers
WHERE CustomerID=5;

SELECT * FROM Customers
WHERE Name='krina';


-- STEP 4 : Create Orders Table

CREATE TABLE Orders
(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    
    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
);


INSERT INTO Orders VALUES
(101,1,'2025-05-01',1500),
(102,2,'2025-05-05',2200),
(103,3,'2025-05-10',1800),
(104,1,'2025-05-15',2500),
(105,4,'2025-05-20',3000),
(106,5,'2025-05-02',1600),
(107,7,'2025-05-04',2100),
(108,3,'2025-05-11',1800),
(109,6,'2025-05-16',2500),
(100,2,'2025-05-21',3000);

SELECT * FROM Orders
WHERE CustomerID = 1;

UPDATE Orders
SET TotalAmount = 5000
WHERE OrderID = 103;

DELETE FROM Orders
WHERE OrderID = 105;

SELECT * FROM Orders
WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;

SELECT 
MAX(TotalAmount) AS Highest_Amount,
MIN(TotalAmount) AS Lowest_Amount,
AVG(TotalAmount) AS Average_Amount
FROM Orders;

-- STEP 5 : Create Products Table

CREATE TABLE Products
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

INSERT INTO Products VALUES
(201,'Laptop',55000,10),
(202,'Mobile',20000,15),
(203,'Keyboard',800,25),
(204,'Mouse',500,0),
(205,'Headphone',2500,8);

SELECT * FROM Products
ORDER BY Price DESC;

SELECT * FROM Products
ORDER BY Price DESC;

UPDATE Products
SET Price = 22000
WHERE ProductID = 202;

DELETE FROM Products
WHERE Stock = 0;

SELECT * FROM Products
WHERE Price BETWEEN 500 AND 2000;

SELECT MAX(Price) AS Highest_Price,
MIN(Price) AS Lowest_Price
FROM Products;

-- STEP 6 : Create OrderDetails Table

CREATE TABLE OrderDetails
(
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    SubTotal DECIMAL(10,2),
    
    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID),
    
    FOREIGN KEY (ProductID)
    REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails VALUES
(1,101,201,1,55000),
(2,102,202,2,40000),
(3,103,203,3,2400),
(4,104,205,2,5000),
(5,101,203,1,800);

SELECT * FROM OrderDetails
WHERE OrderID = 101;

SELECT SUM(SubTotal) AS Total_Revenue
FROM OrderDetails;

SELECT ProductID,
SUM(Quantity) AS Total_Quantity
FROM OrderDetails
GROUP BY ProductID
ORDER BY Total_Quantity DESC
LIMIT 3;

SELECT ProductID,
COUNT(ProductID) AS Sold_Times
FROM OrderDetails
WHERE ProductID = 203
GROUP BY ProductID;

SELECT * FROM Customers;

SELECT * FROM Orders;

SELECT * FROM Products;

SELECT * FROM OrderDetails;