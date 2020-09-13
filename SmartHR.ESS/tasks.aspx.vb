Imports DevExpress.Web.ASPxGridView.Export
Imports System.IO

Partial Public Class tasks
    Inherits System.Web.UI.Page

    Private cpHtmlText As String = String.Empty
    Private cpShowDetails As Boolean = False
    Private cpURL As String = String.Empty
    Private UDetails As Users = Nothing
    Private UserGroup As String = String.Empty

#Region " *** Web Form Functions *** "

    Private Function GetUrl(ByVal sender As Object, ByVal iRowIndex As Integer) As String

        Dim ReturnText As String = String.Empty

        Dim WFType As String = String.Empty

        Dim AppType As String = String.Empty

        Dim PathID As String = String.Empty

        Dim Summary As String = String.Empty

        Try

            With sender

                PathID = .GetRowValues(iRowIndex, "CompositeKey").ToString()

                Session("PathID") = PathID

                WFType = GetXML(.GetRowValues(iRowIndex, "XMLTag"), KeyName:="WFType")

                AppType = GetXML(.GetRowValues(iRowIndex, "XMLTag"), KeyName:="AppType")

                Summary = .GetRowValues(iRowIndex, "Summary").ToString()

                Dim AppStatus As String = .GetRowValues(iRowIndex, "AppStatus").ToString()

                Dim CompanyNum As String = .GetRowValues(iRowIndex, "OriginatorCompanyNum").ToString()
                Dim EmployeeNum As String = .GetRowValues(iRowIndex, "OriginatorEmployeeNum").ToString()

                SetEmployeeData(Session, CompanyNum & " " & EmployeeNum)

                Select Case WFType.ToLower()

                    Case "basic conditions"
                        ReturnText = "conditionsman.aspx?ID=" & PathID

                    Case "change"
                        ReturnText = "changeman.aspx?ID=" & PathID

                    Case "claims"
                        ReturnText = "claimsman.aspx?ID=" & PathID

                    Case "ir"
                        If (Summary.ToLower() = "ir performance") Then

                            ReturnText = "irman_001.aspx?ID=" & PathID

                        Else

                            ReturnText = "irman_002.aspx?ID=" & PathID

                        End If

                    Case "leave"
                        If (AppStatus.ToLower() = "adjust") Then

                            ReturnText = "leaveadjust.aspx?ID=" & PathID

                        Else

                            ReturnText = "leaveman.aspx?ID=" & PathID

                            If (Summary = "Leave Cancellation") Then ReturnText &= "&Cancel=True"

                        End If

                    Case "loans", "stores"
                        If (WFType.ToLower() = "loans") Then

                            ReturnText = "loans"

                        Else

                            ReturnText = "assets"

                        End If

                        ReturnText &= "man.aspx?ID=" & PathID

                        If ((Summary = "Stores Cancellation") Or (Summary = "Loan Cancellation")) Then ReturnText &= "&Cancel=True"

                    Case "notify"
                        ReturnText = "notify.aspx?ID=" & PathID

                    Case "onboarding"
                        ReturnText = "employee.aspx?CompanyNum=" & CompanyNum & "&EmployeeNum=" & EmployeeNum & "&ID=" & PathID

                        '    Case "pd standards"
                        '        SetManagedUser(Me, CompanyNum, EmployeeNum, Template, "Development Tab")

                        '        'TODO: Ensure PD Standard tasks are resolved
                        '        'Select Case Summary.ToLower()

                        '        '    Case "learning application"

                        '        '        If (GetArrayItem(hSetup, "Basic")) Then

                        '        '            url = "pdstandardsman_004.aspx?ID=" & PathID

                        '        '        Else

                        '        '            url = "pdstandardsman_009.aspx?ID=" & PathID

                        '        '        End If

                        '        '        'url = "lnatrainform.aspx?PathID=" & e.Item.Cells(0).Text & "&ActionType=" & e.Item.Cells(4).Text

                        '        '    Case "learning program"

                        '        '        url = "pdstandardsman_002.aspx?ID=" & PathID

                        '        '        'url = "lnaacceptance.aspx?PathID=" & e.Item.Cells(0).Text & "&ActionType=" & e.Item.Cells(4).Text

                        '        '    Case "learning evaluation"

                        '        '        If (GetArrayItem(hSetup, "Basic")) Then

                        '        '            url = "pdstandardsman_005.aspx?ID=" & PathID

                        '        '        Else

                        '        '            url = "pdstandardsman_010.aspx?ID=" & PathID

                        '        '        End If

                        '        '        'url = "perfeval.aspx?CID=" & CompanyNum & "&EID=" & EmployeeNum & "&PathID=" & e.Item.Cells(0).Text & "&ActionType=" & e.Item.Cells(4).Text & "&TType=" & e.Item.Cells(2).Text

                        '        'End Select

                    Case "performance"
                        Session.Add("PathID", PathID)
                        'MARCO CODE BEGIN

                        Dim SchemeCode As String = GetSQLField("SELECT [SchemeCode] FROM [PerfEvalScheme] WHERE [PathID]=" & PathID & "", "SchemeCode")

                        ReturnText = "performanceman_00" & If(SchemeCode.Contains("TWS"), "4", "2") & ".aspx?ID=" & PathID

                        'MARCO CODE END

                    Case "terminations"
                        ReturnText = "terminateman.aspx?ID=" & PathID

                    Case "timesheet"
                        ReturnText = "timesheetsman.aspx?ID=" & PathID

                    Case "training"
                        ReturnText = "trainingman.aspx?ID=" & PathID

                        If AppType.ToString().ToLower() = "evaluation" Then

                            ReturnText = "trainingevaluation.aspx?ID=" & PathID

                        ElseIf AppType.ToString().ToLower() = "agreement" Then

                            ReturnText = "trainingagreementman.aspx?ID=" & PathID

                        Else

                            ReturnText = "trainingman.aspx?ID=" & PathID

                            If ((Summary = "Training Cancellation") Or (Summary = "Training Cancellation")) Then ReturnText &= "&Cancel=True"

                        End If

                    Case "transfers"
                        ReturnText = "transferman.aspx?ID=" & PathID

                End Select

            End With

        Catch ex As Exception

        Finally

        End Try

        Return ReturnText

    End Function

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim redirected As String = Request.QueryString("Eval")

        If redirected = "success" Then

            ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "SuccessSubmitShow", "window.parent.ShowPopup(""success Thank you and we appreciate your feedback."")", True)

        End If

        If (Session("docUnread")) Then

            Response.Redirect("documentmapman.aspx", True)

            Exit Sub

        End If

        If (IsNumeric(Request.QueryString("TabID"))) Then tabTasks.ActiveTabIndex = Convert.ToInt32(Request.QueryString("TabID").ToString())

        If (Not IsPostBack) Then

            ClearFromCache("Data.Tasks.Inbox." & Session.SessionID)

            ClearFromCache("Data.Tasks.Alternative." & Session.SessionID)

            ClearFromCache("Data.Tasks.Pending." & Session.SessionID)

            ClearFromCache("Data.Tasks.Completed." & Session.SessionID)

            SetEmployeeData(Session, Session("Selected.Value"))

        End If

        If (Not IsNull(Session("LoggedOn"))) Then UserGroup = GetUserGroup(Session("LoggedOn").UserID, Session.SessionID)

        UDetails = GetUserDetails(Session, "Tasks")

        Try

            If (Not IsNull(Session("Managed"))) Then

                With Session("Managed")

                    Select Case tabTasks.ActiveTabIndex

                        Case 0

                            Dim dtResults As DataTable = Nothing

                            Dim objValues() As Object = Nothing

                            Try

                                dtResults = GetUserGroupAcc(UserGroup, Session.SessionID, "Data.UserGroups.AccessTo.Filter." & Session.SessionID)

                                If (IsData(dtResults)) Then

                                    If (dtResults.Columns.IndexOf("Count") = -1) Then dtResults.Columns.Add("Count")

                                    If (dtResults.Columns.IndexOf("Created") = -1) Then dtResults.Columns.Add("Created")

                                    If (dtResults.Columns.IndexOf("Actioned") = -1) Then dtResults.Columns.Add("Actioned")

                                    If (dtResults.Columns.IndexOf("AveDays") = -1) Then dtResults.Columns.Add("AveDays")

                                    '# of Tasks - Count
                                    'Days Since Task Created - Created
                                    'Days Since Last Task Actioned - Actioned
                                    'Avg Days Last Actioned - AveDays

                                    If (Convert.ToBoolean(GetArrayItem(Session("Managed").Template, "eGeneral.TaskResults"))) Then

                                        For i As Integer = 0 To (dtResults.Rows.Count - 1)

                                            objValues = GetSQLFields("select count([ID]) as [Count], datediff(day, min([OriginatorDate]), getdate()) as [Created], datediff(day, min([ActionDate]), getdate()) as [Actioned], sum(datediff(day, [ActionDate], getdate())) as [ActionedSum] from [ess.Path] where ((not (select [StatusID] from [ess.WF] where [id] = [ess.Path].[WFID]) in(select [id] from [ess.StatusLU] where [Status] = 'Start')) and ([ActionerUsername] = (select top 1 [Username] from [Users] where ([CompanyNum] + ' ' + [EmployeeNum] = '" & GetDataText(dtResults.Rows(i).Item("Value").ToString()) & "') order by [DefaultUser] desc)) and (([Frozen] is null) or ([Frozen] = 0)))")

                                            If (Not IsNull(objValues)) Then

                                                If (IsNumeric(objValues(0))) Then

                                                    dtResults.Rows(i).Item("Count") = Convert.ToSingle(objValues(0))

                                                Else

                                                    dtResults.Rows(i).Item("Count") = 0

                                                End If

                                                If (IsNumeric(objValues(1))) Then

                                                    dtResults.Rows(i).Item("Created") = Convert.ToSingle(objValues(1))

                                                Else

                                                    dtResults.Rows(i).Item("Created") = 0

                                                End If

                                                If (IsNumeric(objValues(2))) Then

                                                    dtResults.Rows(i).Item("Actioned") = Convert.ToSingle(objValues(2))

                                                Else

                                                    dtResults.Rows(i).Item("Actioned") = 0

                                                End If

                                                If (IsNumeric(objValues(0)) AndAlso IsNumeric(objValues(3))) Then

                                                    If (Convert.ToSingle(objValues(0)) > 0) Then

                                                        dtResults.Rows(i).Item("AveDays") = Convert.ToSingle(Convert.ToSingle(objValues(3)) / Convert.ToSingle(objValues(0))).ToString("0")

                                                    Else

                                                        dtResults.Rows(i).Item("AveDays") = 0

                                                    End If

                                                Else

                                                    dtResults.Rows(i).Item("AveDays") = 0

                                                End If

                                            Else

                                                dtResults.Rows(i).Item("Count") = 0

                                                dtResults.Rows(i).Item("Created") = 0

                                                dtResults.Rows(i).Item("Actioned") = 0

                                                dtResults.Rows(i).Item("AveDays") = 0

                                            End If

                                        Next

                                    End If

                                    dgView_005.DataSource = dtResults

                                    dgView_005.DataBind()

                                End If

                            Catch ex As Exception

                            Finally

                                If (Not IsNull(objValues)) Then objValues = Nothing

                                If (Not IsNull(dtResults)) Then

                                    dtResults.Dispose()

                                    dtResults = Nothing

                                End If

                            End Try

                        Case 1

                            Dim dtSource As DataTable = GetSQLDT("select [ID] as [CompositeKey], [Originator], [XMLTag], [ActionDate], [PrevActioner], [OriginatorCompanyNum], [OriginatorEmployeeNum], (select [Status] from [ess.StatusLU] where ([id] = (select [StatusID] from [ess.WF] where ([id] = [ess.Path].[WFID])))) as [AppStatus], [Summary], (select [WFType] from [ess.WFLU] where ([id] = (select [WFLUID] from [ess.WF] where ([id] = [ess.Path].[WFID])))) as [WFType] from [ess.Path] where ((not (select [StatusID] from [ess.WF] where [id] = [ess.Path].[WFID]) in(select [id] from [ess.StatusLU] where [Status] = 'Start')) and ([ActionerUsername] = '" & .UserID & "') and (([Frozen] is null) or ([Frozen] = 0)))", "Data.Tasks.Inbox." & Session.SessionID)

                            Dim dtExpiration As Date = CType(If(GetArrayItem(Nothing, "ePerformance.TWSExpirationDate"), System.DateTime.Now.AddDays(5).Date), Date)

                            For iLoop As Integer = 0 To dtSource.Rows.Count - 1
                                Try
                                    Dim iRow As DataRow = dtSource.Rows(iLoop)
                                    If iRow(8).ToString.Contains("Performance") Then
                                        Dim PathID As String = iRow(0).ToString()
                                        Dim dr As DataRow = GetSQLDT("SELECT SchemeCode,Completed FROM PerfEvalScheme WHERE PathID = " & PathID).Rows(0)
                                        If (dr(0).ToString().Contains("TWS") AndAlso dr(1) = True) OrElse (dr(0).ToString().Contains("TWS") AndAlso System.DateTime.Now.Date > dtExpiration) Then
                                            dtSource.Rows(iLoop).Delete()
                                        End If
                                    End If
                                Catch ex As Exception

                                End Try

                            Next

                            dgView_001.DataSource = dtSource

                            GridFormat(dgView_001, .Template)

                            dgView_001.DataBind()

                        Case 2
                            dgView_002.DataSource = GetSQLDT("select [ID] as [CompositeKey], [Originator], [XMLTag], [ActionDate], [Actioner], [PrevActioner], [OriginatorCompanyNum], [OriginatorEmployeeNum], (select [Status] from [ess.StatusLU] where ([id] = (select [StatusID] from [ess.WF] where ([id] = [ess.Path].[WFID])))) as [AppStatus], [Summary], (select [WFType] from [ess.WFLU] where ([id] = (select [WFLUID] from [ess.WF] where ([id] = [ess.Path].[WFID])))) as [WFType] from [ess.Path] where (((select top 1 [Username] from [Users] where ([CompanyNum] = '" & .CompanyNum & "') and ([EmployeeNum] = '" & .EmployeeNum & "') order by [DefaultUser] desc) = '" & .UserID & "') and ([dbo].[GetAltTasks](N'" & .CompanyNum & "', N'" & .EmployeeNum & "', [ess.Path].[OriginatorCompanyNum], [ess.Path].[OriginatorEmployeeNum], [ess.Path].[WFID]) = 1) and ([ess.Path].[PAID] in(select [id] from [ess.PALU] where [PostActionType] in('Start', 'Pending'))))", "Data.Tasks.Alternative." & Session.SessionID)

                            GridFormat(dgView_002, .Template)

                            dgView_002.DataBind()

                        Case 3
                            Dim dtSource As DataTable = GetSQLDT("select [ID] as [CompositeKey], [XMLTag], [ActionDate], [Actioner], [PrevActioner], [Summary], (select [WFType] from [ess.WFLU] where ([id] = (select [WFLUID] from [ess.WF] where ([id] = [ess.Path].[WFID])))) as [WFType] from [ess.Path] where ((not (select [StatusID] from [ess.WF] where [id] = [ess.Path].[WFID]) in(select [id] from [ess.StatusLU] where [Status] = 'Start')) and ([OriginatorUsername] = '" & .UserID & "') and (([Frozen] is null) or ([Frozen] = 0)))", "Data.Tasks.Pending." & Session.SessionID)

                            Dim dtExpiration As Date = CType(If(GetArrayItem(Nothing, "ePerformance.TWSExpirationDate"), System.DateTime.Now.AddDays(5).Date), Date)

                            For iLoop As Integer = 0 To dtSource.Rows.Count - 1
                                Try
                                    Dim iRow As DataRow = dtSource.Rows(iLoop)
                                    If iRow(6).ToString.Contains("Performance") Then
                                        Dim PathID As String = iRow(0).ToString()
                                        Dim dr As DataRow = GetSQLDT("SELECT SchemeCode,Completed FROM PerfEvalScheme WHERE PathID = " & PathID).Rows(0)
                                        If (dr(0).ToString().Contains("TWS") AndAlso dr(1) = True) OrElse (dr(0).ToString().Contains("TWS") AndAlso System.DateTime.Now.Date > dtExpiration) Then
                                            dtSource.Rows(iLoop).Delete()
                                        End If
                                    End If
                                Catch ex As Exception

                                End Try
                            Next
                            dgView_003.DataSource = dtSource

                            GridFormat(dgView_003, .Template)

                            dgView_003.DataBind()

                        Case 4
                            With UDetails
                                dgView_004.DataSource = GetSQLDT("select [ID] as [CompositeKey], [XMLTag], [ActionDate], [PrevActioner], [Summary], (select [WFType] from [ess.WFLU] where ([id] = (select [WFLUID] from [ess.WF] where ([id] = [ess.Path].[WFID])))) as [WFType] from [ess.Path] where (((select [StatusID] from [ess.WF] where [id] = [ess.Path].[WFID]) in(select [id] from [ess.StatusLU] where [Status] = 'Start')) and ([ActionerUsername] = '" & UDetails.UserID & "') and (([Frozen] is null) or ([Frozen] = 0)))", "Data.Tasks.Completed." & Session.SessionID)

                                GridFormat(dgView_004, .Template)

                                dgView_004.DataBind()
                            End With
                    End Select

                End With

            End If

        Catch ex As Exception

        End Try

    End Sub

    Private Sub dgView_001_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs) Handles dgView_001.CustomCallback, dgView_002.CustomCallback, dgView_003.CustomCallback, dgView_004.CustomCallback

        pcDetails.ScrollBars = ScrollBars.Vertical

        If (IsNumeric(e.Parameters)) Then

            cpURL = GetUrl(sender, Convert.ToInt32(e.Parameters)).Replace("""", "\""").Replace("'", "\'")

        Else

            cpURL = String.Empty

            Dim SQL As String = String.Empty

            Dim PathID As Integer = 0

            Dim dtData As DataTable = Nothing

            Dim iIndex As Integer = Convert.ToInt32(e.Parameters.Split(" ")(1))

            Try

                PathID = Convert.ToInt32(sender.GetRowValues(iIndex, "CompositeKey"))

                Dim xmlTag As String = sender.GetRowValues(iIndex, "XMLTag").ToString()

                Dim appType As String = GetXML(xmlTag, KeyName:="AppType")

                Select Case GetXML(xmlTag, KeyName:="WFType")

                    Case "Change"
                        'Added another status 'Returned'
                        SQL = String.Format("SELECT [NotifyDate] AS [Date], (SELECT [Key] FROM [ess.Policy] WHERE ([ID] = [C].[PolicyID])) AS [Item], [ValueF] AS [Changed From], [ValueT] AS [Changed To], (CASE WHEN ActionedBy = 1 THEN 'Approved' WHEN ActionedBy = 0 THEN 'Returned' ELSE 'Rejected' END) AS [Status] FROM (SELECT *, NULL AS ActionedBy FROM [ess.Change] WHERE PathID <> '{0}' UNION SELECT * FROM [ess.Reject]) AS [C] WHERE [PathID] = '{0}' ORDER BY [PolicyID]", PathID.ToString())
                        'SQL = String.Format("SELECT A.NotifyDate AS [Date], (SELECT [Key] FROM [ess.Policy] WHERE ([ID] = [B].[PolicyID])) AS [Item], A.[ValueF] AS [Changed From], A.[ValueT] AS [Changed To], (CASE WHEN B.ActionedBy = 1 THEN 'Approved' WHEN ActionedBy = 0 THEN 'Returned' ELSE 'Rejected' END ) AS [Status] FROM [ess.Change] A  RIGHT JOIN [ess.Reject] B ON B.PathID = A.PathID WHERE A.PathID = {0} ORDER BY B.PolicyID", PathID.ToString())
                    Case "Claims"
                        SQL = "select [Date] as [Claim Date], [Type], [CapturedDate] as [Captured On], [Username] as [Captured By], (select sum([Amount]) from [ClaimEntries] where ([CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Date], 120) + ' ' + [Type] = (select [CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [Date], 120) + ' ' + [Type] from [Claims] where ([PathID] = " & PathID.ToString() & ")))) as [Total Claim], [Status], [Description] from [Claims] where ([PathID] = " & PathID.ToString() & ")"

                    Case "IR"

                    Case "Leave"
                        SQL = "select [StartDate] as [Start], [EndDate] as [Until], [CaptureDate] as [Captured On], [CapturedByUsername] as [Captured By], [LeaveStatus] as [Status], [Remarks] as [Description] from [Leave] where ([PathID] = " & PathID.ToString() & ")"

                    Case "Loans"
                        SQL = "select [LoanDate] as [Date], [FirstInstallment] as [Installment Date], [Term] as [Period], [IntRate] as [Rate], [Amount] as [Loan Amount], [CapturedDate] as [Captured On], [CapturedByUsername] as [Captured By], [LoanStatus] as [Status], [Description] from [Loan] where ([PathID] = " & PathID.ToString() & ")"

                    Case "Notify"
                        SQL = "select [DateNotified] as [Notification Date], [Status], [Subject] from [ess.NotifyHR] where ([PathID] = " & PathID.ToString() & ")"

                    Case "Onboarding"

                    Case "Performance"
                        SQL = "select [EvalDate] as [Evaluation Date], [SchemeCode] as [Scheme Code], [Name] as [Scheme Name], [Score] as [Total Score] from [PerfEvalScheme] where ([PathID] = " & PathID.ToString() & ")"

                    Case "Registration"

                    Case "Stores"
                        SQL = "select [IssueDate] as [Date Issued], [ItemCode] as [Code], (select [ItemDescription] from [StoresItems] where ([CompanyNum] + ' ' + [ItemCode] = (select [CompanyNum] + ' ' + [ItemCode] from [StoreIssued] where ([PathID] = " & PathID.ToString() & ")))) as [Name], [Quantity], [CapturedDate] as [Captured On], [CapturedByUsername] as [Captured By], [StoreStatus] as [Status], [Remarks] as [Description] from [StoreIssued] where ([PathID] = " & PathID.ToString() & ")"

                    Case "Terminations"

                    Case "Timesheet"
                        SQL = "select [Start], [Until], [Type], [CapturedDate] as [Captured On], [Username] as [Captured By], [Status], [Description] from [Timesheets] where ([PathID] = " & PathID.ToString() & ")"

                    Case "Training"

                        If appType = "Evaluation" Then

                            SQL =
                                "SELECT " +
                                "	[Training Type] = " +
                                "		CASE WHEN [TrainingType] = 1 THEN 'In-house' " +
                                "			 WHEN [TrainingType] = 2 THEN 'External' " +
                                "			 WHEN [TrainingType] = 3 THEN 'Overseas' " +
                                "		END, " +
                                "	[Training Course] = [CourseName], " +
                                "	[Provider] = [ProviderName], " +
                                "	[Schedule Dates] = " +
                                "		CONVERT(VARCHAR, [StartDate], 101) + ' - ' + " +
                                "		CONVERT(VARCHAR, [EndDate], 101) " +
                                "FROM [TrainingEvaluation] " +
                                "WHERE [PathID] = " + PathID.ToString() + " "

                        ElseIf appType = "Agreement" Then

                            SQL =
                                "SELECT " +
                                "	[Ext. Position Title] = [ExternalPositionTitle], " +
                                "	[Date Prepared] = [DatePrepared] " +
                                "FROM [TrainingAgreementForm] " +
                                "WHERE [PathID] = " + PathID.ToString() + " "

                        Else

                            SQL = "select [StartDate] as [Start], [CompletionDate] as [Completed On], [CourseName] as [Course], [ProviderName] as [Provider], [CapturedByUsername] as [Captured By], [TrainingStatus] from [TrainingPlanned] where ([PathID] = " & PathID.ToString() & ")"

                        End If

                    Case "Transfers"

                End Select

                dtData = GetSQLDT(SQL)

                If (IsData(dtData)) Then

                    cpHtmlText = "<table cellpadding=""0"" style=""text-align: left; width: 100%"">"

                    For x As Integer = 0 To (dtData.Rows.Count - 1)

                        For i As Integer = 0 To (dtData.Columns.Count - 1)

                            cpHtmlText &= "<tr>"

                            cpHtmlText &= "<td style=""font-weight: bold; text-align: right; width: 125px"">" & dtData.Columns(i).ColumnName & "</td><td style=""width: 10px"" /><td>"

                            If (IsDate(dtData.Rows(x).Item(i))) Then

                                Dim dtDate As Date = dtData.Rows(x).Item(i)

                                cpHtmlText &= dtDate.ToString(GetArrayItem(Session("Managed").Template, "eGeneral.DateFormat"))

                            ElseIf (dtData.Columns(i).ColumnName = "Total Claim" OrElse dtData.Columns(i).ColumnName = "Loan Amount" OrElse dtData.Columns(i).ColumnName = "Total Score") Then 'If (IsNumeric(dtData.Rows(x).Item(i))) Then

                                cpHtmlText &= Convert.ToSingle(dtData.Rows(x).Item(i)).ToString("0.00")

                            Else

                                cpHtmlText &= dtData.Rows(x).Item(i).ToString()

                            End If

                            cpHtmlText &= "</td></tr>"

                        Next

                        If (x < (dtData.Rows.Count - 1)) Then cpHtmlText &= "<tr><td colspan=""3"" style=""height: 5px"" /></tr>"

                    Next

                    cpHtmlText &= "</table>"

                End If

                cpShowDetails = True

            Catch ex As Exception

            Finally

                If (Not IsNull(dtData)) Then

                    dtData.Dispose()

                    dtData = Nothing

                End If

            End Try

        End If

    End Sub

    Private Sub dgView_001_CustomColumnDisplayText(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewColumnDisplayTextEventArgs) Handles dgView_001.CustomColumnDisplayText, dgView_002.CustomColumnDisplayText, dgView_003.CustomColumnDisplayText, dgView_004.CustomColumnDisplayText

        If (e.Column.FieldName = "XMLTag") Then

            Dim xmlTag As String = e.GetFieldValue("XMLTag").ToString()

            If (xmlTag.Length = 0) Then

                xmlTag =
                    "<WFType=" & sender.GetRowValues(e.VisibleRowIndex, "WFType") & ">" &
                    "<AppType=" & sender.GetRowValues(e.VisibleRowIndex, "Summary") & ">"

            End If

            Dim wfType As String = GetXML(xmlTag, KeyName:="WFType")
            Dim appType As String = GetXML(xmlTag, KeyName:="AppType")

            If (wfType.ToLower() = "performance") Then

                Dim PerfGroupName As String = GetSQLField("select [GroupName] from [PerfEvalScheme] where ([PathID] = " & sender.GetRowValues(e.VisibleRowIndex, "CompositeKey") & ")", "GroupName")

                If (IsNull(PerfGroupName)) Then PerfGroupName = "Performance"

                e.DisplayText = wfType & ": " & PerfGroupName

            ElseIf (wfType.ToLower() = "training") Then

                Dim summary As String = sender.GetRowValues(e.VisibleRowIndex, "Summary").ToString()

                If appType.ToLower() = "evaluation" Then

                    Dim summaryArr As String() = summary.Split(New Char() {":"})

                    e.DisplayText =
                        IIf(summaryArr.Length > 1, summaryArr(0).Trim(), "") & ": " &
                        appType & ": "

                    If summaryArr.Length > 1 Then

                        e.DisplayText += summaryArr(1).Trim()

                    Else

                        e.DisplayText += summaryArr(0).Trim()

                    End If

                ElseIf appType.ToLower() = "training" Or appType.ToLower() = "agreement" Then

                    e.DisplayText =
                        wfType & ": " &
                        appType & ": " &
                        summary & ": " &
                        GetXML(xmlTag, KeyName:="StartDate")

                Else

                    e.DisplayText = wfType & ": " & appType

                End If

            Else

                e.DisplayText = wfType & ": " & appType

            End If

        ElseIf ((GetXML(e.GetFieldValue("XMLTag").ToString(), KeyName:="WFType").ToLower() = "performance") AndAlso (Not IsNull(e.GetFieldValue("PrevActioner"))) AndAlso (Not GetArrayItem(UDetails.Template, "ePerformance.DisplayNames")) AndAlso ((e.Column.FieldName = "Actioner") OrElse (e.Column.FieldName = "PrevActioner"))) Then

            e.DisplayText = "* hidden"

        End If

    End Sub

    Private Sub dgView_001_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_001.CustomJSProperties, dgView_002.CustomJSProperties, dgView_003.CustomJSProperties, dgView_004.CustomJSProperties

        Dim cpToolURL As String = cpURL

        If (cpToolURL.ToLower().Contains(".aspx")) Then

            cpToolURL = cpToolURL.Substring(0, cpToolURL.IndexOf(".aspx"))

            cpToolURL &= ".aspx"

            If (File.Exists(Server.MapPath(String.Empty) & "\tools\" & cpToolURL.Replace("/", "\"))) Then

                cpToolURL = "tools/" & cpToolURL

            Else

                cpToolURL = "tools/index.aspx"

            End If

        Else

            cpToolURL = "tools/index.aspx"

        End If

        e.Properties("cpHtmlText") = cpHtmlText

        e.Properties("cpURL") = cpURL

        e.Properties("cpToolURL") = cpToolURL

        e.Properties("cpShowDetails") = cpShowDetails

    End Sub

    Private Sub dgView_001_HeaderFilterFillItems(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewHeaderFilterEventArgs) Handles dgView_001.HeaderFilterFillItems, dgView_002.HeaderFilterFillItems, dgView_003.HeaderFilterFillItems, dgView_004.HeaderFilterFillItems

        If (e.Column.FieldName = "XMLTag") Then

            For i As Integer = 0 To (e.Values.Count - 1)

                e.Values(i).DisplayText = Regex.Replace(e.Values(i).DisplayText, EscapeRegex("&lt;"), "<", RegexOptions.IgnoreCase Or RegexOptions.Singleline Or RegexOptions.Multiline)

                e.Values(i).DisplayText = Regex.Replace(e.Values(i).DisplayText, EscapeRegex("&gt;"), ">", RegexOptions.IgnoreCase Or RegexOptions.Singleline Or RegexOptions.Multiline)

                If (e.Values(i).DisplayText.Contains("<") AndAlso e.Values(i).DisplayText.Contains(">")) Then e.Values(i).DisplayText = GetXML(e.Values(i).DisplayText, KeyName:="WFType") & ": " & GetXML(e.Values(i).DisplayText, KeyName:="AppType")

            Next

        End If

    End Sub

    Private Sub dgView_005_HtmlDataCellPrepared(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewTableDataCellEventArgs) Handles dgView_005.HtmlDataCellPrepared

        If (e.DataColumn.FieldName = "Text") Then

            e.Cell.Style.Add("color", "#5689c5")

            e.Cell.Style.Add("cursor", "pointer")

            e.Cell.Style.Add("text-decoration", "none")

            e.Cell.Attributes.Add("onclick", "window.parent.cmbEmployee.SetValue('" & sender.GetRowValues(e.VisibleIndex, "Value").ToString() & "'); window.parent.lpPage.Show(); window.parent.cpPanes.PerformCallback('load\ ' + '" & sender.GetRowValues(e.VisibleIndex, "Value").ToString() & "' + '\ ' + '" & sender.GetRowValues(e.VisibleIndex, "Text").ToString() & "' + '\ tasks.aspx?TabID=1');")

        End If

    End Sub

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Dim dgExports As ASPxGridViewExporter = Nothing

        Try

            dgExports = tabTasks.TabPages(tabTasks.ActiveTabIndex).FindControl(source.ID.ToString().Replace("mnuExport", "dgExports"))

            If (Not IsNull(dgExports)) Then

                Dim xFilePath As String = tabTasks.TabPages(tabTasks.ActiveTabIndex).Text & " [" & Date.Today.ToString("yyyy-MM-dd") & "]"

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

    Private Sub tabTasks_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CustomJSPropertiesEventArgs) Handles tabTasks.CustomJSProperties

        If (Not IsNull(Session("Managed"))) Then

            e.Properties("cpVisibleResults") = Convert.ToBoolean(GetArrayItem(Session("Managed").Template, "eGeneral.TaskResults"))

        Else

            e.Properties("cpVisibleResults") = False

        End If

    End Sub

#End Region

End Class
