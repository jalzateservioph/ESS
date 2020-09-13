/**********************************************************************************************************

							*** v6.0.74 (Update existing structures) ***

***********************************************************************************************************/

/* WE HAVE TO DROP THE DEPARTMENT LINK FIRST OTHERWISE WE HAVE ISSUES WITH THE VIEW ess_WFLU UPON CREATION */

if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.WFLU]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'LinkedDepartments')
	alter table [ess.WFLU] drop column [LinkedDepartments]
GO

/* WE HAVE TO DROP THE DEPARTMENT LINK FIRST OTHERWISE WE HAVE ISSUES WITH THE VIEW ess_WFLU UPON CREATION */




if exists (select [id] from [sysobjects] where id = object_id(N'[Personnel]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Personnel]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'PathID')
		alter table [Personnel] add [PathID] [bigint] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Personnel]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'OutOfficeStatus')
		alter table [Personnel] add [OutOfficeStatus] [tinyint] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Personnel]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'TODateSaved')
		alter table [Personnel] add [TODateSaved] [datetime] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Personnel]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'TOUsername')
		alter table [Personnel] add [TOUsername] [nvarchar] (20) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Personnel]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Status')
		alter table [Personnel] add [Status] [nvarchar] (15) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Personnel]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Status')
		alter table [Personnel] add [Status] [nvarchar] (15) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Personnel]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'TransferDate')
		alter table [Personnel] add [TransferDate] [datetime] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Personnel]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'TransferReason')
		alter table [Personnel] add [TransferReason] [nvarchar] (80) null

end
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[Counselling_Conduct]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Counselling_Conduct]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Venue')
		alter table [Counselling_Conduct] add [Venue] [nvarchar] (64) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Counselling_Conduct]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'PathID')
		alter table [Counselling_Conduct] add [PathID] [bigint] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Counselling_Conduct]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'ParentID')
		alter table [Counselling_Conduct] add [ParentID] [bigint] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Counselling_Conduct]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Status')
		alter table [Counselling_Conduct] add [Status] [nvarchar] (15) null

end
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[Counselling_Work_Performance]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Counselling_Work_Performance]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Venue')
		alter table [Counselling_Work_Performance] add [Venue] [nvarchar] (64) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Counselling_Work_Performance]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'PathID')
		alter table [Counselling_Work_Performance] add [PathID] [bigint] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Counselling_Work_Performance]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'ParentID')
		alter table [Counselling_Work_Performance] add [ParentID] [bigint] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Counselling_Work_Performance]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Status')
		alter table [Counselling_Work_Performance] add [Status] [nvarchar] (15) null

end
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess.ModuleLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.ModuleLU]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'TemplateElement')
		alter table [ess.ModuleLU] add [TemplateElement] [nvarchar] (30) null

end
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[TrainingEventLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[TrainingEventLU]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'QtySeatsAvailable')
	begin

		alter table [TrainingEventLU] add [QtySeatsAvailable] [smallint] null

		alter table [dbo].[TrainingEventLU] add constraint [DF_TrainingEventLU_QtySeatsAvailable] default (0) for [QtySeatsAvailable]

	end

