/****** Object:  StoredProcedure [dbo].[prInsertToTempPH]    Script Date: 3/22/2019 1:43:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[prInsertToTempPH]') AND OBJECTPROPERTY(ID, N'ISPROCEDURE') = 1)
BEGIN
	PRINT 'Dropping Procedure prInsertToTempPH'
	DROP PROCEDURE [dbo].[prInsertToTempPH]	
END

PRINT N'Creating [dbo].[prInsertToTempPH]...';
GO

CREATE procedure [dbo].[prInsertToTempPH]
@EMPLOYEE_NUMBER VARCHAR(50),
@PROMOTION_DATE DATETIME,
@EMPLOYEE_CATEGORY VARCHAR(100),
@PAY_LEVEL VARCHAR(5),
@JOB_GRADE VARCHAR(5),
@EMPLOYEE_CLASS VARCHAR(100),
@POSITION VARCHAR(200)
AS
BEGIN
	INSERT INTO [prPromotionHistoryTemp] 
	VALUES 
	(
		@EMPLOYEE_NUMBER,@PROMOTION_DATE,@EMPLOYEE_CATEGORY,
		@PAY_LEVEL,@JOB_GRADE,@EMPLOYEE_CLASS,@POSITION
	)
END
