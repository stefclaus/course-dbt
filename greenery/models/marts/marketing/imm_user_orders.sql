with users as (
    select * 
    from {{ ref('dim_users') }}
), 

orders as (
    select *
    from {{ ref('fct_orders') }}
), 

user_orders as (
    select a.user_guid,
        a.first_name,
        a.last_name,
        a.email,
        a.phone_number,
        a.created_at_utc,
        a.updated_at_utc,
        a.address_guid,
        a.zipcode,
        a.state,
        a.country,
        b.order_guid,
        b.promo_guid,
        b.order_cost,
        b.shipping_cost,
        b.order_total,
        b.tracking_guid,
        b.shipping_service,
        b.estimated_delievery_at_utc,
        b.delivered_at_utc,
        b.status,
        b.product_guid,
        b.quantity
    from users a
    left outer join orders b
    on a.user_guid = b.user_guid 
        
)

select * from user_orders