USE CircusDW;
GO

If (object_id('vETLIsIN') is not null) Drop view vETLIsIN;
go


CREATE VIEW vETLIsIN
AS
SELECT DISTINCT
	AnimalID = dbo.Animals.AnimalNumber,
	PerformanceID = dbo.Performance.PerformanceID
FROM Circus.dbo.Take_part_in as ST1
JOIN dbo.Animals on dbo.Animals.AnimalNumber = ST1.animal_ID
JOIN dbo.Performance on dbo.Performance.PerformanceID = ST1.performance_ID
; 
go


MERGE INTO dbo.IsIn AS TT
USING vETLIsIN AS ST
ON TT.AnimalID = ST.AnimalID
AND TT.PerformanceID = ST.PerformanceID
WHEN NOT MATCHED THEN
    INSERT (PerformanceID, AnimalID)
    VALUES (ST.PerformanceID, ST.AnimalID);


If (object_id('vETLIsIN') is not null) Drop view vETLIsIN;
go