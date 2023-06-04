--DDL -> Data Definition Language
CREATE TABLE amazon_orders
(
order_id integer,
order_date date,
product_name VARCHAR(100),
total_price DECIMAL(10,2),
payment_method VARCHAR(100)
);

--Delete a table from the database
--  DROP TABLE amazon_orders;

--DML -> Data Manipulation Language
INSERT INTO amazon_orders VALUES (1,'2022-10-01','Baby Milk',30.5,'UPI');
INSERT INTO amazon_orders VALUES (2,'2022-10-02','Baby Powder',130,'Credit Card');
INSERT INTO amazon_orders VALUES (3,'2022-10-01','Baby Milk',30.5,'UPI');
INSERT INTO amazon_orders VALUES (4,'2022-10-02','Baby Powder',130,'Credit Card');

-- To delete data
DELETE FROM amazon_orders;

--DQL -> Data Querying Language
SELECT * FROM amazon_orders;

/*
data types:
Integer ->1,2,3,-1,-2
date -> '2020-11-01'
VARCHAR(100) -> Baby Milk
DECIMAL(5,2) -> 1234.45
*/
--Limiting columns or selecting specific columns
SELECT product_name, order_date FROM amazon_orders;

--Limiting rows
SELECT TOP 3 * FROM amazon_orders;

--Data Sorting
SELECT * FROM amazon_orders
ORDER BY order_date;

--Change datatype of a column:
ALTER TABLE amazon_orders ALTER COLUMN order_date DATETIME; --DDL
INSERT INTO amazon_orders VALUES (2,'2022-10-02 12:05:12','Baby Powder',130,'Credit Card');

--ADD new column in existing table:
ALTER TABLE amazon_orders ADD user_name VARCHAR(20); 
INSERT INTO amazon_orders VALUES (5,'2022-10-02 12:05:12',null,130,'Credit Card','Pawan');

--DROP a column from an existing table:
ALTER TABLE amazon_orders DROP COLUMN user_name;
--Constraints:
CREATE TABLE a_orders
(
order_id integer NOT NULL UNIQUE, --NOT NULL & Unique Constraint 
order_date date,
product_name VARCHAR(100),
total_price DECIMAL(10,2),
payment_method VARCHAR(100) CHECK (payment_method IN ('UPI','Credit Card')), --CHECK Constraint
category VARCHAR(20) DEFAULT 'Mens Wear'
PRIMARY KEY(order_id, product_name)
);

INSERT INTO a_orders VALUES(1,'2022-10-10','Facewash',240,'Credit Card','Kids Wear');
INSERT INTO a_orders(order_id,order_date,product_name,total_price,payment_method) VALUES(3,'2022-10-10','Facewash',240,'UPI');
INSERT INTO a_orders(order_id,order_date,product_name,total_price,payment_method) 
VALUES(4,'2022-10-10','Facewash',240,DEFAULT);

-- PRIMARY KEY: UNIQUE + NOT NULL  (Can be a combination of one or more columns)
-- Can have only one PRIMARY KEY in a table. 
SELECT * FROM a_orders;

SELECT DISTINCT ship_mode 
FROM Orders;

SELECT DISTINCT ship_mode, segment
FROM orders;

---FILTERS----
SELECT *
FROM orders
WHERE Ship_mode='FIRST CLASS';

SELECT	* 
FROM orders
WHERE order_date < '2020-12-08'
ORDER BY order_date DESC;

SELECT	* 
FROM orders
WHERE order_date BETWEEN '2020-12-08' AND '2020-12-25'
ORDER BY order_date DESC;

SELECT ship_mode
FROM orders
WHERE ship_mode IN ('First Class','Same Day')

SELECT *
FROM orders
WHERE ship_mode ='First Class' OR ship_mode = 'Same Day'

SELECT *
FROM orders
WHERE ship_mode = 'FIRST CLASS' AND segment = 'Consumer'

SELECT CAST(order_date AS DATE) AS order_date_new,*
FROM orders
WHERE CAST(order_date AS DATE)='2020-12-10';

SELECT *, profit/sales AS ratio, GETDATE()
FROM orders
WHERE ship_mode = 'FIRST CLASS'

SELECT *, CAST(order_date AS TIME)
FROM Orders;

---Pattern Matching (LIKE)
SELECT order_id,order_date,customer_name
FROM orders
WHERE customer_name LIKE 'C%';

SELECT order_id,order_date,customer_name
FROM orders
WHERE customer_name LIKE '%N';

SELECT order_id,order_date,customer_name, UPPER(Customer_Name) AS name_upper
FROM orders
WHERE UPPER(Customer_Name) LIKE '%VEN%';

SELECT order_id,order_date,customer_name
FROM orders
WHERE UPPER(Customer_Name) LIKE '_L%';

SELECT order_id,order_date,customer_name
FROM orders
WHERE UPPER(Customer_Name) LIKE 'C[al]%';

SELECT order_id,order_date,customer_name
FROM orders
WHERE UPPER(Customer_Name) LIKE 'C[a-f]%';

SELECT * FROM orders;

-- Assignment 1 ---- Solution ----
--Q1--
SELECT *
FROM orders
WHERE customer_name LIKE '_a_d%';

--Q2--
SELECT *
FROM orders
WHERE order_date BETWEEN '2020-12-01' AND '2020-12-31';

--Q3--
SELECT *
FROM orders
WHERE ship_mode NOT IN ('Standard Class','First Class') 
AND ship_date > '2020-11-30'
	

--Q4--
SELECT *
FROM orders
WHERE customer_name NOT LIKE 'A%n';

--Q5--
SELECT *
FROM orders
WHERE profit LIKE '-%'

--Q6--
SELECT *
FROM orders
WHERE quantity<3 OR profit=0;

--Q7--
SELECT *
FROM orders
WHERE region = 'South' AND discount>0;

--Q8--
SELECT TOP 5 *
FROM orders
WHERE category = 'Furniture'
ORDER BY sales DESC;

--Q9--
SELECT * 
FROM orders
WHERE category IN ('Furniture','Technology')
AND (order_date BETWEEN '2020-01-01' AND '2020-12-31');

