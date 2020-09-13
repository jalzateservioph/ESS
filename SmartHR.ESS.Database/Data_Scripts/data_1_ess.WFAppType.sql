IF NOT EXISTS (SELECT 1 FROM [ess.WFAppType] WHERE AppType = 'Evaluation' AND WFType = 'Training')
BEGIN
	INSERT INTO [ess.WFAppType] (AppType, WFType, WFName)
	VALUES ('Evaluation', 'Training', 'TrainingEvaluation')
END

IF NOT EXISTS (SELECT 1 FROM [ess.WFAppType] WHERE AppType = 'Agreement' AND WFType = 'Training')
BEGIN
	INSERT INTO [ess.WFAppType] (AppType, WFType, WFName)
	VALUES ('Agreement', 'Training', 'TrainingAgreement')
END
GO