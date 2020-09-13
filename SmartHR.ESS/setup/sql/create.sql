/**********************************************************************************************************

							*** v6.0.74 (Create non existing tables) ***

***********************************************************************************************************/
if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.SQLExecute]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.SQLExecute] (
		[ID] [uniqueidentifier] not null,
		[CompanyNum] [nvarchar] (20) not null,
		[EmployeeNum] [nvarchar] (12) not null,
		[ExecuteOn] [datetime] null,
		[Executed] [bit] not null,
		[SQLExec] [ntext] not null,
		[SQLData] [ntext] null,
		[Status] [nvarchar] (15) not null,
		[PathID] [bigint] null
	) on [primary] textimage_on [primary]

	alter table [dbo].[ess.SQLExecute] add
		constraint [DF_ess.SQLExecute_Executed] default (0) for [Executed],
		constraint [PK_ess.SQLExecute] primary key clustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[Timesheets]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[Timesheets] (
		[CompanyNum] [nvarchar] (20) not null,
		[EmployeeNum] [nvarchar] (12) not null,
		[Start] [datetime] not null,
		[Until] [datetime] not null,
		[Type] [nvarchar] (25) not null,
		[Description] [ntext] null,
		[DocPath] [nvarchar] (255) null,
		[ESSPath] [nvarchar] (255) null,
		[Username] [nvarchar] (20) not null,
		[CapturedDate] [datetime] not null,
		[Status] [nvarchar] (15) not null,
		[PathID] [bigint] null
	) on [primary] textimage_on [primary]

	alter table [dbo].[Timesheets] add
		constraint [DF_Timesheets_CapturedDate] default (getdate()) for [CapturedDate],
		constraint [DF_Timesheets_Status] default (N'Unsubmitted') for [Status],
		constraint [PK_Timesheets] primary key clustered 
		(
			[CompanyNum],
			[EmployeeNum],
			[Start],
			[Until],
			[Type]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[TimesheetEntries]') and objectproperty([id], N'IsUserTable') = 1)
begin

	create table [dbo].[TimesheetEntries] (
		[CompanyNum] [nvarchar] (20) not null,
		[EmployeeNum] [nvarchar] (12) not null,
		[Start] [datetime] not null,
		[Until] [datetime] not null,
		[Type] [nvarchar] (25) not null,
		[ItemDate] [datetime] not null,
		[DocPath] [nvarchar] (255) null,
		[ESSPath] [nvarchar] (255) null 
	) on [primary]

	alter table [dbo].[TimesheetEntries] add
		constraint [PK_TimesheetEntries] primary key clustered 
		(
			[CompanyNum],
			[EmployeeNum],
			[Start],
			[Until],
			[Type],
			[ItemDate]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[TimesheetChildEntries]') and objectproperty([id], N'IsUserTable') = 1)
begin

	create table [dbo].[TimesheetChildEntries] (
		[CompanyNum] [nvarchar] (20) not null,
		[EmployeeNum] [nvarchar] (12) not null,
		[Start] [datetime] not null,
		[Until] [datetime] not null,
		[Type] [nvarchar] (25) not null,
		[ItemDate] [datetime] not null,
		[ItemName] [nvarchar] (50) not null,
		[DocPath] [nvarchar] (255) null,
		[ESSPath] [nvarchar] (255) null 
	) on [primary]

	alter table [dbo].[TimesheetChildEntries] add
		constraint [PK_TimesheetChildEntries] primary key clustered 
		(
			[CompanyNum],
			[EmployeeNum],
			[Start],
			[Until],
			[Type],
			[ItemDate],
			[ItemName]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[TimesheetMappingLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	create table [dbo].[TimesheetMappingLU] (
		[ColumnID] [tinyint] not null,
		[ItemType] [nvarchar] (25) not null
	) on [primary]

	alter table [dbo].[TimesheetMappingLU] add
		constraint [PK_TimesheetMappingLU] primary key clustered 
		(
			[ColumnID],
			[ItemType]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[TimesheetSetup]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[TimesheetSetup] (
		[ID] [tinyint] identity (1, 1) not null,
		[AssemblyID] [tinyint] not null,
		[DataTypeID] [tinyint] not null,
		[GroupTypeID] [tinyint] not null,
		[Size] [smallint] null,
		[Name] [nvarchar] (50) not null,
		[Text] [nvarchar] (75) not null,
		[IsChild] [bit] not null,
		[IsView] [bit] not null,
		[Index] [tinyint] NULL,
		[SQLCalculate] [ntext] NULL,
		[SQLSelect] [ntext] NULL,
		[SQLUpdate] [ntext] NULL,
		[Description] [ntext] NULL
	) on [primary]

	alter table [dbo].[TimesheetSetup] add
		constraint [DF_TimesheetSetup_IsView] default (0) for [IsView],
		constraint [PK_TimesheetSetup] primary key clustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[TimesheetTypeLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[TimesheetTypeLU] (
		[ItemType] [nvarchar] (25) not null
	) on [primary]

	alter table [dbo].[TimesheetTypeLU] add
		constraint [PK_TimesheetTypeLU] primary key clustered 
		(
			[ItemType]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[Charts.TypeLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[Charts.TypeLU] (
		[ID] [tinyint] not null,
		[TypeName] [nvarchar](25) not null
	) on [primary]

	alter table [dbo].[Charts.TypeLU] add 
		constraint [PK_Charts.TypeLU] primary key clustered 
		(
			[ID]
		) on [primary]

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[Charts.ChartLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[Charts.ChartLU] (
		[ID] [tinyint] identity (1,1) not null,
		[TypeID] [tinyint] not null,
		[Title] [nvarchar](64) not null,
	) on [primary]

	alter table [dbo].[Charts.ChartLU] add 
		constraint [PK_Charts.ChartLU] primary key clustered 
		(
			[ID]
		) on [primary]

	alter table [dbo].[Charts.ChartLU] with check add 
		constraint [FK_Charts.ChartLU_Charts.TypeLU] foreign key([TypeID]) references [Charts.TypeLU] ([ID])
		on update cascade
		on delete cascade

	alter table [dbo].[Charts.ChartLU] check constraint [FK_Charts.ChartLU_Charts.TypeLU]

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[Charts.DataLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[Charts.DataLU] (
		[ID] [smallint] identity (1,1) not null,
		[ChartID] [tinyint] not null,
		[Name] [nvarchar](25) not null,
		[SQL] [ntext] not null
	) on [primary]

	alter table [dbo].[Charts.DataLU] add 
		constraint [PK_Charts.DataLU] primary key clustered 
		(
			[ID]
		) on [primary]

	alter table [dbo].[Charts.DataLU] with check add 
		constraint [FK_Charts.DataLU_Charts.ChartLU] foreign key([ChartID]) references [Charts.ChartLU] ([ID])
		on update cascade
		on delete cascade

	alter table [dbo].[Charts.DataLU] check constraint [FK_Charts.DataLU_Charts.ChartLU]

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[Charts.ParamLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[Charts.ParamLU] (
		[ID] [smallint] identity (1,1) not null,
		[ChartID] [tinyint] not null,
		[Type] [nvarchar](75) null,
		[Index] [tinyint] not null,
		[Name] [nvarchar](50) not null,
		[Value] [nvarchar](256) null,
		[DisplayFormat] [nvarchar](50) null,
		[ValueFormat] [nvarchar](50) null,
		[SQL] [ntext] null,
		[TextField] [nvarchar](75) null,
		[ValueField] [nvarchar](75) null
	) on [primary]

	alter table [dbo].[Charts.ParamLU] add 
		constraint [PK_Charts.ParamLU] primary key clustered 
		(
			[ID]
		) on [primary]

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[AssemblyLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[AssemblyLU] (
		[ID] [tinyint] identity (1, 1) not null,
		[Assembly] [nvarchar] (75) not null,
		[Typename] [nvarchar] (75) not null,
		[FriendlyName] [nvarchar] (50) null,
		[Property] [nvarchar] (15) null
	) on [primary]

	alter table [dbo].[AssemblyLU] add 
		constraint [PK_AssemblyLU] primary key nonclustered 
		(
			[ID]
		) on [primary]

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[ess.LearningNeeds]') and objectproperty([id], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.LearningNeeds] (
		[Username] [nvarchar] (20) not null,
		[CompanyNum] [nvarchar] (20) not null,
		[EmployeeNum] [nvarchar] (12) not null,
		[CourseName] [nvarchar] (100) not null,
		[ProviderName] [nvarchar] (50) not null,
		[StartDate] [datetime] not null,
		[CompletionDate] [datetime] null,
		[DirectCost] [real] null,
		[CourseCategory] [nvarchar] (40) null,
		[InternalCourse] [bit] not null,
		[IndividualPriority] [nvarchar] (100) null,
		[DepartmentalPriority] [nvarchar] (100)  NULL 
	) on [primary]

	alter table [dbo].[ess.LearningNeeds] with nocheck add 
		constraint [PK_ess.LearningNeeds] primary key clustered 
		(
			[Username],
			[CompanyNum],
			[EmployeeNum],
			[CourseName],
			[ProviderName],
			[StartDate]
		) on [primary] 

	exec sp_bindefault N'[dbo].[UW_ZeroDefault]', N'[ess.LearningNeeds].[DirectCost]'

	exec sp_bindefault N'[dbo].[UW_ZeroDefault]', N'[ess.LearningNeeds].[InternalCourse]'

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.PerfSubmitted]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.PerfSubmitted] (
		[CompanyNum] [nvarchar] (20) not null,
		[EmployeeNum] [nvarchar] (12) not null,
		[Username] [nvarchar] (20) not null,
		[PathID] [bigint] not null
	) on [primary]

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[Passwords]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[Passwords](
		[ID] [uniqueidentifier] not null,
		[CompanyNum] [nvarchar](20) not null,
		[EmployeeNum] [nvarchar](12) not null,
		[Username] [nvarchar](20) not null,
		[CreatedOn] [datetime] not null
	) on [primary]

	alter table [dbo].[Passwords] add 
		constraint [PK_Passwords] primary key nonclustered 
		(
			[ID]
		) on [primary]

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[MessageStatusLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[MessageStatusLU](
		[ID] [smallint] not null,
		[Description] [nvarchar](64) not null
	) on [primary]

	alter table [dbo].[MessageStatusLU] add 
		constraint [PK_MessageStatusLU] primary key nonclustered 
		(
			[ID]
		) on [primary]

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[Claims]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[Claims] (
		[CompanyNum] [nvarchar] (20) not null,
		[EmployeeNum] [nvarchar] (12) not null,
		[Date] [datetime] not null,
		[Type] [nvarchar] (25) not null,
		[Description] [ntext] null,
		[DocPath] [nvarchar] (255) null,
		[ESSPath] [nvarchar] (255) null,
		[Username] [nvarchar] (20) not null,
		[CapturedDate] [datetime] not null,
		[Status] [nvarchar] (15) not null,
		[PathID] [bigint] null
	) on [primary] textimage_on [primary]

	alter table [dbo].[Claims] add
		constraint [DF_Claims_CapturedDate] default (getdate()) for [CapturedDate],
		constraint [DF_Claims_Status] default (N'Unsubmitted') for [Status],
		constraint [PK_Claims] primary key clustered 
		(
			[CompanyNum],
			[EmployeeNum],
			[Date],
			[Type]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[ClaimEntries]') and objectproperty([id], N'IsUserTable') = 1)
begin

	create table [dbo].[ClaimEntries] (
		[CompanyNum] [nvarchar] (20) not null,
		[EmployeeNum] [nvarchar] (12) not null,
		[Date] [datetime] not null,
		[Type] [nvarchar] (25) not null,
		[ItemType] [nvarchar] (25) not null,
		[ItemName] [nvarchar] (80) not null,
		[Amount] [real] not null,
		[DocPath] [nvarchar] (255) null,
		[ESSPath] [nvarchar] (255) null 
	) on [primary]

	alter table [dbo].[ClaimEntries] add
		constraint [PK_ClaimEntries] primary key clustered 
		(
			[CompanyNum],
			[EmployeeNum],
			[Date],
			[Type],
			[ItemType],
			[ItemName]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[ClaimMappingLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	create table [dbo].[ClaimMappingLU] (
		[ColumnID] [tinyint] not null,
		[ItemType] [nvarchar] (25) not null
	) on [primary]

	alter table [dbo].[ClaimMappingLU] add
		constraint [PK_ClaimMappingLU] primary key clustered 
		(
			[ColumnID],
			[ItemType]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ClaimSetup]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ClaimSetup] (
		[ID] [tinyint] identity (1, 1) not null,
		[AssemblyID] [tinyint] not null,
		[DataTypeID] [tinyint] not null,
		[GroupTypeID] [tinyint] not null,
		[Size] [smallint] null,
		[Name] [nvarchar] (50) not null,
		[Text] [nvarchar] (75) not null,
		[IsView] [bit] not null,
		[Index] [tinyint] NULL,
		[SQLCalculate] [ntext] NULL,
		[SQLSelect] [ntext] NULL,
		[SQLUpdate] [ntext] NULL,
		[Description] [ntext] NULL
	) on [primary]

	alter table [dbo].[ClaimSetup] add
		constraint [DF_ClaimSetup_IsView] default (0) for [IsView],
		constraint [PK_ClaimSetup] primary key clustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ClaimTypeLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ClaimTypeLU] (
		[ItemType] [nvarchar] (25) not null
	) on [primary]

	alter table [dbo].[ClaimTypeLU] add
		constraint [PK_ClaimTypeLU] primary key clustered 
		(
			[ItemType]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ClaimSubTypeLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ClaimSubTypeLU] (
		[ItemType] [nvarchar] (25) not null,
		[SubItemType] [nvarchar] (25) not null
	) on [primary]

	alter table [dbo].[ClaimSubTypeLU] add
		constraint [PK_ClaimSubTypeLU] primary key clustered 
		(
			[ItemType],
			[SubItemType]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[DataTypeLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[DataTypeLU] (
		[ID] [tinyint] identity (1, 1) not null,
		[DataType] [tinyint] not null,
		[Typename] [nvarchar] (75) not null
	) on [primary]

	alter table [dbo].[DataTypeLU] add 
		constraint [PK_DataTypeLU] primary key nonclustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[DocLinkCategoryLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[DocLinkCategoryLU] (
		[Value] [nvarchar] (10) not null,
		[Text] [nvarchar] (25) not null
	) on [primary]

	alter table [dbo].[DocLinkCategoryLU] with nocheck add
		constraint [PK_DocLinkCategoryLU] primary key clustered
		(
			[Value]
		) on [primary]

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[EmailLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[EmailLU] (
		[ID] [tinyint] identity (1, 1) not null,
		[Type] [nvarchar] (50) not null,
		[Server] [nvarchar] (75) not null,
		[Port] [smallint] not null,
		[Username] nvarchar(32) null,
		[Password] nvarchar(64) null,		
		[Name] [nvarchar] (50) not null,
		[Address] [nvarchar] (128) not null,
		[Subject] [nvarchar] (128) not null,
		[Body] [ntext] not null,
		[BodyText] [ntext] null
	) on [primary] textimage_on [primary]

	alter table [dbo].[EmailLU] add 
		constraint [PK_EmailLU] primary key clustered 
		(
			[ID]
		) on [primary]

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[EmailResults]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[EmailResults] (
		[ID] [uniqueidentifier] not null,
		[Date] [datetime] not null,
		[Server] [nvarchar] (75) not null,
		[Port] [smallint] not null,
		[Username] [nvarchar] (32) null,
		[Password] [nvarchar] (64) null,
		[From] [nvarchar] (128) not null,
		[To] [nvarchar] (128) not null,
		[Subject] [nvarchar] (256) not null,
		[Message] [ntext] not null,
		[Status] [nvarchar] (25) not null,
		[ErrorText] [ntext] null
	) on [primary] textimage_on [primary]

	alter table [dbo].[EmailResults] with nocheck add 
		constraint [PK_EmailResults] primary key clustered 
		(
			[ID]
		) on [primary]

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ActionLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.ActionLU] (
		[ID] [tinyint] identity (1, 1) not null,
		[ReportsToType] [nvarchar] (50) not null
	) on [primary]

	alter table [dbo].[ess.ActionLU] add 
		constraint [PK_ess.ActionLU] primary key nonclustered 
		(
			[ID]
		) on [primary]

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Change]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.Change] (
		[CompanyNum] [nvarchar] (20) not null,
		[EmployeeNum] [nvarchar] (12) not null,
		[NotifyDate] [datetime] not null,
		[PolicyID] [tinyint] not null,
		[AssemblyID] [tinyint] not null,
		[Template] [nvarchar] (30) not null,
		[ValueF] [nvarchar] (80) not null,
		[ValueT] [nvarchar] (80) not null,
		[PathID] [bigint] null
	) on [primary]

	alter table [dbo].[ess.Change] add 
		constraint [PK_ess.Change] primary key clustered 
		(
			[CompanyNum],
			[EmployeeNum],
			[NotifyDate],
			[PolicyID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ConditionClauses]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.ConditionClauses] (
		[ID] [bigint] identity (1, 1) not null,
		[ConditionID] [int] not null,
		[CurTable] [nvarchar] (128) not null,
		[CurField] [nvarchar] (128) not null,
		[CurWhere] [nvarchar] (4000) not null,
		[Criteria] [nvarchar] (2) not null,
		[ComTable] [nvarchar] (128) null,
		[ComField] [nvarchar] (128) null,
		[ComWhere] [nvarchar] (4000) null,
		[ComValue] [nvarchar] (4000) null 
	) on [primary]

	alter table [dbo].[ess.ConditionClauses] with nocheck add 
		constraint [PK_ess.ConditionClauses] primary key clustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Conditions]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.Conditions] (
		[ID] [int] identity (1, 1) not null,
		[Name] [nvarchar] (50) not null,
		[Description] [nvarchar] (1024)not null
	) on [primary]

	alter table [dbo].[ess.Conditions] with nocheck add 
		constraint [PK_ess.Conditions] primary key clustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Documents]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.Documents] (
		[ID] [bigint] identity (1, 1) not null,
		[CompanyNum] [nvarchar] (20) not null,
		[EmployeeNum] [nvarchar] (12) not null,
		[Category] [nvarchar] (25) not null,
		[Path] [nvarchar] (255) not null,
		[VirtualPath] [nvarchar] (255) not null,
		[Description] [nvarchar] (50) not null,
		[DateLinked] [datetime] not null,
		[UserLinked] [nvarchar] (20) not null,
		[Acknowledged] [bit] not null,
		[Accepted] [bit] null,
		[DateRead] [datetime] null,
		[DeclinedReason] [nvarchar] (255) null
	) on [primary]

	alter table [dbo].[ess.Documents] add 
		constraint [PK_ess.Documents] primary key nonclustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.EvalGroups]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.EvalGroups] (
		[CompanyNum] [nvarchar] (20) not null,
		[EmployeeNum] [nvarchar] (12) not null,
		[Name] [nvarchar] (50) not null 
	) on [primary]

	alter table [dbo].[ess.EvalGroups] with nocheck add
		constraint [PK_ess.EvalGroups] primary key clustered 
		(
			[CompanyNum],
			[EmployeeNum],
			[Name]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.EvalGroupItems]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.EvalGroupItems] (
		[CompanyNum] [nvarchar] (20) not null,
		[EmployeeNum] [nvarchar] (12) not null,
		[GroupName] [nvarchar] (50) not null,
		[SchemeCode] [nvarchar] (50) not null,
		[EvalCompanyNum] [nvarchar] (20) not null,
		[EvalEmployeeNum] [nvarchar] (12) not null,
		[ApprCompanyNum] [nvarchar] (20) not null,
		[ApprEmployeeNum] [nvarchar] (12) not null,
		[ApprType] [nvarchar] (20) not null
	) on [primary]

	alter table [dbo].[ess.EvalGroupItems] with nocheck add 
		constraint [PK_ess.EvalGroupItems] primary key clustered 
		(
			[CompanyNum],
			[EmployeeNum],
			[GroupName],
			[SchemeCode],
			[EvalCompanyNum],
			[EvalEmployeeNum],
			[ApprCompanyNum],
			[ApprEmployeeNum],
			[ApprType]
		) on [primary] 

	alter table [dbo].[ess.EvalGroupItems] add
		constraint [FK_ess.EvalGroupItems_ess.EvalGroups] foreign key 
		(
			[CompanyNum],
			[EmployeeNum],
			[GroupName]
		) references [dbo].[ess.EvalGroups] (
			[CompanyNum],
			[EmployeeNum],
			[Name]
		) on delete cascade on update cascade 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.LeaveBlock]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.LeaveBlock] (
		[CompanyNum] [nvarchar] (20) not null,
		[EmployeeNum] [nvarchar] (12) not null,
		[BlockFrom] [datetime] not null,
		[BlockUntil] [datetime] not null,
		[Description] [nvarchar] (1024) null,
		[CapturedBy] [nvarchar] (20) not null,
		[CapturedOn] [datetime] not null
	) on [primary]

	alter table [dbo].[ess.LeaveBlock] add
		constraint [PK_ess.LeaveBlock] primary key clustered 
		(
			[CompanyNum],
			[EmployeeNum],
			[BlockFrom]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Menu]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.Menu] (
		[ID] [tinyint] identity (1, 1) not null,
		[Description] [nvarchar] (50) not null,
		[ItemImage] [nvarchar] (50) not null,
		[LoadURL] [nvarchar] (128) not null,
		[Visible] [bit] not null,
		[TemplateElement] [nvarchar] (30) null,
		[LoggedOnUser] [bit] not null,
		[OrderID] [smallint] not null,
		[HomeType] [tinyint] null,
		[HomeImage] [nvarchar] (128) null,
		[HomeDescription] [nvarchar] (1024) null,
		[HomeTooltip] [ntext] null
	) on [primary]

	alter table [dbo].[ess.Menu] with nocheck add 
		constraint [PK_ess.Menu] primary key clustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ModuleLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.ModuleLU] (
		[ID] [tinyint] identity (1, 1) not null,
		[Description] [nvarchar] (50) not null,
		[TemplateElement] [nvarchar] (30) null
	) on [primary]

	alter table [dbo].[ess.ModuleLU] with nocheck add 
		constraint [PK_ess.ModuleLU] primary key clustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.News]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.News] (
		[ID] uniqueidentifier rowguidcol not null,
		[Date] [smalldatetime] not null,
		[Title] [nvarchar] (50) not null,
		[Summary] [nvarchar] (256) not null,
		[Article] [ntext] not null,
		[CapturedBy] [nvarchar] (20) not null,
		[CapturedDate] [smalldatetime] not null,
		[ImageUrl] [nvarchar] (128) null
	) on [primary] textimage_on [primary]

	alter table [dbo].[ess.News] with nocheck add 
		constraint [PK_ess.News] primary key clustered 
		(
			[ID]
		) on [primary] 

	alter table [dbo].[ess.News] add
		constraint [DF_ess.News_ID] default (newid()) for [ID],
		constraint [DF_ess.News_CapturedDate] default (getdate()) for [CapturedDate]

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.NotifyHR]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.NotifyHR] (
		[CompanyNum] [nvarchar] (20) not null,
		[EmployeeNum] [nvarchar] (12) not null,
		[DateNotified] [datetime] not null,
		[Subject] [ntext] null,
		[Description] [ntext] null,
		[Reply] [ntext] null,
		[Status] [nvarchar] (10) null,
		[PathID] [bigint] null 
	) on [primary] textimage_on [primary]

	alter table [dbo].[ess.NotifyHR] add 
		constraint [PK_ess.NotifyHR] primary key clustered 
		(
			[CompanyNum],
			[EmployeeNum],
			[DateNotified]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.PALU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.PALU] (
		[ID] [tinyint] identity (1, 1) not null,
		[PostActionType] [nvarchar] (50) not null
	) on [primary]

	alter table [dbo].[ess.PALU] add 
		constraint [PK_ess.PALU] primary key nonclustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Path]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.Path] (
		[ID] [bigint] identity (1, 1) not null,
		[WFLUID] [tinyint] not null,
		[Summary] [nvarchar] (50) null,
		[ActionID] [tinyint] null,
		[ActionDate] [datetime] null,
		[StatusID] [tinyint] null,
		[PAID] [tinyint] null,
		[UserEmail] [nvarchar] (80) null,
		[UserCell] [nvarchar] (50) null,
		[WFID] [smallint] null,
		[Actioner] [nvarchar] (100) null,
		[ActionerCompanyNum] [nvarchar] (20) null,
		[ActionerEmployeeNum] [nvarchar] (12) null,
		[ActionerUsername] [nvarchar] (20) null,
		[ActionedBy] [nvarchar] (100) null,
		[ActionedByCompNum] [nvarchar] (20) null,
		[ActionedByEmpNum] [nvarchar] (12) null,
		[ActionedByUsername] [nvarchar] (20) null,
		[EmailCC] [nvarchar] (25) null,
		[EmailBCC] [nvarchar] (25) null,
		[SMSCC] [nvarchar] (25) null,
		[EmailOrigCC] [nvarchar] (25) null,
		[EmailOrigBCC] [nvarchar] (25) null,
		[SMSOrigCC] [nvarchar] (25) null,
		[EmailActCC] [nvarchar] (25) null,
		[EmailActBCC] [nvarchar] (25) null,
		[SMSActCC] [nvarchar] (25) null,
		[Originator] [nvarchar] (100) null,
		[OriginatorCompanyNum] [nvarchar] (20) null,
		[OriginatorEmployeeNum] [nvarchar] (12) null,
		[OriginatorUsername] [nvarchar] (20) null,
		[OriginatorDate] [datetime] null,
		[OriginatorEmail] [nvarchar] (80) null,
		[OriginatorCell] [nvarchar] (50) null,
		[PrevActioner] [nvarchar] (100) null,
		[PrevActionerCompNum] [nvarchar] (20) null,
		[PrevActionerEmpNum] [nvarchar] (12) null,
		[PrevActionerUsername] [nvarchar] (20) null,
		[Frozen] [bit] null,
		[XMLTag] [nvarchar] (512) null
	) on [primary]

	alter table [dbo].[ess.Path] add 
		constraint [PK_ess.Path] primary key nonclustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Policy]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.Policy] (
		[ID] [tinyint] identity (1, 1) not null,
		[GroupID] [tinyint] not null,
		[SetupAssemblyID] [tinyint] not null,
		[SetupDataTypeID] [tinyint] not null,
		[AssemblyID] [tinyint] not null,
		[DataTypeID] [tinyint] not null,
		[Key] [nvarchar] (25) not null,
		[Name] [nvarchar] (25) null,
		[Label] [nvarchar] (128) null,
		[Description] [ntext] not null,
		[Visible] [bit] not null constraint [DF_ess.Policy_Visible] default (0),
		[Editable] [bit] not null constraint [DF_ess.Policy_Editable] default (0),
		[Required] [bit] not null constraint [DF_ess.Policy_Required] default (0),
		[YesNo] [bit] not null constraint [DF_ess.Policy_YesNo] default (0),
		[Int] [int] null,
		[IntMin] [int] null,
		[IntMax] [int] null,
		[Dec] [float] null,
		[DecMin] [float] null,
		[DecMax] [float] null,
		[Date] [datetime] null,
		[DateMin] [datetime] null,
		[DateMax] [datetime] null,
		[Text] [ntext] null,
		[GUID] [uniqueidentifier] null,
		[Object] [image] null,
		[LookupTable] [nvarchar] (75) null,
		[LookupText] [nvarchar] (75) null,
		[LookupValue] [nvarchar] (75) null,
		[LookupFilter] [ntext] null,
		[Validation] [ntext] null,
		[Cascade] [bit] not null constraint [DF_ess.Policy_Cascade] default (0)
	) on [primary]

	alter table [dbo].[ess.Policy] add 
		constraint [PK_ess.Policy] primary key nonclustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.PolicyGroups]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.PolicyGroups] (
		[ID] [tinyint] identity (1, 1) not null,
		[Name] [nvarchar] (75) not null,
		[Description] [ntext] null
	) on [primary]

	alter table [dbo].[ess.PolicyGroups] add 
		constraint [PK_ess.PolicyGroups] primary key nonclustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.PolicyItems]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.PolicyItems] (
		[ID] [smallint] identity (1, 1) not null,
		[PolicyID] [tinyint] not null,
		[Template] [nvarchar] (10) not null,
		[Visible] [bit] not null constraint [DF_ess.PolicyItems_Visible] default (0),
		[Editable] [bit] not null constraint [DF_ess.PolicyItems_Editable] default (0),
		[Required] [bit] not null constraint [DF_ess.PolicyItems_Required] default (0),
		[YesNo] [bit] not null constraint [DF_ess.PolicyItems_YesNo] default (0),
		[Int] [int] null,
		[IntMin] [int] null,
		[IntMax] [int] null,
		[Dec] [float] null,
		[DecMin] [float] null,
		[DecMax] [float] null,
		[Date] [datetime] null,
		[DateMin] [datetime] null,
		[DateMax] [datetime] null,
		[Text] [ntext] null,
		[GUID] [uniqueidentifier] null,
		[Object] [image] null,
		[LookupTable] [nvarchar] (75) null,
		[LookupText] [nvarchar] (75) null,
		[LookupValue] [nvarchar] (75) null,
		[LookupFilter] [ntext] null,
		[Validation] [ntext] null
	) on [primary]

	alter table [dbo].[ess.PolicyItems] add 
		constraint [PK_ess.PolicyItems] primary key nonclustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Properties]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.Properties] (
		[ID] [tinyint] identity (1, 1) not null,
		[LicenseKey] [nvarchar] (29) not null,
		[AppVersion] [nvarchar] (15) not null,
		[DBVersion] [nvarchar] (15) not null
	) on [primary]

	alter table [dbo].[ess.Properties] add 
		constraint [PK_ess.Properties] primary key nonclustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where id = object_id(N'[ess.QSubjects]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.QSubjects] (
		[CompanyNum] [nvarchar] (20) not null,
		[EmployeeNum] [nvarchar] (12) not null,
		[StartDate] [datetime] not null,
		[Subject] [nvarchar] (75) not null,
		[MarkReceived] [nvarchar] (10) null,
		[Grading] [nvarchar] (10) null,
		[Grade] [nvarchar] (10) null
	) on [primary]

	alter table [dbo].[ess.QSubjects] with nocheck add 
		constraint [PK_ess.QSubjects] primary key clustered 
		(
			[CompanyNum],
			[EmployeeNum],
			[StartDate],
			[Subject]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ReportsLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.ReportsLU] (
		[ID] smallint identity (1, 1) not null,
		[Title] [nvarchar] (50) not null,
		[Path] [nvarchar] (128) not null,
		[SQL] [ntext] null
	) on [primary]

	alter table [dbo].[ess.ReportsLU] with nocheck add
		constraint [PK_ess.ReportsLU] primary key clustered
		(
			[ID]
		) on [primary]

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Users.ReportsLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.Users.ReportsLU] (
		[ID] smallint identity (1, 1) not null,
		[ModuleID] [tinyint] null,
		[Template] [nvarchar](10) null,
		[Name] [nvarchar](64) not null,
		[ReportUri] [nvarchar](128) not null,
		[SQL] [ntext] null,
		[CreatedBy] [nvarchar](20) not null,
		[CreatedOn] [datetime] not null
	) on [primary]

	alter table [dbo].[ess.Users.ReportsLU] with nocheck add
		constraint [PK_ess.Users.ReportsLU] primary key clustered
		(
			[ID]
		) on [primary]

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[FK_ess.Users.ReportsLU_ess.ModuleLU]') and objectproperty([ID], N'IsForeignKey') = 1)
begin

	alter table [dbo].[ess.Users.ReportsLU] with check add constraint [FK_ess.Users.ReportsLU_ess.ModuleLU] foreign key([ModuleID])
	references [dbo].[ess.ModuleLU]([ID])
	on update cascade
	on delete cascade

	alter table [dbo].[ess.Users.ReportsLU] check constraint [FK_ess.Users.ReportsLU_ess.ModuleLU]

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[FK_ess.Users.ReportsLU_UserGroupTemplates]') and objectproperty([ID], N'IsForeignKey') = 1)
begin

	alter table [dbo].[ess.Users.ReportsLU] with check add constraint [FK_ess.Users.ReportsLU_UserGroupTemplates] foreign key([Template])
	references [dbo].[UserGroupTemplates]([Code])
	on update cascade
	on delete cascade

	alter table [dbo].[ess.Users.ReportsLU] check constraint [FK_ess.Users.ReportsLU_UserGroupTemplates]

