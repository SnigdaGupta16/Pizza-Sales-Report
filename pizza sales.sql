use pizza_sales;
SELECT 
    *  
FROM
    pizza_sales;
describe pizza_sales;
SELECT 
    order_date, order_time
FROM
    pizza_sales;
-- converting date and column from text to date and time format respectively
UPDATE pizza_sales 
SET 
    order_date = STR_TO_DATE(order_date, '%d-%m-%Y');
alter table pizza_sales modify order_date date;
alter table pizza_sales modify order_time time;

-- total revenue
SELECT 
    SUM(total_price) AS total_revenue
FROM
    pizza_sales;

-- avg order values
SELECT 
    ROUND((SUM(total_price) / COUNT(DISTINCT (order_id))),
            2) AS avg_order_value
FROM
    pizza_sales;

-- total pizzas sold
SELECT 
    SUM(quantity) AS total_pizzas_sold
FROM
    pizza_sales;

-- total_order_placed
SELECT 
    COUNT(DISTINCT (order_id)) AS total_orders
FROM
    pizza_sales;

-- avg pizzas per order
SELECT 
    ROUND(SUM(quantity) / COUNT(DISTINCT (order_id)),
            2) AS avg_pizza_per_order
FROM
    pizza_sales;

-- hourly trend for total pizzas sold
SELECT 
    HOUR(order_time) AS order_hour, SUM(quantity)
FROM
    pizza_sales
GROUP BY order_hour
ORDER BY order_hour;

-- weekly trend for total pizzas sold
SELECT 
    YEAR(order_date) AS order_year,
    WEEK(order_date) AS week_number,
    COUNT(DISTINCT (order_id)) AS total_orders
FROM
    pizza_sales
GROUP BY week_number , order_year
ORDER BY week_number , order_year;

-- percentage of sales by pizza category
SELECT DISTINCT
    (pizza_category)
FROM
    pizza_sales;
SELECT 
    SUM(quantity)
FROM
    pizza_sales;
    
SELECT 
    pizza_category, SUM(total_price), 
    ROUND((SUM(total_price) / (SELECT 
                    SUM(total_price)
                FROM
                    pizza_sales)) * 100,
            2) AS percentage_sales
FROM
    pizza_sales
GROUP BY pizza_category;

SELECT 
    pizza_category, SUM(total_price), 
    ROUND((SUM(total_price) / (SELECT 
                    SUM(total_price)
                FROM
                    pizza_sales
                WHERE
                    MONTH(order_date) = 1)) * 100,
            2) AS percentage_sales
FROM
    pizza_sales
WHERE
    MONTH(order_date) = 1
GROUP BY pizza_category;

-- percentage of sales by pizza category

SELECT 
    pizza_size, round(SUM(total_price),2) as total_sales,  
    round((SUM(total_price) / (SELECT 
                    SUM(total_price)
                FROM
                    pizza_sales where quarter(order_date)=1
                )) * 100,2) AS percentage_sales
FROM
    pizza_sales
    where quarter(order_date)=1
GROUP BY pizza_size;

-- pizzas sold by category
SELECT 
    pizza_category, SUM(quantity) AS pizzas_sold
FROM
    pizza_sales
GROUP BY pizza_category
ORDER BY pizza_category;

-- top 5 bestsellers- rev, qty, orders
SELECT 
    pizza_name, SUM(total_price) AS total_revenue
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 5;

SELECT 
    pizza_name, SUM(quantity) AS total_pizzas
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas desc
LIMIT 5;

SELECT 
    pizza_name, count(order_id) AS total_orders
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC
LIMIT 5;

-- bottom 5 bestsellers- rev, qty, orders
SELECT 
    pizza_name, SUM(total_price) AS total_revenue
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue asc
LIMIT 5;

SELECT 
    pizza_name, SUM(quantity) AS total_pizzas
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas asc
LIMIT 5;

SELECT 
    pizza_name, count(order_id) AS total_orders
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY total_orders asc
LIMIT 5;