{{
  config(
    materialized='table'
  )
}}

with stg_products as (
    select 
        product_id as product_guid,
        name,
        price,
        inventory
FROM {{ source('greenery', 'products') }})

select * 
from stg_products 


