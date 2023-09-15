
CREATE PROCEDURE [dbo].[usp_DimLoadProduct]
AS
BEGIN
	TRUNCATE TABLE [Dimension].[Product]

	INSERT INTO [Dimension].[Product]
	SELECT P.ProductID
		,P.[CatalogNo]
		,D.Category
		,D.PageDimension
		,PC.[Name] AS ProductName
		,S.[Name] AS [Status]
		,P.CreatedDate
		,P.ModifiedDate
		,[dbo].[fn_GetProductGroupName](P.ProductID, 1, DS.CultureID) AS FirstLevelCategory
		,[dbo].[fn_GetProductGroupName](P.ProductID, 2, DS.CultureID) AS SecondLevelCategory
	FROM LZ_uStore.dbo.Product P
	JOIN [Dimension].[DimStore] DS ON DS.StoreID = P.StoreID
	JOIN LZ_SodexoHaleon.dbo.Doc D ON D.ProductID = P.ProductID
		AND D.IsDeleted = 0
	LEFT JOIN LZ_uStore.dbo.[Status] S ON S.StatusID = P.StatusID
		AND S.IsDeleted = 0
	LEFT JOIN LZ_uStore.dbo.Product_Culture PC ON PC.ProductID = P.ProductID
		AND PC.CultureID = DS.CultureID
		AND PC.ISDeleted = 0
	WHERE P.IsDeleted = 0
END
