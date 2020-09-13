SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[TrainingEvaluationOverseas]') AND OBJECTPROPERTY(ID, N'ISTABLE') = 1)
BEGIN
	CREATE TABLE [dbo].TrainingEvaluationOverseas(
		[ID] [int] IDENTITY(1,1) NOT NULL,
		[CompanyNum] [nvarchar](20) NOT NULL,
		[EmployeeName] [nvarchar](100) NOT NULL,
		[EmployeeNum] [nvarchar](12) NOT NULL,
		[CourseName] [nvarchar](100) NOT NULL,
		[TrainingDate] [datetime] NOT NULL,
		[Item1_1_Response] [tinyint] NULL,
		[Item1_1_Explanation] [nvarchar](255) NULL,
		[Item1_1_Strengths] [nvarchar](255) NULL,
		[Item1_1_Improvements] [nvarchar](255) NULL,
		[Item1_2_Response] [tinyint] NULL,
		[Item1_2_Comments] [nvarchar](255) NULL,
		[Item1_3_Response] [tinyint] NULL,
		[Item1_3_Comments] [nvarchar](255) NULL,
		[Item2_Superior] [nvarchar](255) NULL,
		[Item2_Subordinates] [nvarchar](255) NULL,
		[Item2_Colleagues] [nvarchar](255) NULL,
		[Item2_1_Response] [tinyint] NULL,
		[Item2_1_Comments] [nvarchar](255) NULL,
		[Item2_2_Response] [tinyint] NULL,
		[Item2_2_Comments] [nvarchar](255) NULL,
		[Item3_1_Response] [tinyint] NULL,
		[Item3_1_Explanation] [nvarchar](255) NULL,
		[Item3_1_Strengths] [nvarchar](255) NULL,
		[Item3_1_Improvements] [nvarchar](255) NULL,
		[Item3_2_Response] [tinyint] NULL,
		[Item3_2_Comments] [nvarchar](255) NULL,
		[Item3_3_Response] [tinyint] NULL,
		[Item3_3_Comments] [nvarchar](255) NULL,
		[Item3_4_Response] [tinyint] NULL,
		[Item3_4_Comments] [nvarchar](255) NULL,
		[Item3_5_Response] [tinyint] NULL,
		[Item3_5_Comments] [nvarchar](255) NULL,
		[Item3_6_Response] [tinyint] NULL,
		[Item3_6_Comments] [nvarchar](255) NULL,
		[Item3_7_Response] [tinyint] NULL,
		[Item3_7_Comments] [nvarchar](255) NULL,
		[Item3_8_Response] [tinyint] NULL,
		[Item3_8_Comments] [nvarchar](255) NULL,
		[Item4_1_Response] [tinyint] NULL,
		[Item4_1_Comments] [nvarchar](255) NULL,
		[Item4_2_Response] [tinyint] NULL,
		[Item4_2_Comments] [nvarchar](255) NULL,
		[Item4_3_Response] [tinyint] NULL,
		[Item4_3_Comments] [nvarchar](255) NULL,
		[Item4_4_Response] [tinyint] NULL,
		[Item4_4_Comments] [nvarchar](255) NULL,
		[Item4_5_Response] [tinyint] NULL,
		[Item4_5_Comments] [nvarchar](255) NULL,
		[Item4_6_Response] [tinyint] NULL,
		[Item4_6_Comments] [nvarchar](255) NULL,
		[Item4_7_HospitalName] [nvarchar](100) NULL,
		[Item4_7_Response] [tinyint] NULL,
		[Item4_7_Comments] [nvarchar](255) NULL,
		[Item4_8_TotalVisits] [tinyint] NULL,
		[Item4_8_VisitsReason] [nvarchar](255) NULL,
		[Item5_HostDivision] [nvarchar](255) NULL,
		[Item5_HostHR] [nvarchar](255) NULL,
		[Item5_HomeDivision] [nvarchar](255) NULL,
		[Item5_HomeHR] [nvarchar](255) NULL,
		[DateSubmitted] [datetime] NULL,
		[Status] [nvarchar](10) NULL,
		[PathID] [bigint] NULL
	 CONSTRAINT [PK_TrainingEvaluationOverseas] PRIMARY KEY NONCLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]	
END