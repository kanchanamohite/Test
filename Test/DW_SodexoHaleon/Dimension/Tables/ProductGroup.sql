CREATE TABLE [Dimension].[ProductGroup] (
    [GroupLevel]     INT            NOT NULL,
    [ProductGroupID] INT            NOT NULL,
    [ParentGroupID]  INT            NULL,
    [CultureID]      INT            NULL,
    [GroupName]      NVARCHAR (100) NULL,
    CONSTRAINT [PK_ProductGroup] PRIMARY KEY CLUSTERED ([ProductGroupID] ASC)
);

