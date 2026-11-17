# HR Employee Analytics: SQL Project

A **Microsoft SQL Server (T-SQL)** project that builds a small HR database from scratch and answers real business questions about headcount, salaries, staff turnover and training completion. It is written for Microsoft SQL Server and run in SQL Server Management Studio (SSMS).

> **Database platform: Microsoft SQL Server (T-SQL), written and tested in SQL Server Management Studio (SSMS).**
> The `.sql` files open and read in any editor or tool, but they will only run as-is on SQL Server. See [Running it on other databases](#running-it-on-other-databases).

All data is fictional.

---

## What this project demonstrates

- Creating a database and tables with primary keys, foreign keys and suitable data types
- Loading sample data with `INSERT`
- Filtering, sorting and summarising data: `WHERE`, `ORDER BY`, `GROUP BY`, `HAVING`, aggregate functions
- Conditional logic with `CASE WHEN`
- Subqueries
- `INNER JOIN` and `LEFT JOIN` across three tables, including the `LEFT JOIN ... IS NULL` pattern to find missing records
- Turning business questions into queries (percentages, rates, per-department breakdowns)
- Changing data safely with `INSERT`, `UPDATE` and `DELETE` inside a transaction that is rolled back
- Basic data-quality checks

---

## The database

Three tables linked by foreign keys:

```
Departments  1 ---< Employees  1 ---< TrainingRecords
```

| Table | Rows | Description |
|---|---|---|
| `Departments` | 5 | One row per department (name and location) |
| `Employees` | 30 | One row per employee: job title, salary, hire date, employment status |
| `TrainingRecords` | 64 | One row per course taken, with completion status |

**Definitions used in the analysis**

- **Active:** `EmploymentStatus = 'Active'`
- **Left:** `EmploymentStatus` is `'Resigned'` or `'Terminated'`

---

## Project files

Run them in order.

| File | What it does |
|---|---|
| `01_Database_Creation.sql` | Creates the `HR_Employee_Analytics` database |
| `02_Table_Creation.sql` | Creates the three tables and inserts the sample data, with a row-count check |
| `03_Data_Extraction_Exploration.sql` | Single-table queries: `SELECT`, `WHERE`, `ORDER BY`, aggregates, `GROUP BY`, `HAVING`, `CASE`, subqueries, data-quality checks |
| `04_Joins_Exploration.sql` | `INNER JOIN`, `LEFT JOIN`, three-table joins, and the business questions by department |
| `05_DML_Exploration.sql` | `INSERT`, `UPDATE`, `DELETE` inside `BEGIN TRANSACTION ... ROLLBACK` so nothing is permanently changed |

---

## Business questions answered

1. How many employees does the company have (ever, and currently active)?
2. Which departments have the most active employees?
3. Which departments have the highest salary expenditure?
4. How many employees have left, and what share is that, overall and by department?
5. What is the training completion rate, overall and by department?
6. Which departments have the highest average salaries?
7. Which active employees have never had any training?

---

## How to run it

1. Open **SQL Server Management Studio (SSMS)** and connect to your SQL Server instance (SQL Server Express or Developer edition is free).
2. Open and run the files in order, `01` to `05`.
3. After file `02`, the check query should return **5 / 30 / 64** rows.
4. File `05` is safe to run: it ends with `ROLLBACK`, so the data returns to exactly how it was.

---

## Screenshots

The supplied SQL ZIP contains a `Screenshots` folder with a checklist/instructions file, but it does **not** currently contain captured SSMS screenshots. To add genuine evidence, run the scripts in SSMS and save screenshots showing the query and its result grid.

## Running it on other databases

The scripts use T-SQL (SQL Server) syntax. Most of the SQL (joins, aggregates, `CASE`, subqueries) is standard and works anywhere. These parts would need changing for **MySQL**:

| SQL Server (used here) | MySQL equivalent |
|---|---|
| `GO` batch separator | Remove it (not a SQL command) |
| `SELECT TOP 5 ...` | `SELECT ... LIMIT 5` |
| `SELECT DB_NAME()` | `SELECT DATABASE()` |
| `BEGIN TRANSACTION` / `ROLLBACK TRANSACTION` | `START TRANSACTION` / `ROLLBACK` |
| Inline `FOREIGN KEY REFERENCES ...` on a column | Separate `FOREIGN KEY (...) REFERENCES ...` clause |

---

## Skills used

SQL Server (T-SQL) · SSMS · Relational database design · Data querying and analysis · Data cleaning checks · Business reporting

---

## Author

**Vhukhudo Phadaphada**: [LinkedIn](https://www.linkedin.com/) · [Email](mailto:your.email@example.com)
