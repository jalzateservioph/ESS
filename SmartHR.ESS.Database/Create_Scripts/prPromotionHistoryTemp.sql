/****** Object:  Table [dbo].[prPromotionHistoryTemp]    Script Date: 4/3/2019 6:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'prPromotionHistoryTemp')
BEGIN
    PRINT N'Creating [dbo].[prPromotionHistoryTemp]...';
    CREATE TABLE [dbo].[prPromotionHistoryTemp](
        [ID] [int] IDENTITY(1,1) NOT NULL,
        [EMPLOYEE_NUMBER] [varchar](50) NOT NULL,
        [PROMOTION_DATE] [datetime] NOT NULL,
        [EMPLOYEE_CATEGORY] [varchar](100) NULL,
        [PAY_LEVEL] [varchar](5) NULL,
        [JOB_GRADE] [varchar](5) NULL,
        [EMPLOYEE_CLASS] [varchar](100) NULL,
        [POSITION] [varchar](200) NULL,
    PRIMARY KEY CLUSTERED 
    (
        [ID] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    ) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO