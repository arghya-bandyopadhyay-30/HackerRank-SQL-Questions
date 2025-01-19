# Detailed Explanation: Find Prices of Products on a Specific Date

This document explains a SQL query that determines the price of all products on `2019-08-16`, considering price changes and assigning default values for products without changes.

---

## Step-by-Step Breakdown

### **Step 1: Identify the Most Recent Price Change**

```sql
SELECT
    product_id,
    MAX(change_date) AS max_change_date
FROM
    Products
WHERE
    change_date <= '2019-08-16'
GROUP BY
    product_id
```

#### **Purpose**
Find the latest price change date (`max_change_date`) for each product before or on `2019-08-16`.

#### **Key Features**

- **`MAX(change_date)`**: Ensures the most recent price change is selected.
- **`GROUP BY product_id`**: Groups results by each product.

---

### **Step 2: Join to Retrieve the Latest Prices**

```sql
SELECT
    p.product_id,
    p.new_price AS price
FROM
    Products p
INNER JOIN
    (
        SELECT
            product_id,
            MAX(change_date) AS max_change_date
        FROM
            Products
        WHERE
            change_date <= '2019-08-16'
        GROUP BY
            product_id
    ) fp
ON
    fp.product_id = p.product_id
    AND fp.max_change_date = p.change_date
```

#### **Purpose**
Retrieve the `new_price` corresponding to the latest price change date for each product.

#### **Key Features**

- **`INNER JOIN`**: Ensures only rows matching the latest change date are included.
- Combines subquery results with the original `Products` table to fetch the corresponding price.

---

### **Step 3: Handle Default Prices**

```sql
SELECT
    p.product_id,
    10 AS price
FROM
    Products p
WHERE
    p.product_id NOT IN (
        SELECT
            product_id
        FROM
            (
                SELECT
                    product_id,
                    MAX(change_date) AS max_change_date
                FROM
                    Products
                WHERE
                    change_date <= '2019-08-16'
                GROUP BY
                    product_id
            ) fp
    )
```

#### **Purpose**
Assign a default price of 10 for products without any price changes before or on `2019-08-16`.

#### **Key Features**

- **`NOT IN`**: Identifies products missing from the filtered results of price changes.
- Default price (`10`) is assigned to such products.

---

### **Step 4: Combine Results**

```sql
SELECT
    p.product_id,
    p.new_price AS price
FROM
    Products p
INNER JOIN
    (
        SELECT
            product_id,
            MAX(change_date) AS max_change_date
        FROM
            Products
        WHERE
            change_date <= '2019-08-16'
        GROUP BY
            product_id
    ) fp
ON
    fp.product_id = p.product_id
    AND fp.max_change_date = p.change_date

UNION

SELECT
    p.product_id,
    10 AS price
FROM
    Products p
WHERE
    p.product_id NOT IN (
        SELECT
            product_id
        FROM
            (
                SELECT
                    product_id,
                    MAX(change_date) AS max_change_date
                FROM
                    Products
                WHERE
                    change_date <= '2019-08-16'
                GROUP BY
                    product_id
            ) fp
    );
```

#### **Purpose**
Combine the results of:
1. Products with price changes.
2. Products without price changes (assigned default price).

#### **Key Features**

- **`UNION`**: Merges results from the two queries, ensuring a complete price list for all products.

---

## Example Walkthrough

### **Input Data**

| product_id | new_price | change_date |
|------------|-----------|-------------|
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |

### **Step 1: Filter for Price Changes Before or On 2019-08-16**

| product_id | max_change_date |
|------------|-----------------|
| 1          | 2019-08-16      |
| 2          | 2019-08-14      |

### **Step 2: Join to Get Latest Prices**

| product_id | price |
|------------|-------|
| 1          | 35    |
| 2          | 50    |

### **Step 3: Add Default Prices for Products with No Changes**

| product_id | price |
|------------|-------|
| 3          | 10    |

### **Step 4: Combine Results**

| product_id | price |
|------------|-------|
| 1          | 35    |
| 2          | 50    |
| 3          | 10    |

---

## Key Features of the Query

### **1. Handles Default Prices**
- Products without price changes default to a price of 10.

### **2. Handles Multiple Changes**
- The `MAX(change_date)` ensures the most recent price before or on `2019-08-16` is used.

### **3. Combines Results Efficiently**
- The `UNION` operator consolidates results from two queries.

---

## Key Considerations

### **1. Performance**
- Efficient grouping and filtering ensure scalability for large datasets.

### **2. Correctness**
- The query handles both products with changes and those without.

### **3. Extensibility**
- Can be easily modified for other dates or default prices.