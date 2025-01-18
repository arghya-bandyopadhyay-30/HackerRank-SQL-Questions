# SQL Question

## Table: Queue

| Column Name | Type    |
|-------------|---------|
| person_id   | int     |
| person_name | varchar |
| weight      | int     |
| turn        | int     |

### Primary Key
- `person_id` is the primary key.

### Description
- This table contains information about people waiting to board a bus:
  - `person_id`: Unique identifier for each person.
  - `person_name`: Name of the person.
  - `weight`: Weight of the person in kilograms.
  - `turn`: Order of boarding the bus, where `turn=1` denotes the first person, and `turn=n` denotes the last.

---

### Problem
The bus has a weight limit of 1000 kilograms. Write a query to find the `person_name` of the last person who can board the bus without exceeding the weight limit. Only one person can board at a time based on their turn.

---

### Example Input
| person_id | person_name | weight | turn |
|-----------|-------------|--------|------|
| 5         | Alice       | 250    | 1    |
| 4         | Bob         | 175    | 5    |
| 3         | Alex        | 350    | 2    |
| 6         | John Cena   | 400    | 3    |
| 1         | Winston     | 500    | 6    |
| 2         | Marie       | 200    | 4    |

---

### Example Output
| person_name |
|-------------|
| John Cena   |

---

### Explanation
- The bus allows passengers to board in the order of their `turn`:
  - Alice boards first with a total weight of 250.
  - Alex boards next, bringing the total weight to 600.
  - John Cena boards last without exceeding the 1000 kg limit (total weight is 1000).
  - Marie cannot board because adding her weight would exceed the limit (1200).
- The result is the name of the last person who successfully boards: `John Cena`.
