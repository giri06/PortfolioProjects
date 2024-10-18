CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,  -- Manually assigned
    Name VARCHAR(100) NOT NULL,
    Date_of_Joining DATE NOT NULL,
    Salary NUMERIC(10, 2) NOT NULL
);

CREATE TABLE Chef (
    Employee_ID INT PRIMARY KEY,  -- Manually assigned
    Years_of_Experience INT,
    Specialization VARCHAR(100),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);


CREATE TABLE Waiter (
    Employee_ID INT PRIMARY KEY,  -- Manually assigned
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);

CREATE TABLE Manager (
    Employee_ID INT PRIMARY KEY,  -- Manually assigned
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);


CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,  -- Manually assigned
    Customer_name VARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    Address TEXT
);


CREATE TABLE Discount (
    Discount_ID INT PRIMARY KEY,  -- Manually assigned
    Discount_percent NUMERIC(5, 2) NOT NULL,
    Description TEXT
);



CREATE TABLE Date_Dim (
    Date_ID INT PRIMARY KEY,  -- Manually assigned
    Date DATE NOT NULL,
    Month VARCHAR(20),
    Year INT,
    Day INT
);

CREATE TABLE Menu (
    Item_ID INT PRIMARY KEY,  -- Manually assigned
    Item_name VARCHAR(100) NOT NULL,
    Description TEXT,
    Price NUMERIC(10, 2) NOT NULL,
    Employee_ID INT,  -- Refers to Chef
    FOREIGN KEY (Employee_ID) REFERENCES Chef(Employee_ID)
);


CREATE TABLE Inventory (
    Inventory_Item_ID INT PRIMARY KEY,  -- Manually assigned
    Item_Name VARCHAR(100) NOT NULL,
    Qty INT NOT NULL,
    Unit_Price NUMERIC(10, 2) NOT NULL,
    Supplier_Name VARCHAR(100),
    Employee_ID INT,  -- Refers to Manager
    FOREIGN KEY (Employee_ID) REFERENCES Manager(Employee_ID)
);


CREATE TABLE "Order" (
    Order_ID INT PRIMARY KEY,  -- Manually assigned
    Total_Amount NUMERIC(10, 2) NOT NULL,
    Order_Date INT,  -- Refers to Date_Dim.Date_ID
    Customer_ID INT, -- Refers to Customer
    Employee_ID INT, -- Refers to Waiter or Manager
    Discount_ID INT, -- Refers to Discount
    FOREIGN KEY (Order_Date) REFERENCES Date_Dim(Date_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Discount_ID) REFERENCES Discount(Discount_ID)
);


CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY,  -- Manually assigned
    Payment_Date INT, -- Refers to Date_Dim.Date_ID
    Payment_Type VARCHAR(50) NOT NULL,
    Amount NUMERIC(10, 2) NOT NULL,
    Order_ID INT, -- Refers to Order
    FOREIGN KEY (Payment_Date) REFERENCES Date_Dim(Date_ID),
    FOREIGN KEY (Order_ID) REFERENCES "Order"(Order_ID)
);

-- Step 10: Create Inventory Purchase table (Dependent on Inventory and Date_Dim)
CREATE TABLE Inventory_Purchase (
    Purchase_ID INT PRIMARY KEY,  -- Manually assigned
    Inventory_Item_ID INT,  -- Refers to Inventory
    Order_Date INT,         -- Refers to Date_Dim.Date_ID
    Quantity_Ordered INT NOT NULL,
    FOREIGN KEY (Inventory_Item_ID) REFERENCES Inventory(Inventory_Item_ID),
    FOREIGN KEY (Order_Date) REFERENCES Date_Dim(Date_ID)
);




-- Insert into Employee table
INSERT INTO Employee (Employee_ID, Name, Date_of_Joining, Salary)
VALUES
(1, 'John Doe', '2020-01-10', 50000.00),
(2, 'Sarah Connor', '2019-03-14', 60000.00),
(3, 'Alice Brown', '2021-05-21', 55000.00),
(4, 'Bob Smith', '2018-07-15', 52000.00),
(5, 'Charlie Davis', '2020-08-25', 57000.00),
(6, 'Eve White', '2017-11-30', 62000.00),
(7, 'James Bond', '2016-01-19', 75000.00);

