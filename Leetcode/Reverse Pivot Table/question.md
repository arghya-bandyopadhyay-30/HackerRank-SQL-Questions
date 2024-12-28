# SQL Question

## Table: Products

| Column Name | Type |
|-------------|---------|
| product_id  | int     |
| store1      | int     |
| store2      | int     |
| store3      | int     |

### Primary Key
- `product_id` is the primary key.

### Description
- This table stores information about product prices across three different stores:
  - `product_id`: Unique identifier for each product.
  - `store1`, `store2`, `store3`: Prices of the product in three stores.
  - If a product is not available in a store, the price value will be `NULL`.

---

### Problem
Write an SQL query to transform the `Products` table into a new format such that each row contains:

1. `product_id`
2. `store` (store1, store2, or store3)
3. `price` (the product's price in that store)

If the product is not available in a store (i.e., the price is `NULL`), exclude that row from the result.

---

### Example Input

#### Products Table:
| product_id | store1 | store2 | store3 |
|------------|--------|--------|--------|
| 0          | 95     | 100    | 105    |
| 1          | 70     | null   | 80     |

---

### Example Output

#### Expected Result Table:
| product_id | store  | price |
|------------|--------|-------|
| 0          | store1 | 95    |
| 0          | store2 | 100   |
| 0          | store3 | 105   |
| 1          | store1 | 70    |
| 1          | store3 | 80    |

---

### Explanation
- Product `0` is available in all stores with prices `95, 100, 105`.
- Product `1` is available in `store1` and `store3`, but not in `store2` (hence it is excluded from the result).

---

### Constraints
- Return the result in any order.
- Use only SQL without creating temporary tables.
