WITH filtered_table AS (
    SELECT
        player_id,
        DATEDIFF(event_date, MIN(event_date) OVER (PARTITION BY player_id)) AS date_diff
    FROM
        Activity
)
SELECT 
    ROUND(
        SUM(CASE WHEN date_diff = 1 THEN 1 ELSE 0 END) / COUNT(DISTINCT player_id),
        2
    ) AS fraction
FROM
    filtered_table;
