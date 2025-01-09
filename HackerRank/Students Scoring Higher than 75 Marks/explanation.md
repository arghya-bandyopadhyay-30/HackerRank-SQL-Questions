# Explanation for Query: Students Scoring Higher than Marks

## Concepts Involved
1. **String Functions**:
   - The `RIGHT()` function extracts the last three characters of a string.
2. **Sorting**:
   - The `ORDER BY` clause sorts results by the specified criteria.
3. **Filtering**:
   - The `WHERE` clause filters out rows that do not meet the condition.
4. **Secondary Sorting**:
   - In cases of a tie, results are sorted by ascending `ID` for consistency.

## Approach to Solve
### Step 1: Filter Students by Marks
- Use `WHERE MARKS > 75` to select students who scored more than `75`.

### Step 2: Extract Last Three Characters for Sorting
- Use the `RIGHT(NAME, 3)` function to extract the last three characters of the student names.

### Step 3: Sort the Results
- Primary sorting is done by `RIGHT(NAME, 3)` in ascending order.
- Secondary sorting is done by `ID` in ascending order to handle ties.