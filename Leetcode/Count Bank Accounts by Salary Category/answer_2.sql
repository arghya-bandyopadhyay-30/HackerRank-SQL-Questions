WITH category_name AS (
    SELECT 'Low Salary' AS category
    UNION
    SELECT 'Average Salary'
    UNION
    SELECT 'High Salary'
),
category_sum AS (
    SELECT
        CASE
            WHEN income < 20000 THEN 'Low Salary'
            WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
            ELSE 'High Salary'
        END AS category,
        COUNT(income) AS accounts_count
    FROM
        Accounts
    GROUP BY
        CASE
            WHEN income < 20000 THEN 'Low Salary'
            WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
            ELSE 'High Salary'
        END
)
SELECT 
    cn.category,
    IFNULL(cs.accounts_count, 0) AS accounts_count
FROM 
    category_name cn
LEFT JOIN
    category_sum cs
ON
    cn.category = cs.category;