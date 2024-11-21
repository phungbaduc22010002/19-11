CREATE DATABASE `buoi7`;
USE `buoi7`;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(100),
    Email  VARCHAR(100)
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    Price DECIMAL(10, 2)
);

CREATE TABLE Promotions (
PromotionsID INT PRIMARY KEY,
PromotionsName VARCHAR(100),
DiscountPercentage DECIMAL(10,2)
);
CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    SaleDate DATE,
    SaleAmount DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
DELIMITER $$
CREATE PROCEDURE Promotion(
     IN monthYear VARCHAR(50),
	 IN revenueThreshold DECIMAL(10, 2)
)
BEGIN 
    DECLARE customerRevenue DECIMAL(10, 2);
    DECLARE customerID INT; 
     DECLARE revenueCursor CURSOR FOR
        SELECT CustomerID, SUM(TotalAmount) AS MonthlyRevenue
        FROM Orders
        WHERE DATE_FORMAT(OrderDate, '%Y-%m') = monthYear
        GROUP BY CustomerID;
        
         DECLARE CONTINUE HANDLER FOR NOT FOUND SET customerID = NULL;

END$$
DELIMITER ;

CALL Promotion('2024-07', 5000);


