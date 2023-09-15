CREATE PROCEDURE [dbo].[usp_LoadOrderProductPropertyDetailsPivot]
AS
BEGIN
	TRUNCATE TABLE [Fact].[OrderProductPropertyDetailsPivot];

	WITH CTE
	AS (
		SELECT OP.OrderProductID
			,P.PropertyName
			,OPPV.PropertyValue
		FROM [Fact].[OrderProduct] OP
		JOIN LZ_SodexoHaleon.dbo.OrderProductPropertyValue OPPV ON OPPV.OrderProductID = OP.OrderProductID
			AND OPPV.IsDeleted = 0
		JOIN LZ_SodexoHaleon.dbo.Property P ON P.PropertyID = OPPV.PropertyID
			AND P.IsDeleted = 0
		WHERE P.PropertyName IN ('JobName')
		)
	INSERT INTO [Fact].[OrderProductPropertyDetailsPivot]
	SELECT OrderProductID
		,JobName
	FROM CTE S
	pivot(MAX(PropertyValue) FOR PropertyName IN ([JobName])) P
END
