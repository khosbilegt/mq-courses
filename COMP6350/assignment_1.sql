-- COMP2350 / COMP6350 Assignment 1 - 2025 student SQL file
-- please rename the file before submission according to the submission instructions for the assignment.
--
-- student name:   ...
-- student number: ...
-- self-written declaration that the work in this assignment is your own
-- student declaration: ...
-- 
-- 
-- ##################################################################################
-- Put your SQL below for the table creation statements for Task B

CREATE TABLE CustomerType
(
    customerTypeID          INT PRIMARY KEY,
    customerTypeName        VARCHAR(45) NOT NULL,
    customerTypeDescription TEXT        NOT NULL
);

CREATE TABLE Customer
(
    customerID          INT PRIMARY KEY,
    customerName        VARCHAR(300) NOT NULL,
    contactName         VARCHAR(300) NOT NULL,
    customerPhoneNumber VARCHAR(20)  NOT NULL,
    customerAddress     VARCHAR(300) NOT NULL,
    customerTypeID      INT,
    FOREIGN KEY (customerTypeID) REFERENCES CustomerType (customerTypeID)
);

CREATE TABLE StaffMember
(
    staffID                  INT PRIMARY KEY,
    staffName                VARCHAR(300) NOT NULL,
    staffRole                VARCHAR(30)  NOT NULL,
    staffCurrentEmployeeType VARCHAR(20)  NOT NULL
);

CREATE TABLE `Order`
(
    orderID                   INT PRIMARY KEY,
    orderDate                 DATE NOT NULL,
    orderTime                 TIME NOT NULL,
    orderDeliveryInstructions TEXT,
    customerID                INT,
    createdByStaffID          INT,
    FOREIGN KEY (customerID) REFERENCES Customer (customerID),
    FOREIGN KEY (createdByStaffID) REFERENCES StaffMember (staffID)
);

CREATE TABLE OrderItem
(
    orderID            INT,
    itemSequenceNumber INT,
    quantity           INT     NOT NULL,
    salePricePerUnit   DECIMAL NOT NULL,
    PRIMARY KEY (orderID, itemSequenceNumber),
    FOREIGN KEY (orderID) REFERENCES `Order` (orderID)
);

CREATE TABLE Payment
(
    paymentID                    INT PRIMARY KEY,
    paymentAmount                DECIMAL     NOT NULL,
    paymentDateTime              DATETIME    NOT NULL,
    paymentMethod                VARCHAR(20) NOT NULL,
    paymentSystemReferenceNumber VARCHAR(256)
);

CREATE TABLE PaymentPortion
(
    paymentID            INT,
    orderID              INT,
    paymentPortionAmount DECIMAL NOT NULL,
    PRIMARY KEY (paymentID, orderID),
    FOREIGN KEY (paymentID) REFERENCES Payment (paymentID),
    FOREIGN KEY (orderID) REFERENCES `Order` (orderID)
);


-- ##################################################################################
-- Put your SQL below for the data insertion statements for Task B

INSERT INTO CustomerType (customerTypeID, customerTypeName, customerTypeDescription)
VALUES
    (1, 'Individual', 'Single customer purchasing for personal use'),
    (2, 'Business', 'Corporate or business customer with bulk orders');

INSERT INTO Customer (customerID, customerName, contactName, customerPhoneNumber, customerAddress, customerTypeID)
VALUES
    (101, 'John Doe', 'John Doe', '0400000001', 'Somewhere in Sydney', 1),
    (102, 'Jane Smith', 'Jane Smith', '0400000002', 'Somewhere in Melbourne', 1),
    (201, 'Patient 0', 'Patient 0', '0399999999', 'Somewhere in Brisbane', 2);

INSERT INTO StaffMember (staffID, staffName, staffRole, staffCurrentEmployeeType)
VALUES
    (1, 'Michael Jackson', 'Manager', 'Full-Time'),
    (2, 'Taylor Swift', 'Sales', 'Full-Time'),
    (3, 'John Lennon', 'Receptionist', 'Part-Time');

