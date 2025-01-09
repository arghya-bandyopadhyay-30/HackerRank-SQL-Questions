# Grouping Consecutive Employees into Pairs

This README explains how to group consecutive employees into pairs using a SQL query and assign a unique group number to each pair. The solution is broken down step by step for clarity.


## Step 1: Create a Common Table Expression (CTE)

### Query:
```sql
WITH cte AS (
    SELECT
        CONCAT(id, ' ', name) AS id_name,
        NTILE(4) OVER (ORDER BY id) AS groups
    FROM emp
)
```

### Explanation:
1. **Concatenate ID and Name:**
    - The `CONCAT(id, ' ', name)` function creates a new column (`id_name`) that combines the employee's ID and name for better readability in the output.

2. **Assign Group Numbers:**
    - The `NTILE(4) OVER (ORDER BY id)` function divides the employees into 4 equal groups based on their `id` in ascending order.
    - The number `4` is adjustable based on the number of employees or desired group size.

### Example Output of the CTE:
| id_name  | groups |
|----------|--------|
| 1 Emp1   | 1      |
| 2 Emp2   | 1      |
| 3 Emp3   | 2      |
| 4 Emp4   | 2      |
| 5 Emp5   | 3      |
| 6 Emp6   | 3      |
| 7 Emp7   | 4      |
| 8 Emp8   | 4      |


## Step 2: Aggregate Names Within Each Group

### Query:
```sql
SELECT
    STRING_AGG(id_name, ', ') AS result,
    groups
FROM cte
GROUP BY groups
ORDER BY groups;
```

### Explanation:
1. **Concatenate Names:**
    - The `STRING_AGG(id_name, ', ')` function combines the `id_name` values within each group, separating them with a comma and a space.

2. **Group by Groups:**
    - The `GROUP BY groups` statement ensures that all employees in the same group (as determined in the CTE) are aggregated into a single row.

3. **Order by Groups:**
    - The `ORDER BY groups` statement ensures the final output is sorted by group numbers.


## Complete SQL Query
```sql
WITH cte AS (
    SELECT
        CONCAT(id, ' ', name) AS id_name,
        NTILE(4) OVER (ORDER BY id) AS groups
    FROM emp
)
SELECT
    STRING_AGG(id_name, ', ') AS result,
    groups
FROM cte
GROUP BY groups
ORDER BY groups;
```


## Why It Works
1. **Dynamic Grouping:**
    - The `NTILE()` function dynamically partitions the employees into groups, allowing for flexibility in group sizes.

2. **Efficient Aggregation:**
    - The `STRING_AGG()` function efficiently concatenates names within each group.

3. **Scalability:**
    - The query can handle any number of employees and adapt to different group sizes by adjusting the `NTILE()` parameter.


## Example Output
### Input Table:
| id | name  |
|----|-------|
| 1  | Emp1  |
| 2  | Emp2  |
| 3  | Emp3  |
| 4  | Emp4  |
| 5  | Emp5  |
| 6  | Emp6  |
| 7  | Emp7  |
| 8  | Emp8  |

### Output Table:
| result           | groups |
|------------------|--------|
| Emp1, Emp2       | 1      |
| Emp3, Emp4       | 2      |
| Emp5, Emp6       | 3      |
| Emp7, Emp8       | 4      |


## How to Use
1. Replace `emp` in the query with your actual table name.
2. Adjust the parameter of `NTILE()` to change the number of groups.
3. Run the query in your SQL environment to get the desired output.


## Notes
- Ensure that the `id` column contains unique and consecutive values for correct grouping.
- Adjust the `NTILE()` parameter based on the total number of employees and desired group sizes.
- If the total number of employees is not divisible evenly by the number of groups, some groups may have one more member than others.