{{
  config(
    materialized='table'
  )
}}

select
  i.order_id as order_id,
  o.created_at as created_at,
  i.product_id as product_id,
  p.product_name as product_name,
  sum(i.num_items) as num_items
from {{ ref('stg_orders') }} o
left join {{ ref('stg_order_items') }} i
  on o.order_id = i.order_id
left join {{ ref('stg_products') }} p
  on i.product_id = p.product_id
group by 1,2,3,4