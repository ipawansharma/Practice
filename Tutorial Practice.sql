
---Inbuilt functions in SQL---

SELECT 'ABHISHEK' +''+ 'Yadav' AS FULL_NAME;
SELECT 'ABHISHEK' +' '+ 'Yadav' AS 'PAWAN SHARMA';

CREATE DATABASE [NEW DB];

Use [NEW DB]

CREATE TABLE PAWAN_SHARMA(
A INT)

CREATE TABLE [PAWAN SHARMA](
A INT)

sp_help [PAWAN_SHARMA]
 

---Fuctions---
--CONCAT
--CONCAT_WS

SELECT CONCAT('Pawan',' ', 'Sharma')
SELECT CONCAT_WS(' ','Pawan','Ruchi')

---LEN---

SELECT LEN('ABHISHEK SINGH') AS [Total Length]

---SUB-STRING---

'AMRITA SINGH' --- STRING
'RIT'  ---SUB-STRING

SELECT SUBSTRING('AMRITA SINGH',3,3) AS SUB_PART;

---CHAR INDEX---
SELECT CHARINDEX('@','pawan.sharma@ttconsultants.com');
----------------------------------------------------------------


CREATE TABLE emailid (
email varchar(50));
INSERT INTO emailid(email) VALUES('emailofpawansharma@gmail.com');
INSERT INTO emailid(email) VALUES('emailofruchi@yahoo.com');

SELECT SUBSTRING(email,1,CHARINDEX('@',email)-1) AS name, 
SUBSTRING(email,CHARINDEX('@',email)+1, CHARINDEX('.',email)) from emailid


SELECT SUBSTRING(email,1,CHARINDEX('@',email)-1) AS name, 
SUBSTRING(email,CHARINDEX('@',email)+1, CHARINDEX('.',email)-CHARINDEX('@',email)-1) AS domain from emailid


--How to find second highest salary of an employee?--
--Second  highest salary

SELECT MAX(EMPLOYEE_SALARY) AS SECOND_HIGHEST_SALARY WHERE
EMPLOYEE_SALARY<(SELECT MAX(EMPLOYEE_SALARY) FROM EMPLOYEE)


CREATE TABLE EMPLOYEE1(
salary INT);

INSERT INTO EMPLOYEE1 VALUES(10000);
INSERT INTO EMPLOYEE1 VALUES(100000);
INSERT INTO EMPLOYEE1 VALUES(1000000);

SELECT * FROM EMPLOYEE1;
-- For 2nd max salary
SELECT MAX(salary) AS MAXIMUM_SALARY FROM EMPLOYEE1 WHERE 
salary<(SELECT MAX(salary) FROM EMPLOYEE1);

-- For 2nd min salary
SELECT MIN(salary) AS MAXIMUM_SALARY FROM EMPLOYEE1 WHERE 
salary>(SELECT MIN(salary) FROM EMPLOYEE1);


--DDL (Data Definition Language) Commands:
--DML (Data Manipulation Language) Commands:

-- DIfference between DELETE & DROP:
-- 1. DELETE command is used to delete the rows based on some condition
-- 2. DROP command is used to entirely delete the complete table including the structure of 
-- the table.
-- 3. DELETE command can be reversed, however; DROP cannot be reversed.

--- DDL Commands can never be rolled back.


-- DELETE FROM TABLE_NAME -- It will delete all the rows from the tables and structure of the
-- table will remain. -- DML Command
--- TRUNCATE TABLE TABLE_NAME -- All records will be deleted but structure will remain. -- DML Command
 
---------------- Differ between DELETE & TRUNCATE --------------------
---DELETE is a DML command so it can be rolled back
---TRUNCATE is a DDL command so it cannot be rolled back
---DELETE is doing everything on row level and there is no effect on structure of the table.
---TRUNCATE first drop each and everything (all the data & structure) and once again make a structure with the same column names for the table.


CREATE DATABASE CLASS_4;

USE CLASS_4;

CREATE TABLE CLASS_4(
NAME VARCHAR(20),
AGE INT,
DOJ DATE);

INSERT INTO CLASS_4 VALUES('Pawan',24,'2022-10-10')
INSERT INTO CLASS_4 VALUES('Nakul',25,'2022-10-10')

SELECT * INTO CLASS_5 FROM CLASS_4; -- Command to use record one table into another

DELETE FROM CLASS_4; --It is slow
TRUNCATE TABLE CLASS_5; --It is fast

------------------------------------------------------------
--ALTER Command-- DDL