end
GO


if not exists (select [id] from [sysobjects] where [id] = object_id(N'[FK_ess.Users.ReportsLU_Users]') and objectproperty([ID], N'IsForeignKey') = 1)
begin

	alter table [dbo].[ess.Users.ReportsLU] with check add constraint [FK_ess.Users.ReportsLU_Users] foreign key([CreatedBy])
	references [dbo].[Users]([Username])
	on update cascade
	on delete cascade

	alter table [dbo].[ess.Users.ReportsLU] check constraint [FK_ess.Users.ReportsLU_Users]

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.RoutingRules]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.RoutingRules] (
		[ID] [bigint] identity (1, 1) not null,
		[CompanyNum] [nvarchar] (20) not null,
		[EmployeeNum] [nvarchar] (12) not null,
		[WFLUID] [tinyint] null,
		[PathID] [bigint] null,
		[RouteToCompNum] [nvarchar] (20) not null,
		[RouteToEmpNum] [nvarchar] (12) not null,
		[From] [datetime] null,
		[Until] [datetime] null,
		[OnceOff] [bit] not null,
		[Description] [nvarchar] (1024) null,
		[CapturedBy] [nvarchar] (20) not null,
		[CapturedOn] [datetime] not null
	) on [primary]

	alter table [dbo].[ess.RoutingRules] with nocheck add 
		constraint [PK_ess.RoutingRules] primary key clustered 
		(
			[ID]
		) on [primary] 

	alter table [dbo].[ess.RoutingRules] add 
		constraint [DF_ess.RoutingRules_OnceOff] default (0) for [OnceOff]

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.StatusLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.StatusLU] (
		[ID] [tinyint] identity (1, 1) not null,
		[Status] [nvarchar] (50) not null
	) on [primary]

	alter table [dbo].[ess.StatusLU] add 
		constraint [PK_ess.StatusLU] primary key nonclustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WF]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.WF] (
		[ID] [smallint] identity (1, 1) not null,
		[ActionID] [tinyint] not null,
		[StatusID] [tinyint] not null,
		[WFLUID] [tinyint] not null,
		[PostActID] [smallint] null,
		[PAID] [tinyint] not null,
		[EmailID] [tinyint] null,
		[SMSID] [tinyint] null,
		[EmailCC] [nvarchar] (25) null,
		[EmailBCC] [nvarchar] (25) null,
		[SMSCC] [nvarchar] (25) null,
		[EmailOrigID] [tinyint] null,
		[SMSOrigID] [tinyint] null,
		[EmailOrigCC] [nvarchar] (25) null,
		[EmailOrigBCC] [nvarchar] (25) null,
		[SMSOrigCC] [nvarchar] (25) null,
		[EmailActID] [tinyint] null,
		[SMSActID] [tinyint] null,
		[EmailActCC] [nvarchar] (25) null,
		[EmailActBCC] [nvarchar] (25) null,
		[SMSActCC] [nvarchar] (25) null,
		[SkipNonExt] [bit] not null,
		[ExecNonProc] [bit] not null,
		[AccessibleBy] [nvarchar] (25) null,
		[PostActProc] [nvarchar] (512) null,
		[TaskIDProc] [nvarchar] (512) null,
		[LockedBy] [nvarchar] (100) null,
		[SkipCondition] [bit] null
	) on [primary]

	alter table [dbo].[ess.WF] add 
		constraint [PK_ess.WF] primary key clustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFAppType]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.WFAppType] (
		[ID] [tinyint] identity (1, 1) not null,
		[AppType] [nvarchar] (50) not null,
		[WFType] [nvarchar] (50) not null,
		[WFName] [nvarchar] (50) not null,
		[StopBalExc] [bit] null,
		[MaxNegative] [real] null
	) on [primary]

	alter table [dbo].[ess.WFAppType] add 
		constraint [PK_ess.WFAppType] primary key nonclustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFAppTypeLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.WFAppTypeLU] (
		[ID] [tinyint] identity (1, 1) not null,
		[AppType] [nvarchar] (50) not null
	) on [primary]

	alter table [dbo].[ess.WFAppTypeLU] add 
		constraint [PK_ess.WFAppTypeLU] primary key nonclustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFAudit]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.WFAudit] (
		[ID] [bigint] identity (1, 1) not null,
		[PathID] [bigint] null,
		[WFLUID] [tinyint] not null,
		[WFName] [nvarchar] (50) null,
		[WFType] [nvarchar] (50) null,
		[Summary] [nvarchar] (50) null,
		[ActionID] [tinyint] null,
		[ActionType] [nvarchar] (50) null,
		[ActionDate] [datetime] null,
		[StatusID] [tinyint] null,
		[StatusType] [nvarchar] (50) null,
		[PAID] [tinyint] null,
		[PostActType] [nvarchar] (50) null,
		[UserEmail] [nvarchar] (80) null,
		[UserCell] [nvarchar] (50) null,
		[WFID] [smallint] null,
		[Actioner] [nvarchar] (100) null,
		[ActionerCompanyNum] [nvarchar] (20) null,
		[ActionerEmployeeNum] [nvarchar] (12) null,
		[ActionerUsername] [nvarchar] (20) null,
		[ActionedBy] [nvarchar] (100) null,
		[ActionedByCompNum] [nvarchar] (20) null,
		[ActionedByEmpNum] [nvarchar] (12) null,
		[ActionedByUsername] [nvarchar] (20) null,
		[EmailCC] [nvarchar] (25) null,
		[EmailBCC] [nvarchar] (25) null,
		[SMSCC] [nvarchar] (25) null,
		[EmailOrigCC] [nvarchar] (25) null,
		[EmailOrigBCC] [nvarchar] (25) null,
		[SMSOrigCC] [nvarchar] (25) null,
		[EmailActCC] [nvarchar] (25) null,
		[EmailActBCC] [nvarchar] (25) null,
		[SMSActCC] [nvarchar] (25) null,
		[Originator] [nvarchar] (100) null,
		[OriginatorCompanyNum] [nvarchar] (20) null,
		[OriginatorEmployeeNum] [nvarchar] (12) null,
		[OriginatorUsername] [nvarchar] (20) null,
		[OriginatorDate] [datetime] null,
		[OriginatorEmail] [nvarchar] (80) null,
		[OriginatorCell] [nvarchar] (50) null,
		[PrevActioner] [nvarchar] (100) null,
		[PrevActionerCompNum] [nvarchar] (20) null,
		[PrevActionerEmpNum] [nvarchar] (12) null,
		[PrevActionerUsername] [nvarchar] (20) null
	) on [primary]

	alter table [dbo].[ess.WFAudit] add 
		constraint [PK_ess.WFAudit] primary key clustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where id = object_id(N'[ess.WFConditions]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.WFConditions] (
		[ID] [bigint] identity (1, 1) not null,
		[WFID] [smallint] not null,
		[ConditionID] [int] not null,
		[ClauseID] [bigint] not null,
		[ReportsToType] [nvarchar] (35) null,
		[CompanyNum] [nvarchar] (20) null,
		[EmployeeNum] [nvarchar] (12) null
	) on [primary]

	alter table [dbo].[ess.WFConditions] with nocheck add 
		constraint [PK_ess.WFConditions] primary key clustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFLinkedDepts]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.WFLinkedDepts] (
		[ID] [smallint] identity (1, 1) not null,
		[WFLUID] [tinyint] not null,
		[DeptName] [nvarchar] (50) not null
	) on [primary]

	alter table [dbo].[ess.WFLinkedDepts] with nocheck add 
		constraint [PK_ess.WFLinkedDepts] primary key clustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.WFLU] (
		[ID] [tinyint] identity (1, 1) not null,
		[WFName] [nvarchar] (50) not null,
		[WFType] [nvarchar] (50) not null
	) on [primary]

	alter table [dbo].[ess.WFLU] add 
		constraint [PK_ess.WFLU] primary key clustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFProcLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.WFProcLU] (
		[ID] [tinyint] identity (1, 1) not null,
		[TypeID] [tinyint] not null,
		[Proc] [nvarchar] (512) not null
	) on [primary]

	alter table [dbo].[ess.WFProcLU] add 
		constraint [PK_ess.WFProcLU] primary key clustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFRemarks]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.WFRemarks] (
		[ID] [bigint] identity (1, 1) not null,
		[CompanyNum] [nvarchar] (20) not null,
		[EmployeeNum] [nvarchar] (12) not null,
		[CaptureDate] [datetime] not null,
		[Remarks] [ntext] not null,
		[PathID] [bigint] not null
	) on [primary] textimage_on [primary]

	alter table [dbo].[ess.WFRemarks] add 
		constraint [PK_ess.WFRemarks] primary key clustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFTaskLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.WFTaskLU] (
		[ID] [tinyint] identity (1, 1) not null,
		[TypeID] [tinyint] not null,
		[Task] [nvarchar] (512) not null
	) on [primary]

	alter table [dbo].[ess.WFTaskLU] add 
		constraint [PK_ess.WFTaskLU] primary key clustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFTypeLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ess.WFTypeLU] (
		[ID] [tinyint] identity (1, 1) not null,
		[WFType] [nvarchar] (50) not null,
		[Tablename] [nvarchar] (128) null
	) on [primary]

	alter table [dbo].[ess.WFTypeLU] add 
		constraint [PK_ess.WFTypeLU] primary key clustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[GroupTypeLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[GroupTypeLU] (
		[ID] [tinyint] identity (1, 1) not null,
		[TypeID] [tinyint] not null,
		[Description] [nvarchar] (25) not null
	) on [primary]

	alter table [dbo].[GroupTypeLU] add
		constraint [PK_GroupTypeLU] primary key clustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[MessagingLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[MessagingLU] (
		[ID] [tinyint] identity (1, 1) not null,
		[Type] [nvarchar] (50) not null,
		[Body] [nvarchar] (512) not null
	) on [primary]

	alter table [dbo].[MessagingLU] with nocheck add 
		constraint [PK_MessagingLU] primary key clustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[MessageResults]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[MessageResults] (
		[ID] [uniqueidentifier] not null,
		[Date] [datetime] not null,
		[StatusID] [smallint] not null,
		[MobileNum] [nvarchar] (16) not null,
		[Message] [ntext] not null
	) on [primary] textimage_on [primary]

	alter table [dbo].[MessageResults] with nocheck add 
		constraint [PK_MessageResults] primary key clustered 
		(
			[ID]
		) on [primary]

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[ParameterLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[ParameterLU] (
		[ID] [smallint] identity (1, 1) not null,
		[Tablename] [nvarchar] (128) not null,
		[Type] [nvarchar] (50) not null,
		[Index] [tinyint] not null,
		[Value] [nvarchar] (128) null
	) on [primary]

	alter table [dbo].[ParameterLU] with nocheck add 
		constraint [PK_ParameterLU] primary key clustered 
		(
			[ID]
		) on [primary] 

end
GO

if not exists (select [id] from [sysobjects] where [id] = object_id(N'[SQLExecute]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	create table [dbo].[SQLExecute] (
		[ID] uniqueidentifier rowguidcol  not null,
		[CompanyNum] [nvarchar] (20) not null,
		[EmployeeNum] [nvarchar] (12) not null,
		[EffectiveDate] [datetime] not null,
		[SQLQuery] [nvarchar] (4000) not null,
		[SQLWhere] [nvarchar] (1024) null 
	) on [primary]

	alter table [dbo].[SQLExecute] with nocheck add 
		constraint [PK_SQLExecute] primary key clustered 
		(
			[ID]
		) on [primary] 

	alter table [dbo].[SQLExecute] add 
		constraint [DF_SQLExecute_ID] default (newid()) for [ID]

end
GO

/**********************************************************************************************************

								*** v6.0.74 (Drop & Create user functions) ***

***********************************************************************************************************/
if exists (select [id] from [sysobjects] where id = object_id(N'[GetAltTasks]') and xtype in (N'FN', N'IF', N'TF'))
	drop function [dbo].[GetAltTasks]
GO

set quoted_identifier on 
GO

set ansi_nulls on 
GO

create function GetAltTasks(@CompNum nvarchar(20), @EmpNum nvarchar(12), @OrigCompNum nvarchar(20), @OrigEmpNum nvarchar(12), @ID smallint)
returns bit
as
begin

	declare @bIDList bit
	declare @Accessible nvarchar(25)
	declare @IDChar tinyint

	set @bIDList = 0

	select @Accessible = [AccessibleBy] from [ess.WF] where [ID] = @ID

	if (not @Accessible is null)
	begin

		if (len(@Accessible) > 0)
		begin

			while(len(@Accessible) > 0)
			begin

				set @IDChar = cast(ascii(substring(@Accessible, 1, 1)) as tinyint)

				if (exists(select [ReportsToType] from [ReportsTo] where ([CompanyNum] = @OrigCompNum) and ([EmployeeNum] = @OrigEmpNum) and ([ReportToCompNum] = @CompNum) and ([ReportToEmpNum] = @EmpNum) and ([ReportsToType] = (select [ReportsToType] from [ess.ActionLU] where [ID] = @IDChar))))
				begin

					set @Accessible = ''

					set @bIDList = 1

				end

				if (len(@Accessible) > 1)
					set @Accessible = substring(@Accessible, 2, len(@Accessible) - 1)
				else
					set @Accessible = ''

			end

		end

	end

	return(@bIDList)

end
GO

set quoted_identifier off 
GO

set ansi_nulls on 
GO

/**********************************************************************************************************

							*** v6.0.74 (Drop & Create stored procedures) ***

***********************************************************************************************************/
set quoted_identifier off 
GO
set ansi_nulls off 
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[SQLExecuteProc]') and objectproperty([id], N'IsProcedure') = 1)
	drop procedure [dbo].[SQLExecuteProc]
GO

create procedure [dbo].[SQLExecuteProc]
as

declare @CompanyNum nvarchar(20),
		@curDate datetime,
		@EmployeeNum nvarchar(12),
		@iCount bigint,
		@ID nvarchar(36),
		@iLoop bigint,
		@rvalue int,
		@SQLExec nvarchar(4000),
		@SQLQuery nvarchar(4000),
		@SQLWhere nvarchar(1024)

declare @SQLExecute table
(
	[ID] bigint identity (1, 1) not null,
	[tID] uniqueidentifier rowguidcol not null,
	[CompanyNum] [nvarchar] (20) not null,
	[EmployeeNum] [nvarchar] (12) not null,
	[SQLQuery] [nvarchar] (4000) not null,
	[SQLWhere] [nvarchar] (1024) null
)

set @curDate = dateadd(day, 1, cast(convert(nvarchar(10), getdate(), 120) + ' 00:00:00' as datetime))

insert into @SQLExecute([tID], [CompanyNum], [EmployeeNum], [SQLQuery], [SQLWhere])
select [ID], [CompanyNum], [EmployeeNum], [SQLQuery], [SQLWhere] from [SQLExecute] where ([EffectiveDate] < @curDate)

set @iLoop = 1

select @iCount = count([ID]) from @SQLExecute

while (@iLoop <= @iCount)
begin

	select @ID = cast([ID] as nvarchar(36)), @CompanyNum = [CompanyNum], @EmployeeNum = [EmployeeNum], @SQLQuery = [SQLQuery], @SQLWhere = [SQLWhere] from @SQLExecute where ([ID] = @iLoop)

	set @SQLQuery = replace(@SQLQuery, 'update [Personnel] set [ShiftType] = ', 'update [Personnel1] set [ShiftType] = ')

	if (@SQLWhere is null)
		set @SQLWhere = ''
	else
		set @SQLWhere = @SQLWhere + ' and '

	set @SQLExec = @SQLQuery + ' where ' + @SQLWhere + '([CompanyNum] = ''' + @CompanyNum + ''') and ([EmployeeNum] = ''' + @EmployeeNum + ''')'

	exec @rvalue = sp_executesql @SQLExec

	set @iLoop = @iLoop + 1

end

delete from [SQLExecute] where ([EffectiveDate] < @curDate)
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[ess.BasicCPath]') and objectproperty([id], N'IsProcedure') = 1)
	drop procedure [ess.BasicCPath]
GO

create procedure [dbo].[ess.BasicCPath] @PathID bigint, @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @StartDate datetime
as

update [PersonnelHistoryLog] set [PathID] = @PathID where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [ActionDate] = @StartDate and [PathID] is null

update [ess.Path] set [Summary] = 'Basic Conditions' where [id] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[ess.BasicCApprove]') and objectproperty([id], N'IsProcedure') = 1)
	drop procedure [ess.BasicCApprove]
GO

create procedure [dbo].[ess.BasicCApprove] @PathID bigint, @StartDate datetime
as

update [PersonnelHistoryLog] set [Status] = 'HR Granted' where [PathID] = @PathID

declare @iCount bigint,
		@iLoop bigint,
		@SQLExec nvarchar(4000)

declare @PersonnelHistoryLog table
(
	[id] bigint identity (1, 1) not null,
	[CompanyNum] [nvarchar] (20) not null,
	[EmployeeNum] [nvarchar] (12) not null,
	[ActionDescription] [nvarchar] (50) not null,
	[ActionDate] [datetime] not null,
	[ChangedTo] [nvarchar] (50) null,
	[EffectiveFrom] [datetime] null,
	[PathQuery] [nvarchar] (512) null
)

insert into @PersonnelHistoryLog([CompanyNum], [EmployeeNum], [ActionDescription], [ActionDate], [ChangedTo], [EffectiveFrom], [PathQuery])
select [CompanyNum], [EmployeeNum], [ActionDescription], [ActionDate], [ChangedTo], [EffectiveFrom], [PathQuery] from [PersonnelHistoryLog] where ([PathID] = @PathID)

set @iLoop = 1

select @iCount = count([id]) from @PersonnelHistoryLog

while (@iLoop <= @iCount)
begin

	select @SQLExec = 'insert into [SQLExecute]([CompanyNum], [EmployeeNum], [EffectiveDate], [SQLQuery]) values(' +
					  '''' + [CompanyNum] + ''', ''' + [EmployeeNum] + ''', ''' + convert(nvarchar(19), [EffectiveFrom], 120) + ''', ''' + replace([PathQuery], '''', '''''') + ''')' from @PersonnelHistoryLog where ([id] = @iLoop)

	exec sp_executesql @SQLExec

	set @iLoop = @iLoop + 1

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[ess.BasicCReject]') and objectproperty([id], N'IsProcedure') = 1)
	drop procedure [ess.BasicCReject]
GO

create procedure [dbo].[ess.BasicCReject] @PathID bigint, @StartDate datetime
as

update [PersonnelHistoryLog] set [Status] = 'HR Declined' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ExecuteProc]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ExecuteProc]
GO

create procedure [dbo].[ExecuteProc]
as

declare @iCount bigint,
	@iloop bigint,
	@ProcID uniqueidentifier,
	@SQLExec nvarchar(4000),
	@SQLData nvarchar(4000),
	@SQLVariable nvarchar(4000),
	@SQLValue nvarchar(4000)

declare @SQLExecute table
(
	[ID] [bigint] identity (1, 1) not null,
	[ProcID] [uniqueidentifier] not null,
	[CompanyNum] [nvarchar] (20) not null,
	[EmployeeNum] [nvarchar] (12) not null,
	[SQLExec] ntext not null,
	[SQLData] ntext null
)

insert into @SQLExecute select [ID], [CompanyNum], [EmployeeNum], [SQLExec], isnull(cast([SQLData] as nvarchar(4000)), '') from [ess.SQLExecute] where ([ExecuteOn] < getdate() and [Executed] = 0 and [Status] = 'HR Granted') order by [ExecuteOn]

set @iLoop = 1

select @iCount = count([ID]) from @SQLExecute

while (@iLoop <= @iCount)
begin

	select @ProcID = [ProcID], @SQLExec = cast([SQLExec] as nvarchar(4000)), @SQLData = cast([SQLData] as nvarchar(4000)) from @SQLExecute where ([ID] = @iLoop)

	while (len(@SQLData) > 0)
	begin

		set @SQLVariable = substring(@SQLData, 1, charindex('>', @SQLData))

		set @SQLData = replace(@SQLData, @SQLVariable, '')

		set @SQLVariable = substring(@SQLVariable, 2, len(@SQLVariable) - 2)

		set @SQLValue = substring(@SQLVariable, charindex('=', @SQLVariable) + 1, len(@SQLVariable) - charindex('=', @SQLVariable))

		set @SQLVariable = replace(@SQLVariable, '=' + @SQLValue, '')

		set @SQLExec = replace(@SQLExec, '<' + @SQLVariable + '>', @SQLValue)

	end

	exec sp_executesql @SQLExec

	update [ess.SQLExecute] set [Executed] = 1 where ([ID] = @ProcID)

	set @iLoop = @iLoop + 1

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.TerminationPath]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.TerminationPath]
GO

