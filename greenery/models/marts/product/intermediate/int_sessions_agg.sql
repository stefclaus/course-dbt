with events as (
  select * from {{ ref('stg_events') }}
)
select
    session_id as session_id,
    user_id as user_id,
    min(created_at) as session_start,
    max(created_at) as session_end,
    age(max(created_at),min(created_at)) as session_length,
    sum(case when event_type = 'page_view' then 1 else 0 end) as num_page_views,
    sum(case when event_type = 'add_to_cart' then 1 else 0 end) as num_cart_adds,
    sum(case when event_type = 'checkout' then 1 else 0 end) as num_checkouts
from events
group by 1,2