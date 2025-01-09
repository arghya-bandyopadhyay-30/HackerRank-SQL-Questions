WITH cte AS (
    SELECT
        id,
        recordDate,
        temperature,
        DATEDIFF(recordDate, LAG(recordDate) OVER (ORDER BY recordDate)) AS date_diff,
        LAG(temperature) OVER (ORDER BY recordDate) AS prev_date_temp
    FROM
        Weather
)
SELECT
    id
FROM
    cte
WHERE
    temperature > prev_date_temp
    AND date_diff = 1;
