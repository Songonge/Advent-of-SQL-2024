WITH tag_changes AS 
(
SELECT
	toy_id,
	toy_name,
    ARRAY(
		-- Find tags present only in new_tags.
        SELECT UNNEST(new_tags)
        EXCEPT
        SELECT UNNEST(previous_tags)
        ) AS added_tags,
    ARRAY(
		-- Find tags common to both previous_tags and new_tags.
    	SELECT UNNEST(previous_tags)
        INTERSECT
        SELECT UNNEST(new_tags)
        ) AS unchanged_tags,
    ARRAY(
		-- Find tags present only in previous_tags.
        SELECT UNNEST(previous_tags)
        EXCEPT
        SELECT UNNEST(new_tags)
        ) AS removed_tags
FROM toy_production
), 
tag_lengths AS 
(
SELECT
	toy_id,
    toy_name,
    added_tags,
    unchanged_tags,
    removed_tags,
	-- Count the number of elements in each array.
    CARDINALITY(added_tags) AS length_added_tags,
    CARDINALITY(unchanged_tags) AS length_unchanged_tags,
    CARDINALITY(removed_tags) AS length_removed_tags
FROM tag_changes
)
-- Find the Toy with the Most Added Tags.
SELECT
    toy_id,
    length_added_tags,
    length_unchanged_tags,
    length_removed_tags
FROM tag_lengths
ORDER BY length_added_tags DESC
LIMIT 1
;
