# Student Challenge Creation Leaderboard

This document explains the process of identifying students who created coding challenges and displays their leaderboard positions based on specified criteria. The final output includes students with unique challenge counts or those who created the maximum number of challenges.

---

## Step-by-Step Breakdown

### Step 1: Calculate the Total Challenges Created
Group the challenges by `hacker_id` and count the total number of challenges created by each hacker.

#### Query:
```sql
WITH CTE AS (
    SELECT
        H.hacker_id,
        H.name,
        COUNT(C.challenge_id) AS challenge_count
    FROM
        Hackers H
    INNER JOIN
        Challenges C
    ON
        H.hacker_id = C.hacker_id
    GROUP BY
        H.hacker_id, H.name
)
```
#### Explanation:
1. Joins the Hackers and Challenges tables using the `hacker_id`.
2. Groups the data by `hacker_id` and `name`.
3. Counts the number of challenges created by each student (`challenge_count`).

#### Example Output:
| hacker_id | name     | challenge_count |
|-----------|----------|-----------------|
| 21283     | Angela   | 6               |
| 88255     | Patrick  | 5               |
| 96196     | Lisa     | 1               |

---

### Step 2: Include Only Eligible Challenge Counts
Filter the results to include:
1. Students who created the maximum number of challenges.
2. Students with unique challenge counts (i.e., no duplicates below the maximum).

#### Query:
```sql
SELECT
    hacker_id,
    name,
    challenge_count
FROM
    CTE
WHERE
    challenge_count = (SELECT MAX(challenge_count) FROM CTE)
    OR
    challenge_count IN (
        SELECT
            challenge_count
        FROM
            CTE
        GROUP BY
            challenge_count
        HAVING
            COUNT(challenge_count) = 1
    )
```
#### Explanation:
1. **Include Maximum Count:** Always include students who created the maximum number of challenges (`MAX(challenge_count)`).
2. **Include Unique Counts Below Maximum:** Use a subquery to identify unique challenge counts (`HAVING COUNT(challenge_count) = 1`).

---

### Step 3: Sort the Results
Sort the filtered results:
1. By `challenge_count` in descending order.
2. For ties, by `hacker_id` in ascending order.

#### Query:
```sql
ORDER BY
    challenge_count DESC,
    hacker_id ASC;
```

---

### Final Query
Below is the complete SQL query:

```sql
WITH CTE AS (
    SELECT
        H.hacker_id,
        H.name,
        COUNT(C.challenge_id) AS challenge_count
    FROM
        Hackers H
    INNER JOIN
        Challenges C
    ON
        H.hacker_id = C.hacker_id
    GROUP BY
        H.hacker_id, H.name
)
SELECT
    hacker_id,
    name,
    challenge_count
FROM
    CTE
WHERE
    challenge_count = (SELECT MAX(challenge_count) FROM CTE)
    OR
    challenge_count IN (
        SELECT
            challenge_count
        FROM
            CTE
        GROUP BY
            challenge_count
        HAVING
            COUNT(challenge_count) = 1
    )
ORDER BY
    challenge_count DESC,
    hacker_id ASC;
```

---

## Example Walkthrough

### Input:
| hacker_id | name     | challenge_count |
|-----------|----------|-----------------|
| 21283     | Angela   | 6               |
| 88255     | Patrick  | 5               |
| 96196     | Lisa     | 1               |

### Filtering:
1. Include students with the maximum challenge count: **Angela** (6 challenges).
2. Include students with unique challenge counts below the maximum: **Patrick** (5 challenges) and **Lisa** (1 challenge).

### Sorting:
1. By `challenge_count` in descending order.
2. By `hacker_id` in ascending order for ties.

### Output:
| hacker_id | name     | challenge_count |
|-----------|----------|-----------------|
| 21283     | Angela   | 6               |
| 88255     | Patrick  | 5               |
| 96196     | Lisa     | 1               |

