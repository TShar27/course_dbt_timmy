# Created a product funnel with the following model 
```sql

WITH sessions AS(
    SELECT
        session_id,
        session_date_utc,
        MAX(CASE WHEN event_type IS NOT NULL THEN 1 ELSE 0 END) AS session_count,
        MAX(CASE WHEN event_type = 'check_out' THEN 1 ELSE 0 END) AS checkout,
        MAX(CASE WHEN event_type = 'check_out' or event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS add_to_cart_checkout,
        MAX(CASE WHEN event_type = 'check_out' or event_type = 'add_to_cart' or event_type = 'page_view' THEN 1 ELSE 0 END) AS add_to_cart_pageview_checkout
    FROM
        {{ref('dim_events')}}
    GROUP BY 1,2
)
    SELECT
        session_date_utc,
        SUM(session_count) AS unique_sessions,
        SUM(CASE WHEN (add_to_cart_pageview_checkout > 0 OR add_to_cart_checkout>0 OR checkout >0) THEN 1 ELSE 0 END) as level_1,
        SUM(CASE WHEN (add_to_cart_checkout>0 OR checkout >0) THEN 1 ELSE 0 END) as level_2,
        SUM(CASE WHEN checkout >0 THEN 1 ELSE 0 END) as level_3
    FROM
        sessions
    GROUP BY 1
    ORDER BY 1

```

# Reflection Questions

My team currently uses dbt. After learning about the use cases of macos,I would recoomend my team take more advantage of their functionality. I also think that my team could implement more testing on our current models that were tied to an alerting system. Right now, we have so much legcay code that hold us back from utilizing the full powers of dbt. 
I was able to see that in full effect after my experience in this course. 

