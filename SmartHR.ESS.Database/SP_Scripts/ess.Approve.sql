PRINT N'Altering [dbo].[ess.Approve]...';

/****** Object:  StoredProcedure [dbo].[ess.Approve]    Script Date: 4/3/2019 6:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[ess.Approve]') AND OBJECTPROPERTY(ID, N'ISPROCEDURE') = 1)
BEGIN
	PRINT 'Dropping Procedure ess.Approve'
	DROP PROCEDURE [dbo].[ess.Approve]	
END

PRINT N'Altering [dbo].[ess.Approve]...';
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
GO