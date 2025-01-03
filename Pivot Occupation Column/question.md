# Pivot Occupation Column in OCCUPATIONS Table

## Problem Statement
Pivot the `Occupation` column in the `OCCUPATIONS` table such that each name is sorted alphabetically and displayed underneath its corresponding occupation. The output should consist of four columns (`Doctor`, `Professor`, `Singer`, and `Actor`) in that specific order, with their respective names listed alphabetically under each column.

### Table Schema

| Column     | Type   | Description                                    |
|------------|--------|------------------------------------------------|
| Name       | String | The name of the individual.                   |
| Occupation | String | The profession of the individual (`Doctor`, `Professor`, `Singer`, or `Actor`). |

### Constraints
- The `Occupation` column will only contain one of the following values: `Doctor`, `Professor`, `Singer`, `Actor`.
- Print `NULL` when there are no more names corresponding to an occupation.

### Output Format
- The pivoted table will have four columns (`Doctor`, `Professor`, `Singer`, and `Actor`) in that specific order.
- Names will be sorted alphabetically under each occupation.
- If there are no more names for an occupation, `NULL` should be printed.

---

## Example Input and Output

**Input Table (OCCUPATIONS)**:

| Name       | Occupation |
|------------|------------|
| Samantha   | Doctor     |
| Julia      | Actor      |
| Maria      | Actor      |
| Meera      | Singer     |
| Ashely     | Professor  |
| Ketty      | Professor  |
| Christeen  | Professor  |
| Jane       | Actor      |
| Jenny      | Doctor     |
| Priya      | Singer     |

**Output**:

| Doctor    | Professor   | Singer   | Actor    |
|-----------|-------------|----------|----------|
| Samantha  | Ashely      | Meera    | Julia    |
| Jenny     | Christeen   | Priya    | Jane     |
| NULL      | Ketty       | NULL     | Maria    |
