SELECT
    person_name
FROM 
    (SELECT
         *,
         SUM(weight) OVER (ORDER BY turn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cum_sum
     FROM
         Queue
    ) AS cumulative_weights
WHERE
    cum_sum <= 1000
ORDER BY
    cum_sum DESC
LIMIT 1;