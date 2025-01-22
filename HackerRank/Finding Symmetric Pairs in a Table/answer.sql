WITH func AS (
    SELECT
        *,
        ROW_NUMBER() OVER(ORDER BY x, y) AS row_num
    FROM
        functions f
)
SELECT DISTINCT
    f1.x,
    f1.y
FROM
    func f1, func f2
WHERE
    f1.row_num != f2.row_num
    AND f1.x = f2.y
    AND f1.y = f2.x
    AND f1.x <= f1.y
ORDER BY
    f1.x, f1.y;