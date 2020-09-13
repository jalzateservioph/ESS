Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxGridView.Export

Partial Public Class organisational
    Inherits System.Web.UI.Page

    Private bEditable As Boolean = True
    Private dOrganizational As DataTable = Nothing

    Private CancelEdit As Boolean
    Private UDetails As Users = Nothing

#Region " *** Web Form Functions *** "

    Private Function CalcDate(ByVal dteStart As Date, ByVal dteEnd As Object, Optional ByVal Terminated As Boolean = False) As String

        If (IsDate(dteStart)) Then

            If (Not IsDate(dteEnd)) Or (Not Terminated) Then dteEnd = Today

            Dim YOS As Integer = Convert.ToInt32(DateDiff("m", dteStart, dteEnd) / 12)

            If (dteStart.AddMonths(YOS * 12) > dteEnd) Then YOS -= 1

            Dim MOS As Integer = Convert.ToInt32(DateDiff("m", dteStart, dteEnd) - (YOS * 12))

            If (dteStart.AddMonths((YOS * 12) + MOS) > dteEnd) Then MOS -= 1

            If (YOS < 0) Or (MOS < 0) Then

                Return "Invalid date intervals"

            Else

                Return YOS.ToString() & " yrs, " & MOS.ToString() & " mnths"

            End If

        Else

            Return "Invalid date intervals"

        End If

    End Function

    Private Function ChangedSQL() As String

        'This function gets all the changes of the 
        Dim SQL As String = String.Empty
        Dim bIndex As Byte = 0

        'Retrieves all the controls information
        Dim dChanges As DataTable = GetSQLDT("select [ess.Policy].[ID] as [ID], [Key], [Name], [Label], [AssemblyID], [TypeName], [Property] from [ess.Policy] left outer join [AssemblyLU] on [ess.Policy].[AssemblyID] = [AssemblyLU].[ID] where (not [TypeName] = 'DevExpress.Web.ASPxGridView.ASPxGridView' and [GroupID] = 7 and not [Key] in('YearsServiceG', 'YearsServiceA')) order by [ess.Policy].[ID]")

        If (IsData(dChanges) AndAlso IsData(dOrganizational)) Then

            Dim objEmpty() As Object = {DBNull.Value, DBNull.Value}
            Dim objControl As Object = Nothing
            Dim objValue() As Object = {Nothing, Nothing}

            For iLoop As Integer = 0 To (dChanges.Rows.Count - 1)

                With dChanges.Rows(iLoop)
                    'finds the controls and store it in thi object variable
                    objControl = tabOrganizational.FindControl(.Item("Name").ToString())

                    If (Not IsNull(objControl) AndAlso dOrganizational.Columns.Contains(.Item("Key").ToString())) Then

                        objValue(0) = Nothing

                        If (.Item("Property").ToString().Length > 0) Then objValue(0) = CallByName(objControl, .Item("Property").ToString(), CallType.Get)

                        objValue(1) = dOrganizational.Rows(0).Item(.Item("Key").ToString())

                        'added a condition where null values are replaced by dbnull
                        If (objValue(0) = Nothing) Then objValue(0) = DBNull.Value
                        'amanriza end
                        If (Not objValue(0).Equals(objValue(1)) AndAlso Not objValue(0).Equals("<select>") AndAlso Not (objValue(0).Equals(String.Empty) And IsNull(objValue(1)))) Then

                            If (.Item("TypeName").ToString() = "DevExpress.Web.ASPxEditors.ASPxDateEdit") Then

                                If (IsDate(objValue(0))) Then objValue(0) = Convert.ToDateTime(objValue(0)).ToString("yyyy-MM-dd HH:mm:ss")

                                If (IsDate(objValue(1))) Then objValue(1) = Convert.ToDateTime(objValue(1)).ToString("yyyy-MM-dd HH:mm:ss")

                            End If

                            If (IsNull(objValue(1))) Then objValue(1) = "{null}"

                            SQL &= "<PolicyID[" & bIndex.ToString("000") & "]=" & .Item("ID").ToString() & "><AssemblyID[" & bIndex.ToString("000") & "]=" & .Item("AssemblyID").ToString() & "><Key[" & bIndex.ToString("000") & "]=" & .Item("Key").ToString() & "><Label[" & bIndex.ToString("000") & "]=" & .Item("Label").ToString() & "><ValueF[" & bIndex.ToString("000") & "]=" & objValue(1) & "><ValueT[" & bIndex.ToString("000") & "]=" & objValue(0) & ">"

                            bIndex += 1

                        End If

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

    Private Sub ClearOrganizationalCache(ByVal SessionID As String)

        ClearFromCache("Data.Organizational.CostCentre." & Session.SessionID)

        ClearFromCache("Data.Organizational.ReportsTo." & Session.SessionID)

    End Sub

    Private Sub GetExpValues(ByVal sender As Object, ByVal e As Object)

        e.NewValues("Remarks") = GetExpControl(sender, "Remarks", "Text")

    End Sub

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        LoadExpDS(dsContracts, "select [ContractName] from [ContractLU] order by [ContractName]")

        LoadExpDS(dsContractTypes, "select [ContractType] from [ContractTypeLU] order by [ContractType]")

        LoadExpDS(dsContractStatus, "select distinct [ContractStatus] from [Contracting] order by [ContractStatus]")

        LoadExpDS(dsCompany, "select distinct [CompanyName] from [Contracting] order by [CompanyName]")

        LoadExpDS(dsContractCostCentre, "select distinct [CostCentre] from [Contracting] order by [CostCentre]")

        LoadExpDS(dsContractDept, "select distinct [DeptName] from [Contracting] order by [DeptName]")

        LoadExpDS(dsContractJobTitle, "select distinct [JobTitle] from [Contracting] order by [JobTitle]")

        LoadExpDS(dsContractJobGrade, "select distinct [JobGrade] from [Contracting] order by [JobGrade]")

        With UDetails

            Select Case tabOrganizational.ActiveTabIndex

                Case 0
                    If (ClearCache) Then ClearFromCache("Data.Organizational.CostCentre." & Session.SessionID)

                    LoadExpGrid(Session, dgView_001, "Organisational Tab", "<Tablename=PersonnelCostCentre><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [CostCentreCompanyNum] + ' ' + [CostCentre]><Columns=(select [CompanyName] from [Company] where ([CompanyNum] = [CostCentreCompanyNum])) as [Company], [CostCentre], [Allocation]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Organizational.CostCentre." & Session.SessionID)


                Case 1
                    If (ClearCache) Then ClearFromCache("Data.Organizational.ReportsTo." & Session.SessionID)

                    LoadExpGrid(Session, dgView_002, "Organisational Tab", "<Tablename=ReportsTo><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [ReportToCompNum] + ' ' + [ReportToEmpNum] + ' ' + [ReportsToType]><Columns=[CompanyNum], [EmployeeNum], [ReportToCompNum], [ReportToEmpNum], (select (isnull([Title], '') + ' ' + isnull([PreferredName], '') + ' ' + [Surname]) from [Personnel] where ([CompanyNum] + ':' + [EmployeeNum] = [ReportToCompNum] + ':' + [ReportToEmpNum])) as [Employee], [ReportsToType]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Organizational.ReportsTo." & Session.SessionID)


                Case 2
                    If (ClearCache) Then ClearFromCache("Data.Organizational.Contracts." & Session.SessionID)

                    LoadExpGrid(Session, dgView_003, "Organisational Tab", "<Tablename=Contracting><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [StartDate], 120) + ' ' + [ContractName]><Columns=[ContractName], [StartDate], [EndDate], [CurrentContract], [ContractType], [ContractStatus], [CompanyName], [DeptName], [CostCentre], [JobTitle], [JobGrade], [Salary], [Remarks]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Organizational.Contracts." & Session.SessionID)


                Case 3
                    If (ClearCache) Then ClearFromCache("Data.Organizational.Movement." & Session.SessionID)

                    Dim SQLQuery As String = ""

                    Dim BalanceType As String = ")>"

                    If (Not IsNull(GetArrayItem(.Template, "eGeneral.PersonnelMovement"))) Then

                        BalanceType = GetArrayItem(.Template, "eGeneral.PersonnelMovement")

                        BalanceType = " and [ActionDescription] not in ('" & GetDataText(BalanceType.Replace(", ", ",")).Replace(",", "', '") & "'))>"

                        SQLQuery = "<Tablename=PersonnelHistoryLog><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + CONVERT(NVARCHAR(19), [ActionDate], 120) + ' ' + [ActionDescription]><Columns=[ActionDescription], [ActionDate], [ActionDate], [ChangedFrom], [ChangedTo]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "'" & BalanceType & ")>"

                    Else

                        SQLQuery = "<Tablename=PersonnelHistoryLog><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + CONVERT(NVARCHAR(19), [ActionDate], 120) + ' ' + [ActionDescription]><Columns=[ActionDescription], [ActionDate], [ActionDate], [ChangedFrom], [ChangedTo]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>"

                    End If

                    LoadExpGrid(Session, dgView_Movement, "Organisational Tab", SQLQuery, "Data.Organizational.Movements." & Session.SessionID)


            End Select

            If (Not IsPostBack) Then
                If (Not dgView_002.Columns("edit").Visible) Then
                    bEditable = False
                    'cmdSubmit.Visible = False
                    'cmdSubmit.Enabled = False
                End If


                'If (Not dgView_002.Columns("edit").Visible) Then
                '    bEditable = False
                '    cmdSubmit.Visible = False
                '    cmdSubmit.Enabled = False
                'ElseIf (tabOrganizational.ActiveTabIndex = 1) Then
                '    bEditable = True
                '    cmdSubmit.Visible = False
                '    cmdSubmit.Enabled = False
                'Else
                '    bEditable = True
                '    cmdSubmit.Visible = True
                'End If

                'tabOrganizational.TabPages(1).Visible = GetArrayItem(.Template, "eOrganizational.ReportsTo")

                Dim Editable As Boolean = False

                Editable = GetArrayItem(.Template, "eOrganizational.ReportsTo.Editable")

                If (Not Editable) AndAlso ((dgView_002.Columns("edit").Visible) Or (dgView_002.Columns("delete").Visible)) Then

                    dgView_002.Columns("edit").Visible = Editable

                    dgView_002.Columns("delete").Visible = Editable

                    dgView_002.Settings.ShowStatusBar = DevExpress.Web.ASPxGridView.GridViewStatusBarMode.Hidden

                End If


                Editable = GetArrayItem(.Template, "eOrganizational.Contracting.Editable")

                If (Not Editable) AndAlso ((dgView_003.Columns("edit").Visible) Or (dgView_003.Columns("delete").Visible)) Then

                    dgView_003.Columns("edit").Visible = Editable

                    dgView_003.Columns("delete").Visible = Editable

                    dgView_003.Settings.ShowStatusBar = DevExpress.Web.ASPxGridView.GridViewStatusBarMode.Hidden

                End If

                dgView_002.Visible = GetArrayItem(.Template, "eOrganizational.ReportsTo")

                dgView_003.Visible = GetArrayItem(.Template, "eOrganizational.Contracting")

                dgView_Movement.Visible = GetArrayItem(.Template, "eOrganizational.PersonnelMovement")

                'Editable = GetArrayItem(.Template, "eOrganizational.UniformAllocation.Editable")

                ''
                'If (Not dgView_002.Columns("edit").Visible) Then
                '    bEditable = False
                '    cmdSubmit.Visible = False
                '    cmdSubmit.Enabled = False
                'Else
                '    bEditable = True
                '    cmdSubmit.Visible = True
                'End If

                'If (Not dgView_003.Columns("edit").Visible) Then
                '    bEditable = False
                '    cmdSubmit.Visible = False
                '    cmdSubmit.Enabled = False
                'Else
                '    bEditable = True
                '    cmdSubmit.Visible = True
                'End If
                If (tabOrganizational.ActiveTabIndex = 0 Or tabOrganizational.ActiveTabIndex = 4) Then
                    cmdSubmit.Visible = True
                    cmdSubmit.Enabled = True
                    cmdSubmit.ClientEnabled = True
                    cmdSubmit.ClientVisible = True
                Else
                    cmdSubmit.Visible = False
                    cmdSubmit.Enabled = False
                    cmdSubmit.ClientEnabled = False
                    cmdSubmit.ClientVisible = False
                End If
            Else
                If (tabOrganizational.ActiveTabIndex = 0 Or tabOrganizational.ActiveTabIndex = 4) Then
                    cmdSubmit.Visible = True
                    cmdSubmit.Enabled = True
                    cmdSubmit.ClientEnabled = True
                    cmdSubmit.ClientVisible = True

                Else
                    cmdSubmit.Visible = False
                    cmdSubmit.Enabled = False
                    cmdSubmit.ClientEnabled = False
                    cmdSubmit.ClientVisible = False
                End If

            End If

        End With

    End Sub

    Private Sub FillComboBox(ByVal cmb As DevExpress.Web.ASPxEditors.ASPxComboBox, ByVal ReportToCompNum As String)

        If (String.IsNullOrEmpty(ReportToCompNum)) Then Return

        LoadExpDS(dsReportToEmpNum, "select [EmployeeNum], (isnull([Title], '') + ' ' + isnull([PreferredName], '') + ' ' + [Surname]) as [Name] from [Personnel] where ([CompanyNum] = '" & GetDataText(ReportToCompNum) & "') order by [Name]")

        cmb.DataBind()

    End Sub

    Private Sub SetPolicy(ByRef cPolicy As Object, ByVal Key As String)

        cPolicy.Visible = GetArrayItem(UDetails.Template, "eOrganizational." & Key)

        cPolicy.Enabled = GetArrayItem(UDetails.Template, "eOrganizational." & Key & ".Editable")

        If (Not bEditable) Then cPolicy.Enabled = False

        If (GetArrayItem(UDetails.Template, "eOrganizational." & Key & ".Required")) Then

            ' jalzate - 05/27/2019
            ' added check to prevent error 
            If IsNothing(cPolicy.GetType().GetProperty("ValidationSettings")) Then
                Return
            End If

            With cPolicy.ValidationSettings

                .ErrorDisplayMode = DevExpress.Web.ASPxEditors.ErrorDisplayMode.ImageWithTooltip

                .SetFocusOnError = True

                .RequiredField.IsRequired = True

                .RequiredField.ErrorText = "This field cannot be empty."

            End With

        End If

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Session("docUnread")) Then

            Response.Redirect("documentmapman.aspx", True)

            Exit Sub

        End If

        If (Not IsPostBack) Then SetEmployeeData(Session, Session("Selected.Value"))

        UDetails = GetUserDetails(Session, "Organisational Tab")

        If (Not dteAppointdate.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom) Then

            dteAppointdate.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom
            dteAppointdate.EditFormatString = GetArrayItem(UDetails.Template, "eGeneral.DateFormat")

        End If

        If (Not dteDateJoinedGroup.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom) Then

            dteDateJoinedGroup.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom
            dteDateJoinedGroup.EditFormatString = GetArrayItem(UDetails.Template, "eGeneral.DateFormat")

        End If

        ' create evevnts



        LoadExpDS(dsDivision, "select distinct [Division] as [Name] from [Company] order by [Division]")

        LoadExpCmb(cmbDivision, "<select>")

        LoadExpDS(dsDepartment, "select distinct [SubDivision] as [Name] from [Company] order by [SubDivision]")

        LoadExpCmb(cmbDepartment, "<select>")

        LoadExpDS(dsSection, "select distinct [SubSubDivision] as [Name] from [Company] order by [SubSubDivision]")

        LoadExpCmb(cmbSection, "<select>")

        LoadExpDS(dsAppointype, "select [AppointmentType] from [AppointmentTypeLU] order by [AppointmentType]")

        LoadExpCmb(cmbAppointype, "<select>")

        LoadExpDS(dsSkill_Level, "select [OccupCategory] from [OccupCategoryLU] order by [OccupCategory]")

        LoadExpCmb(cmbSkill_Level, "<select>")

        'LoadExpDS(dsPosition, "select [Position] from [PositionLU] order by [Position]")

        'LoadExpCmb(cmbPosition, "<select>")

        LoadExpDS(dsReportToCompNum, "select [CompanyName] + ' [' + [CompanyNum] + ']' as [CompanyName], [CompanyNum] from [Company] order by [CompanyName]")

        LoadExpDS(dsReportsToType, "select distinct [ReportsToType] from [ReportsTo] order by [ReportsToType]")

        LoadData()

        With UDetails

            LoadExpDS(dsCostCentre, "select [CostCentre] from [CostCentreLU] where ([CompanyNum] = '" & .CompanyNum & "') order by [CostCentre]")

            LoadExpCmb(cmbCostCentre, "<select>")

            'LoadExpDS(dsDeptName, "select [DeptName] from [Department] where ([CompanyNum] = '" & .CompanyNum & "') order by [DeptName]")

            'LoadExpCmb(cmbDeptName, "<select>")

            LoadExpDS(dsJobGrade, "select [JobGrade] from [JobGrade] where ([CompanyNum] = '" & .CompanyNum & "') order by [JobGrade]")

            LoadExpCmb(cmbJobGrade, "<select>")

            LoadExpDS(dsJobTitle, "select [IndividualJobTitle] as JobTitle from [IndividualJobTitle] order by [IndividualJobTitle]")

            LoadExpCmb(cmbJobTitle, "<select>")

            LoadExpDS(dsFixed, "SELECT DISTINCT [Fixed] FROM [FixedLU]")

            LoadExpCmb(cmbFixed, "<select>")

            'LoadExpDS(dsLocation, "select [Location] from [LocationLU] where ([CompanyNum] = '" & .CompanyNum & "') order by [Location]")

            'LoadExpCmb(cmbLocation, "<select>")

            LoadExpDS(dsShifting, "select [ShiftType] As Shifting from [ShiftTypeLU] where ([CompanyNum] = '" & .CompanyNum & "') order by [ShiftType]")

            LoadExpCmb(cmbShifting, "<select>")

            LoadExpDS(dsCategory, "select [OFOCode] As Category from [OFOCodeLU] order by [OFOCode]")

            LoadExpCmb(cmbCategory, "<select>")

            LoadExpDS(dsWorkAssignment, "select [Category] as WorkAssignment from [LocationCategoryLU] order by [Category]")

            LoadExpCmb(cmbWorkAssignment, "<select>")

            LoadExpDS(dsUnionAffiliation, "select [JobTitle] as UnionAffiliation from [JobTitle] where ([CompanyNum] = '" & .CompanyNum & "') order by [JobTitle]")

            LoadExpCmb(cmbUnionAffiliation, "<select>")

            LoadExpDS(dsShirtSize, "select distinct [AttributeValue] as ShirtSize from [PersonnelAttribute] where ([AttributeName] = 'SHIRT SIZE' and [CompanyNum] = '" & .CompanyNum & "') order by [AttributeValue]")

            LoadExpCmb(cmbShirtSize, "<select>")

            '26/06/2019 amanriza
            'fixed shirtsize combobox returning to its default value upon reload.
            'cmbShirtSize.Text = "<select>"
            'amanriza

            'dOrganizational = GetSQLDT("select q [IndividualJobTitle] as JobTitle, [JobTitle] as UnionAffiliation, [JobGrade], [CostCentre], [OFOCode] as Category, [OFOOccupation] as PayLevel, [ShiftType] as Shifting, [LocationCategory] as WorkAssignment, [DeptName], [Skill_Level], [Appointype], [Position], [Location], [DateJoinedGroup], [Appointdate], [TerminationDate], [Termination] from [Personnel] as [p] left outer join [Personnel1] as [p1] on ([p].[CompanyNum] = [p1].[CompanyNum] and [p].[EmployeeNum] = [p1].[EmployeeNum]) where ([p].[CompanyNum] = '" & .CompanyNum & "' and [p].[EmployeeNum] = '" & .EmployeeNum & "')")

            dOrganizational = GetSQLDT("SELECT * FROM [vwOrganizationalInformation] WHERE ([CompanyNum] = '" & .CompanyNum & "' AND [EmployeeNum] = '" & .EmployeeNum & "')")

            If (Not IsPostBack) AndAlso (IsData(dOrganizational)) Then

                With dOrganizational.Rows(0)
                    'START jlacno
                    SetComboValue(cmbCategory, .Item("Category").ToString())

                    items_saved.Add("Category", cmbCategory.Value)

                    SetPolicy(cmbCategory, "Category")

                    lblCategory.Visible = cmbCategory.Visible

                    LoadExpDS(dsPayLevel, "select [Occupation] As PayLevel from [OFOCodeOccupLU] where ([OFOCode] = '" & .Item("Category").ToString() & "') order by [Occupation]")

                    LoadExpCmb(cmbPayLevel, "<select>")

                    SetComboValue(cmbPayLevel, .Item("PayLevel").ToString())

                    items_saved.Add("PayLevel", cmbPayLevel.Value)

                    SetPolicy(cmbPayLevel, "PayLevel")

                    lblPayLevel.Visible = cmbPayLevel.Visible

                    SetComboValue(cmbShifting, .Item("Shifting").ToString())

                    items_saved.Add("Shifting", cmbShifting.Value)

                    SetPolicy(cmbShifting, "Shifting")

                    lblShifting.Visible = cmbShifting.Visible

                    SetComboValue(cmbWorkAssignment, .Item("WorkAssignment").ToString())

                    items_saved.Add("WorkAssignment", cmbWorkAssignment.Value)

                    SetPolicy(cmbWorkAssignment, "WorkAssignment")

                    lblWorkAssignment.Visible = cmbWorkAssignment.Visible

                    SetComboValue(cmbUnionAffiliation, .Item("UnionAffiliation").ToString())

                    items_saved.Add("UnionAffiliation", cmbUnionAffiliation.Value)

                    SetPolicy(cmbUnionAffiliation, "UnionAffiliation")

                    lblUnionAffiliation.Visible = cmbUnionAffiliation.Visible
                    'END jlacno 

                    SetComboValue(cmbJobTitle, .Item("JobTitle").ToString())

                    items_saved.Add("JobTitle", cmbJobTitle.Value)

                    SetPolicy(cmbJobTitle, "JobTitle")

                    lblJobTitle.Visible = cmbJobTitle.Visible

                    SetComboValue(cmbJobGrade, .Item("JobGrade").ToString())

                    items_saved.Add("JobGrade", cmbJobGrade.Value)

                    SetPolicy(cmbJobGrade, "JobGrade")

                    lblJobGrade.Visible = cmbJobGrade.Visible

                    SetComboValue(cmbCostCentre, .Item("CostCentre").ToString())

                    items_saved.Add("CostCentre", cmbCostCentre.Value)

                    SetPolicy(cmbCostCentre, "CostCentre")

                    SetPolicy(cmdCostCentre, "CostCentreAlloc")

                    lblCostCentre.Visible = cmbCostCentre.Visible

                    'SetComboValue(cmbDeptName, .Item("DeptName").ToString())

                    'items_saved.Add("DeptName", cmbDeptName.Value)

                    'SetPolicy(cmbDeptName, "DeptName")

                    'lblDeptName.Visible = cmbDeptName.Visible

                    SetComboValue(cmbSkill_Level, .Item("Skill_Level").ToString())

                    items_saved.Add("Skill_Level", cmbSkill_Level.Value)

                    SetPolicy(cmbSkill_Level, "Skill_Level")

                    lblSkill_Level.Visible = cmbSkill_Level.Visible

                    SetComboValue(cmbAppointype, .Item("Appointype").ToString())

                    items_saved.Add("Appointype", cmbAppointype.Value)

                    SetPolicy(cmbAppointype, "Appointype")

                    lblAppointype.Visible = cmbAppointype.Visible

                    'SetComboValue(cmbPosition, .Item("Position").ToString())

                    'items_saved.Add("Position", cmbPosition.Value)

                    'SetPolicy(cmbPosition, "Position")

                    'lblPosition.Visible = cmbPosition.Visible

                    'SetComboValue(cmbLocation, .Item("Location").ToString())

                    'items_saved.Add("Location", cmbLocation.Value)

                    'SetPolicy(cmbLocation, "Location")

                    'lblLocation.Visible = cmbLocation.Visible

                    txtBlazer.Value = .Item("Blazer")
                    SetPolicy(txtBlazer, "Blazer")
                    lblBlazer.Visible = txtBlazer.Visible


                    txtSkirt.Value = .Item("Skirt")
                    SetPolicy(txtSkirt, "Skirt")
                    lblSkirt.Visible = txtSkirt.Visible

                    txtBlouse.Value = .Item("Blouse")

                    SetPolicy(txtBlouse, "Blouse")

                    lblBlouse.Visible = txtBlouse.Visible

                    txtSlacks.Value = .Item("Slacks")

                    SetPolicy(txtSlacks, "Slacks")

                    lblSlacks.Visible = txtSlacks.Visible

                    txtShirtjack.Value = .Item("Shirtjack")

                    SetPolicy(txtShirtjack, "Shirtjack")

                    lblShirtjack.Visible = txtShirtjack.Visible

                    txtShirtjackPants.Value = .Item("ShirtjackPants")

                    SetPolicy(txtShirtjackPants, "ShirtjackPants")

                    lblShirtjackPants.Visible = txtShirtjackPants.Visible

                    txtPoloBarong.Value = .Item("PoloBarong")

                    SetPolicy(txtPoloBarong, "PoloBarong")

                    lblPoloBarong.Visible = txtPoloBarong.Visible

                    txtRepellantPants.Value = .Item("RepellantPants")

                    SetPolicy(txtRepellantPants, "RepellantPants")

                    lblRepellantPants.Visible = txtRepellantPants.Visible

                    txtPoloShirt.Value = .Item("PoloShirt")

                    SetPolicy(txtPoloShirt, "PoloShirt")

                    lblPoloShirt.Visible = txtPoloShirt.Visible

                    txtMaongPants.Value = .Item("MaongPants")

                    SetPolicy(txtMaongPants, "MaongPants")

                    lblMaongPants.Visible = txtMaongPants.Visible

                    txtTShirt.Value = .Item("TShirt")

                    SetPolicy(txtTShirt, "TShirt")

                    lblTShirt.Visible = txtTShirt.Visible

                    txtOveralls.Value = .Item("Overalls")

                    SetPolicy(txtOveralls, "Overalls")

                    lblOveralls.Visible = txtOveralls.Visible

#Region "REVISED UNIFORM FIELDS"

                    txtMALE_MGRSpecialPoloshirt.Value = .Item("MALE_MGRSpecialPoloshirt")
                    SetPolicy(txtMALE_MGRSpecialPoloshirt, "MALE_MGRSpecialPoloshirt")
                    lblMALE_MGRSpecialPoloshirt.Visible = txtMALE_MGRSpecialPoloshirt.Visible

                    txtMALE_SUSpecialPoloshirt.Value = .Item("MALE_SUSpecialPoloshirt")
                    SetPolicy(txtMALE_SUSpecialPoloshirt, "MALE_SUSpecialPoloshirt")
                    lblMALE_SUSpecialPoloshirt.Visible = txtMALE_SUSpecialPoloshirt.Visible

                    txtMALE_Polo.Value = .Item("MALE_Polo")
                    SetPolicy(txtMALE_Polo, "MALE_Polo")
                    lblMALE_Polo.Visible = txtMALE_Polo.Visible

                    txtMALE_MaleShirtpackShort.Value = .Item("MALE_MaleShirtpackShort")
                    SetPolicy(txtMALE_MaleShirtpackShort, "MALE_MaleShirtpackShort")
                    lblMALE_MaleShirtpackShort.Visible = txtMALE_MaleShirtpackShort.Visible

                    txtMALE_MaleShirtPackLong.Value = .Item("MALE_MaleShirtPackLong")
                    SetPolicy(txtMALE_MaleShirtPackLong, "MALE_MaleShirtPackLong")
                    lblMALE_MaleShirtPackLong.Visible = txtMALE_MaleShirtPackLong.Visible

                    txtMALE_MaleBlackPants.Value = .Item("MALE_MaleBlackPants")
                    SetPolicy(txtMALE_MaleBlackPants, "MALE_MaleBlackPants")
                    lblMALE_MaleBlackPants.Visible = txtMALE_MaleBlackPants.Visible

                    txtFEMALE_MGRSpecialPoloshirt.Value = .Item("FEMALE_MGRSpecialPoloshirt")
                    SetPolicy(txtFEMALE_MGRSpecialPoloshirt, "FEMALE_MGRSpecialPoloshirt")
                    lblFEMALE_MGRSpecialPoloshirt.Visible = txtFEMALE_MGRSpecialPoloshirt.Visible

                    txtFEMALE_SUSpecialPoloshirt.Value = .Item("FEMALE_SUSpecialPoloshirt")
                    SetPolicy(txtFEMALE_SUSpecialPoloshirt, "FEMALE_SUSpecialPoloshirt")
                    lblFEMALE_SUSpecialPoloshirt.Visible = txtFEMALE_SUSpecialPoloshirt.Visible

                    txtFEMALE_Blouse.Value = .Item("FEMALE_Blouse")
                    SetPolicy(txtFEMALE_Blouse, "FEMALE_Blouse")
                    lblFEMALE_Blouse.Visible = txtFEMALE_Blouse.Visible

                    txtFEMALE_FemaleShirtpackShort.Value = .Item("FEMALE_FemaleShirtpackShort")
                    SetPolicy(txtFEMALE_FemaleShirtpackShort, "FEMALE_FemaleShirtpackShort")
                    lblFEMALE_FemaleShirtpackShort.Visible = txtFEMALE_FemaleShirtpackShort.Visible

                    txtFEMALE_FemaleShirtPackLong.Value = .Item("FEMALE_FemaleShirtPackLong")
                    SetPolicy(txtFEMALE_FemaleShirtPackLong, "FEMALE_FemaleShirtPackLong")
                    lblFEMALE_FemaleShirtPackLong.Visible = txtFEMALE_FemaleShirtPackLong.Visible

                    txtFEMALE_FemaleBlackPants.Value = .Item("FEMALE_FemaleBlackPants")
                    SetPolicy(txtFEMALE_FemaleBlackPants, "FEMALE_FemaleBlackPants")
                    lblFEMALE_FemaleBlackPants.Visible = txtFEMALE_FemaleBlackPants.Visible

                    txtFEMALE_Skirt.Value = .Item("FEMALE_Skirt")
                    SetPolicy(txtFEMALE_Skirt, "FEMALE_Skirt")
                    lblFEMALE_Skirt.Visible = txtFEMALE_Skirt.Visible

                    txtFEMALE_Blazer.Value = .Item("FEMALE_Blazer")
                    SetPolicy(txtFEMALE_Blazer, "FEMALE_Blazer")
                    lblFEMALE_Blazer.Visible = txtFEMALE_Blazer.Visible

                    txtUNISEX_ProdSUShirt.Value = .Item("UNISEX_ProdSUShirt")
                    SetPolicy(txtUNISEX_ProdSUShirt, "UNISEX_ProdSUShirt")
                    lblUNISEX_ProdSUShirt.Visible = txtUNISEX_ProdSUShirt.Visible

                    txtUNISEX_ProdRNFShirt.Value = .Item("UNISEX_ProdRNFShirt")
                    SetPolicy(txtUNISEX_ProdRNFShirt, "UNISEX_ProdRNFShirt")
                    lblUNISEX_ProdRNFShirt.Visible = txtUNISEX_ProdRNFShirt.Visible

                    txtUNISEX_MaongPants.Value = .Item("UNISEX_MaongPants")
                    SetPolicy(txtUNISEX_MaongPants, "UNISEX_MaongPants")
                    lblUNISEX_MaongPants.Visible = txtUNISEX_MaongPants.Visible

                    txtUNISEX_RepellantPants.Value = .Item("UNISEX_RepellantPants")
                    SetPolicy(txtUNISEX_RepellantPants, "UNISEX_RepellantPants")
                    lblUNISEX_RepellantPants.Visible = txtUNISEX_RepellantPants.Visible

                    txtRESERVEDMALE_RNFSpecialShirt.Value = .Item("RESERVEDMALE_RNFSpecialShirt")
                    SetPolicy(txtRESERVEDMALE_RNFSpecialShirt, "RESERVEDMALE_RNFSpecialShirt")
                    lblRESERVEDMALE_RNFSpecialShirt.Visible = txtRESERVEDMALE_RNFSpecialShirt.Visible

                    txtRESERVEDMALE_CampaignShirt.Value = .Item("RESERVEDMALE_CampaignShirt")
                    SetPolicy(txtRESERVEDMALE_CampaignShirt, "RESERVEDMALE_CampaignShirt")
                    lblRESERVEDMALE_CampaignShirt.Visible = txtRESERVEDMALE_CampaignShirt.Visible

                    txtRESERVEDMALE_SpecialShirt.Value = .Item("RESERVEDMALE_SpecialShirt")
                    SetPolicy(txtRESERVEDMALE_SpecialShirt, "RESERVEDMALE_SpecialShirt")
                    lblRESERVEDMALE_SpecialShirt.Visible = txtRESERVEDMALE_SpecialShirt.Visible

                    txtRESERVEDMALE_Polo2.Value = .Item("RESERVEDMALE_Polo2")
                    SetPolicy(txtRESERVEDMALE_Polo2, "RESERVEDMALE_Polo2")
                    lblRESERVEDMALE_Polo2.Visible = txtRESERVEDMALE_Polo2.Visible

                    txtRESERVEDMALE_Polo3.Value = .Item("RESERVEDMALE_Polo3")
                    SetPolicy(txtRESERVEDMALE_Polo3, "RESERVEDMALE_Polo3")
                    lblRESERVEDMALE_Polo3.Visible = txtRESERVEDMALE_Polo3.Visible

                    txtRESERVEDMALE_MaleSlacks.Value = .Item("RESERVEDMALE_MaleSlacks")
                    SetPolicy(txtRESERVEDMALE_MaleSlacks, "RESERVEDMALE_MaleSlacks")
                    lblRESERVEDMALE_MaleSlacks.Visible = txtRESERVEDMALE_MaleSlacks.Visible

                    txtRESERVEDMALE_MaleSlacks2.Value = .Item("RESERVEDMALE_MaleSlacks2")
                    SetPolicy(txtRESERVEDMALE_MaleSlacks2, "RESERVEDMALE_MaleSlacks2")
                    lblRESERVEDMALE_MaleSlacks2.Visible = txtRESERVEDMALE_MaleSlacks2.Visible

                    txtRESERVEDMALE_MaleBlackPants2.Value = .Item("RESERVEDMALE_MaleBlackPants2")
                    SetPolicy(txtRESERVEDMALE_MaleBlackPants2, "RESERVEDMALE_MaleBlackPants2")
                    lblRESERVEDMALE_MaleBlackPants2.Visible = txtRESERVEDMALE_MaleBlackPants2.Visible

                    txtRESERVEDMALE_MaleSpecialJacket.Value = .Item("RESERVEDMALE_MaleSpecialJacket")
                    SetPolicy(txtRESERVEDMALE_MaleSpecialJacket, "RESERVEDMALE_MaleSpecialJacket")
                    lblRESERVEDMALE_MaleSpecialJacket.Visible = txtRESERVEDMALE_MaleSpecialJacket.Visible

                    txtRESERVEDFEMALE_RNFSpecialShirt.Value = .Item("RESERVEDFEMALE_RNFSpecialShirt")
                    SetPolicy(txtRESERVEDFEMALE_RNFSpecialShirt, "RESERVEDFEMALE_RNFSpecialShirt")
                    lblRESERVEDFEMALE_RNFSpecialShirt.Visible = txtRESERVEDFEMALE_RNFSpecialShirt.Visible

                    txtRESERVEDFEMALE_CampaignShirt.Value = .Item("RESERVEDFEMALE_CampaignShirt")
                    SetPolicy(txtRESERVEDFEMALE_CampaignShirt, "RESERVEDFEMALE_CampaignShirt")
                    lblRESERVEDFEMALE_CampaignShirt.Visible = txtRESERVEDFEMALE_CampaignShirt.Visible

                    txtRESERVEDFEMALE_SpecialShirt.Value = .Item("RESERVEDFEMALE_SpecialShirt")
                    SetPolicy(txtRESERVEDFEMALE_SpecialShirt, "RESERVEDFEMALE_SpecialShirt")
                    lblRESERVEDFEMALE_SpecialShirt.Visible = txtRESERVEDFEMALE_SpecialShirt.Visible

                    txtRESERVEDFEMALE_Blouse2.Value = .Item("RESERVEDFEMALE_Blouse2")
                    SetPolicy(txtRESERVEDFEMALE_Blouse2, "RESERVEDFEMALE_Blouse2")
                    lblRESERVEDFEMALE_Blouse2.Visible = txtRESERVEDFEMALE_Blouse2.Visible

                    txtRESERVEDFEMALE_Blouse3.Value = .Item("RESERVEDFEMALE_Blouse3")
                    SetPolicy(txtRESERVEDFEMALE_Blouse3, "RESERVEDFEMALE_Blouse3")
                    lblRESERVEDFEMALE_Blouse3.Visible = txtRESERVEDFEMALE_Blouse3.Visible

                    txtRESERVEDFEMALE_FemaleSlacks.Value = .Item("RESERVEDFEMALE_FemaleSlacks")
                    SetPolicy(txtRESERVEDFEMALE_FemaleSlacks, "RESERVEDFEMALE_FemaleSlacks")
                    lblRESERVEDFEMALE_FemaleSlacks.Visible = txtRESERVEDFEMALE_FemaleSlacks.Visible

                    txtRESERVEDFEMALE_FemaleSlacks2.Value = .Item("RESERVEDFEMALE_FemaleSlacks2")
                    SetPolicy(txtRESERVEDFEMALE_FemaleSlacks2, "RESERVEDFEMALE_FemaleSlacks2")
                    lblRESERVEDFEMALE_FemaleSlacks2.Visible = txtRESERVEDFEMALE_FemaleSlacks2.Visible

                    txtRESERVEDFEMALE_FemaleBlackPants2.Value = .Item("RESERVEDFEMALE_FemaleBlackPants2")
                    SetPolicy(txtRESERVEDFEMALE_FemaleBlackPants2, "RESERVEDFEMALE_FemaleBlackPants2")
                    lblRESERVEDFEMALE_FemaleBlackPants2.Visible = txtRESERVEDFEMALE_FemaleBlackPants2.Visible

                    txtRESERVEDFEMALE_Skirt2.Value = .Item("RESERVEDFEMALE_Skirt2")
                    SetPolicy(txtRESERVEDFEMALE_Skirt2, "RESERVEDFEMALE_Skirt2")
                    lblRESERVEDFEMALE_Skirt2.Visible = txtRESERVEDFEMALE_Skirt2.Visible

                    txtRESERVEDFEMALE_FemaleSpecialJacket.Value = .Item("RESERVEDFEMALE_FemaleSpecialJacket")
                    SetPolicy(txtRESERVEDFEMALE_FemaleSpecialJacket, "RESERVEDFEMALE_FemaleSpecialJacket")
                    lblRESERVEDFEMALE_FemaleSpecialJacket.Visible = txtRESERVEDFEMALE_FemaleSpecialJacket.Visible

