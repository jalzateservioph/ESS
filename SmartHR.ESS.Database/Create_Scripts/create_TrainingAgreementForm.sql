SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[TrainingAgreementForm]') AND OBJECTPROPERTY(ID, N'ISTABLE') = 1)
BEGIN
	CREATE TABLE [dbo].TrainingAgreementForm(
		[TAFID] [int] IDENTITY(1,1) NOT NULL,
		[EmployeeNum] [nvarchar](20) NOT NULL,
		[CompanyNum] [nvarchar](20) NOT NULL,
		[Name] [nvarchar](155) NOT NULL,
		[ExternalPositionTitle] [nvarchar](255) NOT NULL,
		[MobileNum] [nvarchar](40) NOT NULL,
		[RTANum] [nvarchar](20) NULL,
		[DatePrepared] [datetime] NOT NULL,
		[Objectives1] [nvarchar](255) NULL,
		[Objectives2] [nvarchar](255) NULL,
		[Objectives3] [nvarchar](255) NULL,
		[Justification1] [nvarchar](255) NULL,
		[Justification2] [nvarchar](255) NULL,
		[Justification3] [nvarchar](255) NULL,
		[Category] [nvarchar](100) NULL,
		[BudgetCode] [nvarchar](100) NULL,
		[BeginningBudget] [real] NULL,
		[EndingBudget] [real] NULL,
		[Status] [nvarchar](20) NOT NULL,
		[CapturedBy] [nvarchar](255) NULL,
		[CapturedOn] [datetime] NULL,
		[PathID] [bigint] NULL,
		[Remarks] [nvarchar](255) NULL
	 CONSTRAINT [PK_TrainingAgreementForm] PRIMARY KEY NONCLUSTERED 
	(
		[TAFID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]	
END