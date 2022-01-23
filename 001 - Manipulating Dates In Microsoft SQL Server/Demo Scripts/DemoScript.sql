DECLARE @Dates TABLE 
(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[Date] [date] NULL
)

DECLARE 
	@BaseDateTime DATETIME,
	@BaseDate DATE,
	@Cnt INT = 0,
	@MaxLoop INT = 365

SET @BaseDateTime = DATEADD(month,DATEDIFF(month,0,GETDATE()),0)

WHILE @Cnt <= @MaxLoop

BEGIN

IF @Cnt != 0 

BEGIN

SET @BaseDateTime = @BaseDateTime + 1

END

SET @BaseDate = CAST(@BaseDateTime as DATE)

INSERT INTO @Dates([DateTime],[Date])
VALUES
(@BaseDateTime,@BaseDate)

SET @Cnt = @Cnt + 1

END

/*Don't Change anything above here */

SELECT TOP 100 PERCENT

	[DateTime],
	DATEPART(dd,[DateTime]) as [DayOfMonth],
	DATEPART(mm,[DateTime]) as [MonthDatePart], 
	MONTH([DateTime]) as [Month],
	DATEPART(yy,[DateTime]) as [Year],
	DATEPART(dw,[DateTime]) as [DayOfWeek],
	DATENAME(dw,[DateTime]) as [DayOfWeekName],
	CASE
        WHEN MONTH([DateTime]) BETWEEN 1 AND 3 THEN 'Q3'
        WHEN MONTH([DateTime]) BETWEEN 4 AND 6 THEN 'Q4'
        WHEN MONTH([DateTime]) BETWEEN 7 AND 9 THEN 'Q1'
        WHEN MONTH([DateTime]) BETWEEN 10 AND 12 THEN 'Q2'
    END AS [Quarter],
	CASE WHEN DatePart(Month, [DateTime]) >= 4
            THEN CAST(DatePart(Year, [DateTime]) as varchar) + '/' + CAST(DatePart(Year, [DateTime]) + 1 as varchar)
            ELSE CAST(DatePart(Year, [DateTime]) - 1 as varchar) + '/' + CAST(DatePart(Year, [DateTime]) as varchar)
       END AS Financial_Year,
	DATEADD(dd,1,[DateTime]) as DatePlusOneDay,
	DATEADD(mm,1,[DateTime]) as DatePlusOneMonth,
	DATEADD(yy,1,[DateTime]) as DatePlusOneYear,
	DATEADD(dd,-1,[DateTime]) as DateMinusOneDay,
	DATEADD(mm,-1,[DateTime]) as DateMinusOneMonth,
	DATEADD(yy,-1,[DateTime]) as DateMinusOneYear,
	DATEADD(dd,-(DATEPART(dw, [DateTime])-1), [DateTime]) StartOfTheWeek,
	DATEADD(dd,-(DATEPART(dw, [DateTime])-1), [DateTime]) EndOfTheWeek,
	DATEADD(day,-7,DATEADD(wk,DATEDIFF(wk,6,[DateTime]),6)) StartOfPreviousWeek,
	DATEADD(month,DATEDIFF(month,0,[DateTime]),0) StartOfMonth

FROM	
	@Dates
ORDER BY 
	[DateTime]
GO