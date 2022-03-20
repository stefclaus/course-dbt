select *
from {{ ref('stg_users') }}
where updated_at_utc < created_at_utc