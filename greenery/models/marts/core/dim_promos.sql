with promos as (
    select * from {{ ref('stg_promos') }}
)

select
    promo_name,
    discount,
    status
from promos
