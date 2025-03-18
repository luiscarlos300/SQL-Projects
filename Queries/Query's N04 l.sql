-- Resumo N04

------------------------------------
SELECT
	channelKey,
	SUM( SalesAmount) as 'SALES'
FROM
	FactSales
WHERE YEAR(DateKey) = '2007'
GROUP BY channelKey

------------------------------------
SELECT 
	ProductKey,
	SUM( SalesAmount) AS 'Total'
FROM 
	FactSales
GROUP BY ProductKey
HAVING SUM( SalesAmount) > 5000000
ORDER BY SUM( SalesAmount) DESC

------------------------------------
SELECT TOP(10)
	ProductKey,
	SUM( SalesAmount) AS 'Total'
FROM 
	FactSales
GROUP BY ProductKey
ORDER BY SUM( SalesAmount) DESC

------------------------------------
SELECT
	BrandName,
	COUNT( ProductName) AS 'Qnt'
FROM
	DimProduct
GROUP BY BrandName

------------------------------------
SELECT
	StockTypeName,
	SUM( Weight ) AS 'Total Weight'
FROM
	DimProduct
WHERE BrandName <> 'Contoso'
GROUP BY StockTypeName
ORDER BY SUM( Weight ) DESC

------------------------------------
SELECT
	Gender,
	COUNT( Gender ) as 'Qtd'
FROM
	DimCustomer
WHERE CustomerType = 'Person'
GROUP BY Gender

------------------------------------
SELECT
	DepartmentName,
	COUNT( DepartmentName ) AS 'Qtd'
FROM
	DimEmployee
WHERE EndDate IS NULL
GROUP BY DepartmentName