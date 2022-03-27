with purchases as (
  select product_guid,
    total_purchases
  from {{ ref('int_purchases') }}
),

page_views as( 
  select product_guid,
    page_views
  from {{ ref('int_page_views') }}
)

select   c.name,
  a.page_views,
  b.total_purchases,
  cast(b.total_purchases as decimal)/cast(a.page_views as decimal) as conversion_rate 
from page_views a 
left outer join purchases b 
on a.product_guid=b.product_guid 
left outer join {{ ref('stg_products') }} c
on a.product_guid=c.product_guid 