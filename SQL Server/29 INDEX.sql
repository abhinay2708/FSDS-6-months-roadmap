-- INDEX--
------------
-- Index is also a db object created to improve the performance of data accsseing
-- index make data accessing faster
-- index in db is similar to in textbook, in textbook using index a particular topic can be located fastly 
--in db using index a particular row can be located fastly
-- indexes created on columns and that column is called index key
-- indexes created on columns 1 that are fequently used in where caluse 2 that are used in join operation
-- CREATE INDEX <NAME> ON <TABLENAME> (COLUMNNMAE)
-- INDEX IMPROVES PERFORMANCE BEACAUSE NO NEED TO SEARCH WHOLE TABLE IT ONLY SEARH VIA THE BTREE AND SEARCH ONLY HALF OF THE TABLE

-- Types of indexes
-- Non Clustered
--Clustered

--EX:-Non Clustered-- 
-- It stores the addresses of the records that stored in table.
-- Index and Tables are two seperate objects
CREATE INDEX I1 ON employee(SAL)

SELECT * FROM employee WHERE ENAME='BLAKE'

SELECT * FROM employee WHERE SAL=3000

-- Clustered Index:-- 
--It stores the actual records.
-- Index and Tables are one object
--ex:-
CREATE TABLE EX(cid INT, cname VARCHAR(10))

CREATE CLUSTERED INDEX I10 on ex(cid)

INSERT INTO EX VALUES(10, 'A')
INSERT INTO EX VALUES(80, 'B')
INSERT INTO EX VALUES(40, 'C')
INSERT INTO EX VALUES(60, 'D')

SELECT * FROM EX

-- It's fetch the data from index not from table that's why it fetch the data in ascending order.
-- for the above query sql server go to index and access all leaf nodes from left to right.

SELECT * FROM EX WHERE cid=40
-- For the above query sql server goes to index and finds entry cid=40 and returns row from index.
-- in CLUSTERED INDEX  there are only 1 lookup that is index because here index and table are one not different.

--How to see the actual query execution plan 
-- just go to the Query and click and choose the include actual execution plan 

-- Difference between non clustered and clustered index?
--			non clustered								clustered
--	stores addresses of actual records				stores actual records
--	index and table are seperate object				index and table are one object
--	needs extra storage								doesn't need extra storage
--	needs two lookup								needs one lookup
--	by default it is created on unique columns		it is created on primary key columns
--	by default sql server allows 999 non clusterd	only one clusterd index allowed per table
--  indexes per table

-- To see the list of indexes.
sp_helpindex ex

-- Droping--
DROP INDEX employee.I1