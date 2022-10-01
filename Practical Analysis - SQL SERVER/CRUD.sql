-- CRUD - Create, Read, Update and Delete

/* 1. a) Create a database called BD_Test.
b) Delete the database created in the previous item.
c) Create a database called Exercises. */

CREATE DATABASE BD_Test

DROP DATABASE BD_Test

CREATE DATABASE Exercises


/* 2. In the database created in the previous exercise, create 3 tables, each containing the following
columns:
Table 1: dCustomer
- Customer_ID
- Customer_Name
- Birth date

Table 2: dManager
- ID_Manager
- Name_Manager
- Hiring date
- Wage

Table 3: fContracts
- Contract_ID
- Signature Date
- Customer_ID
- ID_Manager
- Contract value

Finally, do a SELECT to view each table. */

USE Exercises

CREATE TABLE dCustomer (
	Customer_ID FLOAT,
	Customer_Name VARCHAR(100),
	Birth_Date DATETIME
)

CREATE TABLE dManager(
	ID_Manager FLOAT,
	Name_Manager VARCHAR(100),
	Hiring_Date DATETIME,
	Wage FLOAT
)

CREATE TABLE fContracts (
	Contract_ID FLOAT,
	Signature_Date DATETIME,
	ID_Manager FLOAT,
	Contract_Value FLOAT
)

SELECT * FROM dCustomer
SELECT * FROM dManager
SELECT * FROM fContracts

/* 3. Data must be added in the dCustomer, dManager and fContracts tables. stay free
to add a new row in each table containing respectively
(1) a new customer (customer id, name and date of birth)
(2) a new manager (manager id, name, hire date and salary)
(3) a new contract (id, signature date, customer id, manager id, contract value) */

INSERT INTO dCustomer(Customer_ID, Customer_Name, Birth_Date)
VALUES
	(1, 'Luis', '2000/12/27'),
	(2, 'William', '1999/09/10'),
	(3,'Brian', '1988/07/22')


INSERT INTO dManager(ID_Manager, Name_Manager, Hiring_Date, Wage)
VALUES
	(1, 'Rodrigo', '2002/12/01', 25000),
	(2, 'Raphael', '2005/09/10', 15000),
	(3, 'Alex', '2010/07/22', 30000)


INSERT INTO fContracts(Contract_ID, Signature_Date, ID_Manager, Contract_Value)
VALUES
	(1, '2009/07/01', 1, 177000),
	(2, '2005/09/10', 1, 105000),
	(3, '2010/07/22', 2, 300000),
	(4, '2007/09/25', 3, 150000)


/* 4. Contract ID equal to 2 was registered with some errors in the fContracts table. Make one
table change by updating the following values:
Signature_Date: 03/17/2019
ID_Manager: 2
Contract_Valuet: 33500 */

UPDATE fContracts
SET Signature_Date = '2019/03/17', 
	ID_Manager = 2, 
	Contract_Value = 33500
WHERE Contract_ID = 2


/* 5. Delete the table row fContracts that Contract_ID = 3 */

DELETE FROM fContracts
WHERE Contract_ID = 3
