WITH timezone_info AS (
    SELECT 'North Pole HQ' AS workshop_name, 'UTC' AS timezone
	FROM Workshops
),
workshop_hours AS (
    SELECT 
        w.workshop_id,
        w.workshop_name,
        tz.timezone,
        (w.business_start_time AT TIME ZONE tz.timezone AT TIME ZONE 'UTC')::time AS utc_start,
        (w.business_end_time AT TIME ZONE tz.timezone AT TIME ZONE 'UTC')::time AS utc_end
    FROM Workshops w
    JOIN timezone_info tz ON w.workshop_name = tz.workshop_name
)
SELECT 
    -- MIN(utc_start) AS meeting_start_utc
	utc_start AS meeting_start_utc,
	utc_end AS meeting_end_utc
FROM workshop_hours
WHERE utc_start <= ALL (SELECT utc_end FROM workshop_hours)
  AND utc_start + INTERVAL '1 hour' <= ALL (SELECT utc_end FROM workshop_hours)
;



