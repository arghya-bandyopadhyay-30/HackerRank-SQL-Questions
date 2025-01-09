# Removing Duplicate Routes

## Overview
In this task, we aim to eliminate duplicate routes from the `routes` table. A route is considered a duplicate if the pair `(source, destination)` and `(destination, source)` represent the same connection, regardless of order. The final output should contain only unique routes, ensuring that the `source` is alphabetically smaller than the `destination` for the same connection.

---

## Approach 1: Using LEAST and GREATEST

### Query
```sql
SELECT
    LEAST(source, destination) AS source,
    GREATEST(source, destination) AS destination,
    MAX(distance) AS distance
FROM
    routes
GROUP BY
    LEAST(source, destination),
    GREATEST(source, destination);
```

### Step-by-Step Explanation
1. **Ensuring Consistent Ordering**:
   - Use `LEAST(source, destination)` to determine the smaller value between `source` and `destination`. This ensures the smaller value is always treated as `source`.
   - Use `GREATEST(source, destination)` to determine the larger value between `source` and `destination`. This ensures the larger value is always treated as `destination`.

2. **Grouping Duplicate Routes**:
   - Group rows by the results of `LEAST(source, destination)` and `GREATEST(source, destination)`. This groups duplicate routes (e.g., `(Mumbai, Bangalore)` and `(Bangalore, Mumbai)`) together.

3. **Aggregating Distances**:
   - Use `MAX(distance)` to retain a single distance value for each group. This assumes distances are identical for duplicates. If distances differ, the maximum value will be retained.

### Output Example
| source     | destination | distance |
|------------|-------------|----------|
| Bangalore  | Mumbai      | 500      |
| Delhi      | Mathura     | 150      |
| Nagpur     | Pune        | 500      |

---

## Approach 2: Using a Common Table Expression (CTE) and ROW_NUMBER

### Query
```sql
WITH cte AS (
    SELECT
        source,
        destination,
        distance,
        ROW_NUMBER() OVER (
            PARTITION BY LEAST(source, destination), GREATEST(source, destination)
            ORDER BY source
        ) AS row_num
    FROM
        routes
)
SELECT
    source,
    destination,
    distance
FROM
    cte
WHERE
    row_num = 1;
```

### Step-by-Step Explanation
1. **Assign Row Numbers**:
   - Use the `ROW_NUMBER()` function to assign a unique row number within groups formed by `LEAST(source, destination)` and `GREATEST(source, destination)`.
   - This groups duplicate routes (e.g., `(Mumbai, Bangalore)` and `(Bangalore, Mumbai)`) into the same partition.

2. **Filter Unique Routes**:
   - `WHERE row_num = 1` ensures only one row per group is retained. The route with the smallest alphabetical order will be selected due to `ORDER BY source`.

3. **Using CTE**:
   - The `cte` (Common Table Expression) simplifies the query logic by separating the row-numbering step from the final filtering.

### Output Example
| source     | destination | distance |
|------------|-------------|----------|
| Bangalore  | Mumbai      | 500      |
| Delhi      | Mathura     | 150      |
| Nagpur     | Pune        | 500      |

---

## Approach 3: Using Self Join

### Query
```sql
SELECT
    c1.source,
    c1.destination,
    c1.distance
FROM
    routes c1
LEFT JOIN routes c2
ON c1.source = c2.destination
   AND c1.destination = c2.source
WHERE
    c1.source < c1.destination;
```

### Step-by-Step Explanation
1. **Identify Duplicate Pairs**:
   - Perform a `LEFT JOIN` to match rows where the `source` of one route matches the `destination` of another route, and vice versa.

2. **Filter Unique Routes**:
   - Use `WHERE c1.source < c1.destination` to ensure that only one representation of a route is retained (e.g., `(Mumbai, Bangalore)` but not `(Bangalore, Mumbai)`).

### Output Example
| source     | destination | distance |
|------------|-------------|----------|
| Bangalore  | Mumbai      | 500      |
| Delhi      | Mathura     | 150      |
| Nagpur     | Pune        | 500      |

---

## Summary
The above approaches ensure duplicate routes are removed while retaining only unique connections in the desired format. The choice of method depends on query requirements and database performance considerations.

