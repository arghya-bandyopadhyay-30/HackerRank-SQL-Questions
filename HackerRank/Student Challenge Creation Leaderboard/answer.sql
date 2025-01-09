WITH CTE AS (
    SELECT 
        H.hacker_id, 
        H.name, 
        COUNT(C.challenge_id) AS challenge_count
    FROM 
        Hackers H
    INNER JOIN 
        Challenges C 
    ON 
        H.hacker_id = C.hacker_id
    GROUP BY 
        H.hacker_id, H.name
)
SELECT 
    hacker_id, 
    name, 
    challenge_count
FROM 
    CTE
WHERE 
    challenge_count = (SELECT MAX(challenge_count) FROM CTE) 
    OR
    challenge_count IN (
        SELECT 
            challenge_count 
        FROM 
            CTE 
        GROUP BY 
            challenge_count 
        HAVING 
            COUNT(challenge_count) = 1
    )
ORDER BY 
    challenge_count DESC, 
    hacker_id ASC;