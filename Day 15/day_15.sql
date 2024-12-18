SELECT 
	a.place_name
FROM sleigh_locations sl
JOIN areas a 
	ON ST_DWithin(sl.coordinate, a.polygon, 0)
WHERE sl.timestamp = (SELECT MAX(timestamp) FROM sleigh_locations)
LIMIT 1
;
	