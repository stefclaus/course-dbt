with users as (
    select * from {{ ref('dim_users') }}
),

orders as (
    select * from {{ ref('fct_orders')}}
)

select
    users.user_id,
    count(order_id) as num_orders,
    count(case when order_status = 'delivered' then order_id else null end) as num_orders_fulfilled,
    count(case when order_status != 'delivered' then order_id else null end) as num_orders_pending,
    count(case when is_promo_purchase is true then order_id else null end) as num_promo_orders,
    min(order_date) as first_order_date,
    max(order_date) as last_order_date,
    date_part('day',min(order_date)-max(users.created_at::timestamp)) as days_to_first_order,
    date_part('day',current_timestamp - max(order_date)::timestamp) as days_since_last_order
from users
left join orders
on users.user_id = orders.user_id
group by 1