end
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[Discipline]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Discipline]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'PathID')
		alter table [Discipline] add [PathID] [bigint] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Discipline]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Status')
		alter table [Discipline] add [Status] [nvarchar] (15) null

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[Timesheets]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Timesheets]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'UseDefault')
		drop table [Timesheets]

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[TimesheetEntries]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[TimesheetEntries]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Type') or not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[TimesheetEntries]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'ItemDate')
		drop table [TimesheetEntries]

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[TimesheetSetup]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[TimesheetSetup]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Text') or not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[TimesheetSetup]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'IsChild')
		drop table [TimesheetSetup]

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[PerfKPA]') and objectproperty([id], N'IsUserTable') = 1)
begin
		
	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[PerfKPA]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Required')
		alter table [PerfKPA] add [Required] [bit] null

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[PerfCSE]') and objectproperty([id], N'IsUserTable') = 1)
begin
		
	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[PerfCSE]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Required')
		alter table [PerfCSE] add [Required] [bit] null

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[PerfEvalKPA]') and objectproperty([id], N'IsUserTable') = 1)
begin
		
	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[PerfEvalKPA]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Required')
		alter table [PerfEvalKPA] add [Required] [bit] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[PerfEvalKPA]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'StickyNotes')
		alter table [PerfEvalKPA] add [StickyNotes] [ntext] null

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.QSubjects]') and objectproperty([id], N'IsUserTable') = 1)
begin
		
	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.QSubjects]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Grade')
		alter table [ess.QSubjects] add [Grade] [nvarchar] (10) null

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[PerfEvalCSE]') and objectproperty([id], N'IsUserTable') = 1)
begin
		
	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[PerfEvalCSE]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Required')
		alter table [PerfEvalCSE] add [Required] [bit] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[PerfEvalCSE]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'StickyNotes')
		alter table [PerfEvalCSE] add [StickyNotes] [ntext] null

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Policy]') and objectproperty([id], N'IsUserTable') = 1)
begin

	declare @length smallint
	declare @typename sysname

	select @length = [scolumns].[length], @typename = [stypes].[name] from [dbo].[syscolumns] as [scolumns] left outer join [dbo].[systypes] as [stypes] on [scolumns].[xtype] = [stypes].[xtype] where ([scolumns].[id] = object_id(N'[dbo].[ess.Policy]')) and ([scolumns].[name] = 'Key')

	if((@length = 25) or ((@length = 50) and ((@typename = 'sysname') or (@typename = 'nvarchar'))))
		alter table [ess.Policy] alter column [Key] [nvarchar] (50) not null

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[Claims]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Claims]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'ClaimID')
		drop table [Claims]

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[MessageResults]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[MessageResults]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'StatusID')
		drop table [MessageResults]

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[EmailResults]') and objectproperty([id], N'IsUserTable') = 1)
begin
		
	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[EmailResults]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Subject')
		alter table [EmailResults] add [Subject] [nvarchar] (256) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[EmailResults]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'ErrorText')
		alter table [EmailResults] add [ErrorText] [ntext] null

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.News]') and objectproperty([id], N'IsUserTable') = 1)
begin
		
	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.News]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'ImageUrl')
		alter table [ess.News] add [ImageUrl] [nvarchar] (128) null

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[EmailLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[EmailLU]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'BodyText')
		alter table [EmailLU] add [BodyText] [ntext] null

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Documents]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.Documents]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Accepted')
		alter table [ess.Documents] add [Accepted] [bit] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.Documents]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'DateRead')
		alter table [ess.Documents] add [DateRead] [datetime] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.Documents]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'DeclinedReason')
		alter table [ess.Documents] add [DeclinedReason] [nvarchar] (255) null

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[ess.Menu]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[ess.Menu]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'OrderID')
		alter table [ess.Menu] add [OrderID] [smallint] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[ess.Menu]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'HomeType')
		alter table [ess.Menu] add [HomeType] [tinyint] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[ess.Menu]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'HomeImage')
		alter table [ess.Menu] add [HomeImage] [nvarchar] (128) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[ess.Menu]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'HomeDescription')
		alter table [ess.Menu] add [HomeDescription] [nvarchar] (1024) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[ess.Menu]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'HomeTooltip')
		alter table [ess.Menu] add [HomeTooltip] [ntext] null

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[ess.ReportsLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[ess.ReportsLU]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'SQL')
	begin

		declare @isnullable int

		select @isnullable = [isnullable] from dbo.syscolumns where [id] = object_id(N'[dbo].[ess.ReportsLU]') and [name] = 'SQL'

		if(not @isnullable = 1)
		begin

			alter table [ess.ReportsLU] alter column [SQL] [ntext] null

			update [ess.ReportsLU] set [SQL] = null where ([SQL] like '')

		end

	end

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[ess.Menu]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[ess.Menu]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'OrderID')
	begin

		declare @isnullable int

		select @isnullable = [isnullable] from dbo.syscolumns where [id] = object_id(N'[dbo].[ess.Menu]') and [name] = 'OrderID'

		if(@isnullable = 1)
		begin

			update [ess.Menu] set [OrderID] = ([id] - 1)

			alter table [ess.Menu] alter column [OrderID] [smallint] not null

		end

	end

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Menu]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.Menu]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'HomepageType') and not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.Menu]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'HomeType')
		exec sp_rename N'dbo.[ess.Menu].HomepageType', N'HomeType', 'COLUMN' 

	if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.Menu]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'HomepageImage') and not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.Menu]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'HomeImage')
		exec sp_rename N'dbo.[ess.Menu].HomepageImage', N'HomeImage', 'COLUMN' 

	if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.Menu]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'HomepageDescription') and not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.Menu]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'HomeDescription')
		exec sp_rename N'dbo.[ess.Menu].HomepageDescription', N'HomeDescription', 'COLUMN' 

	if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.Menu]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'HomepageTooltip') and not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.Menu]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'HomeTooltip')
		exec sp_rename N'dbo.[ess.Menu].HomepageTooltip', N'HomeTooltip', 'COLUMN' 

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[ess.Path]') and objectproperty([id], N'IsUserTable') = 1)
begin

	declare @length smallint
	declare @typename sysname

	select @length = [scolumns].[length], @typename = [stypes].[name] from [dbo].[syscolumns] as [scolumns] left outer join [dbo].[systypes] as [stypes] on [scolumns].[xtype] = [stypes].[xtype] where ([scolumns].[id] = object_id(N'[dbo].[ess.Path]')) and ([scolumns].[name] = 'UserEmail')

	if((@length = 45) or ((@length = 90) and ((@typename = 'sysname') or (@typename = 'nvarchar'))))
		alter table [ess.Path] alter column [UserEmail] [nvarchar] (80) null

	select @length = [scolumns].[length], @typename = [stypes].[name] from [dbo].[syscolumns] as [scolumns] left outer join [dbo].[systypes] as [stypes] on [scolumns].[xtype] = [stypes].[xtype] where ([scolumns].[id] = object_id(N'[dbo].[ess.Path]')) and ([scolumns].[name] = 'OriginatorEmail')

	if((@length = 50) or ((@length = 100) and ((@typename = 'sysname') or (@typename = 'nvarchar'))))
		alter table [ess.Path] alter column [OriginatorEmail] [nvarchar] (80) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[ess.Path]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'XMLTag')
		alter table [ess.Path] add [XMLTag] [nvarchar] (512) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[ess.Path]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'UserCell')
		alter table [ess.Path] add [UserCell] [nvarchar] (50) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[ess.Path]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'OriginatorCell')
		alter table [ess.Path] add [OriginatorCell] [nvarchar] (50) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[ess.Path]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'SMSCC')
		alter table [ess.Path] add [SMSCC] [nvarchar] (25) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[ess.Path]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'SMSOrigCC')
		alter table [ess.Path] add [SMSOrigCC] [nvarchar] (25) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[ess.Path]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'SMSActCC')
		alter table [ess.Path] add [SMSActCC] [nvarchar] (25) null

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Policy]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.Policy]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Cascade')
		alter table [ess.Policy] add [Cascade] [bit] not null constraint [DF_ess.Policy_Cascade] default (0)

	update [ess.Policy] set [AssemblyID] = 2 where ([Key] = 'CostCentreAlloc')

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.PolicyItems]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.PolicyItems]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Validation')
		alter table [ess.PolicyItems] add [Validation] [ntext] null

