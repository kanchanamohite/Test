CREATE PROCEDURE [dbo].[usp_LoadOrderProduct]
AS
BEGIN
	TRUNCATE TABLE [Fact].[OrderProduct]

	INSERT INTO [Fact].[OrderProduct]
	SELECT OP.OrderProductID
		,OP.OrderID
		,OP.ProductID
		,OP.TotalQuantity
		,OP.QuantityPerRecipient
		,ISNULL(OP.TotalPrice, 0) AS TotalPrice
	FROM LZ_uStore.dbo.OrderProduct OP
	JOIN [Fact].[Orders] O ON O.OrderID = OP.OrderID
	WHERE OP.IsDeleted = 0
		AND OP.IsDraft = 0
		AND OP.IsSavedDraft = 0
		AND OP.StatusID = O.StatusID
END
