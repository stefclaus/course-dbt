
###Question: How many users do we have? 

##Query: select count(distinct(user_guid)) from dbt_stef_c.stg_users

##Answer: 130

###Question: On average, how many orders do we receive per hour?

 ##Query: with distinct_orders as (
  select count(distinct order_guid) as distinct_orders,
    extract(epoch from max(created_at_utc)-min(created_at_utc))/3600 as total_hours
  from dbt_stef_c.stg_orders)
  
  select distinct_orders/total_hours as orders_per_hour
  from distinct_orders

 ## Answers: 7.52

###Question: On average, how long does an order take from being placed to being delivered?

##Query:  with time_passed as (
  select 
    extract(epoch from (delivered_at_utc)-(created_at_utc))/3600 as elapsed_hours
    from dbt_stef_c.stg_orders)

  select  avg(elapsed_hours)
  from time_passed

##Answer: 93.4 hours

###Question: How many users have only made one purchase? Two purchases? Three+ purchases?

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

##Query:with order_count as(
  select count(*) order_guid,
    user_guid
from dbt_stef_c.stg_orders
group by user_guid)

select order_guid,
  count(*) user_guid 
from order_count
group by order_guid
order by 1

##Answer:
1 25
2 28
3+ 71

###Question: On average, how many unique sessions do we have per hour?

##Query: 

with sessions as 
  (select count(distinct session_id) as distinct_sessions,
      date_trunc('hour', created_at) AS hour_created_at
  from dbt_stef_c.stg_events
  group by 2)

select avg(distinct_sessions)
from sessions


##Answer: 16.3
