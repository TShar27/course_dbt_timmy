{{config(materialized = 'table')}}

SELECT
    order_id,
    CASE WHEN promo_id IS NULL THEN 'none' ELSE promo_id END AS promo_id,
    user_id,
    address_id,
    created_at,
    order_cost,
    shipping_cost,
    order_total,
    tracking_id,
    shipping_service,
    estimated_delivery_at,
    delivered_at,
    status
FROM
    {{source('tutorial','orders')}}

select * from orders limit 100;

