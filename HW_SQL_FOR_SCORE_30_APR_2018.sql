use sakila;
#
#Quesion 1a
SELECT first_name, last_name FROM actor;
#
#Question 1b
SELECT CONCAT(first_name, ' ', last_name) AS Actor_Name FROM actor;
#
#Question 2a
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = "Joe";
#
#Question 2b
SELECT first_name, last_name FROM actor
WHERE last_name LIKE '%GEN%';
#
#Question 2c
SELECT last_name, first_name  FROM actor
WHERE last_name LIKE '%LI%';
#
#Question 2d
SHOW COLUMNS FROM country;
SELECT country_id, country FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");
#
#Question 3a
ALTER TABLE actor
ADD middle_name VARCHAR(45) AFTER first_name;
show columns from actor;
#
#Question 3b
ALTER TABLE actor
MODIFY COLUMN middle_name BLOB;
show columns from actor;
#
#Question 3c
ALTER TABLE actor
DROP COLUMN middle_name;
show columns from actor;
#
#Question 4a
SELECT last_name, COUNT(*) AS num_names
FROM actor
GROUP BY last_name;
#
#Question 4b
SELECT last_name, COUNT(*) AS num_names
FROM actor
GROUP BY last_name
HAVING COUNT(*) > 1;
#
#Question 4c
SELECT last_name,first_name FROM actor;
UPDATE actor
set first_name = "HARPO"
WHERE last_name = "WILLIAMS" AND first_name ="GROUCHO";
SELECT last_name,first_name FROM actor
WHERE last_name = "WILLIAMS" AND first_name ="HARPO";
#
#Question 4d
SELECT actor_id, last_name,first_name FROM actor
WHERE last_name = "WILLIAMS" AND first_name ="HARPO";
#Question 4d
#SELECT actor_id, last_name,first_name FROM actor
#
#Question 5a
SHOW DATABASES;
DESCRIBE address;
#
#Question 6a preparation
DESCRIBE staff;
#
#Question 6a Answer
SELECT first_name, last_name, address
FROM staff, address
WHERE staff.address_id = address.address_id
ORDER BY first_name, last_name, address;
#
#Question 6b
SELECT staff.first_name, staff.last_name, COUNT(payment.amount) AS Aug_2005_total_payment
FROM staff INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id;
#
#Question 6c
SELECT film.title, COUNT(film_actor.actor_id) AS Total_Actors
FROM film_actor INNER JOIN film ON film.film_id = film_actor.film_id
GROUP BY film.title;
#
#Question 6d
SELECT film.title, COUNT(inventory.film_id) AS Copies
FROM film INNER JOIN inventory ON film.film_id = inventory.film_id
WHERE film.title = "Hunchback Impossible";
#
#Question 6e
SELECT customer.last_name, COUNT(payment.amount) AS total_payments
FROM payment INNER JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY customer.last_name;
#
#Question 7a
SELECT title FROM film
WHERE (title LIKE 'K%' OR title LIKE 'Q%') IN (SELECT language_id FROM language WHERE name ='English');
#
#Question 7b
SELECT first_name, last_name FROM actor 
WHERE actor_id IN ( SELECT actor_id from film_actor
                    WHERE film_id IN (SELECT film_id 
                                      FROM film 
                                      WHERE title="Alone Trip"));
#
#Question 7c
SELECT customer.first_name, customer.last_name, customer.email
FROM country, city, address, customer
WHERE (customer.address_id = address.address_id) AND (address.city_id = city.city_id)
	   AND (city.country_id = country.country_id) AND  country.country = "Canada"; 
#
#Question 7d
SELECT film.title
FROM film, film_category
WHERE (film.film_id = film_category.film_id) AND film_category.category_id = 8;
#
#Question 7e
SELECT film_text.title, COUNT(film_text.title) AS Most_Rented 
FROM film_text, inventory, rental
WHERE (film_text.film_id = inventory.film_id) AND (inventory.inventory_id=rental.inventory_id)
GROUP BY film_text.title
ORDER BY COUNT(film_text.title) DESC;
#
#Question 7f
SELECT store.store_id, COUNT(payment.amount) AS business_$
FROM inventory, rental, payment, store
WHERE (store.store_id = inventory.store_id) AND (inventory.inventory_id = rental.inventory_id) 
       AND (rental.rental_id = payment.rental_id)
GROUP BY store.store_id;
#
#Question 7g
SELECT store.store_id, city.city, country.country
FROM country, city, address, store
WHERE (country.country_id = city.country_id) AND (city.city_id = address.city_id)
	    AND (address.address_id = store.address_id);
#
#Question 7h
SELECT category.name, COUNT(payment.amount) AS Gross_Revenue_$ 
FROM category, film_category, inventory, rental, payment
WHERE (category.category_id = film_category.category_id) AND (film_category.film_id=inventory.film_id) 
AND (inventory.inventory_id = rental.inventory_id) AND (rental.rental_id = payment.rental_id)
GROUP BY category.name 
ORDER BY COUNT(category.name) DESC
LIMIT 5;
#
#Question 8a
CREATE VIEW top_grossing_genre AS
SELECT category.name, COUNT(payment.amount) AS Top_Gross_Revenue_$ 
FROM category, film_category, inventory, rental, payment
WHERE (category.category_id = film_category.category_id) AND (film_category.film_id=inventory.film_id) 
AND (inventory.inventory_id = rental.inventory_id) AND (rental.rental_id = payment.rental_id)
GROUP BY category.name 
ORDER BY COUNT(category.name) DESC
LIMIT 5;
#DROP VIEW top_grossing_genre;
SELECT *
FROM top_grossing_genre;
#
#Clean Up Views
DROP VIEW top_grossing_genre;
##############################################################################################################
#                                            End of Homework
##############################################################################################################




