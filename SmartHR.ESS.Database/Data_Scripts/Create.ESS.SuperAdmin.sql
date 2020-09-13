IF NOT EXISTS(SELECT 1 FROM [UserGroupTemplates] WHERE [Code] = 'SuperAdmin')
	INSERT INTO [dbo].[UserGroupTemplates] ([Code], [Name]) VALUES (N'SuperAdmin', N'SUPER ADMINISTRATOR')

-- jalzate - 03/28/2019
-- questionable. will need to find further references for this.
-- no longer questionable. attached related queries below
UPDATE [ess.Policy] SET [AssemblyID] = 24 WHERE [Key] = 'DEPENDANTS'
-- related queries
UPDATE [ess.Policy] SET Visible = 1, Editable = 0, Required = 0, Approval = 0, ApprovalLevel = 2
UPDATE [ess.Policy] SET AssemblyID = '24' WHERE GroupID = 6 AND AssemblyID = 21
EXEC [ess.Cascade]
-- related queries - end

IF NOT EXISTS(SELECT 1 FROM UserGroupTemplateRights WHERE [Code] = 'SuperAdmin')
BEGIN
    INSERT INTO UserGroupTemplateRights
	SELECT 'SuperAdmin', [DataElement], [fView], [fAdd], [fEdit], [fDelete], [fPrint], [ExcludeUGFlag], [Category]
    FROM [dbo].[UserGroupTemplateRights] 
    WHERE Code = 'Admin'
END

IF NOT EXISTS(SELECT 1 FROM ReportsTo WHERE ReportToCompNum = '101230' and ReportToEmpNum = '011656' and ReportsToType = 'HR Manager')
BEGIN
    INSERT INTO ReportsTo SELECT CompanyNum, EmployeeNum, '101230', '011656', 'HR Manager', NULL 
	FROM ReportsTo 
	WHERE ReportsToType = 'Manager'
END

GO