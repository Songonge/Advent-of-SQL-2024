SELECT
    date,
    SUM(CASE WHEN drink_name = 'Eggnog' THEN quantity ELSE 0 END) AS eggnog,
    SUM(CASE WHEN drink_name = 'Hot Cocoa' THEN quantity ELSE 0 END) AS hot_cocoa,
    SUM(CASE WHEN drink_name = 'Peppermint Schnapps' THEN quantity ELSE 0 END) AS peppermint_schnapps
FROM Drinks
GROUP BY date
HAVING
    SUM(CASE WHEN drink_name = 'Hot Cocoa' THEN quantity ELSE 0 END) = 38
    AND SUM(CASE WHEN drink_name = 'Peppermint Schnapps' THEN quantity ELSE 0 END) = 298
    AND SUM(CASE WHEN drink_name = 'Eggnog' THEN quantity ELSE 0 END) = 198
ORDER BY date;