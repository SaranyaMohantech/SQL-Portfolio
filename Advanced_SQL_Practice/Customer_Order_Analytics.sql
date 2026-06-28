WITH cte AS
(
    SELECT
        c.customer_name,
        COUNT(*) OVER(PARTITION BY c.customer_id) AS total_orders,
        SUM(o.amount) OVER(PARTITION BY c.customer_id) AS total_spent,
        AVG(o.amount) OVER(PARTITION BY c.customer_id) AS avg_order_amount,
        ROW_NUMBER() OVER(PARTITION BY c.customer_id ORDER BY o.order_id) AS rn
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
)

SELECT
    customer_name,
    total_orders,
    total_spent,
    avg_order_amount
FROM cte
WHERE rn = 1;
