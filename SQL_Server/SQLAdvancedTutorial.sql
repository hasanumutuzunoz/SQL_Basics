-- COMMON TABLE EXPRESSION (CTE)
WITH CTE_Employee AS 
(SELECT FirstName, LastName, Gender, Salary, 
COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender,
AVG(Salary) OVER (PARTITION BY Gender) AS AvgSalary
FROM SQLTutorial..EmployeeDemographics emp				  
JOIN SQLTutorial..EmployeeSalary sal					  
	ON emp.EmployeeID = sal.EmployeeID
WHERE Salary > '45000')

SELECT FirstName, AvgSalary FROM CTE_Employee
SELECT * FROM CTE_Employee -- this won't work, only works with first SELECT statement directly under 






-- TEMP TABLES
CREATE TABLE #temp_Employee --We don't need to run CREATE TABLE every time like CTE
(EmployeeID INT,
JobTitle VARCHAR(100),
Salary INT)

SELECT * FROM #temp_Employee 

INSERT INTO #temp_Employee VALUES 
('1001', 'HR', '45000')

-- Insert all from employee salary to temparory table
INSERT INTO #temp_Employee
SELECT * FROM SQLTutorial..EmployeeSalary

DROP TABLE IF EXISTS #temp_Employee2 
CREATE TABLE #temp_Employee2 
(JobTitle VARCHAR(100),
EmployeesPerJob INT,
AvgAge INT,
AvgSalary INT,)

INSERT INTO #temp_Employee2
SELECT JobTitle, COUNT (JobTitle), AVG (Age), AVG(Salary)
FROM SQLTutorial.dbo.EmployeeDemographics emp
JOIN SQLTutorial.dbo.EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT * FROM #temp_Employee2



--STRING FUNCTIONS
CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
From EmployeeErrors

Select *
From EmployeeDemographics

-- Using Trim, LTRIM, RTRIM
Select EmployeeID, TRIM(employeeID) AS IDTRIM -- get rid of spaces from both sides
FROM EmployeeErrors 

Select EmployeeID, RTRIM(employeeID) as IDRTRIM
FROM EmployeeErrors 

Select EmployeeID, LTRIM(employeeID) as IDLTRIM
FROM EmployeeErrors 


-- Using Replace
Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
FROM EmployeeErrors


/* Using Substring
This is good for matching columns in joins. In this example we are taking first 3 letters from each column.*/ 
Select Substring(err.FirstName,1,3), Substring(dem.FirstName,1,3), Substring(err.LastName,1,3), Substring(dem.LastName,1,3)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	on Substring(err.FirstName,1,3) = Substring(dem.FirstName,1,3)
	and Substring(err.LastName,1,3) = Substring(dem.LastName,1,3)

-- Using UPPER and lower
Select firstname, LOWER(firstname)
from EmployeeErrors

Select Firstname, UPPER(FirstName)
from EmployeeErrors

SELECT * FROM EmployeeDemographics





-- STORED PROCEDURES
CREATE PROCEDURE TEST 
AS
SELECT * FROM EmployeeDemographics

EXEC TEST


CREATE PROCEDURE Temp_Employee 
AS
DROP TABLE IF EXISTS #temp_Employee 
Create Table #temp_employee (
JobTitle VARCHAR (100),
EmployeesPerJob INT,
AvgAge INT,
AvgSalary INT)

INSERT INTO #temp_employee
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM SQLTutorial..EmployeeDemographics emp
JOIN SQLTutorial..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT * FROM #temp_Employee

EXEC Temp_Employee @JobTitle = 'Accountant'
EXEC Temp_Employee @JobTitle = 'Salesman'

--EXEC Temp_Employee



-- SUBQUERIES
SELECT * FROM EmployeeSalary

-- Subquery in SELECT
SELECT EmployeeID, Salary, (SELECT AVG(Salary) FROM EmployeeSalary) AS ALLAvgSalary
FROM EmployeeSalary

-- Subquery in PARTITION BY
SELECT EmployeeID, Salary, AVG(Salary) OVER() AS ALLAvgSalary
FROM EmployeeSalary 

-- Subquery in FROM   (slower than TEMP TABLE and  COMMON TABLE EXPRESSION (CTE)! it is not recomended using this method)
SELECT a.EmployeeID, ALLAvgSalary 
FROM (SELECT EmployeeID, Salary, AVG(Salary) OVER() AS ALLAvgSalary
	  FROM EmployeeSalary) a


-- Subquery in WHERE
SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary 
WHERE EmployeeID IN (
	SELECT EmployeeID 
	FROM EmployeeDemographics
	WHERE Age > 30)