SELECT
    h.hacker_id,
    h.name
FROM
    submissions s
INNER JOIN
    hackers h ON h.hacker_id = s.hacker_id
INNER JOIN
    challenges c ON c.challenge_id = s.challenge_id
INNER JOIN
    difficulty d ON d.difficulty_level = c.difficulty_level
WHERE
    s.score = d.score
GROUP BY
    h.hacker_id, h.name
HAVING
    COUNT(c.challenge_id) > 1
ORDER BY
    COUNT(c.challenge_id) DESC,
    h.hacker_id ASC;