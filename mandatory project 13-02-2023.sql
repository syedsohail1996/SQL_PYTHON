use mavenmovies;
-- Write a SQL query to count the number of characters except the spaces for each actor.
-- Return first 10 actors name length along with their name
select * from actor;
SELECT 
    actor_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    LENGTH(CONCAT(first_name, ' ', last_name)) AS len
FROM
    actor
ORDER BY actor_id asc
LIMIT 10; 

-- 2 .List all Oscar awardees(Actors who received Oscar award) with their full names and length of their names.

select * from actor_award;

select
actor_id,
 CONCAT(first_name, ' ', last_name) AS full_name,
LENGTH(CONCAT(first_name, '', last_name)) AS len
 from actor_award 
where actor_award.awards like '%Oscar%' 
order by actor_id  ;

-- 3.Find the actors who have acted in the film ‘Frost Head’.

select * from film
where film.title = 'Frost Head' and film_id in
;



select * from film_actor 
where film_id=341;


select *
 from actor 
where actor_id in (select actor_id from film_actor 
where film_id in (select film_id from film
where film.title = 'Frost Head') );
                    -- or --
select a.first_name ,a.actor_id  from actor a  join film_actor fa on a.actor_id=fa.actor_id
                       join film f on f.film_id = fa.film_id
                      where f.title = 'Frost Head';


  --  4.Pull all the films acted by the actor Will Wilson
  
 SELECT * from actor
 where first_name='will' and last_name='wilson';
 
 select a.first_name ,a.last_name,a.actor_id ,f.title from actor a  join film_actor fa on a.actor_id=fa.actor_id
                       join film f on f.film_id = fa.film_id
                      where a.first_name = 'will' and a.last_name='wilson';
                      
 -- 5.Pull all the films which were rented and return in the month of May.
# as per this question we didnt find rented and return colums in our whole database , we tried to write but we didint get a logic.
select * from film;
where last_update= month(5);   

-- 6. Pull all the films with ‘Comedy’ category.
 
 select * from category
 where  name='Comedy';
 
 select category.category_id , category.name ,film.title from category  join film_category on category.category_id = film_category.category_id
                       join film  on film.film_id = film_category.film_id
                      where category.category_id = 5;

 