#End Region

                    ' division
                    SetComboValue(cmbDivision, .Item("Division").ToString())

                    items_saved.Add("Division", cmbDivision.Value)

                    SetPolicy(cmbDivision, "Division")

                    lblDivision.Visible = cmbDivision.Visible

                    ' department
                    SetComboValue(cmbDepartment, .Item("Department").ToString())

                    items_saved.Add("Department", cmbDepartment.Value)

                    SetPolicy(cmbDepartment, "Department")

                    lblDepartment.Visible = cmbDepartment.Visible

                    ' section
                    SetComboValue(cmbSection, .Item("Section").ToString())

                    items_saved.Add("Section", cmbSection.Value)

                    SetPolicy(cmbSection, "Section")

                    lblSection.Visible = cmbSection.Visible


                    SetComboValue(cmbFixed, .Item("Fixed").ToString())

                    items_saved.Add("Fixed", cmbFixed.Value)

                    SetPolicy(cmbFixed, "Fixed")

                    lblFixed.Visible = cmbFixed.Visible

                    If (Not IsNull(.Item("DateJoinedGroup"))) Then

                        dteDateJoinedGroup.Value = .Item("DateJoinedGroup")

                        txtYearsServiceG.Text = CalcDate(dteDateJoinedGroup.Value, .Item("TerminationDate"), .Item("Termination"))

                    End If

                    If (Not IsNull(.Item("Appointdate"))) Then

                        dteAppointdate.Value = .Item("Appointdate")

                        txtYearsServiceA.Text = CalcDate(dteAppointdate.Value, .Item("TerminationDate"), .Item("Termination"))

                    End If

                    ' Shirt Size
                    If (Not IsNull(.Item("ShirtSize"))) Then

                        SetComboValue(cmbShirtSize, .Item("ShirtSize").ToString())

                        items_saved.Add("ShirtSize", cmbShirtSize.Value)

                    End If

                    SetPolicy(cmbShirtSize, "ShirtSize")

                    lblShirtSize.Visible = cmbShirtSize.Visible


                    SetPolicy(dteDateJoinedGroup, "DateJoinedGroup")

                    lblDateJoinedGroup.Visible = dteDateJoinedGroup.Visible

                    SetPolicy(dteAppointdate, "Appointdate")

                    lblAppointdate.Visible = dteAppointdate.Visible

                    txtYearsServiceG.Visible = GetArrayItem(UDetails.Template, "eOrganizational.YearsServiceG")

                    lblYearsServiceG.Visible = txtYearsServiceG.Visible

                    txtYearsServiceA.Visible = GetArrayItem(UDetails.Template, "eOrganizational.YearsServiceA")

                    lblYearsServiceA.Visible = txtYearsServiceA.Visible

                End With

            End If

        End With

    End Sub

    Protected Sub cmbEmployee_OnCallback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase)

        FillComboBox(TryCast(source, DevExpress.Web.ASPxEditors.ASPxComboBox), e.Parameter)

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        LoadData(True)
        Dim ReturnText As String = String.Empty

        Dim SQL As String = ChangedSQL()

        If (SQL.Length > 0) Then

            With UDetails

                Dim bChange As Boolean = GetArrayItem(.Template, "eGeneral.OrganizationalChange")
                Dim bLogChange As Boolean = GetArrayItem(.Template, "eGeneral.OrganizationalLogChange")

                Dim NotifyDate As String = Now.ToString("yyyy-MM-dd HH:mm:ss")

                Dim ChangedSQL() As String = {"update [Personnel] set ", "update [Personnel1] set "}

                Dim iCount As Byte = Convert.ToByte(GetXML(SQL, KeyName:="Count"))

                Dim PolicyID As Integer
                Dim AssemblyID As Integer
                Dim KeyDesc As String
                Dim LabelDesc As String
                Dim ValueF As String
                Dim ValueT As String

                For iLoop As Integer = 0 To (iCount - 1)

                    PolicyID = (GetXML(SQL, KeyName:="PolicyID[" & iLoop.ToString("000") & "]"))

                    AssemblyID = Convert.ToByte(GetXML(SQL, KeyName:="AssemblyID[" & iLoop.ToString("000") & "]"))

                    KeyDesc = GetXML(SQL, KeyName:="Key[" & iLoop.ToString("000") & "]").Replace("MaritalStatus", "MaritialStatus")

                    LabelDesc = GetXML(SQL, KeyName:="Label[" & iLoop.ToString("000") & "]")

                    ValueF = GetXML(SQL, KeyName:="ValueF[" & iLoop.ToString("000") & "]")

                    ValueT = GetXML(SQL, KeyName:="ValueT[" & iLoop.ToString("000") & "]")

                    ExecSQL("insert into [ess.Change]([CompanyNum], [EmployeeNum], [NotifyDate], [PolicyID], [AssemblyID], [Template], [ValueF], [ValueT]) values('" & .CompanyNum & "', '" & .EmployeeNum & "', '" & NotifyDate & "', " & PolicyID.ToString() & ", " & AssemblyID.ToString() & ", 'Organisational Tab', '" & ValueF & "', '" & ValueT & "')")

                    If (bChange AndAlso bLogChange) Then ExecSQL("insert into [PersonnelHistoryLog]([CompanyNum], [EmployeeNum], [ActionDescription], [ActionDate], [ChangedFrom], [ChangedTo], [ChangedBy], [Remarks]) values('" & .CompanyNum & "', '" & .EmployeeNum & "', '" & LabelDesc & "', '" & NotifyDate & "', '" & ValueF & "', '" & ValueT & "', '" & .UserID & "', 'ESS: Changed by user')")

                    If (FindPolicyTableName(PolicyID) = "Personnel1") Then
                        ChangedSQL(1) &= "[" & KeyDesc & "] = '" & ValueT & "', "
                    Else
                        ChangedSQL(0) &= "[" & KeyDesc & "] = '" & ValueT & "', "
                    End If

                    'If (KeyDesc = "Position" Or KeyDesc = "Location") Then

                    '    ChangedSQL(1) &= "[" & KeyDesc & "] = '" & ValueT & "', "

                    'Else

                    '    ChangedSQL(0) &= "[" & KeyDesc & "] = '" & ValueT & "', "

                    'End If

                Next

                If (ChangedSQL(0).EndsWith(", ")) Then ChangedSQL(0) = ChangedSQL(0).Substring(0, ChangedSQL(0).Length - 2)

                If (ChangedSQL(1).EndsWith(", ")) Then ChangedSQL(1) = ChangedSQL(1).Substring(0, ChangedSQL(1).Length - 2)

                ChangedSQL(0) &= " where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')"

                ChangedSQL(1) &= " where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')"

                If (bChange) Then

                    If (ExecSQL(ChangedSQL(0)) And ExecSQL(ChangedSQL(1))) Then

                        If (ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & .CompanyNum & "', '" & .EmployeeNum & "', 0, 'Change', 'Notify', 'Start', 'Start', '" & NotifyDate & "'")) Then

                            ClearOrganizationalCache(Session.SessionID)

                            ReturnText = "tasks.aspx tools/index.aspx"

                        End If

                    End If

                Else

                    If (ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & .CompanyNum & "', '" & .EmployeeNum & "', 0, 'Change', 'Approve', 'Start', 'Start', '" & NotifyDate & "'")) Then

                        ClearOrganizationalCache(Session.SessionID)

                        ReturnText = "tasks.aspx tools/index.aspx"

                    End If

                End If

            End With

        Else

            ClearOrganizationalCache(Session.SessionID)

            ReturnText = "tasks.aspx tools/index.aspx"

        End If

        e.Result = ReturnText

    End Sub

    Private Sub dgView_002_CellEditorInitialize(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewEditorEventArgs) Handles dgView_002.CellEditorInitialize

        If (Not sender.IsEditing OrElse Not e.Column.FieldName = "ReportToEmpNum") Then Return

        Dim combo As DevExpress.Web.ASPxEditors.ASPxComboBox = TryCast(e.Editor, DevExpress.Web.ASPxEditors.ASPxComboBox)

        If (sender.IsEditing AndAlso Not sender.IsNewRowEditing) Then

            If (IsNull(e.KeyValue)) Then Return

            Dim val As String = sender.GetRowValuesByKeyValue(e.KeyValue, "ReportToCompNum")

            If (val Is DBNull.Value) Then Return

            FillComboBox(combo, val)

            'If (IsNumeric(combo.Value)) Then

            Session("orgEmployeeNum") = combo.Value

            AddHandler combo.Callback, AddressOf cmbEmployee_OnCallback

        ElseIf (sender.IsEditing AndAlso sender.IsNewRowEditing) Then

            AddHandler combo.Callback, AddressOf cmbEmployee_OnCallback

        End If

    End Sub

    Private Sub dgView_002_CustomColumnDisplayText(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewColumnDisplayTextEventArgs) Handles dgView_002.CustomColumnDisplayText

        If (e.Column.FieldName = "ReportToEmpNum") Then e.DisplayText = e.GetFieldValue("Employee")

    End Sub

    Private Sub dgView_002_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_002.CustomJSProperties, dgView_003.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

    End Sub

    Private Sub dgView_002_HeaderFilterFillItems(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewHeaderFilterEventArgs) Handles dgView_002.HeaderFilterFillItems

        If (e.Column.FieldName = "ReportToEmpNum") Then

            Dim i As Integer = (e.Values.Count - 1)

            While (i > -1)

                If (e.Values(i).IsShowAllFilter OrElse e.Values(i).IsFilterByQuery) Then

                    Exit While

                Else

                    e.Values.RemoveAt(i)

                    i -= 1

                End If

            End While

            Dim xValues As String = String.Empty

            Dim arValues As ArrayList = Nothing

            arValues = New ArrayList()

            For i = 0 To (sender.VisibleRowCount - 1)

                If (Not xValues.Contains("[" & sender.GetRowValues(i, "ReportToEmpNum") & "]")) Then

                    xValues &= "[" & sender.GetRowValues(i, "ReportToEmpNum") & "]"

                    arValues.Add(sender.GetRowValues(i, "Employee") & ";" & sender.GetRowValues(i, "ReportToEmpNum"))

                End If

            Next

            arValues.Sort()

            For i = 0 To (arValues.Count - 1)

                e.Values.Add(New FilterValue(arValues(i).ToString().Split(";")(0), arValues(i).ToString().Split(";")(1), ""))

            Next

        End If

    End Sub

    Private Sub dgView_002_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_002.RowDeleting, dgView_003.RowDeleting

        Dim SQLAudit As String = String.Empty

        If (sender.Equals(dgView_002)) Then

            SQLAudit = "<Tablename=ReportsTo><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><CostCentreCompanyNum=" & e.Values("CostCentreCompanyNum").ToString() & "><CostCentre=" & e.Values("CostCentre").ToString() & ">"

        Else

            SQLAudit = "<Tablename=Contracting><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><StartDate=" & Convert.ToDateTime(e.Values("StartDate")).ToString("yyyy-MM-dd HH:mm:ss") & "><ContractName=" & e.Values("ContractName").ToString() & ">"

        End If

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

        End If

    End Sub

    Private Sub dgView_002_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_002.RowInserting, dgView_003.RowInserting

        Dim SQLAudit As String = String.Empty

        If (sender.Equals(dgView_002)) Then

            SQLAudit = "<Tablename=ReportsTo><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        Else

            SQLAudit = "<Tablename=Contracting><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        End If

        If (sender.Equals(dgView_003)) Then GetExpValues(sender, e)

        With UDetails

            e.NewValues("CompanyNum") = .CompanyNum

            e.NewValues("EmployeeNum") = .EmployeeNum

        End With

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_002_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_002.RowUpdating, dgView_003.RowUpdating

        Dim SQLAudit As String = String.Empty

        If (sender.Equals(dgView_002)) Then

            SQLAudit = "<Tablename=ReportsTo><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><CostCentreCompanyNum;2=" & e.OldValues("CostCentreCompanyNum").ToString() & "><CostCentre;3=" & e.OldValues("CostCentre").ToString() & ">"

        Else

            SQLAudit = "<Tablename=Contracting><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><StartDate;2=" & Convert.ToDateTime(e.OldValues("StartDate")).ToString("yyyy-MM-dd HH:mm:ss") & "><ContractName;3=" & e.OldValues("ContractName").ToString() & ">"

        End If

        If (sender.Equals(dgView_003)) Then GetExpValues(sender, e)

        e.NewValues("ReportToEmpNum") = Session("orgEmployeeNum")

        Session.Remove("orgEmployeeNum")

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_002_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_002.RowValidating

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

    Private Sub dgView_002_StartRowEditing(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxStartRowEditingEventArgs) Handles dgView_002.StartRowEditing

        If (sender.IsEditing) AndAlso (Not sender.IsNewRowEditing) Then LoadExpDS(dsReportToEmpNum, "select [EmployeeNum], (isnull([Title], '') + ' ' + isnull([PreferredName], '') + ' ' + [Surname]) as [Name] from [Personnel] where ([CompanyNum] = '" & sender.GetRowValuesByKeyValue(e.EditingKeyValue, "ReportToCompNum").ToString() & "') order by [Name]")

    End Sub

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Dim dgExports As ASPxGridViewExporter = Nothing

        Try

            dgExports = tabOrganizational.TabPages(tabOrganizational.ActiveTabIndex).FindControl(source.ID.ToString().Replace("mnuExport", "dgExports"))

            If (Not IsNull(dgExports)) Then

                Dim xFilePath As String = tabOrganizational.TabPages(tabOrganizational.ActiveTabIndex).Text & " [" & Date.Today.ToString("yyyy-MM-dd") & "]"

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

    Protected Sub cmbDivision_ValueChanged(sender As Object, e As EventArgs)
        Dim name As String = cmbDivision.SelectedItem.Value

        If Not name = "" Then
            LoadExpDS(dsDepartment, "select distinct [SubDivision] as [Name] from [Company] where [Division] = '" & name & "' order by [SubDivision]")

            LoadExpCmb(cmbDepartment, "<select>")
        End If


    End Sub

    Protected Sub cmbDepartment_ValueChanged(sender As Object, e As EventArgs)
        Dim name As String = cmbDepartment.SelectedItem.Value

        If Not name = "" Then
            LoadExpDS(dsSection, "select distinct [SubSubDivision] as [Name] from [Company] where [SubDivision] = '" & name & "'  order by [SubSubDivision]")

            LoadExpCmb(cmbSection, "<select>")
        End If


    End Sub

    Protected Sub tabOrganizational_ActiveTabChanged(source As Object, e As DevExpress.Web.ASPxTabControl.TabControlEventArgs) Handles tabOrganizational.ActiveTabChanged

    End Sub

    Protected Sub cmdSubmit_Click(sender As Object, e As EventArgs) Handles cmdSubmit.Click

    End Sub

#End Region

End Class