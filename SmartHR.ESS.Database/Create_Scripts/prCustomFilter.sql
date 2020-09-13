/****** Object:  Table [dbo].[prCustomFilter]    Script Date: 4/3/2019 6:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'prCustomFilter')
BEGIN
    PRINT N'Creating [dbo].[prCustomFilter]...';
	CREATE TABLE [dbo].[prCustomFilter](
		[FilterName] [varchar](100) NOT NULL,
		[FilterColumn] [varchar](100) NOT NULL,
		[Filters] [varchar](200) NOT NULL
	) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO