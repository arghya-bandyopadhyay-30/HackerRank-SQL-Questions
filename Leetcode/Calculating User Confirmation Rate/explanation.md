# Calculating User Confirmation Rate

This document explains how to calculate the confirmation rate for users based on data from the `Signups` and `Confirmations` tables. The confirmation rate is defined as the number of `confirmed` actions divided by the total number of confirmation requests. If a user has not made any confirmation requests, their confirmation rate is `0.00`.

---

## Key Concepts

### 1. Confirmation Rate
- **Formula**: `confirmation_rate = confirmed_count / total_count`
- If a user has no confirmation requests, their confirmation rate is `0.00`.

### 2. LEFT JOIN
- Includes all users from the `Signups` table, even if they have no rows in the `Confirmations` table.

### 3. NULL Handling
- For users with no confirmation requests, `total_count` will be `0`. This is handled by assigning a confirmation rate of `0.00`.

### 4. Rounding
- The confirmation rate is rounded to two decimal places for clarity.

---

## Step-by-Step Breakdown

### Step 1: Join the Tables
Perform a **LEFT JOIN** between `Signups` and `Confirmations` to get all users and their confirmation actions.

```sql
WITH join_table AS (
    SELECT
        s.user_id,
        c.action
    FROM
        Signups s
    LEFT JOIN
        Confirmations c
    ON
        s.user_id = c.user_id
)
```

#### Explanation:
- Ensures all users from `Signups` are included, even if they have no confirmation requests.
- Adds the `action` column (e.g., `confirmed` or `timeout`) from the `Confirmations` table.

#### Example Output:
| user_id | action   |
|---------|----------|
| 3       | timeout  |
| 3       | timeout  |
| 7       | confirmed|
| 7       | confirmed|
| 7       | confirmed|
| 2       | confirmed|
| 2       | timeout  |
| 6       | NULL     |

---

### Step 2: Count Confirmed Actions
Count the number of confirmed actions for each user.

```sql
WITH confirmed_count AS (
    SELECT
        user_id,
        COUNT(action) AS count
    FROM
        join_table
    WHERE
        action = 'confirmed'
    GROUP BY
        user_id
)
```

#### Explanation:
- Filters `join_table` to include only `confirmed` actions.
- Counts the number of `confirmed` actions for each user.

#### Example Output:
| user_id | count |
|---------|-------|
| 2       | 1     |
| 7       | 3     |

---

### Step 3: Count Total Actions
Count the total number of confirmation requests for each user.

```sql
WITH total_count AS (
    SELECT
        user_id,
        COUNT(action) AS total
    FROM
        join_table
    GROUP BY
        user_id
)
```

#### Explanation:
- Counts all actions (both `confirmed` and `timeout`) for each user.
- Includes users with no actions by ensuring they are part of `join_table`.

#### Example Output:
| user_id | total |
|---------|-------|
| 2       | 2     |
| 3       | 2     |
| 6       | 0     |
| 7       | 3     |

---

### Step 4: Calculate the Confirmation Rate
Use a **RIGHT JOIN** between `confirmed_count` and `total_count` to calculate the confirmation rate for each user.

```sql
SELECT
    t.user_id,
    CASE
        WHEN t.total = 0 THEN 0
        ELSE ROUND(COALESCE(c.count, 0) / t.total, 2)
    END AS confirmation_rate
FROM
    total_count t
LEFT JOIN
    confirmed_count c
ON
    t.user_id = c.user_id;
```

#### Explanation:
- Joins `confirmed_count` and `total_count` to ensure all users are included.
- Calculates the confirmation rate:
  - `confirmation_rate = count / total`
  - Assigns `0.00` if `total` is `0`.
- Rounds the confirmation rate to two decimal places.

#### Example Output:
| user_id | confirmation_rate |
|---------|-------------------|
| 6       | 0.00              |
| 3       | 0.00              |
| 7       | 1.00              |
| 2       | 0.50              |

---

## Final Query

```sql
WITH join_table AS (
    SELECT
        s.user_id,
        c.action
    FROM
        Signups s
    LEFT JOIN
        Confirmations c
    ON
        s.user_id = c.user_id
),
confirmed_count AS (
    SELECT
        user_id,
        COUNT(action) AS count
    FROM
        join_table
    WHERE
        action = 'confirmed'
    GROUP BY
        user_id
),
total_count AS (
    SELECT
        user_id,
        COUNT(action) AS total
    FROM
        join_table
    GROUP BY
        user_id
)
SELECT
    t.user_id,
    CASE
        WHEN t.total = 0 THEN 0
        ELSE ROUND(COALESCE(c.count, 0) / t.total, 2)
    END AS confirmation_rate
FROM
    total_count t
LEFT JOIN
    confirmed_count c
ON
    t.user_id = c.user_id;
```

---

## Example Walkthrough

### Input Data

#### `Signups` Table:
| user_id | time_stamp          |
|---------|---------------------|
| 3       | 2020-03-21 10:16:13 |
| 7       | 2020-01-04 13:57:59 |
| 2       | 2020-07-29 23:09:44 |
| 6       | 2020-12-09 10:39:37 |

#### `Confirmations` Table:
| user_id | time_stamp          | action   |
|---------|---------------------|----------|
| 3       | 2021-01-06 03:30:46 | timeout  |
| 3       | 2021-07-14 14:00:00 | timeout  |
| 7       | 2021-06-12 11:57:29 | confirmed|
| 7       | 2021-06-13 12:58:28 | confirmed|
| 7       | 2021-06-14 13:59:27 | confirmed|
| 2       | 2021-01-22 00:00:00 | confirmed|
| 2       | 2021-02-28 23:59:59 | timeout  |

### Output:
| user_id | confirmation_rate |
|---------|-------------------|
| 6       | 0.00              |
| 3       | 0.00              |
| 7       | 1.00              |
| 2       | 0.50              |

---

This query ensures that all users are included in the results and calculates their confirmation rate accurately, even if they have no confirmation requests.

