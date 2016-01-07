-- +------------------------------------------------------
-- + Get a CSV of columns in a table
-- + Author: Simon Rogers
-- + Date: 7th January 2016
-- + SQL: mysql
-- +------------------------------------------------------

SET @@group_concat_max_len = 1000000;

SET @table_name = '<table_name>';

SELECT @table_name as `table`, trim(group_concat(concat(' \'',column_name,'\''))) as `columns`
FROM information_schema.columns
WHERE table_name = @table_name
and column_name NOT IN ('id', 'created_at', 'updated_at', 'deleted_at')
ORDER BY table_name,ordinal_position;
