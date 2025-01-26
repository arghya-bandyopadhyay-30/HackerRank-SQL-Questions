WITH FilteredStadium AS (
    SELECT
        *,
        id - ROW_NUMBER() OVER (ORDER BY id) AS grp
    FROM
        Stadium
    WHERE
        people >= 100
),
GroupedData AS (
    SELECT
        grp
    FROM
        FilteredStadium
    GROUP BY
        grp
    HAVING
        COUNT(*) >= 3
)
SELECT
    id,
    visit_date,
    people
FROM
    FilteredStadium f
INNER JOIN
    GroupedData g
ON
    f.grp = g.grp
ORDER BY
    visit_date;