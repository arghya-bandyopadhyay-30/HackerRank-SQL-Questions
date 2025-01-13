WITH cte_logs AS (
    SELECT
        *,
        LAG(num) OVER() AS prev,
        LEAD(num) OVER() AS next
    FROM
        Logs
)
SELECT
    DISTINCT num AS ConsecutiveNums
FROM
    cte_logs
WHERE
    num = prev AND num = next;
