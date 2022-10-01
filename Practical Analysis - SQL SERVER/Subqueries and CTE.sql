-- Subqueries and CTE

/* 1. For tax purposes, the company's accounting needs a table containing all sales referring 
to the store 'Contoso Orlando Store'. This is because this store is located in a region where 
taxation was recently modified.

So create a database query to get a FactSales table containing all the sales for this store. */

DECLARE @varStoreName VARCHAR(100) = 'Contoso Orlando Store'

SELECT * FROM FactSales
WHERE StoreKey = (SELECT 
					StoreKey 
				FROM 
					DimStore 
				WHERE StoreName = @varStoreName)



/* 2. The product control sector wants to do an analysis to find out which products have a 
UnitPrice greater than the UnitPrice of the ID equal to 1893 */

DECLARE @varProductKey INT = 1893

SELECT 
	ProductKey,
	ProductName,
	UnitPrice,
	(SELECT 
		UnitPrice 
	FROM 
		DimProduct 
	WHERE ProductKey = @varProductKey) AS 'UnitPrice 1893'
FROM DimProduct
WHERE UnitPrice > (SELECT 
						UnitPrice 
					FROM 
						DimProduct 
					WHERE ProductKey = @varProductKey)



/* 3. The Asian Holiday Promotion discount action was one of the company's most successful.
Now, Contoso wants to understand a little better about the profile of customers 
who compare products with this promotion.

Your job is to create a query that returns a list of customers who bought in this promotion. */

DECLARE @varPromotion VARCHAR(100) = 'Asian Holiday Promotion'

SELECT 
	*
FROM 
	DimCustomer
WHERE CustomerKey = ANY (SELECT 
							CustomerKey 
						FROM 
							FactOnlineSales 
						WHERE PromotionKey = ANY (SELECT 
												PromotionKey 
											FROM 
												DimPromotion 
											WHERE PromotionName = @varPromotion)
)



/* 4. You must create a query for the sales department that shows the following columns from the DimProduct table:
ProductKey,ProductName, BrandName, UnitPrice, AVG UnitPrice. */

SELECT
	ProductKey,
	ProductName,
	BrandName,
	UnitPrice,
	(SELECT
		AVG(UnitPrice)
	FROM
		DimProduct) AS 'AVG UnitPrice'
FROM	
	DimProduct


/* 5. Create a CTE that is the grouping of the DimProdutct table, storing the total of products by brand.
Then do a SELECT on this CTE, finding out what is the maximum amount of products for a brand. 
Call this CTE CTE_ProductsBrand. */

WITH CTE_ProductsBrand AS(
	SELECT
		BrandName,
		COUNT(*) AS 'Amount'
	FROM
		DimProduct
	GROUP BY BrandName
)

SELECT 
	MAX(Amount) AS 'MAX Amount'
FROM CTE_ProductsBrand