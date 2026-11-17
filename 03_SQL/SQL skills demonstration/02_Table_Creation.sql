/* =====================================================================
   HR Employee Analytics - SQL Project
   File 02 - Table creation and sample data

   Three tables:
     Departments     one row per department
     Employees       one row per employee   (linked to a department)
     TrainingRecords one row per course taken (linked to an employee)

   Relationship:  Departments 1 ---< Employees 1 ---< TrainingRecords
   All data is fictional.
   ===================================================================== */

USE HR_Employee_Analytics;
GO

/* ---------- PART 1: CREATE THE TABLES ---------- */

CREATE TABLE Departments (
    DepartmentID    INT          NOT NULL PRIMARY KEY,   -- unique ID for each department
    DepartmentName  VARCHAR(50)  NOT NULL,
    Location        VARCHAR(50)  NOT NULL
);

CREATE TABLE Employees (
    EmployeeID        INT            NOT NULL PRIMARY KEY,
    FirstName         VARCHAR(50)    NOT NULL,
    LastName          VARCHAR(50)    NOT NULL,
    DepartmentID      INT            NOT NULL
        FOREIGN KEY REFERENCES Departments (DepartmentID),   -- links to Departments
    JobTitle          VARCHAR(60)    NOT NULL,
    Salary            DECIMAL(10,2)  NOT NULL,               -- annual salary
    HireDate          DATE           NOT NULL,
    EmploymentStatus  VARCHAR(20)    NOT NULL                -- Active, Resigned or Terminated
);

CREATE TABLE TrainingRecords (
    TrainingID        INT          NOT NULL PRIMARY KEY,
    EmployeeID        INT          NOT NULL
        FOREIGN KEY REFERENCES Employees (EmployeeID),       -- links to Employees
    TrainingName      VARCHAR(60)  NOT NULL,
    CompletionStatus  VARCHAR(20)  NOT NULL                  -- Completed, In Progress or Not Started
);
GO

/* ---------- PART 2: ADD THE SAMPLE DATA ---------- */
/* Order matters: Departments first, then Employees, then TrainingRecords. */

/* ---------- Departments ---------- */
INSERT INTO Departments (DepartmentID, DepartmentName, Location) VALUES
(1, 'Sales', 'Cape Town'),
(2, 'IT', 'Johannesburg'),
(3, 'Customer Support', 'Durban'),
(4, 'Finance', 'Johannesburg'),
(5, 'Human Resources', 'Johannesburg');

/* ---------- Employees ---------- */
INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, JobTitle, Salary, HireDate, EmploymentStatus) VALUES
(101, 'Thabo', 'Nkosi', 1, 'Sales Manager', 82000, '2019-03-15', 'Active'),
(102, 'Lerato', 'Dlamini', 1, 'Account Executive', 56000, '2021-06-01', 'Active'),
(103, 'Sipho', 'Mokoena', 1, 'Sales Representative', 38000, '2022-02-14', 'Active'),
(104, 'Naledi', 'Naidoo', 1, 'Sales Representative', 36000, '2023-05-22', 'Resigned'),
(105, 'Kyle', 'Jacobs', 1, 'Account Executive', 58000, '2020-09-07', 'Active'),
(106, 'Zanele', 'Pillay', 1, 'Sales Representative', 37000, '2024-01-15', 'Active'),
(107, 'Pieter', 'Botha', 1, 'Business Development Rep', 45000, '2022-10-03', 'Active'),
(108, 'Megan', 'Smith', 1, 'Sales Representative', 35000, '2025-03-10', 'Active'),
(201, 'Kagiso', 'Khumalo', 2, 'IT Manager', 98000, '2018-07-02', 'Active'),
(202, 'Priya', 'Govender', 2, 'Software Developer', 78000, '2021-01-11', 'Active'),
(203, 'Rohan', 'Patel', 2, 'Software Developer', 74000, '2022-08-29', 'Active'),
(204, 'Ayanda', 'Sithole', 2, 'Systems Administrator', 62000, '2020-04-20', 'Active'),
(205, 'Daniel', 'Ferreira', 2, 'Data Analyst', 65000, '2023-02-06', 'Active'),
(206, 'Emma', 'Venter', 2, 'Support Technician', 42000, '2024-06-17', 'Resigned'),
(207, 'Bongani', 'Mahlangu', 2, 'Software Developer', 70000, '2025-08-04', 'Active'),
(301, 'Nomsa', 'Ndlovu', 3, 'Support Team Lead', 48000, '2020-02-10', 'Active'),
(302, 'Tshepo', 'Molefe', 3, 'Customer Support Agent', 28000, '2022-09-12', 'Resigned'),
(303, 'Lindiwe', 'Zulu', 3, 'Customer Support Agent', 27000, '2023-03-06', 'Resigned'),
(304, 'Samuel', 'Radebe', 3, 'Customer Support Agent', 29000, '2023-11-20', 'Active'),
(305, 'Zoe', 'Adams', 3, 'Customer Support Agent', 28500, '2024-07-01', 'Terminated'),
(306, 'Vusi', 'Maseko', 3, 'Customer Success Specialist', 34000, '2025-01-13', 'Active'),
(401, 'Sarah', 'Coetzee', 4, 'Finance Manager', 88000, '2019-01-21', 'Active'),
(402, 'Michael', 'Louw', 4, 'Accountant', 60000, '2021-10-18', 'Active'),
(403, 'Fatima', 'Ismail', 4, 'Payroll Specialist', 50000, '2022-05-09', 'Active'),
(404, 'James', 'Petersen', 4, 'Financial Analyst', 62000, '2023-09-25', 'Active'),
(405, 'Chloe', 'Kruger', 4, 'Accountant', 58000, '2025-09-01', 'Active'),
(501, 'Grace', 'Mthembu', 5, 'HR Manager', 80000, '2018-11-05', 'Active'),
(502, 'Hannah', 'Cele', 5, 'HR Generalist', 46000, '2021-03-29', 'Active'),
(503, 'Imran', 'Abrahams', 5, 'Recruiter', 42000, '2023-07-17', 'Active'),
(504, 'Karabo', 'Baloyi', 5, 'HR Administrator', 32000, '2026-09-14', 'Active');

