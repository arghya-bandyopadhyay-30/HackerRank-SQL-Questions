# Solution 2: Explanation and Implementation

This document explains a solution to calculate the total investment values (`tiv_2016`) for specific policyholders meeting the given criteria. The solution uses **nested subqueries** for a concise and direct approach.

---

## Problem Statement

We need to calculate the sum of `tiv_2016` values for policyholders who:
1. Share the same `tiv_2015` value with one or more other policyholders.
2. Are located in unique cities (i.e., no other policyholder shares their `lat` and `lon` values).

The result must be rounded to two decimal places.

---

## Solution Design

This solution uses **nested subqueries** to filter records directly, avoiding the need for intermediate tables or Common Table Expressions (CTEs).

### Step-by-Step Explanation

### **Step 1: Identify `tiv_2015` Shared by Multiple Policyholders**

```sql
SELECT
    tiv_2015
FROM
    Insurance
GROUP BY
    tiv_2015
HAVING
    COUNT(*) > 1
```

- **Purpose**: Find `tiv_2015` values that are shared by more than one policyholder.
- **Explanation**:
  - The `GROUP BY` groups records by `tiv_2015`.
  - The `HAVING COUNT(*) > 1` ensures that only those values with more than one occurrence are included.

---

### **Step 2: Identify Unique Locations**

```sql
SELECT
    lat, lon
FROM
    Insurance
GROUP BY
    lat, lon
HAVING
    COUNT(*) = 1
```

- **Purpose**: Identify `(lat, lon)` pairs that are unique.
- **Explanation**:
  - The `GROUP BY` groups records by `lat` and `lon`.
  - The `HAVING COUNT(*) = 1` ensures that only unique locations (no duplicates) are included.

---

### **Step 3: Combine the Conditions in the Main Query**

```sql
SELECT
    ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM
    Insurance
WHERE
    tiv_2015 IN (
        SELECT
            tiv_2015
        FROM
            Insurance
        GROUP BY
            tiv_2015
        HAVING
            COUNT(*) > 1
    )
    AND
    (lat, lon) IN (
        SELECT
            lat, lon
        FROM
            Insurance
        GROUP BY
            lat, lon
        HAVING
            COUNT(*) = 1
    );
```

#### **Step-by-Step Execution**:

1. **Filter Records with Shared `tiv_2015` Values**:
   - The `tiv_2015 IN (...)` clause filters for policyholders with `tiv_2015` values shared by multiple records.

2. **Filter Records with Unique Locations**:
   - The `(lat, lon) IN (...)` clause filters for policyholders with unique `(lat, lon)` pairs.

3. **Calculate the Sum of `tiv_2016`**:
   - The `SUM(tiv_2016)` computes the total of `tiv_2016` values for the filtered records.

4. **Round the Result**:
   - The `ROUND()` function ensures the output is rounded to two decimal places.

---

### Example Walkthrough

#### **Input Table**:

| pid | tiv_2015 | tiv_2016 | lat  | lon  |
|-----|----------|----------|------|------|
| 1   | 10       | 5        | 10   | 10   |
| 2   | 20       | 20       | 20   | 20   |
| 3   | 10       | 30       | 20   | 20   |
| 4   | 10       | 40       | 40   | 40   |

#### **Intermediate Results**:

1. **Shared `tiv_2015` Values**:
   - Subquery Result: `{10}`.

2. **Unique Locations**:
   - Subquery Result: `{(10, 10), (40, 40)}`.

3. **Filtered Records**:
   - Matching both conditions: Records 1 and 4.

#### **Output**:

| tiv_2016 |
|----------|
| 45.00    |

---

## Key Points

1. **Concise Design**:
   - This solution avoids intermediate tables or CTEs, making it compact and efficient.

2. **Accurate Filtering**:
   - The `HAVING` clauses in the subqueries ensure precise filtering of shared and unique values.

3. **Formatted Output**:
   - The `ROUND()` function guarantees the result meets the required precision.

---

## Comparison with Solution 1

| Feature                | Solution 1 (CTE)         | Solution 2 (Subqueries)  |
|------------------------|--------------------------|--------------------------|
| **Modularity**         | High                    | Moderate                 |
| **Conciseness**        | Moderate                | High                     |
| **Ease of Debugging**  | High (modular steps)    | Moderate (direct steps)  |
| **Performance**        | Similar (depends on DB) | Similar (depends on DB)  |

Both solutions produce the same result: **45.00**.