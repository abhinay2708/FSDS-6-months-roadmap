use db7am

SELECT * FROM employee WHERE SAL>(SELECT SAL FROM employee WHERE ENAME='BLAKE')

SELECT * FROM EMPLOYEE WHERE HIREDATE<(SELECT HIREDATE FROM EMPLOYEE WHERE ENAME='KING')

SELECT ENAME  FROM EMPLOYEE WHERE SAL= (SELECT MAX(SAL) FROM EMPLOYEE)

----- display employee name having max and min salary.-----------------######
SELECT ENAME, HIREDATE, DATEDIFF(YY, HIREDATE, GETDATE()) AS EXPERIENCE
FROM EMPLOYEE WHERE HIREDATE= (SELECT MIN(HIREDATE) FROM EMPLOYEE)
UNION
SELECT ENAME, HIREDATE, DATEDIFF(YY, HIREDATE, GETDATE()) AS EXPERIENCE
FROM EMPLOYEE WHERE HIREDATE= (SELECT MAX(HIREDATE) FROM EMPLOYEE)
--------------------------------------------------------------------------
SELECT ENAME, HIREDATE, DATEDIFF(YY, HIREDATE, GETDATE()) AS EXPERIENCE
FROM EMPLOYEE WHERE HIREDATE IN  ((SELECT MIN(HIREDATE) FROM EMPLOYEE),
								 (SELECT MAX(HIREDATE) FROM EMPLOYEE))
--------------------------------------------------------------------------------
SELECT ENAME, HIREDATE, DATEDIFF(YY, HIREDATE, GETDATE()) AS EXPERIENCE
FROM EMPLOYEE WHERE HIREDATE= (SELECT MIN(HIREDATE) FROM EMPLOYEE)
					OR HIREDATE= (SELECT MAX(HIREDATE) FROM EMPLOYEE)

-------------------------------------------------------------------------------
--Employees working in new york location
SELECT e.ename, d.loc 
from employee as e inner join dept as d
on e.deptno=d.deptno WHERE d.loc='new york'

SELECT * FROM employee 
WHERE DEPTNO= (SELECT DEPTNO FROM DEPT WHERE LOC='NEW YORK')

--difference between join and sub query--
--1 to display data from one table and condition based on another table then we can use join or sub-query.
--2 to display daa from two tables then use join

-- display 2nd max salary
SELECT MAX(SAL) FROM EMPLOYEE WHERE SAL <> (SELECT MAX(SAL) FROM EMPLOYEE)

-- DISPLAY THE NAMES OF EMPLOYEE WHO HOLD 2N MAX SALARY 
SELECT ENAME, SAL FROM EMPLOYEE
WHERE SAL=(SELECT MAX(SAL) FROM EMPLOYEE WHERE SAL <> (SELECT MAX(SAL) FROM EMPLOYEE))

-- 2ND MAX EXPERIENCE
SELECT MIN(HIREDATE) FROM EMPLOYEE WHERE HIREDATE <> (SELECT MIN(HIREDATE) FROM EMPLOYEE)

-- multi row subqueries--
-- if sub query return more than one value than it is called multi row subquery.
-- operator must be in, any, not in, all.
--		single			multi
--		  =				 in
--		  <>			 not in
--		  >				 >any >all
--		  <				 <any <all

--employees details who works in new york and chicago
SELECT * FROM employee 
WHERE DEPTNO IN (SELECT DEPTNO FROM DEPT
				 WHERE LOC IN ('NEW YORK', 'CHICAGO'))

-- ## CO-RELATED SUB -QUERIES ## --
-- IF INNER QUERY REFERNCES VALUES OF OUTER QUERY THEN IT IS CALLED CO-RELATED SUB-QUERY.
-- Execution starts from outer query and inner query is executed no of times depends on no of rows retuen by outer query.
-- Use co-related sub-queries to execute sub-query for each row return by outer query.

-- Execution:-
--1 return a row from outer query
--2 pass value to inner query
--3 executes inner query
--4 pass inner query output to outer query
--5 executes outer query where condition

--employees earning more than avg sal of the organization ?
SELECT * FROM employee
WHERE sal > (SELECT AVG(sal) FROM employee)

-- employees earning more than avg sal of their dept ?
SELECT * FROM employee as e
WHERE sal > (SELECT AVG(sal) FROM employee  WHERE deptno =  e.deptno)

-- Display emp earning max salaries in their dept.
SELECT * FROM EMPLOYEE AS E WHERE SAL = (SELECT MAX(SAL) FROM EMPLOYEE WHERE DEPTNO= E.DEPTNO)

-- 
SELECT * FROM SALESDATA AS S WHERE SALES= (SELECT MAX(SALES) FROM SALESDATA WHERE CATEGORY= S.CATEGORY)

-- Diplay top 3 max salaries.
SELECT DISTINCT TOP 3 SAL FROM EMPLOYEE ORDER BY SAL DESC

-- 5TH MAX SALARY
WITH E AS (
SELECT ENAME, SAL, ROW_NUMBER() OVER(ORDER BY SAL DESC) AS RNO FROM EMPLOYEE)
SELECT ENAME, SAL FROM E WHERE RNO= 5

-- Display op 3 max sal
SELECT DISTINCT  A.SAL FROM EMPLOYEE AS A 
WHERE 3> (SELECT COUNT (DISTINCT B.SAL) FROM EMPLOYEE AS B WHERE A.SAL < B.SAL)
ORDER BY SAL DESC

