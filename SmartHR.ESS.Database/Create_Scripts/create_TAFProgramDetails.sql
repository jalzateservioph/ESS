SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[TAFProgramDetails]') AND OBJECTPROPERTY(ID, N'ISTABLE') = 1)
BEGIN
	CREATE TABLE [dbo].TAFProgramDetails(
		[ProgramDetailsID] [int] IDENTITY(1,1) NOT NULL,
		[Type] [nvarchar](155) NOT NULL,
		[ProgramType] [nvarchar](155) NOT NULL,
		[ProgramTitle] [nvarchar](255) NOT NULL,
		[Provider] [nvarchar](155) NOT NULL,
		[DateFrom] [datetime] NOT NULL,
		[DateTo] [datetime] NOT NULL,
		[Venue] [nvarchar](155) NOT NULL,
		[Investment] decimal (18,2) NOT NULL,
		[Duration] [nvarchar](155) NULL,
		[ExistingStart] [nvarchar](155) NULL,
		[Expiry] [nvarchar](155) NULL,
		[TAFID] [int] NOT NULL
	 CONSTRAINT [PK_TAFProgramDetails] PRIMARY KEY NONCLUSTERED 
	(
		[ProgramDetailsID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]	
END