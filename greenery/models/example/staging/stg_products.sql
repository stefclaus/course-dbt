{{
  config(
    materialized='table'
  )
}}

SELECT 
    product_id,
    name,
    price::numeric AS price,
    inventory
FROM {{ source('tutorial', 'products') }}