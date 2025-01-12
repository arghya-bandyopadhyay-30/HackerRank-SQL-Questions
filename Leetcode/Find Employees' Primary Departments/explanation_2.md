# Finding Employees' Primary Departments Using `EXISTS`

This query utilizes a **correlated subquery** with the `NOT EXISTS` clause to identify the primary department for each employee. It ensures accurate results for the following scenarios:

1. **Employees with multiple departments**: Select the department where `primary_flag = 'Y'`.
2. **Employees with only one department**: Automatically consider that department as the primary department, regardless of the `primary_flag`.

---

## Step-by-Step Explanation

### Step 1: Select Employees with a Primary Department

The first condition in the `WHERE` clause filters rows where the `primary_flag = 'Y'`. This selects employees who explicitly have a marked primary department.

#### Partial Query:
```sql
SELECT
    employee_id,
    department_id
FROM
    Employee e1
WHERE
    primary_flag = 'Y';
```

#### Example Output:
| employee_id | department_id |
|-------------|---------------|
| 2           | 1             |
| 4           | 3             |

---

### Step 2: Handle Employees with No Primary Department

The second condition (`NOT EXISTS`) addresses cases where an employee has no department with `primary_flag = 'Y'`. For such employees, the subquery ensures the inclusion of rows where:

1. No department exists for the same employee with `primary_flag = 'Y'.`
2. The current row is the default department for the employee.

#### Subquery Logic:
```sql
NOT EXISTS (
    SELECT
        1
    FROM
        Employee e2
    WHERE
        e2.employee_id = e1.employee_id
        AND e2.primary_flag = 'Y'
)
```

#### How It Works:

- For each row in the outer query (`e1`), the subquery (`e2`) checks for another department belonging to the same employee (`e2.employee_id = e1.employee_id`) where `primary_flag = 'Y'.`
- If no such department exists, the row is included in the result.

---

### Step 3: Combine Both Conditions

The query combines the two conditions (`primary_flag = 'Y'` and `NOT EXISTS`) using an `OR` operator:

- Include rows where the department is explicitly marked as primary (`primary_flag = 'Y'`).
- Include rows where no primary department exists for the employee.

#### Final Query:
```sql
SELECT
    employee_id,
    department_id
FROM
    Employee e1
WHERE
    primary_flag = 'Y'
    OR NOT EXISTS (
        SELECT
            1
        FROM
            Employee e2
        WHERE
            e2.employee_id = e1.employee_id
            AND e2.primary_flag = 'Y'
    );
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

### Step 1: Filter Rows with `primary_flag = 'Y'`
| employee_id | department_id |
|-------------|---------------|
| 2           | 1             |
| 4           | 3             |

### Step 2: Filter Rows with `NOT EXISTS`
For employees with no primary department:

- **Employee 1**:
  - Only one department (1) exists.
  - No primary department (`primary_flag = 'Y'` does not exist).
  - Include department 1.

- **Employee 3**:
  - Only one department (3) exists.
  - No primary department (`primary_flag = 'Y'` does not exist).
  - Include department 3.

### Step 3: Combine Results
| employee_id | department_id |
|-------------|---------------|
| 1           | 1             |
| 2           | 1             |
| 3           | 3             |
| 4           | 3             |

---

## Why This Approach is Efficient

1. **No Window Functions**: Direct filtering avoids the need for calculating additional metrics like `COUNT()` or window aggregates.
2. **Handles Edge Cases**: Employees with multiple departments and no primary department are correctly handled using the `NOT EXISTS` condition.
3. **Simplicity**: The query logic is straightforward and adaptable to various datasets.

This solution ensures accurate determination of primary departments for employees in any organizational structure.