# Analytics engineering with dbt

Template repository for the projects and environment of the course: Analytics engineering with dbt

> Please note that this sets some environment variables so if you create some new terminals please load them again.

## License

Apache 2.0

Question: How many users do we have? 

Query: select count(distinct(user_guid)) from dbt_stef_c.stg_users

Answer: 130

Question: On average, how many orders do we receive per hour?



Question: On average, how long does an order take from being placed to being delivered?

Question: How many users have only made one purchase? Two purchases? Three+ purchases?

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

Question: On average, how many unique sessions do we have per hour?