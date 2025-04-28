USE CircusDW;
GO

If (object_id('vETLTakingPart') is not null) Drop view vETLTakingPart;
go


CREATE VIEW vETLTakingPart
AS
SELECT DISTINCT
	PersonID = dbo.Performers.PersonNumber,
	PerformanceID = dbo.Performance.PerformanceID
FROM Circus.dbo.Perform_in as ST1
JOIN dbo.Performers on dbo.Performers.PersonNumber = ST1.person_ID
JOIN dbo.Performance on dbo.Performance.PerformanceID = ST1.performance_ID
; 
go


MERGE INTO dbo.TakingPart AS TT
USING vETLTakingPart AS ST
ON TT.PersonID = ST.PersonID
AND TT.PerformanceID = ST.PerformanceID
WHEN NOT MATCHED THEN
    INSERT (PerformanceID, PersonID)
    VALUES (ST.PerformanceID, ST.PersonID);


If (object_id('vETLTakingPart') is not null) Drop view vETLTakingPart;
go