CREATE TABLE CLASS_6(
NAME VARCHAR(20),
AGE INT,
DOJ DATE);

INSERT INTO CLASS_6 VALUES('Pawan',24,'2022-10-10')
INSERT INTO CLASS_6 VALUES('Nakul',25,'2022-10-10')

-- Command to drop a column:
ALTER TABLE CLASS_6 DROP COLUMN DOJ; -- ALTER TABLE TABLE_NAME DROP COLUMN COLUMN_NAME

SELECT * FROM CLASS_6;

-- Command to add a column:
ALTER TABLE CLASS_6 ADD MobileNo INT;

--How to change the datatype of column:
ALTER TABLE CLASS_6 ALTER COLUMN MobileNo VARCHAR(20);

--UPDATE (DML)
SELECT * FROM CLASS_6;

UPDATE CLASS_6 SET MobileNo='+91' WHERE NAME='Nakul'

-----------------------------------------------------------------------------
--Questions:
--Q1. Select all the CustomerID WHERE email is having a substring 'LLI' and month of delivery is in October & November. 
SELECT Customers_new.customerid
FROM customers_new, orders
WHERE customers_new.customerid=orders.customersid
AND EMAIL LIKE '%LLI%'
AND MONTH(DeliveryDate) IN (10,11)

--Q2. I want top 10 customers who have their total order amount greater than 10000 and their
-- name start with 'A', country is United States and month of ordering is october?

SELECT TOP 10 firstname+' '+lastname AS FullName
FROM Customer_new AS C,orders AS O
WHERE C.CustomerID=O.CustomerID AND Country='United States'
AND MONTH(DeliveryDate)=10 AND SUBSTRING(firstname,1,1) IN ('A')
GROUP BY firstname+' '+lastname
HAVING SUM(Total_Order_amount)>10000
ORDER BY SUM(Total_Order_amount) DESC;


SELECT customers_new.customerID
FROM customers_new AS C, orders AS O
WHERE C.customersID=O.CustomersID 
AND EMAIL LIKE '%LLI%'
AND MONTH(DeliveryDate) IN (10,11)

--Q2. I want top 10 customers who have their total order amount greater than 10000 and their
-- name start with 'A', country is United States and month of ordering is october?


SELECT TOP 10 FirstName+' '+LastName AS Full_Name
FROM Customer_new AS C, Orders AS O
WHERE C.customerID=O.CustomerID
AND FirstName LIKE 'A%' 
AND MONTH(DeliveryDate)=10
AND Country='United States'
GROUP BY FirstName+' '+LastName
HAVING SUM(Total_Order_Amount)>10000
ORDER BY SUM(Total_Order_Amount) desc

--Q3. I want all the customerID that are duplicated in my orders table? (IMP INTERVIEW QUE)

SELECT CustomerID 
FROM ORDERS
GROUP BY CustomerID
HAVING COUNT(CUSTOMERID)>1

--Q4. I want state wise sales of all the states where the sales amount is geater than 100000 and month of
-- sales is in October, November and december.
-- Note- People are paying on their order date only

SELECT States, SUM(Total_order_amount) AS Sales
FROM Customers_new AS C,Orders AS O
WHERE C.CustomerID=O.CustomerID
AND DATEPART(MONTH,OrderDate) IN (10,11,12)
GROUP BY States
HAVING SUM(Total_order_amount)>100000


--Q5. I want TOP 10 customers full name whose age is less than 30 and their birth month is October and delivery is
--done in less than 4 days AND total_order_amount >10000 and their entering month in the company is
--november or december AND their ID is divisible by 4?

SELECT TOP 10 firstname+' '+lastname AS Full_Name
FROM Customers_new AS C, Orders AS O
WHERE C.CustomerID=O.CustomerID 
AND DATEDIFF(YEAR,Date_of_birth,CURRENT_TIMESTAMP)<30 AND MONTH(Date_Of_Birth)=10
AND DATEDIFF(DAY,OrderDate,DeliveryDate)<4 AND MONTH(DateEntered) IN (11,12)
AND C.CustomerID%4=0
GROUP BY firstname+' '+lastname
HAVING SUM(Total_Order_Amount)>10000
ORDER BY SUM(Total_Order_Amount) desc;


--Q. I want total order amount spent by all the customers registered?

SELECT FirstName+' '+LastName AS Full_Name, SUM(Total_Order_Amount)
FROM Customers AS C left join Orders AS O
on C.CustomerID=O.CustomerID
GROUP BY FirstName+' '+LastName


