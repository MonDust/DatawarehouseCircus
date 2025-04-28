Use CircusDW;

INSERT INTO Performance (PerformanceName, PerformanceType, Designer)
VALUES ('The Lion King', 'acrobatics', 'Julie Taymor'),
       ('Swan Lake', 'clown acts', 'Pyotr Ilyich Tchaikovsky'),
       ('Hamlet', 'juggling', 'William Shakespeare'),
	   ('Big Perf', 'juggling', 'William Shakespeare');

INSERT INTO Performers (PersonNumber, FirstName, LastName, Education, DateOfAcceptance, YearOfAcceptance, TimeOfAcceptance, DateOfEndOfWork, YearOfEndOfWork, StatusOfPerformer, Specialization, IsCurrent)
VALUES (1, 'Emma', 'Watson', 'Primary', '2010-05-15', 2010, '2006-2010', NULL, NULL, 'employed', 'clown acts', 1),
       (2, 'Tom', 'Hiddleston', 'High School', '2009-08-20', 2009, '2006-2010', NULL, NULL, 'employed', 'acrobatics', 1),
       (3, 'Natalie', 'Portman', 'PhD', '2001-11-10', 2001, '2001-2005', NULL, NULL, 'employed', 'clown acts', 1);

INSERT INTO Animals (AnimalNumber, Name, Species, DateOfAcquired, TimeOfHavingTheAnimal, DateOfLoss, AnimalStatus, LastVeterinaryVisit, TimeFromVeterinaryVisit, IsCurrent)
VALUES (1, 'Simba', 'Lion', '2010-03-01', 'medium', NULL, 'available', '2017-12-15', 'medium ago', 1),
       (2, 'Odette', 'Swan', '2009-06-10', 'long', NULL, 'available', '2017-09-20', 'medium ago', 1),
       (3, 'Yorick', 'Rabbit', '2007-01-15', 'very long', NULL, 'not available', '2017-11-30', 'medium ago', 1);

INSERT INTO TicketType (Type, PossibilityExchange)
VALUES ('VIP', 'Yes'),
       ('Normal', 'Yes'),
       ('Reduced', 'No');

INSERT INTO Seating (NumberOfSeats, SeatLocation)
VALUES (21, 'Front down'),
       (130, 'Left side'),
       (150, 'Far from stage');

INSERT INTO Times (Hour, TimeOfDay)
VALUES (14, 'between 13 and 15'),
       (20, 'between 16 and 20'),
       (10, 'between 9 and 12');

INSERT INTO Places (Address, City)
VALUES ('402 Bowman Loop Suite 790Port Leslie, NV 97953', 'Port Lisaborough'),
       ('051 Eric Mountain Apt. 202South Brandon, DE 24791', 'East Christinehaven'),
       ('32254 George Square Apt. 446West Mark, WA 10620', 'Donfort');


INSERT INTO Date (FullDate, Year, Month, MonthNo, DayOfWeek, DayOfWeekNo, Holiday, BeforeHolidayDay, Quarter, Season)
VALUES ('2018-04-15', 2018, 'April', 4, 'Friday', 6, NULL, NULL, 2, 'Spring'),
       ('2010-04-16', 2010, 'April', 4, 'Saturday', 7, 'Easter', 'Good Friday', 2, 'Spring'),
       ('2018-12-17', 2018, 'December', 12, 'Sunday', 1, NULL, NULL, 4, 'Winter');

INSERT INTO IsIn (PerformanceID, AnimalID)
VALUES (1, 1),
       (2, 2),
       (3, 3),
	   (4, 1),
	   (4, 2);

INSERT INTO TakingPart (PerformanceID, PersonID)
VALUES (1, 1),
       (2, 2),
       (3, 3),
	   (4, 1),
	   (4, 2),
	   (4, 3);

INSERT INTO TicketAcquiring (TicketTypeID, SeatingID, PerformanceID, TicketNumber)
VALUES (1, 1, 1, 234),
       (2, 2, 2, 358),
       (3, 3, 3, 105),
	   (1, 2, 4, 121);

INSERT INTO PerformanceEvaluation (PerformanceID, StartDateTimeID, EndDateTimeID, DateID, PlaceID, SeatingID, TicketTypeID, RatingID, SatisfactionRate, CleanlinessRate, Duration)
VALUES (1, 1, 2, 1, 1, 1, 1, 234, 5, 4, 120),
       (2, 2, 3, 2, 2, 2, 2, 258, 4, 3, 130),
       (3, 3, 1, 3, 3, 3, 3, 105, 4, 4, 140),
	   (4, 2, 3, 2, 2, 2, 2, 268, 2, 2, 150),
	   (4, 2, 3, 2, 2, 3, 2, 290, 9, 6, 150),
	   (2, 2, 3, 2, 2, 1, 2, 201, 8, 7, 150);