# Group Consecutive Employees into Pairs

## Problem Statement
Given an input table `emp` with the following columns:
- `id` (integer): The unique identifier of the employee.
- `name` (character varying): The name of the employee.

Write an SQL query to group every two consecutive employees into a single row. The output should:
1. Concatenate the names of the two employees in a group into a single column named `result`.
2. Assign a unique group number to each pair in a column named `groups`.


## Example Input

**Input Table (`emp`):**

| id  | name  |
|-----|-------|
| 1   | Emp1  |
| 2   | Emp2  |
| 3   | Emp3  |
| 4   | Emp4  |
| 5   | Emp5  |
| 6   | Emp6  |
| 7   | Emp7  |
| 8   | Emp8  |


## Example Output

**Output Table:**

| result        | groups |
|---------------|--------|
| Emp1, Emp2    | 1      |
| Emp3, Emp4    | 2      |
| Emp5, Emp6    | 3      |
| Emp7, Emp8    | 4      |


## Constraints
- Each group must include exactly two employees.
- If there is an odd number of employees, the last group may contain a single employee.