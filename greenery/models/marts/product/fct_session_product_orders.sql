with order_session as(
  select session_guid, 
    order_guid,
    quantity, 
    checkout,
    package_shipped
  from {{ ref('int_order_session') }}
  where checkout=true),
  
product_session as (
  select session_guid, 
    name, 
    add_to_cart,
    page_view
  from {{ ref('int_product_session') }})
    
select  b.name,
  a.session_guid, 
  a.order_guid, 
  a.quantity,
  a.checkout,
  a.package_shipped,
  b.add_to_cart,
  b.page_view
from order_session a
left outer join product_session b
on a.session_guid=b.session_guid


  