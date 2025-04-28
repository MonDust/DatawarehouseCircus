import holidays
import datetime

polish_holidays = holidays.UK()

start_year = 1995
end_year = 2025

output_file = "ETL_holidays_inserts.txt"

with open(output_file, "w") as file:
    file.write("INSERT INTO holidays (Date, HolidayName) VALUES\n")

    for year in range(start_year, end_year + 1):
        for month in range(1, 13):
            for day in range(1, 32):
                try:
                    date = datetime.date(year, month, day)
                    holiday_name = polish_holidays.get(date)
                    if holiday_name is not None:
                        holiday_name = holiday_name.replace("'", "")
                        file.write(f"('{date.strftime('%Y-%m-%d')}', '{holiday_name}'),\n")
                except ValueError:
                    pass
