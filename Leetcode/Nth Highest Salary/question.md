# SQL Question

## Table: Employee

| Column Name | Type |
|-------------|------|
| id          | int  |
| salary      | int  |

### Primary Key
- `id` is the primary key.

### Description
- This table contains salary information for employees:
  - `id`: Unique identifier for each employee.
  - `salary`: Employee's salary.

---

### Problem
Write a SQL function to find the `nth` highest salary from the `Employee` table. If there is no `nth` highest salary, return `null`.

---

### Example 1

#### Input:
| id | salary |
|----|--------|
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |

**n = 2**

#### Output:
| getNthHighestSalary(2) |
|------------------------|
| 200                    |

---

### Example 2

#### Input:
| id | salary |
|----|--------|
| 1  | 100    |

**n = 2**

#### Output:
| getNthHighestSalary(2) |
|------------------------|
| null                   |

---

### Constraints
- The function should return `null` if `n` exceeds the number of distinct salaries.
- Salaries may contain duplicates.
