IF NOT EXISTS ( SELECT 1 FROM [ess.Policy] WHERE Name = 'cmbCategory')
BEGIN
	INSERT INTO [ess.Policy]
	(GroupID, SetupAssemblyID, SetupDataTypeID, AssemblyID, DataTypeID, [Key], Name, Label, [Description], Visible, Editable, [Required], YesNo, LookupTable, LookupText, LookupValue, [Cascade])
	Values
	('7', '5', '3', '6', '13', 'Category', 'cmbCategory', 'Category', 'This setting specifies whether the category field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', '1', '0', '0', '0', '[OFOCodeLU]', '[OFOCode]', '[OFOCode]', '1')
END

IF NOT EXISTS ( SELECT 1 FROM [ess.Policy] WHERE Name = 'cmbPayLevel')
BEGIN
	INSERT INTO [ess.Policy]
	(GroupID, SetupAssemblyID, SetupDataTypeID, AssemblyID, DataTypeID, [Key], Name, Label, [Description], Visible, Editable, [Required], YesNo, LookupTable, LookupText, LookupValue, [Cascade])
	Values
	('7', '5', '3', '6', '13', 'PayLevel', 'cmbPayLevel', 'Pay Level', 'This setting specifies whether the Pay Level field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', '1', '0', '0', '0', '[OFOCodeOccupLU]', '[Occupation]', '[Occupation]', '1')
END
		
IF NOT EXISTS ( SELECT 1 FROM [ess.Policy] WHERE Name = 'cmbShifting')
BEGIN
	INSERT INTO [ess.Policy]
	(GroupID, SetupAssemblyID, SetupDataTypeID, AssemblyID, DataTypeID, [Key], Name, Label, [Description], Visible, Editable, [Required], YesNo, LookupTable, LookupText, LookupValue, [Cascade]
	, LookupFilter
	)
	Values
	('7', '5', '3', '6', '13', 'Shifting', 'cmbShifting', 'Shifting', 'This setting specifies whether the Shifting field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', '1', '0', '0', '0', '[ShiftTypeLU]', '[ShiftType]', '[ShiftType]', '1'
	, '[CompanyNum] = ''<%CompanyNum%>'''
			)
END
			
IF NOT EXISTS ( SELECT 1 FROM [ess.Policy] WHERE Name = 'cmbWorkAssignment')
BEGIN
	INSERT INTO [ess.Policy]
	(GroupID, SetupAssemblyID, SetupDataTypeID, AssemblyID, DataTypeID, [Key], Name, Label, [Description], Visible, Editable, [Required], YesNo, LookupTable, LookupText, LookupValue, [Cascade]
	)
	Values
	('7', '5', '3', '6', '13', 'WorkAssignment', 'cmbWorkAssignment', 'Work Assignment', 'This setting specifies whether the Work Assignment field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', '1', '0', '0', '0', '[LocationCategoryLU]', '[Category]', '[Category]', '1'
			)
END
		
IF NOT EXISTS ( SELECT 1 FROM [ess.Policy] WHERE Name = 'cmbUnionAffiliation')
BEGIN
	INSERT INTO [ess.Policy]
	(GroupID, SetupAssemblyID, SetupDataTypeID, AssemblyID, DataTypeID, [Key], Name, Label, [Description], Visible, Editable, [Required], YesNo, LookupTable, LookupText, LookupValue, [Cascade]
	, LookupFilter
	)
	Values
	('7', '5', '3', '6', '13', 'UnionAffiliation', 'cmbUnionAffiliation', 'Union Affiliation', 'This setting specifies whether the Union Affiliation field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', '1', '0', '0', '0', '[JobTitle]', '[Jobtitle]', '[JobTitle]', '1'
	, '[CompanyNum] = ''<%CompanyNum%>'''
			)
END

