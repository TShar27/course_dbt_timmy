{{sessions_with_checkout()}}
SELECT 
    SUM(has_checkout)::numeric/COUNT(session_id) AS conv_rate
FROM
    sessions_with_checkout

    
