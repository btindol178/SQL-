--- QUICK SQL TUTORIAL USING DATABASE

-- Instruments is 15 for the compnum 
SELECT DISTINCT(COMPNUM) FROM HCS_DISCOVER.DW.DimDivision


-- Select Top 10 from order,division,shipto,products,SalesForce,date,IDN TABLE
SELECT TOP 10 * FROM HCS_DISCOVER.dw.FactOrders O -- ORDERS
left join HCS_DISCOVER.dw.DimDivision D on D.ID = O.DIV_ID  -- DIVISION
left join HCS_DISCOVER.dw.DimSalesForce ST on ST.ID = O.SHIP_TO_ID  -- SHIPTO
left join HCS_DISCOVER.dw.DimProducts P on P.ID = O.PRODUCT_ID  -- PRODUCT TABLE
left join HCS_DISCOVER.dw.DimSalesForce SF on SF.ID = O.SALES_FORCE_ID  -- SALES FORCE TABLE
left join HCS_DISCOVER.dw.DimDate DT on DT.ID = O.DATE_ID -- DATE TABLE
left join LOX_DW.dw.DimIDN DI on DI.ID_ENTITY = O.IDN_ID  -- IDN ID FROM LOX
left join LOX_DW.dw.DimGPO DG on DG.ID_ENTITY = O.GPO_ID -- GPO ID 

-- Select top 10 from orders
SELECT TOP 10 * FROM HCS_DISCOVER.dw.FactOrders
SELECT TOP 10 * FROM HCS_DISCOVER.dw.DimShipTo
SELECT TOP 10 * FROM HCS_DISCOVER.dw.DimProducts
SELECT TOP 10 * FROM HCS_DISCOVER.dw.DimSalesForce
SELECT TOP 10 * FROM HCS_DISCOVER.dw.DimDate
SELECT TOP 10 * FROM LOX_DW.dw.DimIDN
SELECT TOP 10 * FROM LOX_DW.dw.DimGPO
SELECT TOP 10 * FROM HCS_DISCOVER.dw.DimDivision


SELECT DISTINCT(ID) FROM HCS_DISCOVER.dw.DimShipTo

-- Get top 10 product group name ordered by order quantity
SELECT TOP(10)  P.[PRODUCT_GROUP_NAME], sum(EXTENDED_AMT) AS [Total Quantity]
FROM HCS_DISCOVER.dw.FactOrders O
left join HCS_DISCOVER.dw.DimProducts P on P.ID = O.PRODUCT_ID 
left join HCS_DISCOVER.dw.DimDivision D on D.ID = O.DIV_ID 
WHERE D.COMPNUM = 15
GROUP BY P.[PRODUCT_GROUP_NAME]
ORDER BY sum(EXTENDED_AMT) DESC

-- get top 5 % of product details
SELECT TOP(5) PERCENT P.[PRODUCT_DETAIL], round(sum(EXTENDED_AMT),1) AS [Total Quantity]
FROM HCS_DISCOVER.dw.FactOrders O
left join HCS_DISCOVER.dw.DimProducts P on P.ID = O.PRODUCT_ID 
left join HCS_DISCOVER.dw.DimDivision D on D.ID = O.DIV_ID 
WHERE D.COMPNUM = 15
GROUP BY P.[PRODUCT_DETAIL]
ORDER BY sum(EXTENDED_AMT) DESC


-- sum the extended amount from product detail only if the product extended amount is greater than the average extended amount 
SELECT P.[PRODUCT_DETAIL], round(sum(EXTENDED_AMT),2) AS [Total Quanaity]
FROM HCS_DISCOVER.dw.FactOrders O
left join HCS_DISCOVER.dw.DimProducts P on P.ID = O.PRODUCT_ID 
left join HCS_DISCOVER.dw.DimDivision D on D.ID = O.DIV_ID 
WHERE D.COMPNUM = 15
GROUP BY P.[PRODUCT_DETAIL]
HAVING sum(EXTENDED_AMT) > (SELECT avg(EXTENDED_AMT) FROM HCS_DISCOVER.dw.FactOrders)
ORDER BY sum(EXTENDED_AMT) DESC;


-- get average order qty and total qty per product detail for intstruments 
SELECT P.[PRODUCT_DETAIL], avg(QTY) AS [Average Quantity], count(QTY) as [Total Quantity]
FROM HCS_DISCOVER.dw.FactOrders O
left join HCS_DISCOVER.dw.DimProducts P on P.ID = O.PRODUCT_ID 
left join HCS_DISCOVER.dw.DimDivision D on D.ID = O.DIV_ID 
WHERE D.COMPNUM = 15
GROUP BY P.[PRODUCT_DETAIL]
ORDER BY [Average Quantity] DESC;


