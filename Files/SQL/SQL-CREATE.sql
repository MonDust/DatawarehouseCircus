/*
    Subject: Circus Database - HHRating
    Description: The Database for a Circus, a file creating all tables.
*/

Use Circus;

CREATE TABLE Performance (
    performance_ID INT PRIMARY KEY,
    performance_name VARCHAR(100) NOT NULL,
    performance_type VARCHAR(50) CHECK (performance_type IN ('acrobatics', 'clown acts', 'animal acts', 'juggling', 'fire performances', 'magicians', 'rope acts', 'circus stunts', 'mime acts', 'dance performances', 'balancing acts', 'other')),
    designer VARCHAR(100),
    description VARCHAR(1000)
);

CREATE TABLE Circus_place (
    place_ID INT PRIMARY KEY,
    address VARCHAR(1000) NOT NULL UNIQUE,
    city VARCHAR(100) NOT NULL
);

CREATE TABLE Show (
    show_num INT,
    performance_ID INT,
    date DATE,
    hour_start TIME,
    hour_end TIME,
    max_number_of_people INT NOT NULL,
    place_ID INT,
    PRIMARY KEY (show_num, performance_ID),
    FOREIGN KEY (performance_ID) REFERENCES Performance(performance_ID)
    ON UPDATE CASCADE,
    FOREIGN KEY (place_ID) REFERENCES Circus_place(place_ID) ON UPDATE CASCADE
);

CREATE TABLE Ticket (
    ticket_number INT PRIMARY KEY,
    type VARCHAR(20) CHECK (type IN ('VIP', 'Normal', 'Reduced')),
    seat_number INT,
    show_num INT NOT NULL,
    performance_ID INT NOT NULL,
    FOREIGN KEY (show_num, performance_ID) REFERENCES Show(show_num, performance_ID)
);

CREATE TABLE Rating (
    rating_ID INT PRIMARY KEY,
    cleanliness_rating INT CHECK (cleanliness_rating >= 0 AND cleanliness_rating <= 10),
    satisfaction_rating INT CHECK (satisfaction_rating >= 0 AND satisfaction_rating <= 10),
    ticket_number INT NOT NULL,
    FOREIGN KEY (ticket_number) REFERENCES Ticket(ticket_number)
    ON UPDATE CASCADE
);

CREATE TABLE Animals (
    animal_ID INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Take_part_in (
    show_num INT,
    performance_ID INT,
    animal_ID INT,
    PRIMARY KEY (show_num, performance_ID, animal_ID),
    FOREIGN KEY (show_num, performance_ID) REFERENCES Show(show_num, performance_ID),
    FOREIGN KEY (animal_ID) REFERENCES Animals(animal_ID) ON UPDATE CASCADE
);

CREATE TABLE Performers (
    person_ID INT PRIMARY KEY,
    name VARCHAR(100),
    surname VARCHAR(100)
);

CREATE TABLE Perform_in (
    show_num INT,
    performance_ID INT,
    person_ID INT,
    PRIMARY KEY (show_num, performance_ID, person_ID),
    FOREIGN KEY (show_num, performance_ID) REFERENCES Show(show_num, performance_ID),
    FOREIGN KEY (person_ID) REFERENCES Performers(person_ID) ON UPDATE CASCADE
);