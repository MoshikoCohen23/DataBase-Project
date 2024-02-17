------------------------------סקריפט בנייה ומחיקה
--DROP TABLE CUSTOMERS
CREATE	TABLE CUSTOMERS (
Email			Varchar(40)	PRIMARY KEY NOT NULL,
First_Name		Varchar(20),
Last_Name		Varchar(20),
Password		Varchar(20)	NOT NULL,

CONSTRAINT ck_EMAIL CHECK (Email LIKE '%@%.%'),
CONSTRAINT ck_PASSWORD CHECK ((len([Password])) > (4))
)

-- DROP TABLE CREDIT_CARDS
CREATE	TABLE CREDIT_CARDS (
CC_Number	 	Varchar(16) 	PRIMARY KEY NOT NULL,
CC_Expiration_Month		tinyint 	NOT NULL,
CC_Expiration_Year		tinyint 	NOT NULL,
CC_CVV		 	Varchar(3) 		NOT NULL,

CONSTRAINT ck_Expiration CHECK ( CC_Expiration_Year + 2000 + CC_Expiration_Month > year(getdate() +month (getdate())))
)

--DROP TABLE 	PRODUCTS
CREATE	TABLE 	PRODUCTS (
Item_Number		Int		PRIMARY KEY	NOT NULL,
Price			smallmoney  	NOT NULL,
Model			Varchar(15) 	NOT NULL,
Size			Varchar(5)		NOT NULL,
Color			Varchar(20)		NOT NULL,
Vendor			Varchar(20)		NOT NULL,

CONSTRAINT 	Ck_Price	CHECK 	(Price > 0)	
)

--DROP TABLE SEARCHES
CREATE	TABLE SEARCHES (
IP_Address		Varchar (50)	NOT NULL,
Search_DT		DateTime	NOT NULL,
Content			Varchar (50),
Email			Varchar (40)	FOREIGN KEY REFERENCES CUSTOMERS (Email),
Filter_Sorting	Varchar (20),

PRIMARY KEY (IP_Address, Search_DT),
)


--DROP TABLE FILTERS_PRICES 
CREATE	TABLE FILTERS_PRICES (
IP_Address	 	Varchar(50)	NOT NULL,
Search_DT		DateTime 	NOT NULL,
Filter_Price	Varchar(20) 	NOT NULL,

PRIMARY KEY (IP_Address, Search_DT, Filter_Price),
CONSTRAINT fk_IP_Address1 FOREIGN KEY (IP_Address,Search_DT)
     REFERENCES SEARCHES (IP_Address, Search_DT)
)

--DROP TABLE FILTERS_COLORS 
CREATE	TABLE FILTERS_COLORS (
IP_Address	 	Varchar(50)	NOT NULL,
Search_DT		DateTime 	NOT NULL,
Filter_Color	Varchar(20) 	NOT NULL,

PRIMARY KEY (IP_Address, Search_DT, Filter_Color),
CONSTRAINT fk_IP_Address2 FOREIGN KEY (IP_Address,Search_DT)
     REFERENCES SEARCHES (IP_Address, Search_DT)
)

--DROP TABLE FILTERS_SIZES 
CREATE	TABLE FILTERS_SIZES (
IP_Address	 	Varchar(50)	NOT NULL,
Search_DT		DateTime 	NOT NULL,
Filter_Size	Varchar(20) 	NOT NULL,

PRIMARY KEY (IP_Address, Search_DT, Filter_Size),
CONSTRAINT fk_IP_Address3 FOREIGN KEY (IP_Address,Search_DT)
     REFERENCES SEARCHES (IP_Address, Search_DT)
)

--DROP TABLE FILTERS_VENDORS 
CREATE	TABLE FILTERS_VENDORS (
IP_Address	 	Varchar(50)	NOT NULL,
Search_DT		DateTime 	NOT NULL,
Filter_Vendor	Varchar(20) 	NOT NULL,

PRIMARY KEY (IP_Address, Search_DT, Filter_Vendor),
CONSTRAINT fk_IP_Address4 FOREIGN KEY (IP_Address,Search_DT)
     REFERENCES SEARCHES (IP_Address, Search_DT)
)

--DROP TABLE REVIEWS
CREATE	TABLE REVIEWS ( 
Item_Number		int		NOT NULL,
DT			DateTime	NOT NULL,
Email_Action		Varchar(40) 	NOT NULL,
Name			Varchar(20) 	NOT NULL,
Content		Varchar(5000)	NOT NULL,
Rate			Tinyint	NOT NULL 	DEFAULT 5,
Title			Varchar (100),
Email_Customer	Varchar(40) ,

PRIMARY KEY (Item_Number, DT),
CONSTRAINT fk_ACTIONS FOREIGN KEY (Item_Number)
  REFERENCES PRODUCTS (Item_Number),
CONSTRAINT fk_EMAILCU FOREIGN KEY (Email_Customer)
     REFERENCES CUSTOMERS (Email)
)

--DROP TABLE QUESTIONS
CREATE	TABLE QUESTIONS ( 
Item_Number		int		NOT NULL,
DT			DateTime	NOT NULL,
Email_Action		Varchar(40) 	NOT NULL,
Name			Varchar(20) 	NOT NULL,
Content		Varchar(5000)	NOT NULL,
DT_Answer			DateTime,
Answer	Varchar(100) ,
Email_Customer	Varchar(40) ,


PRIMARY KEY (Item_Number, DT),
CONSTRAINT fk_ACTIONS1 FOREIGN KEY (Item_Number)
  REFERENCES PRODUCTS (Item_Number),
  CONSTRAINT fk_DT CHECK(DT<DT_Answer),
CONSTRAINT fk_EMAILCU1 FOREIGN KEY (Email_Customer)
     REFERENCES CUSTOMERS (Email)

)

