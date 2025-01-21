WITH project_with_id AS (
    SELECT
        p1.*,
        SUM(
            CASE 
                WHEN p1.end_date = p2.start_date THEN 0
                ELSE 1
            END
        ) OVER(ORDER BY p1.start_date DESC) AS project_id
    FROM
        Projects p1
    LEFT JOIN
        Projects p2
    ON
        p1.end_date = p2.start_date
)
SELECT
    MIN(start_date) AS start_date,
    MAX(end_date) AS end_date
FROM
    project_with_id
GROUP BY
    project_id
ORDER BY
    COUNT(*) ASC,
    start_date ASC;