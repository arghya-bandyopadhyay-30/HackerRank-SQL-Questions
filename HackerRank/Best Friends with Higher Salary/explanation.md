# Detailed Explanation of the Solution

---

## Step 1: Understanding the Tables

We have three tables:

1. **Students:** Contains student names and IDs.
2. **Friends:** Maps each student to their best friend's ID.
3. **Packages:** Contains the salary offered to each student.

**Goal:** Find students whose best friends received a higher salary than them.

---

## Step 2: Approach

1. **Create a temporary CTE `own_salary`:**  
   - Join the `Friends` table with the `Packages` table to obtain each student's salary and their best friend's ID.

2. **Join with `Packages` again:**  
   - Compare the friend's salary with the student's salary.

3. **Join with `Students` table to retrieve names.**

4. **Filter and sort the results accordingly.**

---

## Step 3: Query Breakdown

```sql
WITH own_salary AS (
    SELECT
        f.id AS id,
        p.salary AS salary,
        f.friend_id AS friend_id
    FROM
        friends f
    INNER JOIN
        packages p
    ON
        f.id = p.id
)
```

The `own_salary` CTE fetches each student's ID, their salary, and their best friend's ID.

**Example result:**

| ID | Salary | Friend_ID |
|----|--------|-----------|
| 1  | 15.20  | 2         |
| 2  | 10.06  | 3         |
| 3  | 11.55  | 4         |
| 4  | 12.12  | 1         |

---

```sql
SELECT
    s.name
FROM
    own_salary os
INNER JOIN
    packages p
ON
    os.friend_id = p.id
INNER JOIN
    students s
ON
    os.id = s.id
WHERE
    p.salary > os.salary
ORDER BY
    p.salary;
```

### Explanation:
1. Join `own_salary` with `Packages` to get the salary of the student's best friend.
2. Join with `Students` to get student names.
3. Use `WHERE p.salary > os.salary` to filter students whose best friends have higher salaries.
4. Sort the output by the friend's salary.

---

## Step 4: Execution Example

Given the tables:

**Students Table**

| ID | Name     |
|----|----------|
| 1  | Ashley   |
| 2  | Samantha |
| 3  | Julia    |
| 4  | Scarlet  |

**Friends Table**

| ID | Friend_ID |
|----|-----------|
| 1  | 2         |
| 2  | 3         |
| 3  | 4         |
| 4  | 1         |

**Packages Table**

| ID | Salary |
|----|--------|
| 1  | 15.20  |
| 2  | 10.06  |
| 3  | 11.55  |
| 4  | 12.12  |

**Output:**

| Name     |
|----------|
| Samantha |
| Julia    |
| Scarlet  |

---

## Step 5: Edge Cases

1. If all students have higher salaries than their friends, the result should be empty.
2. If no data is present in the tables, the query should return an empty result.
3. The ordering is important to match the requirements.

---

## Complexity Analysis

1. **Time Complexity:** O(n) due to sequential joins and filtering.
2. **Space Complexity:** O(n) due to the use of a CTE.
