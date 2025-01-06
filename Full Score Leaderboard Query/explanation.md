# Full Score Leaderboard Query

This document explains the SQL query that identifies hackers who achieved full scores in more than one challenge. Below is a step-by-step guide to understanding and implementing the query.

---

## Step-by-Step Breakdown

### Step 1: Identify Full Scores
Join the **Submissions**, **Challenges**, and **Difficulty** tables to check if the hacker's score matches the full score for the challenge.

#### Query:
```sql
SELECT
    s.hacker_id,
    c.challenge_id
FROM
    submissions s
INNER JOIN
    challenges c ON s.challenge_id = c.challenge_id
INNER JOIN
    difficulty d ON c.difficulty_level = d.difficulty_level
WHERE
    s.score = d.score;
```

#### What It Does:
- Joins the tables:
  - **Submissions** with **Challenges** using `challenge_id`.
  - **Challenges** with **Difficulty** using `difficulty_level`.
- Filters rows where the score in the **Submissions** table matches the full score for the challenge's difficulty.

---

### Step 2: Count Full Scores Per Hacker
Group the results by `hacker_id` and count the number of challenges for which they achieved full scores.

#### Query:
```sql
SELECT
    s.hacker_id,
    COUNT(c.challenge_id) AS full_score_count
FROM
    submissions s
INNER JOIN
    challenges c ON s.challenge_id = c.challenge_id
INNER JOIN
    difficulty d ON c.difficulty_level = d.difficulty_level
WHERE
    s.score = d.score
GROUP BY
    s.hacker_id;
```

#### What It Does:
- Groups by `hacker_id`.
- Counts the number of `challenge_id` values where the hacker achieved a full score.

---

### Step 3: Filter Hackers with More Than One Full Score
Use the `HAVING` clause to retain only hackers who achieved full scores in more than one challenge.

#### Query:
```sql
SELECT
    s.hacker_id
FROM
    submissions s
INNER JOIN
    challenges c ON s.challenge_id = c.challenge_id
INNER JOIN
    difficulty d ON c.difficulty_level = d.difficulty_level
WHERE
    s.score = d.score
GROUP BY
    s.hacker_id
HAVING
    COUNT(c.challenge_id) > 1;
```

---

### Step 4: Include Hacker Names and Sort the Results
Join the filtered results with the **Hackers** table to get the hacker names, and order the results:
- By the number of full scores in descending order.
- By `hacker_id` in ascending order (for ties).

#### Final Query:
```sql
SELECT
    h.hacker_id,
    h.name
FROM
    submissions s
INNER JOIN
    hackers h ON h.hacker_id = s.hacker_id
INNER JOIN
    challenges c ON c.challenge_id = s.challenge_id
INNER JOIN
    difficulty d ON d.difficulty_level = c.difficulty_level
WHERE
    s.score = d.score
GROUP BY
    h.hacker_id, h.name
HAVING
    COUNT(c.challenge_id) > 1
ORDER BY
    COUNT(c.challenge_id) DESC,
    h.hacker_id ASC;
```

---

## Example Walkthrough

### Input Data:
Refer to the input tables provided in the question.

### Intermediate Steps:
1. **Identify Full Scores:**
   - Hacker 90411 achieved full scores for challenges 71055 and 66730.
2. **Count Full Scores Per Hacker:**
   - Hacker 90411: 2 full scores.
3. **Filter Hackers:**
   - Only hacker 90411 has more than one full score.
4. **Include Names and Sort:**
   - Output: `90411, Joe`.

### Final Output:
| hacker_id | name |
|-----------|------|
| 90411     | Joe  |

---

## Summary
This query identifies hackers who have achieved full scores in more than one challenge, includes their names, and sorts the results for better readability. Follow the steps above to implement the query efficiently.