create procedure [dbo].[ess.TerminationPath] @PathID bigint, @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @StartDate datetime
as

update [Personnel] set [PathID] = @PathID where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [Status] = 'New' and [PathID] is null

update [ess.SQLExecute] set [PathID] = @PathID where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [Status] = 'New' and [PathID] is null

update [ess.Path] set [Summary] = 'Termination' where [ID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.TransferPath]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.TransferPath]
GO

create procedure [dbo].[ess.TransferPath] @PathID bigint, @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @StartDate datetime
as

update [Personnel] set [PathID] = @PathID where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [Status] = 'New' and [PathID] is null

update [ess.SQLExecute] set [PathID] = @PathID where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [Status] = 'New' and [PathID] is null

update [ess.Path] set [Summary] = 'Transfer' where [ID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.TimeHRAccept]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.TimeHRAccept]
GO

create procedure [dbo].[ess.TimeHRAccept] @PathID bigint, @StartDate datetime
as

update [Timesheets] set [Status] = 'HR Granted' where [PathID] = @PathID

declare @iCount bigint,
		@iLoop bigint,
		@SQLExec nvarchar(2048)

declare @TimesheetSetup table
(
	[ID] bigint identity (1, 1) not null,
	[SQLUpdate] [nvarchar] (2048) null
)

