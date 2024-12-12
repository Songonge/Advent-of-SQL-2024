WITH production_trends AS (
  SELECT
    production_date,
    toys_produced,
    LAG(toys_produced) OVER (ORDER BY production_date) AS previous_day_production,
    toys_produced - LAG(toys_produced) OVER (ORDER BY production_date) AS production_change,
    ROUND(
      (toys_produced - LAG(toys_produced) OVER (ORDER BY production_date))::numeric /
      NULLIF(LAG(toys_produced) OVER (ORDER BY production_date), 0) * 100,
      2
    ) AS production_change_percentage
  FROM toy_production_new
)
SELECT 
	production_date
FROM production_trends
WHERE production_change_percentage IS NOT NULL
ORDER BY production_change_percentage DESC
LIMIT 1
;