--Q10--
SELECT *
FROM orders
WHERE order_date BETWEEN '2020-01-01' AND '2020-12-31'
AND ship_date BETWEEN '2021-01-01' AND '2021-12-31';

--Aggregation--

SELECT COUNT(*) AS Cnt,
SUM(sales) AS total_sales,
MAX(sales) AS max_sales,
MIN(profit) AS min_profit,
AVG(profit) AS avg_profit
FROM orders;

--GROUP BY--
SELECT region,COUNT(*) AS Cnt,
SUM(sales) AS total_sales,
MAX(sales) AS max_sales,
MIN(profit) AS min_profit,
AVG(profit) AS avg_profit
FROM orders
GROUP BY region;

/* Note
Interview Question: How to select distinct values in a column without using the distinct kwrd?
Answer: GROUP BY

SELECT DISTINCT region
FROM orders;

--( OR )--

SELECT region
FROM orders
GROUP BY region;

Note 2: Thumb rule for GROUP BY
In SELECT statement, we can use aggregate functions or only those columns which are present in 
GROUP BY statement.

Note 3: Aggregate functions ignores the NULL values.
*/

------------------------ Assignment Day 4 -------------------------
--Q1--
UPDATE orders
SET city=NULL
WHERE order_id IN ('CA-2020-161389','US-2021-156909')

--Q2--
SELECT *
FROM orders
WHERE city IS NULL;

--Q3--
SELECT category, SUM(profit) AS total_profit,
MIN(order_date) AS first_order_date,
MAX(order_date) AS latest_order_date
FROM orders
GROUP BY category;

--Q4--
SELECT sub_category, AVG(profit), MAX(profit)/2
FROM orders
GROUP BY sub_category
HAVING AVG(profit)>MAX(profit)/2;

--Q5--
SELECT student_id,marks 
FROM exams
WHERE subject IN ('Physics','Chemistry')
GROUP BY student_id,marks
HAVING COUNT(*)=2;


--Q6--
SELECT category,COUNT(product_id)
FROM orders
GROUP BY category;

--Q7--
SELECT TOP 5 sub_category,SUM(quantity) AS total_quantity
FROM orders
WHERE region='West'
GROUP BY sub_category
ORDER BY total_quantity DESC;

--Q8--
SELECT region, ship_mode, SUM(sales)
FROM orders
WHERE order_date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY region, ship_mode;

--------------------------------------------------------------
---------------------------JOINS------------------------------

SELECT * FROM returns;

--INNER JOIN--
SELECT o.order_id, r.return_reason
FROM orders o INNER JOIN returns r
ON o.order_id=r.order_id;

--LEFT JOIN--
SELECT r.return_reason, CAST(SUM(sales) AS DECIMAL(10,2)) AS total_sales
FROM orders o 
LEFT JOIN returns r ON o.order_id=r.order_id
WHERE r.return_reason IS NOT NULL
GROUP BY r.return_reason;

SELECT *
FROM employee;

SELECT *
FROM dept

--CROSS JOIN-- Each record of first table is joined to the every record of second table
--Output of CROSS JOIN: (rows of first table)*(rows of second table)

SELECT *
FROM employee,dept;

--(OR)--

SELECT *
FROM employee INNER JOIN dept
ON 1=1;

SELECT *
FROM employee e 
FULL OUTER JOIN dept d
ON e.dept_id=d.dep_id;

CREATE TABLE people
(
manager VARCHAR(20),
region VARCHAR(10)
);

INSERT INTO people 
VALUES ('Ankit','West'), 
('Deepak','East'),
('Vishal','Central'),
('Sanjay','South');

SELECT o.order_id,o.product_id,r.return_reason,p.manager
FROM orders o 
INNER JOIN returns r ON o.order_id=r.order_id
INNER JOIN people p ON p.region=o.region;

SELECT * FROM orders;
SELECT * FROM returns;

---------------------Assignment Day 5---------------------
--Q1--
SELECT region, COUNT(*)
FROM orders o 
INNER JOIN returns r ON o.order_id=r.order_id
GROUP BY region;

--Q2--
SELECT category,SUM(sales)
FROM orders o
LEFT JOIN returns r ON o.order_id=r.order_id
WHERE r.order_id IS NULL
GROUP BY category;

--Q3--
SELECT * FROM employee;
SELECT * FROM dept;

--Q4--
SELECT d.dep_name
FROM employee e 
LEFT JOIN dept d ON d.dep_id=e.dept_id
GROUP BY dep_name
HAVING COUNT(salary)=COUNT(DISTINCT salary);

--Q5--
SELECT o.sub_category
FROM orders o 
LEFT JOIN returns r ON o.order_id=r.order_id
GROUP BY o.sub_category
HAVING COUNT(DISTINCT r.return_reason)=3;

--Q6--
SELECT o.city
FROM orders o 
LEFT JOIN returns r ON o.order_id=r.order_id
GROUP BY o.city
HAVING COUNT(r.return_reason)=0;

--Q7--
SELECT TOP 3 sub_category, SUM(sales)
FROM orders o 
INNER JOIN returns r ON o.order_id=r.order_id
GROUP BY sub_category
ORDER BY SUM(sales) DESC;

--Q8--
SELECT dep_name 
FROM employee e
FULL OUTER JOIN dept d ON e.dept_id=d.dep_id
WHERE emp_name IS NULL;

--(OR)--
SELECT dep_name
FROM dept d
LEFT JOIN employee e ON d.dep_id=e.dept_id
WHERE emp_name IS NULL;

--Q9--
SELECT emp_name
FROM employee e 
FULL OUTER JOIN dept d ON e.dept_id=d.dep_id
WHERE d.dep_id IS NULL;


-----------Amazon Interview Question------------
/* Q. There are two tables, first table have 5 records and second table have 10 records.
You can assume any values in each of the tables. How many maximum and minimum records possible
in case of INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN */

CREATE TABLE temp1
(record1 INT
);
CREATE TABLE temp2
(record2 INT
);

