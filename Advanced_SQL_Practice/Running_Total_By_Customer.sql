SELECT
    c.customer_name,
    o.order_id,
    o.amount,
    SUM(o.amount) OVER
    (
        PARTITION BY c.customer_id
        ORDER BY o.order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_name, o.order_id;



/*
Business Requirement:

Calculate the running total of customer spending after each order.

Skills used:

Window Functions
SUM() OVER()
PARTITION BY
ORDER BY
*/
