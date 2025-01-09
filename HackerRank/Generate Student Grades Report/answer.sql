WITH cte AS (
    SELECT 
        s.Name,
        g.Grade,
        s.Marks
    FROM
        Students s
    JOIN 
        Grades g
    ON 
        s.Marks BETWEEN g.Min_Mark AND g.Max_Mark
)
SELECT 
    CASE 
        WHEN Grade >= 8 THEN Name
        ELSE NULL
    END AS Name,
    Grade,
    Marks
FROM cte
ORDER BY 
    Grade DESC,
    CASE 
        WHEN Grade >= 8 THEN Name
    END ASC,
    CASE 
        WHEN Grade < 8 THEN Marks
    END ASC;