SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[TrainingExternalBudget]') AND OBJECTPROPERTY(ID, N'ISTABLE') = 1)
BEGIN
	CREATE TABLE [dbo].[TrainingExternalBudget](
		[CompanyNum] [nvarchar](20) NOT NULL,
		[CategoryName] [nvarchar](255) NOT NULL,
		[Year] [int] NOT NULL,
		[Month] [int] NOT NULL,
		[Budget] [real] NULL,
		[RemainingBudget] [real] NULL,
		[CapturedBy] [nvarchar](12) NULL,
		[CapturedOn] [datetime] NULL
	 CONSTRAINT [PK_TrainingExternalBudget] PRIMARY KEY NONCLUSTERED 
	(
		[CompanyNum] ASC,
		[CategoryName] ASC,
		[Year] ASC,
		[Month] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]	
END