--DROP TABLE ADDRESSES 
CREATE	TABLE ADDRESSES (
Email			Varchar(40)	NOT NULL,
Number			Tinyint		NOT NULL,
Apartment		Varchar(5),
Street			Varchar(20) 	NOT NULL,
City			Varchar(20) 	NOT NULL,
State			Varchar(20)	NOT NULL,
Country			Varchar(20)	NOT NULL,
Zip_Code		Varchar(20) 	NOT NULL,

PRIMARY KEY (Email, Number),
CONSTRAINT fk_Email FOREIGN KEY (Email)
			REFERENCES CUSTOMERS (Email)
)

--DROP TABLE RELATES
CREATE	TABLE RELATES ( 
Item_Number_A		int 		NOT NULL,			
Item_Number_B		int 		NOT NULL,

PRIMARY KEY (Item_Number_A, Item_Number_B),
CONSTRAINT fk_Item_Number_A FOREIGN KEY (Item_Number_A)
 REFERENCES PRODUCTS (Item_Number),
CONSTRAINT fk_Item_Number_B FOREIGN KEY (Item_Number_B)
				 REFERENCES PRODUCTS (Item_Number)
)


--DROP TABLE FINDS
CREATE	TABLE 	FINDS (
Item_Number		Int 		NOT NULL,
IP_Address		Varchar(50)	NOT NULL,
Search_DT		DateTime	NOT NULL,

PRIMARY KEY (Item_Number, IP_Address, Search_DT),
CONSTRAINT	fk_ItemNum	FOREIGN KEY	(Item_Number)
				REFERENCES	PRODUCTS (Item_Number),
CONSTRAINT   fk_IP	FOREIGN KEY	(IP_Address,Search_DT)
			REFERENCES	SEARCHES (IP_Address,Search_DT)
)


--DROP TABLE ORDERS 
CREATE	TABLE ORDERS (
Order_ID 		Int PRIMARY KEY 	NOT NULL, 
First_Name		Varchar (20)		NOT NULL,
Last_Name		Varchar (20) 		NOT NULL,
Email_Order		Varchar(40) 		NOT NULL,
Date 			Date 				NOT NULL,
Delivery_Method 	Char(1) 		NOT NULL,
Shipping_Rate		SmallMoney		NOT NULL, 
Phone 			Varchar(10) 		NOT NULL,
Company 		Varchar(10),
Address_Apartment	Varchar(5),
Address_Street	Varchar(20) 		NOT NULL,
Address_City		Varchar(20) 		NOT NULL,
Address_State		Varchar(20) 		NOT NULL,
Address_Country      Varchar(20) 		NOT NULL,
Address_Zip_Code	Varchar(20) 		NOT NULL,
Email_Customer     	Varchar(40) 	FOREIGN KEY (Email_customer)  
REFERENCES CUSTOMERS(Email),
Address_Number 	tinyint,
CC_Number		Varchar(16)     		NOT NULL,
CONSTRAINT ck_Delivery_Method CHECK (Delivery_Method IN ('D','P')),	
CONSTRAINT ck_Email_Order CHECK (Email_Order LIKE '%@%.%'),	
CONSTRAINT ck_Shipping_Rate CHECK (Shipping_Rate >= 0 ),
CONSTRAINT fk_CC_Number FOREIGN KEY (CC_Number)
				REFERENCES CREDIT_CARDS (CC_Number),
CONSTRAINT fk_Email_Address FOREIGN KEY (Email_Customer, Address_Number)
				 REFERENCES ADDRESSES (Email, Number)
)


--DROP TABLE IS_CONTAINS
CREATE	TABLE IS_CONTAINS (
Order_ID	int 	NOT NULL,
Item_Number	int 	NOT NULL,
Quantity	Tinyint 	NOT NULL DEFAULT 1,

PRIMARY KEY(Order_ID,Item_Number),	
CONSTRAINT fk_Order_ID FOREIGN KEY (Order_ID)
				REFERENCES ORDERS (Order_ID),
CONSTRAINT fk_Item_Number FOREIGN KEY (Item_Number)
				REFERENCES PRODUCTS (Item_Number),
CONSTRAINT ck_Quantity CHECK (Quantity > 0)
)

--DROP TABLE NAMES
CREATE	TABLE NAMES (
Item_Number		Int		PRIMARY KEY	NOT NULL,
Name	Varchar(100)	NOT NULL,
CONSTRAINT fk_PRODUCT_NAME FOREIGN KEY (Item_Number)
     REFERENCES PRODUCTS (Item_Number)
)


--DROP TABLE COLORS
CREATE TABLE COLORS (
Color Varchar(20) PRIMARY KEY)

INSERT COLORS
SELECT Distinct Color FROM PRODUCTS

ALTER TABLE PRODUCTS
	ADD CONSTRAINT FK_COLOR FOREIGN KEY (Color) REFERENCES COLORS (Color)

--DROP TABLE VENDORS
CREATE TABLE VENDORS (
Vendor Varchar(20) PRIMARY KEY)

INSERT VENDORS
SELECT Distinct Vendor FROM PRODUCTS

ALTER TABLE PRODUCTS
	ADD CONSTRAINT FK_VENDOR FOREIGN KEY (Vendor) REFERENCES VENDORS (Vendor)

--DROP TABLE STATES
CREATE TABLE STATES (
State Varchar(20) PRIMARY KEY not null)

INSERT STATES
SELECT Distinct State FROM ADDRESSES

ALTER TABLE ADDRESSES
	ADD CONSTRAINT FK_STATES1 FOREIGN KEY (State) REFERENCES STATES (State)

