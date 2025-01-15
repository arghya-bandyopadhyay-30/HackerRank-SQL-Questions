WITH filtered_customer AS (
    SELECT
        visited_on,
        SUM(amount) AS amount
    FROM
        Customer
    GROUP BY
        visited_on
),
customer_with_total_and_avg AS (
    SELECT
        visited_on,
        ROW_NUMBER() OVER (ORDER BY visited_on) AS days_count,
        SUM(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS running_total,
        AVG(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS running_avg
    FROM
        filtered_customer
)
SELECT
    visited_on,
    running_total AS amount,
    ROUND(running_avg, 2) AS average_amount
FROM
    customer_with_total_and_avg
WHERE
    days_count > 6;