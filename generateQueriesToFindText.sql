-- +------------------------------------------------------
-- + Generates a list of queries to run to find a specified search term
-- + Author: Simon Rogers
-- + Date: 7th January 2016
-- + SQL: mysql
-- +------------------------------------------------------

SET @searchTerm = '%<searchTerm>%';

CREATE TEMPORARY TABLE search (
id int(11) NOT NULL AUTO_INCREMENT,
search varchar(1020) NOT NULL,
PRIMARY KEY(id)
);

INSERT INTO search (search)
SELECT concat('SELECT * FROM ', table_name, ' WHERE `', column_name,  '` like \'%',@searchTerm,'%\';') as `SearchTerm`
FROM information_schema.columns
WHERE data_type in ('char', 'varchar', 'longtext', 'mediumtext', 'text', 'tinytext', 'set')
and table_schema != 'information_schema';

SELECT search FROM search;

DROP TEMPORARY TABLE search;
