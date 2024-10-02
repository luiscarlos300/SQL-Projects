-- Resumo N03

SELECT TOP(100)
	*
FROM FactSales
ORDER BY SalesQuantity DESC


SELECT TOP(10)
	*
FROM DimProduct
ORDER BY UnitPrice DESC, Weight DESC


SELECT
	ProductName,
	Weight
FROM DimProduct
WHERE Weight > 100


SELECT
	COUNT(StoreName) AS 'QTD'
FROM DimStore

SELECT
	StoreName, 
	OpenDate, 
	EmployeeCount
FROM
	DimStore
WHERE CloseDate IS NULL


SELECT
	ProductKey
FROM 
	DimProduct
	WHERE BrandName = 'Litware' AND AvailableForSaleDate = '2009-03-15'


SELECT
	ProductName
FROM
	DimProduct
WHERE ProductName LIKE '%LCD%'