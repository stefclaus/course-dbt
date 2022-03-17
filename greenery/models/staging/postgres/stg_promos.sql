select 
    promo_id as promo_guid,
    discount,
    status
FROM {{ source('greenery', 'promos') }}


