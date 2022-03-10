{{
  config(
    materialized='table'
  )
}}

SELECT 
    product_id,
    name AS product_name,
    price::numeric AS price,
    inventory
FROM {{ source('tutorial', 'products') }}