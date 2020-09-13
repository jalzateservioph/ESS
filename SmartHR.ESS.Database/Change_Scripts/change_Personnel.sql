--CREATE FIELD FOR CityOfBirth Text 
IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'Personnel'
         AND COLUMN_NAME = 'CityOfBirth'
) 
BEGIN
	--Create the field
	ALTER TABLE [Personnel] ADD CityOfBirth NVARCHAR(50);
END

--CREATE FIELD FOR ExemptionClaim Text 
IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'Personnel'
         AND COLUMN_NAME = 'ExemptionClaim'
) 
BEGIN
	--Create the field
	ALTER TABLE [Personnel] ADD ExemptionClaim SMALLINT;
END