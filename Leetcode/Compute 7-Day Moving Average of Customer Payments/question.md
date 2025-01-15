# Compute 7-Day Moving Average of Customer Payments

## Problem Statement

You are given a table `Customer` containing information about transactions in a restaurant. Each row records a customer's visit date and the total amount they paid. Your task is to calculate a 7-day moving average of payments, including the current day and the preceding 6 days.

---

## Table Schema

### Customer Table
| Column Name   | Type    | Description                              |
|---------------|---------|------------------------------------------|
| customer_id   | int     | Unique identifier for the customer.      |
| name          | varchar | Name of the customer.                   |
| visited_on    | date    | Date when the customer visited.          |
| amount        | int     | Total payment made by the customer.      |

- `(customer_id, visited_on)` is the primary key.

---

## Output Format

The result table should include:
1. `visited_on`: The date of the transaction.
2. `amount`: The total payment made over the 7-day window ending on this date.
3. `average_amount`: The moving average of payments over the 7-day window, rounded to 2 decimal places.

### Result Table
| Column Name    | Type    | Description                                           |
|----------------|---------|-------------------------------------------------------|
| visited_on     | date    | Date of the transaction.                              |
| amount         | int     | Total payments over the 7-day window.                 |
| average_amount | decimal | Average payments over the 7-day window (rounded to 2).|

---

## Example Input

### Customer Table:
| customer_id | name     | visited_on   | amount |
|-------------|----------|--------------|--------|
| 1           | Jhon     | 2019-01-01   | 100    |
| 2           | Daniel   | 2019-01-02   | 110    |
| 3           | Jade     | 2019-01-03   | 120    |
| 4           | Khaled   | 2019-01-04   | 130    |
| 5           | Winston  | 2019-01-05   | 110    |
| 6           | Elvis    | 2019-01-06   | 140    |
| 7           | Anna     | 2019-01-07   | 150    |
| 8           | Maria    | 2019-01-08   | 80     |
| 9           | Jaze     | 2019-01-09   | 110    |
| 1           | Jhon     | 2019-01-10   | 130    |
| 3           | Jade     | 2019-01-10   | 150    |

---

## Example Output

| visited_on   | amount | average_amount |
|--------------|--------|----------------|
| 2019-01-07   | 860    | 122.86         |
| 2019-01-08   | 840    | 120.00         |
| 2019-01-09   | 840    | 120.00         |
| 2019-01-10   | 1000   | 142.86         |

---

## Explanation

1. **2019-01-07**:
   - Days in the 7-day window: `2019-01-01` to `2019-01-07`.
   - Total payments: `100 + 110 + 120 + 130 + 110 + 140 + 150 = 860`.
   - Moving average: `860 / 7 = 122.86`.

2. **2019-01-08**:
   - Days in the 7-day window: `2019-01-02` to `2019-01-08`.
   - Total payments: `110 + 120 + 130 + 110 + 140 + 150 + 80 = 840`.
   - Moving average: `840 / 7 = 120.00`.

3. **2019-01-09**:
   - Days in the 7-day window: `2019-01-03` to `2019-01-09`.
   - Total payments: `120 + 130 + 110 + 140 + 150 + 80 + 110 = 840`.
   - Moving average: `840 / 7 = 120.00`.

4. **2019-01-10**:
   - Days in the 7-day window: `2019-01-04` to `2019-01-10`.
   - Total payments: `130 + 110 + 140 + 150 + 80 + 110 + 130 + 150 = 1000`.
   - Moving average: `1000 / 7 = 142.86`.