INSERT INTO temp1 VALUES (1),(1),(1),(1),(1)
INSERT INTO temp2 VALUES (2),(2),(2),(2),(2)

SELECT * FROM temp1;
SELECT * FROM temp2;


SELECT *
FROM temp1,temp2

-------------SELF JOIN--------------

SELECT * FROM employee;

---Q: Salary of employees greater than the salary of their manager?

SELECT e1.emp_id,e1.emp_name,e2.emp_name
FROM employee e1
INNER JOIN employee e2 ON e1.manager_id=e2.emp_id
WHERE e1.salary>e2.salary;

SELECT dept_id, STRING_AGG(emp_name,' | ') WITHIN GROUP (ORDER BY emp_name) AS list_of_employee 
FROM employee
GROUP BY dept_id;

--------------------------DATE FUNCTIONS----------------------------

--DATEPART & DATENAME:
SELECT order_id,order_date,DATEPART(YEAR,order_date) AS order_year,
DATEPART(MONTH,order_date) AS order_month,
DATEPART(WEEK,order_date) AS order_week,
DATENAME(MONTH,order_date)
FROM orders;

--DATEADD:
SELECT order_id,order_date,
DATEADD(DAY,5,order_date) AS added_date,
DATEADD(DAY,-10,order_date) AS substracted_date
FROM orders;

--DATEDIFF:
SELECT order_id,order_date,ship_date,
DATEDIFF(DAY,order_date,ship_date) AS days_taken
FROM orders
ORDER BY days_taken DESC;

------------------------------CASE WHEN-----------------------------------
SELECT order_id,profit,
CASE
WHEN profit<0 THEN 'Loss'
WHEN profit<100 AND profit>0 THEN 'Low Profit'
WHEN profit<250 THEN 'Medium Profit'
WHEN profit<400 THEN 'High Profit'
ELSE 'Very High Profit'
END AS profit_category
FROM orders;


--------------------------------Assignment 6-----------------------------------

--Q1--
SELECT e1.emp_name,e2.emp_name,
DATEDIFF(DAY,e1.dob,e2.dob) AS diff_age
FROM employee e1
INNER JOIN employee e2 ON e1.manager_id=e2.emp_id

--Q2--

SELECT o.sub_category
FROM orders o
LEFT JOIN returns r ON o.order_id=r.order_id
WHERE DATEPART(MONTH,order_date)=11
GROUP BY sub_category
HAVING COUNT(r.order_id)=0;


--Q3--
SELECT order_id 
FROM orders
GROUP BY order_id
HAVING COUNT(order_id)=1 

--Q4--
SELECT e2.emp_name,STRING_AGG(e1.emp_name,',') WITHIN GROUP (ORDER BY e1.salary) AS employees
FROM employee e1
INNER JOIN employee e2 ON e1.manager_id=e2.emp_id
GROUP BY e2.emp_name;

--Q5--
SELECT order_date,ship_date,
DATEDIFF(DAY,order_date,ship_date)-2*DATEDIFF(WEEK,order_date,ship_date) AS no_of_business_days
FROM orders
ORDER BY no_of_business_days DESC;

--Q6--

SELECT category, SUM(sales) AS total_sales,
SUM(CASE WHEN r.order_id IS NOT NULL THEN sales END) AS total_sales_returned 
FROM orders o
LEFT JOIN returns r ON o.order_id=r.order_id
GROUP BY category;

--Q7--

SELECT category,
SUM (CASE WHEN DATEPART(YEAR,order_date)=2019 THEN sales END) AS total_sales_2019,
SUM (CASE WHEN DATEPART(YEAR,order_date)=2020 THEN sales END) AS total_sales_2019
FROM orders
GROUP BY category

--Q8--

SELECT TOP 5 city, AVG(DATEDIFF(DAY,order_date,ship_date)) AS avg_days
FROM orders
WHERE region = 'West'
GROUP BY city
ORDER BY avg_days DESC;

--Q9--

SELECT e1.emp_name AS employee_name,
e2.emp_name AS manager_name,
e3.emp_name AS senior_manager_name
FROM employee e1
INNER JOIN employee e2 ON e1.manager_id=e2.emp_id
INNER JOIN employee e3 ON e2.manager_id=e3.emp_id;

------------------------------------STRING FUNCTIONS------------------------------------------
--LEN()
SELECT order_id,LEN(customer_name) AS len_name
FROM orders;

--LEFT()
SELECT order_id,LEFT(customer_name,4) AS left_4
FROM orders;

--RIGHT()

SELECT order_id,RIGHT(customer_name,5) AS right_5
FROM orders;

--SUBSTRING()

SELECT order_id,SUBSTRING(customer_name,4,5) AS substr45
FROM orders;

SELECT SUBSTRING(order_id,4,4) AS order_year
FROM orders;

--CHARINDEX()

SELECT order_id,customer_name,
CHARINDEX('C',customer_name) AS space_position
FROM orders;

--CONCAT()

SELECT order_id,customer_name,
CONCAT(order_id,' ',customer_name) AS added_string
FROM orders;

--OR--


SELECT order_id,customer_name
,order_id+' '+customer_name AS added_string
FROM orders;

--REPLACE()

SELECT order_id,customer_name,
REPLACE(order_id,'CA','PB')
FROM orders;

--TRANSLATE()

SELECT order_id,customer_name,
TRANSLATE(customer_name,'AG','BT')
FROM orders;

--CELING()
--to convert the float value to the nearest rounded value


--REVERSE()

SELECT order_id,customer_name,
REVERSE(customer_name)
FROM orders;

--TRIM()

SELECT TRIM(' Pawan ')

------------------------------------NULL HANDLING FUNCTIONS------------------------------------
--ISNULL()

SELECT order_id,city,ISNULL(city,'unknown') AS new_city
FROM orders;

--COALESCE()

SELECT order_id,city,state,
COALESCE(city,state,region,'Unknown')
FROM orders
ORDER BY city;

--CAST()

SELECT order_id,customer_name,sales,
CAST(sales AS DECIMAL(10,2))
FROM orders;

--ROUND()

SELECT order_id,customer_name,sales,
ROUND(sales,1)
FROM orders;

