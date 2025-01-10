# Fraction of Players Logging in on Consecutive Days

## Problem Statement

You are given a table `Activity` containing information about players logging into a game. Each row represents a login record, including the date, device used, and the number of games played.

Write a query to calculate the fraction of players who logged in again on the day after their first login, rounded to 2 decimal places. 

The fraction is defined as:
```
fraction = (number of players who logged in on the day after their first login) / (total number of players)
```


---

## Table Schema

### Activity Table
| Column Name  | Type    | Description                                |
|--------------|---------|--------------------------------------------|
| player_id    | int     | The unique identifier for each player.     |
| device_id    | int     | The device used by the player to log in.   |
| event_date   | date    | The date the player logged in.             |
| games_played | int     | The number of games played during the session. |

- `(player_id, event_date)` is the primary key.

---

## Output Format

The output should contain the following column:
1. `fraction`: The fraction of players who logged in on the day after their first login, rounded to 2 decimal places.

### Result Table
| Column Name | Type    | Description                                                 |
|-------------|---------|-------------------------------------------------------------|
| fraction    | decimal | Fraction of players who logged in on the day after their first login. |

---

## Example Input

### Activity Table:
| player_id | device_id | event_date | games_played |
|-----------|-----------|------------|--------------|
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |

---

## Example Output

| fraction |
|----------|
| 0.33     |

---

## Explanation

1. **Player 1**:
   - First login: `2016-03-01`.
   - Consecutive login: `2016-03-02` (logged in the day after their first login).
   - Player 1 is included in the count.

2. **Player 2**:
   - First login: `2017-06-25`.
   - No consecutive login (did not log in the day after their first login).
   - Player 2 is not included in the count.

3. **Player 3**:
   - First login: `2016-03-02`.
   - Next login: `2018-07-03` (not the day after their first login).
   - Player 3 is not included in the count.

**Calculation**:
```
Fraction = players with consecutive logins / total players = 1 / 3 = 0.33
```


### Output:
| fraction |
|----------|
| 0.33     |

