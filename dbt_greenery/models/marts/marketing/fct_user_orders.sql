{{config(
    materialized=
        'table'
    )}}
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.address,
    u.zipcode,
    u.state,
    u.country,
    MIN(o.created_at_utc) AS first_order_created_at,
    MAX(o.created_at_utc) AS last_order_created_at,
    COUNT(DISTINCT order_id) AS num_orders,
    SUM(CASE WHEN o.order_status = 'shipped' THEN 1 ELSE 0 END) AS count_orders_shipped,
    SUM(CASE WHEN o.order_status = 'pending' THEN 1 ELSE 0 END) AS count_orders_pending,
    SUM(CASE WHEN o.order_status = 'preparing' THEN 1 ELSE 0 END) AS count_orders_preparing,
    SUM(CASE WHEN o.order_status = 'delivered' THEN 1 ELSE 0 END) AS count_orders_delivered
FROM
    {{ref('dim_users')}} AS u 
JOIN {{ref('fct_orders')}} as o 
    ON u.user_id = o.user_id
GROUP BY 1,2,3,4,5,6,7,8
