WITH customer_orders AS
(
    SELECT
        c.customer_name,
        o.order_id,
        o.amount,
        MAX(o.amount) OVER
        (
            PARTITION BY c.customer_id
        ) AS max_amount
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
)

SELECT
    customer_name,
    order_id,
    amount
FROM customer_orders
WHERE amount = max_amount
ORDER BY customer_name;

/*
Business Requirement:

Identify the highest-value order placed by each customer.

Skills used:

MAX()
Window Functions
CTE
*/
