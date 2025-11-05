SELECT * FROM employee

SELECT * FROM DEPT

-- Display employee details with department details.
SELECT e.*, d.* FROM employee as e INNER JOIN DEPT AS d ON E.DEPTNO=D.DEPTNO

SELECT e.ename, e.job, e.hiredate, e.sal, d.dname, d.loc FROM employee as e INNER JOIN DEPT as d ON e.DEPTNO=d.DEPTNO

-- Display employee details with dept wise working at new tork location and earning more than 2000.
SELECT e.ename, e.job, e.hiredate, e.sal, d.dname, d.loc
FROM employee as e INNER JOIN DEPT as d ON e.deptno=d.deptno
WHERE LOC= 'NEW YORK' AND SAL>2000

-- Display dept wise no of employee
SELECT d.dname, COUNT(e.ename) as NO_OF_EMP FROM employee as e INNER JOIN DEPT as d ON e.deptno=d.deptno 
GROUP BY d.dname

-- Display country wise no of employee.
SELECT d.loc, COUNT(e.ename) AS NO_OF_EMP 
FROM employee as e INNER JOIN DEPT as d ON e.deptno=d.deptno 
GROUP BY D.LOC

-- How to join two tables without common fields.
-- TABLE A
CREATE TABLE A (ID INT)
INSERT INTO A VALUES (10), (20), (30)

-- TABLE B
CREATE TABLE B (NAME VARCHAR(10))
INSERT INTO B VALUES('X'), ('Y'), ('Z')

WITH M AS
(SELECT ID, ROW_NUMBER()OVER(ORDER BY ID ASC) AS R_NO FROM A),
N AS 
(SELECT NAME, ROW_NUMBER() OVER(ORDER BY NAME) AS R_NO FROM B)

SELECT M.ID, N.NAME FROM M INNER JOIN N ON M.R_NO=N.R_NO


