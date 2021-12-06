{{config(materialized='table')}}

SELECT 
    session_id,
    product_id
FROM
    {{ref('dim_events')}}

WHERE product_id is not null 