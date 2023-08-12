--CREATE TABLE EmployeeDemographics (
--	EmployeeID INT,
--	FirstName VARCHAR(50),
--	LastName VARCHAR(50),
--	Age INT,
--	Gender VARCHAR(50)
--	);


--CREATE TABLE EmployeeSalary (
--	EmployeeID INT,
--	JobTitle VARCHAR(50),
--	Salary INT
--);



INSERT INTO EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male');


Insert Into EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000);


SELECT * FROM EmployeeDemographics;
SELECT * FROM EmployeeSalary;
--DROP TABLE EmployeeDemographics;
SELECT TOP 1 * FROM EmployeeDemographics;
SELECT DISTINCT(Gender) FROM EmployeeDemographics;
SELECT COUNT (LastName) AS LastNameCount FROM EmployeeDemographics;
SELECT MAX(Salary) FROM EmployeeSalary;
SELECT MIN(Salary) FROM EmployeeSalary;
SELECT AVG(Salary) FROM EmployeeSalary;
SELECT * FROM SQLTutorial.dbo.EmployeeSalary;     -- We can define from which database and table if we are in master database, otherwise we will get error because there is no table in the master database. 
SELECT * FROM EmployeeDemographics WHERE FirstName = 'Jim';
SELECT * FROM EmployeeDemographics WHERE FirstName <> 'Jim';  -- <> means does not equal 
SELECT * FROM EmployeeDemographics WHERE Age <= 32 AND Gender = 'Male';
SELECT * FROM EmployeeDemographics WHERE Age <= 32 OR Gender = 'Male';
SELECT * FROM EmployeeDemographics WHERE LastName LIKE 'S%';
SELECT * FROM EmployeeDemographics WHERE LastName LIKE '%S';
SELECT * FROM EmployeeDemographics WHERE LastName LIKE 'S%o%';
SELECT * FROM EmployeeDemographics WHERE FirstName is NOT NULL;
SELECT * FROM EmployeeDemographics WHERE FirstName IN ('Jim', 'Michael', 'Pam');
SELECT Gender, COUNT(Gender) FROM EmployeeDemographics GROUP BY Gender;
SELECT Gender, Age, COUNT(Gender) AS CountGender FROM EmployeeDemographics WHERE Age > 30 GROUP BY Gender, Age ORDER BY Gender DESC;
SELECT * FROM EmployeeDemographics ORDER BY Age, Gender;
SELECT * FROM EmployeeDemographics ORDER BY 4 DESC, 5 DESC;