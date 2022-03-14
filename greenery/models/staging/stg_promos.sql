{{
  config(
    materialized='view'
  )
}}

with source as (
    
    select * from {{ source('postgres', 'promos') }}
    
),

cleaned as (
    
    select
      promo_id::varchar AS promo_name,
      discount::numeric AS discount,
      status
    from source

)

select * from cleaned