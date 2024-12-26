WITH combined_table AS (
    SELECT
        d.name AS Department, 
        e.name AS Employee, 
        e.salary AS Salary,
        DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS rank
    FROM
        Employee e
    INNER JOIN
        Department d
    ON
        e.departmentId = d.id
)
SELECT 
    Department,
    Employee,
    Salary
FROM 
    combined_table
WHERE 
    rank <= 3;