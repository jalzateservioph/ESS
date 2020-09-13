/****** Object:  StoredProcedure [dbo].[prInsertToTemp]    Script Date: 3/22/2019 1:43:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[prInsertToTemp]') AND OBJECTPROPERTY(ID, N'ISPROCEDURE') = 1)
BEGIN
	PRINT 'Dropping Procedure prInsertToTemp'
	DROP PROCEDURE [dbo].[prInsertToTemp]	
END

PRINT N'Creating [dbo].[prInsertToTemp]...';
GO

CREATE procedure [dbo].[prInsertToTemp]
@PERIOD_FROM DATETIME,
@PERIOD_TO DATETIME,
@RATE_DATE DATETIME,
@RATER VARCHAR(100),
@RATE_CODE VARCHAR(10),
@MAN_NO VARCHAR(50),
@JOBTITLE_CODE VARCHAR(20),
@PAYLVL_CODE VARCHAR(20),
@RATE_TYPE VARCHAR(20),
@PAYGRP_CODE VARCHAR(20)
AS
BEGIN
	INSERT INTO [prTempPerformance] 
	VALUES 
	(
		@PERIOD_FROM,@PERIOD_TO,@RATE_DATE,
		@RATER,@RATE_CODE,@MAN_NO,@JOBTITLE_CODE,
		@PAYLVL_CODE,@RATE_TYPE,@PAYGRP_CODE
	)
END