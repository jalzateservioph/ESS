/**********************************************************************************************************

							*** v6.0.74 (Delete tables not required) ***

***********************************************************************************************************/
/*
if exists (select [id] from [sysobjects] where [id] = object_id(N'[SQLExecute]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [SQLExecute]
--GO
*/

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ChartSeries]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [ChartSeries]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ChartLU]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [ChartLU]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ChartTypeLU]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [ChartTypeLU]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Assembly]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [ess.Assembly]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ClaimCategoryLU]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [ClaimCategoryLU]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ClaimDetails]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [ClaimDetails]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[Claims.bck]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [Claims.bck]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[Emails]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [Emails]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[Messages]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [Messages]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ClaimMapLU]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [ClaimMapLU]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ClaimsSetup]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [ClaimsSetup]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ClaimsSubTypeLU]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [ClaimsTypeLU]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ClaimsSubTypeLU]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [ClaimsSubTypeLU]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[CurrencyLU]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [CurrencyLU]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.CharLU]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [ess.CharLU]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.DataType]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [ess.DataType]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[EmailLU]') and objectproperty([ID], N'IsUserTable') = 1) and exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.EmailLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	declare	@Name nvarchar(256),
			@From nvarchar(256),
			@Server nvarchar(75),
			@Port smallint,
			@Username nvarchar(32),
			@Password nvarchar(64)

	select top 1 @From = replace(replace(replace([From], '<From=', ''), '><Address=', ';'), '>', ''), @Server = [Server], @Port = [Port], @Username = [Username], @Password = [Password] from [ess.EmailLU]

	if (@From like '%;%')
	begin

		set @Name = left(@From, charindex(';', @From) - 1)

		set @From = replace(@From, @Name + ';', '')

	end

	if (@Port is null)
		set @Port = 25

	if (@From is null)
		set @From = '<email address>'

	if (@Server is null)
		set @Server = '<server>'

	update [EmailLU] set [Address] = @From, [Server] = @Server, [Port] = @Port, [Username] = @Username, [Password] = @Password

	drop table [ess.EmailLU]

end
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess.EmailResults]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [ess.EmailResults]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess.Emails]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [ess.Emails]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess.Groups]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [ess.Groups]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess.Items]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [ess.Items]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess.KnowledgeBase]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [ess.KnowledgeBase]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess.KnowledgebaseOLD]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [ess.KnowledgebaseOLD]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess.MIMETypesLU]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [ess.MIMETypesLU]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess.RecruitScreenTemplate]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [ess.RecruitScreenTemplate]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Setup]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [ess.Setup]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.PerfEvalScheme]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [ess.PerfEvalScheme]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.PerfEvalSubmit]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [ess.PerfEvalSubmit]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Setup]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [ess.Setup_old]
GO
if exists (select [id] from [sysobjects] where id = object_id(N'[ess.Setup.new]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [ess.Setup.new]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess.Setup.old]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [ess.Setup.old]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.SetupItems]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [ess.SetupItems]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.SMSLU]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [ess.SMSLU]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.SMSResults]') and objectproperty([ID], N'IsUserTable') = 1)
	drop table [ess.SMSResults]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess.SMSs]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [ess.SMSs]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess.StoredPwd]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [ess.StoredPwd]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess.Setup_old]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [ess.Setup_old]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess.TPerfEvalScheme]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [ess.TPerfEvalScheme]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess.Tooltips]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [ess.Tooltips]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess.UserReports]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [ess.UserReports]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess.RecruitSaved]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [ess.RecruitSaved]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[web.Sessions]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [web.Sessions]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[PersonnelFiles]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [PersonnelFiles]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[Timesheet]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [Timesheet]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[TimesheetAllocation]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [TimesheetAllocation]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[TimesheetAllocationSetup]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [TimesheetAllocationSetup]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[TimesheetSubTypeLU]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [TimesheetSubTypeLU]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess.ReportLU]') and objectproperty([id], N'IsUserTable') = 1)
	drop table [ess.ReportLU]
GO

