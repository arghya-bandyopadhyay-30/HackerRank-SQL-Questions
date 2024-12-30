# Query Median of Northern Latitudes

## Problem Statement
Query the median of the Northern Latitudes (`LAT_N`) from the `STATION` table and round your answer to 4 decimal places.

### Table Schema

| Field   | Type         | Description                                      |
|---------|--------------|--------------------------------------------------|
| ID      | NUMBER       | The unique identifier for the station.           |
| CITY    | VARCHAR2(21) | The name of the city where the station is located.|
| STATE   | VARCHAR2(2)  | The state abbreviation where the station is located.|
| LAT_N   | NUMBER       | The latitude coordinate of the station.          |
| LONG_W  | NUMBER       | The longitude coordinate of the station.         |

## Input
The `STATION` table.

## Output
- The median value of `LAT_N`, rounded to 4 decimal places.

## Example
1. If the `LAT_N` values are: 32.1, 45.2, 50.3, 60.4, 70.5
The median is `50.3` (the middle value when sorted).

2. If the `LAT_N` values are: 32.1, 45.2, 50.3, 60.4
The median is `(45.2 + 50.3) / 2 = 47.75`.

### Constraints
- Handle both odd and even numbers of rows.
- Ensure the result is rounded to 4 decimal places.
