/****** Object:  View [dbo].[vwQualifications]    Script Date: 4/3/2019 6:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT 1 FROM sys.views WHERE [Name] = 'vwQualifications' AND [Type]='V')
	DROP VIEW vwQualifications;
GO

PRINT N'Creating [dbo].[vwQualifications]...';
GO

CREATE VIEW [dbo].[vwQualifications]
AS
	SELECT
		EmployeeNum
	   ,[Degree]	  = ISNULL((CASE WHEN Qualification IN ('HIGH SCHOOL','ELEMENTARY') THEN REPLACE(Qualification,'&','AND') ELSE REPLACE(Course,'&','AND') END),'-')
	   ,[Institution] = ISNULL(REPLACE(Institution,'&','AND'),'-') 
	   ,[From-To]	  = ISNULL((CAST(YEAR(StartDate) AS VARCHAR(4)) + ' - ' + CAST(YEAR(DateObtained) AS VARCHAR(4))),'-')
	FROM Qualifications

GO
