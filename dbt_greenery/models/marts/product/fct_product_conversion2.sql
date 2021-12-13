{{sessions_with_checkout()}}
,sessions_with_product AS(
    SELECT
        session_id,
        split_part(page_url,'/',5) as product_id
    FROM 
        {{ref('stg_events')}}
    WHERE event_type = 'add_to_cart'
    GROUP BY 1,2
)
SELECT 
    product_id,
    SUM(has_checkout)::numeric/COUNT(session_id) AS conv_rate
FROM
    sessions_with_product swp
LEFT JOIN sessions_with_checkout swc USING (session_id)
GROUP BY swp.product_id