ALTER TABLE ORDERS
	ADD CONSTRAINT FK_STATES2 FOREIGN KEY (Address_State) 
REFERENCES STATES (State)


--DROP TABLE CITIES
CREATE TABLE CITIES (
City Varchar(20) PRIMARY KEY not null)

INSERT CITIES
SELECT Distinct City FROM ADDRESSES

ALTER TABLE ADDRESSES
	ADD CONSTRAINT FK_CITY1 FOREIGN KEY (City) REFERENCES CITIES (City)

ALTER TABLE ORDERS
	ADD CONSTRAINT FK_CITIES2 FOREIGN KEY (Address_City) 
REFERENCES CITIES (City)

-- 

DROP TABLE IS_CONTAINS
DROP TABLE ORDERS
DROP TABLE ADDRESSES
DROP TABLE CITIES
DROP TABLE STATES
DROP TABLE CREDIT_CARDS
DROP TABLE REVIEWS
DROP TABLE QUESTIONS
DROP TABLE RELATES
DROP TABLE FINDS
DROP TABLE FILTERS_COLORS
DROP TABLE FILTERS_PRICES
DROP TABLE FILTERS_SIZES
DROP TABLE FILTERS_VENDORS
DROP TABLE SEARCHES
DROP TABLE NAMES
DROP TABLE PRODUCTS
DROP TABLE COLORS
DROP TABLE VENDORS
DROP TABLE CUSTOMERS



----------------------------------חלק 1
---שתי שאילתות ללא קינון
SELECT 	P.Vendor , TotalSales= SUM(I.Quantity) 
FROM 		ORDERS AS O JOIN IS_CONTAINS AS I ON O.Order_ID=I.order_ID JOIN
PRODUCTS AS P ON P.Item_Number=I.Item_Number
WHERE 		YEAR(O.Date)=2021
GROUP BY 	P.Vendor
HAVING 	SUM(I.Quantity) > 3
ORDER BY 	2 DESC

SELECT 	Product=P1.Item_Number, N1.Name, P1.Price, RelatedProduct=P2.Item_Number,
N2.Name , P2.Price
FROM  		PRODUCTS AS P1 JOIN NAMES AS N1 ON P1.Item_Number=N1.Item_Number JOIN
RELATES AS R ON P1.Item_Number=R.Item_Number_A JOIN PRODUCTS AS P2 ON P2.Item_Number=R.Item_Number_B JOIN NAMES AS N2 ON N2.Item_Number=P2.Item_Number
WHERE 		P1.Price > P2.Price  AND  P1.Price/P2.Price < 1.35
ORDER BY 	1,6

---שתי שאילתות מקוננות

SELECT TOP 5 	X20.Item_Number, Sold2019=X19.Total, Sold2020=X20.Total,  
Ratio = cast(X20.total as real) / cast(X19.total as real)
FROM		((SELECT  DISTINCT P.Item_Number, Total=SUM(I.Quantity)  
FROM PRODUCTS AS P JOIN IS_CONTAINS AS I ON P.Item_Number=I.Item_Number JOIN ORDERS AS O ON O.Order_ID = I.Order_ID
		  WHERE year(O.Date) = 2020 
		  GROUP BY P.Item_Number ) AS X20 JOIN
		 (SELECT  DISTINCT P.Item_Number, Total=SUM(I.Quantity)  
		  FROM PRODUCTS AS P JOIN IS_CONTAINS AS I ON P.Item_Number=I.Item_Number
  JOIN ORDERS AS O ON O.Order_ID = I.Order_ID
		  WHERE year(O.Date) = 2019 
		  GROUP BY P.Item_Number ) AS X19 ON X20.Item_Number = X19.Item_Number)
ORDER BY 	Ratio DESC


SELECT 	City = O.Address_City , Amount = SUM(P.Price * I.Quantity) 
FROM 		PRODUCTS AS P JOIN IS_CONTAINS AS I ON P.Item_Number = I.Item_Number JOIN
ORDERS AS O ON I.Order_ID = O.Order_ID 
GROUP BY 	O.Address_City
HAVING 	SUM(P.Price*I.Quantity) < (SELECT TotalSum = SUM(P.Price * I.Quantity )
FROM PRODUCTS AS P JOIN IS_CONTAINS AS I ON P.Item_Number = I.Item_Number JOIN ORDERS AS O ON I.Order_ID = O.Order_ID ) 
     /(SELECT COUNT(DISTINCT Address_City)
FROM ORDERS)
ORDER BY 	2



---שתי שאילתות מקוננות עם מרכיבים נוספים

UPDATE PRODUCTS 
SET Price= (
	CASE WHEN PRODUCTS.Item_Number in (SELECT TOP 10 P.Item_Number 
				 		FROM 		PRODUCTS AS P JOIN IS_CONTAINS AS 
I ON P.Item_Number = I.Item_Number JOIN ORDERS AS O ON 
O.Order_ID = I.Order_ID
				 		WHERE 		datediff(mm,O.Date,GETDATE())<= 6
						GROUP BY  	P.Item_Number 
						ORDER BY 	SUM(I.Quantity)) 
THEN PRODUCTS.Price*0.8
		ELSE PRODUCTS.Price END)

	
SELECT  	Item_Number, Price
FROM		PRODUCTS 
WHERE 		Item_Number IN (SELECT TOP 10 	P.Item_Number 
				  FROM 		PRODUCTS AS P JOIN IS_CONTAINS AS I ON
P.Item_Number = I.Item_Number JOIN ORDERS AS O ON O.Order_ID = I.Order_ID
				 WHERE 		datediff (mm, O.Date, GETDATE()) <= 6
				 GROUP BY  		P.Item_Number 
				 ORDER BY 		SUM(I.Quantity))
