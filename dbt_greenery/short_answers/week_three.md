# What is the overall conversion rate?
```sql
WITH data as
(SELECT 
    SUM(total_views) as total_views,
    SUM(count_checkout) as total_purchases
FROM dbt_timmy_shar.fct_page_views)
SELECT
    ROUND((total_purchases/total_views) * 100,2) as overall_conversion_rate_pct
FROM
    data
```
## Answer 11.92%

# What is the conversion rate by product? 

Created two tables and joined them together to get the answer:

int_checkout.sql

```sql
{{config(materialized='table')}}

SELECT 
    session_id,
    product_id
FROM
    {{ref('dim_events')}}

WHERE product_id is not null 
```

int_session.sql
```sql
{{config(materialized='table')}}

SELECT 
    session_id,
    CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END AS checkout
FROM
     {{ref('dim_events')}}
```

fct_product_conversions.sql
```sql
{{config(materialized='table')}}

SELECT 
    product_id,
    SUM(CASE WHEN checkout = 1 THEN 1 ELSE 0 END) as num_checkouts,
    COUNT(DISTINCT s.session_id) as num_sessions,
    1.0*SUM(CASE WHEN checkout = 1 THEN 1 ELSE 0 END)/COUNT(DISTINCT s.session_id) AS conversion_rate
FROM 
    {{ref('int_session')}} s
JOIN {{ref('int_checkout')}} c 
    ON s.session_id = c.session_id
GROUP BY 1
```

## I get much higher conversion rates per product so I know im not doing something exactly right. Am trying to figure out where my mistep was. 



