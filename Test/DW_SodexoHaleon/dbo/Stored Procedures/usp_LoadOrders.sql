
CREATE PROCEDURE [dbo].[usp_LoadOrders]
AS
BEGIN
	TRUNCATE TABLE [Fact].[Orders]

	INSERT INTO [Fact].[Orders]
	SELECT O.OrderID
		,O.EncryptedOrderId
		,FORMAT(O.DateOrderSubmitted, 'yyyy-MM-dd HH:mm:ss') AS OrderDateTime
		,O.UserID
		,O.StatusID
		,O.BillAmount
		,(
			SELECT VAT
			FROM LZ_SodexoHaleon.dbo.VATConfig
			) / 100 AS VATPercentage
		,(
			SELECT AMEXPercentage
			FROM LZ_SodexoHaleon.dbo.AMEXConfig
			) AS AMEXPercentage
		,(
			SELECT PDRValue
			FROM LZ_SodexoHaleon.dbo.PDRConfig
			) AS PDRValue
		,PD.VATCharges
		,PD.CardFees
		,PD.CardFeesExcludingVAT
	FROM LZ_uStore.dbo.Orders O
	LEFT JOIN LZ_SodexoHaleon.dbo.PaymentDetails PD ON PD.OrderID = O.OrderID
	JOIN Dimension.DimStore DS ON DS.StoreID = O.StoreID
	WHERE O.IsDeleted = 0
		AND O.StatusID = DS.StatusID
		AND O.DisplayOrderDate > DS.LiveDate
		AND O.IsSaveForLater = 0
		AND (
			O.iscart != 1
			OR (
				O.iscart = 1
				AND O.Approvalstatusid = 0
				AND O.dateordersubmitted IS NOT NULL
				)
			) --approval pending orders
END
