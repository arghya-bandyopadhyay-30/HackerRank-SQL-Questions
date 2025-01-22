# SQL Question

## Given Table: Functions

| Column | Type    |
|--------|---------|
| X      | Integer |
| Y      | Integer |

---

## Problem Statement

You are given a table `Functions` that contains two columns: `X` and `Y`.

Two pairs of values \( (X, Y) \) are considered **symmetric pairs** if:

- The first value of one pair is equal to the second value of the other pair, and vice versa.

In other words, a pair \( (X_1, Y_1) \) is symmetric with another pair \( (X_2, Y_2) \) if:

\[
X_1 = Y_2 \quad \text{and} \quad X_2 = Y_1
\]

Write an SQL query to output all symmetric pairs in ascending order by the value of `X`. Ensure that the output is formatted such that \( X \leq Y \).

---

## Example Input

| X  | Y  |
|----|----|
| 20 | 20 |
| 20 | 20 |
| 20 | 21 |
| 23 | 22 |
| 22 | 23 |
| 21 | 20 |

---

## Example Output

| X  | Y  |
|----|----|
| 20 | 20 |
| 20 | 21 |
| 22 | 23 |

---

## Explanation

The symmetric pairs in the given data are:

1. \( (20, 20) \) appears twice, meaning it is a symmetric pair.
2. \( (20, 21) \) and \( (21, 20) \) are symmetric because \( X_1 = Y_2 \) and \( X_2 = Y_1 \).
3. \( (22, 23) \) and \( (23, 22) \) are symmetric pairs.

After ensuring \( X \leq Y \), the expected output is ordered accordingly.