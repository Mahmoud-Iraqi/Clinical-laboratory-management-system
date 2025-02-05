# Clinical Laboratory Database Project

## Project Overview
This project is a **relational database system** designed to efficiently manage clinical laboratory operations, including patient records, test results, medical history, staff details, and laboratory branches. The database ensures **data integrity, security, and streamlined retrieval** of essential laboratory data.

## Features
- **Patient Management:** Stores patient demographics, test orders, and reports.
- **Test Management:** Keeps track of test details, including unique codes, price, min/max values, and results.
- **Sample Tracking:** Manages sample collection, types, and association with test results.
- **Staff & Order Providers:** Records details of laboratory staff, including doctors, secretaries, and managers, along with external order providers.
- **Branch & Visit Logs:** Tracks laboratory branches, patient visits, and ratings.
- **Query Optimization:** Provides complex SQL queries for retrieving reports, test results, and staff details efficiently.

## Database Schema
The database consists of multiple tables, including:
1. **Patient** (`ID`, `Name`, `Birth_Date`, `Address`, `Gender`)
2. **Order_Provider** (`ID`, `Name`, `Specialty`, `Address`)
3. **Test** (`Code`, `Name`, `Price`, `Min_Value`, `Max_Value`, `Category`)
4. **Test_Result** (`ID`, `Status`, `Releasing_Date`, `Actual_Value`)
5. **Sample** (`ID`, `Type`, `Collecting_Date`, `Patient_ID`, `Doctor_ID`)
6. **Branch** (`ID`, `Location`, `Phone`, `Manager_ID`)
7. **Staff** (`ID`, `Name`, `Salary`, `Phone`, `Branch_ID`)
8. **Doctor** (`ID`, `Degree`)
9. **Secretary** (`ID`, `No_of_Languages`)
10. **Manager** (`ID`)

## Queries Implemented
Several SQL queries are designed to retrieve essential information, including:
- Retrieving patient reports along with doctor and secretary details.
- Fetching the highest-paid staff members in a particular branch.
- Identifying order providers and the number of patients they have directed.
- Finding test results marked as abnormal.
- Ranking laboratory branches based on patient ratings.

## Technologies Used
- **Database System:** SQLite / MySQL
- **Query Language:** SQL
- **ER Modeling Tool:** MySQL Workbench / Draw.io

## How to Use
1. Clone the repository or download the database schema.
2. Import the SQL file into your database system (e.g., MySQL, SQLite).
3. Run provided SQL queries to test data retrieval and analysis.
4. Modify or extend the schema to suit additional requirements.
