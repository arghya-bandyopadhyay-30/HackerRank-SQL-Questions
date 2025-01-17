# SQL Question

## Table: Salary

| Column Name | Type    |
|-------------|---------|
| id          | int     |
| name        | varchar |
| sex         | ENUM    |
| salary      | int     |

### Primary Key
- `id` is the primary key.

### Description
- This table contains the following information about employees:
  - `id`: Unique identifier for each employee.
  - `name`: Name of the employee.
  - `sex`: ENUM value of type (`'m'`, `'f'`) representing gender.
  - `salary`: The salary of the employee.

---

### Problem
Write a single `UPDATE` statement to swap all `'f'` and `'m'` values in the `sex` column without using any intermediate temporary tables.

- If the value is `'m'`, it should be changed to `'f'`.
- If the value is `'f'`, it should be changed to `'m'`.

**Constraints:**
- Only one `UPDATE` statement should be used.
- No `SELECT` statements or temporary tables are allowed.

---

### Example Input

#### Salary Table (Before Update)
| id | name | sex | salary |
|----|------|-----|--------|
| 1  | A    | m   | 2500   |
| 2  | B    | f   | 1500   |
| 3  | C    | m   | 5500   |
| 4  | D    | f   | 500    |

---

### Example Output

#### Salary Table (After Update)
| id | name | sex | salary |
|----|------|-----|--------|
| 1  | A    | f   | 2500   |
| 2  | B    | m   | 1500   |
| 3  | C    | f   | 5500   |
| 4  | D    | m   | 500    |

---

### Explanation
- Employees with `sex = 'm'` (ID 1, 3) are changed to `f`.
- Employees with `sex = 'f'` (ID 2, 4) are changed to `m`.
