IF NOT EXISTS (SELECT 1 FROM [ess.ReportsLU] WHERE [Title] = 'Training Evaluation - In House')
BEGIN
	INSERT INTO [ess.ReportsLU] ([Title], [Path], [SQL])
	VALUES ('Training Evaluation - In House', 'reports/training_eval_inhouse.rdl', 'SELECT  TrainingPartipant = EmployeeName, TrainingProgram = CourseName, Division, Department, Facilitator, TrainingDate = CONVERT(VARCHAR, TrainingDate, 101), Response_1_1, Strengths_1_1, AreasOfImprovement_1_1, Response_1_2, Strengths_1_2, AreasOfImprovement_1_2, Response_1_3, Strengths_1_3, AreasOfImprovement_1_3, Response_1_4, Strengths_1_4, AreasOfImprovement_1_4, Response_1_5, Strengths_1_5, AreasOfImprovement_1_5, Response_2_1, Strengths_2_1, AreasOfImprovement_2_1, Response_2_2, Strengths_2_2, AreasOfImprovement_2_2, Response_2_3, Strengths_2_3, AreasOfImprovement_2_3, Response_3_1, Strengths_3_1, AreasOfImprovement_3_1, Response_3_2, Strengths_3_2, AreasOfImprovement_3_2, Response_4_1, Strengths_4_1, AreasOfImprovement_4_1, Response_4_2, Strengths_4_2, AreasOfImprovement_4_2, Response_4_3, Strengths_4_3, AreasOfImprovement_4_3, Response_4_4, Strengths_4_4, AreasOfImprovement_4_4, Response_4_5, Strengths_4_5, AreasOfImprovement_4_5, Response_4_6, Strengths_4_6, AreasOfImprovement_4_6, Response_5_1, Strengths_5_1, AreasOfImprovement_5_1, Remarks FROM TrainingEvaluationInHouse WHERE PathID = <%PARAM[0]%>')
END

IF NOT EXISTS (SELECT 1 FROM [ess.ReportsLU] WHERE [Title] = 'Training Evaluation - External')
BEGIN
	INSERT INTO [ess.ReportsLU] ([Title], [Path], [SQL])
	VALUES ('Training Evaluation - External', 'reports/training_eval_external.rdl', 'SELECT Provider, CourseName, SpeakerName, TrainingDate, NumberOfParticipants, Venue, EmployeeName, EmployeeNum, Division, Department, Section, Response_1_1, Response_1_2, Response_1_3, Response_2_1, Response_2_2, Response_2_3, Response_2_4, Response_2_5, Response_3_1, Response_3_2, Response_3_3, Response_3_4, Response_3_5, Response_4_1, Response_4_2, Response_5_1, Response_5_2, Response_5_3, Response_5_4, Response_5_5, Answer_1, Answer_2, Answer_3, Answer_4, Answer_5, Answer_6, Answer_7 FROM TrainingEvaluationExternal WHERE PathID = <%PARAM[0]%>')
END

IF NOT EXISTS (SELECT 1 FROM [ess.ReportsLU] WHERE [Title] = 'Training Evaluation - Overseas')
BEGIN
	INSERT INTO [ess.ReportsLU] ([Title], [Path], [SQL])
	VALUES ('Training Evaluation - Overseas', 'reports/training_eval_overseas.rdl', 'SELECT [Item1_1_Response], [Item1_1_Explanation], [Item1_1_Strengths], [Item1_1_Improvements], [Item1_2_Response], [Item1_2_Comments], [Item1_3_Response], [Item1_3_Comments], [Item2_Superior], [Item2_Subordinates], [Item2_Colleagues], [Item2_1_Response], [Item2_1_Comments], [Item2_2_Response], [Item2_2_Comments], [Item3_1_Response], [Item3_1_Explanation], [Item3_1_Strengths], [Item3_1_Improvements], [Item3_2_Response], [Item3_2_Comments], [Item3_3_Response], [Item3_3_Comments], [Item3_4_Response], [Item3_4_Comments], [Item3_5_Response], [Item3_5_Comments], [Item3_6_Response], [Item3_6_Comments], [Item3_7_Response], [Item3_7_Comments], [Item3_8_Response], [Item3_8_Comments], [Item4_1_Response], [Item4_1_Comments], [Item4_2_Response], [Item4_2_Comments], [Item4_3_Response], [Item4_3_Comments], [Item4_4_Response], [Item4_4_Comments], [Item4_5_Response], [Item4_5_Comments], [Item4_6_Response], [Item4_6_Comments], [Item4_7_HospitalName], [Item4_7_Response], [Item4_7_Comments], [Item4_8_TotalVisits], [Item4_8_VisitsReason], [Item5_HostDivision], [Item5_HostHR], [Item5_HomeDivision], [Item5_HomeHR] FROM TrainingEvaluationOverseas WHERE PathID = <%PARAM[0]%>')
