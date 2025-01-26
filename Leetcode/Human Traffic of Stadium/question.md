# SQL Question

## Given Table: Stadium

| Column Name | Type |
|-------------|------|
| id          | int  |
| visit_date  | date |
| people      | int  |

### Table Properties:

- `visit_date` contains unique values.
- `id` increases as `visit_date` increases.

---

### Problem Statement

You are given a table `Stadium` containing information about stadium visits. Your task is to identify records where:

1. There are **three or more consecutive `id` values**, and
2. The number of people (`people`) is **greater than or equal to 100** for each row.

**Requirements:**
- Return all such records ordered by `visit_date` in ascending order.

---

### Example Input

#### Stadium Table:

| id  | visit_date | people |
|-----|------------|--------|
| 1   | 2017-01-01  | 10     |
| 2   | 2017-01-02  | 109    |
| 3   | 2017-01-03  | 150    |
| 4   | 2017-01-04  | 99     |
| 5   | 2017-01-05  | 145    |
| 6   | 2017-01-06  | 1455   |
| 7   | 2017-01-07  | 199    |
| 8   | 2017-01-09  | 188    |

---

### Example Output

| id  | visit_date | people |
|-----|------------|--------|
| 5   | 2017-01-05 | 145    |
| 6   | 2017-01-06 | 1455   |
| 7   | 2017-01-07 | 199    |
| 8   | 2017-01-09 | 188    |

---

### Explanation

1. The rows with `id` values `5, 6, 7, 8` meet the criteria of having at least 100 people and forming a consecutive `id` sequence.
2. The rows with `id` values `2, 3` do not meet the criteria since they do not form a sequence of at least three consecutive values.

---

### Constraints

- Assume the `id` values are always increasing in sequence without gaps.
- The output should be ordered by `visit_date`.