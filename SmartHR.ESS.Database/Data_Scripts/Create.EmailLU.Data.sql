IF NOT EXISTS(SELECT 1 FROM [dbo].[EmailLU] WHERE [Type] = N'Change: Auto-Approve')
    INSERT INTO [dbo].[EmailLU] ([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) 
    VALUES (N'Change: Auto-Approve', N'mail.smtp2go.com', 2525, N'admin@gurango.net', N'G3d8Wzb/qtoLTxAoJmme+A==', N'ESS Administrator', N'admin@gurango.net', N'SmartHR: Your Change Application', N'<p>Dear <%PARAM[5]%>,</p><p>&nbsp;</p><p>This is to inform you that changes has been made to your PERSONNEL INFORMATION on <%PARAM[0]%>. </p><p>{TABLE1: SELECT[11]%>}</p><p>If this was not you, kindly inform HR immediately. For inquiries, please call Compensation &amp; Benefits Section at local 8044, 8114, or 8199.</p><p>&nbsp;</p><p>Thank you. </p>', NULL)

IF NOT EXISTS(SELECT 1 FROM [dbo].[EmailLU] WHERE [Type] = N'Change: Returned for Revision')
    INSERT INTO [dbo].[EmailLU] ([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) 
    VALUES (N'Change: Returned for Revision', N'mail.smtp2go.com', 2525, N'admin@gurango.net', N'G3d8Wzb/qtoLTxAoJmme+A==', N'ESS Administrator', N'admin@gurango.net', N'SmartHR: Your Change Application', N'Dear <%PARAM[5]%>,<p>&nbsp;</p><p>This is to inform you that changes you have made to your PERSONNEL INFORMATION is returned for revision&nbsp;on <%PARAM[0]%>. </p><p>{TABLE1: SELECT[1]%>}</p><p>For inquiries, please call Compensation &amp; Benefits Section at local 8044, 8114, or 8199.</p><p>&nbsp;</p><p>Thank you.</p>', NULL)

DELETE FROM [dbo].[EmailLU] WHERE [Type] = N'Change: Submitted Revision'

INSERT INTO [dbo].[EmailLU] ([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) 
VALUES (N'Change: Submitted Revision', N'mail.smtp2go.com', 2525, N'admin@gurango.net', N'G3d8Wzb/qtoLTxAoJmme+A==', N'ESS Administrator', N'admin@gurango.net', N'SmartHR: Your Change Application', N'&nbsp;Dear <%PARAM[4]%>,<p>&nbsp;</p><p>This is to inform you that <%PARAM[5]%> has re-submitted his/her changes in PERSONNEL INFORMATION&nbsp;on <%PARAM[0]%>. </p><p>{TABLE1: SELECT[1]%>}</p><p>For inquiries, please call Compensation &amp; Benefits Section at local 8044, 8114, or 8199.</p><p>&nbsp;</p><p>Thank you.</p>', NULL)
GO


  IF(SELECT count([Type]) FROM [EmailLU] WHERE TYPE = 'Change: Complete') = 0 
  BEGIN
  SET IDENTITY_INSERT [dbo].[EmailLU] ON

  INSERT INTO [dbo].[EmailLU] ([ID], [Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) VALUES ((SELECT MAX(ID) + 1 FROM [EmailLU]), N'Change: Completed', N'mail.smtp2go.com', 2525, N'admin@gurango.net', N'G3d8Wzb/qtoLTxAoJmme+A==', N'ESS Administrator', N'admin@gurango.net', N'SmartHR: Your Change Application',N'<p>Dear <%PARAM[5]%>,</p><p>&nbsp;</p><p>This is to inform you that changes has been made to your PERSONNEL INFORMATION on <%PARAM[0]%>. </p><p>{TABLE1: SELECT[11]%>}</p><p>If this was not you, kindly inform HR immediately. For inquiries, please call Compensation &amp; Benefits Section at local 8044, 8114, or 8199.</p><p>&nbsp;</p><p>Thank you. </p>', NULL)

  SET IDENTITY_INSERT [dbo].[EmailLU] OFF
  END   

  GO

  --2020-03-05
  --Default email server credentials
  UPDATE EmailLU SET [Server] = 'mail.smtp2go.com',
				   [Port] = '2525',
				   [Username] = 'admin@gurango.net',
				   [Name] = 'ESS Administrator',
				   [Address] = 'admin@gurango.net',
				   [Password] = 'G3d8Wzb/qtoLTxAoJmme+A=='
GO