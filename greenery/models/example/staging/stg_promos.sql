{{
  config(
    materialized='table'
  )
}}

SELECT 
    promo_id AS promo_name,
    discount::numeric AS discount,
    status
FROM {{ source('tutorial', 'promos') }}