--- Pivot Operator--
-- operator used to convert rows into columns 
-- operator used to display data in matrix form
-- operator used for cross tabulation

-- SELECT COLUMNS FROM (SELECT REQUIRED DATA) AS <ALIAS> PIVOT (AGGR-EXPR FOR colame IN (v1, v2, v3,--) ORDER BY COL ASC/DESC
SELECT * FROM (SELECT DEPTNO, JOB, SAL FROM employee) AS E
PIVOT(
      SUM(SAL)FOR DEPTNO IN ([10],[20],[30])
     ) AS DEPT_JOB_TOTSAL
ORDER BY JOB ASC

-------------
SELECT * FROM (SELECT YEAR(HIREDATE) AS YEAR, DATEPART(QQ, HIREDATE) AS QRT, EMPNO FROM emploYEE)AS E
PIVOT(
        COUNT(EMPNO) FOR QRT IN ([1],[2],[3],[4])
     ) AS YEAR_QRT_EMPLOYEE
ORDER BY YEAR ASC

-----------------
SELECT * FROM SALESDATA

SELECT * FROM (SELECT REGION, CATEGORY, SALES FROM SALESDATA) AS S
PIVOT(
        SUM(SALES) FOR REGION IN ([SOUTH], [WEST], [CENTRAL], [EAST])
        ) AS REG_CAT_TOTSAL
ORDER BY CATEGORY ASC

