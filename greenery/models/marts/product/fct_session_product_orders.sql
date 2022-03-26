


  with order_items as (select product_guid, 
    order_guid,
    quantity
  from {{ ref('stg_order_items') }}),
  
  sessions as (
    select session_guid, 
      order_guid
    from {{ ref('stg_events') }}),
    
product_order as (
    select a.product_guid,
    a.order_guid,
    a.quantity,
    b.session_guid
  from order_items a
  left outer join sessions b
  on a.order_guid=b.order_guid)
  
  select a.product_guid,
    a.order_guid,
    a.quantity,
    a.session_guid,
    b.name
  from product_order a
  left outer join {{ ref('stg_products') }} b
  on a.product_guid=b.product_guid