-- For each product group get count of orders and unique products and order it by decending distinct products or the product group names with the msot number of products
SELECT P.[PRODUCT_GROUP_NAME], round(avg(QTY),2) AS [Average Quantity] , count(PRODUCT_DETAIL) as [Number of Individual Products] ,count(DISTINCT(PRODUCT_DETAIL)) as [Distinct Products]
FROM HCS_DISCOVER.dw.FactOrders O
left join HCS_DISCOVER.dw.DimProducts P on P.ID = O.PRODUCT_ID 
left join HCS_DISCOVER.dw.DimDivision D on D.ID = O.DIV_ID 
WHERE D.COMPNUM = 15
GROUP BY P.[PRODUCT_GROUP_NAME]
ORDER BY [Distinct Products] DESC;


-- Select Top 10 from order,division,shipto,products,SalesForce,date,IDN TABLE
SELECT DI.[OWNER],
P.[BUSINESS_UNIT],
O.[EXTENDED_AMT],
O.[QTY],
P.[PRODUCT_GROUP_NAME],
DT.[FULLDATE]
FROM HCS_DISCOVER.dw.FactOrders O -- ORDERS
left join HCS_DISCOVER.dw.DimDivision D on D.ID = O.DIV_ID  -- DIVISION
left join HCS_DISCOVER.dw.DimSalesForce ST on ST.ID = O.SHIP_TO_ID  -- SHIPTO
left join HCS_DISCOVER.dw.DimProducts P on P.ID = O.PRODUCT_ID  -- PRODUCT TABLE
left join HCS_DISCOVER.dw.DimSalesForce SF on SF.ID = O.SALES_FORCE_ID  -- SALES FORCE TABLE
left join HCS_DISCOVER.dw.DimDate DT on DT.ID = O.DATE_ID -- DATE TABLE
left join LOX_DW.dw.DimIDN DI on DI.ID_ENTITY = O.IDN_ID  -- IDN ID FROM LOX
left join LOX_DW.dw.DimGPO DG on DG.ID_ENTITY = O.GPO_ID -- GPO ID 
WHERE DI.[OWNER] LIKE 'b%' AND P.[BUSINESS_UNIT] LIKE '%e' AND P.[PRODUCT_GROUP_NAME] LIKE '%CARE%';-- Where the owner of ther idn id table starts with b (brett)_ AND where business unit column ends with e AND where product group name column has the word CARE ANYWHERE IN STRING

--SELECT DISTINCT(INW.[OWNER]) FROM LOX_DW.dw.DimIDN AS INW


-- where the owner has the string a in the second position.... 
SELECT DI.[OWNER],
P.[BUSINESS_UNIT],
O.[EXTENDED_AMT],
O.[QTY],
P.[PRODUCT_GROUP_NAME],
DT.[FULLDATE]
FROM HCS_DISCOVER.dw.FactOrders O -- ORDERS
left join HCS_DISCOVER.dw.DimDivision D on D.ID = O.DIV_ID  -- DIVISION
left join HCS_DISCOVER.dw.DimSalesForce ST on ST.ID = O.SHIP_TO_ID  -- SHIPTO
left join HCS_DISCOVER.dw.DimProducts P on P.ID = O.PRODUCT_ID  -- PRODUCT TABLE
left join HCS_DISCOVER.dw.DimSalesForce SF on SF.ID = O.SALES_FORCE_ID  -- SALES FORCE TABLE
left join HCS_DISCOVER.dw.DimDate DT on DT.ID = O.DATE_ID -- DATE TABLE
left join LOX_DW.dw.DimIDN DI on DI.ID_ENTITY = O.IDN_ID  -- IDN ID FROM LOX
left join LOX_DW.dw.DimGPO DG on DG.ID_ENTITY = O.GPO_ID -- GPO ID 
WHERE DI.[OWNER] LIKE '_a%'; -- where the owner has the string a in the second position.... 


