import random
import csv
from datetime import datetime, timedelta
from faker import Faker


def random_date(start_date, end_date):
    delta = end_date - start_date
    random_days = random.randint(0, delta.days)
    return start_date + timedelta(days=random_days)


# --- GLOBAL VARIABLES ---

fake = Faker()
number_of_data_dimension = 5000
number_of_data_fact = 500000
last_date_snapshot1 = 2010  # 2020
first_date_snapshot1 = 1995  # 2010
last_date_snapshot2 = 2020
first_date_snapshot2 = 2010
list_of_specializations = ['acrobatics', 'clown acts', 'animal acts', 'juggling', 'fire performances', 'magicians',
                           'rope acts', 'circus stunts', 'mime acts', 'dance performances', 'balancing acts', 'other']


# --- CLASSES ---
class Performance:
    def __init__(self, performance_ID, performance_name, performance_type, designer, description, time_tables, date_start, date_end,
                 days_of_performance):
        self.performance_ID = performance_ID
        self.performance_name = performance_name
        self.performance_type = performance_type
        self.designer = designer
        self.description = description
        self.time_tables = time_tables
        self.date_start = date_start
        self.date_end = date_end
        self.days_of_performance = days_of_performance
        self.number_of_shows = 0

    def __str__(self):
        return f"{self.performance_ID}|{self.performance_name}|{self.performance_type}|{self.designer}|{self.description}"

    def return_list(self):
        return [self.performance_ID, self.performance_name, self.date_start, self.date_end, self.days_of_performance]
    def get_number_of_show(self):
        return self.number_of_shows

    def increament_shows(self):
        self.number_of_shows = self.number_of_shows + 1

    def get_date_start(self):
        return self.date_start

    def get_date_end(self):
        return self.date_end


class CircusPlace:
    def __init__(self, place_ID, address, city):
        self.place_ID = place_ID
        self.address = address
        self.city = city

    def __str__(self):
        return f"{self.place_ID}|{self.address}|{self.city}"


class Show:
    def __init__(self, show_num, performance_ID, date, hour_start, hour_end, max_number_of_people, place_ID):
        self.show_num = show_num
        self.performance_ID = performance_ID
        self.date = date
        self.hour_start = hour_start
        self.hour_end = hour_end
        self.max_number_of_people = max_number_of_people
        self.place_ID = place_ID

    def __str__(self):
        return f"{self.show_num}|{self.performance_ID}|{self.date}|{self.hour_start}|{self.hour_end}|{self.max_number_of_people}|{self.place_ID}"

    def return_performance_numb(self):
        return self.performance_ID

class Ticket:
    def __init__(self, ticket_number, ticket_type, seat_number, show_num, performance_id):
        self.ticket_number = ticket_number
        self.ticket_type = ticket_type
        self.seat_number = seat_number
        self.show_num = show_num
        self.performance_id = performance_id

    def __str__(self):
        return f"{self.ticket_number}|{self.ticket_type}|{self.seat_number}|{self.show_num}|{self.performance_id}"


class Rating:
    def __init__(self, rating_ID, cleanliness_rating, satisfaction_rating, ticket_number):
        self.rating_ID = rating_ID
        self.cleanliness_rating = cleanliness_rating
        self.satisfaction_rating = satisfaction_rating
        self.ticket_number = ticket_number

    def __str__(self):
        return f"{self.rating_ID}|{self.cleanliness_rating}|{self.satisfaction_rating}|{self.ticket_number}"


class Animals:
    def __init__(self, animal_ID, name, species, is_available, date_aquired, date_loss, last_veterinary_visit,
                 last_cleaning):
        self.animal_ID = animal_ID
        self.name = name
        self.species = species
        self.is_available = is_available
        self.date_aquired = date_aquired
        self.date_loss = date_loss
        self.last_veterinary_visit = last_veterinary_visit
        self.last_cleaning = last_cleaning

    def __str__(self):
        return f"{self.animal_ID}|{self.name}"

    def return_list(self):
        return [self.animal_ID, self.name, self.species, self.is_available, self.date_aquired, self.date_loss,
                self.last_veterinary_visit, self.last_cleaning]


class TakePartIn:
    def __init__(self, show_num, performance_id, animal_ID):
        self.show_num = show_num
        self.performance_id = performance_id
        self.animal_ID = animal_ID

    def __str__(self):
        return f"{self.show_num}|{self.performance_id}|{self.animal_ID}"


