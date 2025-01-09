WITH parent_nodes AS (
    SELECT b1.N
    FROM bst b1
    WHERE EXISTS (
        SELECT 1
        FROM bst b2
        WHERE b1.N = b2.P
    )
)
SELECT N,
    CASE 
        WHEN P IS NULL THEN 'Root' -- Node with no parent
        WHEN N IN (SELECT N FROM parent_nodes) AND P IS NOT NULL THEN 'Inner' -- Node with at least one child and has a parent
        ELSE 'Leaf' -- Node with no child
    END AS Node_Type
FROM bst
ORDER BY N;