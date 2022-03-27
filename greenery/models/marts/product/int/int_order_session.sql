with sessions as (
    select session_guid, 
      order_guid, 
      event_type
    from {{ ref('stg_events') }}
    where order_guid is not null),

order_items as (
  select product_guid, 
    order_guid,
    quantity
  from {{ ref('stg_order_items') }})
  
 select a.session_guid,
    a.order_guid,
    case when a.event_type = 'checkout' then true else false end as checkout,
    case when a.event_type = 'package_shipped' then true else false end as package_shipped,
    b.product_guid
  from sessions a
  inner join order_items b
  on a.order_guid=b.order_guid


