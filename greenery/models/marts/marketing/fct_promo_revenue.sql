with order_item_agg as (
  select
    order_id,
    sum(num_items) as total_items
  from {{ ref('fct_order_items') }}
  group by 1
  ),

orders as (
  select * from {{ ref('stg_orders')}}
)

select
  orders.promo_name,
  sum(orders.order_cost) as total_promo_revenue,
  sum(order_item_agg.total_items) as total_promo_items
from orders
inner join order_item_agg
  on orders.order_id = order_item_agg.order_id
where orders.promo_name is not null
group by 1
