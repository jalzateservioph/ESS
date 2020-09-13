PRINT N'Starting rebuilding table [dbo].[ess.Reject]...';
GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_ess.Reject] (
    [CompanyNum]       NVARCHAR (20)  NOT NULL,
    [EmployeeNum]      NVARCHAR (12)  NOT NULL,
    [NotifyDate]       DATETIME       NOT NULL,
    [PolicyID]         TINYINT        NOT NULL,
    [AssemblyID]       TINYINT        NOT NULL,
    [Template]         NVARCHAR (30)  NOT NULL,
    [ValueF]           NVARCHAR (80)  NOT NULL,
    [ValueT]           NVARCHAR (80)  NOT NULL,
    [PathID]           BIGINT         NULL,
    [Level]            INT            DEFAULT ((0)) NOT NULL,
    [AdditionalField]  NVARCHAR (100) NULL,
    [AdditionalName]   NVARCHAR (100) NULL,
    [AdditionalFilter] NVARCHAR (100) NULL,
    [ActionedBy]       NVARCHAR (100) NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_ess.Reject] PRIMARY KEY CLUSTERED ([CompanyNum] ASC, [EmployeeNum] ASC, [NotifyDate] ASC, [PolicyID] ASC, [ValueF] ASC, [ValueT] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[ess.Reject])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_ess.Reject] ([CompanyNum], [EmployeeNum], [NotifyDate], [PolicyID], [ValueF], [ValueT], [AssemblyID], [Template], [PathID], [ActionedBy])
        SELECT   [CompanyNum],
                 [EmployeeNum],
                 [NotifyDate],
                 [PolicyID],
                 [ValueF],
                 [ValueT],
                 [AssemblyID],
                 [Template],
                 [PathID],
                 [ActionedBy]
        FROM     [dbo].[ess.Reject]
        ORDER BY [CompanyNum] ASC, [EmployeeNum] ASC, [NotifyDate] ASC, [PolicyID] ASC, [ValueF] ASC, [ValueT] ASC;
    END

DROP TABLE [dbo].[ess.Reject];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ess.Reject]', N'ess.Reject';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_ess.Reject]', N'PK_ess.Reject', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
GO