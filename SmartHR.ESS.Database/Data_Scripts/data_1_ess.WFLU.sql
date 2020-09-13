IF NOT EXISTS (SELECT 1 FROM [ess.WFLU] WHERE WFName = 'TrainingEvaluation' AND WFType = 'Training')
BEGIN
	INSERT INTO [ess.WFLU] (WFName, WFType)
	VALUES ('TrainingEvaluation', 'Training')
END

IF NOT EXISTS (SELECT 1 FROM [ess.WFLU] WHERE WFName = 'TrainingAgreement' AND WFType = 'Training')
BEGIN
	INSERT INTO [ess.WFLU] (WFName, WFType)
	VALUES ('TrainingAgreement', 'Training')
END
GO