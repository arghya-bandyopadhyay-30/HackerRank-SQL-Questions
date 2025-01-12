# Finding Employees' Primary Departments Using Window Functions

This solution utilizes **Common Table Expressions (CTEs)** and **Window Functions** to identify the primary department for each employee. The query ensures correctness in the following scenarios:

1. **Employees with multiple departments**: Select the department where `primary_flag = 'Y'`.
2. **Employees with only one department**: Automatically treat that department as the primary department, irrespective of the `primary_flag`.

---

## Step-by-Step Explanation

### Step 1: Define a Common Table Expression (CTE)
The CTE (`filtered_emp`) calculates the total number of departments each employee is associated with. This is achieved using the `COUNT()` function as a window function, partitioned by `employee_id`.

#### Query:
```sql
WITH filtered_emp AS (
    SELECT
        employee_id,
        department_id,
        primary_flag,
        COUNT(department_id) OVER (PARTITION BY employee_id) AS dept_count
    FROM
        Employee
)
```

#### Example Output of `filtered_emp`:
| employee_id | department_id | primary_flag | dept_count |
|-------------|---------------|--------------|------------|
| 1           | 1             | N            | 1          |
| 2           | 1             | Y            | 2          |
| 2           | 2             | N            | 2          |
| 3           | 3             | N            | 1          |
| 4           | 2             | N            | 3          |
| 4           | 3             | Y            | 3          |
| 4           | 4             | N            | 3          |

---

### Step 2: Filter for Primary Departments

The final query uses a `WHERE` clause to determine the primary department for each employee:

- **Employees with multiple departments (`dept_count > 1`)**:
  Select the department where `primary_flag = 'Y'`.
  - Example: Employee 2 has two departments (1 and 2), and department 1 is marked as primary.

- **Employees with a single department (`dept_count = 1`)**:
  Automatically select their only department as the primary department.
  - Example: Employee 1 has only department 1.

#### Query:
```sql
SELECT
    employee_id,
    department_id
FROM
    filtered_emp
WHERE
    (dept_count > 1 AND primary_flag = 'Y')
    OR dept_count = 1;
```

---

## Example Walkthrough

### Input Data:
| employee_id | department_id | primary_flag |
|-------------|---------------|--------------|
| 1           | 1             | N            |
| 2           | 1             | Y            |
| 2           | 2             | N            |
| 3           | 3             | N            |
| 4           | 2             | N            |
| 4           | 3             | Y            |
| 4           | 4             | N            |

### Step 1: Compute `dept_count` for Each Employee
| employee_id | department_id | primary_flag | dept_count |
|-------------|---------------|--------------|------------|
| 1           | 1             | N            | 1          |
| 2           | 1             | Y            | 2          |
| 2           | 2             | N            | 2          |
| 3           | 3             | N            | 1          |
| 4           | 2             | N            | 3          |
| 4           | 3             | Y            | 3          |
| 4           | 4             | N            | 3          |

### Step 2: Apply Filters
#### Employees:
1. **Employee 1**:
   - Only one department (`dept_count = 1`).
   - Selected department: 1.

2. **Employee 2**:
   - Two departments (`dept_count = 2`).
   - Department 1 is marked as primary (`primary_flag = 'Y'`).
   - Selected department: 1.

3. **Employee 3**:
   - Only one department (`dept_count = 1`).
   - Selected department: 3.

4. **Employee 4**:
   - Three departments (`dept_count = 3`).
   - Department 3 is marked as primary (`primary_flag = 'Y'`).
   - Selected department: 3.

### Final Output:
| employee_id | department_id |
|-------------|---------------|
| 1           | 1             |
| 2           | 1             |
| 3           | 3             |
| 4           | 3             |

---

## Summary

This query effectively handles:
1. Employees with multiple departments by relying on the `primary_flag`.
2. Employees with a single department by automatically assigning that department as primary.

### Benefits of Using CTEs and Window Functions:
- **Clarity**: Breaking down complex logic into intermediate steps.
- **Efficiency**: Avoids repetitive aggregations by computing `dept_count` once.
- **Scalability**: Handles large datasets efficiently by leveraging window functions.

This approach ensures accurate and efficient determination of primary departments for employees in any organization.

