{{
  config(
    materialized='table'
  )
}}

select
    u.user_id,
    u.first_name||' '||u.last_name as user_name,
    u.email,
    u.phone_number,
    u.created_at,
    u.updated_at,
    a.address as street,
    a.postal_code as postal_code,
    a.state as state,
    a.country as country,
    date_part('day',current_timestamp - u.created_at::timestamp) as days_since_join
from {{ ref('stg_users') }} u
left join {{ ref('stg_addresses') }} a
  on u.address_id = a.address_id
