IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'ess.PolicyMapping')
BEGIN
    PRINT N'Creating [dbo].[ess.PolicyMapping]...';

    CREATE TABLE [ess.PolicyMapping]
    (	PolicyID	BIGINT
    ,ModuleName	VARCHAR(100)
    ,TabName		VARCHAR(100)
    ,ItemName	VARCHAR(100)
    ,TableName	VARCHAR(100)
    ,FieldName	VARCHAR(100)
    )
END
GO