# Full Score Leaderboard Query

## Problem Statement
Julia has conducted a coding contest and needs help creating a leaderboard. Write an SQL query to identify hackers who achieved full scores for more than one challenge. The query must:
1. Display the `hacker_id` and `name` of hackers.
2. Order the output:
   - **Descending order** by the total number of challenges in which they earned full scores.
   - If multiple hackers achieved full scores in the same number of challenges, order them by **ascending `hacker_id`**.

---

## Additional Information
- A `hacker_id` can attempt each `challenge_id` only once, so the `score` for each combination of (`hacker_id`, `challenge_id`) in the **Submissions** table represents the **final score** for that challenge. Hence, we do not need to sum scores for a challenge_id — the score is already final.

---

## Input Tables

### Hackers Table
| Column     | Type    | Description                     |
|------------|---------|---------------------------------|
| hacker_id  | Integer | Unique ID of the hacker.        |
| name       | String  | Name of the hacker.             |

### Difficulty Table
| Column           | Type    | Description                          |
|-------------------|---------|--------------------------------------|
| difficulty_level  | Integer | Level of difficulty of the challenge. |
| score             | Integer | Full score for the difficulty level. |

### Challenges Table
| Column           | Type    | Description                           |
|-------------------|---------|---------------------------------------|
| challenge_id      | Integer | Unique ID of the challenge.           |
| hacker_id         | Integer | ID of the hacker who created it.      |
| difficulty_level  | Integer | Difficulty level of the challenge.    |

### Submissions Table
| Column           | Type    | Description                          |
|-------------------|---------|--------------------------------------|
| submission_id     | Integer | Unique ID of the submission.         |
| hacker_id         | Integer | ID of the hacker who made the submission. |
| challenge_id      | Integer | ID of the challenge being attempted. |
| score             | Integer | Final score for the submission.      |

---

## Example Input

### Hackers Table:
| hacker_id | name     |
|-----------|----------|
| 5580      | Rose     |
| 8439      | Angela   |
| 27205     | Frank    |
| 52243     | Patrick  |
| 52348     | Lisa     |
| 57645     | Kimberly |
| 77726     | Bonnie   |
| 83082     | Michael  |
| 86870     | Todd     |
| 90411     | Joe      |

### Difficulty Table:
| difficulty_level | score |
|-------------------|-------|
| 1                | 20    |
| 2                | 30    |
| 3                | 40    |
| 4                | 60    |
| 5                | 80    |
| 6                | 100   |
| 7                | 120   |

### Challenges Table:
| challenge_id | hacker_id | difficulty_level |
|--------------|-----------|------------------|
| 4810         | 77726     | 4                |
| 21089        | 27205     | 1                |
| 36566        | 5580      | 7                |
| 66730        | 52243     | 6                |
| 71055        | 52243     | 2                |

### Submissions Table:
| submission_id | hacker_id | challenge_id | score |
|---------------|-----------|--------------|-------|
| 68628         | 77726     | 36566        | 30    |
| 65300         | 77726     | 21089        | 10    |
| 40326         | 52243     | 36566        | 77    |
| 8941          | 27205     | 4810         | 4     |
| 83554         | 77726     | 66730        | 30    |
| 43353         | 52243     | 66730        | 100   |
| 55385         | 52348     | 71055        | 20    |
| 39784         | 27205     | 71055        | 23    |
| 94613         | 86870     | 71055        | 30    |
| 45788         | 52348     | 36566        | 0     |
| 93058         | 86870     | 36566        | 30    |
| 7344          | 8439      | 66730        | 92    |
| 2721          | 8439      | 4810         | 36    |
| 523           | 5580      | 71055        | 4     |
| 49105         | 52348     | 66730        | 0     |
| 55877         | 57645     | 66730        | 80    |
| 38355         | 27205     | 66730        | 35    |
| 3924          | 8439      | 36566        | 80    |
| 97397         | 90411     | 66730        | 100   |
| 84162         | 83082     | 4810         | 40    |
| 97431         | 90411     | 71055        | 30    |

---

## Example Output

| hacker_id | name |
|-----------|------|
| 90411     | Joe  |

---

## Explanation
1. A hacker achieves a **full score** for a challenge if their submission score matches the full score of the challenge's difficulty level (from the **Difficulty Table**).
2. Hacker `90411` achieved full scores for:
   - Challenge `71055` (difficulty level 2, full score 30).
   - Challenge `66730` (difficulty level 6, full score 100).
3. No other hacker achieved full scores for more than one challenge.

As a result, the output contains `90411 Joe`.
