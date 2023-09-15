
CREATE VIEW [dbo].[VW_rptMI]
AS
SELECT U.OrderUser AS OrderUser
	,O.OrderDateTime AS OrderDateTime
	,O.EncryptedOrderId AS [Order]
	,U.Department AS Department
	--,Client Cost Centre --Removed as per User Story 30677
	,P.ProductName AS ProductName
	,UOPD.PaperOptions + ', ' + UOPD.BindingType + ', ' + P.PageDimension AS StockType
	,OP.TotalQuantity AS Quantity
	,UOPD.PrintCostMono AS PrintCostmono
	,UOPD.PrintCostColour AS PrintCostcolour
	,UOPD.PrintClicksMono AS PrintClicksmono
	,UOPD.PrintClicksColour AS PrintClickscolour
	,ISNULL(UOPD.Simplex, 0) AS PrintcountSimplex
	,ISNULL(UOPD.Duplex, 0) AS PrintCountDuplex
	,UOPD.ConsumablesCost AS ConsumablesCost
	,OP.TotalPrice AS TotalCost
	--,Requested Delivery Date Time --Blank Column
	,SD.CompletedDate AS DeliveredDateTime
	,IIF(SD.AddressType = 'ULD', CONCAT (
			SD.Address1
			,' ' + SD.Address2
			,' ' + SD.City
			,' ' + SD.STATE
			,' ' + SD.Zip
			), CONCAT (
			SD.Address1
			,' ' + SD.Address2
			,' ' + SD.City
			,' ' + SD.Zip + ' '
			,SD.UCountry
			)) AS DeliveryAddress
FROM Fact.Orders O
LEFT JOIN Fact.OrderProduct OP ON OP.OrderID = O.OrderID
LEFT JOIN Dimension.UserDetails U ON U.UstoreUserID = O.UserID
LEFT JOIN Dimension.Product P ON P.ProductID = OP.ProductID
LEFT JOIN Fact.ShippingDetails SD ON SD.OrderProductID = OP.OrderProductID
LEFT JOIN Fact.UploadOrderProductDetailsPivot UOPD ON UOPD.OrderProductID = OP.OrderProductID
