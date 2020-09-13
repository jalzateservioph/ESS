SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[ess.TrainingAgreementPath]') AND OBJECTPROPERTY(ID, N'ISPROCEDURE') = 1)
BEGIN
PRINT 'Dropping Procedure ess.TrainingAgreementPath'
DROP PROCEDURE [DBO].[ess.TrainingAgreementPath]	
END
PRINT 'Creating Procedure ess.TrainingAgreementPath'
GO

CREATE PROCEDURE DBO.[ess.TrainingAgreementPath]

	@PathID			BIGINT = NULL, 
	@CompanyNum		NVARCHAR(20) = NULL, 
	@EmployeeNum	NVARCHAR(12) = NULL, 
	@StartDate		DATETIME = NULL

AS

----------------------------------------------------------------------------------------------------
SET NOCOUNT ON
----------------------------------------------------------------------------------------------------
BEGIN
----------------------------------------------------------------------------------------------------

DECLARE @ExternalPositionTitle NVARCHAR(50)

UPDATE [TrainingAgreementForm] 
   SET [PathID] = @PathID 
WHERE [CompanyNum] = @CompanyNum 
  AND [EmployeeNum] = @EmployeeNum 
  AND [DatePrepared] = @StartDate 
  AND [PathID] IS NULL
  
UPDATE [TrainingPlanned]
	SET [PathID] = @PathID
WHERE [CompanyNum] = @CompanyNum 
  AND [EmployeeNum] = @EmployeeNum 
  AND [StartDate] = @StartDate 
  AND [PathID] IS NULL

UPDATE tp
	SET tp.[cfType] = tad.[Type],
	tp.[cfProgramType] = tad.[ProgramType],
	tp.[cfInvestment] = tad.[Investment],
	tp.[StartDate] = tad.[DateFrom],
	tp.[CompletionDate] = tad.[DateTo]
FROM [TrainingPlanned] tp
INNER JOIN [TrainingAgreementForm] taf
	ON tp.[PathID] = taf.[PathID]
INNER JOIN [TAFProgramDetails] tad
	ON taf.[TAFID] = tad.[TAFID]
WHERE taf.[PathID] = @PathID
AND tp.[PathID] = @PathID

SELECT 
	@ExternalPositionTitle = [ExternalPositionTitle] 
FROM [TrainingAgreementForm] 
WHERE [PathID] = @PathID

UPDATE [ess.Path] 
   SET [Summary] = @ExternalPositionTitle 
WHERE [ID] = @PathID

----------------------------------------------------------------------------------------------------			
END
----------------------------------------------------------------------------------------------------
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
----------------------------------------------------------------------------------------------------