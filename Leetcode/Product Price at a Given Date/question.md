# SQL Question

## Table: Products

| Column Name   | Type    |
|---------------|---------|
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |

### Primary Key
- `(product_id, change_date)` is the primary key.

### Description
- This table stores the price changes for products:
  - `product_id`: Unique identifier for each product.
  - `new_price`: The new price of the product as of the `change_date`.
  - `change_date`: The date on which the price change occurred.

### Problem
Find the prices of all products on `2019-08-16`. Assume that the price of all products before any recorded change is `10`.

---

### Example Input
| product_id | new_price | change_date |
|------------|-----------|-------------|
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |

---

### Example Output
| product_id | price |
|------------|-------|
| 2          | 50    |
| 1          | 35    |
| 3          | 10    |

---

### Explanation
- Product `1` had price changes on `2019-08-14`, `2019-08-15`, and `2019-08-16`. The price on `2019-08-16` was `35`.
- Product `2` had price changes on `2019-08-14` and `2019-08-17`. On `2019-08-16`, the last price change was on `2019-08-14`, so the price was `50`.
- Product `3` has no price changes before `2019-08-16`, so its price is `10` (default price).
