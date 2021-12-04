# Questions Week 2

# What is our user repeat rate?

```sql
WITH data AS(
SELECT
    SUM(CASE WHEN num_orders >0  THEN 1 ELSE 0 END) AS total_shoppers,
    SUM(CASE WHEN num_orders >=2 THEN 1 ELSE 0 END) AS repeat_customers
FROM
    dbt_timmy_shar.fct_user_orders)
SELECT 
(1.0* repeat_customers/total_shoppers)*100 AS repeat_rate_pct
FROM
    data
```
## Answer: 79.84%
