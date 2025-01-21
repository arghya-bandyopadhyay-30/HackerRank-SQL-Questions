# SQL Question

## Given Table: Projects

| Column     | Type    |
|------------|---------|
| Task_ID    | Integer |
| Start_Date | Date    |
| End_Date   | Date    |

---

### Problem Statement

You are given a table `Projects` with columns `Task_ID`, `Start_Date`, and `End_Date`. The difference between `End_Date` and `Start_Date` is guaranteed to be exactly 1 day for each row.

If the `End_Date` of one task matches the `Start_Date` of another task, they belong to the same project. Samantha wants to find the number of unique projects and their start and end dates.

### Task:

Write an SQL query to output the start and end dates of each project. The results should be:

1. Ordered by the number of days taken to complete the project (ascending).
2. If multiple projects have the same duration, order them by the start date.

---

### Example Input

| Task_ID | Start_Date | End_Date   |
|---------|------------|------------|
| 1       | 2015-10-01  | 2015-10-02  |
| 2       | 2015-10-02  | 2015-10-03  |
| 3       | 2015-10-03  | 2015-10-04  |
| 4       | 2015-10-13  | 2015-10-14  |
| 5       | 2015-10-14  | 2015-10-15  |
| 6       | 2015-10-28  | 2015-10-29  |
| 7       | 2015-10-30  | 2015-10-31  |

---

### Expected Output

| Start_Date | End_Date   |
|------------|------------|
| 2015-10-28  | 2015-10-29  |
| 2015-10-30  | 2015-10-31  |
| 2015-10-13  | 2015-10-15  |
| 2015-10-01  | 2015-10-04  |

---

### Explanation

The input describes the following four projects:

1. **Project 1:** Tasks 1, 2, and 3 (start: `2015-10-01`, end: `2015-10-04`) took **3 days** to complete.
2. **Project 2:** Tasks 4 and 5 (start: `2015-10-13`, end: `2015-10-15`) took **2 days** to complete.
3. **Project 3:** Task 6 (start: `2015-10-28`, end: `2015-10-29`) took **1 day** to complete.
4. **Project 4:** Task 7 (start: `2015-10-30`, end: `2015-10-31`) took **1 day** to complete.

The output is sorted by project duration and then by start date.