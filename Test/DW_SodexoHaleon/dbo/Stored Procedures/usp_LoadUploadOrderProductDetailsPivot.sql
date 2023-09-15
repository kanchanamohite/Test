
CREATE PROCEDURE [dbo].[usp_LoadUploadOrderProductDetailsPivot]
AS
BEGIN
	TRUNCATE TABLE [Fact].[UploadOrderProductDetailsPivot];

	WITH CTE
	AS (
		SELECT OP.OrderProductID
			,UOPP.PrintClicksColour
			,UOPP.PrintClicksMono
			,UOPP.PrintCostColour
			,UOPP.PrintCostMono
			,CASE 
				WHEN UPRD.PropertyName = 'Double Sided Printing'
					THEN IIF(UPRD.OptionValue = 'True', 'Duplex', 'Simplex')
				WHEN UPRD.PropertyName LIKE '%Paper Options%'
					AND UPRD.UnitCost > 0.000000
					THEN 'Paper Options'
				ELSE UPRD.PropertyName
				END AS PropertyName
			,CASE UPRD.PropertyName
				WHEN 'Double Sided Printing'
					THEN CAST(IIF(UPRD.OptionValue = 'True', [dbo].[fn_GetPageCount](UPRD.UploadedPageNo, 'Duplex'), [dbo].[fn_GetPageCount](UPRD.UploadedPageNo, 'Simplex')) AS NVARCHAR(100))
				ELSE UPRD.OptionValue
				END AS OptionValue
			,UOPP.ConsumablesCost
		FROM [Fact].[OrderProduct] OP
		LEFT JOIN LZ_SodexoHaleon.dbo.UploadOrderProductPrice UOPP ON UOPP.OrderProductID = OP.OrderProductID
			AND UOPP.IsDeleted = 0
		LEFT JOIN LZ_SodexoHaleon.dbo.UploadPropertyReportDetails UPRD ON UPRD.OrderProductID = OP.OrderProductID
			AND PropertyName IN (
				'Paper Options'
				,'Double Sided Printing'
				,'Binding Type'
				,'Paper Options B&W'
				,'Paper Options Colour'
				)
			AND UPRD.IsDeleted = 0
		)
	INSERT INTO [Fact].[UploadOrderProductDetailsPivot]
	SELECT OrderProductID
		,PrintClicksColour
		,PrintClicksMono
		,PrintCostColour
		,PrintCostMono
		,Simplex
		,Duplex
		,[Paper Options] AS PaperOptions
		,[Binding Type] AS BindingType
		,ConsumablesCost
	FROM CTE S
	PIVOT(MAX(OptionValue) FOR PropertyName IN (
				[Simplex]
				,[Duplex]
				,[Paper Options]
				,[Binding Type]
				)) P
END
