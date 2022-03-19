with stg_orders as (
    select * from {{ ref('stg_orders') }}
)

select a.order_guid,
    a.user_guid,
    a.promo_guid,
    a.address_guid,
    a.created_at_utc,
    a.order_cost,
    a.shipping_cost,
    a.order_total,
    a.tracking_guid,
    a.shipping_service,
    a.estimated_delievery_at_utc,
    a.delivered_at_utc,
    a.status,
    b.product_guid,
    b.quantity
from stg_orders a
left join {{ ref('stg_order_items') }} b
    on a.order_guid=b.order_guid