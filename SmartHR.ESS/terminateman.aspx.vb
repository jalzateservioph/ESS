Public Class terminateman
    Inherits System.Web.UI.Page

    Private CompanyNum As String = String.Empty
    Private EmployeeNum As String = String.Empty
    Private PathID As String = String.Empty

#Region " *** Web Form Functions *** "

    Private Sub LoadData()

        Dim objEmployee() As Object = GetSQLFields("select [CompanyNum], [EmployeeNum], [SQLData] from [ess.SQLExecute] where ([PathID] = " & PathID & ")")

        If (Not IsNull(objEmployee)) Then

            CompanyNum = objEmployee(0)

            EmployeeNum = objEmployee(1)

            Dim SQLData As String = String.Empty

            If (Not IsNull(CompanyNum) AndAlso Not IsNull(EmployeeNum)) Then

                SQLData = "select [c].[CompanyName], [c].[Division], [c].[SubDivision], [c].[SubSubDivision], (select top 1 [Username] from [Users] where ([CompanyNum] = [e].[CompanyNum] and [EmployeeNum] = [e].[EmployeeNum]) order by [DefaultUser] desc) as [UserID], " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & " as [Text], [e].[CompanyNum] + ' ' + [e].[EmployeeNum] as [Value], [e].[Surname], [e].[PreferredName], [e].[FirstName], [JobTitle], [JobGrade], [CostCentre], [DeptName], [Appointype], 'mailto:' + isnull([EMailAddress], '') as [mailto], [EMailAddress], [OfficeNo], [CellTel], [Leave_Scheme], [e1].[ShiftType], [EmployeePicture], cast([OutOfficeStatus] as varchar(3)) as [OutOfficeStatus], 0 as [Processed] from ([Personnel] as [e] left outer join [Personnel1] as [e1] on [e].[CompanyNum] = [e1].[CompanyNum] and [e].[EmployeeNum] = [e1].[EmployeeNum]) left outer join [Company] as [c] on [e].[CompanyNum] = [c].[CompanyNum]<%Terminated%> order by " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & ", [e].[CompanyNum], [e].[EmployeeNum]"

                If (GetArrayItem(Nothing, "eGeneral.ShowTerminated")) Then

                    SQLData = Regex.Replace(SQLData, EscapeRegex("<%Terminated%>"), " where ([e].[CompanyNum] = '" & CompanyNum & "' and [e].[EmployeeNum] = '" & EmployeeNum & "')", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                Else

                    SQLData = Regex.Replace(SQLData, EscapeRegex("<%Terminated%>"), " where ((((([e].[Appointdate] <= '" & Today.ToString("yyyy-MM-dd") & "') and (not [e].[Termination] = 1)) or (([e].[Termination] = 1) and ([e].[Appointdate] <= '" & Today.ToString("yyyy-MM-dd") & "') and ([e].[TerminationDate] > '" & Today.ToString("yyyy-MM-dd") & "')))) and ([e].[CompanyNum] = '" & CompanyNum & "' and [e].[EmployeeNum] = '" & EmployeeNum & "'))", RegexOptions.Singleline Or RegexOptions.Multiline Or RegexOptions.IgnoreCase)

                End If

                cmbEmployee.DataSource = GetSQLDT(SQLData)

                cmbEmployee.DataBind()

                If (Not IsPostBack) Then cmbEmployee.Value = CompanyNum & " " & EmployeeNum

            End If

            LoadExpDS(dsTermination, "select [TerminationReason] from [TerminationReasonLU] order by [TerminationReason]")

            If (Not dteTermination.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom) Then

                dteTermination.EditFormat = DevExpress.Web.ASPxEditors.EditFormat.Custom
                dteTermination.EditFormatString = GetArrayItem(Nothing, "eGeneral.DateFormat")

            End If

            SQLData = objEmployee(2)

            If (Not IsNull(SQLData) AndAlso Not IsPostBack) Then

                Dim TermDate As String = GetXML(SQLData, KeyName:="TerminationDate")

                dteTermination.Date = New Date(Convert.ToInt32(TermDate.Substring(0, 4)), Convert.ToInt32(TermDate.Substring(5, 2)), Convert.ToInt32(TermDate.Substring(8, 2)))

                cmbReason.Value = GetXML(SQLData, KeyName:="TerminationReason")

            End If

        End If

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        PathID = String.Empty

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        LoadData()

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim Values() As String = e.Parameter.Split(" ")

        PathID = String.Empty

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        Dim bSaved As Boolean = ExecSQL("update [ess.SQLExecute] set [SQLExec] = 'update [Personnel] set [Termination] = 1, [TerminationReason] = ''" & cmbReason.Value.ToString() & "'', [TerminationDate] = ''" & dteTermination.Date.ToString("yyyy-MM-dd HH:mm:ss") & "'' where ([CompanyNum] = ''<CompanyNum>'' and [EmployeeNum] = ''<EmployeeNum>'')', [SQLData] = '<TerminationDate=" & dteTermination.Date.ToString("yyyy-MM-dd") & "><TerminationReason=" & cmbReason.Value.ToString() & ">' where ([PathID] = " & PathID & ")")

        If (bSaved) Then

            Dim PathData As String = GetPathData(PathID)

            bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & CompanyNum & "', '" & EmployeeNum & "', " & PathID & ", 'Terminations', 'Terminations', '" & Values(0) & "', '" & GetXML(PathData, KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'")

            If (Values(1).Length > 0) Then bSaved = ExecSQL("insert into [ess.WFRemarks]([CompanyNum], [EmployeeNum], [CaptureDate], [Remarks], [PathID]) values('" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & Now().ToString("yyyy-MM-dd HH:mm:ss") & "', '" & GetDataText(Values(1)) & "', " & PathID & ")")

            If (bSaved) Then e.Result = "tasks.aspx tools/index.aspx"

        End If

    End Sub

#End Region

End Class