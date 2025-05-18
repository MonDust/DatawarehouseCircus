# Data Warehouse Circus - Hilarity Haven
The project simulates the design and implementation of a Business Intelligence system for a fictional Circus organization: Hilarity Haven Circus. It involves full lifecycle development including requirement analysis, data modeling, data generation, ETL processing, OLAP analysis, and Power BI reporting.

The system enables analysys of ticket sales, performance popularity and artist metrics through dashboards.

## The files
### Process Specification - Organization specifics
Descriptions of:
- organization, and their two measurable goals,
- two business processes of the organization.

File: ProcessSpecification.pdf

### Requirement Process Specification - Data sources design
Descriptions of:
- organization, and their two measurable goals,
- two data sources: "HHRating" (relational with schema, implemented by SQL) and "Eploperf" CSV,
- two analytical problems with eight queries for each and description of data needed.

File: Requirementprocessspecification.pdf

### Data generator
Generator of all needed data for both data sources. Special file for generating dates (with holidays).
Examples of generated data is available at: Example_of_generated_data.pdf

Files: 

/python_scripts/data_generator.py

/python_scripts/holiday_generator.py

### Schemas implementation
Data needs to be generated from data generators in two snapshots (two times T1 and T2). Loading needs to be done from two snapshots T1, then T2.

Files are available in: /Files/SQL/ folder.

### Project Report - Data Warehouse design
The file contains the checks if the queries defined in Requirementprocessspecification.pdf can be execured with the current data.
It contains description of data warehouse with its schema.

File: ProjectReport.pdf

### Data Warehouse implementation
Files:
Visual studio project in /CircusDW/CircusDW.zip
Inserting and loading in /Files/Warehouse/ folder:
- ETL process (all ETL files),
- example data: Data.sql
- Relational_table_creation.sql - implementation of schema (and additional creation of auxiliary table (holidays)).

### Analysis/visulalization
Done in Power BI.
Files:
- KPI/KPI.xlsx - analysis dones in excel.
- KPIandMDX.pdf - the overwiew document, KPI definitions.
- visualization/ folder:
  - visualization.pbix - interactive Power BI dashboard file
  - visualization.pdf - showcase of example of dashboards. 

## Information
The project implemented for Data Warehouses course.

## Author
O. Paszkiewicz (Mondust)
2024
  

