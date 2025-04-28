USE CircusDW
GO

-- Drop temporary table if exists
IF OBJECT_ID('dbo.AnimalsTemp') IS NOT NULL 
    DROP TABLE dbo.AnimalsTemp;

-- Create temporary table to hold CSV data
CREATE TABLE dbo.AnimalsTemp(
    AnimalID INT,
    Name VARCHAR(255),
    Species VARCHAR(255),
    IsAvailable VARCHAR(255),
    DateAcquired DATE,
    DateLoss DATE,
    LastVeterinaryVisit DATE,
    LastCleaning DATE
);
GO

-- Bulk insert data from CSV into temporary table
BULK INSERT dbo.AnimalsTemp
FROM 'C:\Users\maria\Desktop\PG\SEM_IV\Data_warehouses\My_work\main_files\animalsT2.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    TABLOCK
);

DECLARE @EntryDate DATETIME; 
SELECT @EntryDate = GETDATE();

/*
DECLARE @CurrentDate DATETIME
SELECT @CurrentDate = MAX(MaxDate)
FROM (
    SELECT MAX(DateOfAcquired) AS MaxDate FROM Animals
    UNION ALL
    SELECT MAX(DateAcquired) AS MaxDate FROM AnimalsTemp
    UNION ALL
    SELECT MAX(DateOfLoss) AS MaxDate FROM Animals
    UNION ALL
    SELECT MAX(DateLoss) AS MaxDate FROM AnimalsTemp
    UNION ALL
    SELECT MAX(LastVeterinaryVisit) AS MaxDate FROM Animals
    UNION ALL
    SELECT MAX(LastVeterinaryVisit) AS MaxDate FROM AnimalsTemp
) AS Dates;
*/

MERGE INTO Animals AS target
USING AnimalsTemp AS source
ON target.AnimalNumber = source.AnimalID
WHEN NOT MATCHED THEN
    INSERT (
		AnimalNumber,
        Name,
        Species,
        DateOfAcquired,
        TimeOfHavingTheAnimal,
        DateOfLoss,
        AnimalStatus,
        LastVeterinaryVisit,
        TimeFromVeterinaryVisit,
        IsCurrent,
        EntryDate,
        ExpiryDate
    )
    VALUES (
		source.AnimalID,
        source.Name,
        source.Species,
        source.DateAcquired,
        Year(source.DateAcquired),
        source.DateLoss,
        CASE 
			WHEN (source.DateLoss IS NULL AND source.IsAvailable = 'yes') THEN 'Available'
			WHEN source.DateLoss IS NULL THEN 'Not Available'
			ELSE 'Dead'
		END,
        source.LastVeterinaryVisit,
        Year(source.LastVeterinaryVisit),
        1,
        @EntryDate,
        NULL
    )
WHEN MATCHED AND (
    target.Name <> source.Name OR
    target.Species <> source.Species OR
    target.DateOfAcquired <> source.DateAcquired OR
    target.DateOfLoss <> source.DateLoss OR
	target.AnimalStatus <> (CASE  
    WHEN (source.DateLoss IS NULL AND source.IsAvailable = 'yes') THEN 'Available'
    WHEN source.DateLoss IS NULL THEN 'Not Available'
    ELSE 'Dead'
END) OR
    target.LastVeterinaryVisit <> source.LastVeterinaryVisit
) THEN
    UPDATE SET target.IsCurrent = 0,
               target.ExpiryDate = @EntryDate;


INSERT INTO Animals(
	AnimalNumber,
    Name,
    Species,
    DateOfAcquired,
    TimeOfHavingTheAnimal,
    DateOfLoss,
    AnimalStatus,
    LastVeterinaryVisit,
    TimeFromVeterinaryVisit,
    IsCurrent,
    EntryDate,
    ExpiryDate
)
SELECT
	AnimalID,
    Name,
    Species,
    DateAcquired,
    Year(DateAcquired),
    DateLoss,
    CASE  
    WHEN (DateLoss IS NULL AND IsAvailable = 'yes') THEN 'Available'
    WHEN DateLoss IS NULL THEN 'Not Available'
    ELSE 'Dead'
END,
    LastVeterinaryVisit,
	Year(LastVeterinaryVisit),
    1,
    @EntryDate,
    NULL
FROM AnimalsTemp
EXCEPT
SELECT 
	AnimalNumber,
    Name,
    Species,
    DateOfAcquired,
    TimeOfHavingTheAnimal,
    DateOfLoss,
    AnimalStatus,
    LastVeterinaryVisit,
    TimeFromVeterinaryVisit,
    1,
    @EntryDate,
	NULL
FROM Animals;


-- Drop the temporary table
DROP TABLE dbo.AnimalsTemp;