-- WHERE Business unit column starts with s and is at least 4 characters long (SAGE/SPINE)
SELECT DI.[OWNER],
P.[BUSINESS_UNIT],
O.[EXTENDED_AMT],
O.[QTY],
P.[PRODUCT_GROUP_NAME],
DT.[FULLDATE]
FROM HCS_DISCOVER.dw.FactOrders O -- ORDERS
left join HCS_DISCOVER.dw.DimDivision D on D.ID = O.DIV_ID  -- DIVISION
left join HCS_DISCOVER.dw.DimSalesForce ST on ST.ID = O.SHIP_TO_ID  -- SHIPTO
left join HCS_DISCOVER.dw.DimProducts P on P.ID = O.PRODUCT_ID  -- PRODUCT TABLE
left join HCS_DISCOVER.dw.DimSalesForce SF on SF.ID = O.SALES_FORCE_ID  -- SALES FORCE TABLE
left join HCS_DISCOVER.dw.DimDate DT on DT.ID = O.DATE_ID -- DATE TABLE
left join LOX_DW.dw.DimIDN DI on DI.ID_ENTITY = O.IDN_ID  -- IDN ID FROM LOX
left join LOX_DW.dw.DimGPO DG on DG.ID_ENTITY = O.GPO_ID -- GPO ID 
WHERE P.[BUSINESS_UNIT] LIKE 'S___%'



-- where column starts with s and ends with s (surgical technologies or SSS)
SELECT DI.[OWNER],
P.[BUSINESS_UNIT],
O.[EXTENDED_AMT],
O.[QTY],
P.[PRODUCT_GROUP_NAME],
DT.[FULLDATE]
FROM HCS_DISCOVER.dw.FactOrders O -- ORDERS
left join HCS_DISCOVER.dw.DimDivision D on D.ID = O.DIV_ID  -- DIVISION
left join HCS_DISCOVER.dw.DimSalesForce ST on ST.ID = O.SHIP_TO_ID  -- SHIPTO
left join HCS_DISCOVER.dw.DimProducts P on P.ID = O.PRODUCT_ID  -- PRODUCT TABLE
left join HCS_DISCOVER.dw.DimSalesForce SF on SF.ID = O.SALES_FORCE_ID  -- SALES FORCE TABLE
left join HCS_DISCOVER.dw.DimDate DT on DT.ID = O.DATE_ID -- DATE TABLE
left join LOX_DW.dw.DimIDN DI on DI.ID_ENTITY = O.IDN_ID  -- IDN ID FROM LOX
left join LOX_DW.dw.DimGPO DG on DG.ID_ENTITY = O.GPO_ID -- GPO ID 
WHERE P.[BUSINESS_UNIT] LIKE 'S%s';


-- GIVE ME OWNER WHERE name does not start with b
SELECT DI.[OWNER],
P.[BUSINESS_UNIT],
O.[EXTENDED_AMT],
O.[QTY],
P.[PRODUCT_GROUP_NAME],
DT.[FULLDATE]
FROM HCS_DISCOVER.dw.FactOrders O -- ORDERS
left join HCS_DISCOVER.dw.DimDivision D on D.ID = O.DIV_ID  -- DIVISION
left join HCS_DISCOVER.dw.DimSalesForce ST on ST.ID = O.SHIP_TO_ID  -- SHIPTO
left join HCS_DISCOVER.dw.DimProducts P on P.ID = O.PRODUCT_ID  -- PRODUCT TABLE
left join HCS_DISCOVER.dw.DimSalesForce SF on SF.ID = O.SALES_FORCE_ID  -- SALES FORCE TABLE
left join HCS_DISCOVER.dw.DimDate DT on DT.ID = O.DATE_ID -- DATE TABLE
left join LOX_DW.dw.DimIDN DI on DI.ID_ENTITY = O.IDN_ID  -- IDN ID FROM LOX
left join LOX_DW.dw.DimGPO DG on DG.ID_ENTITY = O.GPO_ID -- GPO ID 
WHERE DI.[OWNER] NOT LIKE 'b%' 


-- GIVE ME OWNER WHERE name starts with b, j or t
SELECT DI.[OWNER],
P.[BUSINESS_UNIT],
O.[EXTENDED_AMT],
O.[QTY],
P.[PRODUCT_GROUP_NAME],
DT.[FULLDATE]
FROM HCS_DISCOVER.dw.FactOrders O -- ORDERS
left join HCS_DISCOVER.dw.DimDivision D on D.ID = O.DIV_ID  -- DIVISION
left join HCS_DISCOVER.dw.DimSalesForce ST on ST.ID = O.SHIP_TO_ID  -- SHIPTO
left join HCS_DISCOVER.dw.DimProducts P on P.ID = O.PRODUCT_ID  -- PRODUCT TABLE
left join HCS_DISCOVER.dw.DimSalesForce SF on SF.ID = O.SALES_FORCE_ID  -- SALES FORCE TABLE
left join HCS_DISCOVER.dw.DimDate DT on DT.ID = O.DATE_ID -- DATE TABLE
left join LOX_DW.dw.DimIDN DI on DI.ID_ENTITY = O.IDN_ID  -- IDN ID FROM LOX
left join LOX_DW.dw.DimGPO DG on DG.ID_ENTITY = O.GPO_ID -- GPO ID 
WHERE DI.[OWNER] LIKE '[bjt]%';


