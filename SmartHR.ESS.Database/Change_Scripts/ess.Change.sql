BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_ess.Change] (
    [CompanyNum]       NVARCHAR (20)  NOT NULL,
    [EmployeeNum]      NVARCHAR (12)  NOT NULL,
    [NotifyDate]       DATETIME       NOT NULL,
    [PolicyID]         INT        NOT NULL,
    [AssemblyID]       TINYINT        NOT NULL,
    [Template]         NVARCHAR (30)  NOT NULL,
    [ValueF]           NVARCHAR (80)  NOT NULL,
    [ValueT]           NVARCHAR (80)  NOT NULL,
    [PathID]           BIGINT         NULL,
    [Level]            INT            DEFAULT ((0)) NOT NULL,
    [AdditionalField]  NVARCHAR (100) NULL,
    [AdditionalName]   NVARCHAR (100) NULL,
    [AdditionalFilter] NVARCHAR (100) NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_ess.Change] PRIMARY KEY CLUSTERED ([CompanyNum] ASC, [EmployeeNum] ASC, [NotifyDate] ASC, [PolicyID] ASC, [ValueF] ASC, [ValueT] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[ess.Change])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_ess.Change] ([CompanyNum], [EmployeeNum], [NotifyDate], [PolicyID], [ValueF], [ValueT], [AssemblyID], [Template], [PathID])
        SELECT   [CompanyNum],
                 [EmployeeNum],
                 [NotifyDate],
                 [PolicyID],
                 [ValueF],
                 [ValueT],
                 [AssemblyID],
                 [Template],
                 [PathID]
        FROM     [dbo].[ess.Change]
        ORDER BY [CompanyNum] ASC, [EmployeeNum] ASC, [NotifyDate] ASC, [PolicyID] ASC, [ValueF] ASC, [ValueT] ASC;
    END

DROP TABLE [dbo].[ess.Change];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ess.Change]', N'ess.Change';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_ess.Change]', N'PK_ess.Change', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
GO

PRINT N'Refreshing [dbo].[ess_Change]...';
GO
EXECUTE sp_refreshsqlmodule N'[dbo].[ess_Change]';
GO