-- VIEWS

/* 1. a) From the DimProduct table, create a View containing the information of
ProductName, ColorName, UnitPrice, and UnitCost, from the DimProduct table. call this view
of vwProducts.

b) From the DimEmployee table, create a View showing FirstName, BirthDate,
DepartmentName. Call this View vwEmployees.
 
c) From the DimStore table, create a View that considers only active stores. Make
a SELECT of all columns. Call this View vwActiveStores.

d) Create a View that is the result of grouping the FactSales table. This one
grouping must consider the SalesQuantity (Total Quantity Sold) by Name of
Product. Call this View vwTotalSoldProducts.*/

CREATE VIEW vwProducts AS
SELECT
	ProductName,
	ColorName,
	UnitPrice,
	UnitCost
FROM
	DimProduct
GO

CREATE VIEW vwEmployees AS
SELECT
	FirstName,
	BirthDate,
	DepartmentName
FROM
	DimEmployee
GO

CREATE VIEW vwActiveStores AS
SELECT
	*
FROM
	DimStore
WHERE CloseDate IS NULL
GO

CREATE VIEW vwTotalSoldProducts AS
SELECT
	ProductName,
	Sum(SalesQuantity) AS 'SalesQuantity'
FROM
	FactSales F
JOIN DimProduct P 
 ON F.ProductKey = P.ProductKey
GROUP BY ProductName
GO


/* 2. Make the following changes to the tables in question 1.

a) In the View created in the letter a of question 1, add the BrandName column.

b) In the View created in the letter c of question 1, make a change and filter only the stores not
active. */

ALTER VIEW vwProducts AS
SELECT
	ProductName,
	ColorName,
	BrandName,
	UnitPrice,
	UnitCost
FROM
	DimProduct
GO

ALTER VIEW vwActiveStores AS
SELECT
	*
FROM
	DimStore
WHERE CloseDate IS NOT NULL
GO


/* Delete the views from the second question */

DROP VIEW vwProducts
DROP VIEW vwActiveStores