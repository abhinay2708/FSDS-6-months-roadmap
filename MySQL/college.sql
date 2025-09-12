CREATE DATABASE college;
USE college;
CREATE TABLE student(
rollno INT PRIMARY KEY,
name VARCHAR(100),
marks INT NOT NULL,
grade VARCHAR(1),
city VARCHAR(10)
);
INSERT INTO student
(rollno,name,marks,grade,city)
VALUES
(101,"anil",78,"C","Pune"),
(102,"abhi",90,"A","West"),
(103,"abhinay",95,"A","Bengal"),
(104,"aman",76,"C","Jharkhand"),
(105,"Jyoti",60,"C","Bihar"),
(106,"Manish",70,"B","Namkum");

SELECT * FROM student;
SELECT DISTINCT grade FROM student;
SELECT * FROM student WHERE marks >80;
SELECT * FROM student WHERE city="West";
SELECT * FROM student WHERE marks>80 AND city="West";
SELECT * FROM student WHERE marks+10>100;
SELECT * FROM student WHERE marks=95;
SELECT * FROM student WHERE marks>90 AND city="Bengal";
SELECT * FROM student WHERE marks>80 OR city="Bengal";
SELECT * FROM student WHERE marks BETWEEN 70 AND 80;
SELECT * FROM student WHERE city IN("West","Bengal","Gurgaon");
SELECT * FROM student WHERE city  NOT IN("West","Bengal","Gurgaon");
SELECT * FROM student WHERE marks>80 LIMIT 3;
SELECT * FROM student ORDER BY city ASC;
SELECT * FROM student ORDER BY city DESC;
SELECT * FROM student ORDER BY marks DESC LIMIT 3;
SELECT marks FROM student;
SELECT MAX(marks) FROM student;
SELECT MIN(marks) FROM student;
SELECT AVG(marks) FROM student;
SELECT COUNT(name) FROM student;
SELECT city FROM student GROUP BY city;
SELECT city,COUNT(rollno) FROM student GROUP BY city;
SELECT city,name,COUNT(rollno) FROM student GROUP BY city,name;
SELECT city ,avg(marks) FROM student GROUP BY city ORDER BY avg(marks) DESC;
SELECT grade,count(name)FROM STUDENT GROUP BY grade order by grade;
SELECT city ,count(rollno) FROM student GROUP BY city HAVING MAX(marks)>=90; 
SET SQL_SAFE_UPDATES=0;
UPDATE student SET grade="O" WHERE GRADE="A";
SELECT* FROM student;
UPDATE student SET marks=75 WHERE rollno=105;
SELECT * FROM student;
UPDATE student SET grade='B' WHERE marks BETWEEN 69 AND 80;
select * from student;
UPDATE student SET marks=marks+1;
DELETE FROM student WHERE marks<75;
CREATE TABLE dept (
id INT PRIMARY KEY,
name VARCHAR(50)
);

CREATE TABLE teacher (
id INT PRIMARY KEY,
name VARCHAR(50),
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES dept(id)
);
ALTER TABLE student ADD COLUMN age INT;
SELECT * FROM student;
ALTER TABLE student ADD COLUMN age INT NOT NULL DEFAULT 20;
ALTER TABLE student DROP COLUMN age;
ALTER TABLE student MODIFY COLUMN age VARCHAR(2);
ALTER TABLE student CHANGE age stu_age INT;
INSERT INTO student(rollno,name,marks,grade,city,stu_age) 
VALUES (106,'BONI',85,'A','hyd',100);
ALTER TABLE student DROP COLUMN stu_age;
SELECT * FROM student;
ALTER TABLE student RENAME TO stu;
ALTER TABLE stu RENAME TO student;
TRUNCATE TABLE student;
ALTER TABLE student CHANGE name full_name VARCHAR(50);
DELETE FROM student WHERE marks<80;
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE student DROP COLUMN grade;
select * from student;
truncate table student;
alter table student;



