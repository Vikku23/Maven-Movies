/*Display the count of unique first name of actor?*/

select count(distinct(first_name)) as unique_count_name from actor;

/* Display the first 10 records from customer table*/

select * from customer limit 10;

/* Display the first 3 records from the customer table whose first name start with 'b' */

select * from customer where first_name regexp '^b' limit 3;
select * from customer where first_name like 'b%' limit 3

/* Display the names of the first 5 movies which are rated as 'G' */

select title, rating from film where rating regexp '^G' limit 5;
select title, rating from film where rating like 'G' limit 5;

/* Find all customers whose first names starts and end with 'a' */

select * from customer where first_name regexp '^a.*a$';
select * from customer where first_name like 'a%a';

/* Display the list of first 4 cities which start and end with 'a' */

select * from city where city regexp '^a.*a$' limit 4;
select * from city where city like 'a%a' limit 4;

/* Find all customer whose first name have 'NI' in any position */

select * from customer where first_name regexp 'NI';
select * from customer where first_name like '%NI%';

/* Find all customers whose first name have 'r' in the second position */

select * from customer where first_name regexp '^.r';
select * from customer where first_name like '_r%';

/* Find all customers whose first name starts with 'a' and are at least 5 characters in length */

select * from customer where first_name like 'a%' and length(first_name) >=5;
select * from customer where first_name regexp '^a' and length(first_name) >=5;

/* Find all customers whose first name starts with 'a' and ends with 'o' */

select * from customer where first_name regexp '^a.*o$';
select * from customer where first_name like 'a%o';

/* Display the actors name in capital letters */

select upper(concat(first_name,' ', last_name)) as Actor_name from actor;

/* Display the first eight characters of the film title */

select title from film where length(title) = 8;

SELECT SUBSTRING(title, 1, 8) AS first_eight_characters
FROM film;

/* How many films did the actors with actor id 1 work in */

select count(film_id) as Total_film from film_actor where actor_id = 1;

/* Query to find the date difference between two given dates '2023-10-19'and '2023-10-23' */

select datediff('2023-10-23', '2023-10-19');

/* Given a date '2023-03-23', write the query to add 10 days to it */

select date_add('2023-03-23',interval 10 day) as new_date; 

/* Given a date '2023-03-23', get the month number from it */

select month('2023-03-23') as month_number;

/* Display the names of actors and the names of the films they have acted in.*/

select concat(first_name, ' ', last_name) as actor_name,title
from actor a join film_actor fa
on a.actor_id = fa.actor_id
join film f
on fa.film_id = f.film_id; 

/* Display the film names and the category of the films they fall into */

select title, name 
from film f join film_category fc
on f.film_id = fc.film_id
join category c 
on fc.category_id = c.category_id;

/* Display the list of films,their actor where the length of the film is greater than 100 min.*/

select concat(first_name, ' ', last_name) as Actor_name,length 
from film f join film_actor fc
on f.film_id = fc.film_id
join actor a 
on fc.actor_id = a.actor_id
where length > 100;

/* Display all the customers whose name starts with A and live in india */

select concat(first_name, ' ', last_name) as Customer_name,country
from customer cu join address a 
on cu.address_id = a.address_id 
join city ci 
on a.city_id = ci.city_id 
join country co
on ci.country_id = co.country_id
where first_name regexp '^a' and country = 'India';

/* Display all cities from india which start with the letter A.*/

select city, country from 
city ci join country co
on ci.country_id = co.country_id
where city regexp '^a' and country = 'India';

/* Create a quick reference of a list of distinct titles and their description
   available in inventory at store 2 to provide easy information about titles */
   
select distinct title, description, store_id
from film f join inventory i 
on f.film_id = i.film_id
where store_id = 2;
   
/* Understand the replacement cost of your film-identify 
replacement cost for films that are
1) Least expensive to replace,
2) Most expensive to replace,
3) The average replacement cost of all the films in store.*/

select
min(replacement_cost) as least_exp_to_replace,
max(replacement_cost) as most_exp_to_replace,
avg(replacement_cost) as avg_of_all_films
from film;

/* Write a sql query to count the number of characters except for the space for each actor. 
   Return the first 10 actor's name lengths along with their names.*/

select concat( first_name, ' ',last_name) as fullname, 
length(concat( first_name, last_name)) as total_length 
from actor limit 10;   

/* List all oscar awardees(Actors who received the oscar award) 
   with their full names and length of their names.*/

select concat( first_name, ' ',last_name) as fullname, awards, 
length(concat( first_name, last_name)) as total_length 
from actor_award
where awards = 'Oscar'   

/* Find the actors who have acted in the fil 'Frost Head'. */

