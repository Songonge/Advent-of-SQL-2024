-- Extract relevant information from the XML data.
WITH parsed_data AS (
  SELECT
    id,
    (xpath('//total_count/text()', menu_data))[1]::text::int AS guest_count_v1,
    (xpath('//total_guests/text()', menu_data))[1]::text::int AS guest_count_v2,
    unnest(xpath('//food_item_id/text()', menu_data))::text::int AS food_item_id
  FROM christmas_menus
),
filtered_data AS (
-- Filter the parsed data to include only events with more than 78 guests.
  SELECT 
  	food_item_id
  FROM parsed_data
  WHERE COALESCE(guest_count_v1, guest_count_v2) > 78
)
-- Counts the occurrences of each food_item_id and selects the one with the highest count.
SELECT 
	food_item_id
FROM filtered_data
GROUP BY food_item_id
ORDER BY COUNT(*) DESC
LIMIT 1
;
