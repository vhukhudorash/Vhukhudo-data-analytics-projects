# SQL HR Employee Analytics

## Project overview

A SQL Server (T-SQL) project using a fictional company's HR data to practise relational database design, data exploration and business-focused querying.

## Database structure

The project creates three related tables:

- `Departments` — one row per department.
- `Employees` — one row per employee, linked to a department.
- `TrainingRecords` — one row per training course record, linked to an employee.

Relationship: `Departments` 1-to-many `Employees`, and `Employees` 1-to-many `TrainingRecords`.

## Numbered scripts

1. `01_Database_Creation.sql` — creates and selects the database.
2. `02_Table_Creation.sql` — creates the tables and inserts fictional sample data.
3. `03_Data_Extraction_Exploration.sql` — explores, filters, sorts and aggregates the data; includes basic data-quality checks.
4. `04_Joins_Exploration.sql` — demonstrates joins and department-level business analysis.
5. `05_DML_Exploration.sql` — demonstrates INSERT, UPDATE and DELETE inside a transaction that ends with ROLLBACK.

## SQL skills demonstrated

`SELECT`, `WHERE`, `DISTINCT`, `ORDER BY`, `TOP`, aggregate functions, `GROUP BY`, `HAVING`, `CASE`, subqueries, `INNER JOIN`, `LEFT JOIN`, `IS NULL`, `INSERT`, `UPDATE`, `DELETE`, transactions and `ROLLBACK`.

## How to run

Open SQL Server Management Studio (SSMS) and execute the numbered `.sql` files in order. The SQL uses SQL Server/T-SQL syntax. The project README inside the extracted folder contains additional setup notes.

## Important

All HR sample data is fictional and intended for learning and portfolio demonstration.
