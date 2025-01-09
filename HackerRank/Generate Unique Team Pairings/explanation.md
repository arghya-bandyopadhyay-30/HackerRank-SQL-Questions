## Explanation: Unique Team Pairings Query

### Step-by-Step Breakdown of the Query

1. **Use a Common Table Expression (CTE)**:
   - A CTE is created to assign a unique row number (`r`) to each team based on its name in alphabetical order. This ensures consistent ordering of teams.

   ```sql
   WITH cte AS (
       SELECT
           *,
           ROW_NUMBER() OVER (ORDER BY team) AS r
       FROM
           teams
   )
   ```

   - **Example Output of the CTE**:

     | team   | r |
     |--------|---|
     | Aus    | 1 |
     | Eng    | 2 |
     | India  | 3 |
     | Pak    | 4 |

2. **Join the CTE with Itself**:
   - The CTE (`cte c1`) is joined with itself (`cte c2`) to create all possible pairings of teams.
   - The condition `c1.r < c2.r` ensures that:
     - Each team is paired only once with every other team.
     - Self-pairings are excluded (e.g., `(India, India)`).
     - Duplicate pairs are eliminated (e.g., `(India, Pak)` and `(Pak, India)` will not both exist).

   ```sql
   SELECT
       c1.team AS team1,
       c2.team AS team2
   FROM
       cte c1
   JOIN
       cte c2
   ON
       c1.r < c2.r;
   ```

3. **Expected Output**:
   - Based on the input data:

     | team1  | team2  |
     |--------|--------|
     | Aus    | Eng    |
     | Aus    | India  |
     | Aus    | Pak    |
     | Eng    | India  |
     | Eng    | Pak    |
     | India  | Pak    |

### Query Explanation
- **ROW_NUMBER()**: Assigns a unique, sequential number to each team based on the alphabetical order of the team name.
- **Self Join**: Matches each team with every other team using the join condition `c1.r < c2.r`.
- **Condition `c1.r < c2.r`**: Ensures uniqueness by pairing each team with teams that come after it in the sorted order.

