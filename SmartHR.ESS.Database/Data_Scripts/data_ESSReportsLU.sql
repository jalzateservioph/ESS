/*
	Created By: Joshua Alzate
	Created On: 04/12/2019
	Description: Creates ess.ReportsLU values in the database
	
	Changes:
		Modified By: 
		Modified On:
		Description
*/
IF NOT EXISTS(
	SELECT 1 FROM [ess.ReportsLU] 
	WHERE Title = 'Training Evaluation - External' AND 
	[Path] = 'reports/training_eval_external.rdl')
BEGIN
	INSERT INTO [ess.ReportsLU]
	([Title], [Path], [SQL])
	VALUES(
	'Training Evaluation - External',
	'reports/training_eval_external.rdl',
	'SELECT
		TEE.Provider, 
		TEE.CourseName, 
		SpeakerName, 
		DateFrom = CONVERT(DATETIME, 
			CONVERT(VARCHAR(10), ISNULL(TAD.DateFrom, TEE.TrainingDate), 101) + '' '' + 
			ISNULL(CONVERT(VARCHAR(10), TAD.DateFrom, 108), ''00:00:00.000'')), 
		DateTo = CONVERT(DATETIME, 
			CONVERT(VARCHAR(10), ISNULL(TAD.DateTo, TEE.TrainingDate), 101) + '' '' + 
			ISNULL(CONVERT(VARCHAR(10), TAD.DateTo, 108), ''00:00:00.000'')),
		TEE.TrainingDate, 	
		NumberOfParticipants, 
		TEE.Venue, 
		EmployeeName, 
		TEE.EmployeeNum, 
		Division, 
		Department, 
		Section, 
		Response_1_1, 
		Response_1_2, 
		Response_1_3, 
		Response_2_1, 
		Response_2_2, 
		Response_2_3, 
		Response_2_4, 
		Response_2_5, 
		Response_3_1, 
		Response_3_2, 
		Response_3_3, 
		Response_3_4, 
		Response_3_5, 
		Response_4_1, 
		Response_4_2, 
		Response_5_1, 
		Response_5_2, 
		Response_5_3, 
		Response_5_4, 
		Response_5_5, 
		Answer_1, 
		Answer_2,
		Answer_3, 
		Answer_4, 
		Answer_5, 
		Answer_6, 
		Answer_7 
	FROM TrainingEvaluationExternal TEE
	LEFT JOIN TrainingCompleted TC
		ON TC.EmployeeNum = TEE.EmployeeNum
		AND TC.CompanyNum = TEE.CompanyNum
		AND TC.CourseName = TEE.CourseName
		AND TC.ProviderName = TEE.Provider
	LEFT JOIN TrainingAgreementForm TAF
		ON TAF.PathID = TC.PathID
	LEFT JOIN TAFProgramDetails TAD
		ON TAD.TAFID = TAF.TAFID
	WHERE TEE.PathID = <%PARAM[0]%>');
END
-- query end

-- TWS reports
IF NOT EXISTS(SELECT 1 FROM [ess.ReportsLU] WHERE Title = 'TWS')
BEGIN
	INSERT INTO [ess.ReportsLU] ([Title],[Path],[SQL])
	VALUES (
		'TWS',
		'reports/ess_tws.rdl',
		'declare @tbl table ( [year] int, xAxis varchar(200), Aspect varchar(200), KPAName varchar(200), CurrentValue real, PreviousValue real, Diff real ) insert into @tbl select (CAST(RIGHT(SchemeCode,4) AS INT)), <%PARAM[0]%>, Aspect, KPAName, Avg(CurrentYear), Avg(PreviousYear), Avg(CurrentYear) - Avg(PreviousYear) from [ess.TWSRawData] where not(Aspect = ''Leadership'') group by SchemeCode, <%PARAM[0]%>, Aspect, KPAName insert into @tbl select (CAST(RIGHT(SchemeCode,4) AS INT)), <%PARAM[0]%>, Aspect, KPAName, Avg(CurrentYear), Avg(PreviousYear), Avg(CurrentYear) - Avg(PreviousYear) from [ess.TWSRawData] where Aspect = ''Leadership'' group by SchemeCode, <%PARAM[0]%>, Aspect, KPAName insert into @tbl select (CAST(RIGHT(SchemeCode,4) AS INT)), <%PARAM[0]%>, Aspect, ''TOTALSROW'', Avg(CurrentYear), Avg(PreviousYear), Avg(CurrentYear) - Avg(PreviousYear) from [ess.TWSRawData] where not(Aspect = ''Leadership'') group by SchemeCode, <%PARAM[0]%>, Aspect order by <%PARAM[0]%> insert into @tbl select (CAST(RIGHT(SchemeCode,4) AS INT)), <%PARAM[0]%>, Aspect, ''TOTALSROW'', Avg(CurrentYear), Avg(PreviousYear), Avg(CurrentYear) - Avg(PreviousYear) from [ess.TWSRawData] where Aspect = ''Leadership'' group by SchemeCode, <%PARAM[0]%>, Aspect order by <%PARAM[0]%> insert into @tbl select [year], xAxis, ''GRANDTOTALROW'', ''GRANDTOTALROW'', Avg(CurrentValue), Avg(PreviousValue), Avg(CurrentValue) - Avg(PreviousValue) from @tbl where KPAName = ''TOTALSROW'' group by [year], xAxis select * from @tbl order by xAxis, Aspect, KPAName'
	)
END
ELSE
BEGIN
	UPDATE [ess.ReportsLU]
	SET
		[Path] = 'reports/ess_tws.rdl',
		[SQL] = 'declare @tbl table ( [year] int, xAxis varchar(200), Aspect varchar(200), KPAName varchar(200), CurrentValue real, PreviousValue real, Diff real ) insert into @tbl select (CAST(RIGHT(SchemeCode,4) AS INT)), <%PARAM[0]%>, Aspect, KPAName, Avg(CurrentYear), Avg(PreviousYear), Avg(CurrentYear) - Avg(PreviousYear) from [ess.TWSRawData] where not(Aspect = ''Leadership'') group by SchemeCode, <%PARAM[0]%>, Aspect, KPAName insert into @tbl select (CAST(RIGHT(SchemeCode,4) AS INT)), <%PARAM[0]%>, Aspect, KPAName, Avg(CurrentYear), Avg(PreviousYear), Avg(CurrentYear) - Avg(PreviousYear) from [ess.TWSRawData] where Aspect = ''Leadership'' group by SchemeCode, <%PARAM[0]%>, Aspect, KPAName insert into @tbl select (CAST(RIGHT(SchemeCode,4) AS INT)), <%PARAM[0]%>, Aspect, ''TOTALSROW'', Avg(CurrentYear), Avg(PreviousYear), Avg(CurrentYear) - Avg(PreviousYear) from [ess.TWSRawData] where not(Aspect = ''Leadership'') group by SchemeCode, <%PARAM[0]%>, Aspect order by <%PARAM[0]%> insert into @tbl select (CAST(RIGHT(SchemeCode,4) AS INT)), <%PARAM[0]%>, Aspect, ''TOTALSROW'', Avg(CurrentYear), Avg(PreviousYear), Avg(CurrentYear) - Avg(PreviousYear) from [ess.TWSRawData] where Aspect = ''Leadership'' group by SchemeCode, <%PARAM[0]%>, Aspect order by <%PARAM[0]%> insert into @tbl select [year], xAxis, ''GRANDTOTALROW'', ''GRANDTOTALROW'', Avg(CurrentValue), Avg(PreviousValue), Avg(CurrentValue) - Avg(PreviousValue) from @tbl where KPAName = ''TOTALSROW'' group by [year], xAxis select * from @tbl order by xAxis, Aspect, KPAName'
	WHERE [Title] = 'TWS'
END