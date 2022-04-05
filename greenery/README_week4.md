## Week 4

### Part 1 Models 

*1a. How are our users moving through the funnel?*

 **Answer:**
| page_view_present | add_to_cart_present |checkout_present | package_shipped_present |
| 578 | 467 |361 | 335 |

Query:
```ruby
select
  sum(case when page_view_present=1 then 1 else 0 end) as page_view_present,
  sum(case when add_to_cart_present=1 then 1 else 0 end) as add_to_cart_present,
  sum(case when checkout_present=1 then 1 else 0 end) as checkout_present,
  sum(case when package_shipped_present=1 then 1 else 0 end) as package_shipped_present
from dbt_stef_c.int_sessions_per_event_type
```

*1b. What are our largest dropoff points?*
I see the biggest dropoff as being from cart to checkout. If this were real life I'd take a look really carefully at these numbers, because they seem almost too good to be true, esp the page to cart dropoff! 

 **Answer:**
| page_to_cart_dropoff | cart_to_checkout_dropoff |checkout_to_ship_dropoff|
| 80.79% | 77.30% |92.79% |

Query:
```ruby
with raw_numbers as (select
  sum(case when page_view_present=1 then 1 else 0 end) as page_view_present,
  sum(case when add_to_cart_present=1 then 1 else 0 end) as add_to_cart_present,
  sum(case when checkout_present=1 then 1 else 0 end) as checkout_present,
  sum(case when package_shipped_present=1 then 1 else 0 end) as package_shipped_present
from dbt_stef_c.int_sessions_per_event_type)

select cast(add_to_cart_present as decimal)/cast(page_view_present as decimal) as page_to_cart_dropoff,
  cast(checkout_present as decimal)/cast(add_to_cart_present as decimal) as cart_to_checkout_dropoff,
  cast(package_shipped_present as decimal)/cast(checkout_present as decimal) as checkout_to_ship_dropoff
from raw_numbers
```

*2. If your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course?*

I see two big areas for improvement: the organization of our folders and using macros. 

Currently, I just house everything in one folder called staging. It's already confusing with the number of queries that we need to run, and isn't well set up to scale. I'm excited to divide everything into marts and then also divide by data source. 

Also excited to implement macros. Some of our models pull in event names, and as events get added I've been adding them by hand. Using a macro developed in this class, I think I could pretty easily make that process fully automated--which truly blows my mind. So much time on repetitive work saved!

*3. After learning about the various options for dbt deployment and seeing your final dbt project, how would you go about setting up a production/scheduled dbt run of your project in an ideal state? *

At work, we use dbt cloud. It's fairly low cost and works beautifully. It was great to hear about other options that have been succesfully implemented in the lecture--like Dagster--but given that this project doesn't run anything besides dbt, I'd advocate to stick with cloud. 
