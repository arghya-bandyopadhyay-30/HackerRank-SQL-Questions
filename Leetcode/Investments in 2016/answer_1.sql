WITH Insurance_location AS (
    SELECT
        pid, 
        tiv_2015, 
        tiv_2016, 
        CONCAT(lat, ", ", lon) AS location
    FROM
        Insurance
),
location_count AS (
    SELECT
        location,
        COUNT(location) AS loc_count
    FROM
        Insurance_location
    GROUP BY
        location
),
tiv_2015_count AS (
    SELECT
        tiv_2015,
        COUNT(tiv_2015) AS tiv_count
    FROM
        Insurance_location
    GROUP BY
        tiv_2015
)
SELECT
    ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM 
    Insurance_location
INNER JOIN 
    location_count ON Insurance_location.location = location_count.location
INNER JOIN 
    tiv_2015_count ON Insurance_location.tiv_2015 = tiv_2015_count.tiv_2015
WHERE
    tiv_count > 1 AND loc_count = 1;