IF NOT EXISTS ( SELECT 1 FROM [ess.Policy] WHERE Name = 'cmbShirtSize')
BEGIN
	INSERT INTO [ess.Policy]
	(GroupID, SetupAssemblyID, SetupDataTypeID, AssemblyID, DataTypeID, [Key], Name, Label, [Description], Visible, Editable, [Required], YesNo, LookupTable, LookupText, LookupValue, [Cascade]
	, LookupFilter
	)
	Values
	('7', '5', '3', '6', '13', 'ShirtSize', 'cmbShirtSize', 'Shirt Size', 'This setting specifies whether the Shirt Size field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', '1', '0', '0', '0', '[PersonnelAttribute]', '[AttributeValue]', '[AttributeValue]', '1'
	, '[CompanyNum] = ''<%CompanyNum%>'' and [EmployeeNum] = ''<%EmployeeNum%>'' and [AttributeName] = ''SHIRT SIZE'''
			)
END

IF NOT EXISTS ( SELECT 1 FROM [ess.Policy] WHERE Name = 'txtBlazer')
BEGIN
	INSERT INTO [ess.Policy]
	(GroupID, SetupAssemblyID, SetupDataTypeID, AssemblyID, DataTypeID, [Key], Name, Label, [Description], Visible, Editable, [Required], YesNo, [Cascade]
	)
	Values
	('7', '5', '3', '19', '13', 'Blazer', 'txtBlazer', 'Blazer', 'This setting specifies whether the Blazer field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', '1', '0', '0', '0', '1'
			)
END

IF NOT EXISTS ( SELECT 1 FROM [ess.Policy] WHERE Name = 'txtSkirt')
BEGIN
	INSERT INTO [ess.Policy]
	(GroupID, SetupAssemblyID, SetupDataTypeID, AssemblyID, DataTypeID, [Key], Name, Label, [Description], Visible, Editable, [Required], YesNo, [Cascade]
	)
	Values
	('7', '5', '3', '19', '13', 'Skirt', 'txtSkirt', 'Skirt', 'This setting specifies whether the Skirt field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', '1', '0', '0', '0', '1'
			)
END

IF NOT EXISTS ( SELECT 1 FROM [ess.Policy] WHERE Name = 'txtBlouse')
BEGIN
	INSERT INTO [ess.Policy]
	(GroupID, SetupAssemblyID, SetupDataTypeID, AssemblyID, DataTypeID, [Key], Name, Label, [Description], Visible, Editable, [Required], YesNo, [Cascade]
	)
	Values
	('7', '5', '3', '19', '13', 'Blouse', 'txtBlouse', 'Blouse', 'This setting specifies whether the Blouse field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', '1', '0', '0', '0', '1'
			)
END

IF NOT EXISTS ( SELECT 1 FROM [ess.Policy] WHERE Name = 'txtSlacks')
BEGIN
	INSERT INTO [ess.Policy]
	(GroupID, SetupAssemblyID, SetupDataTypeID, AssemblyID, DataTypeID, [Key], Name, Label, [Description], Visible, Editable, [Required], YesNo, [Cascade]
	)
	Values
	('7', '5', '3', '19', '13', 'Slacks', 'txtSlacks', 'Slacks', 'This setting specifies whether the Slacks field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', '1', '0', '0', '0', '1'
			)
END

IF NOT EXISTS ( SELECT 1 FROM [ess.Policy] WHERE Name = 'txtShirtjack')
BEGIN
	INSERT INTO [ess.Policy]
	(GroupID, SetupAssemblyID, SetupDataTypeID, AssemblyID, DataTypeID, [Key], Name, Label, [Description], Visible, Editable, [Required], YesNo, [Cascade]
	)
	Values
	('7', '5', '3', '19', '13', 'Shirtjack', 'txtShirtjack', 'Shirtjack', 'This setting specifies whether the Shirtjack field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', '1', '0', '0', '0', '1'
			)
END

IF NOT EXISTS ( SELECT 1 FROM [ess.Policy] WHERE Name = 'txtShirtjackPants')
BEGIN
	INSERT INTO [ess.Policy]
	(GroupID, SetupAssemblyID, SetupDataTypeID, AssemblyID, DataTypeID, [Key], Name, Label, [Description], Visible, Editable, [Required], YesNo, [Cascade]
	)
	Values
	('7', '5', '3', '19', '13', 'ShirtjackPants', 'txtShirtjackPants', 'Shirtjack Pants', 'This setting specifies whether the ShirtjackPants field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', '1', '0', '0', '0', '1'
			)
