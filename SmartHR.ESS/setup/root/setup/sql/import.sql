/**********************************************************************************************************

					*** v6.0.74 (Create default data and import existing data) ***

***********************************************************************************************************/
if exists (select [id] from [sysobjects] where [id] = object_id(N'[Charts.TypeLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	if not exists(select top 1 [ID] from [Charts.TypeLU])
	begin

		insert into [Charts.TypeLU]([ID], [TypeName]) values(0, 'Bar')
		insert into [Charts.TypeLU]([ID], [TypeName]) values(3, 'Pie')

	end

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[AssemblyLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	if not exists(select top 1 [ID] from [AssemblyLU])
	begin

		/* DevExpress.Web.ASPxEditors (Editors) */
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxBinaryImage', null, null)
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxButton', null, null)
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxButtonEdit', null, null)
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxCalendar', null, null)
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxCheckBox', 'Check', 'Checked')
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxComboBox', 'Combo', 'Value')
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxDateEdit', 'Date', 'Value')
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxFilterControl', null, null)
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxHtmlEditor', null, null)
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxHyperLink', null, null)
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxImage', null, null)
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxLabel', 'Label', null)
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxListBox', 'Listbox (items)', null)
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxMemo', 'Memo', null)
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxObjectContainer', null, null)
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxRadioButton', null, null)
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxRadioButtonList', 'Radio (items)', null)
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxSpinEdit', 'Spin', null)
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxTextBox', 'Text', 'Text')
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxUploadControl', null, null)
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxColorEdit', null, null)
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxDropDownEdit', null, null)
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.ASPxEditors.v11.1.dll', 'DevExpress.Web.ASPxEditors.ASPxProgressBar', null, null)

		/* DevExpress.Web.ASPxGridView (Grid View) */
		insert into [AssemblyLU]([Assembly], [Typename]) values('DevExpress.Web.ASPxGridView.v11.1.dll', 'DevExpress.Web.ASPxGridView.ASPxGridView')

		/* DevExpress.Web.ASPxRatingControl (Rating Control) */
		insert into [AssemblyLU]([Assembly], [Typename], [FriendlyName], [Property]) values('DevExpress.Web.v11.1.dll', 'DevExpress.Web.ASPxRatingControl', 'Rating', 'Value')

	end

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[DataTypeLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists(select top 1 [ID] from [DataTypeLU])
	begin

		insert into [DataTypeLU]([DataType], [Typename]) values(1, 'bigint')
		insert into [DataTypeLU]([DataType], [Typename]) values(6, 'binary')
		insert into [DataTypeLU]([DataType], [Typename]) values(0, 'bit')
		insert into [DataTypeLU]([DataType], [Typename]) values(3, 'char')
		insert into [DataTypeLU]([DataType], [Typename]) values(4, 'datetime')
		insert into [DataTypeLU]([DataType], [Typename]) values(2, 'decimal')
		insert into [DataTypeLU]([DataType], [Typename]) values(2, 'float')
		insert into [DataTypeLU]([DataType], [Typename]) values(6, 'image')
		insert into [DataTypeLU]([DataType], [Typename]) values(1, 'int')
		insert into [DataTypeLU]([DataType], [Typename]) values(2, 'money')
		insert into [DataTypeLU]([DataType], [Typename]) values(3, 'nchar')
		insert into [DataTypeLU]([DataType], [Typename]) values(3, 'ntext')
		insert into [DataTypeLU]([DataType], [Typename]) values(3, 'nvarchar')
		insert into [DataTypeLU]([DataType], [Typename]) values(2, 'real')
		insert into [DataTypeLU]([DataType], [Typename]) values(4, 'smalldatetime')
		insert into [DataTypeLU]([DataType], [Typename]) values(1, 'smallint')
		insert into [DataTypeLU]([DataType], [Typename]) values(2, 'smallmoney')
		insert into [DataTypeLU]([DataType], [Typename]) values(6, 'sql_variant')
		insert into [DataTypeLU]([DataType], [Typename]) values(3, 'sysname')
		insert into [DataTypeLU]([DataType], [Typename]) values(3, 'text')
		insert into [DataTypeLU]([DataType], [Typename]) values(4, 'timestamp')
		insert into [DataTypeLU]([DataType], [Typename]) values(1, 'tinyint')
		insert into [DataTypeLU]([DataType], [Typename]) values(5, 'uniqueidentifier')
		insert into [DataTypeLU]([DataType], [Typename]) values(6, 'varbinary')
		insert into [DataTypeLU]([DataType], [Typename]) values(3, 'varchar')
		insert into [DataTypeLU]([DataType], [Typename]) values(3, 'xml')

	end

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[DocLinkCategoryLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	if not exists(select top 1 [Value] from [DocLinkCategoryLU])
	begin

		insert into [DocLinkCategoryLU]([Value], [Text]) values('Accident', 'Accident')
		insert into [DocLinkCategoryLU]([Value], [Text]) values('CV', 'CV')
		insert into [DocLinkCategoryLU]([Value], [Text]) values('Develop', 'Development')
		insert into [DocLinkCategoryLU]([Value], [Text]) values('Hazard', 'Hazard')
		insert into [DocLinkCategoryLU]([Value], [Text]) values('IR', 'IR')
		insert into [DocLinkCategoryLU]([Value], [Text]) values('Leave', 'Leave')
		insert into [DocLinkCategoryLU]([Value], [Text]) values('OH&S', 'OH&S')
		insert into [DocLinkCategoryLU]([Value], [Text]) values('Organisat', 'Organisational')
		insert into [DocLinkCategoryLU]([Value], [Text]) values('Pay', 'Pay')
		insert into [DocLinkCategoryLU]([Value], [Text]) values('Perform', 'Evaluations')
		insert into [DocLinkCategoryLU]([Value], [Text]) values('Personal', 'Personal')
		insert into [DocLinkCategoryLU]([Value], [Text]) values('Store/Loan', 'Store/Loan')
		insert into [DocLinkCategoryLU]([Value], [Text]) values('Training', 'Training')

	end

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[MessageStatusLU]') and objectproperty([ID], N'IsUserTable') = 1)
begin

	delete from [MessageStatusLU]

	if not exists(select top 1 [ID] from [MessageStatusLU])
	begin

		insert into [MessageStatusLU]([ID], [Description]) values(-1, 'Pending')
		insert into [MessageStatusLU]([ID], [Description]) values(0, 'Delivered')
		insert into [MessageStatusLU]([ID], [Description]) values(9, 'Undeliverable')
		insert into [MessageStatusLU]([ID], [Description]) values(255, 'Unknown error')

	end

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[EmailLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	/* TODO: v6.0.74 remove once released (this is only to ensure all new items are created in order) */
	--truncate table [EmailLU]

	if not exists(select top 1 [id] from [EmailLU])
	begin

		/* *** Reset Password *** */
		/* ********************** */
		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Password: Reset', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Password', '<p>Dear <%PARAM[0]%>,</p><p>You have requested to complete our password change procedure. Please click on the link below and you will be able to choose a new password for your account:</p><p><a href="<%PARAM[1]%>">Click here to reset your account password</a></p><p>If you experience problems opening the link above, then you can copy and paste the link below into the address bar of your internet browser.</p><p><%PARAM[1]%></p><p>NOTE: Your verification link will only be valid for 24 hours.</p>', 'Dear <%PARAM[0]%>,

You have requested to complete our password change procedure. Please click on the link below and you will be able to choose a new password for your account:

<%PARAM[1]%>

NOTE: Your verification link will only be valid for 24 hours.')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Password: Success', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Password', '<p>Dear <%PARAM[0]%>,</p><p>This is to inform you that your recent password change request has successfully been processed.</p>', 'Dear <%PARAM[0]%>,

This is to inform you that your recent password change request has successfully been processed.')

		/* *** Notification Workflow *** */
		/* ***************************** */
		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Notify - Inform', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: New Notification', '<p>Dear <%PARAM[1]%>,<br /></p><p>This is to inform you that you have been assigned to a new notification request, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Originator</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[5]%></td></tr><tr><td style="text-align: right">Date</td><td></td><td><%PARAM[0]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[6]%></td></tr><tr><td style="text-align: right">Subject</td><td></td><td><%PARAM[7]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Description</td></tr><tr><td colspan="3"><%PARAM[8]%></td></tr></table>', 'Dear <%PARAM[1]%>,

This is to inform you that you have been assigned to a new notification request, the details follow:

Originator: <%PARAM[5]%>
Date: <%PARAM[0]%>
Status: <%PARAM[6]%>
Subject: <%PARAM[7]%>
Description: <%PARAM[8]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Notify - Originator', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Notification', '<p>Dear <%PARAM[5]%>,<br /></p><p>This is to inform you that your notification request, has been received and passsed onto <%PARAM[1]%> for further processing, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[6]%></td></tr><tr><td style="text-align: right">Subject</td><td></td><td><%PARAM[7]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Description</td></tr><tr><td colspan="3"><%PARAM[8]%></td></tr></table>', 'Dear <%PARAM[5]%>,

This is to inform you that your notification request, has been received and passsed onto <%PARAM[1]%> for further processing, the details follow:

Date: <%PARAM[0]%>
Status: <%PARAM[6]%>
Subject: <%PARAM[7]%>
Description: <%PARAM[8]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Notify - Completed', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Notification', '<p>Dear <%PARAM[5]%>,<br /></p><p>This is to inform you that your notification request, has been <%PARAM[2]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[6]%></td></tr><tr><td style="text-align: right">Subject</td><td></td><td><%PARAM[7]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Description</td></tr><tr><td colspan="3"><%PARAM[8]%></td></tr></table>', 'Dear <%PARAM[5]%>,

This is to inform you that your notification request, has been <%PARAM[2]%>, the details follow:

Date: <%PARAM[0]%>
Status: <%PARAM[6]%>
Subject: <%PARAM[7]%>
Description: <%PARAM[8]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Notify - Actioned', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Notification', '<p>Dear <%PARAM[4]%>,<br /></p><p>This is to inform you that your notification request, has been processed by <%PARAM[3]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[6]%></td></tr><tr><td style="text-align: right">Subject</td><td></td><td><%PARAM[7]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Description</td></tr><tr><td colspan="3"><%PARAM[8]%></td></tr></table>', 'Dear <%PARAM[4]%>,

This is to inform you that your notification request, has been processed by <%PARAM[3]%>, the details follow:

Date: <%PARAM[0]%>
Status: <%PARAM[6]%>
Subject: <%PARAM[7]%>
Description: <%PARAM[8]%>')

		/* *** Change: Notify Control Workflow *** */
		/* *************************************** */
		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Change: Notify - Inform', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: New Change Control Task', '<p>Dear <%PARAM[1]%>,<br /></p><p>This is to inform you that <%PARAM[5]%> has made the following changes to their personal/organizational particulars:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">{TABLE:select [Label] as [Item], [ValueF] as [From], [ValueT] as [To] from [ess.Change] as [c] left outer join [ess.Policy] as [p] on [c].[PolicyID] = [p].[ID] where ([PathID] = <%PathID%>) order by [PolicyID]}</td></tr></table>', 'Dear <%PARAM[1]%>,

This is to inform you that <%PARAM[5]%> has made the following changes to their personal/organizational particulars:

Date: <%PARAM[0]%>

{TABLE:select [Label] as [Item], [ValueF] as [From], [ValueT] as [To] from [ess.Change] as [c] left outer join [ess.Policy] as [p] on [c].[PolicyID] = [p].[ID] where ([PathID] = <%PathID%>) order by [PolicyID]}')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Change: Notify - Originator', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Change Control Task', '<p>Dear <%PARAM[5]%>,<br /></p><p>This is to inform you that you have made the following changes to your personal/organizational particulars:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">{TABLE:select [Label] as [Item], [ValueF] as [From], [ValueT] as [To] from [ess.Change] as [c] left outer join [ess.Policy] as [p] on [c].[PolicyID] = [p].[ID] where ([PathID] = <%PathID%>) order by [PolicyID]}</td></tr></table>', 'Dear <%PARAM[5]%>,

This is to inform you that you have made the following changes to your personal/organizational particulars:

Date: <%PARAM[0]%>

{TABLE:select [Label] as [Item], [ValueF] as [From], [ValueT] as [To] from [ess.Change] as [c] left outer join [ess.Policy] as [p] on [c].[PolicyID] = [p].[ID] where ([PathID] = <%PathID%>) order by [PolicyID]}')

		/* *** Change: Approve Control Workflow *** */
		/* **************************************** */
		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Change: Approve - Inform', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: New Change Control Task', '<p>Dear <%PARAM[1]%>,<br /></p><p>This is to inform you that <%PARAM[5]%> has requested that you make the following changes to their personal/organizational particulars:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">{TABLE:select [Label] as [Item], [ValueF] as [From], [ValueT] as [To] from [ess.Change] as [c] left outer join [ess.Policy] as [p] on [c].[PolicyID] = [p].[ID] where ([PathID] = <%PathID%>) order by [PolicyID]}</td></tr></table>', 'Dear <%PARAM[1]%>,

This is to inform you that <%PARAM[5]%> has requested that you make the following changes to their personal/organizational particulars:

Date: <%PARAM[0]%>

{TABLE:select [Label] as [Item], [ValueF] as [From], [ValueT] as [To] from [ess.Change] as [c] left outer join [ess.Policy] as [p] on [c].[PolicyID] = [p].[ID] where ([PathID] = <%PathID%>) order by [PolicyID]}')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Change: Approve - Originator', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Change Control Task', '<p>Dear <%PARAM[5]%>,<br /></p><p>This is to inform you that your change request has been pased on to <%PARAM[1]%> for further processing and includes the following changes to your personal/organizational particulars:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">{TABLE:select [Label] as [Item], [ValueF] as [From], [ValueT] as [To] from [ess.Change] as [c] left outer join [ess.Policy] as [p] on [c].[PolicyID] = [p].[ID] where ([PathID] = <%PathID%>) order by [PolicyID]}</td></tr></table>', 'Dear <%PARAM[5]%>,

This is to inform you that your change request has been pased on to <%PARAM[1]%> for further processing and includes the following changes to your personal/organizational particulars:

Date: <%PARAM[0]%>

{TABLE:select [Label] as [Item], [ValueF] as [From], [ValueT] as [To] from [ess.Change] as [c] left outer join [ess.Policy] as [p] on [c].[PolicyID] = [p].[ID] where ([PathID] = <%PathID%>) order by [PolicyID]}')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Change: Approve - Completed', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Change Control Task', '<p>Dear <%PARAM[5]%>,<br /></p><p>This is to inform you that your change request has been <%PARAM[2]%>, the following changes were made to your personal/organizational particulars:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">{TABLE:select [Label] as [Item], [ValueF] as [From], [ValueT] as [To] from [ess.Change] as [c] left outer join [ess.Policy] as [p] on [c].[PolicyID] = [p].[ID] where ([PathID] = <%PathID%>) order by [PolicyID]}</td></tr></table>', 'Dear <%PARAM[5]%>,

This is to inform you that your change request has been <%PARAM[2]%>, the following changes were made to your personal/organizational particulars:

Date: <%PARAM[0]%>

{TABLE:select [Label] as [Item], [ValueF] as [From], [ValueT] as [To] from [ess.Change] as [c] left outer join [ess.Policy] as [p] on [c].[PolicyID] = [p].[ID] where ([PathID] = <%PathID%>) order by [PolicyID]}')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Change: Approve - Actioned', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Change Control Task', '<p>Dear <%PARAM[5]%>,<br /></p><p>This is to inform you that your change request task, has been processed by <%PARAM[3]%>, the following changes were made to <%PARAM[0]%>''s personal/organizational particulars:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">{TABLE:select [Label] as [Item], [ValueF] as [From], [ValueT] as [To] from [ess.Change] as [c] left outer join [ess.Policy] as [p] on [c].[PolicyID] = [p].[ID] where ([PathID] = <%PathID%>) order by [PolicyID]}</td></tr></table>', 'Dear <%PARAM[5]%>,

This is to inform you that your change request task, has been processed by <%PARAM[3]%>, the following changes were made to <%PARAM[0]%>''s personal/organizational particulars:
Date : <%PARAM[0]%>

{TABLE:select [Label] as [Item], [ValueF] as [From], [ValueT] as [To] from [ess.Change] as [c] left outer join [ess.Policy] as [p] on [c].[PolicyID] = [p].[ID] where ([PathID] = <%PathID%>) order by [PolicyID]}')

		/* *** Leave Workflow *** */
		/* ********************** */
		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Leave - Inform', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: New Leave Application', '<p>Dear <%PARAM[3]%>,<br /></p><p>This is to inform you that you have been assigned to a new leave application, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Originator</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Start Date</td><td></td><td><%PARAM[1]%></td></tr><tr><td style="text-align: right">End Date</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Application Type</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Duration</td><td></td><td><%PARAM[8]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[9]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Remarks</td></tr><tr><td colspan="3"><%PARAM[10]%></td></tr></table>', 'Dear <%PARAM[3]%>,

This is to inform you that you have been assigned to a new leave application, the details follow:

Originator: <%PARAM[0]%>

Start Date: <%PARAM[1]%>
 
End Date:  <%PARAM[2]%>

Application Type: <%PARAM[7]%>

Duration: <%PARAM[8]%>

Status: <%PARAM[9]%>

Remarks: <%PARAM[10]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Leave - Originator', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Leave Application', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your leave application has been received and pased on to <%PARAM[3]%> for further processing, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Start Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[1]%></td></tr><tr><td style="text-align: right">End Date</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Application Type</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Duration</td><td></td><td><%PARAM[8]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[9]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Remarks</td></tr><tr><td colspan="3"><%PARAM[10]%></td></tr></table>', 'Dear <%PARAM[0]%>,

This is to inform you that your leave application has been received and pased on to <%PARAM[3]%> for further processing, the details follow:

Start Date: <%PARAM[1]%>

End Date: <%PARAM[2]%>

Application Type: <%PARAM[7]%>

Duration: <%PARAM[8]%>

Status: <%PARAM[9]%>

Remarks: <%PARAM[10]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Leave - Completed', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Leave Application', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your leave application has been <%PARAM[4]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Start Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[1]%></td></tr><tr><td style="text-align: right">End Date</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Application Type</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Duration</td><td></td><td><%PARAM[8]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[9]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Remarks</td></tr><tr><td colspan="3"><%PARAM[10]%></td></tr></table>', 'Dear <%PARAM[0]%>,

This is to inform you that your leave application has been <%PARAM[4]%>, the details follow:

Start Date: <%PARAM[1]%> 

End Date: <%PARAM[2]%>

Application Type: <%PARAM[7]%>

Duration: <%PARAM[8]%>

Status: <%PARAM[9]%>

Remarks: <%PARAM[10]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Leave - Actioned', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Leave Application', '<p>This is to inform you that your leave application task has been processed by <%PARAM[5]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Originator</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Start Date</td><td></td><td><%PARAM[1]%></td></tr><tr><td style="text-align: right">End Date</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Application Type</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Duration</td><td></td><td><%PARAM[8]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[9]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Remarks</td></tr><tr><td colspan="3"><%PARAM[10]%></td></tr></table>', 'This is to inform you that your leave application task has been processed by <%PARAM[5]%>, the details follow:

Originator: <%PARAM[0]%>

Start Date: <%PARAM[1]%>

End Date: <%PARAM[2]%>

Application Type: <%PARAM[7]%>

Duration: <%PARAM[8]%>

Status: <%PARAM[9]%>

Remarks: <%PARAM[10]%>')

		/* *** Evaluation Workflow *** */
		/* *************************** */
		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Evaluation - Inform', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: New Evaluation Task', '<p>Dear <%PARAM[1]%>,<br /></p><p>This is to inform you that you have been assigned to a new evaluation task, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Originator</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[5]%></td></tr><tr><td style="text-align: right">Date</td><td></td><td><%PARAM[0]%></td></tr><tr><td style="text-align: right">Scheme</td><td></td><td><%PARAM[6]%></td></tr><tr><td style="text-align: right">Type</td><td></td><td><%PARAM[7]%></td></tr></table>', 'Dear <%PARAM[1]%>,

This is to inform you that you have been assigned to a new evaluation task, the details follow:

Originator: <%PARAM[5]%>

Date: <%PARAM[0]%>

Scheme: <%PARAM[6]%>

Type: <%PARAM[7]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Evaluation - Originator', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Evaluation Task', '<p>Dear <%PARAM[5]%>,<br /></p><p>This is to inform you that your evaluation task has been received and pased on to <%PARAM[3]%> for further processing, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Scheme</td><td></td><td><%PARAM[6]%></td></tr><tr><td style="text-align: right">Type</td><td></td><td><%PARAM[7]%></td></tr></table>', 'Dear <%PARAM[5]%>,

This is to inform you that your evaluation task has been received and pased on to <%PARAM[3]%> for further processing, the details follow: <%PARAM[0]%> 

Scheme: <%PARAM[6]%>

Type: <%PARAM[7]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Evaluation - Completed', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Evaluation Task', '<p>Dear <%PARAM[5]%>,<br /></p><p>This is to inform you that your evaluation task has been <%PARAM[2]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Scheme</td><td></td><td><%PARAM[6]%></td></tr><tr><td style="text-align: right">Type</td><td></td><td><%PARAM[7]%></td></tr></table>', 'Dear <%PARAM[5]%>,

This is to inform you that your evaluation task has been <%PARAM[2]%>, the details follow: <%PARAM[0]%>

Scheme: <%PARAM[6]%>

Type: <%PARAM[7]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Evaluation - Actioned', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Evaluation Task', '<p>This is to inform you that your evaluation task has been processed by <%PARAM[3]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Originator</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[5]%></td></tr><tr><td style="text-align: right">Date</td><td></td><td><%PARAM[0]%></td></tr><tr><td style="text-align: right">Scheme</td><td></td><td><%PARAM[6]%></td></tr><tr><td style="text-align: right">Type</td><td></td><td><%PARAM[7]%></td></tr></table>', 'This is to inform you that your evaluation task has been processed by <%PARAM[3]%>, the details follow:

Originator: <%PARAM[5]%>

Date: <%PARAM[0]%>

Scheme: <%PARAM[6]%>

Type: <%PARAM[7]%>')

		/* *** Training Workflow *** */
		/* ************************* */
		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Training - Inform', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: New Training Application', '<p>Dear <%PARAM[3]%>,<br /></p><p>This is to inform you that you have been assigned to a new training application, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Originator</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Start Date</td><td></td><td><%PARAM[1]%></td></tr><tr><td style="text-align: right">End Date</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Application Type</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Duration</td><td></td><td><%PARAM[8]%> <%PARAM[9]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[10]%></td></tr></table>', 'Dear <%PARAM[3]%>,

This is to inform you that you have been assigned to a new training application, the details follow:

Originator: <%PARAM[0]%>

Start Date: <%PARAM[1]%>

End Date: <%PARAM[2]%>

Application Type: <%PARAM[7]%>

Duration: <%PARAM[8]%> <%PARAM[9]%>

Status: <%PARAM[10]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Training - Originator', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Training Application', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your training application has been received and pased on to <%PARAM[3]%> for further processing, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Start Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[1]%></td></tr><tr><td style="text-align: right">End Date</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Application Type</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Duration</td><td></td><td><%PARAM[8]%> <%PARAM[9]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[10]%></td></tr></table>', 'Dear <%PARAM[0]%>,

This is to inform you that your training application has been received and pased on to <%PARAM[3]%> for further processing, the details follow:

Start Date: <%PARAM[1]%>

End Date: <%PARAM[2]%>

Application Type: <%PARAM[7]%>

Duration: <%PARAM[8]%> <%PARAM[9]%>

Status: <%PARAM[10]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Training - Completed', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Training Application', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your training application has been <%PARAM[4]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Start Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[1]%></td></tr><tr><td style="text-align: right">End Date</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Application Type</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Duration</td><td></td><td><%PARAM[8]%> <%PARAM[9]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[10]%></td></tr></table>', 'Dear <%PARAM[0]%>,

This is to inform you that your training application has been <%PARAM[4]%>, the details follow:

Start Date: <%PARAM[1]%>

End Date: <%PARAM[2]%>

Application Type: <%PARAM[7]%> 

Duration: <%PARAM[9]%>

Status: <%PARAM[10]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Training - Actioned', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Training Application', '<p>Dear <%PARAM[6]%>,<br /></p><p>This is to inform you that your training application task has been processed by <%PARAM[5]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Originator</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Start Date</td><td></td><td><%PARAM[1]%></td></tr><tr><td style="text-align: right">End Date</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Application Type</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Duration</td><td></td><td><%PARAM[8]%> <%PARAM[9]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[10]%></td></tr></table>', 'Dear <%PARAM[6]%>,

This is to inform you that your training application task has been processed by <%PARAM[5]%>, the details follow:

Originator: <%PARAM[0]%>

Start Date: <%PARAM[1]%>

End Date: <%PARAM[2]%>

Application Type: <%PARAM[7]%>

Duration: <%PARAM[8]%> <%PARAM[9]%>

Status: <%PARAM[10]%>')

		/* *** Stores Workflow *** */
		/* *********************** */
		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Stores - Inform', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: New Store Application', '<p>Dear <%PARAM[2]%>,<br /></p><p>This is to inform you that you have been assigned to a new asset application, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Originator</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Date</td><td></td><td><%PARAM[1]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">{TABLE:select [ItemDescription] as [Item], [Quantity] as [Qty], [ReturnDate] as [Return On], [Reference] from [StoreIssued] [iss] left outer join [StoresItems] as [itm] on [iss].[CompanyNum] = [itm].[CompanyNum] and [iss].[ItemCode] = [itm].[ItemCode] where ([iss].[PathID] = <%PathID%>) order by [Item]}</td></tr></table>', 'Dear <%PARAM[2]%>,

This is to inform you that you have been assigned to a new asset application, the details follow:

Originator: <%PARAM[0]%>

Date: <%PARAM[1]%>

{TABLE:select [ItemDescription] as [Item], [Quantity] as [Qty], [ReturnDate] as [Return On], [Reference] from [StoreIssued] [iss] left outer join [StoresItems] as [itm] on [iss].[CompanyNum] = [itm].[CompanyNum] and [iss].[ItemCode] = [itm].[ItemCode] where ([iss].[PathID] = <%PathID%>) order by [Item]}')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Stores - Originator', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Store Application', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your asset application has been received and pased on to <%PARAM[2]%> for further processing, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[1]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">{TABLE:select [ItemDescription] as [Item], [Quantity] as [Qty], [ReturnDate] as [Return On], [Reference] from [StoreIssued] [iss] left outer join [StoresItems] as [itm] on [iss].[CompanyNum] = [itm].[CompanyNum] and [iss].[ItemCode] = [itm].[ItemCode] where ([iss].[PathID] = <%PathID%>) order by [Item]}</td></tr></table>', 'Dear <%PARAM[0]%>,

This is to inform you that your asset application has been received and pased on to <%PARAM[2]%> for further processing, the details follow:

Date: <%PARAM[1]%>

{TABLE:select [ItemDescription] as [Item], [Quantity] as [Qty], [ReturnDate] as [Return On], [Reference] from [StoreIssued] [iss] left outer join [StoresItems] as [itm] on [iss].[CompanyNum] = [itm].[CompanyNum] and [iss].[ItemCode] = [itm].[ItemCode] where ([iss].[PathID] = <%PathID%>) order by [Item]}')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Stores - Completed', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Store Application', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your asset application has been <%PARAM[3]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[1]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">{TABLE:select [ItemDescription] as [Item], [Quantity] as [Qty], [ReturnDate] as [Return On], [Reference] from [StoreIssued] [iss] left outer join [StoresItems] as [itm] on [iss].[CompanyNum] = [itm].[CompanyNum] and [iss].[ItemCode] = [itm].[ItemCode] where ([iss].[PathID] = <%PathID%>) order by [Item]}</td></tr></table>', 'Dear <%PARAM[0]%>, 

This is to inform you that your asset application has been <%PARAM[3]%>, the details follow:

Date: <%PARAM[1]%> 

{TABLE:select [ItemDescription] as [Item], [Quantity] as [Qty], [ReturnDate] as [Return On], [Reference] from [StoreIssued] [iss] left outer join [StoresItems] as [itm] on [iss].[CompanyNum] = [itm].[CompanyNum] and [iss].[ItemCode] = [itm].[ItemCode] where ([iss].[PathID] = <%PathID%>) order by [Item]}')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Stores - Actioned', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Store Application', '<p>Dear <%PARAM[5]%>,<br /></p><p>This is to inform you that your asset application task has been processed by <%PARAM[4]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[1]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">{TABLE:select [ItemDescription] as [Item], [Quantity] as [Qty], [ReturnDate] as [Return On], [Reference] from [StoreIssued] [iss] left outer join [StoresItems] as [itm] on [iss].[CompanyNum] = [itm].[CompanyNum] and [iss].[ItemCode] = [itm].[ItemCode] where ([iss].[PathID] = <%PathID%>) order by [Item]}</td></tr></table>', 'Dear <%PARAM[5]%>,

This is to inform you that your asset application task has been processed by <%PARAM[4]%>, the details follow:

Date: <%PARAM[1]%>

{TABLE:select [ItemDescription] as [Item], [Quantity] as [Qty], [ReturnDate] as [Return On], [Reference] from [StoreIssued] [iss] left outer join [StoresItems] as [itm] on [iss].[CompanyNum] = [itm].[CompanyNum] and [iss].[ItemCode] = [itm].[ItemCode] where ([iss].[PathID] = <%PathID%>) order by [Item]}')

		/* *** Loans Workflow *** */
		/* ********************** */
		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Loans - Inform', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: New Loan Application', '<p>Dear <%PARAM[3]%>,<br /></p><p>This is to inform you that you have been assigned to a new loan application, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Originator</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Date</td><td></td><td><%PARAM[1]%></td></tr><tr><td style="text-align: right">Amount</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Interest Rate</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Period</td><td></td><td><%PARAM[8]%></td></tr><tr><td style="text-align: right">First Installment</td><td></td><td><%PARAM[9]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[10]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Remarks</td></tr><tr><td colspan="3"><%PARAM[11]%></td></tr></table>', 'Dear <%PARAM[3]%>,

This is to inform you that you have been assigned to a new loan application, the details follow:

Originator:  <%PARAM[0]%>

Date: <%PARAM[1]%>

Amount: <%PARAM[2]%>

Interest Rate: <%PARAM[7]%>

Period: <%PARAM[8]%>

First Installment: <%PARAM[9]%>

Status: <%PARAM[10]%>

Remarks: <%PARAM[11]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Loans - Originator', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Loan Application', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your loan application has been received and pased on to <%PARAM[3]%> for further processing, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[1]%></td></tr><tr><td style="text-align: right">Amount</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Interest Rate</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Period</td><td></td><td><%PARAM[8]%></td></tr><tr><td style="text-align: right">First Installment</td><td></td><td><%PARAM[9]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[10]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Remarks</td></tr><tr><td colspan="3"><%PARAM[11]%></td></tr></table>', 'Dear <%PARAM[0]%>,

This is to inform you that your loan application has been received and pased on to <%PARAM[3]%> for further processing, the details follow:

Date: <%PARAM[1]%>

Amount: <%PARAM[2]%>

Interest Rate: <%PARAM[7]%>

Period: <%PARAM[8]%>

First Installment: <%PARAM[9]%>

Status: <%PARAM[10]%>

Remarks: <%PARAM[11]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Loans - Completed', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Loan Application', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your loan application has been <%PARAM[4]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[1]%></td></tr><tr><td style="text-align: right">Amount</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Interest Rate</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Period</td><td></td><td><%PARAM[8]%></td></tr><tr><td style="text-align: right">First Installment</td><td></td><td><%PARAM[9]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[10]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Remarks</td></tr><tr><td colspan="3"><%PARAM[11]%></td></tr></table>', 'Dear <%PARAM[0]%>,

This is to inform you that your loan application has been <%PARAM[4]%>, the details follow:

Date: <%PARAM[1]%>

Amount: <%PARAM[2]%>

Interest Rate: <%PARAM[7]%>

Period: <%PARAM[8]%>

First Installment: <%PARAM[9]%>

Status: <%PARAM[10]%>

Remarks: <%PARAM[11]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Loans - Actioned', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Loan Application', '<p>Dear <%PARAM[6]%>,<br /></p><p>This is to inform you that your loan application task has been processed by <%PARAM[5]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Originator</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Date</td><td></td><td><%PARAM[1]%></td></tr><tr><td style="text-align: right">Amount</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Interest Rate</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Period</td><td></td><td><%PARAM[8]%></td></tr><tr><td style="text-align: right">First Installment</td><td></td><td><%PARAM[9]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[10]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Remarks</td></tr><tr><td colspan="3"><%PARAM[11]%></td></tr></table>', 'Dear <%PARAM[6]%>,

This is to inform you that your loan application task has been processed by <%PARAM[5]%>, the details follow:

Originator: <%PARAM[0]%>

Date: <%PARAM[1]%>

Amount: <%PARAM[2]%>

Interest Rate: <%PARAM[7]%>

Period: <%PARAM[8]%>

First Installment: <%PARAM[9]%>

Status: <%PARAM[10]%>

Remarks: <%PARAM[11]%>')

		/* *** Claims Workflow *** */
		/* *********************** */
		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Claims - Inform', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: New Claim Application', '<p>Dear <%PARAM[3]%>,<br /></p><p>This is to inform you that you have been assigned to a new claim application, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Originator</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Date</td><td></td><td><%PARAM[1]%></td></tr><tr><td style="text-align: right">Type</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[7]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Remarks</td></tr><tr><td colspan="3"><%PARAM[8]%></td></tr></table>', 'Dear <%PARAM[3]%>,

This is to inform you that you have been assigned to a new claim application, the details follow:

Originator: <%PARAM[0]%>

Date: <%PARAM[1]%>

Type: <%PARAM[2]%>

Status: <%PARAM[7]%>

Remarks: <%PARAM[8]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Claims - Originator', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Claim Application', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your claim application has been received and pased on to <%PARAM[3]%> for further processing, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[1]%></td></tr><tr><td style="text-align: right">Type</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[7]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Remarks</td></tr><tr><td colspan="3"><%PARAM[8]%></td></tr></table>', 'Dear <%PARAM[0]%>,

This is to inform you that your claim application has been received and pased on to <%PARAM[3]%> for further processing, the details follow:

Date: <%PARAM[1]%>

Type: <%PARAM[2]%>

Status: <%PARAM[7]%>

Remarks: <%PARAM[8]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Claims - Completed', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Claim Application', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your claim application has been <%PARAM[4]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[1]%></td></tr><tr><td style="text-align: right">Type</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[7]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Remarks</td></tr><tr><td colspan="3"><%PARAM[8]%></td></tr></table>', 'Dear <%PARAM[0]%>,

This is to inform you that your claim application has been <%PARAM[4]%>, the details follow:

Date: <%PARAM[1]%>

Type: <%PARAM[2]%>

Status: <%PARAM[7]%>

Remarks: <%PARAM[8]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Claims - Actioned', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Claim Application', '<p>Dear <%PARAM[6]%>,<br /></p><p>This is to inform you that your claim application task has been processed by <%PARAM[5]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Originator</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Date</td><td></td><td><%PARAM[1]%></td></tr><tr><td style="text-align: right">Type</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[7]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Remarks</td></tr><tr><td colspan="3"><%PARAM[8]%></td></tr></table>', 'Dear <%PARAM[6]%>,

This is to inform you that your claim application task has been processed by <%PARAM[5]%>, the details follow:

Originator: <%PARAM[0]%>

Date: <%PARAM[1]%>

Type: <%PARAM[2]%>

Status: <%PARAM[7]%>

Remarks: <%PARAM[8]%>')

		/* *** Cancel Leave Workflow *** */
		/* ***************************** */
		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Cancel: Leave - Inform', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: New Leave Cancellation', '<p>Dear <%PARAM[3]%>,<br /></p><p>This is to inform you that you have been assigned to a new leave cancellation, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Originator</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Start Date</td><td></td><td><%PARAM[1]%></td></tr><tr><td style="text-align: right">End Date</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Application Type</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Duration</td><td></td><td><%PARAM[8]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[9]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Remarks</td></tr><tr><td colspan="3"><%PARAM[10]%></td></tr></table>', 'Dear <%PARAM[3]%>,

This is to inform you that you have been assigned to a new leave cancellation, the details follow:

Originator: <%PARAM[0]%>

Start Date: <%PARAM[1]%>

End Date: <%PARAM[2]%>

Application Type: <%PARAM[7]%>

Duration: <%PARAM[8]%>

Status: <%PARAM[9]%>

Remarks: <%PARAM[10]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Cancel: Leave - Originator', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Leave Cancellation', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your leave cancellation has been received and pased on to <%PARAM[3]%> for further processing, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Start Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[1]%></td></tr><tr><td style="text-align: right">End Date</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Application Type</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Duration</td><td></td><td><%PARAM[8]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[9]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Remarks</td></tr><tr><td colspan="3"><%PARAM[10]%></td></tr></table>', 'Dear <%PARAM[0]%>,

This is to inform you that your leave cancellation has been received and pased on to <%PARAM[3]%> for further processing, the details follow:

Start Date: <%PARAM[1]%>

End Date: <%PARAM[2]%>

Application Type: <%PARAM[7]%>

Duration: <%PARAM[8]%>

Status: <%PARAM[9]%>

Remarks: <%PARAM[10]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Cancel: Leave - Completed', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Leave Cancellation', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your leave cancellation has been <%PARAM[4]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Start Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[1]%></td></tr><tr><td style="text-align: right">End Date</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Application Type</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Duration</td><td></td><td><%PARAM[8]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[9]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Remarks</td></tr><tr><td colspan="3"><%PARAM[10]%></td></tr></table>', 'Dear <%PARAM[0]%>,

This is to inform you that your leave cancellation has been <%PARAM[4]%>, the details follow:

Start Date: <%PARAM[1]%>

End Date: <%PARAM[2]%>

Application Type: <%PARAM[7]%>

Duration: <%PARAM[8]%>

Status: <%PARAM[9]%>

Remarks: <%PARAM[10]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Cancel: Leave - Actioned', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Leave Cancellation', '<p>This is to inform you that your leave cancellation task has been processed by <%PARAM[5]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Originator</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Start Date</td><td></td><td><%PARAM[1]%></td></tr><tr><td style="text-align: right">End Date</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Application Type</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Duration</td><td></td><td><%PARAM[8]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[9]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Remarks</td></tr><tr><td colspan="3"><%PARAM[10]%></td></tr></table>', 'This is to inform you that your leave cancellation task has been processed by <%PARAM[5]%>, 

Originator: <%PARAM[0]%>

Start Date: <%PARAM[1]%>

End Date: <%PARAM[2]%>

Application Type: <%PARAM[7]%>

Duration: <%PARAM[8]%>

Status: <%PARAM[9]%>

Remarks: <%PARAM[10]%>')

		/* *** Cancel Training Workflow *** */
		/* ******************************** */
		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Cancel: Training - Inform', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: New Training Cancellation', '<p>Dear <%PARAM[3]%>,<br /></p><p>This is to inform you that you have been assigned to a new training cancellation, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Originator</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Start Date</td><td></td><td><%PARAM[1]%></td></tr><tr><td style="text-align: right">End Date</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Application Type</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Duration</td><td></td><td><%PARAM[8]%> <%PARAM[9]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[10]%></td></tr></table>', 'Dear <%PARAM[3]%>,

This is to inform you that you have been assigned to a new training cancellation, the details follow:

Originator: <%PARAM[0]%>

Start Date: <%PARAM[1]%>

End Date: <%PARAM[2]%>

Application Type: <%PARAM[7]%>

Duration: <%PARAM[8]%> <%PARAM[9]%>

Status: <%PARAM[10]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Cancel: Training - Originator', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Training Cancellation', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your training cancellation has been received and pased on to <%PARAM[3]%> for further processing, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Start Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[1]%></td></tr><tr><td style="text-align: right">End Date</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Application Type</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Duration</td><td></td><td><%PARAM[8]%> <%PARAM[9]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[10]%></td></tr></table>', 'Dear <%PARAM[0]%>,

This is to inform you that your training cancellation has been received and pased on to <%PARAM[3]%> for further processing, the details follow:

Start Date: : <%PARAM[1]%>

End Date: <%PARAM[2]%>

Application Type: <%PARAM[7]%>

Duration: <%PARAM[8]%> <%PARAM[9]%>

Status: <%PARAM[10]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Cancel: Training - Completed', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Training Cancellation', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your training cancellation has been <%PARAM[4]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Start Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[1]%></td></tr><tr><td style="text-align: right">End Date</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Application Type</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Duration</td><td></td><td><%PARAM[8]%> <%PARAM[9]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[10]%></td></tr></table>', 'Dear <%PARAM[0]%>,

This is to inform you that your training cancellation has been <%PARAM[4]%>, the details follow:

Start Date: <%PARAM[1]%>

End Date: <%PARAM[2]%>

Application Type: <%PARAM[7]%>

Duration: <%PARAM[8]%> <%PARAM[9]%>

Status: <%PARAM[10]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Cancel: Training - Actioned', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Training Cancellation', '<p>Dear <%PARAM[6]%>,<br /></p><p>This is to inform you that your training cancellation task has been processed by <%PARAM[5]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Originator</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Start Date</td><td></td><td><%PARAM[1]%></td></tr><tr><td style="text-align: right">End Date</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Application Type</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Duration</td><td></td><td><%PARAM[8]%> <%PARAM[9]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[10]%></td></tr></table>', 'Dear <%PARAM[6]%>,

This is to inform you that your training cancellation task has been processed by <%PARAM[5]%>, the details follow:

Originator: <%PARAM[0]%>

Start Date: <%PARAM[1]%>

End Date: <%PARAM[2]%>

Application Type: <%PARAM[7]%>

Duration: <%PARAM[8]%> <%PARAM[9]%>

Status: <%PARAM[10]%>')

		/* *** Cancel Stores Workflow *** */
		/* ****************************** */
		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Cancel: Stores - Inform', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: New Store Cancellation', '<p>Dear <%PARAM[2]%>,<br /></p><p>This is to inform you that you have been assigned to a new asset cancellation, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Originator</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Date</td><td></td><td><%PARAM[1]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">{TABLE:select [ItemDescription] as [Item], [Quantity] as [Qty], [ReturnDate] as [Return On], [Reference] from [StoreIssued] [iss] left outer join [StoresItems] as [itm] on [iss].[CompanyNum] = [itm].[CompanyNum] and [iss].[ItemCode] = [itm].[ItemCode] where ([iss].[PathID] = <%PathID%>) order by [Item]}</td></tr></table>', 'Dear <%PARAM[2]%>,

This is to inform you that you have been assigned to a new asset cancellation, the details follow:

Originator: <%PARAM[0]%>

Date: <%PARAM[1]%>

{TABLE:select [ItemDescription] as [Item], [Quantity] as [Qty], [ReturnDate] as [Return On], [Reference] from [StoreIssued] [iss] left outer join [StoresItems] as [itm] on [iss].[CompanyNum] = [itm].[CompanyNum] and [iss].[ItemCode] = [itm].[ItemCode] where ([iss].[PathID] = <%PathID%>) order by [Item]}')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Cancel: Stores - Originator', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Store Cancellation', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your asset cancellation has been received and pased on to <%PARAM[2]%> for further processing, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[1]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">{TABLE:select [ItemDescription] as [Item], [Quantity] as [Qty], [ReturnDate] as [Return On], [Reference] from [StoreIssued] [iss] left outer join [StoresItems] as [itm] on [iss].[CompanyNum] = [itm].[CompanyNum] and [iss].[ItemCode] = [itm].[ItemCode] where ([iss].[PathID] = <%PathID%>) order by [Item]}</td></tr></table>', 'Dear <%PARAM[0]%>,

This is to inform you that your asset cancellation has been received and pased on to <%PARAM[2]%> for further processing, the details follow:

Date: <%PARAM[1]%>

{TABLE:select [ItemDescription] as [Item], [Quantity] as [Qty], [ReturnDate] as [Return On], [Reference] from [StoreIssued] [iss] left outer join [StoresItems] as [itm] on [iss].[CompanyNum] = [itm].[CompanyNum] and [iss].[ItemCode] = [itm].[ItemCode] where ([iss].[PathID] = <%PathID%>) order by [Item]}')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Cancel: Stores - Completed', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Store Cancellation', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your asset cancellation has been <%PARAM[3]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[1]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">{TABLE:select [ItemDescription] as [Item], [Quantity] as [Qty], [ReturnDate] as [Return On], [Reference] from [StoreIssued] [iss] left outer join [StoresItems] as [itm] on [iss].[CompanyNum] = [itm].[CompanyNum] and [iss].[ItemCode] = [itm].[ItemCode] where ([iss].[PathID] = <%PathID%>) order by [Item]}</td></tr></table>', 'Dear <%PARAM[0]%>,

This is to inform you that your asset cancellation has been <%PARAM[3]%>, the details follow:

Date: <%PARAM[1]%>

{TABLE:select [ItemDescription] as [Item], [Quantity] as [Qty], [ReturnDate] as [Return On], [Reference] from [StoreIssued] [iss] left outer join [StoresItems] as [itm] on [iss].[CompanyNum] = [itm].[CompanyNum] and [iss].[ItemCode] = [itm].[ItemCode] where ([iss].[PathID] = <%PathID%>) order by [Item]}')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Cancel: Stores - Actioned', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Store Cancellation', '<p>Dear <%PARAM[5]%>,<br /></p><p>This is to inform you that your asset cancellation task has been processed by <%PARAM[4]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[1]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">{TABLE:select [ItemDescription] as [Item], [Quantity] as [Qty], [ReturnDate] as [Return On], [Reference] from [StoreIssued] [iss] left outer join [StoresItems] as [itm] on [iss].[CompanyNum] = [itm].[CompanyNum] and [iss].[ItemCode] = [itm].[ItemCode] where ([iss].[PathID] = <%PathID%>) order by [Item]}</td></tr></table>', 'Dear <%PARAM[5]%>,

This is to inform you that your asset cancellation task has been processed by <%PARAM[4]%>, the details follow:

Date: <%PARAM[1]%>

{TABLE:select [ItemDescription] as [Item], [Quantity] as [Qty], [ReturnDate] as [Return On], [Reference] from [StoreIssued] [iss] left outer join [StoresItems] as [itm] on [iss].[CompanyNum] = [itm].[CompanyNum] and [iss].[ItemCode] = [itm].[ItemCode] where ([iss].[PathID] = <%PathID%>) order by [Item]}')

		/* *** Cancel Loans Workflow *** */
		/* ***************************** */
		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Cancel: Loans - Inform', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: New Loan Cancellation', '<p>Dear <%PARAM[3]%>,<br /></p><p>This is to inform you that you have been assigned to a new loan cancellation, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Originator</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Date</td><td></td><td><%PARAM[1]%></td></tr><tr><td style="text-align: right">Amount</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Interest Rate</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Period</td><td></td><td><%PARAM[8]%></td></tr><tr><td style="text-align: right">First Installment</td><td></td><td><%PARAM[9]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[10]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Remarks</td></tr><tr><td colspan="3"><%PARAM[11]%></td></tr></table>', 'Dear <%PARAM[3]%>,

This is to inform you that you have been assigned to a new loan cancellation, the details follow:

Originator: <%PARAM[0]%>

Date: <%PARAM[1]%>

Amount: <%PARAM[2]%>

Interest Rate: <%PARAM[7]%>

Period: <%PARAM[8]%>

First Installment: <%PARAM[9]%>

Status: <%PARAM[10]%>

Remarks: <%PARAM[11]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Cancel: Loans - Originator', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Loan Cancellation', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your loan cancellation has been received and pased on to <%PARAM[3]%> for further processing, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[1]%></td></tr><tr><td style="text-align: right">Amount</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Interest Rate</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Period</td><td></td><td><%PARAM[8]%></td></tr><tr><td style="text-align: right">First Installment</td><td></td><td><%PARAM[9]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[10]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Remarks</td></tr><tr><td colspan="3"><%PARAM[11]%></td></tr></table>', 'Dear <%PARAM[0]%>,

This is to inform you that your loan cancellation has been received and pased on to <%PARAM[3]%> for further processing, the details follow:

Date: <%PARAM[1]%>

Amount: <%PARAM[2]%>

Interest Rate: <%PARAM[7]%>

Period: <%PARAM[8]%>

First Installment: <%PARAM[9]%>

Status: <%PARAM[10]%>

Remarks: <%PARAM[11]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Cancel: Loans - Completed', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Loan Cancellation', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your loan cancellation has been <%PARAM[4]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Date</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[1]%></td></tr><tr><td style="text-align: right">Amount</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Interest Rate</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Period</td><td></td><td><%PARAM[8]%></td></tr><tr><td style="text-align: right">First Installment</td><td></td><td><%PARAM[9]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[10]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Remarks</td></tr><tr><td colspan="3"><%PARAM[11]%></td></tr></table>', 'Dear <%PARAM[0]%>,

This is to inform you that your loan cancellation has been <%PARAM[4]%>, the details follow:

Date: <%PARAM[1]%>

Amount: <%PARAM[2]%>

Interest Rate: <%PARAM[7]%>

Period: <%PARAM[8]%>

First Installment: <%PARAM[9]%>

Status: <%PARAM[10]%>

Remarks: <%PARAM[11]%>')

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) values('Cancel: Loans - Actioned', '<server>', 25, null, null, 'Employee Self Service', '<email address>', 'SmartHR: Your Loan Cancellation', '<p>Dear <%PARAM[6]%>,<br /></p><p>This is to inform you that your loan cancellation task has been processed by <%PARAM[5]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right; width: 115px">Originator</td><td style="width: 10px"></td><td style="width: 475px"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Date</td><td></td><td><%PARAM[1]%></td></tr><tr><td style="text-align: right">Amount</td><td></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Interest Rate</td><td></td><td><%PARAM[7]%></td></tr><tr><td style="text-align: right">Period</td><td></td><td><%PARAM[8]%></td></tr><tr><td style="text-align: right">First Installment</td><td></td><td><%PARAM[9]%></td></tr><tr><td style="text-align: right">Status</td><td></td><td><%PARAM[10]%></td></tr><tr><td colspan="3"><br /></td></tr><tr><td colspan="3">Remarks</td></tr><tr><td colspan="3"><%PARAM[11]%></td></tr></table>', 'Dear <%PARAM[6]%>,

This is to inform you that your loan cancellation task has been processed by <%PARAM[5]%>, the details follow:

Originator: <%PARAM[0]%>

Date: <%PARAM[1]%>

Amount: <%PARAM[2]%>

Interest Rate: <%PARAM[7]%>

Period: <%PARAM[8]%>

First Installment: <%PARAM[9]%>

Status: <%PARAM[10]%>

Remarks: <%PARAM[11]%>')

	end

	/*
	if not exists(select top 1 [id] from [EmailLU] where ([Type] like 'IR Performance - %'))
	begin

		/* *** IR Workflow *** */
		/* ******************* */
		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) select top 1 'IR Performance - Inform', [Server], [Port], [Username], [Password], [Name], [Address], 'SmartHR: New Performance Counselling', 'XXX', 'XXX' from [EmailLU]
		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) select top 1 'IR Performance - Originator', [Server], [Port], [Username], [Password], [Name], [Address], 'SmartHR: Your Performance Counselling', 'XXX', 'XXX' from [EmailLU]
		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) select top 1 'IR Performance - Completed', [Server], [Port], [Username], [Password], [Name], [Address], 'SmartHR: Your Performance Counselling', 'XXX', 'XXX' from [EmailLU]
		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) select top 1 'IR Performance - Actioned', [Server], [Port], [Username], [Password], [Name], [Address], 'SmartHR: Your Performance Counselling', 'XXX', 'XXX' from [EmailLU]

	end
	*/

	if not exists(select top 1 [id] from [EmailLU] where ([Type] like 'Onboarding - %'))
	begin

		/* *** Onboarding Workflow *** */
		/* *************************** */

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) select top 1 'Onboarding - Inform', [Server], [Port], [Username], [Password], [Name], [Address], 'SmartHR: New Employee Application', '<p>Dear <%PARAM[1]%>,<br /></p><p>This is to inform you that you have been assigned a new employee approval task, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right">Employee Number</td><td style="width: 10px"></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Employee</td><td></td><td><%PARAM[0]%></td></tr></table><br /><br /><table style="margin: 0px; padding: 5px"><tr><td style="text-align: right">Job Title</td><td></td><td><%PARAM[3]%></td></tr><tr><td style="text-align: right">Cost Centre</td><td></td><td><%PARAM[5]%></td></tr><tr><td style="text-align: right">Appointment Date</td><td></td><td><%PARAM[6]%></td></tr><tr><td style="text-align: right">Appointment Type</td><td></td><td><%PARAM[7]%></td></tr></table><br /><br />', 'Dear <%PARAM[1]%>,

This is to inform you that you have been assigned a new employee approval task, the details follow:

Employee Number: <%PARAM[2]%>

Employee: <%PARAM[0]%>

Job Title: <%PARAM[3]%>

Cost Centre: <%PARAM[5]%>

Appointment Date: <%PARAM[6]%>

Appointment Type: <%PARAM[7]%>' from [EmailLU]

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) select top 1 'Onboarding - Originator', [Server], [Port], [Username], [Password], [Name], [Address], 'SmartHR: Your Application', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your employment application has been received and pased onto <%PARAM[1]%> for further processing, the details follow:</p><table style="margin: 0px; padding: 5px"><tr><td style="text-align: right">Job Title</td><td style="width: 10px"></td><td><%PARAM[3]%></td></tr><tr><td style="text-align: right">Cost Centre</td><td></td><td><%PARAM[5]%></td></tr><tr><td style="text-align: right">Appointment Date</td><td></td><td><%PARAM[6]%></td></tr><tr><td style="text-align: right">Appointment Type</td><td></td><td><%PARAM[7]%></td></tr></table><br /><br />', 'Dear <%PARAM[0]%>,

