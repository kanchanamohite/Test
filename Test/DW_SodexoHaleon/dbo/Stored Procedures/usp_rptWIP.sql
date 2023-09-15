CREATE PROCEDURE [dbo].[usp_rptWIP]
AS
BEGIN
	SELECT OrderNumber
		,JobSubmissionDateTime
		,ClientName
		,ClientDepartment
		,ClientLocation
		,VATcost
		,CardCharges
		,TotalJobCost
		,PaymentMethod
		,PaymentRef
		,DeliveryAddress
		,LineID
		,LineJobName
		,TopLevelCatalogueCategory
		,SubCategoryCatalogueCategory
		,Qty
		,Linecost
	FROM [dbo].[VW_rptTransactional]
	WHERE Deliverydate IS NULL
	ORDER BY JobSubmissionDateTime DESC
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_rptWIP] TO [ReportUser]
    AS [dbo];

