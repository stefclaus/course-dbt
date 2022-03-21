{{
  config(
    materialized='table'
  )
}}

select
    p.product_id as product_id,
    p.product_name as product_name,
    p.price as price,
    p.inventory as inventory
from {{ ref('stg_products') }} p
