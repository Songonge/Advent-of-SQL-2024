WITH extracted_domains AS (
    SELECT
        UNNEST(email_addresses) AS email
    FROM contact_list
),
domain_list AS (
    SELECT
        SPLIT_PART(email, '@', 2) AS domain,
        COUNT(*) AS total_users,
        ARRAY_AGG(email) AS users
    FROM extracted_domains
    GROUP BY domain
)
SELECT 
    domain AS "Domain",
    total_users AS "Total Users",
    users AS "Users"
FROM domain_list
ORDER BY total_users DESC, domain ASC
;
