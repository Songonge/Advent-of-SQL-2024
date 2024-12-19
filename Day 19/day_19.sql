WITH avg_last_score AS (
    SELECT 
        AVG(year_end_performance_scores[array_length(year_end_performance_scores, 1)]) AS avg_score
    FROM employees
),
salary_with_bonuses AS (
    SELECT 
        employee_id,
        name,
        salary,
        CASE 
            WHEN year_end_performance_scores[array_length(year_end_performance_scores, 1)] > avg_score 
			THEN salary * 1.15
            ELSE salary
        END AS salary_with_bonus
    FROM employees
    CROSS JOIN avg_last_score 
)
SELECT 
    ROUND(SUM(salary_with_bonus),2) AS total_salary_with_bonuses
FROM salary_with_bonuses
;
	