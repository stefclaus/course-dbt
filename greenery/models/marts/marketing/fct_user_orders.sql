select user_guid, 
    count(order_guid) as number_of_orders,
    sum(order_total) as order_amount, 
    sum(quantity) as number_of_items
from {{ ref('imm_user_orders') }}
group by user_guid