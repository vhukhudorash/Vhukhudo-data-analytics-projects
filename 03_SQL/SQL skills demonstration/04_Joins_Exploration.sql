/* =====================================================================
   HR Employee Analytics - SQL Project
   File 04 - Joins exploration
   A JOIN combines rows from two tables using a column they share.
     Employees.DepartmentID      = Departments.DepartmentID
     TrainingRecords.EmployeeID  = Employees.EmployeeID
   ===================================================================== */

USE HR_Employee_Analytics;
GO

/* ---------- 1. INNER JOIN: only rows that match in both tables ---------- */

SELECT e.FirstName, e.LastName, e.JobTitle, d.DepartmentName, d.Location
FROM   Employees e
INNER  JOIN Departments d ON e.DepartmentID = d.DepartmentID;

/* ---------- 2. Joining three tables ---------- */

SELECT d.DepartmentName, e.FirstName, e.LastName,
       t.TrainingName, t.CompletionStatus
FROM   Employees e
JOIN   Departments     d ON e.DepartmentID = d.DepartmentID
JOIN   TrainingRecords t ON e.EmployeeID   = t.EmployeeID
ORDER  BY d.DepartmentName, e.LastName;

/* ---------- 3. LEFT JOIN: keep ALL rows from the left table ---------- */
/* Employees with no training appear with NULL in the training columns. */

SELECT e.EmployeeID, e.FirstName, e.LastName, t.TrainingName
FROM   Employees e
LEFT   JOIN TrainingRecords t ON e.EmployeeID = t.EmployeeID
WHERE  e.EmployeeID IN (107, 108, 405);

-- INNER JOIN drops employees with no training; LEFT JOIN keeps them.
SELECT COUNT(*) AS InnerJoinRows
FROM   Employees e JOIN TrainingRecords t ON e.EmployeeID = t.EmployeeID;

SELECT COUNT(*) AS LeftJoinRows
FROM   Employees e LEFT JOIN TrainingRecords t ON e.EmployeeID = t.EmployeeID;

/* ---------- 4. Finding what is MISSING (LEFT JOIN + IS NULL) ---------- */

-- Q7. Which active employees have never had any training?
SELECT e.EmployeeID, e.FirstName, e.LastName, d.DepartmentName, e.HireDate
FROM   Employees e
JOIN   Departments d ON e.DepartmentID = d.DepartmentID
LEFT   JOIN TrainingRecords t ON e.EmployeeID = t.EmployeeID
WHERE  t.TrainingID IS NULL
  AND  e.EmploymentStatus = 'Active';

/* ---------- 5. Business questions: JOIN + GROUP BY ---------- */

-- Q2. Which departments have the most employees? (active staff)
SELECT d.DepartmentName, COUNT(*) AS ActiveEmployees
FROM   Employees e
JOIN   Departments d ON e.DepartmentID = d.DepartmentID
WHERE  e.EmploymentStatus = 'Active'
GROUP  BY d.DepartmentName
ORDER  BY ActiveEmployees DESC;

-- Q3. Which departments have the highest salary expenditure? (active staff)
SELECT d.DepartmentName, SUM(e.Salary) AS TotalSalaries
FROM   Employees e
JOIN   Departments d ON e.DepartmentID = d.DepartmentID
WHERE  e.EmploymentStatus = 'Active'
GROUP  BY d.DepartmentName
ORDER  BY TotalSalaries DESC;

-- Q6. Which departments have the highest average salaries? (active staff)
SELECT d.DepartmentName, ROUND(AVG(e.Salary), 0) AS AverageSalary
FROM   Employees e
JOIN   Departments d ON e.DepartmentID = d.DepartmentID
WHERE  e.EmploymentStatus = 'Active'
GROUP  BY d.DepartmentName
ORDER  BY AverageSalary DESC;

-- Q4 (by department). How many employees have left, and what share is that?
SELECT d.DepartmentName,
       COUNT(*) AS TotalEverEmployed,
       SUM(CASE WHEN e.EmploymentStatus = 'Active' THEN 0 ELSE 1 END) AS EmployeesLeft,
       ROUND(100.0 * SUM(CASE WHEN e.EmploymentStatus = 'Active' THEN 0 ELSE 1 END)
             / COUNT(*), 1) AS LeftPercent
FROM   Employees e
JOIN   Departments d ON e.DepartmentID = d.DepartmentID
GROUP  BY d.DepartmentName
ORDER  BY LeftPercent DESC;

-- Q5 (by department). Training completion rate
SELECT d.DepartmentName,
       COUNT(*) AS TrainingRecords,
       ROUND(100.0 * SUM(CASE WHEN t.CompletionStatus = 'Completed' THEN 1 ELSE 0 END)
             / COUNT(*), 1) AS CompletionRatePercent
FROM   TrainingRecords t
JOIN   Employees   e ON t.EmployeeID   = e.EmployeeID
JOIN   Departments d ON e.DepartmentID = d.DepartmentID
GROUP  BY d.DepartmentName
ORDER  BY CompletionRatePercent;
