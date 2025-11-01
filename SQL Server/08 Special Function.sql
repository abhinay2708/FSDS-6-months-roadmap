use db7am

-- SPECIAL FUNCTIONS

--ISNULL()--To handle null values.
SELECT ISNULL(100, 200) --100
SELECT ISNULL(NULL, 200) --200

-- Display ename,sal, comm if comm is null then fill with 500.
SELECT ENAME, SAL, ISNULL(COMM, 500) as COMM FROM employee

-- Display ename, sal, comm and totalsal.
SELECT ENAME, SAL, COMM, SAL + ISNULL(COMM, 0) as TOTALSAL FROM employee

-- CAST()--Convert one data type to another data type
SELECT CAST('123' as VARCHAR) as casting 

-- Display COMM=N/A where comm is null.
SELECT ENAME, SAL, ISNULL(CAST(COMM as VARCHAR), 'N/A') as COMM FROM employee
SELECT ENAME, SAL, COALESCE(CAST(COMM as VARCHAR), 'N/A') as COMM FROM employee

-- COALESCE()--Used to clean data
SELECT COALESCE(NULL,300, NULL, 200, NULL)

