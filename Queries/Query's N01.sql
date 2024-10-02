-- Resumo N01

SELECT DISTINCT 
	DepartmentName 
FROM 
	DimEmployee

SELECT TOP(5) 
	* 
FROM 
	DimEmployee

SELECT TOP(5) PERCENT 
	* FROM 
DimEmployee

SELECT
	FirstName as 'Nome',
	LastName as 'Sobrenome'
FROM
	DimEmployee

-- Comentários
/* Comentários */

-- Exercícios N01

SELECT
	COUNT(CustomerKey) AS 'Qtde Clientes'
FROM
	DimCustomer

SELECT
	COUNT(ProductKey) AS 'Qtde Produtos'
FROM
	DimProduct

SELECT 
	CustomerKey AS 'ID_Cliente', 
	FirstName AS 'Nome', 
	EmailAddress AS 'E-mail',
	BirthDate AS 'Data_Nascimento'
FROM
	DimCustomer


SELECT TOP(100)
	*
FROM
	DimCustomer

SELECT TOP(10) PERCENT
	*
FROM
	DimCustomer


SELECT DISTINCT
	Manufacturer
FROM
	DimProduct


SELECT
    COUNT(ProductKey) AS 'Qtde Produtos Distintos Vendidos'
FROM
    (SELECT DISTINCT
        ProductKey
    FROM
        FactSales) AS Sales

SELECT
	COUNT( DISTINCT ProductKey) AS 'Qtde Produtos Distintos Vendidos'
FROM
	FactSales