-- 1) How many copies of the film Hunchback Impossible exist in the inventory system?
select count(inventory_id) as Copies from inventory
where film_id = (select film_id from film
where title ='Hunchback Impossible');

-- 2) List all films whose length is longer than the average of all the films.
select film_id from film
where length > (select avg(length) from film);

-- 3) Use subqueries to display all actors who appear in the film Alone Trip.
select first_name, last_name from actor
where actor_id in (select actor_id from film_actor
where film_id = (select film_id from film 
where title = 'Alone Trip'));

-- 4) Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
select film_id, title from film
where film_id in (select film_id from film_category
where category_id =(select category_id from category
where name ='family'));

-- 5) Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
-- subquery
select first_name,last_name,email from customer
where address_id in (select address_id from address
where city_id in (select city_id from city
where country_id = (select country_id from country 
where country ='canada')));

-- join
select c.first_name,c.last_name,c.email from customer c
left join address a on c.address_id = a.address_id
left join city ct on a.city_id = ct.city_id
left join country co on ct.country_id = co.country_id
where country = 'canada';

-- 6) Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
select title from film
where film_id in (select film_id from film_actor
where actor_id = (select actor_id from film_actor
group by actor_id
order by count(film_id) desc
limit 1)
);

-- 7) Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
select film_id, title from film
where film_id in (select film_id from inventory
where inventory_id in (select inventory_id from rental
where customer_id= (select customer_id from payment
group by customer_id
order by sum(amount) desc
limit 1)));

-- 8) Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
select customer_id, sum(amount) as total_amount from payment
group by customer_id
having total_amount> (select avg(total_amount) from (
select customer_id, sum(amount) as total_amount
from payment
group by customer_id) as customer_payment
)






