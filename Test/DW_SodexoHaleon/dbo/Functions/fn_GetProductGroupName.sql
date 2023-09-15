CREATE FUNCTION [dbo].[fn_GetProductGroupName] (
	@ProductID INT
	,@GL INT
	,@CultureID INT
	)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @ProductGroupID INT
		,@ParentGroupID INT
		,@GroupLevel INT
		,@GroupName VARCHAR(100)
		,@ProductGroupRET VARCHAR(100)
	DECLARE @ProductGroup TABLE (
		GroupLevel INT
		,ParentGroupId INT
		,GroupName VARCHAR(100)
		)

	SELECT TOP 1 @ProductGroupID = ProductGroupID
	FROM LZ_uStore.dbo.ProductGroupMembership
	WHERE ProductID = @ProductID
		AND IsDeleted = 0

	SET @ParentGroupID = @ProductGroupID

	SELECT TOP 1 @GroupLevel = GroupLevel
		,@GroupName = GroupName
	FROM [Dimension].[ProductGroup]
	WHERE ProductGroupID = @ProductGroupID
		AND CultureID = @CultureID

	INSERT INTO @ProductGroup (
		GroupLevel
		,ParentGroupId
		,GroupName
		)
	VALUES (
		@GroupLevel
		,@ParentGroupID
		,@GroupName
		)

	WHILE @GroupLevel > 1
	BEGIN
		SET @GroupLevel = @GroupLevel - 1

		SELECT TOP 1 @ParentGroupID = ParentGroupID
		FROM [Dimension].[ProductGroup]
		WHERE ProductGroupID = @ParentGroupID
			AND CultureID = @CultureID

		SELECT TOP 1 @GroupName = GroupName
		FROM [Dimension].[ProductGroup]
		WHERE ProductGroupID = @ParentGroupID
			AND CultureID = @CultureID

		INSERT INTO @ProductGroup (
			GroupLevel
			,ParentGroupId
			,GroupName
			)
		VALUES (
			@GroupLevel
			,@ParentGroupID
			,@GroupName
			)
	END

	SELECT TOP 1 @ProductGroupRET = GroupName
	FROM @ProductGroup
	WHERE GroupLevel = @GL

	RETURN @ProductGroupRET
END