/* ---------- TrainingRecords ---------- */
INSERT INTO TrainingRecords (TrainingID, EmployeeID, TrainingName, CompletionStatus) VALUES
(1, 101, 'Workplace Safety', 'Completed'),
(2, 101, 'Data Protection', 'Completed'),
(3, 101, 'Anti-Harassment', 'Completed'),
(4, 102, 'Workplace Safety', 'Completed'),
(5, 102, 'Data Protection', 'Completed'),
(6, 103, 'Workplace Safety', 'Completed'),
(7, 103, 'Data Protection', 'In Progress'),
(8, 104, 'Workplace Safety', 'Completed'),
(9, 104, 'Data Protection', 'Not Started'),
(10, 105, 'Workplace Safety', 'Completed'),
(11, 105, 'Data Protection', 'Completed'),
(12, 105, 'Excel for Business', 'Completed'),
(13, 106, 'Workplace Safety', 'In Progress'),
(14, 106, 'Data Protection', 'Not Started'),
(15, 107, 'Workplace Safety', 'Not Started'),
(16, 107, 'Data Protection', 'In Progress'),
(17, 201, 'Workplace Safety', 'Completed'),
(18, 201, 'Data Protection', 'Completed'),
(19, 201, 'Anti-Harassment', 'Completed'),
(20, 202, 'Workplace Safety', 'Completed'),
(21, 202, 'Data Protection', 'Completed'),
(22, 203, 'Workplace Safety', 'Completed'),
(23, 203, 'Data Protection', 'Completed'),
(24, 203, 'Excel for Business', 'Completed'),
(25, 204, 'Workplace Safety', 'Completed'),
(26, 204, 'Data Protection', 'In Progress'),
(27, 205, 'Data Protection', 'Completed'),
(28, 205, 'Excel for Business', 'Completed'),
(29, 206, 'Workplace Safety', 'Completed'),
(30, 206, 'Data Protection', 'Not Started'),
(31, 207, 'Workplace Safety', 'Not Started'),
(32, 207, 'Data Protection', 'Not Started'),
(33, 301, 'Workplace Safety', 'Completed'),
(34, 301, 'Data Protection', 'Completed'),
(35, 301, 'Customer Service', 'Completed'),
(36, 301, 'Anti-Harassment', 'Completed'),
(37, 302, 'Workplace Safety', 'Completed'),
(38, 302, 'Data Protection', 'Not Started'),
(39, 302, 'Customer Service', 'Not Started'),
(40, 303, 'Workplace Safety', 'Not Started'),
(41, 303, 'Customer Service', 'Not Started'),
(42, 304, 'Workplace Safety', 'Completed'),
(43, 304, 'Customer Service', 'In Progress'),
(44, 305, 'Workplace Safety', 'Completed'),
(45, 305, 'Data Protection', 'Not Started'),
(46, 306, 'Workplace Safety', 'In Progress'),
(47, 306, 'Customer Service', 'Not Started'),
(48, 401, 'Workplace Safety', 'Completed'),
(49, 401, 'Data Protection', 'Completed'),
(50, 401, 'Anti-Harassment', 'Completed'),
(51, 402, 'Workplace Safety', 'Completed'),
(52, 402, 'Data Protection', 'Completed'),
(53, 403, 'Data Protection', 'Completed'),
(54, 403, 'Excel for Business', 'Completed'),
(55, 404, 'Workplace Safety', 'Completed'),
(56, 404, 'Data Protection', 'Completed'),
(57, 404, 'Excel for Business', 'Completed'),
(58, 501, 'Workplace Safety', 'Completed'),
(59, 501, 'Data Protection', 'Completed'),
(60, 501, 'Anti-Harassment', 'Completed'),
(61, 502, 'Workplace Safety', 'Completed'),
(62, 502, 'Data Protection', 'Completed'),
(63, 503, 'Workplace Safety', 'Completed'),
(64, 503, 'Data Protection', 'In Progress');
GO

/* ---------- CHECK: expect 5, 30 and 64 rows ---------- */
SELECT 'Departments' AS TableName, COUNT(*) AS TotalRows FROM Departments
UNION ALL
SELECT 'Employees', COUNT(*) FROM Employees
UNION ALL
SELECT 'TrainingRecords', COUNT(*) FROM TrainingRecords;
