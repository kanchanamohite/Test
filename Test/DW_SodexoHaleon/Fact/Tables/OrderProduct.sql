CREATE TABLE [Fact].[OrderProduct] (
    [OrderProductID]       INT             NOT NULL,
    [OrderID]              INT             NULL,
    [ProductID]            INT             NULL,
    [TotalQuantity]        INT             NULL,
    [QuantityPerRecipient] INT             NULL,
    [TotalPrice]           NUMERIC (19, 5) NOT NULL,
    CONSTRAINT [PK_OrderProduct] PRIMARY KEY CLUSTERED ([OrderProductID] ASC)
);

