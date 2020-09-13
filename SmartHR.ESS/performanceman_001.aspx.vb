Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxHiddenField

Partial Public Class performanceman_001
    Inherits System.Web.UI.Page

    Private CancelEdit As Boolean
    Private RefreshDelete As Boolean
    Private RefreshParent As Boolean
    Private UDetails As Users = Nothing
    Private UserGroup As String = Nothing

#Region " *** Web Form Functions *** "

    Private Sub FillComboBox(ByVal cmb As DevExpress.Web.ASPxEditors.ASPxComboBox, ByVal CompNum As String)

        If (String.IsNullOrEmpty(CompNum)) Then Return

        If (Not IsNull(UserGroup)) Then LoadExpDS(dsEmpNum, "select [EmployeeNum], (isnull([Title], '') + ' ' + isnull([PreferredName], '') + ' ' + [Surname]) as [Name] from [Personnel] where ([CompanyNum] = '" & GetDataText(CompNum) & "' and ([CompanyNum] + ' ' + [EmployeeNum] in(" & GetUserGroupAccText(UserGroup, Session.SessionID, "Data.UserGroups.AccessTo.Evaluations." & Session.SessionID, String.Empty, " + ' ' + [a].[EmployeeNum]") & "))) order by [Name]")

        cmb.DataBind()

    End Sub

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        If (GetArrayItem(UDetails.Template, "ePerformance.SchemeCode")) Then

            LoadExpDS(dsScheme, "select distinct [Name], [SchemeCode] from [PerfScheme] where ([SchemeCode] in(select [EmployeeNum] from [Personnel] where (([CompanyNum] + ' ' + [EmployeeNum] in(" & GetUserGroupAccText(UserGroup, Session.SessionID, "Data.UserGroups.AccessTo.Evaluations.Schemes." & Session.SessionID, String.Empty, " + ' ' + [a].[EmployeeNum]") & "))))) order by [Name]")

        Else

            LoadExpDS(dsScheme, "select distinct [Name], [SchemeCode] from [PerfScheme] order by [Name]")

        End If

        Dim dgView As ASPxGridView = Nothing

        Dim iRowIndex As Integer

        Dim dtTable As DataTable = Nothing

        Dim IsRowExpanded As Boolean

        If (Not IsNull(UserGroup)) Then

            LoadExpDS(dsCompNum, "select [CompanyName], [CompanyNum] from [Company] where ([CompanyNum] in(" & GetUserGroupAccText(UserGroup, Session.SessionID, "Data.UserGroups.AccessTo.Evaluations." & Session.SessionID) & ")) order by [CompanyName]")

            With UDetails

                Select Case tabEvaluations.ActiveTabIndex

                    Case 0
                        If (ClearCache) Then ClearFromCache("Data.UserGroups.AccessTo.Evaluations.Self." & Session.SessionID)

                        If (IsString(Cache("Data.Filter." & Session.SessionID))) Then

                            dgView_001.DataSource = GetUserGroupAcc(UserGroup, Session.SessionID, "Data.UserGroups.AccessTo.Evaluations.Self." & Session.SessionID, ", (select top 1 [SchemeCode] from [ess.EvalGroupItems] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [GroupName] = '" & Session("EvaluationGroup") & "' and [EvalCompanyNum] = [e].[CompanyNum] and [EvalEmployeeNum] = [e].[EmployeeNum] and [ApprType] = 'self')) as [Scheme]", Cache("Data.Filter." & Session.SessionID))

                        Else

                            dgView_001.DataSource = GetUserGroupAcc(UserGroup, Session.SessionID, "Data.UserGroups.AccessTo.Evaluations.Self." & Session.SessionID, ", (select top 1 [SchemeCode] from [ess.EvalGroupItems] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [GroupName] = '" & Session("EvaluationGroup") & "' and [EvalCompanyNum] = [e].[CompanyNum] and [EvalEmployeeNum] = [e].[EmployeeNum] and [ApprType] = 'self')) as [Scheme]")

                        End If

                        dgView_001.DataBind()

                    Case 1
                        If (ClearCache) Then

                            ClearFromCache("Data.UserGroups.AccessTo.Evaluations.Others." & Session.SessionID)

                            ClearFromCache("Data.UserGroups.AccessTo.Evaluations.Others.Items." & Session.SessionID)

                        End If

                        If (IsNumeric(Session("Data.UserGroups.AccessTo.Evaluations.Others.LoadSub"))) Then IsRowExpanded = dgView_002.IsRowExpanded(Session("Data.UserGroups.AccessTo.Evaluations.Others.LoadSub"))

                        dgView_002.DataSource = GetUserGroupAcc(UserGroup, Session.SessionID, "Data.UserGroups.AccessTo.Evaluations.Others." & Session.SessionID)

                        dgView_002.DataBind()

                        If (Not IsPostBack) Then Session("Data.UserGroups.AccessTo.Evaluations.Others.LoadSub") = Nothing

                        If (IsNumeric(Session("Data.UserGroups.AccessTo.Evaluations.Others.LoadSub"))) Then

                            iRowIndex = Session("Data.UserGroups.AccessTo.Evaluations.Others.LoadSub")

                            If (IsRowExpanded) Then

                                Dim items As DevExpress.Web.ASPxHiddenField.ASPxHiddenField = Nothing

                                items = items_004

                                dgView = TryCast(dgView_002.FindDetailRowTemplateControl(iRowIndex, "dgView_004"), ASPxGridView)

                                Dim ValueString As String = dgView_002.GetRowValues(iRowIndex, "Value").ToString()

                                If (Not IsNull(dgView)) Then

                                    dtTable = GetUserGroupAcc(UserGroup, Session.SessionID, "Data.UserGroups.AccessTo.Evaluations.Others.Items." & Session.SessionID, ", (select top 1 [ApprType] from [ess.EvalGroupItems] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [GroupName] = '" & Session("EvaluationGroup") & "' and [EvalCompanyNum] = [e].[CompanyNum] and [EvalEmployeeNum] = [e].[EmployeeNum] and [ApprCompanyNum] + ' ' + [ApprEmployeeNum] = '" & ValueString & "' and not [ApprType] = 'self')) as [ApprType], (select top 1 [SchemeCode] from [ess.EvalGroupItems] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [GroupName] = '" & Session("EvaluationGroup") & "' and [EvalCompanyNum] = [e].[CompanyNum] and [EvalEmployeeNum] = [e].[EmployeeNum] and [ApprCompanyNum] + ' ' + [ApprEmployeeNum] = '" & ValueString & "' and not [ApprType] = 'self')) as [Scheme]")

                                    If (IsData(dtTable)) Then dtTable.DefaultView.RowFilter = "not [Value] = '" & ValueString & "'"

                                    dgView.DataSource = dtTable

                                    dgView.DataBind()

                                End If

                                If (Not IsNull(items)) Then items = Nothing

                            End If

                        End If

                    Case 2
                        If (ClearCache) Then

                            ClearFromCache("Data.UserGroups.AccessTo.Evaluations.360." & Session.SessionID)

                            ClearFromCache("Data.UserGroups.AccessTo.Evaluations.360.Items." & Session.SessionID)

                        End If

                        dtTable = GetUserGroupAcc(UserGroup, Session.SessionID, "Data.UserGroups.AccessTo.Evaluations.360." & Session.SessionID, ", (select top 1 [SchemeCode] from [ess.EvalGroupItems] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [GroupName] = '" & Session("EvaluationGroup") & "' and [EvalCompanyNum] = [e].[CompanyNum] and [EvalEmployeeNum] = [e].[EmployeeNum])) as [Scheme]")

                        If (IsData(dtTable)) Then dtTable.DefaultView.RowFilter = "not [Scheme] is null"

                        dgView_003.DataSource = dtTable

                        dgView_003.DataBind()

                        If (IsNumeric(Session("Data.UserGroups.AccessTo.Evaluations.360.LoadSub"))) Then IsRowExpanded = dgView_003.IsRowExpanded(Session("Data.UserGroups.AccessTo.Evaluations.360.LoadSub"))

                        If (Not IsPostBack) Then Session("Data.UserGroups.AccessTo.Evaluations.360.LoadSub") = Nothing

                        If (IsNumeric(Session("Data.UserGroups.AccessTo.Evaluations.360.LoadSub"))) Then

                            iRowIndex = Session("Data.UserGroups.AccessTo.Evaluations.360.LoadSub")

                            If (IsRowExpanded) Then

                                dgView = TryCast(dgView_003.FindDetailRowTemplateControl(iRowIndex, "dgView_005"), ASPxGridView)

                                If (Not IsNull(dgView)) Then

                                    Dim ValueString As String = dgView_003.GetRowValues(iRowIndex, "Value").ToString()

                                    LoadExpGrid(Session, dgView, "Performance Tab", "<Tablename=ess.EvalGroupItems><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [GroupName] + ' ' + [SchemeCode] + ' ' + [EvalCompanyNum] + ' ' + [EvalEmployeeNum] + ' ' + [ApprCompanyNum] + ' ' + [ApprEmployeeNum] + ' ' + [ApprType]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & Session("EvaluationGroup") & "'><Columns=[SchemeCode], [EvalCompanyNum], [EvalEmployeeNum], [ApprCompanyNum], [ApprEmployeeNum], (select (isnull([Title], '') + ' ' + isnull([PreferredName], '') + ' ' + [Surname]) from [Personnel] where ([CompanyNum] + ':' + [EmployeeNum] = [ApprCompanyNum] + ':' + [ApprEmployeeNum])) as [Employee], [ApprType]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [GroupName] = '" & Session("EvaluationGroup") & "' and [EvalCompanyNum] + ' ' + [EvalEmployeeNum] = '" & GetDataText(ValueString) & "')>", "Data.UserGroups.AccessTo.Evaluations.360.Items." & Session.SessionID)

                                End If

                            End If

                        End If

                End Select

            End With

        End If

        If (Not IsNull(dtTable)) Then

            dtTable.Dispose()

            dtTable = Nothing

        End If

    End Sub

    Private Function Submit(ByRef dgView As ASPxGridView) As String

        Dim bSaved As Boolean = True

        Dim SQL As String = String.Empty

        Dim mKey As Object = Nothing

        Dim items As DevExpress.Web.ASPxHiddenField.ASPxHiddenField = Nothing

        If (dgView.Equals(dgView_001)) Then

            items = items_001

        Else

            mKey = dgView.GetMasterRowKeyValue()

            items = items_004

        End If

        If (Not IsNull(items)) Then

            With UDetails

                If (dgView.Equals(dgView_001)) Then

                    SQL = "delete from [ess.EvalGroupItems] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [GroupName] = '" & Session("EvaluationGroup") & "' and [ApprType] = 'self')"

                Else

                    If (Not IsNull(mKey)) Then SQL = "delete from [ess.EvalGroupItems] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [GroupName] = '" & Session("EvaluationGroup") & "' and [ApprCompanyNum] + ' ' + [ApprEmployeeNum] = '" & mKey.ToString() & "' and not [ApprType] = 'self')"

                End If

                If (SQL.Length > 0) Then

                    If (ExecSQL(SQL)) Then

                        Dim CompanyNum As String = String.Empty
                        Dim EmployeeNum As String = String.Empty

                        Dim ItemKey As String = String.Empty

                        For iLoop As Integer = 0 To (dgView.VisibleRowCount - 1)

                            If (dgView.Selection.IsRowSelected(iLoop)) Then

                                ItemKey = dgView.ID & "_" & iLoop.ToString("000")

                                Dim blnSelectedAll As String = If(items.Contains("SelectedAll"), items.Get("SelectedAll"), "")

                                If (items.Contains(ItemKey) Or blnSelectedAll = "True") Then

                                    If ((items.Get(ItemKey) <> Nothing AndAlso items.Get(ItemKey).ToString().Length > 0) Or items.Contains("SelectedKey")) Then

                                        Dim vKey As String

                                        If (items.Get(ItemKey) <> Nothing AndAlso items.Get(ItemKey).ToString().Length > 0) Then

                                            vKey = ItemKey

                                        ElseIf (items.Get("SelectedKey").ToString().Length > 0) Then

                                            vKey = "SelectedKey"

                                        End If


                                        SQL = String.Empty

                                        If (dgView.Equals(dgView_001)) Then

                                            CompanyNum = dgView.GetRowValues(iLoop, "Value").ToString().Split(" ")(0)
                                            EmployeeNum = dgView.GetRowValues(iLoop, "Value").ToString().Split(" ")(1)

                                            'SQL = "insert into [ess.EvalGroupItems]([CompanyNum], [EmployeeNum], [GroupName], [SchemeCode], [EvalCompanyNum], [EvalEmployeeNum], [ApprCompanyNum], [ApprEmployeeNum], [ApprType]) values('" & .CompanyNum & "', '" & .EmployeeNum & "', '" & Session("EvaluationGroup") & "', '" & items.Get(ItemKey) & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & CompanyNum & "', '" & EmployeeNum & "', 'self')"
                                            SQL = "insert into [ess.EvalGroupItems]([CompanyNum], [EmployeeNum], [GroupName], [SchemeCode], [EvalCompanyNum], [EvalEmployeeNum], [ApprCompanyNum], [ApprEmployeeNum], [ApprType]) values('" & .CompanyNum & "', '" & .EmployeeNum & "', '" & Session("EvaluationGroup") & "', '" & items.Get(vKey) & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & CompanyNum & "', '" & EmployeeNum & "', 'self')"

                                        ElseIf (items.Contains(ItemKey & "_Type") OrElse blnSelectedAll = "True") Then

                                            If (items.Get(ItemKey & "_Type") <> Nothing AndAlso items.Get(ItemKey & "_Type").ToString().Length > 0) Then

                                                CompanyNum = dgView.GetRowValues(iLoop, "Value").ToString().Split(" ")(0)
                                                EmployeeNum = dgView.GetRowValues(iLoop, "Value").ToString().Split(" ")(1)

                                                'SQL = "insert into [ess.EvalGroupItems]([CompanyNum], [EmployeeNum], [GroupName], [SchemeCode], [EvalCompanyNum], [EvalEmployeeNum], [ApprCompanyNum], [ApprEmployeeNum], [ApprType]) values('" & .CompanyNum & "', '" & .EmployeeNum & "', '" & Session("EvaluationGroup") & "', '" & items.Get(ItemKey) & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & mKey.ToString().Split(" ")(0) & "', '" & mKey.ToString().Split(" ")(1) & "', '" & items.Get(ItemKey & "_Type") & "')"
                                                SQL = "insert into [ess.EvalGroupItems]([CompanyNum], [EmployeeNum], [GroupName], [SchemeCode], [EvalCompanyNum], [EvalEmployeeNum], [ApprCompanyNum], [ApprEmployeeNum], [ApprType]) values('" & .CompanyNum & "', '" & .EmployeeNum & "', '" & Session("EvaluationGroup") & "', '" & items.Get(vKey) & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & mKey.ToString().Split(" ")(0) & "', '" & mKey.ToString().Split(" ")(1) & "', '" & items.Get(ItemKey & "_Type") & "')"

                                            ElseIf (items.Get("SelectedKeyType") <> Nothing AndAlso items.Get("SelectedKeyType").ToString().Length > 0) Then

                                                CompanyNum = dgView.GetRowValues(iLoop, "Value").ToString().Split(" ")(0)
                                                EmployeeNum = dgView.GetRowValues(iLoop, "Value").ToString().Split(" ")(1)

                                                'SQL = "insert into [ess.EvalGroupItems]([CompanyNum], [EmployeeNum], [GroupName], [SchemeCode], [EvalCompanyNum], [EvalEmployeeNum], [ApprCompanyNum], [ApprEmployeeNum], [ApprType]) values('" & .CompanyNum & "', '" & .EmployeeNum & "', '" & Session("EvaluationGroup") & "', '" & items.Get(ItemKey) & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & mKey.ToString().Split(" ")(0) & "', '" & mKey.ToString().Split(" ")(1) & "', '" & items.Get(ItemKey & "_Type") & "')"
                                                SQL = "insert into [ess.EvalGroupItems]([CompanyNum], [EmployeeNum], [GroupName], [SchemeCode], [EvalCompanyNum], [EvalEmployeeNum], [ApprCompanyNum], [ApprEmployeeNum], [ApprType]) values('" & .CompanyNum & "', '" & .EmployeeNum & "', '" & Session("EvaluationGroup") & "', '" & items.Get(vKey) & "', '" & CompanyNum & "', '" & EmployeeNum & "', '" & mKey.ToString().Split(" ")(0) & "', '" & mKey.ToString().Split(" ")(1) & "', '" & items.Get("SelectedKeyType") & "')"

                                            End If
                                        End If

                                        If (SQL.Length > 0) Then bSaved = ExecSQL(SQL)

                                        If (Not bSaved) Then Exit For

                                    End If

                                End If

                            End If

                        Next

                    End If

                End If

            End With

        End If

        If (bSaved) Then

            ClearFromCache("Data.UserGroups.AccessTo.Evaluations.Self." & Session.SessionID)

            ClearFromCache("Data.UserGroups.AccessTo.Evaluations.Others." & Session.SessionID)

            ClearFromCache("Data.UserGroups.AccessTo.Evaluations.Others.Items." & Session.SessionID)

            ClearFromCache("'Data.UserGroups.AccessTo.Evaluations.360." & Session.SessionID)

            ClearFromCache("'Data.UserGroups.AccessTo.Evaluations.360.Items." & Session.SessionID)

            Return SUCCESS & " Successfully saved the information"

        Else

            Return DBERROR & SQL

        End If

    End Function

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not IsPostBack) Then

            If (IsNumeric(Request.QueryString("ID"))) Then tabEvaluations.ActiveTabIndex = Convert.ToInt32(Request.QueryString("ID"))

        End If

        UDetails = GetUserDetails(Session, "Performance Tab")

        If (Not IsNull(Session("LoggedOn"))) Then UserGroup = GetUserGroup(Session("LoggedOn").UserID, Session.SessionID)

        LoadData()

    End Sub

    Protected Sub cmbEmployee_OnCallback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase)

        FillComboBox(TryCast(source, DevExpress.Web.ASPxEditors.ASPxComboBox), e.Parameter)

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim ErrorText As String = String.Empty

        If (e.Parameter = "Back") Then

            ErrorText = "performance.aspx?TabID=2 tools/index.aspx"

        ElseIf (e.Parameter = "Submit") Then

            Select Case tabEvaluations.ActiveTabIndex

                Case 0
                    ErrorText = Submit(dgView_001)

                Case 1
                    If (IsNumeric(Session("Data.UserGroups.AccessTo.Evaluations.Others.LoadSub"))) Then

                        Dim iRowIndex As Integer = Session("Data.UserGroups.AccessTo.Evaluations.Others.LoadSub")

                        Dim dgView As ASPxGridView = TryCast(dgView_002.FindDetailRowTemplateControl(iRowIndex, "dgView_004"), ASPxGridView)

                        If (Not IsNull(dgView)) Then ErrorText = Submit(dgView)

                    End If

            End Select

        End If

        e.Result = e.Parameter & " " & ErrorText

    End Sub

    Protected Sub dgView_001_CustomJSProperties(ByVal sender As Object, ByVal e As ASPxGridViewClientJSPropertiesEventArgs)

        e.Properties("cpCancelEdit") = CancelEdit

        e.Properties("cpRefreshDelete") = RefreshDelete

        e.Properties("cpRefreshParent") = RefreshParent

    End Sub

    Private Sub dgView_002_DetailRowExpandedChanged(ByVal sender As Object, ByVal e As ASPxGridViewDetailRowEventArgs) Handles dgView_002.DetailRowExpandedChanged, dgView_003.DetailRowExpandedChanged

        If (e.Expanded) Then

            Dim dgView As ASPxGridView = Nothing

            With UDetails

                Dim items As DevExpress.Web.ASPxHiddenField.ASPxHiddenField = Nothing

                If (sender.Equals(dgView_002)) Then

                    items = items_004

                    If (Not IsNull(items)) Then items.Clear()

                    ClearFromCache("Data.UserGroups.AccessTo.Evaluations.Others.Items." & Session.SessionID)

                    dgView = TryCast(dgView_002.FindDetailRowTemplateControl(e.VisibleIndex, "dgView_004"), ASPxGridView)

                    Dim ValueString As String = dgView_002.GetRowValues(e.VisibleIndex, "Value").ToString()

                    If (Not IsNull(dgView)) Then

                        Dim dtTable As DataTable = Nothing

                        Try

                            dtTable = GetUserGroupAcc(UserGroup, Session.SessionID, "Data.UserGroups.AccessTo.Evaluations.Others.Items." & Session.SessionID, ", (select top 1 [ApprType] from [ess.EvalGroupItems] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [GroupName] = '" & Session("EvaluationGroup") & "' and [EvalCompanyNum] = [e].[CompanyNum] and [EvalEmployeeNum] = [e].[EmployeeNum] and [ApprCompanyNum] + ' ' + [ApprEmployeeNum] = '" & ValueString & "' and not [ApprType] = 'self')) as [ApprType], (select top 1 [SchemeCode] from [ess.EvalGroupItems] where ([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [GroupName] = '" & Session("EvaluationGroup") & "' and [EvalCompanyNum] = [e].[CompanyNum] and [EvalEmployeeNum] = [e].[EmployeeNum] and [ApprCompanyNum] + ' ' + [ApprEmployeeNum] = '" & ValueString & "' and not [ApprType] = 'self')) as [Scheme]")

                            If (IsData(dtTable)) Then dtTable.DefaultView.RowFilter = "not [Value] = '" & ValueString & "'"

                            dgView.DataSource = dtTable

                            dgView.DataBind()

                        Catch ex As Exception

                        Finally

                            If (Not IsNull(dtTable)) Then

                                dtTable.Dispose()

                                dtTable = Nothing

                            End If

                        End Try

                    End If

                    Session("Data.UserGroups.AccessTo.Evaluations.Others.LoadSub") = e.VisibleIndex

                ElseIf (sender.Equals(dgView_003)) Then

                    ClearFromCache("Data.UserGroups.AccessTo.Evaluations.360.Items." & Session.SessionID)

                    dgView = TryCast(dgView_003.FindDetailRowTemplateControl(e.VisibleIndex, "dgView_005"), ASPxGridView)

                    Dim ValueString As String = dgView_003.GetRowValues(e.VisibleIndex, "Value").ToString()

                    If (Not IsNull(dgView)) Then LoadExpGrid(Session, dgView, "Performance Tab", "<Tablename=ess.EvalGroupItems><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [GroupName] + ' ' + [SchemeCode] + ' ' + [EvalCompanyNum] + ' ' + [EvalEmployeeNum] + ' ' + [ApprCompanyNum] + ' ' + [ApprEmployeeNum] + ' ' + [ApprType]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "', '" & Session("EvaluationGroup") & "'><Columns=[SchemeCode], [EvalCompanyNum], [EvalEmployeeNum], [ApprCompanyNum], [ApprEmployeeNum], (select (isnull([Title], '') + ' ' + isnull([PreferredName], '') + ' ' + [Surname]) from [Personnel] where ([CompanyNum] + ':' + [EmployeeNum] = [ApprCompanyNum] + ':' + [ApprEmployeeNum])) as [Employee], [ApprType]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "' and [GroupName] = '" & Session("EvaluationGroup") & "' and [EvalCompanyNum] + ' ' + [EvalEmployeeNum] = '" & GetDataText(ValueString) & "')>", "Data.UserGroups.AccessTo.Evaluations.360.Items." & Session.SessionID)

                    Session("Data.UserGroups.AccessTo.Evaluations.360.LoadSub") = e.VisibleIndex

                End If

                If (Not IsNull(items)) Then items = Nothing

            End With

        ElseIf (sender.Equals(dgView_002) AndAlso IsNumeric(Session("Data.UserGroups.AccessTo.Evaluations.Others.LoadSub"))) Then

            Session.Remove("Data.UserGroups.AccessTo.Evaluations.Others.LoadSub")

        ElseIf (sender.Equals(dgView_003) AndAlso IsNumeric(Session("Data.UserGroups.AccessTo.Evaluations.360.LoadSub"))) Then

            Session.Remove("Data.UserGroups.AccessTo.Evaluations.360.LoadSub")

        End If

    End Sub

    Protected Sub dgView_001_CellEditorInitialize(ByVal sender As Object, ByVal e As ASPxGridViewEditorEventArgs)

        If (Not sender.IsEditing OrElse Not e.Column.FieldName = "ApprEmployeeNum") Then Return

        Dim combo As DevExpress.Web.ASPxEditors.ASPxComboBox = TryCast(e.Editor, DevExpress.Web.ASPxEditors.ASPxComboBox)

        If (sender.IsEditing AndAlso Not sender.IsNewRowEditing) Then

            If (IsNull(e.KeyValue)) Then Return

            Dim val As String = sender.GetRowValuesByKeyValue(e.KeyValue, "ApprCompanyNum")

            If (val Is DBNull.Value) Then Return

            FillComboBox(combo, val)

            AddHandler combo.Callback, AddressOf cmbEmployee_OnCallback

            If (IsNumeric(combo.Value)) Then Session("perEmployeeNum") = combo.Value

        ElseIf (sender.IsEditing AndAlso sender.IsNewRowEditing) Then

            AddHandler combo.Callback, AddressOf cmbEmployee_OnCallback

        End If

    End Sub

    Protected Sub dgView_001_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgView_001.DataBound

        If (sender.Equals(dgView_001) AndAlso Not tabEvaluations.ActiveTabIndex = 0) Then Exit Sub

        If (sender.ID = "dgView_004" AndAlso Not tabEvaluations.ActiveTabIndex = 1) Then Exit Sub

        Dim SkipSelect As Boolean

        Dim items As DevExpress.Web.ASPxHiddenField.ASPxHiddenField = Nothing

        If (sender.Equals(dgView_001)) Then

            items = items_001

        Else

            items = items_004

        End If

        If (Not IsNull(items)) Then

            SkipSelect = items.Contains("Submitted")

            Dim objValue As Object = Nothing
            Dim ItemKey As String = String.Empty

            Try

                For iLoop As Integer = 0 To (sender.VisibleRowCount - 1)

                    ItemKey = sender.ID & "_" & iLoop.ToString("000")

                    If (sender.ID = "dgView_004") Then

                        objValue = sender.GetRowValues(iLoop, "ApprType").ToString()

                        If (Not items.Contains(ItemKey & "_Type")) Then items.Add(ItemKey & "_Type", objValue)

                    End If

                    objValue = sender.GetRowValues(iLoop, "Scheme").ToString()

                    If (Not items.Contains(ItemKey)) Then items.Add(ItemKey, objValue)

                    If (Not IsNull(objValue)) Then

                        If (Not SkipSelect AndAlso objValue.ToString().Length > 0) Then sender.Selection.SelectRow(iLoop)

                    End If

                Next

            Catch ex As Exception

            Finally

                If (Not IsNull(objValue)) Then objValue = Nothing

                If (Not IsNull(items)) Then

                    If (SkipSelect) Then items.Remove("Submitted")

                    items = Nothing

                End If

            End Try

        End If

    End Sub

    Protected Sub dgView_001_HtmlRowCreated(ByVal sender As Object, ByVal e As ASPxGridViewTableRowEventArgs) Handles dgView_001.HtmlRowCreated

        If (e.RowType = GridViewRowType.Data) Then

            Dim items As DevExpress.Web.ASPxHiddenField.ASPxHiddenField = Nothing

            If (sender.Equals(dgView_001)) Then

                items = items_001

            Else

                items = items_004

            End If

            If (Not IsNull(items)) Then

                Dim objValue As Object = Nothing

                Dim ItemKey As String

                Dim bSelectedKey As Boolean = False

                ItemKey = sender.ID & "_" & e.VisibleIndex.ToString("000")

                Dim cmbScheme As DevExpress.Web.ASPxEditors.ASPxComboBox = TryCast(sender.FindRowCellTemplateControl(e.VisibleIndex, CType(sender.Columns("Scheme"), GridViewDataColumn), "cmbScheme" & sender.ID.Replace("dgView", String.Empty)), DevExpress.Web.ASPxEditors.ASPxComboBox)

                If (Not IsNull(cmbScheme)) Then

                    If (items.Contains(ItemKey)) Then objValue = items.Get(ItemKey)

                    If (items.Contains(ItemKey) AndAlso Not IsString(items.Get(ItemKey))) Then

                        If (items.Contains("SelectedKey") AndAlso IsString(items.Get("SelectedKey"))) Then

                            bSelectedKey = True

                            objValue = items.Get("SelectedKey")

                        End If

                    End If

                    cmbScheme.ID = ItemKey

                    cmbScheme.ClientInstanceName = cmbScheme.ID

                    'RNaanep 07012015
                    'cmbScheme.ClientSideEvents.SelectedIndexChanged = "function(s, e) { " & items.ClientInstanceName & ".Set('" & ItemKey & "', s.GetValue()); if (s.GetValue().length != 0) { " & sender.ID.ToString() & ".SelectRowOnPage(" & e.VisibleIndex.ToString() & "); } }"
                    cmbScheme.ClientSideEvents.SelectedIndexChanged = "function(s, e) { if (s.GetValue().length != 0) { " & sender.ID.ToString() & ".SelectRowOnPage(" & e.VisibleIndex.ToString() & "); } }"

                    If (Not IsNull(objValue) AndAlso Not objValue = String.Empty) Then

                        cmbScheme.Value = objValue

                    ElseIf (Not IsNull(sender.GetRowValues(e.VisibleIndex, "Scheme"))) Then

                        cmbScheme.Value = sender.GetRowValues(e.VisibleIndex, "Scheme").ToString()

                        objValue = cmbScheme.Value

                    End If

                    cmbScheme.DataBind()

                    If (Not items.Contains(ItemKey)) Then items.Add(ItemKey, objValue)

                End If

                If (sender.ID = "dgView_004") Then

                    Dim cmbApprType As DevExpress.Web.ASPxEditors.ASPxComboBox = TryCast(sender.FindRowCellTemplateControl(e.VisibleIndex, CType(sender.Columns("ApprType"), GridViewDataColumn), "cmbApprType" & sender.ID.Replace("dgView", String.Empty)), DevExpress.Web.ASPxEditors.ASPxComboBox)

                    If (Not IsNull(cmbApprType)) Then

                        cmbApprType.Items.Add("Peer", "peer")

                        cmbApprType.Items.Add("Subordinate", "subordinate")

                        cmbApprType.Items.Add("Superior", "superior")

                        If (items.Contains(ItemKey & "_Type") AndAlso Not IsString(items.Get(ItemKey & "_Type"))) Then

                            If (items.Contains("SelectedKeyType") AndAlso IsString(items.Get("SelectedKeyType"))) Then

                                bSelectedKey = False

                                objValue = items.Get("SelectedKeyType")

                            End If

                        ElseIf (bSelectedKey OrElse Not IsNull(objValue)) Then

                            If (items.Contains(ItemKey & "_Type")) Then

                                objValue = items.Get(ItemKey & "_Type")

                            Else

                                objValue = Nothing

                            End If

                        End If

                        cmbApprType.ID = ItemKey & "_Type"

                        cmbApprType.ClientSideEvents.SelectedIndexChanged = "function(s, e) { " & items.ClientInstanceName & ".Set('" & ItemKey & "_Type', s.GetValue()); }"

                        If (Not IsNull(objValue) AndAlso Not objValue = String.Empty AndAlso Not bSelectedKey) Then

                            cmbApprType.Value = objValue

                        ElseIf (Not IsNull(sender.GetRowValues(e.VisibleIndex, "ApprType"))) Then

                            cmbApprType.Value = sender.GetRowValues(e.VisibleIndex, "ApprType").ToString()

                            objValue = cmbApprType.Value

                        End If

                        If (Not items.Contains(ItemKey & "_Type")) Then items.Add(ItemKey & "_Type", objValue)

                    End If

                End If

            End If

        End If

    End Sub

    Protected Sub dgView_001_CancelRowEditing(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxStartRowEditingEventArgs)

    End Sub

    Protected Sub dgView_001_CustomColumnDisplayText(ByVal sender As Object, ByVal e As ASPxGridViewColumnDisplayTextEventArgs)

        If (e.Column.FieldName = "ApprEmployeeNum") Then e.DisplayText = e.GetFieldValue("Employee")

    End Sub

    Protected Sub dgView_001_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs)

        Dim SQLAudit As String = String.Empty

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            If (sender.ID = "dgView_005") Then

                If (dgView_003.VisibleRowCount > 0) Then

                    RefreshDelete = True

                Else

                    If (IsNumeric(Session("Data.UserGroups.AccessTo.Evaluations.360.LoadSub"))) Then Session.Remove("Data.UserGroups.AccessTo.Evaluations.360.LoadSub")

                    RefreshParent = True

                End If

            End If

        End If

    End Sub

    Protected Sub dgView_001_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs)

        Dim SQLAudit As String = String.Empty

        If (CancelEdit AndAlso (sender.ID.ToString() = "dgView_005")) Then

            e.Cancel = True

            Exit Sub

        End If

        With UDetails

            e.NewValues("EvalCompanyNum") = .CompanyNum

            e.NewValues("EvalEmployeeNum") = .EmployeeNum

        End With

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Protected Sub dgView_001_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs)

        Dim SQLAudit As String = String.Empty

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

            CancelEdit = True

        End If

    End Sub

    Protected Sub dgView_001_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs)

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

    Protected Sub dgView_001_StartRowEditing(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxStartRowEditingEventArgs)

        If (sender.IsEditing) AndAlso (Not sender.IsNewRowEditing) Then LoadExpDS(dsEmpNum, "select [EmployeeNum], (isnull([Title], '') + ' ' + isnull([PreferredName], '') + ' ' + [Surname]) as [Name] from [Personnel] where ([CompanyNum] = '" & sender.GetRowValuesByKeyValue(e.EditingKeyValue, "ApprCompanyNum").ToString() & "') order by [Name]")

    End Sub

    Protected Sub dgView_001_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs) Handles dgView_001.CustomCallback

        Dim grid As ASPxGridView = (TryCast(sender, ASPxGridView))
        grid.DataBind()

        items_001.Set("SelectedKey", cmbSchemeAll_001.SelectedItem.Value)

    End Sub
#End Region
End Class