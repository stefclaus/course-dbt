with orders as (
    select * from {{ ref('stg_orders') }}
),

addresses as (
    select * from {{ ref('stg_addresses')}}
)

select
    orders.order_id as order_id,
    orders.promo_name as promo_name,
    orders.created_at as created_at,
    orders.order_cost as order_cost,
    orders.shipping_cost as shipping_cost,
    orders.total_cost as total_cost,
    orders.tracking_id as tracking_id,
    orders.shipping_service as shipping_service,
    orders.estimated_delivery_at as estimated_delivery_at,
    orders.delivered_at as delivered_at,
    orders.order_status,
    date_part('day',orders.delivered_at - orders.created_at) as days_to_deliver,
    case when orders.order_status = 'delivered' and orders.delivered_at <= orders.estimated_delivery_at then true else false end as ontime_delivery,
    addresses.postal_code as delivery_postal_code,
    addresses.state as delivery_state,
    addresses.country as delivery_country
from orders
left join addresses
  on orders.address_id = addresses.address_id
