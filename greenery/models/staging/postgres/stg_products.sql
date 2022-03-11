select 
    product_id as product_id,
    name,
    price,
    inventory
FROM {{ source('greenery', 'products') }}


