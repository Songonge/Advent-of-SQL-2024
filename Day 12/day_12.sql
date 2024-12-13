WITH percentile_request AS (
	SELECT
		gl.gift_name,
		COUNT(gr.request_id) AS overall_requests,
		PERCENT_RANK() OVER (ORDER BY COUNT(gr.request_id)) AS percentile
	FROM gift_lists gl
	LEFT JOIN gift_requests gr
		ON gl.gift_id = gr.gift_id
	GROUP BY gl.gift_name
), 
percentile_rank AS(
	SELECT
		gift_name,
		percentile,
		ROW_NUMBER() OVER (ORDER BY percentile DESC, gift_name ASC) AS row_num
	FROM percentile_request
)
SELECT
	gift_name,
	ROUND(percentile::numeric, 2) AS overall_rank
FROM percentile_rank
ORDER BY overall_rank DESC, gift_name ASC
;
