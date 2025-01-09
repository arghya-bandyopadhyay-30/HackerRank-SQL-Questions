# Student Challenge Creation Leaderboard

## Problem Statement
Julia asked her students to create coding challenges. Write a query to:
1. Print the `hacker_id`, `name`, and the total number of challenges created by each student.
2. Sort the results:
   - By the total number of challenges in **descending order**.
   - If multiple students created the same number of challenges, sort them by **ascending `hacker_id`**.
3. Apply the following condition:
   - If **more than one student created the same number of challenges** and the count is **less than the maximum number of challenges created**, exclude those students from the result.

---

## Input Tables

### Hackers Table
| Column     | Type    | Description              |
|------------|---------|--------------------------|
| hacker_id  | Integer | Unique ID of the hacker. |
| name       | String  | Name of the hacker.      |

### Challenges Table
| Column      | Type    | Description                          |
|-------------|---------|--------------------------------------|
| challenge_id| Integer | Unique ID of the challenge.          |
| hacker_id   | Integer | ID of the student who created it.    |

---

## Example Input

### Hackers Table:
| hacker_id | name     |
|-----------|----------|
| 21283     | Angela   |
| 88255     | Patrick  |
| 96196     | Lisa     |

### Challenges Table:
| challenge_id | hacker_id |
|--------------|-----------|
| 1            | 21283     |
| 2            | 21283     |
| 3            | 21283     |
| 4            | 21283     |
| 5            | 21283     |
| 6            | 21283     |
| 7            | 88255     |
| 8            | 88255     |
| 9            | 88255     |
| 10           | 88255     |
| 11           | 88255     |
| 12           | 96196     |

---

## Example Output

| hacker_id | name     | challenge_count |
|-----------|----------|-----------------|
| 21283     | Angela   | 6               |
| 88255     | Patrick  | 5               |
| 96196     | Lisa     | 1               |

---

## Explanation

### For Sample Input 0:
- Angela created 6 challenges, Patrick created 5 challenges, and Lisa created 1 challenge.
- Since there are no duplicate challenge counts below the maximum (6), all students are included in the result.

---

## Constraints
1. Only unique challenge counts below the maximum are included in the result.
2. Hackers with the maximum number of challenges are always included, even if their count is not unique.
