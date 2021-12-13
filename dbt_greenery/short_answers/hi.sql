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