ORDER BY Price

--
SELECT		Email = E.Email_Action , Q.Name
FROM(	SELECT DISTINCT	Q1.Email_Action
	FROM 			QUESTIONS AS Q1 
	WHERE			((SELECT AV 
				  FROM  (SELECT Email_Action,  AV =COUNT(DISTINCT DT)
					  FROM QUESTIONS AS Q2
					  WHERE  Q1.Email_Action = Q2.Email_Action  
					  GROUP BY Email_Action) AS NUM_Q)
						>       
					 (SELECT AVRAGE = cast(SUM(TotalQ) AS real) / 
						  cast (COUNT(DISTINCT Email_Action) AS real)           
					  FROM (SELECT Email_Action, TotalQ =COUNT(DISTINCT DT)
				  		 FROM   QUESTIONS 
				  		 GROUP BY Email_Action) AS X))	
	EXCEPT 

	SELECT DISTINCT Email_Order
	FROM ORDERS) AS E JOIN QUESTIONS AS Q ON E.Email_Action = Q.Email_Action


	
----------------------------------חלק 2
---VIEW
--DROP VIEW V_PRODUCTS_IN_ORDERS
CREATE VIEW V_PRODUCTS_IN_ORDERS AS
SELECT 	Order_ID = O.Order_ID, Order_Date = O.Date ,City = O.Address_City, 
Item_Number = P.Item_Number, Name = N.Name
FROM 		PRODUCTS AS P JOIN IS_CONTAINS AS I ON P.Item_Number=I.Item_Number JOIN
ORDERS AS O ON I.Order_ID=O.Order_ID JOIN NAMES AS N ON
N.Item_Number= P.Item_Number

SELECT 	City, Num_Rollerbalde = COUNT ( DISTINCT Item_Number)
FROM 		V_PRODUCTS_IN_ORDERS 
WHERE 		Name LIKE '%Skate%' AND YEAR(Order_Date) = 2018 
GROUP BY	City
HAVING  	COUNT(DISTINCT Item_Number) > 1
ORDER BY 	Num_Rollerbalde DESC

---פונקציות
--DROP FUNCTION FilterUsage
CREATE FUNCTION FilterUsage ( @Filter Varchar(20) , @DateFrom Date , @DateTo Date )  
RETURNS  INT
AS 	BEGIN
		DECLARE @TimesBeenUsed INT
		IF ( @Filter = 'Color' ) 
			SELECT 	@TimesBeenUsed = count (*) 
			FROM		FILTERS_COLORS AS FC
			WHERE 		FC.Search_DT BETWEEN @DateFrom AND @DateTo
			 
		IF ( @Filter = 'Price' ) 
			SELECT 	@TimesBeenUsed = count (*) 
			FROM		FILTERS_PRICES AS FP
			WHERE 		FP.Search_DT BETWEEN @DateFrom AND @DateTo
			
		IF ( @Filter = 'Size' )
			SELECT 	@TimesBeenUsed = count (*) 
			FROM		FILTERS_SIZES AS FS
			WHERE 		FS.Search_DT BETWEEN @DateFrom AND @DateTo
			
		IF ( @Filter = 'Vendor' )
			SELECT 	@TimesBeenUsed = count (*) 
			FROM		FILTERS_VENDORS AS FV
			WHERE 		FV.Search_DT BETWEEN @DateFrom AND @DateTo
		
		IF ( @Filter ='Best Selling'  )
			SELECT 	@TimesBeenUsed = count (*) 
			FROM		SEARCHS AS S
			WHERE 		S.Search_DT BETWEEN @DateFrom AND @DateTo AND
(S.Filter_Sorting ='Best Selling')
			
		IF ( @Filter = 'Price, low to high' )
			SELECT 	@TimesBeenUsed = count (*) 
			FROM		SEARCHS AS S
			WHERE 		S.Search_DT BETWEEN @DateFrom AND @DateTo AND
(S.Filter_Sorting ='Price, low to high')

		IF ( @Filter ='Price, high to low' )
			SELECT 	@TimesBeenUsed = count (*) 
			FROM		SEARCHS AS S
			WHERE 		S.Search_DT BETWEEN @DateFrom AND @DateTo AND
(S.Filter_Sorting ='Price, high to low')

		IF ( @Filter =' Alphabetically, A-Z' )
			SELECT 	@TimesBeenUsed = count (*) 
			FROM		SEARCHS AS S
			WHERE 		S.Search_DT BETWEEN @DateFrom AND @DateTo AND  
(S.Filter_Sorting =' Alphabetically, A-Z')
			
		IF ( @Filter = 'Alphabetically, Z-A')
			SELECT 	@TimesBeenUsed = count (*) 
			FROM		SEARCHS AS S
			WHERE 		S.Search_DT BETWEEN @DateFrom AND @DateTo AND
  		(S.Filter_Sorting ='Alphabetically, Z-A')

RETURN 	@TimesBeenUsed
END

SELECT 	Timeused= dbo.FilterUsage ('color' , '01/01/2017' , '01/01/2020 ')

--

CREATE 	Function 	VIPCustomers (@Amount int, @Months int) 
RETURNS 	TABLE 
AS	RETURN
		SELECT		C.Email, FullName = C.First_Name +' '+C.Last_Name,
 				Amount= SUM (I.Quantity*P.Price)
		FROM		CUSTOMERS AS C JOIN ORDERS AS O ON C.Email=O.Email_Customer 
JOIN IS_CONTAINS AS I ON O.Order_ID=I.Order_ID JOIN
PRODUCTS AS P ON P.Item_Number=I.Item_Number
		WHERE		Datediff (mm,O.Date, getdate())<= @Months
		GROUP BY	C.Email, C.First_Name, C.Last_Name
		HAVING		SUM (I.Quantity*P.Price) >= @Amount

