{{
  config(
    materialized='table'
  )
}}

SELECT 
    order_id,
    user_id,
    promo_id,
    address_id,
    created_at,
    order_cost::numeric AS order_cost,
    shipping_cost::numeric AS shipping_cost,
    order_total::numeric AS order_total,
    tracking_id,
    shipping_service,
    estimated_delivery_at,
    delivered_at,
    status AS order_status
FROM {{ source('tutorial', 'orders') }}