--Q. I want customers who have never ordered?

USE PracticeDB;

--CREATE TABLE Customers(
--CustomerID INT,
--firstname VARCHAR(20),
--lastname VARCHAR(20))

--INSERT INTO Customers VALUES(100,'Pawan','Sharma')
--INSERT INTO Customers VALUES(101,'Nakul','Sharma')
--INSERT INTO Customers VALUES(102,'Abhay','Thakur')
--INSERT INTO Customers VALUES(103,'Shivangi','Goel')
--INSERT INTO Customers VALUES(104,'Poorvi','Goel')

--CREATE TABLE Orders(
--CustomerID INT,
--OrderDate DATE,
--Total_Order_Amount INT)

--INSERT INTO Orders VALUES(100,'2020-01-01',12359)
--INSERT INTO Orders VALUES(101,'2022-02-02',12688)
--INSERT INTO Orders VALUES(103,'2022-12-10',156895)

--SELECT * FROM Customers;
--SELECT * FROM Orders;

--SELECT firstname+' '+lastname AS FULL_NAME
--FROM Customers AS C LEFT JOIN Orders AS O ON C.CustomerID=O.CustomerID - 
--Customers INNER JOIN Orders ON C.CustomerID=O.CustomerID

--Q. I want customers who have never ordered?

SELECT firstname+' '+lastname AS [Full Name]
FROM Customers C LEFT JOIN Orders O
ON C.CustomerID=O.CustomerID
WHERE O.CustomerID IS NULL;

-- CASE WHEN (Category)

--Q. 
SELECT student_id,
SUM(CASE WHEN SUBJECT='English' THEN 'Marks' ELSE 0 END) AS English,
SUM(CASE WHEN SUBJECT='Maths' THEN 'Marks' ELSE 0 END) AS Maths,
SUM(CASE WHEN SUBJECT='Science' THEN 'Marks' ELSE 0 END) AS Science
FROM student
GROUP BY student_id

---ORDER BY WITH CASE WHEN---
-- I want to order by table on the basis of age column but with one condition (IF KIND=DOG
-- THEN THAT THING WILL BE ORDERED FIRST, ELSE OTHERS)

SELECT *
FROM PETS
ORDER BY
( CASE WHEN KIND='DOG' THEN AGE 
ELSE OWNERID 
END);

---SET OPERATORS---
--UNION
--UNION ALL
--INTERSECT
--EXCEPT

--Conditions for SET Operators:
--COLUMNS SHOULD BE SAME
--ORDER OF COLUMN SHOULD BE SAME
--DATATYPES HAS TO BE SAME

--UNION: Distinct records from all the select statements
--UNION ALL: All records from all the select statements including duplicates.
--INTERSECT: Command Distinct records 
--EXCEPT: Removes results of 2nd select statements from results of first select statement

---------------------------------SUBQUERY & CTE-----------------------------------

--Limitations for SUBQUERY & CTE: 
--Cannot use ORDER BY clause inside a CTE, VIEW, SUBQUERY.
--Cannot use an UPDATE clause from the results of CTE, VIEW, SUBQUERY.

WITH CTE AS (
SELECT O.Name, StreetAdress, COUNT(OwnerID)
FROM Owners AS O Outer Join Pets AS P
ON O.OWN_ID=P.OwnerID
WHERE KIND='DOG' AND SUBSTRING(P.Name,1,1) IN ('A','B') AND O.Name LIKE 'B%'
GROUP BY O.Name, StreetAdress)
SELECT NAME,StreetAdress,
CASE WHEN LEN(StreetAdress)>15 THEN 'LONG CITY'
ELSE 'SHORT CITY' END AS Category
FROM CTE;

---CTE VS SUBQUERY
--1. CTE is more understandable than Subquery
--2. In CTE, filtered results will create a object of itself. CTE is faster

---------------VIEWS---------------
CREATE VIEW RESULTS_FOR_DOG AS
SELECT PETID,Owners.Name FROM Owners
JOIN Pets
ON Owners.Own_ID=pets.OwnerID
WHERE KIND='DOG'

SELECT * FROM RESULTS_FOR_DOG

---------------WINDOW--------------

--1. Over Clause: Anything you want to do with your window functions like creating a window,
--partition it or order it. You have to use Over Clause.

--Q. Find the cumulative sum or running sum with window functions.

SELECT * SUM(Salary) OVER (ORDER BY emp_ID) AS SUM_SALARY
FROM Employee;

