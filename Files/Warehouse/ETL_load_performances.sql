USE CircusDW
GO

MERGE INTO Performance as TT
	USING Circus.dbo.Performance as ST
		ON TT.PerformanceName = ST.performance_name
		AND TT.PerformanceType = ST.performance_type
		AND TT.Designer = ST.designer
			WHEN Not Matched
				THEN
					INSERT
					Values (
					ST.performance_name,
					ST.performance_type,
					ST.designer
					)
			WHEN Not Matched By Source
				Then
					DELETE;