--CREATE FIELD FOR RemainingBudget Real
IF NOT EXISTS (
	SELECT	*
	FROM	INFORMATION_SCHEMA.COLUMNS
	WHERE	TABLE_NAME = 'TrainingExternalBudget'
			AND COLUMN_NAME = 'RemainingBudget'
)
BEGIN
	--Create the field
	ALTER TABLE TrainingExternalBudget ADD RemainingBudget [decimal](23,2);
END

--CHANGE FIELD FOR Budget Real
IF EXISTS (
	SELECT	*
	FROM	INFORMATION_SCHEMA.COLUMNS
	WHERE	TABLE_NAME = 'TrainingExternalBudget'
			AND COLUMN_NAME = 'Budget'
)
BEGIN
	--ALTER the field
	ALTER TABLE TrainingExternalBudget ALTER COLUMN Budget [decimal](23,2);
END

--CREATE FIELD FOR DateTransferred Date
IF NOT EXISTS (
	SELECT	*
	FROM	INFORMATION_SCHEMA.COLUMNS
	WHERE	TABLE_NAME = 'TrainingExternalBudget'
			AND COLUMN_NAME = 'DateTransferred'
)
BEGIN
	--Create the field
	ALTER TABLE TrainingExternalBudget ADD DateTransferred DateTime NULL;
END

--CREATE FIELD FOR AmountTransferred Real
IF NOT EXISTS (
	SELECT	*
	FROM	INFORMATION_SCHEMA.COLUMNS
	WHERE	TABLE_NAME = 'TrainingExternalBudget'
			AND COLUMN_NAME = 'AmountTransferred'
)
BEGIN
	--Create the field
	ALTER TABLE TrainingExternalBudget ADD AmountTransferred real NULL;
END