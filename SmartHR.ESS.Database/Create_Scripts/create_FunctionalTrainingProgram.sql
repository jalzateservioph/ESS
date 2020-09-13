SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[FunctionalTrainingProgram]') AND OBJECTPROPERTY(ID, N'ISTABLE') = 1)
BEGIN
	CREATE TABLE [dbo].FunctionalTrainingProgram(
		[ID] [int] IDENTITY(1,1) NOT NULL,
		[CompanyNum] [nvarchar](20) NOT NULL,
		[Min] [decimal](18,2) NULL,
		[Max] [decimal] (18,2) NULL,
		[ServiceAgreement] [nvarchar](255) NOT NULL,
		[Years] [int] NOT NULL check ([Years] >= 0),
		[Months] [int] NOT NULL check ([Months] >= 0 AND [Months] <= 11),
		[CapturedBy] [nvarchar](255) NULL,
		[CapturedOn] [datetime] NULL
	 CONSTRAINT [PK_FunctionalTrainingProgram] PRIMARY KEY NONCLUSTERED 
	(
		[ID] ASC,
		[ServiceAgreement] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]	
END