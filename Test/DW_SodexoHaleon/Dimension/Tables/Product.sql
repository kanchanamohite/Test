CREATE TABLE [Dimension].[Product] (
    [ProductID]           INT            NOT NULL,
    [CatalogNo]           NVARCHAR (50)  NULL,
    [Category]            VARCHAR (25)   NULL,
    [PageDimension]       VARCHAR (200)  NULL,
    [ProductName]         NVARCHAR (200) NULL,
    [Status]              NVARCHAR (50)  NULL,
    [CreatedDate]         DATETIME       NULL,
    [ModifiedDate]        DATETIME       NULL,
    [FirstLevelCategory]  VARCHAR (100)  NULL,
    [SecondLevelCategory] VARCHAR (100)  NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED ([ProductID] ASC)
);

