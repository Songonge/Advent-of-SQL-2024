WITH parsed_urls AS (
  SELECT
    url,
    (regexp_match(url, '\\?(.*)$'))[1] AS query_string,
    regexp_split_to_array((regexp_match(url, '\\?(.*)$'))[1], '&') AS param_array
  FROM web_requests
),
parsed_params AS (
  SELECT
    url,
    query_string,
    param_array,
    json_object_agg(
      split_part(param, '=', 1),
      split_part(param, '=', 2)
    ) AS query_parameters,
    array_length(param_array, 1) AS count_params
  FROM parsed_urls,
       unnest(param_array) AS param
  GROUP BY url, query_string, param_array
)
SELECT 
	url,
	query_parameters,
	count_params
FROM parsed_params
WHERE LOWER(URL) LIKE '%utm_source=advent-of-sql%' --query_parameters->>'utm_source' = 'advent-of-sql'
ORDER BY url ASC, count_params DESC 
LIMIT 10
;
