WITH cte AS (
    SELECT 
        CONCAT(id, ' ', name) AS id_name,
        NTILE(4) OVER (ORDER BY id) AS groups
    FROM emp
)
SELECT 
    STRING_AGG(id_name, ', ') AS result,
    groups
FROM cte
GROUP BY groups
ORDER BY groups;