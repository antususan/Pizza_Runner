-- 1.How many pizzas were ordered?

USE pizza_runner;
Select COUNT(order_id) AS Total_pizza_ordered 
FROM customer_orders ;

Answer :

# Total_pizza_ordered
14

-- 2.How many unique customer orders were made?

SELECT   customer_id ,COUNT( DISTINCT order_id) AS unique_customer_order
FROM customer_orders
group by customer_id;

Answer :

# customer_id	unique_customer_order
101	3
102	2
103	2
104	2
105	1

-- 3. How many successful orders were delivered by each runner?

SELECT runner_id,COUNT(order_id) as sucessful_orders 
FROM runner_orders 
WHERE cancellation IS NULL
GROUP BY runner_id;

Answer :

# runner_id	sucessful_orders
1	4
2	3
3	1


-- 4. How many of each type of pizza was delivered?

SELECT pn.pizza_name, Count( co.pizza_id)AS Total_pizaa_delivered
from customer_orders AS co 
JOIN runner_orders AS ro
ON co.order_id =ro.order_id
JOIN pizza_names AS pn
ON pn.pizza_id =co.pizza_id
Where cancellation IS NULL
GROUP BY pn.pizza_name ;

Answer :

# pizza_name	Total_pizaa_delivered
Meatlovers	9
Vegetarian	3


-- 5 How many Vegetarian and Meatlovers were ordered by each customer?
SELECT co.customer_id,pn.pizza_name,count(pn.pizza_name) AS num_of_Piza
from customer_orders AS co
JOIN pizza_names AS pn
ON co.pizza_id =pn.pizza_id
GROUP BY co.customer_id,pn.pizza_name
ORDER BY co.customer_id;

Answer :

# customer_id	pizza_name	num_of_Piza
101	Meatlovers	2
101	Vegetarian	1
102	Meatlovers	2
102	Vegetarian	1
103	Meatlovers	3
103	Vegetarian	1
104	Meatlovers	3
105	Vegetarian	1


-- 6. What was the maximum number of pizzas delivered in a single order?

WITH Max_Piza_count AS
(
SELECT co.order_id,  COUNT(co.pizza_id) as pizza_count
FROM customer_orders AS co
JOIN runner_orders AS ro
ON co.order_id =ro.order_id
WHERE cancellation IS NULL 
GROUP BY co.order_id
)
SELECT MAX(pizza_count) AS Pizza_cout FROM Max_Piza_count;

Answer :

# Pizza_cout
3


-- 7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

SELECT co.customer_id,
SUM(case 
when co.exclusions IS NULL AND co.extras IS NULL THEN 1
ELSE 0
end )AS no_change,
SUM(case 
when co.exclusions  IS NOT NULL or co.extras IS NOT NULL THEN 1
ELSE 0
end) AS at_least_1_change
FROM customer_orders AS co
JOIN runner_orders AS ro
ON co.order_id =ro.order_id
where ro.cancellation IS NULL 
GROUP BY co.customer_id 
 ;
 
 Answer :
 
 # customer_id	no_change	at_least_1_change
101	2	0
102	3	0
103	0	3
104	1	2
105	0	1

 
 
 -- 8.How many pizzas were delivered that had both exclusions and extras?
WITH pizza_count AS
(
SELECT customer_id, COUNT(pizza_id) AS Pizz_both_exlusion_extras
FROM customer_orders AS co
JOIN runner_orders AS ro
ON co.order_id =ro.order_id
WHERE (exclusions AND extras IS NOT NULL) AND cancellation IS NULL
GROUP BY customer_id)

Select Pizz_both_exlusion_extras from pizza_count;

Answer:
# Pizz_both_exlusion_extras
1

 
 -- 9.What was the total volume of pizzas ordered for each hour of the day?
 
 SELECT HOUR(order_time)AS hour_of_day,COUNT(order_id) AS num_pizza
 FROM customer_orders
 GROUP BY hour_of_day 
 order by hour_of_day ASC;
 
 Answer: 
 # hour_of_day	num_pizza
11	1
13	3
18	3
19	1
21	3
23	3


-- 10.What was the volume of orders for each day of the week? 
 
SELECT DAYNAME(order_time)AS day_of_week,COUNT(order_id) AS num_pizza
FROM customer_orders
GROUP BY day_of_week
;

Answer: 

# day_of_week	num_pizza
Wednesday	5
Thursday	3
Saturday	5
Friday	1

