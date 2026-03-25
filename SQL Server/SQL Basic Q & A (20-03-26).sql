-- 1. Display all employees.

SELECT * FROM EMPLOYEE

-- 2. Show employee names and salaries.

SELECT ENAME, SAL FROM EMPLOYEE

-- 3. Display employees who work in department 30.

SELECT * FROM EMPLOYEE WHERE DEPTNO=30

-- 4. Show employees with salary greater than 2000.

SELECT * FROM EMPLOYEE WHERE SAL>2000

-- 5. List employees hired after 1981.

SELECT * FROM EMPLOYEE WHERE YEAR(HIREDATE) > 1981

-- 6. Display employee names in uppercase.

SELECT UPPER(ENAME) FROM EMPLOYEE

-- 7. Show unique job roles.

SELECT DISTINCT(JOB) AS JOB FROM EMPLOYEE

-- 8. Count total number of employees.

SELECT COUNT(*) FROM EMPLOYEE

-- 9. Find employees with NULL commission.

SELECT * FROM EMPLOYEE WHERE COMM IS NULL

--10. Show employees whose name starts with 'S'.

SELECT * FROM EMPLOYEE WHERE ENAME LIKE 'S%'

-- 11. Display employees sorted by salary (ascending).

SELECT * FROM EMPLOYEE ORDER BY SAL ASC

-- 12. Display top 3 highest paid employees.

SELECT TOP 3 ENAME, SAL FROM EMPLOYEE ORDER BY SAL DESC

-- 13. Show employees with salary between 1000 and 3000.

SELECT * FROM EMPLOYEE WHERE SAL BETWEEN 1000 AND 3000

-- 14. Find employees working as 'MANAGER'.

SELECT * FROM EMPLOYEE WHERE JOB = 'MANAGER'

-- 15. Show employees from department 10 or 20.

SELECT * FROM EMPLOYEE WHERE DEPTNO IN (10,20)

--16. Display employees not in department 30.

SELECT * FROM EMPLOYEE WHERE DEPTNO NOT IN (30)

-- 17. Sort employees by department and then salary descending.

SELECT * FROM EMPLOYEE ORDER BY DEPTNO ASC, SAL DESC

-- 18. Show employees whose name ends with 'N'.

SELECT * FROM EMPLOYEE WHERE ENAME LIKE '%N'

-- 19. Display employees hired in 1981.

SELECT * FROM EMPLOYEE WHERE YEAR(HIREDATE) = 1981

-- 20. Show employees with commission greater than salary.

SELECT * FROM EMPLOYEE WHERE COMM>SAL

-- 21. Find average salary of all employees.

SELECT AVG(SAL) FROM EMPLOYEE 

-- 22. Find maximum salary.

SELECT MAX(SAL) AS MAX_SAL FROM EMPLOYEE

-- 23. Find minimum salary.

SELECT MIN(SAL) AS MIN_SAL FROM EMPLOYEE

-- 24. Count employees in each department.

SELECT COUNT(ENAME) AS EMPLOYEE, DEPTNO FROM EMPLOYEE GROUP BY DEPTNO

-- 25. Find total salary per department.

SELECT DEPTNO, SUM(SAL) AS TOTAL_SAL FROM EMPLOYEE GROUP BY DEPTNO

-- 26. Find average salary per job role.

SELECT JOB, AVG(SAL) AS AVERAGE_SAL FROM EMPLOYEE GROUP BY JOB

-- 27. Find department with highest average salary.

SELECT TOP 1 DEPTNO, AVG(SAL) AS AVERAGE_SAL FROM EMPLOYEE GROUP BY DEPTNO ORDER BY AVERAGE_SAL DESC

-- 28. Count employees with and without commission.

SELECT COUNT(CASE WHEN COMM IS NOT NULL THEN 1 END) AS WITH_COMM,
		COUNT(CASE WHEN COMM IS NULL THEN 1 END) AS WITHOUT_COMM
FROM EMPLOYEE

-- 29. Find total commission paid.

SELECT SUM(COMM) TOTAL_COMM FROM EMPLOYEE 

-- 30. Find number of employees for each job.

SELECT JOB, COUNT(ENAME) AS NO_OF_EMP FROM EMPLOYEE GROUP BY JOB

-- 31. Find departments with more than 3 employees.

SELECT DEPTNO, COUNT(ENAME) AS NO_OF_EMP FROM EMPLOYEE GROUP BY DEPTNO HAVING COUNT(ENAME)>3

