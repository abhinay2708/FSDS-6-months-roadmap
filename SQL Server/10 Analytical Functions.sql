USE db7am

-- Analytical Function/ Window Function

-- RANK()--To find ranks
-- DENSE_RANK--to find ranks

-- Display ranks of the employees based on sal highest paid employee should get 1st rank ?
SELECT ENAME, SAL, RANK()OVER(ORDER BY SAL DESC) as rnk FROM employee

-- Display ranks of the employees based on sal highest paid employee should get 1st rank ?
SELECT ENAME, SAL, DENSE_RANK()OVER(ORDER BY SAL DESC) as rnk FROM employee

-- Find ranks of the employees based on sal if salaries are same then ranking should be based on hiredate ?
SELECT ENAME, SAL,HIREDATE, RANK()OVER(ORDER BY SAL DESC, HIREDATE ASC) as rnk FROM employee

-- find ranks with in dept first divide the table dept wise using partition by clause and apply rank/dense_rank functions on each dept.
SELECT ENAME, SAL, HIREDATE,DEPTNO, DENSE_RANK()OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) as rnk FROM employee

-- CTE(COMMON TABLE EXPRESSION)

-- Display top 3 max salary using top clause?
SELECT TOP 3 SAL FROM employee

-- Display top 3 max salaries ?
WITH E AS
(SELECT ENAME, SAL, HIREDATE, DEPTNO, RANK()OVER(ORDER BY SAL DESC) as rnk FROM employee)
SELECT SAL FROM E WHERE rnk<=3

-- Display 5th max salary?
WITH E AS 
(SELECT ENAME, SAL, DENSE_RANK()OVER(ORDER BY SAL DESC) as rnk FROM employee)
SELECT SAL FROM E WHERE rnk=5

-- ROW_NUMBER()-- Used to see the row number, here the data must be sorted.

-- Row number based on salary.
SELECT ENAME, SAL, ROW_NUMBER()OVER(ORDER BY SAL DESC) as rno FROM employee

-- Display the row number based on the table order.
SELECT ENAME, SAL, ROW_NUMBER()OVER(ORDER BY EMPNO ASC) as rno FROM employee

-- LAG()-- Return previous row value.If unavialable then return NULL.
-- to see the prevoius salary
SELECT EMPNO, ENAME, SAL, LAG(SAL,1)OVER(ORDER BY EMPNO ASC) AS PREV FROM employee

--- 

 CREATE TABLE population
   (  
     year   INT,
     population  NUMERIC
  )

 INSERT INTO population 
 VALUES
    (2020,1328024498),
    (2021,1402617695), 
    (2022,1425423212), 
    (2023,1438069596),
    (2024,1450935791)

SELECT * FROM  population

-- Display year, population, growth.
WITH E AS
(
SELECT year, population, LAG(population,1)OVER(ORDER BY year ASC) as prev,
(population-LAG(population,1)OVER(ORDER BY year ASC)) AS growth
FROM population
)
SELECT year, population, growth, CAST((growth /prev)*100 AS DECIMAL(4,1)) AS perct FROM E

------------------------------
 CREATE TABLE sales
 (
    id  int  ,
    sdate  date,
    amt     money
  )

 insert into sales values(1,'2025-01-5',1000)
 insert into sales values(2,'2025-01-6',800)
 insert into sales values(3,'2025-01-10',2000)
 insert into sales values(4,'2025-01-11',500)
 insert into sales values(5,'2025-01-15',3000)
 insert into sales values(6,'2025-01-16',1000)
 insert into sales values(7,'2025-01-17',2000)
 insert into sales values(8,'2025-01-23',5000)

SELECT * FROM sales

-- find dates where no sales in consecutive 3 days ?
WITH E AS(
SELECT id, amt, sdate, LAG(sdate,1)OVER(ORDER BY id ASC) AS prev FROM sales
)
SELECT id, amt, sdate FROM E
WHERE DAY(sdate)-DAY(prev) >=3  --- or we can use DATEDIFF(DD, prev, sdate)>=3
