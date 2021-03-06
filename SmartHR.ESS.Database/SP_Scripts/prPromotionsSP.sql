/****** Object:  StoredProcedure [dbo].[prPromotionsSP]    Script Date: 3/27/2019 1:56:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[prPromotionsSP]') AND OBJECTPROPERTY(ID, N'ISPROCEDURE') = 1)
BEGIN
	PRINT 'Dropping Procedure [prPromotionsSP]'
	DROP PROCEDURE [dbo].[prPromotionsSP]	
END

PRINT N'Creating [dbo].[prPromotionsSP]...';
GO

CREATE PROCEDURE [dbo].[prPromotionsSP]
	@Years			INT
	,@HireDate		DATETIME
	,@AsOf			DATETIME
	,@Filter		VARCHAR(100)
	,@FullName		VARCHAR(100)
AS
BEGIN
	SELECT DISTINCT
		[Division]			= COALESCE((RIGHT(C.Division,(CASE WHEN LEN(C.Division)-4 > 0 THEN LEN(C.Division)-4 ELSE LEN(C.Division) END))),' ')
	   ,[Department]		= COALESCE(C.SubDivision,'-') + ' / ' + COALESCE(C.SubSubDivision,'-')
	   ,[Employment Type]	= COALESCE(P.EmploymentType,'')
	   ,[Category]			= COALESCE(D.OFOCode,'')
	   ,[PayLevel]			= D.OFOOccupation
	   --,[PayLevel]			= COALESCE((CASE WHEN (LEN(D.OFOOccupation) < 2 AND ISNUMERIC(D.OFOOccupation) = 1) OR (LEN(D.OFOOccupation) < 3 AND ISNUMERIC(RIGHT(D.OFOOccupation,1))= 0) THEN '0' + D.OFOOccupation ELSE D.OFOOccupation END),'')
	   ,[Employee Number]	= P.EmployeeNum
	   ,[Full Name]			= P.Surname + ', ' + P.FirstName + ' ' + COALESCE((LEFT(P.MIDDLENAME,(CASE WHEN LEN(P.MIDDLENAME) > 0 AND P.MIDDLENAME LIKE '%[A-Z]' THEN 1 END)))+'.',' ') 
	   ,[Age]				= CAST(ROUND((DATEDIFF(DAY,P.BirthDate,GETDATE())/365.25),2) AS DECIMAL(10,2))
	   ,[Grade]				= P.JobGrade
	   ,[Job Title]			= P.JobTitle
	   ,[Date Hired]		= P.DateJoinedGroup
	   ,[HR]				= CAST(ROUND((DATEDIFF(DAY,P.DateJoinedGroup, GETDATE())/365.25),2) AS DECIMAL(10,2))
	   ,[Reg`Tn Date]		= D.ProbationEndDate
	   ,[RD]				= CAST(ROUND((DATEDIFF(DAY,D.ProbationEndDate,GETDATE())/365.25),2) AS DECIMAL(10,2))
	   ,[Degree]			= STUFF((SELECT '#' + ISNULL(Degree,'-') + (CASE WHEN LEN(Degree) <= 28 THEN (CASE WHEN LEN(Institution) > 66 THEN '###' ELSE (CASE WHEN LEN(Institution) > 33 THEN '##' ELSE '#' END) END) ELSE (CASE WHEN LEN(Degree) <= 56 THEN (CASE WHEN LEN(Institution) > 66 THEN '##' ELSE (CASE WHEN LEN(Institution) > 33 THEN '#' ELSE '' END) END) ELSE '#' END) END) AS [text()] FROM vwQualifications WHERE EmployeeNum = P.EmployeeNum ORDER BY [From-To] DESC FOR XML PATH('')),1,1,'')
	   ,[School]			= REPLACE(STUFF((SELECT '#' + ISNULL(Institution,'-') + (CASE WHEN LEN(Institution) <= 33 THEN (CASE WHEN LEN(Degree) > 56 THEN '###' ELSE (CASE WHEN LEN(Degree) > 28 THEN '##' ELSE '#' END) END) ELSE (CASE WHEN LEN(Institution) <= 66 THEN (CASE WHEN LEN(Degree) > 56 THEN '##' ELSE (CASE WHEN LEN(Degree) > 28 THEN '#' ELSE '' END) END) ELSE '#' END) END) AS [text()] FROM vwQualifications WHERE EmployeeNum = P.EmployeeNum ORDER BY [From-To] DESC FOR XML PATH('')),1,1,''),'&amp;','AND')
	   ,[From - To]			= STUFF((SELECT '#' + [From-To] + (CASE WHEN LEN(Degree) > 60 OR LEN(Institution) > 60 THEN '###' ELSE (CASE WHEN LEN(Degree) > 28 OR LEN(Institution) > 33 THEN '##' ELSE '#' END) END) AS [text()] FROM vwQualifications WHERE EmployeeNum = P.EmployeeNum ORDER BY [From-To] DESC FOR XML PATH('')),1,1,'')
	   ,[First]				= CONVERT(INT,v1.Rate_Code)
	   ,[Second]			= CONVERT(INT,v2.Rate_Code)
	   ,[Third]				= CONVERT(INT,v3.Rate_Code)
	   ,[Fourth]			= CONVERT(INT,v4.Rate_Code)
	   ,[Attendance]		= CONVERT(INT,A.Rate_Code)
	   ,[Promotion H]		= REPLACE(STUFF((SELECT '#' + CONVERT(VARCHAR(10),EffectiveFrom,110) AS [text()] FROM (SELECT DISTINCT EffectiveFrom AS [EffectiveFrom] FROM PersonnelHistoryLog WHERE Remarks LIKE '%PROMOTION%' AND EmployeeNum = P.EmployeeNum AND ActionDescription IN ('Individual Job Title','Job Title','OFO Code','OFO Occupation','Pay Level')) X ORDER BY EffectiveFrom DESC FOR XML PATH('')),1,1,''),'-','/')
	FROM Personnel				 P
		LEFT JOIN Personnel1	 D ON P.CompanyNum = D.CompanyNum AND P.EmployeeNum	= D.EmployeeNum
		LEFT JOIN Company		 C ON P.CompanyNum = C.CompanyNum
		LEFT JOIN (SELECT Man_No, Rate_Code FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY Man_No ORDER BY ID DESC) AS RN FROM prPerformance WHERE DATEPART(YEAR,PERIOD_FROM) = (@Years - 1) AND Rate_Type = 'Attendance') AS xKey WHERE RN = 1) AS A	ON P.EmployeeNum = A.Man_No
		LEFT JOIN (SELECT Man_No, Rate_Code FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY Man_No ORDER BY ID DESC) AS RN FROM prPerformance WHERE DATEPART(YEAR,PERIOD_FROM) = (@Years - 1) AND Rate_Type = 'MidYear')	AS xKey WHERE RN = 1) AS v1	ON P.EmployeeNum = v1.Man_No
		LEFT JOIN (SELECT Man_No, Rate_Code FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY Man_No ORDER BY ID DESC) AS RN FROM prPerformance WHERE DATEPART(YEAR,PERIOD_FROM) = (@Years - 1) AND Rate_Type = 'YearEnd')	AS xKey WHERE RN = 1) AS v2	ON P.EmployeeNum = v2.Man_No
		LEFT JOIN (SELECT Man_No, Rate_Code FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY Man_No ORDER BY ID DESC) AS RN FROM prPerformance WHERE DATEPART(YEAR,PERIOD_FROM) = (@Years)	  AND Rate_Type = 'MidYear')	AS xKey WHERE RN = 1) AS v3	ON P.EmployeeNum = v3.Man_No
		LEFT JOIN (SELECT Man_No, Rate_Code FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY Man_No ORDER BY ID DESC) AS RN FROM prPerformance WHERE DATEPART(YEAR,PERIOD_FROM) = (@Years)	  AND Rate_Type = 'YearEnd')	AS xKey WHERE RN = 1) AS v4	ON P.EmployeeNum = v4.Man_No
	WHERE P.CompanyNum NOT IN ('Applicants','Date Migration','Temporary','Unallocated')
		AND D.OFOCode != 'Student Trainee'
		AND P.DateJoinedGroup <= @HireDate
		AND ((CONVERT(DATE,P.TerminationDate) > @AsOf AND P.Termination = 1) OR (P.TerminationDate IS NULL AND P.Termination = 0))
		AND ((@Filter = 'None')  OR (((P.EmployeeNum IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Employee Number' AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Employee Number' AND FilterName = @Filter) = 0))
		AND ((C.Division		 IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Division'				AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Division'			 AND FilterName = @Filter) = 0))
		AND ((C.SubDivision		 IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Department'			AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Department'		 AND FilterName = @Filter) = 0))
		AND ((C.SubSubDivision	 IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Section'				AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Section'			 AND FilterName = @Filter) = 0))
		AND ((P.Deptname		 IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'SubSection'			AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'SubSection'		 AND FilterName = @Filter) = 0))
		AND ((P.CostCentre		 IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Cost Centre'			AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Cost Centre'		 AND FilterName = @Filter) = 0))
		AND ((P.EmploymentType	 IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Employment Type'		AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Employee Type'	 AND FilterName = @Filter) = 0))
		AND ((D.OFOCode			 IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Category'				AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Category'			 AND FilterName = @Filter) = 0))
		AND ((D.OFOOccupation	 IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Pay Level'			AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Pay Level'		 AND FilterName = @Filter) = 0))
		AND ((P.PayMode			 IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Pay Mode'				AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Pay Mode'			 AND FilterName = @Filter) = 0))
		AND ((P.JobGrade		 IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Job Grade'			AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Job Grade'		 AND FilterName = @Filter) = 0))
		AND ((P.JobTitle		 IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Job Title'			AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Job Title'		 AND FilterName = @Filter) = 0))
		AND ((P.JobType			 IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Job Type'				AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Job Type'			 AND FilterName = @Filter) = 0))
		AND ((P.MaritialStatus	 IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Civil Status'			AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Civil Status'		 AND FilterName = @Filter) = 0))
		AND ((P.Sex				 IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Sex'					AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Sex'				 AND FilterName = @Filter) = 0))
		AND ((P.Nationality		 IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Nationality'			AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Nationality'		 AND FilterName = @Filter) = 0))
		AND ((D.LocationCategory IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Plant'				AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Plant'			 AND FilterName = @Filter) = 0))
		AND ((A.RATE_CODE		 IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Attendance Rating'	AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Attendance Rating' AND FilterName = @Filter) = 0))
		AND ((P.Surname			 IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Surname'				AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Surname'			 AND FilterName = @Filter) = 0))))
	GROUP BY C.Division, C.SubDivision, C.SubSubDivision, P.EmploymentType, D.OFOCode, D.OFOOccupation, P.EmployeeNum, P.Surname, P.FirstName, P.MiddleName, P.BirthDate, P.JobGrade, P.JobTitle, P.DateJoinedGroup, D.ProbationEndDate, A.Rate_Code, v1.Rate_Code, v2.Rate_Code, v3.Rate_Code, v4.Rate_Code
END