/**********************************************************************************************************

						*** v6.0.74 (Delete user functions not required) ***

***********************************************************************************************************/
if exists (select [id] from [sysobjects] where id = object_id(N'[GetLNALearnID]') and xtype in (N'FN', N'IF', N'TF'))
	drop function [dbo].[GetLNALearnID]
GO

/**********************************************************************************************************

						*** v6.0.74 (Delete stored procedures not required) ***

***********************************************************************************************************/
if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.CreateTemplateItems]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.CreateTemplateItems]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.TextID]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.TextID]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFCheck]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.WFCheck]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFVerify]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [ess.WFVerify]
GO

/*
if exists (select [id] from [sysobjects] where [id] = object_id(N'[SQLExecuteProc]') and objectproperty([ID], N'IsProcedure') = 1)
	drop procedure [SQLExecuteProc]
--GO
*/

/**********************************************************************************************************

							*** v6.0.74 (Delete views not required) ***

***********************************************************************************************************/
if exists (select [id] from [sysobjects] where id = object_id(N'[ess_Setup_new]') and objectproperty([id], N'IsView') = 1)
	drop view [ess_Setup]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess_Setup_new]') and objectproperty([id], N'IsView') = 1)
	drop view [ess_Setup_new]
GO

if exists (select [id] from [sysobjects] where id = object_id(N'[ess_Setup_old]') and objectproperty([id], N'IsView') = 1)
	drop view [ess_Setup_old]
GO

declare @iCount bigint,
		@iLoop bigint,
		@SQLExec nvarchar(4000),
		@sView sysname

declare @View table
(
	[id] bigint identity (1, 1) not null,
	[Name] sysname not null
)

insert into @View([Name]) select [name] from [sysobjects] where (([xtype] = N'V') and ([name] like 'essView.%'))

set @iLoop = 1

select @iCount = count([id]) from @View

while (@iLoop <= @iCount)
begin

	select @sView = [Name] from @View where ([id] = @iLoop)

	if exists (select [id] from [sysobjects] where [id] = object_id('[' + @sView + ']') and objectproperty([id], N'IsView') = 1)
	begin

		set @SQLExec = 'drop view [' + @sView + ']'

		exec sp_executesql @SQLExec

	end

	set @iLoop = @iLoop + 1
	
end
GO

/**********************************************************************************************************

							*** v6.0.74 (Delete triggers not required) ***

***********************************************************************************************************/
if exists (select [id] from [sysobjects] where id = object_id(N'[ess.RecruitSaved_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [ess.RecruitSaved_DTrig]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[TimesheetSubTypeLU_UTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[TimesheetSubTypeLU_UTrig]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.TimesheetTypeLU_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.TimesheetTypeLU_DTrig]
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.LeaveAdjustments_DTrig]') and objectproperty([id], N'IsTrigger') = 1)
	drop trigger [dbo].[ess.LeaveAdjustments_DTrig]
GO

/**********************************************************************************************************

							*** v6.0.74 (Delete data not required) ***

***********************************************************************************************************/
if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFLU]') and objectproperty([id], N'IsTable') = 1)
	delete from [ess.WFLU] where ([WFName] = 'IR' and [WFType] = 'IR')
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFAppType]') and objectproperty([id], N'IsTable') = 1)
	delete from [ess.WFAppType] where ([AppType] = 'IR' and [WFType] = 'IR' and [WFName] = 'IR')
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFTypeLU]') and objectproperty([id], N'IsTable') = 1)
	delete from [ess.WFTypeLU] where ([WFType] = 'IR' and [TableName] is null)
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.PolicyItems]') and objectproperty([id], N'IsTable') = 1)
	delete from [ess.PolicyItems] where ([PolicyID] in(select [ID] from [ess.Policy] where ([Key] in('ForceTime', 'ShowTime'))))
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Policy]') and objectproperty([id], N'IsTable') = 1)
	delete from [ess.Policy] where ([Key] in('ForceTime', 'ShowTime'))
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFTypeLU]') and objectproperty([id], N'IsTable') = 1)
	delete from [ess.WFTypeLU] where ([WFType] = 'Onboarding' and [Tablename] = 'Onboarding')
GO