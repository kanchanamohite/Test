CREATE TABLE [Fact].[Orders] (
    [OrderID]              INT             NOT NULL,
    [EncryptedOrderId]     INT             NULL,
    [OrderDateTime]        DATETIME        NULL,
    [UserID]               INT             NULL,
    [StatusID]             INT             NULL,
    [BillAmount]           NUMERIC (19, 5) NULL,
    [VATPercentage]        DECIMAL (18, 5) NULL,
    [AMEXPercentage]       DECIMAL (18, 5) NULL,
    [PDRValue]             DECIMAL (18, 5) NULL,
    [VATCharges]           DECIMAL (18, 2) NULL,
    [CardFees]             DECIMAL (18, 2) NULL,
    [CardFeesExcludingVAT] DECIMAL (18, 2) NULL,
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([OrderID] ASC)
);

