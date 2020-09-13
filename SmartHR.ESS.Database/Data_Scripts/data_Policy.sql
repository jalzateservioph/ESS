--policy reset query
--delete from [ess.Policy]
--delete from [ess.PolicyMapping]

--reset id sequesnce
--declare @idx int = (select count(*) from [ess.Policy])
--DBCC CHECKIDENT ('[ess.Policy]', RESEED, @idx);
TRUNCATE TABLE [ess.Policy]

/**************************** ess.Policy - 'Information' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Information')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(1,5,3,5,3,'Information','Information','Information','This security setting determines whether the connection information is displayed on the main logon screen.

		If this policy is enabled, the user will see to which server and database the application is connecting to.

		Default:

		Disabled on new installations.',1,1,0,0,1);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 1, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'Information', Label = 'Information', [Description] = 'This security setting determines whether the connection information is displayed on the main logon screen.

		If this policy is enabled, the user will see to which server and database the application is connecting to.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 1 WHERE [Key]  = 'Information';
END

/**************************** ess.Policy - 'Strict' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Strict')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(1,5,3,5,3,'Strict','Strict','Strict','This security setting determines whether passwords must meet complexity requirements.

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

		By default, member computers follow the configuration of their domain controllers.',1,1,0,0,1);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 1, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'Strict', Label = 'Strict', [Description] = 'This security setting determines whether passwords must meet complexity requirements.

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

		By default, member computers follow the configuration of their domain controllers.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 1 WHERE [Key]  = 'Strict';
END

/**************************** ess.Policy - 'MinLength' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'MinLength')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(1,18,9,18,9,'MinLength','MinLength','MinLength','This security setting determines the least number of characters that a password for a user account may contain. You can set a value of between 1 and 14 characters, or you can establish that no password is required by setting the number of characters to 0.

		Default:

		8 on new installations.

		Note:

		By default, member computers follow the configuration of their domain controllers.',1,1,0,0,1);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 1, SetupAssemblyID = 18, SetupDataTypeID = 9, AssemblyID = 18, DataTypeID = 9, Name = 'MinLength', Label = 'MinLength', [Description] = 'This security setting determines the least number of characters that a password for a user account may contain. You can set a value of between 1 and 14 characters, or you can establish that no password is required by setting the number of characters to 0.

		Default:

		8 on new installations.

		Note:

		By default, member computers follow the configuration of their domain controllers.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 1 WHERE [Key]  = 'MinLength';
END

/**************************** ess.Policy - 'ADEnabled' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ADEnabled')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(1,5,3,5,3,'ADEnabled','ADEnabled','ADEnabled','This security setting determines whether usernames and passwords are validated against an active directory store.

		If this policy is enabled, then the user will have to supply their windows username and password to logon to the system, which will then be validated against the active directory store.

		Default:

		Disabled on new installations.

		Note:

		If this policy is enabled, then the required ''ADServer'' policy item also needs to be configured. The configuration of passwords do not apply to this authentication type as this is controlled by the active directory domain controllers.',1,1,0,0,1);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 1, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'ADEnabled', Label = 'ADEnabled', [Description] = 'This security setting determines whether usernames and passwords are validated against an active directory store.

		If this policy is enabled, then the user will have to supply their windows username and password to logon to the system, which will then be validated against the active directory store.

		Default:

		Disabled on new installations.

		Note:

		If this policy is enabled, then the required ''ADServer'' policy item also needs to be configured. The configuration of passwords do not apply to this authentication type as this is controlled by the active directory domain controllers.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 1 WHERE [Key]  = 'ADEnabled';
END

/**************************** ess.Policy - 'ADLogon' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ADLogon')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(1,5,3,5,3,'ADLogon','ADLogon','ADLogon','This security setting determines whether usernames and passwords are validated against an active directory store for the current logged on user.

		If this policy is enabled, then the user will be allowed to automatically logon to the system without having to supply their windows username and password.

		Default:

		Disabled on new installations.

		Note:

		If this policy is enabled, then the required ''ADServer'' policy item also needs to be configured. The configuration of passwords do not apply to this authentication type as this is controlled by the active directory domain controllers.',1,1,0,0,1);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 1, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'ADLogon', Label = 'ADLogon', [Description] = 'This security setting determines whether usernames and passwords are validated against an active directory store for the current logged on user.

		If this policy is enabled, then the user will be allowed to automatically logon to the system without having to supply their windows username and password.

		Default:

		Disabled on new installations.

		Note:

		If this policy is enabled, then the required ''ADServer'' policy item also needs to be configured. The configuration of passwords do not apply to this authentication type as this is controlled by the active directory domain controllers.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 1 WHERE [Key]  = 'ADLogon';
END

/**************************** ess.Policy - 'ADServer' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ADServer')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(1,19,13,19,13,'ADServer','ADServer','ADServer','This security setting determines the active directory store to use for username and password validation.

		If this policy is configured, then the username and password will be validated against this active directory store.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ADEnabled'' or ''ADLogon'' policy is enabled.',1,1,0,0,1);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 1, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'ADServer', Label = 'ADServer', [Description] = 'This security setting determines the active directory store to use for username and password validation.

		If this policy is configured, then the username and password will be validated against this active directory store.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ADEnabled'' or ''ADLogon'' policy is enabled.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 1 WHERE [Key]  = 'ADServer';
END

/**************************** ess.Policy - 'UseProxy' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'UseProxy')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(1,5,3,5,3,'UseProxy','UseProxy','UseProxy','This security setting specifies whether to use a proxy server when an external connection needs to be established to the internet.

		Default:

		Disabled on new installations.',1,1,0,0,1);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 1, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'UseProxy', Label = 'UseProxy', [Description] = 'This security setting specifies whether to use a proxy server when an external connection needs to be established to the internet.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 1 WHERE [Key]  = 'UseProxy';
END

/**************************** ess.Policy - 'ProxyAddress' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ProxyAddress')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(1,19,13,19,13,'ProxyAddress','ProxyAddress','ProxyAddress','This security setting specifies a proxy address to use when an external connection needs to be established to the internet.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''UseProxy'' policy is enabled. If this policy is configured, then the required ''ProxyPort'' policy item also needs to be configured, otherwise the ''UseProxy'' policy will ignore the Address and Port settings.',1,1,0,0,1);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 1, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'ProxyAddress', Label = 'ProxyAddress', [Description] = 'This security setting specifies a proxy address to use when an external connection needs to be established to the internet.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''UseProxy'' policy is enabled. If this policy is configured, then the required ''ProxyPort'' policy item also needs to be configured, otherwise the ''UseProxy'' policy will ignore the Address and Port settings.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 1 WHERE [Key]  = 'ProxyAddress';
END

/**************************** ess.Policy - 'ProxyPort' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ProxyPort')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(1,18,9,18,9,'ProxyPort','ProxyPort','ProxyPort','This security setting specifies the port on the proxy address server to use when an external connection needs to be established to the internet.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''UseProxy'' policy is enabled.',1,1,0,0,1);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 1, SetupAssemblyID = 18, SetupDataTypeID = 9, AssemblyID = 18, DataTypeID = 9, Name = 'ProxyPort', Label = 'ProxyPort', [Description] = 'This security setting specifies the port on the proxy address server to use when an external connection needs to be established to the internet.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''UseProxy'' policy is enabled.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 1 WHERE [Key]  = 'ProxyPort';
END

/**************************** ess.Policy - 'ProxyUsername' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ProxyUsername')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(1,19,13,19,13,'ProxyUsername','ProxyUsername','ProxyUsername','This security setting specifies a proxy username to use when an external connection needs to be established to the internet.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''UseProxy'' policy is enabled. If this policy is configured, then the required ''ProxyPassword'' policy item also needs to be configured, otherwise the ''UseProxy'' policy will ignore the Username and Password settings.',1,1,0,0,1);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 1, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'ProxyUsername', Label = 'ProxyUsername', [Description] = 'This security setting specifies a proxy username to use when an external connection needs to be established to the internet.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''UseProxy'' policy is enabled. If this policy is configured, then the required ''ProxyPassword'' policy item also needs to be configured, otherwise the ''UseProxy'' policy will ignore the Username and Password settings.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 1 WHERE [Key]  = 'ProxyUsername';
END

/**************************** ess.Policy - 'ProxyPassword' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ProxyPassword')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(1,19,13,19,13,'ProxyPassword','ProxyPassword','ProxyPassword','This security setting specifies a proxy password to use when an external connection needs to be established to the internet.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''UseProxy'' policy is enabled.',1,1,0,0,1);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 1, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'ProxyPassword', Label = 'ProxyPassword', [Description] = 'This security setting specifies a proxy password to use when an external connection needs to be established to the internet.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''UseProxy'' policy is enabled.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 1 WHERE [Key]  = 'ProxyPassword';
END

/**************************** ess.Policy - 'ProxyDomain' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ProxyDomain')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(1,19,13,19,13,'ProxyDomain','ProxyDomain','ProxyDomain','This security setting specifies a proxy domain to use when an external connection needs to be established to the internet.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''UseProxy'' policy is enabled.',1,1,0,0,1);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 1, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'ProxyDomain', Label = 'ProxyDomain', [Description] = 'This security setting specifies a proxy domain to use when an external connection needs to be established to the internet.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''UseProxy'' policy is enabled.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 1 WHERE [Key]  = 'ProxyDomain';
END

/**************************** ess.Policy - 'ErrorLogs' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ErrorLogs')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(1,5,3,5,3,'ErrorLogs','ErrorLogs','ErrorLogs','This setting determines whether errors on the ESS should be emailed through to the local IT support or configured department.

		If this policy is enabled, then any failure on the ESS will be sent through to the local IT department as configured in the appropreate policies.

		Default:

		Disabled on new installations.

		Note:

		If this policy is enabled, then the required ''ErrorFrom'', ''ErrorTo'', ''ErrorSmtp'', ''ErrorPort'' policy items also needs to be configured.',1,1,0,0,1);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 1, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'ErrorLogs', Label = 'ErrorLogs', [Description] = 'This setting determines whether errors on the ESS should be emailed through to the local IT support or configured department.

		If this policy is enabled, then any failure on the ESS will be sent through to the local IT department as configured in the appropreate policies.

		Default:

		Disabled on new installations.

		Note:

		If this policy is enabled, then the required ''ErrorFrom'', ''ErrorTo'', ''ErrorSmtp'', ''ErrorPort'' policy items also needs to be configured.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 1 WHERE [Key]  = 'ErrorLogs';
END

/**************************** ess.Policy - 'ErrorFrom' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ErrorFrom')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(1,19,13,19,13,'ErrorFrom','ErrorFrom','ErrorFrom','This setting specifies the from email address to use when sending error logs via email.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ErrorLogs'' policy is enabled.',1,1,0,0,1);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 1, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'ErrorFrom', Label = 'ErrorFrom', [Description] = 'This setting specifies the from email address to use when sending error logs via email.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ErrorLogs'' policy is enabled.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 1 WHERE [Key]  = 'ErrorFrom';
END

/**************************** ess.Policy - 'ErrorTo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ErrorTo')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(1,19,13,19,13,'ErrorTo','ErrorTo','ErrorTo','This setting specifies the to email address to use when sending error logs via email.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ErrorLogs'' policy is enabled. This policy can contain a comma seperated list e.g. it@company.com, errors@absalomsystems.com',1,1,0,0,1);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 1, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'ErrorTo', Label = 'ErrorTo', [Description] = 'This setting specifies the to email address to use when sending error logs via email.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ErrorLogs'' policy is enabled. This policy can contain a comma seperated list e.g. it@company.com, errors@absalomsystems.com', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 1 WHERE [Key]  = 'ErrorTo';
END

/**************************** ess.Policy - 'ErrorSmtp' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ErrorSmtp')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(1,19,13,19,13,'ErrorSmtp','ErrorSmtp','ErrorSmtp','This setting specifies the smtp server ip / address to be used when sending error logs via email.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ErrorLogs'' policy is enabled.',1,1,0,0,1);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 1, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'ErrorSmtp', Label = 'ErrorSmtp', [Description] = 'This setting specifies the smtp server ip / address to be used when sending error logs via email.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ErrorLogs'' policy is enabled.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 1 WHERE [Key]  = 'ErrorSmtp';
END

/**************************** ess.Policy - 'ErrorPort' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ErrorPort')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(1,18,9,18,9,'ErrorPort','ErrorPort','ErrorPort','This setting specifies the port on the smtp server ip / address to use when sending error logs via email.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ErrorLogs'' policy is enabled.',1,1,0,0,1);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 1, SetupAssemblyID = 18, SetupDataTypeID = 9, AssemblyID = 18, DataTypeID = 9, Name = 'ErrorPort', Label = 'ErrorPort', [Description] = 'This setting specifies the port on the smtp server ip / address to use when sending error logs via email.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ErrorLogs'' policy is enabled.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 1 WHERE [Key]  = 'ErrorPort';
END

/**************************** ess.Policy - 'ErrorUsername' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ErrorUsername')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(1,19,13,19,13,'ErrorUsername','ErrorUsername','ErrorUsername','This setting specifies the username when connecting to the smtp server ip / address to enable sending error logs via email.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ErrorLogs'' policy is enabled.',1,1,0,0,1);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 1, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'ErrorUsername', Label = 'ErrorUsername', [Description] = 'This setting specifies the username when connecting to the smtp server ip / address to enable sending error logs via email.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ErrorLogs'' policy is enabled.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 1 WHERE [Key]  = 'ErrorUsername';
END

/**************************** ess.Policy - 'ErrorPassword' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ErrorPassword')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(1,19,13,19,13,'ErrorPassword','ErrorPassword','ErrorPassword','This setting specifies the password when connecting to the smtp server ip / address to enable sending error logs via email.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ErrorLogs'' policy is enabled.',1,1,0,0,1);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 1, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'ErrorPassword', Label = 'ErrorPassword', [Description] = 'This setting specifies the password when connecting to the smtp server ip / address to enable sending error logs via email.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ErrorLogs'' policy is enabled.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 1 WHERE [Key]  = 'ErrorPassword';
END

/**************************** ess.Policy - 'Dropdown' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Dropdown')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel,[Text]) VALUES(2,19,13,19,13,'Dropdown','Dropdown','Dropdown','This setting determines the format used for display purposes where the access to list employee details should be shown.

		Default:

		''<%Surname%>, <%PreferredName%>'' on new installations.

		Note:

		This policy can contain the following fields (<%CompanyNum%>, <%EmployeeNum%>, <%UserGroup%>, <%Surname%>, <%PreferredName%>, <%FirstName%>, <%DeptName%>, <%CompanyName%>, <%Division%>, <%SubDivision%>, <%SubSubDivision%>).',1,1,0,0,2,'<%EmployeeNum%>, <%Surname%>');
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'Dropdown', Label = 'Dropdown', [Description] = 'This setting determines the format used for display purposes where the access to list employee details should be shown.

		Default:

		''<%Surname%>, <%PreferredName%>'' on new installations.

		Note:

		This policy can contain the following fields (<%CompanyNum%>, <%EmployeeNum%>, <%UserGroup%>, <%Surname%>, <%PreferredName%>, <%FirstName%>, <%DeptName%>, <%CompanyName%>, <%Division%>, <%SubDivision%>, <%SubSubDivision%>).', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 2, [Text] = '<%EmployeeNum%>, <%Surname%>' WHERE [Key]  = 'Dropdown';
END

/**************************** ess.Policy - 'ShowAge' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ShowAge')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,5,3,5,3,'ShowAge','ShowAge','ShowAge','This setting determines if the age is shown next to the persons name that is being managed.

		Default:

		Enabled on new installations.',1,1,0,0,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'ShowAge', Label = 'ShowAge', [Description] = 'This setting determines if the age is shown next to the persons name that is being managed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 2 WHERE [Key]  = 'ShowAge';
END

/**************************** ess.Policy - 'DateFormat' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'DateFormat')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,19,13,19,13,'DateFormat','DateFormat','DateFormat','This setting specifies the date format to be used when displaying date items on grids and date driven controls.

		Default:

		dd/MM/yyyy on new installations.',1,1,0,1,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'DateFormat', Label = 'DateFormat', [Description] = 'This setting specifies the date format to be used when displaying date items on grids and date driven controls.

		Default:

		dd/MM/yyyy on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 2 WHERE [Key]  = 'DateFormat';
END

/**************************** ess.Policy - 'PersonalChange' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'PersonalChange')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,5,3,5,3,'PersonalChange','PersonalChange','PersonalChange','This setting determines if the employee should be able to change any form field visible on the personal module.

		Default:

		Disabled on new installations.',1,1,0,1,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'PersonalChange', Label = 'PersonalChange', [Description] = 'This setting determines if the employee should be able to change any form field visible on the personal module.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 2 WHERE [Key]  = 'PersonalChange';
END

/**************************** ess.Policy - 'PersonalLogChange' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'PersonalLogChange')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,5,3,5,3,'PersonalLogChange','PersonalLogChange','PersonalLogChange','This setting determines if any changes made by the employee to any form field visible on the personal module should be logged in the history log section.

		Default:

		Disabled on new installations.',1,1,0,1,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'PersonalLogChange', Label = 'PersonalLogChange', [Description] = 'This setting determines if any changes made by the employee to any form field visible on the personal module should be logged in the history log section.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 2 WHERE [Key]  = 'PersonalLogChange';
END

/**************************** ess.Policy - 'OrganizationalChange' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'OrganizationalChange')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,5,3,5,3,'OrganizationalChange','OrganizationalChange','OrganizationalChange','This setting determines if the employee should be able to change any form field visible on the organizational module.

		Default:

		Disabled on new installations.',1,1,0,1,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'OrganizationalChange', Label = 'OrganizationalChange', [Description] = 'This setting determines if the employee should be able to change any form field visible on the organizational module.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 2 WHERE [Key]  = 'OrganizationalChange';
END

/**************************** ess.Policy - 'OrganizationalLogChange' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'OrganizationalLogChange')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,5,3,5,3,'OrganizationalLogChange','OrganizationalLogChange','OrganizationalLogChange','This setting determines if any changes made by the employee to any form field visible on the organizational module should be logged in the history log section.

		Default:

		Disabled on new installations.',1,1,0,1,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'OrganizationalLogChange', Label = 'OrganizationalLogChange', [Description] = 'This setting determines if any changes made by the employee to any form field visible on the organizational module should be logged in the history log section.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 2 WHERE [Key]  = 'OrganizationalLogChange';
END

/**************************** ess.Policy - 'Homepage' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Homepage')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,5,3,5,3,'Homepage','Homepage','Homepage','This setting determines if the homepage should be shown the first time an employee logs onto the ESS.

		Default:

		Disabled on new installations.',1,1,0,0,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'Homepage', Label = 'Homepage', [Description] = 'This setting determines if the homepage should be shown the first time an employee logs onto the ESS.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 2 WHERE [Key]  = 'Homepage';
END

/**************************** ess.Policy - 'SMSAppID' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SMSAppID')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,19,13,19,13,'SMSAppID','SMSAppID','SMSAppID','This setting specifies the user account to use when enabling SMS sending through the ESS.

		Default:

		Not configured on new installations.',1,1,0,0,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'SMSAppID', Label = 'SMSAppID', [Description] = 'This setting specifies the user account to use when enabling SMS sending through the ESS.

		Default:

		Not configured on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 2 WHERE [Key]  = 'SMSAppID';
END

/**************************** ess.Policy - 'SMSCode' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SMSCode')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,19,13,19,13,'SMSCode','SMSCode','SMSCode','This setting specifies the account code to use when enabling SMS sending through the ESS.

		Default:

		Not configured on new installations.',1,1,0,0,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'SMSCode', Label = 'SMSCode', [Description] = 'This setting specifies the account code to use when enabling SMS sending through the ESS.

		Default:

		Not configured on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 2 WHERE [Key]  = 'SMSCode';
END

/**************************** ess.Policy - 'SMSCodePwd' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SMSCodePwd')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,19,13,19,13,'SMSCodePwd','SMSCodePwd','SMSCodePwd','This setting specifies the account password to use when enabling SMS sending through the ESS.

		Default:

		Not configured on new installations.',1,1,0,0,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'SMSCodePwd', Label = 'SMSCodePwd', [Description] = 'This setting specifies the account password to use when enabling SMS sending through the ESS.

		Default:

		Not configured on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 2 WHERE [Key]  = 'SMSCodePwd';
END

/**************************** ess.Policy - 'SMSCountry' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SMSCountry')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,18,9,18,9,'SMSCountry','SMSCountry','SMSCountry','This setting specifies the country code to use as a default replacement on cellphone numbers that do not conform to international format.

		Default:

		Not configured on new installations.',1,1,0,0,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 18, SetupDataTypeID = 9, AssemblyID = 18, DataTypeID = 9, Name = 'SMSCountry', Label = 'SMSCountry', [Description] = 'This setting specifies the country code to use as a default replacement on cellphone numbers that do not conform to international format.

		Default:

		Not configured on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 2 WHERE [Key]  = 'SMSCountry';
END

/**************************** ess.Policy - 'SMSURL' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SMSURL')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,19,13,19,13,'SMSURL','SMSURL','SMSURL','This setting specifies the URL to use when you wish the receive SMS delivery status when sending SMS messages through the ESS.

		Default:

		Not configured on new installations.',1,1,0,0,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'SMSURL', Label = 'SMSURL', [Description] = 'This setting specifies the URL to use when you wish the receive SMS delivery status when sending SMS messages through the ESS.

		Default:

		Not configured on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 2 WHERE [Key]  = 'SMSURL';
END

/**************************** ess.Policy - 'Discipline' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Discipline')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(3,5,3,5,3,'Discipline','Discipline','Discipline','This setting specifies if discipline recors should be hidden once there is a end date linked to the record.

		Default:

		Disabled on new installations.',1,1,0,1,3);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 3, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'Discipline', Label = 'Discipline', [Description] = 'This setting specifies if discipline recors should be hidden once there is a end date linked to the record.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 3 WHERE [Key]  = 'Discipline';
END

/**************************** ess.Policy - 'OnOffer' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'OnOffer')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(4,5,3,5,3,'OnOffer','OnOffer','OnOffer','This setting specifies whether training courses should only display those courses that are marked as on offer on grids and related controls.

		Default:

		Disabled on new installations.',1,1,0,0,4);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 4, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'OnOffer', Label = 'OnOffer', [Description] = 'This setting specifies whether training courses should only display those courses that are marked as on offer on grids and related controls.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 4 WHERE [Key]  = 'OnOffer';
END

/**************************** ess.Policy - 'DisplayNames' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'DisplayNames')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(5,5,3,5,3,'DisplayNames','DisplayNames','DisplayNames','This setting specifies whether performance items in the tasks module should hide the names for the current and previous locations.

		Default:

		Disabled on new installations.',1,1,0,1,5);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 5, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'DisplayNames', Label = 'DisplayNames', [Description] = 'This setting specifies whether performance items in the tasks module should hide the names for the current and previous locations.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 5 WHERE [Key]  = 'DisplayNames';
END

/**************************** ess.Policy - 'ShowScore' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ShowScore')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(5,5,3,5,3,'ShowScore','ShowScore','ShowScore','This setting specifies whether the score should be shown at the bottom of each evaluation form being completed.

		Default:

		Disabled on new installations.

		Note:

		Scores will be calculated at runtime as the evaluation is completed.',1,1,0,1,5);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 5, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'ShowScore', Label = 'ShowScore', [Description] = 'This setting specifies whether the score should be shown at the bottom of each evaluation form being completed.

		Default:

		Disabled on new installations.

		Note:

		Scores will be calculated at runtime as the evaluation is completed.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 5 WHERE [Key]  = 'ShowScore';
END

/**************************** ess.Policy - 'AutoCalcWeight' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'AutoCalcWeight')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(5,5,3,5,3,'AutoCalcWeight','AutoCalcWeight','AutoCalcWeight','This setting specifies whether weights are automatically calculated for KPA and CSE items (sets the weight for each item to the 100 devide by the number of items).

		Default:

		Disabled on new installations.',1,1,0,1,5);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 5, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'AutoCalcWeight', Label = 'AutoCalcWeight', [Description] = 'This setting specifies whether weights are automatically calculated for KPA and CSE items (sets the weight for each item to the 100 devide by the number of items).

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 5 WHERE [Key]  = 'AutoCalcWeight';
END

/**************************** ess.Policy - 'SchemeCode' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SchemeCode')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(5,5,3,5,3,'SchemeCode','SchemeCode','SchemeCode','This setting specifies whether to only load schemes where the scheme code is in the users access to list.

		Default:

		Disabled on new installations.',1,1,0,1,5);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 5, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'SchemeCode', Label = 'SchemeCode', [Description] = 'This setting specifies whether to only load schemes where the scheme code is in the users access to list.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 5 WHERE [Key]  = 'SchemeCode';
END

/**************************** ess.Policy - 'OtherLanguage' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'OtherLanguage')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,24,18,'OtherLanguage','dgView_001','Other languages','This setting specifies whether the other languages grid in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 24, DataTypeID = 18, Name = 'dgView_001', Label = 'Other languages', [Description] = 'This setting specifies whether the other languages grid in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'OtherLanguage';
END

/**************************** ess.Policy - 'Dependents' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Dependents')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,24,18,'Dependents','dgView_003','Dependents','This setting specifies whether the dependants grid in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 24, DataTypeID = 18, Name = 'dgView_003', Label = 'Dependents', [Description] = 'This setting specifies whether the dependants grid in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Dependents';
END

/**************************** ess.Policy - 'EmployeeNum' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'EmployeeNum')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'EmployeeNum','txtEmployeeNum','Employee number','This setting specifies whether the employee number field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtEmployeeNum', Label = 'Employee number', [Description] = 'This setting specifies whether the employee number field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'EmployeeNum';
END

/**************************** ess.Policy - 'PreferredName' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'PreferredName')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'PreferredName','txtPreferredName','Preferred name','This setting specifies whether the preferred name field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtPreferredName', Label = 'Preferred name', [Description] = 'This setting specifies whether the preferred name field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'PreferredName';
END

/**************************** ess.Policy - 'Title' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Title')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,6,13,'Title','cmbTitle','Title','This setting specifies whether the title field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbTitle', Label = 'Title', [Description] = 'This setting specifies whether the title field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Title';
END

/**************************** ess.Policy - 'FirstName' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'FirstName')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'FirstName','txtFirstName','First name','This setting specifies whether the first name field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,1,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtFirstName', Label = 'First name', [Description] = 'This setting specifies whether the first name field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 1, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'FirstName';
END

/**************************** ess.Policy - 'Surname' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Surname')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'Surname','txtSurname','Surname','This setting specifies whether the surname field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSurname', Label = 'Surname', [Description] = 'This setting specifies whether the surname field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Surname';
END

/**************************** ess.Policy - 'IDNum' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'IDNum')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'IDNum','txtIDNum','ID / Passport number','This setting specifies whether the id / passport number field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtIDNum', Label = 'ID / Passport number', [Description] = 'This setting specifies whether the id / passport number field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'IDNum';
END

/**************************** ess.Policy - 'Sex' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Sex')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,6,13,'Sex','cmbSex','Gender','This setting specifies whether the gender field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbSex', Label = 'Gender', [Description] = 'This setting specifies whether the gender field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Sex';
END

/**************************** ess.Policy - 'Nationality' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Nationality')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,6,13,'Nationality','cmbNationality','Nationality','This setting specifies whether the nationality field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbNationality', Label = 'Nationality', [Description] = 'This setting specifies whether the nationality field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Nationality';
END

/**************************** ess.Policy - 'BirthDate' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'BirthDate')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,7,15,'BirthDate','dteBirthDate','Birth date','This setting specifies whether the birth date field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 7, DataTypeID = 15, Name = 'dteBirthDate', Label = 'Birth date', [Description] = 'This setting specifies whether the birth date field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'BirthDate';
END

/**************************** ess.Policy - 'Language' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Language')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,6,13,'Language','cmbLanguage','Language','This setting specifies whether the language field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbLanguage', Label = 'Language', [Description] = 'This setting specifies whether the language field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Language';
END

/**************************** ess.Policy - 'Religion' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Religion')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,6,13,'Religion','cmbReligion','Religion','This setting specifies whether the religion field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbReligion', Label = 'Religion', [Description] = 'This setting specifies whether the religion field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Religion';
END

/**************************** ess.Policy - 'EthnicGroup' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'EthnicGroup')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,6,13,'EthnicGroup','cmbEthnicGroup','Ethnic group','This setting specifies whether the ethnic group field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbEthnicGroup', Label = 'Ethnic group', [Description] = 'This setting specifies whether the ethnic group field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'EthnicGroup';
END

/**************************** ess.Policy - 'MaritalStatus' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'MaritalStatus')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,6,13,'MaritalStatus','cmbMaritalStatus','Marital status','This setting specifies whether the marital status field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbMaritalStatus', Label = 'Marital status', [Description] = 'This setting specifies whether the marital status field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'MaritalStatus';
END

/**************************** ess.Policy - 'Disability' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Disability')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,6,13,'Disability','cmbDisability','Disability','This setting specifies whether the disability field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,1,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbDisability', Label = 'Disability', [Description] = 'This setting specifies whether the disability field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 1, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Disability';
END

/**************************** ess.Policy - 'DisabilityNotes' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'DisabilityNotes')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'DisabilityNotes','txtDisabilityNotes','Disability notes','This setting specifies whether the disability notes field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtDisabilityNotes', Label = 'Disability notes', [Description] = 'This setting specifies whether the disability notes field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'DisabilityNotes';
END

/**************************** ess.Policy - 'Address1' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Address1')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'Address1','txtAddress1','Street','This setting specifies whether the address line 1 field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtAddress1', Label = 'Street', [Description] = 'This setting specifies whether the address line 1 field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Address1';
END

/**************************** ess.Policy - 'Address2' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Address2')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'Address2','txtAddress2','Suburb','This setting specifies whether the address line 2 field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtAddress2', Label = 'Suburb', [Description] = 'This setting specifies whether the address line 2 field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Address2';
END

/**************************** ess.Policy - 'Address3' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Address3')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'Address3','txtAddress3','Address line 3','This setting specifies whether the address line 3 field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtAddress3', Label = 'Address line 3', [Description] = 'This setting specifies whether the address line 3 field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Address3';
END

/**************************** ess.Policy - 'Address4' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Address4')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'Address4','txtAddress4','Address line 4','This setting specifies whether the address line 4 field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtAddress4', Label = 'Address line 4', [Description] = 'This setting specifies whether the address line 4 field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Address4';
END

/**************************** ess.Policy - 'POBox' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'POBox')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'POBox','txtPOBox','P.O. Box','This setting specifies whether the po box field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtPOBox', Label = 'P.O. Box', [Description] = 'This setting specifies whether the po box field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'POBox';
END

/**************************** ess.Policy - 'POArea' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'POArea')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'POArea','txtPOArea','Postal area','This setting specifies whether the postal area field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtPOArea', Label = 'Postal area', [Description] = 'This setting specifies whether the postal area field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'POArea';
END

/**************************** ess.Policy - 'POCode' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'POCode')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'POCode','txtPOCode','Postal code','This setting specifies whether the postal code field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtPOCode', Label = 'Postal code', [Description] = 'This setting specifies whether the postal code field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'POCode';
END

/**************************** ess.Policy - 'OfficeNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'OfficeNo')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'OfficeNo','txtOfficeNo','Work number','This setting specifies whether the work number field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtOfficeNo', Label = 'Work number', [Description] = 'This setting specifies whether the work number field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'OfficeNo';
END

/**************************** ess.Policy - 'ExtensionNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ExtensionNo')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'ExtensionNo','txtExtensionNo','Local No.','This setting specifies whether the phone extension field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtExtensionNo', Label = 'Local No.', [Description] = 'This setting specifies whether the phone extension field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'ExtensionNo';
END

/**************************** ess.Policy - 'CellTel' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'CellTel')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'CellTel','txtCellTel','Mobile number','This setting specifies whether the mobile number field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtCellTel', Label = 'Mobile number', [Description] = 'This setting specifies whether the mobile number field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'CellTel';
END

/**************************** ess.Policy - 'HomeTel' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'HomeTel')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'HomeTel','txtHomeTel','Home Tel. No.','This setting specifies whether the home number field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtHomeTel', Label = 'Home Tel. No.', [Description] = 'This setting specifies whether the home number field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'HomeTel';
END

/**************************** ess.Policy - 'EmailAddress' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'EmailAddress')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel,[Validation]) VALUES(6,5,3,19,13,'EmailAddress','txtEmailAddress','Company Email Address','This setting specifies whether the email address field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6, '');
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtEmailAddress', Label = 'Company Email Address', [Description] = 'This setting specifies whether the email address field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6, [Validation] = '' WHERE [Key]  = 'EmailAddress';
END

/**************************** ess.Policy - 'SpouseName' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SpouseName')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'SpouseName','txtSpouseName','Spouse name','This setting specifies whether the spouse name field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSpouseName', Label = 'Spouse name', [Description] = 'This setting specifies whether the spouse name field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'SpouseName';
END

/**************************** ess.Policy - 'SpouseTel' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SpouseTel')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'SpouseTel','txtSpouseTel','Spouse number','This setting specifies whether the spouse number field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSpouseTel', Label = 'Spouse number', [Description] = 'This setting specifies whether the spouse number field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'SpouseTel';
END

/**************************** ess.Policy - 'JobTitle' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'JobTitle')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,6,13,'JobTitle','cmbJobTitle','Job title','This setting specifies whether the job title field in the organizational module should be displayed.

		Default:

		Enabled on new installations.',1,1,1,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbJobTitle', Label = 'Job title', [Description] = 'This setting specifies whether the job title field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 1, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'JobTitle';
END

/**************************** ess.Policy - 'JobGrade' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'JobGrade')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,6,13,'JobGrade','cmbJobGrade','Job grade','This setting specifies whether the job grade field in the organizational module should be displayed.

		Default:

		Enabled on new installations.',1,1,1,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbJobGrade', Label = 'Job grade', [Description] = 'This setting specifies whether the job grade field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 1, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'JobGrade';
END

/**************************** ess.Policy - 'CostCentre' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'CostCentre')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,6,13,'CostCentre','cmbCostCentre','Cost centre','This setting specifies whether the cost centre field in the organizational module should be displayed.

		Default:

		Enabled on new installations.',1,1,1,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbCostCentre', Label = 'Cost centre', [Description] = 'This setting specifies whether the cost centre field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 1, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'CostCentre';
END

/**************************** ess.Policy - 'CostCentreAlloc' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'CostCentreAlloc')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,2,13,'CostCentreAlloc','cmdCostCentre','Cost Centre Allocation','This setting specifies whether the cost centre allocation field in the organizational module should be displayed.

		Default:

		Enabled on new installations.',1,1,1,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 2, DataTypeID = 13, Name = 'cmdCostCentre', Label = 'Cost Centre Allocation', [Description] = 'This setting specifies whether the cost centre allocation field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 1, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'CostCentreAlloc';
END

/**************************** ess.Policy - 'Skill_Level' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Skill_Level')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,6,13,'Skill_Level','cmbSkill_Level','Occupational category','This setting specifies whether the occupational category field in the organizational module should be displayed.

		Default:

		Enabled on new installations.',1,1,1,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbSkill_Level', Label = 'Occupational category', [Description] = 'This setting specifies whether the occupational category field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 1, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'Skill_Level';
END

/**************************** ess.Policy - 'Appointype' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Appointype')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,6,13,'Appointype','cmbAppointype','Appointment type','This setting specifies whether the appointment type field in the organizational module should be displayed.

		Default:

		Enabled on new installations.',1,1,1,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbAppointype', Label = 'Appointment type', [Description] = 'This setting specifies whether the appointment type field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 1, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'Appointype';
END

/**************************** ess.Policy - 'DateJoinedGroup' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'DateJoinedGroup')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,7,15,'DateJoinedGroup','dteDateJoinedGroup','Date joined group','This setting specifies whether the date joined group field in the organizational module should be displayed.

		Default:

		Enabled on new installations.',1,1,1,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 7, DataTypeID = 15, Name = 'dteDateJoinedGroup', Label = 'Date joined group', [Description] = 'This setting specifies whether the date joined group field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 1, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'DateJoinedGroup';
END

/**************************** ess.Policy - 'Appointdate' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Appointdate')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,7,15,'Appointdate','dteAppointdate','Appointment date','This setting specifies whether the appointment date field in the organizational module should be displayed.

		Default:

		Enabled on new installations.',1,1,1,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 7, DataTypeID = 15, Name = 'dteAppointdate', Label = 'Appointment date', [Description] = 'This setting specifies whether the appointment date field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 1, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'Appointdate';
END

/**************************** ess.Policy - 'YearsServiceG' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'YearsServiceG')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,19,13,'YearsServiceG','txtYearsServiceG','Years of service (group)','This setting specifies whether the years of service (group) field in the organizational module should be displayed.

		Default:

		Enabled on new installations.',1,1,1,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtYearsServiceG', Label = 'Years of service (group)', [Description] = 'This setting specifies whether the years of service (group) field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 1, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'YearsServiceG';
END

/**************************** ess.Policy - 'YearsServiceA' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'YearsServiceA')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,19,13,'YearsServiceA','txtYearsServiceA','Years of service (appointment)','This setting specifies whether the years of service (appointment) field in the organizational module should be displayed.

		Default:

		Enabled on new installations.',1,1,1,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtYearsServiceA', Label = 'Years of service (appointment)', [Description] = 'This setting specifies whether the years of service (appointment) field in the organizational module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 1, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'YearsServiceA';
END

/**************************** ess.Policy - 'ReportsTo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ReportsTo')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,24,18,'ReportsTo','dgView','Reports to','This setting specifies whether the reports to grid in the organizational module should be displayed.

		Default:

		Enabled on new installations.',1,0,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 24, DataTypeID = 18, Name = 'dgView', Label = 'Reports to', [Description] = 'This setting specifies whether the reports to grid in the organizational module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 0, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'ReportsTo';
END

/**************************** ess.Policy - 'BalanceGrid' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'BalanceGrid')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'BalanceGrid','BalanceGrid','BalanceGrid','This setting allows you to exclude specific leave types from the leave balances grid.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to hide a specific leave type, even if the employee may have access to that particular leave type. This policy can contain a comma seperated list e.g. Sick, Study',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'BalanceGrid', Label = 'BalanceGrid', [Description] = 'This setting allows you to exclude specific leave types from the leave balances grid.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to hide a specific leave type, even if the employee may have access to that particular leave type. This policy can contain a comma seperated list e.g. Sick, Study', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'BalanceGrid';
END

/**************************** ess.Policy - 'BalanceGridColumns' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'BalanceGridColumns')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'BalanceGridColumns','BalanceGridColumns','BalanceGridColumns','This setting allows you to exclude specific columns from the leave balances grid.

		Default:

		Unit Type, Accum Balance, Total Accrual, Future Taken

		Note:

		When using this policy you can configure to hide a specific column in the leave balances grid, even if the employee may have access to that particular column (the items specified should match the names of the column headers). This policy can contain a comma seperated list e.g. Type, Unit Type, As At',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'BalanceGridColumns', Label = 'BalanceGridColumns', [Description] = 'This setting allows you to exclude specific columns from the leave balances grid.

		Default:

		Unit Type, Accum Balance, Total Accrual, Future Taken

		Note:

		When using this policy you can configure to hide a specific column in the leave balances grid, even if the employee may have access to that particular column (the items specified should match the names of the column headers). This policy can contain a comma seperated list e.g. Type, Unit Type, As At', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'BalanceGridColumns';
END

/**************************** ess.Policy - 'Default' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Default')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,6,13,6,13,'Default','Default','Default','This setting allows you to set a specific leave type to be selected on the application dropdown list the first time the employee opens the leave screen.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to automatically select the leave type the first time the employee opens the leave application screen. This policy can only contain one leave type',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 6, SetupDataTypeID = 13, AssemblyID = 6, DataTypeID = 13, Name = 'Default', Label = 'Default', [Description] = 'This setting allows you to set a specific leave type to be selected on the application dropdown list the first time the employee opens the leave screen.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to automatically select the leave type the first time the employee opens the leave application screen. This policy can only contain one leave type', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'Default';
END

/**************************** ess.Policy - 'Negative' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Negative')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'Negative','Negative','Negative','This setting allows you to specify which leave types are allowed to go into a negative balance when the employee applies for leave.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to allow a specific leave type to go into a negative balance. This policy can contain a comma seperated list e.g. Sick, Study',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'Negative', Label = 'Negative', [Description] = 'This setting allows you to specify which leave types are allowed to go into a negative balance when the employee applies for leave.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to allow a specific leave type to go into a negative balance. This policy can contain a comma seperated list e.g. Sick, Study', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'Negative';
END

/**************************** ess.Policy - 'ShiftTypes' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ShiftTypes')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'ShiftTypes','ShiftTypes','ShiftTypes','This setting allows you to specify which shift types adds +0.5 to the leave duration for each leave day applied for by the employee.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to add +0.5 days for each leave day for a specific shift type. This policy can contain a comma seperated list e.g. 10 - Hour Shift, 12 - Hour Shift',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'ShiftTypes', Label = 'ShiftTypes', [Description] = 'This setting allows you to specify which shift types adds +0.5 to the leave duration for each leave day applied for by the employee.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to add +0.5 days for each leave day for a specific shift type. This policy can contain a comma seperated list e.g. 10 - Hour Shift, 12 - Hour Shift', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'ShiftTypes';
END

/**************************** ess.Policy - 'ShiftLeaveTypes' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ShiftLeaveTypes')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'ShiftLeaveTypes','ShiftLeaveTypes','ShiftLeaveTypes','This setting allows you to specify which leave types adds +0.5 to the leave duration for each leave day applied for by the employee.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to add +0.5 days for each leave day for a leave type. This policy depends on the values as setup in the ''ShiftTypes'' policy. This policy can contain a comma seperated list e.g. Sick, Study',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'ShiftLeaveTypes', Label = 'ShiftLeaveTypes', [Description] = 'This setting allows you to specify which leave types adds +0.5 to the leave duration for each leave day applied for by the employee.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to add +0.5 days for each leave day for a leave type. This policy depends on the values as setup in the ''ShiftTypes'' policy. This policy can contain a comma seperated list e.g. Sick, Study', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'ShiftLeaveTypes';
END

/**************************** ess.Policy - 'FridayRule' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'FridayRule')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'FridayRule','FridayRule','FridayRule','This setting allows you to specify which leave types adds +1 to the leave duration for each leave day applied for by the employee that falls on a friday.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to add +1 day for each leave day for a leave type that falls on a friday. This policy can contain a comma seperated list e.g. Sick, Study',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'FridayRule', Label = 'FridayRule', [Description] = 'This setting allows you to specify which leave types adds +1 to the leave duration for each leave day applied for by the employee that falls on a friday.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to add +1 day for each leave day for a leave type that falls on a friday. This policy can contain a comma seperated list e.g. Sick, Study', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'FridayRule';
END

/**************************** ess.Policy - 'SaturdayRule' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SaturdayRule')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,5,3,5,3,'SaturdayRule','SaturdayRule','SaturdayRule','This setting specifies whether a saterday should be calculated as 0.5 days duration on any leave type if the application falls on a saturday.

		Default:

		Disabled on new installations.',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'SaturdayRule', Label = 'SaturdayRule', [Description] = 'This setting specifies whether a saterday should be calculated as 0.5 days duration on any leave type if the application falls on a saturday.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'SaturdayRule';
END

/**************************** ess.Policy - 'LeaveBlock' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'LeaveBlock')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,5,3,5,3,'LeaveBlock','LeaveBlock','LeaveBlock','This setting specifies whether the leave blocking section in the leave module should be enabled.

		Default:

		Disabled on new installations.',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'LeaveBlock', Label = 'LeaveBlock', [Description] = 'This setting specifies whether the leave blocking section in the leave module should be enabled.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'LeaveBlock';
END

/**************************** ess.Policy - 'DeleteCancel' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'DeleteCancel')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,5,3,5,3,'DeleteCancel','DeleteCancel','DeleteCancel','This setting specifies whether the leave application should be deleted once the cancellation has been approved.

		Default:

		Disabled on new installations.',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'DeleteCancel', Label = 'DeleteCancel', [Description] = 'This setting specifies whether the leave application should be deleted once the cancellation has been approved.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'DeleteCancel';
END

/**************************** ess.Policy - 'ForceComments' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ForceComments')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,5,3,5,3,'ForceComments','ForceComments','ForceComments','This setting specifies whether the remarks box should be completed before the leave application will be allowed to be submitted for approval.

		Default:

		Disabled on new installations.',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'ForceComments', Label = 'ForceComments', [Description] = 'This setting specifies whether the remarks box should be completed before the leave application will be allowed to be submitted for approval.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'ForceComments';
END

/**************************** ess.Policy - 'StaffOnLeave' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'StaffOnLeave')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,5,3,5,3,'StaffOnLeave','StaffOnLeave','StaffOnLeave','This setting specifies whether the staff on leave page is generated using the reports to structure or the security and rights assigned to the particular employee.

		Default:

		The Reports to structure will be used when generating the staff on leave page.

		Note:

		When this policy is enabled the security and rights is used, when this policy is disabled then the reports to structure is used.',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'StaffOnLeave', Label = 'StaffOnLeave', [Description] = 'This setting specifies whether the staff on leave page is generated using the reports to structure or the security and rights assigned to the particular employee.

		Default:

		The Reports to structure will be used when generating the staff on leave page.

		Note:

		When this policy is enabled the security and rights is used, when this policy is disabled then the reports to structure is used.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'StaffOnLeave';
END

/**************************** ess.Policy - 'IgnoreBalance' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'IgnoreBalance')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,5,3,5,3,'IgnoreBalance','IgnoreBalance','IgnoreBalance','This setting specifies whether the leave balances on the balances grid should not be calculate at runtime, but rather be read from the existing balances table.

		Default:

		Disabled on new installations.

		Note:

		Enabling this policy will bypass all leave calculations.',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'IgnoreBalance', Label = 'IgnoreBalance', [Description] = 'This setting specifies whether the leave balances on the balances grid should not be calculate at runtime, but rather be read from the existing balances table.

		Default:

		Disabled on new installations.

		Note:

		Enabling this policy will bypass all leave calculations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'IgnoreBalance';
END

/**************************** ess.Policy - 'FinancialYear' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'FinancialYear')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,7,15,7,15,'FinancialYear','FinancialYear','FinancialYear','This setting allows you to specify the month and day of the business financial year end.

		Default:

		Not configured on new installations.

		Note:

		When using this policy any leave application that will span across the month and day for each year will automatically be split into two leave applications.',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 7, SetupDataTypeID = 15, AssemblyID = 7, DataTypeID = 15, Name = 'FinancialYear', Label = 'FinancialYear', [Description] = 'This setting allows you to specify the month and day of the business financial year end.

		Default:

		Not configured on new installations.

		Note:

		When using this policy any leave application that will span across the month and day for each year will automatically be split into two leave applications.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'FinancialYear';
END

/**************************** ess.Policy - 'FinancialTotal' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'FinancialTotal')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,5,3,5,3,'FinancialTotal','FinancialTotal','FinancialTotal','This setting specifies whether the date as configured in the ''FinancialYear'' policy is to be used to calculate total and future taken leave.

		Default:

		Disabled on new installations.

		Note:

		This policy depends on if the ''FinancialYear'' is enabled. If this policy is disabled then the total and future taken leave will be displayed as per the leave scheme setup for the particular employee. If this policy is enabled it will use the ''FinancialYear'' policy''s date to determine the total and future taken leave.',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'FinancialTotal', Label = 'FinancialTotal', [Description] = 'This setting specifies whether the date as configured in the ''FinancialYear'' policy is to be used to calculate total and future taken leave.

		Default:

		Disabled on new installations.

		Note:

		This policy depends on if the ''FinancialYear'' is enabled. If this policy is disabled then the total and future taken leave will be displayed as per the leave scheme setup for the particular employee. If this policy is enabled it will use the ''FinancialYear'' policy''s date to determine the total and future taken leave.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'FinancialTotal';
END

/**************************** ess.Policy - 'Consecutive' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Consecutive')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'Consecutive','Consecutive','Consecutive','This setting allows you to specify which leave types may not be taken in excess of x amount of duration per application (as configured through the ConsecutiveMax policy).

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to disallow a leave application for a specific leave type exceeding x amount of duration as per the ConsecutiveMax policy. This policy can contain a comma seperated list e.g. Sick, Study',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'Consecutive', Label = 'Consecutive', [Description] = 'This setting allows you to specify which leave types may not be taken in excess of x amount of duration per application (as configured through the ConsecutiveMax policy).

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to disallow a leave application for a specific leave type exceeding x amount of duration as per the ConsecutiveMax policy. This policy can contain a comma seperated list e.g. Sick, Study', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'Consecutive';
END

/**************************** ess.Policy - 'ConsecutiveMax' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ConsecutiveMax')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'ConsecutiveMax','ConsecutiveMax','ConsecutiveMax','This setting allows you to specify the maximum duration per leave type allowed for each application (as configured through the consecutive policy).

		Default:

		Not configured on new installations.

		Note:

		When configuring this policy ensure that you enter the number of days as this policy will only work on leave types that are linked to the duration type of days. This policy can contain a comma seperated list e.g. 2, 5 (and should be configured for each type as configured in the ''Consecutive'' policy)',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'ConsecutiveMax', Label = 'ConsecutiveMax', [Description] = 'This setting allows you to specify the maximum duration per leave type allowed for each application (as configured through the consecutive policy).

		Default:

		Not configured on new installations.

		Note:

		When configuring this policy ensure that you enter the number of days as this policy will only work on leave types that are linked to the duration type of days. This policy can contain a comma seperated list e.g. 2, 5 (and should be configured for each type as configured in the ''Consecutive'' policy)', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'ConsecutiveMax';
END

/**************************** ess.Policy - 'ForceDocument' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ForceDocument')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'ForceDocument','ForceDocument','ForceDocument','This setting allows you to specify which leave types should force a person to upload a file before application.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to force a document to be attached for a specific leave type when the person is applying for leave. This policy can contain a comma seperated list e.g. Sick, Study',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'ForceDocument', Label = 'ForceDocument', [Description] = 'This setting allows you to specify which leave types should force a person to upload a file before application.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to force a document to be attached for a specific leave type when the person is applying for leave. This policy can contain a comma seperated list e.g. Sick, Study', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'ForceDocument';
END

/**************************** ess.Policy - 'ForceDocumentMax' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ForceDocumentMax')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'ForceDocumentMax','ForceDocumentMax','ForceDocumentMax','This setting allows you to specify which leave types should force a person to upload a file before application (if the duration will exceed the configured maximum allowed).

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to force a document to be attached for a specific leave type when the person is applying for leave (if the duration will exceed the configured maximum allowed). This policy can contain a comma seperated list e.g. Sick, Study',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'ForceDocumentMax', Label = 'ForceDocumentMax', [Description] = 'This setting allows you to specify which leave types should force a person to upload a file before application (if the duration will exceed the configured maximum allowed).

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to force a document to be attached for a specific leave type when the person is applying for leave (if the duration will exceed the configured maximum allowed). This policy can contain a comma seperated list e.g. Sick, Study', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'ForceDocumentMax';
END

/**************************** ess.Policy - 'ForceDocumentMaxValue' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ForceDocumentMaxValue')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'ForceDocumentMaxValue','ForceDocumentMaxValue','ForceDocumentMaxValue','This setting allows you to specify the maximum duration allowed, before forcing a required attached document.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ForceDocumentMax'' is configured. This policy can contain a comma seperated list e.g. 2, 5 (and should be configured for each type as configured in the ''ForceDocumentMax'' policy)',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'ForceDocumentMaxValue', Label = 'ForceDocumentMaxValue', [Description] = 'This setting allows you to specify the maximum duration allowed, before forcing a required attached document.

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ForceDocumentMax'' is configured. This policy can contain a comma seperated list e.g. 2, 5 (and should be configured for each type as configured in the ''ForceDocumentMax'' policy)', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'ForceDocumentMaxValue';
END

/**************************** ess.Policy - 'ForceDocumentDuration' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ForceDocumentDuration')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'ForceDocumentDuration','ForceDocumentDuration','ForceDocumentDuration','This setting allows you to specify which leave types should force a person to upload a file before application (if there is another application within the configured duration - weeks).

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to force a document to be attached for a specific leave type when the person is applying for leave (if there is another application within the configured duration - weeks). This policy can contain a comma seperated list e.g. Sick, Study',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'ForceDocumentDuration', Label = 'ForceDocumentDuration', [Description] = 'This setting allows you to specify which leave types should force a person to upload a file before application (if there is another application within the configured duration - weeks).

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to force a document to be attached for a specific leave type when the person is applying for leave (if there is another application within the configured duration - weeks). This policy can contain a comma seperated list e.g. Sick, Study', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'ForceDocumentDuration';
END

/**************************** ess.Policy - 'ForceDocumentDurationValue' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ForceDocumentDurationValue')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'ForceDocumentDurationValue','ForceDocumentDurationValu','ForceDocumentDurationValu','This setting allows you to specify the duration allowed, before forcing a required attached document (if another application is made within this amount of time - weeks).

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ForceDocumentDuration'' is configured. This policy can contain a comma seperated list e.g. 2, 5 (and should be configured for each type as configured in the ''ForceDocumentDuration'' policy)',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'ForceDocumentDurationValu', Label = 'ForceDocumentDurationValu', [Description] = 'This setting allows you to specify the duration allowed, before forcing a required attached document (if another application is made within this amount of time - weeks).

		Default:

		Not configured on new installations.

		Note:

		This policy depends on if the ''ForceDocumentDuration'' is configured. This policy can contain a comma seperated list e.g. 2, 5 (and should be configured for each type as configured in the ''ForceDocumentDuration'' policy)', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'ForceDocumentDurationValue';
END

/**************************** ess.Policy - 'ForceDocumentWeekend' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ForceDocumentWeekend')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'ForceDocumentWeekend','ForceDocumentWeekend','ForceDocumentWeekend','This setting allows you to specify which leave types should force a person to upload a file before application (if the leave application starts / ends on a weekend (Friday, Saturday, Sunday or Monday)).

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to force a document to be attached for a specific leave type when the person is applying for leave (if the leave application starts / ends on a weekend (Friday, Saturday, Sunday or Monday)). This policy can contain a comma seperated list e.g. Sick, Study',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'ForceDocumentWeekend', Label = 'ForceDocumentWeekend', [Description] = 'This setting allows you to specify which leave types should force a person to upload a file before application (if the leave application starts / ends on a weekend (Friday, Saturday, Sunday or Monday)).

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to force a document to be attached for a specific leave type when the person is applying for leave (if the leave application starts / ends on a weekend (Friday, Saturday, Sunday or Monday)). This policy can contain a comma seperated list e.g. Sick, Study', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'ForceDocumentWeekend';
END

/**************************** ess.Policy - 'DisallowWeekend' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'DisallowWeekend')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'DisallowWeekend','DisallowWeekend','DisallowWeekend','This setting allows you to specify which leave types may not be starting / ending either side or over a weekend (Friday, Saturday, Sunday or Monday).

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to disallow a leave application starting / ending either side or over a weekend (Friday, Saturday, Sunday or Monday). This policy can contain a comma seperated list e.g. Sick, Study',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'DisallowWeekend', Label = 'DisallowWeekend', [Description] = 'This setting allows you to specify which leave types may not be starting / ending either side or over a weekend (Friday, Saturday, Sunday or Monday).

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to disallow a leave application starting / ending either side or over a weekend (Friday, Saturday, Sunday or Monday). This policy can contain a comma seperated list e.g. Sick, Study', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'DisallowWeekend';
END

/**************************** ess.Policy - 'ShowSearch' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ShowSearch')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,5,3,5,3,'ShowSearch','ShowSearch','ShowSearch','This setting determines if the search button on the toolbar should be shown.

		Default:

		Enabled on new installations.',1,1,0,1,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'ShowSearch', Label = 'ShowSearch', [Description] = 'This setting determines if the search button on the toolbar should be shown.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 2 WHERE [Key]  = 'ShowSearch';
END

/**************************** ess.Policy - 'ShowEmail' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ShowEmail')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,5,3,5,3,'ShowEmail','ShowEmail','ShowEmail','This setting determines if the email button on the toolbar should be shown.

		Default:

		Enabled on new installations.',1,1,0,1,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'ShowEmail', Label = 'ShowEmail', [Description] = 'This setting determines if the email button on the toolbar should be shown.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 2 WHERE [Key]  = 'ShowEmail';
END

/**************************** ess.Policy - 'ShowSMS' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ShowSMS')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,5,3,5,3,'ShowSMS','ShowSMS','ShowSMS','This setting determines if the sms button on the toolbar should be shown.

		Default:

		Enabled on new installations.',1,1,0,1,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'ShowSMS', Label = 'ShowSMS', [Description] = 'This setting determines if the sms button on the toolbar should be shown.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 2 WHERE [Key]  = 'ShowSMS';
END

/**************************** ess.Policy - 'LeaveHistory' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'LeaveHistory')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'LeaveHistory','LeaveHistory','LeaveHistory','This setting allows you to specify which leave types may not be applied for in the past.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to disallow specific leave type applications if they are in the past. This policy can contain a comma seperated list e.g. Annual, Study',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'LeaveHistory', Label = 'LeaveHistory', [Description] = 'This setting allows you to specify which leave types may not be applied for in the past.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to disallow specific leave type applications if they are in the past. This policy can contain a comma seperated list e.g. Annual, Study', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'LeaveHistory';
END

/**************************** ess.Policy - 'QuarterDay' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'QuarterDay')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,5,3,5,3,'QuarterDay','QuarterDay','QuarterDay','This setting determines if the leave duration can be manually overwritten with 1/4 of a day.

		Default:

		Disabled on new installations.',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'QuarterDay', Label = 'QuarterDay', [Description] = 'This setting determines if the leave duration can be manually overwritten with 1/4 of a day.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'QuarterDay';
END

/**************************** ess.Policy - 'StaffOnTraining' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'StaffOnTraining')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(4,5,3,5,3,'StaffOnTraining','StaffOnTraining','StaffOnTraining','This setting specifies whether the staff on training page is generated using the reports to structure or the security and rights assigned to the particular employee.

		Default:

		The Reports to structure will be used when generating the staff on training page.

		Note:

		When this policy is enabled the security and rights is used, when this policy is disabled then the reports to structure is used.',1,1,0,1,4);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 4, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'StaffOnTraining', Label = 'StaffOnTraining', [Description] = 'This setting specifies whether the staff on training page is generated using the reports to structure or the security and rights assigned to the particular employee.

		Default:

		The Reports to structure will be used when generating the staff on training page.

		Note:

		When this policy is enabled the security and rights is used, when this policy is disabled then the reports to structure is used.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 4 WHERE [Key]  = 'StaffOnTraining';
END

/**************************** ess.Policy - 'AddrUnit' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'AddrUnit')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'AddrUnit','txtSARSAddress1','Complex Unit No.','This setting specifies whether the address line 1 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSARSAddress1', Label = 'Complex Unit No.', [Description] = 'This setting specifies whether the address line 1 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'AddrUnit';
END

/**************************** ess.Policy - 'AddrComplex' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'AddrComplex')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'AddrComplex','txtSARSAddress2','Address line 2 (long)','This setting specifies whether the address line 2 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSARSAddress2', Label = 'Address line 2 (long)', [Description] = 'This setting specifies whether the address line 2 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'AddrComplex';
END

/**************************** ess.Policy - 'AddrStreetNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'AddrStreetNo')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'AddrStreetNo','txtSARSAddress3','Address line 3 (long)','This setting specifies whether the address line 3 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSARSAddress3', Label = 'Address line 3 (long)', [Description] = 'This setting specifies whether the address line 3 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'AddrStreetNo';
END

/**************************** ess.Policy - 'AddrStreetName' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'AddrStreetName')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'AddrStreetName','txtSARSAddress4','Address line 4 (long)','This setting specifies whether the address line 4 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSARSAddress4', Label = 'Address line 4 (long)', [Description] = 'This setting specifies whether the address line 4 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'AddrStreetName';
END

/**************************** ess.Policy - 'AddrSuburb' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'AddrSuburb')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'AddrSuburb','txtSARSAddress5','Address line 5 (long)','This setting specifies whether the address line 5 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSARSAddress5', Label = 'Address line 5 (long)', [Description] = 'This setting specifies whether the address line 5 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'AddrSuburb';
END

/**************************** ess.Policy - 'AddrCity' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'AddrCity')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'AddrCity','txtSARSAddress6','Address line 6 (long)','This setting specifies whether the address line 6 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSARSAddress6', Label = 'Address line 6 (long)', [Description] = 'This setting specifies whether the address line 6 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'AddrCity';
END

/**************************** ess.Policy - 'AddrZip' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'AddrZip')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'AddrZip','txtSARSAddress7','Address line 7 (long)','This setting specifies whether the address line 6 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSARSAddress7', Label = 'Address line 7 (long)', [Description] = 'This setting specifies whether the address line 6 (long) field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'AddrZip';
END

/**************************** ess.Policy - 'FaxNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'FaxNo')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'FaxNo','txtFacsimile','Fax No.','This setting specifies whether the facsimile field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtFacsimile', Label = 'Fax No.', [Description] = 'This setting specifies whether the facsimile field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'FaxNo';
END

/**************************** ess.Policy - 'EmailAddress1' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'EmailAddress1')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'EmailAddress1','txtEmailAddress1','Personal Email Address','This setting specifies whether the email address (alternative) field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtEmailAddress1', Label = 'Personal Email Address', [Description] = 'This setting specifies whether the email address (alternative) field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'EmailAddress1';
END

/**************************** ess.Policy - 'Latitude' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Latitude')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'Latitude','txtLatitude','Latitude','This setting specifies whether the latitude field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtLatitude', Label = 'Latitude', [Description] = 'This setting specifies whether the latitude field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Latitude';
END

/**************************** ess.Policy - 'Longitude' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Longitude')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'Longitude','txtLongitude','Longitude','This setting specifies whether the longitude field in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtLongitude', Label = 'Longitude', [Description] = 'This setting specifies whether the longitude field in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Longitude';
END

/**************************** ess.Policy - 'DisableAutoSave' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'DisableAutoSave')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(5,5,3,5,3,'DisableAutoSave','DisableAutoSave','DisableAutoSave','This setting disabled the autosave feature on the performance module; the module will only send the data to the server if the users save or submit the form.

		Default:

		Disabled on new installations.',1,1,0,0,5);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 5, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'DisableAutoSave', Label = 'DisableAutoSave', [Description] = 'This setting disabled the autosave feature on the performance module; the module will only send the data to the server if the users save or submit the form.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 5 WHERE [Key]  = 'DisableAutoSave';
END

/**************************** ess.Policy - 'ShowTerminated' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ShowTerminated')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,5,3,5,3,'ShowTerminated','ShowTerminated','ShowTerminated','This setting allows the ESS to load terminated employees in the dropdown where you can choose an employee; when this policy is disabled only current employees will be loaded into the dropdown menu on the left.

		Default:

		Disabled on new installations.',1,1,0,0,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'ShowTerminated', Label = 'ShowTerminated', [Description] = 'This setting allows the ESS to load terminated employees in the dropdown where you can choose an employee; when this policy is disabled only current employees will be loaded into the dropdown menu on the left.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 2 WHERE [Key]  = 'ShowTerminated';
END

/**************************** ess.Policy - 'EvaluationsConfig' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'EvaluationsConfig')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,5,3,5,3,'EvaluationsConfig','EvaluationsConfig','EvaluationsConfig','This setting determines if the particular employee should be allowed to configured evaluations (e.g. create groups and schemes via the ESS).

		Default:

		Disabled on new installations.',1,1,0,1,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'EvaluationsConfig', Label = 'EvaluationsConfig', [Description] = 'This setting determines if the particular employee should be allowed to configured evaluations (e.g. create groups and schemes via the ESS).

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 2 WHERE [Key]  = 'EvaluationsConfig';
END

/**************************** ess.Policy - 'EvaluationResults' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'EvaluationResults')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,5,3,5,3,'EvaluationResults','EvaluationResults','EvaluationResults','This setting determines if the particular employee should be allowed to see the results pane on the evaluations module.

		Default:

		Disabled on new installations.',1,1,0,1,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'EvaluationResults', Label = 'EvaluationResults', [Description] = 'This setting determines if the particular employee should be allowed to see the results pane on the evaluations module.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 2 WHERE [Key]  = 'EvaluationResults';
END

/**************************** ess.Policy - 'LeaveResults' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'LeaveResults')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,5,3,5,3,'LeaveResults','LeaveResults','LeaveResults','This setting determines if the particular employee should be allowed to see the results pane on the leave module.

		Default:

		Disabled on new installations.',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'LeaveResults', Label = 'LeaveResults', [Description] = 'This setting determines if the particular employee should be allowed to see the results pane on the leave module.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'LeaveResults';
END

/**************************** ess.Policy - 'TaskResults' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'TaskResults')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,5,3,5,3,'TaskResults','TaskResults','TaskResults','This setting determines if the particular employee should be allowed to see the results pane on the tasks module.

		Default:

		Disabled on new installations.',1,1,0,1,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'TaskResults', Label = 'TaskResults', [Description] = 'This setting determines if the particular employee should be allowed to see the results pane on the tasks module.

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 2 WHERE [Key]  = 'TaskResults';
END

/**************************** ess.Policy - 'TimesheetsConfig' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'TimesheetsConfig')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,5,3,5,3,'TimesheetsConfig','TimesheetsConfig','TimesheetsConfig','This setting determines if the particular employee should be allowed to configured timesheets (e.g. create new timesheet forms or update existing forms via the ESS).

		Default:

		Disabled on new installations.',1,1,0,1,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'TimesheetsConfig', Label = 'TimesheetsConfig', [Description] = 'This setting determines if the particular employee should be allowed to configured timesheets (e.g. create new timesheet forms or update existing forms via the ESS).

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 2 WHERE [Key]  = 'TimesheetsConfig';
END

/**************************** ess.Policy - 'ClaimsConfig' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ClaimsConfig')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,5,3,5,3,'ClaimsConfig','ClaimsConfig','ClaimsConfig','This setting determines if the particular employee should be allowed to configured claims (e.g. create new claim forms or update existing forms via the ESS).

		Default:

		Disabled on new installations.',1,1,0,1,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'ClaimsConfig', Label = 'ClaimsConfig', [Description] = 'This setting determines if the particular employee should be allowed to configured claims (e.g. create new claim forms or update existing forms via the ESS).

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 2 WHERE [Key]  = 'ClaimsConfig';
END

/**************************** ess.Policy - 'KeyAreas' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'KeyAreas')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(5,19,13,19,13,'KeyAreas','KeyAreas','KeyAreas','This setting allows for customization inside the evaluation module to the Key Areas label.

		Default:

		''Key Areas'' on new installations.',1,1,0,0,5);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 5, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'KeyAreas', Label = 'KeyAreas', [Description] = 'This setting allows for customization inside the evaluation module to the Key Areas label.

		Default:

		''Key Areas'' on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 5 WHERE [Key]  = 'KeyAreas';
END

/**************************** ess.Policy - 'KeyElements' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'KeyElements')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(5,19,13,19,13,'KeyElements','KeyElements','KeyElements','This setting allows for customization inside the evaluation module to the Key Elements label.

		Default:

		''Critical Success Elements'' on new installations.',1,1,0,0,5);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 5, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'KeyElements', Label = 'KeyElements', [Description] = 'This setting allows for customization inside the evaluation module to the Key Elements label.

		Default:

		''Critical Success Elements'' on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 5 WHERE [Key]  = 'KeyElements';
END

/**************************** ess.Policy - 'ShowCreate' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ShowCreate')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,5,3,5,3,'ShowCreate','ShowCreate','ShowCreate','This setting determines if the employee create button on the toolbar should be shown (take-on).

		Default:

		Disabled on new installations.',1,1,0,1,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'ShowCreate', Label = 'ShowCreate', [Description] = 'This setting determines if the employee create button on the toolbar should be shown (take-on).

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 2 WHERE [Key]  = 'ShowCreate';
END

/**************************** ess.Policy - 'AdjustmentTypes' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'AdjustmentTypes')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'AdjustmentTypes','AdjustmentTypes','AdjustmentTypes','This setting allows you to include specific leave types from the list of available leave types.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to show specific leave types, when making use of the leave adjustment section in the leave module. This policy can contain a comma seperated list e.g. Annual, Sick',1,1,0,0,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'AdjustmentTypes', Label = 'AdjustmentTypes', [Description] = 'This setting allows you to include specific leave types from the list of available leave types.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to show specific leave types, when making use of the leave adjustment section in the leave module. This policy can contain a comma seperated list e.g. Annual, Sick', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 0, ApprovalLevel = 8 WHERE [Key]  = 'AdjustmentTypes';
END

/**************************** ess.Policy - 'AllowPicUpload' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'AllowPicUpload')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,5,3,5,3,'AllowPicUpload','AllowPicUpload','AllowPicUpload','This setting determines if the employee should be able to upload his/her personal photo.

		Default:

		Enabled on new installations.',1,1,0,1,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'AllowPicUpload', Label = 'AllowPicUpload', [Description] = 'This setting determines if the employee should be able to upload his/her personal photo.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 2 WHERE [Key]  = 'AllowPicUpload';
END

/**************************** ess.Policy - 'ShowContacts' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ShowContacts')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,5,3,5,3,'ShowContacts','ShowContacts','ShowContacts','This setting determines if the employee contacts button on the toolbar should be shown (contact list).

		Default:

		Disabled on new installations.',1,1,0,1,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'ShowContacts', Label = 'ShowContacts', [Description] = 'This setting determines if the employee contacts button on the toolbar should be shown (contact list).

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 2 WHERE [Key]  = 'ShowContacts';
END

/**************************** ess.Policy - 'ShowDelete' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ShowDelete')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,5,3,5,3,'ShowDelete','ShowDelete','ShowDelete','This setting determines if the employee deletion button on the toolbar should be shown (terminations).

		Default:

		Disabled on new installations.',1,1,0,1,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'ShowDelete', Label = 'ShowDelete', [Description] = 'This setting determines if the employee deletion button on the toolbar should be shown (terminations).

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 2 WHERE [Key]  = 'ShowDelete';
END

/**************************** ess.Policy - 'ShowTransfer' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ShowTransfer')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,5,3,5,3,'ShowTransfer','ShowTransfer','ShowTransfer','This setting determines if the employee transfer button on the toolbar should be shown (transfers).

		Default:

		Disabled on new installations.',1,1,0,1,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'ShowTransfer', Label = 'ShowTransfer', [Description] = 'This setting determines if the employee transfer button on the toolbar should be shown (transfers).

		Default:

		Disabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 2 WHERE [Key]  = 'ShowTransfer';
END

/**************************** ess.Policy - 'LeaveResultType1' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'LeaveResultType1')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,6,13,6,13,'LeaveResultType1','LeaveResultType1','LeaveResultType1','This setting allows you to set a specific leave type to be used for the calculation on the leave results screen.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to show calculations for a specific leave type on the results screen. This policy can only contain one leave type',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 6, SetupDataTypeID = 13, AssemblyID = 6, DataTypeID = 13, Name = 'LeaveResultType1', Label = 'LeaveResultType1', [Description] = 'This setting allows you to set a specific leave type to be used for the calculation on the leave results screen.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to show calculations for a specific leave type on the results screen. This policy can only contain one leave type', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'LeaveResultType1';
END

/**************************** ess.Policy - 'LeaveResultType2' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'LeaveResultType2')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,6,13,6,13,'LeaveResultType2','LeaveResultType2','LeaveResultType2','This setting allows you to set a specific leave type to be used for the calculation on the leave results screen.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to show calculations for a specific leave type on the results screen. This policy can only contain one leave type',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 6, SetupDataTypeID = 13, AssemblyID = 6, DataTypeID = 13, Name = 'LeaveResultType2', Label = 'LeaveResultType2', [Description] = 'This setting allows you to set a specific leave type to be used for the calculation on the leave results screen.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to show calculations for a specific leave type on the results screen. This policy can only contain one leave type', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'LeaveResultType2';
END

/**************************** ess.Policy - 'LeaveFuture' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'LeaveFuture')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'LeaveFuture','LeaveFuture','LeaveFuture','This setting allows you to specify which leave types may not be applied for in the future.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to disallow specific leave type applications if they are in the future. This policy can contain a comma seperated list e.g. Annual, Study',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'LeaveFuture', Label = 'LeaveFuture', [Description] = 'This setting allows you to specify which leave types may not be applied for in the future.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to disallow specific leave type applications if they are in the future. This policy can contain a comma seperated list e.g. Annual, Study', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'LeaveFuture';
END

/**************************** ess.Policy - 'ForceDocumentPublic' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ForceDocumentPublic')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'ForceDocumentPublic','ForceDocumentPublic','ForceDocumentPublic','This setting allows you to specify which leave types should force a person to upload a file before application (if the leave application starts or ends one day before or after a public holiday).

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to force a document to be attached for a specific leave type when the person is applying for leave (if the leave application starts / ends one day before or after a public holiday). This policy can contain a comma seperated list e.g. Sick, Study',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'ForceDocumentPublic', Label = 'ForceDocumentPublic', [Description] = 'This setting allows you to specify which leave types should force a person to upload a file before application (if the leave application starts or ends one day before or after a public holiday).

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to force a document to be attached for a specific leave type when the person is applying for leave (if the leave application starts / ends one day before or after a public holiday). This policy can contain a comma seperated list e.g. Sick, Study', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'ForceDocumentPublic';
END

/**************************** ess.Policy - 'DisallowPublic' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'DisallowPublic')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'DisallowPublic','DisallowPublic','DisallowPublic','This setting allows you to specify which leave types may not be starting / ending one day before or after a public holiday.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to disallow a leave application starting / ending one day before or after a public holiday. This policy can contain a comma seperated list e.g. Sick, Study',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'DisallowPublic', Label = 'DisallowPublic', [Description] = 'This setting allows you to specify which leave types may not be starting / ending one day before or after a public holiday.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to disallow a leave application starting / ending one day before or after a public holiday. This policy can contain a comma seperated list e.g. Sick, Study', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'DisallowPublic';
END

/**************************** ess.Policy - 'LeaveInverse' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'LeaveInverse')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(8,19,13,19,13,'LeaveInverse','LeaveInverse','LeaveInverse','This setting allows you to specify which leave types where the duration calculation is swopped, calculates the duration for non-working hours/days, e.g. weekends or public holidays and rejects applications if there is a normal working hour/day in between.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to calculate the duration for specific leave type applications part of non-working hours/days, e.g. weekends or public holidays. This policy can contain a comma seperated list e.g. Annual, Study',1,1,0,1,8);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 8, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'LeaveInverse', Label = 'LeaveInverse', [Description] = 'This setting allows you to specify which leave types where the duration calculation is swopped, calculates the duration for non-working hours/days, e.g. weekends or public holidays and rejects applications if there is a normal working hour/day in between.

		Default:

		Not configured on new installations.

		Note:

		When using this policy you can configure to calculate the duration for specific leave type applications part of non-working hours/days, e.g. weekends or public holidays. This policy can contain a comma seperated list e.g. Annual, Study', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 8 WHERE [Key]  = 'LeaveInverse';
END

/**************************** ess.Policy - 'Category' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Category')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,6,13,'Category','cmbCategory','Category','This setting specifies whether the category field in the organizational module should be displayed.

			Default:

			Enabled on new installations.',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbCategory', Label = 'Category', [Description] = 'This setting specifies whether the category field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'Category';
END

/**************************** ess.Policy - 'PayLevel' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'PayLevel')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,6,13,'PayLevel','cmbPayLevel','Pay Level','This setting specifies whether the Pay Level field in the organizational module should be displayed.

			Default:

			Enabled on new installations.',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbPayLevel', Label = 'Pay Level', [Description] = 'This setting specifies whether the Pay Level field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'PayLevel';
END

/**************************** ess.Policy - 'Shifting' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Shifting')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,6,13,'Shifting','cmbShifting','Shifting','This setting specifies whether the Shifting field in the organizational module should be displayed.

			Default:

			Enabled on new installations.',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbShifting', Label = 'Shifting', [Description] = 'This setting specifies whether the Shifting field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'Shifting';
END

/**************************** ess.Policy - 'WorkAssignment' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'WorkAssignment')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,6,13,'WorkAssignment','cmbWorkAssignment','Work Assignment','This setting specifies whether the Work Assignment field in the organizational module should be displayed.

			Default:

			Enabled on new installations.',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbWorkAssignment', Label = 'Work Assignment', [Description] = 'This setting specifies whether the Work Assignment field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'WorkAssignment';
END

/**************************** ess.Policy - 'UnionAffiliation' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'UnionAffiliation')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,6,13,'UnionAffiliation','cmbUnionAffiliation','Union Affiliation','This setting specifies whether the Union Affiliation field in the organizational module should be displayed.

			Default:

			Enabled on new installations.',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbUnionAffiliation', Label = 'Union Affiliation', [Description] = 'This setting specifies whether the Union Affiliation field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'UnionAffiliation';
END

/**************************** ess.Policy - 'ShirtSize' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ShirtSize')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,6,13,'ShirtSize','cmbShirtSize','Shirt Size','This setting specifies whether the Shirt Size field in the organizational module should be displayed.

			Default:

			Enabled on new installations.',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbShirtSize', Label = 'Shirt Size', [Description] = 'This setting specifies whether the Shirt Size field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'ShirtSize';
END

/**************************** ess.Policy - 'Blazer' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Blazer')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,19,13,'Blazer','txtBlazer','Blazer','This setting specifies whether the Blazer field in the organizational module should be displayed.

			Default:

			Enabled on new installations.',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtBlazer', Label = 'Blazer', [Description] = 'This setting specifies whether the Blazer field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'Blazer';
END

/**************************** ess.Policy - 'Skirt' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Skirt')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,19,13,'Skirt','txtSkirt','Skirt','This setting specifies whether the Skirt field in the organizational module should be displayed.

			Default:

			Enabled on new installations.',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSkirt', Label = 'Skirt', [Description] = 'This setting specifies whether the Skirt field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'Skirt';
END

/**************************** ess.Policy - 'Blouse' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Blouse')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,19,13,'Blouse','txtBlouse','Blouse','This setting specifies whether the Blouse field in the organizational module should be displayed.

			Default:

			Enabled on new installations.',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtBlouse', Label = 'Blouse', [Description] = 'This setting specifies whether the Blouse field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'Blouse';
END

/**************************** ess.Policy - 'Slacks' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Slacks')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,19,13,'Slacks','txtSlacks','Slacks','This setting specifies whether the Slacks field in the organizational module should be displayed.

			Default:

			Enabled on new installations.',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSlacks', Label = 'Slacks', [Description] = 'This setting specifies whether the Slacks field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'Slacks';
END

/**************************** ess.Policy - 'Shirtjack' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Shirtjack')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,19,13,'Shirtjack','txtShirtjack','Shirtjack','This setting specifies whether the Shirtjack field in the organizational module should be displayed.

			Default:

			Enabled on new installations.',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtShirtjack', Label = 'Shirtjack', [Description] = 'This setting specifies whether the Shirtjack field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'Shirtjack';
END

/**************************** ess.Policy - 'ShirtjackPants' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ShirtjackPants')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,19,13,'ShirtjackPants','txtShirtjackPants','Shirtjack Pants','This setting specifies whether the ShirtjackPants field in the organizational module should be displayed.

			Default:

			Enabled on new installations.',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtShirtjackPants', Label = 'Shirtjack Pants', [Description] = 'This setting specifies whether the ShirtjackPants field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'ShirtjackPants';
END

/**************************** ess.Policy - 'PoloBarong' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'PoloBarong')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,19,13,'PoloBarong','txtPoloBarong','Polo/Barong','This setting specifies whether the Polo/Barong field in the organizational module should be displayed.

			Default:

			Enabled on new installations.',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtPoloBarong', Label = 'Polo/Barong', [Description] = 'This setting specifies whether the Polo/Barong field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'PoloBarong';
END

/**************************** ess.Policy - 'RepellantPants' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'RepellantPants')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,19,13,'RepellantPants','txtRepellantPants','Repellant Pants','This setting specifies whether the Repellant Pants field in the organizational module should be displayed.

			Default:

			Enabled on new installations.',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtRepellantPants', Label = 'Repellant Pants', [Description] = 'This setting specifies whether the Repellant Pants field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'RepellantPants';
END

/**************************** ess.Policy - 'PoloShirt' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'PoloShirt')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,19,13,'PoloShirt','txtPoloShirt','Polo Shirt','This setting specifies whether the Polo Shirt field in the organizational module should be displayed.

			Default:

			Enabled on new installations.',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtPoloShirt', Label = 'Polo Shirt', [Description] = 'This setting specifies whether the Polo Shirt field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'PoloShirt';
END

/**************************** ess.Policy - 'MaongPants' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'MaongPants')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,19,13,'MaongPants','txtMaongPants','Maong Pants','This setting specifies whether the Maong Pants field in the organizational module should be displayed.

			Default:

			Enabled on new installations.',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtMaongPants', Label = 'Maong Pants', [Description] = 'This setting specifies whether the Maong Pants field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'MaongPants';
END

/**************************** ess.Policy - 'TShirt' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'TShirt')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,19,13,'TShirt','txtTShirt','T-Shirt','This setting specifies whether the T-Shirt field in the organizational module should be displayed.

			Default:

			Enabled on new installations.',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtTShirt', Label = 'T-Shirt', [Description] = 'This setting specifies whether the T-Shirt field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'TShirt';
END

/**************************** ess.Policy - 'Overalls' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Overalls')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,19,13,'Overalls','txtOveralls','Overalls','This setting specifies whether the Overalls field in the organizational module should be displayed.

			Default:

			Enabled on new installations.',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtOveralls', Label = 'Overalls', [Description] = 'This setting specifies whether the Overalls field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'Overalls';
END

/**************************** ess.Policy - 'NOK_Surname' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'NOK_Surname')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'NOK_Surname','txtGuardianLastName','Emergency Contact Last Name','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtGuardianLastName', Label = 'Emergency Contact Last Name', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'NOK_Surname';
END

/**************************** ess.Policy - 'NOK_FirstName' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'NOK_FirstName')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'NOK_FirstName','txtGuardianFirstName','Emergency Contact First Name','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtGuardianFirstName', Label = 'Emergency Contact First Name', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'NOK_FirstName';
END

/**************************** ess.Policy - 'NOK_MiddleName' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'NOK_MiddleName')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'NOK_MiddleName','txtGuardianMiddleName','Emergency Contact Middle Name','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtGuardianMiddleName', Label = 'Emergency Contact Middle Name', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'NOK_MiddleName';
END

/**************************** ess.Policy - 'NOK_Age' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'NOK_Age')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'NOK_Age','txtGuardianAge','Emergency Contact Age','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtGuardianAge', Label = 'Emergency Contact Age', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'NOK_Age';
END

/**************************** ess.Policy - 'NOK_ERAddress' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'NOK_ERAddress')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'NOK_ERAddress','txtGuardianAddress','Emergency Contact Address','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtGuardianAddress', Label = 'Emergency Contact Address', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'NOK_ERAddress';
END

/**************************** ess.Policy - 'NOK_ContactNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'NOK_ContactNo')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'NOK_ContactNo','txtGuardianContactNo','Emergency Contact Contact Information','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtGuardianContactNo', Label = 'Emergency Contact Contact Information', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'NOK_ContactNo';
END

/**************************** ess.Policy - 'NOK_Occupation' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'NOK_Occupation')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'NOK_Occupation','txtGuardianOccupation','Emergency Contact Occupation','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtGuardianOccupation', Label = 'Emergency Contact Occupation', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'NOK_Occupation';
END

/**************************** ess.Policy - 'NOK_Employer' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'NOK_Employer')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'NOK_Employer','txtGuardianEmployer','Emergency Contact Employer','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtGuardianEmployer', Label = 'Emergency Contact Employer', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'NOK_Employer';
END

/**************************** ess.Policy - 'NOK_Gender' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'NOK_Gender')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,6,13,'NOK_Gender','cmbGuardianSex','Emergency Contact Gender','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbGuardianSex', Label = 'Emergency Contact Gender', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'NOK_Gender';
END

/**************************** ess.Policy - 'NOK_Relationship' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'NOK_Relationship')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,6,13,'NOK_Relationship','cmbGuardianRelationship','Emergency Contact Relationship','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbGuardianRelationship', Label = 'Emergency Contact Relationship', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'NOK_Relationship';
END

/**************************** ess.Policy - 'NOK_DateOfBirth' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'NOK_DateOfBirth')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,7,15,'NOK_DateOfBirth','dteGuardianBirthDate','Emergency Contact Birthdate','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 7, DataTypeID = 15, Name = 'dteGuardianBirthDate', Label = 'Emergency Contact Birthdate', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'NOK_DateOfBirth';
END

/**************************** ess.Policy - 'Initials' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Initials')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'Initials','txtSuffix','Suffix','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSuffix', Label = 'Suffix', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Initials';
END

/**************************** ess.Policy - 'MaidenName' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'MaidenName')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'MaidenName','txtMaidenName','Mother Maiden Name','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtMaidenName', Label = 'Mother Maiden Name', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'MaidenName';
END

/**************************** ess.Policy - 'MiddleName' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'MiddleName')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'MiddleName','txtMiddleName','Middle Name','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtMiddleName', Label = 'Middle Name', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'MiddleName';
END

/**************************** ess.Policy - 'Age' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Age')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'Age','txtAge','Age','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtAge', Label = 'Age', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Age';
END

/**************************** ess.Policy - 'ZodiacSignActual' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ZodiacSignActual')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'ZodiacSignActual','txtZodiacSign','Zodiac Sign','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtZodiacSign', Label = 'Zodiac Sign', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'ZodiacSignActual';
END

/**************************** ess.Policy - 'SpouseMiddleName' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SpouseMiddleName')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'SpouseMiddleName','txtSpouseMiddleName','SpouseMiddleName','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSpouseMiddleName', Label = 'SpouseMiddleName', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'SpouseMiddleName';
END

/**************************** ess.Policy - 'BIRMembershipNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'BIRMembershipNo')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'BIRMembershipNo','txtTIN','TIN No.','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtTIN', Label = 'TIN No.', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'BIRMembershipNo';
END

/**************************** ess.Policy - 'SSSMembershipNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SSSMembershipNo')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'SSSMembershipNo','txtSSS','SSS Membership No.','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSSS', Label = 'SSS Membership No.', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'SSSMembershipNo';
END

/**************************** ess.Policy - 'PAGIBIGMembershipNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'PAGIBIGMembershipNo')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'PAGIBIGMembershipNo','txtHDMF','Pag-Ibig Membership No.','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtHDMF', Label = 'Pag-Ibig Membership No.', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'PAGIBIGMembershipNo';
END

/**************************** ess.Policy - 'PHILMemNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'PHILMemNo')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'PHILMemNo','txtPHIC','Phil-Health Membership No.','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtPHIC', Label = 'Phil-Health Membership No.', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'PHILMemNo';
END

/**************************** ess.Policy - 'PersonnelMovement' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'PersonnelMovement')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,21,18,'PersonnelMovement','dgView_Movement','PersonnelMovement','',1,0,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 21, DataTypeID = 18, Name = 'dgView_Movement', Label = 'PersonnelMovement', [Description] = '', Visible = 1, Editable = 0, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'PersonnelMovement';
END

/**************************** ess.Policy - 'AdminRestriction' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'AdminRestriction')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(2,19,13,19,13,'AdminRestriction','AdminRestriction','AdminRestriction','This setting allows a SuperAdmin to control which fields are maintained by other users. Default: Not configured on new installations. Note: When using this policy you can configure to hide specific items. This policy can contain a comma seperated list e.g. Age, BloodType',1,1,0,1,2);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 2, SetupAssemblyID = 19, SetupDataTypeID = 13, AssemblyID = 19, DataTypeID = 13, Name = 'AdminRestriction', Label = 'AdminRestriction', [Description] = 'This setting allows a SuperAdmin to control which fields are maintained by other users. Default: Not configured on new installations. Note: When using this policy you can configure to hide specific items. This policy can contain a comma seperated list e.g. Age, BloodType', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 2 WHERE [Key]  = 'AdminRestriction';
END

/**************************** ess.Policy - 'SpouseAge' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SpouseAge')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'SpouseAge','txtSpouseAge','Spouse Age','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSpouseAge', Label = 'Spouse Age', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'SpouseAge';
END

/**************************** ess.Policy - 'SpouseOccu' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SpouseOccu')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'SpouseOccu','txtSpouseOccupation','Spouse Occupation','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSpouseOccupation', Label = 'Spouse Occupation', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'SpouseOccu';
END

/**************************** ess.Policy - 'SpouseEmployer' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SpouseEmployer')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'SpouseEmployer','txtSpouseEmployer','Spouse Employer','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSpouseEmployer', Label = 'Spouse Employer', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'SpouseEmployer';
END

/**************************** ess.Policy - 'SpouseEmployerAdd' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SpouseEmployerAdd')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'SpouseEmployerAdd','txtSpouseEmployerAddress','Spouse Employer Address','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSpouseEmployerAddress', Label = 'Spouse Employer Address', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'SpouseEmployerAdd';
END

/**************************** ess.Policy - 'Certifications' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Certifications')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(9,5,3,24,18,'Certifications','dgView_005','Certifications','This setting specifies whether the certifications grid in the curriculum viate module should be displayed.      Default:      Enabled on new installations.',1,1,0,1,9);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 9, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 24, DataTypeID = 18, Name = 'dgView_005', Label = 'Certifications', [Description] = 'This setting specifies whether the certifications grid in the curriculum viate module should be displayed.      Default:      Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 9 WHERE [Key]  = 'Certifications';
END

/**************************** ess.Policy - 'Seminars' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Seminars')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(9,5,3,24,18,'Seminars','dgView_005','Seminars','This setting specifies whether the seminars grid in the curriculum viate module should be displayed.      Default:      Enabled on new installations.',1,1,0,1,9);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 9, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 24, DataTypeID = 18, Name = 'dgView_005', Label = 'Seminars', [Description] = 'This setting specifies whether the seminars grid in the curriculum viate module should be displayed.      Default:      Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 9 WHERE [Key]  = 'Seminars';
END

/**************************** ess.Policy - 'ShuttleRoute' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ShuttleRoute')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,6,13,'ShuttleRoute','cmbShuttlePreference','ShuttleRoute','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbShuttlePreference', Label = 'ShuttleRoute', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'ShuttleRoute';
END

/**************************** ess.Policy - 'Region' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Region')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,6,13,'Region','cmbPermanentRegion','Region','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbPermanentRegion', Label = 'Region', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Region';
END

/**************************** ess.Policy - 'OnTheJobTraining' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'OnTheJobTraining')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(9,5,3,24,18,'OnTheJobTraining','dgView_001','OnTheJobTraining','',1,1,0,1,9);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 9, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 24, DataTypeID = 18, Name = 'dgView_001', Label = 'OnTheJobTraining', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 9 WHERE [Key]  = 'OnTheJobTraining';
END

/**************************** ess.Policy - 'Attributes' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Attributes')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,24,18,'Attributes','dgView_004','Attributes','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 24, DataTypeID = 18, Name = 'dgView_004', Label = 'Attributes', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Attributes';
END

/**************************** ess.Policy - 'RecInterestHob' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'RecInterestHob')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'RecInterestHob','txtInterestsHobbies','RecInterestHob','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtInterestsHobbies', Label = 'RecInterestHob', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'RecInterestHob';
END

/**************************** ess.Policy - 'AddrRegion' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'AddrRegion')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,6,13,'AddrRegion','cmbPresentRegion','AddrRegion','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbPresentRegion', Label = 'AddrRegion', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'AddrRegion';
END

/**************************** ess.Policy - 'EmploymentHistory' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'EmploymentHistory')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(9,5,3,24,18,'EmploymentHistory','dgView_007','EmploymentHistory','',1,1,0,1,9);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 9, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 24, DataTypeID = 18, Name = 'dgView_007', Label = 'EmploymentHistory', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 9 WHERE [Key]  = 'EmploymentHistory';
END

/**************************** ess.Policy - 'EducationalBackground' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'EducationalBackground')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(9,5,3,24,18,'EducationalBackground','dgView_002','EducationalBackground','',1,1,0,1,9);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 9, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 24, DataTypeID = 18, Name = 'dgView_002', Label = 'EducationalBackground', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 9 WHERE [Key]  = 'EducationalBackground';
END

/**************************** ess.Policy - 'TaxCode' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'TaxCode')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,6,13,'TaxCode','cmbTaxCode','TaxCode','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbTaxCode', Label = 'TaxCode', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'TaxCode';
END

/**************************** ess.Policy - 'OrganizationalAffiliations' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'OrganizationalAffiliations')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(9,5,3,24,18,'OrganizationalAffiliations','dgView_003','OrganizationalAffiliations','',1,1,0,1,9);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 9, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 24, DataTypeID = 18, Name = 'dgView_003', Label = 'OrganizationalAffiliations', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 9 WHERE [Key]  = 'OrganizationalAffiliations';
END

/**************************** ess.Policy - 'AddrState' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'AddrState')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'AddrState','txtPresentProvince','AddrState','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtPresentProvince', Label = 'AddrState', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'AddrState';
END

/**************************** ess.Policy - 'AddrBaranggay' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'AddrBaranggay')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'AddrBaranggay','txtPresentBaranggay','AddrBarangay','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtPresentBaranggay', Label = 'Present Barangay', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'AddrBaranggay';
END

/**************************** ess.Policy - 'AddrTelNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'AddrTelNo')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'AddrTelNo','txtPresentTelNo','AddrTelNo','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtPresentTelNo', Label = 'AddrTelNo', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'AddrTelNo';
END

/**************************** ess.Policy - 'Address5' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Address5')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'Address5','txtAddress5','Address5','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtAddress5', Label = 'Address5', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Address5';
END

/**************************** ess.Policy - 'Address6' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Address6')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'Address6','txtAddress6','Address6','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtAddress6', Label = 'Address6', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Address6';
END

/**************************** ess.Policy - 'PermanentHouseNumber' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'PermanentHouseNumber')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'PermanentHouseNumber','txtPermanentHouseNumber','PermanentHouseNumber','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtPermanentHouseNumber', Label = 'PermanentHouseNumber', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'PermanentHouseNumber';
END

/**************************** ess.Policy - 'PermanentStreetName' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'PermanentStreetName')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'PermanentStreetName','txtPermanentStreetName','PermanentStreetName','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtPermanentStreetName', Label = 'PermanentStreetName', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'PermanentStreetName';
END

/**************************** ess.Policy - 'PermanentSubdivision' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'PermanentSubdivision')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'PermanentSubdivision','txtPermanentSubdivision','PermanentSubdivision','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtPermanentSubdivision', Label = 'PermanentSubdivision', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'PermanentSubdivision';
END

/**************************** ess.Policy - 'State_or_Province' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'State_or_Province')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'State_or_Province','txtPermanentProvince','State_or_Province','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtPermanentProvince', Label = 'State_or_Province', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'State_or_Province';
END

/**************************** ess.Policy - 'PermanentCity' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'PermanentCity')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'PermanentCity','txtPermanentCity','PermanentCity','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtPermanentCity', Label = 'PermanentCity', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'PermanentCity';
END

/**************************** ess.Policy - 'PermanentBaranggay' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'PermanentBaranggay')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'PermanentBaranggay','txtPermanentBaranggay','Permanent Barangay','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtPermanentBaranggay', Label = 'Permanent Barangay', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'PermanentBaranggay';
END

/**************************** ess.Policy - 'PermanentPostalCode' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'PermanentPostalCode')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'PermanentPostalCode','txtPermanentPostalCode','PermanentPostalCode','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtPermanentPostalCode', Label = 'PermanentPostalCode', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'PermanentPostalCode';
END

/**************************** ess.Policy - 'PermanentTelNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'PermanentTelNo')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'PermanentTelNo','txtPermanentTelNo','PermanentTelNo','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtPermanentTelNo', Label = 'PermanentTelNo', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'PermanentTelNo';
END

/**************************** ess.Policy - 'Division' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Division')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,19,13,'Division','txtDivision','Division','',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtDivision', Label = 'Division', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'Division';
END

/**************************** ess.Policy - 'Department' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Department')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,19,13,'Department','txtDepartment','Department','',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtDepartment', Label = 'Department', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'Department';
END

/**************************** ess.Policy - 'Section' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Section')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,19,13,'Section','txtSection','Section','',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSection', Label = 'Section', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'Section';
END

/**************************** ess.Policy - 'Fixed' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Fixed')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,6,13,'Fixed','cmbFixed','Fixed','',1,1,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbFixed', Label = 'Fixed', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'Fixed';
END

/**************************** ess.Policy - 'Contracting' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Contracting')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(7,5,3,21,18,'Contracting','dgView_003','Contracting','',1,0,0,1,7);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 7, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 21, DataTypeID = 18, Name = 'dgView_003', Label = 'Contracting', [Description] = '', Visible = 1, Editable = 0, [Required] = 0, [Cascade] = 1, ApprovalLevel = 7 WHERE [Key]  = 'Contracting';
END

/**************************** ess.Policy - 'BloodType' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'BloodType')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,6,13,'BloodType','cmbBloodType','Blood Type','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbBloodType', Label = 'Blood Type', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'BloodType';
END

/**************************** ess.Policy - 'MarriageDate' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'MarriageDate')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,7,15,'MarriageDate','dteMarriageDate','Date Of Marriage','',1,0,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 7, DataTypeID = 15, Name = 'dteMarriageDate', Label = 'Date of Marriage', [Description] = '', Visible = 1, Editable = 0, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'MarriageDate';
END

/**************************** ess.Policy - 'TownOfBirth' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'TownOfBirth')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'TownOfBirth','txtTownOfBirth','Town of Birth','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtTownOfBirth', Label = 'Town of Birth', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'TownOfBirth';
END

/**************************** ess.Policy - 'CountryOfBirth' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'CountryOfBirth')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'CountryOfBirth','cmbCountryOfBirth','Country of Birth','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'cmbCountryOfBirth', Label = 'Country of Birth', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'CountryOfBirth';
END

/**************************** ess.Policy - 'CityOfBirth' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'CityOfBirth')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'CityOfBirth','txtCityOfBirth','Municipality/City','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtCityOfBirth', Label = 'Municipality/City', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'CityOfBirth';
END

/**************************** ess.Policy - 'ExemptionClaim' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ExemptionClaim')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,5,3,'ExemptionClaim','chkExemptionClaim','ExemptionClaim','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 5, DataTypeID = 3, Name = 'chkExemptionClaim', Label = 'ExemptionClaim', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'ExemptionClaim';
END

/**************************** ess.Policy - 'Dependants' ****************************/
--IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Dependants')
--BEGIN
--   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,24,18,'Dependants','dgView_003','Dependants','This setting specifies whether the dependants grid in the personal module should be displayed.

