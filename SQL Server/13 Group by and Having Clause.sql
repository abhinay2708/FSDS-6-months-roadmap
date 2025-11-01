SELECT * FROM employee

-- Display deptno wise total salary
SELECT  DEPTNO,SUM(SAL) AS TOTAL_SAL FROM employee GROUP BY deptno

-- Job wise summary ie. min sal, max sal, total sal, no of employee.
SELECT JOB, MIN(SAL) AS MINSAL,
	MAX(SAL) AS MAXSAL,
	SUM(SAL) AS TOTALSAL,
	COUNT(*) AS CNT
FROM employee GROUP BY JOB

-- Year wise no of emp joined.
SELECT COUNT(*) AS NO_OF_EMP, 
YEAR(HIREDATE) AS HYEAR 
FROM employee
GROUP BY YEAR(HIREDATE)

-- Day wise no of employee joined.
SELECT DATENAME(DW, HIREDATE) AS DAY,
COUNT(*) AS NO_OF_EMP 
FROM employee
GROUP BY DATENAME(DW, HIREDATE) 

-- Month wise no of employees joined in the yea 1981.
SELECT DATENAME(MM,HIREDATE) AS MNTH,
COUNT(*) AS CNT
FROM employee
WHERE YEAR(HIREDATE) = '1981'
GROUP BY DATENAME(MM,HIREDATE)

-- FIND THE DEPARTMENT HAVING MORE THAN 3 EMPLOYEES.
SELECT DEPTNO, COUNT(*) AS NO_OF_EMP
FROM employee
GROUP BY DEPTNO
HAVING COUNT(*)>3
 