END

IF NOT EXISTS (SELECT 1 FROM [ess.ReportsLU] WHERE [Title] = 'Training Agreement Form')
BEGIN
	INSERT INTO [ess.ReportsLU] ([Title], [Path], [SQL])
	VALUES ('Training Agreement Form', 'reports/training_agreement_form.rdl', 'DECLARE @PathID nvarchar(20) = ''<%PARAM[0]%>'' DECLARE @CompanyNum nvarchar(20) = (SELECT CompanyNum FROM TrainingAgreementForm WHERE PathID = @PathID) SELECT TOP 1 ''MAIN'' AS [Originator], NULL AS [Program], NULL AS [ServiceAgreement], NULL AS [Minimum], NULL AS [Maximum], taf.[EmployeeNum] [ID],  taf.[Name],  co.[Division],  co.[SubDivision] Department,  co.[SubSubDivision] Section,  pers1.[OFOCode] [Level],  taf.[ExternalPositionTitle],  pers.[HomeTel] [LocalNum],  taf.[MobileNum],  taf.[RTANum],  taf.[DatePrepared], tad.[Type], tad.[ProgramType], tad.[ProgramTitle], tad.[Provider], tad.[DateFrom], tad.[DateTo], tad.[Venue], tad.[Investment], tad.[Duration], tad.[ExistingStart], tad.[Expiry], taf.[Category], taf.[BudgetCode], taf.[BeginningBalance], taf.[EndingBalance], taf.[Objectives1], taf.[Objectives2], taf.[Objectives3], taf.[Justification1], taf.[Justification2], taf.[Justification3] FROM TrainingAgreementForm taf  INNER JOIN Personnel1 pers1 ON taf.EmployeeNum = pers1.EmployeeNum  INNER JOIN Personnel pers ON taf.EmployeeNum = pers.EmployeeNum  INNER JOIN Company co ON taf.CompanyNum = co.CompanyNum  LEFT JOIN TAFProgramDetails tad ON taf.TAFID = tad.TAFID WHERE taf.PathID = @PathID union select ''SDP'' as [Originator],  Program,  CONCAT(sdp.ServiceAgreement, '' Year/s'') as [ServiceAgreement],  NULL as [Minimum],  NULL as [Maximum], NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL from SpecializedDevelopmentProgram sdp WHERE CompanyNum = @CompanyNum union select ''FTP'' as [Originator],  NULL as Program,  CASE  	WHEN ftp.Years > 0	THEN CONCAT(ftp.Years, cast((ftp.Months / CONVERT(decimal(4,2), 12))as float), '' Year/s'') 	ELSE 	CONCAT(ftp.Months, '' Month/s'') END as ServiceAgreement, ftp.Min as [Minimum], ftp.Max as [Maximum], NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL FROM FunctionalTrainingProgram ftp WHERE CompanyNum = @CompanyNum ORDER BY [Originator] ASC, [ServiceAgreement] ASC, [Minimum] ASC')
END

IF NOT EXISTS (SELECT 1 FROM [ess.ReportsLU] WHERE [Title] = 'External Budget Monitoring')
BEGIN
	INSERT INTO [ess.ReportsLU] ([Title], [Path], [SQL])
	VALUES ('External Budget Monitoring', 'reports/external_budget_monitoring.rdl', 'DECLARE @Year nvarchar(4) = ''<%PARAM[0]%>'', @MonthFrom nvarchar(2) = ''<%PARAM[1]%>'', @MonthTo nvarchar(2) = ''<%PARAM[2]%>'' SELECT [Year] = @Year, [MonthFrom] = @MonthFrom, [MonthTo] = @MonthTo, [IDNum] = taf.[EmployeeNum],  [Cost] = tad.[Investment],  [DateReceived1] = taf.[DatePrepared], [DateReceived] = tad.[DateFrom], [CategoryName] = taf.[Category], taf.[BudgetCode],  TEB.Jan, TEB.Feb, TEB.Mar, TEB.Apr, TEB.May, TEB.Jun, TEB.Jul, TEB.Aug, TEB.Sep, TEB.Oct, TEB.Nov, TEB.Dec FROM TrainingAgreementForm taf INNER JOIN TAFProgramDetails tad ON taf.[TAFID] = tad.[TAFID] INNER JOIN ( 	SELECT CategoryName,  	ISNULL([1], 0) as [Jan],  	ISNULL([2], 0) as [Feb],  	ISNULL([3], 0) as [Mar],  	ISNULL([4], 0) as [Apr],  	ISNULL([5], 0) as [May],  	ISNULL([6], 0) as [Jun],  	ISNULL([7], 0) as [Jul],  	ISNULL([8], 0) as [Aug],  	ISNULL([9], 0) as [Sep],  	ISNULL([10], 0) as [Oct],  	ISNULL([11], 0) as [Nov],  	ISNULL([12], 0) as [Dec] 	FROM    	(	SELECT CategoryName, [Month], Budget	FROM TrainingExternalBudget	WHERE [Year] = @Year	AND [Month] BETWEEN @MonthFrom AND @MonthTo 	) p   	PIVOT   	(  	MAX(Budget) FOR [Month] IN  ( [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12] )   	) AS pvt   ) TEB 	on TEB.CategoryName = taf.[Category] WHERE taf.[Status] = ''Approve'' AND MONTH(tad.[DateFrom]) BETWEEN @MonthFrom AND @MonthTo AND YEAR(tad.[DateFrom]) = @Year')
