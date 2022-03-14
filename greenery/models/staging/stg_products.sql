{{
  config(
    materialized='view'
  )
}}

with source as (
    
    select * from {{ source('postgres', 'products') }}
    
),

cleaned as (
    
    select 
      product_id,
      name AS product_name,
      price::numeric AS price,
      inventory
    from source

)

select * from cleaned