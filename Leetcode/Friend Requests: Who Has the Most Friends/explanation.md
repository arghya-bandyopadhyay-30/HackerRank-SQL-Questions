# Detailed Explanation: Finding the Last Person Who Can Board the Bus

This document explains a SQL query that determines the name of the last person who can board the bus without exceeding the total weight limit of 1000 kilograms. The solution uses window functions and filtering to compute cumulative weights and efficiently identify the desired result.

---

## Step-by-Step Breakdown

### **Step 1: Calculate the Cumulative Weight**

```sql
SUM(weight) OVER (
    ORDER BY turn
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS cum_sum
```

#### **Purpose**
Compute the total weight of passengers as they board the bus in the order of `turn`.

#### **Explanation**
- **`SUM(weight)`**: Adds up the weights of all passengers within the specified range.
- **`OVER` Clause**:
  - **`ORDER BY turn`**: Ensures that weights are added sequentially based on the order of boarding (`turn`).
  - **`ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`**:
    - Starts from the first row (`UNBOUNDED PRECEDING`).
    - Includes the current row in the calculation.

#### **Result**
A cumulative sum (`cum_sum`) column is added to the dataset, tracking the total weight up to each person.

---

### **Step 2: Use a Subquery to Compute Cumulative Weights**

```sql
SELECT
    *,
    SUM(weight) OVER (ORDER BY turn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cum_sum
FROM
    Queue
```

#### **Purpose**
Create a temporary table containing:
1. All columns from the `Queue` table.
2. A new column, `cum_sum`, representing the cumulative weight.

---

### **Step 3: Filter for the Weight Limit**

```sql
WHERE cum_sum <= 1000
```

#### **Purpose**
Include only those passengers whose cumulative weight does not exceed the bus's limit of 1000 kilograms.

#### **Explanation**
- For each passenger, the cumulative weight is checked against the limit.
- If adding the current passenger exceeds the limit, they and everyone after them are excluded from consideration.

---

### **Step 4: Find the Last Person Who Can Board**

```sql
ORDER BY cum_sum DESC
LIMIT 1
```

#### **Purpose**
Identify the last person who can board the bus without exceeding the weight limit.

#### **Explanation**
- **`ORDER BY cum_sum DESC`**: Sorts the filtered results in descending order of cumulative weight.
- **`LIMIT 1`**: Retrieves the top record, which represents the last eligible passenger.

---

## Final Query

```sql
SELECT
    person_name
FROM
    (SELECT
         *,
         SUM(weight) OVER (ORDER BY turn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cum_sum
     FROM
         Queue
    ) AS cumulative_weights
WHERE
    cum_sum <= 1000
ORDER BY
    cum_sum DESC
LIMIT 1;
```

---

## Example Walkthrough

### **Input Data**

| person_id | person_name | weight | turn |
|-----------|-------------|--------|------|
| 5         | Alice       | 250    | 1    |
| 4         | Bob         | 175    | 5    |
| 3         | Alex        | 350    | 2    |
| 6         | John Cena   | 400    | 3    |
| 1         | Winston     | 500    | 6    |
| 2         | Marie       | 200    | 4    |

### **Step 1: Compute Cumulative Weight**

| person_id | person_name | weight | turn | cum_sum |
|-----------|-------------|--------|------|---------|
| 5         | Alice       | 250    | 1    | 250     |
| 3         | Alex        | 350    | 2    | 600     |
| 6         | John Cena   | 400    | 3    | 1000    |
| 2         | Marie       | 200    | 4    | 1200    |
| 4         | Bob         | 175    | 5    | 1375    |
| 1         | Winston     | 500    | 6    | 1875    |

### **Step 2: Filter for `cum_sum <= 1000`**

| person_id | person_name | weight | turn | cum_sum |
|-----------|-------------|--------|------|---------|
| 5         | Alice       | 250    | 1    | 250     |
| 3         | Alex        | 350    | 2    | 600     |
| 6         | John Cena   | 400    | 3    | 1000    |

### **Step 3: Sort by `cum_sum DESC` and Select Top Record**

| person_id | person_name | weight | turn | cum_sum |
|-----------|-------------|--------|------|---------|
| 6         | John Cena   | 400    | 3    | 1000    |

### **Final Output**

| person_name |
|-------------|
| John Cena   |

---

## Key Features of the Query

### **1. Cumulative Sum Tracking**
- The query uses a window function to dynamically calculate cumulative weight as passengers board the bus in sequence.

### **2. Efficient Filtering**
- The `WHERE cum_sum <= 1000` clause ensures only valid passengers are considered.

### **3. Optimal Sorting**
- Sorting by `cum_sum DESC` ensures the last eligible passenger is identified efficiently.

### **4. Scalable Solution**
- The approach handles larger datasets efficiently using window functions and limiting the result set to one record.