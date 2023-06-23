-- Common Table Expression
/*
CTE returns a result set which can be used in the following/Immediate  query.
*/
WITH CTE AS
(
select * from Category where name='Action'
)
select * from CTE;
select * from CTE;

WITH CTE AS
(
select * from Category where name='Action'
)
select F.*,CTE.Name as CategoryName 
from Film F
 INNER JOIN film_category FC ON F.FIlm_ID=FC.Film_ID
 INNER JOIN CTE ON CTE.Category_ID=FC.Category_ID;


select * from Customer C INNER JOIN 
Address A ON C.Address_ID=A.Address_ID
INNER JOIN CITY CI ON CI.CITY_ID=A.CITY_ID
INNER JOIN COUNTRY CO ON CO.COUNTRY_ID=CI.COUNTRY_ID;

WITH CTE AS 
(
Select A.Address_ID,A.Address,A.District,CI.CITY,CO.COUNTRY from 
Address A INNER JOIN CITY CI ON A.CITY_ID=CI.CITY_ID
INNER JOIN COUNTRY CO ON CO.COuntry_ID=CI.COuntry_ID
)
SELECT CONCAT(FIRST_NAME,SPACE(1),LAST_NAME) AS CUSTOMERFULLNAME,
CTE.*
 FROM CUSTOMER  C INNER JOIN CTE ON C.ADDRESS_ID=CTE.ADDRESS_ID;

WITH recursive RCTE AS
(
SELECT 1 AS NUMBER -- base query 1        RCTE-- Number-->1
UNION ALL
select Number+1 FROM RCTE WHERE Number<50 -- Repeater
UNION ALL 
SELECT NUMBER*3 FROM RCTE WHERE NUMBER <2000
)
select * from RCTE;

select * from Customer where First_name like 'A%'
UNION ALL
select * from Customer where First_name like 'P%' OR  First_name like 'A%' 









WITH CTE AS (
select Customer_ID,Concat(First_Name,Last_Name) as FullName,Email,Address_ID as ADRID 
from Customer where First_Name='Mary'
)
select * from Address as A INNER JOIN CTE on A.Address_ID=CTE.ADRID;

WITH CTE(First_Name,Last_name ) AS (
select First_Name,Last_name,Address_ID 
from Customer where First_Name='Mary'
)
select * from Address as A INNER JOIN CTE on A.Address_ID=CTE.Address_ID;

-- SET Operators 
-- UNION and UNION ALL
select Category_ID,Name from Category where Category_ID IN (1,2,3)
UNION 
select Category_ID,NAME from Category where Category_ID IN (2,3,4);
-- Recursive CTE

WITH RECURSIVE  CTE AS (
select 1 as Number -- Anchor or base query
UNION ALL
select Number+1 FROM CTE where Number<100 -- Recursive Query
)
Select * from CTE;

-- Case Expressions are used to give results based on the validated expression
select Customer_ID,SUM(Amount) as TotalAmount,
CASE WHEN SUM(Amount)>150 
THEN 'Loyal Customer' 
WHEN SUM(Amount) Between 100 and 150 THEN 'Regular Customer' WHEN  SUM(Amount) Between 50 and 100 THEN 'Seasonal Customer'
Else 'Ocasional customer'
 END as CustomerType
 from payment
Group by Customer_ID
order by TotalAmount DESc;



-- Complex way


select * from Customer;