INSERT INTO `Order` (orderID, orderDate, orderTime, orderDeliveryInstructions, customerID, createdByStaffID)
VALUES
    (1001, '2025-09-01', '10:30:00', 'Leave at front door', 101, 2),
    (1002, '2025-09-02', '14:15:00', 'Ring bell twice', 102, 3),
    (1003, '2025-09-03', '09:45:00', 'Deliver to reception', 201, 1);

INSERT INTO OrderItem (orderID, itemSequenceNumber, quantity, salePricePerUnit)
VALUES
    (1001, 1, 2, 15.50),
    (1001, 2, 1, 25.00),
    (1002, 1, 3, 9.99),
    (1003, 1, 10, 12.00),
    (1003, 2, 5, 50.00);

INSERT INTO Payment (paymentID, paymentAmount, paymentDateTime, paymentMethod, paymentSystemReferenceNumber)
VALUES
    (5001, 56.00, '2025-09-01 11:00:00', 'CreditCard', 'REF12345'),
    (5002, 29.97, '2025-09-02 15:00:00', 'PayPal', 'REF54321'),
    (5003, 700.00, '2025-09-03 12:30:00', 'BankTransfer', 'REF99999');

INSERT INTO PaymentPortion (paymentID, orderID, paymentPortionAmount)
VALUES
    (5001, 1001, 56.00),
    (5002, 1002, 29.97),
    (5003, 1003, 600.00),
    (5003, 1001, 100.00);


-- ##################################################################################
-- Put your SQL below for the data query statements for Task C
-- your task C i) sql query code below

SELECT customerID, customerName, customerPhoneNumber, customerAddress FROM Customer
WHERE customerName like '%a%' or customerName like '%A%' or customerName like '%z%' or customerName like '%Z%';

-- your task C ii) sql query code below

select c.customerID, c.customerName, min(o.orderDate) as firstOrderDate
from customer c
         left join (select customerID, min(timestamp(orderDate, orderTime)) as orderDate
                    from `order`
                    group by customerID) o on c.customerID = o.customerID
group by c.customerID, c.customerName;

-- your task C iii) sql query code below

select o.orderID, o.orderDate, o.orderTime, c.customerName, c.contactName, oi.amount
from `order` o
left join customer c on c.customerID = o.customerID
left join (
    select orderId, sum(salePricePerUnit * quantity) as amount from orderitem
    group by orderId
) oi on oi.orderID = o.orderID
order by o.orderDate, o.orderTime, c.customerID desc;

-- your task C iv) sql query code below

select o.orderId, totalPaid from `order` o
            left join (
        select orderID, sum(paymentPortionAmount) as totalPaid
        from paymentportion
        group by orderID
    ) pp on pp.orderID = o.orderID

-- your task C v) sql query code below

select s.staffID, s.staffName, coalesce(o.numberOfOrders, 0) as 'number of orders', y.year
from staffmember s
cross join (select 2021 as year union all select 2022 union all select 2023 union all select 2024 union all select 2025) y
         left join (
    select createdByStaffID, DATE_FORMAT(orderDate, '%Y') as year, count(*) as numberOfOrders
    from `order`
    group by createdByStaffID, DATE_FORMAT(orderDate, '%Y')
) o on o.createdByStaffID = s.staffID and o.year = y.year
order by s.staffID, y.year;

-- Cross join returns all matching records even if there is no match, allowing count to return 0 for years with no orders.
-- Union all ensures all years are included in the result as separate entries.

-- your task C vi) sql query code below

select o.orderID,
       coalesce(oi.totalOrderAmount, 0)                             as totalOrderAmount,
       coalesce(pp.totalPaid, 0)                                    as totalPaid,
       coalesce(oi.totalOrderAmount, 0) - coalesce(pp.totalPaid, 0) as totalOwing
from `order` o
         left join (select orderID, sum(salePricePerUnit * quantity) as totalOrderAmount
                    from orderitem
                    group by orderID) oi on oi.orderID = o.orderID
         left join (select orderID, sum(paymentPortionAmount) as totalPaid
                    from paymentportion
                    group by orderID) pp on pp.orderID = o.orderID
order by o.orderID;

-- My data was faulty so it should show negative owed, meaning the customer paid extra.


-- end of file
