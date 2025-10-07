
/*
select first_name, last_name 
from staff
where first_name ilike 'A%A'

select distinct extract(mounth from created_date)
from orders

select product_id, round(price - ((price * 20) / 120), 2) 
from product

select city
from city
where city like '__q%'

select created_date::time
from orders

select *
from product
where product like '% %'

select order_id, amount, discount, amount - ((100 * discount) / 100::numeric) 
from orders

select *
from product
where price >= 100 and char_length(product) = 10

select *
from customer
where char_length(first_name) = char_length(last_name) and left(first_name, 1) = left(last_name, 1) 

select count(*) as total 
from city
where left(city, 1) = right(city, 1)

select count(*) as total
from product
where not deleted 


select count(*) 
from orders
where amount between 200 and 215


select *
from orders
where discount > 3

select count(*) as total
from city
where left(city, 1) = right(city, 1)

*/

select first_name as "Имя", last_name as "Фамилия", a.address 
from customer c 
join address a on a.address_id = c.address_id 

select first_name as "Имя", last_name as "Фамилия", a.address as "Адрес", c2.city as "Город"
from customer c 
join address a on a.address_id = c.address_id 
join city c2 on a.city_id = c2.city_id 

select count(*)
from category c 
join product p on c.category_id = p.category_id 
where c.category = 'Музыка'

select c.first_name, c.last_name 
from customer c 
join address a on a.address_id = c.address_id 
join city c2 on c2.city_id = a.city_id 
where c2.city  = 'Aden'

select count(*)
from staff s 
join "structure" s2 on s.unit_id = s2.unit_id 
where unit = 'Группа розничных платежей'

select avg(o.amount) 
from customer c 
join orders o on o.customer_id = c.customer_id 
where c.last_name ilike 'a%'

select max(price) 
from product p 
where price between 0 and 50

select c.category 
from category c 
join product p on c.category_id = p.category_id 
group by c.category_id 
/* where p(*) > 30 */

select count(*) 
from orders o 
where not deleted and o.delivery_id is not null

select count(*) 
from orders o 
join customer c on c.customer_id = o.customer_id 
join address a on a.address_id = c.address_id 
join city c2 on c2.city_id = a.address_id 
where city = 'El Alto'

select count(*)
from orders o 
join customer c on c.customer_id = o.customer_id 
where c.first_name = 'Linda' and c.last_name = 'Williams'

select distinct count(*)
from category c 
join product p on c.category_id = p.category_id 
where c.category = 'Игрушки'

