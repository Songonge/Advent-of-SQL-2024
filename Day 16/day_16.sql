WITH sleigh_times AS (
    SELECT
        sl.timestamp,
        sl.coordinate,
        LEAD(sl.timestamp) OVER (ORDER BY sl.timestamp) AS next_timestamp
    FROM sleigh_locations_new sl
),
sleigh_with_areas AS (
    SELECT
        a.place_name,
        st.timestamp,
        st.next_timestamp,
        EXTRACT(EPOCH FROM (st.next_timestamp - st.timestamp)) / 3600 AS hours_spent
    FROM sleigh_times st
    JOIN areas_new a
    	ON ST_Contains(a.polygon, st.coordinate)
),
total_hours AS (
    SELECT
        place_name,
        SUM(hours_spent) AS total_hours_spent
    FROM sleigh_with_areas
    WHERE next_timestamp IS NOT NULL 
    GROUP BY place_name
)
SELECT
    place_name
FROM total_hours
ORDER BY total_hours_spent DESC
LIMIT 1
;