END

IF NOT EXISTS ( SELECT 1 FROM [ess.Policy] WHERE Name = 'txtPoloBarong')
BEGIN
	INSERT INTO [ess.Policy]
	(GroupID, SetupAssemblyID, SetupDataTypeID, AssemblyID, DataTypeID, [Key], Name, Label, [Description], Visible, Editable, [Required], YesNo, [Cascade]
	)
	Values
	('7', '5', '3', '19', '13', 'PoloBarong', 'txtPoloBarong', 'Polo/Barong', 'This setting specifies whether the Polo/Barong field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', '1', '0', '0', '0', '1'
			)
END

IF NOT EXISTS ( SELECT 1 FROM [ess.Policy] WHERE Name = 'txtRepellantPants')
BEGIN
	INSERT INTO [ess.Policy]
	(GroupID, SetupAssemblyID, SetupDataTypeID, AssemblyID, DataTypeID, [Key], Name, Label, [Description], Visible, Editable, [Required], YesNo, [Cascade]
	)
	Values
	('7', '5', '3', '19', '13', 'RepellantPants', 'txtRepellantPants', 'Repellant Pants', 'This setting specifies whether the Repellant Pants field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', '1', '0', '0', '0', '1'
			)
END

IF NOT EXISTS ( SELECT 1 FROM [ess.Policy] WHERE Name = 'txtPoloShirt')
BEGIN
	INSERT INTO [ess.Policy]
	(GroupID, SetupAssemblyID, SetupDataTypeID, AssemblyID, DataTypeID, [Key], Name, Label, [Description], Visible, Editable, [Required], YesNo, [Cascade]
	)
	Values
	('7', '5', '3', '19', '13', 'PoloShirt', 'txtPoloShirt', 'Polo Shirt', 'This setting specifies whether the Polo Shirt field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', '1', '0', '0', '0', '1'
			)
END

IF NOT EXISTS ( SELECT 1 FROM [ess.Policy] WHERE Name = 'txtMaongPants')
BEGIN
	INSERT INTO [ess.Policy]
	(GroupID, SetupAssemblyID, SetupDataTypeID, AssemblyID, DataTypeID, [Key], Name, Label, [Description], Visible, Editable, [Required], YesNo, [Cascade]
	)
	Values
	('7', '5', '3', '19', '13', 'MaongPants', 'txtMaongPants', 'Maong Pants', 'This setting specifies whether the Maong Pants field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', '1', '0', '0', '0', '1'
			)
END

IF NOT EXISTS ( SELECT 1 FROM [ess.Policy] WHERE Name = 'txtTShirt')
BEGIN
	INSERT INTO [ess.Policy]
	(GroupID, SetupAssemblyID, SetupDataTypeID, AssemblyID, DataTypeID, [Key], Name, Label, [Description], Visible, Editable, [Required], YesNo, [Cascade]
	)
	Values
	('7', '5', '3', '19', '13', 'TShirt', 'txtTShirt', 'T-Shirt', 'This setting specifies whether the T-Shirt field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', '1', '0', '0', '0', '1'
			)
END

IF NOT EXISTS ( SELECT 1 FROM [ess.Policy] WHERE Name = 'txtOveralls')
BEGIN
	INSERT INTO [ess.Policy]
	(GroupID, SetupAssemblyID, SetupDataTypeID, AssemblyID, DataTypeID, [Key], Name, Label, [Description], Visible, Editable, [Required], YesNo, [Cascade]
	)
	Values
	('7', '5', '3', '19', '13', 'Overalls', 'txtOveralls', 'Overalls', 'This setting specifies whether the Overalls field in the organizational module should be displayed.

			Default:

			Enabled on new installations.', '1', '0', '0', '0', '1'
			)
END
		
UPDATE POL
SET POL.LookupTable = '[IndividualJobTitle]', POL.LookupText = '[IndividualJobTitle]', POL.LookupValue = '[IndividualJobTitle]', POL.LookupFilter = null
from [ess.Policy] as POL
where POL.[Key] = 'JobTitle' 
AND POL.[Name] = 'cmbJobTitle'