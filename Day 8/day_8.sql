WITH RECURSIVE staff_hierarchy AS (
	SELECT 
		staff_id,
		staff_name,
		1 AS level,
		ARRAY[staff_id] AS path
	FROM staff
	WHERE manager_id IS NULL
	
	UNION ALL
	
	SELECT
		s.staff_id,
		s.staff_name,
		sh.level + 1 AS level,
		sh.path || s.staff_id AS path
	FROM staff AS s
	INNER JOIN staff_hierarchy AS sh
		ON s.manager_id = sh.staff_id
)
SELECT 
	staff_id,
	staff_name,
	level,
	array_to_string(path, ',') AS path
FROM staff_hierarchy
ORDER BY level DESC, staff_id
;