-- GIVE ME OWNER WHERE name does not starts with b, j or t
SELECT DI.[OWNER],
P.[BUSINESS_UNIT],
O.[EXTENDED_AMT],
O.[QTY],
P.[PRODUCT_GROUP_NAME],
DT.[FULLDATE]
FROM HCS_DISCOVER.dw.FactOrders O -- ORDERS
left join HCS_DISCOVER.dw.DimDivision D on D.ID = O.DIV_ID  -- DIVISION
left join HCS_DISCOVER.dw.DimSalesForce ST on ST.ID = O.SHIP_TO_ID  -- SHIPTO
left join HCS_DISCOVER.dw.DimProducts P on P.ID = O.PRODUCT_ID  -- PRODUCT TABLE
left join HCS_DISCOVER.dw.DimSalesForce SF on SF.ID = O.SALES_FORCE_ID  -- SALES FORCE TABLE
left join HCS_DISCOVER.dw.DimDate DT on DT.ID = O.DATE_ID -- DATE TABLE
left join LOX_DW.dw.DimIDN DI on DI.ID_ENTITY = O.IDN_ID  -- IDN ID FROM LOX
left join LOX_DW.dw.DimGPO DG on DG.ID_ENTITY = O.GPO_ID -- GPO ID 
WHERE DI.[OWNER] NOT LIKE '[bjt]%';




SELECT DISTINCT(BUSINESS_UNIT) FROM HCS_DISCOVER.dw.DimProducts
-- wHERE NAME IS IN THESE SPECIFIC NAMES
SELECT DI.[OWNER],
P.[BUSINESS_UNIT],
O.[EXTENDED_AMT],
O.[QTY],
P.[PRODUCT_GROUP_NAME],
DT.[FULLDATE]
FROM HCS_DISCOVER.dw.FactOrders O -- ORDERS
left join HCS_DISCOVER.dw.DimDivision D on D.ID = O.DIV_ID  -- DIVISION
left join HCS_DISCOVER.dw.DimSalesForce ST on ST.ID = O.SHIP_TO_ID  -- SHIPTO
left join HCS_DISCOVER.dw.DimProducts P on P.ID = O.PRODUCT_ID  -- PRODUCT TABLE
left join HCS_DISCOVER.dw.DimSalesForce SF on SF.ID = O.SALES_FORCE_ID  -- SALES FORCE TABLE
left join HCS_DISCOVER.dw.DimDate DT on DT.ID = O.DATE_ID -- DATE TABLE
left join LOX_DW.dw.DimIDN DI on DI.ID_ENTITY = O.IDN_ID  -- IDN ID FROM LOX
left join LOX_DW.dw.DimGPO DG on DG.ID_ENTITY = O.GPO_ID -- GPO ID 
WHERE P.[BUSINESS_UNIT] IN ('SAGE', 'Surgical Technologies', 'CORE ENDO');

-- select distinct product id for waste management 
Select distinct(P.ID), P.[PRODUCT_DETAIL],P.[PRODUCT_GROUP_NAME] FROM HCS_DISCOVER.dw.DimProducts P 
WHERE P.[PRODUCT_GROUP_NAME] LIKE 'waste%' 

-- INNER JOIN DISTICT PRODUCT ID FROM FACT ORDERS ON PRODUCT TABLE FOR ONLY INSTRUMENTS 
WITH activepn as (Select Distinct PRODUCT_ID FROM HCS_DISCOVER.dw.FactOrders o)

SELECT [ID]
      ,[COMPNUM]
      ,[PRODUCT_NUM]
      ,[SRC_PRODNUM]
      ,[PRODUCT_DESC]
      ,[EXTENDED_DESC]
      ,[PRODUCT_GROUP_CODE]
      ,[PRODUCT_GROUP_NAME]
      ,[MAJOR_CODE]
      ,[LIST_PRICE]
      ,[FLOOR_PRICE]
      ,[PRODUCT_DETAIL]
      ,[PRODUCT_FAMILY]
      ,[BUSINESS_UNIT]
      ,[FRANCHISE]
      ,[MAJOR_CODE_NAME]
      ,[BC]
      ,[NT_CATEGORY]
      ,[DIVISION]
      ,[ALT_DIVISION]
      ,[OWNER]
      ,[CatalogNumber]
      ,[UnitOfMeasure]
      ,[PackContent]
      ,[LifeCycleCode]
      ,[LifeCycleCodeDescription]
      ,[ItemTypeCode]
      ,[ItemTypeDescription] 
 FROM HCS_DISCOVER.[dw].[DimProducts] p
