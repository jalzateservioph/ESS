--DELETE FIELD FOR Objectives1 Text
IF EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TAFProgramDetails'
         AND COLUMN_NAME = 'Objectives1'
) 
BEGIN
	--Delete the field
	ALTER TABLE TAFProgramDetails DROP COLUMN Objectives1
END

--DELETE FIELD FOR Objectives2 Text 
IF EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TAFProgramDetails'
         AND COLUMN_NAME = 'Objectives2'
) 
BEGIN
	--Delete the field
	ALTER TABLE TAFProgramDetails DROP COLUMN Objectives2
END

--DELETE FIELD FOR Objectives3 Text 
IF EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TAFProgramDetails'
         AND COLUMN_NAME = 'Objectives3'
) 
BEGIN
	--Delete the field
	ALTER TABLE TAFProgramDetails DROP COLUMN Objectives3
END

--DELETE FIELD FOR Justification1 Text 
IF EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TAFProgramDetails'
         AND COLUMN_NAME = 'Justification1'
) 
BEGIN
	--Delete the field
	ALTER TABLE TAFProgramDetails DROP COLUMN Justification1
END

--DELETE FIELD FOR Justification2 Text 
IF EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TAFProgramDetails'
         AND COLUMN_NAME = 'Justification2'
) 
BEGIN
	--Delete the field
	ALTER TABLE TAFProgramDetails DROP COLUMN Justification2
END

--DELETE FIELD FOR Justification3 Text 
IF EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'TAFProgramDetails'
         AND COLUMN_NAME = 'Justification3'
) 
BEGIN
	--Delete the field
	ALTER TABLE TAFProgramDetails DROP COLUMN Justification3
END