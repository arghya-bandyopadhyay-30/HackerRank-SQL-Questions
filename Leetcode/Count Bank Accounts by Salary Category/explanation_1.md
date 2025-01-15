# Query for Counting Bank Accounts by Salary Category

This document explains two approaches for categorizing and counting bank accounts based on income levels. Each approach uses SQL Common Table Expressions (CTEs) and ensures that all salary categories are included in the final result.

---

## Approach 1: Using a Single CTE and a LEFT JOIN

### Step 1: Create Salary Categories
Define the three salary categories explicitly in a CTE:
- `Low Salary`
- `Average Salary`
- `High Salary`

#### Query:
```sql
WITH category_name AS (
    SELECT 'Low Salary' AS category
    UNION
    SELECT 'Average Salary'
    UNION
    SELECT 'High Salary'
)
```

### Step 2: Group and Count Accounts by Category
Use a `CASE` statement to group incomes into the three categories:
1. **`income < 20000`**: Low Salary
2. **`income BETWEEN 20000 AND 50000`**: Average Salary
3. **`income > 50000`**: High Salary

#### Query:
```sql
WITH category_sum AS (
    SELECT
        CASE
            WHEN income < 20000 THEN 'Low Salary'
            WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
            ELSE 'High Salary'
        END AS category,
        COUNT(income) AS accounts_count
    FROM
        Accounts
    GROUP BY
        CASE
            WHEN income < 20000 THEN 'Low Salary'
            WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
            ELSE 'High Salary'
        END
)
```

### Step 3: Combine Categories with Counts
Perform a `LEFT JOIN` between `category_name` and `category_sum` to ensure all categories appear in the result, even if they have no accounts.

#### Final Query:
```sql
SELECT
    cn.category,
    IFNULL(cs.accounts_count, 0) AS accounts_count
FROM
    category_name cn
LEFT JOIN
    category_sum cs
ON
    cn.category = cs.category;
```

### Example Output:
| category       | accounts_count |
|----------------|----------------|
| Low Salary     | 1              |
| Average Salary | 0              |
| High Salary    | 3              |

### Key Points:
- **Ensures All Categories Appear**: The `LEFT JOIN` ensures that even if a category has no accounts, it appears in the result with `accounts_count = 0`.
- **Efficient**: Handles large datasets by grouping and joining categories.

---

## Approach 2: Using Multiple CTEs for Each Category

### Step 1: Create Separate CTEs for Each Category
Define three CTEs to calculate the count of accounts in each category individually:

1. **Low Salary**: Incomes `< 20000`
2. **Average Salary**: Incomes `BETWEEN 20000 AND 50000`
3. **High Salary**: Incomes `> 50000`

#### Query:
```sql
WITH low_salary AS (
    SELECT
        'Low Salary' AS category,
        COUNT(income) AS accounts_count
    FROM
        Accounts
    WHERE
        income < 20000
),
average_salary AS (
    SELECT
        'Average Salary' AS category,
        COUNT(income) AS accounts_count
    FROM
        Accounts
    WHERE
        income BETWEEN 20000 AND 50000
),
high_salary AS (
    SELECT
        'High Salary' AS category,
        COUNT(income) AS accounts_count
    FROM
        Accounts
    WHERE
        income > 50000
)
```

### Step 2: Combine Results Using UNION
Combine the three categories using `UNION` to create the final result table.

#### Final Query:
```sql
SELECT * FROM low_salary
UNION
SELECT * FROM average_salary
UNION
SELECT * FROM high_salary;
```

### Example Output:
| category       | accounts_count |
|----------------|----------------|
| Low Salary     | 1              |
| Average Salary | 0              |
| High Salary    | 3              |

### Key Points:
- **Straightforward Categorization**: Each category is calculated independently using separate CTEs.
- **No Missing Categories**: Every category appears in the result, even if no accounts exist in that category.

---

## Comparison of Approaches
| Feature                        | Approach 1                                | Approach 2                                |
|--------------------------------|-------------------------------------------|-------------------------------------------|
| Simplicity                     | Uses fewer CTEs and a `LEFT JOIN`         | Uses separate CTEs for each category      |
| Performance on Large Datasets  | More efficient due to single grouping     | May require more resources for large data |
| Flexibility                    | Easily adaptable for new categories       | Requires new CTEs for additional categories |