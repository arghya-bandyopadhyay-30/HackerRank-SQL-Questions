# Explanation for Query: Shortest and Longest City Names

## Concepts Involved
1. **String Functions**: The `LENGTH()` function is used to calculate the number of characters in the city name.
2. **Subqueries**: Nested queries help find the minimum and maximum lengths of city names.
3. **Sorting**: The `ORDER BY` clause ensures alphabetical order when there are ties.
4. **UNION ALL**: Combines results from two separate queries.

## Approach to Solve
### Step 1: Identify the Shortest and Longest City Names
- Use `LENGTH(CITY)` to calculate the length of each city name.
- Find the minimum length using a subquery: `SELECT MIN(LENGTH(CITY)) FROM STATION`.
- Find the maximum length using a subquery: `SELECT MAX(LENGTH(CITY)) FROM STATION`.

### Step 2: Retrieve the Cities Alphabetically
- For both shortest and longest names, sort the results by `CITY` using `ORDER BY CITY`.
- Use `LIMIT 1` to pick the first city in alphabetical order in case of a tie.

### Step 3: Combine Results
- Use `UNION ALL` to combine the results of the shortest and longest city queries into a single output.

#### Why Use UNION ALL?
1. **Performance:**

- UNION removes duplicate rows by default, which requires an additional step of comparing results across both queries.
- UNION ALL skips the deduplication process, making it faster and more efficient.

2. **Distinct Results Are Guaranteed:**

- Since the shortest and longest city queries are based on non-overlapping criteria (MIN and MAX of length), there is no risk of duplicate rows.
- Using UNION ALL ensures both rows are returned without unnecessary computation.

3. **Clarity of Intent:** UNION ALL explicitly states that you want to combine all rows from the two queries, retaining the natural distinctness of the results.

## SQL Query Breakdown
### Shortest City Query
```sql
SELECT CITY, LENGTH(CITY)
FROM STATION
WHERE LENGTH(CITY) = (SELECT MIN(LENGTH(CITY)) FROM STATION)
ORDER BY CITY
LIMIT 1;
```

### Longest City Query
```sql
SELECT CITY, LENGTH(CITY)
FROM STATION
WHERE LENGTH(CITY) = (SELECT MAX(LENGTH(CITY)) FROM STATION)
ORDER BY CITY
LIMIT 1;
```