WITH CTE AS 
(
Select Concat(C.First_name,space(1),C.Last_Name) as CustomerName,TotalAmount,
CASE 
WHEN C.First_Name REGEXP '^[A-H]' THEN 'Millenials'
WHEN C.First_Name REGEXP '^[I-P]' THEN 'GenZ'
WHEN C.First_Name REGEXP '^[Q-X]' THEN 'GenY'
ELSE 'BabyBoomers' END AS 'GENERAATION',
CASE
 WHEN TotalAmount>150 THEN 'Loyal Customer'
WHEN TotalAmount Between 100 and 150 THEN 'Regular Customer'
WHEN  TotalAmount Between 50 and 100 THEN 'Seasonal Customer'
Else 'Ocasional customer'
 END as CustomerType
 FROM (
select Customer_ID,SUM(Amount) as TotalAmount
 from payment
Group by Customer_ID) as T 
INNER JOIN CUSTOMER C ON C.Customer_ID=T.Customer_ID )
SELECT * FROM CTE ORDER By TotalAmount DESC,GENERAATION ASC;


WITH CTE AS (
select CONCAT(CU.First_NAME,SPACE(1),CU.LAST_NAME) CUSTOMERFULLNAME,T.*,
CASE 
WHEN T.TOTALPAYMENT > 150 THEN 'Loyal Customer'
WHEN T.TOTALPAYMENT BETWEEN 100 AND 150 THEN 'Regular Customer'
ELSE 'Seasonal Customer' END CustomerTYPE, CU.Address_ID
 FROM (
select Customer_ID,SUM(Amount) as TotalPayment from Payment Group BY Customer_ID) T
INNER JOIN CUSTOMER CU ON CU.CUSTOMER_ID=T.CUSTOMER_ID )
SELECT CTE.*,A.address,A.DISTRICT FROM CTE INNER JOIN ADDRESS A ON CTE.ADDRESS_ID=A.ADDRESS_ID
where CustomerType='loyal Customer'
ORDER BY TotalPayment DESC;














select DISTINCT Country from address a Inner join City C ON a.City_ID=C.City_ID
INNER JOIN Country Co ON CO.country_ID=C.Country_ID;

select Customer_ID,SUM(Amount) as TotalAmount,
CASE
 WHEN (select Country from address a Inner join City C ON a.City_ID=C.City_ID
INNER JOIN Country Co ON CO.country_ID=C.Country_ID 
INNER JOIN Customer Cu ON Cu.Address_ID=A.Address_ID 
WHERE Cu.Customer_ID=P.Customer_ID
) IN ('INDIA','CHINA','Afghanistan')  THEN 'Asian Customer'
Else 'Outside of Asia Customer'
 END as CustomerContinent
 from payment P
Group by Customer_ID;


WITH CTE AS  (
select Customer_ID,SUM(Amount) as TotalAmount,
CASE
  (select Country from address a Inner join City C ON a.City_ID=C.City_ID
INNER JOIN Country Co ON CO.country_ID=C.Country_ID 
INNER JOIN Customer Cu ON Cu.Address_ID=A.Address_ID 
WHERE Cu.Customer_ID=P.Customer_ID
) 
WHEN  'INDIA' THEN 'SubContinent'
WHEN 'CHINA' THEN 'Chinese'
WHEN 'Afghanistan' Then 'Kabuls'
Else 'Outside of Asia Customer'
 END as CustomerContinent
 from payment P
Group by Customer_ID)
select * from CTE INNER JOIN CUSTOMER CU ON CTE.Customer_ID=CU.CUstomer_ID;

select * from Customer Where First_name Regexp 'ARY*';
select * from Customer Where First_name Regexp 'ARY+';

WITH CTE AS (
select Cu.* from address a Inner join City C ON a.City_ID=C.City_ID
INNER JOIN CUSTOMER Cu ON CU.Address_ID=A.Address_ID
WHERE C.Country_ID  = (
select Country_ID FROm COUNTRY WHERE COUNTRY IN ('INDIA')
))
select * from CTE;

with cte as (
select * from Customer CU WHERE CU.first_name REGEXP '^A' and Cu.First_Name like '%_A')
select * from CTE;

-- Temporay Table and CTE

select * from film;

