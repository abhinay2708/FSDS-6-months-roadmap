-- GROUPING SETS()-- 

-- Calculate dept wise and with in dept job wise total sal and also display grand total.
SELECT DEPTNO, JOB, SUM(SAL) AS TOTAL_SAL
FROM employee
GROUP BY GROUPING SETS((DEPTNO, JOB), ())

-- Calculate dept wise and with in dept job wise total sal and, dept wise also display grand total.
SELECT DEPTNO, JOB, SUM(SAL) AS TOTAL_SAL
FROM employee
GROUP BY GROUPING SETS((DEPTNO, JOB), DEPTNO, ())
ORDER BY DEPTNO ASC

-- Calculate dept wise and with in dept job wise total sal and, dept wise, job wise also display grand total.
SELECT DEPTNO, JOB, SUM(SAL) AS TOTAL_SAL
FROM employee
GROUP BY GROUPING SETS((DEPTNO, JOB), DEPTNO, job, ())
ORDER BY DEPTNO ASC, JOB ASC