SELECT 	*	
FROM 	dbo.VIPCustomers (600,12)
ORDER BY	3 DESC

---טריגר פשוט
--DROP 	TRIGGER 	Set_Ratio
CREATE 	TRIGGER 	Set_Ratio
		ON		IS_CONTAINS
		FOR 		INSERT

AS	
UPDATE	PRODUCTS 
SET 	
TotalIncome = (SELECT 	SUM (I.Quantity* P.Price)
  FROM 	PRODUCTS AS P JOIN IS_CONTAINS AS I 
ON P.Item_Number= I.Item_Number
			 WHERE 	P.Item_Number = PRODUCTS.Item_Number  ) 
UPDATE	PRODUCTS 
SET
	[Ratio (%)] = (SELECT	SUM (I.Quantity* P.Price) * 100
			 FROM 		PRODUCTS AS P JOIN IS_CONTAINS AS I
ON P.Item_Number = I.Item_Number
			 WHERE P.Item_Number = PRODUCTS.Item_Number)  /
			(SELECT SUM (I.Quantity* P.Price)
			 FROM PRODUCTS AS P JOIN IS_CONTAINS AS I ON
 P.Item_Number = I.Item_Number)

 --ALTER TABLE PRODUCTS DROP COLUMN TotalIncome
ALTER 	TABLE 	PRODUCTS
ADD	TotalIncome 	real

--ALTER TABLE PRODUCTS DROP COLUMN Ratio
ALTER 	TABLE 	PRODUCTS
ADD	[Ratio (%)] 	real
UPDATE	PRODUCTS 
SET 	
     TotalIncome=(SELECT SUM (I.Quantity* P.Price)
		    FROM PRODUCTS AS P JOIN IS_CONTAINS AS I ON P.Item_Number=I.Item_Number
		    WHERE P.Item_Number = PRODUCTS.Item_Number  ) 
UPDATE	PRODUCTS 
SET
     [Ratio (%)]=(SELECT SUM (I.Quantity* P.Price) * 100
		    FROM PRODUCTS AS P JOIN IS_CONTAINS AS I ON P.Item_Number=I.Item_Number
		    WHERE P.Item_Number = PRODUCTS.Item_Number) /
		   (SELECT SUM (I.Quantity* P.Price)
		    FROM PRODUCTS AS P JOIN IS_CONTAINS AS I ON  
  P.Item_Number=I.Item_Number)

SELECT *
FROM PRODUCTS 
WHERE Item_number = 10120


INSERT INTO  ORDERS (Order_ID, First_name, Last_name, Email_order, Date , Delivery_method , shipping_rate , phone , company , Address_Apartment ,Address_Street, Address_City ,Address_State ,Address_Country, Address_Zip_Code, Email_customer , cc_number, Address_Number)
VALUES (888888, 'Doili', 'Soli' ,'DOLisoli@gmail.com' ,'2021-05-28','P' ,0,05642647353,'icx', 2,'rager', 'Norfolk', 'california', 'USA', 77777,NULL , '3492555390354670', NULL)

INSERT INTO IS_CONTAINS (Order_ID,Item_Number ,Quantity )
VALUES(888888 ,10120, 1 )

---פרוצדורה
--DROP PROCEDURE SP_BestSellers
CREATE PROCEDURE SP_BestSellers	@DateFrom Date ,  @DateTo Date
AS BEGIN
IF (SELECT Object_ID ('BEST_SELLERS')) IS NOT NULL DROP TABLE BEST_SELLERS

CREATE TABLE	BEST_SELLERS (	
		Item_Number		Int	PRIMARY KEY	NOT NULL,
		Name 			VARCHAR (100)		NOT NULL,
		NumberOfSales		Int			NOT NULL )

INSERT INTO 	BEST_SELLERS 

	SELECT TOP 10  P.Item_Number,N.Name, NumberOfSales= SUM(Distinct I.Quantity)
	FROM 		 PRODUCTS AS P JOIN IS_CONTAINS AS I ON P.Item_Number= I.Item_Number
 			 JOIN ORDERS AS O ON O.Order_ID = I.Order_ID 
 JOIN NAMES AS N ON P.Item_number = N.Item_number
	WHERE 		 O.Date BETWEEN @DateFrom AND @DateTo
	GROUP BY 	 P.Item_number, N.Name
	ORDER BY 	 NumberOfSales DESC 
END

EXECUTE SP_BestSellers  '01/01/2017' , '01/01/2020'

SELECT *
FROM BEST_SELLERS
ORDER BY NumberOfSales DESC



----------------------------------חלק 4
---טריגר מורכב
-- DROP TRIGGER Set_Address
CREATE 	TRIGGER 	Set_Address
		ON			ORDERS
		FOR 		INSERT, UPDATE
AS	---הגדרת משתנים של אינסטרטד
DECLARE @Order_ID		int
DECLARE @First_Name		Varchar (20)
DECLARE @Last_Name		Varchar (20)
DECLARE @Email_Order			Varchar (40)
DECLARE @Date			Date
DECLARE @Delivery_Method			Char (1)
DECLARE @Shipping_Rate			smallmoney
DECLARE @Phone			Varchar (10)
DECLARE @Company			Varchar (10)
DECLARE @Address_Apartment		Varchar (5)
DECLARE @Address_Street	Varchar (20)
DECLARE @Address_City	Varchar (20)
DECLARE @Address_State	Varchar (20)
DECLARE @Address_Country	Varchar (20)
DECLARE @Address_Zip_Code	Varchar (20)
DECLARE @Email_Customer		Varchar (40)
DECLARE @Address_Number		tinyint
DECLARE @CC_Number		Varchar (16)
			
