WITH combined_tables AS 
(
-- Combine Binky's and Blinky's data
SELECT 
	id,
	value
FROM letters_a
UNION ALL
SELECT 
	id,
	value
FROM letters_b
), valid_letters AS 
(
-- Filter valid ASCII values (32 for space, 33-126 for printable characters)
SELECT 
	id,
	value
FROM combined_tables
WHERE value BETWEEN 32 AND 126 
	AND (value BETWEEN 65 AND 90  -- For Uppercase letters
		OR value BETWEEN 97 AND 122  -- For Lowercase letters
		OR value IN (32, 33, 34, 39, 40, 41, 44, 45, 46, 58, 59, 63))  -- For Valid special chars
), decoded_letters AS
(
-- Decode ASCII values into characters
SELECT 
	id,
	CHR(value) AS selected_character
FROM valid_letters
)
-- Combine and order the decoded characters into a message
SELECT 
	STRING_AGG(selected_character, '' ORDER BY id) AS decoded_message
FROM decoded_letters
;

-- Binky's Table
-- SELECT *
-- FROM letters_a
-- ;

-- Blinky's Table
-- SELECT *
-- FROM letters_b
-- ;
