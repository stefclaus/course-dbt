select 
    session_guid,
    {{ event_types() }}
from {{ ref('stg_events') }}
group by 1