class Performers:
    def __init__(self, person_ID, pin, name, surname, date_of_birth, education, date_of_acceptance, date_end_of_work,
                 specialization):
        self.person_ID = person_ID
        self.pin = pin
        self.name = name
        self.surname = surname
        self.date_of_birth = date_of_birth
        self.education = education
        self.date_of_acceptance = date_of_acceptance
        self.date_end_of_work = date_end_of_work
        self.specialization = specialization

    def __str__(self):
        return f"{self.person_ID}|{self.name}|{self.surname}"

    def return_list(self):
        return [self.person_ID, self.pin, self.name, self.surname, self.date_of_birth, self.education,
                self.date_of_acceptance, self.date_end_of_work, self.specialization]


class PerformIn:
    def __init__(self, show_num, performance_id, person_ID):
        self.show_num = show_num
        self.performance_id = performance_id
        self.person_ID = person_ID

    def __str__(self):
        return f"{self.show_num}|{self.performance_id}|{self.person_ID}"


# --- GENERATORS ---

def generate_performances(first_date_snapshot, last_date_snapshot, number_add = 0):
    performances = []
    for i in range(1+number_add, number_of_data_dimension+number_add+1):
        start_date = fake.date_between_dates(date_start=datetime(first_date_snapshot, 1, 1),
                                            date_end=datetime(last_date_snapshot, 12, 31))
        end_date = start_date + timedelta(days=random.randint(1, 480))
        performance = Performance(
            i,
            fake.catch_phrase().replace('\n', ''),
            random.choice(list_of_specializations),
            fake.name().replace('\n', ''),
            fake.text().replace('\n', ''),
            f"{start_date.strftime('%Y-%m-%d')} - {end_date.strftime('%Y-%m-%d')}",
            start_date,
            end_date,
            random.choice(["Mondays", "Tuesdays", "Wednesdays", "Thursdays", "Fridays", "Saturdays", "Sundays"])
        )
        performances.append(performance)
    return performances


def generate_circus_places(number_add = 0):
    circus_places = []
    for i in range(1+number_add, number_of_data_dimension+number_add+1):
        circus_place = CircusPlace(
            i,
            fake.address().replace('\n', ''),
            fake.city().replace('\n', '')
        )
        circus_places.append(circus_place)
    return circus_places


def generate_shows(performances, number_add = 0, number_add2 = 0, number_add3 = 0):
    shows = []
    for i in range(1+number_add, number_of_data_fact+number_add+1):
        times = [fake.time() for _ in range(2)]
        times.sort()
        performance_number = random.randint(0, number_of_data_dimension - 1)
        show = Show(
            i,
            performance_number + number_add2 + 1,
            fake.date_between_dates(date_start=performances[performance_number].get_date_start(),
                                   date_end=performances[performance_number].get_date_end()),
            times[0],
            times[1],
            random.randint(100, 1000),
            random.randint(1+number_add3, number_of_data_dimension+number_add3)
        )
        shows.append(show)
    return shows


def generate_tickets(shows ,number_add = 0, number_add2 = 0, number_add3 = 0):
    tickets = []
    for i in range(1+number_add, number_of_data_fact*2+number_add+1):
        show_numb = random.randint(0, number_of_data_fact - 1)
        performance_numb = shows[show_numb].return_performance_numb()
        ticket = Ticket(
            i,
            random.choice(['VIP', 'Normal', 'Reduced']),
            random.randint(1, 200),
            show_numb + number_add2 + 1,
            performance_numb
        )
        tickets.append(ticket)
    return tickets


def generate_ratings(number_add = 0, number_add2 = 0):
    ratings = []
    numberh = 1+number_add
    for i in range(1+number_add, number_of_data_fact*2+number_add+1):
        rating = Rating(
            numberh,
            random.randint(0, 10),
            random.randint(0, 10),
            i
        )
        if random.random() < 0.8:
            ratings.append(rating)
            numberh = numberh+1
    return ratings


def generate_animals(first_date_snapshot, last_date_snapshot, number_add = 0):
    animals = []
    for i in range(1+number_add, number_of_data_dimension+number_add+1):
        dates = [fake.date_between_dates(date_start=datetime(first_date_snapshot, 1, 1),
                                        date_end=datetime(last_date_snapshot, 12, 31)) for _ in range(4)]
        dates.sort()
        date_loss = random.choice([None, dates[3]])
        no_yes = "no" if date_loss else random.choice(["yes", "no"])
        animal = Animals(
            i,
            fake.first_name().replace('\n', ''),
            random.choice(["Lion", "Elephant", "Tiger", "Bear", "Monkey", "Snake", "Giraffe", "Pig", "Dog", "Parrot"]),
            no_yes,
            dates[0],
            date_loss,
            dates[2],
            dates[1]
        )
        animals.append(animal)
    return animals


