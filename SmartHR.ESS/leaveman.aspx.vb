Imports System.IO

Partial Public Class leaveman
    Inherits System.Web.UI.Page

    Private ButtonID As String
    Private LeaveType As String
    Private UnitType As String
    Private Duration As String

    Private bCancel As Boolean
    Private PathID As String
    Private UDetails As Users

    Private dteFrom As Date
    Private dteUntil As Date
    Private HeaderData As HtmlTable
    Private Saved() As String
    Private ShowRemarks As String

    Private dteAppStart As Date
    Private dteAppUntil As Date

#Region " *** Web Form Functions *** "

    Private Function LoadBalances(ByVal CompanyNum As String, ByVal EmployeeNum As String, ByVal LeaveScheme As String, Optional ByVal LeaveType As String = "") As Single

        Dim SQLDuration(1) As String

        SQLDuration(0) = "convert(nvarchar(10), [Duration], 0) + ' ' + (select distinct [lRules].[AccrueUnit] from [LeaveRules] as [lRules] left outer join "
        SQLDuration(1) = "(select distinct [lRules].[AccrueUnit] from [LeaveRules] as [lRules] left outer join "

        If (LeaveScheme.Length > 0) Then

            SQLDuration(0) &= "[LeaveSchemeRules] as [lSchRules] on ([lRules].[RuleName] = [lSchRules].[RuleName]) and ([lRules].[LeaveType] = [lSchRules].[LeaveType]) where ([lSchRules].[LeaveScheme] = '" & LeaveScheme & "' and [lSchRules]"
            SQLDuration(1) &= "[LeaveSchemeRules] as [lSchRules] on ([lRules].[RuleName] = [lSchRules].[RuleName]) and ([lRules].[LeaveType] = [lSchRules].[LeaveType]) where ([lSchRules].[LeaveScheme] = '" & LeaveScheme & "' and [lSchRules]"

        Else

            SQLDuration(0) &= "[PersonnelLeaveRules] as [pRules] on ([lRules].[RuleName] = [pRules].[RuleName]) and ([lRules].[LeaveType] = [pRules].[LeaveType]) where ([pRules].[CompanyNum] = '" & CompanyNum & "' and [pRules].[EmployeeNum] = '" & EmployeeNum & "' and [pRules]"
            SQLDuration(1) &= "[PersonnelLeaveRules] as [pRules] on ([lRules].[RuleName] = [pRules].[RuleName]) and ([lRules].[LeaveType] = [pRules].[LeaveType]) where ([pRules].[CompanyNum] = '" & CompanyNum & "' and [pRules].[EmployeeNum] = '" & EmployeeNum & "' and [pRules]"

        End If

        SQLDuration(0) &= ".[LeaveType] = ([Leave].[LeaveType])))"
        SQLDuration(1) &= ".[LeaveType] = ([Leave].[LeaveType])))"

        If (LeaveType.Length = 0) Then

            LoadExpGrid(Session, dgView, "Leave History Tab", "<Tablename=Leave><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [StartDate], 120)><Columns=[LeaveType], " & SQLDuration(1) & " as [UnitType], [StartDate], [EndDate], " & SQLDuration(0) & " as [Duration], [LeaveStatus], [CapturedByUsername], [CaptureDate], [Remarks], [PathID], (select [ESSPath] from [PersonnelDocLink] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' And [PathID] = " & PathID & ")) as [ESSPath]><Where=([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [PathID] = " & PathID & ")>")

            Return 0

        Else

            Dim TotalBalance As String = GetXML(GetBalance(UDetails.Template, Convert.ToBoolean(GetArrayItem(UDetails.Template, "eLeave.IgnoreBalance")), CompanyNum, EmployeeNum, LeaveType, LeaveScheme, GetSQLField("select [EndDate] from [Leave] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [PathID] = " & PathID & ")", "EndDate"), False, -1), KeyName:="TotalBalance")

            If (IsNumeric(TotalBalance)) Then

                Return Convert.ToSingle(TotalBalance)

            Else

                Return 0

            End If

        End If

    End Function

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        PathID = String.Empty

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        If (Not IsNull(Request.QueryString("Cancel"))) Then bCancel = Convert.ToBoolean(Request.QueryString("Cancel").ToString())

        UDetails = GetUserDetails(Session, "Leave History Tab", True)

        If (Not IsPostBack) Then

            With UDetails

                CType(pnlLeave.FindControl("lblPanel"), DevExpress.Web.ASPxEditors.ASPxLabel).Text = "Leave " & IIf(Not bCancel, "Acceptance", "Cancellation") & ": (" & .CompanyNum & ", " & .EmployeeNum & ") - " & .Surname & ", " & .Name

            End With

        End If

        With UDetails

            LoadBalances(.CompanyNum, .EmployeeNum, .LeaveScheme)

        End With

        With GetUserDetails(Session, "Staff Locator")

            HeaderData = New HtmlTable

            HeaderData.Attributes.Add("class", "dgHeader")

            HeaderData.Style.Add("width", "100%")

            HeaderData.CellPadding = 0

            HeaderData.CellSpacing = 0

            Saved = New String() {"Employee", "Type", "Status", String.Empty, String.Empty}

            If (Not GetArrayItem(.Template, "eLeave.StaffOnLeave")) Then

                rptItems.DataSource = GetSQLDT("select convert(nvarchar(19), [l].[StartDate], 120) as [From], convert(nvarchar(19), [l].[EndDate], 120) as [Until], " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & " as [Employee], [l].[LeaveType] as [Type], [l].[LeaveStatus] as [Status], [l].[Duration] as [Duration] from [Leave] as [l] left outer join ([Personnel] as [e] left outer join [Company] as [c] on [e].[CompanyNum] = [c].[CompanyNum]) on [e].[CompanyNum] = [l].[CompanyNum] and [e].[EmployeeNum] = [l].[EmployeeNum] where ([l].[CompanyNum] + ':' + [l].[EmployeeNum] in(select [CompanyNum] + ':' + [EmployeeNum] from [ReportsTo] where ([ReportToCompNum] = '" & .CompanyNum & "' and [ReportToEmpNum] = '" & .EmployeeNum & "'))) and (([e].[Termination] = 0) and (([l].[StartDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[EndDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[StartDate] <= '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and [l].[EndDate] >= '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "'))) order by [From], [Until], [Employee], [Type], [Status], [Duration]")

            Else

                Dim UserGroup As String = GetUserGroup(Session("LoggedOn").UserID, Session.SessionID)

                If (Not IsNull(UserGroup)) Then rptItems.DataSource = GetSQLDT("select convert(nvarchar(19), [l].[StartDate], 120) as [From], convert(nvarchar(19), [l].[EndDate], 120) as [Until], " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")).Replace("[e].", "[emp].").Replace("[c].", "[comp].") & " as [Employee], [l].[LeaveType] as [Type], [l].[LeaveStatus] as [Status], [l].[Duration] as [Duration] from [Leave] as [l] left outer join ([Personnel] as [emp] left outer join [Company] as [comp] on [emp].[CompanyNum] = [comp].[CompanyNum]) on [emp].[CompanyNum] = [l].[CompanyNum] and [emp].[EmployeeNum] = [l].[EmployeeNum] where ([l].[CompanyNum] + ':' + [l].[EmployeeNum] in((" & GetUserGroupAccText(UserGroup, Session.SessionID, SQLWhere:="(select [fPrint] from [UserGroupTemplateRights] where ([Code] = [TemplateCode] and [DataElement] = 'Staff Locator')) = 1", SQLIdentifier:=" + ':' + [a].[EmployeeNum]") & ")) and ([emp].[Termination] = 0) and (([l].[StartDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[EndDate] between '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "') or ([l].[StartDate] <= '" & dteFrom.ToString("yyyy-MM-dd HH:mm:ss") & "' and [l].[EndDate] >= '" & dteUntil.ToString("yyyy-MM-dd HH:mm:ss") & "'))) order by [From], [Until], [Employee], [Type], [Status], [Duration]")

            End If

            rptItems.DataBind()

        End With

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim Values() As String = e.Parameter.Split(" ")

        PathID = String.Empty

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()
        If (Not IsNull(Request.QueryString("Cancel"))) Then bCancel = Convert.ToBoolean(Request.QueryString("Cancel").ToString())

        Dim ShowPopup As Boolean = False

        Dim ErrorText As String = SUCCESS

        With GetUserDetails(Session, "Leave History Tab", True)

            Dim LeaveTypes As String = String.Empty

            If (Not IsNull(GetArrayItem(.Template, "eLeave.Negative"))) Then

                LeaveTypes = GetArrayItem(.Template, "eLeave.Negative")

                LeaveTypes = "'" & GetDataText(LeaveTypes.Replace(", ", ",")).Replace(",", "', '") & "'"

            End If

            Dim bSaved As Boolean

            Dim PathData As String = GetPathData(PathID)

            Dim Balance As Single = 0

            Dim BalanceText As String = String.Empty

            Dim CheckPending As Boolean

            Dim BalPending As Single = 0

            Dim MaxNegative As Single = GetBalanceMaxNeg(.CompanyNum, .EmployeeNum, .Department, LeaveType, BalPending, PathID)

            CheckPending = Convert.ToBoolean(BalPending > 0)

            BalanceText = GetXML(GetBalance(.Template, Convert.ToBoolean(GetArrayItem(.Template, "eLeave.IgnoreBalance")), .CompanyNum, .EmployeeNum, LeaveType, .LeaveScheme, dteAppUntil, CheckPending), KeyName:="TotalBalance")

            If (BalanceText.Length > 0) Then Balance = Convert.ToSingle(BalanceText)

            Dim durValue As Single = Convert.ToSingle(Duration.Split(" ")(0))

            If (CheckPending) Then

                If (Balance < 0) Then

                    Balance += durValue

                Else

                    Balance -= BalPending

                End If

            End If

            If (Values(0).ToLower() = "approve" AndAlso durValue > Balance) Then

                ShowPopup = True

                If (LeaveTypes.ToLower().Contains("'" & LeaveType.ToLower() & "'")) AndAlso ((Balance - durValue) > MaxNegative) Then

                    If (ShowPopup) Then ShowPopup = False

                Else

                    If ((Balance - durValue) >= 0) Then

                        ErrorText = "information Your current application will exceed your available balance by " & Convert.ToSingle(Math.Abs(Balance - durValue + Math.Abs(MaxNegative))).ToString(NumericFormat) & " " & UnitType & "."

                    Else

                        If (((Balance + Math.Abs(MaxNegative)) - durValue) < 0) Then

                            ErrorText = "information Your current application will exceed your available balance by " & Convert.ToSingle(Math.Abs(Balance + Math.Abs(MaxNegative) - durValue)).ToString(NumericFormat) & " " & UnitType & "."

                        Else

                            ShowPopup = False

                        End If

                    End If

                End If

            End If

            If (Not ShowPopup OrElse bCancel) Then

                bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & UDetails.CompanyNum & "', '" & UDetails.EmployeeNum & "', " & PathID & ", 'Leave', '" & IIf(Not bCancel, LeaveType, "Cancel") & "', '" & Values(0) & "', '" & GetXML(PathData, KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'")

                If (bSaved) Then

                    If (Values(1).Length > 0) Then bSaved = ExecSQL("insert into [ess.WFRemarks]([CompanyNum], [EmployeeNum], [CaptureDate], [Remarks], [PathID]) values('" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & Now().ToString("yyyy-MM-dd HH:mm:ss") & "', '" & GetDataText(Values(1)) & "', " & PathID & ")")

                    If (bSaved) Then

                        ErrorText = "tasks.aspx tools/index.aspx"

                    Else

                    End If

                End If

            End If

        End With

        e.Result = Values(0) & " " & ErrorText

    End Sub

    Private Sub dgView_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView.CustomJSProperties

        Dim Balance As Single = 0
        Dim Remaining As Single = 0

        e.Properties("cpType") = -1

        If (ButtonID = "Select") Then

            e.Properties("cpType") = 0

        ElseIf (ButtonID = "Balance") Then

            e.Properties("cpType") = 1

            With UDetails

                Balance = LoadBalances(.CompanyNum, .EmployeeNum, .LeaveScheme, LeaveType)

                Remaining = Balance - Convert.ToSingle(Duration.Split(" ")(0))

            End With

        End If

        e.Properties("cpBalance") = Balance.ToString(NumericFormat) & " " & UnitType

        e.Properties("cpRemaining") = Remaining.ToString(NumericFormat) & " " & UnitType

        e.Properties("cpShow") = ShowRemarks

        e.Properties("cpRemarks") = txtRemarks_History.Text

    End Sub

    Private Sub dgView_CustomButtonCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonCallbackEventArgs) Handles dgView.CustomButtonCallback

        ButtonID = e.ButtonID

        If (e.ButtonID = "Select") Then

            If (IsNumeric(PathID)) Then txtRemarks_History.Text = GetRemarks(UDetails.Template, PathID, txtRemarks_History.Text)

            ShowRemarks = True

        ElseIf (e.ButtonID = "Balance") Then

            LeaveType = sender.GetRowValues(e.VisibleIndex, "LeaveType")
            UnitType = sender.GetRowValues(e.VisibleIndex, "UnitType")
            Duration = sender.GetRowValues(e.VisibleIndex, "Duration")

            ShowRemarks = True

        End If

    End Sub

    Private Sub dgView_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgView.DataBound

        If (Date.TryParse(sender.GetRowValues(0, "StartDate"), dteAppStart)) Then

            dteFrom = dteAppStart.AddDays(-7)

        Else

            dteFrom = Now

        End If

        dteFrom = New Date(dteFrom.Year, dteFrom.Month, dteFrom.Day, 0, 0, 0)

        If (Date.TryParse(sender.GetRowValues(0, "EndDate"), dteAppUntil)) Then

            lblBalanceAsAt.Text = dteAppUntil.ToString(GetArrayItem(UDetails.Template, "eGeneral.DateFormat"))

            dteUntil = dteAppUntil.AddDays(7)

        Else

            dteUntil = dteFrom.AddDays(14)

        End If

        dteUntil = New Date(dteUntil.Year, dteUntil.Month, dteUntil.Day, 23, 59, 59)

        LeaveType = sender.GetRowValues(0, "LeaveType")

        UnitType = sender.GetRowValues(0, "UnitType")

        Duration = sender.GetRowValues(0, "Duration")

        lblDuration.Text = sender.GetRowValues(0, "Duration")

    End Sub

    Private Sub rptItems_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptItems.ItemDataBound

        If (e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem) Then GenerateGrid(sender, e, HeaderData, dteFrom, dteUntil, Saved)

    End Sub

    Protected Function GetClickUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "function(s, e) { window.open('" & Container.Grid.GetRowValues(Container.VisibleIndex, "ESSPath").ToString().Replace("~/", "") & "', 'download'); }"

        If (Not File.Exists(ServerPath & Container.Grid.GetRowValues(Container.VisibleIndex, "ESSPath").ToString().Replace("~/", "\").Replace("/", "\"))) Then ReturnText = String.Empty

        Return ReturnText

    End Function

    Protected Function GetImgUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "images/"

        If (File.Exists(ServerPath & Container.Grid.GetRowValues(Container.VisibleIndex, "ESSPath").ToString().Replace("~/", "\").Replace("/", "\"))) Then

            ReturnText &= "select"

        Else

            ReturnText &= "error"

        End If

        Return ReturnText & ".png"

    End Function

    Protected Function GetTooltip(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim ReturnText As String = "Open File"

        If (Not File.Exists(ServerPath & Container.Grid.GetRowValues(Container.VisibleIndex, "ESSPath").ToString().Replace("~/", "\").Replace("/", "\"))) Then ReturnText = "no file attached"

        Return ReturnText

    End Function

#End Region

End Class