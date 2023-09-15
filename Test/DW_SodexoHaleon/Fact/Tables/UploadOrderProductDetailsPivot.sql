CREATE TABLE [Fact].[UploadOrderProductDetailsPivot] (
    [OrderProductID]    INT             NOT NULL,
    [PrintClicksColour] SMALLINT        NULL,
    [PrintClicksMono]   SMALLINT        NULL,
    [PrintCostColour]   NUMERIC (12, 6) NULL,
    [PrintCostMono]     NUMERIC (12, 6) NULL,
    [Simplex]           NVARCHAR (500)  NULL,
    [Duplex]            NVARCHAR (500)  NULL,
    [PaperOptions]      NVARCHAR (500)  NULL,
    [BindingType]       NVARCHAR (500)  NULL,
    [ConsumablesCost]   NUMERIC (12, 6) NULL,
    CONSTRAINT [PK_UploadOrderProductDetails] PRIMARY KEY CLUSTERED ([OrderProductID] ASC)
);

