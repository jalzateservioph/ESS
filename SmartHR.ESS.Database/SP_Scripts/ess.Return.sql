IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[ess.Return]') AND OBJECTPROPERTY(ID, N'ISPROCEDURE') = 1)
BEGIN
	PRINT 'Dropping Procedure ess.Return'
	DROP PROCEDURE [dbo].[ess.Return]	
END

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