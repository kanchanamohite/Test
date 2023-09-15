
CREATE PROCEDURE [dbo].[usp_rptMI]
AS
BEGIN
	SELECT OrderUser
		,OrderDateTime
		,[Order]
		,Department
		,ProductName
		,StockType
		,Quantity
		,PrintCostmono
		,PrintCostcolour
		,PrintClicksmono
		,PrintClickscolour
		,PrintcountSimplex
		,PrintCountDuplex
		,ConsumablesCost
		,TotalCost
		,DeliveredDateTime
		,DeliveryAddress
	FROM [dbo].[VW_rptMI]
	ORDER BY OrderDateTime
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_rptMI] TO [ReportUser]
    AS [dbo];

