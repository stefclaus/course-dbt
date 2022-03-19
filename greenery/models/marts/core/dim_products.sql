with stg_products as (
    select * from {{ ref('stg_products') }}
)

select a.product_guid,
    a.name,
    a.price,
    a.inventory,
    b.order_guid,
    b.quantity
from stg_products a
left join {{ ref('stg_order_items') }} b
    on a.product_guid=b.product_guid