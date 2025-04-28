USE CircusDW
GO

MERGE INTO Places as TT
	USING Circus.dbo.Circus_place as ST
		ON TT.Address = ST.address
		AND TT.City = ST.city
			WHEN Not Matched
				THEN
					INSERT
					Values (
					ST.address,
					ST.city
					)
			WHEN Not Matched By Source
				Then
					DELETE
;
