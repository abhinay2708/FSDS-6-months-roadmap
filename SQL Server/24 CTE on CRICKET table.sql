use db7am
-- Create the new table for the 2023 World Cup results (Team A, Team B, Winner format)
CREATE TABLE CRICKET(
    Match_id INT ,
    Team_a VARCHAR(255),
    Team_b VARCHAR(255),
    Winner VARCHAR(255)
)

-- Insert data into the new results table by extracting information from the original schedule data
INSERT INTO CRICKET (Match_id, Team_a, Team_b, Winner) VALUES
(1, 'England', 'New Zealand', 'New Zealand'),
(2, 'Pakistan', 'Netherlands', 'Pakistan'),
(3, 'Bangladesh', 'Afghanistan', 'Bangladesh'),
(4, 'South Africa', 'Sri Lanka', 'South Africa'),
(5, 'India', 'Australia', 'India'),
(6, 'New Zealand', 'Netherlands', 'New Zealand'),
(7, 'England', 'Bangladesh', 'England'),
(8, 'Pakistan', 'Sri Lanka', 'Pakistan'),
(9, 'India', 'Afghanistan', 'India'),
(10, 'Australia', 'South Africa', 'South Africa'),
(11, 'New Zealand', 'Bangladesh', 'New Zealand'),
(12, 'India', 'Pakistan', 'India'),
(13, 'England', 'Afghanistan', 'Afghanistan'),
(14, 'Australia', 'Sri Lanka', 'Australia'),
(15, 'South Africa', 'Netherlands', 'The Netherlands'),
(16, 'New Zealand', 'Afghanistan', 'New Zealand'),
(17, 'India', 'Bangladesh', 'India'),
(18, 'Australia', 'Pakistan', 'Australia'),
(19, 'Netherlands', 'Sri Lanka', 'Sri Lanka'),
(20, 'England', 'South Africa', 'South Africa'),
(21, 'India', 'New Zealand', 'India'),
(22, 'Pakistan', 'Afghanistan', 'Afghanistan'),
(23, 'South Africa', 'Bangladesh', 'South Africa'),
(24, 'Australia', 'Netherlands', 'Australia'),
(25, 'England', 'Sri Lanka', 'Sri Lanka'),
(26, 'Pakistan', 'South Africa', 'South Africa'),
(27, 'Australia', 'New Zealand', 'Australia'),
(28, 'Netherlands', 'Bangladesh', 'Netherlands'),
(29, 'India', 'England', 'India'),
(30, 'Afghanistan', 'Sri Lanka', 'Afghanistan'),
(31, 'Pakistan', 'Bangladesh', 'Pakistan'),
(32, 'New Zealand', 'South Africa', 'South Africa'),
(33, 'India', 'Sri Lanka', 'India'),
(34, 'Netherlands', 'Afghanistan', 'Afghanistan'),
(35, 'New Zealand', 'Pakistan', 'Pakistan'),
(36, 'England', 'Australia', 'Australia'),
(37, 'India', 'South Africa', 'India'),
(38, 'Bangladesh', 'Sri Lanka', 'Bangladesh'),
(39, 'Australia', 'Afghanistan', 'Australia'),
(40, 'England', 'Netherlands', 'England'),
(41, 'New Zealand', 'Sri Lanka', 'New Zealand'),
(42, 'South Africa', 'Afghanistan', 'South Africa'),
(43, 'Australia', 'Bangladesh', 'Australia'),
(44, 'England', 'Pakistan', 'England'),
(45, 'India', 'Netherlands', 'India'),
(46, 'India', 'New Zealand', 'India'),
(47, 'South Africa', 'Australia', 'Australia'),
(48, 'India', 'Australia', 'Australia')


SELECT * FROM CRICKET

with p As(
SELECT COUNTRY, COUNT(*) As Played FROM (
SELECT TEAM_a AS COUNTRY FROM CRICKET
UNION ALL
SELECT TEAM_b AS COUNTRY FROM CRICKET) AS e
GROUP BY COUNTRY),

W AS (
SELECT WINNER AS COUNTRY, COUNT(*) AS WON
FROM CRICKET
GROUP BY WINNER
)
SELECT P.Country, P.PLAYED, W.WON,  P.PLAYED - W.WON as lost
FROM p INNER JOIN W ON P.COUNTRY = W. COUNTRY
