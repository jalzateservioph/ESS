IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'RelativesLU')
BEGIN
    PRINT N'Creating [dbo].[RelativesLU]...';
    CREATE TABLE [dbo].[RelativesLU] ( [Relatives] NVARCHAR (20) NOT NULL );
END
GO