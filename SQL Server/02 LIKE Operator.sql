-- LIKE OPERATOR

USE db7am

-- name starts with 'a'.
SELECT * FROM cust WHERE name LIKE 'a%'

-- name ends with 'y'.
SELECT * FROM cust WHERE name LIKE '%y'

-- name contains 'a'.
SELECT * FROM cust WHERE name LIKE '%a%'

-- where 'i' is the 4th character.
SELECT * FROM cust WHERE name LIKE '___i%'

-- Where name hold only 4 characters.
SELECT * FROM cust WHERE name LIKE '____'

-- Name start with Vowels.
SELECT * FROM cust WHERE name LIKE '[aeiou]%'

-- Name starts between a and p.
SELECT * FROM cust WHERE name LIKE '[a-p]%'

--------------------------------------------------------
INSERT INTO emp (empid,ename,job,sal,hiredate,dept)
VALUES
(101, 'akash', 'se', 42345, '2018-10-12', 'dev'),
(102, 'prakash', 'ad', 56784, '2020-12-23', 'crt'),
(103, 'bhuvan', 'an', 60970, '2022-06-20', 'anz'),
(104, 'chandan', 'ds', 90345, '2024-09-21', 'ml'),
(105, 'jain', 'hr', 70865, '2016-04-07', 'rt')

SELECT * FROM emp

-- salary 8 digits
SELECT * FROM emp WHERE sal LIKE '________'

-- customer hired in april month
SELECT * FROM emp WHERE hiredate LIKE '_____04%'

--Customer hired in 2020.
SELECT * FROM emp WHERE hiredate LIKE '2020%'

-- Customer hired in first 9 days.
SELECT * FROM emp WHERE hiredate LIKE '%0_'

create table hero(
id tinyint,
name varchar(30))

INSERT INTO hero (id, name)
values
(01, 'amir_khan'),
(02, 'salman_khan'),
(03, 'saif_ali_khan'),
(04, 'akshay%kumar')

SELECT * FROM hero

--list of hero name contains '_'.
SELECT * FROM hero WHERE name LIKE '%\_%' ESCAPE '\'

-- name contains '%'.
SELECT * FROM hero WHERE name LIKE '%\%%' ESCAPE '\'

-- name contains 2 '_', that can be anywhere.
SELECT * FROM hero WHERE name LIKE '%\_%\_%' ESCAPE '\'
