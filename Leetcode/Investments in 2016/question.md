# SQL Question

## Table: Insurance

| Column Name | Type  |
|-------------|-------|
| pid         | int   |
| tiv_2015    | float |
| tiv_2016    | float |
| lat         | float |
| lon         | float |

### Primary Key
- `pid` is the primary key.

### Description
- Each row contains information about one policy:
  - `pid`: Policyholder's ID.
  - `tiv_2015`: Total investment value in 2015.
  - `tiv_2016`: Total investment value in 2016.
  - `lat`: Latitude of the policyholder's city.
  - `lon`: Longitude of the policyholder's city.

### Problem
Write a solution to report the sum of all total investment values in `2016` (`tiv_2016`) for all policyholders who:
1. Have the same `tiv_2015` value as one or more other policyholders.
2. Are not located in the same city as any other policyholder (i.e., the `(lat, lon)` pairs must be unique).

The result should be rounded to two decimal places.

---

### Example Input

| pid | tiv_2015 | tiv_2016 | lat | lon |
|-----|----------|----------|-----|-----|
| 1   | 10       | 5        | 10  | 10  |
| 2   | 20       | 20       | 20  | 20  |
| 3   | 10       | 30       | 20  | 20  |
| 4   | 10       | 40       | 40  | 40  |

### Example Output

| tiv_2016 |
|----------|
| 45.00    |

### Explanation
- Records `1` and `4` meet the criteria:
  - Both have `tiv_2015 = 10`, which is shared by multiple policyholders.
  - Their locations `(lat, lon)` are unique.
- The sum of `tiv_2016` for these records is `5 + 40 = 45.00`.