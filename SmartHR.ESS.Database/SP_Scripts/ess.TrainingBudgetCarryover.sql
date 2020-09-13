SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[ess.TrainingBudgetCarryover]') AND OBJECTPROPERTY(ID, N'ISPROCEDURE') = 1)
BEGIN
PRINT 'Dropping Procedure ess.TrainingBudgetCarryover'
DROP PROCEDURE [DBO].[ess.TrainingBudgetCarryover]	
END
PRINT 'Creating Procedure ess.TrainingBudgetCarryover'
GO

CREATE PROCEDURE DBO.[ess.TrainingBudgetCarryover]

AS

----------------------------------------------------------------------------------------------------
SET NOCOUNT ON
----------------------------------------------------------------------------------------------------
BEGIN
----------------------------------------------------------------------------------------------------

UPDATE teb
SET teb.[AmountTransferred] = teb1.[RemainingBudget],
teb.[DateTransferred] = GETDATE(),
teb.[RemainingBudget] = teb1.[RemainingBudget] + teb.[RemainingBudget]
FROM TrainingExternalBudget teb
INNER JOIN TrainingExternalBudget teb1
	ON teb1.[CategoryName] = teb.[CategoryName]
	AND teb1.[Month] = MONTH(GETDATE()) - 1
	AND teb1.[Year] = teb.[Year]
WHERE teb.[Month] = MONTH(GETDATE())
AND teb.[Year] = YEAR(GETDATE())
AND teb.[DateTransferred] IS NULL
AND teb.[AmountTransferred] IS NULL

UPDATE teb1 
SET teb1.[RemainingBudget] = 0
FROM TrainingExternalBudget teb1
WHERE teb1.[Month] = MONTH(DATEADD(MONTH, -1, GETDATE()))
AND teb1.[Year] = YEAR(DATEADD(MONTH, -1, GETDATE()))

----------------------------------------------------------------------------------------------------			
END
----------------------------------------------------------------------------------------------------
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
----------------------------------------------------------------------------------------------------