select  concat( first_name, ' ',last_name) as Fullname,Title
from actor a join  film_actor fa 
on a.actor_id =  fa.actor_id
join film f 
on f.film_id = fa.film_id 
where title = 'Frost Head';

/* Pull all the films acted by the actor 'Will Wilson'.*/

select title,concat(first_name, ' ', last_name) as actor_name
from film f join  film_actor fa 
on f.film_id =  fa.film_id
join actor a 
on fa.actor_id = a.actor_id
where first_name = 'Will' and last_name ='Wilson';

/*Pull all the films which were rented and return them in the month of may.*/

select title ,rental_date,return_date
from film f join inventory i 
on f.film_id = i.film_id
join rental r 
on r.inventory_id = i.inventory_id 
where month(rental_date) =5 and month(return_date) = 5;
 
 /* Pull all the films with 'Comedy' category.*/
 
select title,name as category
from film f join film_category fc
on f.film_id = fc.film_id
join category c 
on c.category_id = fc.category_id 
where name = 'Comedy';


/**GROUP BY, HAVING CLAUSE AND AGGREGATION**/

/* Write a query to group the rental data by customer_id.*/

select customer_id ,count(*)
from rental
group by customer_id;

/*Write a query to count the number of payments made by each customer. 
Show the customer id, the number of rentals and the total amount paid for each customer. */

select customer_id, count(rental_id) as no_of_rental, sum(amount) as Total_amount
from payment
group by customer_id;

/*Modify the above query to include only those customer who have made at least 20.*/

select customer_id, count(rental_id) as no_of_rental, sum(amount) as Total_amount
from payment
group by customer_id
having no_of_rental >= 20;

/*Write a query to find the number of films acted by each actor_id using film_actor table.*/

select actor_id, count(*) as No_of_film
from film_actor
group by actor_id;

/*Write a query to find the total number of films acted by each actor grouped by the film rating*/

select actor_id, count(*) as Total_film, rating
from film f join film_actor fa
on f.film_id = fa.film_id
group by rating,actor_id;

/*Write a query to group the rentals by year and count them.*/

select year(rental_date) as Rental_year, count(*) as Total_rental
from rental
group by Rental_year;

/**  NON CORRELATED SUBQUERY**/

/*CONSTRUCT A QUERY AGAINST THE FILM TABLE THAT USES A FILTER CONDITION WITH 
A NONCORRELATED SUBQUERY AGAINST THE CATEGORY TABLE TO FIND ALL HORROR FILMS. */

select film_id, title
from film
where film_id in (select film_id from film_category 
where category_id in (select category_id from category
where name = 'Horror'));

/*Write a query that returns all cities that are not in china.*/
select city_id, city 
from city 
where country_id in (select country_id from country where country != 'China');

/*Write a query that returns all cities that are in India or Pakistan.*/

select city_id, city 
from city 
where country_id in (select country_id from country where country = 'India' or country = 'Pakistan');

/**CORRELATED SUBQUERY**/
/*Write a query to count the number of film rentals for each customer and the containing query then retrieves 
those customers who have rented exactly 30 films.*/

select customer_id, count(*) Film_rentalcount
from rental r1 
where ( select count(*) from rental r2 where r1.customer_id = r2.customer_id) = 30
group by customer_id;

/*Write a query  to find all customers whose total payments for all film rentals are between 100 and 150 dollars.*/
 
 select customer_id ,sum(amount) as Total_payment
 from payment p1
 where (select sum(amount) from payment p2 where p1.customer_id = p2.customer_id)
 between 100 and 150
 group by customer_id;
 
 /*Write a query to find all the customers who rented at least one film 
 prior to june 01 2005 without regard for how many films were rented.*/
 
 select c.first_name,last_name
 from customer c where exists( select 1 from rental r where r.customer_id = c.customer_id 
 and date(r.rental_date) < '2005-06-01');
 
/*Construct a query against the film table that uses a filter condition with 
correlated subquery against the category table to find all Horror films.*/

select film_id , title 
from film f where exists(select film_id from film_category fc 
where f.film_id = fc.film_id 
and exists(select category_id from category c where name = 'Horror'
and c.category_id = fc.category_id));
 
/**Conditional Logic**/

/*Write a query to generate a value for the activity_type column which returns the string
 “Active” or “Inactive” depending on the value of the customer.active column.*/
 
 select customer_id, first_name,last_name,
 case
 when active = 1 then 'Active'
 when active = 0 then 'Inactive'
 else 'Unknown'
 end as Activity_type
 from customer;
 
/*Write a query to retrieve the number of rentals for each active customer
For inactive customer the result should be 0.Use case expression and correlated subquery.*/

select customer_id,first_name,last_name,
case
when(select count(*) from rental r where c.customer_id = r.customer_id and active = 1)then 1
when(select count(*) from rental r where c.customer_id = r.customer_id and active = 0)then 0
else 'Unknown'
end as Status
from customer c;

