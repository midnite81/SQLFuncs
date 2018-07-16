-- CASTING 
SELECT CAST(id as CHAR(50)) as cast_column 
FROM my_table;

-- CONVERTING
SELECT CONVERT(id, CHAR(50)) as cast_column 
FROM my_table;
