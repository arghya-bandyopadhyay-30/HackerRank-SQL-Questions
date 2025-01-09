# Find Dates with Higher Temperatures than the Previous Day

## Problem Statement
You are given a table `Weather` containing daily temperature records. Write an SQL query to find all the `id` values of the days where the temperature was higher than the previous day's temperature.

---

## Table Schema

### Weather Table:
| Column Name   | Type    | Description                              |
|---------------|---------|------------------------------------------|
| id            | int     | A unique identifier for each record.    |
| recordDate    | date    | The date of the temperature record.     |
| temperature   | int     | The recorded temperature on this date.  |

- The `id` column has unique values.
- No two rows have the same `recordDate`.

---

## Output Format
The output should be a table containing a single column:

| Column Name | Type |
|-------------|------|
| id          | int  |

---

## Constraints
1. Compare the temperature of a given date with the previous date's temperature.
2. The difference between `recordDate` and the previous date should be exactly one day.

---

## Example Input

### Input:

| id | recordDate | temperature |
|----|------------|-------------|
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |

---

## Example Output

### Output:
| id  |
|-----|
| 2   |
| 4   |

---

## Explanation
1. On `2015-01-02`, the temperature (25) is higher than the previous day (`2015-01-01`, temperature 10).
2. On `2015-01-04`, the temperature (30) is higher than the previous day (`2015-01-03`, temperature 20).
3. These dates meet the criteria, so their `id` values (2, 4) are returned.
