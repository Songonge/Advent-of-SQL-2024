WITH total_amount AS (
	SELECT
		EXTRACT(YEAR FROM sale_date) yr,
		EXTRACT(QUARTER FROM sale_date) quarter,
		SUM(amount) AS total_sales,
		LAG(SUM(amount), 1) OVER (
			ORDER BY 
				EXTRACT(YEAR FROM sale_date), 
				EXTRACT(QUARTER FROM sale_date)
			) AS previous_quarter_amount
	FROM sales
	GROUP BY yr, quarter
)
SELECT
	yr,
	quarter,
	total_sales,
	total_sales / previous_quarter_amount AS growth_rate
FROM total_amount
ORDER BY growth_rate DESC NULLS LAST
LIMIT 1
;
