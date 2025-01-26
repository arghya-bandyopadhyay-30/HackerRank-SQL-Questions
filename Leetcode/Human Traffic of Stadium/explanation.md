# Detailed Explanation: Finding Consecutive Stadium Visits with High Attendance

---

## Step 1: Understanding the Data

Given input data:

| id  | visit_date  | people |
|-----|------------|--------|
| 1   | 2017-01-01  | 10     |
| 2   | 2017-01-02  | 109    |
| 3   | 2017-01-03  | 150    |
| 4   | 2017-01-04  | 99     |
| 5   | 2017-01-05  | 145    |
| 6   | 2017-01-06  | 1455   |
| 7   | 2017-01-07  | 199    |
| 8   | 2017-01-09  | 188    |

---

## Step 2: SQL Query Breakdown

### Part 1: Identify Consecutive Visits with High Attendance

```sql
WITH FilteredStadium AS (
    SELECT
        *,
        id - ROW_NUMBER() OVER (ORDER BY id) AS grp
    FROM
        Stadium
    WHERE
        people >= 100
)
```

- Filters records where `people >= 100`.
- Uses `id - ROW_NUMBER()` to group consecutive entries.

---

### Part 2: Grouping and Filtering Valid Sequences

```sql
GroupedData AS (
    SELECT
        grp
    FROM
        FilteredStadium
    GROUP BY
        grp
    HAVING
        COUNT(*) >= 3
)
```

- Groups consecutive records and selects groups where there are at least 3 rows.

---

### Part 3: Generating the Final Output

```sql
SELECT
    id,
    visit_date,
    people
FROM
    FilteredStadium f
INNER JOIN
    GroupedData g
ON
    f.grp = g.grp
ORDER BY
    visit_date;
```

- Joins the identified groups to get the required rows.
- Orders them by `visit_date`.

---

## Step 3: Example Execution Output

| id  | visit_date  | people |
|-----|------------|--------|
| 5   | 2017-01-05  | 145    |
| 6   | 2017-01-06  | 1455   |
| 7   | 2017-01-07  | 199    |
| 8   | 2017-01-09  | 188    |

---

## Step 4: Edge Cases Considered

1. **Handling sparse data with large gaps:** Ensuring sequences are properly grouped.
2. **Ensuring correct ordering based on visit_date:** Ordering results appropriately.
3. **Handling cases with less than 3 consecutive records:** Ensuring they are excluded.
4. **All records with people < 100:** The output should be empty.

---

## Conclusion

The solution effectively identifies and groups consecutive high-attendance visits, ensuring the data is processed efficiently and correctly filtered.