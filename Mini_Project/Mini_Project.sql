-- SQLWithIDC - Mini Project

-- Phase 1: Foundation & Inspection
   -------
   
-- 2. List all unique pizza categories (DISTINCT).
select distinct category as unique_categories from pizza_types;

-- 3. Display pizza_type_id, name, and ingredients, replacing NULL ingredients with "Missing Data". Show first 5 rows.
select pizza_type_id,name,coalesce(ingredients,'Missing Data') as ingredients from pizza_types limit 5;

-- 4. Check for pizzas missing a price (IS NULL).
select pizza_id from pizzas where price is null;

-------------------------------------------------------------------------------------------------------------------

-- Phase 2: Filtering & Exploration
   -------
   
-- 1. Orders placed on '2015-01-01' (SELECT + WHERE).
select * from orders where date='2015-01-01';

-- 2. List pizzas with price descending.
select * from pizzas order by price desc;

-- 3. Pizzas sold in sizes 'L' or 'XL'.
select p.pizza_id,p.size,od.order_id from pizzas p inner join order_details od  on p.pizza_id=od.pizza_id where p.size in('L','XL');

-- 4. Pizzas priced between $15.00 and $17.00.
select * from pizzas where price between 15.00 and 17.00;

-- 5. Pizzas with "Chicken" in the name.
select name from pizza_types where name like '%Chicken%';

-- 6.Orders on '2015-02-15' or placed after 8 PM.
select * from orders where date='2015-02-15' or time>'20:00:00';

------------------------------------------------------------------------------------------------------

-- Phase 3: Sales Performance
   -------
   
-- 1. Total quantity of pizzas sold (SUM).
select sum(quantity) as total_quantity_sold from order_details;

-- 2. Average pizza price (AVG).
select round(avg(price),2) as avg_price from pizzas;

-- 3. Total order value per order (JOIN, SUM, GROUP BY).
select od.order_id,sum(od.quantity*p.price) as order_value from order_details od inner join pizzas p on od.pizza_id=p.pizza_id
group by od.order_id order by od.order_id;

-- 4. Total quantity sold per pizza category (JOIN, GROUP BY).
select pt.category,sum(od.quantity) as quantity_sold from pizza_types pt inner join pizzas p on pt.pizza_type_id=p.pizza_type_id
inner join order_details od on p.pizza_id=od.pizza_id
group by pt.category order by quantity_sold desc;

-- 5. Categories with more than 5,000 pizzas sold (HAVING).
select pt.category,sum(od.quantity) as quantity_sold from pizza_types pt inner join pizzas p on pt.pizza_type_id=p.pizza_type_id
inner join order_details od on p.pizza_id=od.pizza_id
group by pt.category having sum(od.quantity)>5000;

-- 6. Pizzas never ordered (LEFT/RIGHT JOIN).
select p.pizza_id,sum(od.quantity) as quantity_sold from pizzas p left join order_details od on p.pizza_id=od.pizza_id
group by p.pizza_id having sum(od.quantity) is null;

-- 7. Price differences between different sizes of the same pizza (SELF JOIN).
select 
p1.pizza_type_id,
p1.size as size_1,
p2.size as size_2,
p1.price as price_1,
p2.price as pricce_2,
abs(p1.price-p2.price) as price_difference
from pizzas p1  join pizzas p2 on p1.pizza_type_id=p2.pizza_type_id
where p1.size<p2.size
order by p1.pizza_type_id,price_difference desc;