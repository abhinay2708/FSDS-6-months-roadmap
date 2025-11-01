-- Creating a sales table and insert the sales.csv file

CREATE TABLE salesdata(
[Ship Mode] VARCHAR(50),
Segment VARCHAR(50),
Country VARCHAR(50),
City VARCHAR(50),
State VARCHAR(50),
[Postal Code] VARCHAR(50),
Region VARCHAR(50),
Category VARCHAR(50),
[Sub-Category] VARCHAR(50),
Sales VARCHAR(50),
Quantity VARCHAR(50),
Discount VARCHAR(50),
Profit VARCHAR(50))


 BULK INSERT salesdata
 FROM 'C:\data\sales.csv'
 WITH (FORMAT='CSV',FIRSTROW = 2,  FIELDTERMINATOR = ',')

 SELECT * FROM salesdata

-- Display region wise total sales.
SELECT Region, SUM(CAST(Sales AS MONEY)) AS Total_Sales 
FROM salesdata
GROUP BY region

-- Display region wise within region category wise total sales.
SELECT REGION, CATEGORY, SUM(CAST(SALES AS MONEY)) AS TOTAL_SALES 
FROM salesdata
GROUP BY region, category
ORDER BY region ASC

-- Display region, state, category wise total sales.
SELECT Region, State, Category, SUM(CAST(SALES AS MONEY)) AS Total_sales
FROM salesdata 
GROUP BY Region, State, Category
ORDER BY Region ASC

-- Display East and West region wise state, category wise total sal.
SELECT Region, State, Category, SUM(CAST(SALES AS MONEY)) AS Total_Sales 
FROM salesdata
WHERE Region IN ('East', 'West')
GROUP BY Region, State, Category
ORDER BY Region, State, Category ASC

-- Change the sales data type varchar to money
ALTER TABLE salesdata ALTER COLUMN Sales MONEY
SP_HELP salesdata

-- To use currency symbol we have to use FORMAT()
SELECT Region, State, Category,
FORMAT(SUM(Sales), 'c', 'en-in') AS Total_sales
FROM salesdata
GROUP BY Region, State, Category
ORDER BY Region


