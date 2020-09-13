IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ess.Policy' AND COLUMN_NAME = 'Approval' ) 
BEGIN
    PRINT N'Altering [dbo].[ess.Policy]...';

    ALTER TABLE [dbo].[ess.Policy] ADD [Approval] BIT DEFAULT ((0)) NOT NULL;

    PRINT N'Refreshing [dbo].[ess_Policy]...';
    EXECUTE sp_refreshsqlmodule N'[dbo].[ess_Policy]';
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ess.Policy' AND COLUMN_NAME = 'ApprovalLevel') 
BEGIN
    PRINT N'Altering [dbo].[ess.Policy]...';

    ALTER TABLE [dbo].[ess.Policy] ADD [ApprovalLevel] INT DEFAULT ((0)) NOT NULL;

    PRINT N'Refreshing [dbo].[ess_Policy]...';
    EXECUTE sp_refreshsqlmodule N'[dbo].[ess_Policy]';
END

GO

--Created by: Joshua Alzate
--Created on: 4/4/2019
--Description: upates ess.Policy id field from tinyint to int

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ess.Policy' AND COLUMN_NAME = 'ID' AND DATA_TYPE = 'int')
BEGIN
	--DROP TABLE [dbo].[temp_ess.Policy]

	CREATE TABLE [dbo].[temp_ess.Policy](
		[ID] [int] IDENTITY(1,1) NOT NULL,
		[GroupID] [tinyint] NOT NULL,
		[SetupAssemblyID] [tinyint] NOT NULL,
		[SetupDataTypeID] [tinyint] NOT NULL,
		[AssemblyID] [tinyint] NOT NULL,
		[DataTypeID] [tinyint] NOT NULL,
		[Key] [nvarchar](50) NOT NULL,
		[Name] [nvarchar](25) NULL,
		[Label] [nvarchar](128) NULL,
		[Description] [ntext] NOT NULL,
		[Visible] [bit] NOT NULL,
		[Editable] [bit] NOT NULL,
		[Required] [bit] NOT NULL,
		[YesNo] [bit] NOT NULL,
		[Int] [int] NULL,
		[IntMin] [int] NULL,
		[IntMax] [int] NULL,
		[Dec] [float] NULL,
		[DecMin] [float] NULL,
		[DecMax] [float] NULL,
		[Date] [datetime] NULL,
		[DateMin] [datetime] NULL,
		[DateMax] [datetime] NULL,
		[Text] [ntext] NULL,
		[GUID] [uniqueidentifier] NULL,
		[Object] [image] NULL,
		[LookupTable] [nvarchar](75) NULL,
		[LookupText] [nvarchar](75) NULL,
		[LookupValue] [nvarchar](75) NULL,
		[LookupFilter] [ntext] NULL,
		[Validation] [ntext] NULL,
		[Cascade] [bit] NOT NULL,
		[Approval] [bit] NOT NULL,
		[ApprovalLevel] [int] NOT NULL
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

	SET IDENTITY_INSERT [dbo].[ess.Policy] OFF

	SET IDENTITY_INSERT [dbo].[temp_ess.Policy] ON

IF EXISTS(SELECT * FROM [dbo].[ess.Policy])
BEGIN

	INSERT INTO [dbo].[temp_ess.Policy]
	(
		[ID],
		[GroupID],
		[SetupAssemblyID],
		[SetupDataTypeID],
		[AssemblyID],
		[DataTypeID],
		[Key],
		[Name],
		[Label],
		[Description],
		[Visible],
		[Editable],
		[Required],
		[YesNo],
		[Int],
		[IntMin],
		[IntMax],
		[Dec],
		[DecMin],
		[DecMax],
		[Date],
		[DateMin],
		[DateMax],
		[Text],
		[GUID],
		[Object],
		[LookupTable],
		[LookupText],
		[LookupValue],
		[LookupFilter],
		[Validation],
		[Cascade],
		[Approval],
		[ApprovalLevel]
	)
	SELECT
		[ID],
		[GroupID],
		[SetupAssemblyID],
		[SetupDataTypeID],
		[AssemblyID],
		[DataTypeID],
		[Key],
		[Name],
		[Label],
		[Description],
		[Visible],
		[Editable],
		[Required],
		[YesNo],
		[Int],
		[IntMin],
		[IntMax],
		[Dec],
		[DecMin],
		[DecMax],
		[Date],
		[DateMin],
		[DateMax],
		[Text],
		[GUID],
		[Object],
		[LookupTable],
		[LookupText],
		[LookupValue],
		[LookupFilter],
		[Validation],
		[Cascade],
		[Approval],
		[ApprovalLevel]
	FROM [dbo].[ess.Policy] TABLOCKX

END

	SET IDENTITY_INSERT [dbo].[temp_ess.Policy] OFF

	DROP TABLE [dbo].[ess.Policy]

	--select * from [dbo].[temp_ess.Policy]

	Exec sp_rename '[dbo].[temp_ess.Policy]', 'ess.Policy'

	--select * from [ess.Policy]

	IF NOT EXISTS(
		SELECT OBJECT_NAME(OBJECT_ID) AS NameofConstraint ,SCHEMA_NAME(schema_id) AS SchemaName ,OBJECT_NAME(parent_object_id) AS TableName ,type_desc AS ConstraintType 
		FROM sys.objects WHERE type_desc LIKE '%CONSTRAINT' AND OBJECT_NAME(OBJECT_ID)='PK_ess.Policy')
	BEGIN
		ALTER TABLE [dbo].[ess.Policy] ADD CONSTRAINT [PK_ess.Policy] PRIMARY KEY (ID)
	END

	if not exists (
		select *
		from sys.all_columns c
		  join sys.tables t on t.object_id = c.object_id
		  join sys.schemas s on s.schema_id = t.schema_id
		  join sys.default_constraints d on c.default_object_id = d.object_id
		where t.name = 'ess.Policy' and c.name = 'Visible' and s.name = 'dbo')
	BEGIN
		ALTER TABLE [dbo].[ess.Policy] ADD  CONSTRAINT [DF_ess.Policy_Visible]  DEFAULT ((0)) FOR [Visible]
	END

	if not exists (
		select *
		from sys.all_columns c
		  join sys.tables t on t.object_id = c.object_id
		  join sys.schemas s on s.schema_id = t.schema_id
		  join sys.default_constraints d on c.default_object_id = d.object_id
		where t.name = 'ess.Policy' and c.name = 'Editable' and s.name = 'dbo')
	BEGIN
		ALTER TABLE [dbo].[ess.Policy] ADD  CONSTRAINT [DF_ess.Policy_Editable]  DEFAULT ((0)) FOR [Editable]
	END

	if not exists (
		select *
		from sys.all_columns c
		  join sys.tables t on t.object_id = c.object_id
		  join sys.schemas s on s.schema_id = t.schema_id
		  join sys.default_constraints d on c.default_object_id = d.object_id
		where t.name = 'ess.Policy' and c.name = 'Required' and s.name = 'dbo')
	BEGIN
		ALTER TABLE [dbo].[ess.Policy] ADD  CONSTRAINT [DF_ess.Policy_Required]  DEFAULT ((0)) FOR [Required]
	END

	if not exists (
		select *
		from sys.all_columns c
		  join sys.tables t on t.object_id = c.object_id
		  join sys.schemas s on s.schema_id = t.schema_id
		  join sys.default_constraints d on c.default_object_id = d.object_id
		where t.name = 'ess.Policy' and c.name = 'YesNo' and s.name = 'dbo')
	BEGIN
		ALTER TABLE [dbo].[ess.Policy] ADD  CONSTRAINT [DF_ess.Policy_YesNo]  DEFAULT ((0)) FOR [YesNo]
	END

	if not exists (
		select *
		from sys.all_columns c
		  join sys.tables t on t.object_id = c.object_id
		  join sys.schemas s on s.schema_id = t.schema_id
		  join sys.default_constraints d on c.default_object_id = d.object_id
		where t.name = 'ess.Policy' and c.name = 'Cascade' and s.name = 'dbo')
	BEGIN
		ALTER TABLE [dbo].[ess.Policy] ADD  CONSTRAINT [DF_ess.Policy_Cascade]  DEFAULT ((0)) FOR [Cascade]
	END

	if not exists (
		select *
		from sys.all_columns c
		  join sys.tables t on t.object_id = c.object_id
		  join sys.schemas s on s.schema_id = t.schema_id
		  join sys.default_constraints d on c.default_object_id = d.object_id
		where t.name = 'ess.Policy' and c.name = 'Approval' and s.name = 'dbo')
	BEGIN
		ALTER TABLE [dbo].[ess.Policy] ADD  DEFAULT ((0)) FOR [Approval]
	END

	if not exists (
		select *
		from sys.all_columns c
		  join sys.tables t on t.object_id = c.object_id
		  join sys.schemas s on s.schema_id = t.schema_id
		  join sys.default_constraints d on c.default_object_id = d.object_id
		where t.name = 'ess.Policy' and c.name = 'ApprovalLevel' and s.name = 'dbo')
	BEGIN
		ALTER TABLE [dbo].[ess.Policy] ADD  DEFAULT ((0)) FOR [ApprovalLevel]
	END

	SET IDENTITY_INSERT [dbo].[ess.Policy] ON

END
GO