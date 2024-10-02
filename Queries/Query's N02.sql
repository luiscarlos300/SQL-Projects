-- Resumo N02

SELECT
	*
FROM
	DimEmployee
WHERE 
	DepartmentName = 'Marketing' AND Gender = 'F'


SELECT TOP(1)
	*
FROM
	DimSalesTerritory
WHERE SalesTerritoryGroup = 'North America' AND NOT SalesTerritoryCountry = 'United States'