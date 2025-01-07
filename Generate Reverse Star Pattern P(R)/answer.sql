WITH RECURSIVE StarPattern AS (
    SELECT 
        20 AS Level,
        REPEAT('* ', 20) AS Stars
    UNION ALL
    SELECT 
        Level - 1,
        REPEAT('* ', Level - 1) AS Stars
    FROM 
        StarPattern
    WHERE 
        Level > 1
)
SELECT 
    Stars
FROM 
    StarPattern;