-- 3RD MAX SAL
SELECT DISTINCT  A.SAL FROM EMPLOYEE AS A 
WHERE 2=(SELECT COUNT (DISTINCT B.SAL) FROM EMPLOYEE AS B WHERE A.SAL < B.SAL)
ORDER BY SAL DESC
--OR 
SELECT DISTINCT  A.SAL FROM EMPLOYEE AS A 
WHERE (3-1)=(SELECT COUNT (DISTINCT B.SAL) FROM EMPLOYEE AS B WHERE A.SAL < B.SAL)
ORDER BY SAL DESC

-- create a user defined function and call the function to get the nth max sal.
CREATE OR ALTER FUNCTION getTopNsal(@n INT) RETURNS TABLE 
AS RETURN 
(SELECT DISTINCT  A.SAL FROM EMPLOYEE AS A 
WHERE (@n-1)=(SELECT COUNT (DISTINCT B.SAL) FROM EMPLOYEE AS B WHERE A.SAL < B.SAL))

SELECT * FROM dbo.getTopNsal(5)


-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-- Derived Tables & CTEs:-
--=> sub-queries in FROM clause are called derived tables
--=> sub-queries output acts like a tbale for outer query
--=> derived table are used in following scenarios
--1 to control order of execution of clauses
--2 to use result of one operation in another operation
--3 to jooin two query outputs

-- controlling order of execution of clauses--
--from
--WHERE
-- GROUP BY
-- HAVING
-- SELECT
-- ORDER BY

-- Display ranks of the employes based on sal and highest paid should get 1st rank.
SELECT EMPNO, ENAME, SAL, DENSE_RANK()OVER(ORDER BY SAL DESC) AS RNK FROM EMPLOYEE

SELECT EMPNO, ENAME, SAL, DENSE_RANK()OVER(ORDER BY SAL DESC) AS RNK FROM EMPLOYEE WHERE 
-- COLUMN ALIAS CANNOT BE USED IN WHERE CLAUSE BECAUSE WHERE CLAUSE IS EXECUTED BEFORE SELECT TO OVERCOME THIS PROBLEM USE DERIVED TBLE
SELECT * FROM (
SELECT EMPNO, ENAME, SAL, DENSE_RANK()OVER(ORDER BY SAL DESC) AS RNK FROM EMPLOYEE) AS E -- HERE E IS A DERIVED TABLE
WHERE RNK<=5

-- display top 3 max salary
SELECT DISTINCT SAL FROM (
SELECT EMPNO, ENAME, SAL, DENSE_RANK()OVER(ORDER BY SAL DESC) AS RNK FROM EMPLOYEE) AS E
WHERE RNK<=3
ORDER BY SAL DESC

-- DISPLAY 3RD MAXIMUM SAL
SELECT * FROM (
SELECT EMPNO, ENAME, SAL, DENSE_RANK()OVER(ORDER BY SAL DESC) AS RNK FROM EMPLOYEE) AS E -- HERE E IS DERIVED TABLE 
WHERE RNK=3

-- RNO
SELECT EMPNO, ENAME, SAL, ROW_NUMBER() OVER(ORDER BY EMPNO ASC) AS RNO FROM EMPLOYEE

-- DISPLAY FIRST 5 ROWS
SELECT * FROM (
SELECT EMPNO, ENAME, SAL, ROW_NUMBER() OVER(ORDER BY EMPNO ASC) AS RNO FROM EMPLOYEE) AS E
WHERE RNO <=5

-- 5TH ROW
SELECT * FROM (
SELECT EMPNO, ENAME, SAL, ROW_NUMBER() OVER(ORDER BY EMPNO ASC) AS RNO FROM EMPLOYEE) AS E
WHERE RNO =5

--5 O 10
SELECT * FROM (
SELECT EMPNO, ENAME, SAL, ROW_NUMBER() OVER(ORDER BY EMPNO ASC) AS RNO FROM EMPLOYEE) AS E
WHERE RNO BETWEEN 5 AND 10

-- 5, 10, 15
SELECT * FROM (
SELECT EMPNO, ENAME, SAL, ROW_NUMBER() OVER(ORDER BY EMPNO ASC) AS RNO FROM EMPLOYEE) AS E
WHERE RNO IN (5,10,15)

-- EVEN NO
SELECT * FROM (
SELECT EMPNO, ENAME, SAL, ROW_NUMBER() OVER(ORDER BY EMPNO ASC) AS RNO FROM EMPLOYEE) AS E
WHERE RNO%2=0

-- ODD NO
SELECT * FROM (
SELECT EMPNO, ENAME, SAL, ROW_NUMBER() OVER(ORDER BY EMPNO ASC) AS RNO FROM EMPLOYEE) AS E
WHERE RNO%2=1

-- LAST 3 ROWS 
SELECT * FROM (
SELECT EMPNO, ENAME, SAL, ROW_NUMBER() OVER(ORDER BY EMPNO ASC) AS RNO FROM EMPLOYEE) AS E
WHERE RNO >=12

-- WHEN ROW NUMER DON'T KNOW 
SELECT * FROM (
SELECT EMPNO, ENAME, SAL, ROW_NUMBER() OVER(ORDER BY EMPNO ASC) AS RNO FROM EMPLOYEE) AS E
WHERE RNO >= (SELECT COUNT(*)-2 FROM EMPLOYEE)

-- Delete first 3 row
delete FROM (
SELECT EMPNO, ENAME, SAL, ROW_NUMBER() OVER(ORDER BY EMPNO ASC) AS RNO FROM EMPLOYEE) AS E
WHERE RNO <=5 -- error

-- delete is not allowed in derived table
-- in  dervied table outer query cannot be dml(insert, update, delete) command must be select. 
-- To overcome this use CTE
