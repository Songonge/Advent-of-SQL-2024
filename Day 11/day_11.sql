WITH ranked_harvests AS (
	SELECT 
	*,
	CASE 
		WHEN season = 'Spring' THEN 1
		WHEN season = 'Summer' THEN 2
		WHEN season = 'Fall' THEN 3
		WHEN season = 'Winter' THEN 4
	END AS ordered_seasons
FROM treeharvests
)
SELECT 
	field_name,
	harvest_year,
	season,
	ROUND(AVG(trees_harvested) OVER (
		PARTITION BY field_name, harvest_year 
		ORDER BY ordered_seasons 
		ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS three_season_moving_avg
FROM ranked_harvests
ORDER BY three_season_moving_avg DESC
;