end
GO

if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.Properties]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'HTMLTemplate')
	alter table [ess.Properties] drop column [HTMLTemplate]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WF]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.WF]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'SkipCondition')
		alter table [ess.WF] add [SkipCondition] [bit] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.WF]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'SMSID')
		alter table [ess.WF] add [SMSID] [tinyint] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.WF]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'SMSCC')
		alter table [ess.WF] add [SMSCC] [nvarchar] (25) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.WF]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'SMSOrigID')
		alter table [ess.WF] add [SMSOrigID] [tinyint] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.WF]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'SMSOrigCC')
		alter table [ess.WF] add [SMSOrigCC] [nvarchar] (25) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.WF]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'SMSActID')
		alter table [ess.WF] add [SMSActID] [tinyint] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.WF]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'SMSActCC')
		alter table [ess.WF] add [SMSActCC] [nvarchar] (25) null

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[ess.WF]') and objectproperty([id], N'IsUserTable') = 1)
begin

	declare @length smallint
	declare @typename sysname

	select @length = [scolumns].[length], @typename = [stypes].[name] from [dbo].[syscolumns] as [scolumns] left outer join [dbo].[systypes] as [stypes] on [scolumns].[xtype] = [stypes].[xtype] where ([scolumns].[id] = object_id(N'[dbo].[ess.WFAudit]')) and ([scolumns].[name] = 'UserEmail')

	if((@length = 45) or ((@length = 90) and ((@typename = 'sysname') or (@typename = 'nvarchar'))))
		alter table [ess.WFAudit] alter column [UserEmail] [nvarchar] (80) null

	select @length = [scolumns].[length], @typename = [stypes].[name] from [dbo].[syscolumns] as [scolumns] left outer join [dbo].[systypes] as [stypes] on [scolumns].[xtype] = [stypes].[xtype] where ([scolumns].[id] = object_id(N'[dbo].[ess.WFAudit]')) and ([scolumns].[name] = 'OriginatorEmail')

	if((@length = 50) or ((@length = 100) and ((@typename = 'sysname') or (@typename = 'nvarchar'))))
		alter table [ess.WFAudit] alter column [OriginatorEmail] [nvarchar] (80) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[ess.WFAudit]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'UserCell')
		alter table [ess.WFAudit] add [UserCell] [nvarchar] (50) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[ess.WFAudit]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'OriginatorCell')
		alter table [ess.WFAudit] add [OriginatorCell] [nvarchar] (50) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[ess.WFAudit]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'SMSCC')
		alter table [ess.WFAudit] add [SMSCC] [nvarchar] (25) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[ess.WFAudit]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'SMSOrigCC')
		alter table [ess.WFAudit] add [SMSOrigCC] [nvarchar] (25) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[ess.WFAudit]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'SMSActCC')
		alter table [ess.WFAudit] add [SMSActCC] [nvarchar] (25) null		

