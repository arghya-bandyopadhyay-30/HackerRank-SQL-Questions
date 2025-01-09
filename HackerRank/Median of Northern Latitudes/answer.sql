WITH Ordered_Data AS (
    SELECT ROW_NUMBER() OVER (ORDER BY LAT_N) AS row_num, LAT_N
    FROM STATION
),
Row_Count AS (
    SELECT COUNT(*) AS total_rows FROM Ordered_Data
)
SELECT ROUND(CASE
        WHEN total_rows % 2 = 1 THEN (
            SELECT LAT_N
            FROM Ordered_Data, Row_Count
            WHERE row_num = ROUND((total_rows + 1)/2)
        )
        ELSE (
            SELECT AVG(LAT_N)
            FROM Ordered_Data, Row_Count
            WHERE row_num IN (ROUND(total_rows/2), ROUND(total_rows/2)+1)
        )
    END, 4) AS MEDIAN
FROM Row_Count;