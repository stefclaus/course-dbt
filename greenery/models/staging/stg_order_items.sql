{{
  config(
    materialized='view'
  )
}}

with source as (
    
    select * from {{ source('postgres', 'order_items') }}
    
),

cleaned as (
    
    select
      order_id,
      product_id,
      quantity AS num_items
    from source

)

select * from cleaned