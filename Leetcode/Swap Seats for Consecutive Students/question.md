# Swap Seats for Consecutive Students

## Problem Statement

You are given a table `Seat` containing the IDs and names of students. The IDs start from 1 and increment continuously. Write a query to swap the `id` of every two consecutive students. If the number of students is odd, the ID of the last student remains unchanged.

---

## Table Schema

### Seat Table
| Column Name | Type    | Description                          |
|-------------|---------|--------------------------------------|
| id          | int     | Unique ID of the student.           |
| student     | varchar | Name of the student.                |

- `id` is the primary key.

---

## Output Format

The result table should include the following columns:
1. `id`: The ID of the seat.
2. `student`: The name of the student after swapping.

### Result Table
| Column Name | Type    | Description                              |
|-------------|---------|------------------------------------------|
| id          | int     | ID of the seat.                         |
| student     | varchar | Name of the student after swapping.      |

---

## Example Input

### Seat Table:
| id | student |
|----|---------|
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |

---

## Example Output

| id | student |
|----|---------|
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |

---

## Explanation

1. Students with consecutive IDs have their names swapped:
   - ID `1` swaps with ID `2`.
   - ID `3` swaps with ID `4`.

2. The last student (`Jeames` with ID `5`) does not swap, as the number of students is odd.

### Swapping Logic:
- For odd IDs: Replace the student with the name of the next student.
- For even IDs: Replace the student with the name of the previous student.

### Output:
| id | student |
|----|---------|
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |
