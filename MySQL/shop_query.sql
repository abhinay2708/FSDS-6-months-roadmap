CREATE DATABASE shop;
USE shop;

CREATE TABLE salesman(
salesman_id INT PRIMARY KEY,
name VARCHAR(50),
city VARCHAR(50),
commission FLOAT
);
DESC salesman;
INSERT INTO salesman
(salesman_id,name,city,commission)
values
(5001,'James Hooq','New York',0.15),
(5002,'Nail Knite','Paris',0.13),
(5005,'Pit Alex','London',0.11),
(5006,'Mc Lyon','Paris',0.14),
(5003,'Lauson Hen','',0.12),
(5007,'Paul Adam','Rome',0.13);

SELECT * FROM salesman;
-----------------------------------------------
CREATE TABLE customer(
customer_id INT PRIMARY KEY,
customer_name VARCHAR(50),
city VARCHAR(50),
grade INT,
salesman_id INT);
DESC customer;
INSERT INTO customer
(customer_id,customer_name,city,grade,salesman_id)
values
(3002,'Nick Rimando','New York',100,5001),
(3005,'Graham Zusi','Caifornia',200,5002),
(3001,'Brad Guzan','London',NULL,NULL),
(3004,'Fabian Johns','Paris',300,5006),
(3007,'Brad Davis','New York',200,5001),
(3009,'Geoff Camero','Berlin',100,NULL),
(3008,'Julian Green','London',300,5002),
(3003,'Jozy Altidor','Moncow',200,5007);
SELECT * FROM customer;
-----------------------------------------------
CREATE TABLE orders(
order_no INT PRIMARY KEY,
purch_amt FLOAT,
order_date DATE,
customer_id INT,
salesman_id INT);
DESC orders;
INSERT INTO orders
(order_no,purch_amt,order_date,customer_id,salesman_id)
VALUES
(70001,150.5,'2016-10-05',3005,5002),
(70009,270.65,'2016-09-10',3001,NULL),
(70002,65.26,'2016-10-05',3002,5001),
(70004,110.5,'2016-08-17',3009,NULL),
(70007,948.5,'2016-09-10',3005,5002),
(70005,2400.6,'2016-07-27',3007,5001),
(70008,5760,'2016-09-10',3002,5001),
(70010,1983.43,'2016-10-10',3004,5006),
(70003,2480.4,'2016-10-10',3009,NULL),
(70012,250.45,'2016-06-27',3008,5002),
(70011,75.29,'2016-08-17',3003,5007);
SELECT * FROM orders;
---------------------------------------------------------------
-- Query 1
-- Display name and commission for all the salesman
SELECT name,commission FROM salesman;

-- Query 2
-- Retrieve salesman id of all salesmen from orders table without any repeats
SELECT DISTINCT salesman_id FROM orders;

-- Query 3
-- Display names and city of salesman, who belongs to the city of Paris
SELECT name,city FROM salesman where city='Paris';

-- Query 4
-- Display all the information for those customers with a grade of 200
SELECT * FROM customer WHERE grade=200;

-- Query 5 
-- Display the order number, order date and the purchase amount for order(s) which will be delivered by the salesman with ID 5001.
SELECT order_no,order_date,purch_amt FROM orders WHERE salesman_id=5001;

-- Query 6
-- Display all the customers, who are either belongs to the city New York or not had a grade above 100
SELECT * FROM customer WHERE city ='New York' OR NOT grade>100;

-- Query 7
-- Find those salesmen with all information who gets the commission within a range of 0.12 and 0.14
SELECT * FROM salesman WHERE commission BETWEEN 0.12 AND 0.14;

-- Query 8
-- Find all those customers with all information whose names are ending with the letter 'n'
SELECT * FROM customer WHERE customer_name LIKE('%n');

-- Query 9
-- Find those salesmen with all information whose name containing the 1st character is 'N' and the 4th character is 'l' and rests may be any character.
SELECT * FROM salesman WHERE name LIKE('N__l%');

-- Query 10
-- Find that customer with all information who does not get any grade except NULL
SELECT * FROM customer WHERE grade is NULL;

-- Query 11
-- Find the total purchase amount of all orders
SELECT SUM(purch_amt) FROM orders;

-- Query 12
-- Find the number of salesman currently listing for all of their customers.
SELECT COUNT(DISTINCT salesman_id) FROM orders;

-- Query 13
-- Find the highest grade for each of the cities of the customers
SELECT city,MAX(grade) FROM customer GROUP BY city;

