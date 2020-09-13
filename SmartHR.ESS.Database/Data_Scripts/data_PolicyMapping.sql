DELETE FROM [ess.PolicyMapping] 
WHERE [PolicyID] IS NULL

/**************************** ess.PolicyMapping - 'Information' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Information'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Information'), '', '', 'Information', '', 'Information');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'Information',TableName = '',FieldName = 'Information' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Information');
END

/**************************** ess.PolicyMapping - 'Strict' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Strict'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Strict'), '', '', 'Strict', '', 'Strict');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'Strict',TableName = '',FieldName = 'Strict' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Strict');
END

/**************************** ess.PolicyMapping - 'MinLength' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'MinLength'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'MinLength'), '', '', 'MinLength', '', 'MinLength');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'MinLength',TableName = '',FieldName = 'MinLength' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'MinLength');
END

/**************************** ess.PolicyMapping - 'ADEnabled' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ADEnabled'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ADEnabled'), '', '', 'ADEnabled', '', 'ADEnabled');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ADEnabled',TableName = '',FieldName = 'ADEnabled' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ADEnabled');
END

/**************************** ess.PolicyMapping - 'ADLogon' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ADLogon'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ADLogon'), '', '', 'ADLogon', '', 'ADLogon');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ADLogon',TableName = '',FieldName = 'ADLogon' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ADLogon');
END

/**************************** ess.PolicyMapping - 'ADServer' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ADServer'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ADServer'), '', '', 'ADServer', '', 'ADServer');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ADServer',TableName = '',FieldName = 'ADServer' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ADServer');
END

/**************************** ess.PolicyMapping - 'UseProxy' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'UseProxy'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'UseProxy'), '', '', 'UseProxy', '', 'UseProxy');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'UseProxy',TableName = '',FieldName = 'UseProxy' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'UseProxy');
END

/**************************** ess.PolicyMapping - 'ProxyAddress' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ProxyAddress'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ProxyAddress'), '', '', 'ProxyAddress', '', 'ProxyAddress');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ProxyAddress',TableName = '',FieldName = 'ProxyAddress' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ProxyAddress');
END

/**************************** ess.PolicyMapping - 'ProxyPort' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ProxyPort'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ProxyPort'), '', '', 'ProxyPort', '', 'ProxyPort');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ProxyPort',TableName = '',FieldName = 'ProxyPort' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ProxyPort');
END

/**************************** ess.PolicyMapping - 'ProxyUsername' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ProxyUsername'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ProxyUsername'), '', '', 'ProxyUsername', '', 'ProxyUsername');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ProxyUsername',TableName = '',FieldName = 'ProxyUsername' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ProxyUsername');
END

/**************************** ess.PolicyMapping - 'ProxyPassword' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ProxyPassword'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ProxyPassword'), '', '', 'ProxyPassword', '', 'ProxyPassword');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ProxyPassword',TableName = '',FieldName = 'ProxyPassword' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ProxyPassword');
END

/**************************** ess.PolicyMapping - 'ProxyDomain' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ProxyDomain'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ProxyDomain'), '', '', 'ProxyDomain', '', 'ProxyDomain');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ProxyDomain',TableName = '',FieldName = 'ProxyDomain' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ProxyDomain');
END

/**************************** ess.PolicyMapping - 'ErrorLogs' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ErrorLogs'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ErrorLogs'), '', '', 'ErrorLogs', '', 'ErrorLogs');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ErrorLogs',TableName = '',FieldName = 'ErrorLogs' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ErrorLogs');
END

/**************************** ess.PolicyMapping - 'ErrorFrom' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ErrorFrom'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ErrorFrom'), '', '', 'ErrorFrom', '', 'ErrorFrom');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ErrorFrom',TableName = '',FieldName = 'ErrorFrom' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ErrorFrom');
END

/**************************** ess.PolicyMapping - 'ErrorTo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ErrorTo'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ErrorTo'), '', '', 'ErrorTo', '', 'ErrorTo');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ErrorTo',TableName = '',FieldName = 'ErrorTo' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ErrorTo');
END

/**************************** ess.PolicyMapping - 'ErrorSmtp' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ErrorSmtp'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ErrorSmtp'), '', '', 'ErrorSmtp', '', 'ErrorSmtp');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ErrorSmtp',TableName = '',FieldName = 'ErrorSmtp' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ErrorSmtp');
END

/**************************** ess.PolicyMapping - 'ErrorPort' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ErrorPort'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ErrorPort'), '', '', 'ErrorPort', '', 'ErrorPort');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ErrorPort',TableName = '',FieldName = 'ErrorPort' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ErrorPort');
END

/**************************** ess.PolicyMapping - 'ErrorUsername' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ErrorUsername'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ErrorUsername'), '', '', 'ErrorUsername', '', 'ErrorUsername');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ErrorUsername',TableName = '',FieldName = 'ErrorUsername' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ErrorUsername');
END

/**************************** ess.PolicyMapping - 'ErrorPassword' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ErrorPassword'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ErrorPassword'), '', '', 'ErrorPassword', '', 'ErrorPassword');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ErrorPassword',TableName = '',FieldName = 'ErrorPassword' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ErrorPassword');
END

/**************************** ess.PolicyMapping - 'Dropdown' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Dropdown'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Dropdown'), '', '', 'Dropdown', '', 'Dropdown');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'Dropdown',TableName = '',FieldName = 'Dropdown' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Dropdown');
END

/**************************** ess.PolicyMapping - 'ShowAge' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ShowAge'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShowAge'), '', '', 'ShowAge', '', 'ShowAge');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ShowAge',TableName = '',FieldName = 'ShowAge' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShowAge');
END

/**************************** ess.PolicyMapping - 'DateFormat' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'DateFormat'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'DateFormat'), '', '', 'DateFormat', '', 'DateFormat');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'DateFormat',TableName = '',FieldName = 'DateFormat' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'DateFormat');
END

/**************************** ess.PolicyMapping - 'PersonalChange' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'PersonalChange'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'PersonalChange'), '', '', 'PersonalChange', '', 'PersonalChange');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'PersonalChange',TableName = '',FieldName = 'PersonalChange' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'PersonalChange');
END

/**************************** ess.PolicyMapping - 'PersonalLogChange' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'PersonalLogChange'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'PersonalLogChange'), '', '', 'PersonalLogChange', '', 'PersonalLogChange');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'PersonalLogChange',TableName = '',FieldName = 'PersonalLogChange' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'PersonalLogChange');
END

/**************************** ess.PolicyMapping - 'OrganizationalChange' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'OrganizationalChange'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'OrganizationalChange'), '', '', 'OrganizationalChange', '', 'OrganizationalChange');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'OrganizationalChange',TableName = '',FieldName = 'OrganizationalChange' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'OrganizationalChange');
END

/**************************** ess.PolicyMapping - 'OrganizationalLogChange' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'OrganizationalLogChange'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'OrganizationalLogChange'), '', '', 'OrganizationalLogChange', '', 'OrganizationalLogChange');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'OrganizationalLogChange',TableName = '',FieldName = 'OrganizationalLogChange' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'OrganizationalLogChange');
END

/**************************** ess.PolicyMapping - 'Homepage' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Homepage'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Homepage'), '', '', 'Homepage', '', 'Homepage');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'Homepage',TableName = '',FieldName = 'Homepage' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Homepage');
END

/**************************** ess.PolicyMapping - 'SMSAppID' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SMSAppID'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SMSAppID'), '', '', 'SMSAppID', '', 'SMSAppID');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'SMSAppID',TableName = '',FieldName = 'SMSAppID' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SMSAppID');
END

/**************************** ess.PolicyMapping - 'SMSCode' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SMSCode'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SMSCode'), '', '', 'SMSCode', '', 'SMSCode');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'SMSCode',TableName = '',FieldName = 'SMSCode' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SMSCode');
END

/**************************** ess.PolicyMapping - 'SMSCodePwd' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SMSCodePwd'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SMSCodePwd'), '', '', 'SMSCodePwd', '', 'SMSCodePwd');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'SMSCodePwd',TableName = '',FieldName = 'SMSCodePwd' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SMSCodePwd');
END

/**************************** ess.PolicyMapping - 'SMSCountry' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SMSCountry'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SMSCountry'), '', '', 'SMSCountry', '', 'SMSCountry');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'SMSCountry',TableName = '',FieldName = 'SMSCountry' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SMSCountry');
END

/**************************** ess.PolicyMapping - 'SMSURL' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SMSURL'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SMSURL'), '', '', 'SMSURL', '', 'SMSURL');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'SMSURL',TableName = '',FieldName = 'SMSURL' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SMSURL');
END

/**************************** ess.PolicyMapping - 'Discipline' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Discipline'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Discipline'), '', '', 'Discipline', '', 'Discipline');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'Discipline',TableName = '',FieldName = 'Discipline' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Discipline');
END

/**************************** ess.PolicyMapping - 'OnOffer' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'OnOffer'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'OnOffer'), '', '', 'OnOffer', '', 'OnOffer');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'OnOffer',TableName = '',FieldName = 'OnOffer' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'OnOffer');
END

/**************************** ess.PolicyMapping - 'DisplayNames' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'DisplayNames'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'DisplayNames'), '', '', 'DisplayNames', '', 'DisplayNames');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'DisplayNames',TableName = '',FieldName = 'DisplayNames' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'DisplayNames');
END

/**************************** ess.PolicyMapping - 'ShowScore' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ShowScore'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShowScore'), '', '', 'ShowScore', '', 'ShowScore');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ShowScore',TableName = '',FieldName = 'ShowScore' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShowScore');
END

/**************************** ess.PolicyMapping - 'AutoCalcWeight' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'AutoCalcWeight'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'AutoCalcWeight'), '', '', 'AutoCalcWeight', '', 'AutoCalcWeight');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'AutoCalcWeight',TableName = '',FieldName = 'AutoCalcWeight' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'AutoCalcWeight');
END

/**************************** ess.PolicyMapping - 'SchemeCode' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SchemeCode'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SchemeCode'), '', '', 'SchemeCode', '', 'SchemeCode');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'SchemeCode',TableName = '',FieldName = 'SchemeCode' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SchemeCode');
END

/**************************** ess.PolicyMapping - 'OtherLanguage' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'OtherLanguage'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'OtherLanguage'), 'Personal', 'Personal', 'Other languages', 'Personnel', 'OtherLanguage');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Other languages',TableName = 'Personnel',FieldName = 'OtherLanguage' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'OtherLanguage');
END

/**************************** ess.PolicyMapping - 'Dependents' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Dependents'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Dependents'), 'Personal', 'Family Background', 'Dependents', 'Personnel', 'Dependents');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Family Background',ItemName = 'Dependents',TableName = 'Personnel',FieldName = 'Dependents' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Dependents');
END

/**************************** ess.PolicyMapping - 'EmployeeNum' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'EmployeeNum'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'EmployeeNum'), 'Personal', 'Personal', 'Employee number', 'Personnel', 'EmployeeNum');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Employee number',TableName = 'Personnel',FieldName = 'EmployeeNum' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'EmployeeNum');
END

/**************************** ess.PolicyMapping - 'PreferredName' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'PreferredName'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'PreferredName'), 'Personal', 'Personal', 'Preferred name', 'Personnel', 'PreferredName');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Preferred name',TableName = 'Personnel',FieldName = 'PreferredName' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'PreferredName');
END

/**************************** ess.PolicyMapping - 'Title' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Title'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Title'), 'Personal', 'Personal', 'Title', 'Personnel', 'Title');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Title',TableName = 'Personnel',FieldName = 'Title' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Title');
END

/**************************** ess.PolicyMapping - 'FirstName' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'FirstName'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'FirstName'), 'Personal', 'Personal', 'First name', 'Personnel', 'FirstName');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'First name',TableName = 'Personnel',FieldName = 'FirstName' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'FirstName');
END

/**************************** ess.PolicyMapping - 'Surname' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Surname'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Surname'), 'Personal', 'Personal', 'Surname', 'Personnel', 'Surname');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Surname',TableName = 'Personnel',FieldName = 'Surname' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Surname');
END

/**************************** ess.PolicyMapping - 'IDNum' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'IDNum'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'IDNum'), 'Personal', 'Personal', 'ID / Passport number', 'Personnel', 'IDNum');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'ID / Passport number',TableName = 'Personnel',FieldName = 'IDNum' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'IDNum');
END

/**************************** ess.PolicyMapping - 'Sex' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Sex'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Sex'), 'Personal', 'Personal', 'Gender', 'Personnel', 'Sex');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Gender',TableName = 'Personnel',FieldName = 'Sex' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Sex');
END

/**************************** ess.PolicyMapping - 'Nationality' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Nationality'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Nationality'), 'Personal', 'Personal', 'Nationality', 'Personnel', 'Nationality');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Nationality',TableName = 'Personnel',FieldName = 'Nationality' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Nationality');
END

/**************************** ess.PolicyMapping - 'BirthDate' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'BirthDate'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'BirthDate'), 'Personal', 'Personal', 'Birth date', 'Personnel', 'BirthDate');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Birth date',TableName = 'Personnel',FieldName = 'BirthDate' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'BirthDate');
END

/**************************** ess.PolicyMapping - 'Language' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Language'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Language'), 'Personal', 'Personal', 'Language', 'Personnel', 'Language');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Language',TableName = 'Personnel',FieldName = 'Language' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Language');
END

/**************************** ess.PolicyMapping - 'Religion' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Religion'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Religion'), 'Personal', 'Personal', 'Religion', 'Personnel', 'Religion');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Religion',TableName = 'Personnel',FieldName = 'Religion' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Religion');
END

/**************************** ess.PolicyMapping - 'EthnicGroup' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'EthnicGroup'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'EthnicGroup'), 'Personal', 'Personal', 'Ethnic group', 'Personnel', 'EthnicGroup');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Ethnic group',TableName = 'Personnel',FieldName = 'EthnicGroup' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'EthnicGroup');
END

/**************************** ess.PolicyMapping - 'MaritalStatus' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'MaritalStatus'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'MaritalStatus'), 'Personal', 'Personal', 'Marital status', 'Personnel', 'MaritalStatus');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Marital status',TableName = 'Personnel',FieldName = 'MaritalStatus' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'MaritalStatus');
END

/**************************** ess.PolicyMapping - 'Disability' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Disability'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Disability'), 'Personal', 'Personal', 'Disability', 'Personnel', 'Disability');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Disability',TableName = 'Personnel',FieldName = 'Disability' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Disability');
END

/**************************** ess.PolicyMapping - 'DisabilityNotes' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'DisabilityNotes'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'DisabilityNotes'), 'Personal', 'Personal', 'Disability notes', 'Personnel', 'DisabilityNotes');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Disability notes',TableName = 'Personnel',FieldName = 'DisabilityNotes' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'DisabilityNotes');
END

/**************************** ess.PolicyMapping - 'Address1' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Address1'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Address1'), 'Personal', 'Address & Telephone', 'Street', 'Personnel', 'Address1');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Street',TableName = 'Personnel',FieldName = 'Address1' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Address1');
END

/**************************** ess.PolicyMapping - 'Address2' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Address2'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Address2'), 'Personal', 'Address & Telephone', 'Suburb', 'Personnel', 'Address2');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Suburb',TableName = 'Personnel',FieldName = 'Address2' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Address2');
END

/**************************** ess.PolicyMapping - 'Address3' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Address3'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Address3'), 'Personal', 'Address & Telephone', 'Address line 3', 'Personnel', 'Address3');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Address line 3',TableName = 'Personnel',FieldName = 'Address3' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Address3');
END

/**************************** ess.PolicyMapping - 'Address4' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Address4'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Address4'), 'Personal', 'Address & Telephone', 'Address line 4', 'Personnel', 'Address4');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Address line 4',TableName = 'Personnel',FieldName = 'Address4' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Address4');
END

/**************************** ess.PolicyMapping - 'POBox' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'POBox'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'POBox'), 'Personal', 'Address & Telephone', 'P.O. Box', 'Personnel', 'POBox');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'P.O. Box',TableName = 'Personnel',FieldName = 'POBox' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'POBox');
END

/**************************** ess.PolicyMapping - 'POArea' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'POArea'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'POArea'), 'Personal', 'Address & Telephone', 'Postal area', 'Personnel', 'POArea');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Postal area',TableName = 'Personnel',FieldName = 'POArea' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'POArea');
END

/**************************** ess.PolicyMapping - 'POCode' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'POCode'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'POCode'), 'Personal', 'Address & Telephone', 'Postal code', 'Personnel', 'POCode');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Postal code',TableName = 'Personnel',FieldName = 'POCode' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'POCode');
END

/**************************** ess.PolicyMapping - 'OfficeNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'OfficeNo'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'OfficeNo'), 'Personal', 'Address & Telephone', 'Work number', 'Personnel', 'OfficeNo');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Work number',TableName = 'Personnel',FieldName = 'OfficeNo' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'OfficeNo');
END

/**************************** ess.PolicyMapping - 'ExtensionNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ExtensionNo'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ExtensionNo'), 'Personal', 'Address & Telephone', 'Local No.', 'Personnel', 'ExtensionNo');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Local No.',TableName = 'Personnel',FieldName = 'ExtensionNo' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ExtensionNo');
END

/**************************** ess.PolicyMapping - 'CellTel' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'CellTel'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'CellTel'), 'Personal', 'Address & Telephone', 'Mobile number', 'Personnel', 'CellTel');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Mobile number',TableName = 'Personnel',FieldName = 'CellTel' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'CellTel');
END

/**************************** ess.PolicyMapping - 'HomeTel' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'HomeTel'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'HomeTel'), 'Personal', 'Address & Telephone', 'Home Tel. No.', 'Personnel', 'HomeTel');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Home Tel. No.',TableName = 'Personnel',FieldName = 'HomeTel' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'HomeTel');
END

/**************************** ess.PolicyMapping - 'EmailAddress' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'EmailAddress'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'EmailAddress'), 'Personal', 'Address & Telephone', 'Company Email Address', 'Personnel', 'EmailAddress');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Company Email Address',TableName = 'Personnel',FieldName = 'EmailAddress' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'EmailAddress');
END

/**************************** ess.PolicyMapping - 'SpouseName' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SpouseName'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseName'), 'Personal', 'Family Background', 'Spouse First name', 'Personnel', 'SpouseName');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Family Background',ItemName = 'Spouse First name',TableName = 'Personnel',FieldName = 'SpouseName' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseName');
END

/**************************** ess.PolicyMapping - 'SpouseTel' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SpouseTel'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseTel'), 'Personal', 'Family Background', 'Spouse number', 'Personnel', 'SpouseTel');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Family Background',ItemName = 'Spouse number',TableName = 'Personnel',FieldName = 'SpouseTel' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseTel');
END

/**************************** ess.PolicyMapping - 'JobTitle' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'JobTitle'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'JobTitle'), 'Organisational', 'Employment', 'Job title', 'Personnel1', 'JobTitle');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Employment',ItemName = 'Job title',TableName = 'Personnel1',FieldName = 'JobTitle' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'JobTitle');
END

/**************************** ess.PolicyMapping - 'JobGrade' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'JobGrade'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'JobGrade'), 'Organisational', 'Employment', 'Job grade', 'Personnel1', 'JobGrade');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Employment',ItemName = 'Job grade',TableName = 'Personnel1',FieldName = 'JobGrade' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'JobGrade');
END

/**************************** ess.PolicyMapping - 'CostCentre' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'CostCentre'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'CostCentre'), 'Organisational', 'Employment', 'Cost centre', 'Personnel1', 'CostCentre');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Employment',ItemName = 'Cost centre',TableName = 'Personnel1',FieldName = 'CostCentre' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'CostCentre');
END

/**************************** ess.PolicyMapping - 'CostCentreAlloc' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'CostCentreAlloc'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'CostCentreAlloc'), 'Organisational', 'Employment', 'Cost Centre Allocation', 'Personnel1', 'CostCentreAlloc');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Employment',ItemName = 'Cost Centre Allocation',TableName = 'Personnel1',FieldName = 'CostCentreAlloc' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'CostCentreAlloc');
END

/**************************** ess.PolicyMapping - 'Skill_Level' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Skill_Level'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Skill_Level'), 'Organisational', 'Employment', 'Occupational category', 'Personnel1', 'Skill_Level');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Employment',ItemName = 'Occupational category',TableName = 'Personnel1',FieldName = 'Skill_Level' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Skill_Level');
END

/**************************** ess.PolicyMapping - 'Appointype' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Appointype'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Appointype'), 'Organisational', 'Employment', 'Appointment type', 'Personnel1', 'Appointype');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Employment',ItemName = 'Appointment type',TableName = 'Personnel1',FieldName = 'Appointype' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Appointype');
END

/**************************** ess.PolicyMapping - 'DateJoinedGroup' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'DateJoinedGroup'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'DateJoinedGroup'), 'Organisational', 'Employment', 'Date joined group', 'Personnel1', 'DateJoinedGroup');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Employment',ItemName = 'Date joined group',TableName = 'Personnel1',FieldName = 'DateJoinedGroup' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'DateJoinedGroup');
END

/**************************** ess.PolicyMapping - 'Appointdate' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Appointdate'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Appointdate'), 'Organisational', 'Employment', 'Appointment date', 'Personnel1', 'Appointdate');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Employment',ItemName = 'Appointment date',TableName = 'Personnel1',FieldName = 'Appointdate' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Appointdate');
END

/**************************** ess.PolicyMapping - 'YearsServiceG' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'YearsServiceG'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'YearsServiceG'), 'Organisational', 'Employment', 'Years of service (group)', 'Personnel1', 'YearsServiceG');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Employment',ItemName = 'Years of service (group)',TableName = 'Personnel1',FieldName = 'YearsServiceG' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'YearsServiceG');
END

/**************************** ess.PolicyMapping - 'YearsServiceA' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'YearsServiceA'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'YearsServiceA'), 'Organisational', 'Employment', 'Years of service (appointment)', 'Personnel1', 'YearsServiceA');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Employment',ItemName = 'Years of service (appointment)',TableName = 'Personnel1',FieldName = 'YearsServiceA' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'YearsServiceA');
END

/**************************** ess.PolicyMapping - 'ReportsTo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ReportsTo'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ReportsTo'), 'Organisational', 'Reports To', 'Reports to', '', 'ReportsTo');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Reports To',ItemName = 'Reports to',TableName = '',FieldName = 'ReportsTo' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ReportsTo');
END

/**************************** ess.PolicyMapping - 'BalanceGrid' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'BalanceGrid'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'BalanceGrid'), '', '', 'BalanceGrid', '', 'BalanceGrid');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'BalanceGrid',TableName = '',FieldName = 'BalanceGrid' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'BalanceGrid');
END

/**************************** ess.PolicyMapping - 'BalanceGridColumns' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'BalanceGridColumns'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'BalanceGridColumns'), '', '', 'BalanceGridColumns', '', 'BalanceGridColumns');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'BalanceGridColumns',TableName = '',FieldName = 'BalanceGridColumns' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'BalanceGridColumns');
END

/**************************** ess.PolicyMapping - 'Default' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Default'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Default'), '', '', 'Default', '', 'Default');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'Default',TableName = '',FieldName = 'Default' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Default');
END

/**************************** ess.PolicyMapping - 'Negative' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Negative'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Negative'), '', '', 'Negative', '', 'Negative');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'Negative',TableName = '',FieldName = 'Negative' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Negative');
END

/**************************** ess.PolicyMapping - 'ShiftTypes' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ShiftTypes'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShiftTypes'), '', '', 'ShiftTypes', '', 'ShiftTypes');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ShiftTypes',TableName = '',FieldName = 'ShiftTypes' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShiftTypes');
END

/**************************** ess.PolicyMapping - 'ShiftLeaveTypes' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ShiftLeaveTypes'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShiftLeaveTypes'), '', '', 'ShiftLeaveTypes', '', 'ShiftLeaveTypes');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ShiftLeaveTypes',TableName = '',FieldName = 'ShiftLeaveTypes' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShiftLeaveTypes');
END

/**************************** ess.PolicyMapping - 'FridayRule' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'FridayRule'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'FridayRule'), '', '', 'FridayRule', '', 'FridayRule');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'FridayRule',TableName = '',FieldName = 'FridayRule' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'FridayRule');
END

/**************************** ess.PolicyMapping - 'SaturdayRule' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SaturdayRule'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SaturdayRule'), '', '', 'SaturdayRule', '', 'SaturdayRule');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'SaturdayRule',TableName = '',FieldName = 'SaturdayRule' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SaturdayRule');
END

/**************************** ess.PolicyMapping - 'LeaveBlock' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'LeaveBlock'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'LeaveBlock'), '', '', 'LeaveBlock', '', 'LeaveBlock');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'LeaveBlock',TableName = '',FieldName = 'LeaveBlock' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'LeaveBlock');
END

/**************************** ess.PolicyMapping - 'DeleteCancel' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'DeleteCancel'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'DeleteCancel'), '', '', 'DeleteCancel', '', 'DeleteCancel');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'DeleteCancel',TableName = '',FieldName = 'DeleteCancel' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'DeleteCancel');
END

/**************************** ess.PolicyMapping - 'ForceComments' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ForceComments'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ForceComments'), '', '', 'ForceComments', '', 'ForceComments');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ForceComments',TableName = '',FieldName = 'ForceComments' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ForceComments');
END

/**************************** ess.PolicyMapping - 'StaffOnLeave' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'StaffOnLeave'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'StaffOnLeave'), '', '', 'StaffOnLeave', '', 'StaffOnLeave');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'StaffOnLeave',TableName = '',FieldName = 'StaffOnLeave' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'StaffOnLeave');
END

/**************************** ess.PolicyMapping - 'IgnoreBalance' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'IgnoreBalance'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'IgnoreBalance'), '', '', 'IgnoreBalance', '', 'IgnoreBalance');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'IgnoreBalance',TableName = '',FieldName = 'IgnoreBalance' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'IgnoreBalance');
END

/**************************** ess.PolicyMapping - 'FinancialYear' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'FinancialYear'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'FinancialYear'), '', '', 'FinancialYear', '', 'FinancialYear');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'FinancialYear',TableName = '',FieldName = 'FinancialYear' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'FinancialYear');
END

/**************************** ess.PolicyMapping - 'FinancialTotal' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'FinancialTotal'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'FinancialTotal'), '', '', 'FinancialTotal', '', 'FinancialTotal');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'FinancialTotal',TableName = '',FieldName = 'FinancialTotal' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'FinancialTotal');
END

/**************************** ess.PolicyMapping - 'Consecutive' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Consecutive'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Consecutive'), '', '', 'Consecutive', '', 'Consecutive');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'Consecutive',TableName = '',FieldName = 'Consecutive' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Consecutive');
END

/**************************** ess.PolicyMapping - 'ConsecutiveMax' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ConsecutiveMax'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ConsecutiveMax'), '', '', 'ConsecutiveMax', '', 'ConsecutiveMax');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ConsecutiveMax',TableName = '',FieldName = 'ConsecutiveMax' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ConsecutiveMax');
END

/**************************** ess.PolicyMapping - 'ForceDocument' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ForceDocument'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ForceDocument'), '', '', 'ForceDocument', '', 'ForceDocument');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ForceDocument',TableName = '',FieldName = 'ForceDocument' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ForceDocument');
END

/**************************** ess.PolicyMapping - 'ForceDocumentMax' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ForceDocumentMax'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ForceDocumentMax'), '', '', 'ForceDocumentMax', '', 'ForceDocumentMax');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ForceDocumentMax',TableName = '',FieldName = 'ForceDocumentMax' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ForceDocumentMax');
END

/**************************** ess.PolicyMapping - 'ForceDocumentMaxValue' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ForceDocumentMaxValue'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ForceDocumentMaxValue'), '', '', 'ForceDocumentMaxValue', '', 'ForceDocumentMaxValue');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ForceDocumentMaxValue',TableName = '',FieldName = 'ForceDocumentMaxValue' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ForceDocumentMaxValue');
END

/**************************** ess.PolicyMapping - 'ForceDocumentDuration' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ForceDocumentDuration'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ForceDocumentDuration'), '', '', 'ForceDocumentDuration', '', 'ForceDocumentDuration');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ForceDocumentDuration',TableName = '',FieldName = 'ForceDocumentDuration' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ForceDocumentDuration');
END

/**************************** ess.PolicyMapping - 'ForceDocumentDurationValue' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ForceDocumentDurationValue'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ForceDocumentDurationValue'), '', '', 'ForceDocumentDurationValu', '', 'ForceDocumentDurationValue');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ForceDocumentDurationValu',TableName = '',FieldName = 'ForceDocumentDurationValue' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ForceDocumentDurationValue');
END

/**************************** ess.PolicyMapping - 'ForceDocumentWeekend' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ForceDocumentWeekend'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ForceDocumentWeekend'), '', '', 'ForceDocumentWeekend', '', 'ForceDocumentWeekend');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ForceDocumentWeekend',TableName = '',FieldName = 'ForceDocumentWeekend' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ForceDocumentWeekend');
END

/**************************** ess.PolicyMapping - 'DisallowWeekend' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'DisallowWeekend'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'DisallowWeekend'), '', '', 'DisallowWeekend', '', 'DisallowWeekend');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'DisallowWeekend',TableName = '',FieldName = 'DisallowWeekend' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'DisallowWeekend');
END

/**************************** ess.PolicyMapping - 'ShowSearch' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ShowSearch'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShowSearch'), '', '', 'ShowSearch', '', 'ShowSearch');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ShowSearch',TableName = '',FieldName = 'ShowSearch' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShowSearch');
END

/**************************** ess.PolicyMapping - 'ShowEmail' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ShowEmail'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShowEmail'), '', '', 'ShowEmail', '', 'ShowEmail');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ShowEmail',TableName = '',FieldName = 'ShowEmail' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShowEmail');
END

/**************************** ess.PolicyMapping - 'ShowSMS' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ShowSMS'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShowSMS'), '', '', 'ShowSMS', '', 'ShowSMS');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ShowSMS',TableName = '',FieldName = 'ShowSMS' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShowSMS');
END

/**************************** ess.PolicyMapping - 'LeaveHistory' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'LeaveHistory'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'LeaveHistory'), '', '', 'LeaveHistory', '', 'LeaveHistory');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'LeaveHistory',TableName = '',FieldName = 'LeaveHistory' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'LeaveHistory');
END

/**************************** ess.PolicyMapping - 'QuarterDay' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'QuarterDay'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'QuarterDay'), '', '', 'QuarterDay', '', 'QuarterDay');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'QuarterDay',TableName = '',FieldName = 'QuarterDay' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'QuarterDay');
END

/**************************** ess.PolicyMapping - 'StaffOnTraining' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'StaffOnTraining'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'StaffOnTraining'), '', '', 'StaffOnTraining', '', 'StaffOnTraining');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'StaffOnTraining',TableName = '',FieldName = 'StaffOnTraining' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'StaffOnTraining');
END

/**************************** ess.PolicyMapping - 'AddrUnit' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'AddrUnit'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrUnit'), 'Personal', 'Address & Telephone', 'Complex Unit No.', 'Personnel', 'AddrUnit');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Complex Unit No.',TableName = 'Personnel',FieldName = 'AddrUnit' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrUnit');
END

/**************************** ess.PolicyMapping - 'AddrComplex' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'AddrComplex'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrComplex'), 'Personal', 'Address & Telephone', 'Complex Name', 'Personnel', 'AddrComplex');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Complex Name',TableName = 'Personnel',FieldName = 'AddrComplex' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrComplex');
END

/**************************** ess.PolicyMapping - 'AddrStreetNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'AddrStreetNo'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrStreetNo'), 'Personal', 'Address & Telephone', 'Address line 3 (long)', 'Personnel', 'AddrStreetNo');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Address line 3 (long)',TableName = 'Personnel',FieldName = 'AddrStreetNo' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrStreetNo');
END

/**************************** ess.PolicyMapping - 'AddrStreetName' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'AddrStreetName'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrStreetName'), 'Personal', 'Address & Telephone', 'Address line 4 (long)', 'Personnel', 'AddrStreetName');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Address line 4 (long)',TableName = 'Personnel',FieldName = 'AddrStreetName' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrStreetName');
END

/**************************** ess.PolicyMapping - 'AddrSuburb' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'AddrSuburb'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrSuburb'), 'Personal', 'Address & Telephone', 'Address line 5 (long)', 'Personnel', 'AddrSuburb');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Address line 5 (long)',TableName = 'Personnel',FieldName = 'AddrSuburb' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrSuburb');
END

/**************************** ess.PolicyMapping - 'AddrCity' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'AddrCity'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrCity'), 'Personal', 'Address & Telephone', 'Address line 6 (long)', 'Personnel', 'AddrCity');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Address line 6 (long)',TableName = 'Personnel',FieldName = 'AddrCity' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrCity');
END

/**************************** ess.PolicyMapping - 'AddrZip' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'AddrZip'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrZip'), 'Personal', 'Address & Telephone', 'Address line 7 (long)', 'Personnel', 'AddrZip');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Address line 7 (long)',TableName = 'Personnel',FieldName = 'AddrZip' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrZip');
END

/**************************** ess.PolicyMapping - 'FaxNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'FaxNo'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'FaxNo'), 'Personal', 'Address & Telephone', 'Fax No.', 'Personnel', 'FaxNo');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Fax No.',TableName = 'Personnel',FieldName = 'FaxNo' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'FaxNo');
END

/**************************** ess.PolicyMapping - 'EmailAddress1' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'EmailAddress1'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'EmailAddress1'), 'Personal', 'Address & Telephone', 'Personal Email Address', 'Personnel', 'EmailAddress1');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Personal Email Address',TableName = 'Personnel',FieldName = 'EmailAddress1' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'EmailAddress1');
END

/**************************** ess.PolicyMapping - 'Latitude' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Latitude'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Latitude'), 'Personal', 'Address & Telephone', 'Latitude', 'Personnel', 'Latitude');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Latitude',TableName = 'Personnel',FieldName = 'Latitude' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Latitude');
END

/**************************** ess.PolicyMapping - 'Longitude' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Longitude'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Longitude'), 'Personal', 'Address & Telephone', 'Longitude', 'Personnel', 'Longitude');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Longitude',TableName = 'Personnel',FieldName = 'Longitude' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Longitude');
END

/**************************** ess.PolicyMapping - 'DisableAutoSave' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'DisableAutoSave'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'DisableAutoSave'), '', '', 'DisableAutoSave', '', 'DisableAutoSave');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'DisableAutoSave',TableName = '',FieldName = 'DisableAutoSave' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'DisableAutoSave');
END

/**************************** ess.PolicyMapping - 'ShowTerminated' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ShowTerminated'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShowTerminated'), '', '', 'ShowTerminated', '', 'ShowTerminated');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ShowTerminated',TableName = '',FieldName = 'ShowTerminated' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShowTerminated');
END

/**************************** ess.PolicyMapping - 'EvaluationsConfig' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'EvaluationsConfig'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'EvaluationsConfig'), '', '', 'EvaluationsConfig', '', 'EvaluationsConfig');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'EvaluationsConfig',TableName = '',FieldName = 'EvaluationsConfig' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'EvaluationsConfig');
END

/**************************** ess.PolicyMapping - 'EvaluationResults' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'EvaluationResults'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'EvaluationResults'), '', '', 'EvaluationResults', '', 'EvaluationResults');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'EvaluationResults',TableName = '',FieldName = 'EvaluationResults' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'EvaluationResults');
END

/**************************** ess.PolicyMapping - 'LeaveResults' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'LeaveResults'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'LeaveResults'), '', '', 'LeaveResults', '', 'LeaveResults');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'LeaveResults',TableName = '',FieldName = 'LeaveResults' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'LeaveResults');
END

/**************************** ess.PolicyMapping - 'TaskResults' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'TaskResults'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'TaskResults'), '', '', 'TaskResults', '', 'TaskResults');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'TaskResults',TableName = '',FieldName = 'TaskResults' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'TaskResults');
END

/**************************** ess.PolicyMapping - 'TimesheetsConfig' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'TimesheetsConfig'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'TimesheetsConfig'), '', '', 'TimesheetsConfig', '', 'TimesheetsConfig');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'TimesheetsConfig',TableName = '',FieldName = 'TimesheetsConfig' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'TimesheetsConfig');
END

/**************************** ess.PolicyMapping - 'ClaimsConfig' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ClaimsConfig'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ClaimsConfig'), '', '', 'ClaimsConfig', '', 'ClaimsConfig');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ClaimsConfig',TableName = '',FieldName = 'ClaimsConfig' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ClaimsConfig');
END

/**************************** ess.PolicyMapping - 'KeyAreas' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'KeyAreas'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'KeyAreas'), '', '', 'KeyAreas', '', 'KeyAreas');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'KeyAreas',TableName = '',FieldName = 'KeyAreas' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'KeyAreas');
END

/**************************** ess.PolicyMapping - 'KeyElements' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'KeyElements'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'KeyElements'), '', '', 'KeyElements', '', 'KeyElements');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'KeyElements',TableName = '',FieldName = 'KeyElements' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'KeyElements');
END

/**************************** ess.PolicyMapping - 'ShowCreate' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ShowCreate'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShowCreate'), '', '', 'ShowCreate', '', 'ShowCreate');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ShowCreate',TableName = '',FieldName = 'ShowCreate' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShowCreate');
END

/**************************** ess.PolicyMapping - 'AdjustmentTypes' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'AdjustmentTypes'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'AdjustmentTypes'), '', '', 'AdjustmentTypes', '', 'AdjustmentTypes');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'AdjustmentTypes',TableName = '',FieldName = 'AdjustmentTypes' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'AdjustmentTypes');
END

/**************************** ess.PolicyMapping - 'AllowPicUpload' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'AllowPicUpload'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'AllowPicUpload'), '', '', 'AllowPicUpload', '', 'AllowPicUpload');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'AllowPicUpload',TableName = '',FieldName = 'AllowPicUpload' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'AllowPicUpload');
END

/**************************** ess.PolicyMapping - 'ShowContacts' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ShowContacts'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShowContacts'), '', '', 'ShowContacts', '', 'ShowContacts');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ShowContacts',TableName = '',FieldName = 'ShowContacts' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShowContacts');
END

/**************************** ess.PolicyMapping - 'ShowDelete' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ShowDelete'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShowDelete'), '', '', 'ShowDelete', '', 'ShowDelete');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ShowDelete',TableName = '',FieldName = 'ShowDelete' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShowDelete');
END

/**************************** ess.PolicyMapping - 'ShowTransfer' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ShowTransfer'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShowTransfer'), '', '', 'ShowTransfer', '', 'ShowTransfer');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ShowTransfer',TableName = '',FieldName = 'ShowTransfer' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShowTransfer');
END

/**************************** ess.PolicyMapping - 'LeaveResultType1' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'LeaveResultType1'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'LeaveResultType1'), '', '', 'LeaveResultType1', '', 'LeaveResultType1');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'LeaveResultType1',TableName = '',FieldName = 'LeaveResultType1' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'LeaveResultType1');
END

/**************************** ess.PolicyMapping - 'LeaveResultType2' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'LeaveResultType2'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'LeaveResultType2'), '', '', 'LeaveResultType2', '', 'LeaveResultType2');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'LeaveResultType2',TableName = '',FieldName = 'LeaveResultType2' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'LeaveResultType2');
END

/**************************** ess.PolicyMapping - 'LeaveFuture' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'LeaveFuture'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'LeaveFuture'), '', '', 'LeaveFuture', '', 'LeaveFuture');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'LeaveFuture',TableName = '',FieldName = 'LeaveFuture' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'LeaveFuture');
END

/**************************** ess.PolicyMapping - 'ForceDocumentPublic' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ForceDocumentPublic'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ForceDocumentPublic'), '', '', 'ForceDocumentPublic', '', 'ForceDocumentPublic');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'ForceDocumentPublic',TableName = '',FieldName = 'ForceDocumentPublic' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ForceDocumentPublic');
END

/**************************** ess.PolicyMapping - 'DisallowPublic' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'DisallowPublic'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'DisallowPublic'), '', '', 'DisallowPublic', '', 'DisallowPublic');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'DisallowPublic',TableName = '',FieldName = 'DisallowPublic' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'DisallowPublic');
END

/**************************** ess.PolicyMapping - 'LeaveInverse' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'LeaveInverse'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'LeaveInverse'), '', '', 'LeaveInverse', '', 'LeaveInverse');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'LeaveInverse',TableName = '',FieldName = 'LeaveInverse' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'LeaveInverse');
END

/**************************** ess.PolicyMapping - 'Category' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Category'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Category'), 'Organisational', 'Employment', 'Category', 'Personnel1', 'Category');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Employment',ItemName = 'Category',TableName = 'Personnel1',FieldName = 'Category' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Category');
END

/**************************** ess.PolicyMapping - 'PayLevel' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'PayLevel'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'PayLevel'), 'Organisational', 'Employment', 'Pay Level', 'Personnel1', 'PayLevel');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Employment',ItemName = 'Pay Level',TableName = 'Personnel1',FieldName = 'PayLevel' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'PayLevel');
END

/**************************** ess.PolicyMapping - 'Shifting' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Shifting'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Shifting'), 'Organisational', 'Employment', 'Shifting', 'Personnel1', 'Shifting');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Employment',ItemName = 'Shifting',TableName = 'Personnel1',FieldName = 'Shifting' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Shifting');
END

/**************************** ess.PolicyMapping - 'WorkAssignment' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'WorkAssignment'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'WorkAssignment'), 'Organisational', 'Employment', 'Work Assignment', 'Personnel1', 'WorkAssignment');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Employment',ItemName = 'Work Assignment',TableName = 'Personnel1',FieldName = 'WorkAssignment' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'WorkAssignment');
END

/**************************** ess.PolicyMapping - 'UnionAffiliation' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'UnionAffiliation'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'UnionAffiliation'), 'Organisational', 'Employment', 'Union Affiliation', 'Personnel1', 'UnionAffiliation');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Employment',ItemName = 'Union Affiliation',TableName = 'Personnel1',FieldName = 'UnionAffiliation' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'UnionAffiliation');
END

/**************************** ess.PolicyMapping - 'ShirtSize' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ShirtSize'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShirtSize'), 'Organisational', 'Uniform Allocation', 'Shirt Size', 'Personnel1', 'ShirtSize');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Uniform Allocation',ItemName = 'Shirt Size',TableName = 'Personnel1',FieldName = 'ShirtSize' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShirtSize');
END

/**************************** ess.PolicyMapping - 'Blazer' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Blazer'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Blazer'), 'Organisational', 'Uniform Allocation', 'Blazer', 'Personnel1', 'Blazer');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Uniform Allocation',ItemName = 'Blazer',TableName = 'Personnel1',FieldName = 'Blazer' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Blazer');
END

/**************************** ess.PolicyMapping - 'Skirt' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Skirt'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Skirt'), 'Organisational', 'Uniform Allocation', 'Skirt', 'Personnel1', 'Skirt');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Uniform Allocation',ItemName = 'Skirt',TableName = 'Personnel1',FieldName = 'Skirt' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Skirt');
END

/**************************** ess.PolicyMapping - 'Blouse' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Blouse'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Blouse'), 'Organisational', 'Uniform Allocation', 'Blouse', 'Personnel1', 'Blouse');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Uniform Allocation',ItemName = 'Blouse',TableName = 'Personnel1',FieldName = 'Blouse' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Blouse');
END

/**************************** ess.PolicyMapping - 'Slacks' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Slacks'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Slacks'), 'Organisational', 'Uniform Allocation', 'Slacks', 'Personnel1', 'Slacks');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Uniform Allocation',ItemName = 'Slacks',TableName = 'Personnel1',FieldName = 'Slacks' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Slacks');
END

/**************************** ess.PolicyMapping - 'Shirtjack' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Shirtjack'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Shirtjack'), 'Organisational', 'Uniform Allocation', 'Shirtjack', 'Personnel1', 'Shirtjack');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Uniform Allocation',ItemName = 'Shirtjack',TableName = 'Personnel1',FieldName = 'Shirtjack' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Shirtjack');
END

/**************************** ess.PolicyMapping - 'ShirtjackPants' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ShirtjackPants'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShirtjackPants'), 'Organisational', 'Uniform Allocation', 'Shirtjack Pants', 'Personnel1', 'ShirtjackPants');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Uniform Allocation',ItemName = 'Shirtjack Pants',TableName = 'Personnel1',FieldName = 'ShirtjackPants' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShirtjackPants');
END

/**************************** ess.PolicyMapping - 'PoloBarong' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'PoloBarong'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'PoloBarong'), 'Organisational', 'Uniform Allocation', 'Polo/Barong', 'Personnel1', 'PoloBarong');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Uniform Allocation',ItemName = 'Polo/Barong',TableName = 'Personnel1',FieldName = 'PoloBarong' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'PoloBarong');
END

/**************************** ess.PolicyMapping - 'RepellantPants' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'RepellantPants'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'RepellantPants'), 'Organisational', 'Uniform Allocation', 'Repellant Pants', 'Personnel1', 'RepellantPants');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Uniform Allocation',ItemName = 'Repellant Pants',TableName = 'Personnel1',FieldName = 'RepellantPants' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'RepellantPants');
END

/**************************** ess.PolicyMapping - 'PoloShirt' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'PoloShirt'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'PoloShirt'), 'Organisational', 'Uniform Allocation', 'Polo Shirt', 'Personnel1', 'PoloShirt');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Uniform Allocation',ItemName = 'Polo Shirt',TableName = 'Personnel1',FieldName = 'PoloShirt' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'PoloShirt');
END

/**************************** ess.PolicyMapping - 'MaongPants' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'MaongPants'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'MaongPants'), 'Organisational', 'Uniform Allocation', 'Maong Pants', 'Personnel1', 'MaongPants');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Uniform Allocation',ItemName = 'Maong Pants',TableName = 'Personnel1',FieldName = 'MaongPants' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'MaongPants');
END

/**************************** ess.PolicyMapping - 'TShirt' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'TShirt'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'TShirt'), 'Organisational', 'Uniform Allocation', 'T-Shirt', 'Personnel1', 'TShirt');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Uniform Allocation',ItemName = 'T-Shirt',TableName = 'Personnel1',FieldName = 'TShirt' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'TShirt');
END

/**************************** ess.PolicyMapping - 'Overalls' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Overalls'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Overalls'), 'Organisational', 'Uniform Allocation', 'Overalls', 'Personnel1', 'Overalls');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Uniform Allocation',ItemName = 'Overalls',TableName = 'Personnel1',FieldName = 'Overalls' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Overalls');
END

/**************************** ess.PolicyMapping - 'NOK_Surname' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'NOK_Surname'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_Surname'), 'Personal', 'Contact Person In Case of Emergency', 'Emergency Contact Last Name', 'Personnel', 'NOK_Surname');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Contact Person In Case of Emergency',ItemName = 'Emergency Contact Last Name',TableName = 'Personnel',FieldName = 'NOK_Surname' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_Surname');
END

/**************************** ess.PolicyMapping - 'NOK_FirstName' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'NOK_FirstName'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_FirstName'), 'Personal', 'Contact Person In Case of Emergency', 'Emergency Contact First Name', 'Personnel', 'NOK_FirstName');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Contact Person In Case of Emergency',ItemName = 'Emergency Contact First Name',TableName = 'Personnel',FieldName = 'NOK_FirstName' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_FirstName');
END

/**************************** ess.PolicyMapping - 'NOK_MiddleName' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'NOK_MiddleName'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_MiddleName'), 'Personal', 'Contact Person In Case of Emergency', 'Emergency Contact Middle Name', 'Personnel', 'NOK_MiddleName');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Contact Person In Case of Emergency',ItemName = 'Emergency Contact Middle Name',TableName = 'Personnel',FieldName = 'NOK_MiddleName' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_MiddleName');
END

/**************************** ess.PolicyMapping - 'NOK_Age' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'NOK_Age'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_Age'), 'Personal', 'Contact Person In Case of Emergency', 'Emergency Contact Age', 'Personnel', 'NOK_Age');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Contact Person In Case of Emergency',ItemName = 'Emergency Contact Age',TableName = 'Personnel',FieldName = 'NOK_Age' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_Age');
END

/**************************** ess.PolicyMapping - 'NOK_ERAddress' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'NOK_ERAddress'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_ERAddress'), 'Personal', 'Contact Person In Case of Emergency', 'Emergency Contact Address', 'Personnel', 'NOK_ERAddress');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Contact Person In Case of Emergency',ItemName = 'Emergency Contact Address',TableName = 'Personnel',FieldName = 'NOK_ERAddress' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_ERAddress');
END

/**************************** ess.PolicyMapping - 'NOK_ContactNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'NOK_ContactNo'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_ContactNo'), 'Personal', 'Contact Person In Case of Emergency', 'Emergency Contact Contact Information', 'Personnel', 'NOK_ContactNo');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Contact Person In Case of Emergency',ItemName = 'Emergency Contact Contact Information',TableName = 'Personnel',FieldName = 'NOK_ContactNo' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_ContactNo');
END

/**************************** ess.PolicyMapping - 'NOK_Occupation' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'NOK_Occupation'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_Occupation'), 'Personal', 'Contact Person In Case of Emergency', 'Emergency Contact Occupation', 'Personnel', 'NOK_Occupation');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Contact Person In Case of Emergency',ItemName = 'Emergency Contact Occupation',TableName = 'Personnel',FieldName = 'NOK_Occupation' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_Occupation');
END

/**************************** ess.PolicyMapping - 'NOK_Employer' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'NOK_Employer'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_Employer'), 'Personal', 'Contact Person In Case of Emergency', 'Emergency Contact Employer', 'Personnel', 'NOK_Employer');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Contact Person In Case of Emergency',ItemName = 'Emergency Contact Employer',TableName = 'Personnel',FieldName = 'NOK_Employer' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_Employer');
END

/**************************** ess.PolicyMapping - 'NOK_Gender' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'NOK_Gender'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_Gender'), 'Personal', 'Contact Person In Case of Emergency', 'Emergency Contact Gender', 'Personnel', 'NOK_Gender');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Contact Person In Case of Emergency',ItemName = 'Emergency Contact Gender',TableName = 'Personnel',FieldName = 'NOK_Gender' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_Gender');
END

/**************************** ess.PolicyMapping - 'NOK_Relationship' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'NOK_Relationship'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_Relationship'), 'Personal', 'Contact Person In Case of Emergency', 'Emergency Contact Relationship', 'Personnel', 'NOK_Relationship');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Contact Person In Case of Emergency',ItemName = 'Emergency Contact Relationship',TableName = 'Personnel',FieldName = 'NOK_Relationship' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_Relationship');
END

/**************************** ess.PolicyMapping - 'NOK_DateOfBirth' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'NOK_DateOfBirth'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_DateOfBirth'), 'Personal', 'Contact Person In Case of Emergency', 'Emergency Contact Birthdate', 'Personnel', 'NOK_DateOfBirth');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Contact Person In Case of Emergency',ItemName = 'Emergency Contact Birthdate',TableName = 'Personnel',FieldName = 'NOK_DateOfBirth' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'NOK_DateOfBirth');
END

/**************************** ess.PolicyMapping - 'Initials' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Initials'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Initials'), 'Personal', 'Personal', 'Suffix', 'Personnel', 'Initials');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Suffix',TableName = 'Personnel',FieldName = 'Initials' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Initials');
END

/**************************** ess.PolicyMapping - 'MaidenName' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'MaidenName'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'MaidenName'), 'Personal', 'Personal', 'Mother Maiden Name', 'Personnel', 'MaidenName');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Mother Maiden Name',TableName = 'Personnel',FieldName = 'MaidenName' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'MaidenName');
END

/**************************** ess.PolicyMapping - 'MiddleName' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'MiddleName'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'MiddleName'), 'Personal', 'Personal', 'Middle Name', 'Personnel', 'MiddleName');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Middle Name',TableName = 'Personnel',FieldName = 'MiddleName' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'MiddleName');
END

/**************************** ess.PolicyMapping - 'Age' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Age'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Age'), 'Personal', 'Personal', 'Age', '', 'Age');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Age', TableName = '',FieldName = 'Age' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Age');
END

/**************************** ess.PolicyMapping - 'ZodiacSignActual' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ZodiacSignActual'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ZodiacSignActual'), 'Personal', 'Personal', 'Zodiac Sign', 'Personnel', 'ZodiacSignActual');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Zodiac Sign',TableName = 'Personnel',FieldName = 'ZodiacSignActual' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ZodiacSignActual');
END

/**************************** ess.PolicyMapping - 'SpouseMiddleName' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SpouseMiddleName'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseMiddleName'), 'Personal', 'Family Background', 'Spouse Middle Name', 'Personnel', 'SpouseMiddleName');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Family Background',ItemName = 'Spouse Middle Name',TableName = 'Personnel',FieldName = 'SpouseMiddleName' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseMiddleName');
END

/**************************** ess.PolicyMapping - 'BIRMembershipNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'BIRMembershipNo'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'BIRMembershipNo'), 'Personal', 'Personal', 'TIN No.', 'Personnel', 'BIRMembershipNo');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'TIN No.',TableName = 'Personnel',FieldName = 'BIRMembershipNo' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'BIRMembershipNo');
END

/**************************** ess.PolicyMapping - 'SSSMembershipNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SSSMembershipNo'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SSSMembershipNo'), 'Personal', 'Personal', 'SSS Membership No.', 'Personnel', 'SSSMembershipNo');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'SSS Membership No.',TableName = 'Personnel',FieldName = 'SSSMembershipNo' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SSSMembershipNo');
END

/**************************** ess.PolicyMapping - 'PAGIBIGMembershipNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'PAGIBIGMembershipNo'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'PAGIBIGMembershipNo'), 'Personal', 'Personal', 'Pag-Ibig Membership No.', 'Personnel', 'PAGIBIGMembershipNo');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Pag-Ibig Membership No.',TableName = 'Personnel',FieldName = 'PAGIBIGMembershipNo' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'PAGIBIGMembershipNo');
END

/**************************** ess.PolicyMapping - 'PHILMemNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'PHILMemNo'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'PHILMemNo'), 'Personal', 'Personal', 'Phil-Health Membership No.', 'Personnel', 'PHILMemNo');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Phil-Health Membership No.',TableName = 'Personnel',FieldName = 'PHILMemNo' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'PHILMemNo');
END

/**************************** ess.PolicyMapping - 'PersonnelMovement' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'PersonnelMovement'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'PersonnelMovement'), 'Organisational', 'Personnel Movement', 'PersonnelMovement', '', 'PersonnelMovement');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Personnel Movement',ItemName = 'PersonnelMovement',TableName = '',FieldName = 'PersonnelMovement' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'PersonnelMovement');
END

/**************************** ess.PolicyMapping - 'AdminRestriction' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'AdminRestriction'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'AdminRestriction'), '', '', 'AdminRestriction', '', 'AdminRestriction');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = '',TabName = '',ItemName = 'AdminRestriction',TableName = '',FieldName = 'AdminRestriction' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'AdminRestriction');
END

/**************************** ess.PolicyMapping - 'SpouseAge' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SpouseAge'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseAge'), 'Personal', 'Family Background', 'Spouse Age', 'Personnel', 'SpouseAge');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Family Background',ItemName = 'Spouse Age',TableName = 'Personnel',FieldName = 'SpouseAge' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseAge');
END

/**************************** ess.PolicyMapping - 'SpouseOccu' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SpouseOccu'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseOccu'), 'Personal', 'Family Background', 'Spouse Occupation', 'Personnel', 'SpouseOccu');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Family Background',ItemName = 'Spouse Occupation',TableName = 'Personnel',FieldName = 'SpouseOccu' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseOccu');
END

/**************************** ess.PolicyMapping - 'SpouseEmployer' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SpouseEmployer'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseEmployer'), 'Personal', 'Family Background', 'Spouse Employer', 'Personnel', 'SpouseEmployer');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Family Background',ItemName = 'Spouse Employer',TableName = 'Personnel',FieldName = 'SpouseEmployer' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseEmployer');
END

/**************************** ess.PolicyMapping - 'SpouseEmployerAdd' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SpouseEmployerAdd'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseEmployerAdd'), 'Personal', 'Family Background', 'Spouse Employer Address', 'Personnel', 'SpouseEmployerAdd');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Family Background',ItemName = 'Spouse Employer Address',TableName = 'Personnel',FieldName = 'SpouseEmployerAdd' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseEmployerAdd');
END

/**************************** ess.PolicyMapping - 'Certifications' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Certifications'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Certifications'), 'Curriculum Vitae', 'Licensures/Certifications', 'Certifications', '', 'Certifications');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Curriculum Vitae',TabName = 'Licensures/Certifications',ItemName = 'Certifications',TableName = '',FieldName = 'Certifications' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Certifications');
END

/**************************** ess.PolicyMapping - 'Seminars' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Seminars'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Seminars'), 'Curriculum Vitae', 'Educational Background', 'Seminars', '', 'Seminars');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Curriculum Vitae',TabName = 'Educational Background',ItemName = 'Seminars',TableName = '',FieldName = 'Seminars' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Seminars');
END

/**************************** ess.PolicyMapping - 'ShuttleRoute' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ShuttleRoute'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShuttleRoute'), 'Personal', 'Personal', 'ShuttleRoute', 'Personnel', 'ShuttleRoute');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'ShuttleRoute',TableName = 'Personnel',FieldName = 'ShuttleRoute' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ShuttleRoute');
END

/**************************** ess.PolicyMapping - 'Region' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Region'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Region'), 'Personal', 'Address & Telephone', 'Region', 'Personnel', 'Region');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Region',TableName = 'Personnel',FieldName = 'Region' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Region');
END

/**************************** ess.PolicyMapping - 'OnTheJobTraining' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'OnTheJobTraining'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'OnTheJobTraining'), 'Curriculum Vitae', 'Employment History', 'OnTheJobTraining', '', 'OnTheJobTraining');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Curriculum Vitae',TabName = 'Employment History',ItemName = 'OnTheJobTraining',TableName = '',FieldName = 'OnTheJobTraining' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'OnTheJobTraining');
END

/**************************** ess.PolicyMapping - 'Attributes' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Attributes'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Attributes'), 'Personal', 'Personal', 'Attributes', 'PersonnelAttribute', 'Attributes');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Attributes',TableName = 'PersonnelAttribute',FieldName = 'Attributes' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Attributes');
END

/**************************** ess.PolicyMapping - 'RecInterestHob' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'RecInterestHob'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'RecInterestHob'), 'Personal', 'Personal', 'RecInterestHob', 'Personnel', 'RecInterestHob');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'RecInterestHob',TableName = 'Personnel',FieldName = 'RecInterestHob' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'RecInterestHob');
END

/**************************** ess.PolicyMapping - 'AddrRegion' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'AddrRegion'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrRegion'), 'Personal', 'Address & Telephone', 'AddrRegion', 'Personnel', 'AddrRegion');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'AddrRegion',TableName = 'Personnel',FieldName = 'AddrRegion' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrRegion');
END

/**************************** ess.PolicyMapping - 'EmploymentHistory' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'EmploymentHistory'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'EmploymentHistory'), 'Curriculum Vitae', 'Employment History', 'EmploymentHistory', '', 'EmploymentHistory');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Curriculum Vitae',TabName = 'Employment History',ItemName = 'EmploymentHistory',TableName = '',FieldName = 'EmploymentHistory' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'EmploymentHistory');
END

/**************************** ess.PolicyMapping - 'EducationalBackground' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'EducationalBackground'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'EducationalBackground'), 'Curriculum Vitae', 'Educational Background', 'EducationalBackground', '', 'EducationalBackground');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Curriculum Vitae',TabName = 'Educational Background',ItemName = 'EducationalBackground',TableName = '',FieldName = 'EducationalBackground' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'EducationalBackground');
END

/**************************** ess.PolicyMapping - 'TaxCode' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'TaxCode'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'TaxCode'), 'Personal', 'Personal', 'TaxCode', 'Personnel', 'TaxCode');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'TaxCode',TableName = 'Personnel',FieldName = 'TaxCode' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'TaxCode');
END

/**************************** ess.PolicyMapping - 'OrganizationalAffiliations' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'OrganizationalAffiliations'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'OrganizationalAffiliations'), 'Curriculum Vitae', 'Organizational Affiliations', 'OrganizationalAffiliations', '', 'OrganizationalAffiliations');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Curriculum Vitae',TabName = 'Organizational Affiliations',ItemName = 'OrganizationalAffiliations',TableName = '',FieldName = 'OrganizationalAffiliations' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'OrganizationalAffiliations');
END

/**************************** ess.PolicyMapping - 'AddrState' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'AddrState'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrState'), 'Personal', 'Address & Telephone', 'AddrState', 'Personnel', 'AddrState');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'AddrState',TableName = 'Personnel',FieldName = 'AddrState' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrState');
END

/**************************** ess.PolicyMapping - 'AddrBaranggay' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'AddrBaranggay'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrBaranggay'), 'Personal', 'Address & Telephone', 'Present Barangay', 'Personnel', 'AddrBaranggay');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Present Barangay',TableName = 'Personnel',FieldName = 'AddrBaranggay' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrBaranggay');
END

/**************************** ess.PolicyMapping - 'AddrTelNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'AddrTelNo'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrTelNo'), 'Personal', 'Address & Telephone', 'AddrTelNo', 'Personnel', 'AddrTelNo');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'AddrTelNo',TableName = 'Personnel',FieldName = 'AddrTelNo' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'AddrTelNo');
END

/**************************** ess.PolicyMapping - 'Address5' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Address5'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Address5'), 'Personal', 'Address & Telephone', 'Address5', 'Personnel', 'Address5');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Address5',TableName = 'Personnel',FieldName = 'Address5' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Address5');
END

/**************************** ess.PolicyMapping - 'Address6' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Address6'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Address6'), 'Personal', 'Address & Telephone', 'Address6', 'Personnel', 'Address6');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Address6',TableName = 'Personnel',FieldName = 'Address6' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Address6');
END

/**************************** ess.PolicyMapping - 'PermanentHouseNumber' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'PermanentHouseNumber'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'PermanentHouseNumber'), 'Personal', 'Address & Telephone', 'PermanentHouseNumber', 'Personnel', 'PermanentHouseNumber');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'PermanentHouseNumber',TableName = 'Personnel',FieldName = 'PermanentHouseNumber' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'PermanentHouseNumber');
END

/**************************** ess.PolicyMapping - 'PermanentStreetName' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'PermanentStreetName'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'PermanentStreetName'), 'Personal', 'Address & Telephone', 'PermanentStreetName', 'Personnel', 'PermanentStreetName');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'PermanentStreetName',TableName = 'Personnel',FieldName = 'PermanentStreetName' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'PermanentStreetName');
END

/**************************** ess.PolicyMapping - 'PermanentSubdivision' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'PermanentSubdivision'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'PermanentSubdivision'), 'Personal', 'Address & Telephone', 'PermanentSubdivision', 'Personnel', 'PermanentSubdivision');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'PermanentSubdivision',TableName = 'Personnel',FieldName = 'PermanentSubdivision' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'PermanentSubdivision');
END

/**************************** ess.PolicyMapping - 'State_or_Province' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'State_or_Province'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'State_or_Province'), 'Personal', 'Address & Telephone', 'State_or_Province', 'Personnel', 'State_or_Province');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'State_or_Province',TableName = 'Personnel',FieldName = 'State_or_Province' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'State_or_Province');
END

/**************************** ess.PolicyMapping - 'PermanentCity' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'PermanentCity'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'PermanentCity'), 'Personal', 'Address & Telephone', 'PermanentCity', 'Personnel', 'PermanentCity');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'PermanentCity',TableName = 'Personnel',FieldName = 'PermanentCity' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'PermanentCity');
END

/**************************** ess.PolicyMapping - 'PermanentBaranggay' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'PermanentBaranggay'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'PermanentBaranggay'), 'Personal', 'Address & Telephone', 'Permanent Barangay', 'Personnel', 'PermanentBaranggay');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'Permanent Barangay',TableName = 'Personnel',FieldName = 'PermanentBaranggay' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'PermanentBaranggay');
END

/**************************** ess.PolicyMapping - 'PermanentPostalCode' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'PermanentPostalCode'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'PermanentPostalCode'), 'Personal', 'Address & Telephone', 'PermanentPostalCode', 'Personnel', 'PermanentPostalCode');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'PermanentPostalCode',TableName = 'Personnel',FieldName = 'PermanentPostalCode' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'PermanentPostalCode');
END

/**************************** ess.PolicyMapping - 'PermanentTelNo' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'PermanentTelNo'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'PermanentTelNo'), 'Personal', 'Address & Telephone', 'PermanentTelNo', 'Personnel', 'PermanentTelNo');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Address & Telephone',ItemName = 'PermanentTelNo',TableName = 'Personnel',FieldName = 'PermanentTelNo' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'PermanentTelNo');
END

/**************************** ess.PolicyMapping - 'Division' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Division'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Division'), 'Organisational', 'Employment', 'Division', 'Company', 'Division');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Employment',ItemName = 'Division',TableName = 'Company',FieldName = 'Division' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Division');
END

/**************************** ess.PolicyMapping - 'Department' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Department'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Department'), 'Organisational', 'Employment', 'Department', 'Company', 'Department');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Employment',ItemName = 'Department',TableName = 'Company',FieldName = 'Department' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Department');
END

/**************************** ess.PolicyMapping - 'Section' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Section'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Section'), 'Organisational', 'Employment', 'Section', 'Company', 'Section');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Employment',ItemName = 'Section',TableName = 'Company',FieldName = 'Section' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Section');
END

/**************************** ess.PolicyMapping - 'Fixed' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Fixed'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Fixed'), 'Organisational', 'Employment', 'Fixed', 'Personnel1', 'Fixed');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Employment',ItemName = 'Fixed',TableName = 'Personnel1',FieldName = 'Fixed' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Fixed');
END

/**************************** ess.PolicyMapping - 'Contracting' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Contracting'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Contracting'), 'Organisational', 'Contracting', 'Contracting', '', 'Contracting');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Organisational',TabName = 'Contracting',ItemName = 'Contracting',TableName = '',FieldName = 'Contracting' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Contracting');
END

/**************************** ess.PolicyMapping - 'BloodType' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'BloodType'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'BloodType'), 'Personal', 'Personal', 'Blood Type', 'Personnel', 'BloodType');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Blood Type',TableName = 'Personnel',FieldName = 'BloodType' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'BloodType');
END

/**************************** ess.PolicyMapping - 'MarriageDate' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'MarriageDate'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'MarriageDate'), 'Personal', 'Personal', 'Date of Marriage', 'Personnel1', 'MarriageDate');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Date of Marriage',TableName = 'Personnel1',FieldName = 'MarriageDate' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'MarriageDate');
END

/**************************** ess.PolicyMapping - 'TownOfBirth' *************************D***/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'TownOfBirth'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'TownOfBirth'), 'Personal', 'Personal', 'Town of Birth', 'Personnel1', 'TownOfBirth');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Town of Birth',TableName = 'Personnel1',FieldName = 'TownOfBirth' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'TownOfBirth');
END