----------------------------------------SET QUERIES--------------------------------------------

--UNION ALL:

SELECT * FROM orders_east
UNION ALL
SELECT * FROM orders_west;

--UNION:

SELECT * FROM orders_east
UNION
SELECT * FROM orders_west;


--INTERSECT:

SELECT * FROM orders_east
INTERSECT
SELECT * FROM orders_west;

--EXCEPT:
SELECT * FROM orders_east
EXCEPT
SELECT * FROM orders_west;


--Note: Only UNION ALL gives duplicates, others SET OPERATORS gives unique values

------------------------------------Assignment 7-------------------------------------------
SELECT * FROM icc_world_cup;
--Q1--

SELECT team_name,no_of_matches_played,ISNULL(no_of_wins,0) AS wins,
(CASE WHEN (no_of_matches_played)-ISNULL(no_of_wins,0)>0 
THEN (no_of_matches_played)-ISNULL(no_of_wins,0) ELSE 0 END) AS losses
FROM
(SELECT team_name,COUNT(team_name) AS no_of_matches_played
FROM
(SELECT team_1 AS team_name
FROM icc_world_cup
UNION ALL
SELECT team_2 
FROM icc_world_cup) A
GROUP BY team_name) n1
LEFT JOIN
(SELECT winner,COUNT(winner) AS no_of_wins
FROM icc_world_cup
GROUP BY winner) n2
ON n1.team_name=n2.winner;

--(OR)--

SELECT team_name,COUNT(*) AS matches_played,SUM(flag) AS matches_won, COUNT(*)-SUM(flag) AS lost_matches
FROM
(SELECT team_1 AS team_name,
CASE WHEN team_1=winner THEN 1 ELSE 0 END AS flag
FROM icc_world_cup
UNION ALL
SELECT team_2,
CASE WHEN team_2=winner THEN 1 ELSE 0 END AS flag
FROM icc_world_cup) A
GROUP BY team_name;

--OR--

WITH CTE AS
(SELECT team_1 AS team_name,CASE WHEN team_1=winner THEN 1 ELSE 0 END AS flag FROM icc_world_cup
UNION ALL
SELECT team_2, CASE WHEN team_2=winner THEN 1 ELSE 0 END AS flag FROM icc_world_cup)
SELECT team_name,COUNT(*) AS matches_played,SUM(flag) AS matches_won, COUNT(*)-SUM(flag) AS lost_matches
FROM CTE
GROUP BY team_name;

--Q2--
SELECT customer_name,
SUBSTRING(customer_name,1,CHARINDEX(' ',customer_name)) AS first_name,
SUBSTRING(customer_name,(CHARINDEX(' ',customer_name)+1),LEN(customer_name)) AS first_name
FROM orders;

--Q3--
/*
create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');
*/

SELECT COUNT(d1.id) AS rides,COUNT(d2.id) AS profit_rides
FROM drivers d1
LEFT JOIN drivers d2 ON d1.id=d2.id AND d1.end_loc=d2.start_loc AND d1.end_time=d2.start_time
GROUP BY d1.id

--Q4--

SELECT customer_name,
LEN(customer_name)-LEN(REPLACE(customer_name,'n','')) AS no_of_occurances_of_n
FROM orders

--Q5--

SELECT 'category' AS hierachy_type, category AS hierachy_name,
SUM(CASE WHEN region='East' THEN sales END) AS total_sales_east_region,
SUM(CASE WHEN region='West' THEN sales END) AS total_sales_east_region
FROM orders
GROUP BY category
UNION ALL
SELECT 'sub_category', sub_category,
SUM(CASE WHEN region='East' THEN sales END) AS total_sales_east_region,
SUM(CASE WHEN region='West' THEN sales END) AS total_sales_east_region
FROM orders
GROUP BY sub_category
UNION ALL
SELECT 'ship_mode',ship_mode,
SUM(CASE WHEN region='East' THEN sales END) AS total_sales_east_region,
SUM(CASE WHEN region='West' THEN sales END) AS total_sales_east_region
FROM orders
GROUP BY ship_mode;

--Q6--

SELECT SUBSTRING(order_id,1,2) AS country,
COUNT(DISTINCT order_id)
FROM orders
GROUP BY SUBSTRING(order_id,1,2);


----------------------------------------VIEWS-----------------------------------------

CREATE VIEW vw_orders AS
SELECT * FROM orders;


CREATE VIEW orders_summary_vw AS
SELECT 'category' AS hierachy_type, category AS hierachy_name,
SUM(CASE WHEN region='East' THEN sales END) AS total_sales_east_region,
SUM(CASE WHEN region='West' THEN sales END) AS total_sales_west_region
FROM orders
GROUP BY category
UNION ALL
SELECT 'sub_category', sub_category,
SUM(CASE WHEN region='East' THEN sales END) AS total_sales_east_region,
SUM(CASE WHEN region='West' THEN sales END) AS total_sales_west_region
FROM orders
GROUP BY sub_category
UNION ALL
SELECT 'ship_mode',ship_mode,
SUM(CASE WHEN region='East' THEN sales END) AS total_sales_east_region,
SUM(CASE WHEN region='West' THEN sales END) AS total_sales_east_region
FROM orders
GROUP BY ship_mode;


SELECT * 
FROM orders_summary_vw

/*
ADVANTAGES OF VIEW: (It doesn't hold data, runs the original query everytime)
1. To share a big query in a single line.
2. To implement the row level security.
*/

SELECT *
FROM employee;


CREATE TABLE new_data_dept
(
dept_id INT PRIMARY KEY,
dept_name VARCHAR(10),
);

CREATE TABLE new_data_emp
(
emp_id INT PRIMARY KEY,
emp_name VARCHAR(10),
dept_id INT REFERENCES new_data_dept(dept_id),
salary INT
);

--IDENTITY:

CREATE TABLE dept1
(emp_id INT IDENTITY(1,1),
dept_id INT,
dept_name VARCHAR(10)
);

INSERT INTO dept1(dept_id,dept_name) VALUES(200,'IT'),(100,'HR')

