# Determining Node Type in a Binary Tree

This document explains how to determine the type of each node in a binary tree using SQL. The classification is based on parent-child relationships stored in a binary search tree (BST) table.

---

## Overview
Each node in a binary tree can be classified as:

1. **Root**: A node with no parent.
2. **Inner**: A node with at least one child and a parent.
3. **Leaf**: A node with no children.

---

## Step-by-Step Process

### Step 1: Identify Nodes with Children
To identify all nodes that have at least one child, we create a Common Table Expression (CTE) called `parent_nodes`.

#### Query:
```sql
WITH parent_nodes AS (
    SELECT b1.N
    FROM bst b1
    WHERE EXISTS (
        SELECT 1
        FROM bst b2
        WHERE b1.N = b2.P
    )
)
```

#### Explanation:
1. The `bst` table contains two columns:
   - `N`: The node.
   - `P`: The parent of the node.
2. The `EXISTS` subquery checks if a node (`b1.N`) exists as a parent (`b2.P`) in the table.
3. Nodes with at least one child are included in the `parent_nodes` CTE.

#### Example Output of `parent_nodes`:
| N  |
|----|
| 2  |
| 8  |
| 5  |

---

### Step 2: Classify Each Node
Using a `CASE` statement, classify each node in the `bst` table as `Root`, `Inner`, or `Leaf`.

#### Query:
```sql
SELECT N,
    CASE
        WHEN P IS NULL THEN 'Root' -- Node with no parent
        WHEN N IN (SELECT N FROM parent_nodes) AND P IS NOT NULL THEN 'Inner' -- Node with at least one child and has a parent
        ELSE 'Leaf' -- Node with no child
    END AS Node_Type
FROM bst
ORDER BY N;
```

#### Explanation:
1. **Root Node**:
   - A node where `P IS NULL` (no parent) is classified as `Root`.
2. **Inner Node**:
   - A node that exists in `parent_nodes` (has at least one child) and has a parent (`P IS NOT NULL`) is classified as `Inner`.
3. **Leaf Node**:
   - Any node that is not in `parent_nodes` (has no children) is classified as `Leaf`.

---

## Final Query
Below is the complete SQL query that combines the steps:

```sql
WITH parent_nodes AS (
    SELECT b1.N
    FROM bst b1
    WHERE EXISTS (
        SELECT 1
        FROM bst b2
        WHERE b1.N = b2.P
    )
)
SELECT N,
    CASE
        WHEN P IS NULL THEN 'Root' -- Node with no parent
        WHEN N IN (SELECT N FROM parent_nodes) AND P IS NOT NULL THEN 'Inner' -- Node with at least one child and has a parent
        ELSE 'Leaf' -- Node with no child
    END AS Node_Type
FROM bst
ORDER BY N;
```

---

## Example Walkthrough

### Input Table:
| N  | P    |
|----|------|
| 1  | 2    |
| 3  | 2    |
| 6  | 8    |
| 9  | 8    |
| 2  | 5    |
| 8  | 5    |
| 5  | NULL |

### Node Classification:
1. **Root**:
   - Node `5` has no parent (`P IS NULL`).
2. **Inner**:
   - Nodes `2` and `8` have both a parent and at least one child.
3. **Leaf**:
   - Nodes `1`, `3`, `6`, and `9` have no children.

### Output:
| N  | Node Type |
|----|-----------|
| 1  | Leaf      |
| 2  | Inner     |
| 3  | Leaf      |
| 5  | Root      |
| 6  | Leaf      |
| 8  | Inner     |
| 9  | Leaf      |

---

## Summary
This process effectively classifies each node in a binary tree based on its parent-child relationships. The final SQL query is both efficient and easy to understand, making it a robust solution for binary tree node classification tasks.

