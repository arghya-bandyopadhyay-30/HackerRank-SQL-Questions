# Detailed Explanation: Swapping Gender Values in SQL

This document provides an in-depth breakdown of the query used to swap gender values in the `Salary` table.

---

## Step-by-Step Breakdown

### **Step 1: Understanding the Problem**
The `sex` column contains ENUM values (`'m'` and `'f'`). We need to swap these values in a single `UPDATE` query without using temporary tables.

---

### **Step 2: Updating the `sex` Column**

```sql
UPDATE
    Salary
SET
    sex = CASE
        WHEN sex = 'm' THEN 'f'
        WHEN sex = 'f' THEN 'm'
    END;
```

#### **Explanation of the Logic:**

1. **`UPDATE Salary`**: Specifies the table we are modifying.
2. **`SET sex = CASE`**:
   - Evaluates each row and changes values accordingly.
   - When `sex = 'm'`, it changes to `'f'`.
   - When `sex = 'f'`, it changes to `'m'`.

---

### **Step 3: Execution Flow**

1. The database scans all rows in the `Salary` table.
2. For each row, the `CASE` condition is evaluated.
3. If the current value is `'m'`, it is updated to `'f'`, and vice versa.
4. The table is updated in place without the need for intermediate tables.

---

### **Step 4: Example Execution**

#### **Initial Data**

| id | name | sex | salary |
|----|------|-----|--------|
| 1  | A    | m   | 2500   |
| 2  | B    | f   | 1500   |
| 3  | C    | m   | 5500   |
| 4  | D    | f   | 500    |

#### **Process**

| Row | Initial | Updated |
|-----|---------|---------|
| 1   | m       | f       |
| 2   | f       | m       |
| 3   | m       | f       |
| 4   | f       | m       |

#### **Final Data**

| id | name | sex | salary |
|----|------|-----|--------|
| 1  | A    | f   | 2500   |
| 2  | B    | m   | 1500   |
| 3  | C    | f   | 5500   |
| 4  | D    | m   | 500    |

---

### **Step 5: Edge Cases to Consider**

1. **Empty Table**: The query will not update any rows.
2. **All values are the same**: All rows will be updated to the opposite gender.
3. **Large dataset**: Query performance should be considered.

---

### **Step 6: Performance Considerations**

1. **Execution Time**: The update runs in O(n) time complexity.
2. **Indexes**: If an index exists on the `sex` column, updates may take longer.
3. **Transactional Integrity**: Use within a transaction to ensure consistency in large updates.

---

## Alternative Solutions

### **1. Using Boolean Logic for Swapping**

```sql
UPDATE Salary
SET sex = IF(sex = 'm', 'f', 'm');
```

- **Pros:**
  - Concise and readable.
  - Efficient for databases supporting `IF` function.

---

### **2. Using XOR Trick (for MySQL ENUM Values)**

```sql
UPDATE Salary
SET sex = CHAR(ASCII(sex) ^ 1);
```

- **Pros:**
  - Uses bitwise XOR operation to swap ASCII values of 'm' and 'f'.
  - Efficient and performant for ENUM columns.

---

## Summary

- The query efficiently swaps gender values without temporary tables.
- The `CASE` statement provides flexibility and readability.
- The solution is scalable and works for all edge cases.

