USE CircusDW
GO

IF OBJECT_ID('vAttendingTheShows') IS NOT NULL
    DROP VIEW vAttendingTheShows;
GO
CREATE VIEW vAttendingTheShows
AS
SELECT DISTINCT
	pe.PerformanceID AS PerformanceID,
	show.show_num AS ShowID,
    tim_start.TimeID AS StartTimeID,
    tim_end.TimeID AS EndTimeID,
    dat.DateID AS DateID,
    show.place_ID AS PlaceID,
    DATEDIFF(MINUTE, show.hour_start, show.hour_end) AS Duration
FROM
	Circus.dbo.Show show
JOIN
	CircusDW.dbo.Performance pe ON pe.PerformanceID = show.performance_ID
JOIN
	CircusDW.dbo.Date dat ON dat.FullDate = show.date
JOIN
	CircusDW.dbo.Times tim_start ON tim_start.Hour = DATEPART(HOUR, show.hour_start)
JOIN
	CircusDW.dbo.Times tim_end ON tim_end.Hour =  DATEPART(HOUR, show.hour_end)	;



GO

MERGE INTO AttendingTheShow AS target
USING vAttendingTheShows AS source
ON (
	target.PerformanceID = source.PerformanceID AND
	target.ShowID = source.ShowID AND
    target.StartDateTimeID = source.StartTimeID AND
    target.EndDateTimeID = source.EndTimeID AND
    target.DateID = source.DateID AND
    target.PlaceID = source.PlaceID
)
WHEN NOT MATCHED THEN
    INSERT (
		PerformanceID,
		ShowID,
        StartDateTimeID,
        EndDateTimeID,
        DateID,
        PlaceID,
        Duration
    )
    VALUES (
		source.PerformanceID,
		source.ShowID,
        source.StartTimeID,
        source.EndTimeID,
        source.DateID,
        source.PlaceID,
        source.Duration
    );


IF OBJECT_ID('vAttendingTheShows') IS NOT NULL
    DROP VIEW vAttendingTheShows;

