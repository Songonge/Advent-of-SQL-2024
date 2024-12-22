SELECT 
    COUNT(skills) AS numofelveswithsql
FROM 
    elves
WHERE 
    ',' || skills || ',' LIKE '%,SQL,%'
;
