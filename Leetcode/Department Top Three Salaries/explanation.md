# Detailed Explanation: Finding High Earners in Each Department

This document explains a SQL query that identifies employees who rank among the top three unique salaries in each department. The solution ensures that salary ties are handled properly and departments are ranked independently.

---

## Step-by-Step Breakdown

### **Step 1: Combine Employee and Department Data**

```sql
FROM
    Employee e
INNER JOIN
    Department d
ON
    e.departmentId = d.id
```

1. **INNER JOIN**: Combines data from the `Employee` and `Department` tables.
2. **Columns Used**:
   - `Employee` contains details about employees, including their salary and department ID.
   - `Department` contains the name of each department.
3. **ON Clause**: Ensures that each employee is matched with the corresponding department using `departmentId`.

---

### **Step 2: Assign Ranks Using DENSE_RANK()**

```sql
DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS rank
```

1. **DENSE_RANK()**:
   - Assigns a rank to each employee based on their salary within their department.
   - Employees with the same salary receive the same rank.
   - Unlike `RANK()`, there are no gaps in ranking for ties.

2. **Ranking Example**:
   - If salaries in a department are `90000, 85000, 85000, 70000`, the ranks will be `1, 2, 2, 3`.

3. **OVER Clause**:
   - `PARTITION BY departmentId`: Groups the employees by department, ranking independently for each department.
   - `ORDER BY salary DESC`: Ensures that the highest salary in each department gets rank 1.

---

### **Step 3: Create a Temporary Table with Ranks**

```sql
WITH combined_table AS (
    SELECT
        d.name AS Department,
        e.name AS Employee,
        e.salary AS Salary,
        DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS rank
    FROM
        Employee e
    INNER JOIN
        Department d
    ON
        e.departmentId = d.id
)
```

1. **WITH Clause**:
   - Creates a Common Table Expression (CTE) named `combined_table` to store intermediate results.

2. **Columns in `combined_table`**:
   - `Department`: The name of the department.
   - `Employee`: The name of the employee.
   - `Salary`: The salary of the employee.
   - `rank`: The rank of the employee's salary within their department.

---

### **Step 4: Filter for Top 3 Ranks**

```sql
SELECT
    Department,
    Employee,
    Salary
FROM
    combined_table
WHERE
    rank <= 3;
```

1. **rank <= 3**:
   - Filters the results to include only employees with salaries ranked 1, 2, or 3 in their department.
   - Employees with lower ranks are excluded.

2. **Final Output Columns**:
   - `Department`: The name of the department.
   - `Employee`: The name of the employee.
   - `Salary`: The salary of the employee.

---

## Key Features of the Query

### **1. Handles Salary Ties**

- Employees with the same salary receive the same rank using `DENSE_RANK()`.
- Ensures that tied salaries are fairly considered as part of the top three.

### **2. Independent Department Ranking**

- The `PARTITION BY departmentId` ensures rankings are calculated separately for each department.

### **3. Efficient Filtering**

- The `WHERE rank <= 3` clause ensures only the relevant employees are included in the final result.

---

## Example Walkthrough

### **Input Data**

#### Employee Table
| id | name  | salary | departmentId |
|----|-------|--------|--------------|
| 1  | Joe   | 85000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
| 7  | Will  | 70000  | 1            |

#### Department Table
| id | name   |
|----|--------|
| 1  | IT     |
| 2  | Sales  |

### **Step-by-Step Execution**

#### **Step 1: Combine Data with INNER JOIN**

| Department | Employee | Salary | departmentId |
|------------|----------|--------|--------------|
| IT         | Joe      | 85000  | 1            |
| IT         | Max      | 90000  | 1            |
| IT         | Janet    | 69000  | 1            |
| IT         | Randy    | 85000  | 1            |
| IT         | Will     | 70000  | 1            |
| Sales      | Henry    | 80000  | 2            |
| Sales      | Sam      | 60000  | 2            |

#### **Step 2: Apply DENSE_RANK()**

| Department | Employee | Salary | rank |
|------------|----------|--------|------|
| IT         | Max      | 90000  | 1    |
| IT         | Joe      | 85000  | 2    |
| IT         | Randy    | 85000  | 2    |
| IT         | Will     | 70000  | 3    |
| IT         | Janet    | 69000  | 4    |
| Sales      | Henry    | 80000  | 1    |
| Sales      | Sam      | 60000  | 2    |

#### **Step 3: Filter for Top 3 Ranks**

| Department | Employee | Salary |
|------------|----------|--------|
| IT         | Max      | 90000  |
| IT         | Joe      | 85000  |
| IT         | Randy    | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |

---

## Final Output

| Department | Employee | Salary |
|------------|----------|--------|
| IT         | Max      | 90000  |
| IT         | Joe      | 85000  |
| IT         | Randy    | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |

---

## Key Considerations

### **1. Scalability**
- The query efficiently handles larger datasets using `DENSE_RANK()` and filtering.

### **2. Flexibility**
- The `rank <= 3` filter can be adjusted to include a different number of top earners.

### **3. Edge Cases**
- Departments with fewer than three unique salaries are handled naturally since the rank filter only includes existing ranks.

