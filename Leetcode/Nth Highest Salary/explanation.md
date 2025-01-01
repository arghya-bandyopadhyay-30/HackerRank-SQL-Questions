# Detailed Explanation: Find Nth Highest Salary

This document provides a thorough explanation of the solution to finding the `nth` highest salary from the `Employee` table.

---

## Step 1: Handle Input Adjustment

```sql
SET N = N - 1;
```

#### **Purpose**
Since SQL uses zero-based indexing when using `LIMIT` and `OFFSET`, we decrement `N` by 1.
- If `N=2`, the offset should be `1` to correctly get the second highest salary.

---

## Step 2: Select Distinct Salaries

```sql
SELECT DISTINCT(salary)
FROM Employee
ORDER BY salary DESC
```

#### **Purpose**
- **`DISTINCT(salary)`**: Ensures duplicate salary values are ignored.
- **`ORDER BY salary DESC`**: Sorts the salaries from highest to lowest.

#### **Example Sorted Salaries:**

| salary |
|--------|
| 300    |
| 200    |
| 100    |

---

## Step 3: Limit and Offset

```sql
LIMIT 1 OFFSET N;
```

#### **Purpose**
- **`LIMIT 1`**: Selects only one record.
- **`OFFSET N`**: Skips `N` rows, effectively retrieving the `N+1`th row.

#### **Example when N=2:**

| Offset 1 | Values |
|----------|--------|
| 1        | 200    |

---

## Example Execution

### **Example 1: Valid Input**

#### **Input:**

| id | salary |
|----|--------|
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |

#### **Execution Steps:**
1. Sorted distinct salaries: `[300, 200, 100]`
2. Offset 1: `[200, 100]`
3. Limit 1: `200`

#### **Output:**
```
200
```

---

### **Example 2: Non-Existent Salary**

#### **Input:**

| id | salary |
|----|--------|
| 1  | 100    |

#### **Execution Steps:**
1. Sorted distinct salaries: `[100]`
2. Offset 1: `[]` (empty set)
3. Limit 1: `null`

#### **Output:**
```
null
```

---

## Key Considerations

### **1. Zero-Based Indexing**
- SQL offsets start from `0`, so the function adjusts `N` accordingly.

### **2. Handling Duplicates**
- Using `DISTINCT` ensures unique salary values are considered.

### **3. Returning Null**
- If `N` exceeds the number of salaries, the function gracefully returns `null`.

### **4. Performance Optimization**
- Adding an index on `salary` improves query performance for large datasets.

---

## Alternative Approaches

### **1. Using Subqueries**

```sql
SELECT salary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rank
    FROM Employee
) ranked_salaries
WHERE rank = N;
```

#### **Explanation:**
- Uses `DENSE_RANK()` to assign ranks to distinct salaries.
- Filters the rank to retrieve the `N`th highest salary.

---

### **2. Using Common Table Expressions (CTE)**

```sql
WITH RankedSalaries AS (
    SELECT DISTINCT salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS rank
    FROM Employee
)
SELECT salary
FROM RankedSalaries
WHERE rank = N;
```

#### **Explanation:**
- The CTE assigns unique ranks to distinct salaries.
- The query retrieves the `N`th highest salary using the rank filter.

---

## Performance Considerations

1. **Indexing:**
   - Adding an index on the `salary` column can significantly speed up the query execution.

2. **Handling Large Datasets:**
   - Using ranking functions like `DENSE_RANK()` may be more efficient for larger tables compared to `LIMIT` and `OFFSET`.