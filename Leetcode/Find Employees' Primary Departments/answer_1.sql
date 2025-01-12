WITH filtered_emp AS (
    SELECT
        employee_id,
        department_id,
        primary_flag,
        COUNT(department_id) OVER (PARTITION BY employee_id) AS dept_count
    FROM
        Employee
)
SELECT
    employee_id,
    department_id
FROM
    filtered_emp
WHERE
    (dept_count > 1 AND primary_flag = 'Y')
    OR dept_count = 1;