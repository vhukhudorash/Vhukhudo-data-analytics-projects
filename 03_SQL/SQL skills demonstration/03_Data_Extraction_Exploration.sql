/* =====================================================================
   HR Employee Analytics - SQL Project
   File 03 - Data extraction and exploration
   Pulling data OUT of one table at a time (joins come in file 04).

   Meaning of terms used in this project:
     Active   = EmploymentStatus is 'Active'
     Left     = EmploymentStatus is 'Resigned' or 'Terminated'
   ===================================================================== */

USE HR_Employee_Analytics;
GO

/* ---------- 1. SELECT: choose what to see ---------- */

SELECT * FROM Departments;                          -- everything

SELECT FirstName, LastName, JobTitle, Salary        -- only some columns
FROM   Employees;

SELECT TOP 5 * FROM Employees;                      -- first 5 rows only

SELECT DISTINCT EmploymentStatus FROM Employees;    -- unique values only

/* ---------- 2. WHERE: filter rows ---------- */

SELECT FirstName, LastName, EmploymentStatus        -- one exact value
FROM   Employees
WHERE  EmploymentStatus = 'Resigned';

SELECT FirstName, LastName, Salary                  -- greater than
FROM   Employees
WHERE  Salary > 70000;

SELECT FirstName, LastName, DepartmentID, Salary    -- AND: both must be true
FROM   Employees
WHERE  DepartmentID = 2 AND Salary > 70000;

SELECT FirstName, LastName, DepartmentID            -- IN: match any in a list
FROM   Employees
WHERE  DepartmentID IN (1, 3);

SELECT FirstName, LastName, HireDate                -- BETWEEN: a range
FROM   Employees
WHERE  HireDate BETWEEN '2023-01-01' AND '2023-12-31';

SELECT FirstName, LastName, JobTitle                -- LIKE: pattern search
FROM   Employees
WHERE  JobTitle LIKE '%Manager%';

/* ---------- 3. ORDER BY: sort the results ---------- */

SELECT FirstName, LastName, Salary
FROM   Employees
ORDER  BY Salary DESC;                              -- highest salary first

SELECT TOP 5 FirstName, LastName, HireDate
FROM   Employees
ORDER  BY HireDate ASC;                             -- the 5 longest-serving

/* ---------- 4. Aggregate functions: summarise many rows ---------- */

SELECT COUNT(*)    AS TotalEmployees,
       SUM(Salary) AS TotalSalaries,
       ROUND(AVG(Salary), 0) AS AverageSalary,
       MIN(Salary) AS LowestSalary,
       MAX(Salary) AS HighestSalary
FROM   Employees;

/* ---------- 5. GROUP BY: one summary per group ---------- */

SELECT EmploymentStatus, COUNT(*) AS Employees      -- how many in each status?
FROM   Employees
GROUP  BY EmploymentStatus;

SELECT DepartmentID,                                -- headcount per department
       COUNT(*) AS Employees
FROM   Employees
WHERE  EmploymentStatus = 'Active'
GROUP  BY DepartmentID;

SELECT DepartmentID, COUNT(*) AS Employees          -- HAVING filters the groups
FROM   Employees
GROUP  BY DepartmentID
HAVING COUNT(*) >= 6;

/* ---------- 6. CASE WHEN: create categories (like IF/ELSE) ---------- */

SELECT FirstName, LastName, Salary,
       CASE WHEN Salary < 40000 THEN 'Low'
            WHEN Salary < 70000 THEN 'Medium'
            ELSE                     'High'
       END AS SalaryLevel
FROM   Employees
ORDER  BY Salary;

/* ---------- 7. A simple subquery (a query inside a query) ---------- */

-- Who earns more than the company average?
SELECT FirstName, LastName, Salary
FROM   Employees
WHERE  Salary > (SELECT AVG(Salary) FROM Employees)
ORDER  BY Salary DESC;

/* ---------- 8. First business answers ---------- */

-- Q1. How many employees does the company have?
SELECT COUNT(*) AS TotalEmployeesEver FROM Employees;
SELECT COUNT(*) AS ActiveEmployees    FROM Employees WHERE EmploymentStatus = 'Active';

-- Q4. How many employees have left the company?
SELECT COUNT(*) AS EmployeesWhoLeft
FROM   Employees
WHERE  EmploymentStatus IN ('Resigned', 'Terminated');

-- Q5. What is the training completion rate?
SELECT COUNT(*) AS TotalTrainingRecords FROM TrainingRecords;
SELECT COUNT(*) AS CompletedTraining
FROM   TrainingRecords
WHERE  CompletionStatus = 'Completed';

-- Same answer as a percentage (SUM + CASE counts only the 'Completed' rows)
SELECT ROUND(100.0 * SUM(CASE WHEN CompletionStatus = 'Completed' THEN 1 ELSE 0 END)
             / COUNT(*), 1) AS CompletionRatePercent
FROM   TrainingRecords;

/* ---------- 9. Quick data-quality checks (each should return 0) ---------- */

SELECT COUNT(*) AS MissingSalaries   FROM Employees WHERE Salary IS NULL;
SELECT COUNT(*) AS NegativeSalaries  FROM Employees WHERE Salary <= 0;
SELECT COUNT(*) AS OddStatusValues   FROM Employees
WHERE  EmploymentStatus NOT IN ('Active', 'Resigned', 'Terminated');
