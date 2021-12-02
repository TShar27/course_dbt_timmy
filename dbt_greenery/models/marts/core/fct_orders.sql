{{config(
    materialized=
        'table'
    )}}
SELECT 
    o.order_id,
    user_id,
    created_at AS created_at_utc,
    order_cost,
    shipping_cost,
    order_total,
    status AS order_status,
    tracking_id,
    o.delivered_at - o.created_at AS time_to_delivery,
    p.product_name,
    p.price as product_price,
    COUNT(p.product_id)
FROM
    {{ref('stg_orders')}} AS o 
JOIN {{ref('stg_order_items')}} as oi 
    ON o.order_id = oi.order_id
JOIN {{ref('stg_products')}} p 
    ON p.product_id = oi.product_id

GROUP BY 1,2,3,4,5,6,7,8,9,10,11