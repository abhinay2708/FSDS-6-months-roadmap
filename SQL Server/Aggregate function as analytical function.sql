use db7am

-- Use aggregate function as analytical function

CREATE TABLE sale(
id TINYINT,
sdate DATE,
amt smallmoney
)

INSERT INTO  
sale (id, sdate, amt) 
VALUES  (1, '2025-01-01', 100),
		(2, '2025-01-02', 120),
		(3, '2025-01-03', 130),
		(4, '2025-01-04', 115),
		(5, '2025-01-05', 140),
		(6, '2025-01-06', 125),
		(7, '2025-01-07', 150),
		(8, '2025-01-08', 145),
		(9, '2025-01-09', 105),
		(10, '2025-01-10', 100)
			
SELECT * FROM sale

-- Display id, sdate, amt, running_total.
SELECT id, sdate, amt, SUM(amt)OVER(ORDER BY sdate ASC) AS running_total FROM sale

-- Display id, sdate, amt, prev_day_amt, difference.
WITH E AS(
SELECT id, sdate, amt,
LAG(amt,1)OVER(ORDER BY sdate ASC) AS prev_day_amt FROM sale
)
SELECT id, sdate, amt, prev_day_amt, (amt-prev_day_amt) AS diff FROM E

-- Display empno, hiredate, sal, moving_avg.
SELECT EMPNO, HIREDATE, SAL, AVG(SAL)OVER(ORDER BY EMPNO ASC) AS MOVING_AVG FROM employee

-- Display id, sdate, amt, moving_avg.
SELECT id, sdate, amt, AVG(amt)OVER(ORDER BY sdate ASC) AS moving_avg FROM sale

-- Display id, sdate, amt and last 7 days moving avg.
SELECT id, sdate, amt,
AVG(amt)OVER(ORDER BY sdate ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS moving_avg 
FROM sale