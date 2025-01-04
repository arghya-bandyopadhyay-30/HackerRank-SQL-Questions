WITH cte AS (
    SELECT
        *,
        ROW_NUMBER() OVER (ORDER BY team) AS r
    FROM
        teams
)
SELECT
    c1.team AS team1,
    c2.team AS team2
FROM
    cte c1
JOIN
    cte c2
ON
    c1.r < c2.r;