/**********************************************************************************************************

								*** v6.0.74 (Drop & Create triggers) ***

***********************************************************************************************************/
set QUOTED_IDENTIFIER off 
GO
set ANSI_NULLS on 
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Company_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.Company_DTrig]
GO

create trigger [dbo].[ess.Company_DTrig] on [dbo].[Company]
for delete
as

if (select count([ess.SQLExecute].[ID]) from [ess.SQLExecute], [deleted] where ([ess.SQLExecute].[Executed] = 0 and ([ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' or [ess.SQLExecute].[SQLData] like '%<CompanyNum=' + [deleted].[CompanyNum] + '>%'))) > 0
begin

    raiserror 50000 'The record can''t be removed as it has pending transfers.'

    rollback transaction

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Company_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.Company_UTrig]
GO

create trigger [dbo].[ess.Company_UTrig] on [dbo].[Company]
for update
as

/* CASCADE UPDATES TO 'ess.SQLExecute' */
if update([CompanyNum])
begin
       update [ess.SQLExecute]
       set [ess.SQLExecute].[SQLData] = replace(replace(cast([ess.SQLExecute].[SQLData] as nvarchar(4000)), '<CompanyNum=' + [deleted].[CompanyNum] + '>', '<CompanyNum=' + [inserted].[CompanyNum] + '>'), '<OldCompanyNum=' + [deleted].[CompanyNum] + '>', '<OldCompanyNum=' + [inserted].[CompanyNum] + '>')
       from [Company], [deleted], [inserted]
       where [ess.SQLExecute].[Executed] = 0 and ([ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' or [ess.SQLExecute].[SQLData] like '%<CompanyNum=' + [deleted].[CompanyNum] + '>%')
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.JobTitle_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.JobTitle_DTrig]
GO

create trigger [dbo].[ess.JobTitle_DTrig] on [dbo].[JobTitle] 
for delete
as

if (select count([ess.SQLExecute].[ID]) from [ess.SQLExecute], [deleted] where ([ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' and [ess.SQLExecute].[SQLData] like '%<JobTitle=' + [deleted].[JobTitle] + '>%')) > 0
begin

    raiserror 50000 'The record can''t be removed as it has pending transfers.'

    rollback transaction

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.JobTitle_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.JobTitle_UTrig]
GO

create trigger [dbo].[ess.JobTitle_UTrig] on [dbo].[JobTitle]
for update
as

/* CASCADE UPDATES TO 'ess.SQLExecute' */
if update([JobTitle])
begin
       update [ess.SQLExecute]
       set [ess.SQLExecute].[SQLData] = replace(cast([ess.SQLExecute].[SQLData] as nvarchar(4000)), '<JobTitle=' + [deleted].[JobTitle] + '>', '<JobTitle=' + [inserted].[JobTitle] + '>')
       from [JobTitle], [deleted], [inserted]
       where [ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' and [ess.SQLExecute].[SQLData] like '%<JobTitle=' + [deleted].[JobTitle] + '>%'
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.JobGrade_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.JobGrade_DTrig]
GO

create trigger [dbo].[ess.JobGrade_DTrig] on [dbo].[JobGrade]
for delete
as

if (select count([ess.SQLExecute].[ID]) from [ess.SQLExecute], [deleted] where ([ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' and [ess.SQLExecute].[SQLData] like '%<JobGrade=' + [deleted].[JobGrade] + '>%')) > 0
begin

    raiserror 50000 'The record can''t be removed as it has pending transfers.'

    rollback transaction

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.JobGrade_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.JobGrade_UTrig]
GO

create trigger [dbo].[ess.JobGrade_UTrig] on [dbo].[JobGrade]
for update
as

/* CASCADE UPDATES TO 'ess.SQLExecute' */
if update([JobGrade])
begin
       update [ess.SQLExecute]
       set [ess.SQLExecute].[SQLData] = replace(cast([ess.SQLExecute].[SQLData] as nvarchar(4000)), '<JobGrade=' + [deleted].[JobGrade] + '>', '<JobGrade=' + [inserted].[JobGrade] + '>')
       from [JobGrade], [deleted], [inserted]
       where [ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' and [ess.SQLExecute].[SQLData] like '%<JobGrade=' + [deleted].[JobGrade] + '>%'
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.JobGradeBandLU_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.JobGradeBandLU_DTrig]
GO

create trigger [dbo].[ess.JobGradeBandLU_DTrig] on [dbo].[JobGradeBandLU]
for delete
as

if (select count([ess.SQLExecute].[ID]) from [ess.SQLExecute], [deleted] where ([ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' and [ess.SQLExecute].[SQLData] like '%<JobGradeBand=' + [deleted].[JobGradeBand] + '>%')) > 0
begin

    raiserror 50000 'The record can''t be removed as it has pending transfers.'

    rollback transaction

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.JobGradeBandLU_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.JobGradeBandLU_UTrig]
GO

create trigger [dbo].[ess.JobGradeBandLU_UTrig] on [dbo].[JobGradeBandLU]
for update
as

/* CASCADE UPDATES TO 'ess.SQLExecute' */
if update([JobGradeBand])
begin
       update [ess.SQLExecute]
       set [ess.SQLExecute].[SQLData] = replace(cast([ess.SQLExecute].[SQLData] as nvarchar(4000)), '<JobGradeBand=' + [deleted].[JobGradeBand] + '>', '<JobGradeBand=' + [inserted].[JobGradeBand] + '>')
       from [JobGradeBandLU], [deleted], [inserted]
       where [ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' and [ess.SQLExecute].[SQLData] like '%<JobGradeBand=' + [deleted].[JobGradeBand] + '>%'
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.StoresItems_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.StoresItems_DTrig]
GO

create trigger [dbo].[ess.StoresItems_DTrig] on [dbo].[StoresItems]
for delete
as

if (select count([ess.SQLExecute].[ID]) from [ess.SQLExecute], [deleted] where ([ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' and [ess.SQLExecute].[SQLData] like '%<ItemCode=' + [deleted].[ItemCode] + '>%')) > 0
begin

    raiserror 50000 'The record can''t be removed as it has pending transfers.'

    rollback transaction

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.StoresItems_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.StoresItems_UTrig]
GO

create trigger [dbo].[ess.StoresItems_UTrig] on [dbo].[StoresItems]
for update
as

/* CASCADE UPDATES TO 'ess.SQLExecute' */
if update([ItemCode])
begin
       update [ess.SQLExecute]
       set [ess.SQLExecute].[SQLData] = replace(cast([ess.SQLExecute].[SQLData] as nvarchar(4000)), '<ItemCode=' + [deleted].[ItemCode] + '>', '<ItemCode=' + [inserted].[ItemCode] + '>')
       from [StoresItems], [deleted], [inserted]
       where [ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' and [ess.SQLExecute].[SQLData] like '%<ItemCode=' + [deleted].[ItemCode] + '>%'
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Team_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.Team_DTrig]
GO

create trigger [dbo].[ess.Team_DTrig] on [dbo].[Team]
for delete
as

if (select count([ess.SQLExecute].[ID]) from [ess.SQLExecute], [deleted] where ([ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' and [ess.SQLExecute].[SQLData] like '%<TeamNum=' + [deleted].[TeamNum] + '>%')) > 0
begin

    raiserror 50000 'The record can''t be removed as it has pending transfers.'

    rollback transaction

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Team_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.Team_UTrig]
GO

create trigger [dbo].[ess.Team_UTrig] on [dbo].[Team]
for update
as

/* CASCADE UPDATES TO 'ess.SQLExecute' */
if update([TeamNum])
begin
       update [ess.SQLExecute]
       set [ess.SQLExecute].[SQLData] = replace(cast([ess.SQLExecute].[SQLData] as nvarchar(4000)), '<TeamNum=' + [deleted].[TeamNum] + '>', '<TeamNum=' + [inserted].[TeamNum] + '>')
       from [Team], [deleted], [inserted]
       where [ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' and [ess.SQLExecute].[SQLData] like '%<TeamNum=' + [deleted].[TeamNum] + '>%'
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.CostCentreLU_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.CostCentreLU_DTrig]
GO

create trigger [dbo].[ess.CostCentreLU_DTrig] on [dbo].[CostCentreLU]
for delete
as

if (select count([ess.SQLExecute].[ID]) from [ess.SQLExecute], [deleted] where ([ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' and [ess.SQLExecute].[SQLData] like '%<CostCentre=' + [deleted].[CostCentre] + '>%')) > 0
begin

    raiserror 50000 'The record can''t be removed as it has pending transfers.'

    rollback transaction

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.CostCentreLU_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.CostCentreLU_UTrig]
GO

create trigger [dbo].[ess.CostCentreLU_UTrig] on [dbo].[CostCentreLU]
for update
as

/* CASCADE UPDATES TO 'ess.SQLExecute' */
if update([CostCentre])
begin
       update [ess.SQLExecute]
       set [ess.SQLExecute].[SQLData] = replace(cast([ess.SQLExecute].[SQLData] as nvarchar(4000)), '<CostCentre=' + [deleted].[CostCentre] + '>', '<CostCentre=' + [inserted].[CostCentre] + '>')
       from [CostCentreLU], [deleted], [inserted]
       where [ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' and [ess.SQLExecute].[SQLData] like '%<CostCentre=' + [deleted].[CostCentre] + '>%'
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Department_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.Department_DTrig]
GO

create trigger [dbo].[ess.Department_DTrig] on [dbo].[Department]
for delete
as

if (select count([ess.SQLExecute].[ID]) from [ess.SQLExecute], [deleted] where ([ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' and [ess.SQLExecute].[SQLData] like '%<DeptName=' + [deleted].[DeptName] + '>%')) > 0
begin

    raiserror 50000 'The record can''t be removed as it has pending transfers.'

    rollback transaction

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Department_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.Department_UTrig]
GO

create trigger [dbo].[ess.Department_UTrig] on [dbo].[Department]
for update
as

/* CASCADE UPDATES TO 'ess.SQLExecute' */
if update([DeptName])
begin
       update [ess.SQLExecute]
       set [ess.SQLExecute].[SQLData] = replace(cast([ess.SQLExecute].[SQLData] as nvarchar(4000)), '<DeptName=' + [deleted].[DeptName] + '>', '<DeptName=' + [inserted].[DeptName] + '>')
       from [Department], [deleted], [inserted]
       where [ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' and [ess.SQLExecute].[SQLData] like '%<DeptName=' + [deleted].[DeptName] + '>%'
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ShiftTypeLU_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.ShiftTypeLU_DTrig]
GO

create trigger [dbo].[ess.ShiftTypeLU_DTrig] on [dbo].[ShiftTypeLU]
for delete
as

if (select count([ess.SQLExecute].[ID]) from [ess.SQLExecute], [deleted] where ([ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' and [ess.SQLExecute].[SQLData] like '%<ShiftType=' + [deleted].[ShiftType] + '>%')) > 0
begin

    raiserror 50000 'The record can''t be removed as it has pending transfers.'

    rollback transaction

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ShiftTypeLU_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.ShiftTypeLU_UTrig]
GO

create trigger [dbo].[ess.ShiftTypeLU_UTrig] on [dbo].[ShiftTypeLU]
for update
as

/* CASCADE UPDATES TO 'ess.SQLExecute' */
if update([ShiftType])
begin
       update [ess.SQLExecute]
       set [ess.SQLExecute].[SQLData] = replace(cast([ess.SQLExecute].[SQLData] as nvarchar(4000)), '<ShiftType=' + [deleted].[ShiftType] + '>', '<ShiftType=' + [inserted].[ShiftType] + '>')
       from [ShiftTypeLU], [deleted], [inserted]
       where [ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' and [ess.SQLExecute].[SQLData] like '%<ShiftType=' + [deleted].[ShiftType] + '>%'
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.LocationLU_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.LocationLU_DTrig]
GO

create trigger [dbo].[ess.LocationLU_DTrig] on [dbo].[LocationLU]
for delete
as

if (select count([ess.SQLExecute].[ID]) from [ess.SQLExecute], [deleted] where ([ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' and [ess.SQLExecute].[SQLData] like '%<Location=' + [deleted].[Location] + '>%')) > 0
begin

    raiserror 50000 'The record can''t be removed as it has pending transfers.'

    rollback transaction

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.LocationLU_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.LocationLU_UTrig]
GO

create trigger [dbo].[ess.LocationLU_UTrig] on [dbo].[LocationLU]
for update
as

/* CASCADE UPDATES TO 'ess.SQLExecute' */
if update([Location])
begin
       update [ess.SQLExecute]
       set [ess.SQLExecute].[SQLData] = replace(cast([ess.SQLExecute].[SQLData] as nvarchar(4000)), '<Location=' + [deleted].[Location] + '>', '<Location=' + [inserted].[Location] + '>')
       from [LocationLU], [deleted], [inserted]
       where [ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' and [ess.SQLExecute].[SQLData] like '%<Location=' + [deleted].[Location] + '>%'
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.CommitteeLU_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.CommitteeLU_DTrig]
GO

create trigger [dbo].[ess.CommitteeLU_DTrig] on [dbo].[CommitteeLU]
for delete
as

if (select count([ess.SQLExecute].[ID]) from [ess.SQLExecute], [deleted] where ([ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' and [ess.SQLExecute].[SQLData] like '%<Committee=' + [deleted].[Committee] + '>%')) > 0
begin

    raiserror 50000 'The record can''t be removed as it has pending transfers.'

    rollback transaction

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.CommitteeLU_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.CommitteeLU_UTrig]
GO

create trigger [dbo].[ess.CommitteeLU_UTrig] on [dbo].[CommitteeLU]
for update
as

/* CASCADE UPDATES TO 'ess.SQLExecute' */
if update([Committee])
begin
       update [ess.SQLExecute]
       set [ess.SQLExecute].[SQLData] = replace(cast([ess.SQLExecute].[SQLData] as nvarchar(4000)), '<Committee=' + [deleted].[Committee] + '>', '<Committee=' + [inserted].[Committee] + '>')
       from [CommitteeLU], [deleted], [inserted]
       where [ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' and [ess.SQLExecute].[SQLData] like '%<Committee=' + [deleted].[Committee] + '>%'
end
GO

declare @table sysname
declare @execSQL nvarchar(4000)

declare pathCur cursor for
	select [sobj].[name] from [syscolumns] as [scol] left outer join [sysobjects] as [sobj] on [scol].[id] = [sobj].[id] where ([scol].[name] = 'PathID') and (objectproperty([sobj].[id], N'IsTable') = 1)

open pathCur

	fetch next from pathCur into @table
	
	while @@FETCH_STATUS = 0
	
	begin

		set @execSQL = N'if exists (select [id] from [sysobjects] where [id] = object_id(N''[dbo].[ess.' + REPLACE(@table, 'ess.', '') + '_DTrig]'') and objectproperty([id], N''IsTrigger'') = 1) drop trigger [dbo].[ess.' + REPLACE(@table, 'ess.', '') + '_DTrig]'	

		exec sp_executesql @execSQL

		set @execSQL = N'if exists (select [id] from [sysobjects] where [id] = object_id(N''[dbo].[ess.' + REPLACE(@table, 'ess.', '') + '_UTrigPathN]'') and objectproperty([id], N''IsTrigger'') = 1) drop trigger [dbo].[ess.' + REPLACE(@table, 'ess.', '') + '_UTrigPathN]'	

		exec sp_executesql @execSQL

		fetch next from pathCur into @table
	
	end

close pathCur

deallocate pathCur
GO

declare @table sysname
declare @execSQL nvarchar(4000)

declare pathCur cursor for
	select [sobj].[name] from [syscolumns] as [scol] left outer join [sysobjects] as [sobj] on [scol].[id] = [sobj].[id] where (not [sobj].[name] in('ess.PerfSubmitted', 'ess.RoutingRules') and [scol].[name] = 'PathID') and (objectproperty([sobj].[id], N'IsTable') = 1)

open pathCur

	fetch next from pathCur into @table
	
	while @@FETCH_STATUS = 0
	
	begin

		set @execSQL = N'if exists (select [id] from [sysobjects] where [id] = object_id(N''[dbo].[ess.' + REPLACE(@table, 'ess.', '') + '_DTrig]'') and objectproperty([id], N''IsTrigger'') = 1) drop trigger [dbo].[ess.' + REPLACE(@table, 'ess.', '') + '_DTrig]'

		exec sp_executesql @execSQL

		set @execSQL = N'if exists (select [id] from [sysobjects] where [id] = object_id(N''[dbo].[ess.' + REPLACE(@table, 'ess.', '') + '_UTrigPathN]'') and objectproperty([id], N''IsTrigger'') = 1) drop trigger [dbo].[ess.' + REPLACE(@table, 'ess.', '') + '_UTrigPathN]'

		exec sp_executesql @execSQL

		set @execSQL = N'create trigger [dbo].[ess.' + REPLACE(@table, 'ess.', '') + '_DTrig] on [dbo].[' + @table + ']' + char(13) + char(10) + 'for delete' + char(13) + char(10) + 'as' + char(13) + char(10) + char(13) + char(10) + 'delete [ess.Path] from [deleted], [ess.Path] where [deleted].[PathID] = [ess.Path].[id]'

		exec sp_executesql @execSQL

		set @execSQL = N'create trigger [dbo].[ess.' + REPLACE(@table, 'ess.', '') + '_UTrigPathN] on [dbo].[' + @table + ']' + char(13) + char(10) + 'after update' + char(13) + char(10) + 'as' + char(13) + char(10) + char(13) + char(10) + 'if (update([PathID]))' + char(13) + char(10) + char(9) + 'delete [ess.Path] from [deleted], [ess.Path], [inserted] where [ess.Path].[ID] = [deleted].[PathID] and [inserted].[PathID] is null'

		exec sp_executesql @execSQL

		fetch next from pathCur into @table
	
	end

close pathCur

deallocate pathCur
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.TimesheetSetup_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.TimesheetSetup_DTrig]
GO

create trigger [dbo].[ess.TimesheetSetup_DTrig] on [dbo].[TimesheetSetup] 
for delete
as

delete [TimesheetMappingLU] from [deleted], [TimesheetMappingLU] where [deleted].[ID] = [TimesheetMappingLU].[ColumnID]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[TimesheetTypeLU_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[TimesheetTypeLU_DTrig]
GO

create trigger [dbo].[TimesheetTypeLU_DTrig] on [dbo].[TimesheetTypeLU] 
for delete
as

if (select count([Timesheets].[Type]) from [Timesheets], [deleted] where ([Timesheets].[Type] = [deleted].[ItemType])) > 0
begin

    raiserror 50000 'The record can''t be removed as it has linked Timesheet items.'

    rollback transaction

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[TimesheetTypeLU_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[TimesheetTypeLU_UTrig]
GO

create trigger [dbo].[TimesheetTypeLU_UTrig] on [dbo].[TimesheetTypeLU]
for update
as

/* CASCADE UPDATES TO 'Timesheets' */
if update([ItemType])
begin
       update [Timesheets]
       set [Timesheets].[Type] = [inserted].[ItemType]
       from [TimesheetTypeLU], [deleted], [inserted]
       where [deleted].[ItemType] = [Timesheets].[Type]
end

/* CASCADE UPDATES TO 'TimesheetMappingLU' */
if update([ItemType])
begin
       update [TimesheetMappingLU]
       set [TimesheetMappingLU].[ItemType] = [inserted].[ItemType]
       from [TimesheetTypeLU], [deleted], [inserted]
       where [deleted].[ItemType] = [TimesheetMappingLU].[ItemType]
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[Timesheets_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[Timesheets_DTrig]
GO

create trigger [dbo].[Timesheets_DTrig] on [dbo].[Timesheets]
for delete
as

delete [TimesheetEntries] from [deleted], [TimesheetEntries] where [deleted].[CompanyNum] = [TimesheetEntries].[CompanyNum] and [deleted].[EmployeeNum] = [TimesheetEntries].[EmployeeNum] and [deleted].[Start] = [TimesheetEntries].[Start] and [deleted].[Until] = [TimesheetEntries].[Until] and [deleted].[Type] = [TimesheetEntries].[Type]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[TimesheetEntries_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[TimesheetEntries_DTrig]
GO

create trigger [dbo].[TimesheetEntries_DTrig] on [dbo].[TimesheetEntries]
for delete
as

delete [TimesheetChildEntries] from [deleted], [TimesheetChildEntries] where [deleted].[CompanyNum] = [TimesheetChildEntries].[CompanyNum] and [deleted].[EmployeeNum] = [TimesheetChildEntries].[EmployeeNum] and [deleted].[Start] = [TimesheetChildEntries].[Start] and [deleted].[Until] = [TimesheetChildEntries].[Until] and [deleted].[Type] = [TimesheetChildEntries].[Type] and [deleted].[ItemDate] = [TimesheetChildEntries].[ItemDate]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[Timesheets_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[Timesheets_UTrig]
GO

create trigger [dbo].[Timesheets_UTrig] on [dbo].[Timesheets]
for update
as

declare @qry bit

/* CASCADE UPDATES TO 'TimesheetEntries' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [TimesheetEntries]
       set [TimesheetEntries].[CompanyNum] = [inserted].[CompanyNum], [TimesheetEntries].[EmployeeNum] = [inserted].[EmployeeNum]
       from [TimesheetEntries], [deleted], [inserted]
       where [deleted].[CompanyNum] = [TimesheetEntries].[CompanyNum] and [deleted].[EmployeeNum] = [TimesheetEntries].[EmployeeNum]
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [TimesheetEntries]
       set [TimesheetEntries].CompanyNum = inserted.CompanyNum
       from [TimesheetEntries], deleted, inserted
       where deleted.CompanyNum = [TimesheetEntries].CompanyNum and deleted.EmployeeNum = [TimesheetEntries].EmployeeNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [TimesheetEntries]
       set [TimesheetEntries].[EmployeeNum] = [inserted].[EmployeeNum]
       from [TimesheetEntries], [deleted], [inserted]
       where [deleted].[CompanyNum] = [TimesheetEntries].[CompanyNum] and [deleted].[EmployeeNum] = [TimesheetEntries].[EmployeeNum]
    set @qry = 1
end
IF update([Start])
begin
       update [TimesheetEntries]
       set [TimesheetEntries].[Start] = [inserted].[Start]
       from [TimesheetEntries], [deleted], [inserted]
       where [deleted].[CompanyNum] = [TimesheetEntries].[CompanyNum] and [deleted].[EmployeeNum] = [TimesheetEntries].[EmployeeNum] and [deleted].[Start] = [TimesheetEntries].[Start]
end
IF update([Until])
begin
       update [TimesheetEntries]
       set [TimesheetEntries].[Until] = [inserted].[Until]
       from [TimesheetEntries], [deleted], [inserted]
       where [deleted].[CompanyNum] = [TimesheetEntries].[CompanyNum] and [deleted].[EmployeeNum] = [TimesheetEntries].[EmployeeNum] and [deleted].[Until] = [TimesheetEntries].[Until]
end
IF update([Type])
begin
       update [TimesheetEntries]
       set [TimesheetEntries].[Type] = [inserted].[Type]
       from [TimesheetEntries], [deleted], [inserted]
       where [deleted].[CompanyNum] = [TimesheetEntries].[CompanyNum] and [deleted].[EmployeeNum] = [TimesheetEntries].[EmployeeNum] and [deleted].[Start] = [TimesheetEntries].[Start] and [deleted].[Until] = [TimesheetEntries].[Until] and [deleted].[Type] = [TimesheetEntries].[Type]
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[TimesheetEntries_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[TimesheetEntries_UTrig]
GO

create trigger [dbo].[TimesheetEntries_UTrig] on [dbo].[TimesheetEntries]
for update
as

declare @qry bit

/* CASCADE UPDATES TO 'TimesheetChildEntries' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [TimesheetChildEntries]
       set [TimesheetChildEntries].[CompanyNum] = [inserted].[CompanyNum], [TimesheetChildEntries].[EmployeeNum] = [inserted].[EmployeeNum]
       from [TimesheetChildEntries], [deleted], [inserted]
       where [deleted].[CompanyNum] = [TimesheetChildEntries].[CompanyNum] and [deleted].[EmployeeNum] = [TimesheetChildEntries].[EmployeeNum]
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [TimesheetChildEntries]
       set [TimesheetChildEntries].CompanyNum = inserted.CompanyNum
       from [TimesheetChildEntries], deleted, inserted
       where deleted.CompanyNum = [TimesheetChildEntries].CompanyNum and deleted.EmployeeNum = [TimesheetChildEntries].EmployeeNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [TimesheetChildEntries]
       set [TimesheetChildEntries].[EmployeeNum] = [inserted].[EmployeeNum]
       from [TimesheetChildEntries], [deleted], [inserted]
       where [deleted].[CompanyNum] = [TimesheetChildEntries].[CompanyNum] and [deleted].[EmployeeNum] = [TimesheetChildEntries].[EmployeeNum]
    set @qry = 1
end
IF update([Start])
begin
       update [TimesheetChildEntries]
       set [TimesheetChildEntries].[Start] = [inserted].[Start]
       from [TimesheetChildEntries], [deleted], [inserted]
       where [deleted].[CompanyNum] = [TimesheetChildEntries].[CompanyNum] and [deleted].[EmployeeNum] = [TimesheetChildEntries].[EmployeeNum] and [deleted].[Start] = [TimesheetChildEntries].[Start]
end
IF update([Until])
begin
       update [TimesheetChildEntries]
       set [TimesheetChildEntries].[Until] = [inserted].[Until]
       from [TimesheetChildEntries], [deleted], [inserted]
       where [deleted].[CompanyNum] = [TimesheetChildEntries].[CompanyNum] and [deleted].[EmployeeNum] = [TimesheetChildEntries].[EmployeeNum] and [deleted].[Until] = [TimesheetChildEntries].[Until]
end
IF update([Type])
begin
       update [TimesheetChildEntries]
       set [TimesheetChildEntries].[Type] = [inserted].[Type]
       from [TimesheetChildEntries], [deleted], [inserted]
       where [deleted].[CompanyNum] = [TimesheetChildEntries].[CompanyNum] and [deleted].[EmployeeNum] = [TimesheetChildEntries].[EmployeeNum] and [deleted].[Start] = [TimesheetChildEntries].[Start] and [deleted].[Until] = [TimesheetChildEntries].[Until] and [deleted].[Type] = [TimesheetChildEntries].[Type]
end
IF update([ItemDate])
begin
       update [TimesheetChildEntries]
       set [TimesheetChildEntries].[ItemDate] = [inserted].[ItemDate]
       from [TimesheetChildEntries], [deleted], [inserted]
       where [deleted].[CompanyNum] = [TimesheetChildEntries].[CompanyNum] and [deleted].[EmployeeNum] = [TimesheetChildEntries].[EmployeeNum] and [deleted].[Start] = [TimesheetChildEntries].[Start] and [deleted].[Until] = [TimesheetChildEntries].[Until] and [deleted].[ItemDate] = [TimesheetChildEntries].[ItemDate]
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ClaimSetup_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.ClaimSetup_DTrig]
GO

create trigger [dbo].[ess.ClaimSetup_DTrig] on [dbo].[ClaimSetup] 
for delete
as

delete [ClaimMappingLU] from [deleted], [ClaimMappingLU] where [deleted].[ID] = [ClaimMappingLU].[ColumnID]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ClaimTypeLU_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.ClaimTypeLU_DTrig]
GO

create trigger [dbo].[ess.ClaimTypeLU_DTrig] on [dbo].[ClaimTypeLU] 
for delete
as

if (select count([Claims].[Type]) from [Claims], [deleted] where ([Claims].[Type] = [deleted].[ItemType])) > 0
begin

    raiserror 50000 'The record can''t be removed as it has linked claim items.'

    rollback transaction

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ClaimTypeLU_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ClaimTypeLU_UTrig]
GO

create trigger [dbo].[ClaimTypeLU_UTrig] on [dbo].[ClaimTypeLU]
for update
as

/* CASCADE UPDATES TO 'Claims' */
if update([ItemType])
begin
       update [Claims]
       set [Claims].[Type] = [inserted].[ItemType]
       from [ClaimTypeLU], [deleted], [inserted]
       where [deleted].[ItemType] = [Claims].[Type]
end

/* CASCADE UPDATES TO 'ClaimMappingLU' */
if update([ItemType])
begin
       update [ClaimMappingLU]
       set [ClaimMappingLU].[ItemType] = [inserted].[ItemType]
       from [ClaimTypeLU], [deleted], [inserted]
       where [deleted].[ItemType] = [ClaimMappingLU].[ItemType]
end

/* CASCADE UPDATES TO 'ClaimSubTypeLU' */
if update([ItemType])
begin
       update [ClaimSubTypeLU]
       set [ClaimSubTypeLU].[ItemType] = [inserted].[ItemType]
       from [ClaimTypeLU], [deleted], [inserted]
       where [deleted].[ItemType] = [ClaimSubTypeLU].[ItemType]
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ClaimSubTypeLU_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.ClaimSubTypeLU_DTrig]
GO

create trigger [dbo].[ess.ClaimSubTypeLU_DTrig] on [dbo].[ClaimSubTypeLU] 
for delete
as

if (select count([ClaimEntries].[ItemType]) from [ClaimEntries], [deleted] where ([ClaimEntries].[Type] = [deleted].[ItemType] and [ClaimEntries].[ItemType] = [deleted].[SubItemType])) > 0
begin

    raiserror 50000 'The record can''t be removed as it has linked sub claim items.'

    rollback transaction

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ClaimSubTypeLU_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ClaimSubTypeLU_UTrig]
GO

create trigger [dbo].[ClaimSubTypeLU_UTrig] on [dbo].[ClaimSubTypeLU]
for update
as

/* CASCADE UPDATES TO 'ClaimEntries' */
if update([ItemType])
begin
       update [ClaimEntries]
       set [ClaimEntries].[Type] = [inserted].[ItemType]
       from [ClaimSubTypeLU], [deleted], [inserted]
       where [deleted].[ItemType] = [ClaimEntries].[Type]
end

if update([SubItemType])
begin
       update [ClaimEntries]
       set [ClaimEntries].[ItemType] = [inserted].[SubItemType]
       from [ClaimSubTypeLU], [deleted], [inserted]
       where [deleted].[ItemType] = [ClaimEntries].[Type] and [deleted].[SubItemType] = [ClaimEntries].[ItemType]
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ReportsTo_ITrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.ReportsTo_ITrig]
GO

create trigger [dbo].[ess.ReportsTo_ITrig] on [dbo].[ReportsTo]
for insert
as

insert into [ess.ActionLU]([ReportsToType]) select distinct [ReportsToType] from [ReportsTo] where (not [ReportsToType] in(select distinct [ReportsToType] from [ess.ActionLU]))
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ReportsTo_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.ReportsTo_UTrig]
GO

create trigger [dbo].[ess.ReportsTo_UTrig] on [dbo].[ReportsTo]
for update
as

insert into [ess.ActionLU]([ReportsToType]) select distinct [ReportsToType] from [ReportsTo] where (not [ReportsToType] in(select distinct [ReportsToType] from [ess.ActionLU]))
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.StoreIssued_ITrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.StoreIssued_ITrig]
GO

create trigger [dbo].[ess.StoreIssued_ITrig] on [dbo].[StoreIssued] 
for insert
as

declare @storeID int
declare @PathID int

select @storeID = [StoreID], @PathID = [PathID] from inserted

IF (@PathID is null)
begin
	
	update [StoreIssued] set [StatusID] = (select [id] from [ess.StatusLU] where [Status] = 'Not Submitted') where [StoreID] = @storeID

end
else
	update [StoreIssued] set [StatusID] = (select top 1 [StatusID] from [StoreIssued] where [PathID] = @PathID and [StatusID] is not null) where [StoreID] = @storeID
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFLU_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.WFLU_DTrig]
GO

create trigger [dbo].[ess.WFLU_DTrig] on [dbo].[ess.WFLU] 
for delete
as

delete [ess.WFRemarks] from [deleted], [ess.WFRemarks] where [PathID] in(select [id] from [ess.Path] where [ess.Path].[WFLUID] = [deleted].[id])

delete [ess.NotifyHR] from [deleted], [ess.NotifyHR] where [PathID] in(select [id] from [ess.Path] where [ess.Path].[WFLUID] = [deleted].[id])

delete [ess.Path] from [deleted], [ess.Path] where [ess.Path].[WFLUID] = [deleted].[id]

delete [ess.WFLinkedDepts] from [deleted], [ess.WFLinkedDepts] where [deleted].[id] = [ess.WFLinkedDepts].[WFLUID]

delete [ess.WFAppType] from [deleted], [ess.WFAppType] where [deleted].[WFType] = [ess.WFAppType].[WFType] and [deleted].[WFName] = [ess.WFAppType].[WFName]

delete [ess.WF] from [deleted], [ess.WF] where [deleted].[id] = [ess.WF].[WFLUID]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFTypeLU_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.WFTypeLU_DTrig]
GO

create trigger [dbo].[ess.WFTypeLU_DTrig] on [dbo].[ess.WFTypeLU] 
for delete
as

delete [ess.WFProcLU] from [deleted], [ess.WFProcLU] where [deleted].[ID] = [ess.WFProcLU].[TypeID]

delete [ess.WFTaskLU] from [deleted], [ess.WFTaskLU] where [deleted].[ID] = [ess.WFTaskLU].[TypeID]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[Claims_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[Claims_DTrig]
GO

create trigger [dbo].[Claims_DTrig] on [dbo].[Claims]
for delete
as

delete [ClaimEntries] from [deleted], [ClaimEntries] where [deleted].[CompanyNum] = [ClaimEntries].[CompanyNum] and [deleted].[EmployeeNum] = [ClaimEntries].[EmployeeNum] and [deleted].[Date] = [ClaimEntries].[Date] and [deleted].[Type] = [ClaimEntries].[Type]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[Claims_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[Claims_UTrig]
GO

create trigger [dbo].[Claims_UTrig] on [dbo].[Claims]
for update
as

declare @qry bit

/* CASCADE UPDATES TO 'ClaimEntries' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [ClaimEntries]
       set [ClaimEntries].[CompanyNum] = [inserted].[CompanyNum], [ClaimEntries].[EmployeeNum] = [inserted].[EmployeeNum]
       from [ClaimEntries], [deleted], [inserted]
       where [deleted].[CompanyNum] = [ClaimEntries].[CompanyNum] and [deleted].[EmployeeNum] = [ClaimEntries].[EmployeeNum]
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [ClaimEntries]
       set [ClaimEntries].CompanyNum = inserted.CompanyNum
       from [ClaimEntries], deleted, inserted
       where deleted.CompanyNum = [ClaimEntries].CompanyNum and deleted.EmployeeNum = [ClaimEntries].EmployeeNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [ClaimEntries]
       set [ClaimEntries].[EmployeeNum] = [inserted].[EmployeeNum]
       from [ClaimEntries], [deleted], [inserted]
       where [deleted].[CompanyNum] = [ClaimEntries].[CompanyNum] and [deleted].[EmployeeNum] = [ClaimEntries].[EmployeeNum]
    set @qry = 1
end
IF update([Date])
begin
       update [ClaimEntries]
       set [ClaimEntries].[Date] = [inserted].[Date]
       from [ClaimEntries], [deleted], [inserted]
       where [deleted].[CompanyNum] = [ClaimEntries].[CompanyNum] and [deleted].[EmployeeNum] = [ClaimEntries].[EmployeeNum] and [deleted].[Date] = [ClaimEntries].[Date]
end
IF update([Type])
begin
       update [ClaimEntries]
       set [ClaimEntries].[Type] = [inserted].[Type]
       from [ClaimEntries], [deleted], [inserted]
       where [deleted].[CompanyNum] = [ClaimEntries].[CompanyNum] and [deleted].[EmployeeNum] = [ClaimEntries].[EmployeeNum] and [deleted].[Date] = [ClaimEntries].[Date] and [deleted].[Type] = [ClaimEntries].[Type]
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.EvalGroups_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.EvalGroups_DTrig]
GO

create trigger [dbo].[ess.EvalGroups_DTrig] on [dbo].[ess.EvalGroups]
for delete
as

delete [ess.EvalGroupItems] from [deleted], [ess.EvalGroupItems] where [deleted].[CompanyNum] = [ess.EvalGroupItems].[CompanyNum] and [deleted].[EmployeeNum] = [ess.EvalGroupItems].[EmployeeNum] and [deleted].[Name] = [ess.EvalGroupItems].[GroupName]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.EvalGroups_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.EvalGroups_UTrig]
GO

create trigger [dbo].[ess.EvalGroups_UTrig] on [dbo].[ess.EvalGroups]
for update
as

declare @qry bit

/* CASCADE UPDATES TO 'ess.EvalGroupItems' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [ess.EvalGroupItems]
       set [ess.EvalGroupItems].[CompanyNum] = [inserted].[CompanyNum], [ess.EvalGroupItems].[EmployeeNum] = [inserted].[EmployeeNum]
       from [ess.EvalGroupItems], [deleted], [inserted]
       where [deleted].[CompanyNum] = [ess.EvalGroupItems].[CompanyNum] and [deleted].[EmployeeNum] = [ess.EvalGroupItems].[EmployeeNum]

       update [ess.EvalGroupItems]
       set [ess.EvalGroupItems].[EvalCompanyNum] = [inserted].[CompanyNum], [ess.EvalGroupItems].[EvalEmployeeNum] = [inserted].[EmployeeNum]
       from [ess.EvalGroupItems], [deleted], [inserted]
       where [deleted].[CompanyNum] = [ess.EvalGroupItems].[EvalCompanyNum] and [deleted].[EmployeeNum] = [ess.EvalGroupItems].[EvalEmployeeNum]

       update [ess.EvalGroupItems]
       set [ess.EvalGroupItems].[ApprCompanyNum] = [inserted].[CompanyNum], [ess.EvalGroupItems].[ApprEmployeeNum] = [inserted].[EmployeeNum]
       from [ess.EvalGroupItems], [deleted], [inserted]
       where [deleted].[CompanyNum] = [ess.EvalGroupItems].[ApprCompanyNum] and [deleted].[EmployeeNum] = [ess.EvalGroupItems].[ApprEmployeeNum]

    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [ess.EvalGroupItems]
       set [ess.EvalGroupItems].CompanyNum = inserted.CompanyNum
       from [ess.EvalGroupItems], deleted, inserted
       where deleted.CompanyNum = [ess.EvalGroupItems].CompanyNum and deleted.EmployeeNum = [ess.EvalGroupItems].EmployeeNum

       update [ess.EvalGroupItems]
       set [ess.EvalGroupItems].EvalCompanyNum = inserted.CompanyNum
       from [ess.EvalGroupItems], deleted, inserted
       where deleted.CompanyNum = [ess.EvalGroupItems].EvalCompanyNum and deleted.EmployeeNum = [ess.EvalGroupItems].EvalEmployeeNum

       update [ess.EvalGroupItems]
       set [ess.EvalGroupItems].ApprCompanyNum = inserted.CompanyNum
       from [ess.EvalGroupItems], deleted, inserted
       where deleted.CompanyNum = [ess.EvalGroupItems].ApprCompanyNum and deleted.EmployeeNum = [ess.EvalGroupItems].ApprEmployeeNum

    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [ess.EvalGroupItems]
       set [ess.EvalGroupItems].[EmployeeNum] = [inserted].[EmployeeNum]
       from [ess.EvalGroupItems], [deleted], [inserted]
       where [deleted].[CompanyNum] = [ess.EvalGroupItems].[CompanyNum] and [deleted].[EmployeeNum] = [ess.EvalGroupItems].[EmployeeNum]

       update [ess.EvalGroupItems]
       set [ess.EvalGroupItems].[EvalEmployeeNum] = [inserted].[EmployeeNum]
       from [ess.EvalGroupItems], [deleted], [inserted]
       where [deleted].[CompanyNum] = [ess.EvalGroupItems].[EvalCompanyNum] and [deleted].[EmployeeNum] = [ess.EvalGroupItems].[EvalEmployeeNum]

       update [ess.EvalGroupItems]
       set [ess.EvalGroupItems].[ApprEmployeeNum] = [inserted].[EmployeeNum]
       from [ess.EvalGroupItems], [deleted], [inserted]
       where [deleted].[CompanyNum] = [ess.EvalGroupItems].[ApprCompanyNum] and [deleted].[EmployeeNum] = [ess.EvalGroupItems].[ApprEmployeeNum]

    set @qry = 1
end
IF update([Name])
begin
       update [ess.EvalGroupItems]
       set [ess.EvalGroupItems].[GroupName] = [inserted].[Name]
       from [ess.EvalGroupItems], [deleted], [inserted]
       where [deleted].[CompanyNum] = [ess.EvalGroupItems].[CompanyNum] and [deleted].[EmployeeNum] = [ess.EvalGroupItems].[EmployeeNum] and [deleted].[Name] = [ess.EvalGroupItems].[GroupName]
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Personnel_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.Personnel_UTrig]
GO

create trigger [dbo].[ess.Personnel_UTrig] on [dbo].[Personnel] 
for update
as

declare @qry bit

/* CASCADE UPDATES TO 'Claims' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update Claims
       set Claims.CompanyNum = inserted.CompanyNum, Claims.EmployeeNum = inserted.EmployeeNum
       from Claims, deleted, inserted
       where deleted.CompanyNum = Claims.CompanyNum and deleted.EmployeeNum = Claims.EmployeeNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update Claims
       set Claims.CompanyNum = inserted.CompanyNum
       from Claims, deleted, inserted
       where deleted.CompanyNum = Claims.CompanyNum and deleted.EmployeeNum = Claims.EmployeeNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update Claims
       set Claims.EmployeeNum = inserted.EmployeeNum
       from Claims, deleted, inserted
       where deleted.CompanyNum = Claims.CompanyNum and deleted.EmployeeNum = Claims.EmployeeNum
    set @qry = 1
end

/* CASCADE UPDATES TO 'ess.WFConditions' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [ess.WFConditions]
       set [ess.WFConditions].CompanyNum = inserted.CompanyNum, [ess.WFConditions].EmployeeNum = inserted.EmployeeNum
       from [ess.WFConditions], deleted, inserted
       where deleted.CompanyNum = [ess.WFConditions].CompanyNum and deleted.EmployeeNum = [ess.WFConditions].EmployeeNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [ess.WFConditions]
       set [ess.WFConditions].CompanyNum = inserted.CompanyNum
       from [ess.WFConditions], deleted, inserted
       where deleted.CompanyNum = [ess.WFConditions].CompanyNum and deleted.EmployeeNum = [ess.WFConditions].EmployeeNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [ess.WFConditions]
       set [ess.WFConditions].EmployeeNum = inserted.EmployeeNum
       from [ess.WFConditions], deleted, inserted
       where deleted.CompanyNum = [ess.WFConditions].CompanyNum and deleted.EmployeeNum = [ess.WFConditions].EmployeeNum
    set @qry = 1
end

/* CASCADE UPDATES TO 'ess.SQLExecute' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [ess.SQLExecute]
       set [ess.SQLExecute].CompanyNum = inserted.CompanyNum, [ess.SQLExecute].EmployeeNum = inserted.EmployeeNum
       from [ess.SQLExecute], deleted, inserted
       where deleted.CompanyNum = [ess.SQLExecute].CompanyNum and deleted.EmployeeNum = [ess.SQLExecute].EmployeeNum

       update [ess.SQLExecute]
       set [ess.SQLExecute].[SQLData] = replace(replace(replace(cast([ess.SQLExecute].[SQLData] as nvarchar(4000)), '<CompanyNum=' + [deleted].[CompanyNum] + '>', '<CompanyNum=' + [inserted].[CompanyNum] + '>'), '<OldCompanyNum=' + [deleted].[CompanyNum] + '>', '<OldCompanyNum=' + [inserted].[CompanyNum] + '>'), '<EmployeeNum=' + [deleted].[EmployeeNum] + '>', '<EmployeeNum=' + [inserted].[EmployeeNum] + '>')
       from [Company], [deleted], [inserted]
       where [ess.SQLExecute].[Executed] = 0 and ([ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' or [ess.SQLExecute].[SQLData] like '%<CompanyNum=' + [deleted].[CompanyNum] + '>%' or [ess.SQLExecute].[SQLData] like '%<EmployeeNum=' + [deleted].[EmployeeNum] + '>%')

    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [ess.SQLExecute]
       set [ess.SQLExecute].CompanyNum = inserted.CompanyNum
       from [ess.SQLExecute], deleted, inserted
       where deleted.CompanyNum = [ess.SQLExecute].CompanyNum and deleted.EmployeeNum = [ess.SQLExecute].EmployeeNum

       update [ess.SQLExecute]
       set [ess.SQLExecute].[SQLData] = replace(replace(cast([ess.SQLExecute].[SQLData] as nvarchar(4000)), '<CompanyNum=' + [deleted].[CompanyNum] + '>', '<CompanyNum=' + [inserted].[CompanyNum] + '>'), '<OldCompanyNum=' + [deleted].[CompanyNum] + '>', '<OldCompanyNum=' + [inserted].[CompanyNum] + '>')
       from [Company], [deleted], [inserted]
       where [ess.SQLExecute].[Executed] = 0 and ([ess.SQLExecute].[SQLData] like '%<OldCompanyNum=' + [deleted].[CompanyNum] + '>%' or [ess.SQLExecute].[SQLData] like '%<CompanyNum=' + [deleted].[CompanyNum] + '>%')

    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [ess.SQLExecute]
       set [ess.SQLExecute].EmployeeNum = inserted.EmployeeNum
       from [ess.SQLExecute], deleted, inserted
       where deleted.CompanyNum = [ess.SQLExecute].CompanyNum and deleted.EmployeeNum = [ess.SQLExecute].EmployeeNum

       update [ess.SQLExecute]
       set [ess.SQLExecute].[SQLData] = replace(cast([ess.SQLExecute].[SQLData] as nvarchar(4000)), '<EmployeeNum=' + [deleted].[EmployeeNum] + '>', '<EmployeeNum=' + [inserted].[EmployeeNum] + '>')
       from [Company], [deleted], [inserted]
       where [ess.SQLExecute].[Executed] = 0 and [ess.SQLExecute].[SQLData] like '%<EmployeeNum=' + [deleted].[EmployeeNum] + '>%'

    set @qry = 1
end

/* CASCADE UPDATES TO 'Timesheets' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update Timesheets
       set Timesheets.CompanyNum = inserted.CompanyNum, Timesheets.EmployeeNum = inserted.EmployeeNum
       from Timesheets, deleted, inserted
       where deleted.CompanyNum = Timesheets.CompanyNum and deleted.EmployeeNum = Timesheets.EmployeeNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update Timesheets
       set Timesheets.CompanyNum = inserted.CompanyNum
       from Timesheets, deleted, inserted
       where deleted.CompanyNum = Timesheets.CompanyNum and deleted.EmployeeNum = Timesheets.EmployeeNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update Timesheets
       set Timesheets.EmployeeNum = inserted.EmployeeNum
       from Timesheets, deleted, inserted
       where deleted.CompanyNum = Timesheets.CompanyNum and deleted.EmployeeNum = Timesheets.EmployeeNum
    set @qry = 1
end

/* CASCADE UPDATES TO '[ess.LeaveBlock]' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [ess.LeaveBlock]
       set [ess.LeaveBlock].CompanyNum = inserted.CompanyNum, [ess.LeaveBlock].EmployeeNum = inserted.EmployeeNum
       from [ess.LeaveBlock], deleted, inserted
       where deleted.CompanyNum = [ess.LeaveBlock].CompanyNum and deleted.EmployeeNum = [ess.LeaveBlock].EmployeeNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [ess.LeaveBlock]
       set [ess.LeaveBlock].CompanyNum = inserted.CompanyNum
       from [ess.LeaveBlock], deleted, inserted
       where deleted.CompanyNum = [ess.LeaveBlock].CompanyNum and deleted.EmployeeNum = [ess.LeaveBlock].EmployeeNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [ess.LeaveBlock]
       set [ess.LeaveBlock].EmployeeNum = inserted.EmployeeNum
       from [ess.LeaveBlock], deleted, inserted
       where deleted.CompanyNum = [ess.LeaveBlock].CompanyNum and deleted.EmployeeNum = [ess.LeaveBlock].EmployeeNum
    set @qry = 1
end

/* CASCADE UPDATES TO '[SQLExecute]' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [SQLExecute]
       set [SQLExecute].CompanyNum = inserted.CompanyNum, [SQLExecute].EmployeeNum = inserted.EmployeeNum
       from [SQLExecute], deleted, inserted
       where deleted.CompanyNum = [SQLExecute].CompanyNum and deleted.EmployeeNum = [SQLExecute].EmployeeNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [SQLExecute]
       set [SQLExecute].CompanyNum = inserted.CompanyNum
       from [SQLExecute], deleted, inserted
       where deleted.CompanyNum = [SQLExecute].CompanyNum and deleted.EmployeeNum = [SQLExecute].EmployeeNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [SQLExecute]
       set [SQLExecute].EmployeeNum = inserted.EmployeeNum
       from [SQLExecute], deleted, inserted
       where deleted.CompanyNum = [SQLExecute].CompanyNum and deleted.EmployeeNum = [SQLExecute].EmployeeNum
    set @qry = 1
end

/* CASCADE UPDATES TO '[ess.PerfSubmitted]' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [ess.PerfSubmitted]
       set [ess.PerfSubmitted].CompanyNum = inserted.CompanyNum, [ess.PerfSubmitted].EmployeeNum = inserted.EmployeeNum
       from [ess.PerfSubmitted], deleted, inserted
       where deleted.CompanyNum = [ess.PerfSubmitted].CompanyNum and deleted.EmployeeNum = [ess.PerfSubmitted].EmployeeNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [ess.PerfSubmitted]
       set [ess.PerfSubmitted].CompanyNum = inserted.CompanyNum
       from [ess.PerfSubmitted], deleted, inserted
       where deleted.CompanyNum = [ess.PerfSubmitted].CompanyNum and deleted.EmployeeNum = [ess.PerfSubmitted].EmployeeNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [ess.PerfSubmitted]
       set [ess.PerfSubmitted].EmployeeNum = inserted.EmployeeNum
       from [ess.PerfSubmitted], deleted, inserted
       where deleted.CompanyNum = [ess.PerfSubmitted].CompanyNum and deleted.EmployeeNum = [ess.PerfSubmitted].EmployeeNum
    set @qry = 1
end

/* CASCADE UPDATES TO '[PerfEvalScheme]' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [PerfEvalScheme]
       set [PerfEvalScheme].AppraiserCompNum = inserted.CompanyNum, [PerfEvalScheme].AppraiserEmpNum = inserted.EmployeeNum
       from [PerfEvalScheme], deleted, inserted
       where deleted.CompanyNum = [PerfEvalScheme].AppraiserCompNum and deleted.EmployeeNum = [PerfEvalScheme].AppraiserEmpNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [PerfEvalScheme]
       set [PerfEvalScheme].AppraiserCompNum = inserted.CompanyNum
       from [PerfEvalScheme], deleted, inserted
       where deleted.CompanyNum = [PerfEvalScheme].AppraiserCompNum and deleted.EmployeeNum = [PerfEvalScheme].AppraiserEmpNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [PerfEvalScheme]
       set [PerfEvalScheme].AppraiserEmpNum = inserted.EmployeeNum
       from [PerfEvalScheme], deleted, inserted
       where deleted.CompanyNum = [PerfEvalScheme].AppraiserCompNum and deleted.EmployeeNum = [PerfEvalScheme].AppraiserEmpNum
    set @qry = 1
end

/* CASCADE UPDATES TO 'ess.LearningNeeds' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [ess.LearningNeeds]
       set [ess.LearningNeeds].CompanyNum = inserted.CompanyNum, [ess.LearningNeeds].EmployeeNum = inserted.EmployeeNum
       from [ess.LearningNeeds], deleted, inserted
       where deleted.CompanyNum = [ess.LearningNeeds].CompanyNum and deleted.EmployeeNum = [ess.LearningNeeds].EmployeeNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [ess.LearningNeeds]
       set [ess.LearningNeeds].CompanyNum = inserted.CompanyNum
       from [ess.LearningNeeds], deleted, inserted
       where deleted.CompanyNum = [ess.LearningNeeds].CompanyNum and deleted.EmployeeNum = [ess.LearningNeeds].EmployeeNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [ess.LearningNeeds]
       set [ess.LearningNeeds].EmployeeNum = inserted.EmployeeNum
       from [ess.LearningNeeds], deleted, inserted
       where deleted.CompanyNum = [ess.LearningNeeds].CompanyNum and deleted.EmployeeNum = [ess.LearningNeeds].EmployeeNum
    set @qry = 1
end

/* CASCADE UPDATES TO 'ess.EvalGroups' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [ess.EvalGroups]
       set [ess.EvalGroups].CompanyNum = inserted.CompanyNum, [ess.EvalGroups].EmployeeNum = inserted.EmployeeNum
       from [ess.EvalGroups], deleted, inserted
       where deleted.CompanyNum = [ess.EvalGroups].CompanyNum and deleted.EmployeeNum = [ess.EvalGroups].EmployeeNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [ess.EvalGroups]
       set [ess.EvalGroups].CompanyNum = inserted.CompanyNum
       from [ess.EvalGroups], deleted, inserted
       where deleted.CompanyNum = [ess.EvalGroups].CompanyNum and deleted.EmployeeNum = [ess.EvalGroups].EmployeeNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [ess.EvalGroups]
       set [ess.EvalGroups].EmployeeNum = inserted.EmployeeNum
       from [ess.EvalGroups], deleted, inserted
       where deleted.CompanyNum = [ess.EvalGroups].CompanyNum and deleted.EmployeeNum = [ess.EvalGroups].EmployeeNum
    set @qry = 1
end

/* CASCADE UPDATES TO 'Passwords' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update Passwords
       set Passwords.CompanyNum = inserted.CompanyNum, Passwords.EmployeeNum = inserted.EmployeeNum
       from Passwords, deleted, inserted
       where deleted.CompanyNum = Passwords.CompanyNum and deleted.EmployeeNum = Passwords.EmployeeNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update Passwords
       set Passwords.CompanyNum = inserted.CompanyNum
       from Passwords, deleted, inserted
       where deleted.CompanyNum = Passwords.CompanyNum and deleted.EmployeeNum = Passwords.EmployeeNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update Passwords
       set Passwords.EmployeeNum = inserted.EmployeeNum
       from Passwords, deleted, inserted
       where deleted.CompanyNum = Passwords.CompanyNum and deleted.EmployeeNum = Passwords.EmployeeNum
    set @qry = 1
end

/* CASCADE UPDATES TO 'ess.Change' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [ess.Change]
       set [ess.Change].[CompanyNum] = inserted.CompanyNum, [ess.Change].[EmployeeNum] = inserted.EmployeeNum
       from [ess.Change], deleted, inserted
       where deleted.CompanyNum = [ess.Change].[CompanyNum] and deleted.EmployeeNum = [ess.Change].[EmployeeNum]
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [ess.Change]
       set [ess.Change].[CompanyNum] = inserted.CompanyNum
       from [ess.Change], deleted, inserted
       where deleted.CompanyNum = [ess.Change].[CompanyNum] and deleted.EmployeeNum = [ess.Change].[EmployeeNum]
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [ess.Change]
       set [ess.Change].[EmployeeNum] = inserted.EmployeeNum
       from [ess.Change], deleted, inserted
       where deleted.CompanyNum = [ess.Change].[CompanyNum] and deleted.EmployeeNum = [ess.Change].[EmployeeNum]
    set @qry = 1
end

/* CASCADE UPDATES TO 'ess.Documents' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [ess.Documents]
       set [ess.Documents].CompanyNum = inserted.CompanyNum, [ess.Documents].EmployeeNum = inserted.EmployeeNum
       from [ess.Documents], deleted, inserted
       where deleted.CompanyNum = [ess.Documents].CompanyNum and deleted.EmployeeNum = [ess.Documents].EmployeeNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [ess.Documents]
       set [ess.Documents].CompanyNum = inserted.CompanyNum
       from [ess.Documents], deleted, inserted
       where deleted.CompanyNum = [ess.Documents].CompanyNum and deleted.EmployeeNum = [ess.Documents].EmployeeNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [ess.Documents]
       set [ess.Documents].EmployeeNum = inserted.EmployeeNum
       from [ess.Documents], deleted, inserted
       where deleted.CompanyNum = [ess.Documents].CompanyNum and deleted.EmployeeNum = [ess.Documents].EmployeeNum
    set @qry = 1
end

/* CASCADE UPDATES TO 'ess.NotifyHR' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [ess.NotifyHR]
       set [ess.NotifyHR].CompanyNum = inserted.CompanyNum, [ess.NotifyHR].EmployeeNum = inserted.EmployeeNum
       from [ess.NotifyHR], deleted, inserted
       where deleted.CompanyNum = [ess.NotifyHR].CompanyNum and deleted.EmployeeNum = [ess.NotifyHR].EmployeeNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [ess.NotifyHR]
       set [ess.NotifyHR].CompanyNum = inserted.CompanyNum
       from [ess.NotifyHR], deleted, inserted
       where deleted.CompanyNum = [ess.NotifyHR].CompanyNum and deleted.EmployeeNum = [ess.NotifyHR].EmployeeNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [ess.NotifyHR]
       set [ess.NotifyHR].EmployeeNum = inserted.EmployeeNum
       from [ess.NotifyHR], deleted, inserted
       where deleted.CompanyNum = [ess.NotifyHR].CompanyNum and deleted.EmployeeNum = [ess.NotifyHR].EmployeeNum
    set @qry = 1
end

/* CASCADE UPDATES TO 'ess.Path - ActionerCompanyNum, ActionerEmployeeNum' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [ess.Path]
       set [ess.Path].ActionerCompanyNum = inserted.CompanyNum, [ess.Path].ActionerEmployeeNum = inserted.EmployeeNum
       from [ess.Path], deleted, inserted
       where deleted.CompanyNum = [ess.Path].ActionerCompanyNum and deleted.EmployeeNum = [ess.Path].ActionerEmployeeNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [ess.Path]
       set [ess.Path].ActionerCompanyNum = inserted.CompanyNum
       from [ess.Path], deleted, inserted
       where deleted.CompanyNum = [ess.Path].ActionerCompanyNum and deleted.EmployeeNum = [ess.Path].ActionerEmployeeNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [ess.Path]
       set [ess.Path].ActionerEmployeeNum = inserted.EmployeeNum
       from [ess.Path], deleted, inserted
       where deleted.CompanyNum = [ess.Path].ActionerCompanyNum and deleted.EmployeeNum = [ess.Path].ActionerEmployeeNum
    set @qry = 1
end

/* CASCADE UPDATES TO 'ess.Path - ActionedByCompNum, ActionedByEmpNum' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [ess.Path]
       set [ess.Path].ActionedByCompNum = inserted.CompanyNum, [ess.Path].ActionedByEmpNum = inserted.EmployeeNum
       from [ess.Path], deleted, inserted
       where deleted.CompanyNum = [ess.Path].ActionedByCompNum and deleted.EmployeeNum = [ess.Path].ActionedByEmpNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [ess.Path]
       set [ess.Path].ActionedByCompNum = inserted.CompanyNum
       from [ess.Path], deleted, inserted
       where deleted.CompanyNum = [ess.Path].ActionedByCompNum and deleted.EmployeeNum = [ess.Path].ActionedByEmpNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [ess.Path]
       set [ess.Path].ActionedByEmpNum = inserted.EmployeeNum
       from [ess.Path], deleted, inserted
       where deleted.CompanyNum = [ess.Path].ActionedByCompNum and deleted.EmployeeNum = [ess.Path].ActionedByEmpNum
    set @qry = 1
end

/* CASCADE UPDATES TO 'ess.Path - OriginatorCompanyNum, OriginatorEmployeeNum' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [ess.Path]
       set [ess.Path].OriginatorCompanyNum = inserted.CompanyNum, [ess.Path].OriginatorEmployeeNum = inserted.EmployeeNum
       from [ess.Path], deleted, inserted
       where deleted.CompanyNum = [ess.Path].OriginatorCompanyNum and deleted.EmployeeNum = [ess.Path].OriginatorEmployeeNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [ess.Path]
       set [ess.Path].OriginatorCompanyNum = inserted.CompanyNum
       from [ess.Path], deleted, inserted
       where deleted.CompanyNum = [ess.Path].OriginatorCompanyNum and deleted.EmployeeNum = [ess.Path].OriginatorEmployeeNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [ess.Path]
       set [ess.Path].OriginatorEmployeeNum = inserted.EmployeeNum
       from [ess.Path], deleted, inserted
       where deleted.CompanyNum = [ess.Path].OriginatorCompanyNum and deleted.EmployeeNum = [ess.Path].OriginatorEmployeeNum
    set @qry = 1
end

/* CASCADE UPDATES TO 'ess.Path - PrevActionerCompNum, PrevActionerEmpNum' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [ess.Path]
       set [ess.Path].PrevActionerCompNum = inserted.CompanyNum, [ess.Path].PrevActionerEmpNum = inserted.EmployeeNum
       from [ess.Path], deleted, inserted
       where deleted.CompanyNum = [ess.Path].PrevActionerCompNum and deleted.EmployeeNum = [ess.Path].PrevActionerEmpNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [ess.Path]
       set [ess.Path].PrevActionerCompNum = inserted.CompanyNum
       from [ess.Path], deleted, inserted
       where deleted.CompanyNum = [ess.Path].PrevActionerCompNum and deleted.EmployeeNum = [ess.Path].PrevActionerEmpNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [ess.Path]
       set [ess.Path].PrevActionerEmpNum = inserted.EmployeeNum
       from [ess.Path], deleted, inserted
       where deleted.CompanyNum = [ess.Path].PrevActionerCompNum and deleted.EmployeeNum = [ess.Path].PrevActionerEmpNum
    set @qry = 1
end

/* CASCADE UPDATES TO 'ess.QSubjects - CompanyNum, EmployeeNum' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [ess.QSubjects]
       set [ess.QSubjects].CompanyNum = inserted.CompanyNum, [ess.QSubjects].EmployeeNum = inserted.EmployeeNum
       from [ess.QSubjects], deleted, inserted
       where deleted.CompanyNum = [ess.QSubjects].CompanyNum and deleted.EmployeeNum = [ess.QSubjects].EmployeeNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [ess.QSubjects]
       set [ess.QSubjects].CompanyNum = inserted.CompanyNum
       from [ess.QSubjects], deleted, inserted
       where deleted.CompanyNum = [ess.QSubjects].CompanyNum and deleted.EmployeeNum = [ess.QSubjects].EmployeeNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [ess.QSubjects]
       set [ess.QSubjects].EmployeeNum = inserted.EmployeeNum
       from [ess.QSubjects], deleted, inserted
       where deleted.CompanyNum = [ess.QSubjects].CompanyNum and deleted.EmployeeNum = [ess.QSubjects].EmployeeNum
    set @qry = 1
end

/* CASCADE UPDATES TO 'ess.WFAudit - ActionerCompanyNum, ActionerEmployeeNum' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [ess.WFAudit]
       set [ess.WFAudit].ActionerCompanyNum = inserted.CompanyNum, [ess.WFAudit].ActionerEmployeeNum = inserted.EmployeeNum
       from [ess.WFAudit], deleted, inserted
       where deleted.CompanyNum = [ess.WFAudit].ActionerCompanyNum and deleted.EmployeeNum = [ess.WFAudit].ActionerEmployeeNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [ess.WFAudit]
       set [ess.WFAudit].ActionerCompanyNum = inserted.CompanyNum
       from [ess.WFAudit], deleted, inserted
       where deleted.CompanyNum = [ess.WFAudit].ActionerCompanyNum and deleted.EmployeeNum = [ess.WFAudit].ActionerEmployeeNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [ess.WFAudit]
       set [ess.WFAudit].ActionerEmployeeNum = inserted.EmployeeNum
       from [ess.WFAudit], deleted, inserted
       where deleted.CompanyNum = [ess.WFAudit].ActionerCompanyNum and deleted.EmployeeNum = [ess.WFAudit].ActionerEmployeeNum
    set @qry = 1
end

/* CASCADE UPDATES TO 'ess.WFAudit - ActionedByCompNum, ActionedByEmpNum' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [ess.WFAudit]
       set [ess.WFAudit].ActionedByCompNum = inserted.CompanyNum, [ess.WFAudit].ActionedByEmpNum = inserted.EmployeeNum
       from [ess.WFAudit], deleted, inserted
       where deleted.CompanyNum = [ess.WFAudit].ActionedByCompNum and deleted.EmployeeNum = [ess.WFAudit].ActionedByEmpNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [ess.WFAudit]
       set [ess.WFAudit].ActionedByCompNum = inserted.CompanyNum
       from [ess.WFAudit], deleted, inserted
       where deleted.CompanyNum = [ess.WFAudit].ActionedByCompNum and deleted.EmployeeNum = [ess.WFAudit].ActionedByEmpNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [ess.WFAudit]
       set [ess.WFAudit].ActionedByEmpNum = inserted.EmployeeNum
       from [ess.WFAudit], deleted, inserted
       where deleted.CompanyNum = [ess.WFAudit].ActionedByCompNum and deleted.EmployeeNum = [ess.WFAudit].ActionedByEmpNum
    set @qry = 1
end

/* CASCADE UPDATES TO 'ess.WFAudit - OriginatorCompanyNum, OriginatorEmployeeNum' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [ess.WFAudit]
       set [ess.WFAudit].OriginatorCompanyNum = inserted.CompanyNum, [ess.WFAudit].OriginatorEmployeeNum = inserted.EmployeeNum
       from [ess.WFAudit], deleted, inserted
       where deleted.CompanyNum = [ess.WFAudit].OriginatorCompanyNum and deleted.EmployeeNum = [ess.WFAudit].OriginatorEmployeeNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [ess.WFAudit]
       set [ess.WFAudit].OriginatorCompanyNum = inserted.CompanyNum
       from [ess.WFAudit], deleted, inserted
       where deleted.CompanyNum = [ess.WFAudit].OriginatorCompanyNum and deleted.EmployeeNum = [ess.WFAudit].OriginatorEmployeeNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [ess.WFAudit]
       set [ess.WFAudit].OriginatorEmployeeNum = inserted.EmployeeNum
       from [ess.WFAudit], deleted, inserted
       where deleted.CompanyNum = [ess.WFAudit].OriginatorCompanyNum and deleted.EmployeeNum = [ess.WFAudit].OriginatorEmployeeNum
    set @qry = 1
end

/* CASCADE UPDATES TO 'ess.WFAudit - PrevActionerCompNum, PrevActionerEmpNum' */
set @qry = 0
IF update(CompanyNum) and update(EmployeeNum) and @qry = 0
begin
       update [ess.WFAudit]
       set [ess.WFAudit].PrevActionerCompNum = inserted.CompanyNum, [ess.WFAudit].PrevActionerEmpNum = inserted.EmployeeNum
       from [ess.WFAudit], deleted, inserted
       where deleted.CompanyNum = [ess.WFAudit].PrevActionerCompNum and deleted.EmployeeNum = [ess.WFAudit].PrevActionerEmpNum
    set @qry = 1
end
IF update(CompanyNum) and @qry = 0
begin
       update [ess.WFAudit]
       set [ess.WFAudit].PrevActionerCompNum = inserted.CompanyNum
       from [ess.WFAudit], deleted, inserted
       where deleted.CompanyNum = [ess.WFAudit].PrevActionerCompNum and deleted.EmployeeNum = [ess.WFAudit].PrevActionerEmpNum
    set @qry = 1
end
IF update(EmployeeNum) and @qry = 0
begin
       update [ess.WFAudit]
       set [ess.WFAudit].PrevActionerEmpNum = inserted.EmployeeNum
       from [ess.WFAudit], deleted, inserted
       where deleted.CompanyNum = [ess.WFAudit].PrevActionerCompNum and deleted.EmployeeNum = [ess.WFAudit].PrevActionerEmpNum
    set @qry = 1
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Personnel_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.Personnel_DTrig]
GO

create trigger [dbo].[ess.Personnel_DTrig] on [dbo].[Personnel]
for delete
as

delete [Claims] from [deleted], [Claims] where [deleted].[CompanyNum] = [Claims].[CompanyNum] and [deleted].[EmployeeNum] = [Claims].[EmployeeNum]

delete [Timesheets] from [deleted], [Timesheets] where [deleted].[CompanyNum] = [Timesheets].[CompanyNum] and [deleted].[EmployeeNum] = [Timesheets].[EmployeeNum]

delete [ess.Change] from [deleted], [ess.Change] where [deleted].[CompanyNum] = [ess.Change].[CompanyNum] and [deleted].[EmployeeNum] = [ess.Change].[EmployeeNum]

delete [ess.SQLExecute] from [deleted], [ess.SQLExecute] where [deleted].[CompanyNum] = [ess.SQLExecute].[CompanyNum] and [deleted].[EmployeeNum] = [ess.SQLExecute].[EmployeeNum]

delete [ess.EvalGroups] from [deleted], [ess.EvalGroups] where [deleted].[CompanyNum] = [ess.EvalGroups].[CompanyNum] and [deleted].[EmployeeNum] = [ess.EvalGroups].[EmployeeNum]

delete [ess.EvalGroupItems] from [deleted], [ess.EvalGroupItems] where ([deleted].[CompanyNum] = [ess.EvalGroupItems].[EvalCompanyNum] and [deleted].[EmployeeNum] = [ess.EvalGroupItems].[EvalEmployeeNum] or [deleted].[CompanyNum] = [ess.EvalGroupItems].[ApprCompanyNum] and [deleted].[EmployeeNum] = [ess.EvalGroupItems].[ApprEmployeeNum])

delete [ess.LearningNeeds] from [deleted], [ess.LearningNeeds] where [deleted].[CompanyNum] = [ess.LearningNeeds].[CompanyNum] and [deleted].[EmployeeNum] = [ess.LearningNeeds].[EmployeeNum]

delete [Passwords] from [deleted], [Passwords] where [deleted].[CompanyNum] = [Passwords].[CompanyNum] and [deleted].[EmployeeNum] = [Passwords].[EmployeeNum]

delete [ess.LeaveBlock] from [deleted], [ess.LeaveBlock] where [deleted].[CompanyNum] = [ess.LeaveBlock].[CompanyNum] and [deleted].[EmployeeNum] = [ess.LeaveBlock].[EmployeeNum]

delete [ess.PerfSubmitted] from [deleted], [ess.PerfSubmitted] where [deleted].[CompanyNum] = [ess.PerfSubmitted].[CompanyNum] and [deleted].[EmployeeNum] = [ess.PerfSubmitted].[EmployeeNum]

delete [ess.Documents] from [deleted], [ess.Documents] where [deleted].[CompanyNum] = [ess.Documents].[CompanyNum] and [deleted].[EmployeeNum] = [ess.Documents].[EmployeeNum]

delete [ess.NotifyHR] from [deleted], [ess.NotifyHR] where [deleted].[CompanyNum] = [ess.NotifyHR].[CompanyNum] and [deleted].[EmployeeNum] = [ess.NotifyHR].[EmployeeNum]

delete [ess.QSubjects] from [deleted], [ess.QSubjects] where [deleted].[CompanyNum] = [ess.QSubjects].[CompanyNum] and [deleted].[EmployeeNum] = [ess.QSubjects].[EmployeeNum]

delete [SQLExecute] from [deleted], [SQLExecute] where [deleted].[CompanyNum] = [SQLExecute].[CompanyNum] and [deleted].[EmployeeNum] = [SQLExecute].[EmployeeNum]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[PerfRangeType_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[PerfRangeType_UTrig]
GO

create trigger [dbo].[PerfRangeType_UTrig] on [dbo].[PerfRangeType]
for update
as

/* * CASCADE UPDATES TO 'PerfCSE' */
DECLARE @qry bit
SET @qry = 0
IF UPDATE(RangeType) and @qry = 0
BEGIN
       UPDATE PerfCSE
       SET PerfCSE.RangeType = inserted.RangeType
       FROM PerfCSE, deleted, inserted
       WHERE deleted.RangeType = PerfCSE.RangeType
    SET @qry = 1
END

/* * CASCADE UPDATES TO 'PerfEvalCSE' */
SET @qry = 0
IF UPDATE(RangeType) and @qry = 0
BEGIN
       UPDATE PerfEvalCSE
       SET PerfEvalCSE.RangeType = inserted.RangeType
       FROM PerfEvalCSE, deleted, inserted
       WHERE deleted.RangeType = PerfEvalCSE.RangeType
    SET @qry = 1
END

/* * CASCADE UPDATES TO 'PerfKPA' */
SET @qry = 0
IF UPDATE(RangeType) and @qry = 0
BEGIN
       UPDATE PerfKPA
       SET PerfKPA.RangeType = inserted.RangeType
       FROM PerfKPA, deleted, inserted
       WHERE deleted.RangeType = PerfKPA.RangeType
    SET @qry = 1
END

/* * CASCADE UPDATES TO 'PerfEvalKPA' */
SET @qry = 0
IF UPDATE(RangeType) and @qry = 0
BEGIN
       UPDATE PerfEvalKPA
       SET PerfEvalKPA.RangeType = inserted.RangeType
       FROM PerfEvalKPA, deleted, inserted
       WHERE deleted.RangeType = PerfEvalKPA.RangeType
    SET @qry = 1
END

/* * CASCADE UPDATES TO 'PerfRangeElements' */
SET @qry = 0
IF UPDATE(RangeType) and @qry = 0
BEGIN
       UPDATE PerfRangeElements
       SET PerfRangeElements.RangeType = inserted.RangeType
       FROM PerfRangeElements, deleted, inserted
       WHERE deleted.RangeType = PerfRangeElements.RangeType
    SET @qry = 1
END
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Users_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.Users_DTrig]
GO

create trigger [dbo].[ess.Users_DTrig] on [dbo].[Users] 
for delete
as

delete [ess.LearningNeeds] from [deleted], [ess.LearningNeeds] where [deleted].[Username] = [ess.LearningNeeds].[Username]

delete [Passwords] from [deleted], [Passwords] where [deleted].[Username] = [Passwords].[Username]

delete [ess.PerfSubmitted] from [deleted], [ess.PerfSubmitted] where [deleted].[Username] = [ess.PerfSubmitted].[Username]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Users_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.Users_UTrig]
GO

create trigger [dbo].[ess.Users_UTrig] on [dbo].[Users] 
for update
as

declare @qry bit

/* CASCADE UPDATES TO 'ess.LearningNeeds' */
set @qry = 0
IF update(Username) and @qry = 0
begin
       update [ess.LearningNeeds]
       set [ess.LearningNeeds].Username = inserted.Username
       from [ess.LearningNeeds], deleted, inserted
       where deleted.Username = [ess.LearningNeeds].Username

    set @qry = 1
end

/* CASCADE UPDATES TO 'Passwords' */
set @qry = 0
IF update(Username) and @qry = 0
begin
       update [Passwords]
       set [Passwords].Username = inserted.Username
       from [Passwords], deleted, inserted
       where deleted.Username = [Passwords].Username

    set @qry = 1
end

/* CASCADE UPDATES TO 'ess.PerfSubmitted' */
set @qry = 0
IF update(Username) and @qry = 0
begin
       update [ess.PerfSubmitted]
       set [ess.PerfSubmitted].Username = inserted.Username
       from [ess.PerfSubmitted], deleted, inserted
       where deleted.Username = [ess.PerfSubmitted].Username

    set @qry = 1
end

/* CASCADE UPDATES TO 'ess.Path' */
set @qry = 0
IF update(Username) and @qry = 0
begin
       update [ess.Path]
       set [ess.Path].ActionerUsername = inserted.Username
       from [ess.Path], deleted, inserted
       where deleted.Username = [ess.Path].ActionerUsername

       update [ess.Path]
       set [ess.Path].ActionedByUsername = inserted.Username
       from [ess.Path], deleted, inserted
       where deleted.Username = [ess.Path].ActionedByUsername

       update [ess.Path]
       set [ess.Path].OriginatorUsername = inserted.Username
       from [ess.Path], deleted, inserted
       where deleted.Username = [ess.Path].OriginatorUsername

       update [ess.Path]
       set [ess.Path].PrevActionerUsername = inserted.Username
       from [ess.Path], deleted, inserted
       where deleted.Username = [ess.Path].PrevActionerUsername
    set @qry = 1
end

/* CASCADE UPDATES TO 'ess.WFAudit' */
set @qry = 0
IF update(Username) and @qry = 0
begin
       update [ess.WFAudit]
       set [ess.WFAudit].ActionerUsername = inserted.Username
       from [ess.WFAudit], deleted, inserted
       where deleted.Username = [ess.WFAudit].ActionerUsername

       update [ess.WFAudit]
       set [ess.WFAudit].ActionedByUsername = inserted.Username
       from [ess.WFAudit], deleted, inserted
       where deleted.Username = [ess.WFAudit].ActionedByUsername

       update [ess.WFAudit]
       set [ess.WFAudit].OriginatorUsername = inserted.Username
       from [ess.WFAudit], deleted, inserted
       where deleted.Username = [ess.WFAudit].OriginatorUsername

       update [ess.WFAudit]
       set [ess.WFAudit].PrevActionerUsername = inserted.Username
       from [ess.WFAudit], deleted, inserted
       where deleted.Username = [ess.WFAudit].PrevActionerUsername
    set @qry = 1
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Qualifications_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.Qualifications_DTrig]
GO

create trigger [dbo].[ess.Qualifications_DTrig] on [dbo].[Qualifications]
for delete
as

delete [ess.QSubjects] from [deleted], [ess.QSubjects] where [deleted].[CompanyNum] = [ess.QSubjects].[CompanyNum] and [deleted].[EmployeeNum] = [ess.QSubjects].[EmployeeNum] and [deleted].[StartDate] = [ess.QSubjects].[StartDate]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.PerfEvalKPA_ITrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.PerfEvalKPA_ITrig]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.PerfEvalCSE_ITrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.PerfEvalCSE_ITrig]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[dbo].[CourseLU_ITrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[CourseLU_ITrig]
GO

create trigger [CourseLU_ITrig] on CourseLU for update as
set nocount on
/* * PREVENT INSERTS IF NO MATCHING KEY IN 'CourseAssessmentMethodLU' */
IF (Select AssessmentMethod from inserted) is not null
BEGIN
IF (SELECT COUNT(*) FROM inserted) !=
   (SELECT COUNT(*) FROM CourseAssessmentMethodLU, inserted WHERE (CourseAssessmentMethodLU.AssessmentMethod = inserted.AssessmentMethod))
    BEGIN
        RAISERROR 44447 'The record can''t be added or changed. Referential integrity rules require a related record in table ''CourseAssessmentMethodLU''.'
        ROLLBACK TRANSACTION
    END
END

/* * PREVENT INSERTS IF NO MATCHING KEY IN 'CourseDeliveryMethodLU' */
IF (Select DeliveryMethod from inserted) is not null
BEGIN
IF (SELECT COUNT(*) FROM inserted) !=
   (SELECT COUNT(*) FROM CourseDeliveryMethodLU, inserted WHERE (CourseDeliveryMethodLU.DeliveryMethod = inserted.DeliveryMethod))
    BEGIN
        RAISERROR 44447 'The record can''t be added or changed. Referential integrity rules require a related record in table ''CourseDeliveryMethodLU''.'
        ROLLBACK TRANSACTION
    END
END

/* * PREVENT INSERTS IF NO MATCHING KEY IN 'CourseNQFLevelLU' */
IF (Select NQFLevel from inserted) is not null
BEGIN
IF (SELECT COUNT(*) FROM inserted) !=
   (SELECT COUNT(*) FROM CourseNQFLevelLU, inserted WHERE (CourseNQFLevelLU.NQFLevel = inserted.NQFLevel))
    BEGIN
        RAISERROR 44447 'The record can''t be added or changed. Referential integrity rules require a related record in table ''CourseNQFLevelLU''.'
        ROLLBACK TRANSACTION
    END
END

/* * PREVENT INSERTS IF NO MATCHING KEY IN 'CourseSubCategoryLU' */
if (select CourseCategory from inserted) is not null
begin

	if (select CourseSubCategory from inserted) is not null
	begin

		IF (Select CourseCategory from inserted) is not null
		BEGIN
		IF (SELECT COUNT(*) FROM inserted) !=
		   (SELECT COUNT(*) FROM CourseSubCategoryLU, inserted WHERE (CourseSubCategoryLU.CourseCategory = inserted.CourseCategory AND CourseSubCategoryLU.CourseSubCategory = inserted.CourseSubCategory))
			BEGIN
				RAISERROR 44447 'The record can''t be added or changed. Referential integrity rules require a related record in table ''CourseSubCategoryLU''.'
				ROLLBACK TRANSACTION
			END
		END

	end

end

/* * PREVENT INSERTS IF NO MATCHING KEY IN 'TrainingProviderLU' */
IF (SELECT COUNT(*) FROM inserted) !=
   (SELECT COUNT(*) FROM TrainingProviderLU, inserted WHERE (TrainingProviderLU.ProviderName = inserted.ProviderName))
    BEGIN
        RAISERROR 44447 'The record can''t be added or changed. Referential integrity rules require a related record in table ''TrainingProviderLU''.'
        ROLLBACK TRANSACTION
    END
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[dbo].[CourseLU_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[CourseLU_UTrig]
GO

create trigger [CourseLU_UTrig] on CourseLU for update as
set nocount on
/* * PREVENT INSERTS IF NO MATCHING KEY IN 'CourseAssessmentMethodLU' */
IF UPDATE(AssessmentMethod)
    BEGIN
        IF (SELECT COUNT(*) FROM inserted) !=
           (SELECT COUNT(*) FROM CourseAssessmentMethodLU, inserted WHERE (CourseAssessmentMethodLU.AssessmentMethod = inserted.AssessmentMethod))
            BEGIN
                RAISERROR 44446 'The record can''t be added or changed. Referential integrity rules require a related record in table ''CourseAssessmentMethodLU''.'
                ROLLBACK TRANSACTION
            END
    END

/* * PREVENT UPDATES IF NO MATCHING KEY IN 'CourseDeliveryMethodLU' */
IF UPDATE(DeliveryMethod)
    BEGIN
        IF (SELECT COUNT(*) FROM inserted) !=
           (SELECT COUNT(*) FROM CourseDeliveryMethodLU, inserted WHERE (CourseDeliveryMethodLU.DeliveryMethod = inserted.DeliveryMethod))
            BEGIN
                RAISERROR 44446 'The record can''t be added or changed. Referential integrity rules require a related record in table ''CourseDeliveryMethodLU''.'
                ROLLBACK TRANSACTION
            END
    END

/* * CASCADE UPDATES TO 'CourseBelongToProgram' */
DECLARE @qry bit
SET @qry = 0
IF UPDATE(CourseName) and UPDATE(ProviderName) and @qry = 0
BEGIN
       UPDATE CourseBelongToProgram
       SET CourseBelongToProgram.CourseName = inserted.CourseName , CourseBelongToProgram.ProviderName = inserted.ProviderName
       FROM CourseBelongToProgram, deleted, inserted
       WHERE deleted.CourseName = CourseBelongToProgram.CourseName AND deleted.ProviderName = CourseBelongToProgram.ProviderName
    SET @qry = 1
END
IF UPDATE(CourseName) and @qry = 0
BEGIN
       UPDATE CourseBelongToProgram
       SET CourseBelongToProgram.CourseName = inserted.CourseName
       FROM CourseBelongToProgram, deleted, inserted
       WHERE deleted.CourseName = CourseBelongToProgram.CourseName AND deleted.ProviderName = CourseBelongToProgram.ProviderName
    SET @qry = 1
END
IF UPDATE(ProviderName) and @qry = 0
BEGIN
       UPDATE CourseBelongToProgram
       SET CourseBelongToProgram.ProviderName = inserted.ProviderName
       FROM CourseBelongToProgram, deleted, inserted
       WHERE deleted.CourseName = CourseBelongToProgram.CourseName AND deleted.ProviderName = CourseBelongToProgram.ProviderName
    SET @qry = 1
END

/* * CASCADE UPDATES TO 'CourseDatesLU' */
SET @qry = 0
IF UPDATE(CourseName) and UPDATE(ProviderName) and @qry = 0
BEGIN
       UPDATE CourseDatesLU
       SET CourseDatesLU.CourseName = inserted.CourseName , CourseDatesLU.ProviderName = inserted.ProviderName
       FROM CourseDatesLU, deleted, inserted
       WHERE deleted.CourseName = CourseDatesLU.CourseName AND deleted.ProviderName = CourseDatesLU.ProviderName
    SET @qry = 1
END
IF UPDATE(CourseName) and @qry = 0
BEGIN
       UPDATE CourseDatesLU
       SET CourseDatesLU.CourseName = inserted.CourseName
       FROM CourseDatesLU, deleted, inserted
       WHERE deleted.CourseName = CourseDatesLU.CourseName AND deleted.ProviderName = CourseDatesLU.ProviderName
    SET @qry = 1
END
IF UPDATE(ProviderName) and @qry = 0
BEGIN
       UPDATE CourseDatesLU
       SET CourseDatesLU.ProviderName = inserted.ProviderName
       FROM CourseDatesLU, deleted, inserted
       WHERE deleted.CourseName = CourseDatesLU.CourseName AND deleted.ProviderName = CourseDatesLU.ProviderName
    SET @qry = 1
END

/* * CASCADE UPDATES TO 'CourseModulesLU' */
SET @qry = 0
IF UPDATE(CourseName) and UPDATE(ProviderName) and @qry = 0
BEGIN
       UPDATE CourseModulesLU
       SET CourseModulesLU.CourseName = inserted.CourseName , CourseModulesLU.ProviderName = inserted.ProviderName
       FROM CourseModulesLU, deleted, inserted
       WHERE deleted.CourseName = CourseModulesLU.CourseName AND deleted.ProviderName = CourseModulesLU.ProviderName
    SET @qry = 1
END
IF UPDATE(CourseName) and @qry = 0
BEGIN
       UPDATE CourseModulesLU
       SET CourseModulesLU.CourseName = inserted.CourseName
       FROM CourseModulesLU, deleted, inserted
       WHERE deleted.CourseName = CourseModulesLU.CourseName AND deleted.ProviderName = CourseModulesLU.ProviderName
    SET @qry = 1
END
IF UPDATE(ProviderName) and @qry = 0
BEGIN
       UPDATE CourseModulesLU
       SET CourseModulesLU.ProviderName = inserted.ProviderName
       FROM CourseModulesLU, deleted, inserted
       WHERE deleted.CourseName = CourseModulesLU.CourseName AND deleted.ProviderName = CourseModulesLU.ProviderName
    SET @qry = 1
END

/* * CASCADE UPDATES TO 'CourseUnitStandards' */
SET @qry = 0
IF UPDATE(CourseName) and UPDATE(ProviderName) and @qry = 0
BEGIN
       UPDATE CourseUnitStandards
       SET CourseUnitStandards.CourseName = inserted.CourseName , CourseUnitStandards.ProviderName = inserted.ProviderName
       FROM CourseUnitStandards, deleted, inserted
       WHERE deleted.CourseName = CourseUnitStandards.CourseName AND deleted.ProviderName = CourseUnitStandards.ProviderName
    SET @qry = 1
END
IF UPDATE(CourseName) and @qry = 0
BEGIN
       UPDATE CourseUnitStandards
       SET CourseUnitStandards.CourseName = inserted.CourseName
       FROM CourseUnitStandards, deleted, inserted
       WHERE deleted.CourseName = CourseUnitStandards.CourseName AND deleted.ProviderName = CourseUnitStandards.ProviderName
    SET @qry = 1
END
IF UPDATE(ProviderName) and @qry = 0
BEGIN
       UPDATE CourseUnitStandards
       SET CourseUnitStandards.ProviderName = inserted.ProviderName
       FROM CourseUnitStandards, deleted, inserted
       WHERE deleted.CourseName = CourseUnitStandards.CourseName AND deleted.ProviderName = CourseUnitStandards.ProviderName
    SET @qry = 1
END

/* * CASCADE UPDATES TO 'TrainingCompleted' */
SET @qry = 0
IF UPDATE(CourseName) and UPDATE(ProviderName) and @qry = 0
BEGIN
       UPDATE TrainingCompleted
       SET TrainingCompleted.CourseName = inserted.CourseName , TrainingCompleted.ProviderName = inserted.ProviderName
       FROM TrainingCompleted, deleted, inserted
       WHERE deleted.CourseName = TrainingCompleted.CourseName AND deleted.ProviderName = TrainingCompleted.ProviderName
    SET @qry = 1
END
IF UPDATE(CourseName) and @qry = 0
BEGIN
       UPDATE TrainingCompleted
       SET TrainingCompleted.CourseName = inserted.CourseName
       FROM TrainingCompleted, deleted, inserted
       WHERE deleted.CourseName = TrainingCompleted.CourseName AND deleted.ProviderName = TrainingCompleted.ProviderName
    SET @qry = 1
END
IF UPDATE(ProviderName) and @qry = 0
BEGIN
       UPDATE TrainingCompleted
       SET TrainingCompleted.ProviderName = inserted.ProviderName
       FROM TrainingCompleted, deleted, inserted
       WHERE deleted.CourseName = TrainingCompleted.CourseName AND deleted.ProviderName = TrainingCompleted.ProviderName
    SET @qry = 1
END

/* * CASCADE UPDATES TO 'TrainingPlanned' */
SET @qry = 0
IF UPDATE(CourseName) and UPDATE(ProviderName) and @qry = 0
BEGIN
       UPDATE TrainingPlanned
       SET TrainingPlanned.CourseName = inserted.CourseName , TrainingPlanned.ProviderName = inserted.ProviderName
       FROM TrainingPlanned, deleted, inserted
       WHERE deleted.CourseName = TrainingPlanned.CourseName AND deleted.ProviderName = TrainingPlanned.ProviderName
    SET @qry = 1
END
IF UPDATE(CourseName) and @qry = 0
BEGIN
       UPDATE TrainingPlanned
       SET TrainingPlanned.CourseName = inserted.CourseName
       FROM TrainingPlanned, deleted, inserted
       WHERE deleted.CourseName = TrainingPlanned.CourseName AND deleted.ProviderName = TrainingPlanned.ProviderName
    SET @qry = 1
END
IF UPDATE(ProviderName) and @qry = 0
BEGIN
       UPDATE TrainingPlanned
       SET TrainingPlanned.ProviderName = inserted.ProviderName
       FROM TrainingPlanned, deleted, inserted
       WHERE deleted.CourseName = TrainingPlanned.CourseName AND deleted.ProviderName = TrainingPlanned.ProviderName
    SET @qry = 1
END

/* * PREVENT UPDATES IF NO MATCHING KEY IN 'CourseNQFLevelLU' */
IF UPDATE(NQFLevel)
    BEGIN
        IF (SELECT COUNT(*) FROM inserted) !=
           (SELECT COUNT(*) FROM CourseNQFLevelLU, inserted WHERE (CourseNQFLevelLU.NQFLevel = inserted.NQFLevel))
            BEGIN
                RAISERROR 44446 'The record can''t be added or changed. Referential integrity rules require a related record in table ''CourseNQFLevelLU''.'
                ROLLBACK TRANSACTION
            END
    END

/* * PREVENT UPDATES IF NO MATCHING KEY IN 'CourseSubCategoryLU' */
if (select CourseCategory from inserted) is not null
begin

	if (select CourseSubCategory from inserted) is not null
	begin

		IF UPDATE(CourseCategory) OR UPDATE(CourseSubCategory)
			BEGIN
				IF (SELECT COUNT(*) FROM inserted) !=
				   (SELECT COUNT(*) FROM CourseSubCategoryLU, inserted WHERE (CourseSubCategoryLU.CourseCategory = inserted.CourseCategory AND CourseSubCategoryLU.CourseSubCategory = inserted.CourseSubCategory))
					BEGIN
						RAISERROR 44446 'The record can''t be added or changed. Referential integrity rules require a related record in table ''CourseSubCategoryLU''.'
						ROLLBACK TRANSACTION
					END
			END
	end

end

/* * PREVENT UPDATES IF NO MATCHING KEY IN 'TrainingProviderLU' */
IF UPDATE(ProviderName)
    BEGIN
        IF (SELECT COUNT(*) FROM inserted) !=
           (SELECT COUNT(*) FROM TrainingProviderLU, inserted WHERE (TrainingProviderLU.ProviderName = inserted.ProviderName))
            BEGIN
                RAISERROR 44446 'The record can''t be added or changed. Referential integrity rules require a related record in table ''TrainingProviderLU''.'
                ROLLBACK TRANSACTION
            END
    END

/* * CASCADE UPDATES TO 'LNALearnEvents' */
SET @qry = 0
IF UPDATE(CourseName) and UPDATE(ProviderName) and @qry = 0
BEGIN
       UPDATE LNALearnEvents
       SET LNALearnEvents.CourseName = inserted.CourseName , LNALearnEvents.ProviderName = inserted.ProviderName
       FROM LNALearnEvents, deleted, inserted
       WHERE deleted.CourseName = LNALearnEvents.CourseName AND deleted.ProviderName = LNALearnEvents.ProviderName
    SET @qry = 1
END
IF UPDATE(CourseName) and @qry = 0
BEGIN
       UPDATE LNALearnEvents
       SET LNALearnEvents.CourseName = inserted.CourseName
       FROM LNALearnEvents, deleted, inserted
       WHERE deleted.CourseName = LNALearnEvents.CourseName AND deleted.ProviderName = LNALearnEvents.ProviderName
    SET @qry = 1
END
IF UPDATE(ProviderName) and @qry = 0
BEGIN
       UPDATE LNALearnEvents
       SET LNALearnEvents.ProviderName = inserted.ProviderName
       FROM LNALearnEvents, deleted, inserted
       WHERE deleted.CourseName = LNALearnEvents.CourseName AND deleted.ProviderName = LNALearnEvents.ProviderName
    SET @qry = 1
END
GO

set QUOTED_IDENTIFIER off 
GO
set ANSI_NULLS on 
GO