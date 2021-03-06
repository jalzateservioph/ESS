/****** Object:  StoredProcedure [dbo].[prPerformanceSP]    Script Date: 3/22/2019 12:09:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ======================================= --
--  CREATED BY : EROS NIKO CAS ALVAREZ	   --
--  UPDATED BY : JESSICA CASUPANAN		   --
--  UPDATED BY : RANDOLPH BENJO T. NAANEP  --
--      LAST UPDATE : 2017-09-26 10:30     --
-- ======================================= --

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[prPerformanceSP]') AND OBJECTPROPERTY(ID, N'ISPROCEDURE') = 1)
BEGIN
	PRINT 'Dropping Procedure [prPerformanceSP]'
	DROP PROCEDURE [dbo].[prPerformanceSP]	
END

PRINT N'Creating [dbo].[prPerformanceSP]...';
GO

CREATE PROCEDURE [dbo].[prPerformanceSP]
	@YEARS	  INT
   ,@JUN	  INT -- YEAR END (1)
   ,@DEC	  INT -- MID YEAR (1)
   ,@HIREDATE DATETIME
   ,@ASOF	  DATETIME
   ,@FILTER	  VARCHAR(200)
   ,@FullName VARCHAR(100)
AS
BEGIN
	SELECT DISTINCT
		[Division]			= COALESCE((RIGHT(C.Division,(CASE WHEN LEN(C.Division)-4 > 0 THEN LEN(C.Division)-4 ELSE LEN(C.Division) END))),' ')
		,[Employment Type]	= COALESCE((CASE WHEN DATEADD(DAY,1,p2.ProbationEndDate) <= @ASOF THEN 'REGULAR' ELSE p1.EmploymentType END),' ')
		,[Category]			= (CASE WHEN p2.OFOCode = 'MANAGER' THEN '1' WHEN p2.OFOCode = 'GENERAL STAFF' THEN '2' WHEN p2.OFOCode = 'LINE' THEN '3' WHEN p2.OFOCode = 'OFFICE STAFF' THEN '4' WHEN p2.OFOCode = 'SPECIAL STAFF' THEN '5' ELSE '0' END) + ' ' + COALESCE(P2.OFOCode,' ')
		,[Employee Number]	= p1.EmployeeNum
		,[Full Name]			= p1.Surname + ', ' + p1.FirstName + ' ' + coalesce((LEFT(p1.MIDDLENAME,(CASE WHEN LEN(p1.MIDDLENAME)>0  AND p1.MIDDLENAME LIKE '%[a-z]' THEN 1 END)))+'.',' ') 
		,[Age]				= CAST(ROUND((DATEDIFF(DAY,p1.BirthDate,GETDATE())/365.25),2) AS DECIMAL(10,2))
		--JGC 08252016 ADDED Department Field
		--JGC 10072016 MODIFIED Department Field
		,[Department]		= COALESCE(C.SubDivision,'-') + ' / ' + COALESCE(C.SubSubDivision,'-')
		-- 
		,[Degree]			= STUFF((SELECT '?' + ISNULL(Degree,'-') +
							(CASE WHEN LEN(Degree) <= 28 THEN (CASE WHEN LEN(Institution) > 66 THEN '???' ELSE (CASE WHEN LEN(Institution) > 33 THEN '??' ELSE '?' END) END)
									ELSE (CASE WHEN LEN(Degree) <= 56 THEN (CASE WHEN LEN(Institution) > 66 THEN '??' ELSE (CASE WHEN LEN(Institution) > 33 THEN '?' ELSE '' END) END) ELSE '?' END) END)
							AS [text()] FROM vwQualifications WHERE EmployeeNum = P1.EmployeeNum ORDER BY [From-To] DESC FOR XML PATH('')),1,1,'')
		,[School]			= REPLACE(STUFF((SELECT '?' + ISNULL(Institution,'-') +
							(CASE WHEN LEN(Institution) <= 33 THEN (CASE WHEN LEN(Degree) > 56 THEN '???' ELSE (CASE WHEN LEN(Degree) > 28 THEN '??' ELSE '?' END) END)
									ELSE (CASE WHEN LEN(Institution) <= 66 THEN (CASE WHEN LEN(Degree) > 56 THEN '??' ELSE (CASE WHEN LEN(Degree) > 28 THEN '?' ELSE '' END) END) ELSE '?' END) END)
							AS [text()] FROM vwQualifications WHERE EmployeeNum = P1.EmployeeNum ORDER BY [From-To] DESC FOR XML PATH('')),1,1,''),'&amp;','AND')
		,[From - To]			= STUFF((SELECT '?' + [From-To] + (CASE WHEN LEN(Degree) > 60 OR LEN(Institution) > 60 THEN '???' ELSE (CASE WHEN LEN(Degree) > 28 OR LEN(Institution) > 33 THEN '??' ELSE '?' END) END) AS [text()] FROM vwQualifications WHERE EmployeeNum = P1.EmployeeNum ORDER BY [From-To] DESC FOR XML PATH('')),1,1,'')
		,[Date Hired]		= p1.DateJoinedGroup
		,[HR]				= CAST(ROUND((DATEDIFF(DAY,p1.DateJoinedGroup,GETDATE())/365.25),2) AS DECIMAL(10,2))
		,[Reg`Tn Date]		= DATEADD(DAY,1,p2.ProbationEndDate)
		,[RD]				= (CASE WHEN DATEADD(DAY,1,p2.ProbationEndDate) > GETDATE() THEN '-' ELSE convert(varchar(10),CAST(ROUND((DATEDIFF(DAY,p2.ProbationEndDate,GETDATE())/365.25),2) AS DECIMAL(10,2))) END)
		,[Grade]				= p1.JobGrade
		,[1]					= '`'
		,[2]					= '`'
		,[3 70%]				= '`'
		,[4 20%]				= '`'
		,[5 10%]				= '`'
		-- JGC 08262016 ADDED COALESCE CONDITION
		,[First]				= COALESCE(v1.Rate_Code,'-')
		,[Second]			= COALESCE(v2.Rate_Code,'-')
		,[Third]				= COALESCE(v3.Rate_Code,'-')
		,[Fourth]			= COALESCE(v4.Rate_Code,'-')
		,[Fifth]				= COALESCE(v5.Rate_Code,'-')
		,[Sixth]				= COALESCE(v6.Rate_Code,'-')
		,[Seventh]			= COALESCE(v7.Rate_Code,'-')
		,[Job Title]			= p1.JobTitle
		--JGC 10072016 MODIFIED PAYLEVEL FOR ORDERING
		,[PayLevel]			= COALESCE((case when (len(p2.OFOOccupation) < 2 and isnumeric(p2.OFOOccupation) = 1) or (len(p2.OFOOccupation) < 3 and ISNUMERIC(RIGHT(p2.OFOOccupation,1))= 0) then '0' + p2.OFOOccupation else p2.OFOOccupation end ),'')
		,[Attendance]		= COALESCE(a.Rate_Code,0)
		--
		-- JGC ADDED REMARKS ON CONDITION
		,[Promotion H]		= REPLACE(STUFF((SELECT '#' + CONVERT(VARCHAR(10),EffectiveFrom,110) AS [text()] FROM (SELECT DISTINCT EffectiveFrom AS [EffectiveFrom] FROM PersonnelHistoryLog WHERE Remarks LIKE '%PROMOTION%' AND EmployeeNum = P1.EmployeeNum AND ActionDescription IN ('Individual Job Title','Job Title','OFO Code','OFO Occupation','Pay Level')) X ORDER BY EffectiveFrom DESC FOR XML PATH('')),1,1,''),'-','/')
		--STUFF((SELECT '#' + (CAST(YEAR(StartDate) AS VARCHAR(4)) + ' - ' + CAST(YEAR(DateObtained) AS VARCHAR(4))) AS [text()] FROM Qualifications WHERE EmployeeNum = P1.EmployeeNum ORDER BY StartDate ASC FOR XML PATH('')),1,1,'')
		--substring((Select ','+(CONVERT(VARCHAR, EffectiveFrom , 101)) From dbo.PersonnelHistoryLog ST1 Where ST1.employeenum = p1.employeenum and ST1.effectivefrom is not null and ST1.Remarks = 'PROMOTION' and(ActionDescription = 'Individual Job Title' OR ActionDescription = 'JOB TITLE' OR  ActionDescription = 'Pay level'  OR ActionDescription = 'OFO OCCUPATION'  OR ActionDescription = 'OFO CODE')group by ST1.effectivefrom ORDER BY EffectiveFrom DESC For XML PATH ('')), 2, 10000)
	FROM Personnel p1
		LEFT JOIN Personnel1	 p2 ON p1.EmployeeNum = p2.EmployeeNum
		LEFT JOIN Company		 c	ON p1.CompanyNum  = c.CompanyNum 					
		--LEFT JOIN Qualifications q	ON p1.EmployeeNum = q.EmployeeNum
		-- JGC 08252016 CHANGE @YEARS-1 = @YEARS
		--LEFT JOIN (SELECT Man_No, Rate_Code FROM (SELECT ROW_NUMBER() OVER (PARTITION BY Man_No ORDER BY ID DESC) AS RN, * FROM prPerformance WHERE DATEPART(YEAR,PERIOD_FROM) = (@Years) AND Rate_Type = 'Attendance') AS xKey WHERE RN = 1) AS a  ON p1.EmployeeNum = a.Man_No
		LEFT JOIN (
			SELECT
				Man_No,
				Rate_Code
			FROM
				(
					SELECT
						ROW_NUMBER() OVER (
							PARTITION BY Man_No
							ORDER BY
								ID DESC
						) AS RN,
						*
					FROM
						prPerformance
					WHERE
						Rate_Type = 'Attendance'
						AND (
							(
								@DEC = 1
								AND PERIOD_FROM = cast(cast((@YEARS-1)*10000 + 7*100 + 1 as varchar(255)) as date)
								AND PERIOD_TO = cast(cast((@YEARS-1)*10000 + 12*100 + 31 as varchar(255)) as date)
							)
							OR (
								@JUN = 1
								AND PERIOD_FROM = cast(cast(@YEARS*10000 + 1*100 + 1 as varchar(255)) as date)
								AND PERIOD_TO = cast(cast(@YEARS*10000 + 6*100 + 30 as varchar(255)) as date)
							)
						)
				) AS xKey
			WHERE
				RN = 1
		) AS a ON p1.EmployeeNum = a.Man_No
		--
		LEFT JOIN (SELECT Man_No, Rate_Code FROM (SELECT ROW_NUMBER() OVER (PARTITION BY Man_No ORDER BY ID DESC) AS RN, * FROM prPerformance WHERE DATEPART(YEAR,PERIOD_FROM) = (@Years - 4) AND Rate_Type = 'MidYear') AS xKey WHERE RN = 1) AS v1 ON p1.EmployeeNum = v1.Man_No
		LEFT JOIN (SELECT Man_No, Rate_Code FROM (SELECT ROW_NUMBER() OVER (PARTITION BY Man_No ORDER BY ID DESC) AS RN, * FROM prPerformance WHERE DATEPART(YEAR,PERIOD_FROM) = (@Years - 3) AND Rate_Type = 'YearEnd') AS xKey WHERE RN = 1) AS v2 ON p1.EmployeeNum = v2.Man_No
		LEFT JOIN (SELECT Man_No, Rate_Code FROM (SELECT ROW_NUMBER() OVER (PARTITION BY Man_No ORDER BY ID DESC) AS RN, * FROM prPerformance WHERE DATEPART(YEAR,PERIOD_FROM) = (@Years - 3) AND Rate_Type = 'MidYear') AS xKey WHERE RN = 1) AS v3 ON p1.EmployeeNum = v3.Man_No
		LEFT JOIN (SELECT Man_No, Rate_Code FROM (SELECT ROW_NUMBER() OVER (PARTITION BY Man_No ORDER BY ID DESC) AS RN, * FROM prPerformance WHERE DATEPART(YEAR,PERIOD_FROM) = (@Years - 2) AND Rate_Type = 'YearEnd') AS xKey WHERE RN = 1) AS v4 ON p1.EmployeeNum = v4.Man_No
		LEFT JOIN (SELECT Man_No, Rate_Code FROM (SELECT ROW_NUMBER() OVER (PARTITION BY Man_No ORDER BY ID DESC) AS RN, * FROM prPerformance WHERE DATEPART(YEAR,PERIOD_FROM) = (@Years - 2) AND Rate_Type = 'MidYear') AS xKey WHERE RN = 1) AS v5 ON p1.EmployeeNum = v5.Man_No
		LEFT JOIN (SELECT Man_No, Rate_Code FROM (SELECT ROW_NUMBER() OVER (PARTITION BY Man_No ORDER BY ID DESC) AS RN, * FROM prPerformance WHERE DATEPART(YEAR,PERIOD_FROM) = (@Years - 1) AND Rate_Type = 'YearEnd') AS xKey WHERE RN = 1) AS v6 ON p1.EmployeeNum = v6.Man_No
		-- JGC 08252016 CHANGE @YEARS = @YEARS -1
		LEFT JOIN (SELECT Man_No, Rate_Code FROM (SELECT ROW_NUMBER() OVER (PARTITION BY Man_No ORDER BY ID DESC) AS RN, * FROM prPerformance WHERE DATEPART(YEAR,PERIOD_FROM) = (@Years - 1)  AND Rate_Type = 'MidYear') AS xKey WHERE RN = 1) AS v7 ON p1.EmployeeNum = v7.Man_No
		--
	WHERE
		((p1.DateJoinedGroup <= @HireDate and ((convert(date,p1.TerminationDate) > @ASOF and p1.termination=1 ) or (p1.TerminationDate is null and p1.termination=0)))and p2.OFOCode<>'STUDENT TRAINEE' and p1.companynum <> 'Applicants' and p1.companynum <> 'DataMigration' and p1.companynum <> 'Temporary' and p1.companynum <> 'unallocated') AND ((@Filter = 'None') OR (
		((p1.EmployeeNum		IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Employee Number' AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Employee Number' AND FilterName = @Filter) = 0))
	AND ((p1.CostCentre			IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Cost Centre'	  AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Cost Centre'	 AND FilterName = @Filter) = 0))
	AND ((p1.EmploymentType		IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Employment Type' AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Employee Type'	 AND FilterName = @Filter) = 0))
	AND ((p1.PayMode			IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Pay Mode'		  AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Pay Mode'		 AND FilterName = @Filter) = 0))
	AND ((p1.JobType			IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Job Type'		  AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Job Type'		 AND FilterName = @Filter) = 0))
	AND ((p1.JobTitle			IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Job Title'		  AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Job Title'		 AND FilterName = @Filter) = 0))
	AND ((p1.JobGrade			IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Job Grade'		  AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Job Grade'		 AND FilterName = @Filter) = 0))
	AND ((p1.Nationality		IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Nationality'	  AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Nationality'	 AND FilterName = @Filter) = 0))
	AND ((p1.MaritialStatus		IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Civil Status'	  AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Civil Status'	 AND FilterName = @Filter) = 0))
	AND ((p1.Sex				IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Sex'			  AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Sex'			 AND FilterName = @Filter) = 0))
	AND ((p1.Deptname			IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Subsection'	  AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Subsection'	     AND FilterName = @Filter) = 0))
	AND ((p1.Surname			like '['+(SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Surname'	  AND FilterName = @Filter)+']%')or((select count(*) from prCustomFilter WHERE FilterColumn = 'Surname' AND FilterName = @Filter) = 0))
	AND ((a.Rate_code			IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Attendance Rating'	AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Attendance Rating' AND FilterName = @Filter) = 0))
	AND ((c.Division			IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Division'		  AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Division'		 AND FilterName = @Filter) = 0))
	AND ((c.SubDivision			IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Department'	  AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Department'		 AND FilterName = @Filter) = 0))
	AND ((c.SubSubDivision		IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Section'		  AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Section'		 AND FilterName = @Filter) = 0))
	AND ((p2.OFOOccupation   	IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Pay Level'		  AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Pay Level'		 AND FilterName = @Filter) = 0))
	AND ((p2.ofocode        	IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Category'		  AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Category'		 AND FilterName = @Filter) = 0))
	AND ((p2.LocationCategory	IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Plant'		      AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Plant'		     AND FilterName = @Filter) = 0))
	--AND ((q.Institution			IN (SELECT Filters FROM prCustomFilter WHERE FilterColumn = 'Institution'	  AND FilterName = @Filter)) OR ((SELECT COUNT(*) FROM prCustomFilter WHERE FilterColumn = 'Institution'	 AND FilterName = @Filter) = 0))
	)) GROUP BY p1.EmployeeNum,		   p1.Surname,			p1.FirstName,		p1.MiddleName,			p1.JobGrade, 
				p1.JobTitle,		   p1.EmploymentType,   p1.DateJoinedGroup, p1.BirthDate,           p1.MaritialStatus, 
				p2.ofocode, p2.ProbationEndDate, p2.OFOOccupation, 
				c.Division, c.SubSubDivision,
				--q.Institution,		   q.Course,			q.StartDate,		q.DateObtained,
				a.Rate_Code, v1.Rate_Code, v2.Rate_Code, v3.Rate_Code, v4.Rate_Code, v5.Rate_Code, v6.Rate_Code, v7.Rate_Code
				--JGC 08252016
				,c.SubDivision
				--,
				ORDER BY [Division], [Category], [PayLevel] desc;
END