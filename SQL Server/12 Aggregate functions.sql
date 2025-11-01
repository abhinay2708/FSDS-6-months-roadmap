use db7am
SELECT * FROM employee
-- Aggregate Functions--Process multiple rows and return one value.
--MAX(), MIN(), SUM(), AVG(), COUNT()

--MAX()-- Return maximum values

--Display the maximum salary from the table.
SELECT MAX(SAL) FROM employee

-- Display max hiredate
SELECT MAX(HIREDATE) AS HDATE FROM employee

--Display min hiredate
SELECT MIN(HIREDATE) AS HDATE FROM employee

--in character 
SELECT MAX(ENAME) AS ENAME FROM employee

SELECT MIN(ENAME) AS ENAME FROM employee


-- Display maximum salaries department wise.-----------------------------------------------------------------------
SELECT ENAME, JOB, HIREDATE, DEPTNO,SAL,
ROW_NUMBER()OVER(PARTITION BY DEPTNO ORDER BY empNO ASC) AS RN 
FROM employee
WHERE SAL= (SELECT MAX(SAL) FROM employee)

-- MIN() -- return minimum value

--Display minimum salary of the employee table
SELECT MIN(SAL) AS SAL FROM employee

-- SUM() -- return total

--Display total salary of the table
SELECT SUM(SAL) AS SAL FROM employee

-- Display total salariees paid to manager.
SELECT SUM(SAL) AS SAL FROM employee WHERE JOB='MANAGER'

-- Calculating total salraies including commisson.
SELECT SUM(SAL+ ISNULL(COMM,0)) AS TOTAL FROM employee

-- Display total salary of clerk.---------------------------------------------------------------------------
SELECT SUM(SAL) AS SAL FROM employee WHERE JOB='CLERK'

SELECT SUM(CASE JOB
			WHEN 'CLERK'
			THEN SAL
			END) AS CLERK
FROM employee

-- Display total salary of clerk, manager, salesman.
SELECT SUM(CASE JOB
			WHEN 'CLERK'
			THEN SAL
			END) AS CLERK,
		SUM(CASE JOB
			WHEN 'MANAGER'
			THEN SAL
			END) AS MANAGER,
		SUM(CASE JOB
			WHEN 'SALESMAN'
			THEN SAL
			END) AS SALESMAN
FROM employee

-- AVG() -- return average values

--Display average salary of employees
SELECT AVG(SAL) AS SAL FROM employee

-- FLOOR() -- rounded the value to the lowest
SELECT FLOOR(AVG(SAL)) AS SAL FROM employee

-- CEILING() -- rounded the value to the highest
SELECT CEILING(AVG(SAL)) AS SAL FROM employee

-- COUNT() -- returns no. of values present in a column(nulls are not counted)
SELECT COUNT(empno) FROM employee

-- COUNT(*) -- returns no. of rows in a table
SELECT COUNT(*) FROM employee

-- COUNT(1) -- it's same as count(*). but it faster than count(*).
SELECT COUNT(1) FROM employee

-- Display no of employee joined in 1981.
SELECT COUNT(1) FROM employee WHERE YEAR(HIREDATE)=1981

-- Display no of employee joined on sunday.
SELECT COUNT(1) FROM employee WHERE DATENAME(DW,HIREDATE)='SUNDAY'

-- No. of employee working for each dept.
SELECT COUNT(CASE DEPTNO
			WHEN 10
			THEN EMPNO
			END) AS [10],
		COUNT(CASE DEPTNO
			WHEN 20
			THEN EMPNO
			END) AS [20],
		COUNT(CASE DEPTNO
			WHEN 30
			THEN EMPNO
			END) AS [30]
FROM employee

-- SUBQUERIES
--Name of the employee having max experience
SELECT ENAME, SAL, HIREDATE
FROM employee 
WHERE 
HIREDATE= (SELECT MIN(HIREDATE) FROM employee)

--Name of the employee having max salary
SELECT ENAME, SAL FROM employee
WHERE SAL=(SELECT MAX(SAL) FROM employee)
