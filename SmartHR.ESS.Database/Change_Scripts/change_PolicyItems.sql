IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ess.PolicyItems' AND COLUMN_NAME = 'Approval') 
BEGIN
    PRINT N'Altering [dbo].[ess.PolicyItems]...';
    ALTER TABLE [dbo].[ess.PolicyItems] ADD [Approval] BIT DEFAULT ((0)) NOT NULL

    PRINT N'Refreshing [dbo].[ess_PolicyItems]...';
    EXECUTE sp_refreshsqlmodule N'[dbo].[ess_PolicyItems]';
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ess.PolicyItems' AND COLUMN_NAME = 'ApprovalLevel') 
BEGIN
    PRINT N'Altering [dbo].[ess.PolicyItems]...';
    ALTER TABLE [dbo].[ess.PolicyItems] ADD [ApprovalLevel] INT DEFAULT ((0)) NOT NULL;

    PRINT N'Refreshing [dbo].[ess_PolicyItems]...';
    EXECUTE sp_refreshsqlmodule N'[dbo].[ess_PolicyItems]';
END

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ess.PolicyItems' AND COLUMN_NAME = 'PolicyID' AND DATA_TYPE = 'int')
BEGIN

	CREATE TABLE [dbo].[temp_ess.PolicyItems](
		[ID] [smallint] IDENTITY(1,1) NOT NULL,
		[PolicyID] [int] NOT NULL,
		[Template] [nvarchar](10) NOT NULL,
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
		[Approval] [bit] NOT NULL,
		[ApprovalLevel] [int] NOT NULL,
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

	SET IDENTITY_INSERT [dbo].[ess.PolicyItems] OFF

	SET IDENTITY_INSERT [dbo].[temp_ess.PolicyItems] ON

	IF EXISTS(SELECT * FROM [dbo].[ess.PolicyItems])
	BEGIN
		INSERT INTO [dbo].[temp_ess.PolicyItems]
		(
			[ID]
			,[PolicyID]
			,[Template]
			,[Visible]
			,[Editable]
			,[Required]
			,[YesNo]
			,[Int]
			,[IntMin]
			,[IntMax]
			,[Dec]
			,[DecMin]
			,[DecMax]
			,[Date]
			,[DateMin]
			,[DateMax]
			,[Text]
			,[GUID]
			,[Object]
			,[LookupTable]
			,[LookupText]
			,[LookupValue]
			,[LookupFilter]
			,[Validation]
			,[Approval]
			,[ApprovalLevel]
		)
		SELECT 
			[ID]
			,[PolicyID]
			,[Template]
			,[Visible]
			,[Editable]
			,[Required]
			,[YesNo]
			,[Int]
			,[IntMin]
			,[IntMax]
			,[Dec]
			,[DecMin]
			,[DecMax]
			,[Date]
			,[DateMin]
			,[DateMax]
			,[Text]
			,[GUID]
			,[Object]
			,[LookupTable]
			,[LookupText]
			,[LookupValue]
			,[LookupFilter]
			,[Validation]
			,[Approval]
			,[ApprovalLevel]
	  FROM [dbo].[ess.PolicyItems]
	END

	SET IDENTITY_INSERT [dbo].[temp_ess.PolicyItems] OFF

	DROP TABLE [ess.PolicyItems]

	EXEC SP_RENAME '[dbo].[temp_ess.PolicyItems]', 'ess.PolicyItems'

	IF EXISTS(
	SELECT OBJECT_NAME(OBJECT_ID) AS NameofConstraint ,SCHEMA_NAME(schema_id) AS SchemaName ,OBJECT_NAME(parent_object_id) AS TableName ,type_desc AS ConstraintType 
	FROM sys.objects WHERE type_desc LIKE '%CONSTRAINT' AND OBJECT_NAME(OBJECT_ID)='PK_ess.PolicyItems')
		ALTER TABLE [dbo].[ess.PolicyItems] ADD CONSTRAINT [PK_ess.PolicyItems] PRIMARY KEY (ID)

	if not exists (
	select *
	from sys.all_columns c
		join sys.tables t on t.object_id = c.object_id
		join sys.schemas s on s.schema_id = t.schema_id
		join sys.default_constraints d on c.default_object_id = d.object_id
	where t.name = 'ess.PolicyItems' and c.name = 'Visible' and s.name = 'dbo')
		ALTER TABLE [dbo].[ess.PolicyItems] ADD  CONSTRAINT [DF_ess.PolicyItems_Visible]  DEFAULT ((0)) FOR [Visible]

	if not exists (
	select *
	from sys.all_columns c
		join sys.tables t on t.object_id = c.object_id
		join sys.schemas s on s.schema_id = t.schema_id
		join sys.default_constraints d on c.default_object_id = d.object_id
	where t.name = 'ess.PolicyItems' and c.name = 'Editable' and s.name = 'dbo')
		ALTER TABLE [dbo].[ess.PolicyItems] ADD  CONSTRAINT [DF_ess.PolicyItems_Editable]  DEFAULT ((0)) FOR [Editable]

	if not exists (
	select *
	from sys.all_columns c
		join sys.tables t on t.object_id = c.object_id
		join sys.schemas s on s.schema_id = t.schema_id
		join sys.default_constraints d on c.default_object_id = d.object_id
	where t.name = 'ess.PolicyItems' and c.name = 'Required' and s.name = 'dbo')
		ALTER TABLE [dbo].[ess.PolicyItems] ADD  CONSTRAINT [DF_ess.PolicyItems_Required]  DEFAULT ((0)) FOR [Required]

	if not exists (
	select *
	from sys.all_columns c
		join sys.tables t on t.object_id = c.object_id
		join sys.schemas s on s.schema_id = t.schema_id
		join sys.default_constraints d on c.default_object_id = d.object_id
	where t.name = 'ess.PolicyItems' and c.name = 'YesNo' and s.name = 'dbo')
		ALTER TABLE [dbo].[ess.PolicyItems] ADD  CONSTRAINT [DF_ess.PolicyItems_YesNo]  DEFAULT ((0)) FOR [YesNo]

	if not exists (
	select *
	from sys.all_columns c
		join sys.tables t on t.object_id = c.object_id
		join sys.schemas s on s.schema_id = t.schema_id
		join sys.default_constraints d on c.default_object_id = d.object_id
	where t.name = 'ess.PolicyItems' and c.name = 'Approval' and s.name = 'dbo')
		ALTER TABLE [dbo].[ess.PolicyItems] ADD  DEFAULT ((0)) FOR [Approval]

	if not exists (
	select *
	from sys.all_columns c
		join sys.tables t on t.object_id = c.object_id
		join sys.schemas s on s.schema_id = t.schema_id
		join sys.default_constraints d on c.default_object_id = d.object_id
	where t.name = 'ess.PolicyItems' and c.name = 'ApprovalLevel' and s.name = 'dbo')
		ALTER TABLE [dbo].[ess.PolicyItems] ADD  DEFAULT ((0)) FOR [ApprovalLevel]

END