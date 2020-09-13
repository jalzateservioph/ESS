SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[TrainingEvaluationExternal]') AND OBJECTPROPERTY(ID, N'ISTABLE') = 1)
BEGIN
	CREATE TABLE [dbo].TrainingEvaluationExternal(
		[ID] [int] IDENTITY(1,1) NOT NULL,
		[CompanyNum] [nvarchar](20) NOT NULL,
		[EmployeeName] [nvarchar](100) NULL,
		[EmployeeNum] [nvarchar](12) NOT NULL,
		[CourseName] [nvarchar] (100) NULL,
		[Provider] [nvarchar] (100) NULL,
		[TrainingDate] [datetime] NULL,
		[SpeakerName] [nvarchar](100) NULL,
		[NumberOfParticipants] [smallint] NULL,
		[Venue] [nvarchar] (100) NULL,
		[Division] [nvarchar] (100) NULL,
		[Department] [nvarchar] (100) NULL,
		[Section] [nvarchar] (100) NULL,
		[Response_1_1] [tinyint] NULL,
		[Response_1_2] [tinyint] NULL,
		[Response_1_3] [tinyint] NULL,
		[Response_2_1] [tinyint] NULL,
		[Response_2_2] [tinyint] NULL,
		[Response_2_3] [tinyint] NULL,
		[Response_2_4] [tinyint] NULL,
		[Response_2_5] [tinyint] NULL,
		[Response_3_1] [tinyint] NULL,
		[Response_3_2] [tinyint] NULL,
		[Response_3_3] [tinyint] NULL,
		[Response_3_4] [tinyint] NULL,
		[Response_3_5] [tinyint] NULL,
		[Response_4_1] [tinyint] NULL,
		[Response_4_2] [tinyint] NULL,
		[Response_5_1] [tinyint] NULL,
		[Response_5_2] [tinyint] NULL,
		[Response_5_3] [tinyint] NULL,
		[Response_5_4] [tinyint] NULL,
		[Response_5_5] [tinyint] NULL,
		[Answer_1] [nvarchar](255) NULL,
		[Answer_2] [nvarchar](255) NULL,
		[Answer_3] [nvarchar](255) NULL,
		[Answer_4] [nvarchar](255) NULL,
		[Answer_5] [nvarchar](255) NULL,
		[Answer_6] [nvarchar](255) NULL,
		[Answer_7] [nvarchar](255) NULL,
		[DateSubmitted] [datetime] NULL,
		[Status] [nvarchar](10) NULL,
		[PathID] [bigint] NULL
	 CONSTRAINT [PK_TrainingEvaluationExternal] PRIMARY KEY NONCLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]	
END