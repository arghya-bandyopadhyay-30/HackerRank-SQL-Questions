# Determine Node Type in Binary Tree

## Problem Statement
Given a table `BST` with the following columns:
- `N` (integer): Represents the value of a node in a binary tree.
- `P` (integer): Represents the parent node of `N`. If `P` is `NULL`, the node is the root of the tree.

Write an SQL query to determine the node type for each node in the binary tree. The possible node types are:
1. **Root**: A node with no parent (`P IS NULL`).
2. **Leaf**: A node with no children.
3. **Inner**: A node that is neither a root nor a leaf (has both a parent and at least one child).

---

## Table Schema

| Column | Type    | Description                         |
|--------|---------|-------------------------------------|
| N      | Integer | Value of the node in the binary tree. |
| P      | Integer | Value of the parent node.           |

---

## Example Input

**Input Table (`BST`):**

| N  | P    |
|----|------|
| 1  | 2    |
| 3  | 2    |
| 6  | 8    |
| 9  | 8    |
| 2  | 5    |
| 8  | 5    |
| 5  | NULL |

---

## Example Output

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

## Explanation

Using the given binary tree structure:
- **Root**: Node `5` has no parent (`P IS NULL`).
- **Leaf**: Nodes `1`, `3`, `6`, and `9` have no children.
- **Inner**: Nodes `2` and `8` have both a parent and at least one child.