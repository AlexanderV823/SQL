--Напишите запрос, который выведет из таблицы с пользователями столбцы с именем и фамилией 
--и для этих столбцов задайте алиасы, присоедините таблицу с адресами и выведите значение адреса.
select first_name as "Имя", last_name as "Фамилия", a.address 
from customer c 
join address a on a.address_id = c.address_id 

--Напишите запрос, который выведет из таблицы с пользователями столбцы с именем и фамилией и для этих столбцов задайте алиасы, 
--присоедините таблицу с адресами и выведите значение адреса, добавьте таблицу с городами и выведите значение города
select first_name as "Имя", last_name as "Фамилия", a.address as "Адрес", c2.city as "Город"
from customer c 
join address a on a.address_id = c.address_id 
join city c2 on a.city_id = c2.city_id 

--Напишите запрос, который выведет количество товаров в категории "Музыка"
select count(*)
from category c 
join product p on c.category_id = p.category_id 
where c.category = 'Музыка'

--Выведите имя и фамилию пользователя из города “Aden”
select c.first_name, c.last_name 
from customer c 
join address a on a.address_id = c.address_id 
join city c2 on c2.city_id = a.city_id 
where c2.city  = 'Aden'

--Получите количество сотрудников, которые числятся в “Группа развития розничных продаж”
select count(*)
from staff s 
join "structure" s2 on s.unit_id = s2.unit_id 
where s2.unit = 'Группа развития розничных платежей'

--Получите среднее значение платежей по каждому пользователю, при этом работать нужно только с пользователями, у которых первая буква фамилии начинается на “А”
select avg(o.amount) 
from customer c 
join orders o on o.customer_id = c.customer_id 
where c.last_name ilike 'a%'

--Получите максимальное значение стоимости товара, если работать только с теми товарами, стоимость которых находятся в диапазоне от 0 до 50
select max(price) 
from product p 
where price > 0 and price < 50

--Выведите названия категорий в которой находится более 30 товаров
select c.category 
from category c 
join product p on c.category_id = p.category_id 
group by c.category_id 
having count(*) > 30

--Какое количество платежей было совершено?
select count(*) 
from orders o 
/*where not deleted and o.delivery_id is not null*/

--Какое количество заказов было совершено пользователями из города “El Alto”?
select count(*) 
from orders o 
join customer c on c.customer_id = o.customer_id 
join address a on a.address_id = c.address_id 
join city c2 on c2.city_id = a.address_id 
where city = 'El Alto'

--Сколько “Черепах” купила “Williams Linda”?
select sum(opl.amount)
from orders o 
join customer c on c.customer_id = o.customer_id 
join order_product_list opl on opl.order_id = o.order_id 
join product p on p.product_id = opl.product_id 
where c.first_name = 'Linda' and c.last_name = 'Williams' and p.product = 'Черепаха'

--Сколько уникальных пользователей совершали покупки товаров из категории “Игрушки”?
select count(distinct customer_id)
from category c 
join product p on c.category_id = p.category_id 
join order_product_list opl on opl.product_id = p.product_id 
join orders o on o.order_id = opl.order_id 
where c.category = 'Игрушки'