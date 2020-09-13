Imports System.IO

Partial Public Class leaveadjust
    Inherits System.Web.UI.Page

    Private ButtonID As String
    Private LeaveType As String
    Private UnitType As String
    Private Duration As String

    Private PathID As String
    Private UDetails As Users

    Private CancelEdit As Boolean

    Private Saved() As String
    Private ShowRemarks As String

    Private dteAppStart As Date

#Region " *** Web Form Functions *** "

    Private Sub GetExpValues(ByVal sender As Object, ByVal e As Object)

        e.NewValues("EffectiveDate") = dteAppStart

        e.NewValues("AdjustedByUsername") = Session("LoggedOn").UserID

        e.NewValues("AdjustedOn") = Now

        e.NewValues("PathID") = Convert.ToInt32(PathID)

        e.NewValues("Remarks") = "ESS: Leave Adjustment Rule"

    End Sub

    Private Function LoadBalances(ByVal CompanyNum As String, ByVal EmployeeNum As String, ByVal LeaveScheme As String, Optional ByVal ClearCache As Boolean = False) As Single

        Dim CacheChanged As Boolean

        If (dgView_002.VisibleRowCount > 0) Then

            If (Not dteAppStart = Session("Leave.CalcDate")) Then

                Session("Leave.CalcDate") = dteAppStart

                CacheChanged = True

                For iLoop As Integer = 0 To dgView_002.VisibleRowCount

                    ClearFromCache("Data.Leave.Balances[" & dgView_002.GetRowValues(iLoop, "LeaveType") & "]." & Session.SessionID)

                Next

            End If

        End If

        If (ClearCache OrElse CacheChanged) Then

            ClearFromCache("Data.Leave.Balances." & Session.SessionID)

            ClearFromCache("Data.Leave.Adjustments." & Session.SessionID)

        End If

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

        With UDetails

            LoadExpGrid(Session, dgView_001, "Leave History Tab", "<Tablename=Leave><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + convert(nvarchar(19), [StartDate], 120)><Columns=[LeaveType], " & SQLDuration(1) & " as [UnitType], [StartDate], [EndDate], " & SQLDuration(0) & " as [Duration], [LeaveStatus], [CapturedByUsername], [CaptureDate], [Remarks], [PathID], (select [ESSPath] from [PersonnelDocLink] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [PathID] = " & PathID & ")) as [ESSPath]><Where=([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [PathID] = " & PathID & ")>")

            If (IsString(LeaveType)) Then

                Dim SQL As String = String.Empty

                SQL = "<Tablename=LeaveCalculateFrom><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [LeaveType]><Columns=[LeaveType], cast('" & dteAppStart.ToString("yyyy-MM-dd HH:mm:ss") & "' as datetime) as [CalcDate], 0 as [Balance], 0 as [AccumBalance], 0 as [TotalBalance]><Where=([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "'"

                Dim BalanceType As String = ")>"

                If (Not IsNull(GetArrayItem(Nothing, "eLeave.AdjustmentTypes"))) Then

                    BalanceType = GetArrayItem(Nothing, "eLeave.AdjustmentTypes")

                    LoadExpDS(dsLeaveTypes, "select [LeaveType] from [LeaveCalculateFrom] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [LeaveType] in('" & GetDataText(BalanceType.Replace(", ", ",")).Replace(",", "', '") & "')) order by [LeaveType]")

                    BalanceType = " and [LeaveType] in('" & GetDataText(BalanceType.Replace(", ", ",")).Replace(",", "', '") & "'))>"

                End If

                SQL &= BalanceType

                LoadExpGrid(Session, dgView_002, "Leave History Tab", SQL)

                If (Not IsPostBack) Then

                    Dim AdjustmentTypes As String = String.Empty

                    If (Not IsNull(GetArrayItem(Nothing, "eLeave.AdjustmentTypes"))) Then AdjustmentTypes = GetArrayItem(Nothing, "eLeave.AdjustmentTypes").ToString()

                    If (AdjustmentTypes.ToLower().Contains(LeaveType.ToLower())) Then

                        If (Not IsData(GetSQLDT("select [CompanyNum] from [LeaveAdjustments] where ([PathID] = " & PathID & ")")) AndAlso IsNumeric(Duration)) Then

                            Dim BalanceText As String = GetBalance(.Template, Convert.ToBoolean(GetArrayItem(.Template, "eLeave.IgnoreBalance")), CompanyNum, EmployeeNum, LeaveType, .LeaveScheme, dteAppStart, False)

                            Dim durValue As Single = Convert.ToSingle(Duration)

                            Dim Balance() As Single = {0, 0, 0}

                            If (IsNumeric(GetXML(BalanceText, KeyName:="Balance"))) Then Balance(0) = Convert.ToSingle(GetXML(BalanceText, KeyName:="Balance"))

                            If (IsNumeric(GetXML(BalanceText, KeyName:="AccumBalance"))) Then Balance(1) = Convert.ToSingle(GetXML(BalanceText, KeyName:="AccumBalance"))

                            If (Balance(1) > 0) Then

                                Balance(2) = Balance(1) - durValue

                                If (Balance(2) > 0) Then

                                    ExecSQL("insert into [LeaveAdjustments]([CompanyNum], [EmployeeNum], [LeaveType], [EffectiveDate], [AdjustmentType], [AdjustmentValue], [AdjustedByUsername], [AdjustedOn], [PathID], [Remarks]) values('" & CompanyNum & "', '" & EmployeeNum & "', '" & LeaveType & "', '" & dteAppStart.ToString("yyyy-MM-dd HH:mm:ss") & "', 'Adjust Accum Balance', " & (durValue * -1).ToString() & ", '" & Session("LoggedOn").UserID & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', " & PathID & ", 'ESS: Leave Adjustment Rule')")

                                    ExecSQL("insert into [LeaveAdjustments]([CompanyNum], [EmployeeNum], [LeaveType], [EffectiveDate], [AdjustmentType], [AdjustmentValue], [AdjustedByUsername], [AdjustedOn], [PathID], [Remarks]) values('" & CompanyNum & "', '" & EmployeeNum & "', '" & LeaveType & "', '" & dteAppStart.ToString("yyyy-MM-dd HH:mm:ss") & "', 'Adjustment', " & durValue.ToString() & ", '" & Session("LoggedOn").UserID & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', " & PathID & ", 'ESS: Leave Adjustment Rule')")

                                Else

                                    ExecSQL("insert into [LeaveAdjustments]([CompanyNum], [EmployeeNum], [LeaveType], [EffectiveDate], [AdjustmentType], [AdjustmentValue], [AdjustedByUsername], [AdjustedOn], [PathID], [Remarks]) values('" & CompanyNum & "', '" & EmployeeNum & "', '" & LeaveType & "', '" & dteAppStart.ToString("yyyy-MM-dd HH:mm:ss") & "', 'Adjust Accum Balance', " & (Balance(1) * -1).ToString() & ", '" & Session("LoggedOn").UserID & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', " & PathID & ", 'ESS: Leave Adjustment Rule')")

                                    ExecSQL("insert into [LeaveAdjustments]([CompanyNum], [EmployeeNum], [LeaveType], [EffectiveDate], [AdjustmentType], [AdjustmentValue], [AdjustedByUsername], [AdjustedOn], [PathID], [Remarks]) values('" & CompanyNum & "', '" & EmployeeNum & "', '" & LeaveType & "', '" & dteAppStart.ToString("yyyy-MM-dd HH:mm:ss") & "', 'Adjustment', " & Balance(1).ToString() & ", '" & Session("LoggedOn").UserID & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "', " & PathID & ", 'ESS: Leave Adjustment Rule')")

                                End If

                            End If

                        End If

                    End If

                End If

                LoadExpGrid(Session, dgView_003, "Leave History Tab", "<Tablename=LeaveAdjustments><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [LeaveType] + ' ' + convert(nvarchar(19), [EffectiveDate], 120) + ' ' + [AdjustmentType]><InsertKey='" & CompanyNum & "', '" & EmployeeNum & "'><Columns=[LeaveType], [EffectiveDate], [AdjustmentType], [AdjustmentValue], [AdjustedByUsername], [AdjustedOn], [PathID], [Remarks]><Where=([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [PathID] = " & PathID & ")>")

                Return 0

            Else

                Dim TotalBalance As String = GetXML(GetBalance(UDetails.Template, Convert.ToBoolean(GetArrayItem(UDetails.Template, "eLeave.IgnoreBalance")), CompanyNum, EmployeeNum, LeaveType, LeaveScheme, GetSQLField("select [EndDate] from [Leave] where ([CompanyNum] = '" & CompanyNum & "' and [EmployeeNum] = '" & EmployeeNum & "' and [PathID] = " & PathID & ")", "EndDate"), False, -1), KeyName:="TotalBalance")

                If (IsNumeric(TotalBalance)) Then

                    Return Convert.ToSingle(TotalBalance)

                Else

                    Return 0

                End If

            End If

        End With

    End Function

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        PathID = String.Empty

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        UDetails = GetUserDetails(Session, "Leave History Tab", True)

        If (Not IsPostBack) Then

            With UDetails

                CType(pnlLeave.FindControl("lblPanel"), DevExpress.Web.ASPxEditors.ASPxLabel).Text = "Leave Adjustment: (" & .CompanyNum & ", " & .EmployeeNum & ") - " & .Surname & ", " & .Name

            End With

        End If

        With UDetails

            LoadBalances(.CompanyNum, .EmployeeNum, .LeaveScheme)

        End With

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim Values() As String = e.Parameter.Split(" ")

        PathID = String.Empty

        If (Not IsNull(Request.QueryString("ID"))) Then PathID = Request.QueryString("ID").ToString()

        Dim ShowPopup As Boolean = False

        Dim ErrorText As String = SUCCESS

        With GetUserDetails(Session, "Leave History Tab", True)

            Dim bSaved As Boolean

            Dim PathData As String = GetPathData(PathID)

            'Dim Balance As Single = 0

            'Dim BalanceText As String = String.Empty

            'Dim CheckPending As Boolean

            'Dim BalPending As Single = 0

            'Dim MaxNegative As Single = GetBalanceMaxNeg(.CompanyNum, .EmployeeNum, .Department, LeaveType, BalPending, PathID)

            'CheckPending = Convert.ToBoolean(BalPending > 0)

            'BalanceText = GetXML(GetBalance(.Template, Convert.ToBoolean(GetArrayItem(.Template, "eLeave.IgnoreBalance")), .CompanyNum, .EmployeeNum, LeaveType, .LeaveScheme, dteAppUntil, CheckPending), KeyName:="TotalBalance")

            'If (BalanceText.Length > 0) Then Balance = Convert.ToSingle(BalanceText)

            'Dim durValue As Single = Convert.ToSingle(Duration.Split(" ")(0))

            'If (CheckPending) Then

            '    If (Balance < 0) Then

            '        Balance += durValue

            '    Else

            '        Balance -= BalPending

            '    End If

            'End If

            bSaved = ExecSQL("exec [ess.WFProc] '" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & UDetails.CompanyNum & "', '" & UDetails.EmployeeNum & "', " & PathID & ", 'Leave', '" & LeaveType & "', '" & Values(0) & "', '" & GetXML(PathData, KeyName:="ActionType") & "', '" & Now.ToString("yyyy-MM-dd HH:mm:ss") & "'")

            If (bSaved) Then

                If (Values(1).Length > 0) Then bSaved = ExecSQL("insert into [ess.WFRemarks]([CompanyNum], [EmployeeNum], [CaptureDate], [Remarks], [PathID]) values('" & Session("LoggedOn").CompanyNum & "', '" & Session("LoggedOn").EmployeeNum & "', '" & Now().ToString("yyyy-MM-dd HH:mm:ss") & "', '" & GetDataText(Values(1)) & "', " & PathID & ")")

                If (bSaved) Then

                    ErrorText = "tasks.aspx tools/index.aspx"

                Else

                End If

            End If

        End With

        e.Result = Values(0) & " " & ErrorText

    End Sub

    Private Sub dgView_001_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_001.CustomJSProperties, dgView_003.CustomJSProperties

        If (sender.Equals(dgView_001)) Then

            e.Properties("cpType") = -1

            If (ButtonID = "Select") Then e.Properties("cpType") = 0

            e.Properties("cpShow") = ShowRemarks

            e.Properties("cpRemarks") = txtRemarks_History.Text

        Else

            e.Properties("cpCancelEdit") = CancelEdit

        End If

    End Sub

    Private Sub dgView_001_CustomButtonCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonCallbackEventArgs) Handles dgView_001.CustomButtonCallback

        ButtonID = e.ButtonID

        If (e.ButtonID = "Select") Then

            If (IsNumeric(sender.GetRowValues(e.VisibleIndex, "PathID"))) Then txtRemarks_History.Text = GetRemarks(UDetails.Template, PathID, txtRemarks_History.Text)

            ShowRemarks = True

        End If

    End Sub

    Private Sub dgView_002_CustomColumnDisplayText(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewColumnDisplayTextEventArgs) Handles dgView_002.CustomColumnDisplayText

        Dim LeaveType As String = sender.GetRowValues(e.VisibleRowIndex, "LeaveType")

        'Dim ItemKey As String = "Data.Leave.Balances[" & LeaveType & "]." & Session.SessionID

        Dim Balances As String = String.Empty

        With UDetails

            'If (IsNull(Cache(ItemKey))) Then UpdateCache(GetBalance(.Template, Convert.ToBoolean(GetArrayItem(.Template, "eLeave.IgnoreBalance")), .CompanyNum, .EmployeeNum, LeaveType, .LeaveScheme, dteAppStart, False, -1), ItemKey, "<TimeSpan=Hours><Duration=1>")

            Balances = GetBalance(.Template, Convert.ToBoolean(GetArrayItem(.Template, "eLeave.IgnoreBalance")), .CompanyNum, .EmployeeNum, LeaveType, .LeaveScheme, dteAppStart, False, -1)

            Select Case e.Column.FieldName

                Case "AccumBalance", "Balance"
                    e.DisplayText = GetXML(Balances, KeyName:=e.Column.FieldName)

                Case "TotalBalance"
                    If (Not GetArrayItem(.Template, "eLeave.FinancialTotal")) Then

                        e.DisplayText = GetXML(Balances, KeyName:=e.Column.FieldName)

                    Else

                        Dim Balance As String = Balances

                        SetXML(Balance, "TotalBalance", Convert.ToDouble(e.Value).ToString(NumericFormat))

                        'UpdateCache(Balance, ItemKey, "<TimeSpan=Hours><Duration=1>")

                        e.DisplayText = Convert.ToDouble(e.Value).ToString(NumericFormat)

                    End If

            End Select

        End With

        If (IsNumeric(e.DisplayText)) Then e.Value = Convert.ToDouble(e.DisplayText)

    End Sub

    Private Sub dgView_001_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgView_001.DataBound

        If (Not Date.TryParse(sender.GetRowValues(0, "StartDate"), dteAppStart)) Then dteAppStart = DateTime.Today

        LeaveType = sender.GetRowValues(0, "LeaveType")

        UnitType = sender.GetRowValues(0, "UnitType")

        Duration = sender.GetRowValues(0, "Duration")

        If (IsString(Duration)) Then Duration = Duration.Split(" ")(0)

        If (Not IsNumeric(Duration)) Then Duration = Regex.Replace(Duration, "\D", String.Empty)

    End Sub

    Private Sub dgView_003_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_003.RowDeleting

        Dim SQLAudit As String = "<Tablename=LeaveAdjustments><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><LeaveType=" & e.Values("LeaveType").ToString() & "><EffectiveDate=" & Convert.ToDateTime(e.Values("EffectiveDate")).ToString("yyyy-MM-dd HH:mm:ss") & "><AdjustmentType=" & e.Values("AdjustmentType").ToString() & ">"

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadBalances(UDetails.CompanyNum, UDetails.EmployeeNum, UDetails.LeaveScheme)

        End If

    End Sub

    Private Sub dgView_003_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_003.RowInserting

        Dim SQLAudit As String = "<Tablename=LeaveAdjustments><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadBalances(UDetails.CompanyNum, UDetails.EmployeeNum, UDetails.LeaveScheme)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_003_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_003.RowUpdating

        Dim SQLAudit As String = "<Tablename=LeaveAdjustments><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><LeaveType;2=" & e.OldValues("LeaveType").ToString() & "><EffectiveDate;3=" & Convert.ToDateTime(e.OldValues("EffectiveDate")).ToString("yyyy-MM-dd HH:mm:ss") & "><AdjustmentType;4=" & e.OldValues("AdjustmentType").ToString() & ">"

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadBalances(UDetails.CompanyNum, UDetails.EmployeeNum, UDetails.LeaveScheme)

            CancelEdit = True

        End If

    End Sub

    Private Sub dgView_003_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_003.RowValidating

        If (IsNull(e.OldValues("EffectiveDate"))) Then e.NewValues("EffectiveDate") = dteAppStart

        e.RowError = ValidateExpGrid(sender, e)

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