# What is the overall conversion rate?
```sql
{{sessions_with_checkout()}} -- macro I created (acts as a snippet) Can view in macros folder
SELECT 
    SUM(has_checkout)::numeric/COUNT(session_id) AS conv_rate
FROM
    sessions_with_checkout
```
## Answer 36.10%

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

## full list of all loan products and their conversion rates :)



