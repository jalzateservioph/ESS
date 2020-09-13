--CREATE FIELD FOR Awards Text 
IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'Qualifications'
         AND COLUMN_NAME = 'Awards'
) 
BEGIN
	--Create the field
	ALTER TABLE [Qualifications] ADD Awards NVARCHAR(300);
END

--CREATE FIELD FOR Awards Text 
IF NOT EXISTS (
  SELECT *
  FROM   INFORMATION_SCHEMA.COLUMNS
  WHERE  TABLE_NAME = 'Qualifications'
         AND COLUMN_NAME = 'Course'
) 
BEGIN
	--Create the field
	ALTER TABLE [Qualifications] ADD Course NVARCHAR(100);
END