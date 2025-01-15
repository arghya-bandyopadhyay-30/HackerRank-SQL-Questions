# Deleting Duplicate Emails

This document explains the SQL query used to remove duplicate rows from the `Person` table based on the `email` column. The query ensures that each email appears only once, retaining the record with the smallest `id`.

---

## Problem Statement

The goal is to:
1. Identify duplicate emails in the `Person` table.
2. Retain only the row with the smallest `id` for each email.
3. Delete all other duplicate rows.

---

## Solution

### Step 1: Understand the Requirement
1. Each email should only appear once in the `Person` table.
2. Among duplicate rows, the one with the smallest `id` should be kept.

---

### Step 2: Identify Duplicate Emails

To identify duplicate emails:
1. Compare the `email` column of one row (`p1`) with the `email` column of another row (`p2`).
2. Use a `JOIN` to find rows where:
   - `p1.email = p2.email` (same email).
   - `p1.id > p2.id` (retain the row with the smallest `id`).

---

### Step 3: Delete Duplicate Rows

The `DELETE` statement removes rows that meet the condition:
- If two rows have the same `email`, delete the row with the larger `id`.

#### Query:
```sql
DELETE
    p1
FROM
    Person p1
JOIN
    Person p2
ON
    p1.email = p2.email
    AND p1.id > p2.id;
```

---

## How It Works

### JOIN Condition:
- **`p1.email = p2.email`**: Ensures the emails are duplicates.
- **`p1.id > p2.id`**: Ensures that only the row with the larger `id` is considered for deletion.

### DELETE Statement:
- Deletes rows from `p1` that satisfy the JOIN condition.

---

## Example Walkthrough

### Input Table:

| id  | email             |
|------|-------------------|
| 1    | john@example.com  |
| 2    | bob@example.com   |
| 3    | john@example.com  |

### Step 1: Identify Duplicates
The `JOIN` identifies rows with duplicate emails:

| p1.id | p1.email          | p2.id | p2.email         |
|-------|--------------------|-------|------------------|
| 3     | john@example.com   | 1     | john@example.com |

### Step 2: Delete Rows with Larger `id`
The row with `id = 3` is deleted because it has a duplicate email and a larger `id`.

### Final Output:

| id  | email             |
|------|-------------------|
| 1    | john@example.com  |
| 2    | bob@example.com   |

---

## Key Concepts

### 1. Efficient De-duplication:
The `JOIN` ensures only duplicate rows are targeted for deletion.

### 2. Retains Smallest `id`:
By comparing `id` values, only the row with the smallest `id` is retained.

### 3. Scalable Solution:
This query works efficiently even for large datasets.
