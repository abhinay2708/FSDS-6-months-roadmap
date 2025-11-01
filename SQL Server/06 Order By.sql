use db7am

SELECT * FROM employee

-- Most experinced employee in the department
SELECT * FROM employee ORDER BY HIREDATE DESC

-- Find the highest paid to lowest paid employees.
SELECT * FROM employee ORDER BY SAL DESC

-- Find the employees depertment wise in ascending order
SELECT EMPNO, ENAME, SAL, DEPTNO FROM employee ORDER BY DEPTNO ASC

-- Arranage employee list department wise ascending and with in dept salary wise descending.
SELECT EMPNO, ENAME, SAL, DEPTNO FROM employee ORDER BY DEPTNO ASC, SAL DESC

-- Find most and least experienced employees in each department
SELECT EMPNO, ENAME, HIREDATE, DEPTNO FROM employee ORDER BY DEPTNO ASC, HIREDATE ASC

--Arrange student list avg wise desc
-- if avg same then arrange based on s1 desc,
--if s1 also same then arrange based on s2 desc.
SELECT sname, s1, s2, s3, (s1+s2+s3)/3 AS 'avg' FROM result ORDER BY (s1+s2+s3)/3 DESC, s1 DESC, s2 DESC

--Display employees working as clerk, manager and arrange output salARY wise descending.
SELECT * FROM employee
WHERE JOB IN ('CLERK', 'MANAGER')
ORDER BY SAL DESC

-- List of transactions of particular customer between sept 1st to oct 1st, and arrange the output latest transaction first.
SELECT * FROM transactions
WHERE ACCNO=100 AND  TDATE BETWEEN '2025-09-01' AND '2025-10-01' 
ORDER BY TDATE DESC

-- ==> DISTINCT CLAUSE