--- לולאה של אינסטרטד
DECLARE 	INSERTED_CURSOR 	CURSOR FOR		
SELECT	Order_ID, First_Name, Last_Name, Email_Order,Date	, Delivery_Method, Shipping_Rate, Phone	, Company, Address_Apartment, Address_Street, Address_City, Address_State, Address_Country, Address_Zip_Code,  Email_Customer, Address_Number, CC_Number
FROM 		INSERTED
WHERE (Email_Customer IS NOT NULL) AND (Address_Number IS NULL)
			
BEGIN 
OPEN INSERTED_CURSOR
FETCH  NEXT  FROM INSERTED_CURSOR INTO  @Order_ID, @First_Name, @Last_Name, @Email_Order, @Date, @Delivery_Method, @Shipping_Rate, @Phone, @Company, @Address_Apartment, @Address_Street, @Address_City, @Address_State, @Address_Country, @Address_Zip_Code, @Email_Customer, @Address_Number ,@CC_Number

DECLARE 	@X int
SET @X = (select COUNT (DISTINCT Order_ID) FROM inserted)

WHILE (@X>0) -- עבור שורה אחת באינסטרטד
BEGIN
			
	DECLARE @Email		Varchar (40)
	DECLARE @Number		tinyint
	DECLARE @Apartment		Varchar (5)
	DECLARE @Street	Varchar (20)
	DECLARE @City	Varchar (20)
	DECLARE @State	Varchar (20)
	DECLARE @Country	Varchar (20)
	DECLARE @Zip_Code	Varchar (20)
			
	DECLARE 	ADDRESSE_CURSOR 	CURSOR FOR		
	SELECT		Email, Number, Apartment, Street, City, State, Country, Zip_Code
	FROM 		ADDRESSES
	WHERE		Email = @Email_Customer
			
BEGIN
	OPEN ADDRESSE_CURSOR
FETCH  NEXT  FROM ADDRESSE_CURSOR INTO @Email, @Number, @Apartment, @Street, @City, @State, @Country, @Zip_Code	
												
	DECLARE @I		int
	SET @I = 0
					
	DECLARE 	@Y int
	SET @Y = (select COUNT (*) FROM ADDRESSES WHERE Email = @Email_Customer)									
	WHILE (@Y>0)
	BEGIN					
IF ((@Email_Customer = @Email) AND (@Address_Number IS NULL) AND (@Address_Apartment = @Apartment) AND (@Address_Street = @Street) AND 
		(@Address_City = @City) AND (@Address_State = @State) AND 
		(@Address_Country = @Country) AND (@Address_Zip_Code =@Zip_Code)) SET @I= 1
					
FETCH  NEXT  FROM ADDRESSE_CURSOR INTO @Email, @Number, @Apartment, @Street, @City, @State, @Country, @Zip_Code
	SET @Y = @Y -1
	END -- END BEGIN

	IF ((@Email_Customer = @Email) AND (@Address_Number IS NULL) AND (@I = 0))
INSERT INTO ADDRESSES (Email, Number, Apartment, Street, City, State, Country, Zip_Code)
		VALUES (@Email_Customer,  1 + (SELECT COUNT (*) 
						   FROM ADDRESSES
				   WHERE Email = @Email_Customer), @Address_Apartment , @Address_Street, @Address_City, @Address_State, @Address_Country, @Address_Zip_Code)			
						
				
	CLOSE ADDRESSE_CURSOR
	DEALLOCATE ADDRESSE_CURSOR
	END -- END BEGIN

	SET @X = @X -1
FETCH  NEXT  FROM INSERTED_CURSOR INTO  @Order_ID, @First_Name, @Last_Name, @Email_Order, @Date, @Delivery_Method, @Shipping_Rate, @Phone, @Company, @Address_Apartment, @Address_Street, @Address_City, @Address_State, @Address_Country, @Address_Zip_Code, @Email_Customer, @Address_Number ,@CC_Number
END -- END BEGIN
CLOSE INSERTED_CURSOR
DEALLOCATE INSERTED_CURSOR
END -- END BEGIN

INSERT INTO  ORDERS (Order_ID, First_name, Last_name, Email_order, Date , Delivery_method , shipping_rate , phone , company , Address_Apartment ,Address_Street, Address_City ,Address_State ,Address_Country, Address_Zip_Code, Email_customer ,cc_number , Address_Number )
VALUES (9929, 'Sarah', 'Marshall' ,'bglartr503@gmail.net' ,'2021-05-28','P' ,0,05642647353,'icx', 2,'rager', 'Norfolk', 'california', 'USA', 77777,'bglartr503@gmail.net' ,'3492555390354670' ,NULL)

select *
from ADDRESSES
where Email='bglartr503@gmail.net'


---WINDOW FUNCTION
-- DROP VIEW V_ORDER_IN_PRODUCTS
CREATE VIEW V_ORDER_IN_PRODUCTS AS
SELECT P.Item_Number, N.Name ,[Total Income] = SUM (P.Price * I.Quantity)
FROM ORDERS AS O JOIN IS_CONTAINS AS I ON O.Order_ID=I.Order_ID JOIN PRODUCTS AS P ON P.Item_Number=I.Item_Number JOIN NAMES AS N ON N.Item_Number=P.Item_Number
GROUP BY P.Item_Number, N.Name


-- DROP VIEW V_ranktot
CREATE VIEW V_ranktot
AS
SELECT 
Item_Number,Name, [Total Income], RANK () OVER (ORDER BY [Total Income] DESC )[Rank],  
[Income Percent] = [Total Income] / (select sum([Total Income]) from V_ORDER_IN_PRODUCTS)
FROM V_ORDER_IN_PRODUCTS




