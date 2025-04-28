USE CircusDW
GO

If (object_id('dbo.PerformersTemp') is not null) DROP TABLE dbo.PerformersTemp;
CREATE TABLE dbo.PerformersTemp(
	PersonID INT, 
	PIN varchar(100), 
	FirstName varchar(255), 
	LastName varchar(255), 
	DateOfBirth date, 
	Education varchar(255), 
	DateOfAcceptance date, 
	DateOfEndOfWork date, 
	Specialization varchar(255)
);
go

BULK INSERT dbo.PerformersTemp
    FROM 'C:\Users\maria\Desktop\PG\SEM_IV\Data_warehouses\My_work\main_files\employeesT2.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )

Declare @EntryDate datetime; 
SELECT @EntryDate = GETDATE();

MERGE INTO Performers AS target
USING PerformersTemp AS source
ON target.PersonNumber = source.PersonID
WHEN NOT MATCHED THEN
    INSERT (
        PersonNumber,
        FirstName,
        LastName,
        Education,
        DateOfAcceptance,
        YearOfAcceptance,
        TimeOfAcceptance,
        DateOfEndOfWork,
        YearOfEndOfWork,
        StatusOfPerformer,
        Specialization,
        IsCurrent,
		EntryDate,
		ExpiryDate
    )
    VALUES (
        source.PersonID,
        source.FirstName,
        source.LastName,
        COALESCE(source.Education, 'Other'),
        source.DateOfAcceptance,
        YEAR(source.DateOfAcceptance),
        CASE 
            WHEN YEAR(source.DateOfAcceptance) BETWEEN 1995 AND 2000 THEN '1995-2000'
            WHEN YEAR(source.DateOfAcceptance) BETWEEN 2001 AND 2005 THEN '2001-2005'
            WHEN YEAR(source.DateOfAcceptance) BETWEEN 2006 AND 2010 THEN '2006-2010'
            WHEN YEAR(source.DateOfAcceptance) BETWEEN 2011 AND 2015 THEN '2011-2015'
            WHEN YEAR(source.DateOfAcceptance) BETWEEN 2016 AND 2018 THEN '2016-2018'
            WHEN YEAR(source.DateOfAcceptance) BETWEEN 2019 AND 2020 THEN '2019-2020'
            ELSE 'Other'
        END,
        source.DateOfEndOfWork,
        YEAR(source.DateOfEndOfWork),
        CASE 
            WHEN source.DateOfEndOfWork IS NULL THEN 'Employed'
            ELSE 'Not Employed'
        END,
        COALESCE(source.Specialization, 'Other'),
        1,
		@EntryDate,
		NULL
    )
WHEN MATCHED AND (
    target.FirstName <> source.FirstName OR
    target.LastName <> source.LastName OR
    target.Education <> COALESCE(source.Education, 'Other') OR
    target.DateOfAcceptance <> source.DateOfAcceptance OR
    target.DateOfEndOfWork <> source.DateOfEndOfWork OR
    target.Specialization <> COALESCE(source.Specialization, 'Other')
) THEN
	UPDATE SET target.IsCurrent = 0,
		target.ExpiryDate = @EntryDate;

INSERT INTO Performers(
	PersonNumber,
    FirstName,
    LastName,
    Education,
    DateOfAcceptance,
    YearOfAcceptance,
    TimeOfAcceptance,
    DateOfEndOfWork,
    YearOfEndOfWork,
    StatusOfPerformer,
    Specialization,
    IsCurrent,
	EntryDate,
	ExpiryDate
	)
	SELECT 
		PersonID AS PersonNumber,
		FirstName,
		LastName,
		COALESCE(Education, 'Other'),
		DateOfAcceptance,
		YEAR(DateOfAcceptance) AS YearOfAcceptance,
		CASE 
			WHEN YEAR(DateOfAcceptance) BETWEEN 1995 AND 2000 THEN '1995-2000'
			WHEN YEAR(DateOfAcceptance) BETWEEN 2001 AND 2005 THEN '2001-2005'
			WHEN YEAR(DateOfAcceptance) BETWEEN 2006 AND 2010 THEN '2006-2010'
			WHEN YEAR(DateOfAcceptance) BETWEEN 2011 AND 2015 THEN '2011-2015'
			WHEN YEAR(DateOfAcceptance) BETWEEN 2016 AND 2018 THEN '2016-2018'
			WHEN YEAR(DateOfAcceptance) BETWEEN 2019 AND 2020 THEN '2019-2020'
			ELSE 'Other'
		END AS TimeOfAcceptance,
		DateOfEndOfWork,
		YEAR(DateOfEndOfWork) AS YearOfEndOfWork,
		CASE 
			WHEN DateOfEndOfWork IS NULL THEN 'Employed'
			ELSE 'Not Employed'
		END AS StatusOfPerformer,
		COALESCE(Specialization, 'Other'),
		1,
		@EntryDate,
		NULL
	FROM PerformersTemp
	EXCEPT
	SELECT 
		PersonNumber,
		FirstName,
		LastName,
		Education,
		DateOfAcceptance,
		YearOfAcceptance,
		TimeOfAcceptance,
		DateOfEndOfWork,
		YearOfEndOfWork,
		StatusOfPerformer,
		Specialization,
		1,
		@EntryDate,
		NULL
	FROM Performers;

-- Drop the temporary table
DROP TABLE PerformersTemp;