-- Query 14 
-- Find the highest purchase amount ordered by the each customer with their ID and highest purchase amount
SELECT customer_id,MAX(purch_amt) FROM orders GROUP BY customer_id;

-- Query 15
-- Find the highest purchase amount ordered by the each customer on a particular date with their ID, order date and highest purchase amount.
SELECT customer_id,order_date,MAX(purch_amt) FROM orders GROUP BY customer_id,order_date;

-- Query 16
-- Find the highest purchase amount on a date '2016-08-17' for each salesman with their ID.
SELECT salesman_id,MAX(purch_amt) FROM orders WHERE order_date='2016-08-17' GROUP BY salesman_id;

-- Query 17
-- Find the highest purchase amount with their customer ID and order date, for only those customers who have the highest purchase amount in a day is more than 2000.
SELECT customer_id,order_date,MAX(purch_amt) FROM orders GROUP BY customer_id,order_date HAVING MAX(purch_amt>2000);

-- Query 18
-- Write a SQL statement that counts all orders for a date August 17th, 2016
SELECT COUNT(order_date) FROM orders WHERE order_date='2016-08-17';

-- Query 19
-- Find the name and city of those customers and salesmen who lives in the same city.
SELECT s.name,c.customer_name,s.city FROM salesman as s,customer as c WHERE s.city=c.city;
SELECT c.customer_name,s.name,c.city FROM customer as c,salesman as s WHERE c.city=s.city;

-- Query 20 
--  Find the names of all customers along with the salesmen who works for them.
SELECT c.customer_name,salesman.name,c.salesman_id FROM customer as c,salesman WHERE c.salesman_id=salesman.salesman_id;

-- Query 21
-- Display all those orders by the customers not located in the same cities where their salesmen live.
SELECT order_no,customer_name,orders.customer_id,orders.salesman_id FROM orders,customer,salesman
 WHERE customer.city<>salesman.city AND orders.customer_id=customer.customer_id AND orders.salesman_id=salesman.salesman_id;
 
 -- Query 22
 --  Display all the orders issued by the salesman 'Paul Adam' from the orders table.
 SELECT * FROM orders WHERE salesman_id=(SELECT salesman_id FROM salesman WHERE name='Paul Adam');
 
 -- Query 23
 --  Display all the orders which values are greater than the average order value for 10th October 2016.
 SELECT * FROM orders WHERE purch_amt>(SELECT AVG(purch_amt) FROM orders WHERE order_date='2016-10-10');
 
 -- Query 24
 -- Find all orders attributed to salesmen in Paris.
 SELECT * FROM orders WHERE salesman_id IN (SELECT salesman_id FROM salesman WHERE city='Paris');
 
 -- Query 25
 --  Extract the data from the orders table for the salesman who earned the maximum commission.
 SELECT * FROM orders WHERE salesman_id IN (SELECT salesman_id FROM salesman WHERE commission=(SELECT MAX(commission) FROM salesman));
 
 -- Query 26
 --  Find the name and ids of all salesmen who had more than one customer.
 SELECT name, salesman_id FROM salesman WHERE salesman_id IN (SELECT salesman_id FROM customer GROUP BY salesman_id HAVING COUNT(DISTINCT(customer_id)>1));
 
 -- Query 27
 -- Write a query to find all the salesmen who worked for only one customer (Using subquery).
 SELECT * FROM salesman WHERE salesman_id IN (SELECT DISTINCT salesman_id FROM customer a WHERE NOT EXISTS (SELECT * FROM customer b WHERE a.salesman_id=b.salesman_id AND a.customer_name<>b.customer_name));
 
 -- Query 28
 -- Write a query to find all the salesmen who worked for only one customer (Equivalent Queries).
 SELECT c.salesman_id, s.name, s.city, s.commission FROM salesman s, customer c WHERE s.salesman_id=c.salesman_id GROUP BY c.salesman_id, s.name HAVING COUNT(c.salesman_id)=1;
 
 -- QUERY 29
 --  Display all the orders that had amounts that were greater than at least one of the orders from September 10th 2012.
 SELECT * FROM Orders WHERE purch_amt > ANY (SELECT purch_amt FROM orders WHERE order_date = '2016-09-10');
 
 -- Query 30
 -- Display only those customers whose grade are, in fact, higher than every customer in New York.
 SELECT * FROM customer WHERE grade > ALL(SELECT grade FROM customer WHERE city = 'NewYork');