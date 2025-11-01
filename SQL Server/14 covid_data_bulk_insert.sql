use db7am

SELECT * FROM employee

-- Group By Clasuse--used to group rows based on one or more columns to calcuate.

-- Display deptartment wise total salary
SELECT DEPTNO, SUM(SAL) AS TOTAL_SAL FROM employee GROUP BY DEPTNO

-- Display job wise summary, i.e.-min sal, max sal, total sal, no. of employee.
SELECT JOB, 
	MIN(SAL) AS MIN_SAL,
	MAX(SAL) AS MAX_SAL,
	SUM(SAL) AS TOTAL_SAL,
	COUNT(1) AS NO_OF_EMP 
FROM employee
GROUP BY JOB

-- Year wise no of employee joined.
SELECT YEAR(HIREDATE) AS YEAR,
COUNT(1) AS NO_OF_EMP
FROM employee
GROUP BY YEAR(HIREDATE)

-- Display datename and how many employee joined.
SELECT DATENAME(DW, HIREDATE) AS DAYNAM,
COUNT(1) AS NO_OF_EMP 
FROM employee
GROUP BY DATENAME(DW, HIREDATE)

-- Month wise no of employee joined in the year 1981.
SELECT DATENAME(MM, HIREDATE) AS MONTH,
COUNT(1) AS NO_OF_EMP
FROM employee 
WHERE YEAR(HIREDATE)='1981' 
GROUP BY DATENAME(MM, HIREDATE)

-- Find the department having more than 3 employees.
SELECT DEPTNO,
COUNT(1) AS NO_OF_EMP
FROM employee 
GROUP BY DEPTNO 
HAVING COUNT(1)>3