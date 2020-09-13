IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[ess.AutoApproved]') AND OBJECTPROPERTY(ID, N'ISPROCEDURE') = 1)
BEGIN
	PRINT 'Dropping Procedure ess.AutoApproved'
	DROP PROCEDURE [DBO].[ess.AutoApproved]	
END

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