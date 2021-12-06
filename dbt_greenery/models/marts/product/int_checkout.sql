{{config(materialized='table')}}

SELECT 
    session_id,
    CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END AS checkout
FROM
     {{ref('dim_events')}}