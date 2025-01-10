# Query Quality and Poor Query Percentage Analysis

This document explains the process of calculating two key metrics for database queries:

1. **Query Quality**: The average of the ratio between query `rating` and `position`.
2. **Poor Query Percentage**: The percentage of queries with `rating` less than 3.

---

## Metrics Overview

### 1. Query Quality
This metric evaluates the overall quality of each query by calculating the average of the `rating` divided by the `position` for each query name. A higher value indicates better performance.

### 2. Poor Query Percentage
This metric identifies the proportion of queries with a `rating` below 3, expressed as a percentage of the total queries for each query name.

---

## Calculation Steps

### Approach 1: Step-by-Step Calculation

#### Step 1: Identify Poor Queries
Count the number of queries with `rating` less than 3 for each `query_name`.

**Query:**
```sql
WITH count_poor_query AS (
    SELECT
        query_name,
        COUNT(query_name) AS poor_count
    FROM
        Queries
    WHERE
        rating < 3
    GROUP BY
        query_name
)
```
**Output Example:**
| query_name | poor_count |
|------------|------------|
| Dog        | 1          |
| Cat        | 1          |

---

#### Step 2: Calculate Quality and Total Queries
For each `query_name`, calculate:
- `quality`: The average of `rating / position`.
- `total_query`: The total number of queries.

**Query:**
```sql
WITH filtered_queries AS (
    SELECT
        query_name,
        ROUND(AVG(rating / position), 2) AS quality,
        COUNT(query_name) AS total_query
    FROM
        Queries
    GROUP BY
        query_name
)
```
**Output Example:**
| query_name | quality | total_query |
|------------|---------|-------------|
| Dog        | 2.50    | 3           |
| Cat        | 0.66    | 3           |

---

#### Step 3: Combine Results
Join the results from Steps 1 and 2 to calculate the `poor_query_percentage`.

**Query:**
```sql
SELECT
    fq.query_name,
    quality,
    IFNULL(ROUND(poor_count * 100 / total_query, 2), 0) AS poor_query_percentage
FROM
    filtered_queries fq
LEFT JOIN
    count_poor_query c
ON
    fq.query_name = c.query_name;
```
**Output Example:**
| query_name | quality | poor_query_percentage |
|------------|---------|-----------------------|
| Dog        | 2.50    | 33.33                 |
| Cat        | 0.66    | 33.33                 |

---

### Optimized Approach
Instead of using multiple Common Table Expressions (CTEs), the calculations can be performed in a single query.

**Query:**
```sql
SELECT
    query_name,
    ROUND(AVG(rating / position), 2) AS quality,
    IFNULL(
        ROUND(
            SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100 / COUNT(query_name),
            2
        ),
        0
    ) AS poor_query_percentage
FROM
    Queries
GROUP BY
    query_name;
```

---

## Comparison of Approaches

| Metric                  | Step-by-Step Approach         | Optimized Approach      |
|-------------------------|-------------------------------|-------------------------|
| **Number of Queries**   | 3 (CTEs + Main Query)         | 1                       |
| **Readability**         | Easier to understand          | Compact but complex     |
| **Performance**         | Slower for large datasets     | Faster                  |

---

## Example Walkthrough

### Input Data:
| query_name | result             | position | rating |
|------------|--------------------|----------|--------|
| Dog        | Golden Retriever   | 1        | 5      |
| Dog        | German Shepherd    | 2        | 5      |
| Dog        | Mule               | 200      | 1      |
| Cat        | Shirazi            | 5        | 2      |
| Cat        | Siamese            | 3        | 3      |
| Cat        | Sphynx             | 7        | 4      |

### Output:
| query_name | quality | poor_query_percentage |
|------------|---------|-----------------------|
| Dog        | 2.50    | 33.33                 |
| Cat        | 0.66    | 33.33                 |

---

## Key Takeaways
- The **step-by-step approach** is suitable for small datasets or when debugging intermediate steps.
- The **optimized approach** is better for performance and compactness, especially for large datasets.

Both approaches produce the same output, ensuring flexibility based on use cases.