-- 32. Find job roles with average salary > 2000.

SELECT JOB, AVG(SAL) AS AVG_SAL FROM EMPLOYEE GROUP BY JOB HAVING AVG(SAL)>2000

-- 33. Find departments where total salary > 5000.

SELECT DEPTNO, SUM(SAL) AS TOTAL_SAL FROM EMPLOYEE GROUP BY DEPTNO HAVING SUM(SAL) > 5000

-- 34. Find jobs having more than 2 employees.

SELECT JOB, COUNT(ENAME) AS NO_OF_EMP FROM EMPLOYEE GROUP BY JOB HAVING COUNT(ENAME) >2

-- 35. Find departments with no employees.

SELECT D.DEPTNO FROM DEPT AS D LEFT JOIN EMPLOYEE AS E ON D.DEPTNO=E.DEPTNO WHERE E.DEPTNO IS NULL

-- 36. Display employee name with department name.

SELECT E.ENAME AS ENAME, D.DNAME AS DNAME FROM EMPLOYEE AS E INNER JOIN DEPT AS D ON E.DEPTNO=D.DEPTNO

-- 37. Show employees along with department location.

SELECT E.ENAME AS ENAME, D.LOC AS LOC FROM EMPLOYEE AS E INNER JOIN DEPT AS D ON E.DEPTNO=D.DEPTNO

-- 38. List employees working in 'SALES'.

SELECT E.ENAME AS ENAME, D.DNAME FROM EMPLOYEE AS E INNER JOIN DEPT AS D ON E.DEPTNO=D.DEPTNO WHERE D.DNAME='SALES'

-- 39. Show employees with their manager names.

SELECT E1.ENAME, E2.ENAME FROM EMPLOYEE AS E1 INNER JOIN EMPLOYEE AS E2 ON E1.MGR=E2.EMPNO

-- 40. Find employees who have no manager.

SELECT ENAME FROM EMPLOYEE WHERE MGR IS NULL

-- 41 Display departments with no employees.

SELECT D.DEPTNO, E.ENAME FROM DEPT AS D LEFT JOIN EMPLOYEE AS E ON D.DEPTNO=E.DEPTNO WHERE E.DEPTNO IS NULL

-- 42. Show employee count per department including empty departments.

SELECT D.DEPTNO, COUNT(E.ENAME) AS NO_OF_EMP 
FROM DEPT AS D LEFT JOIN EMPLOYEE AS E ON D.DEPTNO=E.DEPTNO GROUP BY D.DEPTNO

-- 43. Find employees earning more than average salary.

SELECT ENAME, SAL FROM EMPLOYEE WHERE SAL > (SELECT AVG(SAL) FROM EMPLOYEE)

-- 44. Find employees in the same department as 'SMITH'.

SELECT DEPTNO, ENAME FROM EMPLOYEE WHERE DEPTNO=(SELECT DEPTNO FROM EMPLOYEE WHERE ENAME='SMITH')

-- 45. Find highest paid employee in each department.

SELECT DEPTNO, MAX(SAL) FROM EMPLOYEE GROUP BY DEPTNO

-- 46. Find employees whose salary is the same as FORD.

SELECT ENAME, SAL FROM EMPLOYEE WHERE SAL=(SELECT SAL FROM EMPLOYEE WHERE ENAME='FORD')

-- 47. Find employees who earn more than their manager.

SELECT E1.ENAME, E1.SAL, E2.ENAME, E2.SAL FROM 
EMPLOYEE AS E1 INNER JOIN EMPLOYEE AS E2 ON E1.MGR=E2.EMPNO WHERE E1.SAL>E2.SAL

-- 48. Rank employees based on salary (highest to lowest).

SELECT *, DENSE_RANK() OVER(ORDER BY SAL DESC) AS RNK FROM EMPLOYEE

-- 49. Find 2nd highest salary.

SELECT MAX(SAL) FROM EMPLOYEE WHERE SAL<(SELECT MAX(SAL) FROM EMPLOYEE)

-- 50. Categorize employees: Salary < 2000 → 'LOW', 2000–3000 → 'MEDIUM', 3000 → 'HIGH'.
SELECT SAL,CASE 
	WHEN SAL<2000 THEN 'LOW'
	WHEN SAL BETWEEN 2000 AND 3000 THEN 'MEDIUM'
	ELSE 'HIGH'
	END AS "CATEGORY"
FROM EMPLOYEE