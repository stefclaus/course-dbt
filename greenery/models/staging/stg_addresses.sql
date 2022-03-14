{{
  config(
    materialized='view'
  )
}}

with source as (
    
    select * from {{ source('postgres', 'addresses') }}
    
),

cleaned as (
    
    select
        address_id,
        address,
        CASE WHEN country = 'United States' AND length(zipcode::varchar) = 4 THEN lpad(zipcode::varchar,5,'0') ELSE zipcode::varchar END AS postal_code,
        state,
        country
    from source

)

select * from cleaned
