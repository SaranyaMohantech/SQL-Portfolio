WITH ranked_orders AS
(
    SELECT
        c.customer_name,
        o.order_id,
        o.amount,
        RANK() OVER
        (
            PARTITION BY c.customer_id
            ORDER BY o.amount DESC
        ) AS rn
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
)

SELECT
    customer_name,
    order_id,
    amount
FROM ranked_orders
WHERE rn <= 2
ORDER BY customer_name, amount DESC;


/*
Business Requirement:

Retrieve the top 2 highest-value orders for each customer.

Skills used:

CTE
RANK()
Window Functions
*/
