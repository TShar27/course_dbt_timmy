# Question 1) How many users do we have?
```sql
SELECT
    Count(DISTINCT(user_id))
FROM users;
```
## Answer: 130 Users 

# Question 2) On average, how many orders do we receive per hour?
```sql
with data as(SELECT 
    date_trunc('hour',created_at) as hour,
    count(created_at) as orders
FROM
    orders
Group by 1)
SELECT
avg(orders) as avg_num_of_orders_per_hour
FROM
    data;
```
## Answer: ~ 8 orders

# Question 3) On average, how long does an order take from being placed to delivered?
```sql
with delivery_time as (
    SELECT 
        delivered_at - created_at as delivery_time
    FROM 
        orders)
    SELECT
        avg(delivery_time)
    FROM
        delivery_time
```
##  Answer: 3 days 22 hours

# Question 4) How many users have made 1 purchase? Two purchases? Three + purchases?
```sql
with purchases as (SELECT 
    user_id,
    count(order_id) as purchases
FROM
    orders 

GROUP BY 1)

SELECT 
    CASE WHEN purchases = 1 then '1'
         WHEN purchases = 2 then '2'
         WHEN purchases >= 3 then '3 or more'
    END AS amount,
    count(*)
FROM
    purchases
GROUP BY 1
ORDER BY 1
```
## Answer: 1-25
##        2-22
##         3+-81

# Question 5) On average, how many unique sessions do we have per hour?

```sql
WITH sessions AS (SELECT
    date_trunc('hour',created_at) AS hour,
    COUNT(DISTINCT session_id) as sessions_count
FROM
    events
GROUP BY 1)
SELECT
    AVG(sessions_count) 
FROM 
    sessions
```
## Answer: ~7.39 