insert into @TimesheetSetup([SQLUpdate])
select [SQLUpdate] from [TimesheetSetup] where (not [SQLUpdate] is null)

set @iLoop = 1

select @iCount = count([ID]) from @TimesheetSetup

while (@iLoop <= @iCount)
begin

	select @SQLExec = [SQLUpdate] from @TimesheetSetup where ([ID] = @iLoop)

	exec sp_executesql @SQLExec

	set @iLoop = @iLoop + 1

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.TimeHRReject]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.TimeHRReject]
GO

create procedure [dbo].[ess.TimeHRReject] @PathID bigint, @StartDate datetime
as

update [Timesheets] set [Status] = 'HR Declined' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.TimeLMAccept]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.TimeLMAccept]
GO

create procedure [dbo].[ess.TimeLMAccept] @PathID bigint, @StartDate datetime
as

update [Timesheets] set [Status] = 'HOD Accepted' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.TimeLMReject]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.TimeLMReject]
GO

create procedure [dbo].[ess.TimeLMReject] @PathID bigint, @StartDate datetime
as

update [Timesheets] set [Status] = 'HOD Declined' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.TimePath]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.TimePath]
GO

create procedure [dbo].[ess.TimePath] @PathID bigint, @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @StartDate datetime
as

update [Timesheets] set [PathID] = @PathID where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [Status] = 'New' and [PathID] is null

update [ess.Path] set [Summary] = 'Timesheet' where [ID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.CancelLeave]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.CancelLeave]
GO

create procedure [dbo].[ess.CancelLeave] @PathID bigint, @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @StartDate datetime
as

declare @PathIDDel bigint

update [ess.Path] set [Summary] = 'Leave Cancellation' where [ID] = @PathID

select @PathIDDel = [PathID] from [Leave] where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [StartDate] = @StartDate

update [Leave] set [PathID] = @PathID where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [StartDate] = @StartDate and not [PathID] is null

if (exists(select [ID] from [ess.Path] where [ID] = @PathIDDel))
	delete from [ess.Path] where [ID] = @PathIDDel
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.CancelLoan]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.CancelLoan]
GO

create procedure [dbo].[ess.CancelLoan] @PathID bigint, @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @StartDate datetime
as

declare @PathIDDel int

update [ess.Path] set [Summary] = 'Loan Cancellation' where [ID] = @PathID

select @PathIDDel = [PathID] from [Loan] where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [LoanDate] = @StartDate

update [Loan] set [PathID] = @PathID where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [LoanDate] = @StartDate and not [PathID] is null

if (exists(select [ID] from [ess.Path] where [ID] = @PathIDDel))
	delete from [ess.Path] where [ID] = @PathIDDel
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.CancelStore]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.CancelStore]
GO

create procedure [dbo].[ess.CancelStore] @PathID bigint, @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @StartDate datetime
as

declare @PathIDDel int

update [ess.Path] set [Summary] = 'Stores Cancellation' where [ID] = @PathID

select @PathIDDel = [PathID] from [StoreIssued] where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [IssueDate] = @StartDate

update [StoreIssued] set [PathID] = @PathID where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [PathID] = @PathIDDel and not [PathID] is null

if (exists(select [ID] from [ess.Path] where [ID] = @PathIDDel))
	delete from [ess.Path] where [ID] = @PathIDDel
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.CancelTraining]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.CancelTraining]
GO

create procedure [dbo].[ess.CancelTraining] @PathID bigint, @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @StartDate datetime
as

declare @PathIDDel int

update [ess.Path] set [Summary] = 'Training Cancellation' where ID = @PathID

select @PathIDDel = [PathID] from [TrainingPlanned] where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [StartDate] = @StartDate

update [TrainingPlanned] set [PathID] = @PathID where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [StartDate] = @StartDate and not [PathID] is null

if (exists(select [ID] from [ess.Path] where [ID] = @PathIDDel))
	delete from [ess.Path] where [ID] = @PathIDDel
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Cascade]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.Cascade]
GO

create procedure [dbo].[ess.Cascade]
as

truncate table [ess.PolicyItems]

declare @iCountPolicy bigint,
		@iLoopPolicy bigint,
		@iCountTemplate bigint,
		@iLoopTemplate bigint,
		@PolicyID tinyint,
		@Template nvarchar(10)

declare @Policy table
(
	[ID] bigint identity (1, 1) not null,
	[PolicyID] [tinyint] not null,
	[Visible] [bit] not null,
	[Editable] [bit] not null,
	[Required] [bit] not null,
	[YesNo] [bit] not null,
	[Int] [int] null,
	[IntMin] [int] null,
	[IntMax] [int] null,
	[Dec] [float] null,
	[DecMin] [float] null,
	[DecMax] [float] null,
	[Date] [datetime] null,
	[DateMin] [datetime] null,
	[DateMax] [datetime] null,
	[Text] [ntext] null,
	[GUID] [uniqueidentifier] null,
	[Object] [image] null,
	[LookupTable] [nvarchar] (75) null,
	[LookupText] [nvarchar] (75) null,
	[LookupValue] [nvarchar] (75) null,
	[LookupFilter] [ntext] null,
	[Validation] [ntext] null
)

declare @Templates table
(
	[ID] bigint identity (1, 1) not null,
	[Code] nvarchar(10) not null
)

insert into @Policy([PolicyID], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation]) select [ID], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation] from [ess.Policy] where ([Cascade] = 1) order by [ID]

insert into @Templates([Code]) select [Code] from [UserGroupTemplates] order by [Code]

set @iLoopPolicy = 1

select @iCountPolicy = count([ID]) from @Policy

select @iCountTemplate = count([ID]) from @Templates

while (@iLoopPolicy <= @iCountPolicy)
begin

	select @PolicyID = [PolicyID] from @Policy where ([ID] = @iLoopPolicy)

	set @iLoopTemplate = 1

	while (@iLoopTemplate <= @iCountTemplate)
	begin

		select @Template = [Code] from @Templates where ([ID] = @iLoopTemplate)

		if not exists(select top 1 [id] from [ess.PolicyItems] where ([PolicyID] = @PolicyID and [Template] = @Template))
			insert into [ess.PolicyItems]([PolicyID], [Template], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation]) select @PolicyID, @Template, [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation] from [ess.Policy] where ([ID] = @PolicyID)

		set @iLoopTemplate = @iLoopTemplate + 1

	end

	set @iLoopPolicy = @iLoopPolicy + 1

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ChangePath]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.ChangePath]
GO

create procedure [dbo].[ess.ChangePath] @PathID bigint, @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @StartDate datetime
as

update [ess.Change] set [PathID] = @PathID where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [NotifyDate] = @StartDate and [PathID] is null

update [ess.Path] set [Summary] = 'Notification' where [ID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ClaimHRAccept]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.ClaimHRAccept]
GO

create procedure [dbo].[ess.ClaimHRAccept] @PathID bigint, @StartDate datetime
as

update [Claims] set [Status] = 'HR Granted' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ClaimHRReject]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.ClaimHRReject]
GO

create procedure [dbo].[ess.ClaimHRReject] @PathID bigint, @StartDate datetime
as

update [Claims] set [Status] = 'HR Declined' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ClaimLMAccept]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.ClaimLMAccept]
GO

create procedure [dbo].[ess.ClaimLMAccept] @PathID bigint, @StartDate datetime
as

update [Claims] set [Status] = 'HOD Accepted' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ClaimLMReject]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.ClaimLMReject]
GO

