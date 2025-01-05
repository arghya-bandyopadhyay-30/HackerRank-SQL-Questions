WITH miscalculate_salaries AS (
    SELECT 
        SALARY,
        CAST(REPLACE(CAST(SALARY AS CHAR), '0', '') AS SIGNED) AS mis_sal
    FROM EMPLOYEES
)
SELECT 
    CEIL(AVG(SALARY) - AVG(mis_sal)) AS error
FROM miscalculate_salaries;
