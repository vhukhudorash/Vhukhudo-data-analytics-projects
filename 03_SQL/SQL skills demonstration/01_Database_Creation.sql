/* =====================================================================
   HR Employee Analytics - SQL Project
   File 01 - Database creation
   Run this first. It creates an empty database to work in.
   ===================================================================== */

-- Create the database
CREATE DATABASE HR_Employee_Analytics;
GO

-- Tell SQL Server to use it
USE HR_Employee_Analytics;
GO

-- Check: this should show the name of our new database
SELECT DB_NAME() AS CurrentDatabase;

/* Want to start again from scratch? Run these two lines first:
   USE master;
   DROP DATABASE HR_Employee_Analytics;
*/
