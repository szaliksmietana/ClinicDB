SELECT
    TABLE_NAME AS TableName,
    INDEX_NAME AS IndexName,
    NON_UNIQUE = 0 AS IsUnique,
    SEQ_IN_INDEX AS ColumnPosition,
    COLUMN_NAME AS ColumnName,
    INDEX_TYPE AS IndexType
FROM
    information_schema.STATISTICS
WHERE
    TABLE_SCHEMA = DATABASE() -- bieżąca baza danych
ORDER BY
    TABLE_NAME,
    INDEX_NAME,
    SEQ_IN_INDEX;
