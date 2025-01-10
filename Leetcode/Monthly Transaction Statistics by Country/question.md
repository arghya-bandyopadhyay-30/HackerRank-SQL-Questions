# Monthly Transaction Statistics by Country

## Problem Statement
You are given a table `Transactions` containing information about incoming transactions. Write an SQL query to calculate the following for each month and country:
1. `trans_count`: The total number of transactions.
2. `approved_count`: The total number of approved transactions.
3. `trans_total_amount`: The total amount of all transactions.
4. `approved_total_amount`: The total amount of approved transactions.

---

## Table Schema

### Transactions Table
| Column Name   | Type    | Description                             |
|---------------|---------|-----------------------------------------|
| id            | int     | Unique identifier for each transaction.|
| country       | varchar | The country where the transaction occurred. |
| state         | enum    | The status of the transaction (`"approved"`, `"declined"`). |
| amount        | int     | The transaction amount.                |
| trans_date    | date    | The date of the transaction.           |

- `id` is the primary key.
- The `state` column can only have values `"approved"` or `"declined"`.

---

## Output Format

The output should include the following columns:
1. `month`: The year and month of the transaction in the format `YYYY-MM`.
2. `country`: The country where the transaction occurred.
3. `trans_count`: The total number of transactions for the country in the month.
4. `approved_count`: The total number of approved transactions for the country in the month.
5. `trans_total_amount`: The total amount of all transactions for the country in the month.
6. `approved_total_amount`: The total amount of approved transactions for the country in the month.

### Result Table
| Column Name             | Type    | Description                                   |
|-------------------------|---------|-----------------------------------------------|
| month                  | varchar | Year and month of the transactions (YYYY-MM). |
| country                | varchar | Country where the transaction occurred.       |
| trans_count            | int     | Total number of transactions.                |
| approved_count         | int     | Total number of approved transactions.        |
| trans_total_amount     | int     | Total amount of all transactions.            |
| approved_total_amount  | int     | Total amount of approved transactions.        |

---

## Example Input

### Transactions Table:
| id   | country | state    | amount | trans_date |
|------|---------|----------|--------|------------|
| 121  | US      | approved | 1000   | 2018-12-18 |
| 122  | US      | declined | 2000   | 2018-12-19 |
| 123  | US      | approved | 2000   | 2019-01-01 |
| 124  | DE      | approved | 2000   | 2019-01-07 |

---

## Example Output

| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
|----------|---------|-------------|----------------|--------------------|-----------------------|
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |

---

## Explanation

1. **For the month `2018-12` in the US**:
   - `trans_count` = 2 (2 transactions in total).
   - `approved_count` = 1 (1 approved transaction).
   - `trans_total_amount` = 3000 (1000 + 2000).
   - `approved_total_amount` = 1000 (only the approved transaction amount).

2. **For the month `2019-01` in the US**:
   - `trans_count` = 1 (1 transaction in total).
   - `approved_count` = 1 (1 approved transaction).
   - `trans_total_amount` = 2000.
   - `approved_total_amount` = 2000.

3. **For the month `2019-01` in Germany (DE)**:
   - `trans_count` = 1.
   - `approved_count` = 1.
   - `trans_total_amount` = 2000.
   - `approved_total_amount` = 2000.