end
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess.WFTypeLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[ess.WFTypeLU]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Tablename')
		alter table [ess.WFTypeLU] add [Tablename] [nvarchar] (128) null

end
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[Grievance]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Grievance]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'CapturedByUsername')
		alter table [Grievance] add [CapturedByUsername] [nvarchar] (20) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Grievance]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'CapturedDate')
		alter table [Grievance] add [CapturedDate] [datetime] null

end
GO

if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Leave]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'TemplateCode')
	alter table [Leave] add [TemplateCode] [nvarchar] (10) null
GO

if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[LeaveAdjustments]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'PathID')
	alter table [LeaveAdjustments] add [PathID] [bigint] null
GO

if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Loan]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'LoanStatus' and [syscol].[cdefault] = 0)
	alter table [Loan] add constraint [DF_Loan_LoanStatus] default 'Not Submitted' for [LoanStatus]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[PerfEvalCSE]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[PerfEvalCSE]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'RangeType')
		alter table [PerfEvalCSE] add [RangeType] [nvarchar] (15) null

end
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[PerfEvalCSE]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[PerfEvalCSE]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'RangeType')
		update [PerfEvalCSE] set [RangeType] = (select [RangeType] from [PerfCSE] where ([SchemeCode] = [PerfEvalCSE].[SchemeCode] and [ClassCode] = [PerfEvalCSE].[ClassCode] and [KPACode] = [PerfEvalCSE].[KPACode] and [CSEName] = [PerfEvalCSE].[CSEName])) where ([RangeType] is null)

end
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[PerfEvalKPA]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[PerfEvalKPA]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'RangeType')
		alter table [PerfEvalKPA] add [RangeType] [nvarchar] (15) null

end
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[PerfEvalKPA]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[PerfEvalKPA]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'RangeType')
		update [PerfEvalKPA] set [RangeType] = (select [RangeType] from [PerfKPA] where ([SchemeCode] = [PerfEvalKPA].[SchemeCode] and [ClassCode] = [PerfEvalKPA].[ClassCode] and [KPACode] = [PerfEvalKPA].[KPACode])) where ([RangeType] is null)

end
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[PerfScheme]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[PerfScheme]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'ESSCreated')
		alter table [PerfScheme] add [ESSCreated] [bit] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[PerfScheme]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'MultiColumn')
		alter table [PerfScheme] add [MultiColumn] [bit] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[PerfScheme]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'WFName')
		alter table [PerfScheme] add [WFName] [nvarchar] (50) null

end
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[PerfEvalScheme]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[PerfEvalScheme]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'GroupRole')
		alter table [PerfEvalScheme] add [GroupRole] [nvarchar] (35) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[PerfEvalScheme]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'GroupName')
		alter table [PerfEvalScheme] add [GroupName] [nvarchar] (50) null

end
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[PersonnelDocLink]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[PersonnelDocLink]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'ESSPath')
		alter table [PersonnelDocLink] add [ESSPath] [nvarchar] (255) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[PersonnelDocLink]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'PathID')
		alter table [PersonnelDocLink] add [PathID] [bigint] null

end
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[PersonnelHistoryLog]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[PersonnelHistoryLog]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Status')
		alter table [PersonnelHistoryLog] add [Status] [nvarchar] (15) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[PersonnelHistoryLog]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'PathID')
		alter table [PersonnelHistoryLog] add [PathID] [bigint] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[PersonnelHistoryLog]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'PathQuery')
		alter table [PersonnelHistoryLog] add [PathQuery] [nvarchar] (512) null

