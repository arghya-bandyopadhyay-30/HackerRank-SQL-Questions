# Calculate User Confirmation Rates

## Problem Statement
You are given two tables, `Signups` and `Confirmations`, containing information about user signups and their confirmation actions. Write an SQL query to calculate the confirmation rate for each user.

The confirmation rate of a user is calculated as:
```
confirmation_rate = number of 'confirmed' actions / total number of confirmation requests
```


If a user has not made any confirmation requests, their confirmation rate should be `0.00`.

---

## Table Schema

### Signups Table
| Column Name | Type     | Description                               |
|-------------|----------|-------------------------------------------|
| user_id     | int      | Unique identifier for the user.           |
| time_stamp  | datetime | The timestamp when the user signed up.    |

- `user_id` is the primary key.

### Confirmations Table
| Column Name | Type     | Description                                |
|-------------|----------|--------------------------------------------|
| user_id     | int      | The ID of the user who requested a confirmation. |
| time_stamp  | datetime | The timestamp of the confirmation request. |
| action      | ENUM     | Status of the confirmation (`'confirmed'` or `'timeout'`). |

- `(user_id, time_stamp)` is the primary key.
- `user_id` is a foreign key referencing the `user_id` column in the `Signups` table.

---

## Output Format

The output should include the following columns:
1. `user_id`: The ID of the user.
2. `confirmation_rate`: The confirmation rate for the user, rounded to two decimal places.

### Result Table
| Column Name        | Type    | Description                          |
|--------------------|---------|--------------------------------------|
| user_id            | int     | The ID of the user.                 |
| confirmation_rate  | decimal | The confirmation rate of the user.  |

---

## Constraints

1. A user with no confirmation requests has a confirmation rate of `0.00`.
2. Round the confirmation rate to two decimal places.
3. Return the result in any order.

---

## Example Input

### Signups Table:
| user_id | time_stamp          |
|---------|---------------------|
| 3       | 2020-03-21 10:16:13 |
| 7       | 2020-01-04 13:57:59 |
| 2       | 2020-07-29 23:09:44 |
| 6       | 2020-12-09 10:39:37 |

### Confirmations Table:
| user_id | time_stamp          | action    |
|---------|---------------------|-----------|
| 3       | 2021-01-06 03:30:46 | timeout   |
| 3       | 2021-07-14 14:00:00 | timeout   |
| 7       | 2021-06-12 11:57:29 | confirmed |
| 7       | 2021-06-13 12:58:28 | confirmed |
| 7       | 2021-06-14 13:59:27 | confirmed |
| 2       | 2021-01-22 00:00:00 | confirmed |
| 2       | 2021-02-28 23:59:59 | timeout   |

---

## Example Output

| user_id | confirmation_rate |
|---------|-------------------|
| 6       | 0.00              |
| 3       | 0.00              |
| 7       | 1.00              |
| 2       | 0.50              |

---

## Explanation

### For Each User:
1. **User 6**:
   - No confirmation requests were made.
   - Confirmation rate: `0.00`.

2. **User 3**:
   - Made 2 confirmation requests, both of which timed out.
   - Confirmation rate: `0.00`.

3. **User 7**:
   - Made 3 confirmation requests, all of which were confirmed.
   - Confirmation rate: \( \frac{3}{3} = 1.00 \).

4. **User 2**:
   - Made 2 confirmation requests: 1 confirmed and 1 timeout.
   - Confirmation rate: \( \frac{1}{2} = 0.50 \).

### Output:
| user_id | confirmation_rate |
|---------|-------------------|
| 6       | 0.00              |
| 3       | 0.00              |
| 7       | 1.00              |
| 2       | 0.50              |

---

## Notes

- Use a `LEFT JOIN` to include users with no confirmation requests.
- Round the confirmation rate to two decimal places.
- Handle cases where the total confirmation count is `0` by setting the confirmation rate to `0.00`.