END

IF EXISTS (SELECT 1 FROM [ess.ReportsLU] WHERE [Title] = 'Training Agreement Form')
BEGIN
	UPDATE [ess.ReportsLU]
	SET [SQL] = '
	DECLARE @PathID nvarchar(20) = ''<%PARAM[0]%>'' 
	
	DECLARE @CompanyNum nvarchar(20) = (SELECT CompanyNum FROM TrainingAgreementForm WHERE PathID = @PathID) 
	
	SELECT 
		TOP 1 
		''MAIN'' AS [Originator], 
		NULL AS [Program], 
		NULL AS [ServiceAgreement], 
		NULL AS [Minimum], 
		NULL AS [Maximum], 
		taf.[EmployeeNum] [ID],  
		taf.[Name],  
		co.[Division],  
		co.[SubDivision] Department,  
		co.[SubSubDivision] Section,  
		pers1.[OFOCode] [Level],  
		taf.[ExternalPositionTitle],  
		pers.[HomeTel] [LocalNum],  
		taf.[MobileNum],  
		taf.[RTANum],  
		taf.[DatePrepared], 
		tad.[Type], 
		tad.[ProgramType], 
		tad.[ProgramTitle], 
		tad.[Provider], 
		tad.[DateFrom], 
		tad.[DateTo], 
		tad.[Venue], 
		tad.[Investment], 
		tad.[Duration], 
		tad.[ExistingStart], 
		tad.[Expiry], 
		taf.[Category], 
		taf.[BudgetCode], 
		taf.[BeginningBalance], 
		taf.[EndingBalance], 
		taf.[Objectives1], 
		taf.[Objectives2], 
		taf.[Objectives3], 
		taf.[Justification1], 
		taf.[Justification2], 
		taf.[Justification3] 
	FROM TrainingAgreementForm taf  
	INNER JOIN Personnel1 pers1 
		ON taf.EmployeeNum = pers1.EmployeeNum  
	INNER JOIN Personnel pers 
		ON taf.EmployeeNum = pers.EmployeeNum  
	INNER JOIN Company co 
		ON taf.CompanyNum = co.CompanyNum  
	LEFT JOIN TAFProgramDetails tad 
		ON taf.TAFID = tad.TAFID 
	WHERE taf.PathID = @PathID 
	UNION 
	SELECT 
		''SDP'' as [Originator],  
		Program,  
		CONVERT(VARCHAR, sdp.ServiceAgreement) + '' Year/s'' as [ServiceAgreement],  
		NULL as [Minimum],  
		NULL as [Maximum], 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL 
	FROM SpecializedDevelopmentProgram sdp
	UNION 
	SELECT 
		''FTP'' as [Originator],  
		NULL as Program,  
		CASE WHEN ftp.Years > 0	THEN CONVERT(VARCHAR, ftp.Years) + CONVERT(VARCHAR, CONVERT(decimal(4,2),(ftp.Months / CONVERT(decimal(4,2), 12)))) + '' Year/s'' 
		ELSE CONVERT(VARCHAR, ftp.Months) + '' Month/s'' END as ServiceAgreement, 
		ftp.Min as [Minimum], 
		ftp.Max as [Maximum], 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL 
	FROM FunctionalTrainingProgram ftp 
	ORDER BY [Originator] ASC, [ServiceAgreement] ASC, [Minimum] ASC'
	WHERE [Title] = 'Training Agreement Form'
	AND [Path] = 'reports/training_agreement_form.rdl'
END

