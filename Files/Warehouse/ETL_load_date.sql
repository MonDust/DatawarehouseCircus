use CircusDW
go

Declare @StartDate date; 
Declare @EndDate date;

SELECT @StartDate = '1995-01-01', @EndDate = '2020-12-31';

-- Step c:  Use a while loop to add dates to the table
Declare @DateInProcess datetime = @StartDate;

While @DateInProcess <= @EndDate
	Begin
	--Add a row into the date dimension table for this date
		Insert Into [dbo].[Date] 
		( [FullDate]
		, [Year]
		, [Month]
		, [MonthNo]
		, [DayOfWeek]
		, [DayOfWeekNo]
		, [Holiday]
		, [BeforeHolidayDay]
		, [Quarter]
		, [Season]
		)
		Values ( 
		  @DateInProcess -- [FullDate]
		  , Cast( Year(@DateInProcess) as varchar(4)) -- [Year]
		  , Cast( DATENAME(month, @DateInProcess) as varchar(10)) -- [Month]
		  , Cast( Month(@DateInProcess) as int) -- [MonthNo]
		  , Cast( DATENAME(dw,@DateInProcess) as varchar(15)) -- [DayOfWeek]
		  , Cast( DATEPART(dw, @DateInProcess) as int) -- [DayOfWeekNo]
		  , 'non-holiday'
		  , 'non-holiday day tomorrow'
		  , 
		  CASE 
              WHEN MONTH(@DateInProcess) BETWEEN 1 AND 3 THEN 1
              WHEN MONTH(@DateInProcess) BETWEEN 4 AND 6 THEN 2
              WHEN MONTH(@DateInProcess) BETWEEN 7 AND 9 THEN 3
              ELSE 4
          END
          , 
          CASE 
              WHEN MONTH(@DateInProcess) IN (12, 1, 2) THEN 'Winter'
              WHEN MONTH(@DateInProcess) IN (3, 4, 5) THEN 'Spring'
              WHEN MONTH(@DateInProcess) IN (6, 7, 8) THEN 'Summer'
              ELSE 'Fall'
          END
		);  
		Set @DateInProcess = DateAdd(d, 1, @DateInProcess);
	End
go


If (object_id('vETLDimDatesData') is not null) Drop View vETLDimDatesData;
go

CREATE VIEW vETLDimDatesData
AS
SELECT 
	dd.DateID
	, dd.FullDate
	, dd.Year
	, dd.Month,
	dd.MonthNo
	, dd.DayOfWeek
	, dd.DayOfWeekNo
	, CASE	
		WHEN ah1.HolidayName is not null THEN ah1.HolidayName
		ELSE 'non-holiday'
	  END AS [Holiday]
	, CASE 
		WHEN ah2.BeforeHolidayDay is not null THEN ah2.BeforeHolidayDay
		ELSE 'jutro non-holiday'
	  END AS [BeforeHolidayDay]
	  , dd.Quarter
	  , dd.Season

FROM 
    auxiliary.dbo.holidays ah1
RIGHT JOIN 
    [dbo].[Date] AS dd ON dd.FullDate = ah1.Date
LEFT JOIN 
    (SELECT DATEADD(day, -1, Date) AS d, 'Jutro ' + HolidayName AS BeforeHolidayDay FROM auxiliary.dbo.holidays) AS ah2 ON dd.FullDate = ah2.d;
GO


MERGE INTO Date as TT
	USING vETLDimDatesData as ST
		ON TT.FullDate = ST.FullDate
			WHEN Matched
			THEN 
				UPDATE
				SET TT.Holiday = ST.Holiday,
					TT.BeforeHolidayDay = ST.BeforeHolidayDay
			;


Drop View vETLDimDatesData;
