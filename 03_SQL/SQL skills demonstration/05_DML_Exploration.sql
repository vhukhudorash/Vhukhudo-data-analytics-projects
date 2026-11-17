/* =====================================================================
   HR Employee Analytics - SQL Project
   File 05 - DML exploration (changing data)
   DML = Data Manipulation Language: INSERT, UPDATE and DELETE.

   SAFE TO RUN: the whole file sits inside BEGIN TRANSACTION ... ROLLBACK.
   Think of it as "pencil, not pen": you can see every change, and
   ROLLBACK at the end undoes all of it. (Change ROLLBACK to COMMIT only
   if you really want to keep the changes.)
   ===================================================================== */

USE HR_Employee_Analytics;
GO

BEGIN TRANSACTION;

/* ---------- 1. INSERT: add new rows ---------- */

-- Add a new recruiter to Human Resources
INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, JobTitle, Salary, HireDate, EmploymentStatus)
VALUES (505, 'Aisha', 'Khan', 5, 'Recruiter', 41000, '2026-11-17', 'Active');

-- Give her a first training course
INSERT INTO TrainingRecords (TrainingID, EmployeeID, TrainingName, CompletionStatus)
VALUES (65, 505, 'Workplace Safety', 'Not Started');

SELECT * FROM Employees WHERE EmployeeID = 505;       -- she is there now

/* ---------- 2. UPDATE: change existing rows ---------- */
/* ALWAYS use WHERE. Without it, EVERY row is changed! */

-- Check first, then change: promote one employee
SELECT EmployeeID, JobTitle, Salary FROM Employees WHERE EmployeeID = 103;

UPDATE Employees
SET    JobTitle = 'Senior Sales Representative',
       Salary   = 42000
WHERE  EmployeeID = 103;

SELECT EmployeeID, JobTitle, Salary FROM Employees WHERE EmployeeID = 103;

-- Update many rows: 5% raise for active Customer Support staff (department 3)
UPDATE Employees
SET    Salary = Salary * 1.05
WHERE  DepartmentID = 3 AND EmploymentStatus = 'Active';

SELECT FirstName, LastName, Salary
FROM   Employees
WHERE  DepartmentID = 3 AND EmploymentStatus = 'Active';

-- Mark a training course as finished
UPDATE TrainingRecords
SET    CompletionStatus = 'Completed'
WHERE  TrainingID = 65;

/* ---------- 3. DELETE: remove rows ---------- */
/* ALWAYS use WHERE here too! */

-- Remove the "Not Started" training of people who have already left
DELETE FROM TrainingRecords
WHERE  CompletionStatus = 'Not Started'
  AND  EmployeeID IN (SELECT EmployeeID FROM Employees
                      WHERE EmploymentStatus <> 'Active');

-- To delete an employee, delete their training first (the child rows),
-- otherwise the foreign key stops you.
DELETE FROM TrainingRecords WHERE EmployeeID = 505;
DELETE FROM Employees       WHERE EmployeeID = 505;

SELECT COUNT(*) AS EmployeesNow FROM Employees;       -- back to 30

/* ---------- Undo everything above ---------- */
ROLLBACK TRANSACTION;

-- Check: the data is exactly as it was (expect 5 / 30 / 64)
SELECT (SELECT COUNT(*) FROM Departments)     AS Departments,
       (SELECT COUNT(*) FROM Employees)       AS Employees,
       (SELECT COUNT(*) FROM TrainingRecords) AS TrainingRecords;
