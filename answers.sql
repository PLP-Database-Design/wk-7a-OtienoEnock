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
CustomerNAme VARCHAR(50),
Quantity INT);

INSERT INTO Orders(OrderID, CustomerName, Quantity)
SELECT DISTINCT OrderID, CustomerName, Quantity
FROM OrderDetails;

CREATE TABLE Products(OrderId INT, 
ProductName VARCHAR(80),
PRIMARY KEY(OrderId, ProductName),
FOREIGN KEY(OrderID) REFERENCES Orders(OrderId));

INSERT INTO Products(OrderID, ProductName)
SELECT DISTINCT OrderID, ProductName
FROM OrderDetails;