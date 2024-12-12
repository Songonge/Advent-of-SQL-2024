SELECT 
	c.name,
    w.wishes ->> 'first_choice' AS primary_wish,
    w.wishes ->> 'second_choice' AS secondary_wish,
    (w.wishes -> 'colors'->> 0) AS favorite_color,
    json_array_length(w.wishes -> 'colors') AS color_count,
	CASE
		WHEN t1.difficulty_to_make = 1 THEN 'Simple Gift'
		WHEN t1.difficulty_to_make = 2 THEN 'Moderate Gift'
		WHEN t1.difficulty_to_make >= 3 THEN 'Complex Gift'
	END AS gift_complexity,
	CASE
		WHEN t1.category = 'outdoor' THEN 'Outside Workshop'
		WHEN t1.category = 'educational' THEN 'Learning Workshop'
		ELSE 'General Workshop'
	END AS assigned_workshop
FROM children AS c
LEFT JOIN wish_lists AS w
	ON c.child_id = w.child_id
LEFT JOIN toy_catalogue AS t1
	ON (w.wishes ->> 'first_choice') = t1.toy_name
LEFT JOIN toy_catalogue AS t2
	ON (w.wishes ->> 'first_choice') = t2.toy_name
ORDER BY c.name ASC
LIMIT 5;
;
