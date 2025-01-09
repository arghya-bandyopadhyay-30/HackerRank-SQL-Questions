WITH RECURSIVE Numbers AS (
    SELECT 
        2 AS num
    UNION ALL
    SELECT 
        num + 1
    FROM 
        Numbers
    WHERE 
        num < 1000
),
PrimeCheck AS (
    SELECT 
        num
    FROM 
        Numbers n
    WHERE NOT EXISTS (
        SELECT 
            1
        FROM 
            Numbers d
        WHERE 
            d.num <= FLOOR(SQRT(n.num))
            AND n.num % d.num = 0
    )
)
SELECT 
    GROUP_CONCAT(num SEPARATOR '&') AS PrimeNumbers
FROM 
    PrimeCheck;
