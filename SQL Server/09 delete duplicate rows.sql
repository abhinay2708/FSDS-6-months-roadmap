USE db7am

-- DELETE DUPLICATES
-- To delete duplicate rows from output we use distinct
SELECT DISTINCT * FROM emp44

SELECT * FROM emp44

 INSERT INTO emp44 
         VALUES(1,'A',5000),(2,'B',6000),(3,'C',7000),(1,'A',5000),(2,'B',6000)

-- Delete the duplicate rows from emp44 table
-- step 1 :- generate row_numbers with in the partition of eno,ename,sal
SELECT eno, ename, sal, ROW_NUMBER()OVER(PARTITION BY eno,ename,sal ORDER BY eno ASC) as rno FROM emp44

-- step 2 :-   delete the records with row_number > 1
WITH E AS
(
SELECT eno, ename, sal, ROW_NUMBER()OVER(PARTITION BY eno,ename,sal ORDER BY eno ASC) as rno FROM emp44
)
DELETE FROM E WHERE rno>1

SELECT * FROM emp44
