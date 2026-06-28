WITH cte AS
(
    SELECT
        c.customer_name,
        o.order_id,
        o.amount,
        LAG(o.amount,1)
            OVER
            (
                PARTITION BY c.customer_id
                ORDER BY o.order_id
            ) AS prev_order,

        LAG(o.amount,2)
            OVER
            (
                PARTITION BY c.customer_id
                ORDER BY o.order_id
            ) AS prev_prev_order
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
)

SELECT DISTINCT
    customer_name
FROM cte
WHERE amount > prev_order
AND prev_order > prev_prev_order
ORDER BY customer_name;


/*
Business Requirement

Find customers whose order amounts increased for three consecutive orders.

Skills used:

LAG()
CTE
Analytical Pattern Detection
*/
