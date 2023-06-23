-- Q1..Create a view definition which groups all the films by their rating.
use mavenmovies;
create view  as_per_rating_wise as (select rating,
count(rating) as 'number' from film group by rating);

select * from as_per_rating_wise;

-- 
-- Create a view definition which computes the total payments made by all customers grouped by country ?
-- Find the least paid country ?
select * from payment;
select * from customer;
select * from address;
select * from city;
select * from country;


select country.country , sum(payment.amount) from payment
join customer on customer.customer_id =  payment.customer_id
join address on address.address_id  =customer.address_id
join city on  city.city_id =  address.city_id 
join country on country.country_id  =  city.country_id
group by country.country
order by sum(payment.amount);

create view  pay_all_cutmrs_by_country_wise  as  (select payment.customer_id, country.country,payment.amount from payment 
join customer on payment.customer_id = customer.customer_id
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id
group by  country.country
order by sum(payment.amount);

select distinct customer_id, amount,country from pay_all_cutmrs_by_country_wise;

SELECT amount,country
FROM pay_all_cutmrs_by_country_wise  
WHERE amount IN  
( SELECT MIN(amount)  
FROM pay_all_cutmrs_by_country_wise  
GROUP BY  country );


-- Q3.. Using stored procedures, print the series 0,2,4,6,8,10 ?

DELIMITER //

CREATE PROCEDURE while_loop()
   BEGIN

   DECLARE num INT default 0;

   DECLARE res Varchar(50);

   SET res = CAST(num AS CHAR);

   WHILE num < 10 DO

             SET num = num + 2;

      SET res = CONCAT(res,',' , num);

   END While;

   SELECT res;

   END //

call while_loop();

-- Q4.. Create a procedure which takes the film rating as input and gives the number of films with that rating as output.

delimiter //

CREATE PROCEDURE film_counts(IN input_rating CHAR(10), OUT num INT)

BEGIN

SELECT count(*) into num FROM film

WHERE rating = input_rating;

END//




CALL film_counts('pg', @fl);

SELECT @fl as number_of_films;


