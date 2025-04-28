USE CircusDW;
GO

/*
CREATE TABLE TicketAcquiring (
    TicketTypeID INT,
    SeatingID INT,
    PerformanceID INT,
    TicketNumber INT, -- degenerate dimension
    FOREIGN KEY (TicketTypeID) REFERENCES TicketType(TicketTypeID),
    FOREIGN KEY (SeatingID) REFERENCES Seating(SeatingID),
    FOREIGN KEY (PerformanceID) REFERENCES Performance(PerformanceID),

	CONSTRAINT ticketaquiring_pk PRIMARY KEY (
		TicketTypeID,
		SeatingID,
		PerformanceID)
);
*/

If (object_id('vETLTicketAcquiring') is not null) Drop view vETLTicketAcquiring;
go

CREATE VIEW vETLTicketAcquiring
AS
SELECT DISTINCT
    tt.TicketTypeID AS TicketTypeID, 
    s.SeatingID AS SeatingID,         
    t.performance_ID AS PerformanceID,
    t.ticket_number AS TicketNumber   
FROM Circus.dbo.Ticket t
JOIN CircusDW.dbo.TicketType tt ON t.type = tt.Type
JOIN CircusDW.dbo.Seating s ON t.seat_number = s.NumberOfSeats
JOIN CircusDW.dbo.Performance p ON t.performance_ID = p.PerformanceID;
 
go



MERGE INTO CircusDW.dbo.TicketAcquiring AS target
USING vETLTicketAcquiring AS source
ON (
    target.TicketTypeID = source.TicketTypeID AND
    target.SeatingID = source.SeatingID AND
    target.PerformanceID = source.PerformanceID AND
    target.TicketNumber = source.TicketNumber
)
WHEN NOT MATCHED THEN
    INSERT (TicketTypeID, SeatingID, PerformanceID, TicketNumber)
    VALUES (source.TicketTypeID, source.SeatingID, source.PerformanceID, source.TicketNumber);


If (object_id('vETLTicketAcquiring') is not null) Drop view vETLTicketAcquiring;
go