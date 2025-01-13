# Finding Numbers Appearing Consecutively Three Times

This query identifies numbers that appear consecutively at least three times in the `Logs` table. Using **window functions** and a **common table expression (CTE)**, we efficiently determine sequences of consecutive numbers.

---

## Step-by-Step Explanation

### Step 1: Analyze the Requirement
To find numbers that appear consecutively at least three times:
1. For each row, compare the current number (`num`) with its previous and next numbers.
2. If the current number matches both its previous and next numbers, it appears consecutively at least three times.

---

### Step 2: Use Window Functions to Retrieve Previous and Next Numbers
The `LAG()` and `LEAD()` functions are used to fetch the previous and next numbers relative to the current row:
- `LAG(num) OVER()`: Retrieves the number from the previous row.
- `LEAD(num) OVER()`: Retrieves the number from the next row.

#### Query:
```sql
WITH cte_logs AS (
    SELECT
        *,
        LAG(num) OVER() AS prev,
        LEAD(num) OVER() AS next
    FROM
        Logs
)
```
#### Example Output of `cte_logs`:
| id | num | prev | next |
|----|-----|------|------|
| 1  | 1   | NULL | 1    |
| 2  | 1   | 1    | 1    |
| 3  | 1   | 1    | 2    |
| 4  | 2   | 1    | 1    |
| 5  | 1   | 2    | 2    |
| 6  | 2   | 1    | 2    |
| 7  | 2   | 2    | NULL |

---

### Step 3: Filter for Consecutive Numbers
Use a `WHERE` clause to filter rows where:

- The current number (`num`) matches both the previous (`prev`) and next (`next`) numbers.

#### Query:
```sql
SELECT
    DISTINCT num AS ConsecutiveNums
FROM
    cte_logs
WHERE
    num = prev AND num = next;
```
#### Explanation:
- `num = prev AND num = next`: Ensures the current number is part of a sequence where it appears at least three times consecutively.
- `DISTINCT`: Ensures only unique numbers are returned in the result.

---

## Example Walkthrough

### Input Data:
| id | num |
|----|-----|
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |

### Step 1: Compute `prev` and `next`:
| id | num | prev | next |
|----|-----|------|------|
| 1  | 1   | NULL | 1    |
| 2  | 1   | 1    | 1    |
| 3  | 1   | 1    | 2    |
| 4  | 2   | 1    | 1    |
| 5  | 1   | 2    | 2    |
| 6  | 2   | 1    | 2    |
| 7  | 2   | 2    | NULL |

### Step 2: Filter for Consecutive Numbers

- For `num = 1`, the row with `id = 2` satisfies `num = prev AND num = next`.
- For `num = 2`, no row satisfies `num = prev AND num = next`.

### Step 3: Output Result:
| ConsecutiveNums |
|-----------------|
| 1               |

---

## Final Query
```sql
WITH cte_logs AS (
    SELECT
        *,
        LAG(num) OVER() AS prev,
        LEAD(num) OVER() AS next
    FROM
        Logs
)
SELECT
    DISTINCT num AS ConsecutiveNums
FROM
    cte_logs
WHERE
    num = prev AND num = next;
```

---

## Key Advantages of this Approach

1. **Efficient Filtering**:
   - Window functions allow direct row-by-row comparisons without requiring self-joins.

2. **Scalability**:
   - Handles large datasets with minimal overhead by using `LAG()` and `LEAD()`.

3. **Simplicity**:
   - The query logic is clear and easy to understand, ensuring maintainability.

This solution ensures accurate detection of numbers appearing consecutively three or more times, making it suitable for various use cases such as log analysis or pattern recognition.

