{{
  config(
    materialized='table'
  )
}}

select
    e.session_id as session_id,
    e.user_id as user_id,
    min(e.created_at) as session_start,
    max(e.created_at) as session_end,
    age(max(e.created_at),min(e.created_at)) as session_length,
    sum(case when e.event_type = 'page_view' then 1 else 0 end) as num_page_views,
    sum(case when e.event_type = 'add_to_cart' then 1 else 0 end) as num_cart_adds,
    sum(case when e.event_type = 'checkout' then 1 else 0 end) as num_checkouts
from {{ ref('stg_events') }} e
group by 1,2