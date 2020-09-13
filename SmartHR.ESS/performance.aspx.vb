Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxGridView.Export
Imports System.Web.HttpUtility

Partial Public Class performance
    Inherits System.Web.UI.Page

    Private HidePopup As Boolean
    Private Refresh As Boolean
    Private CancelEdit As Boolean
    Private RefreshDelete As Boolean
    Private UDetails As Users = Nothing
    Private UserGroup As String = String.Empty

#Region " *** Web Form Functions *** "

    Private Sub CalcKPA(ByVal SchemeCode As String, ByVal RowCount As Integer)

        If (GetArrayItem(UDetails.Template, "ePerformance.AutoCalcWeight")) Then ExecSQL("update [PerfKPA] set [Weight] = " & (100 / RowCount).ToString(NumericFormat) & " where ([SchemeCode] = '" & SchemeCode & "' and [ClassCode] = 'ESS')")

    End Sub

    Private Sub CalcCSE(ByVal Key As String, ByVal RowCount As Integer)

        If (GetArrayItem(UDetails.Template, "ePerformance.AutoCalcWeight")) Then ExecSQL("update [PerfCSE] set [Weight] = " & (100 / RowCount).ToString(NumericFormat) & " where ([SchemeCode] + ' ' + [ClassCode] + ' ' + [KPACode] = '" & Key & "')")

    End Sub

    Private Sub GetExpValues(ByVal sender As Object, ByVal e As Object)

        If (GetArrayItem(UDetails.Template, "ePerformance.AutoCalcWeight")) Then e.NewValues("Weight") = Nothing

        If (sender.Equals(dgView_003)) Then

            e.NewValues("Description") = GetExpControl(sender, "Description", "Text")

        ElseIf (sender.ID.ToString() = "dgView_004") Then

            e.NewValues("Description") = GetExpControl(sender, "Description", "Text")

        End If

    End Sub

    Private Sub LoadData(Optional ByVal ClearCache As Boolean = False)

        LoadExpDS(dsCSEName, "select [CSEName] from [PerfCSE] order by [CSEName]")

        If (GetArrayItem(UDetails.Template, "ePerformance.SchemeCode")) Then

            LoadExpDS(dsEvaluation, "select distinct [Name], [SchemeCode] from [PerfScheme] where ([ESSCreated] = 1 and [SchemeCode] in(select [EmployeeNum] from [Personnel] where (([CompanyNum] + ' ' + [EmployeeNum] in(" & GetUserGroupAccText(UserGroup, Session.SessionID, "Data.UserGroups.AccessTo.Evaluations.Schemes." & Session.SessionID, String.Empty, " + ' ' + [a].[EmployeeNum]") & "))))) order by [Name]")

        Else

            LoadExpDS(dsEvaluation, "select distinct [Name], [SchemeCode] from [PerfScheme] where ([ESSCreated] = 1) order by [Name]")

        End If

        LoadExpDS(dsGroup, "select [PerfGroupCode], [GroupName] from [PerfGroup] order by [GroupName]")

        LoadExpDS(dsKPACode, "select [KPACode], [KPAName] from [PerfKPA] order by [KPAName] + ' (' + [KPACode] + ')'")

        LoadExpDS(dsRangeType, "select [RangeType], [Description] from [PerfRangeType] order by [Description]")

        LoadExpDS(dsWorkflow, "select distinct [WFName] from [ess.WFLU] where ([WFType] = 'Performance') order by [WFName]")

        Dim IsRowExpanded As Boolean

        With UDetails

            Select Case tabEvaluations.ActiveTabIndex

                Case 0
                    Dim dtScore As DataTable = Nothing

                    Dim objValues() As Object = Nothing

                    Try

                        dtScore = GetUserGroupAcc(UserGroup, Session.SessionID, "Data.UserGroups.AccessTo.Filter." & Session.SessionID)

                        If (IsData(dtScore)) Then

                            If (dtScore.Columns.IndexOf("Score") = -1) Then dtScore.Columns.Add("Score")

                            If (dtScore.Columns.IndexOf("EvalDate") = -1) Then dtScore.Columns.Add("EvalDate")

                            If (Convert.ToBoolean(GetArrayItem(Session("Managed").Template, "eGeneral.EvaluationResults"))) Then

                                For i As Integer = 0 To (dtScore.Rows.Count - 1)

                                    objValues = GetSQLFields("select top 1 [EvalDate], [Score] from [PerfEvalScheme] where ([CompanyNum] + ' ' + [EmployeeNum] = '" & GetDataText(dtScore.Rows(i).Item("Value").ToString()) & "' and [Completed] = 1) order by [EvalDate] desc")

                                    If (Not IsNull(objValues)) Then

                                        If (IsNumeric(objValues(1))) Then

                                            dtScore.Rows(i).Item("Score") = Convert.ToSingle(objValues(1)).ToString(NumericFormat)

                                        Else

                                            dtScore.Rows(i).Item("Score") = 0.ToString(NumericFormat)

                                        End If

                                        If (IsDate(objValues(0))) Then dtScore.Rows(i).Item("EvalDate") = Convert.ToDateTime(objValues(0)).ToString(GetArrayItem(.Template, "eGeneral.DateFormat"))

                                    End If

                                Next

                            End If

                            dgView_005.DataSource = dtScore

                            dgView_005.DataBind()

                        End If

                    Catch ex As Exception

                    Finally

                        If (Not IsNull(objValues)) Then objValues = Nothing

                        If (Not IsNull(dtScore)) Then

                            dtScore.Dispose()

                            dtScore = Nothing

                        End If

                    End Try

                Case 1
                    ClearFromCache("Data.Evaluations.History." & Session.SessionID)

                    'RNaanep - 20160426

                    LoadExpGrid(
                        Session, dgView_002, "Performance Tab",
                        "<CustomSelectQuery=" +
                        "SELECT " +
                        "	[CompositeKey] = " +
                        "		[P].[CompanyNum] + ' ' + " +
                        "		[P].[EmployeeNum] + ' ' + " +
                        "		[SchemeCode] + " +
                        "		CONVERT(NVARCHAR(19), [EvalDate], 120), " +
                        "	[DateCompleted], " +
                        "	[SchemeCode], " +
                        "	[Name], " +
                        "	[FullName] = " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & ", " +
                        "	[AppraiserType] = UPPER(AppraiserType), " +
                        "	[Completed], " +
                        "	[PathID] = [P].[PathID], " +
                        "	[EvalDate], " +
                        "	[EvalHistType] = 'Performance' " +
                        "FROM PerfEvalScheme [P] " +
                        "LEFT JOIN [Personnel] [E] " +
                        "	ON [E].[EmployeeNum] = [P].[EmployeeNum] " +
                        "LEFT JOIN [Company] [C] " +
                        "	ON [C].[CompanyNum] = [P].[CompanyNum] " +
                        "WHERE [P].[AppraiserEmpNum] = '" & .EmployeeNum & "' " +
                        "  AND [P].[PathID] IS NOT NULL " +
                        "UNION ALL " +
                        "SELECT " +
                        "	[CompositeKey] = " +
                        "		[TE].[CompanyNum] + ' ' + " +
                        "		[TE].[EmployeeNum] + ' ' + " +
                        "		CONVERT(NVARCHAR(19), [TE].[TrainingType]) + ' ' + " +
                        "		[TE].[CourseName] + ' ' + " +
                        "		[TE].[ProviderName] + ' ' + " +
                        "		CONVERT(NVARCHAR(19), [StartDate], 120), " +
                        "	[DateCompleted] = " +
                        "		CASE WHEN [TEIH].[PathID] IS NOT NULL THEN [TEIH].[DateSubmitted] " +
                        "			 WHEN [TEE].[PathID] IS NOT NULL THEN [TEE].[DateSubmitted] " +
                        "			 WHEN [TEO].[PathID] IS NOT NULL THEN [TEO].[DateSubmitted] " +
                        "		END, " +
                        "	[SchemeCode] = [TE].[CourseName], " +
                        "	[Name] = [TE].[CourseName], " +
                        "	[FullName] = " & GetDisplayText(GetArrayItem(Nothing, "eGeneral.Dropdown")) & ", " +
                        "   [AppraiserType] = " +
                        "       CASE [TE].[TrainingType] " +
                        "            WHEN 1 THEN 'IN-HOUSE' " +
                        "            WHEN 2 THEN 'EXTERNAL' " +
                        "            WHEN 3 THEN 'OVERSEAS' " +
                        "        END, " +
                        "	[Completed] = " +
                        "		CASE WHEN " +
                        "			[TEIH].[PathID] IS NOT NULL OR " +
                        "			[TEE].[PathID] IS NOT NULL OR " +
                        "			[TEO].[PathID] IS NOT NULL " +
                        "		THEN 1 ELSE 0 END, " +
                        "	[PathID] = [TE].[PathID], " +
                        "	[EvalDate] = " +
                        "		CASE WHEN [TEIH].[PathID] IS NOT NULL THEN [TEIH].[DateSubmitted] " +
                        "			 WHEN [TEE].[PathID] IS NOT NULL THEN [TEE].[DateSubmitted] " +
                        "			 WHEN [TEO].[PathID] IS NOT NULL THEN [TEO].[DateSubmitted] " +
                        "		END, " +
                        "	[EvalHistType] = 'Training' " +
                        "FROM TrainingEvaluation [TE] " +
                        "LEFT JOIN [Personnel] [E] " +
                        "	ON [E].[EmployeeNum] = [TE].[EmployeeNum] " +
                        "LEFT JOIN TrainingEvaluationInHouse [TEIH] " +
                        "	ON [TEIH].[PathID] = [TE].[PathID] " +
                        "LEFT JOIN TrainingEvaluationExternal [TEE] " +
                        "	ON [TEE].[PathID] = [TE].[PathID] " +
                        "LEFT JOIN TrainingEvaluationOverseas [TEO] " +
                        "	ON [TEO].[PathID] = [TE].[PathID] " +
                        "WHERE [TE].[EmployeeNum] = '" & .EmployeeNum & "' " +
                        "  AND [TE].[PathID] IS NOT NULL " +
                        ">", "Data.Evaluations.History." & Session.SessionID)

                Case 2
                    If (ClearCache) Then ClearFromCache("Data.Evaluations.Groups." & Session.SessionID)

                    LoadExpGrid(Session, dgView_001, "Performance Tab", "<Tablename=ess.EvalGroups><PrimaryKey=[CompanyNum] + ' ' + [EmployeeNum] + ' ' + [Name]><InsertKey='" & .CompanyNum & "', '" & .EmployeeNum & "'><Columns=[Name]><Where=([CompanyNum] = '" & .CompanyNum & "' and [EmployeeNum] = '" & .EmployeeNum & "')>", "Data.Evaluations.Groups." & Session.SessionID)

                Case 3
                    If (IsNull(cmbScheme_003.Value)) Then ClearCache = True

                    If (ClearCache) Then

                        ClearFromCache("Data.Evaluations.Setup." & Session.SessionID)

                        ClearFromCache("Data.Evaluations.Setup.CSE." & Session.SessionID)

                    End If

                    If (Not IsPostBack) Then Session("Evaluations.Setup.LoadSub") = Nothing

                    If (IsNumeric(Session("Evaluations.Setup.LoadSub"))) Then IsRowExpanded = dgView_003.IsRowExpanded(Session("Evaluations.Setup.LoadSub"))

                    LoadExpGrid(Session, dgView_003, "Performance Tab", "<Tablename=PerfKPA><PrimaryKey=[SchemeCode] + ' ' + [ClassCode] + ' ' + [KPACode]><InsertKey='" & cmbScheme_003.Value & "', 'ESS'><Columns=[KPACode], [KPAName], [Description], [Target], [RangeType], [Weight], [Required]><Where=([SchemeCode] = '" & cmbScheme_003.Value & "' and [ClassCode] = 'ESS')>", "Data.Evaluations.Setup." & Session.SessionID)

                    If (IsNumeric(Session("Evaluations.Setup.LoadSub"))) Then

                        Dim iRowIndex As Integer = Session("Evaluations.Setup.LoadSub")

                        If (IsRowExpanded) Then

                            Dim dgView As ASPxGridView = TryCast(dgView_003.FindDetailRowTemplateControl(iRowIndex, "dgView_004"), ASPxGridView)

                            If (Not IsNull(dgView)) Then LoadExpGrid(Session, dgView, "Performance Tab", "<Tablename=PerfCSE><PrimaryKey=[SchemeCode] + ' ' + [ClassCode] + ' ' + [KPACode] + ' ' + [CSEName]><InsertKey='" & cmbScheme_003.Value & "', 'ESS', '" & dgView_003.GetRowValues(iRowIndex, "KPACode") & "'><Columns=[CSEName], [Description], [Target], [RangeType], [Weight], [Required]><Where=([SchemeCode] + ' ' + [ClassCode] + ' ' + [KPACode] = '" & dgView_003.GetRowValues(iRowIndex, "CompositeKey") & "')>", "Data.Evaluations.Setup.CSE." & Session.SessionID)

                        End If

                    End If

            End Select

        End With

    End Sub

