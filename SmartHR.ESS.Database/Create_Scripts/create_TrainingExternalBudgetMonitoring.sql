SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[TrainingExternalBudgetMonitoring]') AND OBJECTPROPERTY(ID, N'ISTABLE') = 1)
BEGIN
	CREATE TABLE [dbo].[TrainingExternalBudgetMonitoring](
		[CategoryName] [nvarchar](200) NOT NULL,
		[BudgetCode] [nvarchar](200) NOT NULL,
		[Year] [int] NOT NULL,
		[Text] [nvarchar](100) NOT NULL,
		[SequenceNum] [nvarchar](100) NOT NULL,
		[CapturedBy] [nvarchar](12) NULL,
		[CapturedOn] [datetime] NULL
	 CONSTRAINT [PK_TrainingExternalBudgetMonitoring] PRIMARY KEY NONCLUSTERED 
	(
		[CategoryName] ASC,
		[Year] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]	
END