create procedure [dbo].[ess.ClaimLMReject] @PathID bigint, @StartDate datetime
as

update [Claims] set [Status] = 'HOD Declined' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ClaimPath]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.ClaimPath]
GO

create procedure [dbo].[ess.ClaimPath] @PathID bigint, @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @StartDate datetime
as

declare @ClaimType nvarchar(25)

update [Claims] set [PathID] = @PathID where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [Date] = @StartDate and [Status] = 'New' and [PathID] is null

select @ClaimType = [Type] from [Claims] where [PathID] = @PathID

update [ess.Path] set [Summary] = @ClaimType where [ID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.FreezePath]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.FreezePath]
GO

create procedure [dbo].[ess.FreezePath] @PathID bigint, @StartDate datetime
as

update [ess.Path] set [Frozen] = 1 where [ID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.LeaveCancel]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [dbo].[ess.LeaveCancel]
GO

create procedure [dbo].[ess.LeaveCancel] @PathID bigint, @StartDate datetime
as

declare @delLeave bit
declare @pTemplate as nvarchar(10)

set @delLeave = null
set @pTemplate = null

select @pTemplate = [TemplateCode] from [Leave] where [PathID] = @PathID

if exists (select [ID] from [ess.PolicyItems] where ([PolicyID] = (select top 1 [ID] from [ess.Policy] where ([GroupID] = 8 and [Key] = 'DeleteCancelled')) and [Template] = @pTemplate))
begin

	select @delLeave = [YesNo] from [ess.PolicyItems] where ([PolicyID] = (select top 1 [ID] from [ess.Policy] where ([GroupID] = 8 and [Key] = 'DeleteCancelled')) and [Template] = @pTemplate)
	
	if (@delLeave is null)
		select @delLeave = [YesNo] from [ess.Policy] where ([GroupID] = 8 and [Key] = 'DeleteCancelled')

end
else
begin

	select @delLeave = [YesNo] from [ess.Policy] where ([GroupID] = 8 and [Key] = 'DeleteCancelled')

end

if (@delLeave is null)
	set @delLeave = 0

if (@delLeave = 0)
	update [Leave] set [LeaveStatus] = 'Cancelled' where [PathID] = @PathID

if (@delLeave = 1)
	update [Leave] set [LeaveStatus] = 'Delete' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.TerminationHRAccept]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.TerminationHRAccept]
GO

create procedure [dbo].[ess.TerminationHRAccept] @PathID bigint, @StartDate datetime
as

update [ess.SQLExecute] set [Status] = 'HR Granted' where ([PathID] = @PathID)

exec ExecuteProc
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.TransferHRAccept]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.TransferHRAccept]
GO

create procedure [dbo].[ess.TransferHRAccept] @PathID bigint, @StartDate datetime
as

update [ess.SQLExecute] set [Status] = 'HR Granted' where ([PathID] = @PathID)

exec ExecuteProc
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.TerminationHRReject]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.TerminationHRReject]
GO

create procedure [dbo].[ess.TerminationHRReject] @PathID bigint, @StartDate datetime
as

update [Personnel] set [TerminationDate] = null, [TerminationReason] = null where ([PathID] = @PathID)

delete from [ess.SQLExecute] where ([PathID] = @PathID)
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.TransferHRReject]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.TransferHRReject]
GO

create procedure [dbo].[ess.TransferHRReject] @PathID bigint, @StartDate datetime
as

delete from [ess.SQLExecute] where ([PathID] = @PathID)
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.LeaveHRAccept]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.LeaveHRAccept]
GO

create procedure [dbo].[ess.LeaveHRAccept] @PathID bigint, @StartDate datetime
as

update [Leave] set [LeaveStatus] = 'HR Granted' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.LeaveHRReject]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.LeaveHRReject]
GO

create procedure [dbo].[ess.LeaveHRReject] @PathID bigint, @StartDate datetime
as

declare	@CompanyNum nvarchar(20),
		@EmployeeNum nvarchar(12),
		@StartDate2 datetime,
		@LeaveType nvarchar(50)

select @CompanyNum = [CompanyNum], @EmployeeNum = [EmployeeNum], @StartDate2 = [StartDate], @LeaveType = [LeaveType] from [Leave] where ([PathID] = @PathID)

update [Leave] set [LeaveStatus] = 'HR Declined' where [PathID] = @PathID

delete from [LeaveAdjustments] where ([PathID] = @PathID)

if exists (select [CompanyNum] from [LeaveAdjustments] where ([CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [EffectiveDate] = @StartDate and [LeaveType] = @LeaveType and [AdjustmentType] = 'Adjustment' and [AdjustmentValue] < 0 and [Remarks] like 'ESS: friday leave rule adjustment'))
	delete from [LeaveAdjustments] where ([CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [EffectiveDate] = @StartDate2 and [LeaveType] = @LeaveType and [AdjustmentType] = 'Adjustment' and [AdjustmentValue] < 0 and [Remarks] like 'ESS: friday leave rule adjustment')
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.LeaveLMAccept]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.LeaveLMAccept]
GO

create procedure [dbo].[ess.LeaveLMAccept] @PathID bigint, @StartDate datetime
as

update [Leave] set [LeaveStatus] = 'HOD Accepted' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.LeaveLMReject]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.LeaveLMReject]
GO

create procedure [dbo].[ess.LeaveLMReject] @PathID bigint, @StartDate datetime
as

declare	@CompanyNum nvarchar(20),
		@EmployeeNum nvarchar(12),
		@StartDate2 datetime,
		@LeaveType nvarchar(50)

select @CompanyNum = [CompanyNum], @EmployeeNum = [EmployeeNum], @StartDate2 = [StartDate], @LeaveType = [LeaveType] from [Leave] where ([PathID] = @PathID)

update [Leave] set [LeaveStatus] = 'HOD Declined' where [PathID] = @PathID

delete from [LeaveAdjustments] where ([PathID] = @PathID)

if exists (select [CompanyNum] from [LeaveAdjustments] where ([CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [EffectiveDate] = @StartDate and [LeaveType] = @LeaveType and [AdjustmentType] = 'Adjustment' and [AdjustmentValue] < 0 and [Remarks] like 'ESS: friday leave rule adjustment'))
	delete from [LeaveAdjustments] where ([CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [EffectiveDate] = @StartDate2 and [LeaveType] = @LeaveType and [AdjustmentType] = 'Adjustment' and [AdjustmentValue] < 0 and [Remarks] like 'ESS: friday leave rule adjustment')
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.LeavePath]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.LeavePath]
GO

create procedure [dbo].[ess.LeavePath] @PathID bigint, @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @StartDate datetime
as

declare @leaveType nvarchar(50)

update [Leave] set [PathID] = @PathID where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [StartDate] = @StartDate and [PathID] is null

select @leaveType = [LeaveType] from [Leave] where [PathID] = @PathID

update [ess.Path] set [Summary] = @leaveType where [ID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.LoanCancel]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.LoanCancel]
GO

create procedure [dbo].[ess.LoanCancel] @PathID bigint, @StartDate datetime
as

update [Loan] set [LoanStatus] = 'Cancelled' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.LoanHRAccept]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.LoanHRAccept]
GO

create procedure [dbo].[ess.LoanHRAccept] @PathID bigint, @StartDate datetime
as

update [Loan] set [LoanStatus] = 'HR Granted' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.LoanHRReject]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.LoanHRReject]
GO

create procedure [dbo].[ess.LoanHRReject] @PathID bigint, @StartDate datetime
as

update [Loan] set [LoanStatus] = 'HR Declined' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.LoanLMAccept]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.LoanLMAccept]
GO

create procedure [dbo].[ess.LoanLMAccept] @PathID bigint, @StartDate datetime
as

update [Loan] set [LoanStatus] = 'HOD Accepted' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.LoanLMReject]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.LoanLMReject]
GO

create procedure [dbo].[ess.LoanLMReject] @PathID bigint, @StartDate datetime
as

update [Loan] set [LoanStatus] = 'HOD Declined' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.LoanPath]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.LoanPath]
GO

create procedure [dbo].[ess.LoanPath] @PathID bigint, @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @StartDate datetime
as

update [Loan] set [PathID] = @PathID where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [LoanDate] = @StartDate and [PathID] is null

update [ess.Path] set [Summary] = 'Loan Application' where [ID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.NotifyComplete]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.NotifyComplete]
GO

create procedure [dbo].[ess.NotifyComplete] @PathID bigint, @StartDate datetime
as

update [ess.NotifyHR] set [Status] = 'Completed' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.NotifyPath]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.NotifyPath]
GO

create procedure [dbo].[ess.NotifyPath] @PathID bigint, @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @StartDate datetime
as

update [ess.NotifyHR] set [PathID] = @PathID where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [DateNotified] = @StartDate and [PathID] is null

update [ess.Path] set [Summary] = 'Absalom Admin Notification' where [ID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.OnboardingHRAccept]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.OnboardingHRAccept]
GO

create procedure [dbo].[ess.OnboardingHRAccept] @PathID bigint, @StartDate datetime
as

update [Personnel] set [Status] = 'HR Granted' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.OnboardingHRReject]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.OnboardingHRReject]
GO

create procedure [dbo].[ess.OnboardingHRReject] @PathID bigint, @StartDate datetime
as

update [Personnel] set [Status] = 'HR Declined' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.OnboardingLMAccept]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.OnboardingLMAccept]
GO

create procedure [dbo].[ess.OnboardingLMAccept] @PathID bigint, @StartDate datetime
as

update [Personnel] set [Status] = 'HOD Accepted' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.OnboardingLMReject]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.OnboardingLMReject]
GO

create procedure [dbo].[ess.OnboardingLMReject] @PathID bigint, @StartDate datetime
as

update [Personnel] set [Status] = 'HOD Declined' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.OnboardingPath]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.OnboardingPath]
GO

create procedure [dbo].[ess.OnboardingPath] @PathID bigint, @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @StartDate datetime
as

update [Personnel] set [PathID] = @PathID, [TODateSaved] = null, [TOUsername] = null where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [PathID] is null

update [ess.Path] set [Summary] = 'Employee Created: Onboarding' where [ID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.PerfPath]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.PerfPath]
GO

create procedure [dbo].[ess.PerfPath] @PathID bigint, @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @StartDate datetime
as

update [PerfEvalScheme] set [PathID] = @PathID, [GroupRole] = (select [ReportsToType] from [ess.ActionLU] where ([ID] = (select [ActionID] from [ess.WF] where ([ID] = (select [WFID] from [ess.Path] where ([ID] = @PathID)))))) where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [EvalDate] = @StartDate and [PathID] is null

update [ess.Path] set [Summary] = 'Performance' where [ID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.PerfSubmit]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.PerfSubmit]
GO

create procedure [dbo].[ess.PerfSubmit] @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @GroupName nvarchar(50), @Username nvarchar(20)
as

declare @iCount bigint,
	@iLoop bigint,
	@rvalue int,
	@SQLExec nvarchar(4000),
	@PerfCompanyNum nvarchar(20),
	@PerfEmployeeNum nvarchar(12),
	@PerfApprCompanyNum nvarchar(20),
	@PerfApprEmployeeNum nvarchar(12),
	@SchemeCode nvarchar(50),
	@EvalDate datetime,
	@WFName nvarchar(50)

declare @PerfEvalScheme table
(
	[ID] bigint identity (1, 1) not null,
	[SchemeCode] [nvarchar] (50) not null,
	[SchemeName] [nvarchar] (80) null,
	[EvalDate] [datetime] not null,
	[EvalCompanyNum] [nvarchar] (20) not null,
	[EvalEmployeeNum] [nvarchar] (12) not null,
	[ApprName] [nvarchar] (80) null,
	[ApprCompanyNum] [nvarchar] (20) not null,
	[ApprEmployeeNum] [nvarchar] (20) not null,
	[ApprType] [nvarchar] (20) not null,
	[WFName] [nvarchar] (50) null
)

