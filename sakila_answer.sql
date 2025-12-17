

--  SECTION - A

-- 1.Write a query to list actors whose last name is 'ALLEN'.
select * from actor where last_name ='ALLEN';



-- 2.Write a query to find the `first_name`, `last_name`, and `email` of all customers whose first name is 'JENNIFER'.
SELECT * FROM customer;
SELECT 
first_name,last_name,email
FROM 
customer
WHERE first_name= 'JENNIFER';


-- 3.Write a query to list the `title`, `release_year`, and `rating` of all films that are rated 'PG-13'.
select * from film;
SELECT title, 
release_year,
rating
from film
where rating = 'PG-13';

-- 4. Write a query to display the `title` and `length` of all films, ordered from the longest film to the shortest.
select * from film;
select title, length
from film
order by length desc;


-- 5.  Write a query to show the `customer_id`, `amount`, and `payment_date` for the 10 most recent payments.
select * from customer;
select * from payment;
select customer_id ,amount, payment_date 
from payment
order by payment_date desc
limit 10;

-- ----------------------------------------------------
-- SECTION - B

-- 1. Write a query to list the first name and last name of all actors who appeared in the film 'AGENT TRUMAN'.
select * from film;
select * from actor;
select a.first_name, a.last_name
from actor a
join film f
on a.actor_id= f.film_id
where f.title ='AGENT TRUMAN';


-- 2. Write a query to display the first name, last name, address, and city for customer 'MARY SMITH'.
select * from customer;
select * from city;
select* from address;
select  ct.city , a. address
FROM customer c
join address a
on c.address_id = a. address_id
join city ct
on ct.city_id =a.city_id
where concat(c.first_name,' ',c.last_name)='MARY SMITH';



-- 3.  Write a query to show the name of each category and the total number of films in that category.
select*from category;
select*from film;
select * from film_category;
select c.name , 
count(f.film_id) as total_films
from film f
join film_category fc
on  fc.film_id=f.film_id
join category c 
on c.category_id= fc.category_id
group by c.name;




-- 4. Write a query to find the `title` and `description` of all films that have the word 'Drama' anywhere in their `description`.
select * from film;
SELECT title, description
FROM film
WHERE description LIKE '%Drama%';


-- 5. Write a query to find the `title` and `rental_duration` for all films that can be rented for more than 5 days.
select * from film;
select title, rental_duration 
from film 
where rental_duration > 5;


-- 6. Write a query to list each `customer_id` and the total `amount` they have paid in rentals. Order the results by the total amount, from highest to lowest.
SELECT * FROM CUSTOMER;
SELECT * FROM PAYMENT;
SELECT * FROM RENTAL;
select c.customer_id, sum(p.amount) as total_amount
from customer c 
join payment p on c.customer_id =p.customer_id
join rental r on  p.rental_id= r. rental_id
group by customer_id
order by total_amount asc;


-- 7. Write a query to find the `first_name`, `last_name`, and `city` for all customers who live in 'Aurora' or 'London'.
select * from customer;
select * from city;
select* from address;

SELECT 
    c.first_name,
    c.last_name,
    ci.city
FROM customer c
JOIN address a
    ON c.address_id = a.address_id
JOIN city ci
    ON a.city_id = ci.city_id
WHERE ci.city IN ('Aurora', 'London');



-- 8. Write a query to find the average `rental_rate` for each film `rating` (G, PG, etc.).

select * from film;
select * from rental;
SELECT rating, AVG(rental_rate) AS average_rental_rate
FROM film
GROUP BY rating;


-- 9.  Write a query to find the `first_name` and `last_name` of actors who have appeared in more than 30 films. Also, show the count of films they appeared in.
select * from actor;
select * from film_actor;
select  a.first_name,a.last_name ,count(fa.film_id)as appeared_film
from actor a 
join film_actor fa
on fa. actor_id= a.actor_id
where a.actor_id >30
group by a.actor_id;




-- 10. Write a query to find all payments with an `amount` greater than 5.00 that were made between '2005-05-25' and '2005-05-30'.

select * from payment;
select *from payment
where amount >5
and payment_date between'2005-05-25'and 2005-05-30;

-- 11. Write a query to display the `title` and `description` of all films in the 'Action' category. 
-- Use a subquery to find the `category_id` for 'Action'.
select * from film_category;
select * from category;
select * from film;
select f.title,f.description from film f 
join film_category fc 
on fc. film_id =f.film_id
where fc.category_id =(
select category_id from category where name ='action');


-- 12.Write a query to list the `first_name` and `last_name` of all customers who have rented the film 'AFRICAN EGG'.
select * from customer;
select *from inventory;   -- store_id
select * from film;       -- film_id
select * from film_category; -- film_id




-- 13. Write a query to find all film titles that do *not* have any copies in the `inventory`.
select * from inventory;
select  title from film 
where film_id not in (
select distinct film_id from inventory);

-- 14. Write a query to show the `store_id` and the total revenue (sum of `amount` from the `payment` table) generated by each store.
select * from store;
select * from payment;
select s.store_id, sum(p.amount)as t_rev
from store s 
join staff st 
on s.store_id=st.store_id
join payment p 
on p.staff_id=st.staff_id
group by s.store_id;

-- 15. Write a query to find the `first_name` and `last_name` of the customer who has spent the most money.
SELECT c.first_name, c.last_name
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id , c.first_name , c.last_name
ORDER BY SUM(p.amount) DESC
LIMIT 1;
