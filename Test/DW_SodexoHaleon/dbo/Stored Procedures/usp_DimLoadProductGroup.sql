CREATE PROCEDURE [dbo].[usp_DimLoadProductGroup]
AS
BEGIN
	TRUNCATE TABLE [Dimension].[ProductGroup]

	DECLARE @Table TABLE (
		ProductGroupID INT
		,ParentGroupID INT
		,CultureID INT
		,[Name] NVARCHAR(100)
		)

	INSERT INTO @Table
	SELECT DISTINCT PG.ProductGroupID
		,PG.ParentGroupID
		,PGC.CultureID
		,PGC.[Name]
	FROM [LZ_uStore].[dbo].[ProductGroup] PG
	LEFT JOIN [LZ_uStore].[dbo].[ProductGroup_Culture] PGC ON PGC.ProductGroupID = PG.ProductGroupID
		AND PGC.IsDeleted = 0
	JOIN [Dimension].[DimStore] DS ON DS.StoreID = PG.StoreID
		AND DS.CultureId = PGC.CultureID
	WHERE PG.IsDeleted = 0;

	WITH ProductGroupCTE
	AS (
		SELECT 1 AS GroupLevel
			,PG.ProductGroupID AS ProductGroupID
			,PG.ParentGroupID AS ParentGroupID
			,PG.CultureID AS CultureID
			,PG.Name AS GroupName
		FROM @Table PG
		WHERE ParentGroupID IS NULL
		
		UNION ALL
		
		SELECT CTE.GroupLevel + 1 AS GroupLevel
			,PG2.ProductGroupID AS ProductGroupID
			,PG2.ParentGroupID AS ParentGroupID
			,PG2.CultureID AS CultureID
			,PG2.Name AS GroupName
		FROM @Table PG2
		INNER JOIN ProductGroupCTE CTE ON PG2.ParentGroupID = CTE.ProductGroupID
			AND PG2.CultureID = CTE.CultureID
		WHERE PG2.ParentGroupID IS NOT NULL
		)
	INSERT INTO [Dimension].[ProductGroup]
	SELECT *
	FROM ProductGroupCTE
END
