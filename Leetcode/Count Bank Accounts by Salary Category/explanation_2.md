# SQL Query for Counting Bank Accounts by Salary Category (Approach 1)

---

## Approach Overview

This approach uses Common Table Expressions (CTEs) and a `LEFT JOIN` to count bank accounts based on salary categories. It ensures that all defined categories appear in the output, even if no accounts exist in a particular category.

---

## Step 1: Define All Salary Categories

Create a CTE `category_name` to define the three salary categories:
1. **`Low Salary`**: Salaries strictly less than `$20,000`.
2. **`Average Salary`**: Salaries between `$20,000` and `$50,000` (inclusive).
3. **`High Salary`**: Salaries strictly greater than `$50,000`.

### Query:
```sql
WITH category_name AS (
    SELECT 'Low Salary' AS category
    UNION
    SELECT 'Average Salary'
    UNION
    SELECT 'High Salary'
)
```
**Purpose**: Ensures that all categories appear in the final output, even if there are no accounts in a category.

---

## Step 2: Categorize Salaries and Count Accounts

Use a `CASE` statement to group accounts into their respective salary categories:
- **`income < 20000`**: `Low Salary`
- **`income BETWEEN 20000 AND 50000`**: `Average Salary`
- **`income > 50000`**: `High Salary`

Count the number of accounts in each category using `COUNT(income)` and `GROUP BY`.

### Query:
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
**Purpose**: Calculates the number of accounts in each category.

---

## Step 3: Combine Categories and Counts Using LEFT JOIN

Perform a `LEFT JOIN` between `category_name` (all possible categories) and `category_sum` (categories with counts):
- Use `IFNULL(accounts_count, 0)` to ensure that categories with no accounts are displayed with a count of 0.

### Final Query:
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
**Purpose**: Ensures all categories are present in the output, even if they have no accounts.

---

## Example Walkthrough

### Input:
| account_id | income  |
|------------|---------|
| 3          | 108939  |
| 2          | 12747   |
| 8          | 87709   |
| 6          | 91796   |

### Step 1: Define Categories
| category       |
|----------------|
| Low Salary     |
| Average Salary |
| High Salary    |

### Step 2: Categorize Salaries and Count Accounts
| category       | accounts_count |
|----------------|----------------|
| Low Salary     | 1              |
| High Salary    | 3              |

### Step 3: Combine Categories and Counts
| category       | accounts_count |
|----------------|----------------|
| Low Salary     | 1              |
| Average Salary | 0              |
| High Salary    | 3              |

---

## Key Points

1. **Ensures All Categories Appear**:
   - The `LEFT JOIN` ensures that categories with no accounts are included in the output.

2. **Handles Missing Data**:
   - Categories with no accounts are assigned a count of `0` using `IFNULL()`.

3. **Efficient and Scalable**:
   - Handles large datasets by grouping accounts and joining predefined categories.

