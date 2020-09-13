IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'RelWorkingInTMP' AND COLUMN_NAME = 'PlantBranch')
    alter table RelWorkingInTMP add PlantBranch nvarchar(100)
GO

PRINT N'Starting rebuilding table [dbo].[RelWorkingInTMP]...';
GO

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_RelWorkingInTMP] (
    [CompanyNum]  NVARCHAR (40)  NOT NULL,
    [EmployeeNum] NVARCHAR (24)  NOT NULL,
    [Position]    NVARCHAR (100) NULL,
    [AppliedOn]   DATETIME       NULL,
    [FirstName]   NVARCHAR (80)  NOT NULL,
    [Surname]     NVARCHAR (80)  NOT NULL,
    [MiddleName]  NVARCHAR (80)  NULL,
    [Relation]    NVARCHAR (50)  NULL,
    [PlaceOfWork] NVARCHAR (100) NULL,
	[PlantBranch] NVARCHAR (100) NULL
    CONSTRAINT [tmp_ms_xx_constraint_PK_RelWorkingInTMP] PRIMARY KEY CLUSTERED ([CompanyNum] ASC, [EmployeeNum] ASC, [Surname] ASC, [FirstName] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[RelWorkingInTMP])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_RelWorkingInTMP] ([CompanyNum], [EmployeeNum], [Surname], [FirstName], [Position], [AppliedOn], [MiddleName], [Relation], [PlaceOfWork])
        SELECT   [CompanyNum],
                 [EmployeeNum],
                 [Surname],
                 [FirstName],
                 [Position],
                 [AppliedOn],
                 [MiddleName],
                 [Relation],
                 [PlaceOfWork]
				 [PlantBranch]
        FROM     [dbo].[RelWorkingInTMP]
        ORDER BY [CompanyNum] ASC, [EmployeeNum] ASC, [Surname] ASC, [FirstName] ASC;
    END

DROP TABLE [dbo].[RelWorkingInTMP];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_RelWorkingInTMP]', N'RelWorkingInTMP';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_RelWorkingInTMP]', N'PK_RelWorkingInTMP', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
GO