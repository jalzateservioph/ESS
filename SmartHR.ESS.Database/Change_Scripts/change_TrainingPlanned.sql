IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfType'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfType [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfProgramType'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfProgramType [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfInvestment'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfInvestment [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfInvestmentUSD'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfInvestmentUSD [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfExistingStart'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfExistingStart [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfDuration'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfDuration [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfExpiry'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfExpiry [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfCELastDay'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfCELastDay [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfCEDateToday'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfCEDateToday [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfContractCompletion'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfContractCompletion [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfContractStatus'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfContractStatus [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfSeparationDate'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfSeparationDate [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfCESeparation'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfCESeparation [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfMonthsUnserved'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfMonthsUnserved [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfUnservedContract'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfUnservedContract [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfPenalty'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfPenalty [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfDateReceived'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfDateReceived [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfBudgetCode'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfBudgetCode [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfBudgetCategory'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfBudgetCategory [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfRFPNum'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfRFPNum [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfSAPDocNum'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfSAPDocNum [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfDivision'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfDivision [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfDepartment'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfDepartment [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfSection'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfSection [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfLevel'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfLevel [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfDesignation'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfDesignation [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfSubCategory'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfSubCategory [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfCertificate'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfCertificate [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfTrainingMaterial'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfTrainingMaterial [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfPlannedEcho'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfPlannedEcho [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfActualEcho'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfActualEcho [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfPlannedPaxEcho'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfPlannedPaxEcho [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfActualPaxEcho'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfActualPaxEcho [nvarchar](50) NULL;
END

IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingPlanned'
         AND COLUMN_NAME = 'cfLateRegistration'
) 
BEGIN
	ALTER TABLE TrainingPlanned ADD cfLateRegistration [nvarchar](50) NULL;
END