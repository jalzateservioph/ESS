SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[TrainingEvaluation]') AND OBJECTPROPERTY(ID, N'ISTABLE') = 1)
BEGIN
	CREATE TABLE [dbo].[TrainingEvaluation](
		[CompanyNum] [nvarchar](20) NOT NULL,
		[EmployeeNum] [nvarchar](12) NOT NULL,
		[TrainingType] [int] NOT NULL,
		[CourseName] [nvarchar](100) NOT NULL,
		[ProviderName] [nvarchar](50) NOT NULL,
		[StartDate] [datetime] NOT NULL,
		[EndDate] [datetime] NOT NULL,
		[PathID] [bigint] NULL
	 CONSTRAINT [PK_TrainingEvaluation] PRIMARY KEY NONCLUSTERED 
	(
		[CompanyNum] ASC,
		[EmployeeNum] ASC,
		[TrainingType] ASC,
		[CourseName] ASC,
		[ProviderName] ASC,
		[StartDate] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]	
END