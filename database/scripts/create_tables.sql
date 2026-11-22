Table1: Product
CREATE TABLE Product (
ProductID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
SKU VARCHAR (100) NOT NULL UNIQUE,
Prod_name VARCHAR (100) NOT NULL,
Description VARCHAR (250),
Prod_price DECIMAL (10,2) NOT NULL CHECK(Prod_price >=0),
Reorder_level INT NOT NULL CHECK(Reorder_level >=0)
);

Table2: Supplier
CREATE TABLE Supplier (
SupplierID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
Supp_name VARCHAR (100) NOT NULL,
Phone VARCHAR (100),
Email VARCHAR (100) UNIQUE,
Address VARCHAR (100) NOT NULL
);

Table3: Customer
CREATE TABLE Customer (
CustomerID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
Cust_name VARCHAR (100) NOT NULL,
Phone VARCHAR (100),
Email VARCHAR (100) UNIQUE,
Address VARCHAR (100) NOT NULL
);

Table4: Receiving
CREATE TABLE Receiving_Header (
ReceivingID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
SupplierID UUID NOT NULL,
Receiving_date DATE NOT NULL,

FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

CREATE TABLE Receiving_Item(
ReceivingID UUID NOT NULL,
ProductID UUID NOT NULL,
Quantity_Received DECIMAL(15,3) NOT NULL CHECK(Quantity_Received>0),
Unit_Cost DECIMAL(15,2) NOT NULL CHECK(Unit_Cost >=0),

PRIMARY KEY (ReceivingID, ProductID),
FOREIGN KEY(ReceivingID) REFERENCES Receiving_Header(ReceivingID),
FOREIGN KEY(ProductID) REFERENCES Product (ProductID)

);

TABLE5:Sale
CREATE TABLE Sale_Header(
SaleID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
CustomerID UUID NOT NULL,
Sold_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

FOREIGN KEY(CustomerID) REFERENCES Customer (CustomerID)
);


CREATE TABLE sale_item(
SaleID UUID NOT NULL,
ProductID UUID NOT NULL,
Quantity_sold DECIMAL(15,3) NOT NULL CHECK(Quantity_sold>0),
Unit_Price DECIMAL(15,2) NOT NULL CHECK(Unit_Price>=0),

PRIMARY KEY(SaleID, ProductID),
FOREIGN KEY(SaleID) REFERENCES Sale_Header(SaleID),
FOREIGN KEY(ProductID) REFERENCES Product (ProductID)

);

Table5: Inventory
CREATE TABLE Inventory (
InventoryID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
ProductID UUID NOT NULL,
Stock_level DECIMAL(15,3) NOT NULL CHECK(Stock_level >= 0),

Location VARCHAR (50) NOT NULL,
Last_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

FOREIGN KEY(ProductID) REFERENCES Product (ProductID),
UNIQUE(ProductID, Location)
);