end
GO

if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[StoreIssued]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'StoreStatus' and [syscol].[cdefault] = 0)
	alter table [StoreIssued] add constraint [DF_StoreIssued_StoreStatus] default 'Not Submitted' for [StoreStatus]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[TrainingPlanned]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[TrainingPlanned]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'TemplateCode')
		alter table [TrainingPlanned] add [TemplateCode] [nvarchar] (10) null

end
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[Users]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[Users]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'ActivationKey')
		alter table [Users] add [ActivationKey] [nvarchar] (24) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[Users]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'PathID')
		alter table [Users] add [PathID] [bigint] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[Users]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'DefaultUser')
		alter table [Users] add [DefaultUser] [bit] null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[Users]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'ADUsername')
		alter table [Users] add [ADUsername] [nvarchar] (128) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[Users]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'ChipnPin')
		alter table [Users] add [ChipnPin] [nvarchar] (10) null

	if not exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[Users]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'ChipnPinSent')
		alter table [Users] add [ChipnPinSent] [datetime] null

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[Users]') and objectproperty([id], N'IsUserTable') = 1)
begin

	declare @xtype tinyint
	declare @isnullable int
	declare @cdefault int

	select @xtype = [xtype], @isnullable = [isnullable], @cdefault = [cdefault] from dbo.syscolumns where [id] = object_id(N'[dbo].[Users]') and [name] = 'DefaultUser'

	if(@isnullable = 1)
		update [Users] set [DefaultUser] = 0

	if((@xtype <> 104) or (@isnullable = 1))
		alter table [Users] alter column [DefaultUser] [bit] not null

	if(@cdefault <> (select [id] from [sysobjects] where [name] = 'UW_ZeroDefault'))
		exec sp_bindefault N'[dbo].[UW_ZeroDefault]', N'[Users].[DefaultUser]'

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[TimesheetSetup]') and objectproperty([id], N'IsUserTable') = 1)
begin

	declare @xtype tinyint
	declare @isnullable int
	declare @cdefault int

	select @xtype = [xtype], @isnullable = [isnullable], @cdefault = [cdefault] from dbo.syscolumns where [id] = object_id(N'[dbo].[TimesheetSetup]') and [name] = 'IsChild'

	if(@isnullable = 1)
		update [TimesheetSetup] set [IsChild] = 0

	if((@xtype <> 104) or (@isnullable = 1))
		alter table [TimesheetSetup] alter column [IsChild] [bit] not null

	if(@cdefault <> (select [id] from [sysobjects] where [name] = 'UW_ZeroDefault'))
		exec sp_bindefault N'[dbo].[UW_ZeroDefault]', N'[TimesheetSetup].[IsChild]'

end
GO

