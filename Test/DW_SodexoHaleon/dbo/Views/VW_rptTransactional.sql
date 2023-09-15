

CREATE VIEW [dbo].[VW_rptTransactional]
AS
SELECT O.EncryptedOrderId AS OrderNumber
	,O.OrderDateTime AS JobSubmissionDateTime
	,U.OrderUser AS ClientName
	,U.Department AS ClientDepartment
	,U.HaleonLocation AS ClientLocation
	--,Client Cost Centre --Removed as per User Story 30677
	,O.VATCharges AS VATcost
	,O.CardFees AS CardCharges
	,O.BillAmount AS TotalJobCost
	,SD.PaymentMethod AS PaymentMethod
	,IIF(SD.PaymentMethod = 'Purchase Order', SD.PONumber, SD.Xtransid) AS PaymentRef
	,SD.BillingEntity AS BusinessEntity
	,CONCAT (
		SD.Company
		,' ' + SD.Address1
		,' ' + SD.Address2
		,' ' + SD.City
		,' ' + SD.SCountry
		,' ' + SD.Zip
		) AS DeliveryAddress
	,OP.OrderProductID AS LineID
	,OPPD.JobName AS LineJobName
	,P.FirstLevelCategory AS TopLevelCatalogueCategory
	,P.SecondLevelCategory AS SubCategoryCatalogueCategory
	,OP.TotalQuantity AS Qty
	,OP.TotalPrice AS Linecost
	,SD.CompletedDate AS Deliverydate
FROM Fact.OrderProduct OP
LEFT JOIN Fact.Orders O ON OP.OrderID = O.OrderID
LEFT JOIN Dimension.UserDetails U ON U.UstoreUserID = O.UserID
LEFT JOIN Dimension.Product P ON P.ProductID = OP.ProductID
LEFT JOIN Fact.ShippingDetails SD ON SD.OrderProductID = OP.OrderProductID
LEFT JOIN Fact.OrderProductPropertyDetailsPivot OPPD ON OPPD.OrderProductID = OP.OrderProductID
