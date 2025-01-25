# SQL Question

## Given Table: Scores

| Column Name | Type    |
|-------------|---------|
| student_id  | int     |
| subject     | varchar |
| score       | int     |
| exam_date   | varchar |

### Primary Key
- `(student_id, subject, exam_date)` is the primary key.

---

### Problem Statement

You are given a table `Scores` that records the scores obtained by students in various subjects on specific dates.

A student is considered to have shown improvement if they satisfy **both** of the following conditions:

1. They have taken exams in the same subject on at least **two different dates**.
2. Their **latest score** in that subject is **higher** than their **first score**.

**Task:**  
Write an SQL query to identify students who have shown improvement in any subject. The result should include:

- `student_id`
- `subject`
- `first_score` (score obtained on the earliest exam date)
- `latest_score` (score obtained on the latest exam date)

**Output Requirements:**  
- Order the result by `student_id` and `subject` in ascending order.

---

### Example Input

#### Scores Table:

| student_id | subject  | score | exam_date  |
|------------|----------|-------|------------|
| 101        | Math     | 70    | 2023-01-15  |
| 101        | Math     | 85    | 2023-02-15  |
| 101        | Physics  | 65    | 2023-01-15  |
| 101        | Physics  | 60    | 2023-02-15  |
| 102        | Math     | 80    | 2023-01-15  |
| 102        | Math     | 85    | 2023-02-15  |
| 103        | Math     | 90    | 2023-01-15  |
| 104        | Physics  | 75    | 2023-01-15  |
| 104        | Physics  | 85    | 2023-02-15  |

---

### Example Output

| student_id | subject  | first_score | latest_score |
|------------|----------|-------------|--------------|
| 101        | Math     | 70          | 85           |
| 102        | Math     | 80          | 85           |
| 104        | Physics  | 75          | 85           |

---

### Explanation

1. **Student 101 (Math):** Improved from `70` to `85`  
2. **Student 101 (Physics):** No improvement (decreased from `65` to `60`)  
3. **Student 102 (Math):** Improved from `80` to `85`  
4. **Student 103 (Math):** Only one exam → **not eligible**  
5. **Student 104 (Physics):** Improved from `75` to `85`  

---

### Constraints

- The score range is between `0` and `100`.
- The result should be ordered by `student_id`, `subject`.