/**************************** ess.PolicyMapping - 'CountryOfBirth' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'CountryOfBirth'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'CountryOfBirth'), 'Personal', 'Personal', 'Country of Birth', 'Personnel1', 'CountryOfBirth');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Country of Birth',TableName = 'Personnel1',FieldName = 'CountryOfBirth' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'CountryOfBirth');
END

/**************************** ess.PolicyMapping - 'CityOfBirth' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'CityOfBirth'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'CityOfBirth'), 'Personal', 'Personal', 'Municipality/City', 'Personnel', 'CityOfBirth');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Municipality/City',TableName = 'Personnel',FieldName = 'CityOfBirth' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'CityOfBirth');
END

/**************************** ess.PolicyMapping - 'ExemptionClaim' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ExemptionClaim'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ExemptionClaim'), 'Personal', 'Personal', 'ExemptionClaim', 'Personnel', 'ExemptionClaim');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'ExemptionClaim',TableName = 'Personnel',FieldName = 'ExemptionClaim' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ExemptionClaim');
END

--/**************************** ess.PolicyMapping - 'Dependants' ****************************/
--IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Dependants'))
--BEGIN
--   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Dependants'), 'Personal', 'Family Background', 'Dependants', 'Personnel', 'Dependants');
--END
--ELSE
--BEGIN
--   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Family Background',ItemName = 'Dependants',TableName = 'Personnel',FieldName = 'Dependants' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Dependants');
--END

