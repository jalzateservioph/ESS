IF NOT EXISTS (SELECT 1 FROM [ess.ActionLU] WHERE ReportsToType = 'Training Admin - External')
BEGIN
	INSERT INTO [ess.ActionLU] (ReportsToType)
	VALUES ('Training Admin - External')
END
GO