# README: Identifying Dates with Higher Temperatures than the Previous Day

This document explains the SQL query used to find dates where the temperature is higher than the previous day. The solution employs a **self-join** on the `Weather` table and filters records to meet the specified condition. Below is a detailed breakdown of the query and its logic.

---

## Problem Statement
Identify rows in the `Weather` table where the temperature on a given day is higher than the temperature on the previous day. The comparison should account for dates that are exactly one day apart.

---

## Solution Overview
The solution involves two main steps:
1. Performing a self-join on the `Weather` table to pair each record with the record from the previous day.
2. Filtering rows to retain only those where the temperature on the current day is higher than the previous day's temperature.

---

## Step-by-Step Breakdown

### Step 1: Self-Join the Table
The `Weather` table is joined with itself to pair each day's record (`w1`) with the previous day's record (`w2`). The join condition ensures that only records exactly one day apart are paired.

### Query:
```sql
SELECT
    w1.id,
    w1.recordDate,
    w1.temperature,
    w2.recordDate AS prev_recordDate,
    w2.temperature AS prev_temperature
FROM
    Weather w1
JOIN
    Weather w2
ON
    DATEDIFF(w1.recordDate, w2.recordDate) = 1;
```

#### Explanation:
- `w1` and `w2` are aliases for the `Weather` table.
- `DATEDIFF(w1.recordDate, w2.recordDate) = 1` ensures that the two paired records are exactly one day apart.
- Retrieves the current day's `id`, `recordDate`, and `temperature` (`w1`), along with the previous day's `recordDate` and `temperature` (`w2`).

#### Example Output:
| id | recordDate  | temperature | prev_recordDate | prev_temperature |
|----|-------------|-------------|-----------------|------------------|
| 2  | 2015-01-02  | 25          | 2015-01-01      | 10               |
| 3  | 2015-01-03  | 20          | 2015-01-02      | 25               |
| 4  | 2015-01-04  | 30          | 2015-01-03      | 20               |

---

### Step 2: Filter Rows with Higher Temperatures
Add a `WHERE` clause to the query to filter rows where the current day's temperature is greater than the previous day's temperature.

### Query:
```sql
SELECT
    w1.id
FROM
    Weather w1
JOIN
    Weather w2
ON
    DATEDIFF(w1.recordDate, w2.recordDate) = 1
WHERE
    w1.temperature > w2.temperature;
```

#### Explanation:
- The `WHERE` clause filters rows where `w1.temperature > w2.temperature`.
- Only retains rows where the current day's temperature is higher than the previous day's temperature.
- Returns the `id` of the current day (`w1.id`).

#### Example Output:
| id |
|----|
| 2  |
| 4  |

---

## Final Query
The complete SQL query is as follows:

```sql
SELECT
    w1.id
FROM
    Weather w1
JOIN
    Weather w2
ON
    DATEDIFF(w1.recordDate, w2.recordDate) = 1
WHERE
    w1.temperature > w2.temperature;
```

---

## Example Walkthrough

### Input Data:
| id | recordDate  | temperature |
|----|-------------|-------------|
| 1  | 2015-01-01  | 10          |
| 2  | 2015-01-02  | 25          |
| 3  | 2015-01-03  | 20          |
| 4  | 2015-01-04  | 30          |

### Execution Steps:
1. **Self-Join:**
   Pair each day's record with the previous day's record.

   Result:
   | id | recordDate  | temperature | prev_recordDate | prev_temperature |
   |----|-------------|-------------|-----------------|------------------|
   | 2  | 2015-01-02  | 25          | 2015-01-01      | 10               |
   | 3  | 2015-01-03  | 20          | 2015-01-02      | 25               |
   | 4  | 2015-01-04  | 30          | 2015-01-03      | 20               |

2. **Filter Rows:**
   Retain rows where the temperature is higher than the previous day.

   Result:
   | id |
   |----|
   | 2  |
   | 4  |

                                                                                                                                                                                                                                                                                                    