This is to inform you that your employment application has been received and pased onto <%PARAM[1]%> for further processing, the details follow:

Job Title: <%PARAM[3]%>

Cost Centre: <%PARAM[5]%>

Appointment Date: <%PARAM[6]%>

Appointment Type: <%PARAM[7]%>' from [EmailLU]

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) select top 1 'Onboarding - Completed', [Server], [Port], [Username], [Password], [Name], [Address], 'SmartHR: Your Application', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your employment application has been <%PARAM[9]%>, the details follow:</p><table style="margin: 0px; padding: 5px"><tr><td style="text-align: right">Job Title</td><td style="width: 10px"></td><td><%PARAM[3]%></td></tr><tr><td style="text-align: right">Cost Centre</td><td></td><td><%PARAM[5]%></td></tr><tr><td style="text-align: right">Appointment Date</td><td></td><td><%PARAM[6]%></td></tr><tr><td style="text-align: right">Appointment Type</td><td></td><td><%PARAM[7]%></td></tr></table><br /><br />', 'Dear <%PARAM[0]%>,

This is to inform you that your employment application has been <%PARAM[9]%>, the details follow:

Job Title: <%PARAM[3]%>

Cost Centre: <%PARAM[5]%>

Appointment Date: <%PARAM[6]%>

Appointment Type: <%PARAM[7]%>' from [EmailLU]

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) select top 1 'Onboarding - Actioned', [Server], [Port], [Username], [Password], [Name], [Address], 'SmartHR: Your Employee Application', '<p>Dear <%PARAM[1]%>,<br /></p><p>This is to inform you that your employee approval task has been processed by <%PARAM[10]%>, the details follow:</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right">Employee Number</td><td style="width: 10px"></td><td><%PARAM[2]%></td></tr><tr><td style="text-align: right">Employee</td><td></td><td><%PARAM[0]%></td></tr></table><br /><br /><table style="margin: 0px; padding: 5px"><tr><td style="text-align: right">Job Title</td><td></td><td><%PARAM[3]%></td></tr><tr><td style="text-align: right">Cost Centre</td><td></td><td><%PARAM[5]%></td></tr><tr><td style="text-align: right">Appointment Date</td><td></td><td><%PARAM[6]%></td></tr><tr><td style="text-align: right">Appointment Type</td><td></td><td><%PARAM[7]%></td></tr></table><br /><br />', 'Dear <%PARAM[11]%>,

