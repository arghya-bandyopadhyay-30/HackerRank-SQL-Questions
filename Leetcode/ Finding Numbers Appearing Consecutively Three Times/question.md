# Find Consecutive Numbers Appearing at Least Three Times

## Problem Statement

You are given a table `Logs` containing a series of numbers with their unique IDs. Write a query to find all numbers that appear consecutively at least three times.

---

## Table Schema

### Logs Table
| Column Name | Type    | Description                                       |
|-------------|---------|---------------------------------------------------|
| id          | int     | Unique identifier for each log entry.             |
| num         | varchar | The number that appears in the log entry.         |

- `id` is the primary key and is an auto-increment column starting from 1.

---

## Output Format

The result table should include the following column:
1. `ConsecutiveNums`: The numbers that appear at least three times consecutively.

### Result Table
| Column Name     | Type    | Description                          |
|-----------------|---------|--------------------------------------|
| ConsecutiveNums | varchar | Numbers appearing three times consecutively. |

---

## Example Input

### Logs Table:
| id | num |
|----|-----|
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |

---

## Example Output

| ConsecutiveNums |
|-----------------|
| 1               |

---

## Explanation

1. The number `1` appears consecutively three times at `id = 1, 2, 3`.
2. No other number appears three times consecutively.
