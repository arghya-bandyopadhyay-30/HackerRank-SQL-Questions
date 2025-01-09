# Explanation for Query: Median of Northern Latitudes

## Concepts Involved
1. **Row Numbering**:
   - The `ROW_NUMBER()` function assigns a unique sequential integer to rows, ordered by `LAT_N`.

2. **Count and Median Calculation**:
   - Use `COUNT(*)` to determine the total number of rows.
   - For an odd number of rows, the median is the middle value.
   - For an even number of rows, the median is the average of the two middle values.

3. **Common Table Expressions (CTEs)**:
   - Use CTEs to organize and simplify the query logic.
   - `Ordered_Data`: Assigns row numbers based on sorted `LAT_N`.
   - `Row_Count`: Counts the total rows for median calculation.

4. **Conditional Logic**:
   - Use a `CASE` statement to handle both odd and even row counts for median calculation.

---

## Step-by-Step Breakdown of the SQL Query

### Step 1: Assign Row Numbers
In the `Ordered_Data` CTE:
- Use the `ROW_NUMBER()` function to assign a unique row number to each record.
- Sort the records in ascending order of `LAT_N`.
- This helps to identify the middle row(s) required for median calculation.

```sql
WITH Ordered_Data AS (
    SELECT ROW_NUMBER() OVER (ORDER BY LAT_N) AS row_num, LAT_N
    FROM STATION
)
```

### Step 2: Count Total Rows
In the Row_Count CTE:
- Use `COUNT(*)` to count the total number of rows in the `Ordered_Data` table.
- This value will determine whether the row count is odd or even.

```sql
Row_Count AS (
    SELECT COUNT(*) AS total_rows FROM Ordered_Data
)
```

### Step 3: Calculate the Median
The main query combines the logic for odd and even row counts using a CASE statement.

#### For Odd Row Counts:
- Calculate the middle row using the formula `(total_rows + 1) / 2`.
- Retrieve the `LAT_N` value corresponding to this row number from `Ordered_Data`.
```sql
SELECT LAT_N
FROM Ordered_Data, Row_Count
WHERE row_num = ROUND((total_rows + 1)/2)
```

#### For Even Row Counts:
- Identify the two middle rows using the formulas `total_rows / 2` and `(total_rows / 2) + 1`.
- Calculate the average of their `LAT_N` values.
```sql
SELECT AVG(LAT_N)
FROM Ordered_Data, Row_Count
WHERE row_num IN (ROUND(total_rows/2), ROUND(total_rows/2)+1)
```

#### Combine Both Conditions:
Use a CASE statement to check whether the total row count is odd or even.
Depending on the result, apply the corresponding logic for median calculation.
```sql
CASE
    WHEN total_rows % 2 = 1 THEN (
        SELECT LAT_N
        FROM Ordered_Data, Row_Count
        WHERE row_num = ROUND((total_rows + 1)/2)
    )
    ELSE (
        SELECT AVG(LAT_N)
        FROM Ordered_Data, Row_Count
        WHERE row_num IN (ROUND(total_rows/2), ROUND(total_rows/2)+1)
    )
```

### Step 4: Round the Median
The ROUND() function rounds the result to 4 decimal places, ensuring the output matches the required precision.
```sql
SELECT ROUND(CASE
    WHEN total_rows % 2 = 1 THEN (
        SELECT LAT_N
        FROM Ordered_Data, Row_Count
        WHERE row_num = ROUND((total_rows + 1)/2)
    )
    ELSE (
        SELECT AVG(LAT_N)
        FROM Ordered_Data, Row_Count
        WHERE row_num IN (ROUND(total_rows/2), ROUND(total_rows/2)+1)
    )
END, 4) AS MEDIAN
```