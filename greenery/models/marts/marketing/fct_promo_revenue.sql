  {{
  config(
    materialized='table'
  )
}}
  
  with order_item_agg as (
  select
    order_id,
    sum(num_items) as total_items
  from
    {{ ref('fct_order_items') }}
  group by 1
  )
  select
    o.promo_name,
    sum(o.order_cost) as total_promo_revenue,
    sum(i.total_items) as total_promo_items
  from
    {{ ref('fct_orders') }} o
  inner join
    order_item_agg i
  on
    o.order_id = i.order_id
  where
    o.promo_name is not null
  group by 1
