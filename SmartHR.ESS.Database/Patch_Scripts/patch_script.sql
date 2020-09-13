BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_ess.Change] (
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
PRINT N'Altering [dbo].[ess.Policy]...';


GO
ALTER TABLE [dbo].[ess.Policy]
    ADD [Approval]      BIT DEFAULT ((0)) NOT NULL,
        [ApprovalLevel] INT DEFAULT ((0)) NOT NULL;


GO
PRINT N'Altering [dbo].[ess.PolicyItems]...';


GO
ALTER TABLE [dbo].[ess.PolicyItems]
    ADD [Approval]      BIT DEFAULT ((0)) NOT NULL,
        [ApprovalLevel] INT DEFAULT ((0)) NOT NULL;


GO
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
PRINT N'Starting rebuilding table [dbo].[RelWorkingInTMP]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_RelWorkingInTMP] (
    [CompanyNum]  NVARCHAR (40)  NOT NULL,
    [EmployeeNum] NVARCHAR (24)  NOT NULL,
    [Position]    NVARCHAR (100) NULL,
    [AppliedOn]   DATETIME       NULL,
    [FirstName]   NVARCHAR (80)  NOT NULL,
    [Surname]     NVARCHAR (80)  NOT NULL,
    [MiddleName]  NVARCHAR (80)  NULL,
    [Relation]    NVARCHAR (50)  NULL,
    [PlaceOfWork] NVARCHAR (100) NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_RelWorkingInTMP] PRIMARY KEY CLUSTERED ([CompanyNum] ASC, [EmployeeNum] ASC, [Surname] ASC, [FirstName] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[RelWorkingInTMP])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_RelWorkingInTMP] ([CompanyNum], [EmployeeNum], [Surname], [FirstName], [Position], [AppliedOn], [MiddleName], [Relation], [PlaceOfWork])
        SELECT   [CompanyNum],
                 [EmployeeNum],
                 [Surname],
                 [FirstName],
                 [Position],
                 [AppliedOn],
                 [MiddleName],
                 [Relation],
                 [PlaceOfWork]
        FROM     [dbo].[RelWorkingInTMP]
        ORDER BY [CompanyNum] ASC, [EmployeeNum] ASC, [Surname] ASC, [FirstName] ASC;
    END

DROP TABLE [dbo].[RelWorkingInTMP];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_RelWorkingInTMP]', N'RelWorkingInTMP';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_RelWorkingInTMP]', N'PK_RelWorkingInTMP', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating [dbo].[BloodTypeLU]...';


GO
CREATE TABLE [dbo].[BloodTypeLU] (
    [BloodType] NVARCHAR (10) NULL
);


GO
PRINT N'Creating [dbo].[DependantsForApproval]...';


GO
CREATE TABLE [dbo].[DependantsForApproval] (
    [CompanyNum]        NVARCHAR (20)  NOT NULL,
    [EmployeeNum]       NVARCHAR (20)  NOT NULL,
    [DependName]        NVARCHAR (100) NULL,
    [DepMidName]        NVARCHAR (100) NULL,
    [Surname]           NVARCHAR (100) NULL,
    [IDNum]             NVARCHAR (100) NULL,
    [DoB]               DATETIME       NULL,
    [Sex]               NVARCHAR (100) NULL,
    [ContactNumber]     NVARCHAR (100) NULL,
    [Nationality]       NVARCHAR (100) NULL,
    [DepCivilStat]      NVARCHAR (100) NULL,
    [OnMedicalAid]      TINYINT        NULL,
    [DepDeceased]       TINYINT        NULL,
    [MedicalAidStartDt] DATETIME       NULL,
    [MedicalAidEndDt]   DATETIME       NULL,
    [DepOccupation]     NVARCHAR (100) NULL,
    [DepEmployer]       NVARCHAR (100) NULL,
    [DepAddress]        NVARCHAR (100) NULL,
    [PathID]            BIGINT         NULL
);


GO
PRINT N'Creating [dbo].[RelativesLU]...';


GO
CREATE TABLE [dbo].[RelativesLU] (
    [Relatives] NVARCHAR (20) NOT NULL
);


GO
PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';


GO
ALTER TABLE [dbo].[DependantsForApproval]
    ADD DEFAULT ('') FOR [DepAddress];


GO
PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';


GO
ALTER TABLE [dbo].[DependantsForApproval]
    ADD DEFAULT ((0)) FOR [OnMedicalAid];


GO
PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';


GO
ALTER TABLE [dbo].[DependantsForApproval]
    ADD DEFAULT ('') FOR [DepCivilStat];


GO
PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';


GO
ALTER TABLE [dbo].[DependantsForApproval]
    ADD DEFAULT ((0)) FOR [DepDeceased];


GO
PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';


GO
ALTER TABLE [dbo].[DependantsForApproval]
    ADD DEFAULT ('') FOR [DepOccupation];


GO
PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';


GO
ALTER TABLE [dbo].[DependantsForApproval]
    ADD DEFAULT ('') FOR [DepEmployer];


GO
PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';


GO
ALTER TABLE [dbo].[DependantsForApproval]
    ADD DEFAULT ('') FOR [DependName];


GO
PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';


GO
ALTER TABLE [dbo].[DependantsForApproval]
    ADD DEFAULT ('') FOR [DepMidName];


GO
PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';


GO
ALTER TABLE [dbo].[DependantsForApproval]
    ADD DEFAULT ('') FOR [Surname];


GO
PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';


GO
ALTER TABLE [dbo].[DependantsForApproval]
    ADD DEFAULT ('') FOR [IDNum];


GO
PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';


GO
ALTER TABLE [dbo].[DependantsForApproval]
    ADD DEFAULT ('') FOR [Nationality];


GO
PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';


GO
ALTER TABLE [dbo].[DependantsForApproval]
    ADD DEFAULT ('') FOR [ContactNumber];


GO
PRINT N'Creating unnamed constraint on [dbo].[DependantsForApproval]...';


GO
ALTER TABLE [dbo].[DependantsForApproval]
    ADD DEFAULT ('') FOR [Sex];


GO
PRINT N'Creating [dbo].[RelWorkingInTMP_ITrig]...';


GO
CREATE TRIGGER "RelWorkingInTMP_ITrig" ON RelWorkingInTMP FOR INSERT AS
SET NOCOUNT ON
/* * PREVENT INSERTS IF NO MATCHING KEY IN 'RecPositionApplied' */
IF (SELECT COUNT(*) FROM inserted) != 
   (SELECT COUNT(*) FROM RecPositionApplied, inserted WHERE (RecPositionApplied.CompanyNum = inserted.CompanyNum AND RecPositionApplied.EmployeeNum = inserted.EmployeeNum AND RecPositionApplied.Position = inserted.Position AND RecPositionApplied.AppliedOn = inserted.AppliedOn))
    BEGIN
        RAISERROR (44447, -1, -1, 'The record can''t be added or changed. Referential integrity rules require a related record in table ''RecPositionApplied''.')
        Rollback TRANSACTION
    End
GO
PRINT N'Creating [dbo].[RelWorkingInTMP_UTrig]...';


GO
CREATE TRIGGER "RelWorkingInTMP_UTrig" ON RelWorkingInTMP FOR UPDATE AS
SET NOCOUNT ON
/* * PREVENT UPDATES IF NO MATCHING KEY IN 'RecPositionApplied' */
IF UPDATE(CompanyNum) OR UPDATE(EmployeeNum) OR UPDATE(Position) OR UPDATE(AppliedOn)
    BEGIN
        IF (SELECT COUNT(*) FROM inserted) !=
   (SELECT COUNT(*) FROM RecPositionApplied, inserted WHERE (RecPositionApplied.CompanyNum = inserted.CompanyNum AND RecPositionApplied.EmployeeNum = inserted.EmployeeNum AND RecPositionApplied.Position = inserted.Position AND RecPositionApplied.AppliedOn = inserted.AppliedOn))
    BEGIN
        RAISERROR (44447, -1, -1, 'The record can''t be added or changed. Referential integrity rules require a related record in table ''RecPositionApplied''.')
        Rollback TRANSACTION
    End
END
GO
PRINT N'Creating [dbo].[Trig.ChangeToReject]...';


GO

CREATE TRIGGER [Trig.ChangeToReject] ON [ess.Change] FOR DELETE
AS
	INSERT INTO [ess.Reject] SELECT *, '' FROM deleted
GO
PRINT N'Creating [dbo].[ess.Change_UTrigPathN]...';


GO
SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER OFF;


GO
create trigger [dbo].[ess.Change_UTrigPathN] on [dbo].[ess.Change]
after update
as

if (update([PathID]))
	delete [ess.Path] from [deleted], [ess.Path], [inserted] where [ess.Path].[ID] = [deleted].[PathID] and [inserted].[PathID] is null
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [dbo].[fnCalculateAge]...';


GO
CREATE FUNCTION [dbo].[fnCalculateAge] (@DateOfBirth DATETIME)
RETURNS INT
AS
BEGIN
	DECLARE @Age INT
	
	SET @Age = DATEDIFF(YY,@DateOfBirth,GETDATE()) - (CASE WHEN DATEADD(YY,DATEDIFF(YY,@DateOfBirth,GETDATE()),@DateOfBirth) > GETDATE() THEN 1 ELSE 0 END)
	
	RETURN @Age
END
GO
PRINT N'Refreshing [dbo].[ess_Change]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[ess_Change]';


GO
PRINT N'Refreshing [dbo].[ess_Policy]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[ess_Policy]';


GO
PRINT N'Refreshing [dbo].[ess_PolicyItems]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[ess_PolicyItems]';


GO
PRINT N'Creating [dbo].[vwPersonnelInformation]...';


GO
-- ======================================= --
--  CREATED BY: RANDOLPH BENJO T. NAANEP   --
--      GURANGO SOFTWARE CORPORATION       --
-- ======================================= --

CREATE VIEW [dbo].[vwPersonnelInformation]
AS
	SELECT
		A.[CompanyNum]
	   ,A.[EmployeeNum]
	   ,[PreferredName]
	   ,[Title]
	   ,[Initials]
	   ,[Surname]
	   ,[FirstName]
	   ,[MiddleName]
	   ,[MaidenName]
	   ,[IDNum]
	   ,[Sex]
	   ,[Nationality]
	   ,[BirthDate]
	   ,[dbo].[fnCalculateAge](BirthDate) AS [Age]
	   ,[ZodiacSign]
	   ,[ZodiacSignActual]
	   ,[Language]
	   ,[Religion]
	   ,[EthnicGroup]
	   ,[MaritialStatus] AS [MaritalStatus]
	   ,[Disability]
	   ,[DisabilityNotes]
	   ,[ShuttleRoute]
	   ,[Address1]
	   ,[Address2]
	   ,[Address3]
	   ,[Address4]
	   ,[POBox]
	   ,[POArea]
	   ,[POCode]
	   ,[OfficeNo]
	   ,[CellTel]
	   ,[ExtensionNo]
	   ,[HomeTel]
	   ,[EMailAddress]
	   ,[AddrUnit]
	   ,[AddrComplex]
	   ,[AddrStreetNo]
	   ,[AddrStreetName]
	   ,[AddrSuburb]
	   ,[AddrCity]
	   ,[AddrZip]
	   ,[Latitude]
	   ,[Longitude]
	   ,[EMailAddress1]
	   ,[FaxNo]
	   ,[SpouseName]
	   ,[SpouseMiddleName]
	   ,[SpouseSurname]
	   ,[SpouseDOB]
	   ,[dbo].[fnCalculateAge](SpouseDOB) AS [SpouseAge]
	   ,[SpouseTel]
	   ,[SpouseEmployer]
	   ,[SpouseEmployerAdd]
	   ,[SpouseOccu]
	   ,[SpouseNationality]
	   ,[NOK_Surname]
	   ,[NOK_FirstName]
	   ,[NOK_MiddleName]
	   ,[NOK_DateOfBirth]
	   ,[dbo].[fnCalculateAge](NOK_DateOfBirth) AS [NOK_Age]
	   ,[NOK_Gender]
	   ,[NOK_Relationship]
	   ,[NOK_ERAddress]
	   ,[NOK_ContactNo]
	   ,[NOK_Occupation]
	   ,[NOK_Employer]
	   ,[BIRMembershipNo]
	   ,[SSSMembershipNo]
	   ,[PAGIBIGMembershipNo]
	   ,[PHILMemNo]
	FROM [Personnel]			AS A
		INNER JOIN [Personnel1]	AS B
			ON A.CompanyNum = B.CompanyNum AND A.EmployeeNum = B.EmployeeNum
GO
PRINT N'Altering [dbo].[ess.Cascade]...';


