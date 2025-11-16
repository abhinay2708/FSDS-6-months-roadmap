--VIEW--

CREATE VIEW V1
AS
SELECT D.DNAME, SUM(E.SAL) AS TOTALSAL
FROM EMPLOYEE AS E INNER JOIN DEPT AS D ON E.DEPTNO=D.DEPTNO 
GROUP BY D.DNAME

-- WHEN Above command is executed sql server stores query but not query output and whenever we want dept wise total sal
-- then instead of executing complex query execute the followng query
SELECT * FROM V1

-- SYNONYMS--
-- a synonym is another name or alternate name for a table or view
-- ex:- emp_personal_details_t =>short name , epd
-- If table name is lengthy tehn we can give a simple and short name to the table called synonyms.
-- Instead of using tablename we can use synonyms name in select/insert/update/delete.
-- CREATE SYNONYM <NAME> FOR <TABNAME>
--EX:- CREATE E FOR EMPloyee
CREATE SYNONYM E FOR employee

-- WHat is the difference between alias and synonym?
--			ALIAS					SYNONYM
--			-----					-------
--	not stored in db			stored in db
--	not permanent				permanent
-- scope of alias is			scope of the synonym is upto the db
-- upto the query in which
-- it is declared



-- SEQUENCE--
-- sequence is also a db object to generate sequence numbers.
-- used to autoencrement column values
-- CREATE SEQUENCE <name> [START WITH <value>] 
--						  [INCREMENT BY <value>]
--						  [MAXVALUE<value>]
--						  [MINVALUE <value>]
--						  [CYCLE/NONCYCLE]

-- EX:-
CREATE SEQUENCE S1 
	START WITH 1 
	INCREMENT BY 1  
	MAXVALUE 5


CREATE TABLE std(sid INT, sname VARCHAR(10))

-- use sequence s1 to generate values for sid for every new student.
INSERT INTO std VALUES(NEXT VALUE FOR S1, 'A')
INSERT INTO std VALUES(NEXT VALUE FOR S1, 'B')
INSERT INTO std VALUES(NEXT VALUE FOR S1, 'C')
INSERT INTO std VALUES(NEXT VALUE FOR S1, 'D')
INSERT INTO std VALUES(NEXT VALUE FOR S1, 'E')
INSERT INTO std VALUES(NEXT VALUE FOR S1, 'F') --=> this commands give error because max value =5.

SELECT * FROM std

-- ex: 2
CREATE SEQUENCE S2 
	START WITH 100 
	INCREMENT BY 1 
	MAXVALUE 9999

-- Use sequence S2 to generate value for empno for existing employees.
UPDATE employee SET EMPNO = NEXT VALUE FOR S2

SELECT * FROM employee

--ex 3
CREATE TABLE BILL(
BILLNO VARCHAR(30),
BDATE DATETIME,
AMT MONEY)

CREATE SEQUENCE S5 START WITH 1 INCREMENT BY 1
MAXVALUE 9999

-- Use sequence s5 to generate billno for every new bill 
INSERT INTO BILL VALUES('DM/'+FORMAT(GETDATE(),'ddMMyy')+'/'+ CAST(NEXT VALUE FOR S5 AS VARCHAR), GETDATE(), 2000)
INSERT INTO BILL VALUES('DM/'+FORMAT(GETDATE(),'ddMMyy')+'/'+ CAST(NEXT VALUE FOR S5 AS VARCHAR), GETDATE(), 3000)
INSERT INTO BILL VALUES('DM/'+FORMAT(GETDATE(),'ddMMyy')+'/'+ CAST(NEXT VALUE FOR S5 AS VARCHAR), GETDATE(), 1000)

SELECT * FROM BILL

-- How to restart sequence
-- using alter command
-- using cycle option

-- alter sequence
ALTER SEQUENCE S1 RESTART WITH 1

SELECT NEXT VALUE FOR S1

-- Scheduling to restart the sequnce everyday

-- cycle option
-- by default sequence created with no cycle, after reaching max value then it stops
-- if sequence created with cycle then after reaching max then it will be reset to min
--EX:=-

CREATE SEQUENCE S10 START WITH 1 INCREMENT BY 1 MAXVALUE 5 MINVALUE 1 CYCLE

SELECT NEXT VALUE FOR S10

-- DROPING:--
DROP SEQUENCE S1

-- IDENTITY--
-- IDENTITY IS ALSO used to genertae sequence numbers
-- used to auto increment column values
-- identity (seed, increment)

CREATE TABLE CUSTOMER
( CID INT IDENTITY(100,1),
CNAME VARCHAR(10))

INSERT INTO CUSTOMER (CNAME) VALUES('A')
INSERT INTO CUSTOMER (CNAME) VALUES('B')
INSERT INTO CUSTOMER (CNAME) VALUES('C')

SELECT * FROM CUSTOMER

-- Difference between identity and sequence
--			IDENTITY									SEQUENCE
--	bind to specific table specific column		not bind to any table or any column
--	not declare with maxvalue					declared with maxvalue
--	value of the identity cannot be accessed	sequence value can be accssed by using 'next value for seq'
--	can't be reste								can be reset
