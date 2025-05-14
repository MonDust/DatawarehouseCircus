# DatawarehouseCircus
The project for Data Warehouses course.

The project simulates the design and implementation of a Business Intelligence sysyem for a fictional Circus organization: Hillarity Haeven Circus. It involves full lifecycle development including requirement analysis, data modeling, data generation, ETL processing, OLAP analysis, and Power BI reporting.

The system enables stakeholders to analyze ticket sales, performance popularity and artist metrics through interactive dashboards.

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

File: 

/python_scripts/data_generator.py

/python_scripts/holiday_generator.py

### Schemas implementation
Data needs to be generated from data generators in two snapshots (two times T1 and T2). Loading needs to be done from two snapshots T1, then T2.

Files are available in: /Files/SQL/ folder.

### Project Report - Data Warehouse design
The file contains the checks if the queries defined in Requirementprocessspecification.pdf can be execured with the current data.
It contains description of data warehouse with its schema.

File: ProjectReport.pdf
  

