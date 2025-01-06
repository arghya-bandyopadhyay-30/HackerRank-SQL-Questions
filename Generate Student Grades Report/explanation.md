# Generating Student Grades Report

This document explains the process of generating a student grades report using SQL. The report involves assigning grades to students based on their marks, filtering names based on specific criteria, and sorting the results according to defined rules.

---

## Step-by-Step Breakdown

### Step 1: Map Students to Grades

**Objective**: Assign grades to each student based on their marks.

**Approach**:
- Use a `JOIN` operation between the `Students` and `Grades` tables.
- Match the `Marks` column in the `Students` table to the appropriate grade range (`Min_Mark` and `Max_Mark`) in the `Grades` table.
- Use a Common Table Expression (CTE) to store intermediate results.

**Query**:
```sql
WITH cte AS (
    SELECT
        s.Name,
        g.Grade,
        s.Marks
    FROM
        Students s
    JOIN
        Grades g
    ON
        s.Marks BETWEEN g.Min_Mark AND g.Max_Mark
)
```

**What It Does**:
- Matches each student’s marks (`s.Marks`) to the grade range (`g.Min_Mark` to `g.Max_Mark`).
- Creates a CTE with columns: `Name`, `Grade`, and `Marks`.

**Example Output of CTE**:
| Name       | Grade | Marks |
|------------|-------|-------|
| Julia      | 9     | 88    |
| Samantha   | 7     | 68    |
| Maria      | 10    | 99    |
| Scarlet    | 8     | 78    |
| Ashley     | 7     | 63    |
| Jane       | 9     | 81    |

---

### Step 2: Filter and Transform Names

**Objective**: Retain names for students with grades ≥ 8, and replace names with `NULL` for grades < 8.

**Approach**:
- Use a `CASE` statement to evaluate the `Grade` column.
  - If `Grade ≥ 8`, retain the `Name`.
  - Otherwise, replace the `Name` with `NULL`.

**Query**:
```sql
SELECT
    CASE
        WHEN Grade >= 8 THEN Name
        ELSE NULL
    END AS Name,
    Grade,
    Marks
FROM cte
```

**Example Output**:
| Name       | Grade | Marks |
|------------|-------|-------|
| Julia      | 9     | 88    |
| NULL       | 7     | 68    |
| Maria      | 10    | 99    |
| Scarlet    | 8     | 78    |
| NULL       | 7     | 63    |
| Jane       | 9     | 81    |

---

### Step 3: Sort the Results

**Objective**: Sort the report based on the following criteria:
1. **Primary**: Descending order of `Grade`.
2. **Secondary for Grades ≥ 8**: Alphabetically by `Name`.
3. **Secondary for Grades < 8**: Ascending order of `Marks`.

**Approach**:
- Use an `ORDER BY` clause with conditional sorting:
  - Sort by `Grade` in descending order.
  - For grades ≥ 8, sort `Name` alphabetically.
  - For grades < 8, sort `Marks` in ascending order.

**Query**:
```sql
ORDER BY
    Grade DESC,
    CASE
        WHEN Grade >= 8 THEN Name
    END ASC,
    CASE
        WHEN Grade < 8 THEN Marks
    END ASC;
```

---

### Final Query

**Complete SQL Query**:
```sql
WITH cte AS (
    SELECT
        s.Name,
        g.Grade,
        s.Marks
    FROM
        Students s
    JOIN
        Grades g
    ON
        s.Marks BETWEEN g.Min_Mark AND g.Max_Mark
)
SELECT
    CASE
        WHEN Grade >= 8 THEN Name
        ELSE NULL
    END AS Name,
    Grade,
    Marks
FROM cte
ORDER BY
    Grade DESC,
    CASE
        WHEN Grade >= 8 THEN Name
    END ASC,
    CASE
        WHEN Grade < 8 THEN Marks
    END ASC;
```

---

## Example Walkthrough

### Input Data
**`Students` Table**:
| Name       | Marks |
|------------|-------|
| Julia      | 88    |
| Samantha   | 68    |
| Maria      | 99    |
| Scarlet    | 78    |
| Ashley     | 63    |
| Jane       | 81    |

**`Grades` Table**:
| Grade | Min_Mark | Max_Mark |
|-------|----------|----------|
| 10    | 95       | 100      |
| 9     | 85       | 94       |
| 8     | 75       | 84       |
| 7     | 65       | 74       |

### Output
| Name       | Grade | Marks |
|------------|-------|-------|
| Maria      | 10    | 99    |
| Jane       | 9     | 81    |
| Julia      | 9     | 88    |
| Scarlet    | 8     | 78    |
| NULL       | 7     | 63    |
| NULL       | 7     | 68    |

---

## Summary
This process effectively maps students to grades, filters and transforms their names based on conditions, and sorts the results according to the specified rules. The resulting report is easy to read and provides meaningful insights into student performance.