SELECT * FROM dept1;


----------------------------------------CTE & Subquery-----------------------------------------

--Subquery:
--Average sale of orders
SELECT AVG(order_sales) AS avg_sales
FROM
(SELECT order_id,SUM(sales) AS order_sales
FROM orders
GROUP BY order_id) A

----Orders having sum of sales greater than avg sales
SELECT order_id
FROM orders
GROUP BY order_id
HAVING SUM(sales)>
(SELECT AVG(order_sales) AS avg_sales
FROM
(SELECT order_id,SUM(sales) AS order_sales
FROM orders
GROUP BY order_id) A)

--Note: Give alias to subqurery only when it is used in SELECT statement.

SELECT *  --OUTER QUERY
FROM employee
WHERE dept_id NOT IN
(SELECT dep_id FROM dept) -- INNER QUERY

--SELECT
--FROM
--WHERE
--HAVING
--JOINS

SELECT A.*,B.* 
FROM
	(SELECT order_id, SUM(sales) AS order_sales 
	FROM orders
	GROUP BY order_id) A
INNER JOIN
	(SELECT AVG(order_sales) AS avg_sales
	FROM
	(SELECT order_id, SUM(sales) AS order_sales 
	FROM orders
	GROUP BY order_id) orders_agg) B
ON 1=1
WHERE order_sales>avg_sales;

SELECT A.*,B.avg_salary
FROM
(SELECT * FROM employee) A
INNER JOIN
(SELECT dept_id, AVG(salary) AS avg_salary
FROM employee
GROUP BY dept_id) B 
ON A.dept_id=B.dept_id

SELECT team_1 
FROM icc_world_cup
UNION
SELECT team_2 
FROM icc_world_cup;

SELECT team_name,no_of_matches_played,ISNULL(no_of_wins,0) AS wins,
(CASE WHEN (no_of_matches_played)-ISNULL(no_of_wins,0)>0 
THEN (no_of_matches_played)-ISNULL(no_of_wins,0) ELSE 0 END) AS losses
FROM
(SELECT team_name,COUNT(team_name) AS no_of_matches_played
FROM
(SELECT team_1 AS team_name
FROM icc_world_cup
UNION ALL
SELECT team_2 
FROM icc_world_cup) A
GROUP BY team_name) n1
LEFT JOIN
(SELECT winner,COUNT(winner) AS no_of_wins
FROM icc_world_cup
GROUP BY winner) n2
ON n1.team_name=n2.winner;


SELECT team_name,COUNT(*) AS matches_played,SUM(flag) AS matches_won, COUNT(*)-SUM(flag) AS lost_matches
FROM
(SELECT team_1 AS team_name,
CASE WHEN team_1=winner THEN 1 ELSE 0 END AS flag
FROM icc_world_cup
UNION ALL
SELECT team_2,
CASE WHEN team_2=winner THEN 1 ELSE 0 END AS flag
FROM icc_world_cup) A
GROUP BY team_name;

--COMMAN TABLE EXPRESSIONS (CTE):

WITH CTE AS
(SELECT team_1 AS team_name,CASE WHEN team_1=winner THEN 1 ELSE 0 END AS flag FROM icc_world_cup
UNION ALL
SELECT team_2, CASE WHEN team_2=winner THEN 1 ELSE 0 END AS flag FROM icc_world_cup)
SELECT team_name,COUNT(*) AS matches_played,SUM(flag) AS matches_won, COUNT(*)-SUM(flag) AS lost_matches
FROM CTE
GROUP BY team_name;


-------------------------------------------RECURSIVE CTE-----------------------------------------
--Recursive CTE runs in loop
--Default maximum recursion is 100, can be changed
--OPTION (MAXRECURSION 1000)


WITH cte_numbers
AS (
    SELECT 1 AS num             --anchor query

	UNION ALL

	SELECT num+1                --recursive query
	FROM cte_numbers
	WHERE num<6                 --filter to stop recursion
	)
SELECT num 
FROM cte_numbers;


CREATE TABLE products
(
product_id INT,
period_start DATE,
period_end DATE,
average_daily_sales INT
);


SELECT * FROM products;

WITH r_cte AS (
SELECT MIN(period_start) AS dates, MAX(period_end) AS max_date FROM products
UNION ALL
SELECT DATEADD(DAY,1,dates) as dates,max_date FROM r_cte
WHERE dates<max_date
)
SELECT product_id,YEAR(dates) AS report_year, SUM(average_daily_sales) as amount FROM r_cte
INNER JOIN products ON dates BETWEEN period_start AND period_end
GROUP BY product_id,YEAR(dates)
ORDER BY product_id,YEAR(dates)
OPTION (MAXRECURSION 1000);

------------------------------------------Assignment 9---------------------------------------------
--Q1--
WITH CTE AS
(SELECT customer_id,COUNT(DISTINCT order_id) AS no_of_orders
FROM orders
GROUP BY customer_id)
SELECT *
FROM CTE
WHERE no_of_orders > (SELECT AVG(no_of_orders) FROM CTE)

--Q2--

WITH CTE1 
AS 
(SELECT dept_id, AVG(salary) AS avg_salary
FROM employee
GROUP BY dept_id)
SELECT emp_id,emp_name
FROM employee e
INNER JOIN CTE1 ON e.dept_id=CTE1.dept_id
WHERE salary > avg_salary;


--Q3--
WITH CTE1 AS 
(SELECT AVG(emp_age) AS avg_age
FROM employee)
SELECT emp_name,emp_id
FROM employee e
INNER JOIN CTE1 ON 1=1
WHERE emp_age > avg_age;

--Q4--
WITH CTE1 AS 
(
SELECT dept_id, MAX(salary) AS max_salary
FROM employee
GROUP BY dept_id
)
SELECT emp_name,salary,CTE1.dept_id
FROM CTE1 
INNER JOIN employee e ON e.dept_id = CTE1.dept_id
WHERE salary = max_salary;

--Q5--
WITH CTE1 AS 
(
SELECT MAX(salary) AS max_salary
FROM employee
)
SELECT emp_name,salary,dept_id
FROM employee e 
INNER JOIN CTE1 ON 1=1
WHERE salary=max_salary;

