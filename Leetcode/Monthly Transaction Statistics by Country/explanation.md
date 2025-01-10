# Monthly Transaction Statistics by Country

This document explains how to calculate monthly transaction statistics for each country, including:

1. **Total number of transactions (`trans_count`)**
2. **Number of approved transactions (`approved_count`)**
3. **Total transaction amount (`trans_total_amount`)**
4. **Total approved transaction amount (`approved_total_amount`)**

---

## Step-by-Step Breakdown

### Step 1: Extract the Month and Year
- Use the `YEAR()` and `MONTH()` functions to extract the year and month from the `trans_date` column.
- Combine them into a single column formatted as `YYYY-MM` using the `CONCAT()` and `LPAD()` functions.

#### Example:
```sql
CONCAT(YEAR(trans_date), "-", LPAD(MONTH(trans_date), 2, '0')) AS month
```
**What It Does:**
- For `trans_date = 2018-12-18`, the result is `2018-12`.

---

### Step 2: Count Total Transactions (`trans_count`)
- Use `COUNT(state)` to count the total number of transactions for each month and country.

---

### Step 3: Count Approved Transactions (`approved_count`)
- Use a `CASE` statement to count only rows where `state = 'approved'`.

#### Example:
```sql
SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count
```

---

### Step 4: Calculate Total Transaction Amount (`trans_total_amount`)
- Use `SUM(amount)` to calculate the total amount for all transactions in each month and country.

---

### Step 5: Calculate Total Approved Transaction Amount (`approved_total_amount`)
- Use a `CASE` statement within `SUM()` to calculate the total amount for approved transactions.

#### Example:
```sql
SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
```

---

### Step 6: Group the Results
- Group by `month` and `country` to calculate the statistics for each combination.

---

## Final Query

```sql
SELECT
    CONCAT(YEAR(trans_date), "-", LPAD(MONTH(trans_date), 2, '0')) AS month,
    country,
    COUNT(state) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM
    Transactions
GROUP BY
    month, country;
```

---

## Example Walkthrough

### Input Data:
| id  | country | state     | amount | trans_date  |
|-----|---------|-----------|--------|-------------|
| 121 | US      | approved  | 1000   | 2018-12-18  |
| 122 | US      | declined  | 2000   | 2018-12-19  |
| 123 | US      | approved  | 2000   | 2019-01-01  |
| 124 | DE      | approved  | 2000   | 2019-01-07  |

---

### Execution Steps:

#### Extract Month and Year:
- `2018-12` for transactions on `2018-12-18` and `2018-12-19`.
- `2019-01` for transactions on `2019-01-01` and `2019-01-07`.

#### Group by Month and Country:
- Group all transactions for each month and country.

#### Calculate Metrics:

1. **For 2018-12, US:**
   - `trans_count = 2` (2 transactions)
   - `approved_count = 1` (1 approved transaction)
   - `trans_total_amount = 1000 + 2000 = 3000`
   - `approved_total_amount = 1000` (only the approved transaction)

2. **For 2019-01, US:**
   - `trans_count = 1` (1 transaction)
   - `approved_count = 1` (1 approved transaction)
   - `trans_total_amount = 2000`
   - `approved_total_amount = 2000`

3. **For 2019-01, DE:**
   - `trans_count = 1`
   - `approved_count = 1`
   - `trans_total_amount = 2000`
   - `approved_total_amount = 2000`

---

### Output:
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
|----------|---------|-------------|----------------|--------------------|-----------------------|
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |

---

## Key Takeaways
- This query is useful for generating monthly transaction statistics by country.
- The use of `CASE` statements ensures flexibility in filtering and summing data.
- Grouping by `month` and `country` provides a clear view of transaction performance over time.

