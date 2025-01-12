# Find Employees' Primary Departments

## Problem Statement

You are given a table `Employee` that contains information about employees and their associated departments. Each employee can belong to multiple departments, and for each department, there is a `primary_flag` that indicates whether the department is the employee's primary department.

Write a query to report the primary department for each employee. If an employee belongs to only one department, consider that department as their primary department, regardless of the `primary_flag`.

---

## Table Schema

### Employee Table
| Column Name   | Type    | Description                                                        |
|---------------|---------|--------------------------------------------------------------------|
| employee_id   | int     | The unique ID of the employee.                                     |
| department_id | int     | The unique ID of the department the employee belongs to.           |
| primary_flag  | varchar | Indicates if the department is primary (`'Y'` or `'N'`).           |

- `(employee_id, department_id)` is the primary key.

---

## Output Format

The result table should include the following columns:
1. `employee_id`: The unique ID of the employee.
2. `department_id`: The primary department for the employee.

### Result Table
| Column Name   | Type    | Description                                      |
|---------------|---------|--------------------------------------------------|
| employee_id   | int     | The unique ID of the employee.                   |
| department_id | int     | The ID of the employee's primary department.     |

---

## Example Input

### Employee Table:
| employee_id | department_id | primary_flag |
|-------------|---------------|--------------|
| 1           | 1             | N            |
| 2           | 1             | Y            |
| 2           | 2             | N            |
| 3           | 3             | N            |
| 4           | 2             | N            |
| 4           | 3             | Y            |
| 4           | 4             | N            |

---

## Example Output

| employee_id | department_id |
|-------------|---------------|
| 1           | 1             |
| 2           | 1             |
| 3           | 3             |
| 4           | 3             |

---

## Explanation

1. **Employee 1**:
   - Belongs to only one department (`1`), so it is their primary department.

2. **Employee 2**:
   - Belongs to departments `1` and `2`, with department `1` marked as primary (`primary_flag = 'Y'`).

3. **Employee 3**:
   - Belongs to only one department (`3`), so it is their primary department.

4. **Employee 4**:
   - Belongs to departments `2`, `3`, and `4`, with department `3` marked as primary (`primary_flag = 'Y'`).
