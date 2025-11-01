SELECT * FROM EXAM

-- List of students who are absent in exactly 1 subject
SELECT * FROM exam 
WHERE 
(s1 IS NULL AND s2 IS NOT NULL AND s3 IS NOT NULL)
OR
(s1 IS NOT NULL AND s2 IS NULL AND s3 IS NOT NULL)
OR 
(s1 IS NOT NULL AND s2 IS NOT NULL AND s3 IS NULL)

-- List of students who are absent in exactly 2 subject
SELECT * FROM exam 
WHERE 
(s1 IS NULL AND s2 IS NULL AND s3 IS NOT NULL)
OR
(s1 IS NULL AND s2 IS NOT NULL AND s3 IS NULL)
OR 
(s1 IS NOT NULL AND s2 IS NULL AND s3 IS NULL)

--List of stuents who absent in all the exams
SELECT * FROM exam WHERE 
(s1 IS NULL AND s2 IS NULL AND s3 IS NULL)
