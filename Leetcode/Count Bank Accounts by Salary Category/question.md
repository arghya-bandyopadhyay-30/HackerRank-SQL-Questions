# Count Bank Accounts by Salary Category

## Problem Statement

You are given a table `Accounts` containing information about the monthly income for various bank accounts. Write a query to calculate the number of bank accounts in each of the following salary categories:

1. **Low Salary**: All incomes strictly less than $20,000.
2. **Average Salary**: All incomes in the inclusive range [$20,000, $50,000].
3. **High Salary**: All incomes strictly greater than $50,000.

The result table must:
- Contain all three categories.
- Show `0` for categories with no accounts.

---

## Table Schema

### Accounts Table
| Column Name | Type | Description                                     |
|-------------|------|-------------------------------------------------|
| account_id  | int  | Unique identifier for the account (primary key).|
| income      | int  | Monthly income for the bank account.            |

---

## Output Format

The result table should include:
1. `category`: The salary category name.
2. `accounts_count`: The number of accounts in that category.

### Result Table
| Column Name     | Type    | Description                          |
|-----------------|---------|--------------------------------------|
| category        | varchar | Name of the salary category.         |
| accounts_count  | int     | Number of accounts in the category.  |

---

## Example Input

### Accounts Table:
| account_id | income |
|------------|--------|
| 3          | 108939 |
| 2          | 12747  |
| 8          | 87709  |
| 6          | 91796  |

---

## Example Output

| category       | accounts_count |
|----------------|----------------|
| Low Salary     | 1              |
| Average Salary | 0              |
| High Salary    | 3              |

---

## Explanation

1. **Low Salary**:
   - Accounts with income less than $20,000: `account_id = 2`.
   - Total count: `1`.

2. **Average Salary**:
   - Accounts with income between $20,000 and $50,000: None.
   - Total count: `0`.

3. **High Salary**:
   - Accounts with income greater than $50,000: `account_id = 3, 8, 6`.
   - Total count: `3`.