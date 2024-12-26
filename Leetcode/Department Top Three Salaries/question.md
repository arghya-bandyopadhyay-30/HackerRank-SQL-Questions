# Department Top Three Salaries

## Table: Employee

| Column Name  | Type    |
|--------------|---------|
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |

### Primary Key
- `id` is the primary key.

### Description
- The table contains the following information:
  - `id`: Unique identifier for each employee.
  - `name`: Name of the employee.
  - `salary`: Salary of the employee.
  - `departmentId`: Foreign key linking to the `Department` table.

---

## Table: Department

| Column Name | Type    |
|-------------|---------|
| id          | int     |
| name        | varchar |

### Primary Key
- `id` is the primary key.

### Description
- The table contains the following information:
  - `id`: Unique identifier for each department.
  - `name`: Name of the department.

---

### Problem
Find the employees who are high earners in each department. A high earner in a department is an employee whose salary ranks in the top three unique salaries for that department.

---

### Example Input
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
| id | name  |
|----|-------|
| 1  | IT    |
| 2  | Sales |

---

### Example Output
| Department | Employee | Salary |
|------------|----------|--------|
| IT         | Max      | 90000  |
| IT         | Joe      | 85000  |
| IT         | Randy    | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |

---

### Explanation
- In the **IT department**:
  - Max earns the highest unique salary.
  - Joe and Randy share the second-highest unique salary.
  - Will earns the third-highest unique salary.
- In the **Sales department**:
  - Henry earns the highest salary.
  - Sam earns the second-highest salary.
  - There is no third-highest salary as only two employees exist in this department.
