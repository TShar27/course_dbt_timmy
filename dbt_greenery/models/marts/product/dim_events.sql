{{config(materialized='table')}}

SELECT 
    user_id,
    event_id,
    session_id,
    created_at as event_created_at_utc,
    DATE(created_at) as session_date_utc,
    event_type,
    page_url
FROM   
{{ref('stg_events')}} 
   