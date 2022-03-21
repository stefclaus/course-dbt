{{
  config(
    materialized='table'
  )
}}

select
    s.user_id as user_id,
    u.user_name as user_name,
    u.email as email,
    s.session_id as session_id,
    s.session_start as session_start,
    s.session_end as session_end,
    s.session_length as session_length,
    s.num_page_views,
    s.num_cart_adds,
    s.num_checkouts
from {{ ref('int_sessions_agg') }} s
left join {{ ref('dim_users')}} u
on s.user_id = u.user_id