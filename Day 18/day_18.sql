WITH RECURSIVE hierarchy AS (
    SELECT 
		staff_id, 
		staff_name, 
		manager_id, 
		1 AS level
    FROM staff_new
    WHERE manager_id IS NULL
	
    UNION ALL
	
    SELECT 
		s.staff_id, 
		s.staff_name,
		s.manager_id, 
		h.level + 1
    FROM staff_new s
    JOIN hierarchy h 
		ON h.staff_id = s.manager_id
),
level_counts AS (
    SELECT 
		level, 
		COUNT(*) AS total_employees
    FROM hierarchy
    GROUP BY level
),
max_level AS (
    SELECT 
		level
    FROM level_counts
    ORDER BY total_employees DESC, level
    LIMIT 1
)
SELECT 
	h.staff_id, 
	h.staff_name, 
	h.manager_id, 
	h.level
FROM hierarchy h
JOIN max_level m 
	ON h.level = m.level
ORDER BY h.staff_id
LIMIT 1
;



