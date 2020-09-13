--CREATE FIELD FOR PathID Text 
IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'PathID'
) 
BEGIN
	--Create the field
	ALTER TABLE TrainingCompleted ADD PathID [bigint];
END

--CREATE FIELD FOR CapturedByUsername Text 
IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'CapturedByUsername'
) 
BEGIN
	--Create the field
	ALTER TABLE TrainingCompleted ADD CapturedByUsername [nvarchar] (20);
END

--CREATE FIELD FOR CapturedOn Text 
IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'CapturedOn'
) 
BEGIN
	--Create the field
	ALTER TABLE TrainingCompleted ADD CapturedOn DateTime;
END


--CREATE FIELD FOR Custom Fields!
IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfType'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfType [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfProgramType'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfProgramType [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfInvestment'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfInvestment [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfInvestmentUSD'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfInvestmentUSD [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfExistingStart'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfExistingStart [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfDuration'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfDuration [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfExpiry'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfExpiry [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfCELastDay'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfCELastDay [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfCEDateToday'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfCEDateToday [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfContractCompletion'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfContractCompletion [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfContractStatus'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfContractStatus [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfSeparationDate'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfSeparationDate [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfCESeparation'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfCESeparation [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfMonthsUnserved'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfMonthsUnserved [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfUnservedContract'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfUnservedContract [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfPenalty'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfPenalty [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfBudgetCode'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfBudgetCode [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfBudgetCategory'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfBudgetCategory [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfRFPNum'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfRFPNum [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfSAPDocNum'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfSAPDocNum [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfDivision'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfDivision [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfDateReceived'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfDateReceived [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfSection'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfSection [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfLevel'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfLevel [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfDesignation'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfDesignation [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfSubCategory'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfSubCategory [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfLateRegistration'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfLateRegistration [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfCertificate'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfCertificate [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfTrainingMaterial'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfTrainingMaterial [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfPlannedEcho'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfPlannedEcho [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfActualEcho'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfActualEcho [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfPlannedPaxEcho'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfPlannedPaxEcho [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfActualPaxEcho'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfActualPaxEcho [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfDepartment'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfDepartment [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfICTType'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfICTType [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfCategory'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfCategory [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfSOA'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfSOA [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfExtension'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfExtension [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfEOAP'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfEOAP [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfEOAA'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfEOAA [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfDurationOIAP'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfDurationOIAP [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfDurationOIAA'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfDurationOIAA [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfActive'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfActive [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfLocation'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfLocation [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfHomeCompany'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfHomeCompany [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfHomeDivision'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfHomeDivision [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfHomeDepartment'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfHomeDepartment [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfHomeSection'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfHomeSection [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfHostCompany'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfHostCompany [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfHostDivision'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfHostDivision [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfHostDepartment'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfHostDepartment [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfHostSection'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfHostSection [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfFirstWD'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfFirstWD [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfLastWD'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfLastWD [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfHostContactHC'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfHostContactHC [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfHostContactRes'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfHostContactRes [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfHostAddress'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfHostAddress [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfHostAEmail'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfHostAEmail [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfHostPEmail'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfHostPEmail [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfHomeContactHC'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfHomeContactHC [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfHomeContactRes'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfHomeContactRes [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfHomeAddress'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfHomeAddress [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfHomePEmail'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfHomePEmail [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfHomeAEmail'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfHomeAEmail [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfStartOSC'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfStartOSC [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfEndOSC'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfEndOSC [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfLengthOSC'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfStatusOSC [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingCompleted'
         AND COLUMN_NAME = 'cfLengthOSC'
) 
BEGIN
	ALTER TABLE TrainingCompleted ADD cfLengthOSC [nvarchar](50) NULL;
END