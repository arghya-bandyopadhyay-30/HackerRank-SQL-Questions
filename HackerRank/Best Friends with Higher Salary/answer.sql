WITH own_salary AS (
    SELECT
        f.id AS id,
        p.salary AS salary,
        f.friend_id AS friend_id
    FROM
        friends f
    INNER JOIN
        packages p
    ON
        f.id = p.id
)
SELECT
    s.name
FROM
    own_salary os
INNER JOIN
    packages p
ON
    os.friend_id = p.id
INNER JOIN
    students s
ON
    os.id = s.id
WHERE
    p.salary > os.salary
ORDER BY
    p.salary;