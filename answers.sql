# Q1
SELECT 
    OrderID,
    CustomerName,
    TRIM(products) AS Products
FROM 
    ProductDetail,
    JSON_TABLE(
        CONCAT('[', REPLACE(Products, ',', '","'), ']'),
        '$[*]' COLUMNS (product VARCHAR(20) PATH '$')
    ) AS jtable;

    #Q2
-- there is need to split the table to remove the partial dependencies. 
-- create new table, orders and products, extract necessary entires from OrderDetails. 

CREATE TABLE Orders(OrderId INT PRIMARY KEY, 
CustomerNAme VARCHAR(50));

INSERT INTO Orders(OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

CREATE TABLE Products(OrderId INT, 
ProductName VARCHAR(80),
Quantity INT,
PRIMARY KEY(OrderId, ProductName),
FOREIGN KEY(OrderID) REFERENCES Orders(OrderId));

INSERT INTO Products(OrderID, ProductName, Quantity)
SELECT DISTINCT OrderID, ProductName,Quantity
FROM OrderDetails;