/**************************** ess.PolicyMapping - 'SeminarsAndTraining' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SeminarsAndTraining'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SeminarsAndTraining'), 'Curriculum Vitae', 'Seminars And Training', 'Seminars And Training', '', 'SeminarsAndTraining');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Curriculum Vitae',TabName = 'Seminars And Training',ItemName = 'Seminars And Training',TableName = '',FieldName = 'SeminarsAndTraining' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SeminarsAndTraining');
END

/**************************** ess.PolicyMapping - 'NextOfKin' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'NextOfKin'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'NextOfKin'), 'Personal', 'Family Background', 'Next of kin', 'Personnel', 'NextOfKin');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Family Background',ItemName = 'Next of kin',TableName = 'Personnel',FieldName = 'NextOfKin' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'NextOfKin');
END

/**************************** ess.PolicyMapping - 'SpouseSurname' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SpouseSurname'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseSurname'), 'Personal', 'Family Background', 'SpouseSurname', 'Personnel1', 'SpouseSurname');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Family Background',ItemName = 'SpouseSurname',TableName = 'Personnel1',FieldName = 'SpouseSurname' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseSurname');
END

/**************************** ess.PolicyMapping - 'SpouseDOB' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SpouseDOB'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseDOB'), 'Personal', 'Family Background', 'SpouseDOB', 'Personnel1', 'SpouseDOB');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Family Background',ItemName = 'SpouseDOB',TableName = 'Personnel1',FieldName = 'SpouseDOB' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseDOB');
END

/**************************** ess.PolicyMapping - 'SpouseAddress' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SpouseAddress'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseAddress'), 'Personal', 'Family Background', 'SpouseAddress', 'Personnel1', 'SpouseAddress');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Family Background',ItemName = 'SpouseAddress',TableName = 'Personnel1',FieldName = 'SpouseAddress' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseAddress');
END

/**************************** ess.PolicyMapping - 'SpouseSex' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SpouseSex'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseSex'), 'Personal', 'Family Background', 'SpouseSex', 'Personnel1', 'SpouseSex');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Family Background',ItemName = 'SpouseSex',TableName = 'Personnel1',FieldName = 'SpouseSex' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseSex');
END

/**************************** ess.PolicyMapping - 'SpouseNationality' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'SpouseNationality'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseNationality'), 'Personal', 'Family Background', 'SpouseNationality', 'Personnel', 'SpouseNationality');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Family Background',ItemName = 'SpouseNationality',TableName = 'Personnel',FieldName = 'SpouseNationality' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'SpouseNationality');
END

/**************************** ess.PolicyMapping - 'Relatives' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'Relatives'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'Relatives'), 'Personal', 'Relatives Working in TMP', 'Relatives', '', 'Relatives');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Relatives Working in TMP',ItemName = 'Relatives',TableName = '',FieldName = 'Relatives' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'Relatives');
END

/**************************** ess.PolicyMapping - 'ZodiacSign' ****************************/
IF NOT EXISTS(SELECT 1 FROM [ess.PolicyMapping] WHERE [PolicyID] = (SELECT ID FROM[ess.Policy] WHERE[Key] = 'ZodiacSign'))
BEGIN
   INSERT INTO [ess.PolicyMapping](PolicyID, ModuleName, TabName, ItemName, TableName, FieldName) VALUES((SELECT ID FROM [ess.Policy] WHERE [Key] = 'ZodiacSign'), 'Personal', 'Personal', 'Animal Sign', 'Personnel', 'ZodiacSign');
