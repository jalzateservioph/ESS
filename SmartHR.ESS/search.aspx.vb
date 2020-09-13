Imports DevExpress.Web.ASPxGridView.Export

Partial Public Class search
    Inherits System.Web.UI.Page

    Private CancelEdit As Boolean
    Private FilePath As String
    Private UDetails As Users = Nothing

#Region " *** Web Form Functions *** "

    Private Sub LoadData()

        Dim UserGroup As String = String.Empty

        If (Not IsNull(Session("LoggedOn"))) Then

            UserGroup = GetUserGroup(Session("LoggedOn").UserID, Session.SessionID)

            If (Not IsNull(UserGroup)) Then

                With UDetails

                    Select Case tabSearch.ActiveTabIndex

                        Case 0
                            ClearFromCache("Data.Filter." & Session.SessionID)

                            LoadExpDS(dsAppointype, "select [AppointmentType] from [AppointmentTypeLU] order by [AppointmentType]")

                            LoadExpDS(dsCostCentre, "select [CostCentre] from [CostCentreLU] where ([CompanyNum] = '" & .CompanyNum & "') order by [CostCentre]")

                            LoadExpDS(dsDeptName, "select [DeptName] from [Department] where ([CompanyNum] = '" & .CompanyNum & "') order by [DeptName]")

                            LoadExpDS(dsJobGrade, "select [JobGrade] from [JobGrade] where ([CompanyNum] = '" & .CompanyNum & "') order by [JobGrade]")

                            LoadExpDS(dsJobTitle, "select [JobTitle] from [JobTitle] where ([CompanyNum] = '" & .CompanyNum & "') order by [JobTitle]")

                            LoadExpDS(dsLocation, "select [Location] from [LocationLU] where ([CompanyNum] = '" & .CompanyNum & "') order by [Location]")

                            LoadExpDS(dsSex, "select [Sex] from [SexLU] order by [Sex]")

                            LoadExpDS(dsTerminationReason, "select [TerminationReason] from [TerminationReasonLU] order by [TerminationReason]")

                            txtEmployeeNum.Focus()

                        Case 1
                            ClearFromCache("Data.Filter." & Session.SessionID)

                            ClearFromCache("Data.UserGroups.AccessTo.Filter." & Session.SessionID)

                            Dim SQLQuery As String = String.Empty

                            Dim SQLFilter() As String = Nothing

                            Array.Resize(SQLFilter, 16)

                            If (txtEmployeeNum.Text.Length > 0) Then SQLFilter(0) &= "[e].[EmployeeNum] like '" & GetDataText(txtEmployeeNum.Text, True) & "'"

                            If (txtName.Text.Length > 0) Then SQLFilter(1) &= "([e].[FirstName] like '" & GetDataText(txtName.Text, True) & "' or [e].[PreferredName] like '" & GetDataText(txtName.Text, True) & "')"

                            If (txtSurname.Text.Length > 0) Then SQLFilter(2) &= "[e].[Surname] like '" & GetDataText(txtSurname.Text, True) & "'"

                            If (Not IsNull(cmbSex.Value)) Then

                                If (cmbSex.Value.ToString().Length > 0) Then SQLFilter(3) &= "[e].[Sex] like '" & GetDataText(cmbSex.Value.ToString(), True) & "'"

                            End If

                            If (txtIDNum.Text.Length > 0) Then SQLFilter(4) &= "[e].[IDNum] like '" & GetDataText(txtIDNum.Text, True) & "'"

                            If (txtPosition.Text.Length > 0) Then SQLFilter(11) &= "[e1].[Position] like '" & GetDataText(txtPosition.Text, True) & "'"

                            If (IsDate(dteAppointmentFrom.Date)) Then SQLFilter(12) &= "[e].[Appointdate] >= '" & dteAppointmentFrom.Date.ToString("yyyy-MM-dd") & "'"

                            If (chkTermination.Checked) Then

                                If (IsDate(dteTerminationFrom.Date)) Then SQLFilter(15) &= "[e].[Termination] = 1"

                                If (Not IsNull(cmbTerminationReason.Value)) Then

                                    If (cmbTerminationReason.Value.ToString().Length > 0) Then SQLFilter(13) &= "[e].[TerminationReason] like '" & GetDataText(cmbTerminationReason.Value.ToString(), True) & "'"

                                End If

                                If (IsDate(dteTerminationFrom.Date)) Then SQLFilter(14) &= "[e].[TerminationDate] >= '" & dteTerminationFrom.Date.ToString("yyyy-MM-dd") & "'"

                            End If

                            If (Not IsNull(cmbJobTitle.Value)) Then

                                If (cmbJobTitle.Value.ToString().Length > 0) Then SQLFilter(5) &= "[e].[JobTitle] like '" & GetDataText(cmbJobTitle.Value.ToString(), True) & "'"

                            End If

                            If (Not IsNull(cmbJobGrade.Value)) Then

                                If (cmbJobGrade.Value.ToString().Length > 0) Then SQLFilter(6) &= "[e].[JobGrade] like '" & GetDataText(cmbJobGrade.Value.ToString(), True) & "'"

                            End If

                            If (Not IsNull(cmbCostCentre.Value)) Then

                                If (cmbCostCentre.Value.ToString().Length > 0) Then SQLFilter(7) &= "[e].[CostCentre] like '" & GetDataText(cmbCostCentre.Value.ToString(), True) & "'"

                            End If

                            If (Not IsNull(cmbDeptName.Value)) Then

                                If (cmbDeptName.Value.ToString().Length > 0) Then SQLFilter(8) &= "[e].[DeptName] like '" & GetDataText(cmbDeptName.Value.ToString(), True) & "'"

                            End If

                            If (Not IsNull(cmbAppointype.Value)) Then

                                If (cmbAppointype.Value.ToString().Length > 0) Then SQLFilter(9) &= "[e].[Appointype] like '" & GetDataText(cmbAppointype.Value.ToString(), True) & "'"

                            End If

                            If (Not IsNull(cmbLocation.Value)) Then

                                If (cmbLocation.Value.ToString().Length > 0) Then SQLFilter(10) &= "[e1].[Location] like '" & GetDataText(cmbLocation.Value.ToString(), True) & "'"

                            End If

                            SQLQuery = String.Empty

                            For iLoop As Integer = 0 To (SQLFilter.Length - 1)

                                If (Not IsNull(SQLFilter(iLoop))) Then SQLQuery &= SQLFilter(iLoop) & " and "

                            Next

                            If (Regex.IsMatch(SQLQuery, "\ and\ $", RegexOptions.IgnoreCase Or RegexOptions.Multiline Or RegexOptions.Singleline)) Then SQLQuery = Regex.Replace(SQLQuery, "\ and\ $", String.Empty, RegexOptions.IgnoreCase Or RegexOptions.Multiline Or RegexOptions.Singleline)

                            If (SQLQuery.Length > 0) Then InsertCache(SQLQuery, "Data.Filter." & Session.SessionID, "<TimeSpan=Days><Duration=1>")

                            dgView_002.DataSource = GetUserGroupAcc(UserGroup, Session.SessionID, "Data.UserGroups.AccessTo.Filter." & Session.SessionID)

                            dgView_002.DataBind()

                    End Select

                End With

            End If

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

        UDetails = GetUserDetails(Session, "Notify Admin")

        LoadData()

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        e.Result = e.Parameter & " "

        Select Case e.Parameter

            Case "Back"
                e.Result &= tabSearch.ActiveTabIndex - 1

            Case "Next"
                e.Result &= tabSearch.ActiveTabIndex + 1

            Case "Submit"
                e.Result &= SUCCESS

        End Select

    End Sub

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Dim dgExports As ASPxGridViewExporter = Nothing

        Try

            dgExports = tabSearch.TabPages(tabSearch.ActiveTabIndex).FindControl(source.ID.ToString().Replace("mnuExport", "dgExports"))

            If (Not IsNull(dgExports)) Then

                Dim xFilePath As String = tabSearch.TabPages(tabSearch.ActiveTabIndex).Text & " [" & Date.Today.ToString("yyyy-MM-dd") & "]"

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

End Class