-- DROP FUNCTION TOTAL_PERCENT
CREATE FUNCTION TOTAL_PERCENT (@RANK1 INT) 

RETURNS REAL
AS
BEGIN 

DECLARE @R INT
SET @R = @RANK1
DECLARE @TOTAL_PERCENT REAL
SET @TOTAL_PERCENT = 0

WHILE (@R > 0)
BEGIN
SET @TOTAL_PERCENT = @TOTAL_PERCENT + ISNULL((SELECT [Income Percent] from V_ranktot where [Rank] = @R) ,0)
SET @R = @R -1
END 

RETURN  @TOTAL_PERCENT
END

SELECT Item_Number,Name, [Total Income], [Rank] , 	[Precent Rank]=( (1/cast((select count(*) from V_ORDER_IN_PRODUCTS) as real)) * [Rank] ),
							 [Income Percent] , [Total Percent] = CAST(dbo.TOTAL_PERCENT([Rank]) AS float)

FROM V_ranktot as v1

--

SELECT State=O.Address_State, [Total Price ] = SUM (I.Quantity * P.Price ) ,  ROUND(CUME_DIST() OVER ( ORDER BY SUM (I.Quantity * P.Price ) DESC),2) [Top] ,
NTILE (3) OVER (ORDER BY SUM (I.Quantity * P.Price ) DESC) [Third] -- 1 Top Third , 2 Middle Third , 3 Lower Third
FROM ORDERS AS O JOIN IS_CONTAINS AS I ON O.Order_ID = I.Order_ID JOIN PRODUCTS AS P  ON P.Item_Number = I.Item_Number
GROUP by  O.Address_State
order by O.Address_State

--

-- DROP VIEW V_ORDER1_IN_PRODUCTS
CREATE VIEW V_ORDER1_IN_PRODUCTS AS
SELECT yy=YEAR(O.Date), mm =MONTH(o.date) ,TOTAL = SUM (P.Price * I.Quantity)
FROM ORDERS AS O JOIN IS_CONTAINS AS I ON O.Order_ID=I.Order_ID JOIN PRODUCTS AS P ON P.Item_Number=I.Item_Number
GROUP BY YEAR(o.date), MONTH(O.Date)


SELECT [Year]=vvv.yy,[Month]=vvv.mm,[This Month]=TOTAL ,
LAG(TOTAL,1) OVER (ORDER BY yy,mm) [Previous Month],
[Growth Rate] = ROUND((TOTAL/cast(LAG(TOTAL,1) OVER (ORDER BY yy,mm) as real )),2)					
FROM V_ORDER1_IN_PRODUCTS as vvv
ORDER BY 1,2

---דוח מושתת על שאילתה מקוננת מורכבת
-- DROP VIEW V_OrderAndQAndP
CREATE VIEW V_OrderAndQAndP AS 
SELECT O.Order_ID ,I.Item_Number,O.Email_Customer, O.Email_Order, O.Date ,I.Quantity
FROM ORDERS AS O JOIN IS_CONTAINS AS I ON O.Order_ID = I.Order_ID 

