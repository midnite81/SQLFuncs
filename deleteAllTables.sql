-- +------------------------------------------------------
-- + Generates SQL to delete all tables from the current active database
-- + Author: Simon Rogers
-- + Created Date: 9th April 2017
-- + SQL: mysql
-- +------------------------------------------------------

SELECT 'SET FOREIGN_KEY_CHECKS = 0;' as `SQL`

UNION ALL 

SELECT concat('DROP TABLE `', TABLE_NAME, '`;') as `SQL` 
FROM information_schema.tables
WHERE TABLE_SCHEMA = database()

UNION ALL 

SELECT 'SET FOREIGN_KEY_CHECKS = 1;' as `SQL`;
