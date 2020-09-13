IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'DependantsForApproval')
BEGIN
    PRINT N'Creating [dbo].[DependantsForApproval]...';

    CREATE TABLE [dbo].[DependantsForApproval] (
        [CompanyNum]        NVARCHAR (20)  NOT NULL,
        [EmployeeNum]       NVARCHAR (20)  NOT NULL,
        [DependName]        NVARCHAR (100) NULL,
        [DepMidName]        NVARCHAR (100) NULL,
        [Surname]           NVARCHAR (100) NULL,
        [IDNum]             NVARCHAR (100) NULL,
        [DoB]               DATETIME       NULL,
        [Sex]               NVARCHAR (100) NULL,
        [ContactNumber]     NVARCHAR (100) NULL,
        [Nationality]       NVARCHAR (100) NULL,
        [DepCivilStat]      NVARCHAR (100) NULL,
        [OnMedicalAid]      TINYINT        NULL,
        [DepDeceased]       TINYINT        NULL,
        [MedicalAidStartDt] DATETIME       NULL,
        [MedicalAidEndDt]   DATETIME       NULL,
        [DepOccupation]     NVARCHAR (100) NULL,
        [DepEmployer]       NVARCHAR (100) NULL,
        [DepAddress]        NVARCHAR (100) NULL,
        [PathID]            BIGINT         NULL
    );


    

    PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';
    
    ALTER TABLE [dbo].[DependantsForApproval]
        ADD DEFAULT ('') FOR [DepAddress];
    

    PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';
    
    ALTER TABLE [dbo].[DependantsForApproval]
        ADD DEFAULT ((0)) FOR [OnMedicalAid];
    

    PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';
    
    ALTER TABLE [dbo].[DependantsForApproval]
        ADD DEFAULT ('') FOR [DepCivilStat];
    

    PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';
    
    ALTER TABLE [dbo].[DependantsForApproval]
        ADD DEFAULT ((0)) FOR [DepDeceased];
    

    PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';
    
    ALTER TABLE [dbo].[DependantsForApproval]
        ADD DEFAULT ('') FOR [DepOccupation];
    

    PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';
    
    ALTER TABLE [dbo].[DependantsForApproval]
        ADD DEFAULT ('') FOR [DepEmployer];
    

    PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';
    
    ALTER TABLE [dbo].[DependantsForApproval]
        ADD DEFAULT ('') FOR [DependName];
    

    PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';
    
    ALTER TABLE [dbo].[DependantsForApproval]
        ADD DEFAULT ('') FOR [DepMidName];
    

    PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';
    
    ALTER TABLE [dbo].[DependantsForApproval]
        ADD DEFAULT ('') FOR [Surname];
    

    PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';
    
    ALTER TABLE [dbo].[DependantsForApproval]
        ADD DEFAULT ('') FOR [IDNum];
    

    PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';
    
    ALTER TABLE [dbo].[DependantsForApproval]
        ADD DEFAULT ('') FOR [Nationality];
    

    PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';
    
    ALTER TABLE [dbo].[DependantsForApproval]
        ADD DEFAULT ('') FOR [ContactNumber];
    

    PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';
    
    ALTER TABLE [dbo].[DependantsForApproval]
        ADD DEFAULT ('') FOR [Sex];
    

END
GO