def generate_take_part_ins(shows, number_add=0, number_add2=0, number_add4=0, number_add3=0):
    take_part_ins = []
    existing_combinations = set()

    for i in range(1 + number_add, number_of_data_fact + number_add + 1):
        show_numb = random.randint(0, number_of_data_fact - 1)
        performance_numb = shows[show_numb].return_performance_numb()
        animal_numb = random.randint(1 + number_add3, number_of_data_dimension + number_add3)

        combination = (show_numb + 1, performance_numb, animal_numb)
        if combination not in existing_combinations:
            take_part_in = TakePartIn(show_numb + 1, performance_numb, animal_numb)
            take_part_ins.append(take_part_in)
            existing_combinations.add(combination)

    return take_part_ins


def generate_performers(first_date_snapshot, last_date_snapshot, number_add = 0):
    performers = []
    for i in range(1+number_add, number_of_data_dimension+number_add+1):
        dates = [fake.date_between_dates(date_start=datetime(first_date_snapshot, 1, 1),
                                        date_end=datetime(last_date_snapshot, 12, 31)) for _ in range(2)]
        dates.sort()
        performer = Performers(
            i,
            f"{random.randint(1000, 9999)}-{random.randint(1000, 9999)}",
            fake.first_name().replace('\n', ''),
            fake.last_name().replace('\n', ''),
            fake.date_between_dates(date_start=datetime(1950, 1, 1), date_end=datetime(first_date_snapshot, 12, 31)),
            random.choice(["High School", "Bachelor's Degree", "Master's Degree", "PhD"]),
            dates[0],
            random.choice([None, dates[1]]),
            random.choice(list_of_specializations)
        )
        performers.append(performer)
    return performers

def generate_perform_ins(shows, number_add=0, number_add2=0, number_add4=0, number_add3=0):
    perform_ins = []
    existing_combinations = set()

    for i in range(1 + number_add, number_of_data_fact + number_add + 1):
        show_numb = random.randint(0, number_of_data_fact - 1)
        performance_numb = shows[show_numb].return_performance_numb()
        person_numb = random.randint(1 + number_add3, number_of_data_dimension + number_add3)

        combination = (show_numb + 1, performance_numb, person_numb)
        if combination not in existing_combinations:
            perform_in = PerformIn(show_numb + 1, performance_numb, person_numb)
            perform_ins.append(perform_in)
            existing_combinations.add(combination)

    return perform_ins

def change_performers_surnames(performers):
    for performer in performers:
        if random.random() < 0.1:
            performer.surname = fake.last_name().replace('\n', '')

def add_date_loss_to_animals(animals, last_date_snapshot):
    for animal in animals:
        if animal.date_loss is None and random.random() < 0.8:
            animal.date_loss = fake.date_between_dates(date_start=animal.last_veterinary_visit,
                                                        date_end=datetime(last_date_snapshot, 12, 31))
            animal.is_available  = "no"

def add_date_end_of_work_to_performers(performers, last_date_snapshot):
    for performer in performers:
        if performer.date_end_of_work is None and random.random() < 0.2:
            performer.date_end_of_work = fake.date_between_dates(date_start=performer.date_of_acceptance,
                                                                 date_end=datetime(last_date_snapshot, 12, 31))

# --- ---

def write_data_to_file(data, filename):
    with open(filename, 'w') as file:
        for item in data:
            file.write(str(item) + '\n')

