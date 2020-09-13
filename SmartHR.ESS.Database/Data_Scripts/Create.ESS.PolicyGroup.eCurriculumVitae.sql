IF NOT EXISTS(SELECT 1 FROM [dbo].[ess.Policy] WHERE [Name] = N'eCurriculumVitae') 
BEGIN
    INSERT INTO [dbo].[ess.PolicyGroups] ([Name], [Description]) VALUES (N'eCurriculumVitae', N'This group policy is used for all curriculum vitae policy configurations.')
END
GO