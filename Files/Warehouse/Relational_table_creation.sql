Use CircusDW;


CREATE TABLE Performance (
    PerformanceID INT IDENTITY(1,1) PRIMARY KEY,
    PerformanceName VARCHAR(MAX),
	PerformanceType VARCHAR(255),
    Designer VARCHAR(255)
);


CREATE TABLE Performers (
    PersonID INT IDENTITY(1,1) PRIMARY KEY,
	PersonNumber INT,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Education VARCHAR(255),
    DateOfAcceptance DATE,
	YearOfAcceptance INT,
	TimeOfAcceptance VARCHAR(255),
    DateOfEndOfWork DATE,
	YearOfEndOfWork INT,
	StatusOfPerformer VARCHAR(255),
    Specialization VARCHAR(255),
    IsCurrent BIT,
	EntryDate datetime,
	ExpiryDate datetime
);


CREATE TABLE Animals (
    AnimalID INT IDENTITY(1,1) PRIMARY KEY,
	AnimalNumber INT,
    Name VARCHAR(255),
    Species VARCHAR(255),
    DateOfAcquired DATE,
	TimeOfHavingTheAnimal VARCHAR(255),
    DateOfLoss DATE,
	AnimalStatus VARCHAR(255),
    LastVeterinaryVisit DATE,
	TimeFromVeterinaryVisit VARCHAR(255),
    IsCurrent BIT,
	EntryDate datetime,
	ExpiryDate datetime
);


CREATE TABLE TicketType (
    TicketTypeID INT IDENTITY(1,1) PRIMARY KEY,
    Type VARCHAR(255),
    PossibilityExchange VARCHAR(255)
);


CREATE TABLE Seating(
    SeatingID INT IDENTITY(1,1) PRIMARY KEY,
    NumberOfSeats INT,
    SeatLocation VARCHAR(255)
);

CREATE TABLE Times (
    TimeID INT IDENTITY(1,1) PRIMARY KEY,
    Hour INT,
    TimeOfDay VARCHAR(255)
);


CREATE TABLE Places (
    PlaceID INT IDENTITY(1,1) PRIMARY KEY,
    Address VARCHAR(MAX),
    City VARCHAR(255)
);


CREATE TABLE Date (
    DateID INT IDENTITY(1,1) PRIMARY KEY,
    FullDate DATE,
    Year INT,
    Month VARCHAR(255),
    MonthNo INT,
    DayOfWeek VARCHAR(255),
    DayOfWeekNo INT,
    Holiday VARCHAR(255),
    BeforeHolidayDay VARCHAR(255),
    Quarter INT,
    Season VARCHAR(255)
);

CREATE TABLE IsIn (
    PerformanceID INT,
    AnimalID INT,
    FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID),
    FOREIGN KEY (PerformanceID) REFERENCES Performance(PerformanceID),

	CONSTRAINT isin_pk PRIMARY KEY (
		AnimalID,
		PerformanceID)
);

CREATE TABLE TakingPart (
    PerformanceID INT,
    PersonID INT,
    FOREIGN KEY (PerformanceID) REFERENCES Performance(PerformanceID),
    FOREIGN KEY (PersonID) REFERENCES Performers(PersonID),

	CONSTRAINT takingpart_pk PRIMARY KEY (
		PerformanceID,
		PersonID)
);


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
		PerformanceID,
		TicketNumber)
);

CREATE TABLE PerformanceEvaluation (
    PerformanceID INT,
    --StartDateTimeID INT,
    --EndDateTimeID INT,
    --DateID INT,
    --PlaceID INT,
    SeatingID INT,
    TicketTypeID INT,
	RatingID INT, -- degenerate dimension
    SatisfactionRate INT,
    CleanlinessRate INT,
    AverageRate AS (CONVERT(DECIMAL(3,1), (SatisfactionRate + 0.0 + CleanlinessRate) / 2)),
    --Duration INT,


    FOREIGN KEY (PerformanceID) REFERENCES Performance(PerformanceID),
    --FOREIGN KEY (PlaceID) REFERENCES Places(PlaceID),
    --FOREIGN KEY (DateID) REFERENCES Date(DateID),
    FOREIGN KEY (SeatingID) REFERENCES Seating(SeatingID),
    FOREIGN KEY (TicketTypeID) REFERENCES TicketType(TicketTypeID),
	--FOREIGN KEY (StartDateTimeID) REFERENCES Times(TimeID),
	--FOREIGN KEY (EndDateTimeID) REFERENCES Times(TimeID),

	CONSTRAINT performanceeval_pk PRIMARY KEY (
		PerformanceID,
		SeatingID,
		TicketTypeID,
		RatingID)
);

CREATE TABLE AttendingTheShow (
	ShowID INT,
	PerformanceID INT,
    StartDateTimeID INT,
    EndDateTimeID INT,
    DateID INT,
    PlaceID INT,
	Duration INT,

	FOREIGN KEY (PerformanceID) REFERENCES Performance(PerformanceID),
	FOREIGN KEY (PlaceID) REFERENCES Places(PlaceID),
    FOREIGN KEY (DateID) REFERENCES Date(DateID),
	FOREIGN KEY (StartDateTimeID) REFERENCES Times(TimeID),
	FOREIGN KEY (EndDateTimeID) REFERENCES Times(TimeID),

	CONSTRAINT attendingtheshow_pk PRIMARY KEY (
	ShowID,
	PerformanceID,
	PlaceID,
	DateID,
	StartDateTimeID,
	EndDateTimeID)
);

GO
