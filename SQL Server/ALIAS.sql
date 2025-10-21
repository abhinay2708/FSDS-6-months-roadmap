-- ALIAS ==> alias means alternative name used to cahnge column heading

SELECT * FROM emp

-- Display ename, annual_salary 
SELECT ename, sal*12 as ann_sal FROM emp
--or, To create a name with sapce we have to use square brackets([])
SELECT ename, sal*12 as [annual salary] FROM emp



