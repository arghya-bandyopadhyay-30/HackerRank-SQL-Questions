# SQL Question

## Given Table: transactions

| Column Name      | Type |
|------------------|------|
| transaction_id   | int  |
| amount           | int  |
| transaction_date | date |

### Primary Key
- `transaction_id` uniquely identifies each row in this table.

---

### Problem Statement

You are given a table `transactions` that contains details of financial transactions, including:

- `transaction_id`: The unique identifier for the transaction.
- `amount`: The transaction amount.
- `transaction_date`: The date the transaction occurred.

Write an SQL query to find the sum of amounts for odd and even transaction amounts for each day. If there are no odd or even transactions for a specific date, display the sum as `0`.

**Output Requirements:**
1. Return the result sorted by `transaction_date` in ascending order.
2. The result should include columns:
   - `transaction_date`
   - `odd_sum`: Sum of odd amounts
   - `even_sum`: Sum of even amounts

---

### Example Input

#### transactions Table:

| transaction_id | amount | transaction_date |
|----------------|--------|------------------|
| 1              | 150    | 2024-07-01        |
| 2              | 200    | 2024-07-01        |
| 3              | 75     | 2024-07-01        |
| 4              | 300    | 2024-07-02        |
| 5              | 50     | 2024-07-02        |
| 6              | 120    | 2024-07-03        |

---

### Example Output

| transaction_date | odd_sum | even_sum |
|------------------|---------|----------|
| 2024-07-01       | 75      | 350      |
| 2024-07-02       | 0       | 350      |
| 2024-07-03       | 0       | 120      |

---

### Explanation

For the given transactions:

- **Date `2024-07-01`:**  
  - Odd amounts: `75` → `odd_sum = 75`
  - Even amounts: `150 + 200 = 350` → `even_sum = 350`

- **Date `2024-07-02`:**  
  - No odd transactions → `odd_sum = 0`
  - Even amounts: `300 + 50 = 350` → `even_sum = 350`

- **Date `2024-07-03`:**  
  - No odd transactions → `odd_sum = 0`
  - Even amounts: `120` → `even_sum = 120`

**Note:** The result is ordered by `transaction_date` in ascending order.
