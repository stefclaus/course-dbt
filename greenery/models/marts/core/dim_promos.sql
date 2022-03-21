{{
  config(
    materialized='table'
  )
}}

select
    p.promo_name as promo_name,
    p.discount as discount,
    p.status as status
from {{ ref('stg_promos') }} p