#End Region

#Region " *** Web Form Events *** "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not IsPostBack) Then

            If (Not IsNull(Request.QueryString("TabID"))) Then

                If (IsNumeric(Request.QueryString("TabID"))) Then tabEvaluations.ActiveTabIndex = Convert.ToInt32(Request.QueryString("TabID"))

            End If

            lblKA.Text = GetArrayItem(Nothing, "ePerformance.KeyAreas")

        End If

        If (Session("docUnread")) Then

            Response.Redirect("documentmapman.aspx", True)

            Exit Sub

        End If

        If (Not IsPostBack) Then SetEmployeeData(Session, Session("Selected.Value"))

        If (Not IsNull(Session("LoggedOn"))) Then UserGroup = GetUserGroup(Session("LoggedOn").UserID, Session.SessionID)

        UDetails = GetUserDetails(Session, "Performance Tab")

        LoadData()

    End Sub

    Private Sub cmbScheme_003_Callback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase) Handles cmbScheme_003.Callback

        Dim Values() As String = e.Parameter.Split(" ")

        Dim ErrorText As String = String.Empty

        Dim SQL As String = String.Empty

        Select Case Values(0)

            Case "Create"
                Dim pCode As String = CreatePin(8)

                While (Not IsNull(GetSQLField("select [SchemeCode] from [PerfScheme] where ([SchemeCode] = '" & pCode & "')", "SchemeCode")))

                    pCode = CreatePin(8)

                End While

                SQL = "insert into [PerfScheme]([SchemeCode], [PerfGroupCode], [Name], [Description], [ESSCreated], [MultiColumn], [WFName]) values('" & pCode & "', '" & GetDataText(Values(1)) & "', '" & GetDataText(Values(2)) & "', " & GetNullText(Values(3)) & ", 1, " & GetBitData(Values(4)) & ", " & GetNullText(Values(5)) & ")"

                If (ExecSQL(SQL)) Then

                    SQL = "insert into [PerfSchemeClass]([SchemeCode], [ClassCode], [Weight]) values('" & pCode & "', 'ESS', 100)"

                    If (ExecSQL(SQL)) Then

                        sender.DataBind()

                        LoadData(True)

                        HidePopup = True

                        Refresh = True

                    End If

                End If

            Case "Copy"
                If (ExecSQL("exec [evaluations.CopyScheme] '" & GetDataText(Values(1)) & "', '" & GetDataText(Values(2)) & "'")) Then

                    sender.DataBind()

                    LoadData(True)

                    Refresh = True

                End If


        End Select

    End Sub

    Private Sub cmbScheme_003_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CustomJSPropertiesEventArgs) Handles cmbScheme_003.CustomJSProperties

        e.Properties("cpHidePopup") = HidePopup

        e.Properties("cpRefresh") = Refresh

        If (Not IsNull(cmbScheme_003.Value)) Then e.Properties("cpValue") = cmbScheme_003.Value

    End Sub

    Private Sub cpPage_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cpPage.Callback

        Dim ReturnText As String = String.Empty

        Dim Values() As String = e.Parameter.Split(" ")

        Dim ErrorText As String = String.Empty

        Select Case Values(0)

            Case "Setup"
                If (Not IsNull(Session("EvaluationGroup"))) Then

                    If (Not Session("EvaluationGroup") = dgView_001.GetRowValues(Convert.ToInt32(Values(2)), "Name")) Then

                        ClearFromCache("Data.UserGroups.AccessTo.Evaluations.Self." & Session.SessionID)

                        ClearFromCache("Data.UserGroups.AccessTo.Evaluations.Others.Items." & Session.SessionID)

                        ClearFromCache("Data.UserGroups.AccessTo.Evaluations.360.Items." & Session.SessionID)

                    End If

                End If

                Session("EvaluationGroup") = dgView_001.GetRowValues(Convert.ToInt32(Values(2)), "Name")

                If (Values(1) = "Personal") Then

                    ReturnText = "performanceman_001.aspx?ID=0 tools/index.aspx"

                ElseIf (Values(1) = "Group") Then

                    ReturnText = "performanceman_001.aspx?ID=1 tools/index.aspx"

                ElseIf (Values(1) = "Overview") Then

                    ReturnText = "performanceman_001.aspx?ID=2 tools/index.aspx"

                ElseIf (Values(1) = "Submit") Then

                    With Session("LoggedOn")

                        Dim SQL As String = "exec [ess.PerfSubmit] '" & .CompanyNum & "', '" & .EmployeeNum & "', '" & Session("EvaluationGroup") & "', '" & .UserID & "'"

                        If (ExecSQL("exec [ess.PerfSubmit] '" & .CompanyNum & "', '" & .EmployeeNum & "', '" & Session("EvaluationGroup") & "', '" & .UserID & "'")) Then ReturnText = "tasks.aspx tools/index.aspx"

                    End With

                End If

        End Select

        e.Result = ReturnText

    End Sub

    Protected Sub dgView_001_CancelRowEditing(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxStartRowEditingEventArgs)

    End Sub

    Private Sub dgView_003_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs) Handles dgView_003.CustomCallback

        Dim Values() As String = e.Parameters.Split(" ")

        Select Case Values(0)

            Case "Clear"

                If (Not cmbScheme_003.Value = Values(1)) Then cmbScheme_003.Value = Values(1)

                LoadData(True)

        End Select

    End Sub

    Protected Sub dgView_001_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs) Handles dgView_001.CustomJSProperties, dgView_003.CustomJSProperties

        e.Properties("cpCancelEdit") = CancelEdit

        e.Properties("cpRefreshDelete") = RefreshDelete

    End Sub

    Private Sub dgView_003_DetailRowExpandedChanged(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewDetailRowEventArgs) Handles dgView_003.DetailRowExpandedChanged

        If (e.Expanded) Then

            Dim lblCSE As ASPxLabel = TryCast(sender.FindDetailRowTemplateControl(e.VisibleIndex, "lblCSE"), ASPxLabel)

            If (Not IsNull(lblCSE)) Then lblCSE.Text = GetArrayItem(Nothing, "ePerformance.KeyElements")

            ClearFromCache("Data.Evaluations.Setup.CSE." & Session.SessionID)

            Dim dgView As ASPxGridView = TryCast(sender.FindDetailRowTemplateControl(e.VisibleIndex, "dgView_004"), ASPxGridView)

            If (Not IsNull(dgView)) Then LoadExpGrid(Session, dgView, "Performance Tab", "<Tablename=PerfCSE><PrimaryKey=[SchemeCode] + ' ' + [ClassCode] + ' ' + [KPACode] + ' ' + [CSEName]><InsertKey='" & cmbScheme_003.Value & "', 'ESS', '" & dgView_003.GetRowValues(e.VisibleIndex, "KPACode") & "'><Columns=[CSEName], [Description], [Target], [RangeType], [Weight], [Required]><Where=([SchemeCode] + ' ' + [ClassCode] + ' ' + [KPACode] = '" & dgView_003.GetRowValues(e.VisibleIndex, "CompositeKey") & "')>", "Data.Evaluations.Setup.CSE." & Session.SessionID)

            Session("Evaluations.Setup.LoadSub") = e.VisibleIndex

        ElseIf (IsNumeric(Session("Evaluations.Setup.LoadSub"))) Then

            Session.Remove("Evaluations.Setup.LoadSub")

        End If

    End Sub

    Private Sub dgView_005_HtmlDataCellPrepared(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewTableDataCellEventArgs) Handles dgView_005.HtmlDataCellPrepared

        If (e.DataColumn.FieldName = "Text") Then

            e.Cell.Style.Add("color", "#5689c5")

            e.Cell.Style.Add("cursor", "pointer")

            e.Cell.Style.Add("text-decoration", "none")

            e.Cell.Attributes.Add("onclick", "tabEvaluations.SetActiveTabIndex(1); dgView_002.ApplyFilter('[Text] = \'" & sender.GetRowValues(e.VisibleIndex, "Text").ToString() & "\'');")

        End If

    End Sub

    Protected Sub dgView_001_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs) Handles dgView_001.RowDeleting, dgView_002.RowDeleting, dgView_003.RowDeleting

        Dim SQLAudit As String = String.Empty

        If (sender.Equals(dgView_002)) Then

            SQLAudit = "<Tablename=PerfEvalScheme><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & "><SchemeCode=" & e.Values("SchemeCode").ToString() & "><EvalDate=" & Convert.ToDateTime(e.Values("EvalDate")).ToString("yyyy-MM-dd HH:mm:ss") & ">"

        ElseIf (sender.Equals(dgView_003)) Then

            SQLAudit = "<Tablename=PerfKPA><SchemeCode=" & e.Values("SchemeCode").ToString() & "><ClassCode=" & e.Values("ClassCode").ToString() & "><KPACode=" & e.Values("KPACode").ToString() & ">"

        ElseIf (sender.ID = "dgView_004") Then

            SQLAudit = "<Tablename=PerfCSE><SchemeCode=" & e.Values("SchemeCode").ToString() & "><ClassCode=" & e.Values("ClassCode").ToString() & "><KPACode=" & e.Values("KPACode").ToString() & "><CSEName=" & e.Values("CSEName").ToString() & ">"

        End If

        e.Cancel = ExecSQL(GetDeleteExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            If (sender.Equals(dgView_003)) Then CalcKPA(cmbScheme_003.Value, sender.VisibleRowCount - 1)

            If (sender.ID = "dgView_004") Then

                CalcCSE(sender.GetMasterRowKeyValue().ToString(), sender.VisibleRowCount - 1)

                RefreshDelete = True

            End If

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

        End If

    End Sub

    Protected Sub dgView_001_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles dgView_001.RowInserting, dgView_002.RowInserting, dgView_003.RowInserting

        Dim SQLAudit As String = String.Empty

        If (sender.Equals(dgView_002)) Then

            SQLAudit = "<Tablename=PerfEvalScheme><CompanyNum=" & UDetails.CompanyNum & "><EmployeeNum=" & UDetails.EmployeeNum & ">"

        ElseIf (sender.Equals(dgView_003)) Then

            SQLAudit = "<Tablename=PerfKPA>"

        ElseIf (sender.ID = "dgView_004") Then

            SQLAudit = "<Tablename=PerfCSE>"

        End If

        If (CancelEdit AndAlso (sender.ID.ToString() = "dgView_004")) Then

            e.Cancel = True

            Exit Sub

        End If

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetInsertExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            CancelEdit = True

            If (sender.Equals(dgView_003)) Then CalcKPA(cmbScheme_003.Value, sender.VisibleRowCount + 1)

            If (sender.ID = "dgView_004") Then CalcCSE(sender.GetMasterRowKeyValue().ToString(), sender.VisibleRowCount + 1)

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

        End If

    End Sub

    Protected Sub dgView_001_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles dgView_001.RowUpdating, dgView_002.RowUpdating, dgView_003.RowUpdating

        Dim SQLAudit As String = String.Empty

        If (sender.Equals(dgView_002)) Then

            SQLAudit = "<Tablename=PerfEvalScheme><CompanyNum;0=" & UDetails.CompanyNum & "><EmployeeNum;1=" & UDetails.EmployeeNum & "><SchemeCode;2=" & e.OldValues("SchemeCode").ToString() & "><EvalDate;3=" & Convert.ToDateTime(e.OldValues("EvalDate")).ToString("yyyy-MM-dd HH:mm:ss") & ">"

        ElseIf (sender.Equals(dgView_003)) Then

            SQLAudit = "<Tablename=PerfKPA><SchemeCode;0=" & e.OldValues("SchemeCode").ToString() & "><ClassCode;1=" & e.OldValues("ClassCode").ToString() & "><KPACode;2=" & e.OldValues("KPACode").ToString() & ">"

        ElseIf (sender.ID = "dgView_004") Then

            SQLAudit = "<Tablename=PerfCSE><SchemeCode;0=" & e.OldValues("SchemeCode").ToString() & "><ClassCode;1=" & e.OldValues("ClassCode").ToString() & "><KPACode;2=" & e.OldValues("KPACode").ToString() & "><CSEName;3=" & e.OldValues("CSEName").ToString() & ">"

        End If

        GetExpValues(sender, e)

        e.Cancel = ExecSQL(GetUpdateExpSQL(sender, e, SQLAudit))

        If (e.Cancel) Then

            CancelEdit = True

            If (sender.Equals(dgView_003)) Then CalcKPA(cmbScheme_003.Value, sender.VisibleRowCount)

            If (sender.ID = "dgView_004") Then CalcCSE(sender.GetMasterRowKeyValue().ToString(), sender.VisibleRowCount)

            If (IsString(SQLAudit)) Then SaveAudit(UDetails, Session("LoggedOn").UserID, SQLAudit)

            LoadData(True)

        End If

    End Sub

    Protected Sub dgView_001_RowValidating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataValidationEventArgs) Handles dgView_001.RowValidating, dgView_003.RowValidating

        e.RowError = ValidateExpGrid(sender, e)

    End Sub

    Protected Function GetClickUrl(ByVal Container As DevExpress.Web.ASPxGridView.GridViewDataItemTemplateContainer) As String

        Dim EvalHistType As String = Container.Grid.GetRowValues(Container.VisibleIndex, "EvalHistType")

        Dim PathID As String = Container.Grid.GetRowValues(Container.VisibleIndex, "PathID")

        Dim EncryptedURL As String = ""

        If EvalHistType = "Training" Then

            Dim EvalType As String = Container.Grid.GetRowValues(Container.VisibleIndex, "AppraiserType")

            Dim ReportID As String = ""

            If EvalType = "IN-HOUSE" Then

                ReportID = "Training Evaluation - In House"

            ElseIf EvalType = "EXTERNAL" Then

                ReportID = "Training Evaluation - External"

            ElseIf EvalType = "OVERSEAS" Then

                ReportID = "Training Evaluation - Overseas"

            End If

            EncryptedURL = UrlEncode(CryptoEncrypt("<type=load><id=" & ReportID & "><param0=" & PathID & ">", EncPwd, SaltPwd, 5, EncVectorPwd, 256))

        Else

            Dim SchemeCode As Object = GetSQLField("SELECT SchemeCode FROM PerfEvalScheme WHERE PathID = '" & PathID & "'", "SchemeCode")

            Dim EvalDate As String = Convert.ToDateTime(Container.Grid.GetRowValues(Container.VisibleIndex, "EvalDate")).ToString("yyyy-MM-dd HH:mm:ss")

            If (SchemeCode.ToString().Contains("2014")) Then

                EncryptedURL = UrlEncode(CryptoEncrypt("<type=load><id=Workplace Survey 2014><param0=" & PathID & "><param1=" & EvalDate & ">", EncPwd, SaltPwd, 5, EncVectorPwd, 256))

            Else

                EncryptedURL = UrlEncode(CryptoEncrypt("<type=load><id=Evaluation><param0=" & PathID & "><param1=" & EvalDate & ">", EncPwd, SaltPwd, 5, EncVectorPwd, 256))

            End If

        End If

        Return "function(s, e) { window.open('reportsview.aspx?params=" & EncryptedURL & "', 'open'); }"

    End Function

    Private Sub tabEvaluations_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CustomJSPropertiesEventArgs) Handles tabEvaluations.CustomJSProperties

        Dim bVisible() As Boolean = {False, False}

        If (Not IsNull(Session("Managed")) AndAlso Not IsNull(Session("Managed").Template)) Then

            If (Not IsNull(GetArrayItem(Session("Managed").Template, "eGeneral.EvaluationsConfig"))) Then bVisible(0) = Convert.ToBoolean(GetArrayItem(Session("Managed").Template, "eGeneral.EvaluationsConfig"))

            If (Not IsNull(GetArrayItem(Session("Managed").Template, "eGeneral.EvaluationResults"))) Then bVisible(1) = Convert.ToBoolean(GetArrayItem(Session("Managed").Template, "eGeneral.EvaluationResults"))

        End If

        'RNaanep - 10/20/2015 - Temporary Fix
        'Dim dt As New DataTable
        'dt = GetSQLDT("SELECT TemplateCode FROM Users WHERE Username = '" & Session("LoggedOn").UserID & "'")
        'If (dt.Rows(0)("TemplateCode").ToString() = "Admin") Or (dt.Rows(0)("TemplateCode").ToString() = "TeamRel") Then
        '    bVisible = {True, True}
        'End If
        'RNaanep - 10/20/2015

        e.Properties("cpVisible") = bVisible(0)

        e.Properties("cpVisibleResults") = bVisible(1)

    End Sub

    Protected Sub mnuExport_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.ASPxMenu.MenuItemEventArgs)

        Dim dgExports As ASPxGridViewExporter = Nothing

        Try

            dgExports = tabEvaluations.TabPages(tabEvaluations.ActiveTabIndex).FindControl(source.ID.ToString().Replace("mnuExport", "dgExports"))

            If (Not IsNull(dgExports)) Then

                Dim xFilePath As String = tabEvaluations.TabPages(tabEvaluations.ActiveTabIndex).Text & " [" & Date.Today.ToString("yyyy-MM-dd") & "]"

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