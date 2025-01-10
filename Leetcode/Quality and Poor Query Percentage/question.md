# Calculate Query Quality and Poor Query Percentage

## Problem Statement
You are given a table `Queries` that contains information about queries collected from a database. Each query has a `position`, `rating`, and other metadata.

1. **Query Quality**:
   - Defined as the average of the ratio between query `rating` and `position`.
   - Formula:
     ```
     quality = avg(rating / position)
     ```

2. **Poor Query Percentage**:
   - Defined as the percentage of queries with a `rating` less than 3.
   - Formula:
     ```
     poor_query_percentage = (count of poor queries / total queries) * 100
     ```

Write a solution to calculate the `query_name`, `quality`, and `poor_query_percentage` for each query. Round both `quality` and `poor_query_percentage` to two decimal places.

---

## Table Schema

### Queries Table
| Column Name | Type    | Description                                   |
|-------------|---------|-----------------------------------------------|
| query_name  | varchar | Name of the query.                           |
| result      | varchar | Result of the query.                         |
| position    | int     | Position of the result (1 to 500).           |
| rating      | int     | Rating of the query result (1 to 5).         |

- There may be duplicate rows in the table.

---

## Output Format

The output should include the following columns:
1. `query_name`: The name of the query.
2. `quality`: The quality of the query, rounded to 2 decimal places.
3. `poor_query_percentage`: The percentage of poor queries for the query, rounded to 2 decimal places.

### Result Table
| Column Name            | Type    | Description                                   |
|------------------------|---------|-----------------------------------------------|
| query_name             | varchar | Name of the query.                           |
| quality                | decimal | Query quality, rounded to 2 decimal places.  |
| poor_query_percentage  | decimal | Percentage of poor queries, rounded to 2 decimal places. |

---

## Example Input

### Queries Table:
| query_name | result            | position | rating |
|------------|-------------------|----------|--------|
| Dog        | Golden Retriever  | 1        | 5      |
| Dog        | German Shepherd   | 2        | 5      |
| Dog        | Mule              | 200      | 1      |
| Cat        | Shirazi           | 5        | 2      |
| Cat        | Siamese           | 3        | 3      |
| Cat        | Sphynx            | 7        | 4      |

---

## Example Output

| query_name | quality | poor_query_percentage |
|------------|---------|-----------------------|
| Dog        | 2.50    | 33.33                 |
| Cat        | 0.66    | 33.33                 |

---

## Explanation

1. For the `Dog` query:
   - **Quality**:
     ```
     quality = ((5 / 1) + (5 / 2) + (1 / 200)) / 3 = 2.50
     ```
   - **Poor Query Percentage**:
     - Poor queries: 1 (rating < 3).
     - Total queries: 3.
     ```
     poor_query_percentage = (1 / 3) * 100 = 33.33
     ```

2. For the `Cat` query:
   - **Quality**:
     ```
     quality = ((2 / 5) + (3 / 3) + (4 / 7)) / 3 = 0.66
     ```
   - **Poor Query Percentage**:
     - Poor queries: 1 (rating < 3).
     - Total queries: 3.
     ```
     poor_query_percentage = (1 / 3) * 100 = 33.33
     ```
