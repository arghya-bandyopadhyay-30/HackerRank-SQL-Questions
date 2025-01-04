WITH formatted_occupations AS (
    SELECT
        NAME,
        OCCUPATION,
        ROW_NUMBER() OVER (
            PARTITION BY OCCUPATION
            ORDER BY NAME
        ) AS row_num
    FROM OCCUPATIONS
)
SELECT
    MAX(CASE WHEN OCCUPATION = 'Doctor' THEN NAME ELSE NULL END) AS Doctor,
    MAX(CASE WHEN OCCUPATION = 'Professor' THEN NAME ELSE NULL END) AS Professor,
    MAX(CASE WHEN OCCUPATION = 'Singer' THEN NAME ELSE NULL END) AS Singer,
    MAX(CASE WHEN OCCUPATION = 'Actor' THEN NAME ELSE NULL END) AS Actor
FROM formatted_occupations
GROUP BY row_num;