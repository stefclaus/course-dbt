select 
    product_guid, 
    count(distinct session_guid) as page_views
from {{ ref('stg_events') }}
where event_type = 'page_view'
group by product_guid