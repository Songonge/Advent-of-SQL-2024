SELECT
	c.name,
	g.name,
	price
FROM children_new AS c
LEFT JOIN gifts AS g
	ON c.child_id = g.child_id
WHERE price > 
(
	SELECT 
		AVG(price)
	FROM gifts
)
ORDER BY price ASC
LIMIT 1
;
