select 
    promo_id as user_guid,
    discount,
    status
FROM {{ source('greenery', 'promos') }}


