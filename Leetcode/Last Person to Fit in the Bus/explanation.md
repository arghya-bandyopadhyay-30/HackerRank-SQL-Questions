# Detailed Explanation: Finding the Last Person Who Can Board the Bus

This document explains a SQL query that identifies the last person in the queue who can board the bus without exceeding the total weight limit of 1000 kilograms. The solution uses window functions and filtering for efficient computation.

---

## Step-by-Step Breakdown

### **Step 1: Calculate Cumulative Weight Using `SUM()`**

```sql
sum(weight) OVER (
    ORDER BY turn
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS cum_sum
```

#### **Purpose**

Compute the cumulative sum of weights in the order of boarding (`turn`).

#### **Explanation**

- **`OVER` Clause**: Defines the window over which the function operates.
- **`ORDER BY turn`**: Ensures weights are summed in the order people board the bus.
- **`ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`**: Specifies the range of rows for calculation:
  - Starts from the first row (`UNBOUNDED PRECEDING`).
  - Includes the current row (`CURRENT ROW`).
- **`SUM(weight)`**: Adds up the weights within the specified range.

#### **Result**

The cumulative sum (`cum_sum`) tracks the total weight of all people who have boarded the bus up to the current person.

---

### **Step 2: Use a Subquery to Compute Cumulative Weight**

```sql
SELECT
    *,
    sum(weight) OVER (ORDER BY turn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cum_sum
FROM
    Queue
```

#### **Purpose**

Creates a temporary table with the following columns:

1. All original columns from the `Queue` table.
2. A new column, `cum_sum`, which holds the cumulative weight.

---

### **Step 3: Filter for Valid Records**

```sql
WHERE cum_sum <= 1000
```

#### **Purpose**

Include only those people who can board the bus without exceeding the weight limit of 1000 kilograms.

#### **Explanation**

- For each person, the cumulative weight (`cum_sum`) is checked against the limit.
- If adding the current person exceeds the limit, that person and everyone after them are excluded.

---

### **Step 4: Find the Last Person Who Can Board**

```sql
ORDER BY cum_sum DESC
LIMIT 1
```

#### **Purpose**

Identify the last person whose cumulative weight does not exceed the limit.

#### **Explanation**

- **`ORDER BY cum_sum DESC`**: Sorts the filtered results in descending order of cumulative weight.
- **`LIMIT 1`**: Retrieves the top record, which represents the last person who can board.

---

## Final Query

```sql
SELECT
    person_name
FROM
    (SELECT
         *,
         sum(weight) OVER (ORDER BY turn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cum_sum
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

### **Step 3: Order by `cum_sum DESC`**

| person_id | person_name | weight | turn | cum_sum |
|-----------|-------------|--------|------|---------|
| 6         | John Cena   | 400    | 3    | 1000    |
| 3         | Alex        | 350    | 2    | 600     |
| 5         | Alice       | 250    | 1    | 250     |

### **Step 4: Select the Top Record**

| person_name |
|-------------|
| John Cena   |

---

## Final Output

| person_name |
|-------------|
| John Cena   |

---

## Key Features of the Query

### **1. Cumulative Sum Tracking**
- The query dynamically calculates the cumulative weight using `SUM()` with a window function.
- This allows precise tracking of the total weight at each step in the queue.

### **2. Efficient Filtering**
- The `WHERE` clause ensures that only valid records (those not exceeding the weight limit) are considered.

### **3. Optimal Sorting**
- Sorting by `cum_sum DESC` ensures that the last person to board is identified efficiently.

### **4. Scalability**
- The solution handles large datasets effectively by leveraging window functions and limiting the result set to one record.