# 7-Day Running Total and Average Analysis

This document explains the SQL query used to calculate a 7-day running total and average of daily transactions from the `Customer` table. The steps involve grouping data by date, calculating running totals and averages using window functions, and filtering for complete 7-day windows.

## Problem Statement

The goal is to:
1. Consolidate daily transaction amounts by `visited_on`.
2. Calculate running totals and averages over a 7-day window.
3. Exclude incomplete 7-day windows from the results.

## Solution

### Step 1: Group by Date
Consolidate transactions by `visited_on` to calculate the total payment for each day. This ensures that multiple entries on the same day are summed up.

**Query:**
```sql
WITH filtered_customer AS (
    SELECT
        visited_on,
        SUM(amount) AS amount
    FROM
        Customer
    GROUP BY
        visited_on
)
```
**Output of `filtered_customer`:**

| visited_on | amount |
|------------|--------|
| 2019-01-01 | 100    |
| 2019-01-02 | 110    |
| 2019-01-03 | 120    |
| 2019-01-04 | 130    |
| 2019-01-05 | 110    |
| 2019-01-06 | 140    |
| 2019-01-07 | 150    |
| 2019-01-08 | 80     |
| 2019-01-09 | 110    |
| 2019-01-10 | 280    |

### Step 2: Calculate Running Totals and Averages
Use window functions to calculate:
1. **`running_total`**: The sum of amounts over a 7-day window (current day + 6 preceding days).
2. **`running_avg`**: The average of amounts over the same 7-day window.

**Query:**
```sql
customer_with_total_and_avg AS (
    SELECT
        visited_on,
        ROW_NUMBER() OVER (ORDER BY visited_on) AS days_count,
        SUM(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS running_total,
        AVG(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS running_avg
    FROM
        filtered_customer
)
```
**Output of `customer_with_total_and_avg`:**

| visited_on | days_count | running_total | running_avg |
|------------|------------|---------------|-------------|
| 2019-01-01 | 1          | 100           | 100.00      |
| 2019-01-02 | 2          | 210           | 105.00      |
| 2019-01-03 | 3          | 330           | 110.00      |
| 2019-01-04 | 4          | 460           | 115.00      |
| 2019-01-05 | 5          | 570           | 114.00      |
| 2019-01-06 | 6          | 710           | 118.33      |
| 2019-01-07 | 7          | 860           | 122.86      |
| 2019-01-08 | 8          | 840           | 120.00      |
| 2019-01-09 | 9          | 840           | 120.00      |
| 2019-01-10 | 10         | 1000          | 142.86      |

### Step 3: Filter Rows for Full 7-Day Windows
Filter rows where there are at least 7 days in the moving window. Use `WHERE days_count > 6` to exclude incomplete windows.

**Query:**
```sql
SELECT
    visited_on,
    running_total AS amount,
    ROUND(running_avg, 2) AS average_amount
FROM
    customer_with_total_and_avg
WHERE
    days_count > 6;
```
**Final Output:**

| visited_on | amount | average_amount |
|------------|--------|----------------|
| 2019-01-07 | 860    | 122.86         |
| 2019-01-08 | 840    | 120.00         |
| 2019-01-09 | 840    | 120.00         |
| 2019-01-10 | 1000   | 142.86         |

## Key Concepts Used

1. **Window Functions:**
   - `SUM() OVER`: Calculates running totals within a 7-day window.
   - `AVG() OVER`: Calculates running averages within a 7-day window.

2. **Row Filtering:**
   - Use `ROW_NUMBER()` to exclude incomplete 7-day windows.

3. **Rounding:**
   - `ROUND()` ensures averages are rounded to two decimal places for better readability.

## Benefits of This Approach

- Efficiently calculates running totals and averages with minimal computation.
- Handles edge cases for incomplete windows.
- Provides clear and accurate results for 7-day trends in transaction data.

This query can be applied to analyze trends, detect patterns, or summarize financial data over a sliding window of days.

