SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[SpecializedDevelopmentProgram]') AND OBJECTPROPERTY(ID, N'ISTABLE') = 1)
BEGIN
	CREATE TABLE [dbo].SpecializedDevelopmentProgram(
		[ID] [int] IDENTITY(1,1) NOT NULL,
		[CompanyNum] [nvarchar](20) NOT NULL,
		[Program] [nvarchar](255) NOT NULL,
		[ServiceAgreement] [int] NOT NULL,
		[CapturedBy] [nvarchar](255) NULL,
		[CapturedOn] [datetime] NULL
	 CONSTRAINT [PK_SpecializedDevelopmentProgram] PRIMARY KEY NONCLUSTERED 
	(
		[ID] ASC,
		[Program] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]	
END