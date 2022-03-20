{{
  config(
    materialized='table'
  )
}}

with stg_order_items as (
    select 
    order_id as order_guid,
    product_id as product_guid,
    quantity
FROM {{ source('greenery', 'order_items') }})

select * from stg_order_items


