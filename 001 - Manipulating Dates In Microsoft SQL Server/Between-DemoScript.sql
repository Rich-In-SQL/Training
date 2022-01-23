DECLARE @Dates TABLE ([id] [int] IDENTITY(1,1) NOT NULL,[val] [datetime] NULL)

INSERT INTO @Dates (val)
VALUES
('2022-09-23 00:00:00.000'),
('2022-09-24 00:00:00.000'),
('2022-09-24 00:01:00.000'),
('2022-09-24 01:00:00.000'),
('2022-09-23 11:15:00.000')

SELECT * FROM @Dates

SELECT 'When we think about between, we want everything between the two dates passed but if we run the below 
query that isn''t what we get. The 24th September is included where the date is 12:00 AM as you can see
the entry for the 24th where the time is 1am is no included. 
This gives us inaccurate results'

Select * from @Dates
WHERE 
	val BETWEEN '23-Sep-2022' 
	AND '24-Sep-2022' --Bug if Time 12:00 AM , it will be included


SELECT 'To resolve this we can make use of the greater than > and less than operators <, if we have a look at the below 
query, this says give me all rows where the val is greater than or equal to the date passed 
AND where val is less than the date passed'

Select * from @Dates
WHERE val >= '23-Sep-2022' AND val < '24-Sep-2022'