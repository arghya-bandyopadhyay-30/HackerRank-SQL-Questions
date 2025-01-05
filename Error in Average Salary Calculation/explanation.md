# README: Calculating the Error in Average Salary Calculation

## Overview
This query calculates the error between the actual average salary and a miscalculated average salary. The miscalculation occurs because Samantha's version removes zeros from salary values. The result is rounded up to the nearest integer.

---

## Step-by-Step Breakdown

### Step 1: **Removing Zeros from Salaries**

#### Purpose:
To simulate Samantha's mistake by removing all zeros from the salary values. A new column (`mis_sal`) is created for these modified values.

#### Query:
```sql
WITH miscalculate_salaries AS (
    SELECT 
        SALARY,
        CAST(REPLACE(CAST(SALARY AS CHAR), '0', '') AS SIGNED) AS mis_sal
    FROM EMPLOYEES
)
```

#### Explanation:
1. **Convert Salary to String:**
   ```sql
   CAST(SALARY AS CHAR)
   ```
   Converts the numeric salary into a string format so that the `REPLACE` function can process it.

2. **Remove Zeros:**
   ```sql
   REPLACE(CAST(SALARY AS CHAR), '0', '')
   ```
   Removes all occurrences of the digit `0` from the salary string.

3. **Convert Back to Integer:**
   ```sql
   CAST(... AS SIGNED)
   ```
   Converts the modified salary back into a numeric format for calculations.

---

### Step 2: **Calculate the Error Between Averages**

#### Purpose:
Calculate the difference between the actual average salary and the miscalculated average salary. The result is rounded up to the nearest integer using the `CEIL` function.

#### Query:
```sql
SELECT 
    CEIL(AVG(SALARY) - AVG(mis_sal)) AS error
FROM miscalculate_salaries;
```

#### Explanation:
1. **Calculate Actual Average Salary:**
   ```sql
   AVG(SALARY)
   ```
   Computes the actual average salary using the original data.

2. **Calculate Miscalculated Average Salary:**
   ```sql
   AVG(mis_sal)
   ```
   Computes the average salary using Samantha's version of the data (salaries without zeros).

3. **Find the Error:**
   ```sql
   AVG(SALARY) - AVG(mis_sal)
   ```
   Calculates the difference between the actual and miscalculated averages.

4. **Round Up the Result:**
   ```sql
   CEIL(...)
   ```
   Rounds up the result to the nearest integer.

---

## Final Query

#### Complete SQL Query:
```sql
WITH miscalculate_salaries AS (
    SELECT 
        SALARY,
        CAST(REPLACE(CAST(SALARY AS CHAR), '0', '') AS SIGNED) AS mis_sal
    FROM EMPLOYEES
)
SELECT 
    CEIL(AVG(SALARY) - AVG(mis_sal)) AS error
FROM miscalculate_salaries;
```

---

## Example Walkthrough

### Input Table:
| ID | Name     | Salary |
|----|----------|--------|
| 1  | Kristeen | 1420   |
| 2  | Ashley   | 2006   |
| 3  | Julia    | 2210   |
| 4  | Maria    | 3000   |

### Miscalculated Salaries:
| ID | Name     | Salary Without Zeros |
|----|----------|-----------------------|
| 1  | Kristeen | 142                   |
| 2  | Ashley   | 26                    |
| 3  | Julia    | 221                   |
| 4  | Maria    | 3                     |

### Average Calculations:
1. **Actual Average Salary:**
   ```
   (1420 + 2006 + 2210 + 3000) / 4 = 2159
   ```

2. **Miscalculated Average Salary:**
   ```
   (142 + 26 + 221 + 3) / 4 = 98
   ```

3. **Error:**
   ```
   2159 - 98 = 2061
   ```

### Output:
| Error |
|-------|
| 2061  |

---

## Summary
This query demonstrates how to handle miscalculated data effectively by:
- Simulating the data error using SQL functions (`REPLACE`, `CAST`).
- Computing averages for both original and modified data.
- Finding the difference and rounding up the result to the nearest integer using `CEIL`.
