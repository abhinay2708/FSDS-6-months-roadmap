use db7am

-- GETDATE()--Current date and time
SELECT GETDATE()

-- YEAR() --year part from date
SELECT YEAR(GETDATE())

-- MONTH()--month part from date
SELECT MONTH(GETDATE())

-- DAY()--day part from date
SELECT DAY(GETDATE())

-- Display ename, year of join?
SELECT ENAME, YEAR(HIREDATE) as joinyear FROM employee

-- Display employee details joined in 1980, 1983,1985.
SELECT * FROM employee WHERE YEAR(HIREDATE) IN (1980, 1983, 1985)

-- Display employee joined in Jan, Apr, Dec month.
SELECT * FROM employee WHERE MONTH(HIREDATE) IN (01, 04, 12)

-- DATEPART()--Part of the date
SELECT DATEPART(YY, GETDATE()) -- YEAR
SELECT DATEPART(MM, GETDATE()) -- MONTH
SELECT DATEPART(DD, GETDATE()) -- DAY
SELECT DATEPART(DW, GETDATE()) -- DAY of the week
SELECT DATEPART(DY, GETDATE()) -- DAY of the year
SELECT DATEPART(HH, GETDATE()) -- Hour
SELECT DATEPART(MI, GETDATE()) -- Minute
SELECT DATEPART(SS, GETDATE()) -- Second
SELECT DATEPART(QQ, GETDATE()) -- Quarter

-- Display employee joined on saturday, sunday.
SELECT * FROM employee WHERE DATEPART(DW, HIREDATE) IN (1,7)

-- Display employee joined in 2nd quarter of 1981 year.
SELECT * FROM employee
WHERE
	YEAR(HIREDATE) = 1981
	AND
	DATEPART(QQ, HIREDATE) = 2

-- DATENAME()--It same as datepart, but in mm and dw it return name.
SELECT DATENAME(MM, GETDATE())
SELECT DATENAME(DW, GETDATE())

-- Display ename and day of join.
SELECT ENAME, DATENAME(DW, HIREDATE) as daynam FROM employee

-- WAQ to find on which day India got Independence.
SELECT DATENAME(DW, '1947-08-15')

-- FORMAT() -- Display dates in different formats.(day-'dd', month-'MM', year-'yyyy', hour-'hh', minute-'mm', second-'ss').
SELECT FORMAT(GETDATE(), 'dd-MM-yyyy')

SELECT FORMAT(GETDATE(), 'dd-MM-yyyy hh:mm:ss')

-- See day,month name first 3 letter.
SELECT FORMAT(GETDATE(), 'ddd-MMM-yyyy')

-- See full month and day name.
SELECT FORMAT(GETDATE(), 'dddd-MMMM-yyyy')

-- display hiredates in dd-MM-yyyy.
SELECT ENAME, FORMAT(HIREDATE, 'dd-MM-yyyy') as hiredate FROM employee

-- Display list of employee joined today.
SELECT * FROM employee 
WHERE HIREDATE = FORMAT(GETDATE(), 'yyyy-MM-dd')

-- DATEADD() -- To add/subtract year/month/day to/from a date.
SELECT DATEADD(DD, 10, GETDATE())
SELECT DATEADD(MM, 2, GETDATE())
SELECT DATEADD(YY, 1, GETDATE())
SELECT DATEADD(DD, -10, GETDATE())
SELECT DATEADD(MM, -2, GETDATE())
SELECT DATEADD(YY, -1, GETDATE())

-- DATEDIFF()-- Difference between two dates.
SELECT DATEDIFF(YY, '2024-10-23', GETDATE())
SELECT DATEDIFF(MM, '2024-10-23', GETDATE())
SELECT DATEDIFF(DD, '2024-10-23', GETDATE())

-- Display ename, experience in years.
SELECT ENAME, DATEDIFF(YY, HIREDATE, GETDATE()) as experience FROM employee

-- Display ename and experience in year and month.
SELECT ENAME,
CONCAT(
	DATEDIFF(MM, HIREDATE, GETDATE())/12, ' Years ',
	DATEDIFF(MM, HIREDATE, GETDATE())%12, ' Months'
	  ) as experience
FROM employee

-- Employee having more than 10 years experience.
SELECT * FROM employee WHERE DATEDIFF(YY, HIREDATE, GETDATE()) > 10

-- EOMONTH()--return last day of month
SELECT EOMONTH(GETDATE())
SELECT EOMONTH(GETDATE(),1) -- Last day of next month
SELECT EOMONTH(GETDATE(),-1) -- Last day of previous month

-- Display first day of the month
SELECT DATEADD(DD,1,EOMONTH(GETDATE()))

--Current month first day 
SELECT DATEADD(DD, 1, EOMONTH(GETDATE(), -1))

-- Display first day of the next year.
SELECT 