
CREATE PROCEDURE [dbo].[usp_LoadShippingDetails]
AS
BEGIN
	TRUNCATE TABLE [Fact].[ShippingDetails]

	INSERT INTO [Fact].[ShippingDetails]
	SELECT OP.OrderID
		,OP.OrderProductID
		,OD.CostCentre
		,OD.AddressID
		,OD.AddressType
		,TD.CompletedDate
		,OD.PaymentMethod
		,OD.PONumber
		,OD.BillingEntity
		,OD.BillName
		,NULLIF(IIF(OD.[AddressType] = 'ULD', A.[Address1], SA.[Address1]), '') AS Address1
		,NULLIF(IIF(OD.[AddressType] = 'ULD', A.[Address2], SA.[Address2]), '') AS Address2
		,NULLIF(IIF(OD.[AddressType] = 'ULD', A.[City], SA.[City]), '') AS City
		,NULLIF(A.[State], '') AS [STATE]
		,NULLIF(IIF(OD.[AddressType] = 'ULD', A.[Zip], SA.[Zip]), '') AS [Zip]
		,NULLIF(SA.[Country], '') AS [SCountry]
		,NULLIF(A.[Country], '') AS [UCountry]
		,NULLIF(IIF(OD.[AddressType] = 'ULD', A.[Company], SA.[Company]), '') AS [Company]
		,FR.Value AS Xtransid
	FROM [Fact].[OrderProduct] OP
	LEFT JOIN [Fact].Orders O ON O.OrderID = OP.OrderID
	LEFT JOIN LZ_SodexoHaleon.dbo.OrderDelivery OD ON OD.OrderID = OP.OrderID
		AND OD.IsDeleted = 0
	LEFT JOIN LZ_SodexoHaleon.dbo.TrackingDetails TD ON TD.uStoreOrderProductID = OP.OrderProductID
		AND TD.IsDeleted = 0
	LEFT JOIN LZ_uStore.dbo.[Address] A ON A.AddressID = OD.AddressID
		AND A.IsDeleted = 0
	LEFT JOIN LZ_SodexoHaleon.dbo.[Address] SA ON SA.AddressID = OD.AddressID
		AND SA.IsDeleted = 0
	LEFT JOIN LZ_SodexoHaleon.dbo.FirstDataReturn FR ON FR.OrderID = OD.OrderID
		AND FR.[Key] = 'x_trans_id'
END
