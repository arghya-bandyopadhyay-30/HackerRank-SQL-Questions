# Swapping Seats of Consecutive Students

This document explains the SQL query that swaps the `id` of every two consecutive students in the `Seat` table. If the total number of students is odd, the ID of the last student remains unchanged.

## Problem Statement

The goal is to rearrange the `student` names in the `Seat` table such that:
1. For **odd IDs**: The student is replaced with the name of the next student.
2. For **even IDs**: The student is replaced with the name of the previous student.
3. The result table must preserve the `id` order.

## Approach

### Step 1: Use Window Functions
Window functions are used to access the next and previous rows in a seamless and efficient manner without requiring self-joins:

1. **`LEAD(student) OVER(ORDER BY id)`**:
   - Retrieves the name of the next student for the current row.
   - Used for swapping the names of students with odd `id`.

2. **`LAG(student) OVER(ORDER BY id)`**:
   - Retrieves the name of the previous student for the current row.
   - Used for swapping the names of students with even `id`.

3. **`IFNULL`**:
   - Ensures that rows with no next student (e.g., the last student in the table) retain their original name.

### Step 2: Write the CASE Logic
The `CASE` statement determines the new name for each row based on the `id`:

- **Condition**: `id % 2 = 1` (odd IDs):
  - Use the name of the next student (`LEAD`).

- **Condition**: `id % 2 = 0` (even IDs):
  - Use the name of the previous student (`LAG`).

### Final Query

```sql
SELECT
    id,
    CASE
        WHEN id % 2 = 1 THEN IFNULL(LEAD(student) OVER(ORDER BY id), student)
        ELSE LAG(student) OVER(ORDER BY id)
    END AS student
FROM
    Seat;
```

## Example Walkthrough

### Input Data

| id  | student  |
|------|----------|
| 1    | Abbot    |
| 2    | Doris    |
| 3    | Emerson  |
| 4    | Green    |
| 5    | Jeames   |

### Step 1: Apply `LEAD` and `LAG`

| id  | student  | next_student (LEAD) | prev_student (LAG) |
|------|----------|----------------------|----------------------|
| 1    | Abbot    | Doris               | NULL                 |
| 2    | Doris    | Emerson             | Abbot                |
| 3    | Emerson  | Green               | Doris                |
| 4    | Green    | Jeames              | Emerson              |
| 5    | Jeames   | NULL                | Green                |

### Step 2: Apply `CASE` Logic

| id  | student_before_swap | swapped_student |
|------|---------------------|-----------------|
| 1    | Abbot              | Doris           |
| 2    | Doris              | Abbot           |
| 3    | Emerson            | Green           |
| 4    | Green              | Emerson         |
| 5    | Jeames             | Jeames          |

### Final Output

| id  | student  |
|------|----------|
| 1    | Doris    |
| 2    | Abbot    |
| 3    | Green    |
| 4    | Emerson  |
| 5    | Jeames   |

## Key Concepts Used

1. **Window Functions**:
   - `LEAD()` and `LAG()` allow seamless access to the next and previous rows, enabling efficient swapping without requiring self-joins.

2. **Conditional Logic**:
   - The `CASE` statement ensures the correct swapping logic for odd and even IDs.

3. **Handling Edge Cases**:
   - `IFNULL` prevents errors when `LEAD` retrieves a `NULL` value for the last student.

## Benefits of This Approach

- Efficient query execution using window functions.
- Simplified logic with `CASE` and window functions.
- Handles edge cases like odd numbers of students seamlessly.

Use this query to easily swap consecutive student names while preserving the table's `id` order.

