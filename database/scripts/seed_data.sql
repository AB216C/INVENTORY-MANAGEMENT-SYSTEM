
INSERT INTO Product (SKU, Prod_name, Description, Prod_price, Reorder_level)
VALUES
('RD-45', 'Macbook Air', 'A lightweight Apple Labtop', 900, 10),
('RD-30', 'Macbook Pro', 'A high-performance Apple Labtop', 1200, 7),
('RD-45-A', 'Iphone X', 'Smartphone-all-scren edge-to-edge', 500, 6);


INSERT INTO Supplier (Supp_name,Phone, Email,Address)
VALUES
 ('Jones', '345-656-434', 'jones@gmail.com', 'China'),
('Rahul', '345-656-400', 'rahul@gmail.com', 'Vietnam'),
('Simba', '345-656-430', 'simba@gmail.com', 'Namibia');


INSERT INTO Customer (Cust_name,Phone, Email,Address)
VALUES
 ('Sam', '545-400-434', 'sam@gmail.com', 'Nebraska'),
 ('Suz', '545-400-400', 'suz@gmail.com', 'Texas'),
('Zama', '545-300-430', 'zama@gmail.com', 'Kansas');



INSERT INTO Receiving_Header(SupplierID, Receiving_date)
VALUES

(
    (SELECT SupplierID FROM Supplier WHERE Email = 'jones@gmail.com' ), '2026-05-25'
), 

(

    (SELECT SupplierID FROM Supplier WHERE Email = 'rahul@gmail.com') , '2026-06-02'
), 

(

    (SELECT SupplierID FROM Supplier WHERE Email = 'simba@gmail.com' ), '2026-06-06'
)

RETURNING ReceivingID, SupplierID, Receiving_date;


INSERT INTO Sale_Header(CustomerID)
VALUES
(
    ( SELECT CustomerID FROM Customer WHERE Email = 'sam@gmail.com')
),

(
    ( SELECT CustomerID FROM Customer WHERE Email = 'suz@gmail.com')
),

(
    ( SELECT CustomerID FROM Customer WHERE Email = 'zama@gmail.com')
)

RETURNING SaleID, CustomerID, Sold_date;



INSERT INTO Receiving_Item(ReceivingID, ProductID, Quantity_Received, Unit_Cost)
VALUES
(
(SELECT ReceivingID FROM Receiving_Header WHERE SupplierID = (SELECT SupplierID FROM Supplier WHERE Email= 'jones@gmail.com') 

AND Receiving_date= '2026-05-25'),

(SELECT ProductID FROM Product WHERE SKU= 'RD-45'),10,700
),
(

(SELECT ReceivingID FROM Receiving_Header WHERE SupplierID = (SELECT SupplierID FROM Supplier WHERE Email= 'jones@gmail.com') 

AND Receiving_date = '2026-05-25'),

(SELECT ProductID FROM Product WHERE SKU= 'RD-30'),5,950

),

(
(SELECT ReceivingID FROM Receiving_Header WHERE SupplierID = (SELECT SupplierID FROM Supplier WHERE Email= 'jones@gmail.com') 

AND Receiving_date = '2026-05-25'),

(SELECT ProductID FROM Product WHERE SKU= 'RD-45-A'),4,350

),

(
(SELECT ReceivingID FROM Receiving_Header WHERE SupplierID = (SELECT SupplierID FROM Supplier WHERE Email= 'rahul@gmail.com') 

AND Receiving_date = '2026-06-02'),

(SELECT ProductID FROM Product WHERE SKU= 'RD-45'),8,720
),

(
(SELECT ReceivingID FROM Receiving_Header WHERE SupplierID = (SELECT SupplierID FROM Supplier WHERE Email= 'rahul@gmail.com') 

AND Receiving_date = '2026-06-02'),

(SELECT ProductID FROM Product WHERE SKU= 'RD-30'),8,940
),

(
(SELECT ReceivingID FROM Receiving_Header WHERE SupplierID = (SELECT SupplierID FROM Supplier WHERE Email= 'simba@gmail.com') 

AND Receiving_date = '2026-06-06'),

(SELECT ProductID FROM Product WHERE SKU= 'RD-45-A'),12,350
);


INSERT INTO sale_item(SaleID, ProductID, Quantity_sold, Unit_Price)
VALUES

(
(SELECT SaleID FROM Sale_Header WHERE CustomerID = (SELECT CustomerID FROM Customer WHERE Email = 'sam@gmail.com')),

(SELECT ProductID FROM Product WHERE SKU = 'RD-45' ), 
2, 900
),

(
(SELECT SaleID FROM Sale_Header WHERE CustomerID = 
(SELECT CustomerID FROM Customer WHERE Email = 'suz@gmail.com')),
(SELECT ProductID FROM Product WHERE SKU = 'RD-45-A' ),
3, 500

), 

(
(SELECT SaleID FROM Sale_Header WHERE CustomerID = 
(SELECT CustomerID FROM Customer WHERE Email = 'suz@gmail.com')), 
(SELECT ProductID FROM Product WHERE SKU = 'RD-45' ), 
1, 900

), 

(
(SELECT SaleID FROM Sale_Header WHERE CustomerID =
(SELECT CustomerID FROM Customer WHERE Email = 'zama@gmail.com')),
(SELECT ProductID FROM Product WHERE SKU = 'RD-45' ),
2, 900

), 

(
(SELECT SaleID FROM Sale_Header WHERE CustomerID = 
(SELECT CustomerID FROM Customer WHERE Email = 'zama@gmail.com')),
(SELECT ProductID FROM Product WHERE SKU = 'RD-30' ), 
1, 1200

), 

(
(SELECT SaleID FROM Sale_Header WHERE CustomerID = 
(SELECT CustomerID FROM Customer WHERE Email = 'zama@gmail.com')),
(SELECT ProductID FROM Product WHERE SKU = 'RD-45-A' ),
3, 500
);


INSERT INTO Inventory (ProductID, Stock_level, Location)

VALUES
((SELECT ProductID FROM Product WHERE SKU = 'RD-45'), 6 , '200-A1'),
((SELECT ProductID FROM Product WHERE SKU = 'RD-45'), 7 , '200-A6'),
((SELECT ProductID FROM Product WHERE SKU = 'RD-30'), 10 , '100-B2'),
((SELECT ProductID FROM Product WHERE SKU = 'RD-30'), 2 , '200-B1'),
((SELECT ProductID FROM Product WHERE SKU = 'RD-45-A'), 10 , '90-A1')

RETURNING InventoryID, ProductID, Stock_level, Location, Last_updated;



