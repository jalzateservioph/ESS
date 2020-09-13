IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[ess.Cascade]') AND OBJECTPROPERTY(ID, N'ISPROCEDURE') = 1)
BEGIN
	PRINT 'Dropping Procedure ess.Cascade'
	DROP PROCEDURE [dbo].[ess.Cascade]	
END

PRINT N'Altering [dbo].[ess.Cascade]...';
GO

CREATE PROCEDURE [dbo].[ess.Cascade]
AS
BEGIN
	TRUNCATE TABLE [ess.PolicyItems]

	DECLARE
		@iCountPolicy	BIGINT
	   ,@iLoopPolicy	BIGINT
	   ,@iCountTemplate	BIGINT
	   ,@iLoopTemplate	BIGINT
	   ,@PolicyID		BIGINT
	   ,@Template		NVARCHAR(10)

	DECLARE @Policy TABLE
	(
		[ID] BIGINT IDENTITY (1,1) NOT NULL,
		[PolicyID] BIGINT NOT NULL,
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
		[LookupTable] [nvarchar] (75) NULL,
		[LookupText] [nvarchar] (75) NULL,
		[LookupValue] [nvarchar] (75) NULL,
		[LookupFilter] [ntext] NULL,
		[Validation] [ntext] NULL,
		[Approval] bit NULL,
		[ApprovalLevel] bit NULL
	)

	DECLARE @Templates TABLE
	(
		[ID] bigint identity (1, 1) not NULL,
		[Code] nvarchar(10) not NULL
	)

	insert into @Policy([PolicyID], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Approval], [ApprovalLevel]) select [ID], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Approval], [ApprovalLevel] from [ess.Policy] where ([Cascade] = 1) order by [ID]

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
				insert into [ess.PolicyItems]([PolicyID], [Template], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Approval], [ApprovalLevel]) select @PolicyID, @Template, [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Approval], [ApprovalLevel] from [ess.Policy] where ([ID] = @PolicyID)

			set @iLoopTemplate = @iLoopTemplate + 1

		end

		set @iLoopPolicy = @iLoopPolicy + 1

	end
END
GO