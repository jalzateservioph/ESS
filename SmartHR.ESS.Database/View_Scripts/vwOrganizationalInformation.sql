-- ======================================= --
--  CREATED BY: RANDOLPH BENJO T. NAANEP   --
--      GURANGO SOFTWARE CORPORATION       --
-- ======================================= --

IF EXISTS(SELECT 1 FROM sys.views WHERE [Name] = 'vwOrganizationalInformation' AND [Type]='V')
	DROP VIEW vwOrganizationalInformation;
GO

PRINT N'Creating [dbo].[vwOrganizationalInformation]...';
GO

CREATE VIEW [dbo].[vwOrganizationalInformation]
AS
	SELECT
		A.[CompanyNum]
	   ,A.[EmployeeNum]
	   ,D.[Division]			AS Division
	   ,D.[SubDivision]			AS Department
	   ,D.[SubSubDivision]		AS Section
	   ,A.[Uniform_Blazer]		AS Blazer
	   ,A.[Uniform_Skirt]		AS Skirt
	   ,A.[Uniform_Blouse]		AS Blouse
	   ,A.[Uniform_Slack]		AS Slacks
	   ,A.[Uniform_Shirtjack]	AS Shirtjack
	   ,A.[Uniform_SJPants]		AS ShirtjackPants
	   ,A.[Uniform_PoloBarong]	AS PoloBarong
	   ,A.[Uniform_RepPants]	AS RepellantPants
	   ,A.[Uniform_PoloShirt]	AS PoloShirt
	   ,A.[Uniform_MaongPants]	AS MaongPants
	   ,A.[Uniform_TShirt]		AS TShirt
	   ,A.[Uniform_Overalls]	AS Overalls
	   ,C.[AttributeValue]		AS ShirtSize
	   ,B.[IndividualJobTitle]	AS JobTitle
	   ,A.[JobTitle]			AS UnionAffiliation
	   ,A.[JobGrade]			AS JobGrade
	   ,A.[CostCentre]			AS CostCentre
	   ,B.[OFOCode]				AS Category
	   ,B.[OFOOccupation]		AS PayLevel
	   ,B.[ShiftType]			AS Shifting
	   ,B.[LocationCategory]	AS WorkAssignment
	   ,A.[DeptName]			AS DeptName
	   ,A.[Skill_Level]			AS Skill_Level
	   ,A.[Appointype]			AS Appointype
	   ,A.[DateJoinedGroup]		AS DateJoinedGroup
	   ,A.[Appointdate]			AS AppointDate
	   ,A.[TerminationDate]		AS TerminationDate
	   ,A.[Termination]			AS Termination
	   ,B.[Fixed]				AS Fixed
	FROM [Personnel]					AS A
		LEFT JOIN [Personnel1]			AS B ON A.CompanyNum = B.CompanyNum AND A.EmployeeNum = B.EmployeeNum
		LEFT JOIN [PersonnelAttribute]	AS C ON A.CompanyNum = C.CompanyNum AND A.EmployeeNum = C.EmployeeNum AND C.AttributeName = 'SHIRT SIZE'
		LEFT JOIN [Company]				AS D ON A.CompanyNum = D.CompanyNum

GO