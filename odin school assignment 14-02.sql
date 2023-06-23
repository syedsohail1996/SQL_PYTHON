-- 
-- Write a SQL query to find the actors who were cast in the movie 'Annie Hall'. Return actor first name, last name and role.
--
select * from movie
where mov_title='Annie Hall';

select actors.act_fname,act_lname,movie_cast.role from movie  join movie_cast  on movie.mov_id = movie_cast.mov_id
join actors on actors.act_id = movie_cast.act_id
where movie.mov_title ='Annie Hall';

--
-- From the following tables, write a SQL query to find the director who directed a movie that casted a role for 'Eyes Wide Shut'.
-- Return director first name, last name and movie title.
--
use moviedb;
select * from movie_cast;

select d.dir_fname, d.dir_lname, m.mov_title from movie m
inner join movie_direction md on md.mov_id = m.mov_id
inner join director d on md.dir_id = d.dir_id
where m.mov_title = 'eyes wide shut';

--
-- Write a SQL query to find who directed a movie that casted a role as ‘Sean Maguire’.
-- Return director first name, last name and movie title.
--
select * from movie_cast;

select * from movie_cast join movie on movie_cast.mov_id = movie.mov_id
join movie_direction md on md.mov_id = movie.mov_id
join director d on d.dir_id = md.dir_id
where movie_cast.role='Sean maguire';

--
-- Write a SQL query to find the actors who have not acted in any movie between 1990 and 2000 (Begin and end values are included.).
-- Return actor first name, last name, movie title and release year.
--
show tables;
SELECT * FROM movie
WHERE mov_year BETWEEN 1990 AND 2000;
select actors.act_fname,actors.act_lname ,movie.mov_title,movie.mov_year from movie join movie_cast mc on movie.mov_id = mc.mov_id
join actors on actors.act_id = mc.act_id
WHERE mov_year BETWEEN 1990 AND 2000;







