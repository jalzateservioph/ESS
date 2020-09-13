Imports System.Web.HttpUtility

Public Class conditions
    Inherits System.Web.UI.Page

    Private AppType As String = "Basic Conditions "
    Private UDetails As Users = Nothing

#Region " *** Web Form Functions *** "

    Private Function CheckState(ByVal SQL As String, ByVal Value As String, ByVal Compare As String, ByVal DescValue As String, ByVal TableName As String, ByVal Field As String) As String

        Dim ReturnText As String = String.Empty

        If (Not IsNull(Value) AndAlso Not IsNull(Compare)) Then

            If (Not Value = Compare AndAlso IsString(Compare)) Then

                ReturnText = SQL.Replace("%ADescription%", DescValue).Replace("%From%", Value).Replace("%To%", Compare).Replace("'<select>'", "null")

                If (Not Field = "DaysPerWeek") Then Compare = "''" & Compare.Replace("'", "''") & "''"

                ReturnText = ReturnText.Replace("%PathQuery%", "update [" & TableName & "] set [" & Field & "] = " & Compare)

            End If

        End If

        Return ReturnText

    End Function

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        LoadExpDS(dsDeptName, "select [DeptName] from [Department] where ([CompanyNum] = '" & UDetails.CompanyNum & "') order by [DeptName]")

        LoadExpDS(dsIndividualJobTitle, "select distinct [IndividualJobTitle] from [Personnel1] order by [IndividualJobTitle]")

        LoadExpDS(dsJobTitle, "select [JobTitle] from [JobTitle] where ([CompanyNum] = '" & UDetails.CompanyNum & "') order by [JobTitle]")

        LoadExpDS(dsJobGrade, "select [JobGrade] from [JobGrade] where ([CompanyNum] = '" & UDetails.CompanyNum & "') order by [JobGrade]")

        LoadExpDS(dsShiftType, "select [ShiftType] from [ShiftTypeLU] where ([CompanyNum] = '" & UDetails.CompanyNum & "') order by [ShiftType]")

        LoadExpDS(dsCostCentre, "select [CostCentre] from [CostCentreLU] where ([CompanyNum] = '" & UDetails.CompanyNum & "') order by [CostCentre]")

        LoadExpDS(dsReason, "select [Remark] from [PersonnelHistoryLogRemarkLU] order by [Remark]")

        Dim SQLError As String = String.Empty

        Dim dtData As DataTable = Nothing

        Try

            dtData = GetSQLDT("select [emp].[DeptName], [emp1].[IndividualJobTitle], [emp].[JobTitle], [emp].[JobGrade], [emp1].[DaysPerWeek], [emp1].[ShiftType], [emp].[CostCentre] from [Personnel] as [emp] left outer join [Personnel1] as [emp1] on [emp].[CompanyNum] = [emp1].[CompanyNum] and [emp].[EmployeeNum] = [emp1].[EmployeeNum] where ([emp].[CompanyNum] = '" & UDetails.CompanyNum & "' and [emp].[EmployeeNum] = '" & UDetails.EmployeeNum & "')", "Data.Conditions." & Session.SessionID)

            If (IsData(dtData)) Then

                With dtData.Rows(0)

                    If (IsNumeric(.Item("JobGrade").ToString())) Then

                        cmbWorkflow.Value = "1"

                    Else

                        cmbWorkflow.Value = "2"

                    End If

                    If (IsDate(dteUntil.Date)) Then cmbWorkflow.Value = "3"

                    Select Case cmbWorkflow.Value

                        Case "1"

                            AppType &= "Grade 1 - 6 "

                            If (IsNull(cmbDeptName.SelectedItem) OrElse .Item("DeptName") = cmbDeptName.SelectedItem.Value.ToString()) Then

                                AppType &= "Same SBU"

                            Else

                                AppType &= "Different SBU"

                            End If

                        Case "2"

                            AppType &= "Staff "

                            If (IsNull(cmbDeptName.SelectedItem) OrElse .Item("DeptName").ToString() = cmbDeptName.SelectedItem.Value.ToString()) Then

                                AppType &= "Same SBU"

                            Else

                                AppType &= "Different SBU"

                            End If

                        Case "3"

                            AppType &= "Acting Allowance"

                    End Select

                    If (Not IsPostBack) Then

                        cmbDeptName.Value = .Item("DeptName")

                        cmbIndividualJobTitle.Value = .Item("IndividualJobTitle")

                        cmbJobTitle.Value = .Item("JobTitle")

                        cmbJobGrade.Value = .Item("JobGrade")

                        txtWorkWeek.Text = .Item("DaysPerWeek")

                        cmbShiftType.Value = .Item("ShiftType")

                        cmbCostCentre.Value = .Item("CostCentre")

                    End If

                End With

            End If

        Catch ex As Exception

        Finally

            If (Not IsNull(dtData)) Then

                dtData.Dispose()

                dtData = Nothing

            End If

        End Try

        With UDetails

            If (ClearCache) Then ClearFromCache("Data.Conditions.History." & Session.SessionID)

            dgView.DataSource = GetSQLDT("select [PathID], [EffectiveFrom] as [Start], [EffectiveTo] as [Until], [ActionDescription] as [Value], [ChangedFrom] as [ValueF], [ChangedTo] as [ValueT] from [PersonnelHistoryLog] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [PathID] in(select [ID] from [ess.Path] where ([WFLUID] in(select [ID] from [ess.WFLU] where ([WFType] = 'Basic Conditions')))))", "Data.Conditions.History." & Session.SessionID)

            GridFormat(dgView, .Template)

            dgView.DataBind()

            cmdSubmit.Enabled = IsWorkflow(.CompanyNum, .EmployeeNum, .Department, .Email, "Basic Conditions", AppType, SQLError)

        End With

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Session("docUnread")) Then

            Response.Redirect("documentmapman.aspx", True)

            Exit Sub

        End If

        If (Not IsPostBack) Then SetEmployeeData(Session, Session("Selected.Value"))

        UDetails = GetUserDetails(Session, "Basic Conditions")

        If (Not dteStart.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom) Then

            dteStart.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom
            dteStart.EditFormatString = GetArrayItem(UDetails.Template, "eGeneral.DateFormat")

        End If

        If (Not dteUntil.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom) Then

            dteUntil.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom
            dteUntil.EditFormatString = GetArrayItem(UDetails.Template, "eGeneral.DateFormat")

        End If

        If (Not IsDate(dteStart.Date)) Then dteStart.Date = DateTime.Today

        LoadData(Not IsPostBack)

    End Sub

    Private Sub cmbWorkflow_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CustomJSPropertiesEventArgs) Handles cmbWorkflow.CustomJSProperties

        e.Properties("cpValue") = cmbWorkflow.Value

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        If (e.Parameter = "Submit") Then

            Dim bSaved As Boolean = True

            Dim bExec As Boolean = False

            Dim SystemDate As String = DateTime.Today.ToString("yyyy-MM-dd HH:mm:ss")

            Dim SQLTemp As String = String.Empty

            Dim SQL As String = "insert into [PersonnelHistoryLog]([CompanyNum], [EmployeeNum], [ActionDescription], [ActionDate], [ChangedFrom], [ChangedTo], [ChangedBy], [Remarks], [EffectiveFrom], [EffectiveTo], [Status], [PathQuery]) values('" & UDetails.CompanyNum & "', '" & UDetails.EmployeeNum & "', '%ADescription%', '" & SystemDate & "', '%From%', '%To%', '" & UDetails.UserID & "', " & If(IsString(cmbReason.Value), "'" & cmbReason.Value.ToString() & "'", "null") & ", '" & dteStart.Date.ToString("yyyy-MM-dd HH:mm:ss") & "', " & IIf(IsDate(dteUntil.Date), "'" & dteUntil.Date.ToString("yyyy-MM-dd HH:mm:ss") & "'", "null") & ", 'New', '%PathQuery%')"

            Dim dtData As DataTable = Nothing

            Try

                dtData = GetSQLDT("select [emp].[DeptName], [emp1].[IndividualJobTitle], [emp].[JobTitle], [emp].[JobGrade], [emp1].[DaysPerWeek], [emp1].[ShiftType], [emp].[CostCentre] from [Personnel] as [emp] left outer join [Personnel1] as [emp1] on [emp].[CompanyNum] = [emp1].[CompanyNum] and [emp].[EmployeeNum] = [emp1].[EmployeeNum] where ([emp].[CompanyNum] = '" & UDetails.CompanyNum & "' and [emp].[EmployeeNum] = '" & UDetails.EmployeeNum & "')", "Data.Conditions." & Session.SessionID)

                If (IsData(dtData)) Then

                    With dtData.Rows(0)

                        SQLTemp = CheckState(SQL, .Item("DeptName").ToString(), cmbDeptName.Value, "Department", "Personnel", "DeptName")

                        If (IsString(SQLTemp)) Then

                            bSaved = ExecSQL(SQLTemp)

                            bExec = bSaved

                        End If

                        If (Not bSaved) Then GoTo SkipSaveData

                        SQLTemp = CheckState(SQL, .Item("IndividualJobTitle").ToString(), cmbIndividualJobTitle.Value, "Individual Job Title", "Personnel1", "IndividualJobTitle")

                        If (IsString(SQLTemp)) Then

                            bSaved = ExecSQL(SQLTemp)

                            bExec = bSaved

                        End If

                        If (Not bSaved) Then GoTo SkipSaveData

                        SQLTemp = CheckState(SQL, .Item("JobTitle").ToString(), cmbJobTitle.Value, "Job Title", "Personnel", "JobTitle")

                        If (IsString(SQLTemp)) Then

                            bSaved = ExecSQL(SQLTemp)

                            bExec = bSaved

                        End If

                        If (Not bSaved) Then GoTo SkipSaveData

                        SQLTemp = CheckState(SQL, .Item("JobGrade").ToString(), cmbJobGrade.Value, "Job Grade", "Personnel", "JobGrade")

                        If (IsString(SQLTemp)) Then

                            bSaved = ExecSQL(SQLTemp)

                            bExec = bSaved

                        End If

                        If (Not bSaved) Then GoTo SkipSaveData

                        SQLTemp = CheckState(SQL, .Item("DaysPerWeek").ToString(), txtWorkWeek.Text, "Days Per Week", "Personnel1", "DaysPerWeek")

                        If (IsString(SQLTemp)) Then

                            bSaved = ExecSQL(SQLTemp)

                            bExec = bSaved

                        End If

                        If (Not bSaved) Then GoTo SkipSaveData

                        SQLTemp = CheckState(SQL, .Item("ShiftType").ToString(), cmbShiftType.Value, "Shift Type", "Personnel", "ShiftType")

                        If (IsString(SQLTemp)) Then

                            bSaved = ExecSQL(SQLTemp)

                            bExec = bSaved

                        End If

                        If (Not bSaved) Then GoTo SkipSaveData

                        SQLTemp = CheckState(SQL, .Item("CostCentre").ToString(), cmbCostCentre.Value, "Cost Centre", "Personnel", "CostCentre")

                        If (IsString(SQLTemp)) Then

                            bSaved = ExecSQL(SQLTemp)

                            bExec = bSaved

                        End If

                        If (Not bExec OrElse Not bSaved) Then GoTo SkipSaveData

                        SQL = "exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & UDetails.CompanyNum & "', '" & UDetails.EmployeeNum & "', 0, 'Basic Conditions', '" & AppType & "', 'Start', 'Start', '" & SystemDate & "'"

                        bSaved = ExecSQL(SQL)

                        If (bSaved) Then

                            If (IsString(txtNotes.Text)) Then ExecSQL("insert into [ess.WFRemarks]([CompanyNum], [EmployeeNum], [CaptureDate], [Remarks], [PathID]) values('" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & Now().ToString("yyyy-MM-dd HH:mm:ss") & "', '" & GetDataText(txtNotes.Text) & "', " & GetXML(SQL, KeyName:="PathID") & ")")

                        End If

SkipSaveData:

                    End With

                End If

            Catch ex As Exception

            Finally

                If (Not IsNull(dtData)) Then

                    dtData.Dispose()

                    dtData = Nothing

                End If

            End Try

            If (bSaved) Then

                ClearFromCache("Data.Conditions." & Session.SessionID)

                e.Result = "tasks.aspx tools/index.aspx"

            End If

        End If

    End Sub

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Try

            Dim xFilePath As String = "Conditions [" & Date.Today.ToString("yyyy-MM-dd") & "]"

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

        Catch ex As Exception

        Finally

        End Try

    End Sub

    Protected Function GetClickUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim EncryptedURL As String = UrlEncode(CryptoEncrypt("<type=load><id=Conditions><param0=" & Container.Grid.GetRowValues(Container.VisibleIndex, "PathID") & ">", EncPwd, SaltPwd, 5, EncVectorPwd, 256))

        Return "function(s, e) { window.open('reportsview.aspx?params=" & EncryptedURL & "', 'open'); }"

    End Function

#End Region

End Class