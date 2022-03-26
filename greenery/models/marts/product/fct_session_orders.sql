

with session_info as (select session_guid,
        event_guid, 
        product_guid,
        order_guid
from {{ ref('stg_events') }}), 

product_info as (
  select product_guid, 
    name,
    price,
    inventory
  from {{ ref('stg_products') }})
  
select a.session_guid, 
  a.event_guid,
  a.product_guid,
  a.order_guid, 
  b.name,
  b.price, 
  b.inventory
from session_info a
left outer join product_info b
on a.product_guid=b.product_guid