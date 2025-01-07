WITH RECURSIVE starpattern AS (
    SELECT 
        1 AS level,
        CAST(REPEAT('* ', 1) AS CHAR(1000)) AS stars
    UNION ALL
    SELECT 
        level + 1,
        REPEAT('* ', level + 1) AS stars
    FROM 
        starpattern
    WHERE 
        level < 20
)
SELECT 
    stars
FROM 
    starpattern;