This is to inform you that your employee approval task has been processed by <%PARAM[10]%>, the details follow:

Employee Num: <%PARAM[2]%>

Employee: <%PARAM[0]%>

Job Title: <%PARAM[3]%>

Cost Centre: <%PARAM[5]%>

Appointment Date: <%PARAM[6]%>

Appointment Type: <%PARAM[7]%>' from [EmailLU]

	end

	if not exists(select top 1 [id] from [EmailLU] where ([Type] like 'Termination - %'))
	begin

		/* *** Termination Workflow *** */
		/* **************************** */

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) select top 1 'Termination - Inform', [Server], [Port], [Username], [Password], [Name], [Address], 'SmartHR: New Employee Termination Request', '<p>Dear <%PARAM[1]%>,<br /></p><p>This is to inform you that you have been assigned a new employee termination request, the details follow</p><table style="margin: 0px; padding: 5px"><tr><td style="text-align: right">Employee Number</td><td style="width: 10px"></td><td style="text-align: left"><%PARAM[2]%></td></tr><tr><td style="text-align: right">Employee</td><td></td><td style="text-align: left"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Job Title</td><td></td><td style="text-align: left"><%PARAM[3]%></td></tr><tr><td style="text-align: right">Cost Centre</td><td></td><td style="text-align: left"><%PARAM[4]%></td></tr><tr><td style="text-align: right">Appointment Date</td><td></td><td style="text-align: left"><%PARAM[5]%></td></tr><tr><td style="text-align: right">Appointment Type</td><td></td><td style="text-align: left"><%PARAM[6]%></td></tr><tr><td style="text-align: right">Termination Date</td><td></td><td style="text-align: left"><%PARAM[7]%></td></tr><tr><td style="text-align: right">Termination Reason</td><td></td><td style="text-align: left"><%PARAM[8]%></td></tr></table><br /><br />', 'Dear <%PARAM[1]%>,

This is to inform you that you have been assigned a new employee termination request, the details follow:

Employee Number: <%PARAM[2]%>

Employee: <%PARAM[0]%>

Job Title: <%PARAM[3]%>

Cost Centre: <%PARAM[4]%>

Appointment Date: <%PARAM[5]%>

Appointment Type: <%PARAM[6]%>

Termination Date: <%PARAM[7]%>

Termination Reason: <%PARAM[8]%>' from [EmailLU]

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) select top 1 'Termination - Originator', [Server], [Port], [Username], [Password], [Name], [Address], 'SmartHR: Your Termination Request', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your employment termination request has been received and pased onto <%PARAM[1]%> for further processing, the details follow</p><table style="margin: 0px; padding: 5px"><tr><td style="text-align: right">Job Title</td><td style="width: 10px"></td><td style="text-align: left"><%PARAM[3]%></td></tr><tr><td style="text-align: right">Cost Centre</td><td></td><td style="text-align: left"><%PARAM[4]%></td></tr><tr><td style="text-align: right">Appointment Date</td><td></td><td style="text-align: left"><%PARAM[5]%></td></tr><tr><td style="text-align: right">Appointment Type</td><td></td><td style="text-align: left"><%PARAM[6]%></td></tr><tr><td style="text-align: right">Termination Date</td><td></td><td style="text-align: left"><%PARAM[7]%></td></tr><tr><td style="text-align: right">Termination Reason</td><td></td><td style="text-align: left"><%PARAM[8]%></td></tr></table><br /><br />', 'Dear <%PARAM[0]%>,

This is to inform you that your employment termination request has been received and pased onto <%PARAM[1]%> for further processing, the details follow:

Job Title: <%PARAM[3]%>

Cost Centre: <%PARAM[4]%>

Appointment Date: <%PARAM[5]%>

Appointment Type: <%PARAM[6]%>

Termination Date: <%PARAM[7]%>

Termination Reason: <%PARAM[8]%>' from [EmailLU]

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) select top 1 'Termination - Completed', [Server], [Port], [Username], [Password], [Name], [Address], 'SmartHR: Your Termination Request', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your termination request has been <%PARAM[9]%>, the details follow:</p><table style="margin: 0px; padding: 5px"><tr><td style="text-align: right">Job Title</td><td style="width: 10px"></td><td style="text-align: left"><%PARAM[3]%></td></tr><tr><td style="text-align: right">Cost Centre</td><td></td><td style="text-align: left"><%PARAM[4]%></td></tr><tr><td style="text-align: right">Appointment Date</td><td></td><td style="text-align: left"><%PARAM[5]%></td></tr><tr><td style="text-align: right">Appointment Type</td><td></td><td style="text-align: left"><%PARAM[6]%></td></tr><tr><td style="text-align: right">Termination Date</td><td></td><td style="text-align: left"><%PARAM[7]%></td></tr><tr><td style="text-align: right">Termination Reason</td><td></td><td style="text-align: left"><%PARAM[8]%></td></tr></table><br /><br />', 'Dear <%PARAM[0]%>,

This is to inform you that your employment termination request has been <%PARAM[9]%>, the details follow:

Job Title: <%PARAM[3]%>

Cost Centre: <%PARAM[4]%>

Appointment Date: <%PARAM[5]%>

Appointment Type: <%PARAM[6]%>

Termination Date: <%PARAM[7]%>

Termination Reason: <%PARAM[8]%>' from [EmailLU]

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) select top 1 'Termination - Actioned', [Server], [Port], [Username], [Password], [Name], [Address], 'SmartHR: Your Employee Termination Request', '<p>Dear <%PARAM[11]%>,<br /></p><p>This is to inform you that your employment termination task has been processed by <%PARAM[10]%>, the details follow</p><table style="margin: 0px; padding: 5px"><tr><td style="text-align: right">Employee Number</td><td style="width: 10px"></td><td style="text-align: left"><%PARAM[2]%></td></tr><tr><td style="text-align: right">Employee</td><td></td><td style="text-align: left"><%PARAM[0]%></td></tr><tr><td style="text-align: right">Job Title</td><td></td><td style="text-align: left"><%PARAM[3]%></td></tr><tr><td style="text-align: right">Cost Centre</td><td></td><td style="text-align: left"><%PARAM[4]%></td></tr><tr><td style="text-align: right">Appointment Date</td><td></td><td style="text-align: left"><%PARAM[5]%></td></tr><tr><td style="text-align: right">Appointment Type</td><td></td><td style="text-align: left"><%PARAM[6]%></td></tr><tr><td style="text-align: right">Termination Date</td><td></td><td style="text-align: left"><%PARAM[7]%></td></tr><tr><td style="text-align: right">Termination Reason</td><td></td><td style="text-align: left"><%PARAM[8]%></td></tr></table><br /><br />', 'Dear <%PARAM[11]%>,

This is to inform you that your employment termination task has been processed by <%PARAM[10]%>, the details follow:

Employee Num: <%PARAM[2]%>

Employee: <%PARAM[0]%>

Job Title: <%PARAM[3]%>

Cost Centre: <%PARAM[4]%>

Appointment Date: <%PARAM[5]%>

Appointment Type: <%PARAM[6]%>

Termination Date: <%PARAM[7]%>

Termination Reason: <%PARAM[8]%>' from [EmailLU]

	end

	if not exists(select top 1 [id] from [EmailLU] where ([Type] like 'Transfer - %'))
	begin

		/* *** Transfer Workflow *** */
		/* ************************* */

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) select top 1 'Transfer - Inform', [Server], [Port], [Username], [Password], [Name], [Address], 'SmartHR: New Employee Transfer Request', '<p>Dear <%PARAM[1]%>,<br /></p><p>This is to inform you that you have been assigned a new employee transfer request, the details follow</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right">Employee Number</td><td style="width: 10px"></td><td style="text-align: left"><%PARAM[2]%></td></tr><tr><td style="text-align: right">Employee</td><td></td><td style="text-align: left"><%PARAM[0]%></td></tr></table><br /><br /><table style="margin: 0px; padding: 5px"><tr style="font-weight: bold; text-align: center"><td>Item</td><td>Changed From</td><td>Changed To</td></tr><tr><td>Company Number</td><td>GetXML(<%PARAM[9]%>?OldCompanyNum)</td><td>GetXML(<%PARAM[9]%>?CompanyNum)</td></tr><tr><td>Job Title</td><td><%PARAM[3]%></td><td>GetXML(<%PARAM[10]%>?JobTitle)</td></tr><tr><td>Job Grade</td><td><%PARAM[4]%></td><td>GetXML(<%PARAM[11]%>?JobGrade)</td></tr><tr><td>Cost Centre</td><td><%PARAM[5]%></td><td>GetXML(<%PARAM[12]%>?CostCentre)</td></tr></table><br /><br />', 'Dear <%PARAM[1]%>,

This is to inform you that you have been assigned a new employee transfer request, the details follow:

Employee Number: <%PARAM[2]%>

Employee: <%PARAM[0]%>

Company Number (from): GetXML(<%PARAM[9]%>?OldCompanyNum)

Company Number (to): GetXML(<%PARAM[9]%>?CompanyNum)

Job Title (from): <%PARAM[3]%>

Job Title (to): GetXML(<%PARAM[10]%>?JobTitle)

Job Grade (from): <%PARAM[4]%>

Job Grade (to): GetXML(<%PARAM[11]%>?JobGrade)

Cost Centre (from): <%PARAM[5]%>

Cost Centre (to): GetXML(<%PARAM[12]%>?CostCentre)' from [EmailLU]

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) select top 1 'Transfer - Originator', [Server], [Port], [Username], [Password], [Name], [Address], 'SmartHR: Your Transfer Request', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your employment transfer request has been received and pased onto <%PARAM[1]%> for further processing, the details follow</p><table style="margin: 0px; padding: 5px"><tr style="font-weight: bold; text-align: center"><td>Item</td><td>Changed From</td><td>Changed To</td></tr><tr><td>Company Number</td><td>GetXML(<%PARAM[9]%>?OldCompanyNum)</td><td>GetXML(<%PARAM[9]%>?CompanyNum)</td></tr><tr><td>Job Title</td><td><%PARAM[3]%></td><td>GetXML(<%PARAM[10]%>?JobTitle)</td></tr><tr><td>Job Grade</td><td><%PARAM[4]%></td><td>GetXML(<%PARAM[11]%>?JobGrade)</td></tr><tr><td>Cost Centre</td><td><%PARAM[5]%></td><td>GetXML(<%PARAM[12]%>?CostCentre)</td></tr></table><br /><br />', 'Dear <%PARAM[0]%>,

This is to inform you that your employment transfer request has been received and pased onto <%PARAM[1]%> for further processing, the details follow:

Company Number (from): GetXML(<%PARAM[9]%>?OldCompanyNum)

Company Number (to): GetXML(<%PARAM[9]%>?CompanyNum)

Job Title (from): <%PARAM[3]%>

Job Title (to): GetXML(<%PARAM[10]%>?JobTitle)

Job Grade (from): <%PARAM[4]%>

Job Grade (to): GetXML(<%PARAM[11]%>?JobGrade)

Cost Centre (from): <%PARAM[5]%>

Cost Centre (to): GetXML(<%PARAM[12]%>?CostCentre)' from [EmailLU]

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) select top 1 'Transfer - Completed', [Server], [Port], [Username], [Password], [Name], [Address], 'SmartHR: Your Transfer Request', '<p>Dear <%PARAM[0]%>,<br /></p><p>This is to inform you that your employment transfer request has been <%PARAM[13]%>, the details follow</p><table style="margin: 0px; padding: 5px"><tr style="font-weight: bold; text-align: center"><td>Item</td><td>Changed From</td><td>Changed To</td></tr><tr><td>Company Number</td><td>GetXML(<%PARAM[9]%>?OldCompanyNum)</td><td>GetXML(<%PARAM[9]%>?CompanyNum)</td></tr><tr><td>Job Title</td><td><%PARAM[3]%></td><td>GetXML(<%PARAM[10]%>?JobTitle)</td></tr><tr><td>Job Grade</td><td><%PARAM[4]%></td><td>GetXML(<%PARAM[11]%>?JobGrade)</td></tr><tr><td>Cost Centre</td><td><%PARAM[5]%></td><td>GetXML(<%PARAM[12]%>?CostCentre)</td></tr></table><br /><br />', 'Dear <%PARAM[0]%>,

This is to inform you that your employment transfer request has been <%PARAM[13]%>, the details follow:

Company Number (from): GetXML(<%PARAM[9]%>?OldCompanyNum)

Company Number (to): GetXML(<%PARAM[9]%>?CompanyNum)

Job Title (from): <%PARAM[3]%>

Job Title (to): GetXML(<%PARAM[10]%>?JobTitle)

Job Grade (from): <%PARAM[4]%>

Job Grade (to): GetXML(<%PARAM[11]%>?JobGrade)

Cost Centre (from): <%PARAM[5]%>

Cost Centre (to): GetXML(<%PARAM[12]%>?CostCentre)' from [EmailLU]

		insert into [EmailLU]([Type], [Server], [Port], [Username], [Password], [Name], [Address], [Subject], [Body], [BodyText]) select top 1 'Transfer - Actioned', [Server], [Port], [Username], [Password], [Name], [Address], 'SmartHR: Your Employee Transfer Request', '<p>Dear <%PARAM[15]%>,<br /></p><p>This is to inform you that your employee transfer request has been processed by <%PARAM[14]%>, the details follow</p><table style="margin: 0px; padding: 0px"><tr><td style="text-align: right">Employee Number</td><td style="width: 10px"></td><td style="text-align: left"><%PARAM[2]%></td></tr><tr><td style="text-align: right">Employee</td><td></td><td style="text-align: left"><%PARAM[0]%></td></tr></table><br /><br /><table style="margin: 0px; padding: 5px"><tr style="font-weight: bold; text-align: center"><td>Item</td><td>Changed From</td><td>Changed To</td></tr><tr><td>Company Number</td><td>GetXML(<%PARAM[9]%>?OldCompanyNum)</td><td>GetXML(<%PARAM[9]%>?CompanyNum)</td></tr><tr><td>Job Title</td><td><%PARAM[3]%></td><td>GetXML(<%PARAM[10]%>?JobTitle)</td></tr><tr><td>Job Grade</td><td><%PARAM[4]%></td><td>GetXML(<%PARAM[11]%>?JobGrade)</td></tr><tr><td>Cost Centre</td><td><%PARAM[5]%></td><td>GetXML(<%PARAM[12]%>?CostCentre)</td></tr></table><br /><br />', 'Dear <%PARAM[15]%>,

This is to inform you that your employee transfer request has been processed by <%PARAM[14]%>, the details follow:

Company Number (from): GetXML(<%PARAM[9]%>?OldCompanyNum)

Company Number (to): GetXML(<%PARAM[9]%>?CompanyNum)

Job Title (from): <%PARAM[3]%>

Job Title (to): GetXML(<%PARAM[10]%>?JobTitle)

Job Grade (from): <%PARAM[4]%>

Job Grade (to): GetXML(<%PARAM[11]%>?JobGrade)

Cost Centre (from): <%PARAM[5]%>

