set @db = database();
set @table = '<table_name>';

SELECT concat_ws(' ', 'public', concat(ColumnType, NullableSign), ColumnName, '{ get; set; }') as `string`
FROM (
    SELECT replace(COLUMN_NAME, ' ', '_') ColumnName,
          ORDINAL_POSITION ColumnId,
          case DATA_TYPE
            when 'bigint' then 'long'
            when 'binary' then 'byte[]'
            when 'bit' then 'bool'
            when 'char' then
              case CHARACTER_MAXIMUM_LENGTH when 36 then 'Guid' else 'string' end
            when 'date' then 'DateTime'
            when 'datetime' then 'DateTime'
            when 'datetime2' then 'DateTime'
            when 'datetimeoffset' then 'DateTimeOffset'
            when 'decimal' then 'decimal'
            when 'float' then 'double'
            when 'image' then 'byte[]'
            when 'int' then 'int'
            when 'money' then 'decimal'
            when 'mediumtext' then 'string'
            when 'nchar' then 'string'
            when 'ntext' then 'string'
            when 'numeric' then 'decimal'
            when 'nvarchar' then 'string'
            when 'real' then 'float'
            when 'smalldatetime' then 'DateTime'
            when 'smallint' then 'short'
            when 'smallmoney' then 'decimal'
            when 'text' then 'string'
            when 'time' then 'TimeSpan'
            when 'timestamp' then 'long'
            when 'tinyint' then 'byte'
            when 'uniqueidentifier' then 'Guid'
            when 'varbinary' then 'byte[]'
            when 'varchar' then 'string'
            else concat('UNKNOWN_', DATA_TYPE)
            end ColumnType,
          case
            when IS_NULLABLE = 'YES' and DATA_TYPE in ('bigint', 'bit', 'date', 'datetime', 'datetime2', 'datetimeoffset',
                                                    'decimal', 'float', 'int', 'money', 'numeric', 'real', 'smalldatetime',
                                                    'smallint', 'smallmoney', 'time', 'tinyint', 'uniqueidentifier')
              then '?'
            else ''
            end NullableSign
    FROM information_schema.columns c
    WHERE table_schema = @db and table_name = @table
    ORDER BY ORDINAL_POSITION
) as derived;
