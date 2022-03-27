
with sessions as (select session_guid, 
      product_guid, 
      event_type
    from {{ ref('stg_events') }}),
    
  products as (
    select product_guid,
      name,
      price, 
      inventory 
    from {{ ref('stg_products') }}
  )  
  
  select a.session_guid,
    a.product_guid,
    case when a.event_type = 'checkout' then true else false end as checkout,
    case when a.event_type = 'package_shipped' then true else false end as package_shipped,
    case when a.event_type = 'add_to_cart' then true else false end as add_to_cart,
    case when a.event_type = 'page_view' then true else false end as page_view,
    b.name,
    b.price,
    b.inventory
  from sessions a
  left join products b
  on a.product_guid=b.product_guid


   