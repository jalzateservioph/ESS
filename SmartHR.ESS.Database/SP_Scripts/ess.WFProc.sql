SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[ess.WFProc]') AND OBJECTPROPERTY(ID, N'ISPROCEDURE') = 1)
BEGIN
PRINT 'Dropping Procedure ess.WFProc'
DROP PROCEDURE [DBO].[ess.WFProc]	
END
PRINT 'Creating Procedure ess.WFProc'
GO

CREATE PROCEDURE DBO.[ess.WFProc]

	@ProcCompNum nvarchar(20), 
	@ProcEmpNum nvarchar(20), 
	@CompanyNum nvarchar(20), 
	@EmployeeNum nvarchar(12), 
	@PathID bigint, 
	@WFType nvarchar(50), 
	@AppType nvarchar(50), 
	@Status nvarchar(50), 
	@ActionType nvarchar(50), 
	@StartDate datetime, 
	@LoggedOnUser nvarchar(20) = '', 
	@WFLUName nvarchar(50) = ''

AS

----------------------------------------------------------------------------------------------------
SET NOCOUNT ON
----------------------------------------------------------------------------------------------------
BEGIN
----------------------------------------------------------------------------------------------------


declare @sSysDate datetime

set @sSysDate = getdate()

declare @WFCnt int
declare @WFLUID tinyint
declare @WFName nvarchar(50)

if (len(@WFLUName) = 0)
	select @WFName = [WFName] from [ess.WFAppType] where ([WFType] = @WFType) and ([AppType] = @AppType)

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

	update [ess.Path] set ActionID = @ActionID, WFLUID = @WFLUID, [ActionDate] = @sSysDate, [StatusID] = @StatusID, [WFID] = @tPostActID, [PAID] = @PAID, [OriginatorEmail] = @OrigEmail, [OriginatorCell] = @OrigCell, [EmailCC] = @EmailCC, [EmailBCC] = @EmailBCC, [SMSCC] = @SMSCC, [EmailOrigCC] = @EmailOrigCC, [EmailOrigBCC] = @EmailOrigBCC, [SMSOrigCC] = @SMSOrigCC, [EmailActCC] = @EmailActCC, [EmailActBCC] = @EmailActBCC, [SMSActCC] = @SMSActCC where [id] = @PathID

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

		if (upper(@WFType) = 'TRAINING' and (upper(@AppType) = 'EVALUATION' or upper(@AppType) = 'AGREEMENT'))
		begin

			set @CurCompNum = @CompanyNum

			set @CurEmpNum = @EmployeeNum

			set @OrigCompNum = @CompanyNum

			set @OrigEmpNum = @EmployeeNum

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
update [ess.Path] set [XMLTag] = '<WFType=' + @WFType + '><AppType=' + @AppType + '><StartDate=' + (SELECT CONVERT(varchar, @StartDate, 1)) + '>' where [id] = @PathIDNew

/* Create Audit Record */
insert into [ess.WFAudit]([PathID], [WFLUID], [WFName], [WFType], [Summary], [ActionID], [ActionType], [ActionDate], [StatusID], [StatusType], [PAID], [PostActType], [UserEmail], [UserCell], [WFID], [Actioner], [ActionerCompanyNum], [ActionerEmployeeNum], [ActionerUsername], [ActionedBy], [ActionedByCompNum], [ActionedByEmpNum], [ActionedByUsername], [EmailCC], [EmailBCC], [SMSCC], [EmailOrigCC], [EmailOrigBCC], [SMSOrigCC], [EmailActCC], [EmailActBCC], [SMSActCC], [Originator], [OriginatorCompanyNum], [OriginatorEmployeeNum], [OriginatorUsername], [OriginatorDate], [OriginatorEmail], [OriginatorCell], [PrevActioner], [PrevActionerCompNum], [PrevActionerEmpNum], [PrevActionerUsername]) select @PathIDNew, [WFLUID], @WFName, @WFType, [Summary], [ActionID], (select [ReportsToType] from [ess.ActionLU] where [id] = [p].[ActionID]), @sSysDate, [StatusID], (select [Status] from [ess.StatusLU] where [id] = [p].[StatusID]), [PAID], (select [id] from [ess.PALU] where [id] = [p].[PAID]), [UserEmail], [UserCell], [WFID], [Actioner], [ActionerCompanyNum], [ActionerEmployeeNum], [ActionerUsername], [ActionedBy], [ActionedByCompNum], [ActionedByEmpNum], [ActionedByUsername], [EmailCC], [EmailBCC], [SMSCC], [EmailOrigCC], [EmailOrigBCC], [SMSOrigCC], [EmailActCC], [EmailActBCC], [SMSActCC], [Originator], [OriginatorCompanyNum], [OriginatorEmployeeNum], [OriginatorUsername], [OriginatorDate], [OriginatorEmail], [OriginatorCell], [PrevActioner], [PrevActionerCompNum], [PrevActionerEmpNum], [PrevActionerUsername] from [ess.Path] as [p] where [id] = @PathIDNew

if (@WFType = 'Performance') and (@AppType = 'Performance') and (@Status = 'Start') and (@ActionType = 'Start')
begin

	if (len(@LoggedOnUser) > 0)
		insert into [ess.PerfSubmitted]([CompanyNum], [EmployeeNum], [Username], [PathID]) values(@ProcCompNum, @ProcEmpNum, @LoggedOnUser, @PathIDNew)

end
else
	select '<PathID=' + cast(@PathIDNew as nvarchar(19)) + '>'

----------------------------------------------------------------------------------------------------			
END
----------------------------------------------------------------------------------------------------
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
----------------------------------------------------------------------------------------------------