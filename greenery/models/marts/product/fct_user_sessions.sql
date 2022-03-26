with sessions as (
  select * from {{ ref('int_sessions_agg') }}
),

users as (
  select * from {{ ref('stg_users')}}
)

select
    sessions.user_id as user_id,
    min(sessions.session_start) as first_visit,
    max(sessions.session_end) as last_vist,
    date_part('day',current_timestamp - max(sessions.session_end)) as days_since_last_session,
    count(sessions.session_id) as num_sessions,
    avg(sessions.session_length) as avg_session_length,
    sum(sessions.num_page_views) as total_page_views,
    sum(sessions.num_cart_adds) as total_cart_adds,
    sum(sessions.num_checkouts) as total_checkouts 
from sessions
left join users
  on sessions.user_id = users.user_id
group by 1