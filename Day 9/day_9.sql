WITH average_speed AS (
	SELECT
		r.reindeer_name,
		t.exercise_name,
		ROUND(AVG(t.speed_record), 2) AS avg_speed
	FROM reindeers r
	JOIN training_sessions t
		ON r.reindeer_id = t.reindeer_id
	WHERE r.reindeer_name NOT LIKE 'Rudolph'
	GROUP BY r.reindeer_name, t.exercise_name
), max_speed AS(
	SELECT
		reindeer_name,
		MAX(avg_speed) AS top_speed
	FROM average_speed
	GROUP BY reindeer_name
)
SELECT
	reindeer_name,
	top_speed
FROM max_speed
ORDER BY top_speed DESC
LIMIT 3
;
