CREATE TABLE [Fact].[ShippingDetails] (
    [OrderID]        INT            NULL,
    [OrderProductID] INT            NOT NULL,
    [CostCentre]     VARCHAR (50)   NULL,
    [AddressID]      INT            NULL,
    [AddressType]    VARCHAR (10)   NULL,
    [CompletedDate]  DATETIME       NULL,
    [PaymentMethod]  VARCHAR (30)   NULL,
    [PONumber]       VARCHAR (50)   NULL,
    [BillingEntity]  VARCHAR (100)  NULL,
    [BillName]       VARCHAR (MAX)  NULL,
    [Address1]       NVARCHAR (100) NULL,
    [Address2]       NVARCHAR (100) NULL,
    [City]           NVARCHAR (50)  NULL,
    [State]          INT            NULL,
    [Zip]            NVARCHAR (50)  NULL,
    [SCountry]       NVARCHAR (50)  NULL,
    [UCountry]       INT            NULL,
    [Company]        VARCHAR (100)  NULL,
    [Xtransid]       VARCHAR (100)  NULL,
    CONSTRAINT [PK_ShippingDetails] PRIMARY KEY CLUSTERED ([OrderProductID] ASC)
);

