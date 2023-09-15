
CREATE FUNCTION [dbo].[fn_GetPageCount] (
	@UploadPageNo VARCHAR(1000)
	,@Value VARCHAR(50)
	)
RETURNS INT
AS
BEGIN
	DECLARE @MyTableVar TABLE (
		Id INT IDENTITY(1, 1)
		,[Value] VARCHAR(15)
		)

	INSERT @MyTableVar
	SELECT *
	FROM STRING_SPLIT(REPLACE(@UploadPageNo, '|', '-'), '-')

	DECLARE @First INT
	DECLARE @Second INT
	DECLARE @RowCount INT
	DECLARE @I INT = 1
	DECLARE @PageCount FLOAT = 0.00

	SELECT @RowCount = COUNT([Value])
	FROM @MyTableVar

	WHILE (@I <= @RowCount)
	BEGIN
		DECLARE @iCount FLOAT

		SELECT @First = [Value]
		FROM @MyTableVar
		WHERE id = @I

		SELECT @Second = [Value]
		FROM @MyTableVar
		WHERE id = @I + 1

		IF @Value = 'Duplex'
			SET @iCount = (@Second - @First + 1) / 2.0
		ELSE IF @Value = 'Simplex'
			SET @iCount = (@Second - @First + 1)
		SET @PageCount = @PageCount + @iCount
		SET @I = @I + 2
	END

	RETURN CEILING(@PageCount)
END
