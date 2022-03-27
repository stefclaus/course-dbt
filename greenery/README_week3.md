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
| Name | Conversion Rate |
| --- | ----------- |
| Alocasia Polly |	0.5 |
| Aloe Vera |	0.5538461538 |
| Angel Wings Begonia	 |0.5161290323 |
| Arrow Head |	0.609375 |
| Bamboo |	0.6086956522 |
| Bird of Paradise |	0.55 |
| Birds Nest Fern |	0.5 |
| Boston Fern |	0.5396825397 |
| Cactus|	0.5818181818 |
| Calathea Makoyana |	0.6037735849 |
| Devil's Ivy	| 0.5333333333 |
| Dragon Tree	| 0.5483870968 |
| Ficus	| 0.5147058824 |
| Fiddle Leaf Fig |	0.5084745763 |
| Jade Plant |	0.5217391304 |
| Majesty Palm |	0.5507246377 |
| Money Tree |	0.4642857143 |
| Monstera |	0.5306122449 |
| Orchid |	0.4933333333 |
| Peace Lily |	0.5223880597 |
| Philodendron |	0.5079365079 |
| Pilea Peperomioides |	0.5333333333 |
| Pink Anthurium |	0.5 |
| Ponytail Palm	| 0.4225352113 |
| Pothos |	0.375 |
| Rubber Plant |	0.5714285714 |
| Snake Plant |	0.4657534247 |
| Spider Plant |	0.5084745763 |
| String of pearls |	0.6769230769 |
| ZZ Plant |	0.5384615385 |

Query:
```ruby

```
