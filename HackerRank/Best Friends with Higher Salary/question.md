# SQL Question

## Given Tables:

### **Students Table**
| Column | Type   |
|--------|--------|
| ID     | Integer|
| Name   | String |

---

### **Friends Table**
| Column    | Type   |
|-----------|--------|
| ID        | Integer|
| Friend_ID | Integer|

---

### **Packages Table**
| Column | Type  |
|--------|-------|
| ID     | Integer|
| Salary | Float  |

---

### Problem Statement

You are given three tables:

- **Students**: Contains student ID and name.
- **Friends**: Each student has one best friend denoted by `Friend_ID`.
- **Packages**: Contains the offered salary for each student.

**Objective:**

Write an SQL query to output the names of students whose best friends received a higher salary offer than themselves.

**Output Requirements:**

- The result should be sorted by the salary offered to the best friends in ascending order.
- It is guaranteed that no two students received the same salary offer.

---

### Example Input

#### **Students Table**
| ID | Name     |
|----|----------|
| 1  | Ashley   |
| 2  | Samantha |
| 3  | Julia    |
| 4  | Scarlet  |

---

#### **Friends Table**
| ID | Friend_ID |
|----|-----------|
| 1  | 2         |
| 2  | 3         |
| 3  | 4         |
| 4  | 1         |

---

#### **Packages Table**
| ID | Salary |
|----|--------|
| 1  | 15.20  |
| 2  | 10.06  |
| 3  | 11.55  |
| 4  | 12.12  |

---

### Example Output

| Name     |
|----------|
| Samantha |
| Julia    |
| Scarlet  |

---

### Explanation

- Samantha's best friend (Julia) received a salary of 11.55, which is greater than her salary (10.06).
- Julia's best friend (Scarlet) received a salary of 12.12, which is greater than her salary (11.55).
- Scarlet's best friend (Ashley) received a salary of 15.20, which is greater than her salary (12.12).
- Ashley's best friend (Samantha) received a salary of 10.06, which is **not** greater than her salary (15.20), so Ashley is not included.