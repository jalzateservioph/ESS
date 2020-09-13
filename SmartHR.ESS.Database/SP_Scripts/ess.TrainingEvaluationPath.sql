SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[ess.TrainingEvaluationPath]') AND OBJECTPROPERTY(ID, N'ISPROCEDURE') = 1)
BEGIN
PRINT 'Dropping Procedure ess.TrainingEvaluationPath'
DROP PROCEDURE [DBO].[ess.TrainingEvaluationPath]	
END
PRINT 'Creating Procedure ess.TrainingEvaluationPath'
GO

CREATE PROCEDURE DBO.[ess.TrainingEvaluationPath]

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

DECLARE 
	@TrainingType INT,
	@CourseName NVARCHAR(50)

UPDATE [TrainingEvaluation] 
   SET [PathID] = @PathID 
WHERE [CompanyNum] = @CompanyNum 
  AND [EmployeeNum] = @EmployeeNum 
  AND [StartDate] = @StartDate 
  AND [PathID] IS NULL

SELECT 
	@TrainingType = [TrainingType],
	@CourseName = [CourseName] 
FROM [TrainingEvaluation] 
WHERE [PathID] = @PathID

UPDATE [ess.Path] 
   SET [Summary] = 
		CASE WHEN @TrainingType = 1 THEN 'In-house'
			 WHEN @TrainingType = 2 THEN 'External'
			 WHEN @TrainingType = 3 THEN 'Overseas'
		END + ':' + @CourseName 
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