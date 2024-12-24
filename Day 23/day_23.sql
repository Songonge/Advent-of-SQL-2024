WITH Gaps AS (
    SELECT 
        id AS current_id,
        LEAD(id) OVER (ORDER BY id) AS next_id
    FROM sequence_table
),
MissingNumbers AS (
    SELECT 
        gap_start,
        gap_end,
        ARRAY_AGG(missing_num) AS missing_numbers
    FROM (
        SELECT 
            current_id + 1 AS gap_start,
            next_id - 1 AS gap_end
        FROM Gaps
        WHERE next_id > current_id + 1
    ) gap
    CROSS JOIN LATERAL generate_series(gap.gap_start, gap.gap_end) AS missing_num
    GROUP BY gap_start, gap_end
)
SELECT 
	gap_start, 
	gap_end, 
	missing_numbers
FROM MissingNumbers
ORDER BY gap_start
;
