# Exam Attendance Per Student Per Subject

## Problem Statement
You are given three tables: `Students`, `Subjects`, and `Examinations`. Write a query to calculate the number of times each student attended each exam. 

Your result should include all students and all subjects, even if a student did not attend any exams for a particular subject. If a student did not attend an exam, the attendance count should be `0`.

---

## Table Schema

### Students Table
| Column Name   | Type    | Description                                    |
|---------------|---------|------------------------------------------------|
| student_id    | int     | Unique identifier for each student.            |
| student_name  | varchar | Name of the student.                           |

### Subjects Table
| Column Name   | Type    | Description                                    |
|---------------|---------|------------------------------------------------|
| subject_name  | varchar | Unique identifier for each subject.            |

### Examinations Table
| Column Name   | Type    | Description                                    |
|---------------|---------|------------------------------------------------|
| student_id    | int     | ID of the student who attended the exam.       |
| subject_name  | varchar | Name of the subject for which the exam was attended. |

---

## Output Format
The output should contain the following columns:
1. `student_id`: The unique ID of the student.
2. `student_name`: The name of the student.
3. `subject_name`: The name of the subject.
4. `attended_exams`: The number of times the student attended the exam for that subject.

### Result Table
| Column Name    | Type    | Description                                    |
|----------------|---------|------------------------------------------------|
| student_id     | int     | Unique identifier for the student.             |
| student_name   | varchar | Name of the student.                           |
| subject_name   | varchar | Name of the subject.                           |
| attended_exams | int     | Count of exams attended by the student for the subject. |

---

## Constraints
1. Every student should be paired with every subject, even if they did not attend an exam.
2. Use a count of `0` for combinations where a student did not attend an exam for a specific subject.
3. The result should be sorted:
   - First by `student_id` in ascending order.
   - Then by `subject_name` in ascending order.

---

## Example Input

### Students Table:
| student_id | student_name |
|------------|--------------|
| 1          | Alice        |
| 2          | Bob          |
| 13         | John         |
| 6          | Alex         |

### Subjects Table:
| subject_name |
|--------------|
| Math         |
| Physics      |
| Programming  |

### Examinations Table:
| student_id | subject_name |
|------------|--------------|
| 1          | Math         |
| 1          | Physics      |
| 1          | Programming  |
| 2          | Programming  |
| 1          | Physics      |
| 1          | Math         |
| 13         | Math         |
| 13         | Programming  |
| 13         | Physics      |
| 2          | Math         |
| 1          | Math         |

---

## Example Output

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

## Explanation
1. Alice attended the `Math` exam 3 times, the `Physics` exam 2 times, and the `Programming` exam 1 time.
2. Bob attended the `Math` exam 1 time and the `Programming` exam 1 time but did not attend the `Physics` exam.
3. Alex did not attend any exams.
4. John attended all three exams exactly once.

The output includes all combinations of students and subjects, even for subjects where a student did not attend any exams.
