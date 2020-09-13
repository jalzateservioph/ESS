/****** Object:  StoredProcedure [dbo].[prInsertPromotionHistory]    Script Date: 3/22/2019 1:40:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[prInsertPromotionHistory]') AND OBJECTPROPERTY(ID, N'ISPROCEDURE') = 1)
BEGIN
	PRINT 'Dropping Procedure prInsertPromotionHistory'
	DROP PROCEDURE [dbo].[prInsertPromotionHistory]	
END

PRINT N'Creating [dbo].[prInsertPromotionHistory]...';
GO

CREATE PROCEDURE [dbo].[prInsertPromotionHistory]
	@EmployeeCode	VARCHAR(20)
   ,@PromotionDate	DATETIME
   ,@Category		VARCHAR(100)
   ,@PayLevel		VARCHAR(10)
   ,@JobGrade		VARCHAR(10)
   ,@EmployeeClass	VARCHAR(100)
   ,@Position		VARCHAR(100)
AS
BEGIN
	DECLARE
		@CompanyCode VARCHAR(20) = (SELECT TOP(1) CompanyNum FROM Personnel WHERE EmployeeNum = @EmployeeCode)
	   ,@Error INT = 0
	
	IF @Category IS NOT NULL OR @Category <> ''
	BEGIN
		BEGIN TRY
			INSERT INTO PersonnelHistoryLog (ActionDate,ActionDescription,CompanyNum,EmployeeNum,EffectiveFrom,ChangedTo,Remarks)
				VALUES (@PromotionDate,'CATEGORY',@CompanyCode,@EmployeeCode,@PromotionDate,@Category,'PROMOTION')
		END TRY
		BEGIN CATCH 
			SET @Error = @Error + 1
		END CATCH
	END
	
	IF @PayLevel IS NOT NULL OR @PayLevel <> ''
	BEGIN
		BEGIN TRY
			INSERT INTO PersonnelHistoryLog (ActionDate,ActionDescription,CompanyNum,EmployeeNum,EffectiveFrom,ChangedTo,Remarks)
				VALUES (@PromotionDate,'PAY LEVEL',@CompanyCode,@EmployeeCode,@PromotionDate,@PayLevel,'PROMOTION')
		END TRY
		BEGIN CATCH 
			SET @Error = @Error + 1
		END CATCH
	END
	
	IF @JobGrade IS NOT NULL OR @JobGrade <> ''
	BEGIN
		BEGIN TRY
			INSERT INTO PersonnelHistoryLog (ActionDate,ActionDescription,CompanyNum,EmployeeNum,EffectiveFrom,ChangedTo,Remarks)
				VALUES (@PromotionDate,'JOB GRADE',@CompanyCode,@EmployeeCode,@PromotionDate,@JobGrade,'PROMOTION')
		END TRY
		BEGIN CATCH 
			SET @Error = @Error + 1
		END CATCH
	END
	
	IF @EmployeeClass IS NOT NULL OR @EmployeeClass <> ''
	BEGIN
		BEGIN TRY
			INSERT INTO PersonnelHistoryLog (ActionDate,ActionDescription,CompanyNum,EmployeeNum,EffectiveFrom,ChangedTo,Remarks)
				VALUES (@PromotionDate,'EMPLOYEE CLASS',@CompanyCode,@EmployeeCode,@PromotionDate,@EmployeeClass,'PROMOTION')
		END TRY
		BEGIN CATCH 
			SET @Error = @Error + 1
		END CATCH
	END
	
	IF @Position IS NOT NULL OR @Position <> ''
	BEGIN
		BEGIN TRY
			INSERT INTO PersonnelHistoryLog (ActionDate,ActionDescription,CompanyNum,EmployeeNum,EffectiveFrom,ChangedTo,Remarks)
				VALUES (@PromotionDate,'POSITION',@CompanyCode,@EmployeeCode,@PromotionDate,@Position,'PROMOTION')
		END TRY
		BEGIN CATCH 
			SET @Error = @Error + 1
		END CATCH
	END
		
	SELECT @Error AS 'ERRORS'
END
