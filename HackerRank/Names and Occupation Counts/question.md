# Query Names and Occupation Counts

## Problem Statement
Query the `OCCUPATIONS` table to generate the following two result sets:

1. An alphabetically ordered list of all names, each followed by the first letter of their corresponding occupation in parentheses.
   - Example: `AnActorName(A)`, `ADoctorName(D)`, `AProfessorName(P)`, `ASingerName(S)`.

2. The number of occurrences of each occupation in the following format:
`There are a total of [occupation_count] [occupation]s.`
- `[occupation_count]` is the count of each occupation.
- `[occupation]` is the lowercase name of the occupation.
- If multiple occupations have the same count, they should be sorted alphabetically.

### Table Schema

| Column     | Type   | Description                                    |
|------------|--------|------------------------------------------------|
| Name       | String | The name of the individual.                   |
| Occupation | String | The profession of the individual (`Doctor`, `Professor`, `Singer`, or `Actor`). |

### Constraints
- Each occupation will have at least two entries in the table.

### Output Format
1. List of names with their profession's initial in parentheses.
2. Total count of each occupation, formatted as:  
`There are a total of [occupation_count] [occupation]s.`


---

## Example

**Input Table (OCCUPATIONS)**:

| Name         | Occupation   |
|--------------|--------------|
| John         | Doctor       |
| Alice        | Actor        |
| Bob          | Professor    |
| Carol        | Singer       |
| Dave         | Doctor       |

**Output**:
```
Alice(A) 
Bob(P) 
Carol(S) 
John(D) 
Dave(D) 
There are a total of 1 actors. 
There are a total of 2 doctors. 
There are a total of 1 professors. 
There are a total of 1 singers.
```

