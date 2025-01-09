# Query for Shortest and Longest City Names

## Problem Statement
Query the two cities in the `STATION` table with the shortest and longest `CITY` names, as well as their respective lengths (i.e., the number of characters in the name). If there is more than one city with the same length, choose the one that comes first when ordered alphabetically.

### Table Schema
`STATION`

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
Two rows:
1. The city with the shortest name and its length.
2. The city with the longest name and its length.

### Constraints
- If there are multiple cities with the shortest or longest name, select the one that comes first alphabetically.

## Example
**Input Table (STATION)**:
| ID  | CITY      | STATE | LAT_N  | LONG_W  |
|------|-----------|-------|--------|---------|
| 1    | York      | NY    | 40.712 | -74.006 |
| 2    | Chicago   | IL    | 41.878 | -87.629 |
| 3    | San Diego | CA    | 32.715 | -117.161|

**Output**:
| CITY      | LENGTH(CITY) |
|-----------|--------------|
| York      | 4            |
| San Diego | 9            |
