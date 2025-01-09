# Calculate the Error in Average Salary Calculation

## Problem Statement
Samantha was tasked with calculating the average monthly salaries for all employees in the `EMPLOYEES` table. However, she unknowingly used salaries with all zeros removed in her calculation. Your task is to find the absolute error between her miscalculated average salary and the actual average salary. The error should be rounded up to the next integer.

---

## Table Schema

| Column | Type    | Description              |
|--------|---------|--------------------------|
| ID     | Integer | Unique identifier for an employee. |
| Name   | String  | Name of the employee.    |
| Salary | Integer | Monthly salary of the employee. |

---

## Example Input

**Input Table (`EMPLOYEES`):**

| ID  | Name      | Salary |
|-----|-----------|--------|
| 1   | Kristeen  | 1420   |
| 2   | Ashley    | 2006   |
| 3   | Julia     | 2210   |
| 4   | Maria     | 3000   |

**Samantha's Table with Zeros Removed:**

| ID  | Name      | Salary Without Zeros |
|-----|-----------|-----------------------|
| 1   | Kristeen  | 142                  |
| 2   | Ashley    | 26                   |
| 3   | Julia     | 221                  |
| 4   | Maria     | 3                    |

---

## Example Output

| Error |
|-------|
| 2061  |

---

## Constraints
- Salaries are guaranteed to be non-negative integers.
- The `REPLACE` function is used to remove zeros from salaries.