INNER JOIN activepn
on activepn.PRODUCT_ID = p.ID where p.[compnum]=15 


--The following SQL statement selects all customers that are from the same STATE as the suppliers:
SELECT O.[ORDER_NUM],
O.[EXTENDED_AMT],
O.[QTY],
ST.[STATE]
FROM hcs_discover.dw.FactOrders O
left join hcs_discover.dw.DimShipTo ST on ST.ID = O.SHIP_TO_ID
WHERE ST.[STATE] IN (SELECT ST.[STATE] FROM hcs_discover.dw.DimShipTo WHERE ST.[STATE] = 'MS');


-- SELECT EXTENDED AMT WHERE THE VALUE IS BETWEEN 100 AND 200
SELECT O.[ORDER_NUM],
O.[QTY],
O.[EXTENDED_AMT],
DT.[FULLDATE]
FROM hcs_discover.dw.FactOrders O
left join hcs_discover.dw.DimDate DT on DT.ID = O.DATE_ID
WHERE O.EXTENDED_AMT BETWEEN 100 AND 200;



-- SELECT EXTENDED AMT WHERE THE VALUE IS NOT BETWEEN 100 AND 200
SELECT O.[ORDER_NUM],
O.[QTY],
O.[EXTENDED_AMT],
DT.[FULLDATE]
FROM hcs_discover.dw.FactOrders O
left join hcs_discover.dw.DimDate DT on DT.ID = O.DATE_ID
WHERE O.EXTENDED_AMT NOT BETWEEN 100 AND 200;

-- WHERE EXTENDED IS BETWEEN 100 AND 200 AND quantity is 10 OR GREATER
SELECT O.[ORDER_NUM],
O.[QTY],
O.[EXTENDED_AMT],
DT.[FULLDATE]
FROM hcs_discover.dw.FactOrders O
left join hcs_discover.dw.DimDate DT on DT.ID = O.DATE_ID
WHERE O.EXTENDED_AMT BETWEEN 100 AND 200 
AND O.[QTY] NOT IN (1,2,3,4,5,6,7,8,9) -- or >10 but making point
AND O.ORDER_NUM IS NOT NULL;

-- GET ONLY ORDERS WITH IN A RANGE OF DATES... 
SELECT O.[ORDER_NUM],
O.[QTY],
O.[EXTENDED_AMT],
DT.[FULLDATE]
FROM hcs_discover.dw.FactOrders O
left join hcs_discover.dw.DimDate DT on DT.ID = O.DATE_ID
WHERE DT.[FULLDATE] BETWEEN '2021-03-02' AND '2021-03-05';


-- maknig a new column with case when 
SELECT  O.[ORDER_NUM],
O.[QTY],
O.[EXTENDED_AMT],
DT.[FULLDATE],
CASE
    WHEN O.[EXTENDED_AMT] < 30 THEN 'The low volume'
    WHEN O.[EXTENDED_AMT] >= 30 OR O.[EXTENDED_AMT]<= 300 THEN 'Medium Volume'
    ELSE 'Super high Volume'
END AS NEW 
FROM hcs_discover.dw.FactOrders O
left join hcs_discover.dw.DimDate DT on DT.ID = O.DATE_ID
WHERE DT.[FULLDATE] BETWEEN '2021-03-02' AND '2021-03-05';



SELECT DI.[OWNER],
P.[BUSINESS_UNIT],
O.[EXTENDED_AMT],
O.[QTY],
P.[PRODUCT_GROUP_NAME],
DT.[FULLDATE]
FROM HCS_DISCOVER.dw.FactOrders O -- ORDERS
left join HCS_DISCOVER.dw.DimDivision D on D.ID = O.DIV_ID  -- DIVISION
left join HCS_DISCOVER.dw.DimSalesForce ST on ST.ID = O.SHIP_TO_ID  -- SHIPTO
left join HCS_DISCOVER.dw.DimProducts P on P.ID = O.PRODUCT_ID  -- PRODUCT TABLE
left join HCS_DISCOVER.dw.DimSalesForce SF on SF.ID = O.SALES_FORCE_ID  -- SALES FORCE TABLE
left join HCS_DISCOVER.dw.DimDate DT on DT.ID = O.DATE_ID -- DATE TABLE
left join LOX_DW.dw.DimIDN DI on DI.ID_ENTITY = O.IDN_ID  -- IDN ID FROM LOX
left join LOX_DW.dw.DimGPO DG on DG.ID_ENTITY = O.GPO_ID -- GPO ID 