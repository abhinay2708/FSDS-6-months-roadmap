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

-- 