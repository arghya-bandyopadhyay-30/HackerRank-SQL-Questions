# Generate Student Grades Report

## Problem Statement
You are given two tables:
1. **Students**: Contains information about students with the following columns:
   - `ID` (integer): Unique identifier for the student.
   - `Name` (string): Name of the student.
   - `Marks` (integer): Marks obtained by the student.

2. **Grades**: Contains information about grade ranges with the following columns:
   - `Grade` (integer): The grade level.
   - `Min_Mark` (integer): The minimum mark required for the grade.
   - `Max_Mark` (integer): The maximum mark allowed for the grade.

Write an SQL query to generate a report containing the columns: `Name`, `Grade`, and `Marks`. The report must satisfy the following requirements:
1. **Filter Names**: Exclude student names for grades less than 8 and replace them with `"NULL"`.
2. **Sort by Grade**:
   - Students with grades ≥ 8: Sort in descending order of `Grade`, and for the same grade, sort alphabetically by `Name`.
   - Students with grades < 8: Sort in descending order of `Grade`, and for the same grade, sort by `Marks` in ascending order.

---

## Table Schema

### Students Table
| Column | Type    | Description                    |
|--------|---------|--------------------------------|
| ID     | Integer | Unique identifier for students |
| Name   | String  | Name of the student            |
| Marks  | Integer | Marks obtained by the student  |

### Grades Table
| Column     | Type    | Description                                |
|------------|---------|--------------------------------------------|
| Grade      | Integer | Grade assigned                            |
| Min_Mark   | Integer | Minimum mark required for the grade        |
| Max_Mark   | Integer | Maximum mark allowed for the grade         |

---

## Example Input

### Students Table
| ID  | Name      | Marks |
|-----|-----------|-------|
| 1   | Julia     | 88    |
| 2   | Samantha  | 68    |
| 3   | Maria     | 99    |
| 4   | Scarlet   | 78    |
| 5   | Ashley    | 63    |
| 6   | Jane      | 81    |

### Grades Table
| Grade | Min_Mark | Max_Mark |
|-------|----------|----------|
| 1     | 0        | 9        |
| 2     | 10       | 19       |
| 3     | 20       | 29       |
| 4     | 30       | 39       |
| 5     | 40       | 49       |
| 6     | 50       | 59       |
| 7     | 60       | 69       |
| 8     | 70       | 79       |
| 9     | 80       | 89       |
| 10    | 90       | 100      |

---

## Example Output

| Name      | Grade | Marks |
|-----------|-------|-------|
| Maria     | 10    | 99    |
| Jane      | 9     | 81    |
| Julia     | 9     | 88    |
| Scarlet   | 8     | 78    |
| NULL      | 7     | 63    |
| NULL      | 7     | 68    |

---

## Constraints
- Each student is guaranteed to have marks within a valid range.
- Grade ranges are distinct and non-overlapping.