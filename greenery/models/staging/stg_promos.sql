{{
  config(
    materialized='table'
  )
}}

SELECT 
    promo_id::varchar AS promo_name,
    discount::numeric AS discount,
    status
FROM {{ source('postgres', 'promos') }}