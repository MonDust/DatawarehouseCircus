USE CircusDW
GO

DECLARE @MaxSeatNumber INT;

SELECT @MaxSeatNumber = MAX(seat_number) FROM Circus.dbo.Ticket;

IF @MaxSeatNumber IS NULL
BEGIN
SELECT @MaxSeatNumber = 500;
END

DECLARE @SeatingCount INT = 1;

WHILE @SeatingCount <= @MaxSeatNumber
BEGIN
    DECLARE @PlaceOfSeat VARCHAR(100);

    IF @SeatingCount BETWEEN 1 AND 30
        SET @PlaceOfSeat = 'Front down';
    ELSE IF @SeatingCount BETWEEN 31 AND 50
        SET @PlaceOfSeat = 'Front up';
    ELSE IF @SeatingCount BETWEEN 51 AND 70
        SET @PlaceOfSeat = 'Back down';
    ELSE IF @SeatingCount BETWEEN 71 AND 80
        SET @PlaceOfSeat = 'Back up';
    ELSE IF @SeatingCount BETWEEN 81 AND 120
        SET @PlaceOfSeat = 'Right side';
    ELSE IF @SeatingCount BETWEEN 121 AND 160
        SET @PlaceOfSeat = 'Left side';
    ELSE
        SET @PlaceOfSeat = 'Far from stage';

    INSERT INTO Seating (NumberOfSeats, SeatLocation)
    VALUES (@SeatingCount, @PlaceOfSeat);

    SET @SeatingCount = @SeatingCount + 1;
END;