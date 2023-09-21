use sakila;
show tables;
desc customer;
select first_name,last_name from customer;
show tables;
select* from film;
select * from film where rating="PG-13";

select* from film;
select * from customer;
show tables;
select * from rental;
select c.first_name,c.last_name,f.title
from customer c
join rental r on c.customer_id=r.customer_id
join inventory i on r.inventory_id=i.inventory_id
join film f on i.film_id=f.film_id  ;
desc rental ;
#Find the total number of rentals per customer.
select c.first_name,c.last_name,count(r.customer_id)
from customer c
join rental r on c.customer_id=r.customer_id
group by r.customer_id;
#Retrieve all films in the film table whose language is not English..
select*from film  where language_id not in (select language_id from language where name="english")
;select*from language;
#Insert a new customer into the customer table.
insert into customer(first_name,last_name,email)
values ('krish','sutapalli','krishnaharsha1029@gmail.com') ;
desc customer;
#Update the email address of a specific customer.
UPDATE customer
SET email = 'krishna@gmail.com'
WHERE email = 'krishnaharsha1029@gmail.com';
#Delete a customer from the customer table.
delete from customer
where customer_id=1;
#Create an index on the film table to improve the performance of queries on the rating column.
create INDEX idx_rating on film(rating);

#Create a view that combines customer information with their rental history.
create view customer_rental_history as
select c.first_name,c.last_name, r.rental_id, r.rental_date
from customer c
join rental r on c.customer_id=r.customer_id;
select* from customer_rental_history;



select * from rental;
#Create a query to categorize customers into 'Gold,' 'Silver,' or 'Bronze' based on their total rental count.
select first_name ,last_name ,
case 
     when rental_count>=20 then "gold"
     when rental_count>=10 then "silver"
     else "bronze"
end as customer_category     
from 
(select c.first_name,c.last_name,count(r.rental_id)as rental_count from customer c join rental r on c.customer_id=r.customer_id group by c.customer_id)
as customer_rental_counts;
#Combine results from two separate queries to retrieve all customer names and all staff names
select first_name,last_name from customer
union
select first_name,last_name from staff;
#Find all films that have been rented at least once.
select*from film;
desc film;
SELECT title
FROM film f
WHERE EXISTS (
    SELECT 1
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    WHERE i.film_id = f.film_id
);
##Calculate the average rental duration for films.
##Rank customers based on the number of rentals.
##Create a trigger that automatically updates the last_update column when a customer record is updated.



