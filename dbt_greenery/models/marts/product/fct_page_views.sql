{{config(materialized='table')}}
{%
    set event_types = [
        "add_to_cart",
        "checkout",
        "delete_from_cart",
        "package_shipped",
        "page_view",
        "account_created",
]
%}
SELECT
    user_id,
    session_id,
    COUNT(DISTINCT event_id) as total_views
    {% for event_type in event_type %},
    SUM(CASE WHEN event_type = '{{event_type}}' THEN 1 ELSE 0 END) AS {{event_type}}s
    {% endfor %}
FROM 
    {{ref('dim_events')}}
GROUP BY 1,2
