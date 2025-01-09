# Explanation for Pivoting the Occupation Column

## Step-by-Step Breakdown of the Query

### Step 1: Assign Row Numbers to Each Occupation

- Use `ROW_NUMBER()` to assign a sequential number to each name within the same occupation, ordered alphabetically.
- This creates a unique row identifier (`row_num`) for each name under its respective occupation.

```sql
WITH formatted_occupations AS (
    SELECT
        NAME,
        OCCUPATION,
        ROW_NUMBER() OVER (
            PARTITION BY OCCUPATION
            ORDER BY NAME
        ) AS row_num
    FROM OCCUPATIONS
)
```

**Example Output of `formatted_occupations`:**

| Name       | Occupation  | row_num |
|------------|-------------|---------|
| Samantha   | Doctor      | 1       |
| Jenny      | Doctor      | 2       |
| Ashely     | Professor   | 1       |
| Christeen  | Professor   | 2       |
| Ketty      | Professor   | 3       |
| Meera      | Singer      | 1       |
| Priya      | Singer      | 2       |
| Julia      | Actor       | 1       |
| Jane       | Actor       | 2       |
| Maria      | Actor       | 3       |

---

### Step 2: Use CASE Statements to Pivot the Occupations

- For each occupation, use a `CASE` statement to filter names based on their occupation and `row_num`.
- Use `MAX()` to ensure a single name appears in each cell for the pivoted table.

```sql
SELECT
    MAX(CASE WHEN OCCUPATION = 'Doctor' THEN NAME ELSE NULL END) AS Doctor,
    MAX(CASE WHEN OCCUPATION = 'Professor' THEN NAME ELSE NULL END) AS Professor,
    MAX(CASE WHEN OCCUPATION = 'Singer' THEN NAME ELSE NULL END) AS Singer,
    MAX(CASE WHEN OCCUPATION = 'Actor' THEN NAME ELSE NULL END) AS Actor
FROM formatted_occupations
GROUP BY row_num;
```

---

### Step 3: Final Output for Each `row_num`

**For `row_num = 1`:**

- **Doctor:** The `CASE` checks if the Occupation is `Doctor`. It finds `Samantha`, and `MAX` returns `Samantha`.
- **Professor:** The `CASE` checks if the Occupation is `Professor`. It finds `Ashely`, and `MAX` returns `Ashely`.
- **Singer:** The `CASE` checks if the Occupation is `Singer`. It finds `Meera`, and `MAX` returns `Meera`.
- **Actor:** The `CASE` checks if the Occupation is `Actor`. It finds `Julia`, and `MAX` returns `Julia`.

**For `row_num = 2`:**

- **Doctor:** The `CASE` checks if the Occupation is `Doctor`. It finds `Jenny`, and `MAX` returns `Jenny`.
- **Professor:** The `CASE` checks if the Occupation is `Professor`. It finds `Christeen`, and `MAX` returns `Christeen`.
- **Singer:** The `CASE` checks if the Occupation is `Singer`. It finds `Priya`, and `MAX` returns `Priya`.
- **Actor:** The `CASE` checks if the Occupation is `Actor`. It finds `Jane`, and `MAX` returns `Jane`.

**For `row_num = 3`:**

- **Doctor:** The `CASE` checks if the Occupation is `Doctor`. No match, so `MAX` returns `NULL`.
- **Professor:** The `CASE` checks if the Occupation is `Professor`. It finds `Ketty`, and `MAX` returns `Ketty`.
- **Singer:** The `CASE` checks if the Occupation is `Singer`. No match, so `MAX` returns `NULL`.
- **Actor:** The `CASE` checks if the Occupation is `Actor`. It finds `Maria`, and `MAX` returns `Maria`.

---

### Final Output

| Doctor     | Professor   | Singer   | Actor    |
|------------|-------------|----------|----------|
| Samantha   | Ashely      | Meera    | Julia    |
| Jenny      | Christeen   | Priya    | Jane     |
| NULL       | Ketty       | NULL     | Maria    |

---

### Summary

1. **Row Assignment:**
   - `ROW_NUMBER()` groups names within each occupation by rank.

2. **CASE Logic:**
   - Filters names by occupation, ensuring alignment under the correct column.

3. **Aggregation:**
   - `MAX` consolidates names for each `row_num` group.

4. **Grouping:**
   - `GROUP BY row_num` organizes the pivoted data.

This approach efficiently pivots the table while maintaining alphabetical order and filling empty slots with `NULL`. 

