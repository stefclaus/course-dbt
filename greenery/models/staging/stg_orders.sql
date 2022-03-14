{{
  config(
    materialized='view'
  )
}}

with source as (
    
    select * from {{ source('postgres', 'orders') }}
    
),

cleaned as (
    
    select
      order_id,
      user_id,
      lower(promo_id::varchar) AS promo_name,
      address_id,
      created_at,
      order_cost::numeric AS order_cost,
      shipping_cost::numeric AS shipping_cost,
      order_total::numeric AS total_cost,
      tracking_id,
      shipping_service,
      estimated_delivery_at,
      delivered_at,
      status AS order_status
    from source

)

select * from cleaned