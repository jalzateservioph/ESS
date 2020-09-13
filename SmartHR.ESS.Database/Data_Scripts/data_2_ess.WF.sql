DECLARE 
	@WFLUID TINYINT,
	@WFID SMALLINT,
	@WFID2 SMALLINT,
	@ActionID TINYINT

-- START: TrainingEvaluation

SELECT @ActionID = ID FROM [ess.ActionLU] WHERE ReportsToType = 'Dummy'

SELECT @WFLUID = ID FROM [ess.WFLU] WHERE WFType = 'Training' AND WFName = 'TrainingEvaluation'

IF NOT EXISTS (SELECT 1 FROM [ess.WF] WHERE ActionID = 0 AND StatusID = 0 AND WFLUID = @WFLUID)
BEGIN
	INSERT INTO [ess.WF] (ActionID, StatusID, WFLUID, PAID, SkipNonExt, ExecNonProc, TaskIDProc)
	VALUES (0, 0, @WFLUID, 0, 0, 0, 'ess.TrainingEvaluationPath')	

	SELECT @WFID = SCOPE_IDENTITY()
END

IF NOT EXISTS (SELECT 1 FROM [ess.WF] WHERE ActionID = @ActionID AND StatusID = 4 AND WFLUID = @WFLUID)
BEGIN
	INSERT INTO [ess.WF] (ActionID, StatusID, WFLUID, PAID, SkipNonExt, ExecNonProc)
	VALUES (@ActionID, 4, @WFLUID, 0, 0, 0)	

	SELECT @WFID2 = SCOPE_IDENTITY()	
END

UPDATE [ess.WF] SET PostActID = @WFID2 WHERE ID = @WFID

UPDATE [ess.WF] SET PostActID = @WFID WHERE ID = @WFID2

-- END: TrainingEvaluation

-- START: TrainingAgreement
SET @WFLUID = NULL
SET	@WFID = NULL
SET	@WFID2 = NULL
SET @ActionID = NULL

SELECT @ActionID = ID FROM [ess.ActionLU] WHERE ReportsToType = 'Training Admin - External'

SELECT @WFLUID = ID FROM [ess.WFLU] WHERE WFType = 'Training' AND WFName = 'TrainingAgreement'

IF NOT EXISTS (SELECT 1 FROM [ess.WF] WHERE ActionID = 0 AND StatusID = 0 AND WFLUID = @WFLUID)
BEGIN
	INSERT INTO [ess.WF] (ActionID, StatusID, WFLUID, PAID, SkipNonExt, ExecNonProc, TaskIDProc)
	VALUES (0, 0, @WFLUID, 0, 0, 0, 'ess.TrainingAgreementPath')	

	SELECT @WFID = SCOPE_IDENTITY()
END

IF NOT EXISTS (SELECT 1 FROM [ess.WF] WHERE ActionID = @ActionID AND StatusID = 4 AND WFLUID = @WFLUID)
BEGIN
	INSERT INTO [ess.WF] (ActionID, StatusID, WFLUID, PAID, SkipNonExt, ExecNonProc)
	VALUES (@ActionID, 4, @WFLUID, 0, 0, 0)	

	SELECT @WFID2 = SCOPE_IDENTITY()	
END

UPDATE [ess.WF] SET PostActID = @WFID2 WHERE ID = @WFID

UPDATE [ess.WF] SET PostActID = @WFID WHERE ID = @WFID2

-- END: TrainingAgreement