select 
    product_id as product_guid,
    name,
    price,
    inventory
FROM {{ source('greenery', 'products') }}


