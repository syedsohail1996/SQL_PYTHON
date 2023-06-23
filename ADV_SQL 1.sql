soemthing@something.something
/*
Regular Expressions
The caret (^) character is used to start matches at the beginning of a searched string.
The dollar ($) character is used to start matches at the end of a searched string.
The dot (.) character matches any single character except for a new line.
[]it is used to match any characters enclosed in the square brackets.
[^]
The asterisk (*) character matches zero (0) or more instances of the preceding strings.
The plus (+) character matches one or more instances of preceding strings.
*/

/*
A regular expression (shortened as regex or regexp;
[1] sometimes referred to as rational expression[2][3]) is a sequence of characters that specifies a search pattern in text.
 Usually such patterns are used by string-searching algorithms for "find" or "find and replace" operations on strings, 
 or for input validation. 
Regular expression techniques are developed in theoretical computer science and formal language theory.
.
*/

-- ^
select * from Actor where First_name regexp '^RI';
-- $
select * from Actor where Last_Name regexp 'ord$';
-- []
-- Last Name where the last letter  is ending  with AEIOU
select * from Actor where Last_Name regexp '[AEIOU]$';
select * from Actor where Last_Name regexp '^[OUA]';
select * from Actor where Last_Name regexp '[^AEIOU]$';
select * from Actor where Last_Name regexp '^[AEIOU]';
select * from Actor where Last_Name regexp '[^AEIOUSG]$';
select * from Actor where Last_Name regexp '^[^AEIOU]';
select * from Actor where Last_Name regexp '[^GUINESS]$';
select * from Actor where last_Name regexp '[A-Z a-z 0-9]';
select * from Actor where First_Name regexp '^[^A-D P-T]';
select * from Actor where last_Name regexp '[P-T]$' and first_name regexp '^[ABC]' and actor_id between 1 and 50;
select * from actor where last_name regexp 'TT$';
select * from actor where first_name regexp 'NNI*';
select * from actor where last_name regexp 'LOB*';
select * from actor where last_name regexp '[LOB][LL][IJK]*';
select * from actor where first_name regexp 'NNI+';
select * from actor where first_name regexp 'NNI*';
select * from actor where last_name regexp 'LOB+';
select * from actor where last_name regexp '^DEG+';
select * from actor where last_name regexp '^DEG+';


select * from actor where first_name regexp '^N..k$';
select * from actor where first_name like 'N__K';

select * from payment where amount regexp '^[1-3]';

select * from Actor ;

select * from payment;

/*
GROUPING and Aggregation
*/
-- COUNT, SUM, AVG, MIN, MAX, MODE
Select * From Customer;
-- How many cities in each district 
select * from Address;
-- The columns which do not participate in the group by clause , should be included in the 
-- select clause by using an aggregate function
select Count(city_id),district  from address
GROUP BY district,City_ID;
-- base query
select C.city,A.District,Co.Country from 
Address A INNER JOIN CITY C ON A.City_ID=C.CIty_ID
INNER JOIN COUNTRy Co ON CO.COuntry_ID=C.COuntry_ID;

-- get the count of cities in each country

select Count(C.City) as countofCities, Co.Country from 
Address A INNER JOIN CITY C ON A.City_ID=C.CIty_ID
INNER JOIN COUNTRy Co ON CO.COuntry_ID=C.COuntry_ID
GROUP BY Co.Country;

select Count(C.City) as countofCities, Co.Country,A.District from 
Address A INNER JOIN CITY C ON A.City_ID=C.CIty_ID
INNER JOIN COUNTRy Co ON CO.COuntry_ID=C.COuntry_ID
GROUP BY Co.Country,A.District;



-- get the count of districts in each country

select Count(A.district) as countofdistrict, Co.Country from 
Address A INNER JOIN CITY C ON A.City_ID=C.CIty_ID
INNER JOIN COUNTRy Co ON CO.COuntry_ID=C.COuntry_ID
GROUP BY Co.Country
HAVING Count(A.district)>=2;
-- getting number of districts per country
select Count(A.district) as countofdistrict, Co.Country from 
Address A INNER JOIN CITY C ON A.City_ID=C.CIty_ID
INNER JOIN COUNTRy Co ON CO.COuntry_ID=C.COuntry_ID
GROUP BY Co.Country
HAVING countofdistrict>=2;

select Count(A.district) as countofdistrict,Count(C.City) as countofCities, Co.Country from 
Address A
INNER JOIN CITY C ON A.City_ID=C.CIty_ID
INNER JOIN COUNTRy Co ON CO.COuntry_ID=C.COuntry_ID
GROUP BY Co.Country;


