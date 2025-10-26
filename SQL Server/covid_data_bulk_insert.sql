use db7am

SP_HELP covid

 BULK INSERT COVID
 FROM 'C:\data\covid_india.csv'
 WITH (FORMAT='CSV',FIRSTROW = 2,  FIELDTERMINATOR = ',')

 SELECT * FROM covid