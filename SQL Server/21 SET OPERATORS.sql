use db7am

-- ## SET OPERATORS ##
-- UNION -- combines rows return by two queries, eliminate duplicates, sort result. (Horizontal Merge)
-- example
SELECT JOB FROM employee WHERE DEPTNO=20
UNION
SELECT JOB FROM employee WHERE DEPTNO=30

-- use same no of same data type records
SELECT JOB, SAL FROM employee WHERE DEPTNO=20
UNION
SELECT JOB, SAL FROM employee WHERE DEPTNO=30

-- We can use two tables also
SELECT ENAME FROM employee
UNION
SELECT DNAME FROM DEPT

-- UNION ALL----
-- combines rows return by two queries, duplicate are not eliminated, result is not sorted.

--example
SELECT JOB FROM employee WHERE DEPTNO=20
UNION ALL
SELECT JOB FROM employee WHERE DEPTNO=30

-- Differnce between union and union all
--		#	UNION	#				#	UNION ALL	#
--		eliminate duplicates		doesn't eliminate duplicates
--		sorts output				doesn't sort
--		slower						faster

-- ## INTERSECT-- Returns common values from output of two select statements.
-- example
SELECT JOB FROM employee WHERE DEPTNO=20
INTERSECT
SELECT JOB FROM employee WHERE DEPTNO=30

-- ## EXCEPT-- Returns values present in 1st query output and not present in 2nd query output.
-- example
SELECT JOB FROM employee WHERE DEPTNO=20
EXCEPT
SELECT JOB FROM employee WHERE DEPTNO=30

-- 2nd example
SELECT JOB FROM employee WHERE DEPTNO=30
EXCEPT
SELECT JOB FROM employee WHERE DEPTNO=20