/*Write a query to show the number of film rentals for May,June and July of 2005 in a single row*/

select 
sum(case when (year(rental_date) = 2005 and (monthname(rental_date) = 'May')) then 1 else 0 end) as May_rental,
sum(case when (year(rental_date) = 2005 and (monthname(rental_date) = 'June')) then 1 else 0 end) as June_rental,
sum(case when (year(rental_date) = 2005 and (monthname(rental_date) = 'July')) then 1 else 0 end) as July_rental
from rental;

/* Write a query to categorize film based on the inventory level
If the count of coopies is 0 then 'Out of stock'
If the count of copies is 1 or 2 then 'Scarce'
If the count of copies is 3 or 4 then 'Available'
If the count of copies is >= 5 then 'Common' */

select film_id,count(*),
case
when count(*) = 0 then 'Out of stock'
when count(*) = 1 or count(*) = 2 then 'Scarce'
when count(*) = 3 or count(*) = 4 then 'Available'
else 'Common'
end as category
from inventory 
group by film_id;

/*Write a query to get each customer along with their total payment, number of payments and average payment*/

select c.customer_id,c.first_name,c.last_name,
sum(p.amount) as total_payment,
count(p.amount) as Number_of_payment,
sum(p.amount)/
case 
when count(p.amount) = 0 then 1
else count(p.amount)
end as Avg_amount
from customer c left join payment p
on c.customer_id = p.customer_id
group by c.customer_id;

/*Write a query to create a single row containing the number of films based on the rating (G, PG, NC17)*/

select
sum(case when rating = 'G' then 1 else 0 end) as G_Category,
sum(case when rating = 'PG' then 1 else 0 end) as PG_Category,
sum(case when rating = 'NC-17' then 1 else 0 end) as NC17_Category
from film;

/**CTE**/

/*Create a CTE with two named subqueries. The first one gets the actors 
with last names starting with s. The second one gets all the pg films 
acted by them. Finally show the film id and title.*/

with actor_s as 
( select actor_id,first_name,last_name from actor where last_name regexp '^s'),
pg_film as 
(select film_id,title,rating from film where rating = 'PG') 

select actor_s.actor_id, actor_s.first_name,actor_s.last_name,pg_film.film_id,pg_film.title,pg_film.rating
from actor_s join film_actor using (actor_id)
join pg_film using(film_id);

/*Add one more subquery to the previous CTE to get the revenues of those movies*/

with actor_s as 
( select actor_id,first_name,last_name from actor where last_name regexp '^s'),
pg_film as 
(select film_id,title,rating from film where rating = 'PG'),
revenue as 
(select i.film_id, sum(p.amount) as Total_amount
from payment p join rental r 
on p.rental_id = r.rental_id
join inventory i 
on i.inventory_id = r.inventory_id
group by i.film_id)

select actor_s.actor_id, actor_s.first_name,actor_s.last_name,
pg_film.film_id,pg_film.title,pg_film.rating,
revenue.Total_amount
from actor_s join film_actor using (actor_id)
join pg_film using(film_id)
join revenue using (film_id);

/**WINDOWS FUNCTION**/

/* find the average rental duration of all customers, with the minimum and maximum rental duration
 as well as display it partitioned by the staff member who handled the rental (Mavenmovies database)*/
 
 select customer_id,staff_id,
 avg(datediff(return_date, rental_date)) over (partition by staff_id) as avg_duration,
 min(datediff(return_date, rental_date)) over (partition by staff_id) as min_duration,
 max(datediff(return_date, rental_date)) over (partition by staff_id) as max_duration
 from rental;
 
 
 /* find the total rental fees generated by each customer,along with the average rental fees for all customers
and display it partition by the rental date*/

select rental.customer_id ,rental_date,
sum(amount) over (partition by customer_id) as total_fees,
avg(amount) over () as avg_fees
from rental join payment
on payment.rental_id = rental.rental_id;

/* rank the film by the number of times they were rented in descending order*/

select f.film_id, f.title,count(r.rental_id) as rental_count,
rank() over (order by count(r.rental_id) desc) as rental_rank
from film f join inventory i 
on f.film_id = i.film_id
join rental r 
on i.inventory_id = r.inventory_id
group by f.film_id 
order by rental_rank;

/* rank the customers by the number of rentals they made in the year 2005 in descending order*/

select c.customer_id ,c.first_name, c.last_name,
count(r.rental_id) as rental_count,
dense_rank() over (order by count(r.rental_id) desc) as ranks
from customer c join rental r on  c.customer_id = r.customer_id
where year(r.rental_date) = 2005
group by c.customer_id order by ranks;