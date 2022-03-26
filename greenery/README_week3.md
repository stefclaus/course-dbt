## Week 2 

### Part 1 Models 

*1a. What is our conversion rate?*

 **Answer:**
62.4%

Query:
```ruby
with conversion_rate as (
select count(distinct session_guid) as unique_session_count, 
  count(distinct order_guid) as unique_order_count
from dbt_stef_c.stg_events)

select cast(unique_order_count as decimal)/cast(unique_session_count as decimal) as solution
from conversion_rate 
```

*1b. What is our conversion rate by product?*

 **Answer:**


Query:
```ruby

```
