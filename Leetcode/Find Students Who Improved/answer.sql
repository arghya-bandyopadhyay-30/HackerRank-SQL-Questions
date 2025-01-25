WITH RankedScores AS (
    SELECT
        student_id,
        subject,
        score,
        exam_date,
        MIN(exam_date) OVER (PARTITION BY student_id, subject) AS first_exam,
        MAX(exam_date) OVER (PARTITION BY student_id, subject) AS latest_exam
    FROM
        Scores s
)
SELECT
    student_id,
    subject,
    MAX(CASE WHEN exam_date = first_exam THEN score END) AS first_score,
    MAX(CASE WHEN exam_date = latest_exam THEN score END) AS latest_score
FROM
    RankedScores
GROUP BY
    student_id, subject
HAVING
    COUNT(DISTINCT exam_date) >= 2 
    AND MAX(CASE WHEN exam_date = first_exam THEN score END) < 
        MAX(CASE WHEN exam_date = latest_exam THEN score END)
ORDER BY
    student_id, subject;