-- Insert into Chef table
INSERT INTO Chef (Employee_ID, Years_of_Experience, Specialization)
VALUES
(1, 5, 'Italian Cuisine'),
(3, 7, 'French Cuisine'),
(5, 3, 'Japanese Cuisine'),
(7, 12, 'Fusion Cuisine');

-- Insert into Waiter table
INSERT INTO Waiter (Employee_ID)
VALUES
(2),
(4),
(6);

-- Insert into Manager table
INSERT INTO Manager (Employee_ID)
VALUES
(7);

-- Insert into Customer table
INSERT INTO Customer (Customer_ID, Customer_name, Phone, Address)
VALUES
(1001, 'Jane Smith', '555-1234', '123 Main St'),
(1002, 'Michael Johnson', '555-2345', '456 Oak St'),
(1003, 'Emily Davis', '555-3456', '789 Pine St'),
(1004, 'William Brown', '555-4567', '321 Cedar St'),
(1005, 'Sophia Miller', '555-5678', '654 Elm St'),
(1006, 'James Wilson', '555-6789', '987 Birch St'),
(1007, 'Olivia Anderson', '555-7890', '321 Maple St'),
(1008, 'Mason Moore', '555-8901', '987 Ash St');

-- Insert into Discount table
INSERT INTO Discount (Discount_ID, Discount_percent, Description)
VALUES
(500, 10.00, 'Seasonal Discount'),
(501, 5.00, 'Loyalty Discount'),
(502, 15.00, 'New Customer Discount');

-- Insert into Date_Dim table
INSERT INTO Date_Dim (Date_ID, Date, Month, Year, Day)
VALUES
(101, '2024-10-18', 'October', 2024, 18),
(102, '2024-10-19', 'October', 2024, 19),
(103, '2024-10-20', 'October', 2024, 20),
(104, '2024-10-21', 'October', 2024, 21),
(105, '2024-10-22', 'October', 2024, 22);

-- Insert into Menu table
INSERT INTO Menu (Item_ID, Item_name, Description, Price, Employee_ID)
VALUES
(2001, 'Spaghetti Carbonara', 'Classic Italian pasta dish', 12.99, 1),
(2002, 'Beef Bourguignon', 'French beef stew with red wine', 19.99, 3),
(2003, 'Sushi Platter', 'Assorted sushi rolls', 25.99, 5),
(2004, 'Ramen Bowl', 'Japanese noodle soup', 10.99, 5),
(2005, 'Filet Mignon', 'Grilled beef filet', 29.99, 7);

-- Insert into Inventory table
INSERT INTO Inventory (Inventory_Item_ID, Item_Name, Qty, Unit_Price, Supplier_Name, Employee_ID)
VALUES
(3001, 'Pasta', 100, 1.50, 'Food Supplier A', 7),
(3002, 'Beef', 50, 10.00, 'Food Supplier B', 7),
(3003, 'Fish', 70, 7.50, 'Food Supplier C', 7),
(3004, 'Rice', 200, 0.80, 'Food Supplier A', 7),
(3005, 'Wine', 30, 15.00, 'Wine Supplier', 7);

-- Insert into Order table
INSERT INTO "Order" (Order_ID, Total_Amount, Order_Date, Customer_ID, Employee_ID, Discount_ID)
VALUES
(4001, 45.97, 101, 1001, 2, 500),
(4002, 35.98, 102, 1002, 2, 501),
(4003, 50.99, 103, 1003, 4, NULL),
(4004, 20.99, 104, 1004, 6, 502),
(4005, 60.97, 105, 1005, 4, 500);

-- Insert into Payment table
INSERT INTO Payment (Payment_ID, Payment_Date, Payment_Type, Amount, Order_ID)
VALUES
(5001, 101, 'Credit Card', 45.97, 4001),
(5002, 102, 'Cash', 35.98, 4002),
(5003, 103, 'Debit Card', 50.99, 4003),
(5004, 104, 'Cash', 20.99, 4004),
(5005, 105, 'Credit Card', 60.97, 4005);

-- Insert into Inventory Purchase table
INSERT INTO Inventory_Purchase (Purchase_ID, Inventory_Item_ID, Order_Date, Quantity_Ordered)
VALUES
(6001, 3001, 101, 50),
(6002, 3002, 102, 25),
(6003, 3003, 103, 30),
(6004, 3004, 104, 100),
(6005, 3005, 105, 10);
