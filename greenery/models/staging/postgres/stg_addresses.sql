{{
  config(
    materialized='table'
  )
}}

with stg_addresses as (
    select 
     address_id as address_guid,
    address, 
    zipcode,
    state, 
    country
from {{ source('greenery', 'addresses') }}
)

select * 
from stg_addresses