select city_id from city c  Inner join Country co
on Co.country_id=C.Country_ID
 where country='Argentina';
 
 select * from Address where city_id in (select city_id from city c  Inner join Country co
on Co.country_id=C.Country_ID
 where country='Argentina'
 )
;

select * from payment;
-- Order of Execution
select SUM(Amount) as TotalAmount,Customer_ID , Current_Date()-- 5
from Payment -- 1
-- where --2 
Group by Customer_ID -- 3
having TotalAmount >180 -- 4
ORDER BY TotalAmount Desc; -- 6
-- LIMIT -- 7
select SUM(Amount) as TotalAmount,Staff_ID from Payment
Group by Staff_ID
ORDER BY TotalAmount Desc;


-- Temporary Tables
select * from Actor_temp;
select * from actor;

create temporary Table Actor_Temp(Actor_ID INT PRIMARY KEY AUTO_INCREMENT,
First_Name VARCHAR(50),
LAST_NAME VARCHAR(50)
);

INSERT INTO Actor_Temp(First_Name,LAst_Name)
SELECT First_name,Last_Name from ACTOR where Actor_id between 50 and 100 ;

CREATE TEMPORARY TABLE ADDRESS_Temp 
SELECT * FROm ADDRESS, Actor, City ;


select * from Address_Temp;
drop table ADDRESS_Temp;

select * from city where country_id IN (
select Country_ID FROM COUNTRY WHERE Country IN ('China','INDIA'));

select 1 as number;

select A.Address_ID,A.Address,C.CITY,CO.COUNTRY from Address A INNER JOIN CITY C ON A.CITY_ID=C.CITY_ID
INNER JOIN COUNTRY CO ON CO.COUNTRY_ID=C.COUNTRY_ID;

select C.*,Addressline.*,
(C.Address_ID+Addressline.Address_ID)
 from customer C INNER JOIN 
(select A.Address_ID,A.Address,C.CITY,CO.COUNTRY from Address A INNER JOIN CITY C ON A.CITY_ID=C.CITY_ID
INNER JOIN COUNTRY CO ON CO.COUNTRY_ID=C.COUNTRY_ID
) AddressLine  ON C.address_id=AddressLine.address_id;

select 1 as number;



select * from Country where country in ('China','India');-- 23

-- DEV-- 1
-- TESTING ENV/ QA-- 8


-- SUB QUERIES
 select * from Address 
 where city_id in (select city_id 
 from city c  Inner join Country co
on Co.country_id=C.Country_ID
 where country='Argentina'
 )
;

-- Subqueries should return single column while used in select or where clause or having
select * from payment where customer_id  IN  
(select Customer_ID from customer where concat(first_name,Last_Name)='MARYSMITH');

SELECT Q1.*,q2.*  FROM
(select Concat(CU.First_Name,Cu.Last_name) FullName,
 Rental_ID, Amount, Payment_Date,Address_ID
 from Customer CU INNER JOIN PAYMENT P 
ON CU.customer_id=P.Customer_ID
-- where concat(first_name,Last_Name)='MARYSMITH'
) Q1
INNER JOIN 
(select Address_ID,City,Country,District from Address AD 
INNER JOIN CITY CI ON AD.City_ID=CI.City_ID
INNER JOIN COUNTRY CO ON CO.Country_ID=CI.COuntry_ID) Q2
ON Q1.Address_ID=Q2.Address_ID;

-- Co-Related Query


select * from customer where concat(first_name,Last_Name)='MARYSMITH';

select * from category;
select * from film_category;
select * from film;

select F.Title,CA.name as CategoryName from Film F 
INNER JOIN Film_Category FC ON F.Film_ID=FC.FIlm_ID
INNER JOIN CATEGORY CA ON CA.Category_ID=FC.Category_ID;
-- Co-related queries are subqueries where the subquery is dependant on 
-- an input from main query or base query

Create Temporary Table FilmCategories
select F.Title,
(select C.Name from Film_Category FC 
INNER JOIN CATEGORY C ON C.Category_ID=FC.Category_ID
WHERE FC.Film_ID=F.Film_ID
) as Category
 from FILM F;
 
 select * from FilmCategories;
 
 select Count(Title) as TitleCount, category from FilmCategories
 Group by Category
 having Category regexp '^HO' ;
 
 
select * from city
where country_id=(select Country_id from country where country='Argentina');

-- co-related queries
select 
A.address,A.district,
(select City FROM CITY C WHERE C.CITY_ID=A.CITy_ID) as CITY_NAME
from address A;

select * from Address;
select * from city ;

-- address, district,

select * from Film 
select * from Actor;
select * from Film_actor;

select First_Name,
(Select Title  from Film F INNER JOIN Film_Actor FA ON FA.Film_ID=F.FIlm_ID
where FA.Actor_ID=A.ACtor_ID
 ) filmName
 from 
Actor A
