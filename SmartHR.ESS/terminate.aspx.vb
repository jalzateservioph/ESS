Public Class terminate
    Inherits System.Web.UI.Page

#Region " *** Web Form Functions *** "

    Private Sub LoadData()

        Dim UserGroup As String = String.Empty

        If (Not IsNull(Session("LoggedOn"))) Then

            UserGroup = GetUserGroup(Session("LoggedOn").UserID, Session.SessionID)

            If (Not IsNull(UserGroup)) Then

                If (cmbEmployee.Items.Count = 0) Then

                    cmbEmployee.DataSource = GetUserGroupAcc(UserGroup, Session.SessionID)

                    cmbEmployee.DataBind()

                End If

            End If

        End If

        LoadExpDS(dsTermination, "select [TerminationReason] from [TerminationReasonLU] order by [TerminationReason]")

        If (Not dteTermination.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom) Then

            dteTermination.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom
            dteTermination.EditFormatString = GetArrayItem(Nothing, "eGeneral.DateFormat")

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

        LoadData()

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        If (e.Parameter = "Submit") Then

            Dim CompanyNum As String = cmbEmployee.Value.ToString().Split(" ")(0)

            Dim EmployeeNum As String = cmbEmployee.Value.ToString().Split(" ")(1)

            Dim bSaved As Boolean = ExecSQL("insert into [ess.SQLExecute]([ID], [CompanyNum], [EmployeeNum], [ExecuteOn], [SQLExec], [SQLData], [Status]) values('" & Guid.NewGuid().ToString() & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & dteTermination.Date.ToString("yyyy-MM-dd HH:mm:ss") & "', 'update [Personnel] set [Termination] = 1, [TerminationReason] = ''" & cmbReason.Value.ToString() & "'', [TerminationDate] = ''" & dteTermination.Date.ToString("yyyy-MM-dd HH:mm:ss") & "'' where ([CompanyNum] = ''<CompanyNum>'' and [EmployeeNum] = ''<EmployeeNum>'')', '<CompanyNum=" & CompanyNum & "><EmployeeNum=" & EmployeeNum & "><TerminationDate=" & dteTermination.Date.ToString("yyyy-MM-dd") & "><TerminationReason=" & cmbReason.Value.ToString() & ">', 'New')")

            If (bSaved) Then bSaved = ExecSQL("update [Personnel] set [TerminationDate] = '" & dteTermination.Date.ToString("yyyy-MM-dd HH:mm:ss") & "', [TerminationReason] = '" & cmbReason.Value.ToString() & "', [Status] = 'New', [PathID] = null where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "')")

            If (bSaved) Then

                Dim SQL As String = "exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & CompanyNum & "', '" & EmployeeNum & "', 0, 'Terminations', 'Terminations', 'Start', 'Start', '" & Now().ToString("yyyy-MM-dd HH:mm:ss") & "'"

                bSaved = ExecSQL(SQL)

                If (bSaved) Then

                    If (IsString(txtNotes.Text)) Then ExecSQL("insert into [ess.WFRemarks]([CompanyNum], [EmployeeNum], [CaptureDate], [Remarks], [PathID]) values('" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & Now().ToString("yyyy-MM-dd HH:mm:ss") & "', '" & GetDataText(txtNotes.Text) & "', " & GetXML(SQL, KeyName:="PathID") & ")")

                    e.Result = "tasks.aspx tools/index.aspx"

                End If

            End If

        End If

    End Sub

#End Region

End Class