--2. RANK, DENSE_RANK AND ROW_NUMBER
--3. FIRST_VALUE, LAST_VALUE, NTH_VALUE, NTILE, PRCEEDING & FOLLOWING

-- FIRST_VALUE SYNTAX:
SELECT *,
FIRST_VALUE(product_name) OVER (PARTITION BY product_category ORDER BY Price DESC) AS Valuee
FROM Product;

-- LAST_VALUE SYNTAX:
-- FOR complete window for single category
SELECT *,
LAST_VALUE(product_name) OVER (PARTITION BY product_category ORDER BY price DESC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS lstValue
FROM Product;

-- FOR a specific area of a window (2 before and 3 after)
SELECT *,
LAST_VALUE(product_name) OVER (PARTITION BY product_category ORDER BY price DESC
ROWS BETWEEN 2 PRECEDING AND 3 FOLLOWING) AS lstValue
FROM Product;

--Q. For 3 days rolling average
SELECT *,
AVG(Price) OVER (PARTITION BY ____ ORDER BY DATE
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Rolling_Average
FROM Product


--Nth Value (Works in MySQL & PostgreSQL)
--Q. Find the 4th most expensive product?

SELECT *,
nth_value(product_name,4) over(PARTITION BY brand ORDER BY PRICE DESC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Rnk
FROM product;

--NTILE: Break data into equal no of subsets (Make buckets of equal numbers)

SELECT *,
NTILE(3) OVER (PARTITION BY product_category ORDER BY price DESC) AS Compartment
FROM product;

---Stored Procedures 
--Ex:
SELECT * 
FROM product
WHERE product_name='XPS 17'

CREATE PROCEDURE GET_PRODUCT_DETAILS
@product_name VARCHAR(20) --GLOBAL VALUE
@price INT
AS
BEGIN
SELECT * FROM PRODUCT WHERE product_name=@product_name,price=@price
END;

EXECUTE GET_PRODUCT_DETAILS 100;

----------------------------------ORDER OF EXECUTION------------------------------------------
----------------------------------------------------------------------------------------------
-- Why DISTINCT doesn't work with ORDER BY?
--Ex:
SELECT DISTINCT source_of_joining FROM students ORDER BY enrollment_date DESC;

--Ex:
SELECT source_of_joining FROM students;

1---Order of execution of above query---
2--FROM (Loading the table)
3--SELECT (Projection the column source_of_joining)

--Ex:
SELECT source_of_joining,enrollment_date FROM students ORDER BY entrollment_date;

---Order of execution of above query---
1--FROM (Loading the table)
SELECT * FROM students
2--SELECT (Projection the column source_of_joining)
SELECT source_of_joining FROM students
3--ORDER BY (Based on enrollment_date)
SELECT source_of_joining FROM students ORDER BY enrollment_date

-- EX:
SELECT source_of_joining FROM students ORDER BY enrollment_date;

---Order of execution of above query---
1--FROM (Loading the table)
SELECT * FROM students
2--SELECT (Projection the column source_of_joining and enrollment_date also because it is
--present in ORDER BY clause)
SELECT source_of_joining,enrollment_date FROM students
3--ORDER BY (Based on enrollment_date)
SELECT source_of_joining,enrollment_date FROM students ORDER BY enrollment_date

-- Ex:
SELECT DISTINCT source_of_joining FROM students ORDER BY enrollment_date;

---Order of execution of above query---
1--FROM (Loading the table)
SELECT * FROM students
2--SELECT (Projection the column source_of_joining and enrollment_date also because it is
--present in ORDER BY clause)
SELECT source_of_joining,enrollment_date FROM students
3--DISTINCT 
SELECT DISTINCT source_of_joining,enrollment_date FROM students
4--ORDER BY (Based on enrollment_date)
SELECT source_of_joining,enrollment_date FROM students ORDER BY enrollment_date


---------------------------Complete order of execution---------------------------------------
FROM
JOIN
WHERE
GROUP BY
HAVING
SELECT
DISTINCT
ORDER BY
LIMIT



create table emp(id INT,name varchar(10),Gender varchar(10));
insert into emp values(1,'A','MALE');
insert into emp values(2,'B','MALE');
insert into emp values(3,'C','MALE');
insert into emp values(4,'D','FEMALE');
insert into emp values(5,'E','FEMALE');

SELECT * FROM EMP;

select id,name,gender
from emp
order by row_number() over(partition by gender order by id),gender DESC

---------------Stored Procedures----------------------------------

CREATE OR REPLACE PROCEDURE pr_name (@p_name VARCHAR, @p_age INT)
