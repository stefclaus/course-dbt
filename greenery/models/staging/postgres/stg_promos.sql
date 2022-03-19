with stg_promos as (
    select 
        promo_id as promo_guid,
        discount,
        status
FROM {{ source('greenery', 'promos') }})

select * 
from stg_promos


