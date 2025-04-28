USE CircusDW
GO

IF OBJECT_ID('vPerformanceEvaluation') IS NOT NULL
    DROP VIEW vPerformanceEvaluation;
GO
CREATE VIEW vPerformanceEvaluation
AS
SELECT DISTINCT
    pe2.PerformanceID AS PerformanceID,
    --tim_start.TimeID AS StartTimeID,
    --tim_end.TimeID AS EndTimeID,
    --dat.DateID AS DateID,
    --show.place_ID AS PlaceID,
    seat.SeatingID AS SeatingID,
    tt.TicketTypeID AS TicketTypeID,
    r.rating_ID AS RatingID,
    r.satisfaction_rating AS SatisfactionRate,
    r.cleanliness_rating AS CleanlinessRate --,
    --CONVERT(DECIMAL(3,1), (r.satisfaction_rating + 0.0 + r.cleanliness_rating) / 2) AS AverageRate,
    --DATEDIFF(MINUTE, show.hour_start, show.hour_end) AS Duration
FROM
    Circus.dbo.Rating r
JOIN
	Circus.dbo.Ticket tick ON tick.ticket_number = r.ticket_number
JOIN
	CircusDW.dbo.TicketType tt ON tt.Type = tick.type
JOIN
	CircusDW.dbo.Seating seat ON seat.NumberOfSeats = tick.seat_number
/* JOIN
	Circus.dbo.Show show ON show.performance_ID = tick.performance_ID */
JOIN
	CircusDW.dbo.Performance pe2 ON tick.performance_ID = pe2.PerformanceID
/*
JOIN
	CircusDW.dbo.Date dat ON dat.FullDate = show.date
JOIN
	CircusDW.dbo.Times tim_start ON tim_start.Hour = DATEPART(HOUR, show.hour_start)
JOIN
	CircusDW.dbo.Times tim_end ON tim_end.Hour =  DATEPART(HOUR, show.hour_end)*/	;



GO


MERGE INTO PerformanceEvaluation AS target
USING vPerformanceEvaluation AS source
ON (
    target.PerformanceID = source.PerformanceID AND
   -- target.StartDateTimeID = source.StartTimeID AND
    --target.EndDateTimeID = source.EndTimeID AND
    --target.DateID = source.DateID AND
    --target.PlaceID = source.PlaceID AND
    target.SeatingID = source.SeatingID AND
    target.TicketTypeID = source.TicketTypeID AND
    target.RatingID = source.RatingID
)
WHEN NOT MATCHED THEN
    INSERT (
        PerformanceID,
        --StartDateTimeID,
        --EndDateTimeID,
        --DateID,
        --PlaceID,
        SeatingID,
        TicketTypeID,
        RatingID,
        SatisfactionRate,
        CleanlinessRate --,
        --Duration
    )
    VALUES (
        source.PerformanceID,
        --source.StartTimeID,
        --source.EndTimeID,
        --source.DateID,
        --source.PlaceID,
        source.SeatingID,
        source.TicketTypeID,
        source.RatingID,
        source.SatisfactionRate,
        source.CleanlinessRate --,
        --source.Duration
    );
GO

IF OBJECT_ID('vPerformanceEvaluation') IS NOT NULL
    DROP VIEW vPerformanceEvaluation;

