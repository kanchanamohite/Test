CREATE TABLE [Dimension].[DimStore] (
    [StoreID]            INT            NOT NULL,
    [CultureID]          INT            NULL,
    [StoreName]          NVARCHAR (100) NULL,
    [CultureDisplayName] NVARCHAR (50)  NULL,
    [NativeLanguageName] NVARCHAR (50)  NULL,
    [StatusID]           INT            NULL,
    [StatusName]         NVARCHAR (50)  NULL,
    [LiveDate]           DATETIME       NULL,
    CONSTRAINT [PK_DimStore] PRIMARY KEY CLUSTERED ([StoreID] ASC)
);