--Q6--
WITH CTE AS
(SELECT category, product_id, SUM(sales) AS total_sales
FROM orders
GROUP BY product_id,category)
SELECT *
FROM CTE
ORDER BY total_sales DESC;

------------------------------------------WINDOW FUNCTIONS------------------------------------------

SELECT *
,ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rn
,RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rnk
,DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS new_rnk
FROM employee;

WITH CTE1 AS (
SELECT category, product_id, SUM(sales) AS sum_of_sales
FROM orders
GROUP BY category,product_id),
CTE2 AS (SELECT *
,DENSE_RANK() OVER(PARTITION BY category ORDER BY sum_of_sales) AS rnk
FROM CTE1)
SELECT * 
FROM CTE2
WHERE rnk<=5;

WITH rnk_sales AS (
SELECT category,product_id
,DENSE_RANK() OVER(PARTITION BY category ORDER BY SUM(sales) DESC) AS rnk
FROM orders
GROUP BY category,product_id
)
SELECT * 
FROM rnk_sales
WHERE rnk<=2;


--LEAD(column,step_size,default_value) 
--default_value can be a column

SELECT *
,LEAD(salary,1,0) OVER(PARTITION BY dept_id ORDER BY salary DESC) AS lead_salary
,LAG(salary,1) OVER(PARTITION BY dept_id ORDER BY salary DESC) AS lag_salary
FROM employee;


WITH CTE1 AS(
SELECT *
,DATEPART(YEAR, order_date) AS yr
FROM orders),
CTE2 AS(
SELECT yr, SUM(sales) AS sum_of_sales
FROM CTE1
GROUP BY yr),
CTE3 AS (
SELECT *
,LAG(sum_of_sales,1,sum_of_sales) OVER(ORDER BY yr) AS previous_year_sale
FROM CTE2)
SELECT *,
ROUND(100*(sum_of_sales-previous_year_sale)/previous_year_sale,2)
FROM CTE3;

SELECT *
,AVG(salary) OVER(PARTITION BY dept_id) AS avg_salary
,MAX(salary) OVER(PARTITION BY dept_id) AS max_salary
,SUM(salary) OVER(PARTITION BY dept_id ORDER BY emp_id ASC) AS running_salary -- RUNNING SUM
FROM employee;