--		Default:

--		Enabled on new installations.',1,1,1,1,6);
--END
--ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 24, DataTypeID = 18, Name = 'dgView_003', Label = 'Dependants', [Description] = 'This setting specifies whether the dependants grid in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 1, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Dependants';
END

/**************************** ess.Policy - 'SeminarsAndTraining' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SeminarsAndTraining')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(9,5,3,24,18,'SeminarsAndTraining','dgView_006','Seminars And Training','This setting specifies whether the seminars and training grid in the curriculum viate module should be displayed.      Default:      Enabled on new installations.',1,1,0,1,9);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 9, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 24, DataTypeID = 18, Name = 'dgView_006', Label = 'Seminars And Training', [Description] = 'This setting specifies whether the seminars and training grid in the curriculum viate module should be displayed.      Default:      Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 9 WHERE [Key]  = 'SeminarsAndTraining';
END

/**************************** ess.Policy - 'NextOfKin' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'NextOfKin')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,24,18,'NextOfKin','dgView_002','Next of kin','This setting specifies whether the next of kin grid in the personal module should be displayed.

		Default:

		Enabled on new installations.',1,1,1,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 24, DataTypeID = 18, Name = 'dgView_002', Label = 'Next of kin', [Description] = 'This setting specifies whether the next of kin grid in the personal module should be displayed.

		Default:

		Enabled on new installations.', Visible = 1, Editable = 1, [Required] = 1, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'NextOfKin';
END

/**************************** ess.Policy - 'SpouseSurname' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SpouseSurname')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'SpouseSurname','txtSpouseSurname','SpouseSurname','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSpouseSurname', Label = 'SpouseSurname', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'SpouseSurname';
END

/**************************** ess.Policy - 'SpouseDOB' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SpouseDOB')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,7,15,'SpouseDOB','dteSpouseBirthDate','SpouseDOB','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 7, DataTypeID = 15, Name = 'dteSpouseBirthDate', Label = 'SpouseDOB', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'SpouseDOB';
END

/**************************** ess.Policy - 'SpouseAddress' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SpouseAddress')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'SpouseAddress','txtSpouseAddress','SpouseAddress','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtSpouseAddress', Label = 'SpouseAddress', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'SpouseAddress';
END

/**************************** ess.Policy - 'SpouseSex' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SpouseSex')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,6,13,'SpouseSex','cmbSpouseSex','SpouseSex','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbSpouseSex', Label = 'SpouseSex', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'SpouseSex';
END

/**************************** ess.Policy - 'SpouseNationality' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'SpouseNationality')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,6,13,'SpouseNationality','cmbSpouseNationality','SpouseNationality','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 6, DataTypeID = 13, Name = 'cmbSpouseNationality', Label = 'SpouseNationality', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'SpouseNationality';
END

/**************************** ess.Policy - 'Relatives' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'Relatives')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,24,18,'Relatives','dgView_Relatives','Relatives','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 24, DataTypeID = 18, Name = 'dgView_Relatives', Label = 'Relatives', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'Relatives';
END

/**************************** ess.Policy - 'ZodiacSign' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.Policy] WHERE [Key] = 'ZodiacSign')
BEGIN
   INSERT INTO [ess.Policy](GroupID,SetupAssemblyID,SetupDataTypeID,AssemblyID,DataTypeID,[Key],Name,Label,[Description],Visible,Editable,[Required],[Cascade],ApprovalLevel) VALUES(6,5,3,19,13,'ZodiacSign','txtAnimalSign','Animal Sign','',1,1,0,1,6);
END
ELSE
BEGIN
   UPDATE [ess.Policy] SET GroupID = 6, SetupAssemblyID = 5, SetupDataTypeID = 3, AssemblyID = 19, DataTypeID = 13, Name = 'txtAnimalSign', Label = 'Animal Sign', [Description] = '', Visible = 1, Editable = 1, [Required] = 0, [Cascade] = 1, ApprovalLevel = 6 WHERE [Key]  = 'ZodiacSign';
END
go




--update 5/31/2019
--remove duplicates
--target table: [ess.Policy]

declare @forDelete table (ID varchar(max), recKey varchar(max))

--get for duplicates
insert into @forDelete
select a.ID, a.[Key] from [ess.Policy] a inner join
(select [Key] from [ess.Policy]
group by [Key]
having count([Key]) > 1) b on a.[Key] = b.[Key]
where a.ID != (select MIN(ID) from [ess.Policy] where [Key] = b.[Key])
group by a.ID, a.[Key]

--select * from @forDelete

--delete duplicates
delete a from [ess.Policy] a inner join @forDelete b on b.ID = a.ID

--check for duplicates
select a.ID, a.[Key] from [ess.Policy] a inner join
(select [Key] from [ess.Policy]
group by [Key]
having count([Key]) > 1) b on a.[Key] = b.[Key]
where a.ID != (select MIN(ID) from [ess.Policy] where [Key] = b.[Key])
group by a.ID, a.[Key]

--end

--jalzate - 6/7/2019
--add label to global items
--UPDATE [ess.Policy]
--set Name = substring([Key], 1, 25)
--where Name is null or Name = ''

UPDATE [ess.Policy]
set Label = substring([Key], 1, 25)
where Label is null or Label = ''

--end


--jalzate - 6/26/2019
--delete dependants record
update [ess.Policy]
set [Label] = 'Dependants'
where [Key] like '%dependants%'
--end

--Organisational > only compensation and benefits users can edit uniform allocation fields.
UPDATE A set Editable = CASE WHEN A.Template IN ('CompBenAdm', 'CompBen') THEN 1 ELSE 0 END 
FROM 
		[ess.PolicyItems] A  INNER JOIN
		[ess.PolicyMapping] B ON B.PolicyID = A.PolicyID
WHERE B.TabName = 'Uniform Allocation'
GO
	