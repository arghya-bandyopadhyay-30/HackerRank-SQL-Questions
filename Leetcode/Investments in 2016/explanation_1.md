# Solution 1: Explanation and Implementation

This document provides a detailed explanation of the SQL solution to calculate the total investment values (`tiv_2016`) for specific policyholders meeting the given criteria. The solution utilizes **Common Table Expressions (CTEs)** for modular and efficient query design.

---

## Problem Statement

We are tasked with summing the total investment values (`tiv_2016`) for policyholders who:
1. Have the same `tiv_2015` value as one or more other policyholders.
2. Are located in a unique city (i.e., no other policyholder shares their `lat` and `lon` values).

The result must be rounded to two decimal places.

---

## Solution Design

The solution uses **CTEs** to break the problem into smaller steps, ensuring modularity and ease of understanding.

### Step-by-Step Explanation

### **Step 1: Create a CTE `Insurance_location`**

```sql
WITH Insurance_location AS (
    SELECT
        pid,
        tiv_2015,
        tiv_2016,
        CONCAT(lat, ", ", lon) AS location
    FROM
        Insurance
)
```
- **Purpose**: Extract key fields (`pid`, `tiv_2015`, `tiv_2016`) from the `Insurance` table.
- **Key Transformation**: Combine `lat` and `lon` into a single string, `location`, for easier grouping and filtering.

---

### **Step 2: Create a CTE `location_count`**

```sql
location_count AS (
    SELECT
        location,
        COUNT(location) AS loc_count
    FROM
        Insurance_location
    GROUP BY
        location
)
```
- **Purpose**: Count how many policyholders share the same `location`.
- **Output**: `loc_count` column indicates the number of policyholders at each location.
- **Key Filter**: Later, we use `loc_count = 1` to ensure the location is unique.

---

### **Step 3: Create a CTE `tiv_2015_count`**

```sql
tiv_2015_count AS (
    SELECT
        tiv_2015,
        COUNT(tiv_2015) AS tiv_count
    FROM
        Insurance_location
    GROUP BY
        tiv_2015
)
```
- **Purpose**: Count how many policyholders share the same `tiv_2015` value.
- **Output**: `tiv_count` column indicates the number of policyholders with the same `tiv_2015`.
- **Key Filter**: Later, we use `tiv_count > 1` to include only shared `tiv_2015` values.

---

### **Step 4: Combine the CTEs and Apply Filters**

```sql
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
```

#### **Step-by-Step Execution**:

1. **Join `Insurance_location` with `location_count`**:
   - Adds `loc_count` to each record, ensuring we can filter by unique locations.
2. **Join `Insurance_location` with `tiv_2015_count`**:
   - Adds `tiv_count` to each record, ensuring we can filter by shared `tiv_2015` values.
3. **Apply Filters**:
   - `tiv_count > 1`: Includes only policyholders sharing `tiv_2015` with others.
   - `loc_count = 1`: Includes only policyholders in unique locations.
4. **Calculate Sum**:
   - Use `SUM(tiv_2016)` to calculate the total investment value for the filtered records.
5. **Round the Result**:
   - Use `ROUND()` to format the output to two decimal places.

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

1. **Policyholders with Shared `tiv_2015`**:
   - `tiv_2015 = 10` is shared by records 1, 3, and 4.

2. **Unique Locations**:
   - Unique `(lat, lon)` pairs: `(10, 10)` (record 1) and `(40, 40)` (record 4).

3. **Filtered Records**:
   - Records meeting both criteria: 1 and 4.

#### **Output**:

| tiv_2016 |
|----------|
| 45.00    |

---

## Key Points

1. **Modular Design**:
   - The use of CTEs simplifies the query, making it easier to understand and debug.

2. **Accurate Filtering**:
   - `GROUP BY` and `COUNT()` ensure that only records meeting the conditions are included.

3. **Formatted Output**:
   - The `ROUND()` function ensures the result is displayed with two decimal places.

---

## Final Query

```sql
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
```