
CREATE PROCEDURE [dbo].[usp_rptTransactional] (
	@StartDate DATETIME
	,@EndDate DATETIME
	)
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
		,BusinessEntity
		,DeliveryAddress
		,LineID
		,LineJobName
		,TopLevelCatalogueCategory
		,SubCategoryCatalogueCategory
		,Qty
		,Linecost
		,Deliverydate
	FROM [dbo].[VW_rptTransactional]
	WHERE Deliverydate IS NOT NULL
		AND Deliverydate >= @StartDate
		AND Deliverydate < @EndDate
	ORDER BY JobSubmissionDateTime
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_rptTransactional] TO [ReportUser]
    AS [dbo];

