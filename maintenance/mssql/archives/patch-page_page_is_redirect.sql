DECLARE @sql nvarchar(max),
	@id sysname;--

SET @sql = 'ALTER TABLE /*_*/page DROP CONSTRAINT ';--

SELECT @id = df.name
FROM sys.default_constraints df
JOIN sys.columns c
	ON c.object_id = df.parent_object_id
	AND c.column_id = df.parent_column_id
WHERE
	df.parent_object_id = OBJECT_ID('/*_*/page')
	AND c.name = 'page_is_redirect';--

SET @sql = @sql + @id;--

-- Drop default constraint
EXEC sp_executesql @sql;--

-- Drop index
DROP INDEX /*_*/page.page_redirect_namespace_len;--

-- Change datatype of the page_is_redirect column
ALTER TABLE /*_*/page
ALTER COLUMN page_is_redirect TINYINT NOT NULL;--

-- Add default constraint again
ALTER TABLE /*_*/page
ADD DEFAULT ((0)) FOR page_is_redirect;--

-- Add index again
CREATE INDEX /*i*/page_redirect_namespace_len ON /*_*/page (page_is_redirect, page_namespace, page_len);
