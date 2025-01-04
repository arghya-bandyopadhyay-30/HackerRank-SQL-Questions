# Unique Team Pairings

## Problem Statement
Generate all possible unique team pairings from the `teams` table. Each team pairing should appear only once, and the order of teams in the pairing does not matter (e.g., `(India, Pak)` and `(Pak, India)` are considered the same pairing). Additionally, self-pairings like `(India, India)` are not allowed.

## Input Table Schema

| Column | Type   | Description           |
|--------|--------|-----------------------|
| team   | String | The name of the team. |

## Example Input

| team   |
|--------|
| Aus    |
| Eng    |
| India  |
| Pak    |

## Expected Output

| team1  | team2  |
|--------|--------|
| Aus    | Eng    |
| Aus    | India  |
| Aus    | Pak    |
| Eng    | India  |
| Eng    | Pak    |
| India  | Pak    |

## Constraints
1. Each team pairing should appear only once.
2. Self-pairings (e.g., `(India, India)`) are not allowed.
3. The output should be in lexicographical order based on the team names.