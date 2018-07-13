DECLARE @base nvarchar(max),
	@SQL nvarchar(max),
	@id sysname;--

SET @base = 'ALTER TABLE /*_*/recentchanges DROP CONSTRAINT ';--

SELECT @id = fk.name
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc
	ON fkc.constraint_object_id = fk.object_id
JOIN sys.columns c
	ON c.column_id = fkc.parent_column_id
	AND c.object_id = fkc.parent_object_id
WHERE
	fk.parent_object_id = OBJECT_ID('/*_*/recentchanges')
	AND fk.referenced_object_id = OBJECT_ID('/*_*/page')
	AND c.name = 'rc_cur_id';--

SET @SQL = @base + @id;--

EXEC sp_executesql @SQL;--

SELECT @id = fk.name
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc
	ON fkc.constraint_object_id = fk.object_id
JOIN sys.columns c
	ON c.column_id = fkc.parent_column_id
	AND c.object_id = fkc.parent_object_id
WHERE
	fk.parent_object_id = OBJECT_ID('/*_*/recentchanges')
	AND fk.referenced_object_id = OBJECT_ID('/*_*/revision')
	AND c.name = 'rc_this_oldid';--

SET @SQL = @base + @id;--

EXEC sp_executesql @SQL;--

SELECT @id = fk.name
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc
	ON fkc.constraint_object_id = fk.object_id
JOIN sys.columns c
	ON c.column_id = fkc.parent_column_id
	AND c.object_id = fkc.parent_object_id
WHERE
	fk.parent_object_id = OBJECT_ID('/*_*/recentchanges')
	AND fk.referenced_object_id = OBJECT_ID('/*_*/revision')
	AND c.name = 'rc_last_oldid';--

SET @SQL = @base + @id;--

EXEC sp_executesql @SQL;--

SELECT @id = fk.name
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc
	ON fkc.constraint_object_id = fk.object_id
JOIN sys.columns c
	ON c.column_id = fkc.parent_column_id
	AND c.object_id = fkc.parent_object_id
WHERE
	fk.parent_object_id = OBJECT_ID('/*_*/recentchanges')
	AND fk.referenced_object_id = OBJECT_ID('/*_*/mwuser')
	AND c.name = 'rc_user';--

SET @SQL = @base + @id;--

EXEC sp_executesql @SQL;--

ALTER TABLE /*_*/recentchanges ADD CONSTRAINT rc_user__user_id__fk FOREIGN KEY (rc_user) REFERENCES /*_*/mwuser(user_id);
