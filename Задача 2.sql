
--Напишите запрос, который выведет все столбцы из таблицы с пользователями
select * 
from staff

--Напишите запрос, который выведет из таблицы с пользователями столбцы с именем и фамилией
select first_name, last_name
from staff

--Напишите запрос, который выведет из таблицы с пользователями столбцы с именем и фамилией. 
--При этом нужны пользователи у которых первая и последняя буквы имени “A”. 
--Так как регистр символов неизвестен, то используйте регистронезависимый поиск.
select first_name, last_name 
from staff
where first_name ilike 'A%A'

--Получите уникальное значение месяца из даты заказов
select distinct extract(mounth from created_date)
from orders

--Из стоимости товара вычтите НДС 20% и округлите полученное значение до сотых.
select product_id, round(price - ((price * 20) / 120), 2) 
from product

--Получите названия городов, третья буква котрых равна “q” с учетом регистра.
select city
from city
where city like '__q%'

--Выведите в результат время заказа без даты
select created_date::time
from orders

--Выведите в результат все столбцы из таблицы товаров, при этом в результате должны быть только те товары, где в названии есть пробел.
select *
from product
where product like '% %'

--Выведите из таблицы с заказами идентификатор заказа, стоимость заказа, размер скидки и посчитайте стоимость заказа за вычетом скидки
select order_id, amount, discount, amount - ((100 * discount) / 100::numeric) 
from orders

--Выведите список товаров, стоимость которых больше или равна 100 и название состоит из 10 символов
select *
from product
where price >= 100 and char_length(product) = 10

--Получите список пользователей, у которых количество символов в имени равно 
--количеству символов в фамилии и первая буква фамилии равна первой букве имени
select *
from customer
where char_length(first_name) = char_length(last_name) and left(first_name, 1) = left(last_name, 1) 

--Сколько городов имеют первый символ названия равный последнему?
select count(*) as total 
from city
where left(city, 1) = right(city, 1)

--Получите товары, которые имеют пометку на удаление, какое количество таких товаров?
select count(*) as total
from product
where not deleted 

--Сколько заказов имеют стоимость от 200 включительно до 215 включительно?
select count(*) 
from orders
where amount between 200 and 215

--Напишите запрос и ответьте на вопрос. Есть ли заказы со скидкой больше 3%?
select *
from orders
where discount > 3