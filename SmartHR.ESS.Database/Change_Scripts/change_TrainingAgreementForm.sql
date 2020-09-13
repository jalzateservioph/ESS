--CREATE FIELD FOR Objectives1 Text 
IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingAgreementForm'
         AND COLUMN_NAME = 'Objectives1'
) 
BEGIN
	--Create the field
	ALTER TABLE TrainingAgreementForm ADD Objectives1 [nvarchar](255);
END

--CREATE FIELD FOR Objectives2 Text 
IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingAgreementForm'
         AND COLUMN_NAME = 'Objectives2'
) 
BEGIN
	--Create the field
	ALTER TABLE TrainingAgreementForm ADD Objectives2 [nvarchar](255);
END

--CREATE FIELD FOR Objectives3 Text 
IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingAgreementForm'
         AND COLUMN_NAME = 'Objectives3'
) 
BEGIN
	--Create the field
	ALTER TABLE TrainingAgreementForm ADD Objectives3 [nvarchar](255);
END

--CREATE FIELD FOR Justification1 Text 
IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingAgreementForm'
         AND COLUMN_NAME = 'Justification1'
) 
BEGIN
	--Create the field
	ALTER TABLE TrainingAgreementForm ADD Justification1 [nvarchar](255);
END

--CREATE FIELD FOR Justification2 Text 
IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingAgreementForm'
         AND COLUMN_NAME = 'Justification2'
) 
BEGIN
	--Create the field
	ALTER TABLE TrainingAgreementForm ADD Justification2 [nvarchar](255);
END

--CREATE FIELD FOR Justification3 Text 
IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingAgreementForm'
         AND COLUMN_NAME = 'Justification3'
) 
BEGIN
	--Create the field
	ALTER TABLE TrainingAgreementForm ADD Justification3 [nvarchar](255);
END

--CREATE FIELD FOR Category Text 
IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingAgreementForm'
         AND COLUMN_NAME = 'Category'
) 
BEGIN
	--Create the field
	ALTER TABLE TrainingAgreementForm ADD Category [nvarchar](100);
END

--CREATE FIELD FOR BudgetCode Text 
IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingAgreementForm'
         AND COLUMN_NAME = 'BudgetCode'
) 
BEGIN
	--Create the field
	ALTER TABLE TrainingAgreementForm ADD BudgetCode [nvarchar](100);
END

--CREATE FIELD FOR BeginningBalance Text 
IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingAgreementForm'
         AND COLUMN_NAME = 'BeginningBalance'
) 
BEGIN
	--Create the field
	ALTER TABLE TrainingAgreementForm ADD BeginningBalance [nvarchar](100);
END

--CREATE FIELD FOR EndingBalance Text 
IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TrainingAgreementForm'
         AND COLUMN_NAME = 'EndingBalance'
) 
BEGIN
	--Create the field
	ALTER TABLE TrainingAgreementForm ADD EndingBalance [nvarchar](100);
END