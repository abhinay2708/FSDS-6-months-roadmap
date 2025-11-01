USE db7am

SELECT * FROM student

-- WHo passed in the all exam 
SELECT * FROM student
  WHERE
    s1>35 AND s2>35 AND s3>35

-- who failed in the all exam 
SELECT * FROM student
  WHERE
    s1<35 AND s2<35 AND s3<35

-- who failed in only 1 subject
SELECT * FROM student
  WHERE
    (s1<35 AND s2>35 AND s3>35)
	OR
	(s1>35 AND s2<35 AND s3>35)
	OR
	(s1>35 AND s2>35 AND s3<35)

-- who failed in 2 subjects
SELECT * FROM student
  WHERE
    (s1<35 AND s2<35 AND s3>35)
	OR
	(s1<35 AND s2>35 AND s3<35)
	OR (s1>35 AND s2<35 AND s3<35)

-- display the cust table
SELECT * FROM cust

-- list of customers whose id is 100, 102, 104
SELECT * FROM cust
  WHERE
    cid in (100, 102, 104)

-- list of customers who are belongs to wb, odisha, asam
SELECT * FROM cust
  WHERE
    city IN  ('wb', 'odisha', 'asam')

-- list of customers who are not belongs to wb, odisha, asam
SELECT * FROM cust
  WHERE
    city NOT IN  ('wb', 'odisha', 'asam')

-- list customers whose age between 20 to 25
SELECT * FROM cust
  WHERE
    age BETWEEN 20 AND 25

-- Customers they registerd in 2025
SELECT * FROM cust
  WHERE
    dOR BETWEEN '2025-01-01' AND '2025-12-31'

-- Customers they not registerd in 2025
SELECT * FROM cust
  WHERE
    dOR NOT BETWEEN '2025-01-01' AND '2025-12-31'

-- List of customers who belongs to wb and assam, and age between 24 to 30, and registered in 2020
SELECT * FROM cust 
  WHERE
	city IN ('wb','asam')
	AND 
	age BETWEEN 24 AND 30
	AND
	dOR NOT BETWEEN '2020-01-01' AND '2020-12-31'

--Customers whose name starts with a.
SELECT * FROM cust
  WHERE
    name LIKE 'a%'

-- Customers whose name ends with y.
SELECT * FROM cust
  WHERE

    name LIKE '%y'
