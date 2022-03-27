with product_interaction_agg as (
  select 
    product_guid,
    count(case when page_view = true then session_guid else null end) as product_sessions,
    count(case when add_to_cart = true then session_guid else null end) as product_adds
  from {{ ref('int_product_session') }}
  group by product_guid
),

product_order_agg as (
  select 
    product_guid,
    count(order_guid) as product_orders,
    count(distinct order_guid) as product_count
    from {{ ref('int_order_session') }}
  group by product_guid
),

product as (
select * from {{ ref('stg_products') }}
)


select product.product_guid,
  product.name,
  coalesce(product_interaction_agg.product_sessions,0) as product_sessions,
  coalesce(product_interaction_agg.product_adds,0) as product_adds
from product
left join product_interaction_agg
  on product.product_guid = product_interaction_agg.product_guid
left join product_order_agg
  on product.product_guid = product_order_agg.product_guid