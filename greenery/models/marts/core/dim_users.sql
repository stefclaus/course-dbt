with users as (
    select * from {{ ref('stg_users') }}
),

addresses as (
    select * from {{ ref('stg_addresses') }}
),

user_orders as (
    select user_id, COUNT(order_id) AS num_purchases from {{ ref('stg_orders') }} group by 1
)

select
    users.user_id,
    users.first_name||' '||users.last_name as user_name,
    users.email,
    users.phone_number,
    users.created_at,
    users.updated_at,
    addresses.address as street,
    addresses.postal_code as postal_code,
    addresses.state as state,
    addresses.country as country,
    date_part('day',current_timestamp - users.created_at::timestamp) as days_since_join,
    case when user_orders.num_purchases > 0 then true else false end as has_purchased
from users
left join addresses
  on users.address_id = addresses.address_id
left join user_orders
  on users.user_id = user_orders.user_id
