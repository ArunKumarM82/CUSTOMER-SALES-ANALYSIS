use[Pizza DB]

--fetech whole table 
select * from pizza_sales

--KPI's

--total revenue of pizza sales
select sum(total_price) as 'Total Revenue' from pizza_sales;

--the average amount spent per order 
select sum(total_price)/count(distinct order_id) as 'Average Order Value' from pizza_sales;

--the sum of the quantities of all pizzas sold
select sum(quantity) as 'Total Pizzas Sold' from pizza_sales

--total number of orders placed
select count(distinct order_id) as 'Total Orders' from pizza_sales;

--the average number of pizzas sold per order
select round(cast(sum(quantity) as float)/cast(count(distinct order_id)as float),2) as 'Average Pizzas Per Order' from pizza_sales;


--CHARTS

--daily trend
select datename(dw,order_date) as 'Order Day', count(distinct order_id) as 'Total Orders' from pizza_sales group by datename(dw,order_date) ;

--hourly trend
select datepart(HH,order_time)as 'Order Hours', count(distinct order_id) as 'Total Orders' from pizza_sales group by datepart(HH,order_time) order by 'Order Hours' ;
 
--Percentage of sales by pizza category
-- filer via months
 select pizza_category,sum(total_price) as 'Total Sales', sum(total_price)*100 /(select sum(total_price) from pizza_sales  where month(order_date) =1) as 'Percentage of Total Sales' from pizza_sales 
 where month(order_date) =1
 group by pizza_category;

 -- filer via quarter
 select pizza_category,sum(total_price) as 'Total Sales', sum(total_price)*100 /(select sum(total_price) from pizza_sales  where datepart(q,order_date) = 2) as 'Percentage of Total Sales' from pizza_sales 
 where datepart(q,order_date) =2
 group by pizza_category;


--Percentage of sales by pizza size
-- filer via months
 select pizza_size,sum(total_price) as 'Total Sales', sum(total_price)*100 /(select sum(total_price) from pizza_sales  where month(order_date) =1) as 'Percentage of Total Sales' from pizza_sales
 where month(order_date) =1
 group by pizza_size 
 order by 'Percentage of Total Sales' desc ;

-- filer via quarter
 select pizza_size,sum(total_price) as 'Total Sales', sum(total_price)*100 /(select sum(total_price) from pizza_sales  where datepart(q,order_date) =1) as 'Percentage of Total Sales' from pizza_sales
 where datepart(q,order_date) =1
 group by pizza_size 
 order by 'Percentage of Total Sales' desc ;

--Total pizzas sold by pizza category
select pizza_category, sum(quantity) as  'Total Pizzas Sold' from pizza_sales
group by pizza_category;

--Top 5 best sellers by total pizzas sold 
select top 5 pizza_name, sum(quantity) as  'Total Pizzas Sold' from pizza_sales
group by pizza_name
order by 'Total Pizzas Sold' desc;

--Top 5 best sellers by total pizzas sold 
select top 5 pizza_name, sum(quantity) as  'Total Pizzas Sold' from pizza_sales
group by pizza_name
order by 'Total Pizzas Sold' asc;