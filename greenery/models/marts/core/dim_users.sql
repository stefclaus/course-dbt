{{
  config(
    materialized='table'
  )
}}

with stg_users as (
    select * from {{ ref('stg_users') }}
)

select a.user_guid,
    a.first_name,
    a.last_name,
    a.email,
    a.phone_number,
    a.created_at_utc,
    a.updated_at_utc,
    a.address_guid,
    b.address,
    b.zipcode,
    b.state,
    b.country
from stg_users a
left join {{ ref('stg_addresses') }} b
    on a.address_guid=b.address_guid