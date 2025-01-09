WITH join_table AS (
    SELECT
        s.user_id,
        c.action
    FROM
        Signups s
    LEFT JOIN
        Confirmations c
    ON
        s.user_id = c.user_id
),
confirmed_count AS (
    SELECT
        user_id,
        COUNT(action) AS count
    FROM
        join_table
    WHERE
        action = 'confirmed'
    GROUP BY
        user_id
),
total_count AS (
    SELECT
        user_id,
        COUNT(action) AS total
    FROM
        join_table
    GROUP BY
        user_id
)
SELECT
    t.user_id,
    CASE
        WHEN (c.count / t.total) IS NULL THEN 0
        ELSE ROUND(c.count / t.total, 2)
    END AS confirmation_rate
FROM 
    confirmed_count c
RIGHT JOIN
    total_count t
ON 
    c.user_id = t.user_id;
