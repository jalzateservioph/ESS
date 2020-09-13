IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'BloodTypeLU')
BEGIN
    PRINT N'Creating [dbo].[BloodTypeLU]...';

    CREATE TABLE [dbo].[BloodTypeLU] (
        [BloodType] NVARCHAR (10) NULL
    );
END

GO