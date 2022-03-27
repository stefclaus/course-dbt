with events as (
    select session_guid, 
        order_guid 
    from {{ ref('stg_events') }}
),

order_items as (
    select product_guid,
        order_guid
    from {{ ref('stg_order_items') }}
)

select
    b.product_guid,
    cast(count(distinct a.session_guid) as numeric) as total_purchases
from 
    events as a
left join 
    order_items as b
on a.order_guid = b.order_guid
where 
    a.order_guid is not null
group by b.product_guid