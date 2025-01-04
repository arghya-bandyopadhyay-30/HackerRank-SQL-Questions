# Remove Duplicate Routes

## Problem Statement
Given a table `routes` with columns `source`, `destination`, and `distance`, write an SQL query to remove duplicate routes. A route is considered a duplicate if the pair (`source`, `destination`) and (`destination`, `source`) represent the same connection, regardless of the order. 

The output table should include only unique routes, ensuring the `source` is alphabetically smaller than `destination` for the same connection. For example, if both (`Mumbai`, `Bangalore`) and (`Bangalore`, `Mumbai`) exist, only (`Mumbai`, `Bangalore`) should appear in the output.

### Table Schema

| Column      | Type    | Description                                 |
|-------------|---------|---------------------------------------------|
| source      | String  | The starting point of the route.           |
| destination | String  | The endpoint of the route.                 |
| distance    | Integer | The distance between `source` and `destination`. |

### Example Input

| source      | destination | distance |
|-------------|-------------|----------|
| Mumbai      | Bangalore   | 500      |
| Bangalore   | Mumbai      | 500      |
| Delhi       | Mathura     | 150      |
| Nagpur      | Pune        | 500      |
| Pune        | Nagpur      | 500      |

### Example Output

| source      | destination | distance |
|-------------|-------------|----------|
| Bangalore   | Mumbai      | 500      |
| Delhi       | Mathura     | 150      |
| Nagpur      | Pune        | 500      |

---

## Constraints
- The `source` and `destination` columns represent cities, and their order does not matter for duplicates.
- The `distance` between duplicate routes is assumed to be the same.