with CTE AS
(
select * from film where title='ACE GOLDFINGER'
),
Cte2 as 
(
select A.First_Name, FA.FILM_ID from Actor A Inner join Film_Actor FA ON
FA.Actor_ID=A.Actor_ID
)
select CTE2.First_Name,CTE.TITLE from CTE INNER JOIN CTE2 ON CTE.Film_ID=CTE2.Film_ID;



-- Union
-- Union combines two or more result sets

select * from City where Country_ID =(Select Country_id from Country where country='INDIA') and CITY LIKE 'A%'
UNION ALL 
select * from City where Country_ID =(Select Country_id from Country where country='INDIA') and CITY REGEXP '^[ABD]'

WITH RECURSIVE recursiveCte AS
(
select 1 as Number
UNION 
SELECT NUMBER+1 FROM recursiveCte where Number<100
)
select * from Recursivecte;


create table Hierarchy(ID INT , NAME VARCHAR(50), ManagerID INT);


Insert into Hierarchy VALUES (1,'DV', NULL),
(2,'Shoeb',1),
(3,'Manoj',1),
(4,'Venkatesh',3),
(5,'Venkatesh',2)

Insert into Hierarchy VALUES (6,'Odin', NULL),
(7,'Shoeb',6),
(8,'Manoj',7),
(9,'Venkatesh',6),
(10,'Venkatesh',8);

select * from Hierarchy;

WITH RECURSIVE HierarchyCTE AS
(
Select ID,NAME,ManagerID From hierarchy where managerid is null
UNION
SELECT Hierarchy.ID,Hierarchy.NAME,Hierarchy.ManagerID From hierarchy INNER JOIN HIERARCHYCTE ON 
Hierarchy.ManagerID=HierarchyCTE.ID where Hierarchy.managerid is NOT null
)
select ID,NAME,ManagerID from HIERARCHYCTE order by ManagerID;





-- Group BY 

select SUM(Amount) TotalPayment, Customer_ID from payment
where Customer_ID between 1 and 5
GROUP BY Customer_ID
Having Totalpayment>120
order by Totalpayment desc;


-- Union

select First_name,Last_Name,Customer_ID from  Customer where First_Name regexp '^[A-E]'
UNION  ALL
SELECT First_name,Last_Name,Customer_ID FROM CUSTOMER WHERE FIRST_NAME REGEXP '^[P-T]' OR First_name REGEXP '^[A]'
order by First_name;



With CTE AS
(
select First_name,Last_Name,Customer_ID from  Customer where First_Name regexp '^[A-E]'
)
select * from CTE;

select * from CTE;

select * from TEMP1;

CREATE TEMPORARY TABLE TEMP1 
select First_name,Last_Name,Customer_ID from  Customer where First_Name regexp '^[A-E]';


select * from Address ;

-- where address_Id is null

-- delete from address where address_id between 45 and 60;

create TEMPORARY table Customer_T(Customer_ID INT , FULLNAME VARCHAR(50), ADDRESS_ID INT);
create TEMPORARY table Address_T(Address_ID INT , address VARCHAR(50), district varchar(50));

INSERT INTO CUSTOMER_T
SELECT Customer_ID,COncat(First_name,SPace(1),Last_Name),AdDress_ID FROM CUSTOMER;

INSERT INTO Address_T
SELECT Address_ID,address,District FROM Address;

delete from Address_T where Address_ID Between 45 and 60;
delete from Customer_T where Customer_ID Between 25 and 35;

select * from Customer_T  CT INNER JOIN Address_T AT ON 
CT.Address_ID=AT.Address_ID;

select * from Customer_T  CT LEFT JOIN Address_T AT ON 
CT.Address_ID=AT.Address_ID;

select * from Customer_T  CT LEFT JOIN Address_T AT ON 
CT.Address_ID=AT.Address_ID where AT.address_id is null;

select * from Customer_T  CT Right JOIN Address_T AT ON 
CT.Address_ID=AT.Address_ID where Ct.Customer_ID is null;


select * from Customer Inner join Address ON customer.Address_ID=Address.Address_ID

