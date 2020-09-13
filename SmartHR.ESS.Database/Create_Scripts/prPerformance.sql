/****** Object:  Table [dbo].[prPerformance]    Script Date: 4/3/2019 6:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'prPerformance')
BEGIN
    PRINT N'Creating [dbo].[prPerformance]...';
    CREATE TABLE [dbo].[prPerformance](
        [ID] [int] IDENTITY(1,1) NOT NULL,
        [PERIOD_FROM] [datetime] NOT NULL,
        [PERIOD_TO] [datetime] NOT NULL,
        [RATE_DATE] [datetime] NOT NULL,
        [RATER] [varchar](100) NOT NULL,
        [RATE_CODE] [varchar](5) NOT NULL,
        [MAN_NO] [varchar](50) NOT NULL,
        [JOBTITLE_CODE] [varchar](100) NOT NULL,
        [PAYLVL_CODE] [varchar](100) NOT NULL,
        [RATE_TYPE] [varchar](50) NOT NULL,
        [PAYGRP_CODE] [varchar](50) NOT NULL,
    PRIMARY KEY CLUSTERED 
    (
        [ID] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    ) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO