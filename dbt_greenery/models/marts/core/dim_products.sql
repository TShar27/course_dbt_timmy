{{config(
    materialized=
        'table'
    )}}
SELECT 
    product_id,
    product_name,
    quantity AS product_in_stock
FROM
    {{ref('stg_products')}}