def write_to_csv(data, filename):
    with open(filename, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerows(data)

def duplicate_file(original_filename, new_filename):
    with open(original_filename, 'r') as original_file:
        data = original_file.read()

    with open(new_filename, 'w') as new_file:
        new_file.write(data)

def append_data_to_file(data, filename):
    with open(filename, 'a') as file:
        for item in data:
            file.write(str(item) + '\n')

def append_to_csv(data, filename):
    with open(filename, 'a', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerows(data)



if __name__ == "__main__":
    performances = generate_performances(first_date_snapshot1, last_date_snapshot1)
    print("performances generated")
    circus_places = generate_circus_places()
    print("circus_places generated")
    shows = generate_shows(performances)
    print("shows generated")
    tickets = generate_tickets(shows)
    print("tickets generated")
    ratings = generate_ratings()
    print("ratings generated")
    animals = generate_animals(first_date_snapshot1, last_date_snapshot1)
    print("animals generated")
    take_part_ins = generate_take_part_ins(shows)
    print("take_part_ins generated")
    performers = generate_performers(first_date_snapshot1, last_date_snapshot1)
    print("performers generated")
    perform_ins = generate_perform_ins(shows)
    print("perform_ins generated")

    write_data_to_file(performances, 'performancesT1.txt')
    write_data_to_file(circus_places, 'circus_placesT1.txt')
    write_data_to_file(shows, 'showsT1.txt')
    write_data_to_file(tickets, 'ticketsT1.txt')
    write_data_to_file(ratings, 'ratingsT1.txt')
    write_data_to_file(animals, 'animalsT1.txt')
    write_data_to_file(take_part_ins, 'take_part_insT1.txt')
    write_data_to_file(performers, 'performersT1.txt')
    write_data_to_file(perform_ins, 'perform_insT1.txt')

    write_to_csv([["Performance ID", "Performance Name", "Timetables - DateStart", "Timetables - DateEnd", "Days of Performance"]]
                 + [performance.return_list() for performance in performances], "performancesT1.csv")

    write_to_csv([["Person ID", "PIN", "Name", "Surname", "Date of Birth", "Education", "Date of Acceptance",
                   "Date of End of Work", "Specialization"]] +
                 [performer.return_list() for performer in performers], "employeesT1.csv")

    write_to_csv([["Animal ID", "Animal Name", "Animal Species", "Is Available for Performances", "Date Acquired",
                   "Date Loss", "Last Veterinary Visit", "Last Cleaning"]] +
                 [animal.return_list() for animal in animals], "animalsT1.csv")

    duplicate_file('performancesT1.txt', 'performancesT2.txt')
    duplicate_file('circus_placesT1.txt', 'circus_placesT2.txt')
    duplicate_file('showsT1.txt', 'showsT2.txt')
    duplicate_file('ticketsT1.txt', 'ticketsT2.txt')
    duplicate_file('ratingsT1.txt', 'ratingsT2.txt')
    duplicate_file('animalsT1.txt', 'animalsT2.txt')
    duplicate_file('take_part_insT1.txt', 'take_part_insT2.txt')
    duplicate_file('performersT1.txt', 'performersT2.txt')
    duplicate_file('perform_insT1.txt', 'perform_insT2.txt')
    duplicate_file('performancesT1.csv', 'performancesT2.csv')
    duplicate_file('employeesT1.csv', 'employeesT2.csv')
    duplicate_file('animalsT1.csv', 'animalsT2.csv')

    change_performers_surnames(performers)
    add_date_loss_to_animals(animals, last_date_snapshot2)
    add_date_end_of_work_to_performers(performers, last_date_snapshot2)

    write_data_to_file(animals, 'animalsT2.txt')
    write_data_to_file(performers, 'performersT2.txt')
    write_to_csv([["Person ID", "PIN", "Name", "Surname", "Date of Birth", "Education", "Date of Acceptance",
                   "Date of End of Work", "Specialization"]] +
                 [performer.return_list() for performer in performers], "employeesT2.csv")

    write_to_csv([["Animal ID", "Animal Name", "Animal Species", "Is Available for Performances", "Date Acquired",
                   "Date Loss", "Last Veterinary Visit", "Last Cleaning"]] +
                 [animal.return_list() for animal in animals], "animalsT2.csv")

    performances2 = generate_performances(first_date_snapshot2, last_date_snapshot2, len(performances))
    print("performances2 generated")
    circus_places2 = generate_circus_places(len(circus_places))
    print("circus_places2 generated")
    shows2 = generate_shows(performances, len(shows), len(performances), len(circus_places))
    print("shows2 generated")
    tickets2 = generate_tickets(shows2, len(tickets), len(shows), len(performances))
    print("tickets2 generated")
    ratings2 = generate_ratings(len(ratings), len(tickets))
    print("ratings2 generated")
    animals2 = generate_animals(first_date_snapshot2, last_date_snapshot2, len(animals))
    print("animals2 generated")
    take_part_ins2 = generate_take_part_ins(shows2, len(take_part_ins), len(shows), len(performances), len(animals))
    print("take_part_ins2 generated")
    performers2 = generate_performers(first_date_snapshot2, last_date_snapshot2, len(performers))
    print("performers2 generated")
    perform_ins2 = generate_perform_ins(shows2, len(perform_ins), len(shows), len(performances), len(performers))
    print("perform_ins2 generated")

    append_data_to_file(performances2, 'performancesT2.txt')
    append_data_to_file(circus_places2, 'circus_placesT2.txt')
    append_data_to_file(shows2, 'showsT2.txt')
    append_data_to_file(tickets2, 'animalsT2.txt')
    append_data_to_file(tickets2, 'ticketsT2.txt')
    append_data_to_file(ratings2, 'ratingsT2.txt')
    append_data_to_file(take_part_ins2, 'take_part_insT2.txt')
    append_data_to_file(performers2, 'performersT2.txt')
    append_data_to_file(perform_ins2, 'perform_insT2.txt')

    append_to_csv([performance.return_list() for performance in performances2], "performancesT2.csv")
    append_to_csv([performer.return_list() for performer in performers2], "employeesT2.csv")
    append_to_csv([animal.return_list() for animal in animals2], "animalsT2.csv")