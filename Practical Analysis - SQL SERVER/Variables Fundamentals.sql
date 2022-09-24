-- SQL Variable Fundamentals--


/* 1. Declare 4 integer variables. Assign the following values ​​to them:
valor1 = 10
valor2 = 5
valor3 = 34
valor4 = 7 */

DECLARE @var1 FLOAT = 10
DECLARE	@var2 FLOAT = 5
DECLARE	@var3 FLOAT = 34
DECLARE	@var4 FLOAT = 7

/* a) Create a new variable to store the result of the sum between value1 and value2. */

DECLARE @varSum FLOAT = @var1 + @var2

SELECT @varSum AS 'Sum'

/* b) Create a new variable to store the result of subtracting between value3 and value 4. */

DECLARE @varSubtraction FLOAT = (@var3 - @var4)

SELECT @varSubtraction AS 'Subtraction'

/* c) Create a new variable to store the result of the multiplication between the value 1 and the
value4 */

DECLARE @varMultiplication FLOAT = @var1 * @var4

SELECT @varMultiplication AS 'Multiplication'

/* d)Create a new variable to store the result of dividing value3 by value4. 
Note: The result must be in decimal, not in integer. */

DECLARE @varDivision FLOAT = @var3 / @var4

SELECT @varDivision AS 'Division'

/* e) Round the result of letter d) to 2 decimal places */

SELECT ROUND(@varDivision,2) AS 'Division Round'



/* 2. For each declaration of the variables below, pay attention to the type of data that must be
specified. */

/* a) Declare a variable called 'Product' and assign the value of 'Cellphone' */

DECLARE @varProduct AS VARCHAR(30)
SET @varProduct = 'Cellphone'

/* b) Declare a variable called 'Amount' and assign it a value of 12. */

DECLARE @varAmount AS FLOAT
SET @varAmount = 12

/* c) Declare a variable called 'Price' and assign the value 9.99. */

DECLARE @varPrice AS FLOAT
SET @varPrice = 9.99

/* d) Declare a variable called 'Invoicing' and assign the result of the multiplication between
'Amount' and 'Price'. */

DECLARE @varInvoicing AS FLOAT
SET @varInvoicing = @varAmount * @varPrice

/* e) View the result of these 4 variables in a single query, through SELECT. */

SELECT @varProduct AS 'Product', @varPrice AS 'Price', @varAmount AS 'Amount' , @varInvoicing AS 'Invoicing'



/* 3. You are responsible for managing a database where external data is received from
users. In summary, these data are:

- Username
- Birth date
- Number of pets that user has

You will need to create SQL code capable of gathering the information provided by this
user. To simulate this data, create 3 variables, called: name, date_birth and
num_pets. You must store the values ​​'André', '10/02/1998' and 2, respectively */

DECLARE @varName VARCHAR(30) = 'Andre'
DECLARE @varDate_Birth DATETIME = '10/02/1998'
DECLARE @varNum_Pets FLOAT = 2

SELECT 'Mu name is ' + @varName + ',' + 
		' I was born in ' + FORMAT(@varDate_Birth, 'dd/MMM/yyyy') + 
		' and I have two ' + CAST(@varNum_Pets AS VARCHAR(30)) + ' pets.' AS 'Answer'



/* 4. You have just been promoted and your role will be to carry out quality control over the
company stores.

The first information that is passed on to you is that 2008 was a very complicated year for
company, as that was when two of the main stores closed. Your first challenge is to discover
the name of these stores that closed in 2008, so you can understand the reason and
map out action plans to prevent other important stores from taking the same path.

Your result should be structured in a sentence, with the following structure:
'The stores closed in 2008 were: ' + store_name

Obs:Use the PRINT command (not SELECT!) to display the result. */

DECLARE @store_name VARCHAR(100) = ''

SELECT
	@store_name += StoreName + ', '
FROM
	DimStore
WHERE FORMAT(CloseDate,'yyyy') = 2008

PRINT 'The stores closed in 2008 were: ' + LEFT(@store_name, DATALENGTH(@store_name) -2)



/* 5. You need to create a query to show the list of products from the DimProduct table to
a specific subcategory: ‘Lamps’.

Use the concept of variables to arrive at this result */

DECLARE @varIdSubcategory INT,
		@varSubcategoryName VARCHAR(30)

SET @varSubcategoryName = 'Lamps'

SET @varIdSubcategory = (	SELECT ProductSubcategoryKey 
							FROM DimProductSubcategory
							WHERE ProductSubcategoryName = @varSubcategoryName)

SELECT 
	*
FROM
	DimProduct
WHERE ProductSubcategoryKey = @varIdSubcategory