GO
ALTER PROCEDURE [dbo].[ess.Cascade]
AS
BEGIN
	TRUNCATE TABLE [ess.PolicyItems]

	DECLARE
		@iCountPolicy	BIGINT
	   ,@iLoopPolicy	BIGINT
	   ,@iCountTemplate	BIGINT
	   ,@iLoopTemplate	BIGINT
	   ,@PolicyID		TINYINT
	   ,@Template		NVARCHAR(10)

	DECLARE @Policy TABLE
	(
		[ID] BIGINT IDENTITY (1,1) NOT NULL,
		[PolicyID] [tinyint] NOT NULL,
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
PRINT N'Creating [dbo].[ess.Approve]...';


GO
CREATE PROCEDURE [dbo].[ess.Approve]
	@CompanyNum	 NVARCHAR(MAX)
   ,@EmployeeNum NVARCHAR(MAX)
   ,@PathID		 INT
   ,@Counter	 INT
   ,@ActionType	 NVARCHAR(MAX)
AS
BEGIN
	DECLARE @LastApprover NVARCHAR(MAX)
	
	SELECT @LastApprover = E.ReportsToType FROM [ess.WF] AS A INNER JOIN [ess.WFLU] AS B ON A.WFLUID = B.ID INNER JOIN [ess.StatusLU] AS C ON A.StatusID = C.ID INNER JOIN [ess.PALU] AS D ON A.PAID = D.ID INNER JOIN [ess.ActionLU] AS E ON A.ActionID = E.ID
		WHERE B.WFType = 'Change' AND B.WFName = 'Approve' AND D.PostActionType = 'Completed'
	
	UPDATE [ess.Change] SET Level = (CASE WHEN @ActionType = @LastApprover THEN 0 ELSE Level - @Counter END) WHERE CompanyNum = @CompanyNum AND EmployeeNum = @EmployeeNum AND PathID = @PathID
	
	SELECT
		[Table] = (CASE WHEN D.[Typename] LIKE '%GridView%'	THEN B.[Key]
						WHEN C.[Name] = 'ePersonal'			THEN 'Personnel'
						WHEN C.[Name] = 'eOrganizational'	THEN 'Personnel1'
						ELSE '' END)
	   ,[Field] = (CASE WHEN D.[Typename] LIKE '%GridView%'	THEN A.[AdditionalField] ELSE B.[Key] END)
	   ,[Where]	= (CASE WHEN D.[Typename] LIKE '%GridView%'	THEN 'AND DependName = ''' + A.[AdditionalFilter] + '''' ELSE '' END)
	   ,[Value]	= A.[ValueT]
	INTO #CHANGES FROM [ess.Change]	  AS A
		INNER JOIN [ess.Policy]		  AS B ON B.ID = A.PolicyID
		INNER JOIN [ess.PolicyGroups] AS C ON C.ID = B.GroupID
		INNER JOIN [AssemblyLU]		  AS D ON D.ID = B.AssemblyID
	WHERE A.CompanyNum = @CompanyNum AND A.EmployeeNum = @EmployeeNum AND A.PathID = @PathID AND A.Level = 0
	
	WHILE ((SELECT COUNT(*) FROM #CHANGES) > 0)
	BEGIN
		DECLARE
			@Query NVARCHAR(MAX)
		   ,@Table NVARCHAR(MAX)
		   ,@Field NVARCHAR(MAX)
		   ,@Where NVARCHAR(MAX)
		   ,@Value NVARCHAR(MAX)
		
		SELECT TOP(1) @Table = [Table], @Field = [Field], @Value = [Value], @Where = [Where] FROM #CHANGES
		
		SET @Query = 'UPDATE ' + @Table + ' SET ' + @Field + ' = ''' + @Value + ''' WHERE CompanyNum = ''' + @CompanyNum + ''' AND EmployeeNum = ''' + @EmployeeNum + ''' ' + @Where
		
		IF EXISTS (SELECT 1 FROM sys.columns WHERE Name = @Field AND Object_ID = Object_ID(@Table))
		BEGIN
			EXEC(@Query)
		END
		
		DELETE FROM #CHANGES WHERE [Field] = @Field AND [Value] = @Value
	END
	
	DROP TABLE #CHANGES
	
	IF (SELECT COUNT(*) FROM [ess.Change] WHERE [CompanyNum] = @CompanyNum AND [EmployeeNum] = @EmployeeNum AND [PathID] = @PathID AND [Level] > 0) = 0
	BEGIN
		DECLARE
			@NewActioner	 NVARCHAR(100) = ''
		   ,@NewCompanyCode	 NVARCHAR(100) = ''
		   ,@NewEmployeeCode NVARCHAR(100) = ''
		   ,@NewUsername	 NVARCHAR(100) = ''
		
		SELECT
			@NewActioner	 = Originator
		   ,@NewCompanyCode	 = OriginatorCompanyNum
		   ,@NewEmployeeCode = OriginatorEmployeeNum
		   ,@NewUsername	 = OriginatorUsername
		FROM [ess.Path] WHERE ID = @PathID
		
		UPDATE [ess.Path] SET
			Actioner			 = @NewActioner
		   ,ActionerCompanyNum	 = @NewCompanyCode
		   ,ActionerEmployeeNum	 = @NewEmployeeCode
		   ,ActionerUsername	 = @NewUsername
		   ,UserEmail			 = (SELECT TOP(1) EmailAddress FROM Personnel WHERE CompanyNum = @NewCompanyCode AND EmployeeNum = @NewEmployeeCode)
		   ,PAID				 = 5
		   ,WFID				 = 191
		WHERE [ID] = @PathID
	END
END
GO
PRINT N'Creating [dbo].[ess.AutoApproved]...';


GO
CREATE PROCEDURE [ess.AutoApproved]
	@CompanyNum	 NVARCHAR(MAX)
   ,@EmployeeNum NVARCHAR(MAX)
   ,@Template	 NVARCHAR(MAX)
   ,@PathID		 INT
AS
BEGIN
	SELECT D.[Name], B.[Key], A.[ValueT] INTO #CHANGES FROM [ess.Change] AS A INNER JOIN [ess.Policy] AS B ON A.PolicyID = B.ID INNER JOIN [ess.PolicyItems] AS C ON A.PolicyID = C.PolicyID INNER JOIN [ess.PolicyGroups] AS D ON B.GroupID = D.ID
		WHERE A.CompanyNum = @CompanyNum AND A.EmployeeNum = @EmployeeNum AND A.PathID = @PathID AND C.Template = @Template AND C.Approval = 0
	
	WHILE ((SELECT COUNT(*) FROM #CHANGES) > 0)
	BEGIN
		DECLARE
			@Query NVARCHAR(MAX)
		   ,@Table NVARCHAR(MAX)
		   ,@Field NVARCHAR(MAX)
		   ,@Value NVARCHAR(MAX)
		
		SELECT TOP(1) @Table = (CASE WHEN [Name] = 'ePersonal' THEN 'Personnel' WHEN [Name] = 'eOrganizational' THEN 'Personnel1' ELSE '' END), @Field = [Key], @Value = [ValueT] FROM #CHANGES
		
		SET @Query = 'UPDATE ' + @Table + ' SET ' + @Field + ' = ''' + @Value + ''' WHERE CompanyNum = ''' + @CompanyNum + ''' AND EmployeeNum = ''' + @EmployeeNum + ''''
		
		IF EXISTS (SELECT 1 FROM sys.columns WHERE Name = @Field AND Object_ID = Object_ID(@Table))
		BEGIN
			EXEC(@Query)
		END
		
		DELETE FROM #CHANGES WHERE [Key] = @Field AND [ValueT] = @Value
	END
	
	DROP TABLE #CHANGES
END
GO
PRINT N'Creating [dbo].[ess.ChangeDependants]...';


GO
CREATE PROCEDURE [dbo].[ess.ChangeDependants]
	@CompanyNum	 NVARCHAR(100)
   ,@EmployeeNum NVARCHAR(100)
   ,@NotifyDate	 DATETIME
   ,@FieldName	 NVARCHAR(100)
   ,@Caption	 NVARCHAR(100)
   ,@ChangeFrom	 NVARCHAR(100)
   ,@ChangeTo	 NVARCHAR(100)
   ,@Filter		 NVARCHAR(100)
AS
BEGIN
	INSERT INTO [ess.Change] (CompanyNum, EmployeeNum, NotifyDate, PolicyID, AssemblyID, Template, ValueF, ValueT, Level, AdditionalField, AdditionalName, AdditionalFilter)
		VALUES (@CompanyNum, @EmployeeNum, @NotifyDate, 42, 19, 'Personal Tab', @ChangeFrom, @ChangeTo, 1, @FieldName, @Caption, @Filter)
END
GO
PRINT N'Creating [dbo].[ess.Return]...';


GO
CREATE PROCEDURE [dbo].[ess.Return]
	@PathID BIGINT
AS
BEGIN
	DECLARE
		@OldActioner	 NVARCHAR(100) = ''
	   ,@OldCompanyCode	 NVARCHAR(100) = ''
	   ,@OldEmployeeCode NVARCHAR(100) = ''
	   ,@OldUsername	 NVARCHAR(100) = ''
	   ,@NewActioner	 NVARCHAR(100) = ''
	   ,@NewCompanyCode	 NVARCHAR(100) = ''
	   ,@NewEmployeeCode NVARCHAR(100) = ''
	   ,@NewUsername	 NVARCHAR(100) = ''
	
	SELECT
		@OldActioner	 = Actioner
	   ,@OldCompanyCode	 = ActionedByCompNum
	   ,@OldEmployeeCode = ActionerEmployeeNum
	   ,@OldUsername	 = ActionerUsername
	   ,@NewActioner	 = (CASE WHEN ActionerEmployeeNum = OriginatorEmployeeNum THEN PrevActioner ELSE Originator			 END)
	   ,@NewCompanyCode	 = (CASE WHEN ActionerEmployeeNum = OriginatorEmployeeNum THEN PrevActionerCompNum ELSE OriginatorCompanyNum	 END)
	   ,@NewEmployeeCode = (CASE WHEN ActionerEmployeeNum = OriginatorEmployeeNum THEN PrevActionerEmpNum ELSE OriginatorEmployeeNum END)
	   ,@NewUsername	 = (CASE WHEN ActionerEmployeeNum = OriginatorEmployeeNum THEN PrevActionerUsername ELSE OriginatorUsername	 END)
	FROM [ess.Path] WHERE ID = @PathID
	
	UPDATE [ess.Path] SET
		Actioner			 = @NewActioner
	   ,ActionerCompanyNum	 = @NewCompanyCode
	   ,ActionerEmployeeNum	 = @NewEmployeeCode
	   ,ActionerUsername	 = @NewUsername
	   ,PrevActioner		 = @OldActioner
	   ,PrevActionerCompNum	 = @OldCompanyCode
	   ,PrevActionerEmpNum	 = @OldEmployeeCode
	   ,PrevActionerUsername = @OldUsername
	   ,UserEmail			 = (SELECT TOP(1) EmailAddress FROM Personnel WHERE EmployeeNum = @NewEmployeeCode)
	WHERE [ID] = @PathID
END
GO
PRINT N'Refreshing [dbo].[ess.ChangePath]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[ess.ChangePath]';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Refreshing [dbo].[ess.LeaveCancel]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[ess.LeaveCancel]';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Refreshing [dbo].[ess.TrainingCancel]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[ess.TrainingCancel]';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Refreshing [dbo].[sp_getEMPApp_Form]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[sp_getEMPApp_Form]';


GO
PRINT N'Refreshing [dbo].[sp_getOjtApp_Form]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[sp_getOjtApp_Form]';


GO
PRINT N'Refreshing [dbo].[sp_getOjtApp_Form_2nd]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[sp_getOjtApp_Form_2nd]';


GO
PRINT N'Refreshing [dbo].[sp_getOjtApp_Form_V2]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[sp_getOjtApp_Form_V2]';


GO
PRINT N'Update complete.';


GO

-------------------------

INSERT INTO [dbo].[UserGroupTemplates] ([Code], [Name]) VALUES (N'SuperAdmin', N'SUPER ADMINISTRATOR')
DELETE FROM [dbo].[ess.Policy] WHERE ID > 149
SET IDENTITY_INSERT [dbo].[ess.Policy] ON
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (150, 7, 5, 3, 6, 13, N'Category', N'cmbCategory', N'Category', N'This setting specifies whether the category field in the organizational module should be displayed. Default: Enabled on new installations.', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'[OFOCodeLU]', N'[OFOCode]', N'[OFOCode]', NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (151, 7, 5, 3, 6, 13, N'PayLevel', N'cmbPayLevel', N'Pay Level', N'This setting specifies whether the Pay Level field in the organizational module should be displayed. Default: Enabled on new installations.', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'[OFOCodeOccupLU]', N'[Occupation]', N'[Occupation]', NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (152, 7, 5, 3, 6, 13, N'Shifting', N'cmbShifting', N'Shifting', N'This setting specifies whether the Shifting field in the organizational module should be displayed. Default: Enabled on new installations.', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'[ShiftTypeLU]', N'[ShiftType]', N'[ShiftType]', N'[CompanyNum] = ''<%CompanyNum%>''', NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (153, 7, 5, 3, 6, 13, N'WorkAssignment', N'cmbWorkAssignment', N'Work Assignment', N'This setting specifies whether the Work Assignment field in the organizational module should be displayed. Default: Enabled on new installations.', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'[LocationCategoryLU]', N'[Category]', N'[Category]', NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (154, 7, 5, 3, 6, 13, N'UnionAffiliation', N'cmbUnionAffiliation', N'Union Affiliation', N'This setting specifies whether the Union Affiliation field in the organizational module should be displayed. Default: Enabled on new installations.', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'[JobTitle]', N'[Jobtitle]', N'[JobTitle]', N'[CompanyNum] = ''<%CompanyNum%>''', NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (155, 7, 5, 3, 6, 13, N'ShirtSize', N'cmbShirtSize', N'Shirt Size', N'This setting specifies whether the Shirt Size field in the organizational module should be displayed. Default: Enabled on new installations.', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'[PersonnelAttribute]', N'[AttributeValue]', N'[AttributeValue]', N'[CompanyNum] = ''<%CompanyNum%>'' and [EmployeeNum] = ''<%EmployeeNum%>'' and [AttributeName] = ''SHIRT SIZE''', NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (156, 7, 5, 3, 19, 13, N'Blazer', N'txtBlazer', N'Blazer', N'This setting specifies whether the Blazer field in the organizational module should be displayed. Default: Enabled on new installations.', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (157, 7, 5, 3, 19, 13, N'Skirt', N'txtSkirt', N'Skirt', N'This setting specifies whether the Skirt field in the organizational module should be displayed. Default: Enabled on new installations.', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (158, 7, 5, 3, 19, 13, N'Blouse', N'txtBlouse', N'Blouse', N'This setting specifies whether the Blouse field in the organizational module should be displayed. Default: Enabled on new installations.', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (159, 7, 5, 3, 19, 13, N'Slacks', N'txtSlacks', N'Slacks', N'This setting specifies whether the Slacks field in the organizational module should be displayed. Default: Enabled on new installations.', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (160, 7, 5, 3, 19, 13, N'Shirtjack', N'txtShirtjack', N'Shirtjack', N'This setting specifies whether the Shirtjack field in the organizational module should be displayed. Default: Enabled on new installations.', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (161, 7, 5, 3, 19, 13, N'ShirtjackPants', N'txtShirtjackPants', N'Shirtjack Pants', N'This setting specifies whether the ShirtjackPants field in the organizational module should be displayed. Default: Enabled on new installations.', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (162, 7, 5, 3, 19, 13, N'PoloBarong', N'txtPoloBarong', N'Polo/Barong', N'This setting specifies whether the Polo/Barong field in the organizational module should be displayed. Default: Enabled on new installations.', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (163, 7, 5, 3, 19, 13, N'RepellantPants', N'txtRepellantPants', N'Repellant Pants', N'This setting specifies whether the Repellant Pants field in the organizational module should be displayed. Default: Enabled on new installations.', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (164, 7, 5, 3, 19, 13, N'PoloShirt', N'txtPoloShirt', N'Polo Shirt', N'This setting specifies whether the Polo Shirt field in the organizational module should be displayed. Default: Enabled on new installations.', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (165, 7, 5, 3, 19, 13, N'MaongPants', N'txtMaongPants', N'Maong Pants', N'This setting specifies whether the Maong Pants field in the organizational module should be displayed. Default: Enabled on new installations.', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (166, 7, 5, 3, 19, 13, N'TShirt', N'txtTShirt', N'T-Shirt', N'This setting specifies whether the T-Shirt field in the organizational module should be displayed. Default: Enabled on new installations.', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (167, 7, 5, 3, 19, 13, N'Overalls', N'txtOveralls', N'Overalls', N'This setting specifies whether the Overalls field in the organizational module should be displayed. Default: Enabled on new installations.', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (168, 6, 5, 3, 19, 13, N'NOK_Surname', N'txtGuardianLastName', N'Emergency Contact Last Name', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (169, 6, 5, 3, 19, 13, N'NOK_FirstName', N'txtGuardianFirstName', N'Emergency Contact First Name', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (170, 6, 5, 3, 19, 13, N'NOK_MiddleName', N'txtGuardianMiddleName', N'Emergency Contact Middle Name', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (171, 6, 5, 3, 19, 13, N'NOK_Age', N'txtGuardianAge', N'Emergency Contact Age', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (172, 6, 5, 3, 19, 13, N'NOK_ERAddress', N'txtGuardianAddress', N'Emergency Contact Address', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (173, 6, 5, 3, 19, 13, N'NOK_ContactNo', N'txtGuardianContactNo', N'Emergency Contact Contact Information', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (174, 6, 5, 3, 19, 13, N'NOK_Occupation', N'txtGuardianOccupation', N'Emergency Contact Occupation', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (175, 6, 5, 3, 19, 13, N'NOK_Employer', N'txtGuardianEmployer', N'Emergency Contact Employer', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (176, 6, 5, 3, 6, 13, N'NOK_Gender', N'txtGuardianSex', N'Emergency Contact Gender', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'[SexLU]', N'[Sex]', N'[Sex]', NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (177, 6, 5, 3, 6, 13, N'NOK_Relationship', N'txtGuardianRelationship', N'Emergency Contact Relationship', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'[RelativesLU]', N'[Relatives]', N'[Relatives]', NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (178, 6, 5, 3, 7, 15, N'NOK_DateOfBirth', N'dteGuardianBirthDate', N'Emergency Contact Birthdate', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (179, 6, 5, 3, 19, 13, N'Initials', N'txtSuffix', N'Suffix', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (180, 6, 5, 3, 19, 13, N'MaidenName', N'txtMaidenName', N'Mother'' Maiden Name', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (181, 6, 5, 3, 19, 13, N'MiddleName', N'txtMiddleName', N'Middle Name', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (182, 6, 5, 3, 19, 13, N'Age', N'txtAge', N'Middle Name', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (183, 6, 5, 3, 19, 13, N'ZodiacSign', N'txtAnimalSign', N'Animal Sign', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (184, 6, 5, 3, 19, 13, N'ZodiacSignActual', N'txtZodiacSign', N'Zodiac Sign', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (185, 6, 5, 3, 19, 13, N'SpouseMiddleName', N'txtSpouseMiddleName', N'SpouseMiddleName', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (186, 7, 5, 3, 19, 13, N'SpouseSurname', N'txtSpouseSurname', N'SpouseSurname', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (188, 6, 5, 3, 19, 13, N'BIRMembershipNo', N'txtTIN', N'BIR Membership No.', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (189, 6, 5, 3, 19, 13, N'SSSMembershipNo', N'txtSSS', N'SSS Membership No.', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (190, 6, 5, 3, 19, 13, N'PAGIBIGMembershipNo', N'txtHDMF', N'Pag-Ibig Membership No.', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (191, 6, 5, 3, 19, 13, N'PHILMemNo', N'txtPHIC', N'Phil-Health Membership No.', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (192, 2, 19, 13, 19, 13, N'PersonnelMovement', NULL, NULL, N'This setting allows you to exclude specific actions from the personnel history grid. Default: Not configured on new installations. Note: When using this policy you can configure to hide specific categories. This policy can contain a comma seperated list e.g. Transfer, Recruited', 0, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Transfer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (193, 2, 19, 13, 19, 13, N'AdminRestriction', NULL, NULL, N'This setting allows a SuperAdmin to control which fields are maintained by other users. Default: Not configured on new installations. Note: When using this policy you can configure to hide specific items. This policy can contain a comma seperated list e.g. Age, BloodType', 0, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Title', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (194, 6, 5, 3, 19, 13, N'SpouseTel', N'txtSpouseTel', N'Spouse Contact Information', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (196, 6, 5, 3, 19, 13, N'SpouseAge', N'txtSpouseAge', N'Spouse Age', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (197, 6, 5, 3, 19, 13, N'SpouseOccu', N'txtSpouseOccupation', N'Spouse Occupation', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (198, 6, 5, 3, 19, 13, N'SpouseEmployer', N'txtSpouseEmployer', N'Spouse Employer', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (199, 6, 5, 3, 19, 13, N'SpouseEmployerAdd', N'txtSpouseEmployerAddress', N'Spouse Employer Address', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (200, 9, 5, 3, 21, 18, N'Certifications', N'dgView_005', N'Certifications', N'This setting specifies whether the certifications grid in the curriculum viate module should be displayed.      Default:      Enabled on new installations.', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([ID], [GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (201, 9, 5, 3, 21, 18, N'Seminars', N'dgView_005', N'Certifications', N'This setting specifies whether the seminars grid in the curriculum viate module should be displayed.      Default:      Enabled on new installations.', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
SET IDENTITY_INSERT [dbo].[ess.Policy] OFF
SET IDENTITY_INSERT [dbo].[ess.PolicyGroups] ON
INSERT INTO [dbo].[ess.PolicyGroups] ([ID], [Name], [Description]) VALUES (9, N'eCurriculumVitae', N'This group policy is used for all curriculum vitae policy configurations.')
SET IDENTITY_INSERT [dbo].[ess.PolicyGroups] OFF
SET IDENTITY_INSERT [dbo].[EmailLU] ON
INSERT INTO [dbo].[EmailLU] ([ID], [Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) VALUES (72, N'Change: Auto-Approve', N'mail.smtp2go.com', 2525, N'admin@gurango.net', N'G3d8Wzb/qtoLTxAoJmme+A==', N'ESS Administrator', N'admin@gurango.net', N'SmartHR: Your Change Application', N'<p>Dear <%PARAM[5]%>,</p><p>&nbsp;</p><p>This is to inform you that changes has been made to your PERSONNEL INFORMATION on <%PARAM[0]%>. </p><p>{TABLE1: SELECT[11]%>}</p><p>If this was not you, kindly inform HR immediately. For inquiries, please call Compensation &amp; Benefits Section at local 8044, 8114, or 8199.</p><p>&nbsp;</p><p>Thank you. </p>', NULL)
INSERT INTO [dbo].[EmailLU] ([ID], [Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) VALUES (73, N'Change: Returned for Revision', N'mail.smtp2go.com', 2525, N'admin@gurango.net', N'G3d8Wzb/qtoLTxAoJmme+A==', N'ESS Administrator', N'admin@gurango.net', N'SmartHR: Your Change Application', N'Dear <%PARAM[5]%>,<p>&nbsp;</p><p>This is to inform you that changes you have made to your PERSONNEL INFORMATION is returned for revision&nbsp;on <%PARAM[0]%>. </p><p>{TABLE1: SELECT[1]%>}</p><p>For inquiries, please call Compensation &amp; Benefits Section at local 8044, 8114, or 8199.</p><p>&nbsp;</p><p>Thank you.</p>', NULL)
DELETE FROM [dbo].[EmailLU] WHERE ID = 74
INSERT INTO [dbo].[EmailLU] ([ID], [Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) VALUES (74, N'Change: Submitted Revision', N'mail.smtp2go.com', 2525, N'admin@gurango.net', N'G3d8Wzb/qtoLTxAoJmme+A==', N'ESS Administrator', N'admin@gurango.net', N'SmartHR: Your Change Application', N'&nbsp;Dear <%PARAM[4]%>,<p>&nbsp;</p><p>This is to inform you that <%PARAM[5]%> has re-submitted his/her changes in PERSONNEL INFORMATION&nbsp;on <%PARAM[0]%>. </p><p>{TABLE1: SELECT[1]%>}</p><p>For inquiries, please call Compensation &amp; Benefits Section at local 8044, 8114, or 8199.</p><p>&nbsp;</p><p>Thank you.</p>', NULL)
SET IDENTITY_INSERT [dbo].[EmailLU] OFF
INSERT INTO [BloodTypeLU] VALUES ('A')
INSERT INTO [BloodTypeLU] VALUES ('B')
INSERT INTO [BloodTypeLU] VALUES ('AB')
INSERT INTO [BloodTypeLU] VALUES ('O')
INSERT INTO [RelativesLU] SELECT 'Father'
INSERT INTO [RelativesLU] SELECT 'Mother'
INSERT INTO [RelativesLU] SELECT 'Brother'
INSERT INTO [RelativesLU] SELECT 'Sister'
INSERT INTO [RelativesLU] SELECT 'GrandMother'
INSERT INTO [RelativesLU] SELECT 'GrandFather'
INSERT INTO [RelativesLU] SELECT 'Son'
INSERT INTO [RelativesLU] SELECT 'Daughter'
INSERT INTO [RelativesLU] SELECT 'Uncle'
INSERT INTO [RelativesLU] SELECT 'Aunt'
INSERT INTO [RelativesLU] SELECT 'Guardian'
INSERT INTO TableLU (Query) VALUES ('--SELECT ''Added By '' + ISNULL(LTRIM(RTRIM(B.Surname)),'''') + '', '' + ISNULL(LTRIM(RTRIM(B.FirstName)),'''') + '' '' + ISNULL(LTRIM(RTRIM(B.MiddleName)),'''') + '' : '' + CONVERT(NVARCHAR(36),A.Remarks) AS [Remarks] FROM [ess.WFRemarks] AS A LEFT JOIN [Personnel] AS B ON A.CompanyNum = B.CompanyNum AND A.EmployeeNum = B.EmployeeNum WHERE (A.[PathID] = <%PathID%>) ORDER BY A.CaptureDate ASC')
UPDATE [TableLU] SET Query = '--SELECT [Label] AS [Item], [ValueF] AS [From], [ValueT] AS [To] FROM [ess.Change] AS [c] LEFT OUTER JOIN [ess.Policy] AS [p] ON [c].[PolicyID] = [p].[ID] WHERE ([PathID] = <%PathID%> AND [Level] > 0) ORDER BY [PolicyID]' WHERE ID = 1

-------------------------

UPDATE [ess.Policy] SET [AssemblyID] = 24 WHERE [Key] = 'DEPENDANTS'

INSERT INTO UserGroupTemplateRights
	SELECT 'SuperAdmin', [DataElement], [fView], [fAdd], [fEdit], [fDelete], [fPrint], [ExcludeUGFlag], [Category]
		FROM [dbo].[UserGroupTemplateRights] WHERE Code = 'Admin'

INSERT INTO ReportsTo SELECT CompanyNum, EmployeeNum, '101230', '011656', 'HR Manager', NULL FROM ReportsTo WHERE ReportsToType = 'Manager'

UPDATE [ess.Policy] SET Visible = 1, Editable = 1, Required = 0, Approval = 1, ApprovalLevel = 2
	EXEC [ess.Cascade]

-------------------------


-------------------------


-- ======================================= --
--  CREATED BY: RANDOLPH BENJO T. NAANEP   --
--      GURANGO SOFTWARE CORPORATION       --
-- ======================================= --
GO
ALTER VIEW [dbo].[vwPersonnelInformation]
AS
	SELECT
		A.[CompanyNum]
	   ,A.[EmployeeNum]
	   ,A.[PreferredName]
	   ,A.[Title]
	   ,A.[Initials]
	   ,A.[Surname]
	   ,A.[FirstName]
	   ,A.[MiddleName]
	   ,A.[MaidenName]
	   ,A.[IDNum]
	   ,A.[Sex]
	   ,A.[Nationality]
	   ,A.[BirthDate]
	   ,[dbo].[fnCalculateAge](BirthDate) AS [Age]
	   ,A.[ZodiacSign]
	   ,A.[ZodiacSignActual]
	   ,A.[Language]
	   ,A.[Religion]
	   ,A.[EthnicGroup]
	   ,A.[MaritialStatus] AS [MaritalStatus]
	   ,A.[Disability]
	   ,A.[DisabilityNotes]
	   ,A.[ShuttleRoute]
	   ,A.[Address1]
	   ,A.[Address2]
	   ,A.[Address3]
	   ,A.[Address4]
	   ,A.[POBox]
	   ,A.[POArea]
	   ,A.[POCode]
	   ,A.[OfficeNo]
	   ,A.[CellTel]
	   ,A.[ExtensionNo]
	   ,A.[HomeTel]
	   ,A.[EMailAddress]
	   ,A.[AddrUnit]
	   ,A.[AddrComplex]
	   ,A.[AddrStreetNo]
	   ,A.[AddrStreetName]
	   ,A.[AddrSuburb]
	   ,A.[AddrCity]
	   ,A.[AddrZip]
	   ,A.[Latitude]
	   ,A.[Longitude]
	   ,A.[EMailAddress1]
	   ,A.[FaxNo]
	   ,A.[SpouseName]
	   ,A.[SpouseMiddleName]
	   ,B.[SpouseSurname]
	   ,B.[SpouseDOB]
	   ,[dbo].[fnCalculateAge](B.SpouseDOB) AS [SpouseAge]
	   ,A.[SpouseTel]
	   ,A.[SpouseEmployer]
	   ,A.[SpouseEmployerAdd]
	   ,A.[SpouseOccu]
	   ,A.[SpouseNationality]
	   ,A.[NOK_Surname]
	   ,A.[NOK_FirstName]
	   ,A.[NOK_MiddleName]
	   ,A.[NOK_DateOfBirth]
	   ,[dbo].[fnCalculateAge](A.NOK_DateOfBirth) AS [NOK_Age]
	   ,A.[NOK_Gender]
	   ,A.[NOK_Relationship]
	   ,A.[NOK_ERAddress]
	   ,A.[NOK_ContactNo]
	   ,A.[NOK_Occupation]
	   ,A.[NOK_Employer]
	   ,A.[BIRMembershipNo]
	   ,A.[SSSMembershipNo]
	   ,A.[PAGIBIGMembershipNo]
	   ,A.[PHILMemNo]
	   ,B.[TownOfBirth]
	   ,B.[CountryOfBirth]
	   ,C.[RecInterestHob]
	   ,A.[AddrRegion]
	   ,A.[Region]
	FROM [Personnel]					AS A
		INNER JOIN [Personnel1]			AS B ON A.CompanyNum = B.CompanyNum AND A.EmployeeNum = B.EmployeeNum
		INNER JOIN [RecPositionApplied]	AS C ON A.CompanyNum = C.CompanyNum AND A.EmployeeNum = C.EmployeeNum

GO

-----------------------------------

CREATE TABLE [ess.PolicyMapping]
(	PolicyID	BIGINT
   ,ModuleName	VARCHAR(100)
   ,TabName		VARCHAR(100)
   ,ItemName	VARCHAR(100)
   ,TableName	VARCHAR(100)
   ,FieldName	VARCHAR(100)
)

----------------------------------

INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 21, 18, N'Attributes', N'dgView_004', N'Attributes', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 6, 13, N'ShuttleRoute', N'cmbShuttlePreference', N'ShuttleRoute', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'[CustomFormFieldValues]', N'[FieldValue]', N'[FieldValue]', N'[CompanyNum] = ''<%CompanyNum%>'' and [EmployeeNum] = ''<%EmployeeNum%>'' and [FieldName] = ''ShuttleRoute''', NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'TownOfBirth', N'txtPlaceOfBirth', N'TownOfBirth', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'CountryOfBirth', N'txtCountryOfBirth', N'CountryOfBirth', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'RecInterestHob', N'txtInterestsHobbies', N'RecInterestHob', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 6, 13, N'AddrRegion', N'cmbPresentRegion', N'AddrRegion', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'[LocationFilter]', N'[Regi]', N'[Regi]', N'', NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 6, 13, N'Region', N'cmbPermanentRegion', N'Region', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'[LocationFilter]', N'[Regi]', N'[Regi]', N'', NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (9, 5, 3, 21, 18, N'OnTheJobTraining', N'dgView_001', N'OnTheJobTraining', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (9, 5, 3, 21, 18, N'EmploymentHistory', N'dgView_007', N'EmploymentHistory', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (9, 5, 3, 21, 18, N'EducationalBackground', N'dgView_002', N'EducationalBackground', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)

ALTER TABLE [PersonnelAttribute] ALTER COLUMN [Category] VARCHAR(10) NULL

UPDATE [ess.Policy] SET Visible = 1, Editable = 1, Required = 0
EXEC [ess.Cascade]

-----------------------------------

DELETE FROM [ess.PolicyMapping]

INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Age'					 ,'ePersonal','Age'					FROM [ess.Policy] WHERE [Key] = 'Age'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Animal Sign'			 ,'ePersonal','ZodiacSignActual'	FROM [ess.Policy] WHERE [Key] = 'ZodiacSignActual'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Date of Birth'		 ,'ePersonal','BirthDate'			FROM [ess.Policy] WHERE [Key] = 'BirthDate'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Disability'			 ,'ePersonal','Disability'			FROM [ess.Policy] WHERE [Key] = 'Disability'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Disability Notes'	 ,'ePersonal','DisabilityNotes'		FROM [ess.Policy] WHERE [Key] = 'DisabilityNotes'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Employee Code'		 ,'ePersonal','EmployeeNum'			FROM [ess.Policy] WHERE [Key] = 'EmployeeNum'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Ethnic Group'		 ,'ePersonal','EthnicGroup'			FROM [ess.Policy] WHERE [Key] = 'EthnicGroup'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','First Name'			 ,'ePersonal','FirstName'			FROM [ess.Policy] WHERE [Key] = 'FirstName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Gender'				 ,'ePersonal','Sex'					FROM [ess.Policy] WHERE [Key] = 'Sex'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','ID No.'				 ,'ePersonal','IDNum'				FROM [ess.Policy] WHERE [Key] = 'IDNum'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Language'			 ,'ePersonal','Language'			FROM [ess.Policy] WHERE [Key] = 'Language'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Marital Status'		 ,'ePersonal','MaritalStatus'		FROM [ess.Policy] WHERE [Key] = 'MaritalStatus'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Middle Name'			 ,'ePersonal','MiddleName'			FROM [ess.Policy] WHERE [Key] = 'MiddleName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Mother''s Maiden Name','ePersonal','MaidenName'			FROM [ess.Policy] WHERE [Key] = 'MaidenName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Nationality'			 ,'ePersonal','Nationality'			FROM [ess.Policy] WHERE [Key] = 'Nationality'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Nickname'			 ,'ePersonal','PreferredName'		FROM [ess.Policy] WHERE [Key] = 'PreferredName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Other Languages'		 ,'ePersonal','OtherLanguage'		FROM [ess.Policy] WHERE [Key] = 'OtherLanguage'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Pag-Ibig No.'		 ,'ePersonal','PAGIBIGMembershipNo'	FROM [ess.Policy] WHERE [Key] = 'PAGIBIGMembershipNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Phil-Health No.'		 ,'ePersonal','PHILMemNo'			FROM [ess.Policy] WHERE [Key] = 'PHILMemNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Religion'			 ,'ePersonal','Religion'			FROM [ess.Policy] WHERE [Key] = 'Religion'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','SSS Membership No.'	 ,'ePersonal','SSSMembershipNo'		FROM [ess.Policy] WHERE [Key] = 'SSSMembershipNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Suffix'				 ,'ePersonal','Initials'			FROM [ess.Policy] WHERE [Key] = 'Initials'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Surname'				 ,'ePersonal','Surname'				FROM [ess.Policy] WHERE [Key] = 'Surname'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Tin No.'				 ,'ePersonal','BIRMembershipNo'		FROM [ess.Policy] WHERE [Key] = 'BIRMembershipNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Title'				 ,'ePersonal','Title'				FROM [ess.Policy] WHERE [Key] = 'Title'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Zodiac Sign'			 ,'ePersonal','ZodiacSign'			FROM [ess.Policy] WHERE [Key] = 'ZodiacSign'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Preferred Shutte Area','ePersonal','ShuttleRoute'		FROM [ess.Policy] WHERE [Key] = 'ShuttleRoute'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Attributes'			 ,'PersonnelAttribute'		,'AttributeName'		 FROM [ess.Policy] WHERE [Key] = 'Attributes'

INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Complex Unit No','ePersonal','AddrUnit' FROM [ess.Policy] WHERE [Key] = 'AddrUnit'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Complex Name','ePersonal','AddrComplex' FROM [ess.Policy] WHERE [Key] = 'AddrComplex'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Street No','ePersonal','AddrStreetNo' FROM [ess.Policy] WHERE [Key] = 'AddrStreetNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Street Name','ePersonal','AddrStreetName' FROM [ess.Policy] WHERE [Key] = 'AddrStreetName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Suburb','ePersonal','AddrSuburb' FROM [ess.Policy] WHERE [Key] = 'AddrSuburb'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','City','ePersonal','AddrCity' FROM [ess.Policy] WHERE [Key] = 'AddrCity'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Zip Code','ePersonal','AddrZip' FROM [ess.Policy] WHERE [Key] = 'AddrZip'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Facsimile No','ePersonal','FaxNo' FROM [ess.Policy] WHERE [Key] = 'FaxNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Email Address (Alternative)','ePersonal','EmailAddress1' FROM [ess.Policy] WHERE [Key] = 'EmailAddress1'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Latitude','ePersonal','Latitude' FROM [ess.Policy] WHERE [Key] = 'Latitude'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Longitude','ePersonal','Longitude' FROM [ess.Policy] WHERE [Key] = 'Longitude'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Street','ePersonal','Address1' FROM [ess.Policy] WHERE [Key] = 'Address1'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Suburb','ePersonal','Address2' FROM [ess.Policy] WHERE [Key] = 'Address2'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','City','ePersonal','Address3' FROM [ess.Policy] WHERE [Key] = 'Address3'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Zip Code','ePersonal','Address4' FROM [ess.Policy] WHERE [Key] = 'Address4'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','P.O. Box','ePersonal','POBox' FROM [ess.Policy] WHERE [Key] = 'POBox'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Area','ePersonal','POArea' FROM [ess.Policy] WHERE [Key] = 'POArea'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Zip Code','ePersonal','POCode' FROM [ess.Policy] WHERE [Key] = 'POCode'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Work No','ePersonal','OfficeNo' FROM [ess.Policy] WHERE [Key] = 'OfficeNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Work Ext No','ePersonal','ExtensionNo' FROM [ess.Policy] WHERE [Key] = 'ExtensionNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Mobile No','ePersonal','CellTel' FROM [ess.Policy] WHERE [Key] = 'CellTel'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Home No','ePersonal','HomeTel' FROM [ess.Policy] WHERE [Key] = 'HomeTel'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Email Address','ePersonal','EmailAddress' FROM [ess.Policy] WHERE [Key] = 'EmailAddress'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Contact No.','ePersonal','SpouseTel' FROM [ess.Policy] WHERE [Key] = 'SpouseTel'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Place of Birth','eOrganizational','TownOfBirth' FROM [ess.Policy] WHERE [Key] = 'TownOfBirth'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Conutry of Birth','eOrganizational','CountryOfBirth' FROM [ess.Policy] WHERE [Key] = 'CountryOfBirth'

INSERT INTO [ess.PolicyMapping] SELECT [ID],'Curriculum Vitae','Employment History','On-The-Job Training','','' FROM [ess.Policy] WHERE [Key] = 'OnTheJobTraining'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Curriculum Vitae','Employment History','Employment History','','' FROM [ess.Policy] WHERE [Key] = 'EmploymentHistory'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Curriculum Vitae','Educational Background','Educational Background','','' FROM [ess.Policy] WHERE [Key] = 'EducationalBackground'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Curriculum Vitae','Licensures/Certifications','Licensures/Certifications','','' FROM [ess.Policy] WHERE [Key] = 'Certifications'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Curriculum Vitae','Educational Background','Seminars and Trainings Attended','','' FROM [ess.Policy] WHERE [Key] = 'Seminars'

INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Age'			 ,'ePersonal'		,'SpouseAge'		 FROM [ess.Policy] WHERE [Key] = 'SpouseAge'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Contact No.'	 ,'ePersonal'		,'SpouseTel'		 FROM [ess.Policy] WHERE [Key] = 'SpouseTel'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Dependants'		 ,'ePersonal'		,'Dependants'		 FROM [ess.Policy] WHERE [Key] = 'Dependants'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Employer'		 ,'ePersonal'		,'SpouseEmployer'	 FROM [ess.Policy] WHERE [Key] = 'SpouseEmployer'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Employer Address','ePersonal'		,'SpouseEmployerAdd' FROM [ess.Policy] WHERE [Key] = 'SpouseEmployerAdd'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','First Name'		 ,'ePersonal'		,'SpouseName'		 FROM [ess.Policy] WHERE [Key] = 'SpouseName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Last Name'		 ,'eOrganizational'	,'SpouseSurname'	 FROM [ess.Policy] WHERE [Key] = 'SpouseSurname'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Middle Name'	 ,'ePersonal'		,'SpouseMiddleName'	 FROM [ess.Policy] WHERE [Key] = 'SpouseMiddleName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Next of Kin'	 ,'ePersonal'		,'NextOfKin'		 FROM [ess.Policy] WHERE [Key] = 'NextOfKin'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Occupation'		 ,'ePersonal'		,'SpouseOccu'		 FROM [ess.Policy] WHERE [Key] = 'SpouseOccu'

INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Age'				,'ePersonal','NOK_Age'			FROM [ess.Policy] WHERE [Key] = 'NOK_Age'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Employer Address'	,'ePersonal','NOK_ERAddress'	FROM [ess.Policy] WHERE [Key] = 'NOK_ERAddress'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','First Name'		,'ePersonal','NOK_FirstName'	FROM [ess.Policy] WHERE [Key] = 'NOK_FirstName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Last Name'		,'ePersonal','NOK_Surname'		FROM [ess.Policy] WHERE [Key] = 'NOK_Surname'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Middle Name'		,'ePersonal','NOK_MiddleName'	FROM [ess.Policy] WHERE [Key] = 'NOK_MiddleName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Contact Number'	,'ePersonal','NOK_ContactNo'	FROM [ess.Policy] WHERE [Key] = 'NOK_ContactNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Occupation'		,'ePersonal','NOK_Occupation'	FROM [ess.Policy] WHERE [Key] = 'NOK_Occupation'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Employer'			,'ePersonal','NOK_Employer'		FROM [ess.Policy] WHERE [Key] = 'NOK_Employer'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Gender'			,'ePersonal','NOK_Gender'		FROM [ess.Policy] WHERE [Key] = 'NOK_Gender'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Relationship'		,'ePersonal','NOK_Relationship'	FROM [ess.Policy] WHERE [Key] = 'NOK_Relationship'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Birthday'			,'ePersonal','NOK_DateOfBirth'	FROM [ess.Policy] WHERE [Key] = 'NOK_DateOfBirth'

---Organisational
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Job Title'						,'eOrganizational','JobTitle'			FROM [ess.Policy] WHERE [Key] = 'JobTitle'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Job Grade'						,'eOrganizational','JobGrade'			FROM [ess.Policy] WHERE [Key] = 'JobGrade'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Cost Centre'						,'eOrganizational','CostCentre'			FROM [ess.Policy] WHERE [Key] = 'CostCentre'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Allocation'						,'eOrganizational','CostCentreAlloc'	FROM [ess.Policy] WHERE [Key] = 'CostCentreAlloc'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Date Hired'						,'eOrganizational','DateJoinedGroup'	FROM [ess.Policy] WHERE [Key] = 'DateJoinedGroup'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Appointment Date'				,'eOrganizational','Appointdate'		FROM [ess.Policy] WHERE [Key] = 'Appointdate'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Years of Service (Group)'		,'eOrganizational','YearsServiceG'		FROM [ess.Policy] WHERE [Key] = 'YearsServiceG'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Years of Service (Appointment)'	,'eOrganizational','YearsServiceA'		FROM [ess.Policy] WHERE [Key] = 'YearsServiceA'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Category'						,'eOrganizational','Category'			FROM [ess.Policy] WHERE [Key] = 'Category'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Pay Level'						,'eOrganizational','PayLevel'			FROM [ess.Policy] WHERE [Key] = 'PayLevel'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Shifting'						,'eOrganizational','Shifting'			FROM [ess.Policy] WHERE [Key] = 'Shifting'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Work Assignment'					,'eOrganizational','WorkAssignment'		FROM [ess.Policy] WHERE [Key] = 'WorkAssignment'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Union Affiliation'				,'eOrganizational','UnionAffiliation'	FROM [ess.Policy] WHERE [Key] = 'UnionAffiliation'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Occupational Category'			,'eOrganizational','Skill_Level'		FROM [ess.Policy] WHERE [Key] = 'Skill_Level'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Appointment Type'				,'eOrganizational','Appointype'			FROM [ess.Policy] WHERE [Key] = 'Appointype'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment',''								,'eOrganizational','DeptName'			FROM [ess.Policy] WHERE [Key] = 'DeptName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment',''								,'eOrganizational','Position'			FROM [ess.Policy] WHERE [Key] = 'Position'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment',''								,'eOrganizational','Location'			FROM [ess.Policy] WHERE [Key] = 'Location'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment',''								,'eOrganizational','ReportsTo'			FROM [ess.Policy] WHERE [Key] = 'ReportsTo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Division'						,'Company'		  ,'Division'			FROM [ess.Policy] WHERE [Key] = 'Division'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Department'						,'Company'		  ,'SubDivision'		FROM [ess.Policy] WHERE [Key] = 'SubDivision'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Section'							,'Company'		  ,'SubSubDivision'		FROM [ess.Policy] WHERE [Key] = 'SubSubDivision'

INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Shirt Size'		,'eOrganizational','ShirtSize'		FROM [ess.Policy] WHERE [Key] = 'ShirtSize'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Blazer'			,'eOrganizational','Blazer'			FROM [ess.Policy] WHERE [Key] = 'Blazer'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Skirt'			,'eOrganizational','Skirt'			FROM [ess.Policy] WHERE [Key] = 'Skirt'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Blouse'			,'eOrganizational','Blouse'			FROM [ess.Policy] WHERE [Key] = 'Blouse'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Slacks'			,'eOrganizational','Slacks'			FROM [ess.Policy] WHERE [Key] = 'Slacks'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Shirtjack'		,'eOrganizational','Shirtjack'		FROM [ess.Policy] WHERE [Key] = 'Shirtjack'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Shirtjack Pants'	,'eOrganizational','ShirtjackPants'	FROM [ess.Policy] WHERE [Key] = 'ShirtjackPants'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Polo/Barong'		,'eOrganizational','PoloBarong'		FROM [ess.Policy] WHERE [Key] = 'PoloBarong'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Repellant Pants'	,'eOrganizational','RepellantPants'	FROM [ess.Policy] WHERE [Key] = 'RepellantPants'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Polo Shirt'		,'eOrganizational','PoloShirt'		FROM [ess.Policy] WHERE [Key] = 'PoloShirt'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Maong Pants'		,'eOrganizational','MaongPants'		FROM [ess.Policy] WHERE [Key] = 'MaongPants'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','T-Shirt'			,'eOrganizational','TShirt'			FROM [ess.Policy] WHERE [Key] = 'TShirt'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Overalls'		,'eOrganizational','Overalls'		FROM [ess.Policy] WHERE [Key] = 'Overalls'

------------------------------

ALTER TABLE [dbo].[ess.Policy] DROP CONSTRAINT [PK_ess.Policy]
GO

ALTER TABLE [dbo].[ess.Policy] ALTER COLUMN [ID] BIGINT NOT NULL
GO

ALTER TABLE [dbo].[ess.Policy] ADD CONSTRAINT [PK_ess.Policy] PRIMARY KEY CLUSTERED ([ID] ASC)
GO

-----------------------------

INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 21, 18, N'Attributes', N'dgView_004', N'Attributes', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 6, 13, N'ShuttleRoute', N'cmbShuttlePreference', N'ShuttleRoute', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'[CustomFormFieldValues]', N'[FieldValue]', N'[FieldValue]', N'[CompanyNum] = ''<%CompanyNum%>'' and [EmployeeNum] = ''<%EmployeeNum%>'' and [FieldName] = ''ShuttleRoute''', NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'TownOfBirth', N'txtPlaceOfBirth', N'TownOfBirth', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'CountryOfBirth', N'txtCountryOfBirth', N'CountryOfBirth', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'RecInterestHob', N'txtInterestsHobbies', N'RecInterestHob', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 6, 13, N'AddrRegion', N'cmbPresentRegion', N'AddrRegion', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'[LocationFilter]', N'[Regi]', N'[Regi]', N'', NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (9, 5, 3, 21, 18, N'OnTheJobTraining', N'dgView_001', N'OnTheJobTraining', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (9, 5, 3, 21, 18, N'EmploymentHistory', N'dgView_007', N'EmploymentHistory', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (9, 5, 3, 21, 18, N'EducationalBackground', N'dgView_002', N'EducationalBackground', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 21, 18, N'Relatives', N'dgView_Relatives', N'Relatives', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 6, 13, N'TaxCode', N'cmbTaxCode', N'TaxCode', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'[TaxCodeLU]', N'[TaxCode]', N'[TaxCode]', N'', NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (9, 5, 3, 21, 18, N'OrganizationalAffiliations', N'dgView_003', N'OrganizationalAffiliations', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'AddrState', N'txtPresentProvince', N'AddrState', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'AddrBaranggay', N'txtPresentBaranggay', N'AddrBaranggay', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'Baranggay', N'txtPermanentBaranggay', N'Baranggay', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'AddrTelNo', N'txtPresentTelNo', N'AddrTelNo', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'Address5', N'txtAddress5', N'Address5', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'Address6', N'txtAddress6', N'Address6', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'PermanentComplexUnitNo', N'txtPermanentComplexUnitNo', N'PermanentComplexUnitNo', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'PermanentComplexName', N'txtPermanentComplexName', N'PermanentComplexName', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'PermanentHouseNumber', N'txtPermanentHouseNumber', N'PermanentHouseNumber', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'PermanentStreetName', N'txtPermanentStreetName', N'PermanentStreetName', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'PermanentSubdivision', N'txtPermanentSubdivision', N'PermanentSubdivision', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 6, 13, N'PermanentRegion', N'cmbPermanentRegion', N'PermanentRegion', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'[LocationFilter]', N'[Regi]', N'[Regi]', N'', NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'State_or_Province', N'txtPermanentProvince', N'State_or_Province', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'PermanentCity', N'txtPermanentCity', N'PermanentCity', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'PermanentBaranggay', N'txtPermanentBaranggay', N'PermanentBaranggay', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'PermanentPostalCode', N'txtPermanentPostalCode', N'PermanentPostalCode', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'PermanentTelNo', N'txtPermanentTelNo', N'PermanentTelNo', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (7, 5, 3, 19, 13, N'Division', N'txtDivision', N'Division', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (7, 5, 3, 19, 13, N'Department', N'txtDepartment', N'Department', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (7, 5, 3, 19, 13, N'Section', N'txtSection', N'Section', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (7, 5, 3, 6, 13, N'Fixed', N'cmbFixed', N'Fixed', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'[FixedLU]', N'[Fixed]', N'[Fixed]', N'', NULL, 1, 1, 2)

go
WITH CTE AS
(
	SELECT [Key], [Name], [Label], RN = ROW_NUMBER() OVER (PARTITION BY [Key], [Name], [Label] ORDER BY [Key], [Name], [Label]) FROM [ess.Policy]
)
DELETE FROM CTE WHERE RN > 1

UPDATE [ess.Policy] SET Visible = 1, Editable = 0, Required = 0, Approval = 0, ApprovalLevel = 2
UPDATE [ess.Policy] SET AssemblyID = '24' WHERE GroupID = 6 AND AssemblyID = 21
EXEC [ess.Cascade]

ALTER TABLE [dbo].[Personnel]
    ADD [AddrBaranggay]			 NVARCHAR(100) DEFAULT ('') NULL,
        [Baranggay]				 NVARCHAR(100) DEFAULT ('') NULL,
        [AddrTelNo]				 NVARCHAR(100) DEFAULT ('') NULL,
        [Address5]				 NVARCHAR(100) DEFAULT ('') NULL,
        [Address6]				 NVARCHAR(100) DEFAULT ('') NULL,
        [PermanentComplexUnitNo] NVARCHAR(100) DEFAULT ('') NULL,
        [PermanentComplexName]	 NVARCHAR(100) DEFAULT ('') NULL,        
        [PermanentBaranggay]	 NVARCHAR(100) DEFAULT ('') NULL,
        [PermanentStreetName]	 NVARCHAR(100) DEFAULT ('') NULL,
        [PermanentSubdivision]	 NVARCHAR(100) DEFAULT ('') NULL,
        [PermanentCity]			 NVARCHAR(100) DEFAULT ('') NULL,
        [PermanentPostalCode]	 NVARCHAR(100) DEFAULT ('') NULL,
        [PermanentTelNo]		 NVARCHAR(100) DEFAULT ('') NULL,
        [PermanentHouseNumber]	 NVARCHAR(100) DEFAULT ('') NULL;

ALTER TABLE [dbo].[Personnel1]
	ADD [Fixed] NVARCHAR(100) DEFAULT ('') NULL;
	
ALTER TABLE [PersonnelAttribute] ALTER COLUMN [Category] VARCHAR(10) NULL

-----------------------------

-- ======================================= --
--  CREATED BY: RANDOLPH BENJO T. NAANEP   --
--      GURANGO SOFTWARE CORPORATION       --
-- ======================================= --
go
ALTER VIEW [dbo].[vwPersonnelInformation]
AS
	SELECT
		A.[CompanyNum]
	   ,A.[EmployeeNum]
	   ,A.[PreferredName]
	   ,A.[Title]
	   ,A.[Initials]
	   ,A.[Surname]
	   ,A.[FirstName]
	   ,A.[MiddleName]
	   ,A.[MaidenName]
	   ,A.[IDNum]
	   ,A.[Sex]
	   ,A.[Nationality]
	   ,A.[BirthDate]
	   ,[dbo].[fnCalculateAge](BirthDate) AS [Age]
	   ,A.[ZodiacSign]
	   ,A.[ZodiacSignActual]
	   ,A.[Language]
	   ,A.[Religion]
	   ,A.[EthnicGroup]
	   ,A.[MaritialStatus] AS [MaritalStatus]
	   ,A.[Disability]
	   ,A.[DisabilityNotes]
	   ,A.[ShuttleRoute]
	   ,A.[Address1]
	   ,A.[Address2]
	   ,A.[Address3]
	   ,A.[Address4]
	   ,A.[Address5]
	   ,A.[Address6]
	   ,A.[POBox]
	   ,A.[POArea]
	   ,A.[POCode]
	   ,A.[OfficeNo]
	   ,A.[CellTel]
	   ,A.[ExtensionNo]
	   ,A.[HomeTel]
	   ,A.[EMailAddress]
	   ,A.[AddrUnit]
	   ,A.[AddrComplex]
	   ,A.[AddrStreetNo]
	   ,A.[AddrStreetName]
	   ,A.[AddrSuburb]
	   ,A.[AddrCity]
	   ,A.[AddrZip]
	   ,A.[Latitude]
	   ,A.[Longitude]
	   ,A.[EMailAddress1]
	   ,A.[FaxNo]
	   ,A.[SpouseName]
	   ,A.[SpouseMiddleName]
	   ,B.[SpouseSurname]
	   ,B.[SpouseDOB]
	   ,[dbo].[fnCalculateAge](B.SpouseDOB) AS [SpouseAge]
	   ,A.[SpouseTel]
	   ,A.[SpouseEmployer]
	   ,A.[SpouseEmployerAdd]
	   ,A.[SpouseOccu]
	   ,A.[SpouseNationality]
	   ,A.[NOK_Surname]
	   ,A.[NOK_FirstName]
	   ,A.[NOK_MiddleName]
	   ,A.[NOK_DateOfBirth]
	   ,[dbo].[fnCalculateAge](A.NOK_DateOfBirth) AS [NOK_Age]
	   ,A.[NOK_Gender]
	   ,A.[NOK_Relationship]
	   ,A.[NOK_ERAddress]
	   ,A.[NOK_ContactNo]
	   ,A.[NOK_Occupation]
	   ,A.[NOK_Employer]
	   ,A.[BIRMembershipNo]
	   ,A.[SSSMembershipNo]
	   ,A.[PAGIBIGMembershipNo]
	   ,A.[PHILMemNo]
	   ,B.[TownOfBirth]
	   ,B.[CountryOfBirth]
	   ,C.[RecInterestHob]
	   ,A.[AddrRegion]
	   ,A.[TaxCode]
	   ,A.[AddrBaranggay]
	   ,A.[Baranggay]
	   ,A.[AddrState]
	   ,A.[AddrTelNo]
	   ,A.[PermanentComplexUnitNo]
	   ,A.[PermanentComplexName]
	   ,A.[PermanentHouseNumber]
	   ,A.[PermanentStreetName]
	   ,A.[PermanentSubdivision]
	   ,A.[Region]
	   ,A.[State_or_Province]
	   ,A.[PermanentCity]
	   ,A.[PermanentBaranggay]
	   ,A.[PermanentPostalCode]
	   ,A.[PermanentTelNo]
	FROM [Personnel]					AS A
		INNER JOIN [Personnel1]			AS B ON A.CompanyNum = B.CompanyNum AND A.EmployeeNum = B.EmployeeNum
		INNER JOIN [RecPositionApplied]	AS C ON A.CompanyNum = C.CompanyNum AND A.EmployeeNum = C.EmployeeNum

GO

------------------------

-- ======================================= --
--  CREATED BY: RANDOLPH BENJO T. NAANEP   --
--      GURANGO SOFTWARE CORPORATION       --
-- ======================================= --

CREATE VIEW [dbo].[vwOrganizationalInformation]
AS
	SELECT
		A.[CompanyNum]
	   ,A.[EmployeeNum]
	   ,D.[Division]			AS Division
	   ,D.[SubDivision]			AS Department
	   ,D.[SubSubDivision]		AS Section
	   ,A.[Uniform_Blazer]		AS Blazer
	   ,A.[Uniform_Skirt]		AS Skirt
	   ,A.[Uniform_Blouse]		AS Blouse
	   ,A.[Uniform_Slack]		AS Slacks
	   ,A.[Uniform_Shirtjack]	AS Shirtjack
	   ,A.[Uniform_SJPants]		AS ShirtjackPants
	   ,A.[Uniform_PoloBarong]	AS PoloBarong
	   ,A.[Uniform_RepPants]	AS RepellantPants
	   ,A.[Uniform_PoloShirt]	AS PoloShirt
	   ,A.[Uniform_MaongPants]	AS MaongPants
	   ,A.[Uniform_TShirt]		AS TShirt
	   ,A.[Uniform_Overalls]	AS Overalls
	   ,C.[AttributeValue]		AS ShirtSize
	   ,B.[IndividualJobTitle]	AS JobTitle
	   ,A.[JobTitle]			AS UnionAffiliation
	   ,A.[JobGrade]			AS JobGrade
	   ,A.[CostCentre]			AS CostCentre
	   ,B.[OFOCode]				AS Category
	   ,B.[OFOOccupation]		AS PayLevel
	   ,B.[ShiftType]			AS Shifting
	   ,B.[LocationCategory]	AS WorkAssignment
	   ,A.[DeptName]			AS DeptName
	   ,A.[Skill_Level]			AS Skill_Level
	   ,A.[Appointype]			AS Appointype
	   ,A.[DateJoinedGroup]		AS DateJoinedGroup
	   ,A.[Appointdate]			AS AppointDate
	   ,A.[TerminationDate]		AS TerminationDate
	   ,A.[Termination]			AS Termination
	   ,B.[Fixed]				AS Fixed
	FROM [Personnel]					AS A
		LEFT JOIN [Personnel1]			AS B ON A.CompanyNum = B.CompanyNum AND A.EmployeeNum = B.EmployeeNum
		LEFT JOIN [PersonnelAttribute]	AS C ON A.CompanyNum = C.CompanyNum AND A.EmployeeNum = C.EmployeeNum AND C.AttributeName = 'SHIRT SIZE'
		LEFT JOIN [Company]				AS D ON A.CompanyNum = D.CompanyNum

GO

------------------------


CREATE TABLE [TaxCodeLU]
(	TaxCode NVARCHAR(10)
)

INSERT INTO [TaxCodeLU] VALUES ('S')
INSERT INTO [TaxCodeLU] VALUES ('S1')
INSERT INTO [TaxCodeLU] VALUES ('S2')
INSERT INTO [TaxCodeLU] VALUES ('S3')
INSERT INTO [TaxCodeLU] VALUES ('S4')
INSERT INTO [TaxCodeLU] VALUES ('M')
INSERT INTO [TaxCodeLU] VALUES ('M1')
INSERT INTO [TaxCodeLU] VALUES ('M2')
INSERT INTO [TaxCodeLU] VALUES ('M3')
INSERT INTO [TaxCodeLU] VALUES ('M4')

CREATE TABLE [FixedLU]
(	Fixed NVARCHAR(100)
)

INSERT INTO [FixedLU] VALUES ('0700H-1600H')
INSERT INTO [FixedLU] VALUES ('0815H-1715H')


-------------------------

DELETE FROM [ess.PolicyMapping]

INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Age'					 ,NULL				  ,NULL					 FROM [ess.Policy] WHERE [Key] = 'Age'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Animal Sign'			 ,'Personnel'		  ,'ZodiacSignActual'	 FROM [ess.Policy] WHERE [Key] = 'ZodiacSignActual'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Date of Birth'		 ,'Personnel'		  ,'BirthDate'			 FROM [ess.Policy] WHERE [Key] = 'BirthDate'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Disability'			 ,'Personnel'		  ,'Disability'			 FROM [ess.Policy] WHERE [Key] = 'Disability'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Disability Notes'	 ,'Personnel'		  ,'DisabilityNotes'	 FROM [ess.Policy] WHERE [Key] = 'DisabilityNotes'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Employee Code'		 ,'Personnel'		  ,'EmployeeNum'		 FROM [ess.Policy] WHERE [Key] = 'EmployeeNum'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Ethnic Group'		 ,'Personnel'		  ,'EthnicGroup'		 FROM [ess.Policy] WHERE [Key] = 'EthnicGroup'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','First Name'			 ,'Personnel'		  ,'FirstName'			 FROM [ess.Policy] WHERE [Key] = 'FirstName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Gender'				 ,'Personnel'		  ,'Sex'				 FROM [ess.Policy] WHERE [Key] = 'Sex'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','ID No.'				 ,'Personnel'		  ,'IDNum'				 FROM [ess.Policy] WHERE [Key] = 'IDNum'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Language'			 ,'Personnel'		  ,'Language'			 FROM [ess.Policy] WHERE [Key] = 'Language'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Marital Status'		 ,'Personnel'		  ,'MaritialStatus'		 FROM [ess.Policy] WHERE [Key] = 'MaritalStatus'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Middle Name'			 ,'Personnel'		  ,'MiddleName'			 FROM [ess.Policy] WHERE [Key] = 'MiddleName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Mother''s Maiden Name','Personnel'		  ,'MaidenName'			 FROM [ess.Policy] WHERE [Key] = 'MaidenName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Nationality'			 ,'Personnel'		  ,'Nationality'		 FROM [ess.Policy] WHERE [Key] = 'Nationality'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Nickname'			 ,'Personnel'		  ,'PreferredName'		 FROM [ess.Policy] WHERE [Key] = 'PreferredName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Pag-Ibig No.'		 ,'Personnel'		  ,'PAGIBIGMembershipNo' FROM [ess.Policy] WHERE [Key] = 'PAGIBIGMembershipNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Phil-Health No.'		 ,'Personnel'		  ,'PHILMemNo'			 FROM [ess.Policy] WHERE [Key] = 'PHILMemNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Religion'			 ,'Personnel'		  ,'Religion'			 FROM [ess.Policy] WHERE [Key] = 'Religion'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','SSS Membership No.'	 ,'Personnel'		  ,'SSSMembershipNo'	 FROM [ess.Policy] WHERE [Key] = 'SSSMembershipNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Suffix'				 ,'Personnel'		  ,'Initials'			 FROM [ess.Policy] WHERE [Key] = 'Initials'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Surname'				 ,'Personnel'		  ,'Surname'			 FROM [ess.Policy] WHERE [Key] = 'Surname'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Tin No.'				 ,'Personnel'		  ,'BIRMembershipNo'	 FROM [ess.Policy] WHERE [Key] = 'BIRMembershipNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Title'				 ,'Personnel'		  ,'Title'				 FROM [ess.Policy] WHERE [Key] = 'Title'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Zodiac Sign'			 ,'Personnel'		  ,'ZodiacSign'			 FROM [ess.Policy] WHERE [Key] = 'ZodiacSign'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Preferred Shutte Area','Personnel'		  ,'ShuttleRoute'		 FROM [ess.Policy] WHERE [Key] = 'ShuttleRoute'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Tax Code'			 ,'Personnel'		  ,'TaxCode'			 FROM [ess.Policy] WHERE [Key] = 'TaxCode'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Attributes'			 ,'PersonnelAttribute','AttributeName'		 FROM [ess.Policy] WHERE [Key] = 'Attributes'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Other Languages'		 ,'OtherLanguage'	  ,'Language'			 FROM [ess.Policy] WHERE [Key] = 'OtherLanguage'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Interests/Hobbies'	 ,'Personnel'		  ,'RecInterestHob'		 FROM [ess.Policy] WHERE [Key] = 'RecInterestHob'

INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) Complex Unit No'	 ,'Personnel','AddrUnit'				FROM [ess.Policy] WHERE [Key] = 'AddrUnit'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) Complex Name'	 ,'Personnel','AddrComplex'				FROM [ess.Policy] WHERE [Key] = 'AddrComplex'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) House Number'	 ,'Personnel','AddrStreetNo'			FROM [ess.Policy] WHERE [Key] = 'AddrStreetNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) Street Name'		 ,'Personnel','AddrStreetName'			FROM [ess.Policy] WHERE [Key] = 'AddrStreetName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) Subdivision'		 ,'Personnel','AddrSuburb'				FROM [ess.Policy] WHERE [Key] = 'AddrSuburb'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) Region'			 ,'Personnel','AddrRegion'				FROM [ess.Policy] WHERE [Key] = 'AddrRegion'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) Province'		 ,'Personnel','AddrState'				FROM [ess.Policy] WHERE [Key] = 'AddrState'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) Municipality/City','Personnel','AddrCity'				FROM [ess.Policy] WHERE [Key] = 'AddrCity'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) Baranggay'		 ,'Personnel','AddrBaranggay'			FROM [ess.Policy] WHERE [Key] = 'AddrBaranggay'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) Postal Code'		 ,'Personnel','AddrZip'					FROM [ess.Policy] WHERE [Key] = 'AddrZip'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) Tel No.'			 ,'Personnel','AddrTelNo'				FROM [ess.Policy] WHERE [Key] = 'AddrTelNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Short) Street'			 ,'Personnel','Address1'				FROM [ess.Policy] WHERE [Key] = 'Address1'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Short) Suburb'			 ,'Personnel','Address2'				FROM [ess.Policy] WHERE [Key] = 'Address2'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Short) City'			 ,'Personnel','Address3'				FROM [ess.Policy] WHERE [Key] = 'Address3'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Short) State/Province'	 ,'Personnel','Address5'				FROM [ess.Policy] WHERE [Key] = 'Address5'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Short) Zip Code'		 ,'Personnel','Address4'				FROM [ess.Policy] WHERE [Key] = 'Address4'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Short) Tel No.'		 ,'Personnel','Address6'				FROM [ess.Policy] WHERE [Key] = 'Address6'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) Complex Unit No'		 ,'Personnel','PermanentComplexUnitNo'	FROM [ess.Policy] WHERE [Key] = 'PermanentComplexUnitNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) Complex Name'			 ,'Personnel','PermanentComplexName'	FROM [ess.Policy] WHERE [Key] = 'PermanentComplexName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) House Number'			 ,'Personnel','PermanentHouseNumber'	FROM [ess.Policy] WHERE [Key] = 'PermanentHouseNumber'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) Street Name'			 ,'Personnel','PermanentStreetName'		FROM [ess.Policy] WHERE [Key] = 'PermanentStreetName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) Subdivision'			 ,'Personnel','PermanentSubdivision'	FROM [ess.Policy] WHERE [Key] = 'PermanentSubdivision'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) Region'				 ,'Personnel','Region'					FROM [ess.Policy] WHERE [Key] = 'Region'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) Province'				 ,'Personnel','State_or_Province'		FROM [ess.Policy] WHERE [Key] = 'State_or_Province'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) Municipality/City'	 ,'Personnel','PermanentCity'			FROM [ess.Policy] WHERE [Key] = 'PermanentCity'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) Baranggay'			 ,'Personnel','PermanentBaranggay'		FROM [ess.Policy] WHERE [Key] = 'PermanentBaranggay'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) Postal Code'			 ,'Personnel','PermanentPostalCode'		FROM [ess.Policy] WHERE [Key] = 'PermanentPostalCode'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) Tel No.'				 ,'Personnel','PermanentTelNo'			FROM [ess.Policy] WHERE [Key] = 'PermanentTelNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Facsimile No','Personnel','FaxNo' FROM [ess.Policy] WHERE [Key] = 'FaxNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Email Address (Alternative)','Personnel','EmailAddress1' FROM [ess.Policy] WHERE [Key] = 'EmailAddress1'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Latitude','Personnel','Latitude' FROM [ess.Policy] WHERE [Key] = 'Latitude'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Longitude','Personnel','Longitude' FROM [ess.Policy] WHERE [Key] = 'Longitude'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','P.O. Box','Personnel','POBox' FROM [ess.Policy] WHERE [Key] = 'POBox'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Area','Personnel','POArea' FROM [ess.Policy] WHERE [Key] = 'POArea'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Zip Code','Personnel','POCode' FROM [ess.Policy] WHERE [Key] = 'POCode'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Work No','Personnel','OfficeNo' FROM [ess.Policy] WHERE [Key] = 'OfficeNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Work Ext No','Personnel','ExtensionNo' FROM [ess.Policy] WHERE [Key] = 'ExtensionNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Mobile No','Personnel','CellTel' FROM [ess.Policy] WHERE [Key] = 'CellTel'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Home No','Personnel','HomeTel' FROM [ess.Policy] WHERE [Key] = 'HomeTel'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Email Address','Personnel','EmailAddress' FROM [ess.Policy] WHERE [Key] = 'EmailAddress'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Contact No.','Personnel','SpouseTel' FROM [ess.Policy] WHERE [Key] = 'SpouseTel'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Place of Birth','Personnel1','TownOfBirth' FROM [ess.Policy] WHERE [Key] = 'TownOfBirth'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Conutry of Birth','Personnel1','CountryOfBirth' FROM [ess.Policy] WHERE [Key] = 'CountryOfBirth'

INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Relatives Working in TMP','Relatives Working in TMP','','' FROM [ess.Policy] WHERE [Key] = 'Relatives'

INSERT INTO [ess.PolicyMapping] SELECT [ID],'Curriculum Vitae','Employment History','On-The-Job Training','','' FROM [ess.Policy] WHERE [Key] = 'OnTheJobTraining'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Curriculum Vitae','Employment History','Employment History','','' FROM [ess.Policy] WHERE [Key] = 'EmploymentHistory'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Curriculum Vitae','Educational Background','Educational Background','','' FROM [ess.Policy] WHERE [Key] = 'EducationalBackground'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Curriculum Vitae','Educational Background','Seminars and Trainings Attended','','' FROM [ess.Policy] WHERE [Key] = 'Seminars'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Curriculum Vitae','Educational Background','Organizational Affiliations','','' FROM [ess.Policy] WHERE [Key] = 'OrganizationalAffiliations'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Curriculum Vitae','Licensures/Certifications','Licensures/Certifications','','' FROM [ess.Policy] WHERE [Key] = 'Certifications'

INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Age'			 ,'Personnel'		,'SpouseAge'		 FROM [ess.Policy] WHERE [Key] = 'SpouseAge'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Contact No.'	 ,'Personnel'		,'SpouseTel'		 FROM [ess.Policy] WHERE [Key] = 'SpouseTel'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Dependants'		 ,'Personnel'		,'Dependants'		 FROM [ess.Policy] WHERE [Key] = 'Dependants'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Employer'		 ,'Personnel'		,'SpouseEmployer'	 FROM [ess.Policy] WHERE [Key] = 'SpouseEmployer'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Employer Address','Personnel'		,'SpouseEmployerAdd' FROM [ess.Policy] WHERE [Key] = 'SpouseEmployerAdd'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','First Name'		 ,'Personnel'		,'SpouseName'		 FROM [ess.Policy] WHERE [Key] = 'SpouseName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Last Name'		 ,'Personnel1'	,'SpouseSurname'	 FROM [ess.Policy] WHERE [Key] = 'SpouseSurname'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Middle Name'	 ,'Personnel'		,'SpouseMiddleName'	 FROM [ess.Policy] WHERE [Key] = 'SpouseMiddleName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Next of Kin'	 ,'Personnel'		,'NextOfKin'		 FROM [ess.Policy] WHERE [Key] = 'NextOfKin'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Occupation'		 ,'Personnel'		,'SpouseOccu'		 FROM [ess.Policy] WHERE [Key] = 'SpouseOccu'

INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Age'				,'Personnel','NOK_Age'			FROM [ess.Policy] WHERE [Key] = 'NOK_Age'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Employer Address'	,'Personnel','NOK_ERAddress'	FROM [ess.Policy] WHERE [Key] = 'NOK_ERAddress'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','First Name'		,'Personnel','NOK_FirstName'	FROM [ess.Policy] WHERE [Key] = 'NOK_FirstName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Last Name'		,'Personnel','NOK_Surname'		FROM [ess.Policy] WHERE [Key] = 'NOK_Surname'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Middle Name'		,'Personnel','NOK_MiddleName'	FROM [ess.Policy] WHERE [Key] = 'NOK_MiddleName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Contact Number'	,'Personnel','NOK_ContactNo'	FROM [ess.Policy] WHERE [Key] = 'NOK_ContactNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Occupation'		,'Personnel','NOK_Occupation'	FROM [ess.Policy] WHERE [Key] = 'NOK_Occupation'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Employer'			,'Personnel','NOK_Employer'		FROM [ess.Policy] WHERE [Key] = 'NOK_Employer'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Gender'			,'Personnel','NOK_Gender'		FROM [ess.Policy] WHERE [Key] = 'NOK_Gender'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Relationship'		,'Personnel','NOK_Relationship'	FROM [ess.Policy] WHERE [Key] = 'NOK_Relationship'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Birthday'			,'Personnel','NOK_DateOfBirth'	FROM [ess.Policy] WHERE [Key] = 'NOK_DateOfBirth'

---Organisational
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Job Title'						,'Personnel1','JobTitle'			FROM [ess.Policy] WHERE [Key] = 'JobTitle'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Job Grade'						,'Personnel1','JobGrade'			FROM [ess.Policy] WHERE [Key] = 'JobGrade'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Cost Centre'						,'Personnel1','CostCentre'			FROM [ess.Policy] WHERE [Key] = 'CostCentre'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Allocation'						,'Personnel1','CostCentreAlloc'		FROM [ess.Policy] WHERE [Key] = 'CostCentreAlloc'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Date Hired'						,'Personnel1','DateJoinedGroup'		FROM [ess.Policy] WHERE [Key] = 'DateJoinedGroup'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Appointment Date'				,'Personnel1','Appointdate'			FROM [ess.Policy] WHERE [Key] = 'Appointdate'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Years of Service (Group)'		,'Personnel1','YearsServiceG'		FROM [ess.Policy] WHERE [Key] = 'YearsServiceG'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Years of Service (Appointment)'	,'Personnel1','YearsServiceA'		FROM [ess.Policy] WHERE [Key] = 'YearsServiceA'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Category'						,'Personnel1','Category'			FROM [ess.Policy] WHERE [Key] = 'Category'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Pay Level'						,'Personnel1','PayLevel'			FROM [ess.Policy] WHERE [Key] = 'PayLevel'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Shifting'						,'Personnel1','Shifting'			FROM [ess.Policy] WHERE [Key] = 'Shifting'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Work Assignment'					,'Personnel1','WorkAssignment'		FROM [ess.Policy] WHERE [Key] = 'WorkAssignment'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Union Affiliation'				,'Personnel1','UnionAffiliation'	FROM [ess.Policy] WHERE [Key] = 'UnionAffiliation'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Occupational Category'			,'Personnel1','Skill_Level'			FROM [ess.Policy] WHERE [Key] = 'Skill_Level'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Appointment Type'				,'Personnel1','Appointype'			FROM [ess.Policy] WHERE [Key] = 'Appointype'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment',''								,'Personnel1','DeptName'			FROM [ess.Policy] WHERE [Key] = 'DeptName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment',''								,'Personnel1','Position'			FROM [ess.Policy] WHERE [Key] = 'Position'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment',''								,'Personnel1','Location'			FROM [ess.Policy] WHERE [Key] = 'Location'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment',''								,'Personnel1','ReportsTo'			FROM [ess.Policy] WHERE [Key] = 'ReportsTo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Fixed'							,'Personnel1','Fixed'				FROM [ess.Policy] WHERE [Key] = 'Fixed'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Division'						,'Company'	 ,'Division'			FROM [ess.Policy] WHERE [Key] = 'Division'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Department'						,'Company'	 ,'SubDivision'			FROM [ess.Policy] WHERE [Key] = 'Department'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment','Section'							,'Company'	 ,'SubSubDivision'		FROM [ess.Policy] WHERE [Key] = 'Section'

INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Shirt Size'		,'Personnel1','ShirtSize'		FROM [ess.Policy] WHERE [Key] = 'ShirtSize'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Blazer'			,'Personnel1','Blazer'			FROM [ess.Policy] WHERE [Key] = 'Blazer'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Skirt'			,'Personnel1','Skirt'			FROM [ess.Policy] WHERE [Key] = 'Skirt'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Blouse'			,'Personnel1','Blouse'			FROM [ess.Policy] WHERE [Key] = 'Blouse'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Slacks'			,'Personnel1','Slacks'			FROM [ess.Policy] WHERE [Key] = 'Slacks'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Shirtjack'		,'Personnel1','Shirtjack'		FROM [ess.Policy] WHERE [Key] = 'Shirtjack'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Shirtjack Pants'	,'Personnel1','ShirtjackPants'	FROM [ess.Policy] WHERE [Key] = 'ShirtjackPants'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Polo/Barong'		,'Personnel1','PoloBarong'		FROM [ess.Policy] WHERE [Key] = 'PoloBarong'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Repellant Pants'	,'Personnel1','RepellantPants'	FROM [ess.Policy] WHERE [Key] = 'RepellantPants'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Polo Shirt'		,'Personnel1','PoloShirt'		FROM [ess.Policy] WHERE [Key] = 'PoloShirt'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Maong Pants'		,'Personnel1','MaongPants'		FROM [ess.Policy] WHERE [Key] = 'MaongPants'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','T-Shirt'			,'Personnel1','TShirt'			FROM [ess.Policy] WHERE [Key] = 'TShirt'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Overalls'		,'Personnel1','Overalls'		FROM [ess.Policy] WHERE [Key] = 'Overalls'

DELETE FROM [ess.Policy] WHERE GroupID IN (6,7,9) AND ID NOT IN (SELECT PolicyID FROM [ess.PolicyMapping])

-------------------------

ALTER TABLE [dbo].[ess.Policy] DROP CONSTRAINT [PK_ess.Policy]
GO

ALTER TABLE [dbo].[ess.Policy] ALTER COLUMN [ID] BIGINT NOT NULL
GO

ALTER TABLE [dbo].[ess.Policy] ADD CONSTRAINT [PK_ess.Policy] PRIMARY KEY CLUSTERED ([ID] ASC)
GO

ALTER TABLE [dbo].[ess.PolicyItems] DROP CONSTRAINT [PK_ess.PolicyItems]
GO

ALTER TABLE [dbo].[ess.PolicyItems] ALTER COLUMN [ID] BIGINT NOT NULL
GO

ALTER TABLE [dbo].[ess.PolicyItems] ADD CONSTRAINT [PK_ess.PolicyItems] PRIMARY KEY CLUSTERED ([ID] ASC)
GO

ALTER TABLE [dbo].[ess.PolicyItems] ALTER COLUMN [PolicyID] BIGINT NOT NULL
GO

ALTER TABLE [dbo].[ess.Change] DROP CONSTRAINT [PK_ess.Change]
GO

ALTER TABLE [dbo].[ess.Change] ALTER COLUMN [PolicyID] BIGINT NOT NULL
GO

ALTER TABLE [dbo].[ess.Change] ADD CONSTRAINT [PK_ess.Change] PRIMARY KEY CLUSTERED ([CompanyNum] ASC, [EmployeeNum] ASC, [NotifyDate] ASC, [PolicyID] ASC, [ValueF] ASC, [ValueT] ASC)
GO

-------------------------

ALTER PROCEDURE [dbo].[ess.Cascade]
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
		[PolicyID] BIGINT  NOT NULL,
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

-------------------------

INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 6, 13, N'SpouseSex', N'cmbSpouseSex', N'SpouseSex', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'[SexLU]', N'[Sex]', N'[Sex]', N'', NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 7, 15, N'SpouseDOB', N'dteSpouseBirthDate', N'SpouseDOB', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 6, 13, N'SpouseNationality', N'cmbSpouseNationality', N'SpouseNationality', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'[NationalityLU]', N'[Nationality]', N'[Nationality]', N'', NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (6, 5, 3, 19, 13, N'SpouseAddress', N'txtSpouseAddress', N'SpouseAddress', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (7, 5, 3, 21, 18, N'Contracting', N'dgView_003', N'Contracting', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)
INSERT INTO [dbo].[ess.Policy] ([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation], [Cascade], [Approval], [ApprovalLevel]) VALUES (7, 5, 3, 21, 18, N'PersonnelMovement', N'dgView_Movement', N'PersonnelMovement', N'', 1, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2)

DROP TRIGGER [RelWorkingInTMP_UTrig];
DROP TRIGGER [RelWorkingInTMP_ITrig];

go
ALTER TABLE [dbo].[Personnel1]
	ADD [SpouseAddress]	NVARCHAR(100) DEFAULT ('') NULL,
		[SpouseSex]		NVARCHAR(100) DEFAULT ('') NULL
go

DELETE FROM [ess.Policy] WHERE [Key] IN ('DeptName','Position','Location')
UPDATE [ess.Policy] SET Visible = 0, Editable = 0
	EXEC [ess.Cascade]

UPDATE [TableLU] SET Query = '--SELECT [m].[ItemName] AS [Item], [c].[ValueF] AS [From], [c].[ValueT] AS [To] FROM [ess.Change] AS [c] LEFT OUTER JOIN [ess.Policy] AS [p] ON [c].[PolicyID] = [p].[ID] LEFT OUTER JOIN [ess.PolicyMapping] AS [m] ON [p].[ID] = [m].[PolicyID] WHERE ([Level] = 0 AND [PathID] = <%PathID%>) ORDER BY [c].[PolicyID]'
	WHERE ID = 11

-------------------------
go
CREATE TRIGGER [dbo].[Trig.RejectToChange] ON [dbo].[ess.Reject] FOR DELETE
AS
	INSERT INTO [ess.Change] ([CompanyNum],[EmployeeNum],[NotifyDate],[PolicyID],[AssemblyID],[Template],[ValueF],[ValueT],[PathID],[Level],[AdditionalField],[AdditionalName],[AdditionalFilter])
		SELECT [CompanyNum],[EmployeeNum],[NotifyDate],[PolicyID],[AssemblyID],[Template],[ValueF],[ValueT],[PathID],[Level],[AdditionalField],[AdditionalName],[AdditionalFilter] FROM deleted

-------------------------

DELETE FROM [ess.PolicyMapping]

INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Age'					 ,NULL				  ,NULL					 FROM [ess.Policy] WHERE [Key] = 'Age'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Animal Sign'			 ,'Personnel'		  ,'ZodiacSignActual'	 FROM [ess.Policy] WHERE [Key] = 'ZodiacSignActual'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Date of Birth'		 ,'Personnel'		  ,'BirthDate'			 FROM [ess.Policy] WHERE [Key] = 'BirthDate'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Disability'			 ,'Personnel'		  ,'Disability'			 FROM [ess.Policy] WHERE [Key] = 'Disability'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Disability Notes'	 ,'Personnel'		  ,'DisabilityNotes'	 FROM [ess.Policy] WHERE [Key] = 'DisabilityNotes'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Employee Code'		 ,'Personnel'		  ,'EmployeeNum'		 FROM [ess.Policy] WHERE [Key] = 'EmployeeNum'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Ethnic Group'		 ,'Personnel'		  ,'EthnicGroup'		 FROM [ess.Policy] WHERE [Key] = 'EthnicGroup'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','First Name'			 ,'Personnel'		  ,'FirstName'			 FROM [ess.Policy] WHERE [Key] = 'FirstName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Gender'				 ,'Personnel'		  ,'Sex'				 FROM [ess.Policy] WHERE [Key] = 'Sex'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','ID No.'				 ,'Personnel'		  ,'IDNum'				 FROM [ess.Policy] WHERE [Key] = 'IDNum'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Language'			 ,'Personnel'		  ,'Language'			 FROM [ess.Policy] WHERE [Key] = 'Language'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Marital Status'		 ,'Personnel'		  ,'MaritialStatus'		 FROM [ess.Policy] WHERE [Key] = 'MaritalStatus'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Middle Name'			 ,'Personnel'		  ,'MiddleName'			 FROM [ess.Policy] WHERE [Key] = 'MiddleName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Mother''s Maiden Name','Personnel'		  ,'MaidenName'			 FROM [ess.Policy] WHERE [Key] = 'MaidenName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Nationality'			 ,'Personnel'		  ,'Nationality'		 FROM [ess.Policy] WHERE [Key] = 'Nationality'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Nickname'			 ,'Personnel'		  ,'PreferredName'		 FROM [ess.Policy] WHERE [Key] = 'PreferredName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Pag-Ibig No.'		 ,'Personnel'		  ,'PAGIBIGMembershipNo' FROM [ess.Policy] WHERE [Key] = 'PAGIBIGMembershipNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Phil-Health No.'		 ,'Personnel'		  ,'PHILMemNo'			 FROM [ess.Policy] WHERE [Key] = 'PHILMemNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Religion'			 ,'Personnel'		  ,'Religion'			 FROM [ess.Policy] WHERE [Key] = 'Religion'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','SSS Membership No.'	 ,'Personnel'		  ,'SSSMembershipNo'	 FROM [ess.Policy] WHERE [Key] = 'SSSMembershipNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Suffix'				 ,'Personnel'		  ,'Initials'			 FROM [ess.Policy] WHERE [Key] = 'Initials'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Surname'				 ,'Personnel'		  ,'Surname'			 FROM [ess.Policy] WHERE [Key] = 'Surname'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Tin No.'				 ,'Personnel'		  ,'BIRMembershipNo'	 FROM [ess.Policy] WHERE [Key] = 'BIRMembershipNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Title'				 ,'Personnel'		  ,'Title'				 FROM [ess.Policy] WHERE [Key] = 'Title'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Zodiac Sign'			 ,'Personnel'		  ,'ZodiacSign'			 FROM [ess.Policy] WHERE [Key] = 'ZodiacSign'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Preferred Shutte Area','Personnel'		  ,'ShuttleRoute'		 FROM [ess.Policy] WHERE [Key] = 'ShuttleRoute'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Tax Code'			 ,'Personnel'		  ,'TaxCode'			 FROM [ess.Policy] WHERE [Key] = 'TaxCode'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Attributes'			 ,'PersonnelAttribute','AttributeName'		 FROM [ess.Policy] WHERE [Key] = 'Attributes'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Other Languages'		 ,'OtherLanguage'	  ,'Language'			 FROM [ess.Policy] WHERE [Key] = 'OtherLanguage'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Personal','Interests/Hobbies'	 ,'Personnel'		  ,'RecInterestHob'		 FROM [ess.Policy] WHERE [Key] = 'RecInterestHob'

INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) Complex Unit No'	 ,'Personnel','AddrUnit'				FROM [ess.Policy] WHERE [Key] = 'AddrUnit'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) Complex Name'	 ,'Personnel','AddrComplex'				FROM [ess.Policy] WHERE [Key] = 'AddrComplex'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) House Number'	 ,'Personnel','AddrStreetNo'			FROM [ess.Policy] WHERE [Key] = 'AddrStreetNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) Street Name'		 ,'Personnel','AddrStreetName'			FROM [ess.Policy] WHERE [Key] = 'AddrStreetName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) Subdivision'		 ,'Personnel','AddrSuburb'				FROM [ess.Policy] WHERE [Key] = 'AddrSuburb'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) Region'			 ,'Personnel','AddrRegion'				FROM [ess.Policy] WHERE [Key] = 'AddrRegion'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) Province'		 ,'Personnel','AddrState'				FROM [ess.Policy] WHERE [Key] = 'AddrState'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) Municipality/City','Personnel','AddrCity'				FROM [ess.Policy] WHERE [Key] = 'AddrCity'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) Baranggay'		 ,'Personnel','AddrBaranggay'			FROM [ess.Policy] WHERE [Key] = 'AddrBaranggay'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) Postal Code'		 ,'Personnel','AddrZip'					FROM [ess.Policy] WHERE [Key] = 'AddrZip'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Long) Tel No.'			 ,'Personnel','AddrTelNo'				FROM [ess.Policy] WHERE [Key] = 'AddrTelNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Short) Street'			 ,'Personnel','Address1'				FROM [ess.Policy] WHERE [Key] = 'Address1'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Short) Suburb'			 ,'Personnel','Address2'				FROM [ess.Policy] WHERE [Key] = 'Address2'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Short) City'			 ,'Personnel','Address3'				FROM [ess.Policy] WHERE [Key] = 'Address3'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Short) State/Province'	 ,'Personnel','Address5'				FROM [ess.Policy] WHERE [Key] = 'Address5'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Short) Zip Code'		 ,'Personnel','Address4'				FROM [ess.Policy] WHERE [Key] = 'Address4'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Present Address - Short) Tel No.'		 ,'Personnel','Address6'				FROM [ess.Policy] WHERE [Key] = 'Address6'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) Complex Unit No'		 ,'Personnel','PermanentComplexUnitNo'	FROM [ess.Policy] WHERE [Key] = 'PermanentComplexUnitNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) Complex Name'			 ,'Personnel','PermanentComplexName'	FROM [ess.Policy] WHERE [Key] = 'PermanentComplexName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) House Number'			 ,'Personnel','PermanentHouseNumber'	FROM [ess.Policy] WHERE [Key] = 'PermanentHouseNumber'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) Street Name'			 ,'Personnel','PermanentStreetName'		FROM [ess.Policy] WHERE [Key] = 'PermanentStreetName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) Subdivision'			 ,'Personnel','PermanentSubdivision'	FROM [ess.Policy] WHERE [Key] = 'PermanentSubdivision'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) Region'				 ,'Personnel','Region'					FROM [ess.Policy] WHERE [Key] = 'Region'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) Province'				 ,'Personnel','State_or_Province'		FROM [ess.Policy] WHERE [Key] = 'State_or_Province'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) Municipality/City'	 ,'Personnel','PermanentCity'			FROM [ess.Policy] WHERE [Key] = 'PermanentCity'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) Baranggay'			 ,'Personnel','PermanentBaranggay'		FROM [ess.Policy] WHERE [Key] = 'PermanentBaranggay'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) Postal Code'			 ,'Personnel','PermanentPostalCode'		FROM [ess.Policy] WHERE [Key] = 'PermanentPostalCode'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','(Permanent Address) Tel No.'				 ,'Personnel','PermanentTelNo'			FROM [ess.Policy] WHERE [Key] = 'PermanentTelNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Facsimile No','Personnel','FaxNo' FROM [ess.Policy] WHERE [Key] = 'FaxNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Email Address (Alternative)','Personnel','EmailAddress1' FROM [ess.Policy] WHERE [Key] = 'EmailAddress1'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Latitude','Personnel','Latitude' FROM [ess.Policy] WHERE [Key] = 'Latitude'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Longitude','Personnel','Longitude' FROM [ess.Policy] WHERE [Key] = 'Longitude'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','P.O. Box','Personnel','POBox' FROM [ess.Policy] WHERE [Key] = 'POBox'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Area','Personnel','POArea' FROM [ess.Policy] WHERE [Key] = 'POArea'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Zip Code','Personnel','POCode' FROM [ess.Policy] WHERE [Key] = 'POCode'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Work No','Personnel','OfficeNo' FROM [ess.Policy] WHERE [Key] = 'OfficeNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Work Ext No','Personnel','ExtensionNo' FROM [ess.Policy] WHERE [Key] = 'ExtensionNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Mobile No','Personnel','CellTel' FROM [ess.Policy] WHERE [Key] = 'CellTel'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Home No','Personnel','HomeTel' FROM [ess.Policy] WHERE [Key] = 'HomeTel'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Email Address','Personnel','EmailAddress' FROM [ess.Policy] WHERE [Key] = 'EmailAddress'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Contact No.','Personnel','SpouseTel' FROM [ess.Policy] WHERE [Key] = 'SpouseTel'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Place of Birth','Personnel1','TownOfBirth' FROM [ess.Policy] WHERE [Key] = 'TownOfBirth'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Address & Telephone','Conutry of Birth','Personnel1','CountryOfBirth' FROM [ess.Policy] WHERE [Key] = 'CountryOfBirth'

INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Relatives Working in TMP','Relatives Working in TMP','','' FROM [ess.Policy] WHERE [Key] = 'Relatives'

INSERT INTO [ess.PolicyMapping] SELECT [ID],'Curriculum Vitae','Employment History','On-The-Job Training','','' FROM [ess.Policy] WHERE [Key] = 'OnTheJobTraining'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Curriculum Vitae','Employment History','Employment History','','' FROM [ess.Policy] WHERE [Key] = 'EmploymentHistory'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Curriculum Vitae','Educational Background','Educational Background','','' FROM [ess.Policy] WHERE [Key] = 'EducationalBackground'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Curriculum Vitae','Educational Background','Seminars and Trainings Attended','','' FROM [ess.Policy] WHERE [Key] = 'Seminars'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Curriculum Vitae','Educational Background','Organizational Affiliations','','' FROM [ess.Policy] WHERE [Key] = 'OrganizationalAffiliations'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Curriculum Vitae','Licensures/Certifications','Licensures/Certifications','','' FROM [ess.Policy] WHERE [Key] = 'Certifications'

---FAMILY BACKGROUND
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Last Name'		 ,'Personnel1'	,'SpouseSurname'	 FROM [ess.Policy] WHERE [Key] = 'SpouseSurname'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','First Name'		 ,'Personnel'	,'SpouseName'		 FROM [ess.Policy] WHERE [Key] = 'SpouseName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Middle Name'	 ,'Personnel'	,'SpouseMiddleName'	 FROM [ess.Policy] WHERE [Key] = 'SpouseMiddleName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Birthday'		 ,'Personnel1'	,'SpouseDOB'		 FROM [ess.Policy] WHERE [Key] = 'SpouseDOB'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Age'			 ,'Personnel'	,'SpouseAge'		 FROM [ess.Policy] WHERE [Key] = 'SpouseAge'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Gender'			 ,'Personnel1'	,'SpouseSex'		 FROM [ess.Policy] WHERE [Key] = 'SpouseSex'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Contact No.'	 ,'Personnel'	,'SpouseTel'		 FROM [ess.Policy] WHERE [Key] = 'SpouseTel'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Address'		 ,'Personnel1'	,'SpouseAddress'	 FROM [ess.Policy] WHERE [Key] = 'SpouseAddress'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Nationality'	 ,'Personnel'	,'SpouseNationality' FROM [ess.Policy] WHERE [Key] = 'SpouseNationality'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Occupation'		 ,'Personnel'	,'SpouseOccu'		 FROM [ess.Policy] WHERE [Key] = 'SpouseOccu'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Employer'		 ,'Personnel'	,'SpouseEmployer'	 FROM [ess.Policy] WHERE [Key] = 'SpouseEmployer'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Employer Address','Personnel'	,'SpouseEmployerAdd' FROM [ess.Policy] WHERE [Key] = 'SpouseEmployerAdd'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Next of Kin'	 ,'Personnel'	,'NextOfKin'		 FROM [ess.Policy] WHERE [Key] = 'NextOfKin'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Family Background','Dependants'		 ,'Personnel'	,'Dependants'		 FROM [ess.Policy] WHERE [Key] = 'Dependants'

INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Age'				,'Personnel','NOK_Age'			FROM [ess.Policy] WHERE [Key] = 'NOK_Age'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Employer Address'	,'Personnel','NOK_ERAddress'	FROM [ess.Policy] WHERE [Key] = 'NOK_ERAddress'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','First Name'		,'Personnel','NOK_FirstName'	FROM [ess.Policy] WHERE [Key] = 'NOK_FirstName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Last Name'		,'Personnel','NOK_Surname'		FROM [ess.Policy] WHERE [Key] = 'NOK_Surname'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Middle Name'		,'Personnel','NOK_MiddleName'	FROM [ess.Policy] WHERE [Key] = 'NOK_MiddleName'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Contact Number'	,'Personnel','NOK_ContactNo'	FROM [ess.Policy] WHERE [Key] = 'NOK_ContactNo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Occupation'		,'Personnel','NOK_Occupation'	FROM [ess.Policy] WHERE [Key] = 'NOK_Occupation'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Employer'			,'Personnel','NOK_Employer'		FROM [ess.Policy] WHERE [Key] = 'NOK_Employer'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Gender'			,'Personnel','NOK_Gender'		FROM [ess.Policy] WHERE [Key] = 'NOK_Gender'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Relationship'		,'Personnel','NOK_Relationship'	FROM [ess.Policy] WHERE [Key] = 'NOK_Relationship'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Personal','Contact Person In Case of Emergency','Birthday'			,'Personnel','NOK_DateOfBirth'	FROM [ess.Policy] WHERE [Key] = 'NOK_DateOfBirth'

---Organisational
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment'		 ,'Date Hired'						,'Personnel1','DateJoinedGroup'		FROM [ess.Policy] WHERE [Key] = 'DateJoinedGroup'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment'		 ,'Appointment Date'				,'Personnel1','Appointdate'			FROM [ess.Policy] WHERE [Key] = 'Appointdate'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment'		 ,'Years of Service (Group)'		,'Personnel1','YearsServiceG'		FROM [ess.Policy] WHERE [Key] = 'YearsServiceG'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment'		 ,'Years of Service (Appointment)'	,'Personnel1','YearsServiceA'		FROM [ess.Policy] WHERE [Key] = 'YearsServiceA'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment'		 ,'Division'						,'Company'	 ,'Division'			FROM [ess.Policy] WHERE [Key] = 'Division'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment'		 ,'Department'						,'Company'	 ,'SubDivision'			FROM [ess.Policy] WHERE [Key] = 'Department'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment'		 ,'Section'							,'Company'	 ,'SubSubDivision'		FROM [ess.Policy] WHERE [Key] = 'Section'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment'		 ,'Appointment Type'				,'Personnel1','Appointype'			FROM [ess.Policy] WHERE [Key] = 'Appointype'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment'		 ,'Occupational Category'			,'Personnel1','Skill_Level'			FROM [ess.Policy] WHERE [Key] = 'Skill_Level'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment'		 ,'Job Title'						,'Personnel1','JobTitle'			FROM [ess.Policy] WHERE [Key] = 'JobTitle'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment'		 ,'Cost Centre'						,'Personnel1','CostCentre'			FROM [ess.Policy] WHERE [Key] = 'CostCentre'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment'		 ,'Allocation'						,'Personnel1','CostCentreAlloc'		FROM [ess.Policy] WHERE [Key] = 'CostCentreAlloc'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment'		 ,'Category'						,'Personnel1','Category'			FROM [ess.Policy] WHERE [Key] = 'Category'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment'		 ,'Shifting'						,'Personnel1','Shifting'			FROM [ess.Policy] WHERE [Key] = 'Shifting'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment'		 ,'Work Assignment'					,'Personnel1','WorkAssignment'		FROM [ess.Policy] WHERE [Key] = 'WorkAssignment'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment'		 ,'Job Grade'						,'Personnel1','JobGrade'			FROM [ess.Policy] WHERE [Key] = 'JobGrade'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment'		 ,'Pay Level'						,'Personnel1','PayLevel'			FROM [ess.Policy] WHERE [Key] = 'PayLevel'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment'		 ,'Fixed'							,'Personnel1','Fixed'				FROM [ess.Policy] WHERE [Key] = 'Fixed'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Employment'		 ,'Union Affiliation'				,'Personnel1','UnionAffiliation'	FROM [ess.Policy] WHERE [Key] = 'UnionAffiliation'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Reports To'		 ,'Reports To'						,''			 ,''					FROM [ess.Policy] WHERE [Key] = 'ReportsTo'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Contracting'		 ,'Contracting'						,''			 ,''					FROM [ess.Policy] WHERE [Key] = 'Contracting'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Personnel Movement','Personnel Movement'				,''			 ,''					FROM [ess.Policy] WHERE [Key] = 'PersonnelMovement'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Blazer'							,'Personnel1','Blazer'				FROM [ess.Policy] WHERE [Key] = 'Blazer'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Skirt'							,'Personnel1','Skirt'				FROM [ess.Policy] WHERE [Key] = 'Skirt'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Blouse'							,'Personnel1','Blouse'				FROM [ess.Policy] WHERE [Key] = 'Blouse'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Slacks'							,'Personnel1','Slacks'				FROM [ess.Policy] WHERE [Key] = 'Slacks'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Shirtjack'						,'Personnel1','Shirtjack'			FROM [ess.Policy] WHERE [Key] = 'Shirtjack'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Shirtjack Pants'					,'Personnel1','ShirtjackPants'		FROM [ess.Policy] WHERE [Key] = 'ShirtjackPants'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Polo/Barong'						,'Personnel1','PoloBarong'			FROM [ess.Policy] WHERE [Key] = 'PoloBarong'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Repellant Pants'					,'Personnel1','RepellantPants'		FROM [ess.Policy] WHERE [Key] = 'RepellantPants'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Polo Shirt'						,'Personnel1','PoloShirt'			FROM [ess.Policy] WHERE [Key] = 'PoloShirt'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Maong Pants'						,'Personnel1','MaongPants'			FROM [ess.Policy] WHERE [Key] = 'MaongPants'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','T-Shirt'							,'Personnel1','TShirt'				FROM [ess.Policy] WHERE [Key] = 'TShirt'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Overalls'						,'Personnel1','Overalls'			FROM [ess.Policy] WHERE [Key] = 'Overalls'
INSERT INTO [ess.PolicyMapping] SELECT [ID],'Organisational','Uniform Allocation','Shirt Size'						,'Personnel1','ShirtSize'			FROM [ess.Policy] WHERE [Key] = 'ShirtSize'

-------------------------

-- ======================================= --
--  CREATED BY: RANDOLPH BENJO T. NAANEP   --
--      GURANGO SOFTWARE CORPORATION       --
-- ======================================= --
go
ALTER VIEW [dbo].[vwPersonnelInformation]
AS
	SELECT
		A.[CompanyNum]
	   ,A.[EmployeeNum]
	   ,A.[PreferredName]
	   ,A.[Title]
	   ,A.[Initials]
	   ,A.[Surname]
	   ,A.[FirstName]
	   ,A.[MiddleName]
	   ,A.[MaidenName]
	   ,A.[IDNum]
	   ,A.[Sex]
	   ,A.[Nationality]
	   ,A.[BirthDate]
	   ,A.[BloodType]
	   ,[dbo].[fnCalculateAge](BirthDate) AS [Age]
	   ,A.[ZodiacSign]
	   ,A.[ZodiacSignActual]
	   ,A.[Language]
	   ,A.[Religion]
	   ,A.[EthnicGroup]
	   ,A.[MaritialStatus] AS [MaritalStatus]
	   ,B.[MarriageDate]
	   ,A.[Disability]
	   ,A.[DisabilityNotes]
	   ,A.[ShuttleRoute]
	   ,A.[Address1]
	   ,A.[Address2]
	   ,A.[Address3]
	   ,A.[Address4]
	   ,A.[Address5]
	   ,A.[Address6]
	   ,A.[POBox]
	   ,A.[POArea]
	   ,A.[POCode]
	   ,A.[OfficeNo]
	   ,A.[CellTel]
	   ,A.[ExtensionNo]
	   ,A.[HomeTel]
	   ,A.[EMailAddress]
	   ,A.[AddrUnit]
	   ,A.[AddrComplex]
	   ,A.[AddrStreetNo]
	   ,A.[AddrStreetName]
	   ,A.[AddrSuburb]
	   ,A.[AddrCity]
	   ,A.[AddrZip]
	   ,A.[Latitude]
	   ,A.[Longitude]
	   ,A.[EMailAddress1]
	   ,A.[FaxNo]
-------SPOUSE INFORMATION
	   ,B.[SpouseSurname]
	   ,A.[SpouseName]
	   ,A.[SpouseMiddleName]
	   ,B.[SpouseDOB]
	   ,[dbo].[fnCalculateAge](B.SpouseDOB) AS [SpouseAge]
	   ,B.[SpouseSex]
	   ,A.[SpouseTel]
	   ,B.[SpouseAddress]
	   ,A.[SpouseNationality]
	   ,A.[SpouseOccu]
	   ,A.[SpouseEmployer]
	   ,A.[SpouseEmployerAdd]
	   ,A.[NOK_Surname]
	   ,A.[NOK_FirstName]
	   ,A.[NOK_MiddleName]
	   ,A.[NOK_DateOfBirth]
	   ,[dbo].[fnCalculateAge](A.NOK_DateOfBirth) AS [NOK_Age]
	   ,A.[NOK_Gender]
	   ,A.[NOK_Relationship]
	   ,A.[NOK_ERAddress]
	   ,A.[NOK_ContactNo]
	   ,A.[NOK_Occupation]
	   ,A.[NOK_Employer]
	   ,A.[BIRMembershipNo]
	   ,A.[SSSMembershipNo]
	   ,A.[PAGIBIGMembershipNo]
	   ,A.[PHILMemNo]
	   ,B.[TownOfBirth]
	   ,B.[CountryOfBirth]
	   ,C.[RecInterestHob]
	   ,A.[AddrRegion]
	   ,A.[TaxCode]
	   ,A.[AddrBaranggay]
	   ,A.[Baranggay]
	   ,A.[AddrState]
	   ,A.[AddrTelNo]
	   ,A.[PermanentComplexUnitNo]
	   ,A.[PermanentComplexName]
	   ,A.[PermanentHouseNumber]
	   ,A.[PermanentStreetName]
	   ,A.[PermanentSubdivision]
	   ,A.[Region]
	   ,A.[State_or_Province]
	   ,A.[PermanentCity]
	   ,A.[PermanentBaranggay]
	   ,A.[PermanentPostalCode]
	   ,A.[PermanentTelNo]
	FROM [Personnel]						 AS A
		LEFT OUTER JOIN [Personnel1]		 AS B ON A.CompanyNum = B.CompanyNum AND A.EmployeeNum = B.EmployeeNum
		LEFT OUTER JOIN [RecPositionApplied] AS C ON A.CompanyNum = C.CompanyNum AND A.EmployeeNum = C.EmployeeNum


GO

-------------------------

-- ======================================= --
--  CREATED BY: RANDOLPH BENJO T. NAANEP   --
--      GURANGO SOFTWARE CORPORATION       --
-- ======================================= --
ALTER VIEW [dbo].[vwOrganizationalInformation]
AS
	SELECT
		A.[CompanyNum]
	   ,A.[EmployeeNum]
	   ,D.[Division]			AS Division
	   ,D.[SubDivision]			AS Department
	   ,D.[SubSubDivision]		AS Section
	   ,A.[Uniform_Blazer]		AS Blazer
	   ,A.[Uniform_Skirt]		AS Skirt
	   ,A.[Uniform_Blouse]		AS Blouse
	   ,A.[Uniform_Slack]		AS Slacks
	   ,A.[Uniform_Shirtjack]	AS Shirtjack
	   ,A.[Uniform_SJPants]		AS ShirtjackPants
	   ,A.[Uniform_PoloBarong]	AS PoloBarong
	   ,A.[Uniform_RepPants]	AS RepellantPants
	   ,A.[Uniform_PoloShirt]	AS PoloShirt
	   ,A.[Uniform_MaongPants]	AS MaongPants
	   ,A.[Uniform_TShirt]		AS TShirt
	   ,A.[Uniform_Overalls]	AS Overalls
	   ,C.[AttributeValue]		AS ShirtSize
	   ,B.[IndividualJobTitle]	AS JobTitle
	   ,A.[JobTitle]			AS UnionAffiliation
	   ,A.[JobGrade]			AS JobGrade
	   ,A.[CostCentre]			AS CostCentre
	   ,B.[OFOCode]				AS Category
	   ,B.[OFOOccupation]		AS PayLevel
	   ,B.[ShiftType]			AS Shifting
	   ,B.[LocationCategory]	AS WorkAssignment
	   ,A.[DeptName]			AS DeptName
	   ,A.[Skill_Level]			AS Skill_Level
	   ,A.[Appointype]			AS Appointype
	   ,A.[DateJoinedGroup]		AS DateJoinedGroup
	   ,A.[Appointdate]			AS AppointDate
	   ,A.[TerminationDate]		AS TerminationDate
	   ,A.[Termination]			AS Termination
	   ,B.[Fixed]				AS Fixed
	FROM [Personnel]					AS A
		LEFT JOIN [Personnel1]			AS B ON A.CompanyNum = B.CompanyNum AND A.EmployeeNum = B.EmployeeNum
		LEFT JOIN [PersonnelAttribute]	AS C ON A.CompanyNum = C.CompanyNum AND A.EmployeeNum = C.EmployeeNum AND C.AttributeName = 'SHIRT SIZE'
		LEFT JOIN [Company]				AS D ON A.CompanyNum = D.CompanyNum

GO

-------------------------

ALTER PROCEDURE [dbo].[ess.Approve]
	@CompanyNum	 NVARCHAR(MAX)
   ,@EmployeeNum NVARCHAR(MAX)
   ,@PathID		 INT
   ,@Counter	 INT
   ,@ActionType	 NVARCHAR(MAX)
AS
BEGIN
	DECLARE @LastApprover NVARCHAR(MAX)
	
	SELECT @LastApprover = E.ReportsToType FROM [ess.WF] AS A INNER JOIN [ess.WFLU] AS B ON A.WFLUID = B.ID INNER JOIN [ess.StatusLU] AS C ON A.StatusID = C.ID INNER JOIN [ess.PALU] AS D ON A.PAID = D.ID INNER JOIN [ess.ActionLU] AS E ON A.ActionID = E.ID
		WHERE B.WFType = 'Change' AND B.WFName = 'Approve' AND D.PostActionType = 'Completed'
	
	UPDATE [ess.Change] SET Level = (CASE WHEN @ActionType = @LastApprover THEN 0 ELSE Level - @Counter END) WHERE CompanyNum = @CompanyNum AND EmployeeNum = @EmployeeNum AND PathID = @PathID
	
	SELECT
		[Table] = D.TableName
	   ,[Field] = (CASE WHEN E.Typename LIKE '%GridView%' THEN A.AdditionalField ELSE D.FieldName END)
	   ,[Where]	= (CASE WHEN E.Typename LIKE '%GridView%' THEN 'AND DependName = ''' + A.AdditionalFilter + '''' ELSE '' END)
	   ,[Value]	= A.[ValueT]
	INTO #CHANGES FROM [ess.Change]		AS A
		INNER JOIN [ess.Policy]			AS B ON B.ID = A.PolicyID
		INNER JOIN [ess.PolicyGroups]	AS C ON C.ID = B.GroupID
		INNER JOIN [ess.PolicyMapping]	AS D ON B.ID = D.PolicyID
		INNER JOIN [AssemblyLU]			AS E ON E.ID = B.AssemblyID
	WHERE A.CompanyNum = @CompanyNum AND A.EmployeeNum = @EmployeeNum AND A.PathID = @PathID AND A.Level = 0
	
	WHILE ((SELECT COUNT(*) FROM #CHANGES) > 0)
	BEGIN
		DECLARE
			@Query NVARCHAR(MAX)
		   ,@Table NVARCHAR(MAX)
		   ,@Field NVARCHAR(MAX)
		   ,@Where NVARCHAR(MAX)
		   ,@Value NVARCHAR(MAX)
		
		SELECT TOP(1) @Table = [Table], @Field = [Field], @Value = [Value], @Where = [Where] FROM #CHANGES
		
		SET @Query = 'UPDATE ' + @Table + ' SET ' + @Field + ' = ''' + @Value + ''' WHERE CompanyNum = ''' + @CompanyNum + ''' AND EmployeeNum = ''' + @EmployeeNum + ''' ' + @Where
		
		IF EXISTS (SELECT 1 FROM sys.columns WHERE Name = @Field AND Object_ID = Object_ID(@Table))
		BEGIN
			EXEC(@Query)
		END
		
		DELETE FROM #CHANGES WHERE [Field] = @Field AND [Value] = @Value
	END
	
	DROP TABLE #CHANGES
	
	IF (SELECT COUNT(*) FROM [ess.Change] WHERE [CompanyNum] = @CompanyNum AND [EmployeeNum] = @EmployeeNum AND [PathID] = @PathID AND [Level] > 0) = 0
	BEGIN
		DECLARE
			@NewActioner	 NVARCHAR(100) = ''
		   ,@NewCompanyCode	 NVARCHAR(100) = ''
		   ,@NewEmployeeCode NVARCHAR(100) = ''
		   ,@NewUsername	 NVARCHAR(100) = ''
		
		SELECT
			@NewActioner	 = Originator
		   ,@NewCompanyCode	 = OriginatorCompanyNum
		   ,@NewEmployeeCode = OriginatorEmployeeNum
		   ,@NewUsername	 = OriginatorUsername
		FROM [ess.Path] WHERE ID = @PathID
		
		UPDATE [ess.Path] SET
			Actioner			 = @NewActioner
		   ,ActionerCompanyNum	 = @NewCompanyCode
		   ,ActionerEmployeeNum	 = @NewEmployeeCode
		   ,ActionerUsername	 = @NewUsername
		   ,UserEmail			 = (SELECT TOP(1) EmailAddress FROM Personnel WHERE CompanyNum = @NewCompanyCode AND EmployeeNum = @NewEmployeeCode)
		   ,PAID				 = 5
		   ,WFID				 = 191
		WHERE [ID] = @PathID
	END
END

-------------------------


-------------------------


-------------------------


-------------------------


-------------------------


-------------------------


-------------------------


-------------------------


-------------------------


-------------------------


-------------------------


-------------------------


-------------------------


-------------------------