--Rolling SUM:
SELECT *
,SUM(salary) OVER (ORDER BY emp_id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_sum
,SUM(salary) OVER (ORDER BY emp_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rolling_sum
FROM employee;

--FIRST_VALUE & LAST VALUE:
SELECT *
,FIRST_VALUE(salary) OVER(ORDER BY salary) AS first_salary
,LAST_VALUE(salary) OVER(ORDER BY salary ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) 
AS last_salary
FROM employee

WITH month_wise_sales AS (
SELECT DATEPART(YEAR,order_date) AS order_year
,DATEPART(MONTH,order_date) AS order_month, SUM(sales) AS total_sales
FROM orders
GROUP BY DATEPART(YEAR,order_date),DATEPART(MONTH,order_date))
SELECT *,
SUM(total_sales) OVER(ORDER BY order_year,order_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) 
AS agg_sales
FROM month_wise_sales


-------------------------------------------Assignment 10------------------------------------------
--Q1.

WITH CTE AS (
SELECT *,
DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC,emp_age) AS rnk,
COUNT(*) OVER(PARTITION BY dept_id) as no_of_emp
FROM employee)
SELECT *
FROM CTE
WHERE rnk=3 OR (rnk=1 AND no_of_emp<3);



--Q2. Write a query to find top 3 and bottom 3 products by sales in each region.

WITH product_sales AS(
SELECT region
,product_id
,SUM(sales) AS total_sales
FROM orders
GROUP BY region,product_id),
ranking AS (
SELECT *
,DENSE_RANK() OVER(PARTITION BY region ORDER BY total_sales DESC) AS top_rank
,DENSE_RANK() OVER(PARTITION BY region ORDER BY total_sales) AS bottom_rank
FROM product_sales)
SELECT region,product_id,total_sales
,CASE WHEN top_rank<=3 THEN 'TOP 3' ELSE 'BOTTOM 3' END AS top_bottom
FROM ranking
WHERE top_rank<=3 OR bottom_rank<=3
ORDER BY top_bottom DESC;
                                                   
--Q3. Among all the sub categories..which sub category had highest month over month growth by 
--sales in Jan 2020

WITH current_sales AS (
SELECT sub_category,FORMAT(order_date,'yyyyMM') AS year_month
,SUM(sales) AS cur_sales
FROM orders 
GROUP BY sub_category,FORMAT(order_date,'yyyyMM')),
previous_sales AS (
SELECT sub_category, year_month, cur_sales,
LAG(cur_sales) OVER(PARTITION BY sub_category ORDER BY year_month) AS pvs_sales
FROM current_sales)
SELECT TOP 1 *
, (cur_sales-pvs_sales)/pvs_sales AS growth
FROM previous_sales
WHERE year_month=202001
ORDER BY growth DESC;


--Q4. write a query to print top 3 products in each category by year over year sales growth in 
--year 2020.

WITH current_sales AS (
SELECT category,product_id
,DATEPART(YEAR, order_date) AS year_order
,SUM(sales) AS cur_sales
FROM orders
GROUP BY category, product_id,DATEPART(YEAR, order_date)),
previous_sales AS (
SELECT *,
LAG(cur_sales) OVER(PARTITION BY category,product_id ORDER BY year_order) AS pvs_sales
FROM current_sales),
growth AS (
SELECT *,
(cur_sales-pvs_sales)/pvs_sales AS yoy_growth
FROM previous_sales
WHERE year_order=2020),
ranking AS (
SELECT *,
DENSE_RANK() OVER(PARTITION BY category ORDER BY yoy_growth DESC) AS rnk
FROM growth)
SELECT * FROM
ranking
WHERE rnk<=3;


--Q5. write a query to get start time and end time of each call from above 2 tables.Also 
--create a column of call duration in minutes.  Please do take into account that there will 
--be multiple calls from one phone number and each entry in start table has a corresponding 
--entry in end table.
WITH CTE1 AS (
SELECT *
,ROW_NUMBER() OVER(ORDER BY phone_number) AS rn1
FROM call_start_logs),
CTE2 AS (
SELECT *
,ROW_NUMBER() OVER(ORDER BY phone_number) AS rn2
FROM call_end_logs)
SELECT CTE1.phone_number
,CTE1.start_time,CTE2.end_time, DATEDIFF(MINUTE,start_time,end_time) AS call_duration
FROM CTE1
INNER JOIN CTE2 ON CTE1.rn1=CTE2.rn2;



-------------------------------------STORED PROCEDURES-----------------------------------
CREATE PROCEDURE spemp 
AS 
SELECT * FROM employee;

EXECUTE spemp;

ALTER PROCEDURE spemp (@salary INT,@dept_id INT) 
AS 
SELECT * FROM employee WHERE salary>@salary AND dept_id=@dept_id;

EXECUTE spemp @salary=10000, @dept_id=100;


ALTER PROCEDURE spemp (@dept_id INT, @cnt2 INT OUT) 
AS 
DECLARE @cnt INT
SELECT @cnt=COUNT(1) FROM employee WHERE dept_id=@dept_id
IF @cnt=0
PRINT('THERE IS NO EMPLOYEE IN THIS DEPT')
ELSE PRINT 'Total Count of employees is ' + CAST(@cnt AS VARCHAR(10))
;

DECLARE @cnt1 INT
EXECUTE spemp 100, @cnt1 OUT
PRINT @cnt1;

-----------FUNCTIONS--------------
CREATE FUNCTION fnproduct (@a INT, @b INT)
RETURNS INT
AS
BEGIN
RETURN (SELECT @a * @b)
END

SELECT [dbo].[fnproduct](10,5)


---PIVOT & UNPIVOT--
SELECT category
,SUM(CASE WHEN DATEPART(YEAR,order_date)=2020 THEN sales END) AS sales_2020
,SUM(CASE WHEN DATEPART(YEAR,order_date)=2021 THEN sales END) AS sales_2021
FROM orders
GROUP BY category

SELECT * FROM
(SELECT category, DATEPART(YEAR,order_date) AS yod, sales
FROM orders) AS t1
PIVOT (
SUM(sales) FOR yod IN ([2020],[2021])
) AS t2

SELECT * FROM
(SELECT category, region, sales
FROM orders) t1
PIVOT (
SUM(sales) FOR region IN (West,East)
) t2

SELECT * INTO sales_yearwise FROM
(SELECT category, region, sales
FROM orders) t1
PIVOT (
SUM(sales) FOR region IN (West,East)
) t2

SELECT * FROM sales_yearwise


------------------------------------Assignment 11-------------------------------------------

--Q1. write a sql to find top 3 products in each category by highest rolling 3 months total 
--sales for Jan 2020.

WITH CTE AS (
SELECT category, product_id
,DATEPART(YEAR,order_date) AS yr
,DATEPART(MONTH,order_date) AS mnth
,SUM(sales) AS product_sales
FROM orders
GROUP BY category, product_id, DATEPART(YEAR,order_date), DATEPART(MONTH,order_date)),
rolling_data AS (
SELECT *,
SUM(product_sales) OVER(PARTITION BY category,product_id ORDER BY yr,mnth ROWS BETWEEN 2 
PRECEDING AND CURRENT ROW) AS rolling_sales
FROM CTE),
filtered_data AS (
SELECT *,
DENSE_RANK() OVER(PARTITION BY category ORDER BY rolling_sales DESC) AS rnk
FROM rolling_data
WHERE yr=2020 AND mnth=1)
SELECT *
FROM filtered_data
WHERE rnk<=3

--Q2. write a query to find products for which month over month sales has never declined.

WITH agg_data AS (
SELECT product_id,SUM(sales) AS sales
,DATEPART(YEAR,order_date) AS yr
,DATEPART(MONTH,order_date) AS mnth
FROM orders
GROUP BY product_id,DATEPART(YEAR,order_date),DATEPART(MONTH,order_date)),
pvs_data AS (
SELECT *
,LAG(sales,1) OVER(PARTITION BY product_id ORDER BY yr,mnth) AS pvs_sales
FROM agg_data)
SELECT DISTINCT product_id
FROM pvs_data
WHERE product_id NOT IN (SELECT product_id FROM pvs_data WHERE sales<pvs_sales GROUP BY product_id)


--Q3. write a query to find month wise sales for each category for months where sales is more 
--than the combined sales of previous 2 months for that category.
WITH monthly_sales AS (
SELECT category 
,DATEPART(YEAR,order_date) AS yr
,DATEPART(MONTH,order_date) AS mnth
,SUM(sales) AS sales
FROM orders
GROUP BY category, DATEPART(YEAR,order_date),DATEPART(MONTH,order_date)),
combined_sales AS (
SELECT *
,SUM(sales) OVER(PARTITION BY category ORDER BY yr,mnth ROWS BETWEEN 2 PRECEDING AND 
1 PRECEDING) AS pvs_sales
FROM monthly_sales)
SELECT *
FROM combined_sales
WHERE sales>pvs_sales;

------------------------------CLUSTERED & NON-CLUSTERED INDEX---------------------------------
--Note: PRIMARY KEY itself is a clustered index by default

CREATE TABLE emp_new 
(
emp_id INT,
emp_name VARCHAR(20),
salary INT
)

INSERT INTO emp_new VALUES(7,'Pawan',700)


CREATE CLUSTERED INDEX new_indx1 ON emp_new(emp_id)

EXECUTE sp_helpindex emp_new

SELECT *
FROM emp_new WHERE emp_id<=3

CREATE NONCLUSTERED INDEX index1 ON emp_new(emp_id) INCLUDE(emp_name)

--Note:To avoid duplicate rows in databases we can create unique index as below:
CREATE UNIQUE NONCLUSTERED INDEX index_name ON table_name(column_name)

--Interview Question: How to delete duplicates from a table?
--Sol 1 (useful when the complete row is duplicate/pure duplicate)

SELECT DISTINCT * INTO emp_new_back FROM emp_new

SELECT * FROM emp_new_back

TRUNCATE TABLE emp_new 

INSERT INTO emp_new SELECT * FROM emp_new_back 

--Sol 2 (useful when the complete row is not duplicate/pure duplicate)

DELETE emp_new
FROM emp_new e1
LEFT JOIN (SELECT emp_id,MAX(salary) AS max_salary FROM emp_new GROUP BY emp_id) e2
ON e1.emp_id=e2.emp_id AND salary=max_salary
WHERE e2.emp_id IS NULL;


----------------------------------------CASE STUDY 1----------------------------------------

--1- write a query to print top 5 cities with highest spends and their percentage contribution 
--of total credit card spends 
WITH CTE1 AS (
SELECT city,
SUM(amount) AS spend
FROM credit_card_transactions
GROUP BY city),
CTE2 AS (
SELECT SUM(CAST(amount AS bigint)) AS total_spend
FROM credit_card_transactions)
SELECT TOP 5 city,spend
,ROUND(100.0*spend/total_spend,2) AS percent_spend 
FROM CTE1 INNER JOIN CTE2
ON 1=1
ORDER BY percent_spend DESC;


--2- write a query to print highest spend month and amount spent in that month for each card 
--type
WITH total_spend AS (
SELECT card_type
,SUM(amount) AS amount_spend
,DATEPART(MONTH,transaction_date) AS highest_spend_month
,DATEPART(YEAR,transaction_date) AS yr
FROM credit_card_transactions
GROUP BY card_type,DATEPART(YEAR,transaction_date),DATEPART(MONTH,transaction_date))
SELECT card_type,yr,highest_spend_month,amount_spend
FROM (SELECT *
,DENSE_RANK() OVER(PARTITION BY card_type ORDER BY amount_spend DESC) AS ranking
FROM total_spend)a
WHERE ranking=1

--3- write a query to print the transaction details(all columns from the table) for each 
--card type when it reaches a cumulative of 1000000 total spends(We should have 4 rows in 
--the o/p one for each card type)
WITH agg_data AS (
SELECT * 
,SUM(amount) OVER(PARTITION BY card_type ORDER BY transaction_date,transaction_id) AS rolling_sum
FROM credit_card_transactions)
SELECT *
FROM ( SELECT *,DENSE_RANK() OVER(PARTITION BY card_type ORDER BY rolling_sum) AS ranking
FROM agg_data WHERE rolling_sum>1000000) a
WHERE ranking=1;

--4- write a query to find city which had lowest percentage spend for gold card type

WITH agg_data AS (
SELECT city,card_type
,SUM(amount) AS total_amount
,SUM(CASE WHEN card_type='Gold' THEN amount END) AS gold_amount
FROM credit_card_transactions
GROUP BY city,card_type)
SELECT TOP 1 city, SUM(gold_amount)*1.0/SUM(total_amount) AS ratio
FROM agg_data
GROUP BY city
HAVING COUNT(gold_amount)>0
ORDER BY ratio

--5- write a query to print 3 columns:  city, highest_expense_type , lowest_expense_type 
--(example format : Delhi , bills, Fuel)

WITH agg_data AS (
SELECT city,exp_type,SUM(amount) AS amount
FROM credit_card_transactions
GROUP BY city,exp_type),
rank_data AS (
SELECT *
,DENSE_RANK() OVER(PARTITION BY city ORDER BY amount DESC) AS rank1
,DENSE_RANK() OVER(PARTITION BY city ORDER BY amount) AS rank2
FROM agg_data)
SELECT city
,MAX(CASE WHEN rank1=1 THEN exp_type END) AS high_expense_type 
,MIN(CASE WHEN rank2=1 THEN exp_type END) AS lowest_expense_type
FROM rank_data
GROUP BY city;

--6- write a query to find percentage contribution of spends by females for each expense 
--type
WITH agg_data AS (
SELECT exp_type
,SUM(CASE WHEN gender='M' THEN amount END) AS females_spend
,SUM(amount) AS total_spend
FROM credit_card_transactions
GROUP BY exp_type)
SELECT *
,100.0*(total_spend-females_spend)/total_spend AS females_spend_percentage
FROM agg_data
ORDER BY females_spend_percentage DESC;

--7- which card and expense type combination saw highest month over month growth in 
--Jan-2014

WITH agg_data AS (
SELECT card_type,exp_type,SUM(amount) AS amount,DATEPART(YEAR,transaction_date) AS yr
,DATEPART(MONTH,transaction_date) AS mnth
FROM credit_card_transactions
GROUP BY card_type,exp_type,DATEPART(YEAR,transaction_date),DATEPART(MONTH,transaction_date)),
rolling_data AS (
SELECT *
,LAG(amount,1) OVER(PARTITION BY card_type,exp_type ORDER BY yr,mnth) AS pvs_amount
FROM agg_data)
SELECT TOP 1 *,
(amount-pvs_amount) AS mom_growth
FROM rolling_data
WHERE pvs_amount IS NOT NULL AND yr=2014 AND mnth=1
ORDER BY mom_growth DESC;

--8--during weekends which city has highest total spend to total no of transcations ratio 
SELECT TOP 1 city,sum(amount)*1.0/count(1) AS spend
FROM credit_card_transactions
WHERE DATENAME(WEEKDAY,transaction_date) IN ('Saturday','Sunday')
GROUP BY city
ORDER BY spend DESC;


--9--which city took least number of days to reach its 500th transaction after the first 
--transaction in that city

WITH CTE1 AS (
SELECT *
,ROW_NUMBER() OVER(PARTITION BY city ORDER BY transaction_date,transaction_id) AS ranking
FROM credit_card_transactions)
SELECT TOP 1 city
,DATEDIFF(DAY,MIN(transaction_date),MAX(transaction_date)) AS days_req
FROM CTE1
WHERE ranking IN (1,500)
GROUP BY city
HAVING COUNT(city)=2
ORDER BY days_req





































