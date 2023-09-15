
CREATE PROCEDURE [dbo].[usp_SSISExecuteSP]
AS
BEGIN
	BEGIN --Dimension tables
		EXEC [dbo].[usp_DimLoadUserDetails]

		EXEC [dbo].[usp_DimLoadProduct]

		EXEC [dbo].[usp_DimLoadProductGroup]
	END

	BEGIN --Fact Primary Tables
		EXEC [dbo].[usp_LoadOrders]

		EXEC [dbo].[usp_LoadOrderProduct]
	END

	BEGIN --Fact Secondary Tables
		EXEC [dbo].[usp_LoadShippingDetails]

		EXEC [dbo].[usp_LoadOrderProductPropertyDetailsPivot]

		EXEC [dbo].[usp_LoadUploadOrderProductDetailsPivot]
	END
END