SELECT	P.Item_Number ,N.Name,
		[Last Search] = (SELECT (Max (F.Search_DT))
				   FROM FINDS AS F 
				   WHERE F.Item_Number= P.Item_Number  ) ,
		[Last Sell] =	(SELECT (Max (v.Date))
				 FROM V_OrderAndQAndP  as v
				 WHERE v.Item_Number= P.Item_Number  ) ,
		[Avrage Rate] = (SELECT AVG (R.Rate)
				   FROM REVIEWS AS R 
				   WHERE P.Item_Number = R.Item_Number ) ,
		[Rate Credabilty]= (SELECT (COUNT(DISTINCT R.DT)/CAST(AVG (R.Rate)AS REAL))
					FROM REVIEWS AS R 
					WHERE P.Item_Number = R.Item_Number ), 
		Questions = (SELECT COUNT( DISTINCT Q.DT )
				FROM QUESTIONS AS Q
				WHERE Q.Item_Number =P.Item_Number  ) ,
		Orders = (SELECT TOT=COUNT (distinct V.Order_ID)
			   FROM V_OrderAndQAndP AS V
			   WHERE V.Item_Number = P.Item_Number ) ,
		[Products Sold] = (SELECT TOT =SUM(V.Quantity) 
				     FROM V_OrderAndQAndP AS V
				     WHERE V.Item_Number = P.Item_Number),
		[Customers Bought] = (SELECT Count (Distinct V.Email_Order)
					 FROM V_OrderAndQAndP AS V
					 WHERE V.Item_Number = P.Item_Number ) ,
		Income = (SELECT SUM (I.quantity * P1.Price )
   FROM IS_CONTAINS AS I JOIN PRODUCTS AS P1 ON  
 I.Item_Number=P1.Item_Number
			   WHERE I.Item_Number = P.Item_Number ) ,
		[Best Selling]= ( CASE WHEN (P.Item_Number IN (SELECT B.Item_Number
								      FROM BEST_SELLERS AS B)) 
									THEN 'Yes'  ELSE 'No' END					
FROM PRODUCTS AS P JOIN NAMES AS N ON P.Item_Number = N.Item_Number
GROUP BY P.Item_Number , N.Name 
ORDER BY  Income DESC

-----------------------------------VIEWS AND TABLES FOR POWER BI

--DROP VIEW V_Sales
CREATE VIEW [dbo].[V_Sales] AS
SELECT I.Order_ID, I.Item_Number, N.Name, P.Model, P.Size, P.Color, P.Vendor, P.Price, I.Quantity, P.TotalIncome, O.First_Name, O.Last_Name,
O.Email_Order, O.Date, O.Delivery_Method, O.Shipping_Rate, O.Company, O.Address_City, O.Address_State, O.Email_Customer, O.Address_Number
FROM PRODUCTS AS P JOIN IS_CONTAINS AS I ON P.Item_Number = I.Item_Number JOIN
		ORDERS AS O ON I.Order_ID = O.Order_ID JOIN NAMES AS N ON N.Item_Number = P.Item_Number
GO


--DROP VIEW V_CATEGORIES
CREATE VIEW V_CATEGORIES AS
SELECT P.Item_Number , N.Name, P.TOTALINCOME, Amount= SUM(I.QUANTITY), Category= (CASE WHEN N.Name like '%Ice%' THEN 'Ice Skate'							
WHEN N.Name like '%bag%' THEN 'Bag'
WHEN (N.Name like '%gear%') OR (N.Name like '%helmet%')  THEN 'Protective Gear'
WHEN N.Name like '%skate%' THEN 'Rollerskate' ELSE 'Clothing' END) 
FROM PRODUCTS AS P JOIN IS_CONTAINS AS I ON P.Item_Number = I.Item_Number JOIN NAMES AS N ON N.Item_Number = P.Item_Number
GROUP BY P.Item_Number, N.Name, P.TOTALINCOME
GO


--DROP VIEW V_StateSales
CREATE VIEW V_StateSales AS
SELECT		O.Address_State, TotalIncome = SUM(I.QUANTITY * P.PRICE) ,
		row_number() over (order by SUM(I.QUANTITY * P.PRICE)  desc) as Rank,  
		BestProduct= (SELECT TOP 1		X.Item_Number
FROM	(SELECT TOP 100000 O1.Address_State, I.Item_Number,  
Sum= SUM(I.Quantity)
					 FROM	 ORDERS AS O1 JOIN IS_CONTAINS AS I ON 
 I.Order_ID=O1.Order_ID
		 			GROUP BY   O1.Address_State, I.Item_Number
		 			ORDER BY   1 )  AS X 
WHERE	O.Address_State = X.Address_State 
ORDER BY SUM(I.Quantity) DESC)
FROM		ORDERS AS O JOIN IS_CONTAINS AS I ON I.Order_ID=O.Order_ID
		JOIN PRODUCTS AS P ON P.Item_Number=I.Item_Number
GROUP BY	O.Address_State


--DROP VIEW V_RevenuePerOrder
CREATE VIEW V_RevenuePerOrder AS
SELECT			O.Order_ID, O.Date, Incomes= SUM(I.QUANTITY * V.PRICE), Expenses = SUM(I.QUANTITY * V.COST), Revenues = SUM(I.QUANTITY * V.PRICE)-SUM(I.QUANTITY * V.COST)
FROM			V_Products_Costs AS V JOIN IS_CONTAINS AS I ON I.Item_Number=V.ITEM_NUMBER JOIN ORDERS AS O ON O.Order_ID=I.Order_ID
GROUP BY		O.Order_ID, O.Date


--DROP VIEW V_Products_Costs
CREATE VIEW V_Products_Costs AS
SELECT		P.Item_Number ,P.Price , Cost=((P.Item_Number)/(CAST (100000 AS REAL))*P.Price)
FROM 		ORDERS AS O JOIN IS_CONTAINS AS I ON I.Order_ID=O.Order_ID
			JOIN PRODUCTS AS P ON P.Item_Number=I.Item_Number
GROUP BY	P.Item_Number,P.Price

--drop table t_StatisticRatioGender
create table t_StatisticRatioGender (
Gender		varchar (10),
[Num#]		int)


--drop table t_StatisticRatioRegistered
create table t_StatisticRatioRegistered (
Type		varchar (25),
[Num#]		int)


--drop table t_StatisticRatioCompany
create table t_StatisticRatioCompany (
Type		varchar (25),
[Num#]		int)

insert into t_StatisticRatioGender (gender, [Num#])
values ('Women',(SELECT TOT = COUNT(O.ORDER_ID) 
			FROM  ORDERS AS O JOIN IS_CONTAINS AS I ON O.ORDER_ID = I.ORDER_ID JOIN NAMES AS N ON N.ITEM_NUMBER=I.ITEM_NUMBER 
			WHERE I.Item_Number IN(SELECT Item_Number
									FROM NAMES
									WHERE  NAME LIKE '%girl%' or NAME LIKE '%women%'))),
('Men',(SELECT TOT = COUNT(O.ORDER_ID) 
			FROM  ORDERS AS O JOIN IS_CONTAINS AS I ON O.ORDER_ID = I.ORDER_ID JOIN NAMES AS N ON N.ITEM_NUMBER=I.ITEM_NUMBER 
			WHERE I.Item_Number IN(SELECT Item_Number
									FROM NAMES
									WHERE  NAME LIKE '%boy%' or NAME LIKE '%men%')))

insert into t_StatisticRatioCompany (Type, [Num#])
values 
('Company', (SELECT TOT = COUNT(COMPANY) 
			FROM ORDERS 
			WHERE Company<>'')),
('[Private Client]',(SELECT TOT = COUNT(Email_Order)
					FROM ORDERS 
					WHERE Company=''))

insert into t_StatisticRatioRegistered (Type, [Num#])
values
('Registered', (SELECT TOT=COUNT(Email_Customer)
				FROM ORDERS 
				WHERE Email_Customer IS NOT NULL)),
('Not Registered',(SELECT TOT=COUNT(Order_ID)
					FROM ORDERS 
					WHERE Email_Customer IS NULL))


