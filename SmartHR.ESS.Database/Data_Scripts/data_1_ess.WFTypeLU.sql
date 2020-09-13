IF NOT EXISTS (SELECT 1 FROM [ess.WFTypeLU] WHERE WFType = 'Training' AND Tablename = 'TrainingEvaluation')
BEGIN
	INSERT INTO [ess.WFTypeLU] (WFType, Tablename)
	VALUES ('Training', 'TrainingEvaluation')
END

IF NOT EXISTS (SELECT 1 FROM [ess.WFTypeLU] WHERE WFType = 'Training' AND Tablename = 'TrainingAgreement')
BEGIN
	INSERT INTO [ess.WFTypeLU] (WFType, Tablename)
	VALUES ('Training', 'TrainingAgreement')
END
GO