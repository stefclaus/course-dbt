select 
    user_id as user_guid,
    first_name,
    last_name,
    phone_number,
    email,
    created_at as created_at_utc,
    updated_at as updated_at_utc,
    address_id as address_guid
FROM {{ source('greenery', 'users') }}


