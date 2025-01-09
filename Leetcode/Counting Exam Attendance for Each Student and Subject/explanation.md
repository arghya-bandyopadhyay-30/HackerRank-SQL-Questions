# Exam Attendance Per Student Per Subject

This document explains how to calculate the number of times each student attended an exam for each subject, ensuring that all students and all subjects are included in the output, even if a student did not attend an exam for a specific subject.

## Step-by-Step Explanation

### Step 1: Generate All Combinations of Students and Subjects
To ensure that all students and subjects are represented, even if no exams were attended, we first generate all possible combinations of students and subjects using a **CROSS JOIN**.

#### Query:
```sql
SELECT
    s.student_id,
    s.student_name,
    sub.subject_name
FROM
    Students s
CROSS JOIN
    Subjects sub;
```

#### What It Does:
- Combines each student from the `Students` table with each subject from the `Subjects` table.
- Ensures that all students are paired with all subjects, regardless of attendance.

#### Example Output:
| student_id | student_name | subject_name |
|------------|--------------|--------------|
| 1          | Alice        | Math         |
| 1          | Alice        | Physics      |
| 1          | Alice        | Programming  |
| 2          | Bob          | Math         |
| 2          | Bob          | Physics      |
| 2          | Bob          | Programming  |
| 13         | John         | Math         |
| ...        | ...          | ...          |

---

### Step 2: Link Exam Attendance to the Combinations
Next, link the combinations generated in Step 1 to the `Examinations` table using a **LEFT JOIN**. This allows us to count the number of exams attended for each student-subject pair.

#### Query:
```sql
SELECT
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM
    Students s
CROSS JOIN
    Subjects sub
LEFT JOIN
    Examinations e
ON
    s.student_id = e.student_id
    AND sub.subject_name = e.subject_name;
```

#### What It Does:
- Joins the `Examinations` table to the student-subject combinations:
  - Matches `student_id` from `Examinations` with `Students`.
  - Matches `subject_name` from `Examinations` with `Subjects`.
- Uses `COUNT(e.subject_name)` to count how many exams a student attended for a specific subject.
- Ensures that if a student did not attend any exams for a subject, the count will be `0`.

#### Example Output (before grouping):
| student_id | student_name | subject_name | attended_exams |
|------------|--------------|--------------|----------------|
| 1          | Alice        | Math         | 3              |
| 1          | Alice        | Physics      | 2              |
| 1          | Alice        | Programming  | 1              |
| 2          | Bob          | Math         | 1              |
| ...        | ...          | ...          | ...            |

---

### Step 3: Group and Sort the Results
Group the data by `student_id`, `student_name`, and `subject_name` to calculate the total count of attended exams for each combination. Sort the results for better readability.

#### Query:
```sql
SELECT
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM
    Students s
CROSS JOIN
    Subjects sub
LEFT JOIN
    Examinations e
ON
    s.student_id = e.student_id
    AND sub.subject_name = e.subject_name
GROUP BY
    s.student_id,
    s.student_name,
    sub.subject_name
ORDER BY
    s.student_id,
    sub.subject_name;
```

#### What It Does:
- **GROUP BY** ensures that the count is calculated for each student-subject pair.
- **ORDER BY** sorts the output:
  - First by `student_id`.
  - Then by `subject_name` within each student.

---

### Final Query
The complete SQL query for calculating exam attendance per student per subject:
```sql
SELECT
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM
    Students s
CROSS JOIN
    Subjects sub
LEFT JOIN
    Examinations e
ON
    s.student_id = e.student_id
    AND sub.subject_name = e.subject_name
GROUP BY
    s.student_id,
    s.student_name,
    sub.subject_name
ORDER BY
    s.student_id,
    sub.subject_name;
```

---

## Example Walkthrough

### Input Tables:
#### Students Table:
| student_id | student_name |
|------------|--------------|
| 1          | Alice        |
| 2          | Bob          |
| 13         | John         |
| 6          | Alex         |

#### Subjects Table:
| subject_name  |
|---------------|
| Math          |
| Physics       |
| Programming   |

#### Examinations Table:
| student_id | subject_name  |
|------------|---------------|
| 1          | Math          |
| 1          | Physics       |
| 1          | Programming   |
| 2          | Programming   |
| 1          | Physics       |
| 1          | Math          |
| 13         | Math          |
| 13         | Programming   |
| 13         | Physics       |
| 2          | Math          |
| 1          | Math          |

---

### Output:
| student_id | student_name | subject_name | attended_exams |
|------------|--------------|--------------|----------------|
| 1          | Alice        | Math         | 3              |
| 1          | Alice        | Physics      | 2              |
| 1          | Alice        | Programming  | 1              |
| 2          | Bob          | Math         | 1              |
| 2          | Bob          | Physics      | 0              |
| 2          | Bob          | Programming  | 1              |
| 6          | Alex         | Math         | 0              |
| 6          | Alex         | Physics      | 0              |
| 6          | Alex         | Programming  | 0              |
| 13         | John         | Math         | 1              |
| 13         | John         | Physics      | 1              |
| 13         | John         | Programming  | 1              |

---

## Key Takeaways
1. **CROSS JOIN** ensures all combinations of students and subjects are included.
2. **LEFT JOIN** ensures that even if a student did not attend an exam, the result still includes that student-subject pair with a count of `0`.
3. **GROUP BY** and **COUNT** aggregate the results to calculate attendance per student per subject.
4. The final query is sorted by `student_id` and `subject_name` for better readability.

By following these steps, you can accurately calculate exam attendance for each student and subject, ensuring no data is missed.

