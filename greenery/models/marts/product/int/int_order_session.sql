with order_items as (select product_guid, 
    order_guid,
    quantity
  from {{ ref('stg_order_items') }}),
  
  sessions as (
    select session_guid, 
      order_guid, 
      product_guid,
      event_type
    from {{ ref('stg_events') }}
    where order_guid is not null) 

 select a.product_guid,
    a.order_guid,
    a.quantity,
    b.session_guid,
    case when b.event_type = 'checkout' then true else false end as checkout,
    case when b.event_type = 'package_shipped' then true else false end as package_shipped
  from order_items a
  left outer join sessions b
  on a.order_guid=b.order_guid
  and b.product_guid=b.product_guid