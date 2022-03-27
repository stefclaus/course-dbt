select 
{{ event_type }}
from {{ ref('stg_events') }}