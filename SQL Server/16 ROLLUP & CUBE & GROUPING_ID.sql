-- display dept wise and with in dept job wise total sal
SELECT DEPTNO, JOB, SUM(SAL) AS TOATL_SAL
FROM employee GROUP BY DEPTNO, JOB 
ORDER BY DEPTNO

-- Display year wise within year quarter wise no of employee.
SELECT YEAR(HIREDATE) AS YEAR, 
	DATEPART(QQ, HIREDATE) AS QUARTER, 
	DATENAME(MM, HIREDATE) AS MONTH,
	COUNT(1) AS NO_OF_EMP
FROM employee 
GROUP BY YEAR(HIREDATE), DATEPART(QQ, HIREDATE), DATENAME(MM, HIREDATE)
ORDER BY YEAR

-- ROLLUP()-- used to display subtotal and grandtotal.

-- Department wise, and job wise subtotal and grand total
SELECT DEPTNO, JOB,
SUM(SAL) AS TOTAL_SAL
FROM employee 
GROUP BY ROLLUP(DEPTNO, JOB)

-- CUBE() - same as rollup but it show subtotal for each group by column and grand total.
SELECT DEPTNO, JOB,
SUM(SAL) AS TOTAL_SAL 
FROM employee
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO

-- GROUPING_ID() -- used to define the groups with numbers
SELECT DEPTNO, JOB, 
SUM(SAL) AS TOTAL_SAL, GROUPING_ID(DEPTNO, JOB)
FROM employee
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO

-- now we can rename the numbers for better understanding
SELECT DEPTNO, JOB, 
SUM(SAL) AS TOTAL_SAL, 
  CASE GROUPING_ID(DEPTNO, JOB)
	WHEN 0 THEN 'JOB TOTAL'
	WHEN 1 THEN 'DEPT SUBTOTAL'
	WHEN 2 THEN 'JOB SUBTOTAL'
	WHEN 3 THEN 'GRAND TOTAL'
	END AS SUBTOTALS
FROM employee
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO

-- Display no of employee based on  sal range.
WITH E AS(
SELECT CASE 
			WHEN SAL BETWEEN 0 AND 1000 THEN '0-1000'
			WHEN SAL BETWEEN 1001 AND 2000 THEN '1001-2000'
			WHEN SAL BETWEEN 2001 AND 3000 THEN '2001-3000'
			WHEN SAL BETWEEN 3001 AND 4000 THEN '3001-4000'
			WHEN SAL>4000 THEN 'Above 4000'
			END AS SAL_RANGE
FROM employee)
SELECT SAL_RANGE,COUNT(*) AS NO_OF_EMP FROM E GROUP BY SAL_RANGE


