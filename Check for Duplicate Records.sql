-- Sometimes, you might want to check that there aren't duplicate records, 
-- in the example below, we will be looking for duplicate email addresses 
-- in the customers table.

SELECT  DISTINCT c.customerId, c.email, d.duplicateCount
FROM    dbo.customers AS c
        INNER JOIN ( SELECT email, COUNT(*) AS duplicateCount
                     FROM   dbo.customers
                     GROUP BY email
                     HAVING COUNT(*) > 1
                   ) d ON c.email = d.email
                   

-- You can achieve the same result USING Common Table Expressions

WITH cte_duplicate (email, duplicateCount)
AS 
(
SELECT DISTINCT email, COUNT(*) AS duplicateCount
                     FROM   dbo.customers
                     GROUP BY email
                     HAVING COUNT(*) > 1
)
SELECT DISTINCT c.customerId, c.email, d.duplicateCount
FROM dbo.customers AS c
INNER JOIN cte_duplicate d ON (d.email = c.email)