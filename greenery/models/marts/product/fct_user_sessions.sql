{{
  config(
    materialized='table'
  )
}}
with sessions as (
  select * from {{ ref('int_sessions_agg') }}
),

users as (
  select * from {{ ref('stg_users')}}
)
select
    s.user_id as user_id,
    count(sessions.session_id) as num_sessions
    avg(sessions.session_length) as avg_session_length,
    sum(sessions.num_page_views) as total_page_views,
    sum(sessions.num_cart_adds) as total_cart_adds,
    sum(sessions.num_checkouts) as total_checkouts 
from sessions
left join users
on s.user_id = users.user_id