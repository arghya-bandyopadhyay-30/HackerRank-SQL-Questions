# Query Students Scoring Higher than Marks

## Problem Statement
Query the `NAME` of any student in the `STUDENTS` table who scored higher than `75` marks. Order the output by the last three characters of each name in ascending order. If two or more students have names ending with the same last three characters (e.g., Bobby, Robby), apply a secondary sort by ascending `ID`.

### Table Schema

| Column | Type    | Description                      |
|--------|---------|----------------------------------|
| ID     | Integer | The unique identifier for the student. |
| Name   | String  | The name of the student.         |
| Marks  | Integer | The marks obtained by the student. |

## Input
The `STUDENTS` table.

## Output
A list of names of students scoring more than `75`, sorted by:
1. Last three characters of their names in ascending order.
2. Student `ID` in ascending order (as a tie-breaker).

## Constraints
- All names are case-sensitive.
- Assume all values in the table are valid.

## Example
**Input Table (STUDENTS)**:

| ID  | Name    | Marks |
|-----|---------|-------|
| 1   | Bobby   | 80    |
| 2   | Robby   | 85    |
| 3   | Alice   | 70    |
| 4   | Steve   | 90    |

**Output**:
| NAME   |
|--------|
| Bobby  |
| Robby  |
