Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxGridView.Export

Partial Public Class personal
    Inherits System.Web.UI.Page

    Private bEditable As Boolean = True
    Private dPersonal As DataTable = Nothing

    Private CancelEdit As Boolean
    Private UDetails As Users = Nothing

#Region " *** Web Form Functions *** "

    Private Function ChangedSQL() As String

        Dim SQL As String = String.Empty
        Dim bIndex As Byte = 0

        Dim dChanges As DataTable = GetSQLDT("select [ess.Policy].[ID] as [ID], [Key], [Name], [Label], [AssemblyID], [TypeName], [Property] from [ess.Policy] left outer join [AssemblyLU] on [ess.Policy].[AssemblyID] = [AssemblyLU].[ID] where (not [TypeName] = 'DevExpress.Web.ASPxGridView.ASPxGridView' and [GroupID] = 6) order by [ess.Policy].[ID]")

        If (IsData(dChanges) AndAlso IsData(dPersonal)) Then

            Dim objControl As Object = Nothing
            Dim objValue() As Object = {Nothing, Nothing}

            For iLoop As Integer = 0 To (dChanges.Rows.Count - 1)

                With dChanges.Rows(iLoop)

                    objControl = tabPersonal.FindControl(.Item("Name").ToString())

                    If (Not IsNull(objControl)) Then

                        'Web control value
                        objValue(0) = CallByName(objControl, .Item("Property").ToString(), CallType.Get)
                        'Field value
                        objValue(1) = dPersonal.Rows(0).Item(.Item("Key").ToString()).ToString()

                        objValue(0) = IIf(objValue(0) Is Nothing, "", objValue(0))
                        objValue(1) = IIf(objValue(1) Is Nothing, "", objValue(1))

                        If (.Item("TypeName").ToString() = "DevExpress.Web.ASPxEditors.ASPxDateEdit") Then

                            If (IsDate(objValue(0))) Then objValue(0) = Convert.ToDateTime(objValue(0)).ToString("yyyy-MM-dd HH:mm:ss")

                            If (IsDate(objValue(1))) Then objValue(1) = Convert.ToDateTime(objValue(1)).ToString("yyyy-MM-dd HH:mm:ss")

                        End If
                        'Added a condition to compare database value against web control value (ExemptionClaim checkbox)
                        If (.Item("TypeName").ToString() = "DevExpress.Web.ASPxEditors.ASPxCheckBox") Then
                            If (objValue(1) = "") Then
                                objValue(1) = False
                            ElseIf (objValue(1) = 1) Then
                                objValue(1) = True
                            Else
                                objValue(1) = False
                            End If
                        End If

                        If (.Item("TypeName").ToString() = "DevExpress.Web.ASPxEditors.ASPxComboBox") Then
                            If (objValue(1) = "") Then
                                'objValue(1) = "<select>"
                                objValue(1) = ""
                            End If
                        End If
                        'end
                        'Replaced all dropdown default value from <select> to String.Empty 
                        'Adjusted condition of some snippets according to the recent change of controls default values. 
                        If (Not objValue(0).Equals(objValue(1)) AndAlso Not objValue(0).Equals(String.Empty) AndAlso Not (objValue(0).Equals(String.Empty) And IsNull(objValue(1)))) Then

                                If (IsNull(objValue(1))) Then objValue(1) = "{null}"

                                SQL &= "<PolicyID[" & bIndex.ToString("000") & "]=" & .Item("ID").ToString() & "><AssemblyID[" & bIndex.ToString("000") & "]=" & .Item("AssemblyID").ToString() & "><Key[" & bIndex.ToString("000") & "]=" & .Item("Key").ToString() & "><Label[" & bIndex.ToString("000") & "]=" & .Item("Label").ToString() & "><ValueF[" & bIndex.ToString("000") & "]=" & objValue(1) & "><ValueT[" & bIndex.ToString("000") & "]=" & objValue(0) & ">"

                                bIndex += 1

                            End If
                            'end
                            objControl = Nothing

                            objValue(0) = Nothing
                            objValue(1) = Nothing

                        End If

                End With

            Next

            dChanges.Dispose()

        End If

        dChanges = Nothing

        If (bIndex > 0) Then SQL &= "<Count=" & bIndex.ToString() & ">"

        Return SQL

    End Function

    Private Sub ClearPersonalCache(ByVal SessionID As String)

        ClearFromCache("Data.Personal." & Session.SessionID)

        ClearFromCache("Data.Personal.OtherLanguage." & Session.SessionID)

        ClearFromCache("Data.Personal.NextOfKin." & Session.SessionID)

        ClearFromCache("Data.Personal.Dependants." & Session.SessionID)

    End Sub

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        With UDetails

            'Select Case tabPersonal.ActiveTabIndex

            'Case 0
            If (ClearCache) Then ClearFromCache("Data.Personal.OtherLanguage." & Session.SessionID)

            If (ClearCache) Then ClearFromCache("Data.Personal.Attributes." & Session.SessionID)

            LoadExpGrid(Session, dgView_001, "Personal Tab", "<Tablename=OtherLanguage><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [Language]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[Language], [Write], [Speak]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Personal.OtherLanguage." & Session.SessionID)

            LoadExpGrid(Session, dgView_004, "Personal Tab", "<Tablename=PersonnelAttribute><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [AttributeName]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[DateCreated], [AttributeName], [AttributeValue]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [AttributeName] IN ('HEIGHT','WEIGHT'))>", "Data.Personal.Attributes." & Session.SessionID)

            'Case 2
            If (ClearCache) Then

                ClearFromCache("Data.Personal.NextOfKin." & Session.SessionID)

                ClearFromCache("Data.Personal.Dependants." & Session.SessionID)

            End If

            LoadExpGrid(Session, dgView_002, "Personal Tab", "<Tablename=NextOfKin><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [NoK]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[NoK], [NoKRelationship], [NoKPhoneHome], [NoKPhoneWork]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Personal.NextOfKin." & Session.SessionID)

            LoadExpGrid(Session, dgView_003, "Personal Tab", "<Tablename=Dependants><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [DependName]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[DependName],ISNULL([DepMidName],'') AS [DepMidName],ISNULL([Surname],'') AS [Surname],ISNULL(CONVERT(NVARCHAR(10),[DoB],10),'') AS [DoB],[dbo].[fnCalculateAge](DoB) AS [Age],ISNULL([Sex],'') AS [Sex],ISNULL([DepCivilStat],'') AS [DepCivilStat],ISNULL([DepDeceased],0) AS [DepDeceased],ISNULL([DepEmployer],'') AS [DepEmployer],ISNULL([DepOccupation],'') AS [DepOccupation],ISNULL([Nationality],'') AS [Nationality],ISNULL([DepAddress],'') AS [DepAddress],ISNULL([ContactNumber],'') AS [ContactNumber],ISNULL([OnMedicalAid],0) AS [OnMedicalAid],ISNULL(CONVERT(NVARCHAR(10),[MedicalAidStartDt],10),'') AS [MedicalAidStartDt],ISNULL(CONVERT(NVARCHAR(10),[MedicalAidEndDt],10),'') AS [MedicalAidEndDt],ISNULL([IDNum],'') AS [IDNum]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Personal.Dependants." & Session.SessionID)

            'Case 4
            If (ClearCache) Then ClearFromCache("Data.Personal.Relatives." & Session.SessionID)

            LoadExpGrid(Session, dgView_Relatives, "Personal Tab", "<Tablename=RelWorkingInTMP><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [Surname] + ' ' + [FirstName]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[Surname], [FirstName], [MiddleName], [Relation], [PlaceOfWork], [PlantBranch]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Personal.Relatives." & Session.SessionID)

            'End Select

            If (Not IsPostBack) Then

                pnlHLanguage.Visible = GetArrayItem(.Template, "ePersonal.OtherLanguage")

                phSpace_001.Visible = pnlHLanguage.Visible

                pnlAttributes.Visible = GetArrayItem(.Template, "ePersonal.Attributes")

                phSpace_004.Visible = pnlAttributes.Visible

                pnlNextofKin.Visible = GetArrayItem(.Template, "ePersonal.NextOfKin")

                phSpace_003.Visible = pnlNextofKin.Visible

                pnlDependants.Visible = GetArrayItem(.Template, "ePersonal.Dependants")

                dgView_Relatives.Visible = GetArrayItem(.Template, "ePersonal.Relatives")

                Dim Editable As Boolean = GetArrayItem(.Template, "ePersonal.OtherLanguage.Editable")

                If (Not Editable) AndAlso ((dgView_001.Columns("edit").Visible) Or (dgView_001.Columns("delete").Visible)) Then

                    dgView_001.Columns("edit").Visible = Editable

                    dgView_001.Columns("delete").Visible = Editable

                    dgView_001.Settings.ShowStatusBar = DevExpress.Web.ASPxGridView.GridViewStatusBarMode.Hidden

                End If

                Editable = GetArrayItem(.Template, "ePersonal.Attributes.Editable")

                If (Not Editable) AndAlso ((dgView_004.Columns("edit").Visible) Or (dgView_004.Columns("delete").Visible)) Then

                    dgView_004.Columns("edit").Visible = Editable

                    dgView_004.Columns("delete").Visible = Editable

                    dgView_004.Settings.ShowStatusBar = DevExpress.Web.ASPxGridView.GridViewStatusBarMode.Hidden

                End If

                Editable = GetArrayItem(.Template, "ePersonal.NextOfKin.Editable")

                If (Not Editable) AndAlso ((dgView_002.Columns("edit").Visible) Or (dgView_002.Columns("delete").Visible)) Then

                    dgView_002.Columns("edit").Visible = Editable

                    dgView_002.Columns("delete").Visible = Editable

                    dgView_002.Settings.ShowStatusBar = DevExpress.Web.ASPxGridView.GridViewStatusBarMode.Hidden

                End If

                Editable = GetArrayItem(.Template, "ePersonal.Dependants.Editable")

                If (Not Editable) AndAlso ((dgView_003.Columns("edit").Visible) Or (dgView_003.Columns("delete").Visible)) Then

                    dgView_003.Columns("edit").Visible = Editable

                    dgView_003.Columns("delete").Visible = Editable

                    dgView_003.Settings.ShowStatusBar = DevExpress.Web.ASPxGridView.GridViewStatusBarMode.Hidden

                End If

                Editable = GetArrayItem(.Template, "ePersonal.Relatives.Editable")

                If (Not Editable) AndAlso ((dgView_Relatives.Columns("edit").Visible) Or (dgView_Relatives.Columns("delete").Visible)) Then

                    dgView_Relatives.Columns("edit").Visible = Editable

                    dgView_Relatives.Columns("delete").Visible = Editable

                    dgView_Relatives.Settings.ShowStatusBar = DevExpress.Web.ASPxGridView.GridViewStatusBarMode.Hidden

                End If

            End If

        End With

    End Sub

    ''' <summary>
    ''' Retrieves all policies for the field and applies them
    ''' </summary>
    ''' <param name="cPolicy"></param>
    ''' <param name="Key"></param>
    Private Sub SetPolicy(ByRef cPolicy As Object, ByVal Key As String)

        cPolicy.Visible = GetArrayItem(UDetails.Template, "ePersonal." & Key)

        cPolicy.Enabled = GetArrayItem(UDetails.Template, "ePersonal." & Key & ".Editable")

        Dim isRequired As Boolean = GetArrayItem(UDetails.Template, "ePersonal." & Key & ".Required")

        Dim validation As Object = GetArrayItem(UDetails.Template, "ePersonal." & Key & ".Validation")

        If (Not bEditable) Then cPolicy.Enabled = False

        'If (GetArrayItem(UDetails.Template, "ePersonal." & Key & ".Required") = True OrElse Not IsNull(GetArrayItem(UDetails.Template, "ePersonal." & Key & ".Validation"))) Then

        If (isRequired = True OrElse validation <> String.Empty) Then

            With cPolicy.ValidationSettings

                .ErrorDisplayMode = ErrorDisplayMode.ImageWithTooltip

                .SetFocusOnError = True

                .RequiredField.IsRequired = True

                .RequiredField.ErrorText = "This field cannot be empty."

            End With

        End If

    End Sub

#End Region

#Region " *** Web Form Events *** "
    Protected Sub dteSpouseBirthDate_DateChanged(ByVal sender As Object, ByVal e As EventArgs)
        txtSpouseAge.Value = CommonFunctions.CalculateAge(DateTime.Parse(dteSpouseBirthDate.Value))
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Session("docUnread")) Then

            Response.Redirect("documentmapman.aspx", True)

            Exit Sub

        End If

        If (Not IsPostBack) Then SetEmployeeData(Session, Session("Selected.Value"))

        UDetails = GetUserDetails(Session, "Personal Tab")

        If (Not dteBirthDate.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom) Then

            dteBirthDate.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom
            dteBirthDate.EditFormatString = GetArrayItem(UDetails.Template, "eGeneral.DateFormat")

        End If

        'Replaced all dropdown default value from '<select>' to 'String.Empty' 
        'Adjusted condition of some snippets according to the recent change of controls default values. 

        LoadExpDS(dsCountryOfBirth, "select [CountryName] from [CountryCodeLU] order by [CountryName]")
        LoadExpCmb(cmbCountryOfBirth, String.Empty)

        LoadExpDS(dsBloodType, "select [BloodType] from [BloodTypeLU] order by [BloodType]")
        LoadExpCmb(cmbBloodType, String.Empty)

        LoadExpDS(dsDisability, "select [Disability] from [DisabilityLU] order by [Disability]")
        LoadExpCmb(cmbDisability, String.Empty)

        LoadExpDS(dsEthnicGroup, "select [EthnicGroup] from [EthnicLU] order by [EthnicGroup]")
        LoadExpCmb(cmbEthnicGroup, String.Empty)

        LoadExpDS(dsLanguage, "select [Language] from [LanguageLU] order by [Language]")
        LoadExpCmb(cmbLanguage, String.Empty)

        LoadExpDS(dsMaritalStatus, "select [MaritalStatus] from [MStatusLU] order by [MaritalStatus]")
        LoadExpCmb(cmbMaritalStatus, String.Empty)

        LoadExpDS(dsNationality, "select [Nationality] from [NationalityLU] order by [Nationality]")
        LoadExpCmb(cmbNationality, String.Empty)
        LoadExpCmb(cmbSpouseNationality, String.Empty)

        LoadExpDS(dsNoKRelationship, "select distinct [NoKRelationship] from [NextOfKin] order by [NoKRelationship]")

        LoadExpDS(dsRelationship, "select distinct [Sex] from [Dependants] order by [Sex]")

        LoadExpDS(dsReligion, "select [Religion] from [ReligionLU] order by [Religion]")

        LoadExpCmb(cmbReligion, String.Empty)

        LoadExpDS(dsTitle, "select distinct [Title] from [Personnel] order by [Title]")

        LoadExpCmb(cmbTitle, String.Empty)

        LoadExpDS(dsSex, "select [Sex] from [SexLU] order by [Sex]")

        LoadExpCmb(cmbSex, String.Empty)
        LoadExpCmb(cmbSpouseSex, String.Empty)

        LoadExpDS(dsRelatives, "SELECT DISTINCT UPPER(Relatives) AS Relatives FROM RelativesLU")
        LoadExpCmb(cmbGuardianRelationship, String.Empty)

        LoadExpDS(dsShuttle, "SELECT UPPER(FieldValue) AS [FieldValue] FROM CustomFormFieldValues WHERE FieldName = 'ShuttleRoute'")
        LoadExpCmb(cmbShuttlePreference, String.Empty)

        LoadExpDS(dsRegion, "SELECT DISTINCT UPPER(Regi) AS Region FROM LocationFilter")
        LoadExpCmb(cmbPresentRegion, String.Empty)
        LoadExpCmb(cmbPermanentRegion, String.Empty)

        LoadExpCmb(cmbGuardianSex, String.Empty)
        LoadExpDS(dsAttribute, "SELECT DISTINCT [AttributeName] FROM [PersonnelAttribute] WHERE [AttributeName] IN ('HEIGHT','WEIGHT')")

        LoadExpDS(dsTaxCode, "SELECT DISTINCT UPPER(TaxCode) AS TaxCode FROM [TaxCodeLU]")
        LoadExpCmb(cmbTaxCode, String.Empty)

        'amanriza - end

        LoadData()

        With UDetails

            dPersonal = GetSQLDT("SELECT * FROM [vwPersonnelInformation] WHERE ([CompanyNum] = '" & .CompanyNum & "' AND [EmployeeNum] = '" & .EmployeeNum & "')", "Data.Personal." & Session.SessionID)

            If (Not IsPostBack) AndAlso (IsData(dPersonal)) Then

                With dPersonal.Rows(0)

                    txtSuffix.Text = .Item("Initials").ToString()
                    items_saved.Add("Initials", txtSuffix.Text)
                    SetPolicy(txtSuffix, "Initials")
                    lblSuffix.Visible = txtSuffix.Visible

                    txtMaidenName.Text = .Item("MaidenName").ToString()
                    items_saved.Add("MaidenName", txtMaidenName.Text)
                    SetPolicy(txtMaidenName, "MaidenName")
                    lblMaidenName.Visible = txtMaidenName.Visible

                    txtMiddleName.Text = .Item("MiddleName").ToString()
                    items_saved.Add("MiddleName", txtMiddleName.Text)
                    SetPolicy(txtMiddleName, "MiddleName")
                    lblMiddleName.Visible = txtMiddleName.Visible

                    txtGuardianLastName.Text = .Item("NOK_Surname").ToString()
                    items_saved.Add("NOK_Surname", txtGuardianLastName.Text)
                    SetPolicy(txtGuardianLastName, "NOK_Surname")
                    lblGuardianLastName.Visible = txtGuardianLastName.Visible

                    txtGuardianFirstName.Text = .Item("NOK_FirstName").ToString()
                    items_saved.Add("NOK_FirstName", txtGuardianFirstName.Text)
                    SetPolicy(txtGuardianFirstName, "NOK_FirstName")
                    lblGuardianFirstName.Visible = txtGuardianFirstName.Visible

                    txtGuardianMiddleName.Text = .Item("NOK_MiddleName").ToString()
                    items_saved.Add("NOK_MiddleName", txtGuardianMiddleName.Text)
                    SetPolicy(txtGuardianMiddleName, "NOK_MiddleName")
                    lblGuardianMiddleName.Visible = txtGuardianMiddleName.Visible

                    txtGuardianAddress.Text = .Item("NOK_ERAddress").ToString()
                    items_saved.Add("NOK_ERAddress", txtGuardianAddress.Text)
                    SetPolicy(txtGuardianAddress, "NOK_ERAddress")
                    lblGuardianAddress.Visible = txtGuardianAddress.Visible

                    txtGuardianContactNo.Text = .Item("NOK_ContactNo").ToString()
                    items_saved.Add("NOK_ContactNo", txtGuardianContactNo.Text)
                    SetPolicy(txtGuardianContactNo, "NOK_ContactNo")
                    lblGuardianContactNo.Visible = txtGuardianContactNo.Visible

                    txtGuardianEmployer.Text = .Item("NOK_Employer").ToString()
                    items_saved.Add("NOK_Employer", txtGuardianEmployer.Text)
                    SetPolicy(txtGuardianEmployer, "NOK_Employer")
                    lblGuardianEmployer.Visible = txtGuardianEmployer.Visible

                    txtGuardianOccupation.Text = .Item("NOK_Occupation").ToString()
                    items_saved.Add("NOK_Occupation", txtGuardianOccupation.Text)
                    SetPolicy(txtGuardianOccupation, "NOK_Occupation")
                    lblGuardianOccupation.Visible = txtGuardianOccupation.Visible

                    txtGuardianAge.Text = .Item("NOK_Age").ToString()
                    items_saved.Add("NOK_Age", txtGuardianAge.Text)
                    SetPolicy(txtGuardianAge, "NOK_Age")
                    lblGuardianAge.Visible = txtGuardianAge.Visible

                    SetComboValue(cmbGuardianRelationship, .Item("NOK_Relationship").ToString())
                    items_saved.Add("NOK_Relationship", cmbGuardianRelationship.Value)
                    SetPolicy(cmbGuardianRelationship, "NOK_Relationship")
                    lblGuardianRelationship.Visible = cmbGuardianRelationship.Visible

                    SetComboValue(cmbGuardianSex, .Item("NOK_Gender").ToString())
                    items_saved.Add("NOK_Gender", cmbGuardianSex.Value)
                    SetPolicy(cmbGuardianSex, "NOK_Gender")
                    lblGuardianSex.Visible = cmbGuardianSex.Visible

                    If (Not IsNull(.Item("NOK_DateOfBirth"))) Then dteGuardianBirthDate.Value = .Item("NOK_DateOfBirth")
                    items_saved.Add("NOK_DateOfBirth", dteGuardianBirthDate.Value)
                    SetPolicy(dteGuardianBirthDate, "NOK_DateOfBirth")
                    lblGuardianBirthDate.Visible = dteGuardianBirthDate.Visible

                    txtTIN.Text = .Item("BIRMembershipNo").ToString()
                    items_saved.Add("BIRMembershipNo", txtTIN.Text)
                    SetPolicy(txtTIN, "BIRMembershipNo")
                    lblTIN.Visible = txtTIN.Visible

                    txtSSS.Text = .Item("SSSMembershipNo").ToString()
                    items_saved.Add("SSSMembershipNo", txtSSS.Text)
                    SetPolicy(txtSSS, "SSSMembershipNo")
                    lblSSS.Visible = txtSSS.Visible

                    txtHDMF.Text = .Item("PAGIBIGMembershipNo").ToString()
                    items_saved.Add("PAGIBIGMembershipNo", txtHDMF.Text)
                    SetPolicy(txtHDMF, "PAGIBIGMembershipNo")
                    lblHDMF.Visible = txtHDMF.Visible

                    txtPHIC.Text = .Item("PHILMemNo").ToString()
                    items_saved.Add("PHILMemNo", txtPHIC.Text)
                    SetPolicy(txtPHIC, "PHILMemNo")
                    lblPHIC.Visible = txtPHIC.Visible

                    txtAge.Text = .Item("Age").ToString()
                    items_saved.Add("Age", txtAge.Text)
                    SetPolicy(txtAge, "Age")
                    lblAge.Visible = txtAge.Visible
                    'change control to ASPxComboBox
                    SetComboValue(txtZodiacSign, .Item("ZodiacSignActual").ToString())
                    'txtZodiacSign.Text = .Item("ZodiacSignActual").ToString()
                    items_saved.Add("ZodiacSignActual", txtZodiacSign.Text)
                    SetPolicy(txtZodiacSign, "ZodiacSignActual")
                    lblZodiacSign.Visible = txtZodiacSign.Visible
                    SetComboValue(txtAnimalSign, .Item("ZodiacSign").ToString())
                    'txtAnimalSign.Text = .Item("ZodiacSign").ToString()
                    items_saved.Add("ZodiacSign", txtAnimalSign.Text)
                    SetPolicy(txtAnimalSign, "ZodiacSign")
                    lblAnimalSign.Visible = txtAnimalSign.Visible

                    txtSpouseName.Text = .Item("SpouseName").ToString()
                    items_saved.Add("SpouseName", txtSpouseName.Text)
                    SetPolicy(txtSpouseName, "SpouseName")
                    lblSpouseName.Visible = txtSpouseName.Visible

                    txtSpouseMiddleName.Text = .Item("SpouseMiddleName").ToString()
                    items_saved.Add("SpouseMiddleName", txtSpouseMiddleName.Text)
                    SetPolicy(txtSpouseMiddleName, "SpouseMiddleName")
                    lblSpouseMiddleName.Visible = txtSpouseMiddleName.Visible

                    txtSpouseSurname.Text = .Item("SpouseSurname").ToString()
                    items_saved.Add("SpouseSurname", txtSpouseSurname.Text)
                    SetPolicy(txtSpouseSurname, "SpouseSurname")
                    lblSpouseSurname.Visible = txtSpouseSurname.Visible

                    txtSpouseTel.Text = .Item("SpouseTel").ToString()
                    items_saved.Add("SpouseTel", txtSpouseTel.Text)
                    SetPolicy(txtSpouseTel, "SpouseTel")
                    lblSpouseTel.Visible = txtSpouseTel.Visible

                    txtSpouseEmployer.Text = .Item("SpouseEmployer").ToString()
                    items_saved.Add("SpouseEmployer", txtSpouseEmployer.Text)
                    SetPolicy(txtSpouseEmployer, "SpouseEmployer")
                    lblSpouseEmployer.Visible = txtSpouseEmployer.Visible

                    txtSpouseEmployerAddress.Text = .Item("SpouseEmployerAdd").ToString()
                    items_saved.Add("SpouseEmployerAdd", txtSpouseEmployerAddress.Text)
                    SetPolicy(txtSpouseEmployerAddress, "SpouseEmployerAdd")
                    lblSpouseEmployerAddress.Visible = txtSpouseEmployerAddress.Visible

                    txtSpouseOccupation.Text = .Item("SpouseOccu").ToString()
                    items_saved.Add("SpouseOccu", txtSpouseOccupation.Text)
                    SetPolicy(txtSpouseOccupation, "SpouseOccu")
                    lblSpouseOccupation.Visible = txtSpouseOccupation.Visible

                    txtSpouseAge.Text = .Item("SpouseAge").ToString()
                    items_saved.Add("SpouseAge", txtSpouseAge.Text)
                    SetPolicy(txtSpouseAge, "SpouseAge")
                    lblSpouseAge.Visible = txtSpouseAge.Visible

                    If (Not IsNull(.Item("SpouseDOB"))) Then dteSpouseBirthDate.Value = .Item("SpouseDOB")
                    items_saved.Add("SpouseDOB", dteSpouseBirthDate.Value)
                    SetPolicy(dteSpouseBirthDate, "SpouseDOB")
                    lblSpouseBirthDate.Visible = dteSpouseBirthDate.Visible

                    SetComboValue(cmbSpouseSex, .Item("SpouseSex").ToString())
                    items_saved.Add("SpouseSex", cmbSpouseSex.Value)
                    SetPolicy(cmbSpouseSex, "SpouseSex")
                    lblSpouseSex.Visible = cmbSpouseSex.Visible

                    SetComboValue(cmbSpouseNationality, .Item("SpouseNationality").ToString())
                    items_saved.Add("SpouseNationality", cmbSpouseNationality.Value)
                    SetPolicy(cmbSpouseNationality, "SpouseNationality")
                    lblSpouseNationality.Visible = cmbSpouseNationality.Visible

                    txtSpouseAddress.Text = .Item("SpouseAddress").ToString()
                    items_saved.Add("SpouseAddress", txtSpouseAddress.Text)
                    SetPolicy(txtSpouseAddress, "SpouseAddress")
                    lblSpouseAddress.Visible = txtSpouseAddress.Visible

                    SetComboValue(cmbShuttlePreference, .Item("ShuttleRoute").ToString())
                    items_saved.Add("ShuttleRoute", cmbShuttlePreference.Value)
                    SetPolicy(cmbShuttlePreference, "ShuttleRoute")
                    lblShuttlePreference.Visible = cmbShuttlePreference.Visible

                    SetComboValue(cmbTaxCode, .Item("TaxCode").ToString())
                    items_saved.Add("TaxCode", cmbTaxCode.Value)
                    SetPolicy(cmbTaxCode, "TaxCode")
                    lblTaxCode.Visible = cmbTaxCode.Visible

                    'Date of Marriage
                    If (Not IsNull(.Item("MarriageDate"))) Then dteMarriageDate.Value = .Item("MarriageDate")
                    items_saved.Add("MarriageDate", dteMarriageDate.Value)
                    SetPolicy(dteMarriageDate, "MarriageDate")
                    lblMarriageDate.Visible = dteMarriageDate.Visible

                    'Is Wife Claiming Exemption
                    chkExemptionClaim.Checked = IIf(.Item("ExemptionClaim").ToString() = "1", True, False) 'added check
                    items_saved.Add("ExemptionClaim", chkExemptionClaim.Value)
                    SetPolicy(chkExemptionClaim, "ExemptionClaim")
                    lblExemptionClaim.Visible = chkExemptionClaim.Visible

                    SetComboValue(cmbPresentRegion, .Item("AddrRegion").ToString())
                    items_saved.Add("AddrRegion", cmbPresentRegion.Value)
                    SetPolicy(cmbPresentRegion, "AddrRegion")
                    lblPresentRegion.Visible = cmbPresentRegion.Visible

                    txtPresentProvince.Text = .Item("AddrState").ToString()
                    items_saved.Add("AddrState", txtPresentProvince.Text)
                    SetPolicy(txtPresentProvince, "AddrState")
                    lblPresentProvince.Visible = txtPresentProvince.Visible

                    txtPresentBaranggay.Text = .Item("AddrBaranggay").ToString()
                    items_saved.Add("AddrBaranggay", txtPresentBaranggay.Text)
                    SetPolicy(txtPresentBaranggay, "AddrBaranggay")
                    lblPresentBaranggay.Visible = txtPresentBaranggay.Visible

                    txtPresentTelNo.Text = .Item("AddrTelNo").ToString()
                    items_saved.Add("AddrTelNo", txtPresentTelNo.Text)
                    SetPolicy(txtPresentTelNo, "AddrTelNo")
                    lblPresentTelNo.Visible = txtPresentTelNo.Visible

                    txtCityOfBirth.Text = .Item("CityOfBirth").ToString()
                    items_saved.Add("CityOfBirth", txtCityOfBirth.Text)
                    SetPolicy(txtCityOfBirth, "CityOfBirth")
                    lblCityOfBirth.Visible = txtCityOfBirth.Visible

                    txtPlaceOfBirth.Text = .Item("TownOfBirth").ToString()
                    items_saved.Add("TownOfBirth", txtPlaceOfBirth.Text)
                    SetPolicy(txtPlaceOfBirth, "TownOfBirth")
                    lblPlaceOfBirth.Visible = txtPlaceOfBirth.Visible

                    SetComboValue(cmbCountryOfBirth, .Item("CountryOfBirth").ToString())
                    items_saved.Add("CountryOfBirth", cmbCountryOfBirth.Value)
                    SetPolicy(cmbCountryOfBirth, "CountryOfBirth")
                    lblCountryOfBirth.Visible = cmbCountryOfBirth.Visible

                    txtInterestsHobbies.Text = .Item("RecInterestHob").ToString()
                    items_saved.Add("RecInterestHob", txtInterestsHobbies.Text)
                    SetPolicy(txtInterestsHobbies, "RecInterestHob")
                    lblInterestsHobbies.Visible = txtInterestsHobbies.Visible

                    txtAddress5.Text = .Item("Address5").ToString()
                    items_saved.Add("Address5", txtAddress5.Text)
                    SetPolicy(txtAddress5, "Address5")
                    lblAddress5.Visible = txtAddress5.Visible

                    txtAddress6.Text = .Item("Address6").ToString()
                    items_saved.Add("Address6", txtAddress6.Text)
                    SetPolicy(txtAddress6, "Address6")
                    lblAddress6.Visible = txtAddress6.Visible

                    ' jalzate - 12/17/2018
                    ' removed as per addendum
                    'txtPermanentComplexUnitNo.Text = .Item("PermanentComplexUnitNo").ToString()
                    'items_saved.Add("PermanentComplexUnitNo", txtPermanentComplexUnitNo.Text)
                    'SetPolicy(txtPermanentComplexUnitNo, "PermanentComplexUnitNo")
                    'lblPermanentComplexUnitNo.Visible = txtPermanentComplexUnitNo.Visible

                    'txtPermanentComplexName.Text = .Item("PermanentComplexName").ToString()
                    'items_saved.Add("PermanentComplexName", txtPermanentComplexName.Text)
                    'SetPolicy(txtPermanentComplexName, "PermanentComplexName")
                    'lblPermanentComplexName.Visible = txtPermanentComplexName.Visible

                    txtPermanentHouseNumber.Text = .Item("PermanentHouseNumber").ToString()
                    items_saved.Add("PermanentHouseNumber", txtPermanentHouseNumber.Text)
                    SetPolicy(txtPermanentHouseNumber, "PermanentHouseNumber")
                    lblPermanentHouseNumber.Visible = txtPermanentHouseNumber.Visible

                    txtPermanentStreetName.Text = .Item("PermanentStreetName").ToString()
                    items_saved.Add("PermanentStreetName", txtPermanentStreetName.Text)
                    SetPolicy(txtPermanentStreetName, "PermanentStreetName")
                    lblPermanentStreetName.Visible = txtPermanentStreetName.Visible

                    txtPermanentSubdivision.Text = .Item("PermanentSubdivision").ToString()
                    items_saved.Add("PermanentSubdivision", txtPermanentSubdivision.Text)
                    SetPolicy(txtPermanentSubdivision, "PermanentSubdivision")
                    lblPermanentSubdivision.Visible = txtPermanentSubdivision.Visible

                    SetComboValue(cmbPermanentRegion, .Item("Region").ToString())
                    items_saved.Add("Region", cmbPermanentRegion.Value)
                    SetPolicy(cmbPermanentRegion, "Region")
                    lblPermanentRegion.Visible = cmbPermanentRegion.Visible

                    txtPermanentProvince.Text = .Item("State_or_Province").ToString()
                    items_saved.Add("State_or_Province", txtPermanentProvince.Text)
                    SetPolicy(txtPermanentProvince, "State_or_Province")
                    lblPermanentProvince.Visible = txtPermanentProvince.Visible

                    txtPermanentCity.Text = .Item("PermanentCity").ToString()
                    items_saved.Add("PermanentCity", txtPermanentCity.Text)
                    SetPolicy(txtPermanentCity, "PermanentCity")
                    lblPermanentCity.Visible = txtPermanentCity.Visible

                    txtPermanentBaranggay.Text = .Item("PermanentBaranggay").ToString()
                    items_saved.Add("PermanentBaranggay", txtPermanentBaranggay.Text)
                    SetPolicy(txtPermanentBaranggay, "PermanentBaranggay")
                    lblPermanentBaranggay.Visible = txtPermanentBaranggay.Visible

                    txtPermanentPostalCode.Text = .Item("PermanentPostalCode").ToString()
                    items_saved.Add("PermanentPostalCode", txtPermanentPostalCode.Text)
                    SetPolicy(txtPermanentPostalCode, "PermanentPostalCode")
                    lblPermanentPostalCode.Visible = txtPermanentPostalCode.Visible

                    txtPermanentTelNo.Text = .Item("PermanentTelNo").ToString()
                    items_saved.Add("PermanentTelNo", txtPermanentTelNo.Text)
                    SetPolicy(txtPermanentTelNo, "PermanentTelNo")
                    lblPermanentTelNo.Visible = txtPermanentTelNo.Visible

                    txtEmployeeNum.Text = .Item("EmployeeNum").ToString()

                    txtEmployeeNum.Visible = GetArrayItem(UDetails.Template, "ePersonal.EmployeeNum")

                    lblEmployeeNum.Visible = txtEmployeeNum.Visible

                    txtPreferredName.Text = .Item("PreferredName").ToString()

                    items_saved.Add("PreferredName", txtPreferredName.Text)

                    SetPolicy(txtPreferredName, "PreferredName")

                    lblPreferredName.Visible = txtPreferredName.Visible
                    SetComboValue(cmbTitle, .Item("Title").ToString())

                    items_saved.Add("Title", cmbTitle.Value)

                    SetPolicy(cmbTitle, "Title")

                    lblTitle.Visible = cmbTitle.Visible

                    txtFirstName.Text = .Item("FirstName").ToString()

                    items_saved.Add("FirstName", txtFirstName.Text)

                    SetPolicy(txtFirstName, "FirstName")

                    lblFirstName.Visible = txtFirstName.Visible

                    txtSurname.Text = .Item("Surname").ToString()

                    items_saved.Add("Surname", txtSurname.Text)

                    SetPolicy(txtSurname, "Surname")

                    lblSurname.Visible = txtSurname.Visible

                    txtIDNum.Text = .Item("IDNum").ToString()

                    items_saved.Add("IDNum", txtIDNum.Text)

                    SetPolicy(txtIDNum, "IDNum")

                    lblIDNum.Visible = txtIDNum.Visible

                    SetComboValue(cmbSex, .Item("Sex").ToString())

                    items_saved.Add("Sex", cmbSex.Value)

                    SetPolicy(cmbSex, "Sex")

                    lblSex.Visible = cmbSex.Visible

                    SetComboValue(cmbNationality, .Item("Nationality").ToString())

                    items_saved.Add("Nationality", cmbNationality.Value)

                    SetPolicy(cmbNationality, "Nationality")

                    lblNationality.Visible = cmbNationality.Visible

                    If (Not IsNull(.Item("BirthDate"))) Then dteBirthDate.Value = .Item("BirthDate")

                    items_saved.Add("BirthDate", dteBirthDate.Value)

                    SetPolicy(dteBirthDate, "BirthDate")

                    lblBirthDate.Visible = dteBirthDate.Visible

                    SetComboValue(cmbLanguage, .Item("Language").ToString())

                    items_saved.Add("Language", cmbLanguage.Value)

                    SetPolicy(cmbLanguage, "Language")

                    lblLanguage.Visible = cmbLanguage.Visible

                    SetComboValue(cmbReligion, .Item("Religion").ToString())

                    items_saved.Add("Religion", cmbReligion.Value)

                    SetPolicy(cmbReligion, "Religion")

                    lblReligion.Visible = cmbReligion.Visible

                    SetComboValue(cmbEthnicGroup, .Item("EthnicGroup").ToString())

                    items_saved.Add("EthnicGroup", cmbEthnicGroup.Value)

                    SetPolicy(cmbEthnicGroup, "EthnicGroup")

                    lblEthnicGroup.Visible = cmbEthnicGroup.Visible

                    SetComboValue(cmbMaritalStatus, .Item("MaritalStatus").ToString())

                    items_saved.Add("MaritalStatus", cmbMaritalStatus.Value)

                    SetPolicy(cmbMaritalStatus, "MaritalStatus")

                    lblMaritalStatus.Visible = cmbMaritalStatus.Visible

                    SetComboValue(cmbDisability, .Item("Disability").ToString())

                    items_saved.Add("Disability", cmbDisability.Value)

                    SetPolicy(cmbDisability, "Disability")

                    lblDisability.Visible = cmbDisability.Visible

                    txtDisabilityNotes.Text = .Item("DisabilityNotes").ToString()

                    items_saved.Add("DisabilityNotes", txtDisabilityNotes.Text)

                    SetPolicy(txtDisabilityNotes, "DisabilityNotes")

                    lblDisabilityNotes.Visible = txtDisabilityNotes.Visible
                    SetComboValue(cmbBloodType, .Item("BloodType").ToString())

                    items_saved.Add("BloodType", cmbBloodType.Value)

                    SetPolicy(cmbBloodType, "BloodType")

                    lblBloodType.Visible = cmbBloodType.Visible

                    txtAddress1.Text = .Item("Address1").ToString()

                    items_saved.Add("Address1", txtAddress1.Text)

                    SetPolicy(txtAddress1, "Address1")

                    lblAddress1.Visible = txtAddress1.Visible

                    txtSARSAddress1.Text = .Item("AddrUnit").ToString()

                    items_saved.Add("AddrUnit", txtSARSAddress1.Text)

                    SetPolicy(txtSARSAddress1, "AddrUnit")

                    lblSARSAddress1.Visible = txtSARSAddress1.Visible

                    txtPOBox.Text = .Item("POBox").ToString()

                    items_saved.Add("POBox", txtPOBox.Text)

                    SetPolicy(txtPOBox, "POBox")

                    lblPostalAddress1.Visible = txtPOBox.Visible

                    txtAddress2.Text = .Item("Address2").ToString()

                    items_saved.Add("Address2", txtAddress2.Text)

                    SetPolicy(txtAddress2, "Address2")

                    lblAddress2.Visible = txtAddress2.Visible

                    txtSARSAddress2.Text = .Item("AddrComplex").ToString()

                    items_saved.Add("AddrComplex", txtSARSAddress2.Text)

                    SetPolicy(txtSARSAddress2, "AddrComplex")

                    lblSARSAddress2.Visible = txtSARSAddress2.Visible

                    txtPOArea.Text = .Item("POArea").ToString()

                    items_saved.Add("POArea", txtPOArea.Text)

                    SetPolicy(txtPOArea, "POArea")

                    lblPostalAddress2.Visible = txtPOArea.Visible

                    txtAddress3.Text = .Item("Address3").ToString()

                    items_saved.Add("Address3", txtAddress3.Text)

                    SetPolicy(txtAddress3, "Address3")

                    lblAddress3.Visible = txtAddress3.Visible

                    txtSARSAddress3.Text = .Item("AddrStreetNo").ToString()

                    items_saved.Add("AddrStreetNo", txtSARSAddress3.Text)

                    SetPolicy(txtSARSAddress3, "AddrStreetNo")

                    lblSARSAddress3.Visible = txtSARSAddress3.Visible

                    txtPOCode.Text = .Item("POCode").ToString()

                    items_saved.Add("POCode", txtPOCode.Text)

                    SetPolicy(txtPOCode, "POCode")

                    lblPostalAddress3.Visible = txtPOCode.Visible

                    txtAddress4.Text = .Item("Address4").ToString()

                    items_saved.Add("Address4", txtAddress4.Text)

                    SetPolicy(txtAddress4, "Address4")

                    lblAddress4.Visible = txtAddress4.Visible

                    txtSARSAddress4.Text = .Item("AddrStreetName").ToString()

                    items_saved.Add("AddrStreetName", txtSARSAddress4.Text)

                    SetPolicy(txtSARSAddress4, "AddrStreetName")

                    lblSARSAddress4.Visible = txtSARSAddress4.Visible

                    txtSARSAddress5.Text = .Item("AddrSuburb").ToString()

                    items_saved.Add("AddrSuburb", txtSARSAddress5.Text)

                    SetPolicy(txtSARSAddress5, "AddrSuburb")

                    lblSARSAddress5.Visible = txtSARSAddress5.Visible

                    txtSARSAddress6.Text = .Item("AddrCity").ToString()

                    items_saved.Add("AddrCity", txtSARSAddress6.Text)

                    SetPolicy(txtSARSAddress6, "AddrCity")

                    lblSARSAddress6.Visible = txtSARSAddress6.Visible

                    txtSARSAddress7.Text = .Item("AddrZip").ToString()

                    items_saved.Add("AddrZip", txtSARSAddress7.Text)

                    SetPolicy(txtSARSAddress7, "AddrZip")

                    lblSARSAddress7.Visible = txtSARSAddress7.Visible

                    txtOfficeNo.Text = .Item("OfficeNo").ToString()

                    items_saved.Add("OfficeNo", txtOfficeNo.Text)

                    SetPolicy(txtOfficeNo, "OfficeNo")

                    lblOfficeNo.Visible = txtOfficeNo.Visible

                    txtExtensionNo.Text = .Item("ExtensionNo").ToString()

                    items_saved.Add("ExtensionNo", txtExtensionNo.Text)

                    SetPolicy(txtExtensionNo, "ExtensionNo")

                    lblExtensionNo.Visible = txtExtensionNo.Visible

                    txtCellTel.Text = .Item("CellTel").ToString()

                    items_saved.Add("CellTel", txtCellTel.Text)

                    SetPolicy(txtCellTel, "CellTel")

                    'txtCellTel.ValidationSettings.ErrorText = "Invalid cell phone number, e.g. 27708162365 (excluding leading zeros or + signs and must be in international format)."
                    'txtCellTel.ValidationSettings.RegularExpression.ValidationExpression = GetArrayItem(UDetails.Template, "ePersonal.CellTel.Validation")

                    lblCellTel.Visible = txtCellTel.Visible

                    txtHomeTel.Text = .Item("HomeTel").ToString()

                    items_saved.Add("HomeTel", txtHomeTel.Text)

                    SetPolicy(txtHomeTel, "HomeTel")

                    lblHomeTel.Visible = txtHomeTel.Visible

                    txtEmailAddress.Text = .Item("EMailAddress").ToString()

                    items_saved.Add("EmailAddress", txtEmailAddress.Text)

                    SetPolicy(txtEmailAddress, "EmailAddress")

                    txtEmailAddress.ValidationSettings.SetFocusOnError = True
                    txtEmailAddress.ValidationSettings.ErrorDisplayMode = ErrorDisplayMode.ImageWithTooltip
                    txtEmailAddress.ValidationSettings.ErrorText = "Invalid e-mail address, e.g. email@server.com."
                    txtEmailAddress.ValidationSettings.RegularExpression.ValidationExpression = GetArrayItem(UDetails.Template, "ePersonal.EmailAddress.Validation")

                    lblEmailAddress.Visible = txtEmailAddress.Visible

                    txtEmailAddress1.Text = .Item("EMailAddress1").ToString()

                    items_saved.Add("EmailAddress1", txtEmailAddress1.Text)

                    SetPolicy(txtEmailAddress1, "EmailAddress1")

                    'txtEmailAddress1.ValidationSettings.SetFocusOnError = True
                    'txtEmailAddress1.ValidationSettings.ErrorDisplayMode = ErrorDisplayMode.ImageWithTooltip
                    'txtEmailAddress1.ValidationSettings.ErrorText = "Invalid e-mail address, e.g. email@server.com."
                    'txtEmailAddress1.ValidationSettings.RegularExpression.ValidationExpression = GetArrayItem(UDetails.Template, "ePersonal.EmailAddress1.Validation")

                    lblEmailAddress1.Visible = txtEmailAddress1.Visible

                    txtLatitude.Text = .Item("Latitude").ToString()

                    items_saved.Add("Latitude", txtLatitude.Text)

                    SetPolicy(txtLatitude, "Latitude")

                    lblLatitude.Visible = txtLatitude.Visible

                    txtLongitude.Text = .Item("Longitude").ToString()

                    items_saved.Add("Longitude", txtLongitude.Text)

                    SetPolicy(txtLongitude, "Longitude")

                    lblLongitude.Visible = txtLongitude.Visible

                    txtFacsimile.Text = .Item("FaxNo").ToString()

                    items_saved.Add("FaxNo", txtFacsimile.Text)

                    SetPolicy(txtFacsimile, "FaxNo")

                    lblFacsimile.Visible = txtFacsimile.Visible

                End With

            End If

            'If (Not pnlNextofKin.Visible) AndAlso (Not pnlDependants.Visible) AndAlso (Not txtSpouseName.Visible) AndAlso (Not txtSpouseTel.Visible) Then tabPersonal.TabPages(2).Visible = False

        End With

    End Sub

    ''' <summary>
    ''' approval
    ''' </summary>
    ''' <param name="source"></param>
    ''' <param name="e"></param>
    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim ReturnText As String = String.Empty

        Dim SQL As String = ChangedSQL()

        If (SQL.Length > 0) Then

            With UDetails

                Dim bChange As Boolean = GetArrayItem(.Template, "eGeneral.PersonalChange")
                Dim bLogChange As Boolean = GetArrayItem(.Template, "eGeneral.PersonalLogChange")

                Dim NotifyDate As String = Now.ToString("yyyy-MM-dd HH:mm:ss")

                Dim ChangeSQL As String = "update [Personnel] set "
                Dim ChangeSQL1 As String = "update [Personnel1] set "

                Dim iCount As Byte = Convert.ToByte(GetXML(SQL, KeyName:="Count"))

                Dim PolicyID As Int16
                Dim AssemblyID As Byte
                Dim KeyDesc As String
                Dim LabelDesc As String
                Dim ValueF As String
                Dim ValueT As String

                '' set new ess.change value
                For iLoop As Integer = 0 To (iCount - 1)

                    PolicyID = Convert.ToInt16(GetXML(SQL, KeyName:="PolicyID[" & iLoop.ToString("000") & "]"))

                    AssemblyID = Convert.ToByte(GetXML(SQL, KeyName:="AssemblyID[" & iLoop.ToString("000") & "]"))

                    KeyDesc = GetXML(SQL, KeyName:="Key[" & iLoop.ToString("000") & "]").Replace("MaritalStatus", "MaritialStatus")

                    LabelDesc = GetXML(SQL, KeyName:="Label[" & iLoop.ToString("000") & "]")

                    ValueF = GetXML(SQL, KeyName:="ValueF[" & iLoop.ToString("000") & "]")

                    ValueT = GetXML(SQL, KeyName:="ValueT[" & iLoop.ToString("000") & "]")

                    Dim Level() As Object = GetSQLFields("SELECT (CASE WHEN Approval = 0 THEN 0 ELSE ApprovalLevel END) AS [Level] FROM [ess.PolicyItems] WHERE [PolicyID] = '" & PolicyID.ToString() & "' AND Template = '" & .Template & "'")

                    ExecSQL("insert into [ess.Change]([CompanyNum], [EmployeeNum], [NotifyDate], [PolicyID], [AssemblyID], [Template], [ValueF], [ValueT], [Level]) VALUES ('" & .CompanyNum & "', '" & .EmployeeNum & "', '" & NotifyDate & "', " & PolicyID.ToString() & ", " & AssemblyID.ToString() & ", 'Personal Tab', '" & ValueF & "', '" & ValueT & "', '" & Level(0).ToString() & "')")

                    If (bChange AndAlso bLogChange) Then ExecSQL("insert into [PersonnelHistoryLog]([CompanyNum], [EmployeeNum], [ActionDescription], [ActionDate], [ChangedFrom], [ChangedTo], [ChangedBy], [Remarks]) values('" & .CompanyNum & "', '" & .EmployeeNum & "', '" & LabelDesc & "', '" & NotifyDate & "', '" & ValueF & "', '" & ValueT & "', '" & .UserID & "', 'ESS: Changed by User')")

                    If (FindPolicyTableName(PolicyID) = "Personnel1") Then 'amanriza - Added check to identify which table that policy resides in.
                        ChangeSQL1 &= "[" & KeyDesc & "] = '" & ValueT & "'"
                        If (iLoop < (iCount - 1)) Then
                            ChangeSQL1 &= ","
                        End If
                    Else
                        ChangeSQL &= "[" & KeyDesc & "] = '" & ValueT & "'"
                        If (iLoop < (iCount - 1)) Then
                            ChangeSQL &= ","
                        End If
                    End If

                Next

                If (ChangeSQL.Substring(ChangeSQL.Length - 1, 1) = ",") Then 'amanriza - check if the last char is ',' and remove it.
                    ChangeSQL = ChangeSQL.Remove(ChangeSQL.Length - 1)
                End If
                If (ChangeSQL1.Substring(ChangeSQL1.Length - 1, 1) = ",") Then
                    ChangeSQL1 = ChangeSQL1.Remove(ChangeSQL1.Length - 1)
                End If


                If (ChangeSQL1 = "update [Personnel1] set ") Then
                    ChangeSQL = String.Empty
                Else
                    ChangeSQL &= " WHERE ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')"
                End If
                If (ChangeSQL1 = "update [Personnel] set ") Then
                    ChangeSQL1 = String.Empty
                Else
                    ChangeSQL1 &= " WHERE ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')" 'amanriza - added filter for ChangeSQL1 query. 

                End If

                ChangeSQL = ChangeSQL + "; " + ChangeSQL1 'combine to queries to execute as one.
                If (bChange) Then 'proceed if personelChange policy is set to true

                    If (ExecSQL(ChangeSQL) = True) Then

                        If (ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & .CompanyNum & "', '" & .EmployeeNum & "', 0, 'Change', 'Notify', 'Start', 'Start', '" & NotifyDate & "'")) Then

                            ClearPersonalCache(Session.SessionID)

                            ReturnText = "tasks.aspx tools/index.aspx"

                        End If

                    End If

                Else

                    '(0) - email
                    '(1) - for approval
                    '(2) - auto approve.
                    Dim objUserData() As Object = GetSQLFields("SELECT A.EMailAddress, ISNULL((SELECT TOP(1) 1 FROM [ess.Change] WHERE CompanyNum = A.CompanyNum AND EmployeeNum = A.EmployeeNum AND Level > 0 AND NotifyDate = '" & NotifyDate & "'),0) AS [ForApproval], ISNULL((SELECT TOP(1) 1 FROM [ess.Change] WHERE CompanyNum = A.CompanyNum AND EmployeeNum = A.EmployeeNum AND Level = 0 AND NotifyDate = '" & NotifyDate & "'),0) AS [AutoApproved] FROM Personnel AS A WHERE A.CompanyNum = '" & .CompanyNum & "' AND A.EmployeeNum = '" & .EmployeeNum & "'")

                    '' EXEC - has email notif
                    '' EXECUTE - no email notif
                    If (ExecSQL(IIf(objUserData(1).ToString() <> 0, "EXEC", "EXECUTE") & " [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & .CompanyNum & "', '" & .EmployeeNum & "', 0, 'Change', 'Approve', 'Start', 'Start', '" & NotifyDate & "'")) Then

                        ClearPersonalCache(Session.SessionID)

                        ReturnText = "tasks.aspx tools/index.aspx"

                    End If '' has auto approve

                    If objUserData(2).ToString() <> 0 Then

                        Dim objPathData() As Object = GetSQLFields("SELECT PathID FROM [ess.Change] WHERE CompanyNum = '" & .CompanyNum & "' AND EmployeeNum = '" & .EmployeeNum & "' AND NotifyDate = '" & NotifyDate & "'") '' get path id

                        Dim EmailPathData() As Object = GetPathLU(objPathData(0).ToString())

                        ExecSQL("EXECUTE [ess.Approve] '" & Session("LoggedOn").CompanyNum & "','" & Session("LoggedOn").EmployeeNum & "','" & objPathData(0).ToString() & "',0,''")

                        SendEmailThread(New Object() {ServerPath, GetEmailID("Change: Auto-Approve"), "<SendTo=" & objUserData(0).ToString() & "><CC=><BCC=>", String.Empty, False, EmailPathData, objPathData(0).ToString()})

                    End If

                End If

            End With

        Else

            ClearPersonalCache(Session.SessionID)

            ReturnText = "tasks.aspx tools/index.aspx"

        End If

        e.Result = ReturnText

    End Sub

    Private Sub dgView_001_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_001.CustomJSProperties, dgView_002.CustomJSProperties, dgView_003.CustomJSProperties, dgView_004.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

    End Sub

    Private Sub dgView_001_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_001.RowDeleting, dgView_002.RowDeleting, dgView_003.RowDeleting, dgView_004.RowDeleting

        Dim SQLAudit As String = String.Empty

        If (sender.Equals(dgView_001)) Then

            SQLAudit = "<Tablename=OtherLanguage><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><Language=" & e.Values("Language").ToString() & ">"

        ElseIf (sender.Equals(dgView_002)) Then

            SQLAudit = "<Tablename=NextOfKin><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><NoK=" & e.Values("NoK").ToString() & ">"

        ElseIf (sender.Equals(dgView_004)) Then

            SQLAudit = "<Tablename=PersonnelAttribute><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><AttributeName=" & e.Values("AttributeName").ToString() & ">"

        Else

            SQLAudit = "<Tablename=Dependants><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><DependName=" & e.Values("DependName").ToString() & ">"

        End If

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

        End If

    End Sub

    Private Sub dgView_001_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_001.RowInserting, dgView_002.RowInserting, dgView_003.RowInserting, dgView_004.RowInserting

        Dim SQLAudit As String = String.Empty

        If (sender.Equals(dgView_001)) Then

            SQLAudit = "<Tablename=OtherLanguage><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        ElseIf (sender.Equals(dgView_002)) Then

            SQLAudit = "<Tablename=NextOfKin><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        ElseIf (sender.Equals(dgView_003)) Then

            SQLAudit = "<Tablename=Dependants><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        ElseIf (sender.Equals(dgView_004)) Then

            SQLAudit = "<Tablename=PersonnelAttribute><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        End If

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            'If (sender.Equals(dgView_003)) Then

            '    Dim xDateTime As String = Now.ToString("yyyy-MM-dd HH:mm:ss")

            '    ExecQuery("INSERT INTO [DependantsForApproval] ([CompanyNum],[EmployeeNum],[DependName],[DepMidName],[Surname],[IDNum],[DoB],[Sex],[ContactNumber],[Nationality],[DepCivilStat],[OnMedicalAid],[DepDeceased],[MedicalAidStartDt],[MedicalAidEndDt],[DepOccupation],[DepEmployer],[DepAddress]) SELECT [CompanyNum],[EmployeeNum],[DependName],[DepMidName],[Surname],[IDNum],[DoB],[Sex],[ContactNumber],[Nationality],[DepCivilStat],[OnMedicalAid],[DepDeceased],[MedicalAidStartDt],[MedicalAidEndDt],[DepOccupation],[DepEmployer],[DepAddress] FROM [Dependants] WHERE [CompanyNum] = '" & UDetails.CompanyNum & "' AND [EmployeeNum] = '" & UDetails.EmployeeNum & "' AND [DependName] = '" & e.NewValues("DependName") & "'; DELETE FROM [Dependants] WHERE [CompanyNum] = '" & UDetails.CompanyNum & "' AND [EmployeeNum] = '" & UDetails.EmployeeNum & "' AND [DependName] = '" & e.NewValues("DependName") & "'")

            '    ExecSQL("EXECUTE [ess.ChangeDependants] '" & UDetails.CompanyNum & "','" & UDetails.EmployeeNum & "','" & xDateTime & "','New Dependant','First Name','','" & e.NewValues("DependName").ToString() & "','" & e.NewValues("DependName").ToString() & "'")

            '    ExecSQL("EXECUTE [ess.WFProc] '" & UDetails.CompanyNum & "', '" & UDetails.EmployeeNum & "', '" & UDetails.CompanyNum & "', '" & UDetails.EmployeeNum & "', 0, 'Change', 'Approve', 'Start', 'Start', '" & xDateTime & "'")

            '    ExecSQL("UPDATE A SET A.PathID = B.PathID FROM [DependantsForApproval] AS A INNER JOIN [ess.Change] AS B ON A.CompanyNum = B.CompanyNum AND A.EmployeeNum = B.EmployeeNum AND A.DependName = B.AdditionalFilter WHERE A.[CompanyNum] = '" & UDetails.CompanyNum & "' AND A.[EmployeeNum] = '" & UDetails.EmployeeNum & "' AND A.[DependName] = '" & e.NewValues("DependName") & "'")

            '    Dim objPathData() As Object = GetSQLFields("SELECT PathID FROM [ess.Change] WHERE CompanyNum = '" & UDetails.CompanyNum & "' AND EmployeeNum = '" & UDetails.EmployeeNum & "' AND NotifyDate = '" & xDateTime & "'")

            '    Dim objUserData() As Object = GetSQLFields("SELECT A.UserEmail, B.EMailAddress FROM [ess.Path] AS A INNER JOIN [Personnel] AS B ON A.OriginatorCompanyNum = B.CompanyNum AND A.OriginatorEmployeeNum = B.EmployeeNum WHERE A.ID = " & objPathData(0).ToString() & "")

            '    Dim EmailPathData() As Object = GetPathLU(objPathData(0).ToString())

            '    SendEmailThread(New Object() {ServerPath, GetEmailID("Change: Notify First Approver"), "<SendTo=" & objUserData(0).ToString() & "><CC=" & objUserData(1).ToString() & "><BCC=>", String.Empty, False, EmailPathData, objPathData(0).ToString()})

            'End If

            'If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, UDetails.UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_001_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_001.RowUpdating, dgView_002.RowUpdating, dgView_003.RowUpdating, dgView_004.RowUpdating

        Dim SQLAudit As String = String.Empty

        If (sender.Equals(dgView_001)) Then

            SQLAudit = "<Tablename=OtherLanguage><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><Language;2=" & e.OldValues("Language").ToString() & ">"

            e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        ElseIf (sender.Equals(dgView_002)) Then

            SQLAudit = "<Tablename=NextOfKin><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><NoK;2=" & e.OldValues("NoK").ToString() & ">"

            e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        ElseIf (sender.Equals(dgView_003)) Then

            Dim OldColumnValue As Object = Nothing
            Dim NewColumnValue As Object = Nothing
            Dim xDateTime As String = Now.ToString("yyyy-MM-dd HH:mm:ss")

            For Each xColumn As GridViewColumn In dgView_003.Columns

                If TypeOf xColumn Is GridViewDataColumn Then

                    Dim xDataColumn As GridViewDataColumn = CType(xColumn, GridViewDataColumn)

                    If Not (xDataColumn.FieldName = "DoB") Or (xDataColumn.FieldName = "MedicalAidStartDt") Or (xDataColumn.FieldName = "MedicalAidEndDt") Then

                        If (e.OldValues(xDataColumn.FieldName) <> e.NewValues(xDataColumn.FieldName)) Then

                            Dim xTry As String = e.OldValues(xDataColumn.FieldName).ToString()
                            Dim yTry As String = e.NewValues(xDataColumn.FieldName).ToString()

                            ExecSQL("EXECUTE [ess.ChangeDependants] '" & UDetails.CompanyNum & "','" & UDetails.EmployeeNum & "','" & xDateTime & "','" & xDataColumn.FieldName.ToString() & "','" & xDataColumn.Caption.ToString() & "','" & xTry & "','" & yTry & "','" & e.OldValues("DependName").ToString() & "'")

                        End If

                    End If

                End If

            Next xColumn

            ExecSQL("EXEC [ess.WFProc] '" & UDetails.CompanyNum & "', '" & UDetails.EmployeeNum & "', '" & UDetails.CompanyNum & "', '" & UDetails.EmployeeNum & "', 0, 'Change', 'Approve', 'Start', 'Start', '" & xDateTime & "'")

            e.Cancel = True

        ElseIf (sender.Equals(dgView_004)) Then

            SQLAudit = "<Tablename=PersonnelAttribute><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><AttributeName;2=" & e.OldValues("AttributeName").ToString() & ">"

            e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        End If

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_001_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_001.RowValidating, dgView_002.RowValidating, dgView_003.RowValidating, dgView_004.RowValidating

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Dim dgExports As ASPxGridViewExporter = Nothing

        Try

            dgExports = tabPersonal.TabPages(tabPersonal.ActiveTabIndex).FindControl(source.ID.ToString().Replace("mnuExport", "dgExports"))

            If (Not IsNull(dgExports)) Then

                Dim xFilePath As String = tabPersonal.TabPages(tabPersonal.ActiveTabIndex).Text & " [" & Date.Today.ToString("yyyy-MM-dd") & "]"

                Select Case e.Item.Name

                    Case "mnuExp_CSV"
                        dgExports.WriteCsvToResponse(xFilePath)

                    Case "mnuExp_XLS"
                        dgExports.WriteXlsToResponse(xFilePath)

                    Case "mnuExp_XLSX"
                        dgExports.WriteXlsxToResponse(xFilePath)

                    Case "mnuExp_RTF"
                        dgExports.WriteRtfToResponse(xFilePath)

                    Case "mnuExp_PDF"
                        dgExports.WritePdfToResponse(xFilePath)

                End Select

            End If

        Catch ex As Exception

        Finally

            If (Not IsNull(dgExports)) Then

                dgExports.Dispose()

                dgExports = Nothing

            End If

        End Try

    End Sub

#End Region

#Region "Relatives"
    Private Sub dgView_Relatives_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_Relatives.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

    End Sub

    Private Sub dgView_Relatives_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_Relatives.RowInserting

        Dim SQLAudit As String = String.Empty

        SQLAudit = "<Tablename=RelWorkingInTMP><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_Relatives_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_Relatives.RowUpdating

        Dim SQLAudit As String = String.Empty

        SQLAudit = "<Tablename=RelWorkingInTMP><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_Relatives_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_Relatives.RowDeleting

        Dim SQLAudit As String = String.Empty

        SQLAudit = "<Tablename=RelWorkingInTMP><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub
#End Region
End Class