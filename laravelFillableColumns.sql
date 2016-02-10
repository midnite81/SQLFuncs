-- +------------------------------------------------------
-- + Retrieve column names to add to the fillable array in Laravel
-- + Author: Simon Rogers
-- + Date: 10th February 2016
-- + SQL: mysql
-- +------------------------------------------------------

-- +------------------------------------------------------
-- + Set the database you want to use
-- +------------------------------------------------------

SET @db = 'myDb'; 

-- +------------------------------------------------------
-- + Increase the group_concat max length so you don't 
-- + get column names cut off mid way through
-- +------------------------------------------------------
SET SESSION group_concat_max_len = 1000000;

-- +------------------------------------------------------
-- + Retrieve the Column Names for Fillable
-- + NB: have removed id, created_at, updated_at and 
-- + deleted_at as by default these would not be fillable
-- +------------------------------------------------------

SELECT table_name, group_concat(column_name ORDER BY `ORDINAL_POSITION` SEPARATOR ', ') as `Columns` 
FROM information_schema.columns 
WHERE table_schema = @db and column_name NOT IN ('id', 'created_at', 'updated_at', 'deleted_at')
GROUP BY table_name;
