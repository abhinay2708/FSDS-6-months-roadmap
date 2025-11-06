-- SELF JOIN

-- Display eployee name and manager name.
SELECT x.ename as employee, y.ename as manager
FROM employee as x INNER JOIN employee as y ON x.mgr=y.empno

-- DISPLAY employees reporting to blake
SELECT x.ename as employee, y.ename as manager
FROM employee as x INNER JOIN employee as y ON x.mgr=y.empno
WHERE y.ename='BLAKE'

-- No of employees reporting to blake
SELECT COUNT(x.ename) AS NO_OF_EMP
FROM employee as x INNER JOIN employee as y ON x.mgr=y.empno
WHERE y.ename='BLAKE'

-- Employees earning more than their managers
SELECT x.ename as Employee,x.sal as Employee_Sal, y.ename as Manager, y.sal as Manager_Sal
FROM employee as x INNER JOIN employee as y ON x.mgr=y.empno
WHERE x.sal>y.sal

--Employees who are senior to the manager.
SELECT x.ename as employee, x.hiredate as emp_hiredate, y.ename as manager, y.hiredate as manager_hiredaet
FROM employee as x INNER JOIN employee as y ON x.mgr=y.empno
WHERE x.hiredate<y.hiredate

-- No of employees reporting to each manager
SELECT y.ename as manager, COUNT(x.ename) as NO_OF_EMP
FROM employee as x INNER JOIN employee as y ON x.mgr=y.empno
GROUP BY y.ename
--------------------------------------------------------------------
-- Team matches
--creating a country table
CREATE TABLE country
(ID INT, NAME VARCHAR(10))
-- insert data
INSERT INTO country VALUES(1, 'IND'), (2, 'AUS'), (3,'SA')
-- query to show the matches
SELECT x.name, y.name
FROM country as x INNER JOIN country  as y on x.id<y.id
-- query to show the matches in one columns
SELECT (x.name+ ' VS ' +y.name) AS TEAMS
FROM country as x INNER JOIN country  as y on x.id<y.id
--or
SELECT (x.name+ ' VS ' +y.name) AS TEAMS
FROM country as x INNER JOIN country  as y on x.id>y.id
------------------------------------------------------------------------
