# Detailed Explanation: Finding Symmetric Pairs in a Table

---

## Step 1: Problem Breakdown

The task is to identify symmetric pairs \((X_1, Y_1)\) and \((X_2, Y_2)\) such that:

- \( X_1 = Y_2 \) and \( X_2 = Y_1 \)
- The output should list pairs in ascending order with \( X \leq Y \).

---

## Step 2: SQL Solution Explanation

### **Step 1: Assigning Row Numbers**

```sql
WITH func AS (
    SELECT
        *,
        ROW_NUMBER() OVER(ORDER BY x, y) AS row_num
    FROM
        functions f
)
```

#### **Explanation:**
- The `ROW_NUMBER()` function is used to provide a unique ID for each row.
- Sorting by `x, y` ensures consistent numbering.

---

### **Step 2: Finding Symmetric Pairs**

```sql
SELECT DISTINCT
    f1.x,
    f1.y
FROM
    func f1, func f2
WHERE
    f1.row_num != f2.row_num
    AND f1.x = f2.y
    AND f1.y = f2.x
    AND f1.x <= f1.y
ORDER BY
    f1.x, f1.y;
```

#### **Explanation:**

1. **Self-Join:** The table is joined with itself to compare values across rows.
2. **Symmetric Condition:**
   - `f1.x = f2.y` and `f1.y = f2.x` identify symmetric pairs.
3. **Avoid Self-Comparison:**
   - `f1.row_num != f2.row_num` ensures rows are not compared with themselves.
4. **Ensuring Order:**
   - The condition `f1.x <= f1.y` ensures the output is correctly ordered.
5. **Removing Duplicates:**
   - The `DISTINCT` keyword ensures no repeated symmetric pairs.

---

## Step 3: Example Execution

### **Given Input:**

| X  | Y  |
|----|----|
| 20 | 20 |
| 20 | 20 |
| 20 | 21 |
| 23 | 22 |
| 22 | 23 |
| 21 | 20 |

---

### **Processed Data with Row Numbers:**

| X  | Y  | row_num |
|----|----|---------|
| 20 | 20 | 1       |
| 20 | 20 | 2       |
| 20 | 21 | 3       |
| 23 | 22 | 4       |
| 22 | 23 | 5       |
| 21 | 20 | 6       |

---

### **Identified Symmetric Pairs:**

- (20, 21) ↔ (21, 20)
- (22, 23) ↔ (23, 22)
- (20, 20) ↔ (20, 20)

---

### **Final Ordered Output:**

| X  | Y  |
|----|----|
| 20 | 20 |
| 20 | 21 |
| 22 | 23 |

---

## Step 4: Edge Cases to Consider

1. **Handling Duplicate Pairs:** Ensure duplicates are removed.
2. **Handling Empty Table:** The query should return no rows.
3. **Handling Large Datasets:** Consider performance optimization.

---

## Step 5: Complexity Analysis

1. **Time Complexity:**
   - O(n²) due to the self-join operation.

2. **Space Complexity:**
   - O(n) due to the use of a CTE.

