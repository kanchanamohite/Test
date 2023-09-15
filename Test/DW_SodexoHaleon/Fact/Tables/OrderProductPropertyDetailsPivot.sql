CREATE TABLE [Fact].[OrderProductPropertyDetailsPivot] (
    [OrderProductID] INT           NOT NULL,
    [JobName]        VARCHAR (MAX) NULL,
    CONSTRAINT [PK_OrderProductPropertyDetails] PRIMARY KEY CLUSTERED ([OrderProductID] ASC)
);

