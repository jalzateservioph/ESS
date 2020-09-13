IF NOT EXISTS(SELECT 1 FROM TableLU WHERE [Query] = ('--SELECT ''Added By '' + ISNULL(LTRIM(RTRIM(B.Surname)),'''') + '', '' + ISNULL(LTRIM(RTRIM(B.FirstName)),'''') + '' '' + ISNULL(LTRIM(RTRIM(B.MiddleName)),'''') + '' : '' + CONVERT(NVARCHAR(36),A.Remarks) AS [Remarks] FROM [ess.WFRemarks] AS A LEFT JOIN [Personnel] AS B ON A.CompanyNum = B.CompanyNum AND A.EmployeeNum = B.EmployeeNum WHERE (A.[PathID] = <%PathID%>) ORDER BY A.CaptureDate ASC') )
    INSERT INTO TableLU (Query) VALUES ('--SELECT ''Added By '' + ISNULL(LTRIM(RTRIM(B.Surname)),'''') + '', '' + ISNULL(LTRIM(RTRIM(B.FirstName)),'''') + '' '' + ISNULL(LTRIM(RTRIM(B.MiddleName)),'''') + '' : '' + CONVERT(NVARCHAR(36),A.Remarks) AS [Remarks] FROM [ess.WFRemarks] AS A LEFT JOIN [Personnel] AS B ON A.CompanyNum = B.CompanyNum AND A.EmployeeNum = B.EmployeeNum WHERE (A.[PathID] = <%PathID%>) ORDER BY A.CaptureDate ASC') 

UPDATE [TableLU] 
SET Query = '--SELECT [Label] AS [Item], [ValueF] AS [From], [ValueT] AS [To] FROM [ess.Change] AS [c] LEFT OUTER JOIN [ess.Policy] AS [p] ON [c].[PolicyID] = [p].[ID] WHERE ([PathID] = <%PathID%> AND [Level] > 0) ORDER BY [PolicyID]' 
WHERE ID = 1;

UPDATE [TableLU] 
SET Query = '--SELECT [m].[ItemName] AS [Item], [c].[ValueF] AS [From], [c].[ValueT] AS [To] FROM [ess.Change] AS [c] LEFT OUTER JOIN [ess.Policy] AS [p] ON [c].[PolicyID] = [p].[ID] LEFT OUTER JOIN [ess.PolicyMapping] AS [m] ON [p].[ID] = [m].[PolicyID] WHERE ([Level] = 0 AND [PathID] = <%PathID%>) ORDER BY [c].[PolicyID]' 
WHERE ID = 11;

UPDATE TableLU SET Query = N'--SELECT [Label] AS [Item], [ValueF] AS [From], [ValueT] AS [To] FROM (SELECT *, NULL AS ActionedBy FROM [ess.Change] WHERE PathID <> <%PathID%> UNION SELECT * FROM [ess.Reject]) AS [c] LEFT OUTER JOIN [ess.Policy] AS [p] ON [c].[PolicyID] = [p].[ID] WHERE ([PathID] = <%PathID%>) ORDER BY [PolicyID]'
WHERE ID = 3;
GO