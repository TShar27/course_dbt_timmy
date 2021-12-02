{{config(materialized='table')}}

SELECT
    user_id,
    session_id,
    COUNT(DISTINCT event_id) as total_views,
    SUM(CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END) AS count_page_view,
    SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) AS count_checkout,
    SUM(CASE WHEN event_type = 'package_shipped' THEN 1 ELSE 0 END) AS count_package_shipped
FROM 
    {{ref('dim_events')}}
GROUP BY 1,2