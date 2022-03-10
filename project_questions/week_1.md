# Answer these questions using the data available using SQL queries. You should query the dbt generated tables you have created. For these short answer questions/queries create a separate readme file in your repo with your answers.
## How many users do we have?
Can count the number of records in the `users` tables:
```
select count(*), count(distinct user_id) FROM users
```
Returns 130 for both. Confirms that `user_id` is unique and that Greenery has 130 users.

## On average, how many orders do we receive per hour?
In order to calculate average number of orders per hour, we need to write a query that returns the total number of queries per hour. Before doing that we need to make sure we have at least one sale per hour. Why? Because if we don't then we'd be missing 0's and overstating the average. 
```
select min(date_trunc('hour',created_at)) as first_sale, max(date_trunc('hour',created_at)) as last_sale, count(distinct(date_trunc('hour',created_at))) as sale_hours FROM orders 
```
This shows that the first order is in the first hour of Feb 10 2021, the last order is in the last hour of Feb 11 2021. So there is sales data for 2 days. If we have a sale for every hour we'd see 48 (24 * 2) unique rows, which we do. So we can move forward without having to impute rows.  
```
with orders_per_hour as (
select
  date_trunc('hour',created_at) as order_hour,
  COUNT(order_id) as num_orders
from orders
group by 1
)
select 
  avg(num_orders)
from orders_per_hour
```
Returns 7.5208333333333333 orders per hour when an order is placed. So on average, there are 7 sales per hour.

> In a case where you don't have sales for every hour, there's another way to calculate this. You can find the total # of orders and the total # of hours between the earliest and latest sale and then divide the two. 

## On average, how long does an order take from being placed to being delivered?
Here we can use the `orders` table again, but should only include cases where an order has been delivered. 
```
with order_delivery_time AS (
select
  order_id,
  age(date(delivered_at),date(created_at)) AS delivery_time
from
  orders
where delivered_at IS NOT NULL
)
select avg(delivery_time) as avg_delivery_time from order_delivery_time
```
This returns an average delivery time of 3 days 21:24:11.803279, which translates to delivery taking on average 4 days. 
## How many users have only made one purchase? Two purchases? Three+ purchases?
Since this is about orders and not items, we can continue to use the orders table. We will assume it does not matter whether the order has been delivered. So we want to find out the number of orders per user and then group by the number of purchases. 
```
with orders_per_user as (
select 
  user_id,
  count(order_id) as num_orders 
from 
  orders 
group by 1
)
select case when num_orders = 1 then '1' when num_orders = 2 then '2' else '3+' end as num_orders, COUNT(user_id) from orders_per_user 
group by 1 order by 1
```
This tells us that 25 users have made 1 order, 28 have made 2 orders, and 71 orders have made 3 or more. 
## On average, how many unique sessions do we have per hour?
Here we are going to build something similar to the second question, with two differences: first we will be using the events table and second we will have to count uniques to avoid double counting a session . We can do the same check. This is probably the type of aggregate that would be abstracted out.
```
select min(date_trunc('hour',created_at)) as first_event, max(date_trunc('hour',created_at)) as last_event, count(distinct(date_trunc('hour',created_at))) as event_hours FROM events 
```
Here we can see that the first event was at 11 PM on Feb 9 2021 and the last was at 8 AM on Feb 12 2021. That's 2 + 24 +24 + 8 = 58 hours, which equals the total event hours. So we can use the same solution as above. 
```
with sessions_per_hour as (
select
  date_trunc('hour',created_at) as order_hour,
  count(distinct session_id) as num_sessions
from events
group by 1
)
select 
  avg(num_sessions)
from sessions_per_hour
```
This returns 16.3275862068965517 so we average ~16 sessions per hour. There is probably some more research to be done to better understand sessions and how they are defined. Looking at the data a session can last for _hours_. 