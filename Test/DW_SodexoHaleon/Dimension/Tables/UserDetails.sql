CREATE TABLE [Dimension].[UserDetails] (
    [UstoreUserID]   INT           NOT NULL,
    [FirstName]      VARCHAR (100) NULL,
    [LastName]       VARCHAR (100) NULL,
    [OrderUser]      VARCHAR (201) NOT NULL,
    [Email]          VARCHAR (100) NOT NULL,
    [Department]     VARCHAR (100) NOT NULL,
    [HaleonLocation] VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_UserDetails] PRIMARY KEY CLUSTERED ([UstoreUserID] ASC)
);

