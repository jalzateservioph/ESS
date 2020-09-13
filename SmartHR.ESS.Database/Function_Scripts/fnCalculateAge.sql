IF OBJECT_ID('dbo.fnCalculateAge', N'FN') IS NOT NULL
	DROP FUNCTION fnCalculateAge
GO

PRINT N'Creating [dbo].[fnCalculateAge]...';
GO

CREATE FUNCTION [dbo].[fnCalculateAge] 
( @DateOfBirth DATETIME )
RETURNS INT
AS
BEGIN
	DECLARE @Age INT
	
	SET @Age = DATEDIFF(YY,@DateOfBirth,GETDATE()) - (CASE WHEN DATEADD(YY,DATEDIFF(YY,@DateOfBirth,GETDATE()),@DateOfBirth) > GETDATE() THEN 1 ELSE 0 END)
	
	RETURN @Age
END
GO