END
ELSE
BEGIN
   UPDATE [ess.PolicyMapping] SET ModuleName = 'Personal',TabName = 'Personal',ItemName = 'Animal Sign',TableName = 'Personnel',FieldName = 'ZodiacSign' WHERE [PolicyID]  = (SELECT ID FROM [ess.Policy] WHERE [Key] = 'ZodiacSign');
END





-- 5/28/2019 updates
--delete top (1) from [ess.PolicyMapping]
--where ItemName = 'spouse number' --removed comment on 2020-01-31

update [ess.PolicyMapping]
set TabName = 'Family Background'
where ItemName like '%spouse%'

--update 5/31/2019
--remove duplicates
--target table: [ess.PolicyMapping]

begin tran

declare @tempHolder table (
	PolicyID varchar(max), 
	ModuleName varchar(max), 
	TabName varchar(max), 
	ItemName varchar(max), 
	TableName varchar(max), 
	FieldName varchar(max)
)

insert into @tempHolder 
select 
	a.PolicyID,
	a.ModuleName,
	a.TabName,
	a.ItemName,
	a.TableName,
	a.FieldName
from 
  [ess.PolicyMapping] a 
  inner join (
    select 
      PolicyID
    from 
      [ess.PolicyMapping] 
    group by 
      PolicyID
    having 
      count(PolicyID) > 1
  ) b on a.PolicyID = b.PolicyID 
group by 
	a.PolicyID,
	a.ModuleName,
	a.TabName,
	a.ItemName,
	a.TableName,
	a.FieldName

delete a 
from 
  [ess.PolicyMapping] as a 
  inner join @tempHolder as b on a.PolicyID = b.PolicyID

insert into [ess.PolicyMapping] 
select * from @tempHolder 

commit