Cost Centre (to): GetXML(<%PARAM[12]%>?CostCentre)' from [EmailLU]

	end

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[ess.ActionLU]') and objectproperty([id], N'IsUserTable') = 1)
	set identity_insert [ess.ActionLU] on
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ActionLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists(select top 1 [id] from [ess.ActionLU])
	begin
	
		insert into [ess.ActionLU]([id], [ReportsToType]) values(0, 'Start')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(1, 'Appraiser')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(2, 'Alternate Leave Manager')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(3, 'Assistant Manager')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(4, 'Branch Manager')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(5, 'Deleted')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(6, 'Direct Manager')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(7, 'Director')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(8, 'HOD')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(9, 'HR Manager')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(10, 'Leave Manager')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(11, 'Manager')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(12, 'Organogram')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(13, 'Payroll Manager')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(14, 'Performance Administrator')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(15, 'SBU Manager')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(16, 'Supervisor')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(17, 'Team Leader')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(18, 'Timesheet Manager')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(19, 'Training Manager')
		
		/* Additional Roles */
		insert into [ess.ActionLU]([id], [ReportsToType]) values(20, 'PM in Charge')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(21, '1st Approver')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(22, '2nd Approver')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(23, 'HR')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(24, 'Dummy')
		insert into [ess.ActionLU]([id], [ReportsToType]) values(25, 'Appraiser (Self)')
	
	end

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[ess.ActionLU]') and objectproperty([id], N'IsUserTable') = 1)
	set identity_insert [ess.ActionLU] off
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[ess.ActionLU]') and objectproperty([id], N'IsUserTable') = 1)
	insert into [ess.ActionLU]([ReportsToType]) select distinct [ReportsToType] from [ReportsTo] where (not [ReportsToType] in(select distinct [ReportsToType] from [ess.ActionLU]))
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ActionLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists(select top 1 [ID] from [ess.ActionLU] where ([ReportsToType] = 'ESS Notifications'))
		insert into [ess.ActionLU]([ReportsToType]) values('ESS Notifications')

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Menu]') and objectproperty([id], N'IsUserTable') = 1)
begin

	/* TODO: v6.0.74 remove once released (this is only to ensure all new items are created in order) */
	truncate table [ess.Menu]

	if not exists(select top 1 [id] from [ess.Menu])
	begin

		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Tasks', '~/images/left_001.png', 'tasks.aspx', 1, 'Tasks', 0, 0)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Notifications', '~/images/left_002.png', 'notify.aspx', 1, 'Notify Admin', 0, 1)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Personal', '~/images/left_003.png', 'personal.aspx', 1, 'Personal Tab', 0, 2)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Organisational', '~/images/left_004.png', 'organisational.aspx', 1, 'Organisational Tab', 0, 3)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Leave', '~/images/left_005.png', 'leave.aspx', 1, 'Leave History Tab', 0, 4)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Curriculum Vitae', '~/images/left_006.png', 'cv.aspx', 1, 'CV Tab', 0, 5)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Accidents', '~/images/left_007.png', 'accidents.aspx', 1, 'Accident Tab', 0, 6)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Industrial Relations', '~/images/left_008.png', 'ir.aspx', 1, 'I.R. Tab', 0, 7)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Evaluations', '~/images/left_009.png', 'performance.aspx', 1, 'Performance Tab', 1, 8)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Linked Documents', '~/images/left_010.png', 'linkdocs.aspx', 1, 'Linked Documents', 0, 9)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Assets', '~/images/left_011.png', 'assets.aspx', 1, 'Stores/Loans Tab', 0, 10)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Loans', '~/images/left_012.png', 'loans.aspx', 1, 'Stores/Loans Tab', 0, 11)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Training', '~/images/left_013.png', 'training.aspx', 1, 'Training Tab', 0, 12)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Workflow', '~/images/left_014.png', 'workflow.aspx', 1, 'Workflow Manager', 1, 13)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Setup', '~/images/left_015.png', 'setup.aspx', 1, 'ESS Setup', 1, 14)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Staff Locator', '~/images/left_016.png', 'staff.aspx', 1, 'Staff Locator', 1, 15)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('OH&S', '~/images/left_017.png', 'ohs.aspx', 1, 'Occup. Health & Safety Tab', 0, 16)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Reports', '~/images/left_018.png', 'reports.aspx', 1, 'ESS Reports', 1, 17)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Claims', '~/images/left_019.png', 'claims.aspx', 1, 'Claims Module', 1, 19)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Policies', '~/images/left_020.png', 'documentmap.aspx', 1, 'Document Mapping', 0, 20)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Financial', '~/images/left_021.png', 'financial.aspx', 0, 'Pay History Tab', 1, 21)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Pay Info', '~/images/left_021.png', 'pay.aspx', 0, 'Pay History Tab', 1, 22)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Learning Needs', '~/images/left_025.png', 'learn.aspx', 1, 'Learning Needs', 0, 23)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Basic Conditions', '~/images/left_026.png', 'conditions.aspx', 1, 'Basic Conditions', 0, 24)

		/*
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Documentation', '~/images/left_012.png', 'documentation.aspx', 1, 'Documentation', 1, 11)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Recruitment', '~/images/left_022.png', 'recruitment.aspx', 1, 'Recruitment Module', 1, 21)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Requests', '~/images/left_024.png', 'requests.aspx', 1, 'Requests', 0, 23)
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('PD Standards', '~/images/left_024.png', 'pdstandards.aspx', 1, 'Development Tab', 0, 24)
		*/
		
	end

	if not exists(select top 1 [id] from [ess.Menu] where ([LoadURL] = 'homepage.aspx'))
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [LoggedOnUser], [OrderID], [HomeType]) values('Homepage', '~/images/left_022.png', 'homepage.aspx', 1, 1, -1, 255)

	if not exists(select top 1 [id] from [ess.Menu] where ([LoadURL] = 'timesheets.aspx'))
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Timesheets', '~/images/left_023.png', 'timesheets.aspx', 1, 'Timesheet Module', 0, 18)

	if not exists(select top 1 [id] from [ess.Menu] where ([LoadURL] = 'conditions.aspx'))
		insert into [ess.Menu]([Description], [ItemImage], [LoadURL], [Visible], [TemplateElement], [LoggedOnUser], [OrderID]) values('Basic Conditions', '~/images/left_026.png', 'conditions.aspx', 1, 'Basic Conditions', 0, 24)

	update [ess.Menu] set [HomeType] = 0 where ([HomeType] is null)

	update [ess.Menu] set [HomeImage] = '~/images/homepage_001.png', [HomeDescription] = 'Your ''TO DO'' list which includes allocated tasks and shows current and completed tasks...' where ([LoadURL] = 'tasks.aspx')
	update [ess.Menu] set [HomeImage] = '~/images/homepage_002.png', [HomeDescription] = 'Contact HR electronically to ask a question / advise them of any changes to make to your record...' where ([LoadURL] = 'notify.aspx')
	update [ess.Menu] set [HomeImage] = '~/images/homepage_003.png', [HomeDescription] = 'View and update your personal details...' where ([LoadURL] = 'personal.aspx')
	update [ess.Menu] set [HomeImage] = '~/images/homepage_004.png', [HomeDescription] = 'View and update your organisational details...' where ([LoadURL] = 'organisational.aspx')
	update [ess.Menu] set [HomeImage] = '~/images/homepage_005.png', [HomeDescription] = 'Apply on line for leave and view your leave balance...' where ([LoadURL] = 'leave.aspx')
	update [ess.Menu] set [HomeImage] = '~/images/homepage_006.png', [HomeDescription] = 'Keep your CV up to date...' where ([LoadURL] = 'cv.aspx')
	update [ess.Menu] set [HomeImage] = '~/images/homepage_007.png', [HomeDescription] = 'Log work related accidents or near hits...' where ([LoadURL] = 'accidents.aspx')
	update [ess.Menu] set [HomeImage] = '~/images/homepage_008.png', [HomeDescription] = 'Log a Grievance or Disciplinary incident...' where ([LoadURL] = 'ir.aspx')
	update [ess.Menu] set [HomeImage] = '~/images/homepage_009.png', [HomeDescription] = 'Complete or View your performance reviews or Allocate performance reviews to others...' where ([LoadURL] = 'performance.aspx')
	update [ess.Menu] set [HomeImage] = '~/images/homepage_010.png', [HomeDescription] = 'Manage scanned documents that form part of the electronic staff file...' where ([LoadURL] = 'linkdocs.aspx')
	update [ess.Menu] set [HomeImage] = '~/images/homepage_011.png', [HomeDescription] = 'Manage assets and submit new assets online...' where ([LoadURL] = 'assets.aspx')
	update [ess.Menu] set [HomeImage] = '~/images/homepage_012.png', [HomeDescription] = 'View and update your loan details and apply for new loans online...' where ([LoadURL] = 'loans.aspx')
	update [ess.Menu] set [HomeImage] = '~/images/homepage_013.png', [HomeDescription] = 'Review your Planned and Completed Training Records and apply for available training...' where ([LoadURL] = 'training.aspx')
	update [ess.Menu] set [HomeImage] = '~/images/homepage_014.png', [HomeDescription] = 'Maintain the authorisation process flow required for any module with workflow...' where ([LoadURL] = 'workflow.aspx')
	update [ess.Menu] set [HomeImage] = '~/images/homepage_015.png', [HomeDescription] = 'Configure options available to manage both viewing rights and company rules...' where ([LoadURL] = 'setup.aspx')
	update [ess.Menu] set [HomeType] = 1, [HomeImage] = '~/images/homepage_016.png', [HomeDescription] = 'Find out if a person is on leave or on training...' where ([LoadURL] = 'staff.aspx')
	update [ess.Menu] set [HomeImage] = '~/images/homepage_017.png', [HomeDescription] = 'Manage the identification of risks, change of risk profiles as well as accidents and near hits...' where ([LoadURL] = 'ohs.aspx')
	update [ess.Menu] set [Visible] = 1, [HomeType] = 1, [HomeImage] = '~/images/homepage_018.png', [HomeDescription] = 'View and export the reports mapped to your profile...' where ([LoadURL] = 'reports.aspx')
	update [ess.Menu] set [OrderID] = 19, [HomeImage] = '~/images/homepage_019.png', [HomeDescription] = 'Log your claims as per company rules for approval and payment...' where ([LoadURL] = 'claims.aspx')
	update [ess.Menu] set [OrderID] = 20, [HomeImage] = '~/images/homepage_020.png', [HomeDescription] = 'Assign documents to employees that must be read prior to further Employee Self Service activity...' where ([LoadURL] = 'documentmap.aspx')
	update [ess.Menu] set [OrderID] = 21, [HomeImage] = '~/images/homepage_021.png', [HomeDescription] = 'Your basic pay history information as well as benifits...' where ([LoadURL] = 'financial.aspx')
	update [ess.Menu] set [OrderID] = 22, [HomeImage] = '~/images/homepage_021.png', [HomeDescription] = 'Your pay history information...' where ([LoadURL] = 'pay.aspx')
	update [ess.Menu] set [OrderID] = 23, [HomeImage] = '~/images/homepage_025.png', [HomeDescription] = 'Identify Training needs by assigning available courses or creating new courses for an employee or a group of employees...' where ([LoadURL] = 'learn.aspx')
	update [ess.Menu] set [OrderID] = 18, [ItemImage] = '~/images/left_023.png', [HomeImage] = '~/images/homepage_022.png', [HomeDescription] = 'Log timesheets for authorisation and submission for payment (if linked to payroll)...' where ([LoadURL] = 'timesheets.aspx')
	update [ess.Menu] set [OrderID] = 24, [HomeImage] = '~/images/homepage_026.png', [HomeDescription] = 'Manage changes in Conditions of Employment of subordinates...' where ([LoadURL] = 'conditions.aspx')

	/*
	update [ess.Menu] set [HomeImage] = '~/images/homepage_021.png', [HomeDescription] = 'Apply for internal vacancies...' where ([LoadURL] = 'recruitment.aspx')
	update [ess.Menu] set [HomeImage] = '~/images/homepage_024.png', [HomeDescription] = 'Manage projects or tasks assigned to yourself and others...' where ([LoadURL] = 'requests.aspx')
	update [ess.Menu] set [HomeImage] = '~/images/homepage_025.png', [HomeDescription] = 'Manage the development of your career in conjunction with the goals of your company...' where ([LoadURL] = 'pdstandards.aspx')
	update [ess.Menu] set [HomeImage] = '~/images/homepage_012.png', [HomeDescription] = 'View and print or save the latest HR policies, procedures and forms...' where ([LoadURL] = 'documentation.aspx')
	*/

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ModuleLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists(select top 1 [id] from [ess.ModuleLU])
	begin

		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('Tasks', 'Tasks')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('Notifications', 'Notify Admin')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('Personal', 'Personal Tab')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('Organisational', 'Organisational Tab')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('Leave', 'Leave History Tab')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('CV', 'CV Tab')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('Accident', 'Accident Tab')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('IR', 'I.R. Tab')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('Evaluations', 'Performance Tab')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('Linked Documents', 'Linked Documents')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('Assets & Loans', 'Stores/Loans Tab')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('Documentation', 'Stores/Loans Tab')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('Timesheets', 'Timesheet Module')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('Training', 'Training Tab')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('Workflow', 'Workflow Manager')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('Setup', 'ESS Setup')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('Staff Locator', 'Staff Locator')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('OH&S', 'Occup. Health & Safety Tab')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('Reports', 'ESS Reports')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('Claims', 'Claim Module')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('Document Mapping', 'Document Mapping')
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('Other', null)
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('General', null)
		insert into [ess.ModuleLU]([Description], [TemplateElement]) values('Requests', null)
	
	end

	update [ess.ModuleLU] set [TemplateElement] = 'Tasks' where ([Description] = 'Tasks' and [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = 'Notify Admin' where ([Description] = 'Notifications' and [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = 'Personal Tab' where ([Description] = 'Personal' and [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = 'Organisational Tab' where ([Description] = 'Organisational' and [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = 'Leave History Tab' where ([Description] = 'Leave' and [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = 'CV Tab' where ([Description] = 'CV' and [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = 'Accident Tab' where ([Description] = 'Accident' and [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = 'I.R. Tab' where ([Description] = 'IR' and [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = 'Performance Tab' where ([Description] = 'Evaluations' and [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = 'Linked Documents' where ([Description] = 'Linked Documents' and [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = 'Stores/Loans Tab' where ([Description] = 'Assets & Loans' and [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = null where ([Description] = 'Documentation' and not [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = 'Timesheet Module' where ([Description] = 'Timesheets' and [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = 'Training Tab' where ([Description] = 'Training' and [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = 'Workflow Manager' where ([Description] = 'Workflow' and [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = 'ESS Setup' where ([Description] = 'Setup' and [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = 'Staff Locator' where ([Description] = 'Staff Locator' and [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = 'Occup. Health & Safety Tab' where ([Description] = 'OH&S' and [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = 'ESS Reports' where ([Description] = 'Reports' and [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = 'Claims Module' where ([Description] = 'Claims' and [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = 'Document Mapping' where ([Description] = 'Document Mapping' and [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = null where ([Description] = 'Other' and not [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = null where ([Description] = 'General' and not [TemplateElement] is null)
	update [ess.ModuleLU] set [TemplateElement] = null where ([Description] = 'Requests' and not [TemplateElement] is null)

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[ess.PALU]') and objectproperty([id], N'IsUserTable') = 1)
	set identity_insert [ess.PALU] on
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.PALU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists(select top 1 [id] from [ess.PALU])
	begin

		insert into [ess.PALU]([id], [PostActionType]) values(0, 'Start')
		insert into [ess.PALU]([id], [PostActionType]) values(1, 'Actioned')
		insert into [ess.PALU]([id], [PostActionType]) values(2, 'Appraised')
		insert into [ess.PALU]([id], [PostActionType]) values(3, 'Approved')
		insert into [ess.PALU]([id], [PostActionType]) values(4, 'Audited')
		insert into [ess.PALU]([id], [PostActionType]) values(5, 'Completed')
		insert into [ess.PALU]([id], [PostActionType]) values(6, 'Pending')
		insert into [ess.PALU]([id], [PostActionType]) values(7, 'Rejected')

	end	

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[ess.PALU]') and objectproperty([id], N'IsUserTable') = 1)
	set identity_insert [ess.PALU] off
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.PolicyGroups]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists(select top 1 [ID] from [ess.PolicyGroups])
	begin

		insert into [ess.PolicyGroups]([Name], [Description]) values('eSecurity', 'This group policy is used for all security related policy configurations.')
		insert into [ess.PolicyGroups]([Name], [Description]) values('eGeneral', 'This group policy is used for all general related policy configurations.')
		insert into [ess.PolicyGroups]([Name], [Description]) values('eIR', 'This group policy is used for all industrial related policy configurations.')
		insert into [ess.PolicyGroups]([Name], [Description]) values('eTraining', 'This group policy is used for all training policy configurations.')
		insert into [ess.PolicyGroups]([Name], [Description]) values('ePerformance', 'This group policy is used for all performance policy configurations.')
		insert into [ess.PolicyGroups]([Name], [Description]) values('ePersonal', 'This group policy is used for all personal policy configurations.')
		insert into [ess.PolicyGroups]([Name], [Description]) values('eOrganizational', 'This group policy is used for all organizational policy configurations.')
		insert into [ess.PolicyGroups]([Name], [Description]) values('eLeave', 'This group policy is used for all leave policy configurations.')

	end

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Policy]') and objectproperty([id], N'IsUserTable') = 1)
begin

	/* TODO: v6.0.74 remove once released (this is only to ensure all new items are created in order) */
	--truncate table [ess.Policy]

	if not exists(select top 1 [ID] from [ess.Policy])
	begin

		/****************************************
			*** Policy Types (eSecurity) ***
		****************************************/
		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(1, 5, 3, 5, 3, 'Information', 'This security setting determines whether the connection information is displayed on the main logon screen.

		If this policy is enabled, the user will see to which server and database the application is connecting to.

		Default:

		Disabled on new installations.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(1, 5, 3, 5, 3, 'Strict', 'This security setting determines whether passwords must meet complexity requirements.

		If this policy is enabled, passwords must meet the following minimum requirements:

		Be at least six characters in length
		Contain characters from three of the following four categories:
		English uppercase characters (A through Z)
		English lowercase characters (a through z)
		Base 10 digits (0 through 9)
		Non-alphabetic characters (for example, !, @, #, $, %, ^, &, *, (, ), {, }, [, ], |, \, ~, `, <, >, ?)
		Complexity requirements are enforced when passwords are changed or created.

		Default:

		Disabled on new installations.

		Note:

		By default, member computers follow the configuration of their domain controllers.')
		/*
		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(1, 5, 3, 5, 3, 'Signup', 'This security policy determins if the end user will be allowed to see the ''Signup'' button on the main logon screen.

		Default:

		Disabled on new installations.

		Note:

		If this policy is enabled, then the required ''Company'' and ''Permission'' policy items also needs to be configured, otherwise the ''Signup'' button will not be displayed even when enabling this policy.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [LookupTable], [LookupText], [LookupValue]) values(1, 6, 13, 6, 13, 'Company', 'This security policy determins the company that will be used to assign to new user registrations.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''Signup'' policy is enabled.', '[Company]', '[CompanyName]', '[CompanyNum]')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [LookupTable], [LookupText], [LookupValue]) values(1, 6, 13, 6, 13, 'Permission', 'This security policy determins the permission template that will be used to assign to new user registrations.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''Signup'' policy is enabled.', '[UserGroupTemplates]', '[Name]', '[Code]')
		*/
		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Int], [IntMin], [IntMax]) values(1, 18, 9, 18, 9, 'MinLength', 'This security setting determines the least number of characters that a password for a user account may contain. You can set a value of between 1 and 14 characters, or you can establish that no password is required by setting the number of characters to 0.

		Default:

		8 on new installations.

		Note:

		By default, member computers follow the configuration of their domain controllers.', 8, 0, 14)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(1, 5, 3, 5, 3, 'ADEnabled', 'This security setting determines whether usernames and passwords are validated against an active directory store.

		If this policy is enabled, then the user will have to supply their windows username and password to logon to the system, which will then be validated against the active directory store.

		Default:

		Disabled on new installations.

		Note:

		If this policy is enabled, then the required ''ADServer'' policy item also needs to be configured. The configuration of passwords do not apply to this authentication type as this is controlled by the active directory domain controllers.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(1, 5, 3, 5, 3, 'ADLogon', 'This security setting determines whether usernames and passwords are validated against an active directory store for the current logged on user.

		If this policy is enabled, then the user will be allowed to automatically logon to the system without having to supply their windows username and password.

		Default:

		Disabled on new installations.

		Note:

		If this policy is enabled, then the required ''ADServer'' policy item also needs to be configured. The configuration of passwords do not apply to this authentication type as this is controlled by the active directory domain controllers.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(1, 19, 13, 19, 13, 'ADServer', 'This security setting determines the active directory store to use for username and password validation.

		If this policy is configured, then the username and password will be validated against this active directory store.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ADEnabled'' or ''ADLogon'' policy is enabled.')
		/*
		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(1, 5, 3, 5, 3, 'ResetSMS', 'This security setting specifies whether to send a mobile text message to the user that contains the newly reset password.

		Default:

		Disabled on new installations.')
		*/
		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(1, 5, 3, 5, 3, 'UseProxy', 'This security setting specifies whether to use a proxy server when an external connection needs to be established to the internet.

		Default:

		Disabled on new installations.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(1, 19, 13, 19, 13, 'ProxyAddress', 'This security setting specifies a proxy address to use when an external connection needs to be established to the internet.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''UseProxy'' policy is enabled. If this policy is configured, then the required ''ProxyPort'' policy item also needs to be configured, otherwise the ''UseProxy'' policy will ignore the Address and Port settings.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(1, 18, 9, 18, 9, 'ProxyPort', 'This security setting specifies the port on the proxy address server to use when an external connection needs to be established to the internet.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''UseProxy'' policy is enabled.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(1, 19, 13, 19, 13, 'ProxyUsername', 'This security setting specifies a proxy username to use when an external connection needs to be established to the internet.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''UseProxy'' policy is enabled. If this policy is configured, then the required ''ProxyPassword'' policy item also needs to be configured, otherwise the ''UseProxy'' policy will ignore the Username and Password settings.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(1, 19, 13, 19, 13, 'ProxyPassword', 'This security setting specifies a proxy password to use when an external connection needs to be established to the internet.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''UseProxy'' policy is enabled.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(1, 19, 13, 19, 13, 'ProxyDomain', 'This security setting specifies a proxy domain to use when an external connection needs to be established to the internet.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''UseProxy'' policy is enabled.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(1, 5, 3, 5, 3, 'ErrorLogs', 'This setting determines whether errors on the ESS should be emailed through to the local IT support or configured department.

		If this policy is enabled, then any failure on the ESS will be sent through to the local IT department as configured in the appropreate policies.

		Default:

		Disabled on new installations.

		Note:

		If this policy is enabled, then the required ''ErrorFrom'', ''ErrorTo'', ''ErrorSmtp'', ''ErrorPort'' policy items also needs to be configured.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(1, 19, 13, 19, 13, 'ErrorFrom', 'This setting specifies the from email address to use when sending error logs via email.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ErrorLogs'' policy is enabled.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(1, 19, 13, 19, 13, 'ErrorTo', 'This setting specifies the to email address to use when sending error logs via email.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ErrorLogs'' policy is enabled. This policy can contain a comma seperated list e.g. it@company.com, errors@absalomsystems.com')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(1, 19, 13, 19, 13, 'ErrorSmtp', 'This setting specifies the smtp server ip / address to be used when sending error logs via email.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ErrorLogs'' policy is enabled.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(1, 18, 9, 18, 9, 'ErrorPort', 'This setting specifies the port on the smtp server ip / address to use when sending error logs via email.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ErrorLogs'' policy is enabled.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(1, 19, 13, 19, 13, 'ErrorUsername', 'This setting specifies the username when connecting to the smtp server ip / address to enable sending error logs via email.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ErrorLogs'' policy is enabled.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(1, 19, 13, 19, 13, 'ErrorPassword', 'This setting specifies the password when connecting to the smtp server ip / address to enable sending error logs via email.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ErrorLogs'' policy is enabled.')

		/***************************************
			*** Policy Types (eGeneral) ***
		***************************************/
		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Text]) values(2, 19, 13, 19, 13, 'Dropdown', 'This setting determines the format used for display purposes where the access to list employee details should be shown.

		Default:

		''<%Surname%>, <%PreferredName%>'' on new installations.

		Note:

		This policy can contain the following fields (<%CompanyNum%>, <%EmployeeNum%>, <%UserGroup%>, <%Surname%>, <%PreferredName%>, <%FirstName%>, <%DeptName%>, <%CompanyName%>, <%Division%>, <%SubDivision%>, <%SubSubDivision%>).', '<%Surname%>, <%PreferredName%>')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [YesNo]) values(2, 5, 3, 5, 3, 'ShowAge', 'This setting determines if the age is shown next to the persons name that is being managed.

		Default:

		Enabled on new installations.', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Text], [Cascade]) values(2, 19, 13, 19, 13, 'DateFormat', 'This setting specifies the date format to be used when displaying date items on grids and date driven controls.

		Default:

		dd/MM/yyyy on new installations.', 'dd/MM/yyyy', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(2, 5, 3, 5, 3, 'PersonalChange', 'This setting determines if the employee should be able to change any form field visible on the personal module.

		Default:

		Disabled on new installations.', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(2, 5, 3, 5, 3, 'PersonalLogChange', 'This setting determines if any changes made by the employee to any form field visible on the personal module should be logged in the history log section.

		Default:

		Disabled on new installations.', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(2, 5, 3, 5, 3, 'OrganizationalChange', 'This setting determines if the employee should be able to change any form field visible on the organizational module.

		Default:

		Disabled on new installations.', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(2, 5, 3, 5, 3, 'OrganizationalLogChange', 'This setting determines if any changes made by the employee to any form field visible on the organizational module should be logged in the history log section.

		Default:

		Disabled on new installations.', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(2, 5, 3, 5, 3, 'Homepage', 'This setting determines if the homepage should be shown the first time an employee logs onto the ESS.

		Default:

		Disabled on new installations.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(2, 19, 13, 19, 13, 'SMSAppID', 'This setting specifies the user account to use when enabling SMS sending through the ESS.

		Default:

		Not configured on new installations.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(2, 19, 13, 19, 13, 'SMSCode', 'This setting specifies the account code to use when enabling SMS sending through the ESS.

		Default:

		Not configured on new installations.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(2, 19, 13, 19, 13, 'SMSCodePwd', 'This setting specifies the account password to use when enabling SMS sending through the ESS.

		Default:

		Not configured on new installations.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(2, 18, 9, 18, 9, 'SMSCountry', 'This setting specifies the country code to use as a default replacement on cellphone numbers that do not conform to international format.

		Default:

		Not configured on new installations.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(2, 19, 13, 19, 13, 'SMSURL', 'This setting specifies the URL to use when you wish the receive SMS delivery status when sending SMS messages through the ESS.

		Default:

		Not configured on new installations.')

		/*******************************************
				*** Policy Types (eIR) ***
		*******************************************/
		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(3, 5, 3, 5, 3, 'Discipline', 'This setting specifies if discipline recors should be hidden once there is a end date linked to the record.

		Default:

		Disabled on new installations.', 1)

		/****************************************
			*** Policy Types (eTraining) ***
		****************************************/
		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(4, 5, 3, 5, 3, 'OnOffer', 'This setting specifies whether training courses should only display those courses that are marked as on offer on grids and related controls.

		Default:

		Disabled on new installations.')

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(4, 5, 3, 5, 3, 'DeleteCancel', 'This setting specifies whether the training application should be deleted once the cancellation has been approved.

		Default:

		Disabled on new installations.', 1)

		/******************************************
			*** Policy Types (ePerformance) ***
		******************************************/
		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(5, 5, 3, 5, 3, 'DisplayNames', 'This setting specifies whether performance items in the tasks module should hide the names for the current and previous locations.

		Default:

		Disabled on new installations.', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(5, 5, 3, 5, 3, 'ShowScore', 'This setting specifies whether the score should be shown at the bottom of each evaluation form being completed.

		Default:

		Disabled on new installations.

		Note:

		Scores will be calculated at runtime as the evaluation is completed.', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(5, 5, 3, 5, 3, 'AutoCalcWeight', 'This setting specifies whether weights are automatically calculated for KPA and CSE items (sets the weight for each item to the 100 devide by the number of items).

		Default:

		Disabled on new installations.', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(5, 5, 3, 5, 3, 'SchemeCode', 'This setting specifies whether to only load schemes where the scheme code is in the users access to list.

		Default:

		Disabled on new installations.', 1)
		/*
		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(5, 5, 3, 5, 3, 'ShowScorePerc', 'This setting specifies whether the score shown at the bottom of the screen should be shown as a percentage % or if is should be shown as a rating which excludes the percentage % symbol.

		Default:

		The Percentage % symbol will be shown.

		Note:

		This policy depends on if the ''ShowScore'' policy is enabled.', 1)
		*/
		/****************************************
			*** Policy Types (ePersonal) ***
		****************************************/
		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 21, 18, 'OtherLanguage', 'dgView_001', 'Other languages', 'This setting specifies whether the other languages grid in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 21, 18, 'NextOfKin', 'dgView_002', 'Next of kin', 'This setting specifies whether the next of kin grid in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 21, 18, 'Dependants', 'dgView_003', 'Dependants', 'This setting specifies whether the dependants grid in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'EmployeeNum', 'txtEmployeeNum', 'Employee number', 'This setting specifies whether the employee number field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'PreferredName', 'txtPreferredName', 'Preferred name', 'This setting specifies whether the preferred name field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [LookupTable], [LookupText], [LookupValue], [Visible], [Cascade]) values(6, 5, 3, 6, 13, 'Title', 'cmbTitle', 'Title', 'This setting specifies whether the title field in the personal module should be displayed.

		Default:

		Enabled on new installations.', '[Personnel]', '[Title]', '[Title]', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'FirstName', 'txtFirstName', 'First name', 'This setting specifies whether the first name field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'Surname', 'txtSurname', 'Surname', 'This setting specifies whether the surname field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'IDNum', 'txtIDNum', 'ID / Passport number', 'This setting specifies whether the id / passport number field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [LookupTable], [LookupText], [LookupValue], [Visible], [Cascade]) values(6, 5, 3, 6, 13, 'Sex', 'cmbSex', 'Gender', 'This setting specifies whether the gender field in the personal module should be displayed.

		Default:

		Enabled on new installations.', '[SexLU]', '[Sex]', '[Sex]', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [LookupTable], [LookupText], [LookupValue], [Visible], [Cascade]) values(6, 5, 3, 6, 13, 'Nationality', 'cmbNationality', 'Nationality', 'This setting specifies whether the nationality field in the personal module should be displayed.

		Default:

		Enabled on new installations.', '[NationalityLU]', '[Nationality]', '[Nationality]', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 7, 15, 'BirthDate', 'dteBirthDate', 'Birth date', 'This setting specifies whether the birth date field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [LookupTable], [LookupText], [LookupValue], [Visible], [Cascade]) values(6, 5, 3, 6, 13, 'Language', 'cmbLanguage', 'Language', 'This setting specifies whether the language field in the personal module should be displayed.

		Default:

		Enabled on new installations.', '[LanguageLU]', '[Language]', '[Language]', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [LookupTable], [LookupText], [LookupValue], [Visible], [Cascade]) values(6, 5, 3, 6, 13, 'Religion', 'cmbReligion', 'Religion', 'This setting specifies whether the religion field in the personal module should be displayed.

		Default:

		Enabled on new installations.', '[ReligionLU]', '[Religion]', '[Religion]', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [LookupTable], [LookupText], [LookupValue], [Visible], [Cascade]) values(6, 5, 3, 6, 13, 'EthnicGroup', 'cmbEthnicGroup', 'Ethnic group', 'This setting specifies whether the ethnic group field in the personal module should be displayed.

		Default:

		Enabled on new installations.', '[EthnicLU]', '[EthnicGroup]', '[EthnicGroup]', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [LookupTable], [LookupText], [LookupValue], [Visible], [Cascade]) values(6, 5, 3, 6, 13, 'MaritalStatus', 'cmbMaritalStatus', 'Marital status', 'This setting specifies whether the marital status field in the personal module should be displayed.

		Default:

		Enabled on new installations.', '[MStatusLU]', '[MaritalStatus]', '[MaritalStatus]', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [LookupTable], [LookupText], [LookupValue], [Visible], [Cascade]) values(6, 5, 3, 6, 13, 'Disability', 'cmbDisability', 'Disability', 'This setting specifies whether the disability field in the personal module should be displayed.

		Default:

		Enabled on new installations.', '[DisabilityLU]', '[Disability]', '[Disability]', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'DisabilityNotes', 'txtDisabilityNotes', 'Disability notes', 'This setting specifies whether the disability notes field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'Address1', 'txtAddress1', 'Address line 1', 'This setting specifies whether the address line 1 field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'Address2', 'txtAddress2', 'Address line 2', 'This setting specifies whether the address line 2 field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'Address3', 'txtAddress3', 'Address line 3', 'This setting specifies whether the address line 3 field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'Address4', 'txtAddress4', 'Address line 4', 'This setting specifies whether the address line 4 field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'POBox', 'txtPOBox', 'P.O. Box', 'This setting specifies whether the po box field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'POArea', 'txtPOArea', 'Postal area', 'This setting specifies whether the postal area field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'POCode', 'txtPOCode', 'Postal code', 'This setting specifies whether the postal code field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'OfficeNo', 'txtOfficeNo', 'Work number', 'This setting specifies whether the work number field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'ExtensionNo', 'txtExtensionNo', 'Phone extension', 'This setting specifies whether the phone extension field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Validation], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'CellTel', 'txtCellTel', 'Mobile number', 'This setting specifies whether the mobile number field in the personal module should be displayed.

		Default:

		Enabled on new installations.', '[^0*]([0-9]*)', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'HomeTel', 'txtHomeTel', 'Home number', 'This setting specifies whether the home number field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Validation], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'EmailAddress', 'txtEmailAddress', 'Email address', 'This setting specifies whether the email address field in the personal module should be displayed.

		Default:

		Enabled on new installations.', '\w+([-+.'']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'SpouseName', 'txtSpouseName', 'Spouse name', 'This setting specifies whether the spouse name field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'SpouseTel', 'txtSpouseTel', 'Spouse number', 'This setting specifies whether the spouse number field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		/*********************************************
			*** Policy Types (eOrganizational) ***
		*********************************************/
		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Visible], [Cascade]) values(7, 5, 3, 6, 13, 'JobTitle', 'cmbJobTitle', 'Job title', 'This setting specifies whether the job title field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', '[JobTitle]', '[JobTitle]', '[JobTitle]', '[CompanyNum] = ''<%CompanyNum%>''', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Visible], [Cascade]) values(7, 5, 3, 6, 13, 'JobGrade', 'cmbJobGrade', 'Job grade', 'This setting specifies whether the job grade field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', '[JobGrade]', '[JobGrade]', '[JobGrade]', '[CompanyNum] = ''<%CompanyNum%>''', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Visible], [Cascade]) values(7, 5, 3, 6, 13, 'CostCentre', 'cmbCostCentre', 'Cost centre', 'This setting specifies whether the cost centre field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', '[CostCentreLU]', '[CostCentre]', '[CostCentre]', '[CompanyNum] = ''<%CompanyNum%>''', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(7, 5, 3, 2, 13, 'CostCentreAlloc', 'cmdCostCentre', 'Cost centre', 'This setting specifies whether the cost centre allocation field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Visible], [Cascade]) values(7, 5, 3, 6, 13, 'DeptName', 'cmbDeptName', 'Department', 'This setting specifies whether the department field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', '[Department]', '[DeptName]', '[DeptName]', '[CompanyNum] = ''<%CompanyNum%>''', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [LookupTable], [LookupText], [LookupValue], [Visible], [Cascade]) values(7, 5, 3, 6, 13, 'Skill_Level', 'cmbSkill_Level', 'Occupational category', 'This setting specifies whether the occupational category field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', '[OccupCategoryLU]', '[OccupCategory]', '[OccupCategory]', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [LookupTable], [LookupText], [LookupValue], [Visible], [Cascade]) values(7, 5, 3, 6, 13, 'Appointype', 'cmbAppointype', 'Appointment type', 'This setting specifies whether the appointment type field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', '[AppointmentTypeLU]', '[AppointmentType]', '[AppointmentType]', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [LookupTable], [LookupText], [LookupValue], [Visible], [Cascade]) values(7, 5, 3, 6, 13, 'Position', 'cmbPosition', 'Position', 'This setting specifies whether the position field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', '[PositionLU]', '[Position]', '[Position]', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Visible], [Cascade]) values(7, 5, 3, 6, 13, 'Location', 'cmbLocation', 'Location', 'This setting specifies whether the location field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', '[LocationLU]', '[Location]', '[Location]', '[CompanyNum] = ''<%CompanyNum%>''', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(7, 5, 3, 7, 15, 'DateJoinedGroup', 'dteDateJoinedGroup', 'Date joined group', 'This setting specifies whether the date joined group field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(7, 5, 3, 7, 15, 'Appointdate', 'dteAppointdate', 'Appointment date', 'This setting specifies whether the appointment date field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(7, 5, 3, 19, 13, 'YearsServiceG', 'txtYearsServiceG', 'Years of service (group)', 'This setting specifies whether the years of service (group) field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(7, 5, 3, 19, 13, 'YearsServiceA', 'txtYearsServiceA', 'Years of service (appointment)', 'This setting specifies whether the years of service (appointment) field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Visible], [Cascade]) values(7, 5, 3, 21, 18, 'ReportsTo', 'dgView', 'Reports to', 'This setting specifies whether the reports to grid in the organizational module should be displayed.

		Default:

		Enabled on new installations.', '[ReportsTo]', '[ReportsToName], [ReportsToType]', '[ReportsToValue]', '[CompanyNum] = ''<%CompanyNum%>'' and [EmployeeNum] = ''<%EmployeeNum%>''', 1, 1)

		/*******************************************
				*** Policy Types (eLeave) ***
		*******************************************/
		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 19, 13, 19, 13, 'Dropdown', 'This setting allows you to exclude specific leave types from the dropdown list of available leave types.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to hide a specific leave type, even if the employee may have access to that particular leave type. This policy can contain a comma seperated list e.g. Sick, Study', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 19, 13, 19, 13, 'BalanceGrid', 'This setting allows you to exclude specific leave types from the leave balances grid.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to hide a specific leave type, even if the employee may have access to that particular leave type. This policy can contain a comma seperated list e.g. Sick, Study', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Text], [Cascade]) values(8, 19, 13, 19, 13, 'BalanceGridColumns', 'This setting allows you to exclude specific columns from the leave balances grid.

		Default:

		Unit Type, Accum Balance, Total Accrual, Future Taken

		Note:

		When using this policy you can configure to hide a specific column in the leave balances grid, even if the employee may have access to that particular column (the items specified should match the names of the column headers). This policy can contain a comma seperated list e.g. Type, Unit Type, As At', 'Unit Type, Accum Balance, Total Accrual, Future Taken', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [LookupTable], [LookupText], [LookupValue], [Cascade]) values(8, 6, 13, 6, 13, 'Default', 'This setting allows you to set a specific leave type to be selected on the application dropdown list the first time the employee opens the leave screen.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to automatically select the leave type the first time the employee opens the leave application screen. This policy can only contain one leave type', 'LeaveLU', 'LeaveType', 'LeaveType', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 19, 13, 19, 13, 'Negative', 'This setting allows you to specify which leave types are allowed to go into a negative balance when the employee applies for leave.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to allow a specific leave type to go into a negative balance. This policy can contain a comma seperated list e.g. Sick, Study', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 19, 13, 19, 13, 'ShiftTypes', 'This setting allows you to specify which shift types adds +0.5 to the leave duration for each leave day applied for by the employee.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to add +0.5 days for each leave day for a specific shift type. This policy can contain a comma seperated list e.g. 10 - Hour Shift, 12 - Hour Shift', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 19, 13, 19, 13, 'ShiftLeaveTypes', 'This setting allows you to specify which leave types adds +0.5 to the leave duration for each leave day applied for by the employee.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to add +0.5 days for each leave day for a leave type. This policy depends on the values as setup in the ''ShiftTypes'' policy. This policy can contain a comma seperated list e.g. Sick, Study', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 19, 13, 19, 13, 'FridayRule', 'This setting allows you to specify which leave types adds +1 to the leave duration for each leave day applied for by the employee that falls on a friday.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to add +1 day for each leave day for a leave type that falls on a friday. This policy can contain a comma seperated list e.g. Sick, Study', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 5, 3, 5, 3, 'SaturdayRule', 'This setting specifies whether a saterday should be calculated as 0.5 days duration on any leave type if the application falls on a saturday.

		Default:

		Disabled on new installations.', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 5, 3, 5, 3, 'LeaveBlock', 'This setting specifies whether the leave blocking section in the leave module should be enabled.

		Default:

		Disabled on new installations.', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 5, 3, 5, 3, 'DeleteCancel', 'This setting specifies whether the leave application should be deleted once the cancellation has been approved.

		Default:

		Disabled on new installations.', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 5, 3, 5, 3, 'ForceComments', 'This setting specifies whether the remarks box should be completed before the leave application will be allowed to be submitted for approval.

		Default:

		Disabled on new installations.', 1)

		/*
		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 5, 3, 5, 3, 'ForceTime', 'This setting specifies whether the time should be completed before the leave application will be allowed to submit for approval.

		Default:

		Disabled on new installations.', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 5, 3, 5, 3, 'ShowTime', 'This setting specifies whether the am/pm dropdown on the leave application screen should be shown and force the employee to choose either am/pm only if the leave duration is set to 0.5 days.

		Default:

		Disabled on new installations.

		Note:

		If this policy is configured and the ''ForceTime'' policy is configured then this policy will take preference.', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 5, 3, 5, 3, 'ShowReminder', 'This setting specifies whether the reminder is shown on the leave application screen to remind an employee to apply for leave 3 days in advance.

		Default:

		Disabled on new installations.', 1)
		*/

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 5, 3, 5, 3, 'StaffOnLeave', 'This setting specifies whether the staff on leave page is generated using the reports to structure or the security and rights assigned to the particular employee.

		Default:

		The Reports to structure will be used when generating the staff on leave page.

		Note:

		When this policy is enabled the security and rights is used, when this policy is disabled then the reports to structure is used.', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 5, 3, 5, 3, 'IgnoreBalance', 'This setting specifies whether the leave balances on the balances grid should not be calculate at runtime, but rather be read from the existing balances table.

		Default:

		Disabled on new installations.

		Note:

		Enabling this policy will bypass all leave calculations.', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 7, 15, 7, 15, 'FinancialYear', 'This setting allows you to specify the month and day of the business financial year end.

		Default:

		Not configured on new installations.

		Note:

		When using this policy any leave application that will span across the month and day for each year will automatically be split into two leave applications.', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 5, 3, 5, 3, 'FinancialTotal', 'This setting specifies whether the date as configured in the ''FinancialYear'' policy is to be used to calculate total and future taken leave.

		Default:

		Disabled on new installations.

		Note:

		This policy depends on if the ''FinancialYear'' is enabled. If this policy is disabled then the total and future taken leave will be displayed as per the leave scheme setup for the particular employee. If this policy is enabled it will use the ''FinancialYear'' policy''s date to determine the total and future taken leave.', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 19, 13, 19, 13, 'Consecutive', 'This setting allows you to specify which leave types may not be taken in excess of x amount of duration per application (as configured through the ConsecutiveMax policy).

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to disallow a leave application for a specific leave type exceeding x amount of duration as per the ConsecutiveMax policy. This policy can contain a comma seperated list e.g. Sick, Study', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 19, 13, 19, 13, 'ConsecutiveMax', 'This setting allows you to specify the maximum duration per leave type allowed for each application (as configured through the consecutive policy).

		Default:

		Not configured on new installations.

		Note:

		When configuring this policy ensure that you enter the number of days as this policy will only work on leave types that are linked to the duration type of days. This policy can contain a comma seperated list e.g. 2, 5 (and should be configured for each type as configured in the ''Consecutive'' policy)', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 19, 13, 19, 13, 'ForceDocument', 'This setting allows you to specify which leave types should force a person to upload a file before application.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to force a document to be attached for a specific leave type when the person is applying for leave. This policy can contain a comma seperated list e.g. Sick, Study', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 19, 13, 19, 13, 'ForceDocumentMax', 'This setting allows you to specify which leave types should force a person to upload a file before application (if the duration will exceed the configured maximum allowed).

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to force a document to be attached for a specific leave type when the person is applying for leave (if the duration will exceed the configured maximum allowed). This policy can contain a comma seperated list e.g. Sick, Study', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 19, 13, 19, 13, 'ForceDocumentMaxValue', 'This setting allows you to specify the maximum duration allowed, before forcing a required attached document.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ForceDocumentMax'' is configured. This policy can contain a comma seperated list e.g. 2, 5 (and should be configured for each type as configured in the ''ForceDocumentMax'' policy)', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 19, 13, 19, 13, 'ForceDocumentDuration', 'This setting allows you to specify which leave types should force a person to upload a file before application (if there is another application within the configured duration - weeks).

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to force a document to be attached for a specific leave type when the person is applying for leave (if there is another application within the configured duration - weeks). This policy can contain a comma seperated list e.g. Sick, Study', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 19, 13, 19, 13, 'ForceDocumentDurationValue', 'This setting allows you to specify the duration allowed, before forcing a required attached document (if another application is made within this amount of time - weeks).

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ForceDocumentDuration'' is configured. This policy can contain a comma seperated list e.g. 2, 5 (and should be configured for each type as configured in the ''ForceDocumentDuration'' policy)', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 19, 13, 19, 13, 'ForceDocumentWeekend', 'This setting allows you to specify which leave types should force a person to upload a file before application (if the leave application starts / ends on a weekend (Friday, Saturday, Sunday or Monday)).

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to force a document to be attached for a specific leave type when the person is applying for leave (if the leave application starts / ends on a weekend (Friday, Saturday, Sunday or Monday)). This policy can contain a comma seperated list e.g. Sick, Study', 1)

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 19, 13, 19, 13, 'DisallowWeekend', 'This setting allows you to specify which leave types may not be starting / ending either side or over a weekend (Friday, Saturday, Sunday or Monday).

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to disallow a leave application starting / ending either side or over a weekend (Friday, Saturday, Sunday or Monday). This policy can contain a comma seperated list e.g. Sick, Study', 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'ShowSearch'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [YesNo], [Cascade]) values(2, 5, 3, 5, 3, 'ShowSearch', 'This setting determines if the search button on the toolbar should be shown.

		Default:

		Enabled on new installations.', 1, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'ShowEmail'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [YesNo], [Cascade]) values(2, 5, 3, 5, 3, 'ShowEmail', 'This setting determines if the email button on the toolbar should be shown.

		Default:

		Enabled on new installations.', 1, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'ShowSMS'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [YesNo], [Cascade]) values(2, 5, 3, 5, 3, 'ShowSMS', 'This setting determines if the sms button on the toolbar should be shown.

		Default:

		Enabled on new installations.', 1, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'LeaveHistory'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 19, 13, 19, 13, 'LeaveHistory', 'This setting allows you to specify which leave types may not be applied for in the past.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to disallow specific leave type applications if they are in the past. This policy can contain a comma seperated list e.g. Annual, Study', 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'QuarterDay'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 5, 3, 5, 3, 'QuarterDay', 'This setting determines if the leave duration can be manually overwritten with 1/4 of a day.

		Default:

		Disabled on new installations.', 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'StaffOnTraining'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(4, 5, 3, 5, 3, 'StaffOnTraining', 'This setting specifies whether the staff on training page is generated using the reports to structure or the security and rights assigned to the particular employee.

		Default:

		The Reports to structure will be used when generating the staff on training page.

		Note:

		When this policy is enabled the security and rights is used, when this policy is disabled then the reports to structure is used.', 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'AddrUnit'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'AddrUnit', 'txtSARSAddress1', 'Address line 1 (long)', 'This setting specifies whether the address line 1 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'AddrComplex'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'AddrComplex', 'txtSARSAddress2', 'Address line 2 (long)', 'This setting specifies whether the address line 2 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'AddrStreetNo'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'AddrStreetNo', 'txtSARSAddress3', 'Address line 3 (long)', 'This setting specifies whether the address line 3 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'AddrStreetName'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'AddrStreetName', 'txtSARSAddress4', 'Address line 4 (long)', 'This setting specifies whether the address line 4 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'AddrSuburb'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'AddrSuburb', 'txtSARSAddress5', 'Address line 5 (long)', 'This setting specifies whether the address line 5 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'AddrCity'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'AddrCity', 'txtSARSAddress6', 'Address line 6 (long)', 'This setting specifies whether the address line 6 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'AddrZip'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'AddrZip', 'txtSARSAddress7', 'Address line 7 (long)', 'This setting specifies whether the address line 6 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'FaxNo'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'FaxNo', 'txtFacsimile', 'Facsimile No', 'This setting specifies whether the facsimile field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'EmailAddress1'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'EmailAddress1', 'txtEmailAddress1', 'Email Address', 'This setting specifies whether the email address (alternative) field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'Latitude'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'Latitude', 'txtLatitude', 'Latitude', 'This setting specifies whether the latitude field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'Longitude'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Name], [Label], [Description], [Visible], [Cascade]) values(6, 5, 3, 19, 13, 'Longitude', 'txtLongitude', 'Longitude', 'This setting specifies whether the longitude field in the personal module should be displayed.

		Default:

		Enabled on new installations.', 1, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'DisableAutoSave'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(5, 5, 3, 5, 3, 'DisableAutoSave', 'This setting disabled the autosave feature on the performance module; the module will only send the data to the server if the users save or submit the form.

		Default:

		Disabled on new installations.')

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'ShowTerminated'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(2, 5, 3, 5, 3, 'ShowTerminated', 'This setting allows the ESS to load terminated employees in the dropdown where you can choose an employee; when this policy is disabled only current employees will be loaded into the dropdown menu on the left.

		Default:

		Disabled on new installations.')

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'EvaluationsConfig'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [YesNo], [Cascade]) values(2, 5, 3, 5, 3, 'EvaluationsConfig', 'This setting determines if the particular employee should be allowed to configured evaluations (e.g. create groups and schemes via the ESS).

		Default:

		Disabled on new installations.', 0, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'EvaluationResults'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [YesNo], [Cascade]) values(2, 5, 3, 5, 3, 'EvaluationResults', 'This setting determines if the particular employee should be allowed to see the results pane on the evaluations module.

		Default:

		Disabled on new installations.', 0, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'LeaveResults'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [YesNo], [Cascade]) values(8, 5, 3, 5, 3, 'LeaveResults', 'This setting determines if the particular employee should be allowed to see the results pane on the leave module.

		Default:

		Disabled on new installations.', 0, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'TaskResults'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [YesNo], [Cascade]) values(2, 5, 3, 5, 3, 'TaskResults', 'This setting determines if the particular employee should be allowed to see the results pane on the tasks module.

		Default:

		Disabled on new installations.', 0, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'TimesheetsConfig'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [YesNo], [Cascade]) values(2, 5, 3, 5, 3, 'TimesheetsConfig', 'This setting determines if the particular employee should be allowed to configured timesheets (e.g. create new timesheet forms or update existing forms via the ESS).

		Default:

		Disabled on new installations.', 0, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'ClaimsConfig'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [YesNo], [Cascade]) values(2, 5, 3, 5, 3, 'ClaimsConfig', 'This setting determines if the particular employee should be allowed to configured claims (e.g. create new claim forms or update existing forms via the ESS).

		Default:

		Disabled on new installations.', 0, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'KeyAreas'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Text]) values(5, 19, 13, 19, 13, 'KeyAreas', 'This setting allows for customization inside the evaluation module to the Key Areas label.

		Default:

		''Key Areas'' on new installations.', 'Key Areas')

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'KeyElements'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Text]) values(5, 19, 13, 19, 13, 'KeyElements', 'This setting allows for customization inside the evaluation module to the Key Elements label.

		Default:

		''Critical Success Elements'' on new installations.', 'Critical Success Elements')

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'ShowCreate'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [YesNo], [Cascade]) values(2, 5, 3, 5, 3, 'ShowCreate', 'This setting determines if the employee create button on the toolbar should be shown (take-on).

		Default:

		Disabled on new installations.', 0, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'AdjustmentTypes'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description]) values(8, 19, 13, 19, 13, 'AdjustmentTypes', 'This setting allows you to include specific leave types from the list of available leave types.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to show specific leave types, when making use of the leave adjustment section in the leave module. This policy can contain a comma seperated list e.g. Annual, Sick')

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'AllowPicUpload'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [YesNo], [Cascade]) values(2, 5, 3, 5, 3, 'AllowPicUpload', 'This setting determines if the employee should be able to upload his/her personal photo.

		Default:

		Enabled on new installations.', 1, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'ShowContacts'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [YesNo], [Cascade]) values(2, 5, 3, 5, 3, 'ShowContacts', 'This setting determines if the employee contacts button on the toolbar should be shown (contact list).

		Default:

		Disabled on new installations.', 0, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'ShowDelete'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [YesNo], [Cascade]) values(2, 5, 3, 5, 3, 'ShowDelete', 'This setting determines if the employee deletion button on the toolbar should be shown (terminations).

		Default:

		Disabled on new installations.', 0, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'ShowTransfer'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [YesNo], [Cascade]) values(2, 5, 3, 5, 3, 'ShowTransfer', 'This setting determines if the employee transfer button on the toolbar should be shown (transfers).

		Default:

		Disabled on new installations.', 0, 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'LeaveResultType1'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [LookupTable], [LookupText], [LookupValue], [Cascade]) values(8, 6, 13, 6, 13, 'LeaveResultType1', 'This setting allows you to set a specific leave type to be used for the calculation on the leave results screen.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to show calculations for a specific leave type on the results screen. This policy can only contain one leave type', 'LeaveLU', 'LeaveType', 'LeaveType', 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'LeaveResultType2'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [LookupTable], [LookupText], [LookupValue], [Cascade]) values(8, 6, 13, 6, 13, 'LeaveResultType2', 'This setting allows you to set a specific leave type to be used for the calculation on the leave results screen.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to show calculations for a specific leave type on the results screen. This policy can only contain one leave type', 'LeaveLU', 'LeaveType', 'LeaveType', 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'LeaveFuture'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 19, 13, 19, 13, 'LeaveFuture', 'This setting allows you to specify which leave types may not be applied for in the future.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to disallow specific leave type applications if they are in the future. This policy can contain a comma seperated list e.g. Annual, Study', 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'LeaveInverse'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 19, 13, 19, 13, 'LeaveInverse', 'This setting allows you to specify which leave types where the duration calculation is swopped, calculates the duration for non-working hours/days, e.g. weekends or public holidays and rejects applications if there is a normal working hour/day in between.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to calculate the duration for specific leave type applications part of non-working hours/days, e.g. weekends or public holidays. This policy can contain a comma seperated list e.g. Annual, Study', 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'ForceDocumentPublic'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 19, 13, 19, 13, 'ForceDocumentPublic', 'This setting allows you to specify which leave types should force a person to upload a file before application (if the leave application starts or ends one day before or after a public holiday).

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to force a document to be attached for a specific leave type when the person is applying for leave (if the leave application starts / ends one day before or after a public holiday). This policy can contain a comma seperated list e.g. Sick, Study', 1)

	end

	if not exists(select top 1 [ID] from [ess.Policy] where ([Key] = 'DisallowPublic'))
	begin

		insert into [ess.Policy]([GroupID], [SetupAssemblyID], [SetupDataTypeID], [AssemblyID], [DataTypeID], [Key], [Description], [Cascade]) values(8, 19, 13, 19, 13, 'DisallowPublic', 'This setting allows you to specify which leave types may not be starting / ending one day before or after a public holiday.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to disallow a leave application starting / ending one day before or after a public holiday. This policy can contain a comma seperated list e.g. Sick, Study', 1)

	end

	update [ess.Policy] set [Description] = 'This setting allows you to specify which leave types should force a person to upload a file before application (if the leave application starts / ends on a weekend (Friday, Saturday, Sunday or Monday)).

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to force a document to be attached for a specific leave type when the person is applying for leave (if the leave application starts / ends on a weekend (Friday, Saturday, Sunday or Monday)). This policy can contain a comma seperated list e.g. Sick, Study' where ([Key] = 'ForceDocumentWeekend')

	update [ess.Policy] set [Description] = 'This setting allows you to specify which leave types may not be starting / ending either side or over a weekend (Friday, Saturday, Sunday or Monday).

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to disallow a leave application starting / ending either side or over a weekend (Friday, Saturday, Sunday or Monday). This policy can contain a comma seperated list e.g. Sick, Study' where ([Key] = 'DisallowWeekend')

	update [ess.Policy] set [Description] = 'This setting allows you to specify which leave types where the duration calculation is swopped, calculates the duration for non-working hours/days, e.g. weekends or public holidays and rejects applications if there is a normal working hour/day in between.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to calculate the duration for specific leave type applications part of non-working hours/days, e.g. weekends or public holidays. This policy can contain a comma seperated list e.g. Annual, Study' where ([Key] = 'LeaveInverse')

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.PolicyItems]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists(select top 1 [ID] from [ess.PolicyItems])
		exec [ess.Cascade]

	declare @iCountPolicy bigint,
			@iLoopPolicy bigint,
			@iCountTemplate bigint,
			@iLoopTemplate bigint,
			@PolicyID tinyint,
			@Template nvarchar(10)

	declare @Policy table
	(
		[ID] bigint identity (1, 1) not null,
		[PolicyID] [tinyint] not null,
		[Visible] [bit] not null,
		[Editable] [bit] not null,
		[Required] [bit] not null,
		[YesNo] [bit] not null,
		[Int] [int] null,
		[IntMin] [int] null,
		[IntMax] [int] null,
		[Dec] [float] null,
		[DecMin] [float] null,
		[DecMax] [float] null,
		[Date] [datetime] null,
		[DateMin] [datetime] null,
		[DateMax] [datetime] null,
		[Text] [ntext] null,
		[GUID] [uniqueidentifier] null,
		[Object] [image] null,
		[LookupTable] [nvarchar] (75) null,
		[LookupText] [nvarchar] (75) null,
		[LookupValue] [nvarchar] (75) null,
		[LookupFilter] [ntext] null,
		[Validation] [ntext] null
	)

	declare @Templates table
	(
		[ID] bigint identity (1, 1) not null,
		[Code] nvarchar(10) not null
	)

	insert into @Policy([PolicyID], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation]) select [ID], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation] from [ess.Policy] where ([Cascade] = 1) order by [ID]

	insert into @Templates([Code]) select [Code] from [UserGroupTemplates] order by [Code]

	set @iLoopPolicy = 1

	select @iCountPolicy = count([ID]) from @Policy

	select @iCountTemplate = count([ID]) from @Templates

	while (@iLoopPolicy <= @iCountPolicy)
	begin

		select @PolicyID = [PolicyID] from @Policy where ([ID] = @iLoopPolicy)

		set @iLoopTemplate = 1

		while (@iLoopTemplate <= @iCountTemplate)
		begin

			select @Template = [Code] from @Templates where ([ID] = @iLoopTemplate)

			if not exists(select top 1 [id] from [ess.PolicyItems] where ([PolicyID] = @PolicyID and [Template] = @Template))
				insert into [ess.PolicyItems]([PolicyID], [Template], [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation]) select @PolicyID, @Template, [Visible], [Editable], [Required], [YesNo], [Int], [IntMin], [IntMax], [Dec], [DecMin], [DecMax], [Date], [DateMin], [DateMax], [Text], [GUID], [Object], [LookupTable], [LookupText], [LookupValue], [LookupFilter], [Validation] from [ess.Policy] where ([ID] = @PolicyID)

			set @iLoopTemplate = @iLoopTemplate + 1

		end

		set @iLoopPolicy = @iLoopPolicy + 1

	end

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Properties]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists(select top 1 [ID] from [ess.Properties])
		insert into [ess.Properties]([LicenseKey], [AppVersion], [DBVersion]) values('xxxxx-xxxxx-xxxxx-xxxxx-xxxxx', 'v6.0.74', 'v6.0.74')

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.ReportsLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists(select top 1 [ID] from [ess.ReportsLU] where ([Title] = 'Pay Report'))
		insert into [ess.ReportsLU]([Title], [Path], [SQL]) values('Pay Report', 'reports/<%PARAM[3]%>.repx', 'select cast(newid() as nvarchar(36)) as [ID], * from [Pay] where ([CompanyNum] = ''<%PARAM[0]%>'' and [EmployeeNum] = ''<%PARAM[1]%>'' and [DateFrom] = ''<%PARAM[2]%>'')')

	if not exists(select top 1 [ID] from [ess.ReportsLU] where ([Title] = 'Evaluation'))
		insert into [ess.ReportsLU]([Title], [Path], [SQL]) values('Evaluation', 'reports/evaluation.repx', 'select cast(newid() as nvarchar(36)) as [ID], [pClass].[CompanyNum] + '' '' + [pClass].[EmployeeNum] + '' '' + [pClass].[SchemeCode] + '' '' + convert(nvarchar(19), [pClass].[EvalDate], 120) + '' '' + [ClassCode] as [CompositeKey], 0 as [Type], [ClassCode], null as [Sort], [ClassName] as [Name], '''' as [RangeType], '''' as [Value], [Weight], [RatingPercentage], [pClass].[Score], ''-'' as [Description], [pClass].[EvalDate] as [ObtainBy], 0 as [Count], '''' as [Answers], '''' as [Answers_010], '''' as [Answers_011], '''' as [Answers_012], ''Appraisal for'' + isnull('' '' + [Title], '''') + isnull('' '' + [Surname] + '', '', '''') + isnull(isnull([PreferredName], [FirstName]), '''') as [Employee], [DeptName], [AppraiserType], [AppraiserName], [Appointdate], [pScheme].[Name] as [Scheme], [pScheme].[Score] as [SchemeScore], ''-'' as [StickyNotes] from ([PerfEvalClass] as [pClass] left outer join [PerfEvalScheme] as [pScheme] on [pClass].[CompanyNum] = [pScheme].[CompanyNum] and [pClass].[EmployeeNum] = [pScheme].[EmployeeNum] and [pClass].[SchemeCode] = [pScheme].[SchemeCode] and [pClass].[EvalDate] = [pScheme].[EvalDate]) left outer join [Personnel] as [emp] on [pClass].[CompanyNum] = [emp].[CompanyNum] and [pClass].[EmployeeNum] = [emp].[EmployeeNum] where ([pScheme].[PathID] = <%PARAM[0]%> and [pScheme].[EvalDate] = ''<%PARAM[1]%>'') union select null, [CompanyNum] + '' '' + [EmployeeNum] + '' '' + [SchemeCode] + '' '' + convert(nvarchar(19), [EvalDate], 120) + '' '' + [ClassCode] + '' '' + [KPACode], 1, [ClassCode], [KPACode], [KPAName], [RangeType], [ElementName], [Weight], [RatingPercentage], [Score], cast(isnull([Remarks], ''-'') as varchar(8000)), [ObtainBy], (select count([CSEName]) from [PerfEvalCSE] where ([SchemeCode] = [PerfEvalKPA].[SchemeCode] and [ClassCode] = [PerfEvalKPA].[ClassCode] and [KPACode] = [PerfEvalKPA].[KPACode])), '''', '''', '''', '''', null, null, null, null, null, null, (select [Score] from [PerfEvalScheme] where ([CompanyNum] + '' '' + [EmployeeNum] + '' '' + [SchemeCode] + '' '' + convert(nvarchar(19), [EvalDate], 120) = [PerfEvalKPA].[CompanyNum] + '' '' + [PerfEvalKPA].[EmployeeNum] + '' '' + [PerfEvalKPA].[SchemeCode] + '' '' + convert(nvarchar(19), [PerfEvalKPA].[EvalDate], 120))), cast(isnull([StickyNotes], ''-'') as varchar(8000)) from [PerfEvalKPA] where ([CompanyNum] + '' '' + [EmployeeNum] + '' '' + [SchemeCode] + '' '' + convert(nvarchar(19), [EvalDate], 120) = (select [CompanyNum] + '' '' + [EmployeeNum] + '' '' + [SchemeCode] + '' '' + convert(nvarchar(19), [EvalDate], 120) from [PerfEvalScheme] where ([PathID] = <%PARAM[0]%> and [EvalDate] = ''<%PARAM[1]%>''))) union select null, [CompanyNum] + '' '' + [EmployeeNum] + '' '' + [SchemeCode] + '' '' + convert(nvarchar(19), [EvalDate], 120) + '' '' + [ClassCode] + '' '' + [KPACode] + '' '' + [CSEName], 2, [ClassCode], [KPACode], [CSEName], [RangeType], [ElementName], [Weight], [RatingPercentage], [Score], cast(isnull([Remarks], ''-'') as varchar(8000)), [ObtainBy], 0, '''', '''', '''', '''', null, null, null, null, null, null, (select [Score] from [PerfEvalScheme] where ([CompanyNum] + '' '' + [EmployeeNum] + '' '' + [SchemeCode] + '' '' + convert(nvarchar(19), [EvalDate], 120) = [PerfEvalCSE].[CompanyNum] + '' '' + [PerfEvalCSE].[EmployeeNum] + '' '' + [PerfEvalCSE].[SchemeCode] + '' '' + convert(nvarchar(19), [PerfEvalCSE].[EvalDate], 120))), cast(isnull([StickyNotes], ''-'') as varchar(8000)) from [PerfEvalCSE] where ([CompanyNum] + '' '' + [EmployeeNum] + '' '' + [SchemeCode] + '' '' + convert(nvarchar(19), [EvalDate], 120) = (select [CompanyNum] + '' '' + [EmployeeNum] + '' '' + [SchemeCode] + '' '' + convert(nvarchar(19), [EvalDate], 120) from [PerfEvalScheme] where ([PathID] = <%PARAM[0]%> and [EvalDate] = ''<%PARAM[1]%>''))) order by [ClassCode], [Sort], [Type], [Name]')

	if not exists(select top 1 [ID] from [ess.ReportsLU] where ([Title] = 'Timesheets'))
		insert into [ess.ReportsLU]([Title], [Path], [SQL]) values('Timesheets', 'reports/timesheets.repx', 'select cast(newid() as nvarchar(36)) as [ID], [c].[EmployeeNum], (select isnull(isnull([PreferredName], [FirstName]), '''') + '' '' + isnull([Surname], '''') from [Personnel] where ([CompanyNum] = ''<%PARAM[0]%>'' and [EmployeeNum] = ''<%PARAM[1]%>'')) as [Name], getdate() as [Period], cast(datename(dw, [c].[ItemDate]) as nvarchar(3)) as [Day], [c].[ItemDate], (select [Text] from [TimesheetSetup] where ([Name] = ''Col1'')) as [Name1], (select [Text] from [TimesheetSetup] where ([Name] = ''Col2'')) as [Name2], (select [Text] from [TimesheetSetup] where ([Name] = ''Col3'')) as [Name3], (select [Text] from [TimesheetSetup] where ([Name] = ''Col4'')) as [Name4], (select [Text] from [TimesheetSetup] where ([Name] = ''Col5'')) as [Name5], (select [Text] from [TimesheetSetup] where ([Name] = ''Col6'')) as [Name6], (select [Text] from [TimesheetSetup] where ([Name] = ''Col7'')) as [Name7], (select [Text] from [TimesheetSetup] where ([Name] = ''Col8'')) as [Name8], (isnull([c].[Col1], 0) + isnull([c].[Col2], 0) + isnull([c].[Col3], 0) + isnull([c].[Col4], 0) + isnull([c].[Col5], 0) + isnull([c].[Col6], 0) + isnull([c].[Col7], 0) + isnull([c].[Col8], 0)) as [Hours], [c].[Col1], [c].[Col2], [c].[Col3], [c].[Col4], [c].[Col5], [c].[Col6], [c].[Col7], [c].[Col8] from [Timesheets] as [p] right outer join [TimesheetChildEntries] as [c] on [p].[CompanyNum] = [c].[CompanyNum] and [p].[EmployeeNum] = [c].[EmployeeNum] and [p].[Start] = [c].[Start] and [p].[Until] = [c].[Until] and [p].[Type] = [c].[Type] where ([p].[CompanyNum] = ''<%PARAM[0]%>'' and [p].[EmployeeNum] = ''<%PARAM[1]%>'' and (([p].[Start] >= convert(nvarchar(7), getdate(), 120) + ''-01 00:00:00'' and [p].[Start] < convert(nvarchar(7), dateadd(month, 1, getdate()), 120) + ''-01 00:00:00'') or ([p].[Until] >= convert(nvarchar(7), getdate(), 120) + ''-01 00:00:00'' and [p].[Until] < convert(nvarchar(7), dateadd(month, 1, getdate()), 120) + ''-01 00:00:00''))) order by [c].[ItemDate], [c].[ItemName]')

	if not exists(select top 1 [ID] from [ess.ReportsLU] where ([Title] = 'Conditions'))
		insert into [ess.ReportsLU]([Title], [Path]) values('Conditions', 'reports/conditions.rpt')

	update [ess.ReportsLU] set [SQL] = 'select cast(newid() as nvarchar(36)) as [ID], [pClass].[CompanyNum] + '' '' + [pClass].[EmployeeNum] + '' '' + [pClass].[SchemeCode] + '' '' + convert(nvarchar(19), [pClass].[EvalDate], 120) + '' '' + [ClassCode] as [CompositeKey], 0 as [Type], [ClassCode], null as [Sort], [ClassName] as [Name], '''' as [RangeType], '''' as [Value], [Weight], [RatingPercentage], [pClass].[Score], ''-'' as [Description], [pClass].[EvalDate] as [ObtainBy], 0 as [Count], '''' as [Answers], '''' as [Answers_010], '''' as [Answers_011], '''' as [Answers_012], ''Appraisal for'' + isnull('' '' + [Title], '''') + isnull('' '' + [Surname] + '', '', '''') + isnull(isnull([PreferredName], [FirstName]), '''') as [Employee], [DeptName], [AppraiserType], [AppraiserName], [Appointdate], [pScheme].[Name] as [Scheme], [pScheme].[Score] as [SchemeScore], ''-'' as [StickyNotes] from ([PerfEvalClass] as [pClass] left outer join [PerfEvalScheme] as [pScheme] on [pClass].[CompanyNum] = [pScheme].[CompanyNum] and [pClass].[EmployeeNum] = [pScheme].[EmployeeNum] and [pClass].[SchemeCode] = [pScheme].[SchemeCode] and [pClass].[EvalDate] = [pScheme].[EvalDate]) left outer join [Personnel] as [emp] on [pClass].[CompanyNum] = [emp].[CompanyNum] and [pClass].[EmployeeNum] = [emp].[EmployeeNum] where ([pScheme].[PathID] = <%PARAM[0]%> and [pScheme].[EvalDate] = ''<%PARAM[1]%>'') union select null, [CompanyNum] + '' '' + [EmployeeNum] + '' '' + [SchemeCode] + '' '' + convert(nvarchar(19), [EvalDate], 120) + '' '' + [ClassCode] + '' '' + [KPACode], 1, [ClassCode], [KPACode], [KPAName], [RangeType], [ElementName], [Weight], [RatingPercentage], [Score], cast(isnull([Remarks], ''-'') as varchar(8000)), [ObtainBy], (select count([CSEName]) from [PerfEvalCSE] where ([SchemeCode] = [PerfEvalKPA].[SchemeCode] and [ClassCode] = [PerfEvalKPA].[ClassCode] and [KPACode] = [PerfEvalKPA].[KPACode])), '''', '''', '''', '''', null, null, null, null, null, null, (select [Score] from [PerfEvalScheme] where ([CompanyNum] + '' '' + [EmployeeNum] + '' '' + [SchemeCode] + '' '' + convert(nvarchar(19), [EvalDate], 120) = [PerfEvalKPA].[CompanyNum] + '' '' + [PerfEvalKPA].[EmployeeNum] + '' '' + [PerfEvalKPA].[SchemeCode] + '' '' + convert(nvarchar(19), [PerfEvalKPA].[EvalDate], 120))), cast(isnull([StickyNotes], ''-'') as varchar(8000)) from [PerfEvalKPA] where ([CompanyNum] + '' '' + [EmployeeNum] + '' '' + [SchemeCode] + '' '' + convert(nvarchar(19), [EvalDate], 120) = (select [CompanyNum] + '' '' + [EmployeeNum] + '' '' + [SchemeCode] + '' '' + convert(nvarchar(19), [EvalDate], 120) from [PerfEvalScheme] where ([PathID] = <%PARAM[0]%> and [EvalDate] = ''<%PARAM[1]%>''))) union select null, [CompanyNum] + '' '' + [EmployeeNum] + '' '' + [SchemeCode] + '' '' + convert(nvarchar(19), [EvalDate], 120) + '' '' + [ClassCode] + '' '' + [KPACode] + '' '' + [CSEName], 2, [ClassCode], [KPACode], [CSEName], [RangeType], [ElementName], [Weight], [RatingPercentage], [Score], cast(isnull([Remarks], ''-'') as varchar(8000)), [ObtainBy], 0, '''', '''', '''', '''', null, null, null, null, null, null, (select [Score] from [PerfEvalScheme] where ([CompanyNum] + '' '' + [EmployeeNum] + '' '' + [SchemeCode] + '' '' + convert(nvarchar(19), [EvalDate], 120) = [PerfEvalCSE].[CompanyNum] + '' '' + [PerfEvalCSE].[EmployeeNum] + '' '' + [PerfEvalCSE].[SchemeCode] + '' '' + convert(nvarchar(19), [PerfEvalCSE].[EvalDate], 120))), cast(isnull([StickyNotes], ''-'') as varchar(8000)) from [PerfEvalCSE] where ([CompanyNum] + '' '' + [EmployeeNum] + '' '' + [SchemeCode] + '' '' + convert(nvarchar(19), [EvalDate], 120) = (select [CompanyNum] + '' '' + [EmployeeNum] + '' '' + [SchemeCode] + '' '' + convert(nvarchar(19), [EvalDate], 120) from [PerfEvalScheme] where ([PathID] = <%PARAM[0]%> and [EvalDate] = ''<%PARAM[1]%>''))) order by [ClassCode], [Sort], [Type], [Name]' where ([Path] like 'reports/evaluation%.repx')

	update [ess.ReportsLU] set [SQL] = 'select cast(newid() as nvarchar(36)) as [ID], [c].[EmployeeNum], (select isnull(isnull([PreferredName], [FirstName]), '''') + '' '' + isnull([Surname], '''') from [Personnel] where ([CompanyNum] = ''<%PARAM[0]%>'' and [EmployeeNum] = ''<%PARAM[1]%>'')) as [Name], getdate() as [Period], cast(datename(dw, [c].[ItemDate]) as nvarchar(3)) as [Day], [c].[ItemDate], (select [Text] from [TimesheetSetup] where ([Name] = ''Col1'')) as [Name1], (select [Text] from [TimesheetSetup] where ([Name] = ''Col2'')) as [Name2], (select [Text] from [TimesheetSetup] where ([Name] = ''Col3'')) as [Name3], (select [Text] from [TimesheetSetup] where ([Name] = ''Col4'')) as [Name4], (select [Text] from [TimesheetSetup] where ([Name] = ''Col5'')) as [Name5], (select [Text] from [TimesheetSetup] where ([Name] = ''Col6'')) as [Name6], (select [Text] from [TimesheetSetup] where ([Name] = ''Col7'')) as [Name7], (select [Text] from [TimesheetSetup] where ([Name] = ''Col8'')) as [Name8], (isnull([c].[Col1], 0) + isnull([c].[Col2], 0) + isnull([c].[Col3], 0) + isnull([c].[Col4], 0) + isnull([c].[Col5], 0) + isnull([c].[Col6], 0) + isnull([c].[Col7], 0) + isnull([c].[Col8], 0)) as [Hours], [c].[Col1], [c].[Col2], [c].[Col3], [c].[Col4], [c].[Col5], [c].[Col6], [c].[Col7], [c].[Col8] from [Timesheets] as [p] right outer join [TimesheetChildEntries] as [c] on [p].[CompanyNum] = [c].[CompanyNum] and [p].[EmployeeNum] = [c].[EmployeeNum] and [p].[Start] = [c].[Start] and [p].[Until] = [c].[Until] and [p].[Type] = [c].[Type] where ([p].[CompanyNum] = ''<%PARAM[0]%>'' and [p].[EmployeeNum] = ''<%PARAM[1]%>'' and (([p].[Start] >= convert(nvarchar(7), getdate(), 120) + ''-01 00:00:00'' and [p].[Start] < convert(nvarchar(7), dateadd(month, 1, getdate()), 120) + ''-01 00:00:00'') or ([p].[Until] >= convert(nvarchar(7), getdate(), 120) + ''-01 00:00:00'' and [p].[Until] < convert(nvarchar(7), dateadd(month, 1, getdate()), 120) + ''-01 00:00:00''))) order by [c].[ItemDate], [c].[ItemName]' where ([Path] like 'reports/timesheets.repx')

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[ess.StatusLU]') and objectproperty([id], N'IsUserTable') = 1)
	set identity_insert [ess.StatusLU] on
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.StatusLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists(select top 1 [id] from [ess.StatusLU])
	begin
	
		insert into [ess.StatusLU]([id], [Status]) values(0, 'Start')
		insert into [ess.StatusLU]([id], [Status]) values(1, 'Adjust')
		insert into [ess.StatusLU]([id], [Status]) values(2, 'Admin')
		insert into [ess.StatusLU]([id], [Status]) values(3, 'Appraise')
		insert into [ess.StatusLU]([id], [Status]) values(4, 'Approve')
		insert into [ess.StatusLU]([id], [Status]) values(5, 'Book')
		insert into [ess.StatusLU]([id], [Status]) values(6, 'Completed')
		insert into [ess.StatusLU]([id], [Status]) values(7, 'Deleted')
		insert into [ess.StatusLU]([id], [Status]) values(8, 'Informed')
		insert into [ess.StatusLU]([id], [Status]) values(9, 'Not Submitted')
		insert into [ess.StatusLU]([id], [Status]) values(10, 'Reject')
		insert into [ess.StatusLU]([id], [Status]) values(11, 'Submitted')
		insert into [ess.StatusLU]([id], [Status]) values(12, 'Timeout')
	
	end
	
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[dbo].[ess.StatusLU]') and objectproperty([id], N'IsUserTable') = 1)
	set identity_insert [ess.StatusLU] off
GO

/* TODO: v6.0.74 Finish importing of PD Standards */
if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFAppTypeLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists (select top 1 [id] from [ess.WFAppTypeLU])
	begin

		insert into [ess.WFAppTypeLU]([AppType]) values('Approve')
		insert into [ess.WFAppTypeLU]([AppType]) values('Cancel')
		insert into [ess.WFAppTypeLU]([AppType]) values('Claims')
		insert into [ess.WFAppTypeLU]([AppType]) values('Notify')
		insert into [ess.WFAppTypeLU]([AppType]) values('Performance')
		insert into [ess.WFAppTypeLU]([AppType]) values('Training')
		insert into [ess.WFAppTypeLU]([AppType]) values('Stores')
		insert into [ess.WFAppTypeLU]([AppType]) values('Loans')

	end

	if not exists (select top 1 [id] from [ess.WFAppTypeLU] where ([AppType] = 'Basic Conditions Grade 1 - 6 Same SBU'))
		insert into [ess.WFAppTypeLU]([AppType]) values('Basic Conditions Grade 1 - 6 Same SBU')

	if not exists (select top 1 [id] from [ess.WFAppTypeLU] where ([AppType] = 'Basic Conditions Grade 1 - 6 Different SBU'))
		insert into [ess.WFAppTypeLU]([AppType]) values('Basic Conditions Grade 1 - 6 Different SBU')

	if not exists (select top 1 [id] from [ess.WFAppTypeLU] where ([AppType] = 'Basic Conditions Staff Same SBU'))
		insert into [ess.WFAppTypeLU]([AppType]) values('Basic Conditions Staff Same SBU')

	if not exists (select top 1 [id] from [ess.WFAppTypeLU] where ([AppType] = 'Basic Conditions Staff Different SBU'))
		insert into [ess.WFAppTypeLU]([AppType]) values('Basic Conditions Staff Different SBU')

	if not exists (select top 1 [id] from [ess.WFAppTypeLU] where ([AppType] = 'Basic Conditions Acting Allowance'))
		insert into [ess.WFAppTypeLU]([AppType]) values('Basic Conditions Acting Allowance')

	if not exists (select top 1 [id] from [ess.WFAppTypeLU] where ([AppType] = 'Timesheet'))
		insert into [ess.WFAppTypeLU]([AppType]) values('Timesheet')

	if not exists (select top 1 [id] from [ess.WFAppTypeLU] where ([AppType] = 'IR'))
		insert into [ess.WFAppTypeLU]([AppType]) values('IR')

	if not exists (select top 1 [id] from [ess.WFAppTypeLU] where ([AppType] = 'Onboarding'))
		insert into [ess.WFAppTypeLU]([AppType]) values('Onboarding')

	if not exists (select top 1 [id] from [ess.WFAppTypeLU] where ([AppType] = 'Terminations'))
		insert into [ess.WFAppTypeLU]([AppType]) values('Terminations')

	if not exists (select top 1 [id] from [ess.WFAppTypeLU] where ([AppType] = 'Transfers'))
		insert into [ess.WFAppTypeLU]([AppType]) values('Transfers')

	/*
	insert into [ess.WFAppTypeLU]([AppType]) values('Registration')
	insert into [ess.WFAppTypeLU]([AppType]) values('PD Standards')
	insert into [ess.WFAppTypeLU]([AppType]) values('PD Standards - Unplanned')
	insert into [ess.WFAppTypeLU]([AppType]) values('PD Standards - Training')
	*/

end
GO

/* TODO: v6.0.74 Finish importing of PD Standards */
if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFTypeLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	truncate table [ess.WFTypeLU]

	if not exists(select top 1 [id] from [ess.WFTypeLU])
	begin

		insert into [ess.WFTypeLU]([WFType], [Tablename]) values('Notify', 'ess.NotifyHR')
		insert into [ess.WFTypeLU]([WFType], [Tablename]) values('Change', 'ess.Change')
		insert into [ess.WFTypeLU]([WFType], [Tablename]) values('Leave', 'Leave')
		insert into [ess.WFTypeLU]([WFType], [Tablename]) values('Performance', 'PerfEvalScheme')
		insert into [ess.WFTypeLU]([WFType], [Tablename]) values('Training', 'TrainingPlanned')
		insert into [ess.WFTypeLU]([WFType], [Tablename]) values('Stores', 'StoreIssued')
		insert into [ess.WFTypeLU]([WFType], [Tablename]) values('Loans', 'Loan')
		insert into [ess.WFTypeLU]([WFType], [Tablename]) values('Claims', 'Claims')

	end

	update [ess.WFTypeLU] set [Tablename] = 'ess.NotifyHR' where ([WFType] = 'Notify' and [Tablename] is null)

	update [ess.WFTypeLU] set [Tablename] = 'ess.Change' where ([WFType] = 'Change' and [Tablename] is null)

	update [ess.WFTypeLU] set [Tablename] = 'Leave' where ([WFType] = 'Leave' and [Tablename] is null)

	update [ess.WFTypeLU] set [Tablename] = 'PerfEvalScheme' where ([WFType] = 'Performance' and [Tablename] is null)

	update [ess.WFTypeLU] set [Tablename] = 'TrainingPlanned' where ([WFType] = 'Training' and [Tablename] is null)

	update [ess.WFTypeLU] set [Tablename] = 'StoreIssued' where ([WFType] = 'Stores' and [Tablename] is null)

	update [ess.WFTypeLU] set [Tablename] = 'Loan' where ([WFType] = 'Loans' and [Tablename] is null)

	update [ess.WFTypeLU] set [Tablename] = 'Claims' where ([WFType] = 'Claims' and [Tablename] is null)

	update [ess.WFTypeLU] set [Tablename] = 'Timesheets' where ([WFType] = 'Timesheet' and [Tablename] is null)

	update [ess.WFTypeLU] set [Tablename] = 'Basic Conditions' where ([WFType] = 'Basic Conditions' and [Tablename] is null)

	if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'Timesheet' and [TableName] = 'Timesheets'))
		insert into [ess.WFTypeLU]([WFType], [Tablename]) values('Timesheet', 'Timesheets')

	if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'IR' and [TableName] = 'Counselling_Work_Performance'))
		insert into [ess.WFTypeLU]([WFType], [Tablename]) values('IR', 'Counselling_Work_Performance')

	if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'IR' and [TableName] = 'Counselling_Conduct'))
		insert into [ess.WFTypeLU]([WFType], [Tablename]) values('IR', 'Counselling_Conduct')

	if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'IR' and [TableName] = 'Discipline'))
		insert into [ess.WFTypeLU]([WFType], [Tablename]) values('IR', 'Discipline')

	if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'Onboarding' and [TableName] = 'Personnel'))
		insert into [ess.WFTypeLU]([WFType], [Tablename]) values('Onboarding', 'Personnel')

	if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'Terminations' and [TableName] = 'Personnel'))
		insert into [ess.WFTypeLU]([WFType], [Tablename]) values('Terminations', 'Personnel')

	if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'Transfers' and [TableName] = 'Personnel'))
		insert into [ess.WFTypeLU]([WFType], [Tablename]) values('Transfers', 'Personnel')

	if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'Basic Conditions' and [TableName] = 'PersonnelHistoryLog'))
		insert into [ess.WFTypeLU]([WFType], [Tablename]) values('Basic Conditions', 'PersonnelHistoryLog')

	/*
	insert into [ess.WFTypeLU]([WFType], [Tablename]) values('PD Standards', null)
	insert into [ess.WFTypeLU]([WFType], [Tablename]) values('Registration', 'Users')
	*/

end
GO

/* TODO: v6.0.74 Finish importing of PD Standards */
if (exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFTypeLU]') and objectproperty([id], N'IsUserTable') = 1) and exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFTaskLU]') and objectproperty([id], N'IsUserTable') = 1) and exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFProcLU]') and objectproperty([id], N'IsUserTable') = 1))
begin

	declare @WFLUID int,
			@WFType nvarchar(50),
			@TableName nvarchar(128)

	truncate table [ess.WFTaskLU]
	truncate table [ess.WFProcLU]

	declare tCursor cursor for
		select [id], [WFType], [TableName] from [ess.WFTypeLU]
		
	open tCursor
	
		fetch next from tCursor into @WFLUID, @WFType, @TableName
		
		while @@FETCH_STATUS = 0
		begin
		
			if not exists(select top 1 [id] from [ess.WFTypeLU] where [WFType] = @WFType)
				insert into [ess.WFTypeLU]([id], [WFType]) values(@WFLUID, @WFType)

			if (lower(@WFType) = 'notify')
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.NotifyPath')

			if (lower(@WFType) = 'change')
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.ChangePath')

			if (lower(@WFType) = 'leave')
			begin
			
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.CancelLeave')
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.LeavePath')
				
			end
			
			if (lower(@WFType) = 'performance')
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.PerfPath')
			
			if (lower(@WFType) = 'training')
			begin
			
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.CancelTraining')
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.TrainingPath')
				
			end
			
			if (lower(@WFType) = 'stores')
			begin
			
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.CancelStore')
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.StorePath')
				
			end
			
			if (lower(@WFType) = 'loans')
			begin
			
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.CancelLoan')
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.LoanPath')
				
			end

			if (lower(@WFType) = 'claims')
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.ClaimPath')

			if (lower(@WFType) = 'timesheet')
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.TimePath')

			if (lower(@WFType) = 'ir') and not exists(select top 1 [id] from [ess.WFTaskLU] where ([Task] = 'ess.IRPerfPath'))
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.IRPerfPath')
			
			if (lower(@WFType) = 'ir') and not exists(select top 1 [id] from [ess.WFTaskLU] where ([Task] = 'ess.IRConductPath'))
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.IRConductPath')
			
			if (lower(@WFType) = 'ir') and not exists(select top 1 [id] from [ess.WFTaskLU] where ([Task] = 'ess.IRDiscPath'))
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.IRDiscPath')

			if (lower(@WFType) = 'onboarding') and not exists(select top 1 [id] from [ess.WFTaskLU] where ([Task] = 'ess.OnboardingPath'))
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.OnboardingPath')

			if (lower(@WFType) = 'terminations')
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.TerminationPath')

			if (lower(@WFType) = 'transfers')
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.TransferPath')

			if (lower(@WFType) = 'basic conditions')
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.BasicCPath')

			/*
			if (lower(@WFType) = 'registration')
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.RegisterPath')

			if (lower(@WFType) = 'pd standards')
			begin
			
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.PDStandards')
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.PDTraining')
				insert into [ess.WFTaskLU]([TypeID], [Task]) values(@WFLUID, 'ess.PDStandards_Unplanned')
				
			end
			*/

			if (lower(@WFType) = 'notify')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.NotifyComplete')
			
			if (lower(@WFType) = 'leave')
			begin
			
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.LeaveCancel')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.LeaveHRAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.LeaveHRReject')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.LeaveLMAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.LeaveLMReject')
				
			end
			
			if (lower(@WFType) = 'performance')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.PerfComplete')
			
			if (lower(@WFType) = 'training')
			begin
			
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.TrainingCancel')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.TrainingHRAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.TrainingHRReject')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.TrainingLMAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.TrainingLMReject')
				
			end
			
			if (lower(@WFType) = 'stores')
			begin
			
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.StoreCancel')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.StoreHRAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.StoreHRReject')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.StoreLMAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.StoreLMReject')
				
			end
			
			if (lower(@WFType) = 'loans')
			begin
			
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.LoanCancel')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.LoanHRAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.LoanHRReject')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.LoanLMAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.LoanLMReject')
				
			end

			if (lower(@WFType) = 'claims')
			begin
			
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.ClaimHRAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.ClaimHRReject')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.ClaimLMAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.ClaimLMReject')
				
			end

			if (lower(@WFType) = 'timesheet')
			begin
			
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.TimeHRAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.TimeHRReject')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.TimeLMAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.TimeLMReject')
				
			end

			if (lower(@WFType) = 'ir' and lower(@TableName) = 'counselling_work_performance') and not exists(select top 1 [id] from [ess.WFProcLU] where ([Proc] like 'ess.IRPerf%'))
			begin
			
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.IRPerfHRAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.IRPerfHRReject')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.IRPerfLMAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.IRPerfLMReject')
				
			end

			if (lower(@WFType) = 'ir' and lower(@TableName) = 'counselling_conduct') and not exists(select top 1 [id] from [ess.WFProcLU] where ([Proc] like 'ess.IRConduct%'))
			begin
			
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.IRConductHRAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.IRConductHRReject')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.IRConductLMAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.IRConductLMReject')
				
			end

			if (lower(@WFType) = 'ir' and lower(@TableName) = 'discipline') and not exists(select top 1 [id] from [ess.WFProcLU] where ([Proc] like 'ess.IRDisc%'))
			begin

				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.IRDiscHRAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.IRDiscHRReject')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.IRDiscLMAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.IRDiscLMReject')

			end

			if (lower(@WFType) = 'onboarding' and lower(@TableName) = 'personnel') and not exists(select top 1 [id] from [ess.WFProcLU] where ([Proc] like 'ess.Onboarding%'))
			begin

				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.OnboardingHRAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.OnboardingHRReject')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.OnboardingLMAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.OnboardingLMReject')

			end

			if (lower(@WFType) = 'basic conditions')
			begin
			
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.BasicCApprove')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.BasicCReject')

			end

			/*
			if (lower(@WFType) = 'registration')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.RegisterActivate')

			if (lower(@WFType) = 'pd standards')
			begin
			
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.PDPlanned_Update')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.FreezePath')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.PDPlanned_Create')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.PDEvaluation')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.PDPlanned')
				
			end
			*/
			
			if (lower(@WFType) = 'terminations' and lower(@TableName) = 'Personnel')
			begin

				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.TerminationHRAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.TerminationHRReject')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.TerminationLMAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.TerminationLMReject')

			end
			
			if (lower(@WFType) = 'transfers' and lower(@TableName) = 'Personnel')
			begin

				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.TransferHRAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.TransferHRReject')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.TransferLMAccept')
				insert into [ess.WFProcLU]([TypeID], [Proc]) values(@WFLUID, 'ess.TransferLMReject')

			end

			fetch next from tCursor into @WFLUID, @WFType, @TableName
			
		end
		
	close tCursor
	
	deallocate tCursor
	
end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[GroupTypeLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists(select top 1 [ID] from [GroupTypeLU])
	begin

		insert into [GroupTypeLU]([TypeID], [Description]) values(4, 'Average')
		insert into [GroupTypeLU]([TypeID], [Description]) values(3, 'Count')
		insert into [GroupTypeLU]([TypeID], [Description]) values(5, 'Custom')
		insert into [GroupTypeLU]([TypeID], [Description]) values(2, 'Max')
		insert into [GroupTypeLU]([TypeID], [Description]) values(1, 'Min')
		insert into [GroupTypeLU]([TypeID], [Description]) values(6, 'None')
		insert into [GroupTypeLU]([TypeID], [Description]) values(0, 'Sum')

	end

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[MessagingLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists(select top 1 [id] from [MessagingLU])
	begin

		/* *** Reset Password *** */
		/* ***************************** */
		insert into [MessagingLU]([Type], [Body]) values('Password: Reset', 'Your Employee Self Service password has been reset to <%PARAM[3]%>')

		/* *** Notification Workflow *** */
		/* ***************************** */
		insert into [MessagingLU]([Type], [Body]) values('Notify - Inform', 'You have been assigned a notification task - SmartHR')
		insert into [MessagingLU]([Type], [Body]) values('Notify - Originator', 'Your notification request submitted on <%PARAM[0]%> has been assigned to <%PARAM[1]%> for further processing')
		insert into [MessagingLU]([Type], [Body]) values('Notify - Completed', 'Your notification request submitted on <%PARAM[0]%> has been <%PARAM[2]%>')
		insert into [MessagingLU]([Type], [Body]) values('Notify - Actioned', 'Your notification task has been processed by <%PARAM[3]%>')

		/* *** Change: Notify Control Workflow *** */
		/* *************************************** */
		insert into [MessagingLU]([Type], [Body]) values('Change: Notify - Inform', 'This is a notification to inform you that <%PARAM[5]%> has made changes to their personal/organizational module on the Employee Self Service')
		insert into [MessagingLU]([Type], [Body]) values('Change: Notify - Originator', 'Your change control request has successfully been processed')

		/* *** Change: Approve Control Workflow *** */
		/* **************************************** */
		insert into [MessagingLU]([Type], [Body]) values('Change: Approve - Inform', 'You have been assigned a change control task - SmartHR')
		insert into [MessagingLU]([Type], [Body]) values('Change: Approve - Originator', 'Your change control request submitted on <%PARAM[0]%> has been assigned to <%PARAM[1]%> for further processing')
		insert into [MessagingLU]([Type], [Body]) values('Change: Approve - Completed', 'Your change control request submitted on <%PARAM[0]%> has been <%PARAM[2]%>')
		insert into [MessagingLU]([Type], [Body]) values('Change: Approve - Actioned', 'Your change control task has been processed by <%PARAM[3]%>')

		/* *** Leave Workflow *** */
		/* ********************** */
		insert into [MessagingLU]([Type], [Body]) values('Leave - Inform', 'You have been assigned a leave application from <%PARAM[0]%> (<%PARAM[1]%> until <%PARAM[2]%>) - SmartHR')
		insert into [MessagingLU]([Type], [Body]) values('Leave - Originator', 'Your leave application (<%PARAM[1]%> until <%PARAM[2]%>) has been assigned to <%PARAM[3]%> for further processing')
		insert into [MessagingLU]([Type], [Body]) values('Leave - Completed', 'Your leave application (<%PARAM[1]%> until <%PARAM[2]%>) has been <%PARAM[4]%>')
		insert into [MessagingLU]([Type], [Body]) values('Leave - Actioned', 'Your leave application task from <%PARAM[0]%> (<%PARAM[1]%> until <%PARAM[2]%>) has been processed by <%PARAM[5]%>')

		/* *** Evaluation Workflow *** */
		/* **************************** */
		insert into [MessagingLU]([Type], [Body]) values('Evaluation - Inform', 'You have have been assigned a evaluation task - SmartHR')
		insert into [MessagingLU]([Type], [Body]) values('Evaluation - Originator', 'Your evaluation submitted on <%PARAM[0]%> has been assigned to <%PARAM[1]%> for further processing')
		insert into [MessagingLU]([Type], [Body]) values('Evaluation - Completed', 'Your evaluation submitted on <%PARAM[0]%> has been <%PARAM[2]%>')
		insert into [MessagingLU]([Type], [Body]) values('Evaluation - Actioned', 'Your evaluation task from has been processed by <%PARAM[3]%>')

		/* *** Training Workflow *** */
		/* ************************* */
		insert into [MessagingLU]([Type], [Body]) values('Training - Inform', 'You have been assigned a training application from <%PARAM[0]%> (<%PARAM[1]%> until <%PARAM[2]%>) - SmartHR')
		insert into [MessagingLU]([Type], [Body]) values('Training - Originator', 'Your training application (<%PARAM[1]%> until <%PARAM[2]%>) has been assigned to <%PARAM[3]%> for further processing')
		insert into [MessagingLU]([Type], [Body]) values('Training - Completed', 'Your training application (<%PARAM[1]%> until <%PARAM[2]%>) has been <%PARAM[4]%>')
		insert into [MessagingLU]([Type], [Body]) values('Training - Actioned', 'Your training application task from <%PARAM[0]%> (<%PARAM[1]%> until <%PARAM[2]%>) has been processed by <%PARAM[5]%>')

		/* *** Stores Workflow *** */
		/* *********************** */
		insert into [MessagingLU]([Type], [Body]) values('Stores - Inform', 'You have been assigned a store application from <%PARAM[0]%> - SmartHR')
		insert into [MessagingLU]([Type], [Body]) values('Stores - Originator', 'Your store application issued on <%PARAM[2]%> has been assigned to <%PARAM[2]%> for further processing')
		insert into [MessagingLU]([Type], [Body]) values('Stores - Completed', 'Your store application issued on <%PARAM[2]%> has been <%PARAM[3]%>')
		insert into [MessagingLU]([Type], [Body]) values('Stores - Actioned', 'Your store application task from <%PARAM[0]%> has been processed by <%PARAM[4]%>')

		/* *** Loans Workflow *** */
		/* ********************** */
		insert into [MessagingLU]([Type], [Body]) values('Loans - Inform', 'You have been assigned a loan application from <%PARAM[0]%> (<%PARAM[1]%>, <%PARAM[2]%>) - SmartHR')
		insert into [MessagingLU]([Type], [Body]) values('Loans - Originator', 'Your loan application (<%PARAM[1]%>, <%PARAM[2]%>) has been assigned to <%PARAM[3]%> for further processing')
		insert into [MessagingLU]([Type], [Body]) values('Loans - Completed', 'Your loan application (<%PARAM[1]%>, <%PARAM[2]%>) has been <%PARAM[4]%>')
		insert into [MessagingLU]([Type], [Body]) values('Loans - Actioned', 'Your loan application task from <%PARAM[0]%> (<%PARAM[1]%>, <%PARAM[2]%>) has been processed by <%PARAM[5]%>')

		/* *** Claims Workflow *** */
		/* *********************** */
		insert into [MessagingLU]([Type], [Body]) values('Claims - Inform', 'You have been assigned a claim application from <%PARAM[0]%> (<%PARAM[1]%>, <%PARAM[2]%>) - SmartHR')
		insert into [MessagingLU]([Type], [Body]) values('Claims - Originator', 'Your claim application (<%PARAM[1]%>, <%PARAM[2]%>) has been assigned to <%PARAM[3]%> for further processing')
		insert into [MessagingLU]([Type], [Body]) values('Claims - Completed', 'Your claim application (<%PARAM[1]%>, <%PARAM[2]%>) has been <%PARAM[4]%>')
		insert into [MessagingLU]([Type], [Body]) values('Claims - Actioned', 'Your claim application task from <%PARAM[0]%> (<%PARAM[1]%>, <%PARAM[2]%>) has been processed by <%PARAM[5]%>')

		/* *** Cancel Leave Workflow *** */
		/* ***************************** */
		insert into [MessagingLU]([Type], [Body]) values('Cancel: Leave - Inform', 'You have been assigned a leave cancellation from <%PARAM[0]%> (<%PARAM[1]%> until <%PARAM[2]%>) - SmartHR')
		insert into [MessagingLU]([Type], [Body]) values('Cancel: Leave - Originator', 'Your leave cancellation (<%PARAM[1]%> until <%PARAM[2]%>) has been assigned to <%PARAM[3]%> for further processing')
		insert into [MessagingLU]([Type], [Body]) values('Cancel: Leave - Completed', 'Your leave cancellation (<%PARAM[1]%> until <%PARAM[2]%>) has been <%PARAM[4]%>')
		insert into [MessagingLU]([Type], [Body]) values('Cancel: Leave - Actioned', 'Your leave cancellation task from <%PARAM[0]%> (<%PARAM[1]%> until <%PARAM[2]%>) has been processed by <%PARAM[5]%>')

		/* *** Cancel Training Workflow *** */
		/* ******************************** */
		insert into [MessagingLU]([Type], [Body]) values('Cancel: Training - Inform', 'You have been assigned a training cancellation from <%PARAM[0]%> (<%PARAM[1]%> until <%PARAM[2]%>) - SmartHR')
		insert into [MessagingLU]([Type], [Body]) values('Cancel: Training - Originator', 'Your training cancellation (<%PARAM[1]%> until <%PARAM[2]%>) has been assigned to <%PARAM[3]%> for further processing')
		insert into [MessagingLU]([Type], [Body]) values('Cancel: Training - Completed', 'Your training cancellation (<%PARAM[1]%> until <%PARAM[2]%>) has been <%PARAM[4]%>')
		insert into [MessagingLU]([Type], [Body]) values('Cancel: Training - Actioned', 'Your training cancellation task from <%PARAM[0]%> (<%PARAM[1]%> until <%PARAM[2]%>) has been processed by <%PARAM[5]%>')

		/* *** Cancel Stores Workflow *** */
		/* ****************************** */
		insert into [MessagingLU]([Type], [Body]) values('Cancel: Stores - Inform', 'You have been assigned a store cancellation from <%PARAM[0]%> - SmartHR')
		insert into [MessagingLU]([Type], [Body]) values('Cancel: Stores - Originator', 'Your store cancellation issued on <%PARAM[2]%> has been assigned to <%PARAM[2]%> for further processing')
		insert into [MessagingLU]([Type], [Body]) values('Cancel: Stores - Completed', 'Your store cancellation issued on <%PARAM[2]%> has been <%PARAM[3]%>')
		insert into [MessagingLU]([Type], [Body]) values('Cancel: Stores - Actioned', 'Your store cancellation task from <%PARAM[0]%> has been processed by <%PARAM[4]%>')

		/* *** Cancel Loans Workflow *** */
		/* ***************************** */
		insert into [MessagingLU]([Type], [Body]) values('Cancel: Loans - Inform', 'You have been assigned a loan cancellation from <%PARAM[0]%> (<%PARAM[1]%>, <%PARAM[2]%>) - SmartHR')
		insert into [MessagingLU]([Type], [Body]) values('Cancel: Loans - Originator', 'Your loan cancellation (<%PARAM[1]%>, <%PARAM[2]%>) has been assigned to <%PARAM[3]%> for further processing')
		insert into [MessagingLU]([Type], [Body]) values('Cancel: Loans - Completed', 'Your loan cancellation (<%PARAM[1]%>, <%PARAM[2]%>) has been <%PARAM[4]%>')
		insert into [MessagingLU]([Type], [Body]) values('Cancel: Loans - Actioned', 'Your loan cancellation task from <%PARAM[0]%> (<%PARAM[1]%>, <%PARAM[2]%>) has been processed by <%PARAM[5]%>')

	end

	if not exists(select top 1 [id] from [MessagingLU] where ([Type] like 'IR - %'))
	begin

		/* *** IR Workflow *** */
		/* ******************* */
		insert into [MessagingLU]([Type], [Body]) values('IR Performance - Inform', 'You have a meeting with <%PARAM[0]%> on <%PARAM[1]%> to discuss work performance')
		insert into [MessagingLU]([Type], [Body]) values('IR Performance - Originator', 'You have a meeting with <%PARAM[2]%> on <%PARAM[1]%> to discuss work performance')
		insert into [MessagingLU]([Type], [Body]) values('IR Performance - Completed', 'Your meeting with <%PARAM[2]%> on <%PARAM[1]%> with regards to work performance has been <%PARAM[4]%>')
		insert into [MessagingLU]([Type], [Body]) values('IR Performance - Actioned', 'Your IR performance meeting with <%PARAM[0]%> on <%PARAM[1]%> has been processed by <%PARAM[5]%>')

	end

	if not exists(select top 1 [id] from [MessagingLU] where ([Type] like 'Onboarding - %'))
	begin

		/* *** Onboarding Workflow *** */
		/* *************************** */
		insert into [MessagingLU]([Type], [Body]) values('Onboarding - Inform', 'You have been assigned a new employee application (<%PARAM[0]%>) - SmartHR')
		insert into [MessagingLU]([Type], [Body]) values('Onboarding - Originator', 'Your application has been received and pased onto <%PARAM[1]%> for further processing')
		insert into [MessagingLU]([Type], [Body]) values('Onboarding - Completed', 'Your application request has been <%PARAM[9]%>')
		insert into [MessagingLU]([Type], [Body]) values('Onboarding - Actioned', 'Your new employee application task from <%PARAM[11]%> has been processed by <%PARAM[10]%>')

	end

	if not exists(select top 1 [id] from [MessagingLU] where ([Type] like 'Termination - %'))
	begin

		/* *** Termination Workflow *** */
		/* **************************** */
		insert into [MessagingLU]([Type], [Body]) values('Termination - Inform', 'You have been assigned a new termination request for <%PARAM[0]%> - SmartHR')
		insert into [MessagingLU]([Type], [Body]) values('Termination - Originator', 'Your termination request has been received and pased onto <%PARAM[1]%> for further processing')
		insert into [MessagingLU]([Type], [Body]) values('Termination - Completed', 'Your termination request has been <%PARAM[9]%>')
		insert into [MessagingLU]([Type], [Body]) values('Termination - Actioned', 'Your termination task from <%PARAM[11]%> has been processed by <%PARAM[10]%>')

	end

	if not exists(select top 1 [id] from [MessagingLU] where ([Type] like 'Transfer - %'))
	begin

		/* *** Transfer Workflow *** */
		/* ************************* */
		insert into [MessagingLU]([Type], [Body]) values('Transfer - Inform', 'You have been assigned a new transfer request for <%PARAM[0]%> - SmartHR')
		insert into [MessagingLU]([Type], [Body]) values('Transfer - Originator', 'Your transfer request has been received and pased onto <%PARAM[1]%> for further processing')
		insert into [MessagingLU]([Type], [Body]) values('Transfer - Completed', 'Your transfer request has been <%PARAM[13]%>')
		insert into [MessagingLU]([Type], [Body]) values('Transfer - Actioned', 'Your transfer task from <%PARAM[15]%> has been processed by <%PARAM[14]%>')

	end

end
GO

/* TODO: v6.0.74 remove once released (this is only to ensure all new items are created in order) */
if exists (select [id] from [sysobjects] where [id] = object_id(N'[ParameterLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists(select top 1 [id] from [ParameterLU])
	begin

		/* *** Reset Password *** */
		/* ********************** */
		/*
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Users', 'Password: Reset', 0, 'Password')
		*/
		
		/* *** Notification Workflow *** */
		/* ***************************** */
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('ess.NotifyHR', 'Notify', 0, 'DateNotified')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('ess.NotifyHR', 'Notify', 1, 'Actioner')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('ess.NotifyHR', 'Notify', 2, 'ActType')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('ess.NotifyHR', 'Notify', 3, 'ActionedBy')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('ess.NotifyHR', 'Notify', 4, 'PrevActioner')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('ess.NotifyHR', 'Notify', 5, 'Originator')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('ess.NotifyHR', 'Notify', 6, 'Status')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('ess.NotifyHR', 'Notify', 7, 'Subject')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('ess.NotifyHR', 'Notify', 8, 'Description')
		
		/* *** Change Control Workflow *** */
		/* ******************************* */
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('ess.Change', 'Change', 0, 'NotifyDate')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('ess.Change', 'Change', 1, 'Actioner')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('ess.Change', 'Change', 2, 'ActType')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('ess.Change', 'Change', 3, 'ActionedBy')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('ess.Change', 'Change', 4, 'PrevActioner')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('ess.Change', 'Change', 5, 'Originator')

		/* *** Leave Workflow *** */
		/* ********************** */
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Leave', 'Leave', 0, 'Originator')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Leave', 'Leave', 1, 'StartDate')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Leave', 'Leave', 2, 'EndDate')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Leave', 'Leave', 3, 'Actioner')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Leave', 'Leave', 4, 'ActType')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Leave', 'Leave', 5, 'ActionedBy')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Leave', 'Leave', 6, 'PrevActioner')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Leave', 'Leave', 7, 'Summary')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Leave', 'Leave', 8, 'Duration')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Leave', 'Leave', 9, 'LeaveStatus')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Leave', 'Leave', 10, 'Remarks')

		/* *** Evaluation Workflow *** */
		/* *************************** */
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('PerfEvalScheme', 'Performance', 0, 'EvalDate')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('PerfEvalScheme', 'Performance', 1, 'Actioner')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('PerfEvalScheme', 'Performance', 2, 'ActType')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('PerfEvalScheme', 'Performance', 3, 'ActionedBy')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('PerfEvalScheme', 'Performance', 4, 'PrevActioner')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('PerfEvalScheme', 'Performance', 5, 'Originator')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('PerfEvalScheme', 'Performance', 6, 'Name')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('PerfEvalScheme', 'Performance', 7, 'AppraiserType')

		/* *** Training Workflow *** */
		/* ************************* */
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('TrainingPlanned', 'Training', 0, 'Originator')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('TrainingPlanned', 'Training', 1, 'StartDate')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('TrainingPlanned', 'Training', 2, 'CompletionDate')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('TrainingPlanned', 'Training', 3, 'Actioner')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('TrainingPlanned', 'Training', 4, 'ActType')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('TrainingPlanned', 'Training', 5, 'ActionedBy')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('TrainingPlanned', 'Training', 6, 'PrevActioner')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('TrainingPlanned', 'Training', 7, 'CourseName')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('TrainingPlanned', 'Training', 8, 'Duration')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('TrainingPlanned', 'Training', 9, 'DurationType')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('TrainingPlanned', 'Training', 10, 'TrainingStatus')

		/* *** Stores Workflow *** */
		/* *********************** */
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('StoreIssued', 'Stores', 0, 'Originator')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('StoreIssued', 'Stores', 1, 'IssueDate')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('StoreIssued', 'Stores', 2, 'Actioner')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('StoreIssued', 'Stores', 3, 'ActType')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('StoreIssued', 'Stores', 4, 'ActionedBy')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('StoreIssued', 'Stores', 5, 'PrevActioner')

		/* *** Loans Workflow *** */
		/* ********************** */
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Loan', 'Loans', 0, 'Originator')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Loan', 'Loans', 1, 'LoanDate')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Loan', 'Loans', 2, 'Amount')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Loan', 'Loans', 3, 'Actioner')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Loan', 'Loans', 4, 'ActType')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Loan', 'Loans', 5, 'ActionedBy')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Loan', 'Loans', 6, 'PrevActioner')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Loan', 'Loans', 7, 'IntRate')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Loan', 'Loans', 8, 'Term')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Loan', 'Loans', 9, 'FirstInstallment')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Loan', 'Loans', 10, 'LoanStatus')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Loan', 'Loans', 11, 'Remarks')

		/* *** Claims Workflow *** */
		/* *********************** */
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Claims', 'Claims', 0, 'Originator')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Claims', 'Claims', 1, 'Date')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Claims', 'Claims', 2, 'Type')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Claims', 'Claims', 3, 'Actioner')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Claims', 'Claims', 4, 'ActType')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Claims', 'Claims', 5, 'ActionedBy')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Claims', 'Claims', 6, 'PrevActioner')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Claims', 'Claims', 7, 'Status')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Claims', 'Claims', 8, 'Description')

	end

	if not exists(select top 1 [id] from [ParameterLU] where ([TableName] = 'Counselling_Work_Performance' and [Type] = 'IR'))
	begin

		/* *** IR Workflow *** */
		/* ******************* */
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Counselling_Work_Performance', 'IR', 0, 'Originator')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Counselling_Work_Performance', 'IR', 1, 'Follow_Up_Date')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Counselling_Work_Performance', 'IR', 2, 'Manager')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Counselling_Work_Performance', 'IR', 3, 'Actioner')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Counselling_Work_Performance', 'IR', 4, 'ActType')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Counselling_Work_Performance', 'IR', 5, 'ActionedBy')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Counselling_Work_Performance', 'IR', 6, 'PrevActioner')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Counselling_Work_Performance', 'IR', 7, 'Status')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Counselling_Work_Performance', 'IR', 8, 'Description')

	end

	if not exists(select top 1 [id] from [ParameterLU] where ([TableName] = 'Personnel' and [Type] = 'Onboarding'))
	begin

		/* *** Onboarding Workflow *** */
		/* **************************** */
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Onboarding', 0, 'Originator')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Onboarding', 1, 'Actioner')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Onboarding', 2, 'EmployeeNum')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Onboarding', 3, 'JobTitle')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Onboarding', 4, 'JobGrade')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Onboarding', 5, 'CostCentre')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Onboarding', 6, 'Appointdate')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Onboarding', 7, 'Appointype')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Onboarding', 8, 'CompanyNum')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Onboarding', 9, 'ActType')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Onboarding', 10, 'ActionedBy')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Onboarding', 11, 'PrevActioner')

	end

	if not exists(select top 1 [id] from [ParameterLU] where ([TableName] = 'Personnel' and [Type] = 'Terminations'))
	begin

		/* *** Termination Workflow *** */
		/* **************************** */
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Terminations', 0, 'Originator')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Terminations', 1, 'Actioner')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Terminations', 2, 'EmployeeNum')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Terminations', 3, 'JobTitle')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Terminations', 4, 'CostCentre')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Terminations', 5, 'Appointdate')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Terminations', 6, 'Appointype')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Terminations', 7, 'TerminationDate')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Terminations', 8, 'TerminationReason')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Terminations', 9, 'ActType')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Terminations', 10, 'ActionedBy')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Terminations', 11, 'PrevActioner')

	end

	if not exists(select top 1 [id] from [ParameterLU] where ([TableName] = 'Personnel' and [Type] = 'Transfers'))
	begin

		/* *** Transfer Workflow *** */
		/* **************************** */
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Transfers', 0, 'Originator')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Transfers', 1, 'Actioner')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Transfers', 2, 'EmployeeNum')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Transfers', 3, 'JobTitle')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Transfers', 4, 'JobGrade')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Transfers', 5, 'CostCentre')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Transfers', 6, 'TransferDate')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Transfers', 7, 'TransferReason')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Transfers', 8, 'CompanyNum')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Transfers', 9, '(select top 1 [SQLData] from [ess.SQLExecute] where ([PathID] = <%PathID%>)) as [CompanyNum1]')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Transfers', 10, '(select top 1 [SQLData] from [ess.SQLExecute] where ([PathID] = <%PathID%> and [SQLData] like ''%JobTitle%'')) as [JobTitle1]')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Transfers', 11, '(select top 1 [SQLData] from [ess.SQLExecute] where ([PathID] = <%PathID%> and [SQLData] like ''%JobGrade%'')) as [JobGrade1]')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Transfers', 12, '(select top 1 [SQLData] from [ess.SQLExecute] where ([PathID] = <%PathID%> and [SQLData] like ''%CostCentre%'')) as [CostCentre1]')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Transfers', 13, 'ActType')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Transfers', 14, 'ActionedBy')
		insert into [ParameterLU]([Tablename], [Type], [Index], [Value]) values('Personnel', 'Transfers', 15, 'PrevActioner')

	end

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[PerfClass]') and objectproperty([id], N'IsUserTable') = 1)
begin

	if not exists(select top 1 [ClassCode] from [PerfClass] where ([ClassCode] = 'ESS'))
		insert into [PerfClass]([ClassCode], [ClassName], [Description], [DefaultWeight]) values('ESS', 'ESS', 'Employee Self Service Class: auto generated, do not delete.', 100)

end
GO

/**********************************************************************************************************

					*** v6.0.74 (create default workflows and linked emails) ***

***********************************************************************************************************/
if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.WFLU]') and objectproperty([id], N'IsUserTable') = 1)
begin

	declare @EmailID tinyint,
			@WFLUID tinyint,
			@WFID smallint,
			@WFID2 smallint,
			@WFID3 smallint,
			@WFID4 smallint,
			@WFPostID smallint,
			@ActionID tinyint

	/* Notify Workflow */
	if not exists(select top 1 [id] from [ess.WFLU] where ([WFName] = 'Notify' and [WFType] like 'Notify'))
	begin

		if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'Notify' and [TableName] = 'ess.NotifyHR'))
			insert into [ess.WFTypeLU]([WFType], [TableName]) values('Notify', 'ess.NotifyHR')

		insert into [ess.WFLU]([WFName], [WFType]) values('Notify', 'Notify')

		select @WFLUID = scope_identity()

		if not exists(select top 1 [id] from [ess.WFAppType] where ([AppType] like 'Notify' and [WFType] like 'Notify'))
			insert into [ess.WFAppType]([AppType], [WFName], [WFType], [StopBalExc]) values('Notify', 'Notify', 'Notify', 0)

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [TaskIDProc]) values(0, 0, @WFLUID, 0, 0, 0, 'ess.NotifyPath')

		select @WFID = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 6, @WFLUID, @WFID, 5, 0, 0, 'ess.NotifyComplete')

		select @WFPostID = scope_identity()

		update [ess.WF] set [PostActID] = @WFPostID where ([id] = @WFID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Notify - Inform')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Notify - Originator')

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Notify - Completed')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFPostID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Notify - Actioned')

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFPostID)

	end

	/* Change: Notify Workflow */
	if not exists(select top 1 [id] from [ess.WFLU] where ([WFName] = 'Notify' and [WFType] like 'Change'))
	begin
	
		if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'Change' and [TableName] = 'ess.Change'))
			insert into [ess.WFTypeLU]([WFType], [TableName]) values('Change', 'ess.Change')
	
		insert into [ess.WFLU]([WFName], [WFType]) values('Notify', 'Change')
	
		select @WFLUID = scope_identity()

		if not exists(select top 1 [id] from [ess.WFAppType] where ([AppType] like 'Notify' and [WFType] like 'Change'))
			insert into [ess.WFAppType]([AppType], [WFName], [WFType], [StopBalExc]) values('Notify', 'Notify', 'Change', 0)

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [TaskIDProc]) values(0, 0, @WFLUID, 0, 0, 0, 'ess.ChangePath')

		select @WFID = scope_identity()

		select @ActionID = [ID] from [ess.ActionLU] where ([ReportsToType] = 'ESS Notifications')

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc]) values(@ActionID, 6, @WFLUID, @WFID, 5, 1, 0)

		select @WFPostID = scope_identity()

		update [ess.WF] set [PostActID] = @WFPostID where ([id] = @WFID)

		/* TODO: Check to ensure sending emails if skipped this item will be temporarily disabled
		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Change: Notify - Inform')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID)*/

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Change: Notify - Originator')

		update [ess.WF] set [EmailID] = @EmailID, [EmailCC] = char(9) where ([id] = @WFPostID)

	end

	/* Change: Approve Workflow */
	if not exists(select top 1 [id] from [ess.WFLU] where ([WFName] like 'Approve' and [WFType] like 'Change'))
	begin
	
		if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'Change' and [TableName] = 'ess.Change'))
			insert into [ess.WFTypeLU]([WFType], [TableName]) values('Change', 'ess.Change')
	
		insert into [ess.WFLU]([WFName], [WFType]) values('Approve', 'Change')
	
		select @WFLUID = scope_identity()

		if not exists(select top 1 [id] from [ess.WFAppType] where ([AppType] like 'Approve' and [WFType] like 'Change'))
			insert into [ess.WFAppType]([AppType], [WFName], [WFType], [StopBalExc]) values('Approve', 'Approve', 'Change', 0)

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [TaskIDProc]) values(0, 0, @WFLUID, 0, 0, 0, 'ess.ChangePath')

		select @WFID = scope_identity()

		select @ActionID = [ID] from [ess.ActionLU] where ([ReportsToType] = 'ESS Notifications')

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc]) values(9, 6, @WFLUID, @WFID, 5, 0, 0)

		select @WFPostID = scope_identity()

		update [ess.WF] set [PostActID] = @WFPostID where ([id] = @WFID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Change: Approve - Inform')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Change: Approve - Originator')

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Change: Approve - Completed')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFPostID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Change: Approve - Actioned')

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFPostID)

	end

	/* Onboarding Workflow */
	if not exists(select top 1 [id] from [ess.WFLU] where ([WFName] like 'Onboarding' and [WFType] like 'Onboarding'))
	begin
	
		if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'Onboarding' and [TableName] = 'Personnel'))
			insert into [ess.WFTypeLU]([WFType], [TableName]) values('Onboarding', 'Personnel')
	
		insert into [ess.WFLU]([WFName], [WFType]) values('Onboarding', 'Onboarding')
	
		select @WFLUID = scope_identity()

		if not exists(select top 1 [id] from [ess.WFAppType] where ([AppType] like 'Onboarding' and [WFType] like 'Onboarding'))
			insert into [ess.WFAppType]([AppType], [WFName], [WFType], [StopBalExc]) values('Onboarding', 'Onboarding', 'Onboarding', 0)

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [TaskIDProc]) values(0, 0, @WFLUID, 0, 0, 0, 'ess.OnboardingPath')

		select @WFID = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 4, @WFLUID, @WFID, 3, 0, 0, 'ess.OnboardingHRAccept')

		select @WFPostID = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 10, @WFLUID, @WFID, 7, 0, 0, 'ess.OnboardingHRReject')

		update [ess.WF] set [PostActID] = @WFPostID where ([id] = @WFID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Onboarding - Inform')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Onboarding - Originator')

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Onboarding - Completed')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFPostID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Onboarding - Actioned')

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFPostID)

	end

	/* Terminations Workflow */
	if not exists(select top 1 [id] from [ess.WFLU] where ([WFName] like 'Terminations' and [WFType] like 'Terminations'))
	begin
	
		if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'Terminations' and [TableName] = 'Personnel'))
			insert into [ess.WFTypeLU]([WFType], [TableName]) values('Terminations', 'Personnel')
	
		insert into [ess.WFLU]([WFName], [WFType]) values('Terminations', 'Terminations')
	
		select @WFLUID = scope_identity()

		if not exists(select top 1 [id] from [ess.WFAppType] where ([AppType] like 'Terminations' and [WFType] like 'Terminations'))
			insert into [ess.WFAppType]([AppType], [WFName], [WFType], [StopBalExc]) values('Terminations', 'Terminations', 'Terminations', 0)

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [TaskIDProc]) values(0, 0, @WFLUID, 0, 0, 0, 'ess.TerminationPath')

		select @WFID = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 4, @WFLUID, @WFID, 3, 0, 0, 'ess.TerminationHRAccept')

		select @WFPostID = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 10, @WFLUID, @WFID, 7, 0, 0, 'ess.TerminationHRReject')

		update [ess.WF] set [PostActID] = @WFPostID where ([id] = @WFID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Termination - Inform')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID)

		/* DO NOT LINK ORIGINATOR OR COMPLETED
		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Termination - Originator')

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Termination - Completed')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFPostID)
		*/

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Termination - Actioned')

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFPostID)

	end

	/* Transfers Workflow */
	if not exists(select top 1 [id] from [ess.WFLU] where ([WFName] like 'Transfers' and [WFType] like 'Transfers'))
	begin
	
		if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'Transfers' and [TableName] = 'Personnel'))
			insert into [ess.WFTypeLU]([WFType], [TableName]) values('Transfers', 'Personnel')
	
		insert into [ess.WFLU]([WFName], [WFType]) values('Transfers', 'Transfers')
	
		select @WFLUID = scope_identity()

		if not exists(select top 1 [id] from [ess.WFAppType] where ([AppType] like 'Transfers' and [WFType] like 'Transfers'))
			insert into [ess.WFAppType]([AppType], [WFName], [WFType], [StopBalExc]) values('Transfers', 'Transfers', 'Transfers', 0)

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [TaskIDProc]) values(0, 0, @WFLUID, 0, 0, 0, 'ess.TransferPath')

		select @WFID = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 4, @WFLUID, @WFID, 3, 0, 0, 'ess.TransferHRAccept')

		select @WFPostID = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 10, @WFLUID, @WFID, 7, 0, 0, 'ess.TransferHRReject')

		update [ess.WF] set [PostActID] = @WFPostID where ([id] = @WFID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Transfer - Inform')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Transfer - Originator')

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Transfer - Completed')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFPostID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Transfer - Actioned')

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFPostID)

	end

	/* Leave Workflow */
	if not exists(select top 1 [id] from [ess.WFLU] where ([WFName] = 'Leave' and [WFType] like 'Leave'))
	begin
	
		if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'Leave' and [TableName] = 'Leave'))
			insert into [ess.WFTypeLU]([WFType], [TableName]) values('Leave', 'Leave')
	
		insert into [ess.WFLU]([WFName], [WFType]) values('Leave', 'Leave')
	
		select @WFLUID = scope_identity()

		insert into [ess.WFAppType]([AppType], [WFName], [WFType], [StopBalExc]) select [LeaveType], 'Leave', 'Leave', 0 from [LeaveLU] where (not [LeaveType] in(select distinct [AppType] from [ess.WFAppType] where ([WFName] = 'Leave' and [WFType] = 'Leave'))) order by [LeaveType]

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [TaskIDProc]) values(0, 0, @WFLUID, 0, 0, 0, 'ess.LeavePath')

		select @WFID = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(10, 4, @WFLUID, 6, 0, 0, 'ess.LeaveLMAccept')

		select @WFID2 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(10, 10, @WFLUID, @WFID, 7, 0, 0, 'ess.LeaveLMReject')

		select @WFID3 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 4, @WFLUID, @WFID, 3, 0, 0, 'ess.LeaveHRAccept')

		select @WFID4 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 10, @WFLUID, @WFID, 7, 0, 0, 'ess.LeaveHRReject')

		select @WFPostID = scope_identity()

		update [ess.WF] set [PostActID] = @WFID2 where ([id] = @WFID)

		update [ess.WF] set [PostActID] = @WFID4 where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Leave - Inform')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Leave - Originator')

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Leave - Completed')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID3)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID4)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFPostID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Leave - Actioned')

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFID2)

	end

	/* Performance Workflow */
	if not exists(select top 1 [id] from [ess.WFLU] where ([WFName] = 'Performance' and [WFType] like 'Performance'))
	begin
	
		if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'Performance' and [TableName] = 'PerfEvalScheme'))
			insert into [ess.WFTypeLU]([WFType], [TableName]) values('Performance', 'PerfEvalScheme')
	
		insert into [ess.WFLU]([WFName], [WFType]) values('Performance', 'Performance')
	
		select @WFLUID = scope_identity()

		if not exists(select top 1 [id] from [ess.WFAppType] where ([AppType] like 'Performance' and [WFType] like 'Performance'))
			insert into [ess.WFAppType]([AppType], [WFName], [WFType], [StopBalExc]) values('Performance', 'Performance', 'Performance', 0)

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [TaskIDProc]) values(0, 0, @WFLUID, 0, 0, 0, 'ess.PerfPath')

		select @WFID = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(24, 3, @WFLUID, @WFID, 2, 0, 0, 'ess.PerfComplete')

		select @WFPostID = scope_identity()

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Evaluation - Inform')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID)

		/* DO NOT LINK ORIGINATOR OR COMPLETED
		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Evaluation - Originator')

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Evaluation - Completed')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFPostID)
		*/

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Evaluation - Actioned')

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFPostID)

	end

	/* Training Workflow */
	if not exists(select top 1 [id] from [ess.WFLU] where ([WFName] = 'Training' and [WFType] like 'Training'))
	begin
	
		if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'Training' and [TableName] = 'TrainingPlanned'))
			insert into [ess.WFTypeLU]([WFType], [TableName]) values('Training', 'TrainingPlanned')
	
		insert into [ess.WFLU]([WFName], [WFType]) values('Training', 'Training')
	
		select @WFLUID = scope_identity()

		if not exists(select top 1 [id] from [ess.WFAppType] where ([AppType] like 'Training' and [WFType] like 'Training'))
			insert into [ess.WFAppType]([AppType], [WFName], [WFType], [StopBalExc]) values('Training', 'Training', 'Training', 0)

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [TaskIDProc]) values(0, 0, @WFLUID, 0, 0, 0, 'ess.TrainingPath')

		select @WFID = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(19, 4, @WFLUID, 6, 0, 0, 'ess.TrainingLMAccept')

		select @WFID2 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(19, 10, @WFLUID, @WFID, 7, 0, 0, 'ess.TrainingLMReject')

		select @WFID3 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 4, @WFLUID, @WFID, 3, 0, 0, 'ess.TrainingHRAccept')

		select @WFID4 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 10, @WFLUID, @WFID, 7, 0, 0, 'ess.TrainingHRReject')

		select @WFPostID = scope_identity()

		update [ess.WF] set [PostActID] = @WFID2 where ([id] = @WFID)

		update [ess.WF] set [PostActID] = @WFID4 where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Training - Inform')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Training - Originator')

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Training - Completed')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID3)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID4)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFPostID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Training - Actioned')

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFID2)

	end

	/* Stores Workflow */
	if not exists(select top 1 [id] from [ess.WFLU] where ([WFName] = 'Stores' and [WFType] like 'Stores'))
	begin
	
		if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'Stores' and [TableName] = 'Stores'))
			insert into [ess.WFTypeLU]([WFType], [TableName]) values('Stores', 'Stores')
	
		insert into [ess.WFLU]([WFName], [WFType]) values('Stores', 'Stores')
	
		select @WFLUID = scope_identity()

		if not exists(select top 1 [id] from [ess.WFAppType] where ([AppType] like 'Stores' and [WFType] like 'Stores'))
			insert into [ess.WFAppType]([AppType], [WFName], [WFType], [StopBalExc]) values('Stores', 'Stores', 'Stores', 0)

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [TaskIDProc]) values(0, 0, @WFLUID, 0, 0, 0, 'ess.StorePath')

		select @WFID = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(31, 4, @WFLUID, 6, 0, 0, 'ess.StoreLMAccept')

		select @WFID2 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(31, 10, @WFLUID, @WFID, 7, 0, 0, 'ess.StoreLMReject')

		select @WFID3 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 4, @WFLUID, @WFID, 3, 0, 0, 'ess.StoreHRAccept')

		select @WFID4 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 10, @WFLUID, @WFID, 7, 0, 0, 'ess.StoreHRReject')

		select @WFPostID = scope_identity()

		update [ess.WF] set [PostActID] = @WFID2 where ([id] = @WFID)

		update [ess.WF] set [PostActID] = @WFID4 where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Stores - Inform')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Stores - Originator')

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Stores - Completed')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID3)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID4)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFPostID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Stores - Actioned')

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFID2)

	end

	/* Loans Workflow */
	if not exists(select top 1 [id] from [ess.WFLU] where ([WFName] = 'Loans' and [WFType] like 'Loans'))
	begin
	
		if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'Loans' and [TableName] = 'Loan'))
			insert into [ess.WFTypeLU]([WFType], [TableName]) values('Loans', 'Loan')
	
		insert into [ess.WFLU]([WFName], [WFType]) values('Loans', 'Loans')
	
		select @WFLUID = scope_identity()

		if not exists(select top 1 [id] from [ess.WFAppType] where ([AppType] like 'Loans' and [WFType] like 'Loans'))
			insert into [ess.WFAppType]([AppType], [WFName], [WFType], [StopBalExc]) values('Loans', 'Loans', 'Loans', 0)

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [TaskIDProc]) values(0, 0, @WFLUID, 0, 0, 0, 'ess.LoanPath')

		select @WFID = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(6, 4, @WFLUID, 6, 0, 0, 'ess.LoanLMAccept')

		select @WFID2 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(6, 10, @WFLUID, @WFID, 7, 0, 0, 'ess.LoanLMReject')

		select @WFID3 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 4, @WFLUID, @WFID, 3, 0, 0, 'ess.LoanHRAccept')

		select @WFID4 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 10, @WFLUID, @WFID, 7, 0, 0, 'ess.LoanHRReject')

		select @WFPostID = scope_identity()

		update [ess.WF] set [PostActID] = @WFID2 where ([id] = @WFID)

		update [ess.WF] set [PostActID] = @WFID4 where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Loans - Inform')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Loans - Originator')

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Loans - Completed')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID3)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID4)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFPostID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Loans - Actioned')

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFID2)

	end

	/* Claims Workflow */
	if not exists(select top 1 [id] from [ess.WFLU] where ([WFName] = 'Claims' and [WFType] like 'Claims'))
	begin
	
		if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'Claims' and [TableName] = 'Claims'))
			insert into [ess.WFTypeLU]([WFType], [TableName]) values('Claims', 'Claims')
	
		insert into [ess.WFLU]([WFName], [WFType]) values('Claims', 'Claims')
	
		select @WFLUID = scope_identity()

		if not exists(select top 1 [id] from [ess.WFAppType] where ([AppType] like 'Claims' and [WFType] like 'Claims'))
			insert into [ess.WFAppType]([AppType], [WFName], [WFType], [StopBalExc]) values('Claims', 'Claims', 'Claims', 0)

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [TaskIDProc]) values(0, 0, @WFLUID, 0, 0, 0, 'ess.ClaimPath')

		select @WFID = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(30, 4, @WFLUID, 6, 0, 0, 'ess.ClaimLMAccept')

		select @WFID2 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(30, 10, @WFLUID, @WFID, 7, 0, 0, 'ess.ClaimLMReject')

		select @WFID3 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 4, @WFLUID, @WFID, 3, 0, 0, 'ess.ClaimHRAccept')

		select @WFID4 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 10, @WFLUID, @WFID, 7, 0, 0, 'ess.ClaimHRReject')

		select @WFPostID = scope_identity()

		update [ess.WF] set [PostActID] = @WFID2 where ([id] = @WFID)

		update [ess.WF] set [PostActID] = @WFID4 where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Claims - Inform')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Claims - Originator')

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Claims - Completed')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID3)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID4)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFPostID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Claims - Actioned')

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFID2)

	end

	/* Cancel Leave Workflow */
	if not exists(select top 1 [id] from [ess.WFLU] where ([WFType] like 'Leave' and [WFName] in(select [WFName] from [ess.WFAppType] where ([AppType] = 'Cancel' and [WFType] = 'Leave'))))
	begin
	
		insert into [ess.WFLU]([WFName], [WFType]) values('LeaveCancel', 'Leave')
	
		select @WFLUID = scope_identity()

		if not exists(select top 1 [id] from [ess.WFAppType] where ([AppType] like 'Cancel' and [WFType] like 'Leave'))
			insert into [ess.WFAppType]([AppType], [WFName], [WFType], [StopBalExc]) values('Cancel', 'LeaveCancel', 'Leave', 0)

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [TaskIDProc]) values(0, 0, @WFLUID, 0, 0, 0, 'ess.CancelLeave')

		select @WFID = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc]) values(10, 4, @WFLUID, 6, 0, 0)

		select @WFID2 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc]) values(10, 10, @WFLUID, @WFID, 7, 0, 0)

		select @WFID3 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 4, @WFLUID, @WFID, 3, 0, 0, 'ess.LeaveCancel')

		select @WFID4 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc]) values(9, 10, @WFLUID, @WFID, 7, 0, 0)

		select @WFPostID = scope_identity()

		update [ess.WF] set [PostActID] = @WFID2 where ([id] = @WFID)

		update [ess.WF] set [PostActID] = @WFID4 where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Cancel: Leave - Inform')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Cancel: Leave - Originator')

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Cancel: Leave - Completed')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID3)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID4)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFPostID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Cancel: Leave - Actioned')

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFID2)

	end

	/* Cancel Training Workflow */
	if not exists(select top 1 [id] from [ess.WFLU] where ([WFType] like 'Training' and [WFName] in(select [WFName] from [ess.WFAppType] where ([AppType] = 'Cancel' and [WFType] = 'Training'))))
	begin
	
		insert into [ess.WFLU]([WFName], [WFType]) values('TrainingCancel', 'Training')
	
		select @WFLUID = scope_identity()

		if not exists(select top 1 [id] from [ess.WFAppType] where ([AppType] like 'Cancel' and [WFType] like 'Training'))
			insert into [ess.WFAppType]([AppType], [WFName], [WFType], [StopBalExc]) values('Cancel', 'TrainingCancel', 'Training', 0)

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [TaskIDProc]) values(0, 0, @WFLUID, 0, 0, 0, 'ess.CancelTraining')

		select @WFID = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc]) values(19, 4, @WFLUID, 6, 0, 0)

		select @WFID2 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc]) values(19, 10, @WFLUID, @WFID, 7, 0, 0)

		select @WFID3 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 4, @WFLUID, @WFID, 3, 0, 0, 'ess.TrainingCancel')

		select @WFID4 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc]) values(9, 10, @WFLUID, @WFID, 7, 0, 0)

		select @WFPostID = scope_identity()

		update [ess.WF] set [PostActID] = @WFID2 where ([id] = @WFID)

		update [ess.WF] set [PostActID] = @WFID4 where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Cancel: Training - Inform')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Cancel: Training - Originator')

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Cancel: Training - Completed')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID3)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID4)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFPostID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Cancel: Training - Actioned')

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFID2)

	end

	/* Cancel Stores Workflow */
	if not exists(select top 1 [id] from [ess.WFLU] where ([WFType] like 'Stores' and [WFName] in(select [WFName] from [ess.WFAppType] where ([AppType] = 'Cancel' and [WFType] = 'Stores'))))
	begin
	
		insert into [ess.WFLU]([WFName], [WFType]) values('StoresCancel', 'Stores')
	
		select @WFLUID = scope_identity()

		if not exists(select top 1 [id] from [ess.WFAppType] where ([AppType] like 'Cancel' and [WFType] like 'Stores'))
			insert into [ess.WFAppType]([AppType], [WFName], [WFType], [StopBalExc]) values('Cancel', 'StoresCancel', 'Stores', 0)

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [TaskIDProc]) values(0, 0, @WFLUID, 0, 0, 0, 'ess.CancelStore')

		select @WFID = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc]) values(31, 4, @WFLUID, 6, 0, 0)

		select @WFID2 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc]) values(31, 10, @WFLUID, @WFID, 7, 0, 0)

		select @WFID3 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 4, @WFLUID, @WFID, 3, 0, 0, 'ess.StoreCancel')

		select @WFID4 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc]) values(9, 10, @WFLUID, @WFID, 7, 0, 0)

		select @WFPostID = scope_identity()

		update [ess.WF] set [PostActID] = @WFID2 where ([id] = @WFID)

		update [ess.WF] set [PostActID] = @WFID4 where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Cancel: Stores - Inform')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Cancel: Stores - Originator')

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Cancel: Stores - Completed')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID3)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID4)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFPostID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Cancel: Stores - Actioned')

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFID2)

	end

	/* Cancel Loans Workflow */
	if not exists(select top 1 [id] from [ess.WFLU] where ([WFType] like 'Loans' and [WFName] in(select [WFName] from [ess.WFAppType] where ([AppType] = 'Cancel' and [WFType] = 'Loans'))))
	begin
	
		insert into [ess.WFLU]([WFName], [WFType]) values('LoansCancel', 'Loans')
	
		select @WFLUID = scope_identity()

		if not exists(select top 1 [id] from [ess.WFAppType] where ([AppType] like 'Cancel' and [WFType] like 'Loans'))
			insert into [ess.WFAppType]([AppType], [WFName], [WFType], [StopBalExc]) values('Cancel', 'LoansCancel', 'Loans', 0)

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [TaskIDProc]) values(0, 0, @WFLUID, 0, 0, 0, 'ess.CancelLoan')

		select @WFID = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc]) values(6, 4, @WFLUID, 6, 0, 0)

		select @WFID2 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc]) values(6, 10, @WFLUID, @WFID, 7, 0, 0)

		select @WFID3 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 4, @WFLUID, @WFID, 3, 0, 0, 'ess.LoanCancel')

		select @WFID4 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc]) values(9, 10, @WFLUID, @WFID, 7, 0, 0)

		select @WFPostID = scope_identity()

		update [ess.WF] set [PostActID] = @WFID2 where ([id] = @WFID)

		update [ess.WF] set [PostActID] = @WFID4 where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Cancel: Loans - Inform')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Cancel: Loans - Originator')

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Cancel: Loans - Completed')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID3)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID4)

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFPostID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'Cancel: Loans - Actioned')

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFID)

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFID2)

	end

	/* IR Workflow (Performance) */
	if not exists(select top 1 [id] from [ess.WFLU] where ([WFName] = 'IR Performance' and [WFType] like 'IR'))
	begin

		if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'IR' and [TableName] = 'Counselling_Work_Performance'))
			insert into [ess.WFTypeLU]([WFType], [Tablename]) values('IR', 'Counselling_Work_Performance')

		insert into [ess.WFLU]([WFName], [WFType]) values('IR Performance', 'IR')

		select @WFLUID = scope_identity()

		if not exists(select top 1 [id] from [ess.WFAppType] where ([AppType] like 'IR Performance' and [WFType] like 'IR'))
			insert into [ess.WFAppType]([AppType], [WFName], [WFType], [StopBalExc]) values('IR Performance', 'IR Performance', 'IR', 0)

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [TaskIDProc]) values(0, 0, @WFLUID, 0, 0, 0, 'ess.IRPerfPath')

		select @WFID = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(12, 4, @WFLUID, @WFID, 3, 0, 0, 'ess.IRPerfHRAccept')

		select @WFID2 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(12, 10, @WFLUID, @WFID, 7, 0, 0, 'ess.IRPerfHRReject')

		select @WFPostID = scope_identity()

		update [ess.WF] set [PostActID] = @WFPostID where ([id] = @WFID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'IR Performance - Inform')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'IR Performance - Originator')

		update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'IR Performance - Completed')

		update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFPostID or [id] = @WFID2)

		select @EmailID = [ID] from [EmailLU] where ([Type] = 'IR Performance - Actioned')

		update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFPostID)

	end

	/* IR Workflow (Conduct) */
	if not exists(select top 1 [id] from [ess.WFLU] where ([WFName] = 'IR Conduct' and [WFType] like 'IR'))
	begin
	
		if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'IR' and [TableName] = 'Counselling_Conduct'))
			insert into [ess.WFTypeLU]([WFType], [Tablename]) values('IR', 'Counselling_Conduct')

		insert into [ess.WFLU]([WFName], [WFType]) values('IR Conduct', 'IR')
	
		select @WFLUID = scope_identity()

		if not exists(select top 1 [id] from [ess.WFAppType] where ([AppType] like 'IR Conduct' and [WFType] like 'IR'))
			insert into [ess.WFAppType]([AppType], [WFName], [WFType], [StopBalExc]) values('IR Conduct', 'IR Conduct', 'IR', 0)

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [TaskIDProc]) values(0, 0, @WFLUID, 0, 0, 0, 'ess.IRConductPath')

		select @WFID = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(16, 4, @WFLUID, 6, 0, 0, 'ess.IRConductLMAccept')

		select @WFID2 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(16, 10, @WFLUID, @WFID, 7, 0, 0, 'ess.IRConductLMReject')

		select @WFID3 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 4, @WFLUID, @WFID, 3, 0, 0, 'ess.IRConductHRAccept')

		select @WFID4 = scope_identity()

		insert into [ess.WF]([ActionID], [StatusID], [WFLUID], [PostActID], [PAID], [SkipNonExt], [ExecNonProc], [PostActProc]) values(9, 10, @WFLUID, @WFID, 7, 0, 0, 'ess.IRConductHRReject')

		select @WFPostID = scope_identity()

		update [ess.WF] set [PostActID] = @WFID2 where ([id] = @WFID)

		update [ess.WF] set [PostActID] = @WFID4 where ([id] = @WFID2)

		--select @EmailID = [ID] from [EmailLU] where ([Type] = 'Leave - Inform')

		--update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID)

		--update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID2)

		--select @EmailID = [ID] from [EmailLU] where ([Type] = 'Leave - Originator')

		--update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID)

		--update [ess.WF] set [EmailOrigID] = @EmailID where ([id] = @WFID2)

		--select @EmailID = [ID] from [EmailLU] where ([Type] = 'Leave - Completed')

		--update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID3)

		--update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFID4)

		--update [ess.WF] set [EmailID] = @EmailID where ([id] = @WFPostID)

		--select @EmailID = [ID] from [EmailLU] where ([Type] = 'Leave - Actioned')

		--update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFID)

		--update [ess.WF] set [EmailActID] = @EmailID where ([id] = @WFID2)

	end

/*
	if not exists(select top 1 [id] from [ess.WFTypeLU] where ([WFType] = 'IR' and [TableName] = 'Discipline'))
		insert into [ess.WFTypeLU]([WFType], [Tablename]) values('IR', 'Discipline')
*/

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.PolicyItems]') and objectproperty([id], N'IsTable') = 1)
begin

	update [ess.PolicyItems] set [Validation] = null where ([PolicyID] in(select [ID] from [ess.Policy] where ([Key] = 'CellTel')))

	update [ess.PolicyItems] set [Validation] = null where ([PolicyID] in(select [ID] from [ess.Policy] where ([Key] = 'EmailAddress1')))

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[ess.Policy]') and objectproperty([id], N'IsTable') = 1)
begin

	update [ess.Policy] set [Validation] = null where ([Key] = 'CellTel')

	update [ess.Policy] set [Validation] = null where ([Key] = 'EmailAddress1')

end
GO

if exists (select [id] from [sysobjects] where [id] = object_id(N'[GlobalSettings]') and objectproperty([id], N'IsTable') = 1)
begin

	if not exists(select top 1 [SettingName] from [GlobalSettings] where ([SettingName] = 'Leave Balance Display - Number of Decimals'))
		insert into [GlobalSettings]([SettingName], [SettingValue]) values('Leave Balance Display - Number of Decimals', '2')

end
GO

/**********************************************************************************************************

									*** v6.0.74 (Create Views) ***

***********************************************************************************************************/
declare @iCount bigint,
	@iLoop bigint,
	@name sysname,
	@SQLExec nvarchar(4000)

declare @SQLViews table
(
	[ID] bigint identity (1, 1) not null,
	[name] sysname not null
)

insert into @SQLViews select [name] from [sysobjects] where ([name] like 'ess.%' and objectproperty([ID], 'IsTable') = 1)

set @iLoop = 1

select @iCount = count([ID]) from @SQLViews

while (@iLoop <= @iCount)
begin

	select @name = [name] from @SQLViews where ([ID] = @iLoop)

	set @SQLExec = 'create view [dbo].[' + replace(@name, '.', '_') + '] as select * from [dbo].[' + @name + ']'

	exec sp_executesql @SQLExec

	set @iLoop = @iLoop + 1

end
GO