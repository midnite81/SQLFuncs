DELIMITER //

CREATE PROCEDURE `__search`(IN `_db` VARCHAR(50), IN `_searchTerm` VARCHAR(50))
	LANGUAGE SQL
	NOT DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY INVOKER
	COMMENT ''
BEGIN

CREATE TEMPORARY TABLE IF NOT EXISTS `search` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`db` varchar(255) NOT NULL,
`table` varchar(255) NOT NULL,
`whereClause` varchar(9999) NOT NULL,
PRIMARY KEY(id)
);

CREATE TEMPORARY TABLE IF NOT EXISTS `results` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`table` varchar(255) NOT NULL,
`count` int NOT NULL,
`query` varchar(2000), 
PRIMARY KEY(id)
);

INSERT INTO search (`db`, `table`, whereClause)
SELECT _db, table_name, 
GROUP_CONCAT(concat('`',column_name,'` LIKE \'',_searchTerm,'\'') SEPARATOR ' or ')
FROM information_schema.columns
WHERE data_type in ('char', 'varchar', 'longtext', 'mediumtext', 'text', 'tinytext', 'set', 'int', 'float', 'decimal')
and table_schema = _db
GROUP BY table_name;

SELECT count(id) INTO @totalRows FROM search;
SET @currentRow = 1; 

label1: LOOP

IF @currentRow <= @totalRows THEN

	SELECT `table`, `whereClause` INTO @table, @whereClause 
	FROM search 
	WHERE id = @currentRow;
	
	SET @query = 'INSERT INTO results (`table`, `count`) '; 
	SET @query = concat(@query, ' SELECT \'', @table,  '\', count(*) FROM ', concat(@db,'.',@table), ' WHERE ', @whereClause);
	SET @getQuery = concat('SELECT * FROM ', concat(@db,'.',@table), ' WHERE ', @whereClause);
	
	PREPARE resultsQuery FROM @query;
	EXECUTE resultsQuery;
	
	UPDATE results SET `query` = @getQuery WHERE id = @currentRow;
	
		
   SET @currentRow = @currentRow + 1;
	ITERATE label1;  
	
END IF; 
LEAVE label1;
END LOOP label1;

SELECT * FROM results;


DROP TEMPORARY TABLE results;
DROP TEMPORARY TABLE search;
END //

DELIMITER ;