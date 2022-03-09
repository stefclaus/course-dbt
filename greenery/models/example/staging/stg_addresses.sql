{{
  config(
    materialized='table'
  )
}}

SELECT 
    address_id,
    address,
    CASE WHEN length(zipcode::varchar) = 4 THEN lpad(zipcode::varchar,5,'0') ELSE zipcode::varchar END AS zipcode,
    state,
    country
FROM {{ source('tutorial', 'addresses') }}