WITH played_songs AS (
	SELECT
		s.song_title,
		COUNT(*) AS total_plays,
		SUM(
			CASE
				WHEN up.duration < s.song_duration THEN 1
				ELSE 0
			END
		) AS total_skips
	FROM user_plays up
	JOIN songs s 
		ON up.song_id = s.song_id
	GROUP BY s.song_title
)
SELECT
	song_title,
	total_plays,
	total_skips
FROM played_songs
ORDER BY total_plays DESC, total_skips ASC
;
