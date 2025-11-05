CREATE TABLE DEPT
(
DEPTNO INT primary key,
DNAME VARCHAR(14),
LOC VARCHAR(13) 
)

INSERT INTO DEPT VALUES (10, 'ACCOUNTS', 'NEW YORK')
INSERT INTO DEPT VALUES (20, 'RESEARCH', 'DALLAS')
INSERT INTO DEPT VALUES (30, 'SALES', 'CHICAGO')
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON')

SELECT * FROM DEPT

-- Display employee details with dept details
SELECT ENAME, JOB, SAL, DNAME, LOC
FROM employee 
INNER JOIN DEPT ON 
employee.deptno=DEPT.DEPTNO

----OR-----------

SELECT e.ENAME, e.JOB, e.SAL, 
	   d.DNAME, d.LOC AS CITY, d.DEPTNO
FROM employee AS e
INNER JOIN DEPT AS d ON
e.deptno=d.DEPTNO
ORDER BY DEPTNO ASC

-- Display employee details with dept wise working at newyork location
SELECT e.ENAME, e.JOB, e.SAL, 
	   d.DNAME, d.LOC AS CITY, d.DEPTNO
FROM employee AS e
INNER JOIN DEPT AS d ON
e.deptno=d.DEPTNO
WHERE d.LOC='NEW YORK' and e.sal> 2000  -- earning more than 2000.
ORDER BY DEPTNO ASC

-- Display no of employee dept wise.AND show the dept names
SELECT d.DNAME, COUNT(*) AS NO_OF_EMP
FROM employee AS e INNER JOIN DEPT AS d 
ON e.DEPTNO=d.DEPTNO
GROUP BY d.DNAME

-- 