/**********************************************************************************************************

							*** v6.0.74 (Update existing data) ***

***********************************************************************************************************/
if exists (select [id] from [sysobjects] where [id] = object_id(N'[EmailLU]') and objectproperty([ID], N'IsUserTable') = 1)
	alter table [EmailLU] alter column [Address] [nvarchar] (128) not null
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[EmailResults]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[EmailResults]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'From')
		alter table [EmailResults] alter column [From] [nvarchar] (128) not null

	if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where [sysobj].[id] = object_id(N'[EmailResults]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'To')
		alter table [EmailResults] alter column [To] [nvarchar] (128) not null

	if exists (select [syscol].[id] from [syscolumns] as [syscol] left outer join [sysobjects] as [sysobj] on [syscol].[id] = [sysobj].[id] where sysobj.[id] = object_id(N'[dbo].[EmailResults]') and objectproperty([sysobj].[id], N'IsUserTable') = 1 and [syscol].[name] = 'Status')
	begin

		declare @length smallint
		declare @typename sysname

		select @length = [scolumns].[length], @typename = [stypes].[name] from [dbo].[syscolumns] as [scolumns] left outer join [dbo].[systypes] as [stypes] on [scolumns].[xtype] = [stypes].[xtype] where ([scolumns].[id] = object_id(N'[dbo].[EmailResults]')) and ([scolumns].[name] = 'Status')

		if(@typename = 'ntext')
		begin

			truncate table [EmailResults]

			alter table [EmailResults] alter column [Status] [nvarchar] (25) not null

		end

	end

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[AssemblyLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	update [AssemblyLU] set [Assembly] = 'DevExpress.Web.ASPxEditors.v11.1.dll' where ([Assembly] like 'DevExpress.Web.ASPxEditors.v%.dll')

	update [AssemblyLU] set [Assembly] = 'DevExpress.Web.ASPxGridView.v11.1.dll' where ([Assembly] like 'DevExpress.Web.ASPxGridView.v%.dll')

	update [AssemblyLU] set [Assembly] = 'DevExpress.Web.v11.1.dll' where ([Assembly] like 'DevExpress.Web.v%.dll')

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Properties]') and objectproperty([id], N'IsUserTable') = 1)
begin

	alter table [ess.Properties] alter column [AppVersion] [nvarchar] (15) not null

	alter table [ess.Properties] alter column [DBVersion] [nvarchar] (15) not null

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Properties]') and objectproperty([id], N'IsUserTable') = 1)
begin

	update [ess.Properties] set [AppVersion] = 'v6.0.74', [DBVersion] = 'v6.0.74'

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[PerfClass]') and objectproperty([id], N'IsUserTable') = 1)
	update [PerfClass] set [Description] = 'Employee Self Service Class: auto generated, do not delete.' where ([Description] = 'Employee Self Service Class [Auto-Generated] - do not delete this class!')
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[PersonnelDocLink]') and objectproperty([id], N'IsUserTable') = 1)
begin

	update [PersonnelDocLink] set [DocPath] = replace([DocPath], '\linkdocs\', '\documents\linked\') where ([DocPath] like '%\linkdocs\%')

	update [PersonnelDocLink] set [ESSPath] = replace([ESSPath], 'linkdocs/', '~/documents/linked/') where ([ESSPath] like 'linkdocs/%')

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[EmailLU]') and objectproperty([id], N'IsUserTable') = 1)
	update [EmailLU] set [Subject] = replace([Subject], 'Employee Self Service: ', 'SmartHR: ')
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[MessagingLU]') and objectproperty([id], N'IsUserTable') = 1)
	update [MessagingLU] set [Body] = replace([Body], ', please log onto the Employee Self Service to process', ' - SmartHR')
GO

/*****************************************************************************************************************

*** v6.0.74 (Update NULL bit fields / non linked defaults to add default UW_ZeroDefault to those columns) ***

*****************************************************************************************************************/
declare @i bigint,
		@count bigint,
		@sqlexec nvarchar(4000),
		@rvalue int,
		@name sysname,
		@column sysname

declare @default table
(
	[ID] bigint identity (1, 1) not null,
	[name] sysname not null,
	[column] sysname not null
)

insert into @default([name], [column]) select (select [name] from [sysobjects] where ([ID] = [syscolumns].[id])), [name] from [syscolumns] where (not (select [name] from [sysobjects] where ([ID] = [syscolumns].[id])) like 'sys%' and (objectproperty([id], N'IsUserTable') = 1) and not (columnproperty([id], [name], 'IsIdentity') = 1) and not (columnproperty([id], [name], 'IsRowGuidCol') = 1) and ([isnullable] = 0) and ([cdefault] = 0) and ([iscomputed] = 0) and [xtype] in(select [xtype] from [systypes] where ([name] = 'bit')))

set @i = 1

select @count = count([ID]) from @default

while (@i <= @count)
begin

	select @name = [name], @column = [column] from @default where ([ID] = @i)

	set @sqlexec = 'update [' + @name + '] set [' + @column + '] = 0 where ([' + @column + '] is null)'

	exec @rvalue = sp_executesql @sqlexec

	set @sqlexec = 'alter table [' + @name + '] alter column [' + @column + '] [bit] not null'

	exec @rvalue = sp_executesql @sqlexec

	set @sqlexec = '[' + @name + '].[' + @column + ']'

	exec sp_bindefault N'[dbo].[UW_ZeroDefault]', @sqlexec

	set @i = @i + 1

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Path]') and objectproperty([id], N'IsUserTable') = 1)
	update [PerfEvalScheme] set [AppraiserCompNum] = (select [PrevActionerCompNum] from [ess.Path] where ([ID] = [PerfEvalScheme].[PathID])), [AppraiserEmpNum] = (select [PrevActionerEmpNum] from [ess.Path] where ([ID] = [PerfEvalScheme].[PathID])) where (not [PathID] is null and not (select [PrevActionerCompNum] from [ess.Path] where ([ID] = [PerfEvalScheme].[PathID])) is null and not (select [PrevActionerEmpNum] from [ess.Path] where ([ID] = [PerfEvalScheme].[PathID])) is null)
GO