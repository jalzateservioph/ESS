SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[gsc_sp_<code of the report>]') AND OBJECTPROPERTY(ID, N'ISPROCEDURE') = 1)
BEGIN
PRINT 'Dropping Procedure gsc_sp_<code of the report>'
DROP PROCEDURE [DBO].gsc_sp_<code of the report>	
END
PRINT 'Creating Procedure gsc_sp_<code of the report>'
GO

CREATE PROCEDURE DBO.gsc_sp_<code of the report>

AS

----------------------------------------------------------------------------------------------------
SET NOCOUNT ON
----------------------------------------------------------------------------------------------------
BEGIN
----------------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------------			
END
----------------------------------------------------------------------------------------------------
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
----------------------------------------------------------------------------------------------------