# Delete Duplicate Emails

## Problem Statement

You are given a table `Person` containing email addresses. Your task is to delete all duplicate emails from the table, keeping only the record with the smallest `id` for each email.

---

## Table Schema

### Person Table
| Column Name | Type    | Description                              |
|-------------|---------|------------------------------------------|
| id          | int     | Unique identifier for the row (primary key). |
| email       | varchar | Email address of the person.            |

- The `id` column is the primary key.
- The `email` column does not allow uppercase letters.

---

## Output Format

After executing the query, the `Person` table should:
1. Retain only unique emails.
2. Keep the record with the smallest `id` for each email.
3. Be ordered in any order, as the final order does not matter.

---

## Example Input

### Person Table:
| id | email            |
|----|------------------|
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |

---

## Example Output

### Person Table:
| id | email            |
|----|------------------|
| 1  | john@example.com |
| 2  | bob@example.com  |

---

## Explanation

1. The email `john@example.com` appears twice (with `id = 1` and `id = 3`).
2. The row with the smallest `id` (i.e., `id = 1`) is retained.
3. All other duplicates are removed.

---
