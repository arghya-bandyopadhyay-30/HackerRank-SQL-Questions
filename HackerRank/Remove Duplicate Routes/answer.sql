-- Using LEAST and GREATEST to remove duplicate routes
SELECT 
    LEAST(source, destination) AS source, 
    GREATEST(source, destination) AS destination, 
    MAX(distance) AS distance
FROM 
    routes
GROUP BY 
    LEAST(source, destination), 
    GREATEST(source, destination);

-- Using CTE and ROW_NUMBER to remove duplicate routes
WITH cte AS (
    SELECT 
        source, 
        destination, 
        distance, 
        ROW_NUMBER() OVER (
            PARTITION BY LEAST(source, destination), GREATEST(source, destination) 
            ORDER BY source
        ) AS row_num
    FROM 
        routes
)
SELECT 
    source, 
    destination, 
    distance
FROM 
    cte
WHERE 
    row_num = 1;

-- Using Self Join to remove duplicate routes
SELECT 
    c1.source, 
    c1.destination, 
    c1.distance
FROM 
    routes c1
LEFT JOIN routes c2
ON c1.source = c2.destination 
   AND c1.destination = c2.source
WHERE 
    c1.source < c1.destination;
