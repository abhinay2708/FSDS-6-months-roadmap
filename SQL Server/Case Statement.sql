-- CASE Statement ==> It is used to implement If-Else in sql queries

SELECT * FROM employee

--Display ENAME jobs if job = clerk display worker
						--	  manager display boss
						--    president display big boss
						--    others employee ?
SELECT ENAME, CASE JOB
	WHEN 'CLERK' THEN 'WORKER'
	WHEN 'MANAGER' THEN 'BOSS'
	WHEN 'PRESIDENT' THEN 'BIG BOSS'
	ELSE JOB
	END AS JOBS
FROM employee

-- Display ename and  department name if deptno = 10 display accounts
											--   20 display research
											--   30 display sales
											--   others unknown
SELECT ENAME, CASE DEPTNO
	WHEN 10 THEN 'ACCOUNTS'
	WHEN 20 THEN 'RESEARCH'
	WHEN 30 THEN 'SALES'
	ELSE 'UNKNOWN'
	END AS 'DEPTNAME'
FROM employee

-- Display ENAME, SAL, SAL RANGE IF sal>3000 display HI_SAL
								--  sal<3000 display LO_SAL
								--  sal=3000 display AVG_SAL
SELECT ENAME, SAL, 
CASE 
	WHEN SAL > 3000 THEN 'HI_SAL'
	WHEN SAL < 3000 THEN 'LO_SAL'
	ELSE 'AVG_SAL'
	END AS 'SAL_RANGE'
FROM employee

CREATE TABLE result 
(sno TINYINT,
sname VARCHAR(10),
s1 SMALLINT,
s2 SMALLINT,
s3 SMALLINT)

INSERT INTO result 
(sno, sname, s1, s2, s3)
VALUES
(1, 'A', 80, 90, 70),
(2, 'B', 50, 60, 40),
(3, 'C', 60, 70, 30)

SELECT * FROM result

-- Display sno  total avg result.
SELECT sno, 
	(s1+s2+s3) as 'total',
	(s1+s2+s3)/3.0 as 'avg',
	CASE 
		WHEN s1>=35 AND s2>=35 AND s3>=35 THEN 'pass'
		ELSE 'fail'
		END AS 'result'
FROM result

