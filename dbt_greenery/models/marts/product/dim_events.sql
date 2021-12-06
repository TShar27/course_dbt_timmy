{{config(materialized='table')}}

SELECT 
    user_id,
    event_id,
    session_id,
    SPLIT_PART(page_url,'/',5) as product_id,
    created_at as event_created_at_utc,
    DATE(created_at) as session_date_utc,
    event_type,
    page_url
FROM   
{{ref('stg_events')}} 
   