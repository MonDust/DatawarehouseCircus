/*
    Date of Preparation:
    Subject: Circus Database - HHRating
    Description: The Database for a Circus, a file loading all the data into tables.
*/
Use Circus;

BULK INSERT dbo.Performance FROM 'C:\Users\maria\Desktop\PG\SEM_IV\Data_warehouses\My_work\main_files\performancesT2.txt' WITH (FIELDTERMINATOR='|');
BULK INSERT dbo.Show FROM 'C:\Users\maria\Desktop\PG\SEM_IV\Data_warehouses\My_work\main_files\showsT2.txt' WITH (FIELDTERMINATOR='|');
BULK INSERT dbo.Circus_place FROM 'C:\Users\maria\Desktop\PG\SEM_IV\Data_warehouses\My_work\main_files\circus_placesT2.txt' WITH (FIELDTERMINATOR='|');
BULK INSERT dbo.Ticket FROM 'C:\Users\maria\Desktop\PG\SEM_IV\Data_warehouses\My_work\main_files\ticketsT2.txt' WITH (FIELDTERMINATOR='|');
BULK INSERT dbo.Rating FROM 'C:\Users\maria\Desktop\PG\SEM_IV\Data_warehouses\My_work\main_files\ratingsT2.txt' WITH (FIELDTERMINATOR='|');
BULK INSERT dbo.Animals FROM 'C:\Users\maria\Desktop\PG\SEM_IV\Data_warehouses\My_work\main_files\animalsT2.txt' WITH (FIELDTERMINATOR='|');
BULK INSERT dbo.Take_part_in FROM 'C:\Users\maria\Desktop\PG\SEM_IV\Data_warehouses\My_work\main_files\take_part_insT2.txt' WITH (FIELDTERMINATOR='|');
BULK INSERT dbo.Performers FROM 'C:\Users\maria\Desktop\PG\SEM_IV\Data_warehouses\My_work\main_files\performersT2.txt' WITH (FIELDTERMINATOR='|');
BULK INSERT dbo.Perform_in FROM 'C:\Users\maria\Desktop\PG\SEM_IV\Data_warehouses\My_work\main_files\perform_insT2.txt' WITH (FIELDTERMINATOR='|');