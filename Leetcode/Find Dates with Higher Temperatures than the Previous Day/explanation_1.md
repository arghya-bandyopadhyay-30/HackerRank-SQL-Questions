# README: Finding Dates with Higher Temperatures than the Previous Day

This document explains how to identify rows in a dataset where the temperature on a given day is higher than the temperature on the previous day, ensuring the dates are exactly one day apart.

## Prerequisites
Ensure you have access to a SQL database and a table named `Weather` with the following schema:

| Column Name   | Data Type |
|---------------|-----------|
| `id`          | INT       |
| `recordDate`  | DATE      |
| `temperature` | INT       |

## Query Overview
The query involves three main steps:
1. Retrieve the previous day’s data using a window function (`LAG()`).
2. Calculate the date difference between consecutive rows.
3. Filter rows where the temperature is higher than the previous day’s temperature and the date difference is exactly one day.

---

## Step-by-Step Breakdown

### Step 1: Use `LAG()` to Retrieve Previous Day's Data
The `LAG()` function allows access to the previous row’s data within the same result set, ordered by `recordDate`.

#### Query:
```sql
SELECT
    id,
    recordDate,
    temperature,
    LAG(recordDate) OVER (ORDER BY recordDate) AS prev_date,
    LAG(temperature) OVER (ORDER BY recordDate) AS prev_date_temp
FROM
    Weather;
```
#### Example Output:
| id | recordDate  | temperature | prev_date   | prev_date_temp |
|----|-------------|-------------|-------------|----------------|
| 1  | 2015-01-01  | 10          | NULL        | NULL           |
| 2  | 2015-01-02  | 25          | 2015-01-01  | 10             |
| 3  | 2015-01-03  | 20          | 2015-01-02  | 25             |
| 4  | 2015-01-04  | 30          | 2015-01-03  | 20             |

---

### Step 2: Calculate the Date Difference
Use the `DATEDIFF()` function (or equivalent) to calculate the difference in days between `recordDate` and `prev_date`.

#### Query:
```sql
SELECT
    id,
    recordDate,
    temperature,
    DATEDIFF(recordDate, LAG(recordDate) OVER (ORDER BY recordDate)) AS date_diff,
    LAG(temperature) OVER (ORDER BY recordDate) AS prev_date_temp
FROM
    Weather;
```
#### Example Output:
| id | recordDate  | temperature | date_diff | prev_date_temp |
|----|-------------|-------------|-----------|----------------|
| 1  | 2015-01-01  | 10          | NULL      | NULL           |
| 2  | 2015-01-02  | 25          | 1         | 10             |
| 3  | 2015-01-03  | 20          | 1         | 25             |
| 4  | 2015-01-04  | 30          | 1         | 20             |

---

### Step 3: Filter Rows
Filter rows where:
1. The temperature is higher than the previous day’s temperature (`temperature > prev_date_temp`).
2. The date difference is exactly one day (`date_diff = 1`).

#### Query:
```sql
SELECT
    id
FROM
    Weather
WHERE
    temperature > LAG(temperature) OVER (ORDER BY recordDate)
    AND DATEDIFF(recordDate, LAG(recordDate) OVER (ORDER BY recordDate)) = 1;
```

---

### Final Query
Combine all steps into a single Common Table Expression (CTE) for better readability and maintainability.

#### Query:
```sql
WITH cte AS (
    SELECT
        id,
        recordDate,
        temperature,
        DATEDIFF(recordDate, LAG(recordDate) OVER (ORDER BY recordDate)) AS date_diff,
        LAG(temperature) OVER (ORDER BY recordDate) AS prev_date_temp
    FROM
        Weather
)
SELECT
    id
FROM
    cte
WHERE
    temperature > prev_date_temp
    AND date_diff = 1;
```

---

## Example Walkthrough

### Input:
| id | recordDate  | temperature |
|----|-------------|-------------|
| 1  | 2015-01-01  | 10          |
| 2  | 2015-01-02  | 25          |
| 3  | 2015-01-03  | 20          |
| 4  | 2015-01-04  | 30          |

### Execution:
1. Use `LAG()` to retrieve previous day’s temperature and date.
2. Calculate `date_diff`.
3. Filter rows:
   - 2015-01-02: Temperature (25) > Previous Day (10) → **Include**.
   - 2015-01-03: Temperature (20) < Previous Day (25) → **Exclude**.
   - 2015-01-04: Temperature (30) > Previous Day (20) → **Include**.

### Output:
| id |
|----|
| 2  |
| 4  |

---

## Notes
- Replace `DATEDIFF()` with the appropriate function if your SQL dialect differs.
- Ensure the `recordDate` column is indexed for optimal performance.

---

## Use Cases
- Identifying significant temperature changes in weather datasets.
- Detecting anomalies in time-series data.

---

## Troubleshooting
1. **NULL Values in `prev_date` or `prev_date_temp`:**
   - This occurs for the first row since no previous data exists.
   - Exclude such rows using `WHERE date_diff IS NOT NULL` if needed.

2. **Incorrect `date_diff` Values:**
   - Ensure `recordDate` contains valid, continuous dates.
   - Handle missing dates appropriately by filling gaps or ignoring such rows.