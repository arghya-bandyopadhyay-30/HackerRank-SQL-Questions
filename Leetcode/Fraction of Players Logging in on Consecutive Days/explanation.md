# Explanation for Fraction of Players Logging in on Consecutive Days

This query calculates the fraction of players who logged in on the day after their first login, rounded to 2 decimal places.

---

## Key Concepts

1. **First Login Date**:
   - Identify the first login date for each player using the `MIN()` function with a `WINDOW` function (`OVER` clause).
   
2. **Date Difference**:
   - Calculate the difference in days between each `event_date` and the first login date for the player using `DATEDIFF()`.

3. **Filter Consecutive Logins**:
   - Check if there is any record where the difference in days (`date_diff`) is `1`.

4. **Calculate Fraction**:
   - Count the number of players who logged in on consecutive days (`date_diff = 1`).
   - Divide this count by the total number of distinct players.
   - Round the result to 2 decimal places.

---

## Step-by-Step Breakdown

### Step 1: Calculate First Login Date and Date Difference
Use a `WINDOW` function to calculate the first login date (`MIN(event_date)`) for each player. Then calculate the difference in days (`DATEDIFF()`) between the current `event_date` and the first login date.

#### Query:
```sql
WITH filtered_table AS (
    SELECT
        player_id,
        DATEDIFF(event_date, MIN(event_date) OVER (PARTITION BY player_id)) AS date_diff
    FROM
        Activity
)
```
#### Example Output:
| player_id | date_diff |
|-----------|-----------|
| 1         | 0         |
| 1         | 1         |
| 2         | 0         |
| 3         | 0         |
| 3         | 1         |

---

### Step 2: Count Consecutive Logins
Count the players who have at least one record with `date_diff = 1`.

#### Query:
```sql
SELECT
    ROUND(
        SUM(CASE WHEN date_diff = 1 THEN 1 ELSE 0 END) / COUNT(DISTINCT player_id),
        2
    ) AS fraction
FROM
    filtered_table;
```
#### What It Does:

- **`SUM(CASE WHEN date_diff = 1 THEN 1 ELSE 0 END)`**:
  Counts players who logged in on the day after their first login.

- **`COUNT(DISTINCT player_id)`**:
  Counts the total number of distinct players.

- **`ROUND(..., 2)`**:
  Rounds the result to 2 decimal places.

---

## Example Walkthrough

### Input:
| player_id | device_id | event_date   | games_played |
|-----------|-----------|--------------|--------------|
| 1         | 2         | 2016-03-01   | 5            |
| 1         | 2         | 2016-03-02   | 6            |
| 2         | 3         | 2017-06-25   | 1            |
| 3         | 1         | 2016-03-02   | 0            |
| 3         | 4         | 2018-07-03   | 5            |

### Execution:
1. **Calculate First Login Date and Date Difference**:

| player_id | event_date   | first_login   | date_diff |
|-----------|--------------|---------------|-----------|
| 1         | 2016-03-01   | 2016-03-01    | 0         |
| 1         | 2016-03-02   | 2016-03-01    | 1         |
| 2         | 2017-06-25   | 2017-06-25    | 0         |
| 3         | 2016-03-02   | 2016-03-02    | 0         |
| 3         | 2018-07-03   | 2016-03-02    | 1         |

2. **Count Consecutive Logins**:
   - Player 1 has `date_diff = 1`.
   - Player 3 has `date_diff = 1`.
   - Total players = 3.
   - Players with consecutive logins = 2 (Player 1 and Player 3).

3. **Calculate Fraction**:
   ```
   fraction = 2 / 3 = 0.67
   ```

---

## Final Query

### Complete SQL Query:
```sql
WITH filtered_table AS (
    SELECT
        player_id,
        DATEDIFF(event_date, MIN(event_date) OVER (PARTITION BY player_id)) AS date_diff
    FROM
        Activity
)
SELECT
    ROUND(
        SUM(CASE WHEN date_diff = 1 THEN 1 ELSE 0 END) / COUNT(DISTINCT player_id),
        2
    ) AS fraction
FROM
    filtered_table;
```

### Output:
| fraction |
|----------|
| 0.67     |