insert into @PerfEvalScheme([SchemeCode], [SchemeName], [EvalDate], [EvalCompanyNum], [EvalEmployeeNum], [ApprCompanyNum], [ApprEmployeeNum], [ApprType], [WFName])
select [SchemeCode], (select top 1 [Name] from [PerfScheme] where ([SchemeCode] = [e].[SchemeCode])), getdate(), [EvalCompanyNum], [EvalEmployeeNum], [ApprCompanyNum], [ApprEmployeeNum], [ApprType], (select top 1 [WFName] from [PerfScheme] where ([SchemeCode] = [e].[SchemeCode])) from [ess.EvalGroupItems] as [e] where ([CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [GroupName] = @GroupName)

update @PerfEvalScheme set [WFName] = '' where ([WFName] is null)

set @iLoop = 1

select @iCount = count([ID]) from @PerfEvalScheme

while (@iLoop <= @iCount)
begin

	select @PerfCompanyNum = [EvalCompanyNum], @PerfEmployeeNum = [EvalEmployeeNum], @SchemeCode = [SchemeCode], @EvalDate = [EvalDate], @PerfApprCompanyNum = [ApprCompanyNum], @PerfApprEmployeeNum = [ApprEmployeeNum], @WFName = [WFName] from @PerfEvalScheme where ([ID] = @iLoop)

	update @PerfEvalScheme set [ApprName] = (select isnull([PreferredName] + ' ', '') + [Surname] from [Personnel] where ([CompanyNum] = @PerfApprCompanyNum and [EmployeeNum] = @PerfApprEmployeeNum)) where ([ID] = @iLoop)

	set @EvalDate = dateadd(ss, @iLoop, @EvalDate)

	select @SQLExec = 'insert into [PerfEvalScheme]([CompanyNum], [EmployeeNum], [SchemeCode], [EvalDate], [Name], [Score], [AppraiserType], [AppraiserName], [AppraiserCompNum], [AppraiserEmpNum], [GroupName]) values(' + '''' + @PerfCompanyNum + ''', ''' + @PerfEmployeeNum + ''', ''' + @SchemeCode + ''', ''' + convert(nvarchar(19), @EvalDate, 120) + ''', ''' + [SchemeName] + ''', 0, ''' + [ApprType] + ''', ''' + [ApprName] + ''', ''' + [ApprCompanyNum] + ''', ''' + [ApprEmployeeNum] + ''', ''' + @GroupName + ''')' from @PerfEvalScheme where ([ID] = @iLoop)

	exec @rvalue = sp_executesql @SQLExec

	if (@rvalue = 0)
	begin

		set @SQLExec = 'insert into [PerfEvalClass]([CompanyNum], [EmployeeNum], [SchemeCode], [EvalDate], [ClassCode], [ClassName], [Weight]) select ''' + @PerfCompanyNum + ''', ''' + @PerfEmployeeNum + ''', ''' + @SchemeCode + ''', ''' + convert(nvarchar(19), @EvalDate, 120) + ''', [pc].[ClassCode], [pc].[ClassName], [ps].[Weight] from [PerfSchemeClass] as [ps] left outer join [PerfClass] as [pc] on [ps].[ClassCode] = [pc].[ClassCode] where ([SchemeCode] = ''' + @SchemeCode + ''')'

		exec @rvalue = sp_executesql @SQLExec

		if (@rvalue = 0)
		begin

			set @SQLExec = 'insert into [PerfEvalKPA]([CompanyNum], [EmployeeNum], [SchemeCode], [EvalDate], [ClassCode], [KPACode], [KPAName], [Target], [Weight], [RangeType], [Required]) select ''' + @PerfCompanyNum + ''', ''' + @PerfEmployeeNum + ''', ''' + @SchemeCode + ''', ''' + convert(nvarchar(19), @EvalDate, 120) + ''', [ClassCode], [KPACode], [KPAName], [Target], [Weight], [RangeType], [Required] from [PerfKPA] where ([SchemeCode] = ''' + @SchemeCode + ''')'

			exec @rvalue = sp_executesql @SQLExec

			if (@rvalue = 0)
			begin

				set @SQLExec = 'insert into [PerfEvalCSE]([CompanyNum], [EmployeeNum], [SchemeCode], [EvalDate], [ClassCode], [KPACode], [CSEName], [Target], [Weight], [RangeType], [Required]) select ''' + @PerfCompanyNum + ''', ''' + @PerfEmployeeNum + ''', ''' + @SchemeCode + ''', ''' + convert(nvarchar(19), @EvalDate, 120) + ''', [ClassCode], [KPACode], [CSEName], [Target], [Weight], [RangeType], [Required] from [PerfCSE] where ([SchemeCode] = ''' + @SchemeCode + ''')'

				exec @rvalue = sp_executesql @SQLExec

				if (@rvalue = 0)
				begin

					set @SQLExec = 'exec [ess.WFProc] ''' + @CompanyNum + ''', ''' + @EmployeeNum + ''', ''' + @PerfCompanyNum + ''', ''' + @PerfEmployeeNum + ''', 0, ''Performance'', ''Performance'', ''Start'', ''Start'', ''' + convert(nvarchar(19), @EvalDate, 120) + ''', ''' + @Username + ''', ''' + @WFName + ''''

					exec @rvalue = sp_executesql @SQLExec

				end

			end

		end

	end

	set @iLoop = @iLoop + 1

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.PerfSubmitted]') and objectproperty([ID], N'IsUserTable') = 1)
	truncate table [ess.PerfSubmitted]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.RegisterPath]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.RegisterPath]
GO

create procedure [dbo].[ess.RegisterPath] @PathID bigint, @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @StartDate datetime
as

update [Users] set [PathID] = @PathID where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [PathID] is null

update [ess.Path] set [Summary] = 'Registration', [Frozen] = 1 where [ID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.RegisterActivate]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.RegisterActivate]
GO

create procedure [dbo].[ess.RegisterActivate] @PathID bigint, @StartDate datetime
as

update [Users] set [ActivationKey] = null where [PathID] = @PathID

update [ess.Path] set [Frozen] = 0 where [ID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.SkillHRAccept]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.SkillHRAccept]
GO

create procedure [dbo].[ess.SkillHRAccept] @PathID bigint, @StartDate datetime
as

update [Skills] set [Status] = 'HR Granted' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.SkillHRReject]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.SkillHRReject]
GO
	
create procedure [dbo].[ess.SkillHRReject] @PathID bigint, @StartDate datetime
as

update [Skills] set [Status] = 'HR Declined' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.SkillLMAccept]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.SkillLMAccept]
GO

create procedure [dbo].[ess.SkillLMAccept] @PathID bigint, @StartDate datetime
as

update [Skills] set [Status] = 'HOD Accepted' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.SkillLMReject]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.SkillLMReject]
GO

create procedure [dbo].[ess.SkillLMReject] @PathID bigint, @StartDate datetime
as

update [Skills] set [Status] = 'HOD Declined' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.SkillPath]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.SkillPath]
GO

create procedure [dbo].[ess.SkillPath] @PathID bigint, @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @StartDate datetime
as

update [Skills] set [PathID] = @PathID, [StatusID] = (select [ID] from [ess.StatusLU] where [Status] = 'Start') where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [StatusID] = -1 and [PathID] is null

update [ess.Path] set [Summary] = 'Skills Learned' where [ID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.IRPerfHRAccept]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.IRPerfHRAccept]
GO

create procedure [dbo].[ess.IRPerfHRAccept] @PathID bigint, @StartDate datetime
as

update [Counselling_Work_Performance] set [Status] = 'HR Granted' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.IRPerfHRReject]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.IRPerfHRReject]
GO
	
create procedure [dbo].[ess.IRPerfHRReject] @PathID bigint, @StartDate datetime
as

update [Counselling_Work_Performance] set [Status] = 'HR Declined' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.IRPerfLMAccept]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.IRPerfLMAccept]
GO

create procedure [dbo].[ess.IRPerfLMAccept] @PathID bigint, @StartDate datetime
as

update [Counselling_Work_Performance] set [Status] = 'HOD Accepted' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.IRPerfLMReject]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.IRPerfLMReject]
GO

create procedure [dbo].[ess.IRPerfLMReject] @PathID bigint, @StartDate datetime
as

update [Counselling_Work_Performance] set [Status] = 'HOD Declined' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.IRPerfPath]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.IRPerfPath]
GO

create procedure [dbo].[ess.IRPerfPath] @PathID bigint, @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @StartDate datetime
as

update [Counselling_Work_Performance] set [PathID] = @PathID, [Status] = 'New' where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [fDate] = @StartDate and [PathID] is null

update [ess.Path] set [Summary] = 'IR Performance' where [ID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.StoreCancel]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.StoreCancel]
GO

create procedure [dbo].[ess.StoreCancel] @PathID bigint, @StartDate datetime
as

update [StoreIssued] set [StoreStatus] = 'Cancelled' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.StoreHRAccept]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.StoreHRAccept]
GO

create procedure [dbo].[ess.StoreHRAccept] @PathID bigint, @StartDate datetime
as

update [StoreIssued] set [StoreStatus] = 'HR Granted' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.StoreHRReject]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.StoreHRReject]
GO

create procedure [dbo].[ess.StoreHRReject] @PathID bigint, @StartDate datetime
as

update [StoreIssued] set [StoreStatus] = 'HR Declined' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.StoreLMAccept]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.StoreLMAccept]
GO

create procedure [dbo].[ess.StoreLMAccept] @PathID bigint, @StartDate datetime
as

update [StoreIssued] set [StoreStatus] = 'HOD Accepted' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.StoreLMReject]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.StoreLMReject]
GO

create procedure [dbo].[ess.StoreLMReject] @PathID bigint, @StartDate datetime
as

update [StoreIssued] set [StoreStatus] = 'HOD Declined' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.StorePath]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.StorePath]
GO

create procedure [dbo].[ess.StorePath] @PathID bigint, @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @StartDate datetime
as

update [StoreIssued] set [PathID] = @PathID, [StatusID] = (select [ID] from [ess.StatusLU] where [Status] = 'Start') where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [StatusID] = -1 and [PathID] is null

update [ess.Path] set [Summary] = 'Store Items' where [ID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.TrainingCancel]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.TrainingCancel]
GO

create procedure [dbo].[ess.TrainingCancel] @PathID bigint, @StartDate datetime
as

declare @delTraining bit
declare @pTemplate as nvarchar(10)

set @delTraining = null
set @pTemplate = null

select @pTemplate = [TemplateCode] from [TrainingPlanned] where [PathID] = @PathID

if exists (select [ID] from [ess.PolicyItems] where ([PolicyID] = 37 and [Template] = @pTemplate))
begin

	select @delTraining = [YesNo] from [ess.PolicyItems] where ([PolicyID] = 37 and [Template] = @pTemplate)
	
	if (@delTraining is null)
		select @delTraining = [YesNo] from [ess.Policy] where ([GroupID] = 4 and [Key] = 'DeleteCancelled')

end
else
begin

	select @delTraining = [YesNo] from [ess.Policy] where ([GroupID] = 4 and [Key] = 'DeleteCancelled')

end

if (@delTraining is null)
	set @delTraining = 0

if (@delTraining = 0)
	update [TrainingPlanned] set [TrainingStatus] = 'Cancelled' where [PathID] = @PathID

if (@delTraining = 1)
	update [TrainingPlanned] set [TrainingStatus] = 'Delete' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.TrainingHRAccept]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.TrainingHRAccept]
GO

create procedure [dbo].[ess.TrainingHRAccept] @PathID bigint, @StartDate datetime
as

update [TrainingPlanned] set [TrainingStatus] = 'HR Granted' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.TrainingHRReject]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.TrainingHRReject]
GO

create procedure [dbo].[ess.TrainingHRReject] @PathID bigint, @StartDate datetime
as

update [TrainingPlanned] set [TrainingStatus] = 'HR Declined' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.TrainingLMAccept]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.TrainingLMAccept]
GO

create procedure [dbo].[ess.TrainingLMAccept] @PathID bigint, @StartDate datetime
as

update [TrainingPlanned] set [TrainingStatus] = 'HOD Accepted' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.TrainingLMReject]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.TrainingLMReject]
GO
	
create procedure [dbo].[ess.TrainingLMReject] @PathID bigint, @StartDate datetime
as

update [TrainingPlanned] set [TrainingStatus] = 'HOD Declined' where [PathID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.TrainingPath]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.TrainingPath]
GO
	
create procedure [dbo].[ess.TrainingPath] @PathID bigint, @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @StartDate datetime
as

declare @CourseName nvarchar(50)

update [TrainingPlanned] set [PathID] = @PathID where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [StartDate] = @StartDate and [PathID] is null

select @CourseName = [CourseName] from [TrainingPlanned] where [PathID] = @PathID

update [ess.Path] set [Summary] = @CourseName where [ID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.UnFreezePath]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.UnFreezePath]
GO

create procedure [dbo].[ess.UnFreezePath] @PathID bigint, @StartDate datetime
as

update [ess.Path] set [Frozen] = null where [ID] = @PathID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFProc]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [dbo].[ess.WFProc]
GO

create procedure [dbo].[ess.WFProc] @ProcCompNum nvarchar(20), @ProcEmpNum nvarchar(20), @CompanyNum nvarchar(20), @EmployeeNum nvarchar(12), @PathID bigint, @WFType nvarchar(50), @AppType nvarchar(50), @Status nvarchar(50), @ActionType nvarchar(50), @StartDate datetime, @LoggedOnUser nvarchar(20) = '', @WFLUName nvarchar(50) = ''
as

declare @sSysDate datetime

set @sSysDate = getdate()

declare @WFCnt int
declare @WFLUID tinyint
declare @WFName nvarchar(50)

if (len(@WFLUName) = 0)
	select top 1 @WFName = [WFName] from [ess.WFAppType] where ([WFType] = @WFType) and ([AppType] = @AppType) order by [ID]

/* select correct WorkFlowName for user based on possible linked departments */
select @WFLUID = [id], @WFName = [WFName] from [ess.WFLU] where ([WFName] = @WFName) and ([WFType] = @WFType)

declare @WFDepartment nvarchar(50)

select @WFDepartment = [DeptName] from [Personnel] where ([CompanyNum] = @CompanyNum) and ([EmployeeNum] = @EmployeeNum)

if ((not @WFDepartment is null) and (len(@WFDepartment) > 0))
begin

	select @WFLUID = [WFLUID] from [ess.WFLinkedDepts] where ([WFLUID] in(select [ID] from [ess.WFLU] where ([WFType] = @WFType)) and [DeptName] = @WFDepartment)

	if (not @WFLUID is null)
	begin
	
		select @WFName = [WFName] from [ess.WFLU] where ([ID] = @WFLUID)
		
	end
	else
	begin
	
		if (len(@WFLUName) = 0)
			select @WFName = [WFName] from [ess.WFAppType] where ([WFType] = @WFType) and ([AppType] = @AppType)
		else
			set @WFName = @WFLUName

	end

end

if (len(@WFLUName) > 0)
begin

	set @WFName = @WFLUName

	select @WFLUID = [id], @WFName = [WFName] from [ess.WFLU] where ([WFName] = @WFName) and ([WFType] = @WFType)

end

declare @ActionID tinyint
declare @StatusID tinyint

/* Get Action & Status Identifiers */
select @ActionID = [id] from [ess.ActionLU] where [ReportsToType] = @ActionType
select @StatusID = [id] from [ess.StatusLU] where [Status] = @Status

select @WFCnt = count([ActionID]) from [ess.WF] where [ActionID] = @ActionID and [StatusID] = @StatusID and [WFLUID] = @WFLUID

declare @EmailID tinyint,
		@SMSID tinyint,
		@EmailCC nvarchar(25),
		@EmailBCC nvarchar(25),
		@SMSCC nvarchar(25),
		@EmailOrigID tinyint,
		@SMSOrigID tinyint,
		@EmailOrigCC nvarchar(25),
		@EmailOrigBCC nvarchar(25),
		@SMSOrigCC nvarchar(25),
		@EmailActID tinyint,
		@SMSActID tinyint,
		@EmailActCC nvarchar(25),
		@EmailActBCC nvarchar(25),
		@SMSActCC nvarchar(25),
		@LockedBy nvarchar(100),
		@PAID tinyint,
		@PathIDNew bigint,
		@PostActID smallint,
		@PostActProc nvarchar(512),
		@TaskIDProc nvarchar(512),
		@tPostActID smallint,
		@WFPathID smallint

/* Get WorkFlow Process Identifier */
if ((@WFCnt > 1) and (@PathID <> 0))
begin

	select @WFPathID = [WFID] from [ess.Path] where [id] = @PathID		

	select @LockedBy = [LockedBy], @PostActID = [PostActID], @PostActProc = [PostActProc], @TaskIDProc = [TaskIDProc], @PAID = [PAID], @EmailID = [EmailID], @SMSID = [SMSID], @EmailCC = [EmailCC], @EmailBCC = [EmailBCC], @SMSCC = [SMSCC], @EmailOrigID = [EmailOrigID], @SMSOrigID = [SMSOrigID], @EmailOrigCC = [EmailOrigCC], @EmailOrigBCC = [EmailOrigBCC], @SMSOrigCC = [SMSOrigCC], @EmailActID = [EmailActID], @SMSActID = [SMSActID], @EmailActCC = [EmailActCC], @EmailActBCC = [EmailActBCC], @SMSActCC = [SMSActCC] from [ess.WF] where [id] = @WFPathID

end
else
	select top 1 @WFPathID = [ID], @LockedBy = [LockedBy], @PostActID = [PostActID], @PostActProc = [PostActProc], @TaskIDProc = [TaskIDProc], @PAID = [PAID], @EmailID = [EmailID], @SMSID = [SMSID], @EmailCC = [EmailCC], @EmailBCC = [EmailBCC], @SMSCC = [SMSCC], @EmailOrigID = [EmailOrigID], @SMSOrigID = [SMSOrigID], @EmailOrigCC = [EmailOrigCC], @EmailOrigBCC = [EmailOrigBCC], @SMSOrigCC = [SMSOrigCC], @EmailActID = [EmailActID], @SMSActID = [SMSActID], @EmailActCC = [EmailActCC], @EmailActBCC = [EmailActBCC], @SMSActCC = [SMSActCC] from [ess.WF] where [ActionID] = @ActionID and [StatusID] = @StatusID and [WFLUID] = @WFLUID

set @tPostActID = @PostActID

if (not @LockedBy is null)
begin

	raiserror('The workflow ''%s'' is currently locked by ''%s''.', 16, 1, @WFName, @LockedBy)
	
	return

end

declare @OrigEmail nvarchar(80)
declare @OrigCell nvarchar(50)
declare @OrigUName nvarchar(20)
declare @OrigDefUName nvarchar(20)

select @OrigEmail = [p].[EMailAddress], @OrigCell = [p].[CellTel], @OrigUName = [u].[Username], @OrigDefUName = (select top 1 [Username] from [Users] where [CompanyNum] = [u].[CompanyNum] and [EmployeeNum] = [u].[EmployeeNum] and [DefaultUser] = 1) from [Personnel] as [p] left outer join [Users] as [u] on [p].[CompanyNum] = [u].[CompanyNum] and [p].[EmployeeNum] = [u].[EmployeeNum] where ([p].[CompanyNum] = @CompanyNum) and ([p].[EmployeeNum] = @EmployeeNum)

if ((not @OrigDefUName is null) and (@OrigUName <> @OrigDefUName))
	set @OrigUName = @OrigDefUName

if (@PathID = 0)
begin

	insert into [ess.Path]([WFLUID], [ActionID], [ActionDate], [StatusID], [WFID], [OriginatorDate], [PAID], [OriginatorCompanyNum], [OriginatorEmployeeNum], [OriginatorUsername], [OriginatorEmail], [OriginatorCell], [EmailCC], [EmailBCC], [SMSCC], [EmailOrigCC], [EmailOrigBCC], [SMSOrigCC], [EmailActCC], [EmailActBCC], [SMSActCC]) values(@WFLUID, @ActionID, @sSysDate, @StatusID, @tPostActID, @sSysDate, @PAID, @CompanyNum, @EmployeeNum, @OrigUName, @OrigEmail, @OrigCell, @EmailCC, @EmailBCC, @SMSCC, @EmailOrigCC, @EmailOrigBCC, @SMSOrigCC, @EmailActCC, @EmailActBCC, @SMSActCC)

	select @PathIDNew = scope_identity()

end
else
begin

	update [ess.Path] set ActionID = @ActionID, [ActionDate] = @sSysDate, [StatusID] = @StatusID, [WFID] = @tPostActID, [PAID] = @PAID, [OriginatorEmail] = @OrigEmail, [OriginatorCell] = @OrigCell, [EmailCC] = @EmailCC, [EmailBCC] = @EmailBCC, [SMSCC] = @SMSCC, [EmailOrigCC] = @EmailOrigCC, [EmailOrigBCC] = @EmailOrigBCC, [SMSOrigCC] = @SMSOrigCC, [EmailActCC] = @EmailActCC, [EmailActBCC] = @EmailActBCC, [SMSActCC] = @SMSActCC where [id] = @PathID

	set @PathIDNew = @PathID

end

declare @strSQLExec nvarchar(4000),
		@WFCPostStatus nvarchar(50)

select @WFCPostStatus = [Status] from [ess.StatusLU] where ([id] = (select [StatusID] from [ess.WF] where ([id] = @tPostActID)))

/* Call task ID stored procedure to update the relevant table */
if ((not @TaskIDProc is null) and (@PathID = 0))
begin

	set @strSQLExec = N'exec [' + cast(@TaskIDProc as nvarchar(512)) + N'] ' + cast(@PathIDNew as nvarchar(19)) + N', ''' + cast(@CompanyNum as nvarchar(20)) + N''', ''' + cast(@EmployeeNum as nvarchar(12)) + N''', ''' + convert(nvarchar(19), @StartDate, 120) + ''''

	exec sp_executesql @strSQLExec
	
end

/* Get the next level user and postaction type */
declare @iCount bigint,
		@iLoop bigint,
		@ClauseID bigint,
		@WFClauseID smallint,
		@CurTable nvarchar(128),
		@CurField nvarchar(128),
		@CurWhere nvarchar(4000),
		@Criteria nvarchar(2),
		@ComTable nvarchar(128),
		@ComField nvarchar(128),
		@ComWhere nvarchar(4000),
		@ComValue nvarchar(4000),
		@SQLExec nvarchar(4000),
		@CType1 sysname,
		@CType2 sysname,
		@CValue1 nvarchar(4000),
		@CValue2 nvarchar(4000),
		@bSkipCondition bit,
		@rvalue int

declare @essWFConditions table
(
	[id] [bigint] identity (1, 1) not null,
	[WFID] [smallint] not null,
	[ConditionID] [int] not null,
	[ClauseID] [bigint] null,
	[ReportsToType] [nvarchar] (35) null,
	[CompanyNum] [nvarchar] (20) null,
	[EmployeeNum] [nvarchar] (12) null
)

declare @bSkipExtProc bit,
		@bSkipProcess bit,
		@ExecNonProc bit,
		@NewPostActProc nvarchar(512),
		@RepToType nvarchar(50)

if (@WFCPostStatus = 'Start')
	goto SkipCondition

CheckNextCondition:

select @bSkipCondition = [SkipCondition] from [ess.WF] where ([id] = @WFPathID)

delete from @essWFConditions

insert into @essWFConditions([WFID], [ConditionID], [ClauseID], [ReportsToType], [CompanyNum], [EmployeeNum])
select @WFPathID, [ConditionID], [ClauseID], [ReportsToType], [CompanyNum], [EmployeeNum] from [ess.WFConditions] where ([WFID] = @WFPathID) order by [id]

set @iLoop = 1

select @iCount = count([id]) from @essWFConditions

if (@iCount > 0)
begin

	while (@iLoop <= @iCount)
	begin

		select @WFClauseID = [WFID], @ClauseID = [ClauseID] from @essWFConditions where ([id] = @iLoop)

		select @CurTable = [CurTable], @CurField = [CurField], @CurWhere = [CurWhere], @Criteria = [Criteria], @ComTable = [ComTable], @ComField = [ComField], @ComWhere = [ComWhere], @ComValue = [ComValue] from [ess.ConditionClauses] where ([id] = @ClauseID)

		set @CurWhere = replace(@CurWhere, '%PathID%', cast(@PathIDNew as nvarchar(10)))

		select @CType1 = [name] from [systypes] where ([xtype] = (select [xtype] from [syscolumns] where ([id] = object_id('[' + @CurTable + ']') and ([name] = @CurField))))

		if (@CType1 = 'sysname')
			set @CType1 = 'nvarchar'

		if (@CType1 = 'datetime') or (@CType1 = 'smalldatetime')
			set @CurField = 'convert(nvarchar(19), [' + @CurField + '], 120)'
		else
			set @CurField = '[' + @CurField + ']'

		set @SQLExec = 'select @CValue1 = ' + @CurField + ' from [' + @CurTable + '] where ' + @CurWhere

		exec sp_executesql @SQLExec, N'@CValue1 nvarchar(4000) OUTPUT', @CValue1 = @CValue1 OUTPUT
	
		if (@CType1 = 'datetime') or (@CType1 = 'smalldatetime') or (@CType1 = 'varchar') or (@CType1 = 'nvarchar') or (@CType1 = 'text') or (@CType1 = 'ntext') or (@CType1 = 'char') or (@CType1 = 'nchar')
			set @CValue1 = '''' + @CValue1 + ''''

		if ((len(@ComTable) > 0) and (len(@ComField) > 0) and (len(@ComWhere) > 0))
		begin

			set @ComWhere = replace(@ComWhere, '%PathID%', cast(@PathIDNew as nvarchar(10)))

			select @CType2 = [name] from [systypes] where ([xtype] = (select [xtype] from [syscolumns] where ([id] = object_id('[' + @ComTable + ']') and ([name] = @ComField))))

			if (@CType2 = 'sysname')
				set @CType2 = 'nvarchar'

			if (@CType2 = 'datetime') or (@CType2 = 'smalldatetime')
				set @ComField = 'convert(nvarchar(19), [' + @ComField + '], 120)'
			else
				set @ComField = '[' + @ComField + ']'

			set @SQLExec = 'select @CValue2 = ' + @ComField + ' from [' + @ComTable + '] where ' + @ComWhere

			exec sp_executesql @SQLExec, N'@CValue2 nvarchar(4000) OUTPUT', @CValue2 = @CValue2 OUTPUT

			if (not @CValue1 is null)
			begin

				set @SQLExec = 'if (' + @CValue1 + ' ' + @Criteria + ' ' + @CValue2 + ') set @rvalue = 1 else set @rvalue = 0'

				exec sp_executesql @SQLExec, N'@rvalue int OUTPUT', @rvalue = @rvalue OUTPUT

				if (@rvalue = 1)
					set @iLoop = @iCount + 1

			end

		end
		else if (not @ComValue is null)
		begin

			if (not @CValue1 is null)
			begin

				set @SQLExec = 'if (' + @CValue1 + ' ' + @Criteria + ' ' + @ComValue + ') set @rvalue = 1 else set @rvalue = 0'

				exec sp_executesql @SQLExec, N'@rvalue int OUTPUT', @rvalue = @rvalue OUTPUT

				if (@rvalue = 1)
					set @iLoop = @iCount + 1

			end

		end

		set @iLoop = @iLoop + 1

	end

end

SkipCondition:

set @bSkipExtProc = 0

CheckNext:

select @RepToType = [a].[ReportsToType], @bSkipProcess = [w].[SkipNonExt], @ExecNonProc = [w].[ExecNonProc] from [ess.WF] as [w] inner join [ess.ActionLU] as [a] on [w].[ActionID] = [a].[id] where ([w].[id] = @tPostActID)

if (@iCount > 0) and (@rvalue = 1)
	goto SkipCheck

if (@bSkipProcess = 1) or ((@iCount > 0) and (@bSkipCondition = 1) and (@rvalue = 0))
begin

	if (upper(@RepToType) = 'DUMMY')
	begin

		if (upper(@WFType) = 'PERFORMANCE')
		begin

			select @WFCnt = count([SchemeCode]) from [PerfEvalScheme] where [PathID] = @PathIDNew
			
		end

		if (upper(@WFType) = 'REGISTRATION')
		begin

			select @WFCnt = count([Username]) from [Users] where [PathID] = @PathIDNew
			
		end

	end
	else
		select @WFCnt = count([ReportsToType]) from [ReportsTo] where [CompanyNum] = @CompanyNum and [EmployeeNum] = @EmployeeNum and [ReportsToType] = @RepToType

	if (@WFCnt < 1) or ((@iCount > 0) and (@bSkipCondition = 1) and (@rvalue = 0))
	begin

		select @tPostActID = [PostActID] from [ess.WF] where [id] = @tPostActID
	
		declare @NewStatusID tinyint
		declare @NewPAID tinyint

		select @NewStatusID = [StatusID], @NewPAID = [PAID], @NewPostActProc = [PostActProc], @EmailID = [EmailID], @SMSID = [SMSID], @EmailCC = [EmailCC], @EmailBCC = [EmailBCC], @SMSCC = [SMSCC], @EmailOrigID = [EmailOrigID], @SMSOrigID = [SMSOrigID], @EmailOrigCC = [EmailOrigCC], @EmailOrigBCC = [EmailOrigBCC], @SMSOrigCC = [SMSOrigCC], @EmailActID = [EmailActID], @SMSActID = [SMSActID], @EmailActCC = [EmailActCC], @EmailActBCC = [EmailActBCC], @SMSActCC = [SMSActCC] from [ess.WF] where [id] = @PostActID
	
		if ((not @NewPostActProc is null) and (@ExecNonProc = 1))
		begin

			set @bSkipExtProc = 1

			declare @NewExecProc nvarchar(50)
			declare @NewNPos int

			set @NewNPos = charindex(',', @NewPostActProc)

			if (@NewNPos > 0)
			begin

				while((@NewNPos > 0) or (len(@NewPostActProc) > 0))
				begin

					if (@NewNPos > 0)
					begin

						set @NewExecProc = left(@NewPostActProc, @NewNPos - 1)

					end
					else
						set @NewExecProc = @NewPostActProc

					set @strSQLExec = N'exec [' + cast(@NewExecProc as nvarchar(512)) + N'] ' + cast(@PathIDNew as nvarchar(19)) + N', ''' + convert(nvarchar(19), @sSysDate, 120) + ''''

					exec sp_executesql @strSQLExec

					if (@NewNPos > 0)
					begin

						set @NewPostActProc = ltrim(right(@NewPostActProc, len(@NewPostActProc) - @NewNPos))

						set @NewNPos = charindex(',', @NewPostActProc)

					end
					else
						set @NewPostActProc = ''

				end

			end
			else
			begin
			
				set @strSQLExec = N'exec [' + cast(@NewPostActProc as nvarchar(512)) + N'] ' + cast(@PathIDNew as nvarchar(19)) + N', ''' + convert(nvarchar(19), @sSysDate, 120) + ''''

				exec sp_executesql @strSQLExec
				
			end

		end

		if (@NewStatusID = (select [id] from [ess.StatusLU] where [Status] = 'Start'))
			goto SkipCheck
	
		update [ess.Path] set [WFID] = @tPostActID, [StatusID] = @NewStatusID, [PAID] = @NewPAID where [id] = @PathIDNew
	
		if ((@iCount > 0) and (@bSkipCondition = 1) and (@rvalue = 0))
		begin
		
			set @WFPathID = @PostActID
		
			goto CheckNextCondition
			
		end

		if (@PostActID <> @tPostActID)
			set @PostActID = @tPostActID
	
		goto CheckNext
	
	end
	
end

SkipCheck:

declare @CurCompNum nvarchar(20)
declare @CurEmpNum nvarchar(12)
declare @OrigCompNum nvarchar(20)
declare @OrigEmpNum nvarchar(12)

declare @CReportsTo nvarchar(35),
		@CComNum nvarchar(20),
		@CEmpNum nvarchar(12)

if (@iCount > 0) and (@rvalue = 1)
	select @CReportsTo = [ReportsToType], @CComNum = [CompanyNum], @CEmpNum = [EmployeeNum] from [ess.WFConditions] where ([WFID] = @WFClauseID) and ([ClauseID] = @ClauseID)

if (@RepToType = 'Start')
begin

	select @CurCompNum = [OriginatorCompanyNum], @CurEmpNum = [OriginatorEmployeeNum]  from [ess.Path] where [id] = @PathIDNew

	set @OrigCompNum = @CurCompNum
	set @OrigEmpNum = @CurEmpNum

end
else
begin

	if (upper(@RepToType) = 'DUMMY')
	begin

		if (upper(@WFType) = 'PERFORMANCE')
		begin

			select @CurCompNum = [AppraiserCompNum], @CurEmpNum = [AppraiserEmpNum], @OrigCompNum = [CompanyNum], @OrigEmpNum = [EmployeeNum] from [PerfEvalScheme] where ([PathID] = @PathIDNew)

			if (not @CComNum is null) and (not @CEmpNum is null)
			begin
			
				set @CurCompNum = @CComNum
				
				set @CurEmpNum = @CEmpNum
				
				set @OrigCompNum = @CompanyNum

				set @OrigEmpNum = @EmployeeNum

			end
			
			if (not @CReportsTo is null)
				select @CurCompNum = [r].[ReportToCompNum], @CurEmpNum = [r].[ReportToEmpNum], @OrigCompNum = [r].[CompanyNum], @OrigEmpNum = [r].[EmployeeNum] from [ReportsTo] as [r] inner join [Personnel] as [p] on [r].[ReportToCompNum] = [p].[CompanyNum] and [r].[ReportToEmpNum] = [p].[EmployeeNum] where ([r].[CompanyNum] = @CompanyNum) and ([r].[EmployeeNum] = @EmployeeNum) and ([r].[ReportsToType] = @CReportsTo)

		end

		if (upper(@WFType) = 'REGISTRATION')
		begin

			select @CurCompNum = [CompanyNum], @CurEmpNum = [EmployeeNum], @OrigCompNum = [CompanyNum], @OrigEmpNum = [EmployeeNum] from [Users] where ([PathID] = @PathIDNew)
			
		end

	end
	else
	begin
	
		select @CurCompNum = [r].[ReportToCompNum], @CurEmpNum = [r].[ReportToEmpNum], @OrigCompNum = [r].[CompanyNum], @OrigEmpNum = [r].[EmployeeNum] from [ReportsTo] as [r] inner join [Personnel] as [p] on [r].[ReportToCompNum] = [p].[CompanyNum] and [r].[ReportToEmpNum] = [p].[EmployeeNum] where ([r].[CompanyNum] = @CompanyNum) and ([r].[EmployeeNum] = @EmployeeNum) and ([r].[ReportsToType] = @RepToType)
		
		if (not @CComNum is null) and (not @CEmpNum is null)
		begin
		
			set @CurCompNum = @CComNum
			
			set @CurEmpNum = @CEmpNum
						
			set @OrigCompNum = @CompanyNum

			set @OrigEmpNum = @EmployeeNum
			
		end
		
		if (not @CReportsTo is null)
			select @CurCompNum = [r].[ReportToCompNum], @CurEmpNum = [r].[ReportToEmpNum], @OrigCompNum = [r].[CompanyNum], @OrigEmpNum = [r].[EmployeeNum] from [ReportsTo] as [r] inner join [Personnel] as [p] on [r].[ReportToCompNum] = [p].[CompanyNum] and [r].[ReportToEmpNum] = [p].[EmployeeNum] where ([r].[CompanyNum] = @CompanyNum) and ([r].[EmployeeNum] = @EmployeeNum) and ([r].[ReportsToType] = @CReportsTo)

	end

end

declare @ActionedBy nvarchar(100),
		@ActionedByCompNum nvarchar(20),
		@ActionedByEmpNum nvarchar(12),
		@ActionerCompNum nvarchar(20),
		@ActionerEmpNum nvarchar(12),
		@Orig nvarchar(100),
		@OrigEmailAddress nvarchar(80),
		@OrigCellphone nvarchar(50),
		@OrigUsername nvarchar(20),
		@OrigUsernameDef nvarchar(20),
		@RepToName nvarchar(100),
		@RepToEmailAddress nvarchar(80),
		@RepToCellphone nvarchar(50),
		@Username nvarchar(20),
		@UsernameDef nvarchar(20)

select @RepToName = isnull(isnull([PreferredName], [FirstName]), '') + ' ' + isnull([Surname], ''), @RepToEmailAddress = [EMailAddress], @RepToCellphone = [CellTel] from [Personnel] where [CompanyNum] = @CurCompNum and [EmployeeNum] = @CurEmpNum

select @Orig = isnull(isnull([PreferredName], [FirstName]), '') + ' ' + isnull([Surname], ''), @OrigEmailAddress = [EMailAddress], @OrigCellphone = [CellTel] from [Personnel] where [CompanyNum] = @OrigCompNum and [EmployeeNum] = @OrigEmpNum

select @Username = [u].[Username], @UsernameDef = (select top 1 [Username] from [Users] where [CompanyNum] = [u].[CompanyNum] and [EmployeeNum] = [u].[EmployeeNum] and [DefaultUser] = 1) from [Users] as [u] where [u].[CompanyNum] = @CurCompNum and [u].[EmployeeNum] = @CurEmpNum

if ((not @UsernameDef is null) and (@Username <> @UsernameDef))
	set @Username = @UsernameDef

select @OrigCompNum = [u].[CompanyNum], @OrigEmpNum = [u].[EmployeeNum], @OrigUsername = [u].[Username], @OrigUsernameDef = (select top 1 [Username] from [Users] where [CompanyNum] = [u].[CompanyNum] and [EmployeeNum] = [u].[EmployeeNum] and [DefaultUser] = 1) from [Users] as [u] where [u].[CompanyNum] = @OrigCompNum and [u].[EmployeeNum] = @OrigEmpNum

if ((not @OrigUsernameDef is null) and (@OrigUsername <> @OrigUsernameDef))
	set @OrigUsername = @OrigUsernameDef

select @ActionerCompNum = [CompanyNum], @ActionerEmpNum = [EmployeeNum] from [Users] where [Username] = (select [ActionerUsername] from [ess.Path] where [id] = @PathIDNew)

if ((@ProcCompNum <> @ActionerCompNum) and (@ProcCompNum <> @CompanyNum)) or ((@ProcEmpNum <> @ActionerEmpNum) and (@ProcEmpNum <> @EmployeeNum))
begin

	declare @ActName nvarchar(100),
			@ActUName nvarchar(20)
			
	select @ActName = isnull(isnull([PreferredName], [FirstName]), '') + ' ' + isnull([Surname], '') from [Personnel] where ([CompanyNum] = @ProcCompNum) and ([EmployeeNum] = @ProcEmpNum)

	select @ActUName = [Username] from [Users] where ([CompanyNum] = @ProcCompNum) and ([EmployeeNum] = @ProcEmpNum)

	update [ess.Path] set [ActionedBy] = @ActName, [ActionedByCompNum] = @ProcCompNum, [ActionedByEmpNum] = @ProcEmpNum, [ActionedByUsername] = @ActUName where [id] = @PathIDNew
	
end

select @ActionedBy = [ActionedBy], @ActionedByCompNum = [ActionedByCompNum], @ActionedByEmpNum = [ActionedByEmpNum] from [ess.Path] where [id] = @PathIDNew

if ((@ActionedBy is null) or (@ActionedByCompNum is null) or (@ActionedByEmpNum is null) or (@ActionerCompNum is null) or (@ActionerEmpNum is null) or ((@ActionedByCompNum = @ActionerCompNum) and (@ActionedByEmpNum = @ActionerEmpNum)))
begin

	set @EmailActID = null
	
	set @SMSActID = null

end

update [ess.Path] set [PrevActioner] = [Actioner], [PrevActionerUsername] = [ActionerUsername], [PrevActionerCompNum] = @ActionerCompNum, [PrevActionerEmpNum] = @ActionerEmpNum, [EmailCC] = @EmailCC, [EmailBCC] = @EmailBCC, [SMSCC] = @SMSCC, [EmailOrigCC] = @EmailOrigCC, [EmailOrigBCC] = @EmailOrigBCC, [SMSOrigCC] = @SMSOrigCC, [EmailActCC] = @EmailActCC, [EmailActBCC] = @EmailActBCC, [SMSActCC] = @SMSActCC where [id] = @PathIDNew

update [ess.Path] set [UserEmail] = @RepToEmailAddress, [UserCell] = @RepToCellphone, [Actioner] = @RepToName, [Originator] = @Orig, [ActionerUsername] = @Username, [ActionerCompanyNum] = @CurCompNum, [ActionerEmployeeNum] = @CurEmpNum, [OriginatorUsername] = @OrigUsername, [OriginatorCompanyNum] = @OrigCompNum, [OriginatorEmployeeNum] = @OrigEmpNum, [OriginatorEmail] = @OrigEmailAddress, [OriginatorCell] = @OrigCellphone where [id] = @PathIDNew

/* Run External Post Action Procedure */
if ((not @PostActProc is null) and (@bSkipExtProc = 0))
begin

	declare @execProc nvarchar(50)
	declare @nPos int

	set @nPos = charindex(',', @PostActProc)

	if (@nPos > 0)
	begin

		while((@nPos > 0) or (len(@PostActProc) > 0))
		begin

			if (@nPos > 0)
			begin


				set @execProc = left(@PostActProc, @nPos - 1)

			end
			else
				set @execProc = @PostActProc

			set @strSQLExec = N'exec [' + cast(@execProc as nvarchar(512)) + N'] ' + cast(@PathIDNew as nvarchar(19)) + N', ''' + convert(nvarchar(19), @sSysDate, 120) + ''''

			exec sp_executesql @strSQLExec

			if (@nPos > 0)
			begin

				set @PostActProc = ltrim(right(@PostActProc, len(@PostActProc) - @nPos))

				set @nPos = charindex(',', @PostActProc)

			end
			else
				set @PostActProc = ''

		end

	end
	else
	begin
	
		set @strSQLExec = N'exec [' + cast(@PostActProc as nvarchar(512)) + N'] ' + cast(@PathIDNew as nvarchar(19)) + N', ''' + convert(nvarchar(19), @sSysDate, 120) + ''''

		exec sp_executesql @strSQLExec
		
	end

end

/* Create XMLTag with supplied values */
update [ess.Path] set [XMLTag] = '<WFType=' + @WFType + '><AppType=' + @AppType + '>' where [id] = @PathIDNew

/* Create Audit Record */
insert into [ess.WFAudit]([PathID], [WFLUID], [WFName], [WFType], [Summary], [ActionID], [ActionType], [ActionDate], [StatusID], [StatusType], [PAID], [PostActType], [UserEmail], [UserCell], [WFID], [Actioner], [ActionerCompanyNum], [ActionerEmployeeNum], [ActionerUsername], [ActionedBy], [ActionedByCompNum], [ActionedByEmpNum], [ActionedByUsername], [EmailCC], [EmailBCC], [SMSCC], [EmailOrigCC], [EmailOrigBCC], [SMSOrigCC], [EmailActCC], [EmailActBCC], [SMSActCC], [Originator], [OriginatorCompanyNum], [OriginatorEmployeeNum], [OriginatorUsername], [OriginatorDate], [OriginatorEmail], [OriginatorCell], [PrevActioner], [PrevActionerCompNum], [PrevActionerEmpNum], [PrevActionerUsername]) select @PathIDNew, [WFLUID], @WFName, @WFType, [Summary], [ActionID], (select [ReportsToType] from [ess.ActionLU] where [id] = [p].[ActionID]), @sSysDate, [StatusID], (select [Status] from [ess.StatusLU] where [id] = [p].[StatusID]), [PAID], (select [id] from [ess.PALU] where [id] = [p].[PAID]), [UserEmail], [UserCell], [WFID], [Actioner], [ActionerCompanyNum], [ActionerEmployeeNum], [ActionerUsername], [ActionedBy], [ActionedByCompNum], [ActionedByEmpNum], [ActionedByUsername], [EmailCC], [EmailBCC], [SMSCC], [EmailOrigCC], [EmailOrigBCC], [SMSOrigCC], [EmailActCC], [EmailActBCC], [SMSActCC], [Originator], [OriginatorCompanyNum], [OriginatorEmployeeNum], [OriginatorUsername], [OriginatorDate], [OriginatorEmail], [OriginatorCell], [PrevActioner], [PrevActionerCompNum], [PrevActionerEmpNum], [PrevActionerUsername] from [ess.Path] as [p] where [id] = @PathIDNew

if (@WFType = 'Performance') and (@AppType = 'Performance') and (@Status = 'Start') and (@ActionType = 'Start')
begin

	if (len(@LoggedOnUser) > 0)
		insert into [ess.PerfSubmitted]([CompanyNum], [EmployeeNum], [Username], [PathID]) values(@ProcCompNum, @ProcEmpNum, @LoggedOnUser, @PathIDNew)

end
else
	select '<PathID=' + cast(@PathIDNew as nvarchar(19)) + '>'
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[evaluations.CopyScheme]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [dbo].[evaluations.CopyScheme]
GO

create procedure [dbo].[evaluations.CopyScheme] @SchemeCode nvarchar(50), @SchemeName nvarchar(80) = ''
as

declare @iIndex tinyint,
		@found bit,
		@SchemeCodeN nvarchar(50),
		@copyNum nvarchar(80)

set @iIndex = 0

IndexCheck:

set @found = 1

set @SchemeCodeN = @SchemeCode + '_' + cast(@iIndex as nvarchar(3))

if (exists(select [SchemeCode] from [PerfScheme] where ([SchemeCode] = @SchemeCodeN)))
	set @found = 0

if (@found = 0)
begin

	set @iIndex = @iIndex + 1

	set @SchemeCodeN = @SchemeCode + '_' + cast(@iIndex as nvarchar(3))

	goto IndexCheck

end

set @copyNum = ''

if (@iIndex > 0)
	set @copyNum = ' (' + cast(@iIndex as nvarchar(3)) + ')'

if (len(@SchemeName) = 0)
	select top 1 @SchemeName = [Name] + ' - Copy' + @copyNum from [PerfScheme] where ([SchemeCode] = @SchemeCode)

insert into [PerfScheme]([SchemeCode], [PerfGroupCode], [Name], [Description], [ESSCreated]) select top 1 @SchemeCodeN, [PerfGroupCode], @SchemeName, [Description], 1 from [PerfScheme] where ([SchemeCode] = @SchemeCode)

insert into [PerfSchemeClass]([SchemeCode], [ClassCode], [Weight]) select top 1 @SchemeCodeN, [ClassCode], [Weight] from [PerfSchemeClass] where ([SchemeCode] = @SchemeCode)

insert into [PerfKPA]([SchemeCode], [ClassCode], [KPACode], [KPAName], [Target], [RangeType], [Weight], [Indicator_], [Description]) select @SchemeCodeN, [ClassCode], [KPACode], [KPAName], [Target], [RangeType], [Weight], [Indicator_], [Description] from [PerfKPA] where ([SchemeCode] = @SchemeCode)

insert into [PerfCSE]([SchemeCode], [ClassCode], [KPACode], [CSEName], [Target], [RangeType], [Weight], [Indicator_], [Description]) select @SchemeCodeN, [ClassCode], [KPACode], [CSEName], [Target], [RangeType], [Weight], [Indicator_], [Description] from [PerfCSE] where ([SchemeCode] = @SchemeCode)
GO

set quoted_identifier off 
GO
set ansi_nulls on 
GO

/**********************************************************************************************************

									*** v6.0.74 (Drop Views) ***

***********************************************************************************************************/
declare @iCount bigint,
	@iLoop bigint,
	@name sysname,
	@SQLExec nvarchar(4000)

declare @SQLViews table
(
	[ID] bigint identity (1, 1) not null,
	[name] sysname not null
)

insert into @SQLViews select [name] from [sysobjects] where ([name] like 'ess_%' and objectproperty([ID], 'IsView') = 1)

set @iLoop = 1

select @iCount = count([ID]) from @SQLViews

while (@iLoop <= @iCount)
begin

	select @name = [name] from @SQLViews where ([ID] = @iLoop)

	set @SQLExec = 'if exists (select [id] from [sysobjects] where [id] = object_id(N''[' + @name + ']'') and objectproperty([ID], N''IsView'') = 1) drop view [' + @name + ']'

	exec sp_executesql @SQLExec

	set @iLoop = @iLoop + 1

end
GO

/**********************************************************************************************************

									*** v6.0.74 (Drop & Create views) ***

***********************************************************************************************************/
if exists (select [id] from [sysobjects] where id = object_id(N'[ess.Properties]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if exists (select [id] from [ess.Properties] where ([AppVersion] in('v6.0.53', 'v6.0.54', 'v6.0.55', 'v6.0.56', 'v6.0.57')))
	begin

		delete from [ess.WFLU] where ([WFType] in('Onboarding', 'Terminations', 'Transfers'))

		delete from [ess.WFAppTypeLU] where ([AppType] in('Onboarding', 'Terminations', 'Transfers'))

		delete from [ess.WFProcLU] where ([TypeID] in(select [ID] from [ess.WFTypeLU] where ([WFType] in('Onboarding', 'Terminations', 'Transfers'))))

		delete from [ess.WFTaskLU] where ([TypeID] in(select [ID] from [ess.WFTypeLU] where ([WFType] in('Onboarding', 'Terminations', 'Transfers'))))

		delete from [ess.WFTypeLU] where ([WFType] in('Onboarding', 'Terminations', 'Transfers'))

		delete from [EmailLU] where ([Type] like 'Onboarding - %' or [Type] like 'Termination - %' or [Type] like 'Transfer - %')

		delete from [MessagingLU] where ([Type] like 'Onboarding - %' or [Type] like 'Termination - %' or [Type] like 'Transfer - %')

		delete from [ParameterLU] where ([Type] in('Onboarding', 'Terminations', 'Transfers'))

	end

end
GO