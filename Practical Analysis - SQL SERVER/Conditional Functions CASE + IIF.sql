-- Conditional Functions

/* 1. The sales department decided to apply a discount to the products according to their class. O
percentage applied must be:

Economy -> 5%
Regular -> 7%
Deluxe -> 9%

a) Make a query to the DimProduct table that returns the following columns: ProductKey,
ProductName, and two other columns that should return the % Discount and UnitPrice with
discount.

b) Make an adaptation of the code so that the 5%, 7% and 9% discount are easily
modified. */

DECLARE @varDiscountD FLOAT = 0.9,
		@varDiscountR FLOAT	= 0.7,
		@varDiscountE FLOAT = 0.5

SELECT
	ProductKey,
	ProductName,
	CASE
		WHEN ClassName = 'Deluxe' THEN @varDiscountD
		WHEN ClassName = 'Regular' THEN @varDiscountR
		ELSE @varDiscountE
	END AS 'Discount',
	CASE
		WHEN ClassName = 'Deluxe' THEN UnitPrice - (UnitPrice * @varDiscountD)
		WHEN ClassName = 'Regular' THEN UnitPrice - (UnitPrice * @varDiscountR)
		ELSE UnitPrice - (UnitPrice * @varDiscountE)
	END AS 'Unit Price'
FROM
	DimProduct



/* 2. You were responsible for the control of the company's products and you must carry out an analysis of the
number of products per brand.
The division of brands into categories should be as follows:

CATEGORY A: More than 500 products
CATEGORY B: Between 100 and 500 products
CATEGORY C: Less than 100 products

Make a query to the DimProduct table and return a table with a grouping of Total of
Products by Brand, in addition to the Category column, according to the rule above. */

SELECT
	BrandName,
	COUNT(ProductName) AS 'Qnt',
	CASE
		WHEN COUNT(ProductName) > 500 THEN 'CATEGORY A'
		WHEN COUNT(ProductName) BETWEEN 100 AND 500 THEN 'CATEGORY B'
		ELSE 'CATEGORY C'
	END AS 'Category'
FROM
	DimProduct
GROUP BY BrandName



/* 3. The logistics sector must carry out a cargo transport of the products that are in the warehouse
from Seattle to the Sunnyside warehouse.
There is not much information about the products that are in the warehouse, it is only known that
there are 100 copies of each Subcategory. That is, 100 laptops, 100 digital cameras, 100
fans, and so on.

The logistics manager defined that the products will be transported by two different routes. In addition
Furthermore, the division of products in each of the routes will be made according to the subcategories (or
that is, all products of the same subcategory will be transported by the same route):

Route 1: Subcategories that have a total sum of less than 1000 kg must be
transported by Route 1.
Route 2: Subcategories that have a total sum greater than or equal to 1000 kg must be
transported by Route 2.

You must perform a query on the DimProduct table and make this division of the subcategories by
each route.*/

SELECT 
	ProductSubcategoryName,
	ROUND(AVG([Weight]) * 100,2) AS 'AVG Weight',
	CASE 
		WHEN ROUND(AVG([Weight]) * 100,2) >= 1000 THEN 'Route 2'
		ELSE 'Route 1'
	END AS 'Route'
FROM
	DimProduct P
INNER JOIN DimProductSubcategory S
	ON P.ProductSubcategoryKey = S.ProductSubcategoryKey
GROUP BY ProductSubcategoryName



/* 4. Find out which store has the most uptime (in days). You must do this
query on the DimStore table, and consider the OpenDate column as a reference for this calculation. */

SELECT 
	StoreName,
	OpenDate,
	CloseDate,
	IIF(CloseDate IS NULL,	
		DATEDIFF(DAY,OpenDate,GETDATE()),
		DATEDIFF(DAY,OpenDate,CloseDate)
	) AS 'Days'
FROM 
	DimStore