IF EXISTS (SELECT 1 FROM [ess.ReportsLU] WHERE [Title] = 'External Budget Monitoring')
BEGIN
	UPDATE [ess.ReportsLU]
	SET [SQL] = '
	DECLARE 
		@Year nvarchar(4) = ''<%PARAM[0]%>'',
		@MonthFrom nvarchar(2) = ''<%PARAM[1]%>'', 
		@MonthTo nvarchar(2) = ''<%PARAM[2]%>''

	SELECT 
		[Year] = @Year, 
		[MonthFrom] = @MonthFrom, 
		[MonthTo] = @MonthTo, 
		[IDNum] = T.[EmployeeNum],  
		[Cost] = T.[Investment],  
		[DateReceived1] = T.[DatePrepared], 
		[DateReceived] = T.[DateFrom], 
		[CategoryName] = T.[Category], 
		T.[BudgetCode],  
		TEB.[Jan], 
		TEB.[Feb], 
		TEB.[Mar], 
		TEB.[Apr], 
		TEB.[May], 
		TEB.[Jun], 
		TEB.[Jul], 
		TEB.[Aug], 
		TEB.[Sep], 
		TEB.[Oct], 
		TEB.[Nov], 
		TEB.[Dec]
	FROM (
		SELECT
			[EmployeeNum] = TP.[EmployeeNum],
			[Investment] = TP.[cfInvestment],
			[DatePrepared] = TAF.[CapturedOn],
			[DateFrom] = TP.[StartDate],
			[Category] = TP.[cfBudgetCategory],
			[BudgetCode] = TP.[cfBudgetCode],
			[Status] = TP.[TrainingStatus]
		FROM TrainingPlanned TP
		LEFT JOIN CourseLU C
			ON C.[CourseName] = TP.[CourseName]
		LEFT JOIN TrainingAgreementForm TAF 
			ON TAF.[PathID] = TP.[PathID] 
		WHERE TP.[CourseName] IS NOT NULL
		  AND TP.[CourseName] <> ''''
		  AND ISNUMERIC(TP.[cfInvestment]) = 1
		  AND CONVERT(DECIMAL(23,10), RTRIM(LTRIM(TP.[cfInvestment]))) > 0
		  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0)
		  AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) 
		UNION ALL
		SELECT
			[EmployeeNum] = TC.[EmployeeNum],
			[Investment] = TC.[cfInvestment],
			[DatePrepared] = TAF.[CapturedOn],
			[DateFrom] = TC.[StartDate],
			[Category] = TC.[cfBudgetCategory],
			[BudgetCode] = TC.[cfBudgetCode],
			[Status] = TC.[TrainingStatus]
		FROM TrainingCompleted TC
		LEFT JOIN CourseLU C
			ON C.[CourseName] = TC.[CourseName]
		LEFT JOIN TrainingAgreementForm TAF 
			ON TAF.[PathID] = TC.[PathID] 
		WHERE TC.[CourseName] IS NOT NULL
		  AND TC.[CourseName] <> ''''
		  AND ISNUMERIC(TC.[cfInvestment]) = 1
		  AND CONVERT(DECIMAL(23,10), RTRIM(LTRIM(TC.[cfInvestment]))) > 0
		  AND (C.[InternalCourse] IS NULL OR C.[InternalCourse] = 0)
		  AND (C.[Overseas] IS NULL OR C.[Overseas] = 0) 
	) T
	INNER JOIN ( 	
		SELECT 
			[CategoryName],  	
			[Jan] = ISNULL([1], 0),  	
			[Feb] = ISNULL([2], 0),  	
			[Mar] = ISNULL([3], 0),  	
			[Apr] = ISNULL([4], 0),  	
			[May] = ISNULL([5], 0),  	
			[Jun] = ISNULL([6], 0),  	
			[Jul] = ISNULL([7], 0),  	
			[Aug] = ISNULL([8], 0),  	
			[Sep] = ISNULL([9], 0),  	
			[Oct] = ISNULL([10], 0),  	
			[Nov] = ISNULL([11], 0),  	
			[Dec] = ISNULL([12], 0) 	
		FROM    	(	
			SELECT 
				[CategoryName], 
				[Month], 
				[Budget]	
			FROM TrainingExternalBudget	
			WHERE [Year] = @Year	
			  AND ([Month] BETWEEN @MonthFrom AND @MonthTo)
		) P PIVOT (  	
			MAX(Budget) FOR [Month] IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
		) AS PVT 
	) TEB 	
		ON TEB.CategoryName = T.[Category] 
	WHERE (T.[Status] LIKE ''Approve%''  OR T.[Status] = ''Completed'')
	  AND (MONTH(T.[DateFrom]) BETWEEN @MonthFrom AND @MonthTo)
	  AND YEAR(T.[DateFrom]) = @Year'
	WHERE [Title] = 'External Budget Monitoring'
	  AND [Path] = 'reports/external_budget_monitoring.rdl'
END

IF EXISTS (SELECT 1 FROM [ess.ReportsLU] WHERE [Title] = 'Training Evaluation - External')
BEGIN
	UPDATE [ess.ReportsLU]
	SET [SQL] = '
	SELECT
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
	WHERE TEE.PathID = <%PARAM[0]%>'
	WHERE [Title] = 'Training Evaluation - External'
	  AND [Path] = 'reports/training_eval_external.rdl'
END