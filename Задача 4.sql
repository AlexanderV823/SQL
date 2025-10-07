
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

/*
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
where s2.unit = 'Группа розничных платежей'

select avg(o.amount) 
from customer c 
join orders o on o.customer_id = c.customer_id 
where c.last_name ilike 'a%'

select max(price) 
from product p 
where price > 0 and price < 50

select c.category 
from category c 
join product p on c.category_id = p.category_id 
group by c.category_id 
having count(*) > 30

select count(*) 
from orders o 
/*where not deleted and o.delivery_id is not null*/

select count(*) 
from orders o 
join customer c on c.customer_id = o.customer_id 
join address a on a.address_id = c.address_id 
join city c2 on c2.city_id = a.address_id 
where city = 'El Alto'

select sum(opl.amount)
from orders o 
join customer c on c.customer_id = o.customer_id 
join order_product_list opl on opl.order_id = o.order_id 
join product p on p.product_id = opl.product_id 
where c.first_name = 'Linda' and c.last_name = 'Williams' and p.product = 'Черепаха'

select count(distinct customer_id)
from category c 
join product p on c.category_id = p.category_id 
join order_product_list opl on opl.product_id = p.product_id 
join orders o on o.order_id = opl.order_id 
where c.category = 'Игрушки'

select count(*)
from customer c
join orders o on c.customer_id = o.customer_id
join address a on a.address_id = c.address_id
join city c2 on a.city_id = c2.city_id
where c2.city = 'El Alto'
*/

========== Задача 4 ==========
select *, row_number() over (order by price)
from product

select product_id, price, price  - lag(price) over (order by product_id)
from product

select concat(c.last_name, ' ', c.first_name)
from (
	select customer_id, sum(amount), dense_rank() over (order by sum(amount) asc)
	from orders 
	group by customer_id) t 
join customer c on c.customer_id = t.customer_id
where dense_rank = 1

select concat(last_name, ' ', first_name)
from customer
where customer_id in (
	select customer_id
	from orders 
	group by customer_id
	having sum(amount) = (
		select sum(amount)
		from orders 
		group by customer_id
		order by 1 
		limit 1))
		
select p.product, opl.sum
from product p
left join (
	select product_id, sum(amount)
	from order_product_list 
	group by product_id) opl on opl.product_id = p.product_id
	
select order_id, customer_id, amount, sum(amount) over (partition by customer_id order by order_id)
from orders 

select *
from (
select *, row_number() over (partition by customer_id order by order_id)
from orders) t
where row_number = 5

select c.customer_id, avg(opl.avg)
from (
	select order_id, avg(amount)
	from order_product_list 
	group by order_id) opl
join orders o on o.order_id = opl.order_id
join customer c on c.customer_id = o.customer_id
group by c.customer_id
order by c.customer_id

select round(max(res), 3)
from (
select c.category_id, count(*) * 100. / (select count(*) from product) res
from product p
join category c on p.category_id = c.category_id
group by c.category_id) t

select category
from category
where category_id in (
select category_id
from (
select p.category_id, sum(opl.amount * p.price), dense_rank() over (order by sum(opl.amount * p.price) desc)
from order_product_list opl
join product p on p.product_id = opl.product_id
group by p.category_id) t
where dense_rank = 1)

select *
from (
select order_id, customer_id, amount, lag(amount) over (partition by customer_id order by order_id),
amount * 100 / lag(amount) over (partition by customer_id order by order_id) - 100 as diff
from orders) t
where diff = 25

select round(max(res))
from (
	select c.category_id, count(*) * 100 /(select count(*) from product) res
	from product p
	join category c on p.category_id = c.category_id
	group by c.category_id) t
